module dui.internal.bindings.glx;
import dui.internal.bindings.x11;
import dui.internal.bindings.opengl;
import dui.internal.bindings.loader;
import core.stdc.config;
import core.stdc.stddef;

GLX loadGLX() {
	string[] libraries;

	version (Posix) {
		libraries = ["libGL.so.1", "libGL.so"];
	}
	else {
		static assert(0);
	}

	return loadSharedLibrary!(GLX, delegate(string name) => "glX"
		~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $])(libraries);
}

alias GLXContext = PrivateGLXcontextRec*;
alias GLXPixmap = c_ulong;
alias GLXDrawable = c_ulong;
alias GLXFBConfig = PrivateGLXFBConfigRec*;
alias GLXFBConfigID = c_ulong;
alias GLXContextID = c_ulong;
alias GLXWindow = c_ulong;
alias GLXPbuffer = c_ulong;
alias PFNGLXGETFBCONFIGSPROC = PrivateGLXFBConfigRec** function(Display* dpy, int screen, int* nelements);
alias PFNGLXCHOOSEFBCONFIGPROC = PrivateGLXFBConfigRec** function(Display* dpy, int screen, const(int)* attrib_list,
	int* nelements);
alias PFNGLXGETFBCONFIGATTRIBPROC = int function(Display* dpy, GLXFBConfig config, int attribute, int* value);
alias PFNGLXGETVISUALFROMFBCONFIGPROC = XVisualInfo* function(Display* dpy, GLXFBConfig config);
alias PFNGLXCREATEWINDOWPROC = c_ulong function(Display* dpy, GLXFBConfig config, Window win, const(int)* attrib_list);
alias PFNGLXDESTROYWINDOWPROC = void function(Display* dpy, GLXWindow win);
alias PFNGLXCREATEPIXMAPPROC = c_ulong function(Display* dpy, GLXFBConfig config, Pixmap pixmap, const(int)* attrib_list);
alias PFNGLXDESTROYPIXMAPPROC = void function(Display* dpy, GLXPixmap pixmap);
alias PFNGLXCREATEPBUFFERPROC = c_ulong function(Display* dpy, GLXFBConfig config, const(int)* attrib_list);
alias PFNGLXDESTROYPBUFFERPROC = void function(Display* dpy, GLXPbuffer pbuf);
alias PFNGLXQUERYDRAWABLEPROC = void function(Display* dpy, GLXDrawable draw, int attribute, uint* value);
alias PFNGLXCREATENEWCONTEXTPROC = PrivateGLXcontextRec* function(Display* dpy, GLXFBConfig config, int render_type,
	GLXContext share_list, int direct);
alias PFNGLXMAKECONTEXTCURRENTPROC = int function(Display* dpy, GLXDrawable draw, GLXDrawable read, GLXContext ctx);
alias PFNGLXGETCURRENTREADDRAWABLEPROC = c_ulong function();
alias PFNGLXGETCURRENTDISPLAYPROC = Display* function();
alias PFNGLXQUERYCONTEXTPROC = int function(Display* dpy, GLXContext ctx, int attribute, int* value);
alias PFNGLXSELECTEVENTPROC = void function(Display* dpy, GLXDrawable draw, c_ulong event_mask);
alias PFNGLXGETSELECTEDEVENTPROC = void function(Display* dpy, GLXDrawable draw, c_ulong* event_mask);
alias PrivateGLXextFuncPtr = void function();
alias PFNGLXGETPROCADDRESSPROC = void function(const(OpenGL.UByte)* procName) function(const(OpenGL.UByte)* procName);
alias PFNGLXALLOCATEMEMORYNVPROC = void* function(OpenGL.Sizei size, OpenGL.Float readfreq, OpenGL.Float writefreq, OpenGL.Float priority);
alias PFNGLXFREEMEMORYNVPROC = void function(void* pointer);
alias PFNGLXGETFRAMEUSAGEMESAPROC = int function(Display* dpy, GLXDrawable drawable, float* usage);
alias PFNGLXBEGINFRAMETRACKINGMESAPROC = int function(Display* dpy, GLXDrawable drawable);
alias PFNGLXENDFRAMETRACKINGMESAPROC = int function(Display* dpy, GLXDrawable drawable);
alias PFNGLXQUERYFRAMETRACKINGMESAPROC = int function(Display* dpy, GLXDrawable drawable, long* swapCount,
	long* missedFrames, float* lastMissedUsage);

