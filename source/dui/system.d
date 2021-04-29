module dui.system;
import dui.canvas;

enum SystemTheme {
	Light,
	Dark,
}

struct SystemSettings {
	LcdPixelLayout lcdPixelLayout;
	double doubleClickTime;
	double caretBlinkRate;

	/** The amount of time, in seconds, to wait after a key is initially pressed before starting to repeat the key */
	double keyRepeatDelay;

	/** The frequency, in hertz, at which a key should be repeated when held pressed */
	double keyRepeatFrequency;

	SystemTheme theme;
}

SystemSettings* systemSettings() {
	static SystemSettings* result;
	if (result) {
		return result;
	}
	result = new SystemSettings;
	result.lcdPixelLayout = LcdPixelLayout(PixelOrder.HorizontalRGB, 0.0);
	result.doubleClickTime = 0.2;
	result.caretBlinkRate = 0.5;
	result.keyRepeatDelay = 0.5;
	result.keyRepeatFrequency = 30;
	result.theme = SystemTheme.Light;
	return result;
}
