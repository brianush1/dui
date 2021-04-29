// import arsd.simpledisplay;
import font;
import dui;
import std.file;
import core.time;
import std.datetime;
import std.random;
double getUnixTime() {
	import std.datetime.systime : SysTime, Clock;
	import std.datetime.interval : Interval;
	import std.datetime.date : DateTime;
	import std.datetime.timezone : UTC;

	return Interval!SysTime(SysTime(DateTime(1970, 1, 1), UTC()), Clock.currTime)
		.length.total!"hnsecs" / 10_000_000.0;
}

void main() {
	Path wack;
	wack.moveTo(Vec2(0, 0));
	wack.lineTo(Vec2(1, 0));
	wack.lineTo(Vec2(0, 1));
	foreach (i; 0 .. 50) {
		if (uniform!"[]"(1, 10) == 1) {
			wack.moveTo(Vec2(uniform!"[]"(-320, 320), uniform!"[]"(-240, 240)));
		}
		else {
			wack.quadTo(
				Vec2(uniform!"[]"(-320, 320), uniform!"[]"(-240, 240)),
				Vec2(uniform!"[]"(-320, 320), uniform!"[]"(-240, 240))
			);
		}
	}
	double start = getUnixTime;
	Canvas canvas = new Canvas;
	canvas.clear(Vec4(1, 1, 1, 1), IVec2(640, 480));
	canvas.setSource(Vec4(0, 0, 0, 1));
	canvas.transform = Mat3(Vec2(canvas.size) / 2);
	canvas.fill(wack, FillOptions(
		FillRule.EvenOdd,
	));
	Window win = new Window("Dui 1");
	// win.vsync = true;
	int count = 0;
	win.onPaint.connect({
		double now = getUnixTime - start;
		import std.math : sin, cos;
		win.canvas.clear(Vec4(0.0, 0.0, 0.0, 1), win.size);
		win.canvas.setSource(canvas, Mat3.scale(Vec2(sin(now), cos(now))));
		Path path;
		path.rect(Vec2(), Vec2(win.size));
		win.canvas.fill(path);
		win.queueRedraw();
	});
	win.show();
	Window win2 = new Window("Dui 2");
	win2.onPaint.connect({
		double now = getUnixTime - start;
		win2.canvas.clear(Vec4(uniform!"[]"(0.0, 1.0), uniform!"[]"(0.0, 1.0), uniform!"[]"(0.0, 1.0), 1), win2.size);
	});
	win2.show();
	win.onCloseRequest.connect({
		import std.stdio : writeln;

		writeln("want close 1");
		stopApplication();
	});
	win2.onCloseRequest.connect({
		import std.stdio : writeln;

		writeln("want close 2");
		stopApplication();
	});
	runApplication();
}