union GLXEvent {
	GLXPbufferClobberEvent glxpbufferclobber;
	GLXBufferSwapComplete glxbufferswapcomplete;
	c_long[24] pad;
}

struct PrivateGLXcontextRec;
struct PrivateGLXFBConfigRec;
struct GLXPbufferClobberEvent {
	int event_type;
	int draw_type;
	c_ulong serial;
	int send_event;
	Display* display;
	GLXDrawable drawable;
	uint buffer_mask;
	uint aux_buffer;
	int x;
	int y;
	int width;
	int height;
	int count;
}

struct GLXBufferSwapComplete {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	GLXDrawable drawable;
	int event_type;
	long ust;
	long msc;
	long sbc;
}

enum PrivateGLX_NUMBER_EVENTS = 17;

interface GLX {
	extern(System) @nogc nothrow:

	void close();

	enum VERSION_1_1 = 1;
	enum VERSION_1_2 = 1;
	enum VERSION_1_3 = 1;
	enum VERSION_1_4 = 1;
	enum EXTENSION_NAME = "GLX";
	enum USE_GL = 1;
	enum BUFFER_SIZE = 2;
	enum LEVEL = 3;
	enum RGBA = 4;
	enum DOUBLEBUFFER = 5;
	enum STEREO = 6;
	enum AUX_BUFFERS = 7;
	enum RED_SIZE = 8;
	enum GREEN_SIZE = 9;
	enum BLUE_SIZE = 10;
	enum ALPHA_SIZE = 11;
	enum DEPTH_SIZE = 12;
	enum STENCIL_SIZE = 13;
	enum ACCUM_RED_SIZE = 14;
	enum ACCUM_GREEN_SIZE = 15;
	enum ACCUM_BLUE_SIZE = 16;
	enum ACCUM_ALPHA_SIZE = 17;
	enum BAD_SCREEN = 1;
	enum BAD_ATTRIBUTE = 2;
	enum NO_EXTENSION = 3;
	enum BAD_VISUAL = 4;
	enum BAD_CONTEXT = 5;
	enum BAD_VALUE = 6;
	enum BAD_ENUM = 7;
	enum VENDOR = 1;
	enum VERSION = 2;
	enum EXTENSIONS = 3;
	enum CONFIG_CAVEAT = 0x20;
	enum DONT_CARE = 0xFFFFFFFF;
	enum X_VISUAL_TYPE = 0x22;
	enum TRANSPARENT_TYPE = 0x23;
	enum TRANSPARENT_INDEX_VALUE = 0x24;
	enum TRANSPARENT_RED_VALUE = 0x25;
	enum TRANSPARENT_GREEN_VALUE = 0x26;
	enum TRANSPARENT_BLUE_VALUE = 0x27;
	enum TRANSPARENT_ALPHA_VALUE = 0x28;
	enum WINDOW_BIT = 0x00000001;
	enum PIXMAP_BIT = 0x00000002;
	enum PBUFFER_BIT = 0x00000004;
	enum AUX_BUFFERS_BIT = 0x00000010;
	enum FRONT_LEFT_BUFFER_BIT = 0x00000001;
	enum FRONT_RIGHT_BUFFER_BIT = 0x00000002;
	enum BACK_LEFT_BUFFER_BIT = 0x00000004;
	enum BACK_RIGHT_BUFFER_BIT = 0x00000008;
	enum DEPTH_BUFFER_BIT = 0x00000020;
	enum STENCIL_BUFFER_BIT = 0x00000040;
	enum ACCUM_BUFFER_BIT = 0x00000080;
	enum NONE = 0x8000;
	enum SLOW_CONFIG = 0x8001;
	enum TRUE_COLOR = 0x8002;
	enum DIRECT_COLOR = 0x8003;
	enum PSEUDO_COLOR = 0x8004;
	enum STATIC_COLOR = 0x8005;
	enum GRAY_SCALE = 0x8006;
	enum STATIC_GRAY = 0x8007;
	enum TRANSPARENT_RGB = 0x8008;
	enum TRANSPARENT_INDEX = 0x8009;
	enum VISUAL_ID = 0x800B;
	enum SCREEN = 0x800C;
	enum NON_CONFORMANT_CONFIG = 0x800D;
	enum DRAWABLE_TYPE = 0x8010;
	enum RENDER_TYPE = 0x8011;
	enum X_RENDERABLE = 0x8012;
	enum FBCONFIG_ID = 0x8013;
	enum RGBA_TYPE = 0x8014;
	enum COLOR_INDEX_TYPE = 0x8015;
	enum MAX_PBUFFER_WIDTH = 0x8016;
	enum MAX_PBUFFER_HEIGHT = 0x8017;
	enum MAX_PBUFFER_PIXELS = 0x8018;
	enum PRESERVED_CONTENTS = 0x801B;
	enum LARGEST_PBUFFER = 0x801C;
	enum WIDTH = 0x801D;
	enum HEIGHT = 0x801E;
	enum EVENT_MASK = 0x801F;
	enum DAMAGED = 0x8020;
	enum SAVED = 0x8021;
	enum WINDOW = 0x8022;
	enum PBUFFER = 0x8023;
	enum PBUFFER_HEIGHT = 0x8040;
	enum PBUFFER_WIDTH = 0x8041;
	enum RGBA_BIT = 0x00000001;
	enum COLOR_INDEX_BIT = 0x00000002;
	enum PBUFFER_CLOBBER_MASK = 0x08000000;
	enum SAMPLE_BUFFERS = 0x186a0;
	enum SAMPLES = 0x186a1;
	enum PbufferClobber = 0;
	enum BufferSwapComplete = 1;
	enum ARB_get_proc_address = 1;
	enum ARB_render_texture = 1;
	enum MESA_swap_frame_usage = 1;
	enum VERSION_1_0 = 1;
	enum GLX_3DFX_multisample = 1;
	enum SAMPLE_BUFFERS_3DFX = 0x8050;
	enum SAMPLES_3DFX = 0x8051;
	enum AMD_gpu_association = 1;
	enum GPU_VENDOR_AMD = 0x1F00;
	enum GPU_RENDERER_STRING_AMD = 0x1F01;
	enum GPU_OPENGL_VERSION_STRING_AMD = 0x1F02;
	enum GPU_FASTEST_TARGET_GPUS_AMD = 0x21A2;
	enum GPU_RAM_AMD = 0x21A3;
	enum GPU_CLOCK_AMD = 0x21A4;
	enum GPU_NUM_PIPES_AMD = 0x21A5;
	enum GPU_NUM_SIMD_AMD = 0x21A6;
	enum GPU_NUM_RB_AMD = 0x21A7;
	enum GPU_NUM_SPI_AMD = 0x21A8;
	enum ARB_context_flush_control = 1;
	enum ARB_create_context = 1;
	enum CONTEXT_DEBUG_BIT_ARB = 0x0001;
	enum CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = 0x0002;
	enum CONTEXT_MAJOR_VERSION_ARB = 0x2091;
	enum CONTEXT_MINOR_VERSION_ARB = 0x2092;
	enum CONTEXT_FLAGS_ARB = 0x2094;
	enum ARB_create_context_no_error = 1;
	enum ARB_create_context_profile = 1;
	enum CONTEXT_CORE_PROFILE_BIT_ARB = 0x00000001;
	enum CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = 0x00000002;
	enum CONTEXT_PROFILE_MASK_ARB = 0x9126;
	enum ARB_create_context_robustness = 1;
	enum CONTEXT_ROBUST_ACCESS_BIT_ARB = 0x00000004;
	enum LOSE_CONTEXT_ON_RESET_ARB = 0x8252;
	enum CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = 0x8256;
	enum NO_RESET_NOTIFICATION_ARB = 0x8261;
	enum ARB_fbconfig_float = 1;
	enum RGBA_FLOAT_BIT_ARB = 0x00000004;
	enum RGBA_FLOAT_TYPE_ARB = 0x20B9;
	enum ARB_framebuffer_sRGB = 1;
	enum FRAMEBUFFER_SRGB_CAPABLE_ARB = 0x20B2;
	enum ARB_multisample = 1;
	enum SAMPLE_BUFFERS_ARB = 100_000;
	enum SAMPLES_ARB = 100_001;
	enum ARB_robustness_application_isolation = 1;
	enum CONTEXT_RESET_ISOLATION_BIT_ARB = 0x00000008;
	enum ARB_robustness_share_group_isolation = 1;
	enum ARB_vertex_buffer_object = 1;
	enum CONTEXT_ALLOW_BUFFER_BYTE_ORDER_MISMATCH_ARB = 0x2095;
	enum ATI_pixel_format_float = 1;
	enum RGBA_FLOAT_ATI_BIT = 0x00000100;
	enum ATI_render_texture = 1;
	enum BIND_TO_TEXTURE_RGB_ATI = 0x9800;
	enum BIND_TO_TEXTURE_RGBA_ATI = 0x9801;
	enum TEXTURE_FORMAT_ATI = 0x9802;
	enum TEXTURE_TARGET_ATI = 0x9803;
	enum MIPMAP_TEXTURE_ATI = 0x9804;
	enum TEXTURE_RGB_ATI = 0x9805;
	enum TEXTURE_RGBA_ATI = 0x9806;
	enum NO_TEXTURE_ATI = 0x9807;
	enum TEXTURE_CUBE_MAP_ATI = 0x9808;
	enum TEXTURE_1D_ATI = 0x9809;
	enum TEXTURE_2D_ATI = 0x980A;
	enum MIPMAP_LEVEL_ATI = 0x980B;
	enum CUBE_MAP_FACE_ATI = 0x980C;
	enum TEXTURE_CUBE_MAP_POSITIVE_X_ATI = 0x980D;
	enum TEXTURE_CUBE_MAP_NEGATIVE_X_ATI = 0x980E;
	enum TEXTURE_CUBE_MAP_POSITIVE_Y_ATI = 0x980F;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Y_ATI = 0x9810;
	enum TEXTURE_CUBE_MAP_POSITIVE_Z_ATI = 0x9811;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Z_ATI = 0x9812;
	enum FRONT_LEFT_ATI = 0x9813;
	enum FRONT_RIGHT_ATI = 0x9814;
	enum BACK_LEFT_ATI = 0x9815;
	enum BACK_RIGHT_ATI = 0x9816;
	enum AUX0_ATI = 0x9817;
	enum AUX1_ATI = 0x9818;
	enum AUX2_ATI = 0x9819;
	enum AUX3_ATI = 0x981A;
	enum AUX4_ATI = 0x981B;
	enum AUX5_ATI = 0x981C;
	enum AUX6_ATI = 0x981D;
	enum AUX7_ATI = 0x981E;
	enum AUX8_ATI = 0x981F;
	enum AUX9_ATI = 0x9820;
	enum BIND_TO_TEXTURE_LUMINANCE_ATI = 0x9821;
	enum BIND_TO_TEXTURE_INTENSITY_ATI = 0x9822;
	enum EXT_buffer_age = 1;
	enum BACK_BUFFER_AGE_EXT = 0x20F4;
	enum EXT_create_context_es2_profile = 1;
	enum CONTEXT_ES2_PROFILE_BIT_EXT = 0x00000004;
	enum EXT_create_context_es_profile = 1;
	enum CONTEXT_ES_PROFILE_BIT_EXT = 0x00000004;
	enum EXT_fbconfig_packed_float = 1;
	enum RGBA_UNSIGNED_FLOAT_BIT_EXT = 0x00000008;
	enum RGBA_UNSIGNED_FLOAT_TYPE_EXT = 0x20B1;
	enum EXT_framebuffer_sRGB = 1;
	enum FRAMEBUFFER_SRGB_CAPABLE_EXT = 0x20B2;
	enum EXT_import_context = 1;
	enum SHARE_CONTEXT_EXT = 0x800A;
	enum VISUAL_ID_EXT = 0x800B;
	enum SCREEN_EXT = 0x800C;
	enum EXT_libglvnd = 1;
	enum VENDOR_NAMES_EXT = 0x20F6;
	enum EXT_scene_marker = 1;
	enum EXT_stereo_tree = 1;
	enum STEREO_NOTIFY_EXT = 0x00000000;
	enum STEREO_NOTIFY_MASK_EXT = 0x00000001;
	enum STEREO_TREE_EXT = 0x20F5;
	enum EXT_swap_control = 1;
	enum SWAP_INTERVAL_EXT = 0x20F1;
	enum MAX_SWAP_INTERVAL_EXT = 0x20F2;
	enum EXT_swap_control_tear = 1;
	enum LATE_SWAPS_TEAR_EXT = 0x20F3;
	enum EXT_texture_from_pixmap = 1;
	enum TEXTURE_1D_BIT_EXT = 0x00000001;
	enum TEXTURE_2D_BIT_EXT = 0x00000002;
	enum TEXTURE_RECTANGLE_BIT_EXT = 0x00000004;
	enum BIND_TO_TEXTURE_RGB_EXT = 0x20D0;
	enum BIND_TO_TEXTURE_RGBA_EXT = 0x20D1;
	enum BIND_TO_MIPMAP_TEXTURE_EXT = 0x20D2;
	enum BIND_TO_TEXTURE_TARGETS_EXT = 0x20D3;
	enum Y_INVERTED_EXT = 0x20D4;
	enum TEXTURE_FORMAT_EXT = 0x20D5;
	enum TEXTURE_TARGET_EXT = 0x20D6;
	enum MIPMAP_TEXTURE_EXT = 0x20D7;
	enum TEXTURE_FORMAT_NONE_EXT = 0x20D8;
	enum TEXTURE_FORMAT_RGB_EXT = 0x20D9;
	enum TEXTURE_FORMAT_RGBA_EXT = 0x20DA;
	enum TEXTURE_1D_EXT = 0x20DB;
	enum TEXTURE_2D_EXT = 0x20DC;
	enum TEXTURE_RECTANGLE_EXT = 0x20DD;
	enum FRONT_LEFT_EXT = 0x20DE;
	enum FRONT_RIGHT_EXT = 0x20DF;
	enum BACK_LEFT_EXT = 0x20E0;
	enum BACK_RIGHT_EXT = 0x20E1;
	enum AUX0_EXT = 0x20E2;
	enum AUX1_EXT = 0x20E3;
	enum AUX2_EXT = 0x20E4;
	enum AUX3_EXT = 0x20E5;
	enum AUX4_EXT = 0x20E6;
	enum AUX5_EXT = 0x20E7;
	enum AUX6_EXT = 0x20E8;
	enum AUX7_EXT = 0x20E9;
	enum AUX8_EXT = 0x20EA;
	enum AUX9_EXT = 0x20EB;
	enum EXT_visual_info = 1;
	enum X_VISUAL_TYPE_EXT = 0x22;
	enum TRANSPARENT_TYPE_EXT = 0x23;
	enum TRANSPARENT_INDEX_VALUE_EXT = 0x24;
	enum TRANSPARENT_RED_VALUE_EXT = 0x25;
	enum TRANSPARENT_GREEN_VALUE_EXT = 0x26;
	enum TRANSPARENT_BLUE_VALUE_EXT = 0x27;
	enum TRANSPARENT_ALPHA_VALUE_EXT = 0x28;
	enum NONE_EXT = 0x8000;
	enum TRUE_COLOR_EXT = 0x8002;
	enum DIRECT_COLOR_EXT = 0x8003;
	enum PSEUDO_COLOR_EXT = 0x8004;
	enum STATIC_COLOR_EXT = 0x8005;
	enum GRAY_SCALE_EXT = 0x8006;
	enum STATIC_GRAY_EXT = 0x8007;
	enum TRANSPARENT_RGB_EXT = 0x8008;
	enum TRANSPARENT_INDEX_EXT = 0x8009;
	enum EXT_visual_rating = 1;
	enum VISUAL_CAVEAT_EXT = 0x20;
	enum SLOW_VISUAL_EXT = 0x8001;
	enum NON_CONFORMANT_VISUAL_EXT = 0x800D;
	enum INTEL_swap_event = 1;
	enum EXCHANGE_COMPLETE_INTEL = 0x8180;
	enum COPY_COMPLETE_INTEL = 0x8181;
	enum FLIP_COMPLETE_INTEL = 0x8182;
	enum BUFFER_SWAP_COMPLETE_INTEL_MASK = 0x04000000;
	enum MESA_agp_offset = 1;
	enum MESA_copy_sub_buffer = 1;
	enum MESA_pixmap_colormap = 1;
	enum MESA_query_renderer = 1;
	enum RENDERER_VENDOR_ID_MESA = 0x8183;
	enum RENDERER_DEVICE_ID_MESA = 0x8184;
	enum RENDERER_VERSION_MESA = 0x8185;
	enum RENDERER_ACCELERATED_MESA = 0x8186;
	enum RENDERER_VIDEO_MEMORY_MESA = 0x8187;
	enum RENDERER_UNIFIED_MEMORY_ARCHITECTURE_MESA = 0x8188;
	enum RENDERER_PREFERRED_PROFILE_MESA = 0x8189;
	enum RENDERER_OPENGL_CORE_PROFILE_VERSION_MESA = 0x818A;
	enum RENDERER_OPENGL_COMPATIBILITY_PROFILE_VERSION_MESA = 0x818B;
	enum RENDERER_OPENGL_ES_PROFILE_VERSION_MESA = 0x818C;
	enum RENDERER_OPENGL_ES2_PROFILE_VERSION_MESA = 0x818D;
	enum RENDERER_ID_MESA = 0x818E;
	enum MESA_release_buffers = 1;
	enum MESA_set_3dfx_mode = 1;
	enum GLX_3DFX_WINDOW_MODE_MESA = 0x1;
	enum GLX_3DFX_FULLSCREEN_MODE_MESA = 0x2;
	enum MESA_swap_control = 1;
	enum NV_copy_buffer = 1;
	enum NV_copy_image = 1;
	enum NV_delay_before_swap = 1;
	enum NV_float_buffer = 1;
	enum FLOAT_COMPONENTS_NV = 0x20B0;
	enum NV_multisample_coverage = 1;
	enum COLOR_SAMPLES_NV = 0x20B3;
	enum COVERAGE_SAMPLES_NV = 100_001;
	enum NV_present_video = 1;
	enum NUM_VIDEO_SLOTS_NV = 0x20F0;
	enum NV_robustness_video_memory_purge = 1;
	enum GENERATE_RESET_ON_VIDEO_MEMORY_PURGE_NV = 0x20F7;
	enum NV_swap_group = 1;
	enum NV_vertex_array_range = 1;
	enum NV_video_capture = 1;
	enum DEVICE_ID_NV = 0x20CD;
	enum UNIQUE_ID_NV = 0x20CE;
	enum NUM_VIDEO_CAPTURE_SLOTS_NV = 0x20CF;
	enum NV_video_out = 1;
	enum VIDEO_OUT_COLOR_NV = 0x20C3;
	enum VIDEO_OUT_ALPHA_NV = 0x20C4;
	enum VIDEO_OUT_DEPTH_NV = 0x20C5;
	enum VIDEO_OUT_COLOR_AND_ALPHA_NV = 0x20C6;
	enum VIDEO_OUT_COLOR_AND_DEPTH_NV = 0x20C7;
	enum VIDEO_OUT_FRAME_NV = 0x20C8;
	enum VIDEO_OUT_FIELD_1_NV = 0x20C9;
	enum VIDEO_OUT_FIELD_2_NV = 0x20CA;
	enum VIDEO_OUT_STACKED_FIELDS_1_2_NV = 0x20CB;
	enum VIDEO_OUT_STACKED_FIELDS_2_1_NV = 0x20CC;
	enum OML_swap_method = 1;
	enum SWAP_METHOD_OML = 0x8060;
	enum SWAP_EXCHANGE_OML = 0x8061;
	enum SWAP_COPY_OML = 0x8062;
	enum SWAP_UNDEFINED_OML = 0x8063;
	enum OML_sync_control = 1;
	enum SGIS_blended_overlay = 1;
	enum BLENDED_RGBA_SGIS = 0x8025;
	enum SGIS_color_range = 1;
	enum SGIS_multisample = 1;
	enum SAMPLE_BUFFERS_SGIS = 100_000;
	enum SAMPLES_SGIS = 100_001;
	enum SGIS_shared_multisample = 1;
	enum MULTISAMPLE_SUB_RECT_WIDTH_SGIS = 0x8026;
	enum MULTISAMPLE_SUB_RECT_HEIGHT_SGIS = 0x8027;
	enum SGIX_fbconfig = 1;
	enum RGBA_BIT_SGIX = 0x00000001;
	enum WINDOW_BIT_SGIX = 0x00000001;
	enum COLOR_INDEX_BIT_SGIX = 0x00000002;
	enum PIXMAP_BIT_SGIX = 0x00000002;
	enum DRAWABLE_TYPE_SGIX = 0x8010;
	enum RENDER_TYPE_SGIX = 0x8011;
	enum X_RENDERABLE_SGIX = 0x8012;
	enum FBCONFIG_ID_SGIX = 0x8013;
	enum RGBA_TYPE_SGIX = 0x8014;
	enum COLOR_INDEX_TYPE_SGIX = 0x8015;
	enum SGIX_hyperpipe = 1;
	enum HYPERPIPE_DISPLAY_PIPE_SGIX = 0x00000001;
	enum PIPE_RECT_SGIX = 0x00000001;
	enum HYPERPIPE_RENDER_PIPE_SGIX = 0x00000002;
	enum PIPE_RECT_LIMITS_SGIX = 0x00000002;
	enum HYPERPIPE_STEREO_SGIX = 0x00000003;
	enum HYPERPIPE_PIXEL_AVERAGE_SGIX = 0x00000004;
	enum HYPERPIPE_PIPE_NAME_LENGTH_SGIX = 80;
	enum BAD_HYPERPIPE_CONFIG_SGIX = 91;
	enum BAD_HYPERPIPE_SGIX = 92;
	enum HYPERPIPE_ID_SGIX = 0x8030;
	enum SGIX_pbuffer = 1;
	enum FRONT_LEFT_BUFFER_BIT_SGIX = 0x00000001;
	enum FRONT_RIGHT_BUFFER_BIT_SGIX = 0x00000002;
	enum BACK_LEFT_BUFFER_BIT_SGIX = 0x00000004;
	enum PBUFFER_BIT_SGIX = 0x00000004;
	enum BACK_RIGHT_BUFFER_BIT_SGIX = 0x00000008;
	enum AUX_BUFFERS_BIT_SGIX = 0x00000010;
	enum DEPTH_BUFFER_BIT_SGIX = 0x00000020;
	enum STENCIL_BUFFER_BIT_SGIX = 0x00000040;
	enum ACCUM_BUFFER_BIT_SGIX = 0x00000080;
	enum SAMPLE_BUFFERS_BIT_SGIX = 0x00000100;
	enum MAX_PBUFFER_WIDTH_SGIX = 0x8016;
	enum MAX_PBUFFER_HEIGHT_SGIX = 0x8017;
	enum MAX_PBUFFER_PIXELS_SGIX = 0x8018;
	enum OPTIMAL_PBUFFER_WIDTH_SGIX = 0x8019;
	enum OPTIMAL_PBUFFER_HEIGHT_SGIX = 0x801A;
	enum PRESERVED_CONTENTS_SGIX = 0x801B;
	enum LARGEST_PBUFFER_SGIX = 0x801C;
	enum WIDTH_SGIX = 0x801D;
	enum HEIGHT_SGIX = 0x801E;
	enum EVENT_MASK_SGIX = 0x801F;
	enum DAMAGED_SGIX = 0x8020;
	enum SAVED_SGIX = 0x8021;
	enum WINDOW_SGIX = 0x8022;
	enum PBUFFER_SGIX = 0x8023;
	enum BUFFER_CLOBBER_MASK_SGIX = 0x08000000;
	enum SGIX_swap_barrier = 1;
	enum SGIX_swap_group = 1;
	enum SGIX_video_resize = 1;
	enum SYNC_FRAME_SGIX = 0x00000000;
	enum SYNC_SWAP_SGIX = 0x00000001;
	enum SGIX_visual_select_group = 1;
	enum VISUAL_SELECT_GROUP_SGIX = 0x8028;
	enum SGI_cushion = 1;
	enum SGI_make_current_read = 1;
	enum SGI_swap_control = 1;
	enum SGI_video_sync = 1;
	enum SUN_get_transparent_index = 1;
	enum SUN_video_resize = 1;
	enum VIDEO_RESIZE_SUN = 0x8171;

