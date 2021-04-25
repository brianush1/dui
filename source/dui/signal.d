module dui.signal;
import dui.log;
import std.uuid;
import std.typecons;

struct Signal(Args...) {

	private void delegate(Args)[UUID] handlers;

	UUID connect(void delegate(Args) handler) {
		UUID id = randomUUID;
		handlers[id] = handler;
		return id;
	}

	bool hasSlot(UUID slot) const {
		return (slot in handlers) != null;
	}

	void disconnect(UUID slot) {
		handlers.remove(slot);
	}

	void emit(Args args) const {
		import std.array : array;

		// we use .array to create a copy so that if the handlers change around
		// while the event is being emitted, nothing weird happens
		foreach (handler; handlers.byValue.array) {
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
