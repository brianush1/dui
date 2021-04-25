module dui.internal.bindings.opengl;
import dui.internal.bindings.loader;

OpenGL loadOpenGL() {
	string[] libraries;

	version (Posix) {
		libraries = ["libGL.so.1", "libGL.so"];
	}
	else {
		static assert(0);
	}

	return loadSharedLibrary!(OpenGL, delegate(string name) => "gl"
		~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $])(libraries);
}

interface OpenGL {
	extern(System) @nogc nothrow:

	void close();

	alias Enum = uint;
	alias Boolean = ubyte;
	alias Bitfield = uint;
	alias Char = char;
	alias Byte = byte;
	alias Short = short;
	alias Int = int;
	alias Sizei = int;
	alias UByte = ubyte;
	alias UShort = ushort;
	alias UInt = uint;
	alias Half = ushort;
	alias Float = float;
	alias Clampf = float;
	alias Double = double;
	alias Clampd = double;
	alias IntPtr = ptrdiff_t;
	alias SizeiPtr = ptrdiff_t;
	alias Int64 = long;
	alias UInt64 = ulong;
	alias Handle = uint;

	enum : ubyte {
		FALSE = 0,
		TRUE = 1,
	}

	enum : uint {
		DEPTH_BUFFER_BIT = 0x00000100,
		STENCIL_BUFFER_BIT = 0x00000400,
		COLOR_BUFFER_BIT = 0x00004000,
		POINTS = 0x0000,
		LINES = 0x0001,
		LINE_LOOP = 0x0002,
		LINE_STRIP = 0x0003,
		TRIANGLES = 0x0004,
		TRIANGLE_STRIP = 0x0005,
		TRIANGLE_FAN = 0x0006,
		NEVER = 0x0200,
		LESS = 0x0201,
		EQUAL = 0x0202,
		LEQUAL = 0x0203,
		GREATER = 0x0204,
		NOTEQUAL = 0x0205,
		GEQUAL = 0x0206,
		ALWAYS = 0x0207,
		ZERO = 0,
		ONE = 1,
		SRC_COLOR = 0x0300,
		ONE_MINUS_SRC_COLOR = 0x0301,
		SRC_ALPHA = 0x0302,
		ONE_MINUS_SRC_ALPHA = 0x0303,
		DST_ALPHA = 0x0304,
		ONE_MINUS_DST_ALPHA = 0x0305,
		DST_COLOR = 0x0306,
		ONE_MINUS_DST_COLOR = 0x0307,
		SRC_ALPHA_SATURATE = 0x0308,
		NONE = 0,
		FRONT_LEFT = 0x0400,
		FRONT_RIGHT = 0x0401,
		BACK_LEFT = 0x0402,
		BACK_RIGHT = 0x0403,
		FRONT = 0x0404,
		BACK = 0x0405,
		LEFT = 0x0406,
		RIGHT = 0x0407,
		FRONT_AND_BACK = 0x0408,
		NO_ERROR = 0,
		INVALID_ENUM = 0x0500,
		INVALID_VALUE = 0x0501,
		INVALID_OPERATION = 0x0502,
		OUT_OF_MEMORY = 0x0505,
		CW = 0x0900,
		CCW = 0x0901,
		POINT_SIZE = 0x0B11,
		POINT_SIZE_RANGE = 0x0B12,
		POINT_SIZE_GRANULARITY = 0x0B13,
		LINE_SMOOTH = 0x0B20,
		LINE_WIDTH = 0x0B21,
		LINE_WIDTH_RANGE = 0x0B22,
		LINE_WIDTH_GRANULARITY = 0x0B23,
		POLYGON_MODE = 0x0B40,
		POLYGON_SMOOTH = 0x0B41,
		CULL_FACE = 0x0B44,
		CULL_FACE_MODE = 0x0B45,
		FRONT_FACE = 0x0B46,
		DEPTH_RANGE = 0x0B70,
		DEPTH_TEST = 0x0B71,
		DEPTH_WRITEMASK = 0x0B72,
		DEPTH_CLEAR_VALUE = 0x0B73,
		DEPTH_FUNC = 0x0B74,
		STENCIL_TEST = 0x0B90,
		STENCIL_CLEAR_VALUE = 0x0B91,
		STENCIL_FUNC = 0x0B92,
		STENCIL_VALUE_MASK = 0x0B93,
		STENCIL_FAIL = 0x0B94,
		STENCIL_PASS_DEPTH_FAIL = 0x0B95,
		STENCIL_PASS_DEPTH_PASS = 0x0B96,
		STENCIL_REF = 0x0B97,
		STENCIL_WRITEMASK = 0x0B98,
		VIEWPORT = 0x0BA2,
		DITHER = 0x0BD0,
		BLEND_DST = 0x0BE0,
		BLEND_SRC = 0x0BE1,
		BLEND = 0x0BE2,
		LOGIC_OP_MODE = 0x0BF0,
		COLOR_LOGIC_OP = 0x0BF2,
		DRAW_BUFFER = 0x0C01,
		READ_BUFFER = 0x0C02,
		SCISSOR_BOX = 0x0C10,
		SCISSOR_TEST = 0x0C11,
		COLOR_CLEAR_VALUE = 0x0C22,
		COLOR_WRITEMASK = 0x0C23,
		DOUBLEBUFFER = 0x0C32,
		STEREO = 0x0C33,
		LINE_SMOOTH_HINT = 0x0C52,
		POLYGON_SMOOTH_HINT = 0x0C53,
		UNPACK_SWAP_BYTES = 0x0CF0,
		UNPACK_LSB_FIRST = 0x0CF1,
		UNPACK_ROW_LENGTH = 0x0CF2,
		UNPACK_SKIP_ROWS = 0x0CF3,
		UNPACK_SKIP_PIXELS = 0x0CF4,
		UNPACK_ALIGNMENT = 0x0CF5,
		PACK_SWAP_BYTES = 0x0D00,
		PACK_LSB_FIRST = 0x0D01,
		PACK_ROW_LENGTH = 0x0D02,
		PACK_SKIP_ROWS = 0x0D03,
		PACK_SKIP_PIXELS = 0x0D04,
		PACK_ALIGNMENT = 0x0D05,
		MAX_TEXTURE_SIZE = 0x0D33,
		MAX_VIEWPORT_DIMS = 0x0D3A,
		SUBPIXEL_BITS = 0x0D50,
		TEXTURE_1D = 0x0DE0,
		TEXTURE_2D = 0x0DE1,
		POLYGON_OFFSET_UNITS = 0x2A00,
		POLYGON_OFFSET_POINT = 0x2A01,
		POLYGON_OFFSET_LINE = 0x2A02,
		POLYGON_OFFSET_FILL = 0x8037,
		POLYGON_OFFSET_FACTOR = 0x8038,
		TEXTURE_BINDING_1D = 0x8068,
		TEXTURE_BINDING_2D = 0x8069,
		TEXTURE_WIDTH = 0x1000,
		TEXTURE_HEIGHT = 0x1001,
		TEXTURE_INTERNAL_FORMAT = 0x1003,
		TEXTURE_BORDER_COLOR = 0x1004,
		TEXTURE_RED_SIZE = 0x805C,
		TEXTURE_GREEN_SIZE = 0x805D,
		TEXTURE_BLUE_SIZE = 0x805E,
		TEXTURE_ALPHA_SIZE = 0x805F,
		DONT_CARE = 0x1100,
		FASTEST = 0x1101,
		NICEST = 0x1102,
		BYTE = 0x1400,
		UNSIGNED_BYTE = 0x1401,
		SHORT = 0x1402,
		UNSIGNED_SHORT = 0x1403,
		INT = 0x1404,
		UNSIGNED_INT = 0x1405,
		FLOAT = 0x1406,
		DOUBLE = 0x140A,
		CLEAR = 0x1500,
		AND = 0x1501,
		AND_REVERSE = 0x1502,
		COPY = 0x1503,
		AND_INVERTED = 0x1504,
		NOOP = 0x1505,
		XOR = 0x1506,
		OR = 0x1507,
		NOR = 0x1508,
		EQUIV = 0x1509,
		INVERT = 0x150A,
		OR_REVERSE = 0x150B,
		COPY_INVERTED = 0x150C,
		OR_INVERTED = 0x150D,
		NAND = 0x150E,
		SET = 0x150F,
		TEXTURE = 0x1702,
		COLOR = 0x1800,
		DEPTH = 0x1801,
		STENCIL = 0x1802,
		STENCIL_INDEX = 0x1901,
		DEPTH_COMPONENT = 0x1902,
		RED = 0x1903,
		GREEN = 0x1904,
		BLUE = 0x1905,
		ALPHA = 0x1906,
		RGB = 0x1907,
		RGBA = 0x1908,
		POINT = 0x1B00,
		LINE = 0x1B01,
		FILL = 0x1B02,
		KEEP = 0x1E00,
		REPLACE = 0x1E01,
		INCR = 0x1E02,
		DECR = 0x1E03,
		VENDOR = 0x1F00,
		RENDERER = 0x1F01,
		VERSION = 0x1F02,
		EXTENSIONS = 0x1F03,
		NEAREST = 0x2600,
		LINEAR = 0x2601,
		NEAREST_MIPMAP_NEAREST = 0x2700,
		LINEAR_MIPMAP_NEAREST = 0x2701,
		NEAREST_MIPMAP_LINEAR = 0x2702,
		LINEAR_MIPMAP_LINEAR = 0x2703,
		TEXTURE_MAG_FILTER = 0x2800,
		TEXTURE_MIN_FILTER = 0x2801,
		TEXTURE_WRAP_S = 0x2802,
		TEXTURE_WRAP_T = 0x2803,
		PROXY_TEXTURE_1D = 0x8063,
		PROXY_TEXTURE_2D = 0x8064,
		REPEAT = 0x2901,
		R3_G3_B2 = 0x2A10,
		RGB4 = 0x804F,
		RGB5 = 0x8050,
		RGB8 = 0x8051,
		RGB10 = 0x8052,
		RGB12 = 0x8053,
		RGB16 = 0x8054,
		RGBA2 = 0x8055,
		RGBA4 = 0x8056,
		RGB5_A1 = 0x8057,
		RGBA8 = 0x8058,
		RGB10_A2 = 0x8059,
		RGBA12 = 0x805A,
		RGBA16 = 0x805B,
		VERTEX_ARRAY = 0x8074,
		UNSIGNED_BYTE_3_3_2 = 0x8032,
		UNSIGNED_SHORT_4_4_4_4 = 0x8033,
		UNSIGNED_SHORT_5_5_5_1 = 0x8034,
		UNSIGNED_INT_8_8_8_8 = 0x8035,
		UNSIGNED_INT_10_10_10_2 = 0x8036,
		TEXTURE_BINDING_3D = 0x806A,
		PACK_SKIP_IMAGES = 0x806B,
		PACK_IMAGE_HEIGHT = 0x806C,
		UNPACK_SKIP_IMAGES = 0x806D,
		UNPACK_IMAGE_HEIGHT = 0x806E,
		TEXTURE_3D = 0x806F,
		PROXY_TEXTURE_3D = 0x8070,
		TEXTURE_DEPTH = 0x8071,
		TEXTURE_WRAP_R = 0x8072,
		MAX_3D_TEXTURE_SIZE = 0x8073,
		UNSIGNED_BYTE_2_3_3_REV = 0x8362,
		UNSIGNED_SHORT_5_6_5 = 0x8363,
		UNSIGNED_SHORT_5_6_5_REV = 0x8364,
		UNSIGNED_SHORT_4_4_4_4_REV = 0x8365,
		UNSIGNED_SHORT_1_5_5_5_REV = 0x8366,
		UNSIGNED_INT_8_8_8_8_REV = 0x8367,
		UNSIGNED_INT_2_10_10_10_REV = 0x8368,
		BGR = 0x80E0,
		BGRA = 0x80E1,
		MAX_ELEMENTS_VERTICES = 0x80E8,
		MAX_ELEMENTS_INDICES = 0x80E9,
		CLAMP_TO_EDGE = 0x812F,
		TEXTURE_MIN_LOD = 0x813A,
		TEXTURE_MAX_LOD = 0x813B,
		TEXTURE_BASE_LEVEL = 0x813C,
		TEXTURE_MAX_LEVEL = 0x813D,
		SMOOTH_POINT_SIZE_RANGE = 0x0B12,
		SMOOTH_POINT_SIZE_GRANULARITY = 0x0B13,
		SMOOTH_LINE_WIDTH_RANGE = 0x0B22,
		SMOOTH_LINE_WIDTH_GRANULARITY = 0x0B23,
		ALIASED_LINE_WIDTH_RANGE = 0x846E,
		TEXTURE0 = 0x84C0,
		TEXTURE1 = 0x84C1,
		TEXTURE2 = 0x84C2,
		TEXTURE3 = 0x84C3,
		TEXTURE4 = 0x84C4,
		TEXTURE5 = 0x84C5,
		TEXTURE6 = 0x84C6,
		TEXTURE7 = 0x84C7,
		TEXTURE8 = 0x84C8,
		TEXTURE9 = 0x84C9,
		TEXTURE10 = 0x84CA,
		TEXTURE11 = 0x84CB,
		TEXTURE12 = 0x84CC,
		TEXTURE13 = 0x84CD,
		TEXTURE14 = 0x84CE,
		TEXTURE15 = 0x84CF,
		TEXTURE16 = 0x84D0,
		TEXTURE17 = 0x84D1,
		TEXTURE18 = 0x84D2,
		TEXTURE19 = 0x84D3,
		TEXTURE20 = 0x84D4,
		TEXTURE21 = 0x84D5,
		TEXTURE22 = 0x84D6,
		TEXTURE23 = 0x84D7,
		TEXTURE24 = 0x84D8,
		TEXTURE25 = 0x84D9,
		TEXTURE26 = 0x84DA,
		TEXTURE27 = 0x84DB,
		TEXTURE28 = 0x84DC,
		TEXTURE29 = 0x84DD,
		TEXTURE30 = 0x84DE,
		TEXTURE31 = 0x84DF,
		ACTIVE_TEXTURE = 0x84E0,
		MULTISAMPLE = 0x809D,
		SAMPLE_ALPHA_TO_COVERAGE = 0x809E,
		SAMPLE_ALPHA_TO_ONE = 0x809F,
		SAMPLE_COVERAGE = 0x80A0,
		SAMPLE_BUFFERS = 0x80A8,
		SAMPLES = 0x80A9,
		SAMPLE_COVERAGE_VALUE = 0x80AA,
		SAMPLE_COVERAGE_INVERT = 0x80AB,
		TEXTURE_CUBE_MAP = 0x8513,
		TEXTURE_BINDING_CUBE_MAP = 0x8514,
		TEXTURE_CUBE_MAP_POSITIVE_X = 0x8515,
		TEXTURE_CUBE_MAP_NEGATIVE_X = 0x8516,
		TEXTURE_CUBE_MAP_POSITIVE_Y = 0x8517,
		TEXTURE_CUBE_MAP_NEGATIVE_Y = 0x8518,
		TEXTURE_CUBE_MAP_POSITIVE_Z = 0x8519,
		TEXTURE_CUBE_MAP_NEGATIVE_Z = 0x851A,
		PROXY_TEXTURE_CUBE_MAP = 0x851B,
		MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C,
		COMPRESSED_RGB = 0x84ED,
		COMPRESSED_RGBA = 0x84EE,
		TEXTURE_COMPRESSION_HINT = 0x84EF,
		TEXTURE_COMPRESSED_IMAGE_SIZE = 0x86A0,
		TEXTURE_COMPRESSED = 0x86A1,
		NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2,
		COMPRESSED_TEXTURE_FORMATS = 0x86A3,
		CLAMP_TO_BORDER = 0x812D,
		BLEND_DST_RGB = 0x80C8,
		BLEND_SRC_RGB = 0x80C9,
		BLEND_DST_ALPHA = 0x80CA,
		BLEND_SRC_ALPHA = 0x80CB,
		POINT_FADE_THRESHOLD_SIZE = 0x8128,
		DEPTH_COMPONENT16 = 0x81A5,
		DEPTH_COMPONENT24 = 0x81A6,
		DEPTH_COMPONENT32 = 0x81A7,
		MIRRORED_REPEAT = 0x8370,
		MAX_TEXTURE_LOD_BIAS = 0x84FD,
		TEXTURE_LOD_BIAS = 0x8501,
		INCR_WRAP = 0x8507,
		DECR_WRAP = 0x8508,
		TEXTURE_DEPTH_SIZE = 0x884A,
		TEXTURE_COMPARE_MODE = 0x884C,
		TEXTURE_COMPARE_FUNC = 0x884D,
		CONSTANT_COLOR = 0x8001,
		ONE_MINUS_CONSTANT_COLOR = 0x8002,
		CONSTANT_ALPHA = 0x8003,
		ONE_MINUS_CONSTANT_ALPHA = 0x8004,
		FUNC_ADD = 0x8006,
		MIN = 0x8007,
		MAX = 0x8008,
		FUNC_SUBTRACT = 0x800A,
		FUNC_REVERSE_SUBTRACT = 0x800B,
		BUFFER_SIZE = 0x8764,
		BUFFER_USAGE = 0x8765,
		QUERY_COUNTER_BITS = 0x8864,
		CURRENT_QUERY = 0x8865,
		QUERY_RESULT = 0x8866,
		QUERY_RESULT_AVAILABLE = 0x8867,
		ARRAY_BUFFER = 0x8892,
		ELEMENT_ARRAY_BUFFER = 0x8893,
		ARRAY_BUFFER_BINDING = 0x8894,
		ELEMENT_ARRAY_BUFFER_BINDING = 0x8895,
		VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F,
		READ_ONLY = 0x88B8,
		WRITE_ONLY = 0x88B9,
		READ_WRITE = 0x88BA,
		BUFFER_ACCESS = 0x88BB,
		BUFFER_MAPPED = 0x88BC,
		BUFFER_MAP_POINTER = 0x88BD,
		STREAM_DRAW = 0x88E0,
		STREAM_READ = 0x88E1,
		STREAM_COPY = 0x88E2,
		STATIC_DRAW = 0x88E4,
		STATIC_READ = 0x88E5,
		STATIC_COPY = 0x88E6,
		DYNAMIC_DRAW = 0x88E8,
		DYNAMIC_READ = 0x88E9,
		DYNAMIC_COPY = 0x88EA,
		SAMPLES_PASSED = 0x8914,
		SRC1_ALPHA = 0x8589,
		BLEND_EQUATION_RGB = 0x8009,
		VERTEX_ATTRIB_ARRAY_ENABLED = 0x8622,
		VERTEX_ATTRIB_ARRAY_SIZE = 0x8623,
		VERTEX_ATTRIB_ARRAY_STRIDE = 0x8624,
		VERTEX_ATTRIB_ARRAY_TYPE = 0x8625,
		CURRENT_VERTEX_ATTRIB = 0x8626,
		VERTEX_PROGRAM_POINT_SIZE = 0x8642,
		VERTEX_ATTRIB_ARRAY_POINTER = 0x8645,
		STENCIL_BACK_FUNC = 0x8800,
		STENCIL_BACK_FAIL = 0x8801,
		STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802,
		STENCIL_BACK_PASS_DEPTH_PASS = 0x8803,
		MAX_DRAW_BUFFERS = 0x8824,
		DRAW_BUFFER0 = 0x8825,
		DRAW_BUFFER1 = 0x8826,
		DRAW_BUFFER2 = 0x8827,
		DRAW_BUFFER3 = 0x8828,
		DRAW_BUFFER4 = 0x8829,
		DRAW_BUFFER5 = 0x882A,
		DRAW_BUFFER6 = 0x882B,
		DRAW_BUFFER7 = 0x882C,
		DRAW_BUFFER8 = 0x882D,
		DRAW_BUFFER9 = 0x882E,
		DRAW_BUFFER10 = 0x882F,
		DRAW_BUFFER11 = 0x8830,
		DRAW_BUFFER12 = 0x8831,
		DRAW_BUFFER13 = 0x8832,
		DRAW_BUFFER14 = 0x8833,
		DRAW_BUFFER15 = 0x8834,
		BLEND_EQUATION_ALPHA = 0x883D,
		MAX_VERTEX_ATTRIBS = 0x8869,
		VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A,
		MAX_TEXTURE_IMAGE_UNITS = 0x8872,
		FRAGMENT_SHADER = 0x8B30,
		VERTEX_SHADER = 0x8B31,
		MAX_FRAGMENT_UNIFORM_COMPONENTS = 0x8B49,
		MAX_VERTEX_UNIFORM_COMPONENTS = 0x8B4A,
		MAX_VARYING_FLOATS = 0x8B4B,
		MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C,
		MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D,
		SHADER_TYPE = 0x8B4F,
		FLOAT_VEC2 = 0x8B50,
		FLOAT_VEC3 = 0x8B51,
		FLOAT_VEC4 = 0x8B52,
		INT_VEC2 = 0x8B53,
		INT_VEC3 = 0x8B54,
		INT_VEC4 = 0x8B55,
		BOOL = 0x8B56,
		BOOL_VEC2 = 0x8B57,
		BOOL_VEC3 = 0x8B58,
		BOOL_VEC4 = 0x8B59,
		FLOAT_MAT2 = 0x8B5A,
		FLOAT_MAT3 = 0x8B5B,
		FLOAT_MAT4 = 0x8B5C,
		SAMPLER_1D = 0x8B5D,
		SAMPLER_2D = 0x8B5E,
		SAMPLER_3D = 0x8B5F,
		SAMPLER_CUBE = 0x8B60,
		SAMPLER_1D_SHADOW = 0x8B61,
		SAMPLER_2D_SHADOW = 0x8B62,
		DELETE_STATUS = 0x8B80,
		COMPILE_STATUS = 0x8B81,
		LINK_STATUS = 0x8B82,
		VALIDATE_STATUS = 0x8B83,
		INFO_LOG_LENGTH = 0x8B84,
		ATTACHED_SHADERS = 0x8B85,
		ACTIVE_UNIFORMS = 0x8B86,
		ACTIVE_UNIFORM_MAX_LENGTH = 0x8B87,
		SHADER_SOURCE_LENGTH = 0x8B88,
		ACTIVE_ATTRIBUTES = 0x8B89,
		ACTIVE_ATTRIBUTE_MAX_LENGTH = 0x8B8A,
		FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B,
		SHADING_LANGUAGE_VERSION = 0x8B8C,
		CURRENT_PROGRAM = 0x8B8D,
		POINT_SPRITE_COORD_ORIGIN = 0x8CA0,
		LOWER_LEFT = 0x8CA1,
		UPPER_LEFT = 0x8CA2,
		STENCIL_BACK_REF = 0x8CA3,
		STENCIL_BACK_VALUE_MASK = 0x8CA4,
		STENCIL_BACK_WRITEMASK = 0x8CA5,
		PIXEL_PACK_BUFFER = 0x88EB,
		PIXEL_UNPACK_BUFFER = 0x88EC,
		PIXEL_PACK_BUFFER_BINDING = 0x88ED,
		PIXEL_UNPACK_BUFFER_BINDING = 0x88EF,
		FLOAT_MAT2x3 = 0x8B65,
		FLOAT_MAT2x4 = 0x8B66,
		FLOAT_MAT3x2 = 0x8B67,
		FLOAT_MAT3x4 = 0x8B68,
		FLOAT_MAT4x2 = 0x8B69,
		FLOAT_MAT4x3 = 0x8B6A,
		SRGB = 0x8C40,
		SRGB8 = 0x8C41,
		SRGB_ALPHA = 0x8C42,
		SRGB8_ALPHA8 = 0x8C43,
		COMPRESSED_SRGB = 0x8C48,
		COMPRESSED_SRGB_ALPHA = 0x8C49,
		VERTEX_ARRAY_BINDING = 0x85B5,
		DOUBLE_VEC2 = 0x8FFC,
		DOUBLE_VEC3 = 0x8FFD,
		DOUBLE_VEC4 = 0x8FFE,
		DOUBLE_MAT2 = 0x8F46,
		DOUBLE_MAT3 = 0x8F47,
		DOUBLE_MAT4 = 0x8F48,
		DOUBLE_MAT2x3 = 0x8F49,
		DOUBLE_MAT2x4 = 0x8F4A,
		DOUBLE_MAT3x2 = 0x8F4B,
		DOUBLE_MAT3x4 = 0x8F4C,
		DOUBLE_MAT4x2 = 0x8F4D,
		DOUBLE_MAT4x3 = 0x8F4E,
		INVALID_FRAMEBUFFER_OPERATION = 0x0506,
		FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 0x8210,
		FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 0x8211,
		FRAMEBUFFER_ATTACHMENT_RED_SIZE = 0x8212,
		FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 0x8213,
		FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 0x8214,
		FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 0x8215,
		FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 0x8216,
		FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 0x8217,
		FRAMEBUFFER_DEFAULT = 0x8218,
		FRAMEBUFFER_UNDEFINED = 0x8219,
		DEPTH_STENCIL_ATTACHMENT = 0x821A,
		MAX_RENDERBUFFER_SIZE = 0x84E8,
		DEPTH_STENCIL = 0x84F9,
		UNSIGNED_INT_24_8 = 0x84FA,
		DEPTH24_STENCIL8 = 0x88F0,
		TEXTURE_STENCIL_SIZE = 0x88F1,
		TEXTURE_RED_TYPE = 0x8C10,
		TEXTURE_GREEN_TYPE = 0x8C11,
		TEXTURE_BLUE_TYPE = 0x8C12,
		TEXTURE_ALPHA_TYPE = 0x8C13,
		TEXTURE_DEPTH_TYPE = 0x8C16,
		UNSIGNED_NORMALIZED = 0x8C17,
		FRAMEBUFFER_BINDING = 0x8CA6,
		DRAW_FRAMEBUFFER_BINDING = FRAMEBUFFER_BINDING,
		RENDERBUFFER_BINDING = 0x8CA7,
		READ_FRAMEBUFFER = 0x8CA8,
		DRAW_FRAMEBUFFER = 0x8CA9,
		READ_FRAMEBUFFER_BINDING = 0x8CAA,
		RENDERBUFFER_SAMPLES = 0x8CAB,
		FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0,
		FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1,
		FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2,
		FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3,
		FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 0x8CD4,
		FRAMEBUFFER_COMPLETE = 0x8CD5,
		FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6,
		FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7,
		FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = 0x8CDB,
		FRAMEBUFFER_INCOMPLETE_READ_BUFFER = 0x8CDC,
		FRAMEBUFFER_UNSUPPORTED = 0x8CDD,
		MAX_COLOR_ATTACHMENTS = 0x8CDF,
		COLOR_ATTACHMENT0 = 0x8CE0,
		COLOR_ATTACHMENT1 = 0x8CE1,
		COLOR_ATTACHMENT2 = 0x8CE2,
		COLOR_ATTACHMENT3 = 0x8CE3,
		COLOR_ATTACHMENT4 = 0x8CE4,
		COLOR_ATTACHMENT5 = 0x8CE5,
		COLOR_ATTACHMENT6 = 0x8CE6,
		COLOR_ATTACHMENT7 = 0x8CE7,
		COLOR_ATTACHMENT8 = 0x8CE8,
		COLOR_ATTACHMENT9 = 0x8CE9,
		COLOR_ATTACHMENT10 = 0x8CEA,
		COLOR_ATTACHMENT11 = 0x8CEB,
		COLOR_ATTACHMENT12 = 0x8CEC,
		COLOR_ATTACHMENT13 = 0x8CED,
		COLOR_ATTACHMENT14 = 0x8CEE,
		COLOR_ATTACHMENT15 = 0x8CEF,
		DEPTH_ATTACHMENT = 0x8D00,
		STENCIL_ATTACHMENT = 0x8D20,
		FRAMEBUFFER = 0x8D40,
		RENDERBUFFER = 0x8D41,
		RENDERBUFFER_WIDTH = 0x8D42,
		RENDERBUFFER_HEIGHT = 0x8D43,
		RENDERBUFFER_INTERNAL_FORMAT = 0x8D44,
		STENCIL_INDEX1 = 0x8D46,
		STENCIL_INDEX4 = 0x8D47,
		STENCIL_INDEX8 = 0x8D48,
		STENCIL_INDEX16 = 0x8D49,
		RENDERBUFFER_RED_SIZE = 0x8D50,
		RENDERBUFFER_GREEN_SIZE = 0x8D51,
		RENDERBUFFER_BLUE_SIZE = 0x8D52,
		RENDERBUFFER_ALPHA_SIZE = 0x8D53,
		RENDERBUFFER_DEPTH_SIZE = 0x8D54,
		RENDERBUFFER_STENCIL_SIZE = 0x8D55,
		FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 0x8D56,
		MAX_SAMPLES = 0x8D57,
	}

