module dui.path;
import dui.vectors;

enum Rotation {
	CCW,
	CW,
}

struct Path {
	enum Command {
		Move,
		Close,
		Line,
		Quad,
		Cubic,
	}

	private {
		Command[] _commands;
		Vec2[] _points;
		Vec2 _lastMove;
	}

	this(Command[] commands, Vec2[] points, Vec2 lastMove) {
		_commands = commands;
		_points = points;
		_lastMove = lastMove;
	}

	immutable(Command)[] commands() const @property {
		import std.exception : assumeUnique;

		return _commands.assumeUnique;
	}

	immutable(Vec2)[] points() const @property {
		import std.exception : assumeUnique;

		return _points.assumeUnique;
	}

	Vec2 lastMove() const @property {
		return _lastMove;
	}

	void moveTo(double x, double y) {
		moveTo(Vec2(x, y));
	}

	void moveTo(Vec2 point) {
		_commands ~= Command.Move;
		_points ~= point;
		_lastMove = point;
	}

	void close() {
		_commands ~= Command.Close;
	}

	void lineTo(double x, double y) {
		lineTo(Vec2(x, y));
	}

	void lineTo(Vec2 point) {
		_commands ~= Command.Line;
		_points ~= point;
	}

	void quadTo(double cx, double cy, double x, double y) {
		quadTo(Vec2(cx, cy), Vec2(x, y));
	}

	void quadTo(Vec2 control, Vec2 point) {
		_commands ~= Command.Quad;
		_points ~= control;
		_points ~= point;
	}

	void cubicTo(double c1x, double c1y, double c2x, double c2y, double x, double y) {
		cubicTo(Vec2(c1x, c1y), Vec2(c2x, c2y), Vec2(x, y));
	}

	void cubicTo(Vec2 c1, Vec2 c2, Vec2 point) {
		_commands ~= Command.Cubic;
		_points ~= c1;
		_points ~= c2;
		_points ~= point;
	}

	void rect(Vec2 position, Vec2 size, Rotation direction = Rotation.CCW) {
		if (direction == Rotation.CCW) {
			moveTo(position);
			lineTo(position + size * Vec2(0, 1));
			lineTo(position + size * Vec2(1, 1));
			lineTo(position + size * Vec2(1, 0));
			close();
		}
		else {
			moveTo(position);
			lineTo(position + size * Vec2(1, 0));
			lineTo(position + size * Vec2(1, 1));
			lineTo(position + size * Vec2(0, 1));
			close();
		}
	}
}
