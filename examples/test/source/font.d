// module font;
// import arsd.ttf;

// static this() {
// 	Font.sansSerif = Font.fromBuffer(import("fonts/Roboto-Regular.ttf"));
// }

// struct FontMetrics {
// 	double ascent;
// 	double descent;
// 	double lineGap;
// 	double xHeight;
// }

// struct Glyph {
// 	private int index = -1;
// 	double advance;
// 	double lsb;
// }

// final class Font {

// 	static Font sansSerif;

// 	private {
// 		stbtt_fontinfo stbfont;
// 		double emScale;

// 		this() {
// 			metrics = FontMetrics.init;
// 		}
// 	}

// 	immutable(FontMetrics) metrics;

// 	Glyph glyph(dchar c) {
// 		int index = stbtt_FindGlyphIndex(&stbfont, cast(int) c);
// 		int advance, lsb;
// 		stbtt_GetGlyphHMetrics(&stbfont, index, &advance, &lsb);
// 		Glyph result = {
// 			index: index,
// 			advance: advance * emScale,
// 			lsb: lsb * emScale,
// 		};
// 		return result;
// 	}

// 	double kerningBetween(Glyph a, Glyph b) {
// 		if (a.index == -1 || b.index == -1)
// 			return 0;
// 		return stbtt_GetGlyphKernAdvance(&stbfont, a.index, b.index) * emScale;
// 	}

// 	static Font fromFile(string file) {
// 		import std.file : read;
// 		import std.exception : assumeUnique;

// 		return fromBuffer(read(file).assumeUnique);
// 	}

// 	static Font fromBuffer(string data) {
// 		return fromBuffer(cast(immutable(void)[]) data);
// 	}

// 	static Font fromBuffer(immutable(void)[] data) {
// 		import std.exception : enforce;

// 		Font result = new Font;
// 		stbtt_InitFont(&result.stbfont, cast(const(ubyte)*) data.ptr,
// 			stbtt_GetFontOffsetForIndex(cast(const(ubyte)*) data.ptr, 0));
// 		result.emScale = stbtt_ScaleForMappingEmToPixels(&result.stbfont, 1);
// 		int ascent, descent, lineGap, xHeight;
// 		stbtt_GetFontVMetrics(&result.stbfont, &ascent, &descent, &lineGap);
// 		int success = stbtt_GetFontXHeight(&result.stbfont, &xHeight);
// 		enforce(success, "could not get font metrics");
// 		FontMetrics m = {
// 			ascent: ascent * result.emScale,
// 			descent: descent * result.emScale,
// 			lineGap: lineGap * result.emScale,
// 			xHeight: xHeight * result.emScale,
// 		};
// 		*cast(FontMetrics*)&result.metrics = m;
// 		return result;
// 	}

// }

// private void addGlyph(ICanvas canvas, Font font, int glyphIndex,
// 		double fontSize, Vector2 pxOffset) {
// 	stbtt_vertex* pvertices;
// 	int nvertices = stbtt_GetGlyphShape(&font.stbfont, glyphIndex, &pvertices);
// 	stbtt_vertex[] vertices = pvertices[0 .. nvertices];
// 	Vector2 transform(double x, double y) {
// 		pragma(inline, true);
// 		return Vector2(x, y) * font.emScale * fontSize * Vector2(1, -1) + pxOffset;
// 	}
// 	foreach (vertex; vertices) {
// 		if (vertex.type == STBTT_vmove) {
// 			canvas.moveTo(transform(vertex.x, vertex.y));
// 		}
// 		else if (vertex.type == STBTT_vline) {
// 			canvas.lineTo(transform(vertex.x, vertex.y));
// 		}
// 		else if (vertex.type == STBTT_vcurve) {
// 			Vector2 p1 = transform(vertex.cx, vertex.cy);
// 			Vector2 p2 = transform(vertex.x, vertex.y);
// 			canvas.quadraticCurveTo(p1, p2);
// 		}
// 		else if (vertex.type == STBTT_vcubic) {
// 			assert(0);
// 		}
// 	}
// 	canvas.closePath();
// }
