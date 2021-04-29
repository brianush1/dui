module dui.internal.renderer;
import dui.internal.renderer.backend.opengl;
import dui.internal.renderer.backend;
import dui.internal.bindings.opengl;
import dui;

struct FillCommand {
	FillOptions options;
	Vec4 tint;
	Mat3 transform;
	Path path;
	Texture texture;
	Mat3 textureTransform;
}

private {
	struct Sample {
		FVec2 translate;
		FVec4 color;
	}

	immutable(Sample[]) rgbSubpixelSamples = [
		// near subpixel
		Sample(FVec2(1 - 5.5 / 12.0,  0.5 / 4.0), FVec4(0.25, 0, 0, 0)),
		Sample(FVec2(1 - 4.5 / 12.0, -1.5 / 4.0), FVec4(0.25, 0, 0, 0)),
		Sample(FVec2(1 - 3.5 / 12.0,  1.5 / 4.0), FVec4(0.25, 0, 0, 0)),
		Sample(FVec2(1 - 2.5 / 12.0, -0.5 / 4.0), FVec4(0.25, 0, 0, 0)),

		// center subpixel
		Sample(FVec2(-1.5 / 12.0,  0.5 / 4.0), FVec4(0, 0.25, 0, 0)),
		Sample(FVec2(-0.5 / 12.0, -1.5 / 4.0), FVec4(0, 0.25, 0, 0)),
		Sample(FVec2( 0.5 / 12.0,  1.5 / 4.0), FVec4(0, 0.25, 0, 0)),
		Sample(FVec2( 1.5 / 12.0, -0.5 / 4.0), FVec4(0, 0.25, 0, 0)),

		// far subpixel
		Sample(FVec2( 2.5 / 12.0,  0.5 / 4.0), FVec4(0, 0, 0.25, 0)),
		Sample(FVec2( 3.5 / 12.0, -1.5 / 4.0), FVec4(0, 0, 0.25, 0)),
		Sample(FVec2( 4.5 / 12.0,  1.5 / 4.0), FVec4(0, 0, 0.25, 0)),
		Sample(FVec2( 5.5 / 12.0, -0.5 / 4.0), FVec4(0, 0, 0.25, 0)),
	];

	immutable(Sample[]) grayscaleSamples = [
		Sample(FVec2(-3.5 / 8.0, -1.5 / 8.0), FVec4(0.125, 0, 0, 0)),
		Sample(FVec2(-2.5 / 8.0,  2.5 / 8.0), FVec4(0.125, 0, 0, 0)),
		Sample(FVec2(-1.5 / 8.0, -2.5 / 8.0), FVec4(0.125, 0, 0, 0)),
		Sample(FVec2(-0.5 / 8.0,  0.5 / 8.0), FVec4(0.125, 0, 0, 0)),
		Sample(FVec2( 0.5 / 8.0, -3.5 / 8.0), FVec4(0.125, 0, 0, 0)),
		Sample(FVec2( 1.5 / 8.0,  3.5 / 8.0), FVec4(0.125, 0, 0, 0)),
		Sample(FVec2( 2.5 / 8.0, -0.5 / 8.0), FVec4(0.125, 0, 0, 0)),
		Sample(FVec2( 3.5 / 8.0,  1.5 / 8.0), FVec4(0.125, 0, 0, 0)),
	];

	immutable(Sample[]) aliasedSamples = [
		Sample(FVec2(0, 0), FVec4(1, 0, 0, 0)),
	];
}

enum RendererBackend {
	OpenGL,
}

enum defaultBackend = RendererBackend.OpenGL;

final class RenderContext {
	AbstractGPUContext ctx;
	alias ctx this;

	Shader vectorShader;
	Shader subpixelShader;
	Shader grayscaleShader;
	Shader blitShader;

	this(RendererBackend backend) {
		final switch (backend) {
			case RendererBackend.OpenGL:
				ctx = new OpenGLContext;
				break;
		}
		initShaders();
	}

