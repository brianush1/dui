module dui.internal.window.x11;
import dui.internal.bindings.x11;
import dui.internal.bindings.x11 : Window;
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

		Bool success;
		x._XkbSetDetectableAutoRepeat(display, True, &success);
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

	bool processEvents() {
		if (pending(display) > 0) {
			XEvent ev;
			nextEvent(display, &ev);

			switch (ev.type) {
				case ClientMessage:
					if (auto win = ev.xclient.window in windowMap) {
						if (ev.xclient.data.l[0] == getAtom!"WM_DELETE_WINDOW") {
							win.onCloseRequest.emit();
						}
						else if (ev.xclient.message_type == getAtom!"_X11DUI_CUSTOM_EVENT_") {
							auto callback = queuedCallbacks[0];
							queuedCallbacks = queuedCallbacks[1 .. $];
							callback();
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
						win.onKeyDown.emit(xk2keycode(keycodeToKeysym(display, ev.xkey.keycode, 0)));
					}
					break;
				case KeyRelease:
					if (auto win = ev.xkey.window in windowMap) {
						win.onKeyUp.emit(xk2keycode(keycodeToKeysym(display, ev.xkey.keycode, 0)));
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

			return true;
		}
		else {
			return false;
		}
	}

	void waitForEvents() {
		XEvent ev;
		peekEvent(display, &ev);
	}

	void delegate()[] queuedCallbacks;

	void enqueueEvent(void delegate() callback) {
		queuedCallbacks.assumeSafeAppend ~= callback;

		// just pick any window, it doesn't matter which
		auto window = windowMap.byValue.front.window;

		XEvent ev;
		ev.xclient.type = ClientMessage;
		ev.xclient.window = window;
		ev.xclient.message_type = getAtom!"_X11DUI_CUSTOM_EVENT_";
		ev.xclient.format = 32;
		ev.xclient.data.l[0] = 0;
		x.sendEvent(display, window, false, NoEventMask, &ev);
		x.flush(display);
	}
}

static XConnection x;
private static GLX glx;
private static OpenGL gl;
private static GLXContext glc;
private static GLXFBConfig fbconf;

enum ubyte openGlMajor = 3; // TODO: let the user specify an OpenGL version maybe
enum ubyte openGlMinor = 3;

void initX11() {
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
		throw new Exception("failed to retrieve framebuffer");
	}

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

	OpenGL.Int[] contextAttribs = [
		glx.CONTEXT_MAJOR_VERSION_ARB, cast(OpenGL.Int) openGlMajor,
		glx.CONTEXT_MINOR_VERSION_ARB, cast(OpenGL.Int) openGlMinor,
		glx.CONTEXT_PROFILE_MASK_ARB, glx.CONTEXT_CORE_PROFILE_BIT_ARB,
		glx.CONTEXT_FLAGS_ARB, glx.CONTEXT_FORWARD_COMPATIBLE_BIT_ARB,
		None,
	];

	glc = glx.createContextAttribsARB(x.display, fbconf, null, True, contextAttribs.ptr);
	enforce(glc);

	glx.makeCurrent(x.display, x.rootWindow(x.display, screen), glc);
}

KeyCode xk2keycode(KeySym xk) {
	switch (xk) {
		case KeySym.XK_F1: return KeyCode.F1;
		case KeySym.XK_F2: return KeyCode.F2;
		case KeySym.XK_F3: return KeyCode.F3;
		case KeySym.XK_F4: return KeyCode.F4;
		case KeySym.XK_F5: return KeyCode.F5;
		case KeySym.XK_F6: return KeyCode.F6;
		case KeySym.XK_F7: return KeyCode.F7;
		case KeySym.XK_F8: return KeyCode.F8;
		case KeySym.XK_F9: return KeyCode.F9;
		case KeySym.XK_F10: return KeyCode.F10;
		case KeySym.XK_F11: return KeyCode.F11;
		case KeySym.XK_F12: return KeyCode.F12;
		case KeySym.XK_F13: return KeyCode.F13;
		case KeySym.XK_F14: return KeyCode.F14;
		case KeySym.XK_F15: return KeyCode.F15;
		case KeySym.XK_F16: return KeyCode.F16;
		case KeySym.XK_F17: return KeyCode.F17;
		case KeySym.XK_F18: return KeyCode.F18;
		case KeySym.XK_F19: return KeyCode.F19;
		case KeySym.XK_F20: return KeyCode.F20;
		case KeySym.XK_Escape: return KeyCode.Esc;
		case KeySym.XK_Scroll_Lock: return KeyCode.ScrollLock;
		case KeySym.XK_Print: return KeyCode.PrintScreen;
		case KeySym.XK_Delete: return KeyCode.Delete;
		case KeySym.XK_Home: return KeyCode.Home;
		case KeySym.XK_End: return KeyCode.End;
		case KeySym.XK_Page_Up: return KeyCode.PageUp;
		case KeySym.XK_Page_Down: return KeyCode.PageDown;
		case KeySym.XK_grave: return KeyCode.Backtick;
		case KeySym.XK_1: return KeyCode.D1;
		case KeySym.XK_2: return KeyCode.D2;
		case KeySym.XK_3: return KeyCode.D3;
		case KeySym.XK_4: return KeyCode.D4;
		case KeySym.XK_5: return KeyCode.D5;
		case KeySym.XK_6: return KeyCode.D6;
		case KeySym.XK_7: return KeyCode.D7;
		case KeySym.XK_8: return KeyCode.D8;
		case KeySym.XK_9: return KeyCode.D9;
		case KeySym.XK_0: return KeyCode.D0;
		case KeySym.XK_minus: return KeyCode.Minus;
		case KeySym.XK_equal: return KeyCode.Equals;
		case KeySym.XK_BackSpace: return KeyCode.Backspace;
		case KeySym.XK_Tab: return KeyCode.Tab;
		case KeySym.XK_q: return KeyCode.Q;
		case KeySym.XK_w: return KeyCode.W;
		case KeySym.XK_e: return KeyCode.E;
		case KeySym.XK_r: return KeyCode.R;
		case KeySym.XK_t: return KeyCode.T;
		case KeySym.XK_y: return KeyCode.Y;
		case KeySym.XK_u: return KeyCode.U;
		case KeySym.XK_i: return KeyCode.I;
		case KeySym.XK_o: return KeyCode.O;
		case KeySym.XK_p: return KeyCode.P;
		case KeySym.XK_bracketleft: return KeyCode.OpenBracket;
		case KeySym.XK_bracketright: return KeyCode.ClosedBracket;
		case KeySym.XK_backslash: return KeyCode.Backslash;
		case KeySym.XK_Caps_Lock: return KeyCode.CapsLock;
		case KeySym.XK_a: return KeyCode.A;
		case KeySym.XK_s: return KeyCode.S;
		case KeySym.XK_d: return KeyCode.D;
		case KeySym.XK_f: return KeyCode.F;
		case KeySym.XK_g: return KeyCode.G;
		case KeySym.XK_h: return KeyCode.H;
		case KeySym.XK_j: return KeyCode.J;
		case KeySym.XK_k: return KeyCode.K;
		case KeySym.XK_l: return KeyCode.L;
		case KeySym.XK_semicolon: return KeyCode.Semicolon;
		case KeySym.XK_apostrophe: return KeyCode.Apostrophe;
		case KeySym.XK_Return: return KeyCode.Enter;
		case KeySym.XK_Shift_L: return KeyCode.LeftShift;
		case KeySym.XK_z: return KeyCode.Z;
		case KeySym.XK_x: return KeyCode.X;
		case KeySym.XK_c: return KeyCode.C;
		case KeySym.XK_v: return KeyCode.V;
		case KeySym.XK_b: return KeyCode.B;
		case KeySym.XK_n: return KeyCode.N;
		case KeySym.XK_m: return KeyCode.M;
		case KeySym.XK_comma: return KeyCode.Comma;
		case KeySym.XK_period: return KeyCode.Period;
		case KeySym.XK_slash: return KeyCode.Slash;
		case KeySym.XK_Shift_R: return KeyCode.RightShift;
		case KeySym.XK_Control_L: return KeyCode.LeftControl;
		case KeySym.XK_Super_L: return KeyCode.LeftSuper;
		case KeySym.XK_Alt_L: return KeyCode.LeftAlt;
		case KeySym.XK_space: return KeyCode.Space;
		case KeySym.XK_Alt_R: return KeyCode.RightAlt;
		case KeySym.XK_Control_R: return KeyCode.RightControl;
		case KeySym.XK_Hyper_L: return KeyCode.LeftHyper;
		case KeySym.XK_Hyper_R: return KeyCode.RightHyper;
		case KeySym.XK_Meta_L: return KeyCode.LeftMeta;
		case KeySym.XK_Meta_R: return KeyCode.RightMeta;
		case KeySym.XK_Left: return KeyCode.LeftArrow;
		case KeySym.XK_Right: return KeyCode.RightArrow;
		case KeySym.XK_Up: return KeyCode.UpArrow;
		case KeySym.XK_Down: return KeyCode.DownArrow;
		case KeySym.XK_Menu: return KeyCode.ContextMenu; // TODO: check that this actually works
		// case KeySym.XK_Macro: return KeyCode.Macro; // TODO: this
		case KeySym.XK_Num_Lock: return KeyCode.NumLock;
		case KeySym.XK_KP_Divide: return KeyCode.NumpadSlash;
		case KeySym.XK_KP_Multiply: return KeyCode.NumpadAsterisk;
		case KeySym.XK_KP_Subtract: return KeyCode.NumpadMinus;
		case KeySym.XK_KP_Add: return KeyCode.NumpadPlus;
		case KeySym.XK_KP_Delete: return KeyCode.NumpadPeriod;
		case KeySym.XK_KP_Enter: return KeyCode.NumpadEnter;
		case KeySym.XK_KP_Insert: return KeyCode.Numpad0;
		case KeySym.XK_KP_End: return KeyCode.Numpad1;
		case KeySym.XK_KP_Down: return KeyCode.Numpad2;
		case KeySym.XK_KP_Page_Down: return KeyCode.Numpad3;
		case KeySym.XK_KP_Left: return KeyCode.Numpad4;
		case KeySym.XK_KP_Begin: return KeyCode.Numpad5;
		case KeySym.XK_KP_Right: return KeyCode.Numpad6;
		case KeySym.XK_KP_Home: return KeyCode.Numpad7;
		case KeySym.XK_KP_Up: return KeyCode.Numpad8;
		case KeySym.XK_KP_Page_Up: return KeyCode.Numpad9;
		default: return KeyCode.Unknown;
	}
}

final class X11Window : AbstractWindow {

	Window window;

	this(InternalWindowOptions options) {
		auto screen = x.defaultScreen(x.display);

		XVisualInfo* vi = glx.getVisualFromFBConfig(x.display, fbconf);
		assert(vi);

		XSetWindowAttributes swa;
		auto root = x.rootWindow(x.display, screen);
		swa.colormap = x.createColormap(x.display, root, vi.visual, AllocNone);

		window = x.createWindow(x.display,
			root,
			0, 0, options.defaultWidth, options.defaultHeight,
			0, vi.depth, InputOutput, vi.visual, CWColormap, &swa,
		);

		x.sync(x.display, False);

		XClassHint class_;
		XWMHints wh;
		XSizeHints size;
		class_.res_class = class_.res_name = cast(char*) options.className.toStringz;
		x.setWMProperties(x.display, window, null, null, null, 0, &size, &wh, &class_);

		title = options.title;

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

	bool onFirstPaintCalled;

	void makeCurrent() {
		bool success = glx.makeCurrent(x.display, window, glc) != 0;
		enforce(success);
	}

	override void redraw() {
		if (!visibility) {
			return;
		}

		makeCurrent();

		if (!onFirstPaintCalled) {
			onFirstPaintCalled = true;
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
