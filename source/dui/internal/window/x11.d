module dui.internal.window.x11;
import dui.internal.bindings.x11;
import dui.internal.bindings.glx;
import dui.internal.bindings.opengl;
import dui.internal.window;
import dui;
import dui : KeyCode;
import std.exception;
import std.string;

final class XConnection {
	X11 x;
	Display* display;
	X11Window[Window] windowMap;

	alias x this;

	this() {
		x = loadX11;

		display = x.openDisplay(null);
		if (display == null) {
			throw new Exception("could not open display");
		}
	}

	~this() {
		x.closeDisplay(display);
		x.close();
	}

	Atom getAtom(string name, bool create = true)() {
		static Atom a;
		if (!a) {
			a = x.internAtom(display, name, !create);
		}
		if (a == None) {
			throw new Exception("XInternAtom " ~ name ~ " " ~ (create ? "true" : "false"));
		}
		return a;
	}

	void eventLoop() {
		while (true) {
			while (pending(display) > 0) {
				XEvent ev;
				nextEvent(display, &ev);

				// { import std.stdio : writeln; try { writeln(ev.type); } catch (Exception) {} }

				switch (ev.type) {
					case ClientMessage:
						if (auto win = ev.xclient.window in windowMap) {
							if (ev.xclient.data.l[0] == getAtom!"WM_DELETE_WINDOW") {
								win.onCloseRequest.emit();
							}
						}
						break;
					case Expose:
						if (auto win = ev.xexpose.window in windowMap) {
							win.redraw();
						}
						break;
					case KeyPress:
						if (auto win = ev.xkey.window in windowMap) {
							win.onKeyDown.emit(xk2keycode(ev.xkey.keycode));
						}
						break;
					case KeyRelease:
						if (auto win = ev.xkey.window in windowMap) {
							win.onKeyUp.emit(xk2keycode(ev.xkey.keycode));
						}
						break;
					case MapNotify:
						if (auto win = ev.xmap.window in windowMap) {
							win._visibility = true;
						}
						break;
					case UnmapNotify:
						if (auto win = ev.xunmap.window in windowMap) {
							win._visibility = false;
						}
						break;
					case DestroyNotify:
						if (auto win = ev.xdestroywindow.window in windowMap) {
							windowMap.remove(ev.xdestroywindow.window);
							// TODO: see what else needs to be done
						}
						break;
					default:
						break;
				}
			}

			foreach (win; windowMap.byValue) {
				win.redraw();
			}
		}
	}
}

KeyCode xk2keycode(uint xk) {
	switch (xk) {
	default:
		return KeyCode.Unknown;
	}
}

final class X11Window : AbstractWindow {

	XConnection x;
	GLX glx;
	OpenGL gl;

	Window window;

	GLXContext glc;

	this(
		ubyte openGlMajor, ubyte openGlMinor,
		uint defaultWidth, uint defaultHeight,
		string title, string className,
	) {
		x = new XConnection;
		glx = loadGLX;
		gl = loadOpenGL;

		auto screen = x.defaultScreen(x.display);

		OpenGL.Int majorGLX, minorGLX;
		bool querySuccess = glx.queryVersion(x.display, &majorGLX, &minorGLX) != 0;
		enforce(querySuccess &&
			!(majorGLX == 1 && minorGLX < 3) && majorGLX >= 1, "GLX version must be >=1.3");

		OpenGL.Int[] glxAttribs = [
			glx.X_RENDERABLE, True,
			glx.DRAWABLE_TYPE, glx.WINDOW_BIT,
			glx.RENDER_TYPE, glx.RGBA_BIT,
			glx.X_VISUAL_TYPE, glx.TRUE_COLOR,
			glx.RED_SIZE, 8,
			glx.GREEN_SIZE, 8,
			glx.BLUE_SIZE, 8,
			glx.ALPHA_SIZE, 8,
			glx.DEPTH_SIZE, 24,
			glx.STENCIL_SIZE, 8,
			glx.DOUBLEBUFFER, True,
			None,
		];

		int fbcount;
		GLXFBConfig* fbc = glx.chooseFBConfig(x.display, screen, glxAttribs.ptr, &fbcount);
		if (fbcount == 0) {
			x.closeDisplay(x.display);
			throw new Exception("failed to retrieve framebuffer");
		}

		GLXFBConfig fbconf;
		int bestNumSamples = -1;
		foreach (i; 0 .. fbcount) {
			XVisualInfo* vi = glx.getVisualFromFBConfig(x.display, fbc[i]);
			if (vi != null) {
				int sb, samples;
				glx.getFBConfigAttrib(x.display, fbc[i], glx.SAMPLE_BUFFERS, &sb);
				glx.getFBConfigAttrib(x.display, fbc[i], glx.SAMPLES, &samples);
				if (bestNumSamples == -1 || (sb && samples > bestNumSamples)) {
					fbconf = fbc[i];
					bestNumSamples = samples;
				}
			}
			x.free(vi);
		}
		x.free(fbc);

		XVisualInfo* vi = glx.getVisualFromFBConfig(x.display, fbconf);
		assert(vi);

		XSetWindowAttributes swa;
		auto root = x.rootWindow(x.display, screen);
		swa.colormap = x.createColormap(x.display, root, vi.visual, AllocNone);

		window = x.createWindow(x.display,
			root,
			0, 0, defaultWidth, defaultHeight,
			0, vi.depth, InputOutput, vi.visual, CWColormap, &swa,
		);

		OpenGL.Int[] contextAttribs = [
			glx.CONTEXT_MAJOR_VERSION_ARB, cast(OpenGL.Int) openGlMajor,
			glx.CONTEXT_MINOR_VERSION_ARB, cast(OpenGL.Int) openGlMinor,
			glx.CONTEXT_PROFILE_MASK_ARB, glx.CONTEXT_CORE_PROFILE_BIT_ARB,
			glx.CONTEXT_FLAGS_ARB, glx.CONTEXT_FORWARD_COMPATIBLE_BIT_ARB,
			None,
		];

		glc = glx.createContextAttribsARB(x.display, fbconf, null, True, contextAttribs.ptr);

		x.sync(x.display, False);

		enforce(glc);

		XClassHint class_;
		XWMHints wh;
		XSizeHints size;
		class_.res_class = class_.res_name = cast(char*) className.toStringz;
		x.setWMProperties(x.display, window, null, null, null, 0, &size, &wh, &class_);

		this.title = title;

		Atom[1] atoms = [x.getAtom!"WM_DELETE_WINDOW"];
		x.setWMProtocols(x.display, window, atoms.ptr, cast(int) atoms.length);

		x.selectInput(x.display, window, 0
			| ExposureMask
			| KeyPressMask
			| KeyReleaseMask
			| PropertyChangeMask
			| FocusChangeMask
			| StructureNotifyMask
			| VisibilityChangeMask
			| ButtonPressMask
			| ButtonReleaseMask
			| PointerMotionMask
		);

		x.windowMap[window] = this;
	}