	void cullFace(Enum mode);
	void frontFace(Enum mode);
	void hint(Enum target, Enum mode);
	void lineWidth(Float width);
	void pointSize(Float size);
	void polygonMode(Enum face, Enum mode);
	void scissor(Int x, Int y, Sizei width, Sizei height);
	void texParameterf(Enum target, Enum pname, Float param);
	void texParameterfv(Enum target, Enum pname, const(Float)* params);
	void texParameteri(Enum target, Enum pname, Int param);
	void texParameteriv(Enum target, Enum pname, const(Int)* params);
	void texImage1D(Enum target, Int level, Int internalformat, Sizei width, Int border, Enum format, Enum type, const(void)* data);
	void texImage2D(Enum target, Int level, Int internalformat, Sizei width, Sizei height, Int border, Enum format, Enum type, const(void)* data);
	void drawBuffer(Enum buf);
	void clear(Bitfield mask);
	void clearColor(Float red, Float green, Float blue, Float alpha);
	void clearStencil(Int s);
	void clearDepth(Double depth);
	void stencilMask(UInt mask);
	void colorMask(Boolean red, Boolean green, Boolean blue, Boolean alpha);
	void depthMask(Boolean flag);
	void disable(Enum cap);
	void enable(Enum cap);
	void finish();
	void flush();
	void blendFunc(Enum sfactor, Enum dfactor);
	void logicOp(Enum opcode);
	void stencilFunc(Enum func, Int ref_, UInt mask);
	void stencilOp(Enum sfail, Enum dpfail, Enum dppass);
	void depthFunc(Enum func);
	void pixelStoref(Enum pname, Float param);
	void pixelStorei(Enum pname, Int param);
	void readBuffer(Enum mode);
	void readPixels(Int x, Int y, Sizei width, Sizei height, Enum format, Enum type, void* data);
	void getBooleanv(Enum pname, Boolean* data);
	void getDoublev(Enum pname, Double* data);
	uint getError();
	void getFloatv(Enum pname, Float* data);
	void getIntegerv(Enum pname, Int* data);
	const(UByte*) getString(Enum name);
	void getTexImage(Enum target, Int level, Enum format, Enum type, void* pixels);
	void getTexParameterfv(Enum target, Enum pname, Float* params);
	void getTexParameteriv(Enum target, Enum pname, Int* params);
	void getTexLevelParameterfv(Enum target, Int level, Enum pname, Float* params);
	void getTexLevelParameteriv(Enum target, Int level, Enum pname, Int* params);
	Boolean isEnabled(Enum cap);
	void depthRange(Double nearVal, Double farVal);
	void viewport(Int x, Int y, Sizei width, Sizei height);
	void drawArrays(Enum mode, Int first, Sizei count);
	void drawElements(Enum mode, Sizei count, Enum type, const(void)* indices);
	void getPointerv(Enum pname, void* params);
	void polygonOffset(Float factor, Float units);
	void copyTexImage1D(Enum target, Int level, Enum internalformat, Int x, Int y, Sizei width, Int border);
	void copyTexImage2D(Enum target, Int level, Enum internalformat, Int x, Int y, Sizei width, Sizei height, Int border);
	void copyTexSubImage1D(Enum target, Int level, Int xoffset, Int x, Int y, Sizei width);
	void copyTexSubImage2D(Enum target, Int level, Int xoffset, Int yoffset, Int x, Int y, Sizei width, Sizei height);
	void texSubImage1D(Enum target, Int level, Int xoffset, Sizei width, Enum format, Enum type, const(void)* pixels);
	void texSubImage2D(Enum target, Int level, Int xoffset, Int yoffset, Sizei width, Sizei height, Enum format, Enum type, const(void)* pixels);
	void bindTexture(Enum target, UInt texture);
	void deleteTextures(Sizei n, const(UInt)* textures);
	void genTextures(Sizei n, UInt* textures);
	Boolean isTexture(UInt texture);
	void drawRangeElements(Enum mode, UInt start, UInt end, Sizei count, Enum type, const(void)* indices);
	void texImage3D(Enum target, Int level, Int internalformat, Sizei width, Sizei height, Sizei depth, Int border, Enum format, Enum type, const(void)* data);
	void texSubImage3D(Enum target, Int level, Int xoffset, Int yoffset, Int zoffset, Sizei width, Sizei height, Sizei depth, Enum format, Enum type, const(void)* pixels);
	void copyTexSubImage3D(Enum target, Int level, Int xoffset, Int yoffset, Int zoffset, Int x, Int y, Sizei width, Sizei height);
	void activeTexture(Enum texture);
	void sampleCoverage(Float value, Boolean invert);
	void compressedTexImage3D(Enum target, Int level, Enum internalformat, Sizei width, Sizei height, Sizei depth, Int border, Sizei imageSize, const(void)* data);
	void compressedTexImage2D(Enum target, Int level, Enum internalformat, Sizei width, Sizei height, Int border, Sizei imageSize, const(void)* data);
	void compressedTexImage1D(Enum target, Int level, Enum internalformat, Sizei width, Int border, Sizei imageSize, const(void)* data);
	void compressedTexSubImage3D(Enum target, Int level, Int xoffset, Int yoffset, Int zoffset, Sizei width, Sizei height, Sizei depth, Enum format, Sizei imageSize, const(void)* data);
	void compressedTexSubImage2D(Enum target, Int level, Int xoffset, Int yoffset, Sizei width, Sizei height, Enum format, Sizei imageSize, const(void)* data);
	void compressedTexSubImage1D(Enum target, Int level, Int xoffset, Sizei width, Enum format, Sizei imageSize, const(void)* data);
	void getCompressedTexImage(Enum target, Int level, void* pixels);
	void blendFuncSeparate(Enum srcRGB, Enum dstRGB, Enum srcAlpha, Enum dstAlpha);
	void multiDrawArrays(Enum mode, const(Int)* first, const(Sizei)* count, Sizei drawcount);
	void multiDrawElements(Enum mode, const(Sizei)* count, Enum type, const(void)* indices, Sizei drawcount);
	void pointParameterf(Enum pname, Float param);
	void pointParameterfv(Enum pname, const(Float)* params);
	void pointParameteri(Enum pname, Int param);
	void pointParameteriv(Enum pname, const(Int)* params);
	void blendColor(Float red, Float green, Float blue, Float alpha);
	void blendEquation(Enum mode);
	void genQueries(Sizei n, UInt* ids);
	void deleteQueries(Sizei n, const(UInt)* ids);
	Boolean isQuery(UInt id);
	void beginQuery(Enum target, UInt id);
	void endQuery(Enum target);
	void getQueryiv(Enum target, Enum pname, Int* params);
	void getQueryObjectiv(UInt id, Enum pname, Int* params);
	void getQueryObjectuiv(UInt id, Enum pname, UInt* params);
	void bindBuffer(Enum target, UInt buffer);
	void deleteBuffers(Sizei n, const(UInt)* buffers);
	void genBuffers(Sizei n, UInt* buffers);
	Boolean isBuffer(UInt buffer);
	void bufferData(Enum target, SizeiPtr size, const(void)* data, Enum usage);
	void bufferSubData(Enum target, IntPtr offset, SizeiPtr size, const(void)* data);
	void getBufferSubData(Enum target, IntPtr offset, SizeiPtr size, void* data);
	void* mapBuffer(Enum target, Enum access);
	Boolean unmapBuffer(Enum target);
	void getBufferParameteriv(Enum target, Enum value, Int* data);
	void getBufferPointerv(Enum target, Enum pname, void* params);
	void blendEquationSeparate(Enum modeRGB, Enum modeAlpha);
	void drawBuffers(Sizei n, const(Enum)* bufs);
	void stencilOpSeparate(Enum face, Enum sfail, Enum dpfail, Enum dppass);
	void stencilFuncSeparate(Enum face, Enum func, Int ref_, UInt mask);
	void stencilMaskSeparate(Enum face, UInt mask);
	void attachShader(UInt program, UInt shader);
	void bindAttribLocation(UInt program, UInt index, const(Char)* name);
	void compileShader(UInt shader);
	uint createProgram();
	UInt createShader(Enum shaderType);
	void deleteProgram(UInt program);
	void deleteShader(UInt shader);
	void detachShader(UInt program, UInt shader);
	void disableVertexAttribArray(UInt index);
	void enableVertexAttribArray(UInt index);
	void getActiveAttrib(UInt program, UInt index, Sizei bufSize, Sizei* length, Int* size, Enum* type, Char* name);
	void getActiveUniform(UInt program, UInt index, Sizei bufSize, Sizei* length, Int* size, Enum* type, Char* name);
	void getAttachedShaders(UInt program, Sizei maxCount, Sizei* count, UInt* shaders);
	Int getAttribLocation(UInt program, const(Char)* name);
	void getProgramiv(UInt program, Enum pname, Int* params);
	void getProgramInfoLog(UInt program, Sizei maxLength, Sizei* length, Char* infoLog);
	void getShaderiv(UInt shader, Enum pname, Int* params);
	void getShaderInfoLog(UInt shader, Sizei maxLength, Sizei* length, Char* infoLog);
	void getShaderSource(UInt shader, Sizei bufSize, Sizei* length, Char* source);
	Int getUniformLocation(UInt program, const(Char)* name);
	void getUniformfv(UInt program, Int location, Float* params);
	void getUniformiv(UInt program, Int location, Int* params);
	void getVertexAttribdv(UInt index, Enum pname, Double* params);
	void getVertexAttribfv(UInt index, Enum pname, Float* params);
	void getVertexAttribiv(UInt index, Enum pname, Int* params);
	void getVertexAttribPointerv(UInt index, Enum pname, void* pointer);
	Boolean isProgram(UInt program);
	Boolean isShader(UInt shader);
	void linkProgram(UInt program);
	void shaderSource(UInt shader, Sizei count, const(Char*)* string, const(Int)* length);
	void useProgram(UInt program);
	void uniform1f(Int location, Float v0);
	void uniform2f(Int location, Float v0, Float v1);
	void uniform3f(Int location, Float v0, Float v1, Float v2);
	void uniform4f(Int location, Float v0, Float v1, Float v2, Float v3);
	void uniform1i(Int location, Int v0);
	void uniform2i(Int location, Int v0, Int v1);
	void uniform3i(Int location, Int v0, Int v1, Int v2);
	void uniform4i(Int location, Int v0, Int v1, Int v2, Int v3);
	void uniform1fv(Int location, Sizei count, const(Float)* value);
	void uniform2fv(Int location, Sizei count, const(Float)* value);
	void uniform3fv(Int location, Sizei count, const(Float)* value);
	void uniform4fv(Int location, Sizei count, const(Float)* value);
	void uniform1iv(Int location, Sizei count, const(Int)* value);
	void uniform2iv(Int location, Sizei count, const(Int)* value);
	void uniform3iv(Int location, Sizei count, const(Int)* value);
	void uniform4iv(Int location, Sizei count, const(Int)* value);
	void uniformMatrix2fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix3fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix4fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void validateProgram(UInt program);
	void vertexAttrib1d(UInt index, Double v0);
	void vertexAttrib1dv(UInt index, const(Double)* v);
	void vertexAttrib1f(UInt index, Float v0);
	void vertexAttrib1fv(UInt index, const(Float)* v);
	void vertexAttrib1s(UInt index, Short v0);
	void vertexAttrib1sv(UInt index, const(Short)* v);
	void vertexAttrib2d(UInt index, Double v0, Double v1);
	void vertexAttrib2dv(UInt index, const(Double)* v);
	void vertexAttrib2f(UInt index, Float v0, Float v1);
	void vertexAttrib2fv(UInt index, const(Float)* v);
	void vertexAttrib2s(UInt index, Short v0, Short v1);
	void vertexAttrib2sv(UInt index, const(Short)* v);
	void vertexAttrib3d(UInt index, Double v0, Double v1, Double v2);
	void vertexAttrib3dv(UInt index, const(Double)* v);
	void vertexAttrib3f(UInt index, Float v0, Float v1, Float v2);
	void vertexAttrib3fv(UInt index, const(Float)* v);
	void vertexAttrib3s(UInt index, Short v0, Short v1, Short v2);
	void vertexAttrib3sv(UInt index, const(Short)* v);
	void vertexAttrib4Nbv(UInt index, const(Byte)* v);
	void vertexAttrib4Niv(UInt index, const(Int)* v);
	void vertexAttrib4Nsv(UInt index, const(Short)* v);
	void vertexAttrib4Nub(UInt index, UByte v0, UByte v1, UByte v2, UByte v3);
	void vertexAttrib4Nubv(UInt index, const(UByte)* v);
	void vertexAttrib4Nuiv(UInt index, const(UInt)* v);
	void vertexAttrib4Nusv(UInt index, const(UShort)* v);
	void vertexAttrib4bv(UInt index, const(Byte)* v);
	void vertexAttrib4d(UInt index, Double v0, Double v1, Double v2, Double v3);
	void vertexAttrib4dv(UInt index, const(Double)* v);
	void vertexAttrib4f(UInt index, Float v0, Float v1, Float v2, Float v3);
	void vertexAttrib4fv(UInt index, const(Float)* v);
	void vertexAttrib4iv(UInt index, const(Int)* v);
	void vertexAttrib4s(UInt index, Short v0, Short v1, Short v2, Short v3);
	void vertexAttrib4sv(UInt index, const(Short)* v);
	void vertexAttrib4ubv(UInt index, const(UByte)* v);
	void vertexAttrib4uiv(UInt index, const(UInt)* v);
	void vertexAttrib4usv(UInt index, const(UShort)* v);
	void vertexAttribPointer(UInt index, Int size, Enum type, Boolean normalized, Sizei stride, const(void)* pointer);
	void uniformMatrix2x3fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix3x2fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix2x4fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix4x2fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix3x4fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix4x3fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void bindVertexArray(UInt array);
	void deleteVertexArrays(Sizei n, const(UInt)* arrays);
	void genVertexArrays(Sizei n, UInt* arrays);
	Boolean isVertexArray(UInt array);
	void uniform1d(Int location, Double x);
	void uniform2d(Int location, Double x, Double y);
	void uniform3d(Int location, Double x, Double y, Double z);
	void uniform4d(Int location, Double x, Double y, Double z, Double w);
	void uniform1dv(Int location, Sizei count, const(Double)* value);
	void uniform2dv(Int location, Sizei count, const(Double)* value);
	void uniform3dv(Int location, Sizei count, const(Double)* value);
	void uniform4dv(Int location, Sizei count, const(Double)* value);
	void uniformMatrix2dv(Int location, Sizei count, Boolean transpose, const(Double)* value);
	void uniformMatrix3dv(Int location, Sizei count, Boolean transpose, const(Double)* value);
	void uniformMatrix4dv(Int location, Sizei count, Boolean transpose, const(Double)* value);
	void uniformMatrix2x3dv(Int location, Sizei count, Boolean transpose, const(Double)* value);
	void uniformMatrix2x4dv(Int location, Sizei count, Boolean transpose, const(Double)* value);
	void uniformMatrix3x2dv(Int location, Sizei count, Boolean transpose, const(Double)* value);
	void uniformMatrix3x4dv(Int location, Sizei count, Boolean transpose, const(Double)* value);
	void uniformMatrix4x2dv(Int location, Sizei count, Boolean transpose, const(Double)* value);
	void uniformMatrix4x3dv(Int location, Sizei count, Boolean transpose, const(Double)* value);

