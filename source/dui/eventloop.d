module dui.eventloop;
import win = dui.internal.window;
import dui;

void processEvents() {
	while (win.processEvents()) {}
}

void waitForEvents() {
	win.waitForEvents();
}

void enqueueEvent(void delegate() func) {
	win.enqueueEvent(func);
}

private static int running;

void runApplication() {
	running += 1;
	int myself = running;
	while (running == myself) {
		while (running == myself && win.processEvents()) {}
		waitForEvents();
	}
}

void stopApplication() {
	running += 1;
}