	private void initShaders() {
		vectorShader = ctx.createShader(ShaderSource(
			q{
				#version 330 core
				layout(location = 0) in vec2 aPos;
				layout(location = 1) in vec2 aUv;

				uniform vec2 uViewportSize;
				uniform vec2 uTranslate;

				out vec2 uv;

				void main() {
					gl_Position = vec4(
						(aPos + uTranslate) / uViewportSize * vec2(2, -2) + vec2(-1, 1),
						0.0, 1.0);
					uv = aUv;
				}
			},
			q{
				#version 330 core
				out vec4 FragColor;

				uniform vec4 uColor;

				in vec2 uv;

				void main() {
					float v = uv.x / 2.0 + uv.y;
					if (v * v > uv.y) {
						discard;
					}
					FragColor = uColor;
				}
			},
		));
		subpixelShader = ctx.createShader(ShaderSource(
			q{
				#version 330 core
				layout(location = 0) in vec2 aPos;
				layout(location = 1) in vec2 aUv;

				out vec2 uv;

				void main() {
					gl_Position = vec4(aPos, 0.0, 1.0);
					uv = aUv;
				}
			},
			q{
				#version 330 core
				out vec4 FragColor;

				uniform sampler2D uSource;
				uniform sampler2D uTarget;
				uniform sampler2D uTexture;
				uniform mat3 uTextureTransform;
				uniform bool uTextureEnabled;
				uniform vec4 uColor;
				uniform vec2 uViewportSize;
				uniform float uContrastFactor;

				in vec2 uv;

				void main() {
					vec4 sample = texture(uSource, uv);
					vec4 sampleL = texture(uSource, uv - vec2(1.0 / uViewportSize.x, 0));
					vec4 target = texture(uTarget, uv);

					float s0 = sampleL.z;
					float s1 = sampleL.x;
					float s2 = sample.y;
					float s3 = sample.z;
					float s4 = sample.x;

					float nr = mix(s1, (s0 + s1 + s2) / 3.0, uContrastFactor);
					float ng = mix(s2, (s1 + s2 + s3) / 3.0, uContrastFactor);
					float nb = mix(s3, (s2 + s3 + s4) / 3.0, uContrastFactor);
					// float nb = (s0 + s1 + s2) / 3.0;
					// float ng = (s1 + s2 + s3) / 3.0;
					// float nr = (s2 + s3 + s4) / 3.0;
					vec4 color = uTextureEnabled
						? uColor * texture(uTexture, (inverse(uTextureTransform) * vec3(uv, 1.0)).xy)
						: uColor;
					FragColor = vec4(
						color.r * nr*color.a + target.r * (1.0 - nr*color.a),
						color.g * ng*color.a + target.g * (1.0 - ng*color.a),
						color.b * nb*color.a + target.b * (1.0 - nb*color.a),
						1.0);
					// FragColor = sample;
				}
			},
		));
		grayscaleShader = ctx.createShader(ShaderSource(
			q{
				#version 330 core
				layout(location = 0) in vec2 aPos;
				layout(location = 1) in vec2 aUv;

				out vec2 uv;

				void main() {
					gl_Position = vec4(aPos, 0.0, 1.0);
					uv = aUv;
				}
			},
			q{
				#version 330 core
				out vec4 FragColor;

				uniform sampler2D uSource;
				uniform sampler2D uTexture;
				uniform mat3 uTextureTransform;
				uniform bool uTextureEnabled;
				uniform vec4 uColor;

				in vec2 uv;

				void main() {
					vec4 sample = texture(uSource, uv);
					vec4 color = uTextureEnabled
						? uColor * texture(uTexture, (inverse(uTextureTransform) * vec3(uv, 1.0)).xy)
						: uColor;
					FragColor = vec4(color.rgb, color.a * sample.x);
				}
			},
		));
		blitShader = ctx.createShader(ShaderSource(
			q{
				#version 330 core
				layout(location = 0) in vec2 aPos;
				layout(location = 1) in vec2 aUv;

				out vec2 uv;

				void main() {
					gl_Position = vec4(aPos, 0.0, 1.0);
					uv = aUv;
				}
			},
			q{
				#version 330 core
				out vec4 FragColor;

				uniform sampler2D uTexture;

				in vec2 uv;

				void main() {
					FragColor = texture(uTexture, uv);
				}
			},
		));
	}

	void free() {
		vectorShader.free();
		subpixelShader.free();
		grayscaleShader.free();
		blitShader.free();
		ctx.free();
	}
}

RenderContext globalContext;

void setupGlobalContext(RendererBackend backend) {
	import dui.internal.window : initWindowSystem;

	initWindowSystem();

	if (!globalContext) {
		globalContext = new RenderContext(backend);
	}
}

void freeGlobalContext() {
	if (globalContext) {
		globalContext.free();
		globalContext = null;
	}
}

final class Renderer {
	private {
		RenderContext ctx;

		VertexBuffer buf, quad;
		Framebuffer sourceFbo, targetFbo;
		bool ownsFbo;
	}

	inout(Framebuffer) fbo() inout {
		return targetFbo;
	}

	void free() {
		buf.free();
		quad.free();
		sourceFbo.free();
		if (ownsFbo) {
			targetFbo.free();
		}
	}

