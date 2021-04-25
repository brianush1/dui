module dui.internal.renderer.backend.opengl;
import dui.internal.renderer.backend;
import dui.internal.bindings.opengl;
import dui;

private void[] flipImage(size_t width, size_t height, const(void)[] data) {
	void[] result = new void[4 * width * height];
	size_t length = 4 * width;
	foreach (j; 0 .. height) {
		size_t index1 = j * 4 * width;
		size_t index2 = (height - j - 1) * 4 * width;
		result[index1 .. index1 + length] = data[index2 .. index2 + length];
	}
	return result;
}

final class OpenGLShader : Shader {
	OpenGL gl;
	OpenGLContext ctx;
	gl.UInt program;

	private this() {}

	void free() {
		if (!gl)
			return;

		gl.deleteProgram(program);
		gl = null;
	}

	private {
		gl.Int[string] uniformMemo;

		gl.Int uniformLocation(string name) {
			import std.string : toStringz;

			if (name in uniformMemo) {
				return uniformMemo[name];
			}

			gl.Int result = gl.getUniformLocation(program, name.toStringz);
			uniformMemo[name] = result;
			return result;
		}

		void restore() {
			ctx.useShader(ctx._currentShader);
		}

		void use() {
			gl.useProgram(program);
		}
	}

	void setUniform(string name, float value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniform1f(loc, cast(gl.Float) value);
	}

	void setUniform(string name, int value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniform1i(loc, cast(gl.Int) value);
	}

	void setUniform(string name, FVec2 value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniform2f(loc,
			cast(gl.Float) value.x,
			cast(gl.Float) value.y,
		);
	}

	void setUniform(string name, FVec3 value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniform3f(loc,
			cast(gl.Float) value.x,
			cast(gl.Float) value.y,
			cast(gl.Float) value.z,
		);
	}

	void setUniform(string name, FVec4 value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniform4f(loc,
			cast(gl.Float) value.x,
			cast(gl.Float) value.y,
			cast(gl.Float) value.z,
			cast(gl.Float) value.w,
		);
	}

	void setUniform(string name, IVec2 value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniform2i(loc,
			cast(gl.Int) value.x,
			cast(gl.Int) value.y,
		);
	}

	void setUniform(string name, IVec3 value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniform3i(loc,
			cast(gl.Int) value.x,
			cast(gl.Int) value.y,
			cast(gl.Int) value.z,
		);
	}

	void setUniform(string name, IVec4 value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniform4i(loc,
			cast(gl.Int) value.x,
			cast(gl.Int) value.y,
			cast(gl.Int) value.z,
			cast(gl.Int) value.w,
		);
	}

	void setUniform(string name, FMat3 value) {
		scope(exit)
			restore();
		use();
		gl.Int loc = uniformLocation(name);
		gl.uniformMatrix3fv(loc, 1, true, cast(const(gl.Float)*) &value);
	}

	private {
		int[string] textures;
		int currTexture;

		int assignTexture(string name) {
			if (name !in textures) {
				scope(exit)
					restore();
				use();
				gl.Int loc = uniformLocation(name);
				gl.uniform1i(loc, currTexture);

				textures[name] = currTexture;
				currTexture += 1;
			}
			return textures[name];
		}
	}

	void setUniform(string name, const(Texture) tex) {
		int texture = assignTexture(name);
		gl.activeTexture(gl.TEXTURE0 + texture);
		if (cast(OpenGLFramebuffer) tex) {
			gl.bindTexture(gl.TEXTURE_2D, (cast(OpenGLFramebuffer) tex).texColorBuffer);
		}
		else if (tex) {
			gl.bindTexture(gl.TEXTURE_2D, (cast(OpenGLTexture) tex).texture);
		}
		else {
			gl.bindTexture(gl.TEXTURE_2D, 0);
		}
	}
}

final class OpenGLVertexBuffer : VertexBuffer {

	OpenGL gl;
	gl.UInt buffer;

	private this() {}

	void free() {
		if (!gl)
			return;

		gl.deleteBuffers(1, &buffer);
		gl = null;
	}

	void upload(void[] data) {
		gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
		gl.bufferData(gl.ARRAY_BUFFER, cast(gl.SizeiPtr) data.length, data.ptr, gl.STREAM_DRAW);
	}
}

final class OpenGLFramebuffer : Framebuffer {

	private {
		OpenGL gl;
		OpenGLContext ctx;
		gl.UInt fbo = -1, rbo, texColorBuffer;
		IVec2 _size;
	}

