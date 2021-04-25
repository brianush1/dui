module dui.internal.window;
import dui;

abstract class AbstractWindow {

	Signal!() onFirstPaint;
	Signal!() onPaint;
	Signal!() onCloseRequest;
	Signal!KeyCode onKeyDown;
	Signal!KeyCode onKeyRepeat;
	Signal!KeyCode onKeyUp;

	void title(string value);
	string title() const;

	void visibility(bool value);
	bool visibility() const;

	void vsync(bool value);
	int width() const;
	int height() const;

}
