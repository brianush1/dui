// import arsd.simpledisplay;
import font;
import dui;
import dui : Image;
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
	import dui.internal.window.x11 : X11Window;

	auto win = new X11Window(
		3, 3,
		640, 480,
		"Dui Example", "duiexample",
	);
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
	Canvas canvas, inner;
	win.onFirstPaint.connect({
		import dui.internal.renderer : setupGlobalContext, defaultBackend;

		setupGlobalContext(defaultBackend);
		canvas = new Canvas;
		inner = new Canvas;
	});
	double start = getUnixTime;
	double past = 0;
	double numFrames = 0;
	win.vsync = true;
	win.onPaint.connect({
		win.gl.clearColor(0, 0, 0, 1);
		win.gl.clear(win.gl.COLOR_BUFFER_BIT);

		double now = getUnixTime - start;
		if (now - past >= 1) {
			double fps = numFrames / (now - past);
			// debug { import std.stdio : writeln; try { writeln("fps: ", fps); } catch (Exception) {} }
			past = now;
			numFrames = 0;
		}
		numFrames++;
		import dui.internal.renderer : blitToScreen;

		Path rect;
		rect.moveTo(10, 10);
		rect.lineTo(100, 10);
		rect.lineTo(100, 100);
		rect.lineTo(10, 100);
		rect.quadTo(50, 100, 50, 50);
		rect.quadTo(50, 10, 10, 10);
		rect.close();

		canvas.clear(Vec4(1, 1, 1, 1), IVec2(win.width, win.height));

		inner.clear(Vec4(0, 0, 0, 0), IVec2(128, 128));
		inner.setSource(Vec4(0, 0, 0, 1));

		Path border;
		border.rect(Vec2(0, 0), Vec2(128, 128));
		border.rect(Vec2(1, 1), Vec2(126, 126), Rotation.CW);
		inner.fill(border, FillOptions(FillRule.NonZero, Antialias.Grayscale));

		import std.math : sin, cos;

		// canvas.setSource(Vec4(0, 0, 1, 1));
		Path foo;
		foo.rect(Vec2(0, 0), Vec2(canvas.size));

		canvas.setSource(inner);
		canvas.fill(foo);

		Path mid;
		mid.rect(Vec2(2, 2), Vec2(124, 20));
		inner.fill(mid);

		canvas.setSource(inner, Mat3(sin(now) * 256, cos(now) * 256) * Mat3.rotation(now * 30 * 3.14159 / 180));
		canvas.fill(foo);

		// canvas.setSource(Vec4(1, 0, 1, 1));
		// canvas.fill(rect, FillOptions(FillRule.EvenOdd, Antialias.Grayscale));

		// canvas.setSource(new Image(read("doggo.png")),
		// 	Mat3.scale(Vec2(0.2, 0.2))
		// 	* Mat3.rotation(20 * 3.14159 / 180));
		// canvas.transform = Mat3(win.width / 2.0, win.height / 2.0);
		// canvas.fill(wack, FillOptions(FillRule.EvenOdd, Antialias.Subpixel));
		// canvas.transform = Mat3.init;

		// renderer.render([
		// 	FillCommand(
		// 		FillOptions(FillRule.EvenOdd, Antialias.Grayscale),
		// 		Vec4(0, 0, 0, 1),
		// 		Mat3(),
		// 		rect,
		// 	),
		// 	FillCommand(
		// 		FillOptions(FillRule.EvenOdd, Antialias.Subpixel),
		// 		Vec4(0, 0, 0, 1),
		// 		Mat3(win.width / 2.0, win.height / 2.0) * Mat3.rotation(0 * 4),
		// 		wack,
		// 	),
		// ]);

		canvas.blitToScreen(IVec2(win.width, win.height));
		// win.redrawOpenGlSceneSoon;
	});
	// win.onKeyDown.connect((KeyCode key) {
	// 	debug { import std.stdio : writeln; try { writeln("pressed ", key); } catch (Exception) {} }
	// });
	spawnTask({
		while (true) {
			KeyCode key = win.onKeyDown.wait;
			debug { import std.stdio : writeln; try { writeln("pressed ", key); } catch (Exception) {} }
		}
	});
	win.visibility = true;
	win.eventLoop;

	// setOpenGLContextVersion(3, 3);
	// openGLContextCompatible = false;
	// SimpleWindow win = new SimpleWindow(640, 480,
	// 	"test", OpenGlOptions.yes, Resizability.allowResizing);
	// Path wack;
	// wack.moveTo(Vec2(0, 0));
	// wack.lineTo(Vec2(1, 0));
	// wack.lineTo(Vec2(0, 1));
	// foreach (i; 0 .. 50) {
	// 	if (uniform!"[]"(1, 10) == 1) {
	// 		wack.moveTo(Vec2(uniform!"[]"(-320, 320), uniform!"[]"(-240, 240)));
	// 	}
	// 	else {
	// 		wack.quadTo(
	// 			Vec2(uniform!"[]"(-320, 320), uniform!"[]"(-240, 240)),
	// 			Vec2(uniform!"[]"(-320, 320), uniform!"[]"(-240, 240))
	// 		);
	// 	}
	// }
	// Canvas canvas, inner;
	// win.visibleForTheFirstTime = {
	// 	import dui.internal.renderer : setupGlobalContext, defaultBackend;

	// 	win.setAsCurrentOpenGlContext;
	// 	setupGlobalContext(defaultBackend);
	// 	canvas = new Canvas;
	// 	inner = new Canvas;
	// };
	// double start = getUnixTime;
	// double past = 0;
	// double numFrames = 0;
	// win.redrawOpenGlScene = {
	// 	double now = getUnixTime - start;
	// 	if (now - past >= 1) {
	// 		double fps = numFrames / (now - past);
	// 		debug { import std.stdio : writeln; try { writeln("fps: ", fps); } catch (Exception) {} }
	// 		past = now;
	// 		numFrames = 0;
	// 	}
	// 	numFrames++;
	// 	import dui.internal.renderer : blitToScreen;

	// 	Path rect;
	// 	rect.moveTo(10, 10);
	// 	rect.lineTo(100, 10);
	// 	rect.lineTo(100, 100);
	// 	rect.lineTo(10, 100);
	// 	rect.quadTo(50, 100, 50, 50);
	// 	rect.quadTo(50, 10, 10, 10);
	// 	rect.close();

	// 	canvas.clear(Vec4(1, 1, 1, 1), IVec2(win.width, win.height));

	// 	inner.clear(Vec4(0, 0, 0, 0), IVec2(128, 128));
	// 	inner.setSource(Vec4(0, 0, 0, 1));

	// 	Path border;
	// 	border.rect(Vec2(0, 0), Vec2(128, 128));
	// 	border.rect(Vec2(1, 1), Vec2(126, 126), Rotation.CW);
	// 	inner.fill(border, FillOptions(FillRule.NonZero, Antialias.Grayscale));

	// 	import std.math : sin, cos;

	// 	// canvas.setSource(Vec4(0, 0, 1, 1));
	// 	Path foo;
	// 	foo.rect(Vec2(0, 0), Vec2(canvas.size));

	// 	canvas.setSource(inner);
	// 	canvas.fill(foo);

	// 	Path mid;
	// 	mid.rect(Vec2(2, 2), Vec2(124, 20));
	// 	inner.fill(mid);

	// 	canvas.setSource(inner, Mat3(sin(now) * 256, cos(now) * 256) * Mat3.rotation(now * 30 * 3.14159 / 180));
	// 	canvas.fill(foo);

	// 	// canvas.setSource(Vec4(1, 0, 1, 1));
	// 	// canvas.fill(rect, FillOptions(FillRule.EvenOdd, Antialias.Grayscale));

	// 	// canvas.setSource(new Image(read("doggo.png")),
	// 	// 	Mat3.scale(Vec2(0.2, 0.2))
	// 	// 	* Mat3.rotation(20 * 3.14159 / 180));
	// 	// canvas.transform = Mat3(win.width / 2.0, win.height / 2.0);
	// 	// canvas.fill(wack, FillOptions(FillRule.EvenOdd, Antialias.Subpixel));
	// 	// canvas.transform = Mat3.init;

	// 	// renderer.render([
	// 	// 	FillCommand(
	// 	// 		FillOptions(FillRule.EvenOdd, Antialias.Grayscale),
	// 	// 		Vec4(0, 0, 0, 1),
	// 	// 		Mat3(),
	// 	// 		rect,
	// 	// 	),
	// 	// 	FillCommand(
	// 	// 		FillOptions(FillRule.EvenOdd, Antialias.Subpixel),
	// 	// 		Vec4(0, 0, 0, 1),
	// 	// 		Mat3(win.width / 2.0, win.height / 2.0) * Mat3.rotation(0 * 4),
	// 	// 		wack,
	// 	// 	),
	// 	// ]);

	// 	canvas.blitToScreen(IVec2(win.width, win.height));
	// 	win.redrawOpenGlSceneSoon;
	// };
	// win.vsync = false;
	// win.eventLoop(1, delegate {});
}