	Boolean isRenderbuffer(UInt);
	void bindRenderbuffer(Enum, UInt);
	void deleteRenderbuffers(Sizei, const(UInt)*);
	void genRenderbuffers(Sizei, UInt*);
	void renderbufferStorage(Enum, Enum, Sizei, Sizei);
	void getRenderbufferParameteriv(Enum, Enum, Int*);
	Boolean isFramebuffer(UInt);
	void bindFramebuffer(Enum, UInt);
	void deleteFramebuffers(Sizei, const(UInt)*);
	void genFramebuffers(Sizei, UInt*);
	Enum checkFramebufferStatus(Enum);
	void framebufferTexture1D(Enum, Enum, Enum, UInt, Int);
	void framebufferTexture2D(Enum, Enum, Enum, UInt, Int);
	void framebufferTexture3D(Enum, Enum, Enum, UInt, Int, Int);
	void framebufferRenderbuffer(Enum, Enum, Enum, UInt);
	void getFramebufferAttachmentParameteriv(Enum, Enum, Enum, Int*);
	void generateMipmap(Enum);
	void blitFramebuffer(Int, Int, Int, Int, Int, Int, Int, Int, Bitfield, Enum);
	void renderbufferStorageMultisample(Enum, Sizei, Enum, Sizei, Sizei);
	void framebufferTextureLayer(Enum, Enum, UInt, Int, Int);
}