	~this() {
		x.close();
		gl.close();
		glx.close();
	}

	bool onFirstPaintCalled;

	void makeCurrent() {
		bool success = glx.makeCurrent(x.display, window, glc) != 0;
		enforce(success);
	}

	void redraw() {
		// TODO: if window is hidden, return

		makeCurrent();

		if (!onFirstPaintCalled) {
			onFirstPaint.emit();
		}

		onPaint.emit();

		glx.swapBuffers(x.display, window);
		gl.finish();
	}

	private string _title;
	override void title(string value) {
		_title = value;
		auto XA_UTF8 = x.getAtom!("UTF8_STRING", false);
		auto XA_NETWM_NAME = x.getAtom!("_NET_WM_NAME", false);
		XTextProperty windowName;
		windowName.value = cast(ubyte*) value.ptr;
		windowName.encoding = XA_UTF8;
		windowName.format = 8;
		windowName.nitems = cast(uint) value.length;
		x.setWMName(x.display, window, &windowName);
		char[1024] namebuf = 0;
		size_t maxlen = 1023;
		if (maxlen > value.length) maxlen = value.length;
		namebuf[0 .. maxlen] = value[0 .. maxlen];
		x.storeName(x.display, window, namebuf.ptr);
		x.changeProperty(x.display, window, XA_NETWM_NAME, XA_UTF8, 8,
			PropModeReplace, cast(const(ubyte)*) value.ptr, cast(int) value.length);
		x.flush(x.display);
	}

	override string title() const {
		return _title;
	}

	private bool _visibility = false;
	override void visibility(bool value) {
		if (value) {
			x.mapWindow(x.display, window);
		}
		else {
			x.withdrawWindow(x.display, window, x.defaultScreen(x.display));
		}
	}

	override bool visibility() const {
		return _visibility;
	}

	override void vsync(bool value) {
		static void function(Display*, Drawable, int) glXSwapInterval;
		static int function(int) glXSwapIntervalMESA;
		if (!glXSwapInterval) {
			glXSwapInterval = cast(typeof(glXSwapInterval))
				glx.getProcAddress(cast(const(ubyte)*) "glXSwapIntervalEXT".ptr);
			if (!glXSwapInterval) {
				return;
			}
		}
		if (!glXSwapIntervalMESA) {
			glXSwapIntervalMESA = cast(typeof(glXSwapIntervalMESA))
				glx.getProcAddress(cast(const(ubyte)*) "glXSwapIntervalMESA".ptr);
		}

		makeCurrent();

		if (glXSwapIntervalMESA) {
			glXSwapIntervalMESA(value ? 1 : 0);
		}

		glXSwapInterval(x.display, window, value ? 1 : 0);
	}

	void eventLoop() {
		x.eventLoop();
	}

	override int width() const {
		auto mx = cast(XConnection) x;
		XWindowAttributes attribs;
		mx.getWindowAttributes(mx.display, window, &attribs);
		return attribs.width;
	}

	override int height() const {
		auto mx = cast(XConnection) x;
		XWindowAttributes attribs;
		mx.getWindowAttributes(mx.display, window, &attribs);
		return attribs.height;
	}

}