	XVisualInfo* chooseVisual(Display* dpy, int screen, int* attribList);
	GLXContext createContext(Display* dpy, XVisualInfo* vis, GLXContext shareList, int direct);
	GLXContext createContextAttribsARB(Display* dpy, GLXFBConfig config, GLXContext share_context, int direct,
		const(int)* attrib_list);
	void destroyContext(Display* dpy, GLXContext ctx);
	int makeCurrent(Display* dpy, GLXDrawable drawable, GLXContext ctx);
	void copyContext(Display* dpy, GLXContext src, GLXContext dst, c_ulong mask);
	void swapBuffers(Display* dpy, GLXDrawable drawable);
	GLXPixmap createGLXPixmap(Display* dpy, XVisualInfo* visual, Pixmap pixmap);
	void destroyGLXPixmap(Display* dpy, GLXPixmap pixmap);
	int queryExtension(Display* dpy, int* errorb, int* event);
	int queryVersion(Display* dpy, int* maj, int* min);
	int isDirect(Display* dpy, GLXContext ctx);
	int getConfig(Display* dpy, XVisualInfo* visual, int attrib, int* value);
	GLXContext getCurrentContext();
	GLXDrawable getCurrentDrawable();
	void waitGL();
	void waitX();
	void useXFont(Font font, int first, int count, int list);
	const(char)* queryExtensionsString(Display* dpy, int screen);
	const(char)* queryServerString(Display* dpy, int screen, int name);
	const(char)* getClientString(Display* dpy, int name);
	Display* getCurrentDisplay();
	GLXFBConfig* chooseFBConfig(Display* dpy, int screen, const(int)* attribList, int* nitems);
	int getFBConfigAttrib(Display* dpy, GLXFBConfig config, int attribute, int* value);
	GLXFBConfig* getFBConfigs(Display* dpy, int screen, int* nelements);
	XVisualInfo* getVisualFromFBConfig(Display* dpy, GLXFBConfig config);
	GLXWindow createWindow(Display* dpy, GLXFBConfig config, Window win, const(int)* attribList);
	void destroyWindow(Display* dpy, GLXWindow window);
	GLXPixmap createPixmap(Display* dpy, GLXFBConfig config, Pixmap pixmap, const(int)* attribList);
	void destroyPixmap(Display* dpy, GLXPixmap pixmap);
	GLXPbuffer createPbuffer(Display* dpy, GLXFBConfig config, const(int)* attribList);
	void destroyPbuffer(Display* dpy, GLXPbuffer pbuf);
	void queryDrawable(Display* dpy, GLXDrawable draw, int attribute, uint* value);
	GLXContext createNewContext(Display* dpy, GLXFBConfig config, int renderType, GLXContext shareList, int direct);
	int makeContextCurrent(Display* dpy, GLXDrawable draw, GLXDrawable read, GLXContext ctx);
	GLXDrawable getCurrentReadDrawable();
	int queryContext(Display* dpy, GLXContext ctx, int attribute, int* value);
	void selectEvent(Display* dpy, GLXDrawable drawable, c_ulong mask);
	void getSelectedEvent(Display* dpy, GLXDrawable drawable, c_ulong* mask);
	PrivateGLXextFuncPtr getProcAddressARB(const(OpenGL.UByte)*);
	void function(const(OpenGL.UByte)* procname) getProcAddress(const(OpenGL.UByte)* procname);
	void* allocateMemoryNV(OpenGL.Sizei size, OpenGL.Float readfreq, OpenGL.Float writefreq, OpenGL.Float priority);
	void freeMemoryNV(void* pointer);
	// int bindTexImageARB(Display* dpy, GLXPbuffer pbuffer, int buffer);
	// int releaseTexImageARB(Display* dpy, GLXPbuffer pbuffer, int buffer);
	// int drawableAttribARB(Display* dpy, GLXDrawable draw, const(int)* attribList);
	// int getFrameUsageMESA(Display* dpy, GLXDrawable drawable, float* usage);
	// int beginFrameTrackingMESA(Display* dpy, GLXDrawable drawable);
	// int endFrameTrackingMESA(Display* dpy, GLXDrawable drawable);
	// int queryFrameTrackingMESA(Display* dpy, GLXDrawable drawable, long* swapCount, long* missedFrames, float* lastMissedUsage);

}
