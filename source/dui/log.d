module dui.log;

void log(Args...)(Args args) {
	import std.stdio : stderr;

	stderr.writeln(args);
}

void logException(Exception ex) {
	log(ex.toString);
}
