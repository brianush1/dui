module dui.canvas;
import dui.internal.renderer;
import dui.internal.renderer.backend : Texture;
import dui;
import std.typecons;

enum PixelOrder {
	Flat,
	HorizontalRGB,
	HorizontalBGR,
	VerticalRGB,
	VerticalBGR,
}

struct LcdPixelLayout {
	PixelOrder order;
	double contrast;
}

enum Blending {
	Normal,
	Overwrite,
	Add,
}

enum Antialias {
	Grayscale,

	/**

	Uses subpixel antialiasing.

	Note that this will remove the alpha component under the bounding box of the path rendered
	using subpixel antialiasing. This will also ignore any blending mode specified and use $(REF Blending.Normal).

	*/
	Subpixel,

	None,
}

enum FillRule {
	NonZero,
	EvenOdd,
}

struct FillOptions {
	FillRule fillRule;
	Antialias antialias;
	Nullable!LcdPixelLayout subpixelLayout;
}

final class Image {

	immutable(size_t) width, height;
	immutable(void[]) pixels;

	IVec2 size() const @property {
		return IVec2(cast(int) width, cast(int) height);
	}

	private Texture texture;

	/** Attempts to load an image from the given data */
	this(const(void)[] data) {
		import imageformats : IFImage, ColFmt, read_image_from_mem;

		IFImage decoded = read_image_from_mem(cast(ubyte[]) data, ColFmt.RGBA);
		width = decoded.w;
		height = decoded.h;
		pixels = cast(immutable(void)[]) decoded.pixels;
		texture = globalContext.createTexture(IVec2(cast(int) width, cast(int) height), pixels);
	}

	private this(size_t width, size_t height, immutable(void)[] pixels) {
		this.width = width;
		this.height = height;
		this.pixels = pixels;
		texture = globalContext.createTexture(IVec2(cast(int) width, cast(int) height), pixels);
	}

	~this() {
		if (texture)
			texture.free();
	}

	static Image fromRawPixels(const(void)[] data, int width) {
		return new Image(
			cast(size_t) width, data.length / (cast(size_t) 4 * width),
			data.idup,
		);
	}

	immutable(void)[] save() {
		import imageformats : write_png_to_mem;

		return cast(immutable(void)[]) write_png_to_mem(width, height,
			cast(ubyte[]) pixels, 4);
	}

}

final class Canvas {
	package {
		IVec2 _size;
		Renderer backend;
		// Canvas[] dependencies;
		// Canvas[] dependents;
		// FillCommand[] queuedCommands;

		// void flush() const {
		// 	if (queuedCommands.length == 0) {
		// 		return;
		// 	}

		// 	auto self = cast(Canvas) this;

		// 	foreach (dependency; dependencies) {
		// 		dependency.flush();
		// 	}

		// 	self.backend.render(queuedCommands);

		// 	self.queuedCommands = [];
		// 	self.dependencies = [];
		// }

		// void flushDependents() const {
		// 	auto self = cast(Canvas) this;

		// 	foreach (dependent; dependents) {
		// 		dependent.flush();
		// 	}

		// 	self.dependents = [];
		// }
	}

	this() {
		backend = new Renderer();
		setupGlobalContext(defaultBackend);
		backend.setup(globalContext);
		clear(Vec4(0, 0, 0, 0), IVec2(320, 200));
	}

	~this() {
		backend.free();
	}

	IVec2 size() const @property {
		return _size;
	}

	void clear(Vec4 background, IVec2 newSize) {
		_size = newSize;
		backend.begin(background, newSize);
	}

	int width() const @property {
		return size.x;
	}

	int height() const @property {
		return size.y;
	}

	private Vec4 tint;

	void setSource(Vec4 color) {
		tint = color;
		texture = null;
	}

	private {
		Texture texture;
		Mat3 textureTransform;
	}

	// when drawing another canvas, make sure that flushing this canvas flushes the other canvas first
	// also any other operations on the other canvas need to have this canvas flushed before
	// because we need to draw the other canvas as it was before those new operations
	// TODO: check if above is implemented correctly
	void setSource(Canvas canvas, Mat3 transform = Mat3.init) {
		import std.exception : enforce;

		enforce(canvas !is this, "cannot render canvas onto itself");

		// dependencies ~= canvas;
		// canvas.dependents ~= this;
		tint = Vec4(1, 1, 1, 1);
		texture = canvas.backend.fbo;
		textureTransform = Mat3.scale(Vec2(1, -1) / Vec2(size)) * transform * Mat3.scale(Vec2(canvas.size) * Vec2(1, -1));
	}

	void setSource(Image image, Mat3 transform = Mat3.init) {
		tint = Vec4(1, 1, 1, 1);
		texture = image.texture;
		textureTransform = Mat3.scale(Vec2(1, -1) / Vec2(size)) * transform * Mat3.scale(Vec2(image.size));
	}

	Mat3 transform;

	void fill(Path path, FillOptions options = FillOptions.init) {
		// flushDependents();
		// queuedCommands ~=
		backend.render([FillCommand(
			options,
			tint,
			transform,
			path,
			texture,
			textureTransform,
		)]);
	}

	void[] getImageData(IVec2 position, IVec2 size) const {
		// flush();
		return backend.fbo.getPixels(position, size);
	}

	void setImageData(IVec2 position, IVec2 size, void[] data) {
		// flush();
		backend.fbo.setPixels(position, size, data);
	}
}