	private this() {}

	void free() {
		if (!gl)
			return;

		gl.deleteRenderbuffers(1, &rbo);
		gl.deleteTextures(1, &texColorBuffer);
		gl.deleteFramebuffers(1, &fbo);
		gl = null;
	}

	IVec2 size() const {
		return _size;
	}

	void resize(IVec2 newSize) {
		import std.algorithm : max;

		newSize = IVec2(max(newSize.x, 1), max(newSize.y, 1));

		if (size != newSize) {
			_size = newSize;

			if (fbo != -1) {
				gl.deleteRenderbuffers(1, &rbo);
				gl.deleteTextures(1, &texColorBuffer);
				gl.deleteFramebuffers(1, &fbo);
			}

			gl.genFramebuffers(1, &fbo);

			gl.bindFramebuffer(gl.FRAMEBUFFER, fbo);

			gl.genTextures(1, &texColorBuffer);
			gl.bindTexture(gl.TEXTURE_2D, texColorBuffer);

			gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA,
				cast(gl.Sizei) size.x, cast(gl.Sizei) size.y,
				0, gl.RGBA, gl.UNSIGNED_BYTE, null);

			gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
			gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
			gl.bindTexture(gl.TEXTURE_2D, 0);

			gl.framebufferTexture2D(gl.FRAMEBUFFER, gl.COLOR_ATTACHMENT0,
				gl.TEXTURE_2D, texColorBuffer, 0);

			gl.genRenderbuffers(1, &rbo);

			gl.bindRenderbuffer(gl.RENDERBUFFER, rbo);
			gl.renderbufferStorage(gl.RENDERBUFFER, gl.DEPTH24_STENCIL8,
				cast(gl.Sizei) size.x, cast(gl.Sizei) size.y);
			gl.bindRenderbuffer(gl.RENDERBUFFER, 0);

			gl.framebufferRenderbuffer(gl.FRAMEBUFFER, gl.DEPTH_STENCIL_ATTACHMENT,
				gl.RENDERBUFFER, rbo);

			if (gl.checkFramebufferStatus(gl.FRAMEBUFFER) != gl.FRAMEBUFFER_COMPLETE) {
				throw new Exception("error while creating framebuffer");
			}

			ctx.bind(ctx.currentFramebuffer);
		}
	}

	void[] getPixels(IVec2 position, IVec2 size) const {
		OpenGLFramebuffer self = cast(OpenGLFramebuffer) this;
		void[] result = new void[cast(size_t) 4 * size.x * size.y];
		self.gl.bindFramebuffer(gl.FRAMEBUFFER, fbo);
		self.gl.readPixels(
			position.x, this.size.y - size.y - position.y,
			size.x, size.y, gl.RGBA, gl.UNSIGNED_BYTE, result.ptr);
		self.ctx.bind(self.ctx.currentFramebuffer);
		return flipImage(size.x, size.y, result);
	}

	void setPixels(IVec2 position, IVec2 size, void[] data) {
		assert(data.length == cast(size_t) 4 * size.x * size.y);

		assert(0); // TODO: implement
	}

}

final class OpenGLTexture : Texture {

	private {
		OpenGL gl;
		OpenGLContext ctx;
		gl.UInt texture;
		IVec2 _size;
	}

	private this() {}

	void free() {
		if (!gl)
			return;

		gl.deleteTextures(1, &texture);
		gl = null;
	}

	IVec2 size() const {
		return _size;
	}

	private void initialize(IVec2 size, const(void)[] data) {
		assert(data.length == cast(size_t) 4 * size.x * size.y);

		gl.genTextures(1, &texture);
		gl.bindTexture(gl.TEXTURE_2D, texture);

		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
		gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA,
			cast(gl.Sizei) size.x, cast(gl.Sizei) size.y,
			0, gl.RGBA, gl.UNSIGNED_BYTE, flipImage(size.x, size.y, data).ptr);
	}

}

final class OpenGLContext : AbstractGPUContext {

	OpenGL gl;
	gl.UInt vao;

	this() {
		gl = loadOpenGL();
		gl.genVertexArrays(1, &vao);
		gl.bindVertexArray(vao);

		gl.disable(gl.MULTISAMPLE);

		stencil = Stencil.init;
		blend = BlendingMode.Normal;
	}

	void free() {
		// TODO: free all the things
	}

