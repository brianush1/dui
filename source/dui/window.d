module dui.window;
import dui.internal.window;
import dui.eventloop : enqueueEvent;
import dui;

final class Window {

	private AbstractWindow internal;

	Signal!() onPaint;
	Signal!() onCloseRequest;
	Signal!KeyCode onKeyDown;
	Signal!KeyCode onKeyRepeat;
	Signal!KeyCode onKeyUp;

	Canvas canvas;

	private bool redrawQueued = false;

	this(string title, string className = "duiwindow", IVec2 defaultSize = IVec2(640, 480)) {
		InternalWindowOptions options = {
			defaultWidth: defaultSize.x,
			defaultHeight: defaultSize.y,
			title: title,
			className: className,
		};
		internal = createWindow(options);
		internal.onFirstPaint.connect({
			canvas = new Canvas;
		});
		internal.onPaint.connect({
			import dui.internal.renderer : blitToScreen;

			redrawQueued = false;

			onPaint.emit();

			canvas.blitToScreen(size);
		});
		internal.onCloseRequest.connect(onCloseRequest);
		internal.onKeyDown.connect(onKeyDown);
		internal.onKeyRepeat.connect(onKeyRepeat);
		internal.onKeyUp.connect(onKeyUp);
	}

	void title(string value) {
		internal.title = value;
	}

	string title() const {
		return internal.title;
	}

	IVec2 size() const {
		return IVec2(internal.width, internal.height);
	}

	bool isVisible() const {
		return internal.visibility;
	}

	void show() {
		internal.visibility = true;
	}

	void hide() {
		internal.visibility = false;
	}

	void queueRedraw() {
		if (!redrawQueued) {
			redrawQueued = true;
			enqueueEvent({
				internal.redraw();
			});
		}
	}

}
