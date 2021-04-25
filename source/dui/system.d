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
	result.theme = SystemTheme.Light;
	return result;
}