	Shader createShader(ShaderSource source) {
		import std.exception : assumeUnique;

		OpenGLShader result = new OpenGLShader;

		result.ctx = this;
		result.gl = gl;

		result.program = gl.createProgram();

		gl.UInt[] shaders;

		static foreach (i; 0 .. 2) {{
			gl.UInt shader = gl.createShader(i == 0 ? gl.VERTEX_SHADER : gl.FRAGMENT_SHADER);

			const(gl.Char)* src = cast(const(gl.Char)*) source.tupleof[i].ptr;
			gl.Int length = cast(gl.Int) source.tupleof[i].length;
			gl.shaderSource(shader, 1, &src, &length);

			gl.compileShader(shader);

			gl.Int success;
			gl.getShaderiv(shader, gl.COMPILE_STATUS, &success);
			if (!success) {
				gl.Int size;
				gl.getShaderiv(shader, gl.INFO_LOG_LENGTH, &size);

				char[] buf = new char[size - 1];
				gl.getShaderInfoLog(shader, size - 1, null, buf.ptr);

				throw new Exception("Shader compilation failed: " ~ buf.assumeUnique);
			}

			gl.attachShader(result.program, shader);

			shaders ~= shader;
		}}

		gl.linkProgram(result.program);

		gl.Int success;
		gl.getProgramiv(result.program, gl.LINK_STATUS, &success);
		if (!success) {
			gl.Int size;
			gl.getProgramiv(result.program, gl.INFO_LOG_LENGTH, &size);

			char[] buf = new char[size - 1];
			gl.getProgramInfoLog(result.program, size - 1, null, buf.ptr);

			throw new Exception("Shader linking failed: " ~ buf.assumeUnique);
		}

		foreach (shader; shaders) {
			gl.deleteShader(shader);
		}

		return result;
	}

	VertexBuffer createVertexBuffer() {
		auto result = new OpenGLVertexBuffer();
		result.gl = gl;
		gl.genBuffers(1, &result.buffer);
		return result;
	}

	Framebuffer createFramebuffer(IVec2 size) {
		auto result = new OpenGLFramebuffer();

		result.ctx = this;
		result.gl = gl;

		result.resize(size);

		return result;
	}

	Texture createTexture(IVec2 size, const(void)[] data) {
		auto result = new OpenGLTexture();

		result.ctx = this;
		result.gl = gl;

		result.initialize(size, data);

		return result;
	}

	private Framebuffer _currentFramebuffer;

	inout(Framebuffer) currentFramebuffer() inout { return _currentFramebuffer; }

	void bind(Framebuffer fbo) {
		_currentFramebuffer = fbo;
		if (fbo) {
			gl.bindFramebuffer(gl.FRAMEBUFFER, (cast(OpenGLFramebuffer) fbo).fbo);
		}
		else {
			gl.bindFramebuffer(gl.FRAMEBUFFER, 0);
		}
	}

	private Shader _currentShader;

	void useShader(Shader shader) {
		_currentShader = shader;
		if (shader is null) {
			gl.useProgram(0);
		}
		else {
			gl.useProgram((cast(OpenGLShader) shader).program);
		}
	}

	void viewport(IVec2 location, IVec2 size) {
		gl.viewport(
			cast(gl.Int) location.x, cast(gl.Int) location.y,
			cast(gl.Sizei) size.x, cast(gl.Sizei) size.y,
		);
	}

	void clearColor(FVec4 color) {
		gl.clearColor(
			cast(gl.Float) color.r,
			cast(gl.Float) color.g,
			cast(gl.Float) color.b,
			cast(gl.Float) color.a,
		);
		gl.clear(gl.COLOR_BUFFER_BIT);
	}

	void clearStencil(ubyte stencil) {
		gl.clearStencil(stencil);
		gl.clear(gl.STENCIL_BUFFER_BIT);
	}

	private static gl.Enum convStencilFunc(Stencil.Function func) {
		final switch (func) {
			case Stencil.Function.Always: return gl.ALWAYS;
			case Stencil.Function.Never: return gl.NEVER;
			case Stencil.Function.Lt: return gl.LESS;
			case Stencil.Function.Le: return gl.LEQUAL;
			case Stencil.Function.Gt: return gl.GREATER;
			case Stencil.Function.Ge: return gl.GEQUAL;
			case Stencil.Function.Eq: return gl.EQUAL;
			case Stencil.Function.Neq: return gl.NOTEQUAL;
		}
	}