	void setup(RenderContext ctx, Framebuffer fbo = null) {
		this.ctx = ctx;

		buf = ctx.createVertexBuffer();
		quad = ctx.createVertexBuffer();
		quad.upload(cast(void[]) [
			-1.0f, -1.0f, 0.0f, 0.0f,
			 1.0f, -1.0f, 1.0f, 0.0f,
			 1.0f,  1.0f, 1.0f, 1.0f,
			-1.0f,  1.0f, 0.0f, 1.0f,
		]);
		sourceFbo = ctx.createFramebuffer(IVec2());
		targetFbo = fbo ? fbo : ctx.createFramebuffer(IVec2());
		ownsFbo = fbo is null;
	}

	private IVec2 size;

	void begin(Vec4 color, IVec2 size) {
		this.size = size;

		sourceFbo.resize(size);
		targetFbo.resize(size);

		ctx.bind(targetFbo);
		ctx.clearColor(FVec4(color));
	}

	void render(const(FillCommand)[] commands) {
		ctx.viewport(IVec2(0, 0), size);
		ctx.vectorShader.setUniform("uViewportSize", cast(FVec2) size);
		ctx.subpixelShader.setUniform("uViewportSize", cast(FVec2) size);

		VertexFormat fmt;
		fmt.add("aPos", Attribute.Type.FVec2);
		fmt.add("aUv", Attribute.Type.FVec2);

		foreach (fill; commands) {
			import std.math : floor, ceil;
			import std.algorithm : map;

			struct Vertex {
				Vec2 point;
				Vec2 uv;
			}

			Vertex[3][] geometry;

			auto points = fill.path.points.map!(x => fill.transform * x);
			if (points.length == 0) {
				continue;
			}

			double minX = double.infinity;
			double maxX = -double.infinity;
			double minY = double.infinity;
			double maxY = -double.infinity;
			foreach (point; points) {
				if (point.x < minX) minX = point.x;
				if (point.x > maxX) maxX = point.x;
				if (point.y < minY) minY = point.y;
				if (point.y > maxY) maxY = point.y;
			}
			minX = floor(minX - 1);
			minY = floor(minY - 1);
			maxX = ceil(maxX + 1);
			maxY = ceil(maxY + 1);

			size_t pointIndex;
			Vec2 lastMove;
			Vec2 lastPoint;
			foreach (cmd; fill.path.commands) {
				final switch (cmd) {
					case Path.Command.Move:
						auto point = points[pointIndex++];
						lastMove = point;
						lastPoint = point;
						break;
					case Path.Command.Close:
						lastPoint = lastMove;
						break;
					case Path.Command.Line:
						auto point = points[pointIndex++];
						geometry ~= [
							Vertex(lastMove, Vec2()),
							Vertex(lastPoint, Vec2()),
							Vertex(point, Vec2()),
						];
						lastPoint = point;
						break;
					case Path.Command.Quad:
						auto control = points[pointIndex++];
						auto point = points[pointIndex++];
						geometry ~= [
							Vertex(lastMove, Vec2()),
							Vertex(lastPoint, Vec2()),
							Vertex(point, Vec2()),
						];
						geometry ~= [
							Vertex(lastPoint, Vec2(0, 0)),
							Vertex(control, Vec2(1, 0)),
							Vertex(point, Vec2(0, 1)),
						];
						lastPoint = point;
						break;
					case Path.Command.Cubic:
						assert(0);
				}
			}

			FVec2[] data;

			foreach (triangle; geometry) {
				data ~= FVec2(triangle[0].point);
				data ~= FVec2(triangle[0].uv);
				data ~= FVec2(triangle[1].point);
				data ~= FVec2(triangle[1].uv);
				data ~= FVec2(triangle[2].point);
				data ~= FVec2(triangle[2].uv);
			}

			// cover
			data ~= FVec2(minX, minY);
			data ~= FVec2(0, 0);
			data ~= FVec2(minX, maxY);
			data ~= FVec2(0, 0);
			data ~= FVec2(maxX, maxY);
			data ~= FVec2(0, 0);
			data ~= FVec2(maxX, minY);
			data ~= FVec2(0, 0);

			// subpixel cover
			data ~= FVec2(minX, minY) / FVec2(fbo.size) * FVec2(2, -2) + FVec2(-1, 1);
			data ~= FVec2(minX, minY) / FVec2(fbo.size) * FVec2(1, -1);
			data ~= FVec2(minX, maxY) / FVec2(fbo.size) * FVec2(2, -2) + FVec2(-1, 1);
			data ~= FVec2(minX, maxY) / FVec2(fbo.size) * FVec2(1, -1);
			data ~= FVec2(maxX, maxY) / FVec2(fbo.size) * FVec2(2, -2) + FVec2(-1, 1);
			data ~= FVec2(maxX, maxY) / FVec2(fbo.size) * FVec2(1, -1);
			data ~= FVec2(maxX, minY) / FVec2(fbo.size) * FVec2(2, -2) + FVec2(-1, 1);
			data ~= FVec2(maxX, minY) / FVec2(fbo.size) * FVec2(1, -1);

			buf.upload(cast(void[]) data);

			ctx.useShader(ctx.vectorShader);
			ctx.bind(sourceFbo);
			ctx.clearColor(FVec4(0, 0, 0, 1));
			ctx.clearStencil(0x00);
			ctx.blend = BlendingMode.Add;

			const(Sample)[] samples;

			final switch (fill.options.antialias) {
				case Antialias.None:
					samples = aliasedSamples;
					break;
				case Antialias.Subpixel:
					samples = rgbSubpixelSamples;
					break;
				case Antialias.Grayscale:
					samples = grayscaleSamples;
					break;
			}

			foreach (sample; samples) {
				if (fill.options.fillRule == FillRule.EvenOdd) {
					Stencil stencil;
					stencil.pass = Stencil.Operation.Inv;
					ctx.stencil = stencil;
				}
				else {
					Stencil stencilFront, stencilBack;
					stencilFront.pass = Stencil.Operation.IncWrap;
					stencilBack.pass = Stencil.Operation.DecWrap;
					ctx.stencil(stencilFront, stencilBack);
				}

				ctx.colorWriteMask(false, false, false, false);

				ctx.vectorShader.setUniform("uColor", sample.color);
				ctx.vectorShader.setUniform("uTranslate", -sample.translate);

				ctx.draw(DrawMode.Triangles, buf, fmt, 0, geometry.length * 3);

				ctx.colorWriteMask(true, true, true, true);
				Stencil stencil;
				stencil.func = Stencil.Function.Neq;
				stencil.refValue = 0;
				stencil.stencilFail = Stencil.Operation.Zero;
				stencil.depthFail = Stencil.Operation.Zero;
				stencil.pass = Stencil.Operation.Zero;
				ctx.stencil = stencil;
				ctx.draw(DrawMode.TriangleFan, buf, fmt, geometry.length * 3, 4);
			}

			ctx.bind(targetFbo);
			ctx.stencil = Stencil.init;

			final switch (fill.options.antialias) {
				case Antialias.Subpixel:
					ctx.blend = BlendingMode.Overwrite;
					ctx.useShader(ctx.subpixelShader);
					ctx.subpixelShader.setUniform("uContrastFactor", 1.0f);
					ctx.subpixelShader.setUniform("uColor", FVec4(fill.tint));
					ctx.subpixelShader.setUniform("uSource", sourceFbo);
					ctx.subpixelShader.setUniform("uTarget", targetFbo);
					ctx.subpixelShader.setUniform("uTexture", fill.texture);
					ctx.subpixelShader.setUniform("uTextureTransform", FMat3(fill.textureTransform));
					ctx.subpixelShader.setUniform("uTextureEnabled", fill.texture ? 1 : 0);
					break;
				case Antialias.None:
				case Antialias.Grayscale:
					ctx.blend = BlendingMode.Normal;
					ctx.useShader(ctx.grayscaleShader);
					ctx.grayscaleShader.setUniform("uColor", FVec4(fill.tint));
					ctx.grayscaleShader.setUniform("uSource", sourceFbo);
					ctx.grayscaleShader.setUniform("uTexture", fill.texture);
					ctx.grayscaleShader.setUniform("uTextureTransform", FMat3(fill.textureTransform));
					ctx.grayscaleShader.setUniform("uTextureEnabled", fill.texture ? 1 : 0);
					break;
			}

			ctx.draw(DrawMode.TriangleFan, buf, fmt, geometry.length * 3 + 4, 4);
		}
	}

	void blitToScreen(IVec2 viewportSize) {
		VertexFormat fmt;
		fmt.add("aPos", Attribute.Type.FVec2);
		fmt.add("aUv", Attribute.Type.FVec2);

		ctx.viewport(IVec2(0, 0), viewportSize);
		ctx.bind(null);
		ctx.useShader(ctx.blitShader);

		ctx.blitShader.setUniform("uTexture", fbo);

		ctx.draw(DrawMode.TriangleFan, quad, fmt, 0, 4);
	}

}

void blitToScreen(Canvas canvas, IVec2 viewportSize) {
	// canvas.flush();
	canvas.backend.blitToScreen(viewportSize);
}
