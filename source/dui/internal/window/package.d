module dui.internal.window;
import dui;

abstract class AbstractWindow {

	Signal!() onFirstPaint;
	Signal!() onPaint;
	Signal!() onCloseRequest;
	Signal!KeyCode onKeyDown;
	Signal!KeyCode onKeyRepeat;
	Signal!KeyCode onKeyUp;

	void redraw();
	void queueRedraw();

	void title(string value);
	string title() const;

	void visibility(bool value);
	bool visibility() const;

	void vsync(bool value);
	int width() const;
	int height() const;

}

struct InternalWindowOptions {
	uint defaultWidth;
	uint defaultHeight;
	string title;
	string className;
}

void initWindowSystem() {
	static bool initialized;

	if (initialized) {
		return;
	}
	else {
		initialized = true;
	}

	version (linux) {
		import dui.internal.window.x11 : initX11;

		initX11();
	}
	else {
		static assert(0);
	}
}

AbstractWindow createWindow(InternalWindowOptions options) {
	initWindowSystem();

	version (linux) {
		import dui.internal.window.x11 : X11Window;

		return new X11Window(options);
	}
	else {
		static assert(0);
	}
}

bool processEvents() {
	initWindowSystem();

	version (linux) {
		import dui.internal.window.x11 : x;

		return x.processEvents();
	}
	else {
		static assert(0);
	}
}

void waitForEvents() {
	initWindowSystem();

	version (linux) {
		import dui.internal.window.x11 : x;

		x.waitForEvents();
	}
	else {
		static assert(0);
	}
}

void enqueueEvent(void delegate() callback) {
	initWindowSystem();

	version (linux) {
		import dui.internal.window.x11 : x;

		x.enqueueEvent(callback);
	}
	else {
		static assert(0);
	}
}

// TODO: provide connection number to user code
