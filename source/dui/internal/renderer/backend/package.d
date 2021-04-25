module dui.internal.renderer.backend;
import dui;

struct ShaderSource {
	string vertex;
	string fragment;
}

interface Shader {
	void free();
	void setUniform(string name, float value);
	void setUniform(string name, int value);
	void setUniform(string name, FVec2 value);
	void setUniform(string name, FVec3 value);
	void setUniform(string name, FVec4 value);
	void setUniform(string name, IVec2 value);
	void setUniform(string name, IVec3 value);
	void setUniform(string name, IVec4 value);
	void setUniform(string name, FMat3 value);
	void setUniform(string name, const(Texture) value);
}

struct Attribute {
	enum Type {
		Float,
		FVec2,
		FVec3,
		FVec4,
		Int,
		IVec2,
		IVec3,
		IVec4,
	}

	string name;
	Type type;
	size_t byteOffset;
}

size_t byteLength(Attribute.Type type) {
	final switch (type) {
		case Attribute.Type.Float: return float.sizeof;
		case Attribute.Type.FVec2: return FVec2.sizeof;
		case Attribute.Type.FVec3: return FVec3.sizeof;
		case Attribute.Type.FVec4: return FVec4.sizeof;
		case Attribute.Type.Int: return int.sizeof;
		case Attribute.Type.IVec2: return IVec2.sizeof;
		case Attribute.Type.IVec3: return IVec3.sizeof;
		case Attribute.Type.IVec4: return IVec4.sizeof;
	}
}

struct VertexFormat {
	Attribute[] attributes;
	size_t stride;

	void add(string name, Attribute.Type type) {
		// TODO: bind to input based on name; currently uses order
		attributes ~= Attribute(name, type, stride);
		stride += type.byteLength;
	}
}

interface VertexBuffer {
	void free();

	void upload(void[] data);
}

interface Texture {
	void free();

	IVec2 size() const;
}

interface Framebuffer : Texture {
	void resize(IVec2 size);

	void[] getPixels(IVec2 position, IVec2 size) const;

	void setPixels(IVec2 position, IVec2 size, void[] data);
}

enum DrawMode {
	Triangles,
	TriangleFan,
	TriangleStrip,
}

struct Stencil {
	enum Function {
		Always,
		Never,
		Lt,
		Le,
		Gt,
		Ge,
		Eq,
		Neq,
	}

	enum Operation {
		Nop,
		Zero,
		Set,
		Inc,
		Dec,
		IncWrap,
		DecWrap,
		Inv,
	}

	Function func = Function.Always;
	Operation stencilFail = Operation.Nop;
	Operation depthFail = Operation.Nop;
	Operation pass = Operation.Nop;
	ubyte refValue = 0;
	ubyte writeMask = 0xFF;
	ubyte readMask = 0xFF;
}

struct BlendingFunction {
	enum Factor {
		Zero,
		One,
		SrcColor,
		DstColor,
		SrcAlpha,
		DstAlpha,
		ConstColor,
		ConstAlpha,
		OneMinusSrcColor,
		OneMinusDstColor,
		OneMinusSrcAlpha,
		OneMinusDstAlpha,
		OneMinusConstColor,
		OneMinusConstAlpha,
	}

	enum Operation {
		Add,
		SrcMinusDst,
		DstMinusSrc,
		Min,
		Max,
	}

	Operation op;
	Factor sfactor;
	Factor dfactor;
	FVec4 constant = FVec4(0, 0, 0, 0);
}

enum BlendingMode : BlendingFunction {
	Normal = BlendingFunction(
		BlendingFunction.Operation.Add,
		BlendingFunction.Factor.SrcAlpha,
		BlendingFunction.Factor.OneMinusSrcAlpha,
	),
	Overwrite = BlendingFunction(
		BlendingFunction.Operation.Add,
		BlendingFunction.Factor.One,
		BlendingFunction.Factor.Zero,
	),
	Add = BlendingFunction(
		BlendingFunction.Operation.Add,
		BlendingFunction.Factor.One,
		BlendingFunction.Factor.One,
	),
}

interface AbstractGPUContext {
	void free();

	// ShaderSource compile(ShaderSource source);

	/** Creates a shader from the given source. May throw if the source provided is invalid */
	Shader createShader(ShaderSource source);

	VertexBuffer createVertexBuffer();

	Framebuffer createFramebuffer(IVec2 size);

	Texture createTexture(IVec2 size, const(void)[] data);

	/** Gets the current bound framebuffer, or $(D null) if none */
	inout(Framebuffer) currentFramebuffer() inout;

	void bind(Framebuffer fbo);

	void useShader(Shader shader);

	/** Sets the viewport rectangle for the context */
	void viewport(IVec2 location, IVec2 size);

	/** Clears the color buffer with the given color */
	void clearColor(FVec4 color);

	/** Clears the stencil buffer with the given stencil */
	void clearStencil(ubyte stencil);

	/** Gets the front-face stencil function */
	Stencil frontStencil() const;

	/** Gets the back-face stencil function */
	Stencil backStencil() const;

	/** Same as $(REF frontStencil) */
	Stencil stencil() const;

	void stencil(Stencil value);

	void stencil(Stencil front, Stencil back);

	/** Gets the color channel blending function */
	BlendingFunction colorBlend() const;

	/** Gets the alpha channel blending function */
	BlendingFunction alphaBlend() const;

	/** Same as $(REF colorBlend) */
	BlendingFunction blend() const;

	void blend(BlendingFunction value);

	void blend(BlendingFunction color, BlendingFunction alpha);

	void colorWriteMask(bool r, bool g, bool b, bool a);

	void draw(DrawMode mode, VertexBuffer buffer, const(VertexFormat) format, size_t start, size_t numVertices);
}
