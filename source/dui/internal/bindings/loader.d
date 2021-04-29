module dui.internal.bindings.loader;

T loadSharedLibrary(T, string delegate(string) toLibraryName)(string[] libraries) if (is(T == interface)) {
	enum Members = {
		string[] members;
		static foreach (member; __traits(allMembers, T)) {
			static if (is(typeof(&__traits(getMember, T, member))) && member != "close") {
				members ~= member;
			}
		}
		return members;
	}();

	final class ResultType : T {
		import std.traits : ReturnType, Parameters;

		extern(System) @nogc nothrow:

		private int numLoaded;

		void close() {
			import core.sys.posix.dlfcn : dlclose;

			numLoaded -= 1;

			if (dl !is null && numLoaded <= 0) {
				dlclose(dl);
				dl = null;
			}
		}

		private void* dl;

		static foreach (member; Members) {
			mixin("
				private ReturnType!(__traits(getMember, T, member))
					function(Parameters!(__traits(getMember, T, member))) _impl"~member~";
				ReturnType!(__traits(getMember, T, member)) "~member~"(Parameters!(__traits(getMember, T, member)) args) {
					assert(dl, \"library closed\");
					return _impl"~member~"(args);
				}
			");
		}
	}

	static ResultType result;

	if (result) {
		result.numLoaded += 1;
		return result;
	}

	ResultType potentialResult = new ResultType;

	version (Posix) {
		import core.sys.posix.dlfcn : dlopen, dlerror, dlsym, RTLD_NOW;
		import std.string : toStringz;

		nextLibrary: foreach (library; libraries) {
			bool last = library == libraries[$ - 1];
			void* dl = dlopen(library.toStringz, RTLD_NOW);
			if (dl) {
				bool hasErrors;
				static foreach (member; Members) {{
					dlerror();
					void* sym = dlsym(dl, toLibraryName(member).toStringz);
					if (dlerror()) {
						if (last) {
							import std.stdio : stderr;

							stderr.writeln("error when loading member '" ~ member ~ "'");
							hasErrors = true;
						}
						else {
							continue nextLibrary;
						}
					}
					*cast(void**)&__traits(getMember, potentialResult, "_impl" ~ member) = sym;
				}}
				if (hasErrors) {
					throw new Exception("could not load library " ~ library);
				}
				potentialResult.dl = dl;
				result = potentialResult;
				result.numLoaded += 1;
				return result;
			}
		}
	}
	else {
		static assert(0);
	}

	return null;
}