	private static gl.Enum convStencilOp(Stencil.Operation op) {
		final switch (op) {
			case Stencil.Operation.Nop: return gl.KEEP;
			case Stencil.Operation.Zero: return gl.ZERO;
			case Stencil.Operation.Set: return gl.REPLACE;
			case Stencil.Operation.Inc: return gl.INCR;
			case Stencil.Operation.Dec: return gl.DECR;
			case Stencil.Operation.IncWrap: return gl.INCR_WRAP;
			case Stencil.Operation.DecWrap: return gl.DECR_WRAP;
			case Stencil.Operation.Inv: return gl.INVERT;
		}
	}

	private Stencil _frontStencil;
	private Stencil _backStencil;

	Stencil frontStencil() const { return _frontStencil; }
	Stencil backStencil() const { return _backStencil; }
	Stencil stencil() const { return _frontStencil; }

	void stencil(Stencil value) {
		stencil(value, value);
	}

	void stencil(Stencil front, Stencil back) {
		_frontStencil = front;
		_backStencil = back;

		if (front.func == Stencil.Function.Always
				&& front.stencilFail == Stencil.Operation.Nop
				&& front.depthFail == Stencil.Operation.Nop
				&& front.pass == Stencil.Operation.Nop
				&& back.func == Stencil.Function.Always
				&& back.stencilFail == Stencil.Operation.Nop
				&& back.depthFail == Stencil.Operation.Nop
				&& back.pass == Stencil.Operation.Nop) {
			gl.disable(gl.STENCIL_TEST);
			return;
		}

		gl.enable(gl.STENCIL_TEST);

		if (front.writeMask == back.writeMask) {
			gl.stencilMask(front.writeMask);
		}
		else {
			gl.stencilMaskSeparate(gl.FRONT, front.writeMask);
			gl.stencilMaskSeparate(gl.BACK, back.writeMask);
		}

		if (front.func == back.func
				&& front.refValue == back.refValue
				&& front.readMask == back.readMask) {
			gl.stencilFunc(convStencilFunc(front.func), front.refValue, front.readMask);
		}
		else {
			gl.stencilFuncSeparate(gl.FRONT, convStencilFunc(front.func), front.refValue, front.readMask);
			gl.stencilFuncSeparate(gl.BACK, convStencilFunc(back.func), back.refValue, back.readMask);
		}

		if (front.stencilFail == back.stencilFail
				&& front.depthFail == back.depthFail
				&& front.pass == back.pass) {
			gl.stencilOp(
				convStencilOp(front.stencilFail),
				convStencilOp(front.depthFail),
				convStencilOp(front.pass),
			);
		}
		else {
			gl.stencilOpSeparate(
				gl.FRONT,
				convStencilOp(front.stencilFail),
				convStencilOp(front.depthFail),
				convStencilOp(front.pass),
			);
			gl.stencilOpSeparate(
				gl.BACK,
				convStencilOp(back.stencilFail),
				convStencilOp(back.depthFail),
				convStencilOp(back.pass),
			);
		}
	}

	private BlendingFunction _colorBlend;
	private BlendingFunction _alphaBlend;

	BlendingFunction colorBlend() const { return _colorBlend; }
	BlendingFunction alphaBlend() const { return _alphaBlend; }
	BlendingFunction blend() const { return _colorBlend; }

	void blend(BlendingFunction value) {
		blend(value, value);
	}

	private gl.Enum convBlendingOperation(BlendingFunction.Operation op) {
		final switch (op) {
			case BlendingFunction.Operation.Add: return gl.FUNC_ADD;
			case BlendingFunction.Operation.SrcMinusDst: return gl.FUNC_SUBTRACT;
			case BlendingFunction.Operation.DstMinusSrc: return gl.FUNC_REVERSE_SUBTRACT;
			case BlendingFunction.Operation.Min: return gl.MIN;
			case BlendingFunction.Operation.Max: return gl.MAX;
		}
	}

