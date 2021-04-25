module dui.matrices;
import dui.vectors;
import std.traits;

alias Mat3 = AbstractMat3!double;
alias IMat3 = AbstractMat3!int;
alias FMat3 = AbstractMat3!float;
alias RMat3 = AbstractMat3!real;

// alias Mat4 = AbstractMat4!double;
// alias IMat4 = AbstractMat4!int;
// alias FMat4 = AbstractMat4!float;
// alias RMat4 = AbstractMat4!real;

struct AbstractMat3(T) {
	private T[3][3] m = [
		[1, 0, 0],
		[0, 1, 0],
		[0, 0, 1],
	];

	this(T x, T y = 0) {
		m = [
			[1, 0, x],
			[0, 1, y],
			[0, 0, cast(T) 1],
		];
	}

	this(AbstractVec2!T vec) {
		m = [
			[1, 0, vec.x],
			[0, 1, vec.y],
			[0, 0, cast(T) 1],
		];
	}

	this(T[3][3] values) {
		m = values;
	}

	this(V)(AbstractMat3!V value) {
		foreach (i; 0 .. 3) {
			foreach (j; 0 .. 3) {
				m[i][j] = cast(T) value.m[i][j];
			}
		}
	}

	T opIndex(size_t r, size_t c) const { return m[r][c]; }

	T x() const @property { return m[0][2]; }
	T y() const @property { return m[1][2]; }

	AbstractVec2!T translation() const {
		return AbstractVec2!T(x, y);
	}

	AbstractMat3!T withTranslation(AbstractVec2!T value) const {
		AbstractMat3!T res = this;
		res.m[0][2] = value.x;
		res.m[1][2] = value.y;
		return res;
	}

	AbstractMat3!T withoutTranslation() const {
		return withTranslation(AbstractVec2!T.init);
	}

	AbstractVec2!T scale() const {
		return AbstractVec2!T(m[0][0], m[1][1]);
	}

	static AbstractMat3!T scale(AbstractVec2!T value) {
		return AbstractMat3!T().withScale(value);
	}

	AbstractMat3!T withScale(AbstractVec2!T value) const {
		AbstractMat3!T res = this;
		res.m[0][0] = value.x;
		res.m[1][1] = value.y;
		return res;
	}

	AbstractMat3!T withoutScale() const {
		return withScale(AbstractVec2!T.init);
	}

	static if (isFloatingPoint!T) {
		static AbstractMat3!T rotation(double theta) {
			import std.math : cos, sin;

			return AbstractMat3!T([
				[cast(T) cos(theta), cast(T) -sin(theta), 0],
				[cast(T) sin(theta), cast(T) cos(theta), 0],
				[0, 0, cast(T) 1],
			]);
		}
	}

	AbstractVec2!T opBinary(string op)(AbstractVec2!T other) const if (op == "*") {
		return (this * AbstractMat3!T(other)).translation;
	}

	AbstractMat3!T opBinary(string op)(AbstractMat3!T other) const if (op == "*") {
		AbstractMat3!T res;

		res.m[0][0] = other.m[0][0] * m[0][0] + other.m[1][0] * m[0][1] + other.m[2][0] * m[0][2];
		res.m[1][0] = other.m[0][0] * m[1][0] + other.m[1][0] * m[1][1] + other.m[2][0] * m[1][2];
		res.m[2][0] = other.m[0][0] * m[2][0] + other.m[1][0] * m[2][1] + other.m[2][0] * m[2][2];
		res.m[0][1] = other.m[0][1] * m[0][0] + other.m[1][1] * m[0][1] + other.m[2][1] * m[0][2];
		res.m[1][1] = other.m[0][1] * m[1][0] + other.m[1][1] * m[1][1] + other.m[2][1] * m[1][2];
		res.m[2][1] = other.m[0][1] * m[2][0] + other.m[1][1] * m[2][1] + other.m[2][1] * m[2][2];
		res.m[0][2] = other.m[0][2] * m[0][0] + other.m[1][2] * m[0][1] + other.m[2][2] * m[0][2];
		res.m[1][2] = other.m[0][2] * m[1][0] + other.m[1][2] * m[1][1] + other.m[2][2] * m[1][2];
		res.m[2][2] = other.m[0][2] * m[2][0] + other.m[1][2] * m[2][1] + other.m[2][2] * m[2][2];

		return res;
	}
}
