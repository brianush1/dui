module dui.vectors;
import std.traits;

alias Vec2 = AbstractVec2!double;
alias IVec2 = AbstractVec2!int;
alias FVec2 = AbstractVec2!float;
alias RVec2 = AbstractVec2!real;

alias Vec3 = AbstractVec3!double;
alias IVec3 = AbstractVec3!int;
alias FVec3 = AbstractVec3!float;
alias RVec3 = AbstractVec3!real;

alias Vec4 = AbstractVec4!double;
alias IVec4 = AbstractVec4!int;
alias FVec4 = AbstractVec4!float;
alias RVec4 = AbstractVec4!real;

struct AbstractVec2(T) {
	T x = 0;
	T y = 0;

	this(V)(AbstractVec2!V base) {
		x = cast(T) base.x;
		y = cast(T) base.y;
	}

	this(T x, T y = 0) {
		this.x = x;
		this.y = y;
	}

	static if (isFloatingPoint!T) {
		T magnitude() @property const {
			import std.math : sqrt;

			return sqrt(x * x + y * y);
		}
	}

	auto opBinary(string op, R)(const(AbstractVec2!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		AbstractVec2!ResT result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		return result;
	}

	auto opBinary(string op, R)(const(R) rhs) const if (isNumeric!R) {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		AbstractVec2!ResT result;
		result.x = mixin("x" ~ op ~ "rhs");
		result.y = mixin("y" ~ op ~ "rhs");
		return result;
	}

	auto opUnary(string op)() const if (op == "-") {
		return AbstractVec2!T(-x, -y);
	}

	AbstractVec2!T opDispatch(string member)() @property const
	if (member.length == 2) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		AbstractVec2!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}

	AbstractVec3!T opDispatch(string member)() @property const
	if (member.length == 3) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		AbstractVec3!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}

	AbstractVec4!T opDispatch(string member)() @property const
	if (member.length == 4) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		AbstractVec4!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}
}

struct AbstractVec3(T) {
	T x = 0;
	T y = 0;
	T z = 0;

	this(V)(AbstractVec3!V base) {
		x = cast(T) base.x;
		y = cast(T) base.y;
		z = cast(T) base.z;
	}

	this(T x, T y = 0, T z = 0) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	static if (isFloatingPoint!T) {
		T magnitude() @property const {
			import std.math : sqrt;

			return sqrt(x * x + y * y + z * z);
		}
	}

	auto opBinary(string op, R)(const(AbstractVec3!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		AbstractVec3!ResT result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		result.z = mixin("z" ~ op ~ "rhs.z");
		return result;
	}

	auto opBinary(string op, R)(const(R) rhs) const if (isNumeric!R) {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		AbstractVec3!ResT result;
		result.x = mixin("x" ~ op ~ "rhs");
		result.y = mixin("y" ~ op ~ "rhs");
		result.z = mixin("z" ~ op ~ "rhs");
		return result;
	}

	auto opUnary(string op)() const if (op == "-") {
		return AbstractVec3!T(-x, -y, -z);
	}

	AbstractVec2!T opDispatch(string member)() @property const
	if (member.length == 2) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		AbstractVec2!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}

	AbstractVec3!T opDispatch(string member)() @property const
	if (member.length == 3) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		AbstractVec3!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}

	AbstractVec4!T opDispatch(string member)() @property const
	if (member.length == 4) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		AbstractVec4!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}
}

struct AbstractVec4(T) {
	T x = 0;
	T y = 0;
	T z = 0;
	T w = 0;

	ref inout(T) r() inout @property { return x; }
	ref inout(T) g() inout @property { return y; }
	ref inout(T) b() inout @property { return z; }
	ref inout(T) a() inout @property { return w; }

	this(V)(AbstractVec4!V base) {
		x = cast(T) base.x;
		y = cast(T) base.y;
		z = cast(T) base.z;
		w = cast(T) base.w;
	}

	this(T x, T y = 0, T z = 0, T w = 0) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	static if (isFloatingPoint!T) {
		T magnitude() @property const {
			import std.math : sqrt;

			return sqrt(x * x + y * y + z * z + w * w);
		}
	}

	auto opBinary(string op, R)(const(AbstractVec4!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		AbstractVec4!ResT result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		result.z = mixin("z" ~ op ~ "rhs.z");
		result.w = mixin("w" ~ op ~ "rhs.w");
		return result;
	}

	auto opBinary(string op, R)(const(R) rhs) const if (isNumeric!R) {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		AbstractVec4!ResT result;
		result.x = mixin("x" ~ op ~ "rhs");
		result.y = mixin("y" ~ op ~ "rhs");
		result.z = mixin("z" ~ op ~ "rhs");
		result.w = mixin("w" ~ op ~ "rhs");
		return result;
	}

	auto opUnary(string op)() const if (op == "-") {
		return AbstractVec4!T(-x, -y, -z, -w);
	}

	AbstractVec2!T opDispatch(string member)() @property const
	if (member.length == 2) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'w' && c <= 'z'));

		AbstractVec2!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}

	AbstractVec3!T opDispatch(string member)() @property const
	if (member.length == 3) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'w' && c <= 'z'));

		AbstractVec3!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}

	AbstractVec4!T opDispatch(string member)() @property const
	if (member.length == 4) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'w' && c <= 'z'));

		AbstractVec4!T result;
		static foreach (i, char c; member) {
			result.tupleof[i] = mixin("this." ~ c);
		}
		return result;
	}
}