	private gl.Enum convBlendingFactor(BlendingFunction.Factor factor) {
		final switch (factor) {
			case BlendingFunction.Factor.Zero: return gl.ZERO;
			case BlendingFunction.Factor.One: return gl.ONE;
			case BlendingFunction.Factor.SrcColor: return gl.SRC_COLOR;
			case BlendingFunction.Factor.DstColor: return gl.DST_COLOR;
			case BlendingFunction.Factor.SrcAlpha: return gl.SRC_ALPHA;
			case BlendingFunction.Factor.DstAlpha: return gl.DST_ALPHA;
			case BlendingFunction.Factor.ConstColor: return gl.CONSTANT_COLOR;
			case BlendingFunction.Factor.ConstAlpha: return gl.CONSTANT_ALPHA;
			case BlendingFunction.Factor.OneMinusSrcColor: return gl.ONE_MINUS_SRC_COLOR;
			case BlendingFunction.Factor.OneMinusDstColor: return gl.ONE_MINUS_DST_COLOR;
			case BlendingFunction.Factor.OneMinusSrcAlpha: return gl.ONE_MINUS_SRC_ALPHA;
			case BlendingFunction.Factor.OneMinusDstAlpha: return gl.ONE_MINUS_DST_ALPHA;
			case BlendingFunction.Factor.OneMinusConstColor: return gl.ONE_MINUS_CONSTANT_COLOR;
			case BlendingFunction.Factor.OneMinusConstAlpha: return gl.ONE_MINUS_CONSTANT_ALPHA;
		}
	}

	void blend(BlendingFunction color, BlendingFunction alpha) {
		_colorBlend = color;
		_alphaBlend = alpha;

		if (color == BlendingMode.Overwrite && alpha == color) {
			// technically doesn't catch all functions equivalent to disabling blending
			// but it's good enough
			gl.disable(gl.BLEND);
			return;
		}

		gl.enable(gl.BLEND);

		if (color.op == alpha.op) {
			gl.blendEquation(convBlendingOperation(color.op));
		}
		else {
			gl.blendEquationSeparate(
				convBlendingOperation(color.op),
				convBlendingOperation(alpha.op),
			);
		}

		if (color.sfactor == alpha.sfactor && color.dfactor == alpha.dfactor) {
			gl.blendFunc(
				convBlendingFactor(color.sfactor),
				convBlendingFactor(color.dfactor),
			);
		}
		else {
			gl.blendFuncSeparate(
				convBlendingFactor(color.sfactor),
				convBlendingFactor(color.dfactor),
				convBlendingFactor(alpha.sfactor),
				convBlendingFactor(alpha.dfactor),
			);
		}

		gl.blendColor(
			color.constant.r,
			color.constant.g,
			color.constant.b,
			alpha.constant.a,
		);
	}

	void colorWriteMask(bool r, bool g, bool b, bool a) {
		gl.colorMask(r ? 1 : 0, g ? 1 : 0, b ? 1 : 0, a ? 1 : 0);
	}

	void draw(DrawMode mode, VertexBuffer buffer, const(VertexFormat) format, size_t start, size_t numVertices) {
		gl.bindBuffer(gl.ARRAY_BUFFER, (cast(OpenGLVertexBuffer) buffer).buffer);
		foreach (i, v; format.attributes) {
			gl.Int size;
			gl.Enum type;
			final switch (v.type) {
				case Attribute.Type.Float:
					size = 1;
					type = gl.FLOAT;
					break;
				case Attribute.Type.FVec2:
					size = 2;
					type = gl.FLOAT;
					break;
				case Attribute.Type.FVec3:
					size = 3;
					type = gl.FLOAT;
					break;
				case Attribute.Type.FVec4:
					size = 4;
					type = gl.FLOAT;
					break;
				case Attribute.Type.Int:
					size = 1;
					type = gl.INT;
					break;
				case Attribute.Type.IVec2:
					size = 2;
					type = gl.INT;
					break;
				case Attribute.Type.IVec3:
					size = 3;
					type = gl.INT;
					break;
				case Attribute.Type.IVec4:
					size = 4;
					type = gl.INT;
					break;
			}
			gl.vertexAttribPointer(cast(gl.UInt) i, size, type,
				false, cast(gl.Sizei) format.stride,
				cast(void*) v.byteOffset);
			gl.enableVertexAttribArray(cast(gl.UInt) i);
		}
		gl.Enum glMode;
		final switch (mode) {
			case DrawMode.Triangles:
				glMode = gl.TRIANGLES;
				break;
			case DrawMode.TriangleFan:
				glMode = gl.TRIANGLE_FAN;
				break;
			case DrawMode.TriangleStrip:
				glMode = gl.TRIANGLE_STRIP;
				break;
		}
		gl.drawArrays(glMode, cast(gl.Int) start, cast(gl.Sizei) numVertices);
		foreach (i, v; format.attributes) {
			gl.disableVertexAttribArray(cast(gl.UInt) i);
		}
	}

}
