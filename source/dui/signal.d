module dui.signal;
import dui.log;
import std.uuid;
import std.typecons;

mixin template Observable(T, string name, T defaultValue = T.init) {
	mixin("
		private T _" ~ name ~ " = defaultValue;

		inout(T) " ~ name ~ "() inout @property {
			return _" ~ name ~ ";
		}

		T " ~ name ~ "(T value) @property {
			T oldValue = " ~ name ~ ";
			" ~ name ~ " = value;
			onChanged!name.emit(oldValue);
			return _" ~ name ~ ";
		}

		template onChanged(string pname) if (pname == name) {
			Signal!T onChanged;
		}
	");
}

/** Returns the type of an observable property, or $(D void) if the property is not observable */
template getObservableType(alias Base, string property) {
	static if (is(typeof(Base.onChanged!property) == Signal!T, T)) {
		static if (is(typeof(__traits(getMember, Base, property)) == T)) {
			alias getObservableType = T;
		}
		else {
			alias getObservableType = void;
		}
	}
	else {
		alias getObservableType = void;
	}
}

struct Signal(Args...) {

	private {

		struct HandlerHolder {
			void delegate(Args)[UUID] handlers;
		}

		HandlerHolder* data;

		void initialize() {
			if (data == null) {
				data = new HandlerHolder;
			}
		}

		this(HandlerHolder* existingData) {
			data = existingData;
		}

	}

	UUID connect(void delegate(Args) handler) {
		initialize();
		UUID id = randomUUID;
		data.handlers[id] = handler;
		return id;
	}

	UUID connect(ref Signal!Args receiver) {
		receiver.initialize();
		HandlerHolder* _data = receiver.data;
		return connect((Args args) {
			Signal!Args(_data).emit(args);
		});
	}

	bool hasSlot(UUID slot) const {
		if (data == null) {
			return false;
		}
		else {
			return (slot in data.handlers) != null;
		}
	}

	void disconnect(UUID slot) {
		if (data == null) {
			return;
		}
		else {
			data.handlers.remove(slot);
		}
	}

	void emit(Args args) const {
		import std.array : array;

		if (data == null) {
			return;
		}

		// we use .array to create a copy so that if the handlers change around
		// while the event is being emitted, nothing weird happens
		foreach (handler; data.handlers.byValue.array) {
			try {
				handler(args);
			}
			catch (Exception ex) {
				log("An exception occurred in signal handler:");
				logException(ex);
			}
		}
	}

	auto wait() const {
		import core.thread.fiber : Fiber;

		auto sig = cast(Signal!Args*) &this;

		static if (Args.length == 1) {
			Args[0] result;
		}
		else static if (Args.length > 1) {
			Tuple!Args result;
		}

		Fiber self = Fiber.getThis;

		UUID slot;
		slot = sig.connect((Args args) {
			sig.disconnect(slot);

			static if (Args.length == 1) {
				result = args[0];
			}
			else static if (Args.length > 1) {
				result = tuple(args);
			}

			try {
				self.call();
			}
			catch (Exception ex) {
				logException(ex);
			}
		});

		Fiber.yield;

		static if (Args.length != 0) {
			return result;
		}
	}

}

void spawnTask(void delegate() del) {
	import core.thread.fiber : Fiber;

	try {
		new Fiber(del).call();
	}
	catch (Exception ex) {
		logException(ex);
	}
}
