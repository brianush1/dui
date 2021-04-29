module dui.internal.bindings.x11;
import dui.internal.bindings.loader;
import core.stdc.config;
import core.stdc.stddef;

X11 loadX11() {
	string[] libraries;

	version (Posix) {
		libraries = ["libX11.so.6", "libX11.so"];
	}
	else {
		static assert(0);
	}

	return loadSharedLibrary!(X11, delegate(string name) {
		if (name[0] == '_') {
			return name[1 .. $];
		}
		else {
			return "X" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
		}
	})(libraries);
}

enum X_PROTOCOL = 11;
enum X_PROTOCOL_REVISION = 0;
alias XID = c_ulong;
alias Mask = c_ulong;
alias Atom = c_ulong;
alias VisualID = c_ulong;
alias Time = c_ulong;
alias Window = c_ulong;
alias Drawable = c_ulong;
alias Font = c_ulong;
alias Pixmap = c_ulong;
alias Cursor = c_ulong;
alias Colormap = c_ulong;
alias GContext = c_ulong;
alias KeyCode = uint;
enum None = 0L;
enum ParentRelative = 1L;
enum CopyFromParent = 0L;
enum PointerWindow = 0L;
enum InputFocus = 1L;
enum PointerRoot = 1L;
enum AnyPropertyType = 0L;
enum AnyKey = 0L;
enum AnyButton = 0L;
enum AllTemporary = 0L;
enum CurrentTime = 0L;
enum NoSymbol = 0L;
enum NoEventMask = 0L;
enum KeyPressMask = 1L << 0;
enum KeyReleaseMask = 1L << 1;
enum ButtonPressMask = 1L << 2;
enum ButtonReleaseMask = 1L << 3;
enum EnterWindowMask = 1L << 4;
enum LeaveWindowMask = 1L << 5;
enum PointerMotionMask = 1L << 6;
enum PointerMotionHintMask = 1L << 7;
enum Button1MotionMask = 1L << 8;
enum Button2MotionMask = 1L << 9;
enum Button3MotionMask = 1L << 10;
enum Button4MotionMask = 1L << 11;
enum Button5MotionMask = 1L << 12;
enum ButtonMotionMask = 1L << 13;
enum KeymapStateMask = 1L << 14;
enum ExposureMask = 1L << 15;
enum VisibilityChangeMask = 1L << 16;
enum StructureNotifyMask = 1L << 17;
enum ResizeRedirectMask = 1L << 18;
enum SubstructureNotifyMask = 1L << 19;
enum SubstructureRedirectMask = 1L << 20;
enum FocusChangeMask = 1L << 21;
enum PropertyChangeMask = 1L << 22;
enum ColormapChangeMask = 1L << 23;
enum OwnerGrabButtonMask = 1L << 24;
enum KeyPress = 2;
enum KeyRelease = 3;
enum ButtonPress = 4;
enum ButtonRelease = 5;
enum MotionNotify = 6;
enum EnterNotify = 7;
enum LeaveNotify = 8;
enum FocusIn = 9;
enum FocusOut = 10;
enum KeymapNotify = 11;
enum Expose = 12;
enum GraphicsExpose = 13;
enum NoExpose = 14;
enum VisibilityNotify = 15;
enum CreateNotify = 16;
enum DestroyNotify = 17;
enum UnmapNotify = 18;
enum MapNotify = 19;
enum MapRequest = 20;
enum ReparentNotify = 21;
enum ConfigureNotify = 22;
enum ConfigureRequest = 23;
enum GravityNotify = 24;
enum ResizeRequest = 25;
enum CirculateNotify = 26;
enum CirculateRequest = 27;
enum PropertyNotify = 28;
enum SelectionClear = 29;
enum SelectionRequest = 30;
enum SelectionNotify = 31;
enum ColormapNotify = 32;
enum ClientMessage = 33;
enum MappingNotify = 34;
enum GenericEvent = 35;
enum LASTEvent = 36;
enum ShiftMask = 1 << 0;
enum LockMask = 1 << 1;
enum ControlMask = 1 << 2;
enum Mod1Mask = 1 << 3;
enum Mod2Mask = 1 << 4;
enum Mod3Mask = 1 << 5;
enum Mod4Mask = 1 << 6;
enum Mod5Mask = 1 << 7;
enum ShiftMapIndex = 0;
enum LockMapIndex = 1;
enum ControlMapIndex = 2;
enum Mod1MapIndex = 3;
enum Mod2MapIndex = 4;
enum Mod3MapIndex = 5;
enum Mod4MapIndex = 6;
enum Mod5MapIndex = 7;
enum Button1Mask = 1 << 8;
enum Button2Mask = 1 << 9;
enum Button3Mask = 1 << 10;
enum Button4Mask = 1 << 11;
enum Button5Mask = 1 << 12;
enum AnyModifier = 1 << 15;
enum Button1 = 1;
enum Button2 = 2;
enum Button3 = 3;
enum Button4 = 4;
enum Button5 = 5;
enum NotifyNormal = 0;
enum NotifyGrab = 1;
enum NotifyUngrab = 2;
enum NotifyWhileGrabbed = 3;
enum NotifyHint = 1;
enum NotifyAncestor = 0;
enum NotifyVirtual = 1;
enum NotifyInferior = 2;
enum NotifyNonlinear = 3;
enum NotifyNonlinearVirtual = 4;
enum NotifyPointer = 5;
enum NotifyPointerRoot = 6;
enum NotifyDetailNone = 7;
enum VisibilityUnobscured = 0;
enum VisibilityPartiallyObscured = 1;
enum VisibilityFullyObscured = 2;
enum PlaceOnTop = 0;
enum PlaceOnBottom = 1;
enum FamilyInternet = 0;
enum FamilyDECnet = 1;
enum FamilyChaos = 2;
enum FamilyInternet6 = 6;
enum FamilyServerInterpreted = 5;
enum PropertyNewValue = 0;
enum PropertyDelete = 1;
enum ColormapUninstalled = 0;
enum ColormapInstalled = 1;
enum GrabModeSync = 0;
enum GrabModeAsync = 1;
enum GrabSuccess = 0;
enum AlreadyGrabbed = 1;
enum GrabInvalidTime = 2;
enum GrabNotViewable = 3;
enum GrabFrozen = 4;
enum AsyncPointer = 0;
enum SyncPointer = 1;
enum ReplayPointer = 2;
enum AsyncKeyboard = 3;
enum SyncKeyboard = 4;
enum ReplayKeyboard = 5;
enum AsyncBoth = 6;
enum SyncBoth = 7;
enum RevertToNone = cast(int) None;
enum RevertToPointerRoot = cast(int) PointerRoot;
enum RevertToParent = 2;
enum Success = 0;
enum BadRequest = 1;
enum BadValue = 2;
enum BadWindow = 3;
enum BadPixmap = 4;
enum BadAtom = 5;
enum BadCursor = 6;
enum BadFont = 7;
enum BadMatch = 8;
enum BadDrawable = 9;
enum BadAccess = 10;
enum BadAlloc = 11;
enum BadColor = 12;
enum BadGC = 13;
enum BadIDChoice = 14;
enum BadName = 15;
enum BadLength = 16;
enum BadImplementation = 17;
enum FirstExtensionError = 128;
enum LastExtensionError = 255;
enum InputOutput = 1;
enum InputOnly = 2;
enum CWBackPixmap = 1L << 0;
enum CWBackPixel = 1L << 1;
enum CWBorderPixmap = 1L << 2;
enum CWBorderPixel = 1L << 3;
enum CWBitGravity = 1L << 4;
enum CWWinGravity = 1L << 5;
enum CWBackingStore = 1L << 6;
enum CWBackingPlanes = 1L << 7;
enum CWBackingPixel = 1L << 8;
enum CWOverrideRedirect = 1L << 9;
enum CWSaveUnder = 1L << 10;
enum CWEventMask = 1L << 11;
enum CWDontPropagate = 1L << 12;
enum CWColormap = 1L << 13;
enum CWCursor = 1L << 14;
enum CWX = 1 << 0;
enum CWY = 1 << 1;
enum CWWidth = 1 << 2;
enum CWHeight = 1 << 3;
enum CWBorderWidth = 1 << 4;
enum CWSibling = 1 << 5;
enum CWStackMode = 1 << 6;
enum ForgetGravity = 0;
enum NorthWestGravity = 1;
enum NorthGravity = 2;
enum NorthEastGravity = 3;
enum WestGravity = 4;
enum CenterGravity = 5;
enum EastGravity = 6;
enum SouthWestGravity = 7;
enum SouthGravity = 8;
enum SouthEastGravity = 9;
enum StaticGravity = 10;
enum UnmapGravity = 0;
enum NotUseful = 0;
enum WhenMapped = 1;
enum Always = 2;
enum IsUnmapped = 0;
enum IsUnviewable = 1;
enum IsViewable = 2;
enum SetModeInsert = 0;
enum SetModeDelete = 1;
enum DestroyAll = 0;
enum RetainPermanent = 1;
enum RetainTemporary = 2;
enum Above = 0;
enum Below = 1;
enum TopIf = 2;
enum BottomIf = 3;
enum Opposite = 4;
enum RaiseLowest = 0;
enum LowerHighest = 1;
enum PropModeReplace = 0;
enum PropModePrepend = 1;
enum PropModeAppend = 2;
enum GXclear = 0x0;
enum GXand = 0x1;
enum GXandReverse = 0x2;
enum GXcopy = 0x3;
enum GXandInverted = 0x4;
enum GXnoop = 0x5;
enum GXxor = 0x6;
enum GXor = 0x7;
enum GXnor = 0x8;
enum GXequiv = 0x9;
enum GXinvert = 0xa;
enum GXorReverse = 0xb;
enum GXcopyInverted = 0xc;
enum GXorInverted = 0xd;
enum GXnand = 0xe;
enum GXset = 0xf;
enum LineSolid = 0;
enum LineOnOffDash = 1;
enum LineDoubleDash = 2;
enum CapNotLast = 0;
enum CapButt = 1;
enum CapRound = 2;
enum CapProjecting = 3;
enum JoinMiter = 0;
enum JoinRound = 1;
enum JoinBevel = 2;
enum FillSolid = 0;
enum FillTiled = 1;
enum FillStippled = 2;
enum FillOpaqueStippled = 3;
enum EvenOddRule = 0;
enum WindingRule = 1;
enum ClipByChildren = 0;
enum IncludeInferiors = 1;
enum Unsorted = 0;
enum YSorted = 1;
enum YXSorted = 2;
enum YXBanded = 3;
enum CoordModeOrigin = 0;
enum CoordModePrevious = 1;
enum Complex = 0;
enum Nonconvex = 1;
enum Convex = 2;
enum ArcChord = 0;
enum ArcPieSlice = 1;
enum GCFunction = 1L << 0;
enum GCPlaneMask = 1L << 1;
enum GCForeground = 1L << 2;
enum GCBackground = 1L << 3;
enum GCLineWidth = 1L << 4;
enum GCLineStyle = 1L << 5;
enum GCCapStyle = 1L << 6;
enum GCJoinStyle = 1L << 7;
enum GCFillStyle = 1L << 8;
enum GCFillRule = 1L << 9;
enum GCTile = 1L << 10;
enum GCStipple = 1L << 11;
enum GCTileStipXOrigin = 1L << 12;
enum GCTileStipYOrigin = 1L << 13;
enum GCFont = 1L << 14;
enum GCSubwindowMode = 1L << 15;
enum GCGraphicsExposures = 1L << 16;
enum GCClipXOrigin = 1L << 17;
enum GCClipYOrigin = 1L << 18;
enum GCClipMask = 1L << 19;
enum GCDashOffset = 1L << 20;
enum GCDashList = 1L << 21;
enum GCArcMode = 1L << 22;
enum GCLastBit = 22;
enum FontLeftToRight = 0;
enum FontRightToLeft = 1;
enum FontChange = 255;
enum XYBitmap = 0;
enum XYPixmap = 1;
enum ZPixmap = 2;
enum AllocNone = 0;
enum AllocAll = 1;
enum DoRed = 1 << 0;
enum DoGreen = 1 << 1;
enum DoBlue = 1 << 2;
enum CursorShape = 0;
enum TileShape = 1;
enum StippleShape = 2;
enum AutoRepeatModeOff = 0;
enum AutoRepeatModeOn = 1;
enum AutoRepeatModeDefault = 2;
enum LedModeOff = 0;
enum LedModeOn = 1;
enum KBKeyClickPercent = 1L << 0;
enum KBBellPercent = 1L << 1;
enum KBBellPitch = 1L << 2;
enum KBBellDuration = 1L << 3;
enum KBLed = 1L << 4;
enum KBLedMode = 1L << 5;
enum KBKey = 1L << 6;
enum KBAutoRepeatMode = 1L << 7;
enum MappingSuccess = 0;
enum MappingBusy = 1;
enum MappingFailed = 2;
enum MappingModifier = 0;
enum MappingKeyboard = 1;
enum MappingPointer = 2;
enum DontPreferBlanking = 0;
enum PreferBlanking = 1;
enum DefaultBlanking = 2;
enum DisableScreenSaver = 0;
enum DisableScreenInterval = 0;
enum DontAllowExposures = 0;
enum AllowExposures = 1;
enum DefaultExposures = 2;
enum ScreenSaverReset = 0;
enum ScreenSaverActive = 1;
enum HostInsert = 0;
enum HostDelete = 1;
enum EnableAccess = 1;
enum DisableAccess = 0;
enum StaticGray = 0;
enum GrayScale = 1;
enum StaticColor = 2;
enum PseudoColor = 3;
enum TrueColor = 4;
enum DirectColor = 5;
enum LSBFirst = 0;
enum MSBFirst = 1;

alias XPointer = char*;
alias GC = PrivateXGC*;
alias Display = PrivateXDisplay;
alias XKeyPressedEvent = XKeyEvent;
alias XKeyReleasedEvent = XKeyEvent;
alias XButtonPressedEvent = XButtonEvent;
alias XButtonReleasedEvent = XButtonEvent;
alias XPointerMovedEvent = XMotionEvent;
alias XEnterWindowEvent = XCrossingEvent;
alias XLeaveWindowEvent = XCrossingEvent;
alias XFocusInEvent = XFocusChangeEvent;
alias XFocusOutEvent = XFocusChangeEvent;
alias XOM = PrivateXOM*;
alias XOC = PrivateXOC*;
alias XFontSet = PrivateXOC*;
alias XIM = PrivateXIM*;
alias XIC = PrivateXIC*;
alias XIMProc = void function(XIM, XPointer, XPointer);
alias XICProc = int function(XIC, XPointer, XPointer);
alias XIDProc = void function(Display*, XPointer, XPointer);
alias XIMStyle = c_ulong;
alias XVaNestedList = void*;
alias XIMFeedback = c_ulong;
alias XIMPreeditState = c_ulong;
alias XIMResetState = c_ulong;
alias XIMStringConversionFeedback = c_ulong;
alias XIMStringConversionPosition = ushort;
alias XIMStringConversionType = ushort;
alias XIMStringConversionOperation = ushort;
alias XIMHotKeyState = c_ulong;
alias XErrorHandler = int function(Display*, XErrorEvent*);
alias XIOErrorHandler = int function(Display*);
alias XConnectionWatchProc = void function(Display*, XPointer, int, int, XPointer*);
alias Bool = int;
alias Status = int;
enum XlibSpecificationRelease = 6;
enum XOrientation {
	XOMOrientation_LTR_TTB = 0,
	XOMOrientation_RTL_TTB = 1,
	XOMOrientation_TTB_LTR = 2,
	XOMOrientation_TTB_RTL = 3,
	XOMOrientation_Context = 4
}

enum XIMCaretDirection {
	XIMForwardChar = 0,
	XIMBackwardChar = 1,
	XIMForwardWord = 2,
	XIMBackwardWord = 3,
	XIMCaretUp = 4,
	XIMCaretDown = 5,
	XIMNextLine = 6,
	XIMPreviousLine = 7,
	XIMLineStart = 8,
	XIMLineEnd = 9,
	XIMAbsolutePosition = 10,
	XIMDontChange = 11
}

enum XIMCaretStyle {
	XIMIsInvisible = 0,
	XIMIsPrimary = 1,
	XIMIsSecondary = 2
}

enum XIMStatusDataType {
	XIMTextType = 0,
	XIMBitmapType = 1
}

enum X_HAVE_UTF8_STRING = 1;
enum True = 1;
enum False = 0;
enum QueuedAlready = 0;
enum QueuedAfterReading = 1;
enum QueuedAfterFlush = 2;
enum AllPlanes = cast(c_ulong)~0L;
enum XNRequiredCharSet = "requiredCharSet";
enum XNQueryOrientation = "queryOrientation";
enum XNBaseFontName = "baseFontName";
enum XNOMAutomatic = "omAutomatic";
enum XNMissingCharSet = "missingCharSet";
enum XNDefaultString = "defaultString";
enum XNOrientation = "orientation";
enum XNDirectionalDependentDrawing = "directionalDependentDrawing";
enum XNContextualDrawing = "contextualDrawing";
enum XNFontInfo = "fontInfo";
enum XIMPreeditArea = 0x0001L;
enum XIMPreeditCallbacks = 0x0002L;
enum XIMPreeditPosition = 0x0004L;
enum XIMPreeditNothing = 0x0008L;
enum XIMPreeditNone = 0x0010L;
enum XIMStatusArea = 0x0100L;
enum XIMStatusCallbacks = 0x0200L;
enum XIMStatusNothing = 0x0400L;
enum XIMStatusNone = 0x0800L;
enum XNVaNestedList = "XNVaNestedList";
enum XNQueryInputStyle = "queryInputStyle";
enum XNClientWindow = "clientWindow";
enum XNInputStyle = "inputStyle";
enum XNFocusWindow = "focusWindow";
enum XNResourceName = "resourceName";
enum XNResourceClass = "resourceClass";
enum XNGeometryCallback = "geometryCallback";
enum XNDestroyCallback = "destroyCallback";
enum XNFilterEvents = "filterEvents";
enum XNPreeditStartCallback = "preeditStartCallback";
enum XNPreeditDoneCallback = "preeditDoneCallback";
enum XNPreeditDrawCallback = "preeditDrawCallback";
enum XNPreeditCaretCallback = "preeditCaretCallback";
enum XNPreeditStateNotifyCallback = "preeditStateNotifyCallback";
enum XNPreeditAttributes = "preeditAttributes";
enum XNStatusStartCallback = "statusStartCallback";
enum XNStatusDoneCallback = "statusDoneCallback";
enum XNStatusDrawCallback = "statusDrawCallback";
enum XNStatusAttributes = "statusAttributes";
enum XNArea = "area";
enum XNAreaNeeded = "areaNeeded";
enum XNSpotLocation = "spotLocation";
enum XNColormap = "colorMap";
enum XNStdColormap = "stdColorMap";
enum XNForeground = "foreground";
enum XNBackground = "background";
enum XNBackgroundPixmap = "backgroundPixmap";
enum XNFontSet = "fontSet";
enum XNLineSpace = "lineSpace";
enum XNCursor = "cursor";
enum XNQueryIMValuesList = "queryIMValuesList";
enum XNQueryICValuesList = "queryICValuesList";
enum XNVisiblePosition = "visiblePosition";
enum XNR6PreeditCallback = "r6PreeditCallback";
enum XNStringConversionCallback = "stringConversionCallback";
enum XNStringConversion = "stringConversion";
enum XNResetState = "resetState";
enum XNHotKey = "hotKey";
enum XNHotKeyState = "hotKeyState";
enum XNPreeditState = "preeditState";
enum XNSeparatorofNestedList = "separatorofNestedList";
enum XBufferOverflow = -1;
enum XLookupNone = 1;
enum XLookupChars = 2;
enum XLookupKeySym = 3;
enum XLookupBoth = 4;
enum XIMReverse = 1L;
enum XIMUnderline = 1L << 1;
enum XIMHighlight = 1L << 2;
enum XIMPrimary = 1L << 5;
enum XIMSecondary = 1L << 6;
enum XIMTertiary = 1L << 7;
enum XIMVisibleToForward = 1L << 8;
enum XIMVisibleToBackword = 1L << 9;
enum XIMVisibleToCenter = 1L << 10;
enum XIMPreeditUnKnown = 0L;
enum XIMPreeditEnable = 1L;
enum XIMPreeditDisable = 1L << 1;
enum XIMInitialState = 1L;
enum XIMPreserveState = 1L << 1;
enum XIMStringConversionLeftEdge = 0x00000001;
enum XIMStringConversionRightEdge = 0x00000002;
enum XIMStringConversionTopEdge = 0x00000004;
enum XIMStringConversionBottomEdge = 0x00000008;
enum XIMStringConversionConcealed = 0x00000010;
enum XIMStringConversionWrapped = 0x00000020;
enum XIMStringConversionBuffer = 0x0001;
enum XIMStringConversionLine = 0x0002;
enum XIMStringConversionWord = 0x0003;
enum XIMStringConversionChar = 0x0004;
enum XIMStringConversionSubstitution = 0x0001;
enum XIMStringConversionRetrieval = 0x0002;
enum XIMHotKeyStateON = 0x0001L;
enum XIMHotKeyStateOFF = 0x0002L;
struct XExtData {
	int number;
	XExtData* next;
	int function(XExtData* extension) free_private;
	XPointer private_data;
}

struct XExtCodes {
	int extension;
	int major_opcode;
	int first_event;
	int first_error;
}

struct XPixmapFormatValues {
	int depth;
	int bits_per_pixel;
	int scanline_pad;
}

struct XGCValues {
	int function_;
	c_ulong plane_mask;
	c_ulong foreground;
	c_ulong background;
	int line_width;
	int line_style;
	int cap_style;
	int join_style;
	int fill_style;
	int fill_rule;
	int arc_mode;
	Pixmap tile;
	Pixmap stipple;
	int ts_x_origin;
	int ts_y_origin;
	Font font;
	int subwindow_mode;
	int graphics_exposures;
	int clip_x_origin;
	int clip_y_origin;
	Pixmap clip_mask;
	int dash_offset;
	char dashes;
}
private struct PrivateXGC;
struct Visual {
	XExtData* ext_data;
	VisualID visualid;
	int class_;
	c_ulong red_mask;
	c_ulong green_mask;
	c_ulong blue_mask;
	int bits_per_rgb;
	int map_entries;
}

struct Depth {
	int depth;
	int nvisuals;
	Visual* visuals;
}

struct PrivateXDisplay;
struct Screen {
	XExtData* ext_data;
	PrivateXDisplay* display;
	Window root;
	int width;
	int height;
	int mwidth;
	int mheight;
	int ndepths;
	Depth* depths;
	int root_depth;
	Visual* root_visual;
	GC default_gc;
	Colormap cmap;
	c_ulong white_pixel;
	c_ulong black_pixel;
	int max_maps;
	int min_maps;
	int backing_store;
	int save_unders;
	c_long root_input_mask;
}

struct ScreenFormat {
	XExtData* ext_data;
	int depth;
	int bits_per_pixel;
	int scanline_pad;
}

struct XSetWindowAttributes {
	Pixmap background_pixmap;
	c_ulong background_pixel;
	Pixmap border_pixmap;
	c_ulong border_pixel;
	int bit_gravity;
	int win_gravity;
	int backing_store;
	c_ulong backing_planes;
	c_ulong backing_pixel;
	int save_under;
	c_long event_mask;
	c_long do_not_propagate_mask;
	int override_redirect;
	Colormap colormap;
	Cursor cursor;
}

struct XWindowAttributes {
	int x;
	int y;
	int width;
	int height;
	int border_width;
	int depth;
	Visual* visual;
	Window root;
	int class_;
	int bit_gravity;
	int win_gravity;
	int backing_store;
	c_ulong backing_planes;
	c_ulong backing_pixel;
	int save_under;
	Colormap colormap;
	int map_installed;
	int map_state;
	c_long all_event_masks;
	c_long your_event_mask;
	c_long do_not_propagate_mask;
	int override_redirect;
	Screen* screen;
}

struct XHostAddress {
	int family;
	int length;
	char* address;
}

struct XServerInterpretedAddress {
	int typelength;
	int valuelength;
	char* type;
	char* value;
}

struct XImage {
	int width;
	int height;
	int xoffset;
	int format;
	char* data;
	int byte_order;
	int bitmap_unit;
	int bitmap_bit_order;
	int bitmap_pad;
	int depth;
	int bytes_per_line;
	int bits_per_pixel;
	c_ulong red_mask;
	c_ulong green_mask;
	c_ulong blue_mask;
	XPointer obdata;
	struct Funcs {
		XImage* function(PrivateXDisplay*, Visual*, uint, int, int, char*, uint, uint, int, int) create_image;
		int function(XImage*) destroy_image;
		c_ulong function(XImage*, int, int) get_pixel;
		int function(XImage*, int, int, c_ulong) put_pixel;
		XImage* function(XImage*, int, int, uint, uint) sub_image;
		int function(XImage*, c_long) add_pixel;
	}
	Funcs f;
}

struct XWindowChanges {
	int x;
	int y;
	int width;
	int height;
	int border_width;
	Window sibling;
	int stack_mode;
}

struct XColor {
	c_ulong pixel;
	ushort red;
	ushort green;
	ushort blue;
	char flags;
	char pad;
}

struct XSegment {
	short x1;
	short y1;
	short x2;
	short y2;
}

struct XPoint {
	short x;
	short y;
}

struct XRectangle {
	short x;
	short y;
	ushort width;
	ushort height;
}

struct XArc {
	short x;
	short y;
	ushort width;
	ushort height;
	short angle1;
	short angle2;
}

struct XKeyboardControl {
	int key_click_percent;
	int bell_percent;
	int bell_pitch;
	int bell_duration;
	int led;
	int led_mode;
	int key;
	int auto_repeat_mode;
}

struct XKeyboardState {
	int key_click_percent;
	int bell_percent;
	uint bell_pitch;
	uint bell_duration;
	c_ulong led_mask;
	int global_auto_repeat;
	char[32] auto_repeats;
}

struct XTimeCoord {
	Time time;
	short x;
	short y;
}

struct XModifierKeymap {
	int max_keypermod;
	KeyCode* modifiermap;
}

struct PrivateXPrivate;
struct PrivateXrmHashBucketRec;
struct PrivateXPrivDisplay {
	XExtData* ext_data;
	PrivateXPrivate* private1;
	int fd;
	int private2;
	int proto_major_version;
	int proto_minor_version;
	char* vendor;
	XID private3;
	XID private4;
	XID private5;
	int private6;
	XID function(PrivateXDisplay*) resource_alloc;
	int byte_order;
	int bitmap_unit;
	int bitmap_pad;
	int bitmap_bit_order;
	int nformats;
	ScreenFormat* pixmap_format;
	int private8;
	int release;
	PrivateXPrivate* private9;
	PrivateXPrivate* private10;
	int qlen;
	c_ulong last_request_read;
	c_ulong request;
	XPointer private11;
	XPointer private12;
	XPointer private13;
	XPointer private14;
	uint max_request_size;
	PrivateXrmHashBucketRec* db;
	int function(PrivateXDisplay*) private15;
	char* display_name;
	int default_screen;
	int nscreens;
	Screen* screens;
	c_ulong motion_buffer;
	c_ulong private16;
	int min_keycode;
	int max_keycode;
	XPointer private17;
	XPointer private18;
	int private19;
	char* xdefaults;
}

struct XKeyEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	Window root;
	Window subwindow;
	Time time;
	int x;
	int y;
	int x_root;
	int y_root;
	uint state;
	uint keycode;
	int same_screen;
}

struct XButtonEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	Window root;
	Window subwindow;
	Time time;
	int x;
	int y;
	int x_root;
	int y_root;
	uint state;
	uint button;
	int same_screen;
}

struct XMotionEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	Window root;
	Window subwindow;
	Time time;
	int x;
	int y;
	int x_root;
	int y_root;
	uint state;
	char is_hint;
	int same_screen;
}

struct XCrossingEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	Window root;
	Window subwindow;
	Time time;
	int x;
	int y;
	int x_root;
	int y_root;
	int mode;
	int detail;
	int same_screen;
	int focus;
	uint state;
}

struct XFocusChangeEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	int mode;
	int detail;
}

struct XKeymapEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	char[32] key_vector;
}

struct XExposeEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	int x;
	int y;
	int width;
	int height;
	int count;
}

struct XGraphicsExposeEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Drawable drawable;
	int x;
	int y;
	int width;
	int height;
	int count;
	int major_code;
	int minor_code;
}

struct XNoExposeEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Drawable drawable;
	int major_code;
	int minor_code;
}

struct XVisibilityEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	int state;
}

struct XCreateWindowEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window parent;
	Window window;
	int x;
	int y;
	int width;
	int height;
	int border_width;
	int override_redirect;
}

struct XDestroyWindowEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window event;
	Window window;
}

struct XUnmapEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window event;
	Window window;
	int from_configure;
}

struct XMapEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window event;
	Window window;
	int override_redirect;
}

struct XMapRequestEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window parent;
	Window window;
}

struct XReparentEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window event;
	Window window;
	Window parent;
	int x;
	int y;
	int override_redirect;
}

struct XConfigureEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window event;
	Window window;
	int x;
	int y;
	int width;
	int height;
	int border_width;
	Window above;
	int override_redirect;
}

struct XGravityEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window event;
	Window window;
	int x;
	int y;
}

struct XResizeRequestEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	int width;
	int height;
}

struct XConfigureRequestEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window parent;
	Window window;
	int x;
	int y;
	int width;
	int height;
	int border_width;
	Window above;
	int detail;
	c_ulong value_mask;
}

struct XCirculateEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window event;
	Window window;
	int place;
}

struct XCirculateRequestEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window parent;
	Window window;
	int place;
}

struct XPropertyEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	Atom atom;
	Time time;
	int state;
}

struct XSelectionClearEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	Atom selection;
	Time time;
}

struct XSelectionRequestEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window owner;
	Window requestor;
	Atom selection;
	Atom target;
	Atom property;
	Time time;
}

struct XSelectionEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window requestor;
	Atom selection;
	Atom target;
	Atom property;
	Time time;
}

struct XColormapEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	Colormap colormap;
	int new_;
	int state;
}

struct XClientMessageEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	Atom message_type;
	int format;
	union _Anonymous_0 {
		char[20] b;
		short[10] s;
		c_long[5] l;
	}
	_Anonymous_0 data;
}

struct XMappingEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
	int request;
	int first_keycode;
	int count;
}

struct XErrorEvent {
	int type;
	Display* display;
	XID resourceid;
	c_ulong serial;
	ubyte error_code;
	ubyte request_code;
	ubyte minor_code;
}

struct XAnyEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	Window window;
}

struct XGenericEvent {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	int extension;
	int evtype;
}

struct XGenericEventCookie {
	int type;
	c_ulong serial;
	int send_event;
	Display* display;
	int extension;
	int evtype;
	uint cookie;
	void* data;
}
union XEvent {
	int type;
	XAnyEvent xany;
	XKeyEvent xkey;
	XButtonEvent xbutton;
	XMotionEvent xmotion;
	XCrossingEvent xcrossing;
	XFocusChangeEvent xfocus;
	XExposeEvent xexpose;
	XGraphicsExposeEvent xgraphicsexpose;
	XNoExposeEvent xnoexpose;
	XVisibilityEvent xvisibility;
	XCreateWindowEvent xcreatewindow;
	XDestroyWindowEvent xdestroywindow;
	XUnmapEvent xunmap;
	XMapEvent xmap;
	XMapRequestEvent xmaprequest;
	XReparentEvent xreparent;
	XConfigureEvent xconfigure;
	XGravityEvent xgravity;
	XResizeRequestEvent xresizerequest;
	XConfigureRequestEvent xconfigurerequest;
	XCirculateEvent xcirculate;
	XCirculateRequestEvent xcirculaterequest;
	XPropertyEvent xproperty;
	XSelectionClearEvent xselectionclear;
	XSelectionRequestEvent xselectionrequest;
	XSelectionEvent xselection;
	XColormapEvent xcolormap;
	XClientMessageEvent xclient;
	XMappingEvent xmapping;
	XErrorEvent xerror;
	XKeymapEvent xkeymap;
	XGenericEvent xgeneric;
	XGenericEventCookie xcookie;
	c_long[24] pad;
}

struct XCharStruct {
	short lbearing;
	short rbearing;
	short width;
	short ascent;
	short descent;
	ushort attributes;
}

struct XFontProp {
	Atom name;
	c_ulong card32;
}

struct XFontStruct {
	XExtData* ext_data;
	Font fid;
	uint direction;
	uint min_char_or_byte2;
	uint max_char_or_byte2;
	uint min_byte1;
	uint max_byte1;
	int all_chars_exist;
	uint default_char;
	int n_properties;
	XFontProp* properties;
	XCharStruct min_bounds;
	XCharStruct max_bounds;
	XCharStruct* per_char;
	int ascent;
	int descent;
}

struct XTextItem {
	char* chars;
	int nchars;
	int delta;
	Font font;
}

struct XChar2b {
	ubyte byte1;
	ubyte byte2;
}

struct XTextItem16 {
	XChar2b* chars;
	int nchars;
	int delta;
	Font font;
}
union XEDataObject {
	Display* display;
	GC gc;
	Visual* visual;
	Screen* screen;
	ScreenFormat* pixmap_format;
	XFontStruct* font;
}

struct XFontSetExtents {
	XRectangle max_ink_extent;
	XRectangle max_logical_extent;
}

struct PrivateXOM;
struct PrivateXOC;
struct XmbTextItem {
	char* chars;
	int nchars;
	int delta;
	XFontSet font_set;
}

struct XwcTextItem {
	wchar_t* chars;
	int nchars;
	int delta;
	XFontSet font_set;
}

struct XOMCharSetList {
	int charset_count;
	char** charset_list;
}

struct XOMOrientation {
	int num_orientation;
	XOrientation* orientation;
}

struct XOMFontInfo {
	int num_font;
	XFontStruct** font_struct_list;
	char** font_name_list;
}

struct PrivateXIM;
struct PrivateXIC;
struct XIMStyles {
	ushort count_styles;
	XIMStyle* supported_styles;
}

struct XIMCallback {
	XPointer client_data;
	XIMProc callback;
}

struct XICCallback {
	XPointer client_data;
	XICProc callback;
}

struct XIMText {
	ushort length;
	XIMFeedback* feedback;
	int encoding_is_wchar;
	union _Anonymous_1 {
		char* multi_byte;
		wchar_t* wide_char;
	}
	_Anonymous_1 string;
}

struct XIMPreeditStateNotifyCallbackStruct {
	XIMPreeditState state;
}

struct XIMStringConversionText {
	ushort length;
	XIMStringConversionFeedback* feedback;
	int encoding_is_wchar;
	union _Anonymous_2 {
		char* mbs;
		wchar_t* wcs;
	}
	_Anonymous_2 string;
}

struct XIMStringConversionCallbackStruct {
	XIMStringConversionPosition position;
	XIMCaretDirection direction;
	XIMStringConversionOperation operation;
	ushort factor;
	XIMStringConversionText* text;
}

struct XIMPreeditDrawCallbackStruct {
	int caret;
	int chg_first;
	int chg_length;
	XIMText* text;
}

struct XIMPreeditCaretCallbackStruct {
	int position;
	XIMCaretDirection direction;
	XIMCaretStyle style;
}

struct XIMStatusDrawCallbackStruct {
	XIMStatusDataType type;
	union _Anonymous_3 {
		XIMText* text;
		Pixmap bitmap;
	}
	_Anonymous_3 data;
}

struct XIMHotKeyTrigger {
	KeySym keysym;
	int modifier;
	int modifier_mask;
}

struct XIMHotKeyTriggers {
	int num_hot_key;
	XIMHotKeyTrigger* key;
}

struct XIMValuesList {
	ushort count_values;
	char** supported_values;
}

alias Region = PrivateXRegion*;
alias XContext = int;
enum NoValue = 0x0000;
enum XValue = 0x0001;
enum YValue = 0x0002;
enum WidthValue = 0x0004;
enum HeightValue = 0x0008;
enum AllValues = 0x000F;
enum XNegative = 0x0010;
enum YNegative = 0x0020;
enum USPosition = 1L << 0;
enum USSize = 1L << 1;
enum PPosition = 1L << 2;
enum PSize = 1L << 3;
enum PMinSize = 1L << 4;
enum PMaxSize = 1L << 5;
enum PResizeInc = 1L << 6;
enum PAspect = 1L << 7;
enum PBaseSize = 1L << 8;
enum PWinGravity = 1L << 9;
enum PAllHints = PPosition | PSize | PMinSize | PMaxSize | PResizeInc | PAspect;
enum InputHint = 1L << 0;
enum StateHint = 1L << 1;
enum IconPixmapHint = 1L << 2;
enum IconWindowHint = 1L << 3;
enum IconPositionHint = 1L << 4;
enum IconMaskHint = 1L << 5;
enum WindowGroupHint = 1L << 6;
enum AllHints = InputHint | StateHint | IconPixmapHint
	| IconWindowHint | IconPositionHint | IconMaskHint | WindowGroupHint;
enum XUrgencyHint = 1L << 8;
enum WithdrawnState = 0;
enum NormalState = 1;
enum IconicState = 3;
enum DontCareState = 0;
enum ZoomState = 2;
enum InactiveState = 4;
enum XNoMemory = -1;
enum XLocaleNotSupported = -2;
enum XConverterNotFound = -3;
enum XICCEncodingStyle {
	XStringStyle = 0,
	XCompoundTextStyle = 1,
	XTextStyle = 2,
	XStdICCTextStyle = 3,
	XUTF8StringStyle = 4
}
enum RectangleOut = 0;
enum RectangleIn = 1;
enum RectanglePart = 2;
enum VisualNoMask = 0x0;
enum VisualIDMask = 0x1;
enum VisualScreenMask = 0x2;
enum VisualDepthMask = 0x4;
enum VisualClassMask = 0x8;
enum VisualRedMaskMask = 0x10;
enum VisualGreenMaskMask = 0x20;
enum VisualBlueMaskMask = 0x40;
enum VisualColormapSizeMask = 0x80;
enum VisualBitsPerRGBMask = 0x100;
enum VisualAllMask = 0x1FF;
enum ReleaseByFreeingColormap = cast(XID) 1L;
enum BitmapSuccess = 0;
enum BitmapOpenFailed = 1;
enum BitmapFileInvalid = 2;
enum BitmapNoMemory = 3;
enum XCSUCCESS = 0;
enum XCNOMEM = 1;
enum XCNOENT = 2;
struct XSizeHints {
	c_long flags;
	int x;
	int y;
	int width;
	int height;
	int min_width;
	int min_height;
	int max_width;
	int max_height;
	int width_inc;
	int height_inc;
	struct Anonymous0 {
		int x;
		int y;
	}
	Anonymous0 min_aspect;
	Anonymous0 max_aspect;
	int base_width;
	int base_height;
	int win_gravity;
}
struct XWMHints {
	c_long flags;
	int input;
	int initial_state;
	Pixmap icon_pixmap;
	Window icon_window;
	int icon_x;
	int icon_y;
	Pixmap icon_mask;
	XID window_group;
}
struct XTextProperty {
	ubyte* value;
	Atom encoding;
	int format;
	c_ulong nitems;
}
struct XIconSize {
	int min_width;
	int min_height;
	int max_width;
	int max_height;
	int width_inc;
	int height_inc;
}
struct XClassHint {
	char* res_name;
	char* res_class;
}
struct XComposeStatus {
	XPointer compose_ptr;
	int chars_matched;
}
struct PrivateXRegion;
struct XVisualInfo {
	Visual* visual;
	VisualID visualid;
	int screen;
	int depth;
	int class_;
	c_ulong red_mask;
	c_ulong green_mask;
	c_ulong blue_mask;
	int colormap_size;
	int bits_per_rgb;
}
struct XStandardColormap {
	Colormap colormap;
	c_ulong red_max;
	c_ulong red_mult;
	c_ulong green_max;
	c_ulong green_mult;
	c_ulong blue_max;
	c_ulong blue_mult;
	c_ulong base_pixel;
	VisualID visualid;
	XID killid;
}

enum KeySym : c_ulong {
	XK_VoidSymbol = 0xffffff,
	XK_BackSpace = 0xff08,
	XK_Tab = 0xff09,
	XK_Linefeed = 0xff0a,
	XK_Clear = 0xff0b,
	XK_Return = 0xff0d,
	XK_Pause = 0xff13,
	XK_Scroll_Lock = 0xff14,
	XK_Sys_Req = 0xff15,
	XK_Escape = 0xff1b,
	XK_Delete = 0xffff,
	XK_Multi_key = 0xff20,
	XK_Codeinput = 0xff37,
	XK_SingleCandidate = 0xff3c,
	XK_MultipleCandidate = 0xff3d,
	XK_PreviousCandidate = 0xff3e,
	XK_Kanji = 0xff21,
	XK_Muhenkan = 0xff22,
	XK_Henkan_Mode = 0xff23,
	XK_Henkan = 0xff23,
	XK_Romaji = 0xff24,
	XK_Hiragana = 0xff25,
	XK_Katakana = 0xff26,
	XK_Hiragana_Katakana = 0xff27,
	XK_Zenkaku = 0xff28,
	XK_Hankaku = 0xff29,
	XK_Zenkaku_Hankaku = 0xff2a,
	XK_Touroku = 0xff2b,
	XK_Massyo = 0xff2c,
	XK_Kana_Lock = 0xff2d,
	XK_Kana_Shift = 0xff2e,
	XK_Eisu_Shift = 0xff2f,
	XK_Eisu_toggle = 0xff30,
	XK_Kanji_Bangou = 0xff37,
	XK_Zen_Koho = 0xff3d,
	XK_Mae_Koho = 0xff3e,
	XK_Home = 0xff50,
	XK_Left = 0xff51,
	XK_Up = 0xff52,
	XK_Right = 0xff53,
	XK_Down = 0xff54,
	XK_Prior = 0xff55,
	XK_Page_Up = 0xff55,
	XK_Next = 0xff56,
	XK_Page_Down = 0xff56,
	XK_End = 0xff57,
	XK_Begin = 0xff58,
	XK_Select = 0xff60,
	XK_Print = 0xff61,
	XK_Execute = 0xff62,
	XK_Insert = 0xff63,
	XK_Undo = 0xff65,
	XK_Redo = 0xff66,
	XK_Menu = 0xff67,
	XK_Find = 0xff68,
	XK_Cancel = 0xff69,
	XK_Help = 0xff6a,
	XK_Break = 0xff6b,
	XK_Mode_switch = 0xff7e,
	XK_script_switch = 0xff7e,
	XK_Num_Lock = 0xff7f,
	XK_KP_Space = 0xff80,
	XK_KP_Tab = 0xff89,
	XK_KP_Enter = 0xff8d,
	XK_KP_F1 = 0xff91,
	XK_KP_F2 = 0xff92,
	XK_KP_F3 = 0xff93,
	XK_KP_F4 = 0xff94,
	XK_KP_Home = 0xff95,
	XK_KP_Left = 0xff96,
	XK_KP_Up = 0xff97,
	XK_KP_Right = 0xff98,
	XK_KP_Down = 0xff99,
	XK_KP_Prior = 0xff9a,
	XK_KP_Page_Up = 0xff9a,
	XK_KP_Next = 0xff9b,
	XK_KP_Page_Down = 0xff9b,
	XK_KP_End = 0xff9c,
	XK_KP_Begin = 0xff9d,
	XK_KP_Insert = 0xff9e,
	XK_KP_Delete = 0xff9f,
	XK_KP_Equal = 0xffbd,
	XK_KP_Multiply = 0xffaa,
	XK_KP_Add = 0xffab,
	XK_KP_Separator = 0xffac,
	XK_KP_Subtract = 0xffad,
	XK_KP_Decimal = 0xffae,
	XK_KP_Divide = 0xffaf,
	XK_KP_0 = 0xffb0,
	XK_KP_1 = 0xffb1,
	XK_KP_2 = 0xffb2,
	XK_KP_3 = 0xffb3,
	XK_KP_4 = 0xffb4,
	XK_KP_5 = 0xffb5,
	XK_KP_6 = 0xffb6,
	XK_KP_7 = 0xffb7,
	XK_KP_8 = 0xffb8,
	XK_KP_9 = 0xffb9,
	XK_F1 = 0xffbe,
	XK_F2 = 0xffbf,
	XK_F3 = 0xffc0,
	XK_F4 = 0xffc1,
	XK_F5 = 0xffc2,
	XK_F6 = 0xffc3,
	XK_F7 = 0xffc4,
	XK_F8 = 0xffc5,
	XK_F9 = 0xffc6,
	XK_F10 = 0xffc7,
	XK_F11 = 0xffc8,
	XK_L1 = 0xffc8,
	XK_F12 = 0xffc9,
	XK_L2 = 0xffc9,
	XK_F13 = 0xffca,
	XK_L3 = 0xffca,
	XK_F14 = 0xffcb,
	XK_L4 = 0xffcb,
	XK_F15 = 0xffcc,
	XK_L5 = 0xffcc,
	XK_F16 = 0xffcd,
	XK_L6 = 0xffcd,
	XK_F17 = 0xffce,
	XK_L7 = 0xffce,
	XK_F18 = 0xffcf,
	XK_L8 = 0xffcf,
	XK_F19 = 0xffd0,
	XK_L9 = 0xffd0,
	XK_F20 = 0xffd1,
	XK_L10 = 0xffd1,
	XK_F21 = 0xffd2,
	XK_R1 = 0xffd2,
	XK_F22 = 0xffd3,
	XK_R2 = 0xffd3,
	XK_F23 = 0xffd4,
	XK_R3 = 0xffd4,
	XK_F24 = 0xffd5,
	XK_R4 = 0xffd5,
	XK_F25 = 0xffd6,
	XK_R5 = 0xffd6,
	XK_F26 = 0xffd7,
	XK_R6 = 0xffd7,
	XK_F27 = 0xffd8,
	XK_R7 = 0xffd8,
	XK_F28 = 0xffd9,
	XK_R8 = 0xffd9,
	XK_F29 = 0xffda,
	XK_R9 = 0xffda,
	XK_F30 = 0xffdb,
	XK_R10 = 0xffdb,
	XK_F31 = 0xffdc,
	XK_R11 = 0xffdc,
	XK_F32 = 0xffdd,
	XK_R12 = 0xffdd,
	XK_F33 = 0xffde,
	XK_R13 = 0xffde,
	XK_F34 = 0xffdf,
	XK_R14 = 0xffdf,
	XK_F35 = 0xffe0,
	XK_R15 = 0xffe0,
	XK_Shift_L = 0xffe1,
	XK_Shift_R = 0xffe2,
	XK_Control_L = 0xffe3,
	XK_Control_R = 0xffe4,
	XK_Caps_Lock = 0xffe5,
	XK_Shift_Lock = 0xffe6,
	XK_Meta_L = 0xffe7,
	XK_Meta_R = 0xffe8,
	XK_Alt_L = 0xffe9,
	XK_Alt_R = 0xffea,
	XK_Super_L = 0xffeb,
	XK_Super_R = 0xffec,
	XK_Hyper_L = 0xffed,
	XK_Hyper_R = 0xffee,
	XK_ISO_Lock = 0xfe01,
	XK_ISO_Level2_Latch = 0xfe02,
	XK_ISO_Level3_Shift = 0xfe03,
	XK_ISO_Level3_Latch = 0xfe04,
	XK_ISO_Level3_Lock = 0xfe05,
	XK_ISO_Level5_Shift = 0xfe11,
	XK_ISO_Level5_Latch = 0xfe12,
	XK_ISO_Level5_Lock = 0xfe13,
	XK_ISO_Group_Shift = 0xff7e,
	XK_ISO_Group_Latch = 0xfe06,
	XK_ISO_Group_Lock = 0xfe07,
	XK_ISO_Next_Group = 0xfe08,
	XK_ISO_Next_Group_Lock = 0xfe09,
	XK_ISO_Prev_Group = 0xfe0a,
	XK_ISO_Prev_Group_Lock = 0xfe0b,
	XK_ISO_First_Group = 0xfe0c,
	XK_ISO_First_Group_Lock = 0xfe0d,
	XK_ISO_Last_Group = 0xfe0e,
	XK_ISO_Last_Group_Lock = 0xfe0f,
	XK_ISO_Left_Tab = 0xfe20,
	XK_ISO_Move_Line_Up = 0xfe21,
	XK_ISO_Move_Line_Down = 0xfe22,
	XK_ISO_Partial_Line_Up = 0xfe23,
	XK_ISO_Partial_Line_Down = 0xfe24,
	XK_ISO_Partial_Space_Left = 0xfe25,
	XK_ISO_Partial_Space_Right = 0xfe26,
	XK_ISO_Set_Margin_Left = 0xfe27,
	XK_ISO_Set_Margin_Right = 0xfe28,
	XK_ISO_Release_Margin_Left = 0xfe29,
	XK_ISO_Release_Margin_Right = 0xfe2a,
	XK_ISO_Release_Both_Margins = 0xfe2b,
	XK_ISO_Fast_Cursor_Left = 0xfe2c,
	XK_ISO_Fast_Cursor_Right = 0xfe2d,
	XK_ISO_Fast_Cursor_Up = 0xfe2e,
	XK_ISO_Fast_Cursor_Down = 0xfe2f,
	XK_ISO_Continuous_Underline = 0xfe30,
	XK_ISO_Discontinuous_Underline = 0xfe31,
	XK_ISO_Emphasize = 0xfe32,
	XK_ISO_Center_Object = 0xfe33,
	XK_ISO_Enter = 0xfe34,
	XK_dead_grave = 0xfe50,
	XK_dead_acute = 0xfe51,
	XK_dead_circumflex = 0xfe52,
	XK_dead_tilde = 0xfe53,
	XK_dead_perispomeni = 0xfe53,
	XK_dead_macron = 0xfe54,
	XK_dead_breve = 0xfe55,
	XK_dead_abovedot = 0xfe56,
	XK_dead_diaeresis = 0xfe57,
	XK_dead_abovering = 0xfe58,
	XK_dead_doubleacute = 0xfe59,
	XK_dead_caron = 0xfe5a,
	XK_dead_cedilla = 0xfe5b,
	XK_dead_ogonek = 0xfe5c,
	XK_dead_iota = 0xfe5d,
	XK_dead_voiced_sound = 0xfe5e,
	XK_dead_semivoiced_sound = 0xfe5f,
	XK_dead_belowdot = 0xfe60,
	XK_dead_hook = 0xfe61,
	XK_dead_horn = 0xfe62,
	XK_dead_stroke = 0xfe63,
	XK_dead_abovecomma = 0xfe64,
	XK_dead_psili = 0xfe64,
	XK_dead_abovereversedcomma = 0xfe65,
	XK_dead_dasia = 0xfe65,
	XK_dead_doublegrave = 0xfe66,
	XK_dead_belowring = 0xfe67,
	XK_dead_belowmacron = 0xfe68,
	XK_dead_belowcircumflex = 0xfe69,
	XK_dead_belowtilde = 0xfe6a,
	XK_dead_belowbreve = 0xfe6b,
	XK_dead_belowdiaeresis = 0xfe6c,
	XK_dead_invertedbreve = 0xfe6d,
	XK_dead_belowcomma = 0xfe6e,
	XK_dead_currency = 0xfe6f,
	XK_dead_lowline = 0xfe90,
	XK_dead_aboveverticalline = 0xfe91,
	XK_dead_belowverticalline = 0xfe92,
	XK_dead_longsolidusoverlay = 0xfe93,
	XK_dead_a = 0xfe80,
	XK_dead_A = 0xfe81,
	XK_dead_e = 0xfe82,
	XK_dead_E = 0xfe83,
	XK_dead_i = 0xfe84,
	XK_dead_I = 0xfe85,
	XK_dead_o = 0xfe86,
	XK_dead_O = 0xfe87,
	XK_dead_u = 0xfe88,
	XK_dead_U = 0xfe89,
	XK_dead_small_schwa = 0xfe8a,
	XK_dead_capital_schwa = 0xfe8b,
	XK_dead_greek = 0xfe8c,
	XK_First_Virtual_Screen = 0xfed0,
	XK_Prev_Virtual_Screen = 0xfed1,
	XK_Next_Virtual_Screen = 0xfed2,
	XK_Last_Virtual_Screen = 0xfed4,
	XK_Terminate_Server = 0xfed5,
	XK_AccessX_Enable = 0xfe70,
	XK_AccessX_Feedback_Enable = 0xfe71,
	XK_RepeatKeys_Enable = 0xfe72,
	XK_SlowKeys_Enable = 0xfe73,
	XK_BounceKeys_Enable = 0xfe74,
	XK_StickyKeys_Enable = 0xfe75,
	XK_MouseKeys_Enable = 0xfe76,
	XK_MouseKeys_Accel_Enable = 0xfe77,
	XK_Overlay1_Enable = 0xfe78,
	XK_Overlay2_Enable = 0xfe79,
	XK_AudibleBell_Enable = 0xfe7a,
	XK_Pointer_Left = 0xfee0,
	XK_Pointer_Right = 0xfee1,
	XK_Pointer_Up = 0xfee2,
	XK_Pointer_Down = 0xfee3,
	XK_Pointer_UpLeft = 0xfee4,
	XK_Pointer_UpRight = 0xfee5,
	XK_Pointer_DownLeft = 0xfee6,
	XK_Pointer_DownRight = 0xfee7,
	XK_Pointer_Button_Dflt = 0xfee8,
	XK_Pointer_Button1 = 0xfee9,
	XK_Pointer_Button2 = 0xfeea,
	XK_Pointer_Button3 = 0xfeeb,
	XK_Pointer_Button4 = 0xfeec,
	XK_Pointer_Button5 = 0xfeed,
	XK_Pointer_DblClick_Dflt = 0xfeee,
	XK_Pointer_DblClick1 = 0xfeef,
	XK_Pointer_DblClick2 = 0xfef0,
	XK_Pointer_DblClick3 = 0xfef1,
	XK_Pointer_DblClick4 = 0xfef2,
	XK_Pointer_DblClick5 = 0xfef3,
	XK_Pointer_Drag_Dflt = 0xfef4,
	XK_Pointer_Drag1 = 0xfef5,
	XK_Pointer_Drag2 = 0xfef6,
	XK_Pointer_Drag3 = 0xfef7,
	XK_Pointer_Drag4 = 0xfef8,
	XK_Pointer_Drag5 = 0xfefd,
	XK_Pointer_EnableKeys = 0xfef9,
	XK_Pointer_Accelerate = 0xfefa,
	XK_Pointer_DfltBtnNext = 0xfefb,
	XK_Pointer_DfltBtnPrev = 0xfefc,
	XK_ch = 0xfea0,
	XK_Ch = 0xfea1,
	XK_CH = 0xfea2,
	XK_c_h = 0xfea3,
	XK_C_h = 0xfea4,
	XK_C_H = 0xfea5,
	XK_3270_Duplicate = 0xfd01,
	XK_3270_FieldMark = 0xfd02,
	XK_3270_Right2 = 0xfd03,
	XK_3270_Left2 = 0xfd04,
	XK_3270_BackTab = 0xfd05,
	XK_3270_EraseEOF = 0xfd06,
	XK_3270_EraseInput = 0xfd07,
	XK_3270_Reset = 0xfd08,
	XK_3270_Quit = 0xfd09,
	XK_3270_PA1 = 0xfd0a,
	XK_3270_PA2 = 0xfd0b,
	XK_3270_PA3 = 0xfd0c,
	XK_3270_Test = 0xfd0d,
	XK_3270_Attn = 0xfd0e,
	XK_3270_CursorBlink = 0xfd0f,
	XK_3270_AltCursor = 0xfd10,
	XK_3270_KeyClick = 0xfd11,
	XK_3270_Jump = 0xfd12,
	XK_3270_Ident = 0xfd13,
	XK_3270_Rule = 0xfd14,
	XK_3270_Copy = 0xfd15,
	XK_3270_Play = 0xfd16,
	XK_3270_Setup = 0xfd17,
	XK_3270_Record = 0xfd18,
	XK_3270_ChangeScreen = 0xfd19,
	XK_3270_DeleteWord = 0xfd1a,
	XK_3270_ExSelect = 0xfd1b,
	XK_3270_CursorSelect = 0xfd1c,
	XK_3270_PrintScreen = 0xfd1d,
	XK_3270_Enter = 0xfd1e,
	XK_space = 0x0020,
	XK_exclam = 0x0021,
	XK_quotedbl = 0x0022,
	XK_numbersign = 0x0023,
	XK_dollar = 0x0024,
	XK_percent = 0x0025,
	XK_ampersand = 0x0026,
	XK_apostrophe = 0x0027,
	XK_quoteright = 0x0027,
	XK_parenleft = 0x0028,
	XK_parenright = 0x0029,
	XK_asterisk = 0x002a,
	XK_plus = 0x002b,
	XK_comma = 0x002c,
	XK_minus = 0x002d,
	XK_period = 0x002e,
	XK_slash = 0x002f,
	XK_0 = 0x0030,
	XK_1 = 0x0031,
	XK_2 = 0x0032,
	XK_3 = 0x0033,
	XK_4 = 0x0034,
	XK_5 = 0x0035,
	XK_6 = 0x0036,
	XK_7 = 0x0037,
	XK_8 = 0x0038,
	XK_9 = 0x0039,
	XK_colon = 0x003a,
	XK_semicolon = 0x003b,
	XK_less = 0x003c,
	XK_equal = 0x003d,
	XK_greater = 0x003e,
	XK_question = 0x003f,
	XK_at = 0x0040,
	XK_A = 0x0041,
	XK_B = 0x0042,
	XK_C = 0x0043,
	XK_D = 0x0044,
	XK_E = 0x0045,
	XK_F = 0x0046,
	XK_G = 0x0047,
	XK_H = 0x0048,
	XK_I = 0x0049,
	XK_J = 0x004a,
	XK_K = 0x004b,
	XK_L = 0x004c,
	XK_M = 0x004d,
	XK_N = 0x004e,
	XK_O = 0x004f,
	XK_P = 0x0050,
	XK_Q = 0x0051,
	XK_R = 0x0052,
	XK_S = 0x0053,
	XK_T = 0x0054,
	XK_U = 0x0055,
	XK_V = 0x0056,
	XK_W = 0x0057,
	XK_X = 0x0058,
	XK_Y = 0x0059,
	XK_Z = 0x005a,
	XK_bracketleft = 0x005b,
	XK_backslash = 0x005c,
	XK_bracketright = 0x005d,
	XK_asciicircum = 0x005e,
	XK_underscore = 0x005f,
	XK_grave = 0x0060,
	XK_quoteleft = 0x0060,
	XK_a = 0x0061,
	XK_b = 0x0062,
	XK_c = 0x0063,
	XK_d = 0x0064,
	XK_e = 0x0065,
	XK_f = 0x0066,
	XK_g = 0x0067,
	XK_h = 0x0068,
	XK_i = 0x0069,
	XK_j = 0x006a,
	XK_k = 0x006b,
	XK_l = 0x006c,
	XK_m = 0x006d,
	XK_n = 0x006e,
	XK_o = 0x006f,
	XK_p = 0x0070,
	XK_q = 0x0071,
	XK_r = 0x0072,
	XK_s = 0x0073,
	XK_t = 0x0074,
	XK_u = 0x0075,
	XK_v = 0x0076,
	XK_w = 0x0077,
	XK_x = 0x0078,
	XK_y = 0x0079,
	XK_z = 0x007a,
	XK_braceleft = 0x007b,
	XK_bar = 0x007c,
	XK_braceright = 0x007d,
	XK_asciitilde = 0x007e,
	XK_nobreakspace = 0x00a0,
	XK_exclamdown = 0x00a1,
	XK_cent = 0x00a2,
	XK_sterling = 0x00a3,
	XK_currency = 0x00a4,
	XK_yen = 0x00a5,
	XK_brokenbar = 0x00a6,
	XK_section = 0x00a7,
	XK_diaeresis = 0x00a8,
	XK_copyright = 0x00a9,
	XK_ordfeminine = 0x00aa,
	XK_guillemotleft = 0x00ab,
	XK_notsign = 0x00ac,
	XK_hyphen = 0x00ad,
	XK_registered = 0x00ae,
	XK_macron = 0x00af,
	XK_degree = 0x00b0,
	XK_plusminus = 0x00b1,
	XK_twosuperior = 0x00b2,
	XK_threesuperior = 0x00b3,
	XK_acute = 0x00b4,
	XK_mu = 0x00b5,
	XK_paragraph = 0x00b6,
	XK_periodcentered = 0x00b7,
	XK_cedilla = 0x00b8,
	XK_onesuperior = 0x00b9,
	XK_masculine = 0x00ba,
	XK_guillemotright = 0x00bb,
	XK_onequarter = 0x00bc,
	XK_onehalf = 0x00bd,
	XK_threequarters = 0x00be,
	XK_questiondown = 0x00bf,
	XK_Agrave = 0x00c0,
	XK_Aacute = 0x00c1,
	XK_Acircumflex = 0x00c2,
	XK_Atilde = 0x00c3,
	XK_Adiaeresis = 0x00c4,
	XK_Aring = 0x00c5,
	XK_AE = 0x00c6,
	XK_Ccedilla = 0x00c7,
	XK_Egrave = 0x00c8,
	XK_Eacute = 0x00c9,
	XK_Ecircumflex = 0x00ca,
	XK_Ediaeresis = 0x00cb,
	XK_Igrave = 0x00cc,
	XK_Iacute = 0x00cd,
	XK_Icircumflex = 0x00ce,
	XK_Idiaeresis = 0x00cf,
	XK_ETH = 0x00d0,
	XK_Eth = 0x00d0,
	XK_Ntilde = 0x00d1,
	XK_Ograve = 0x00d2,
	XK_Oacute = 0x00d3,
	XK_Ocircumflex = 0x00d4,
	XK_Otilde = 0x00d5,
	XK_Odiaeresis = 0x00d6,
	XK_multiply = 0x00d7,
	XK_Oslash = 0x00d8,
	XK_Ooblique = 0x00d8,
	XK_Ugrave = 0x00d9,
	XK_Uacute = 0x00da,
	XK_Ucircumflex = 0x00db,
	XK_Udiaeresis = 0x00dc,
	XK_Yacute = 0x00dd,
	XK_THORN = 0x00de,
	XK_Thorn = 0x00de,
	XK_ssharp = 0x00df,
	XK_agrave = 0x00e0,
	XK_aacute = 0x00e1,
	XK_acircumflex = 0x00e2,
	XK_atilde = 0x00e3,
	XK_adiaeresis = 0x00e4,
	XK_aring = 0x00e5,
	XK_ae = 0x00e6,
	XK_ccedilla = 0x00e7,
	XK_egrave = 0x00e8,
	XK_eacute = 0x00e9,
	XK_ecircumflex = 0x00ea,
	XK_ediaeresis = 0x00eb,
	XK_igrave = 0x00ec,
	XK_iacute = 0x00ed,
	XK_icircumflex = 0x00ee,
	XK_idiaeresis = 0x00ef,
	XK_eth = 0x00f0,
	XK_ntilde = 0x00f1,
	XK_ograve = 0x00f2,
	XK_oacute = 0x00f3,
	XK_ocircumflex = 0x00f4,
	XK_otilde = 0x00f5,
	XK_odiaeresis = 0x00f6,
	XK_division = 0x00f7,
	XK_oslash = 0x00f8,
	XK_ooblique = 0x00f8,
	XK_ugrave = 0x00f9,
	XK_uacute = 0x00fa,
	XK_ucircumflex = 0x00fb,
	XK_udiaeresis = 0x00fc,
	XK_yacute = 0x00fd,
	XK_thorn = 0x00fe,
	XK_ydiaeresis = 0x00ff,
	XK_Aogonek = 0x01a1,
	XK_breve = 0x01a2,
	XK_Lstroke = 0x01a3,
	XK_Lcaron = 0x01a5,
	XK_Sacute = 0x01a6,
	XK_Scaron = 0x01a9,
	XK_Scedilla = 0x01aa,
	XK_Tcaron = 0x01ab,
	XK_Zacute = 0x01ac,
	XK_Zcaron = 0x01ae,
	XK_Zabovedot = 0x01af,
	XK_aogonek = 0x01b1,
	XK_ogonek = 0x01b2,
	XK_lstroke = 0x01b3,
	XK_lcaron = 0x01b5,
	XK_sacute = 0x01b6,
	XK_caron = 0x01b7,
	XK_scaron = 0x01b9,
	XK_scedilla = 0x01ba,
	XK_tcaron = 0x01bb,
	XK_zacute = 0x01bc,
	XK_doubleacute = 0x01bd,
	XK_zcaron = 0x01be,
	XK_zabovedot = 0x01bf,
	XK_Racute = 0x01c0,
	XK_Abreve = 0x01c3,
	XK_Lacute = 0x01c5,
	XK_Cacute = 0x01c6,
	XK_Ccaron = 0x01c8,
	XK_Eogonek = 0x01ca,
	XK_Ecaron = 0x01cc,
	XK_Dcaron = 0x01cf,
	XK_Dstroke = 0x01d0,
	XK_Nacute = 0x01d1,
	XK_Ncaron = 0x01d2,
	XK_Odoubleacute = 0x01d5,
	XK_Rcaron = 0x01d8,
	XK_Uring = 0x01d9,
	XK_Udoubleacute = 0x01db,
	XK_Tcedilla = 0x01de,
	XK_racute = 0x01e0,
	XK_abreve = 0x01e3,
	XK_lacute = 0x01e5,
	XK_cacute = 0x01e6,
	XK_ccaron = 0x01e8,
	XK_eogonek = 0x01ea,
	XK_ecaron = 0x01ec,
	XK_dcaron = 0x01ef,
	XK_dstroke = 0x01f0,
	XK_nacute = 0x01f1,
	XK_ncaron = 0x01f2,
	XK_odoubleacute = 0x01f5,
	XK_rcaron = 0x01f8,
	XK_uring = 0x01f9,
	XK_udoubleacute = 0x01fb,
	XK_tcedilla = 0x01fe,
	XK_abovedot = 0x01ff,
	XK_Hstroke = 0x02a1,
	XK_Hcircumflex = 0x02a6,
	XK_Iabovedot = 0x02a9,
	XK_Gbreve = 0x02ab,
	XK_Jcircumflex = 0x02ac,
	XK_hstroke = 0x02b1,
	XK_hcircumflex = 0x02b6,
	XK_idotless = 0x02b9,
	XK_gbreve = 0x02bb,
	XK_jcircumflex = 0x02bc,
	XK_Cabovedot = 0x02c5,
	XK_Ccircumflex = 0x02c6,
	XK_Gabovedot = 0x02d5,
	XK_Gcircumflex = 0x02d8,
	XK_Ubreve = 0x02dd,
	XK_Scircumflex = 0x02de,
	XK_cabovedot = 0x02e5,
	XK_ccircumflex = 0x02e6,
	XK_gabovedot = 0x02f5,
	XK_gcircumflex = 0x02f8,
	XK_ubreve = 0x02fd,
	XK_scircumflex = 0x02fe,
	XK_kra = 0x03a2,
	XK_kappa = 0x03a2,
	XK_Rcedilla = 0x03a3,
	XK_Itilde = 0x03a5,
	XK_Lcedilla = 0x03a6,
	XK_Emacron = 0x03aa,
	XK_Gcedilla = 0x03ab,
	XK_Tslash = 0x03ac,
	XK_rcedilla = 0x03b3,
	XK_itilde = 0x03b5,
	XK_lcedilla = 0x03b6,
	XK_emacron = 0x03ba,
	XK_gcedilla = 0x03bb,
	XK_tslash = 0x03bc,
	XK_ENG = 0x03bd,
	XK_eng = 0x03bf,
	XK_Amacron = 0x03c0,
	XK_Iogonek = 0x03c7,
	XK_Eabovedot = 0x03cc,
	XK_Imacron = 0x03cf,
	XK_Ncedilla = 0x03d1,
	XK_Omacron = 0x03d2,
	XK_Kcedilla = 0x03d3,
	XK_Uogonek = 0x03d9,
	XK_Utilde = 0x03dd,
	XK_Umacron = 0x03de,
	XK_amacron = 0x03e0,
	XK_iogonek = 0x03e7,
	XK_eabovedot = 0x03ec,
	XK_imacron = 0x03ef,
	XK_ncedilla = 0x03f1,
	XK_omacron = 0x03f2,
	XK_kcedilla = 0x03f3,
	XK_uogonek = 0x03f9,
	XK_utilde = 0x03fd,
	XK_umacron = 0x03fe,
	XK_Wcircumflex = 0x1000174,
	XK_wcircumflex = 0x1000175,
	XK_Ycircumflex = 0x1000176,
	XK_ycircumflex = 0x1000177,
	XK_Babovedot = 0x1001e02,
	XK_babovedot = 0x1001e03,
	XK_Dabovedot = 0x1001e0a,
	XK_dabovedot = 0x1001e0b,
	XK_Fabovedot = 0x1001e1e,
	XK_fabovedot = 0x1001e1f,
	XK_Mabovedot = 0x1001e40,
	XK_mabovedot = 0x1001e41,
	XK_Pabovedot = 0x1001e56,
	XK_pabovedot = 0x1001e57,
	XK_Sabovedot = 0x1001e60,
	XK_sabovedot = 0x1001e61,
	XK_Tabovedot = 0x1001e6a,
	XK_tabovedot = 0x1001e6b,
	XK_Wgrave = 0x1001e80,
	XK_wgrave = 0x1001e81,
	XK_Wacute = 0x1001e82,
	XK_wacute = 0x1001e83,
	XK_Wdiaeresis = 0x1001e84,
	XK_wdiaeresis = 0x1001e85,
	XK_Ygrave = 0x1001ef2,
	XK_ygrave = 0x1001ef3,
	XK_OE = 0x13bc,
	XK_oe = 0x13bd,
	XK_Ydiaeresis = 0x13be,
	XK_overline = 0x047e,
	XK_kana_fullstop = 0x04a1,
	XK_kana_openingbracket = 0x04a2,
	XK_kana_closingbracket = 0x04a3,
	XK_kana_comma = 0x04a4,
	XK_kana_conjunctive = 0x04a5,
	XK_kana_middledot = 0x04a5,
	XK_kana_WO = 0x04a6,
	XK_kana_a = 0x04a7,
	XK_kana_i = 0x04a8,
	XK_kana_u = 0x04a9,
	XK_kana_e = 0x04aa,
	XK_kana_o = 0x04ab,
	XK_kana_ya = 0x04ac,
	XK_kana_yu = 0x04ad,
	XK_kana_yo = 0x04ae,
	XK_kana_tsu = 0x04af,
	XK_kana_tu = 0x04af,
	XK_prolongedsound = 0x04b0,
	XK_kana_A = 0x04b1,
	XK_kana_I = 0x04b2,
	XK_kana_U = 0x04b3,
	XK_kana_E = 0x04b4,
	XK_kana_O = 0x04b5,
	XK_kana_KA = 0x04b6,
	XK_kana_KI = 0x04b7,
	XK_kana_KU = 0x04b8,
	XK_kana_KE = 0x04b9,
	XK_kana_KO = 0x04ba,
	XK_kana_SA = 0x04bb,
	XK_kana_SHI = 0x04bc,
	XK_kana_SU = 0x04bd,
	XK_kana_SE = 0x04be,
	XK_kana_SO = 0x04bf,
	XK_kana_TA = 0x04c0,
	XK_kana_CHI = 0x04c1,
	XK_kana_TI = 0x04c1,
	XK_kana_TSU = 0x04c2,
	XK_kana_TU = 0x04c2,
	XK_kana_TE = 0x04c3,
	XK_kana_TO = 0x04c4,
	XK_kana_NA = 0x04c5,
	XK_kana_NI = 0x04c6,
	XK_kana_NU = 0x04c7,
	XK_kana_NE = 0x04c8,
	XK_kana_NO = 0x04c9,
	XK_kana_HA = 0x04ca,
	XK_kana_HI = 0x04cb,
	XK_kana_FU = 0x04cc,
	XK_kana_HU = 0x04cc,
	XK_kana_HE = 0x04cd,
	XK_kana_HO = 0x04ce,
	XK_kana_MA = 0x04cf,
	XK_kana_MI = 0x04d0,
	XK_kana_MU = 0x04d1,
	XK_kana_ME = 0x04d2,
	XK_kana_MO = 0x04d3,
	XK_kana_YA = 0x04d4,
	XK_kana_YU = 0x04d5,
	XK_kana_YO = 0x04d6,
	XK_kana_RA = 0x04d7,
	XK_kana_RI = 0x04d8,
	XK_kana_RU = 0x04d9,
	XK_kana_RE = 0x04da,
	XK_kana_RO = 0x04db,
	XK_kana_WA = 0x04dc,
	XK_kana_N = 0x04dd,
	XK_voicedsound = 0x04de,
	XK_semivoicedsound = 0x04df,
	XK_kana_switch = 0xff7e,
	XK_Farsi_0 = 0x10006f0,
	XK_Farsi_1 = 0x10006f1,
	XK_Farsi_2 = 0x10006f2,
	XK_Farsi_3 = 0x10006f3,
	XK_Farsi_4 = 0x10006f4,
	XK_Farsi_5 = 0x10006f5,
	XK_Farsi_6 = 0x10006f6,
	XK_Farsi_7 = 0x10006f7,
	XK_Farsi_8 = 0x10006f8,
	XK_Farsi_9 = 0x10006f9,
	XK_Arabic_percent = 0x100066a,
	XK_Arabic_superscript_alef = 0x1000670,
	XK_Arabic_tteh = 0x1000679,
	XK_Arabic_peh = 0x100067e,
	XK_Arabic_tcheh = 0x1000686,
	XK_Arabic_ddal = 0x1000688,
	XK_Arabic_rreh = 0x1000691,
	XK_Arabic_comma = 0x05ac,
	XK_Arabic_fullstop = 0x10006d4,
	XK_Arabic_0 = 0x1000660,
	XK_Arabic_1 = 0x1000661,
	XK_Arabic_2 = 0x1000662,
	XK_Arabic_3 = 0x1000663,
	XK_Arabic_4 = 0x1000664,
	XK_Arabic_5 = 0x1000665,
	XK_Arabic_6 = 0x1000666,
	XK_Arabic_7 = 0x1000667,
	XK_Arabic_8 = 0x1000668,
	XK_Arabic_9 = 0x1000669,
	XK_Arabic_semicolon = 0x05bb,
	XK_Arabic_question_mark = 0x05bf,
	XK_Arabic_hamza = 0x05c1,
	XK_Arabic_maddaonalef = 0x05c2,
	XK_Arabic_hamzaonalef = 0x05c3,
	XK_Arabic_hamzaonwaw = 0x05c4,
	XK_Arabic_hamzaunderalef = 0x05c5,
	XK_Arabic_hamzaonyeh = 0x05c6,
	XK_Arabic_alef = 0x05c7,
	XK_Arabic_beh = 0x05c8,
	XK_Arabic_tehmarbuta = 0x05c9,
	XK_Arabic_teh = 0x05ca,
	XK_Arabic_theh = 0x05cb,
	XK_Arabic_jeem = 0x05cc,
	XK_Arabic_hah = 0x05cd,
	XK_Arabic_khah = 0x05ce,
	XK_Arabic_dal = 0x05cf,
	XK_Arabic_thal = 0x05d0,
	XK_Arabic_ra = 0x05d1,
	XK_Arabic_zain = 0x05d2,
	XK_Arabic_seen = 0x05d3,
	XK_Arabic_sheen = 0x05d4,
	XK_Arabic_sad = 0x05d5,
	XK_Arabic_dad = 0x05d6,
	XK_Arabic_tah = 0x05d7,
	XK_Arabic_zah = 0x05d8,
	XK_Arabic_ain = 0x05d9,
	XK_Arabic_ghain = 0x05da,
	XK_Arabic_tatweel = 0x05e0,
	XK_Arabic_feh = 0x05e1,
	XK_Arabic_qaf = 0x05e2,
	XK_Arabic_kaf = 0x05e3,
	XK_Arabic_lam = 0x05e4,
	XK_Arabic_meem = 0x05e5,
	XK_Arabic_noon = 0x05e6,
	XK_Arabic_ha = 0x05e7,
	XK_Arabic_heh = 0x05e7,
	XK_Arabic_waw = 0x05e8,
	XK_Arabic_alefmaksura = 0x05e9,
	XK_Arabic_yeh = 0x05ea,
	XK_Arabic_fathatan = 0x05eb,
	XK_Arabic_dammatan = 0x05ec,
	XK_Arabic_kasratan = 0x05ed,
	XK_Arabic_fatha = 0x05ee,
	XK_Arabic_damma = 0x05ef,
	XK_Arabic_kasra = 0x05f0,
	XK_Arabic_shadda = 0x05f1,
	XK_Arabic_sukun = 0x05f2,
	XK_Arabic_madda_above = 0x1000653,
	XK_Arabic_hamza_above = 0x1000654,
	XK_Arabic_hamza_below = 0x1000655,
	XK_Arabic_jeh = 0x1000698,
	XK_Arabic_veh = 0x10006a4,
	XK_Arabic_keheh = 0x10006a9,
	XK_Arabic_gaf = 0x10006af,
	XK_Arabic_noon_ghunna = 0x10006ba,
	XK_Arabic_heh_doachashmee = 0x10006be,
	XK_Farsi_yeh = 0x10006cc,
	XK_Arabic_farsi_yeh = 0x10006cc,
	XK_Arabic_yeh_baree = 0x10006d2,
	XK_Arabic_heh_goal = 0x10006c1,
	XK_Arabic_switch = 0xff7e,
	XK_Cyrillic_GHE_bar = 0x1000492,
	XK_Cyrillic_ghe_bar = 0x1000493,
	XK_Cyrillic_ZHE_descender = 0x1000496,
	XK_Cyrillic_zhe_descender = 0x1000497,
	XK_Cyrillic_KA_descender = 0x100049a,
	XK_Cyrillic_ka_descender = 0x100049b,
	XK_Cyrillic_KA_vertstroke = 0x100049c,
	XK_Cyrillic_ka_vertstroke = 0x100049d,
	XK_Cyrillic_EN_descender = 0x10004a2,
	XK_Cyrillic_en_descender = 0x10004a3,
	XK_Cyrillic_U_straight = 0x10004ae,
	XK_Cyrillic_u_straight = 0x10004af,
	XK_Cyrillic_U_straight_bar = 0x10004b0,
	XK_Cyrillic_u_straight_bar = 0x10004b1,
	XK_Cyrillic_HA_descender = 0x10004b2,
	XK_Cyrillic_ha_descender = 0x10004b3,
	XK_Cyrillic_CHE_descender = 0x10004b6,
	XK_Cyrillic_che_descender = 0x10004b7,
	XK_Cyrillic_CHE_vertstroke = 0x10004b8,
	XK_Cyrillic_che_vertstroke = 0x10004b9,
	XK_Cyrillic_SHHA = 0x10004ba,
	XK_Cyrillic_shha = 0x10004bb,
	XK_Cyrillic_SCHWA = 0x10004d8,
	XK_Cyrillic_schwa = 0x10004d9,
	XK_Cyrillic_I_macron = 0x10004e2,
	XK_Cyrillic_i_macron = 0x10004e3,
	XK_Cyrillic_O_bar = 0x10004e8,
	XK_Cyrillic_o_bar = 0x10004e9,
	XK_Cyrillic_U_macron = 0x10004ee,
	XK_Cyrillic_u_macron = 0x10004ef,
	XK_Serbian_dje = 0x06a1,
	XK_Macedonia_gje = 0x06a2,
	XK_Cyrillic_io = 0x06a3,
	XK_Ukrainian_ie = 0x06a4,
	XK_Ukranian_je = 0x06a4,
	XK_Macedonia_dse = 0x06a5,
	XK_Ukrainian_i = 0x06a6,
	XK_Ukranian_i = 0x06a6,
	XK_Ukrainian_yi = 0x06a7,
	XK_Ukranian_yi = 0x06a7,
	XK_Cyrillic_je = 0x06a8,
	XK_Serbian_je = 0x06a8,
	XK_Cyrillic_lje = 0x06a9,
	XK_Serbian_lje = 0x06a9,
	XK_Cyrillic_nje = 0x06aa,
	XK_Serbian_nje = 0x06aa,
	XK_Serbian_tshe = 0x06ab,
	XK_Macedonia_kje = 0x06ac,
	XK_Ukrainian_ghe_with_upturn = 0x06ad,
	XK_Byelorussian_shortu = 0x06ae,
	XK_Cyrillic_dzhe = 0x06af,
	XK_Serbian_dze = 0x06af,
	XK_numerosign = 0x06b0,
	XK_Serbian_DJE = 0x06b1,
	XK_Macedonia_GJE = 0x06b2,
	XK_Cyrillic_IO = 0x06b3,
	XK_Ukrainian_IE = 0x06b4,
	XK_Ukranian_JE = 0x06b4,
	XK_Macedonia_DSE = 0x06b5,
	XK_Ukrainian_I = 0x06b6,
	XK_Ukranian_I = 0x06b6,
	XK_Ukrainian_YI = 0x06b7,
	XK_Ukranian_YI = 0x06b7,
	XK_Cyrillic_JE = 0x06b8,
	XK_Serbian_JE = 0x06b8,
	XK_Cyrillic_LJE = 0x06b9,
	XK_Serbian_LJE = 0x06b9,
	XK_Cyrillic_NJE = 0x06ba,
	XK_Serbian_NJE = 0x06ba,
	XK_Serbian_TSHE = 0x06bb,
	XK_Macedonia_KJE = 0x06bc,
	XK_Ukrainian_GHE_WITH_UPTURN = 0x06bd,
	XK_Byelorussian_SHORTU = 0x06be,
	XK_Cyrillic_DZHE = 0x06bf,
	XK_Serbian_DZE = 0x06bf,
	XK_Cyrillic_yu = 0x06c0,
	XK_Cyrillic_a = 0x06c1,
	XK_Cyrillic_be = 0x06c2,
	XK_Cyrillic_tse = 0x06c3,
	XK_Cyrillic_de = 0x06c4,
	XK_Cyrillic_ie = 0x06c5,
	XK_Cyrillic_ef = 0x06c6,
	XK_Cyrillic_ghe = 0x06c7,
	XK_Cyrillic_ha = 0x06c8,
	XK_Cyrillic_i = 0x06c9,
	XK_Cyrillic_shorti = 0x06ca,
	XK_Cyrillic_ka = 0x06cb,
	XK_Cyrillic_el = 0x06cc,
	XK_Cyrillic_em = 0x06cd,
	XK_Cyrillic_en = 0x06ce,
	XK_Cyrillic_o = 0x06cf,
	XK_Cyrillic_pe = 0x06d0,
	XK_Cyrillic_ya = 0x06d1,
	XK_Cyrillic_er = 0x06d2,
	XK_Cyrillic_es = 0x06d3,
	XK_Cyrillic_te = 0x06d4,
	XK_Cyrillic_u = 0x06d5,
	XK_Cyrillic_zhe = 0x06d6,
	XK_Cyrillic_ve = 0x06d7,
	XK_Cyrillic_softsign = 0x06d8,
	XK_Cyrillic_yeru = 0x06d9,
	XK_Cyrillic_ze = 0x06da,
	XK_Cyrillic_sha = 0x06db,
	XK_Cyrillic_e = 0x06dc,
	XK_Cyrillic_shcha = 0x06dd,
	XK_Cyrillic_che = 0x06de,
	XK_Cyrillic_hardsign = 0x06df,
	XK_Cyrillic_YU = 0x06e0,
	XK_Cyrillic_A = 0x06e1,
	XK_Cyrillic_BE = 0x06e2,
	XK_Cyrillic_TSE = 0x06e3,
	XK_Cyrillic_DE = 0x06e4,
	XK_Cyrillic_IE = 0x06e5,
	XK_Cyrillic_EF = 0x06e6,
	XK_Cyrillic_GHE = 0x06e7,
	XK_Cyrillic_HA = 0x06e8,
	XK_Cyrillic_I = 0x06e9,
	XK_Cyrillic_SHORTI = 0x06ea,
	XK_Cyrillic_KA = 0x06eb,
	XK_Cyrillic_EL = 0x06ec,
	XK_Cyrillic_EM = 0x06ed,
	XK_Cyrillic_EN = 0x06ee,
	XK_Cyrillic_O = 0x06ef,
	XK_Cyrillic_PE = 0x06f0,
	XK_Cyrillic_YA = 0x06f1,
	XK_Cyrillic_ER = 0x06f2,
	XK_Cyrillic_ES = 0x06f3,
	XK_Cyrillic_TE = 0x06f4,
	XK_Cyrillic_U = 0x06f5,
	XK_Cyrillic_ZHE = 0x06f6,
	XK_Cyrillic_VE = 0x06f7,
	XK_Cyrillic_SOFTSIGN = 0x06f8,
	XK_Cyrillic_YERU = 0x06f9,
	XK_Cyrillic_ZE = 0x06fa,
	XK_Cyrillic_SHA = 0x06fb,
	XK_Cyrillic_E = 0x06fc,
	XK_Cyrillic_SHCHA = 0x06fd,
	XK_Cyrillic_CHE = 0x06fe,
	XK_Cyrillic_HARDSIGN = 0x06ff,
	XK_Greek_ALPHAaccent = 0x07a1,
	XK_Greek_EPSILONaccent = 0x07a2,
	XK_Greek_ETAaccent = 0x07a3,
	XK_Greek_IOTAaccent = 0x07a4,
	XK_Greek_IOTAdieresis = 0x07a5,
	XK_Greek_IOTAdiaeresis = 0x07a5,
	XK_Greek_OMICRONaccent = 0x07a7,
	XK_Greek_UPSILONaccent = 0x07a8,
	XK_Greek_UPSILONdieresis = 0x07a9,
	XK_Greek_OMEGAaccent = 0x07ab,
	XK_Greek_accentdieresis = 0x07ae,
	XK_Greek_horizbar = 0x07af,
	XK_Greek_alphaaccent = 0x07b1,
	XK_Greek_epsilonaccent = 0x07b2,
	XK_Greek_etaaccent = 0x07b3,
	XK_Greek_iotaaccent = 0x07b4,
	XK_Greek_iotadieresis = 0x07b5,
	XK_Greek_iotaaccentdieresis = 0x07b6,
	XK_Greek_omicronaccent = 0x07b7,
	XK_Greek_upsilonaccent = 0x07b8,
	XK_Greek_upsilondieresis = 0x07b9,
	XK_Greek_upsilonaccentdieresis = 0x07ba,
	XK_Greek_omegaaccent = 0x07bb,
	XK_Greek_ALPHA = 0x07c1,
	XK_Greek_BETA = 0x07c2,
	XK_Greek_GAMMA = 0x07c3,
	XK_Greek_DELTA = 0x07c4,
	XK_Greek_EPSILON = 0x07c5,
	XK_Greek_ZETA = 0x07c6,
	XK_Greek_ETA = 0x07c7,
	XK_Greek_THETA = 0x07c8,
	XK_Greek_IOTA = 0x07c9,
	XK_Greek_KAPPA = 0x07ca,
	XK_Greek_LAMDA = 0x07cb,
	XK_Greek_LAMBDA = 0x07cb,
	XK_Greek_MU = 0x07cc,
	XK_Greek_NU = 0x07cd,
	XK_Greek_XI = 0x07ce,
	XK_Greek_OMICRON = 0x07cf,
	XK_Greek_PI = 0x07d0,
	XK_Greek_RHO = 0x07d1,
	XK_Greek_SIGMA = 0x07d2,
	XK_Greek_TAU = 0x07d4,
	XK_Greek_UPSILON = 0x07d5,
	XK_Greek_PHI = 0x07d6,
	XK_Greek_CHI = 0x07d7,
	XK_Greek_PSI = 0x07d8,
	XK_Greek_OMEGA = 0x07d9,
	XK_Greek_alpha = 0x07e1,
	XK_Greek_beta = 0x07e2,
	XK_Greek_gamma = 0x07e3,
	XK_Greek_delta = 0x07e4,
	XK_Greek_epsilon = 0x07e5,
	XK_Greek_zeta = 0x07e6,
	XK_Greek_eta = 0x07e7,
	XK_Greek_theta = 0x07e8,
	XK_Greek_iota = 0x07e9,
	XK_Greek_kappa = 0x07ea,
	XK_Greek_lamda = 0x07eb,
	XK_Greek_lambda = 0x07eb,
	XK_Greek_mu = 0x07ec,
	XK_Greek_nu = 0x07ed,
	XK_Greek_xi = 0x07ee,
	XK_Greek_omicron = 0x07ef,
	XK_Greek_pi = 0x07f0,
	XK_Greek_rho = 0x07f1,
	XK_Greek_sigma = 0x07f2,
	XK_Greek_finalsmallsigma = 0x07f3,
	XK_Greek_tau = 0x07f4,
	XK_Greek_upsilon = 0x07f5,
	XK_Greek_phi = 0x07f6,
	XK_Greek_chi = 0x07f7,
	XK_Greek_psi = 0x07f8,
	XK_Greek_omega = 0x07f9,
	XK_Greek_switch = 0xff7e,
	XK_leftradical = 0x08a1,
	XK_topleftradical = 0x08a2,
	XK_horizconnector = 0x08a3,
	XK_topintegral = 0x08a4,
	XK_botintegral = 0x08a5,
	XK_vertconnector = 0x08a6,
	XK_topleftsqbracket = 0x08a7,
	XK_botleftsqbracket = 0x08a8,
	XK_toprightsqbracket = 0x08a9,
	XK_botrightsqbracket = 0x08aa,
	XK_topleftparens = 0x08ab,
	XK_botleftparens = 0x08ac,
	XK_toprightparens = 0x08ad,
	XK_botrightparens = 0x08ae,
	XK_leftmiddlecurlybrace = 0x08af,
	XK_rightmiddlecurlybrace = 0x08b0,
	XK_topleftsummation = 0x08b1,
	XK_botleftsummation = 0x08b2,
	XK_topvertsummationconnector = 0x08b3,
	XK_botvertsummationconnector = 0x08b4,
	XK_toprightsummation = 0x08b5,
	XK_botrightsummation = 0x08b6,
	XK_rightmiddlesummation = 0x08b7,
	XK_lessthanequal = 0x08bc,
	XK_notequal = 0x08bd,
	XK_greaterthanequal = 0x08be,
	XK_integral = 0x08bf,
	XK_therefore = 0x08c0,
	XK_variation = 0x08c1,
	XK_infinity = 0x08c2,
	XK_nabla = 0x08c5,
	XK_approximate = 0x08c8,
	XK_similarequal = 0x08c9,
	XK_ifonlyif = 0x08cd,
	XK_implies = 0x08ce,
	XK_identical = 0x08cf,
	XK_radical = 0x08d6,
	XK_includedin = 0x08da,
	XK_includes = 0x08db,
	XK_intersection = 0x08dc,
	XK_union = 0x08dd,
	XK_logicaland = 0x08de,
	XK_logicalor = 0x08df,
	XK_partialderivative = 0x08ef,
	XK_function = 0x08f6,
	XK_leftarrow = 0x08fb,
	XK_uparrow = 0x08fc,
	XK_rightarrow = 0x08fd,
	XK_downarrow = 0x08fe,
	XK_blank = 0x09df,
	XK_soliddiamond = 0x09e0,
	XK_checkerboard = 0x09e1,
	XK_ht = 0x09e2,
	XK_ff = 0x09e3,
	XK_cr = 0x09e4,
	XK_lf = 0x09e5,
	XK_nl = 0x09e8,
	XK_vt = 0x09e9,
	XK_lowrightcorner = 0x09ea,
	XK_uprightcorner = 0x09eb,
	XK_upleftcorner = 0x09ec,
	XK_lowleftcorner = 0x09ed,
	XK_crossinglines = 0x09ee,
	XK_horizlinescan1 = 0x09ef,
	XK_horizlinescan3 = 0x09f0,
	XK_horizlinescan5 = 0x09f1,
	XK_horizlinescan7 = 0x09f2,
	XK_horizlinescan9 = 0x09f3,
	XK_leftt = 0x09f4,
	XK_rightt = 0x09f5,
	XK_bott = 0x09f6,
	XK_topt = 0x09f7,
	XK_vertbar = 0x09f8,
	XK_emspace = 0x0aa1,
	XK_enspace = 0x0aa2,
	XK_em3space = 0x0aa3,
	XK_em4space = 0x0aa4,
	XK_digitspace = 0x0aa5,
	XK_punctspace = 0x0aa6,
	XK_thinspace = 0x0aa7,
	XK_hairspace = 0x0aa8,
	XK_emdash = 0x0aa9,
	XK_endash = 0x0aaa,
	XK_signifblank = 0x0aac,
	XK_ellipsis = 0x0aae,
	XK_doubbaselinedot = 0x0aaf,
	XK_onethird = 0x0ab0,
	XK_twothirds = 0x0ab1,
	XK_onefifth = 0x0ab2,
	XK_twofifths = 0x0ab3,
	XK_threefifths = 0x0ab4,
	XK_fourfifths = 0x0ab5,
	XK_onesixth = 0x0ab6,
	XK_fivesixths = 0x0ab7,
	XK_careof = 0x0ab8,
	XK_figdash = 0x0abb,
	XK_leftanglebracket = 0x0abc,
	XK_decimalpoint = 0x0abd,
	XK_rightanglebracket = 0x0abe,
	XK_marker = 0x0abf,
	XK_oneeighth = 0x0ac3,
	XK_threeeighths = 0x0ac4,
	XK_fiveeighths = 0x0ac5,
	XK_seveneighths = 0x0ac6,
	XK_trademark = 0x0ac9,
	XK_signaturemark = 0x0aca,
	XK_trademarkincircle = 0x0acb,
	XK_leftopentriangle = 0x0acc,
	XK_rightopentriangle = 0x0acd,
	XK_emopencircle = 0x0ace,
	XK_emopenrectangle = 0x0acf,
	XK_leftsinglequotemark = 0x0ad0,
	XK_rightsinglequotemark = 0x0ad1,
	XK_leftdoublequotemark = 0x0ad2,
	XK_rightdoublequotemark = 0x0ad3,
	XK_prescription = 0x0ad4,
	XK_permille = 0x0ad5,
	XK_minutes = 0x0ad6,
	XK_seconds = 0x0ad7,
	XK_latincross = 0x0ad9,
	XK_hexagram = 0x0ada,
	XK_filledrectbullet = 0x0adb,
	XK_filledlefttribullet = 0x0adc,
	XK_filledrighttribullet = 0x0add,
	XK_emfilledcircle = 0x0ade,
	XK_emfilledrect = 0x0adf,
	XK_enopencircbullet = 0x0ae0,
	XK_enopensquarebullet = 0x0ae1,
	XK_openrectbullet = 0x0ae2,
	XK_opentribulletup = 0x0ae3,
	XK_opentribulletdown = 0x0ae4,
	XK_openstar = 0x0ae5,
	XK_enfilledcircbullet = 0x0ae6,
	XK_enfilledsqbullet = 0x0ae7,
	XK_filledtribulletup = 0x0ae8,
	XK_filledtribulletdown = 0x0ae9,
	XK_leftpointer = 0x0aea,
	XK_rightpointer = 0x0aeb,
	XK_club = 0x0aec,
	XK_diamond = 0x0aed,
	XK_heart = 0x0aee,
	XK_maltesecross = 0x0af0,
	XK_dagger = 0x0af1,
	XK_doubledagger = 0x0af2,
	XK_checkmark = 0x0af3,
	XK_ballotcross = 0x0af4,
	XK_musicalsharp = 0x0af5,
	XK_musicalflat = 0x0af6,
	XK_malesymbol = 0x0af7,
	XK_femalesymbol = 0x0af8,
	XK_telephone = 0x0af9,
	XK_telephonerecorder = 0x0afa,
	XK_phonographcopyright = 0x0afb,
	XK_caret = 0x0afc,
	XK_singlelowquotemark = 0x0afd,
	XK_doublelowquotemark = 0x0afe,
	XK_cursor = 0x0aff,
	XK_leftcaret = 0x0ba3,
	XK_rightcaret = 0x0ba6,
	XK_downcaret = 0x0ba8,
	XK_upcaret = 0x0ba9,
	XK_overbar = 0x0bc0,
	XK_downtack = 0x0bc2,
	XK_upshoe = 0x0bc3,
	XK_downstile = 0x0bc4,
	XK_underbar = 0x0bc6,
	XK_jot = 0x0bca,
	XK_quad = 0x0bcc,
	XK_uptack = 0x0bce,
	XK_circle = 0x0bcf,
	XK_upstile = 0x0bd3,
	XK_downshoe = 0x0bd6,
	XK_rightshoe = 0x0bd8,
	XK_leftshoe = 0x0bda,
	XK_lefttack = 0x0bdc,
	XK_righttack = 0x0bfc,
	XK_hebrew_doublelowline = 0x0cdf,
	XK_hebrew_aleph = 0x0ce0,
	XK_hebrew_bet = 0x0ce1,
	XK_hebrew_beth = 0x0ce1,
	XK_hebrew_gimel = 0x0ce2,
	XK_hebrew_gimmel = 0x0ce2,
	XK_hebrew_dalet = 0x0ce3,
	XK_hebrew_daleth = 0x0ce3,
	XK_hebrew_he = 0x0ce4,
	XK_hebrew_waw = 0x0ce5,
	XK_hebrew_zain = 0x0ce6,
	XK_hebrew_zayin = 0x0ce6,
	XK_hebrew_chet = 0x0ce7,
	XK_hebrew_het = 0x0ce7,
	XK_hebrew_tet = 0x0ce8,
	XK_hebrew_teth = 0x0ce8,
	XK_hebrew_yod = 0x0ce9,
	XK_hebrew_finalkaph = 0x0cea,
	XK_hebrew_kaph = 0x0ceb,
	XK_hebrew_lamed = 0x0cec,
	XK_hebrew_finalmem = 0x0ced,
	XK_hebrew_mem = 0x0cee,
	XK_hebrew_finalnun = 0x0cef,
	XK_hebrew_nun = 0x0cf0,
	XK_hebrew_samech = 0x0cf1,
	XK_hebrew_samekh = 0x0cf1,
	XK_hebrew_ayin = 0x0cf2,
	XK_hebrew_finalpe = 0x0cf3,
	XK_hebrew_pe = 0x0cf4,
	XK_hebrew_finalzade = 0x0cf5,
	XK_hebrew_finalzadi = 0x0cf5,
	XK_hebrew_zade = 0x0cf6,
	XK_hebrew_zadi = 0x0cf6,
	XK_hebrew_qoph = 0x0cf7,
	XK_hebrew_kuf = 0x0cf7,
	XK_hebrew_resh = 0x0cf8,
	XK_hebrew_shin = 0x0cf9,
	XK_hebrew_taw = 0x0cfa,
	XK_hebrew_taf = 0x0cfa,
	XK_Hebrew_switch = 0xff7e,
	XK_Thai_kokai = 0x0da1,
	XK_Thai_khokhai = 0x0da2,
	XK_Thai_khokhuat = 0x0da3,
	XK_Thai_khokhwai = 0x0da4,
	XK_Thai_khokhon = 0x0da5,
	XK_Thai_khorakhang = 0x0da6,
	XK_Thai_ngongu = 0x0da7,
	XK_Thai_chochan = 0x0da8,
	XK_Thai_choching = 0x0da9,
	XK_Thai_chochang = 0x0daa,
	XK_Thai_soso = 0x0dab,
	XK_Thai_chochoe = 0x0dac,
	XK_Thai_yoying = 0x0dad,
	XK_Thai_dochada = 0x0dae,
	XK_Thai_topatak = 0x0daf,
	XK_Thai_thothan = 0x0db0,
	XK_Thai_thonangmontho = 0x0db1,
	XK_Thai_thophuthao = 0x0db2,
	XK_Thai_nonen = 0x0db3,
	XK_Thai_dodek = 0x0db4,
	XK_Thai_totao = 0x0db5,
	XK_Thai_thothung = 0x0db6,
	XK_Thai_thothahan = 0x0db7,
	XK_Thai_thothong = 0x0db8,
	XK_Thai_nonu = 0x0db9,
	XK_Thai_bobaimai = 0x0dba,
	XK_Thai_popla = 0x0dbb,
	XK_Thai_phophung = 0x0dbc,
	XK_Thai_fofa = 0x0dbd,
	XK_Thai_phophan = 0x0dbe,
	XK_Thai_fofan = 0x0dbf,
	XK_Thai_phosamphao = 0x0dc0,
	XK_Thai_moma = 0x0dc1,
	XK_Thai_yoyak = 0x0dc2,
	XK_Thai_rorua = 0x0dc3,
	XK_Thai_ru = 0x0dc4,
	XK_Thai_loling = 0x0dc5,
	XK_Thai_lu = 0x0dc6,
	XK_Thai_wowaen = 0x0dc7,
	XK_Thai_sosala = 0x0dc8,
	XK_Thai_sorusi = 0x0dc9,
	XK_Thai_sosua = 0x0dca,
	XK_Thai_hohip = 0x0dcb,
	XK_Thai_lochula = 0x0dcc,
	XK_Thai_oang = 0x0dcd,
	XK_Thai_honokhuk = 0x0dce,
	XK_Thai_paiyannoi = 0x0dcf,
	XK_Thai_saraa = 0x0dd0,
	XK_Thai_maihanakat = 0x0dd1,
	XK_Thai_saraaa = 0x0dd2,
	XK_Thai_saraam = 0x0dd3,
	XK_Thai_sarai = 0x0dd4,
	XK_Thai_saraii = 0x0dd5,
	XK_Thai_saraue = 0x0dd6,
	XK_Thai_sarauee = 0x0dd7,
	XK_Thai_sarau = 0x0dd8,
	XK_Thai_sarauu = 0x0dd9,
	XK_Thai_phinthu = 0x0dda,
	XK_Thai_maihanakat_maitho = 0x0dde,
	XK_Thai_baht = 0x0ddf,
	XK_Thai_sarae = 0x0de0,
	XK_Thai_saraae = 0x0de1,
	XK_Thai_sarao = 0x0de2,
	XK_Thai_saraaimaimuan = 0x0de3,
	XK_Thai_saraaimaimalai = 0x0de4,
	XK_Thai_lakkhangyao = 0x0de5,
	XK_Thai_maiyamok = 0x0de6,
	XK_Thai_maitaikhu = 0x0de7,
	XK_Thai_maiek = 0x0de8,
	XK_Thai_maitho = 0x0de9,
	XK_Thai_maitri = 0x0dea,
	XK_Thai_maichattawa = 0x0deb,
	XK_Thai_thanthakhat = 0x0dec,
	XK_Thai_nikhahit = 0x0ded,
	XK_Thai_leksun = 0x0df0,
	XK_Thai_leknung = 0x0df1,
	XK_Thai_leksong = 0x0df2,
	XK_Thai_leksam = 0x0df3,
	XK_Thai_leksi = 0x0df4,
	XK_Thai_lekha = 0x0df5,
	XK_Thai_lekhok = 0x0df6,
	XK_Thai_lekchet = 0x0df7,
	XK_Thai_lekpaet = 0x0df8,
	XK_Thai_lekkao = 0x0df9,
	XK_Hangul = 0xff31,
	XK_Hangul_Start = 0xff32,
	XK_Hangul_End = 0xff33,
	XK_Hangul_Hanja = 0xff34,
	XK_Hangul_Jamo = 0xff35,
	XK_Hangul_Romaja = 0xff36,
	XK_Hangul_Codeinput = 0xff37,
	XK_Hangul_Jeonja = 0xff38,
	XK_Hangul_Banja = 0xff39,
	XK_Hangul_PreHanja = 0xff3a,
	XK_Hangul_PostHanja = 0xff3b,
	XK_Hangul_SingleCandidate = 0xff3c,
	XK_Hangul_MultipleCandidate = 0xff3d,
	XK_Hangul_PreviousCandidate = 0xff3e,
	XK_Hangul_Special = 0xff3f,
	XK_Hangul_switch = 0xff7e,
	XK_Hangul_Kiyeog = 0x0ea1,
	XK_Hangul_SsangKiyeog = 0x0ea2,
	XK_Hangul_KiyeogSios = 0x0ea3,
	XK_Hangul_Nieun = 0x0ea4,
	XK_Hangul_NieunJieuj = 0x0ea5,
	XK_Hangul_NieunHieuh = 0x0ea6,
	XK_Hangul_Dikeud = 0x0ea7,
	XK_Hangul_SsangDikeud = 0x0ea8,
	XK_Hangul_Rieul = 0x0ea9,
	XK_Hangul_RieulKiyeog = 0x0eaa,
	XK_Hangul_RieulMieum = 0x0eab,
	XK_Hangul_RieulPieub = 0x0eac,
	XK_Hangul_RieulSios = 0x0ead,
	XK_Hangul_RieulTieut = 0x0eae,
	XK_Hangul_RieulPhieuf = 0x0eaf,
	XK_Hangul_RieulHieuh = 0x0eb0,
	XK_Hangul_Mieum = 0x0eb1,
	XK_Hangul_Pieub = 0x0eb2,
	XK_Hangul_SsangPieub = 0x0eb3,
	XK_Hangul_PieubSios = 0x0eb4,
	XK_Hangul_Sios = 0x0eb5,
	XK_Hangul_SsangSios = 0x0eb6,
	XK_Hangul_Ieung = 0x0eb7,
	XK_Hangul_Jieuj = 0x0eb8,
	XK_Hangul_SsangJieuj = 0x0eb9,
	XK_Hangul_Cieuc = 0x0eba,
	XK_Hangul_Khieuq = 0x0ebb,
	XK_Hangul_Tieut = 0x0ebc,
	XK_Hangul_Phieuf = 0x0ebd,
	XK_Hangul_Hieuh = 0x0ebe,
	XK_Hangul_A = 0x0ebf,
	XK_Hangul_AE = 0x0ec0,
	XK_Hangul_YA = 0x0ec1,
	XK_Hangul_YAE = 0x0ec2,
	XK_Hangul_EO = 0x0ec3,
	XK_Hangul_E = 0x0ec4,
	XK_Hangul_YEO = 0x0ec5,
	XK_Hangul_YE = 0x0ec6,
	XK_Hangul_O = 0x0ec7,
	XK_Hangul_WA = 0x0ec8,
	XK_Hangul_WAE = 0x0ec9,
	XK_Hangul_OE = 0x0eca,
	XK_Hangul_YO = 0x0ecb,
	XK_Hangul_U = 0x0ecc,
	XK_Hangul_WEO = 0x0ecd,
	XK_Hangul_WE = 0x0ece,
	XK_Hangul_WI = 0x0ecf,
	XK_Hangul_YU = 0x0ed0,
	XK_Hangul_EU = 0x0ed1,
	XK_Hangul_YI = 0x0ed2,
	XK_Hangul_I = 0x0ed3,
	XK_Hangul_J_Kiyeog = 0x0ed4,
	XK_Hangul_J_SsangKiyeog = 0x0ed5,
	XK_Hangul_J_KiyeogSios = 0x0ed6,
	XK_Hangul_J_Nieun = 0x0ed7,
	XK_Hangul_J_NieunJieuj = 0x0ed8,
	XK_Hangul_J_NieunHieuh = 0x0ed9,
	XK_Hangul_J_Dikeud = 0x0eda,
	XK_Hangul_J_Rieul = 0x0edb,
	XK_Hangul_J_RieulKiyeog = 0x0edc,
	XK_Hangul_J_RieulMieum = 0x0edd,
	XK_Hangul_J_RieulPieub = 0x0ede,
	XK_Hangul_J_RieulSios = 0x0edf,
	XK_Hangul_J_RieulTieut = 0x0ee0,
	XK_Hangul_J_RieulPhieuf = 0x0ee1,
	XK_Hangul_J_RieulHieuh = 0x0ee2,
	XK_Hangul_J_Mieum = 0x0ee3,
	XK_Hangul_J_Pieub = 0x0ee4,
	XK_Hangul_J_PieubSios = 0x0ee5,
	XK_Hangul_J_Sios = 0x0ee6,
	XK_Hangul_J_SsangSios = 0x0ee7,
	XK_Hangul_J_Ieung = 0x0ee8,
	XK_Hangul_J_Jieuj = 0x0ee9,
	XK_Hangul_J_Cieuc = 0x0eea,
	XK_Hangul_J_Khieuq = 0x0eeb,
	XK_Hangul_J_Tieut = 0x0eec,
	XK_Hangul_J_Phieuf = 0x0eed,
	XK_Hangul_J_Hieuh = 0x0eee,
	XK_Hangul_RieulYeorinHieuh = 0x0eef,
	XK_Hangul_SunkyeongeumMieum = 0x0ef0,
	XK_Hangul_SunkyeongeumPieub = 0x0ef1,
	XK_Hangul_PanSios = 0x0ef2,
	XK_Hangul_KkogjiDalrinIeung = 0x0ef3,
	XK_Hangul_SunkyeongeumPhieuf = 0x0ef4,
	XK_Hangul_YeorinHieuh = 0x0ef5,
	XK_Hangul_AraeA = 0x0ef6,
	XK_Hangul_AraeAE = 0x0ef7,
	XK_Hangul_J_PanSios = 0x0ef8,
	XK_Hangul_J_KkogjiDalrinIeung = 0x0ef9,
	XK_Hangul_J_YeorinHieuh = 0x0efa,
	XK_Korean_Won = 0x0eff,
	XK_Armenian_ligature_ew = 0x1000587,
	XK_Armenian_full_stop = 0x1000589,
	XK_Armenian_verjaket = 0x1000589,
	XK_Armenian_separation_mark = 0x100055d,
	XK_Armenian_but = 0x100055d,
	XK_Armenian_hyphen = 0x100058a,
	XK_Armenian_yentamna = 0x100058a,
	XK_Armenian_exclam = 0x100055c,
	XK_Armenian_amanak = 0x100055c,
	XK_Armenian_accent = 0x100055b,
	XK_Armenian_shesht = 0x100055b,
	XK_Armenian_question = 0x100055e,
	XK_Armenian_paruyk = 0x100055e,
	XK_Armenian_AYB = 0x1000531,
	XK_Armenian_ayb = 0x1000561,
	XK_Armenian_BEN = 0x1000532,
	XK_Armenian_ben = 0x1000562,
	XK_Armenian_GIM = 0x1000533,
	XK_Armenian_gim = 0x1000563,
	XK_Armenian_DA = 0x1000534,
	XK_Armenian_da = 0x1000564,
	XK_Armenian_YECH = 0x1000535,
	XK_Armenian_yech = 0x1000565,
	XK_Armenian_ZA = 0x1000536,
	XK_Armenian_za = 0x1000566,
	XK_Armenian_E = 0x1000537,
	XK_Armenian_e = 0x1000567,
	XK_Armenian_AT = 0x1000538,
	XK_Armenian_at = 0x1000568,
	XK_Armenian_TO = 0x1000539,
	XK_Armenian_to = 0x1000569,
	XK_Armenian_ZHE = 0x100053a,
	XK_Armenian_zhe = 0x100056a,
	XK_Armenian_INI = 0x100053b,
	XK_Armenian_ini = 0x100056b,
	XK_Armenian_LYUN = 0x100053c,
	XK_Armenian_lyun = 0x100056c,
	XK_Armenian_KHE = 0x100053d,
	XK_Armenian_khe = 0x100056d,
	XK_Armenian_TSA = 0x100053e,
	XK_Armenian_tsa = 0x100056e,
	XK_Armenian_KEN = 0x100053f,
	XK_Armenian_ken = 0x100056f,
	XK_Armenian_HO = 0x1000540,
	XK_Armenian_ho = 0x1000570,
	XK_Armenian_DZA = 0x1000541,
	XK_Armenian_dza = 0x1000571,
	XK_Armenian_GHAT = 0x1000542,
	XK_Armenian_ghat = 0x1000572,
	XK_Armenian_TCHE = 0x1000543,
	XK_Armenian_tche = 0x1000573,
	XK_Armenian_MEN = 0x1000544,
	XK_Armenian_men = 0x1000574,
	XK_Armenian_HI = 0x1000545,
	XK_Armenian_hi = 0x1000575,
	XK_Armenian_NU = 0x1000546,
	XK_Armenian_nu = 0x1000576,
	XK_Armenian_SHA = 0x1000547,
	XK_Armenian_sha = 0x1000577,
	XK_Armenian_VO = 0x1000548,
	XK_Armenian_vo = 0x1000578,
	XK_Armenian_CHA = 0x1000549,
	XK_Armenian_cha = 0x1000579,
	XK_Armenian_PE = 0x100054a,
	XK_Armenian_pe = 0x100057a,
	XK_Armenian_JE = 0x100054b,
	XK_Armenian_je = 0x100057b,
	XK_Armenian_RA = 0x100054c,
	XK_Armenian_ra = 0x100057c,
	XK_Armenian_SE = 0x100054d,
	XK_Armenian_se = 0x100057d,
	XK_Armenian_VEV = 0x100054e,
	XK_Armenian_vev = 0x100057e,
	XK_Armenian_TYUN = 0x100054f,
	XK_Armenian_tyun = 0x100057f,
	XK_Armenian_RE = 0x1000550,
	XK_Armenian_re = 0x1000580,
	XK_Armenian_TSO = 0x1000551,
	XK_Armenian_tso = 0x1000581,
	XK_Armenian_VYUN = 0x1000552,
	XK_Armenian_vyun = 0x1000582,
	XK_Armenian_PYUR = 0x1000553,
	XK_Armenian_pyur = 0x1000583,
	XK_Armenian_KE = 0x1000554,
	XK_Armenian_ke = 0x1000584,
	XK_Armenian_O = 0x1000555,
	XK_Armenian_o = 0x1000585,
	XK_Armenian_FE = 0x1000556,
	XK_Armenian_fe = 0x1000586,
	XK_Armenian_apostrophe = 0x100055a,
	XK_Georgian_an = 0x10010d0,
	XK_Georgian_ban = 0x10010d1,
	XK_Georgian_gan = 0x10010d2,
	XK_Georgian_don = 0x10010d3,
	XK_Georgian_en = 0x10010d4,
	XK_Georgian_vin = 0x10010d5,
	XK_Georgian_zen = 0x10010d6,
	XK_Georgian_tan = 0x10010d7,
	XK_Georgian_in = 0x10010d8,
	XK_Georgian_kan = 0x10010d9,
	XK_Georgian_las = 0x10010da,
	XK_Georgian_man = 0x10010db,
	XK_Georgian_nar = 0x10010dc,
	XK_Georgian_on = 0x10010dd,
	XK_Georgian_par = 0x10010de,
	XK_Georgian_zhar = 0x10010df,
	XK_Georgian_rae = 0x10010e0,
	XK_Georgian_san = 0x10010e1,
	XK_Georgian_tar = 0x10010e2,
	XK_Georgian_un = 0x10010e3,
	XK_Georgian_phar = 0x10010e4,
	XK_Georgian_khar = 0x10010e5,
	XK_Georgian_ghan = 0x10010e6,
	XK_Georgian_qar = 0x10010e7,
	XK_Georgian_shin = 0x10010e8,
	XK_Georgian_chin = 0x10010e9,
	XK_Georgian_can = 0x10010ea,
	XK_Georgian_jil = 0x10010eb,
	XK_Georgian_cil = 0x10010ec,
	XK_Georgian_char = 0x10010ed,
	XK_Georgian_xan = 0x10010ee,
	XK_Georgian_jhan = 0x10010ef,
	XK_Georgian_hae = 0x10010f0,
	XK_Georgian_he = 0x10010f1,
	XK_Georgian_hie = 0x10010f2,
	XK_Georgian_we = 0x10010f3,
	XK_Georgian_har = 0x10010f4,
	XK_Georgian_hoe = 0x10010f5,
	XK_Georgian_fi = 0x10010f6,
	XK_Xabovedot = 0x1001e8a,
	XK_Ibreve = 0x100012c,
	XK_Zstroke = 0x10001b5,
	XK_Gcaron = 0x10001e6,
	XK_Ocaron = 0x10001d1,
	XK_Obarred = 0x100019f,
	XK_xabovedot = 0x1001e8b,
	XK_ibreve = 0x100012d,
	XK_zstroke = 0x10001b6,
	XK_gcaron = 0x10001e7,
	XK_ocaron = 0x10001d2,
	XK_obarred = 0x1000275,
	XK_SCHWA = 0x100018f,
	XK_schwa = 0x1000259,
	XK_EZH = 0x10001b7,
	XK_ezh = 0x1000292,
	XK_Lbelowdot = 0x1001e36,
	XK_lbelowdot = 0x1001e37,
	XK_Abelowdot = 0x1001ea0,
	XK_abelowdot = 0x1001ea1,
	XK_Ahook = 0x1001ea2,
	XK_ahook = 0x1001ea3,
	XK_Acircumflexacute = 0x1001ea4,
	XK_acircumflexacute = 0x1001ea5,
	XK_Acircumflexgrave = 0x1001ea6,
	XK_acircumflexgrave = 0x1001ea7,
	XK_Acircumflexhook = 0x1001ea8,
	XK_acircumflexhook = 0x1001ea9,
	XK_Acircumflextilde = 0x1001eaa,
	XK_acircumflextilde = 0x1001eab,
	XK_Acircumflexbelowdot = 0x1001eac,
	XK_acircumflexbelowdot = 0x1001ead,
	XK_Abreveacute = 0x1001eae,
	XK_abreveacute = 0x1001eaf,
	XK_Abrevegrave = 0x1001eb0,
	XK_abrevegrave = 0x1001eb1,
	XK_Abrevehook = 0x1001eb2,
	XK_abrevehook = 0x1001eb3,
	XK_Abrevetilde = 0x1001eb4,
	XK_abrevetilde = 0x1001eb5,
	XK_Abrevebelowdot = 0x1001eb6,
	XK_abrevebelowdot = 0x1001eb7,
	XK_Ebelowdot = 0x1001eb8,
	XK_ebelowdot = 0x1001eb9,
	XK_Ehook = 0x1001eba,
	XK_ehook = 0x1001ebb,
	XK_Etilde = 0x1001ebc,
	XK_etilde = 0x1001ebd,
	XK_Ecircumflexacute = 0x1001ebe,
	XK_ecircumflexacute = 0x1001ebf,
	XK_Ecircumflexgrave = 0x1001ec0,
	XK_ecircumflexgrave = 0x1001ec1,
	XK_Ecircumflexhook = 0x1001ec2,
	XK_ecircumflexhook = 0x1001ec3,
	XK_Ecircumflextilde = 0x1001ec4,
	XK_ecircumflextilde = 0x1001ec5,
	XK_Ecircumflexbelowdot = 0x1001ec6,
	XK_ecircumflexbelowdot = 0x1001ec7,
	XK_Ihook = 0x1001ec8,
	XK_ihook = 0x1001ec9,
	XK_Ibelowdot = 0x1001eca,
	XK_ibelowdot = 0x1001ecb,
	XK_Obelowdot = 0x1001ecc,
	XK_obelowdot = 0x1001ecd,
	XK_Ohook = 0x1001ece,
	XK_ohook = 0x1001ecf,
	XK_Ocircumflexacute = 0x1001ed0,
	XK_ocircumflexacute = 0x1001ed1,
	XK_Ocircumflexgrave = 0x1001ed2,
	XK_ocircumflexgrave = 0x1001ed3,
	XK_Ocircumflexhook = 0x1001ed4,
	XK_ocircumflexhook = 0x1001ed5,
	XK_Ocircumflextilde = 0x1001ed6,
	XK_ocircumflextilde = 0x1001ed7,
	XK_Ocircumflexbelowdot = 0x1001ed8,
	XK_ocircumflexbelowdot = 0x1001ed9,
	XK_Ohornacute = 0x1001eda,
	XK_ohornacute = 0x1001edb,
	XK_Ohorngrave = 0x1001edc,
	XK_ohorngrave = 0x1001edd,
	XK_Ohornhook = 0x1001ede,
	XK_ohornhook = 0x1001edf,
	XK_Ohorntilde = 0x1001ee0,
	XK_ohorntilde = 0x1001ee1,
	XK_Ohornbelowdot = 0x1001ee2,
	XK_ohornbelowdot = 0x1001ee3,
	XK_Ubelowdot = 0x1001ee4,
	XK_ubelowdot = 0x1001ee5,
	XK_Uhook = 0x1001ee6,
	XK_uhook = 0x1001ee7,
	XK_Uhornacute = 0x1001ee8,
	XK_uhornacute = 0x1001ee9,
	XK_Uhorngrave = 0x1001eea,
	XK_uhorngrave = 0x1001eeb,
	XK_Uhornhook = 0x1001eec,
	XK_uhornhook = 0x1001eed,
	XK_Uhorntilde = 0x1001eee,
	XK_uhorntilde = 0x1001eef,
	XK_Uhornbelowdot = 0x1001ef0,
	XK_uhornbelowdot = 0x1001ef1,
	XK_Ybelowdot = 0x1001ef4,
	XK_ybelowdot = 0x1001ef5,
	XK_Yhook = 0x1001ef6,
	XK_yhook = 0x1001ef7,
	XK_Ytilde = 0x1001ef8,
	XK_ytilde = 0x1001ef9,
	XK_Ohorn = 0x10001a0,
	XK_ohorn = 0x10001a1,
	XK_Uhorn = 0x10001af,
	XK_uhorn = 0x10001b0,
	XK_EcuSign = 0x10020a0,
	XK_ColonSign = 0x10020a1,
	XK_CruzeiroSign = 0x10020a2,
	XK_FFrancSign = 0x10020a3,
	XK_LiraSign = 0x10020a4,
	XK_MillSign = 0x10020a5,
	XK_NairaSign = 0x10020a6,
	XK_PesetaSign = 0x10020a7,
	XK_RupeeSign = 0x10020a8,
	XK_WonSign = 0x10020a9,
	XK_NewSheqelSign = 0x10020aa,
	XK_DongSign = 0x10020ab,
	XK_EuroSign = 0x20ac,
	XK_zerosuperior = 0x1002070,
	XK_foursuperior = 0x1002074,
	XK_fivesuperior = 0x1002075,
	XK_sixsuperior = 0x1002076,
	XK_sevensuperior = 0x1002077,
	XK_eightsuperior = 0x1002078,
	XK_ninesuperior = 0x1002079,
	XK_zerosubscript = 0x1002080,
	XK_onesubscript = 0x1002081,
	XK_twosubscript = 0x1002082,
	XK_threesubscript = 0x1002083,
	XK_foursubscript = 0x1002084,
	XK_fivesubscript = 0x1002085,
	XK_sixsubscript = 0x1002086,
	XK_sevensubscript = 0x1002087,
	XK_eightsubscript = 0x1002088,
	XK_ninesubscript = 0x1002089,
	XK_partdifferential = 0x1002202,
	XK_emptyset = 0x1002205,
	XK_elementof = 0x1002208,
	XK_notelementof = 0x1002209,
	XK_containsas = 0x100220B,
	XK_squareroot = 0x100221A,
	XK_cuberoot = 0x100221B,
	XK_fourthroot = 0x100221C,
	XK_dintegral = 0x100222C,
	XK_tintegral = 0x100222D,
	XK_because = 0x1002235,
	XK_approxeq = 0x1002248,
	XK_notapproxeq = 0x1002247,
	XK_notidentical = 0x1002262,
	XK_stricteq = 0x1002263,
	XK_braille_dot_1 = 0xfff1,
	XK_braille_dot_2 = 0xfff2,
	XK_braille_dot_3 = 0xfff3,
	XK_braille_dot_4 = 0xfff4,
	XK_braille_dot_5 = 0xfff5,
	XK_braille_dot_6 = 0xfff6,
	XK_braille_dot_7 = 0xfff7,
	XK_braille_dot_8 = 0xfff8,
	XK_braille_dot_9 = 0xfff9,
	XK_braille_dot_10 = 0xfffa,
	XK_braille_blank = 0x1002800,
	XK_braille_dots_1 = 0x1002801,
	XK_braille_dots_2 = 0x1002802,
	XK_braille_dots_12 = 0x1002803,
	XK_braille_dots_3 = 0x1002804,
	XK_braille_dots_13 = 0x1002805,
	XK_braille_dots_23 = 0x1002806,
	XK_braille_dots_123 = 0x1002807,
	XK_braille_dots_4 = 0x1002808,
	XK_braille_dots_14 = 0x1002809,
	XK_braille_dots_24 = 0x100280a,
	XK_braille_dots_124 = 0x100280b,
	XK_braille_dots_34 = 0x100280c,
	XK_braille_dots_134 = 0x100280d,
	XK_braille_dots_234 = 0x100280e,
	XK_braille_dots_1234 = 0x100280f,
	XK_braille_dots_5 = 0x1002810,
	XK_braille_dots_15 = 0x1002811,
	XK_braille_dots_25 = 0x1002812,
	XK_braille_dots_125 = 0x1002813,
	XK_braille_dots_35 = 0x1002814,
	XK_braille_dots_135 = 0x1002815,
	XK_braille_dots_235 = 0x1002816,
	XK_braille_dots_1235 = 0x1002817,
	XK_braille_dots_45 = 0x1002818,
	XK_braille_dots_145 = 0x1002819,
	XK_braille_dots_245 = 0x100281a,
	XK_braille_dots_1245 = 0x100281b,
	XK_braille_dots_345 = 0x100281c,
	XK_braille_dots_1345 = 0x100281d,
	XK_braille_dots_2345 = 0x100281e,
	XK_braille_dots_12345 = 0x100281f,
	XK_braille_dots_6 = 0x1002820,
	XK_braille_dots_16 = 0x1002821,
	XK_braille_dots_26 = 0x1002822,
	XK_braille_dots_126 = 0x1002823,
	XK_braille_dots_36 = 0x1002824,
	XK_braille_dots_136 = 0x1002825,
	XK_braille_dots_236 = 0x1002826,
	XK_braille_dots_1236 = 0x1002827,
	XK_braille_dots_46 = 0x1002828,
	XK_braille_dots_146 = 0x1002829,
	XK_braille_dots_246 = 0x100282a,
	XK_braille_dots_1246 = 0x100282b,
	XK_braille_dots_346 = 0x100282c,
	XK_braille_dots_1346 = 0x100282d,
	XK_braille_dots_2346 = 0x100282e,
	XK_braille_dots_12346 = 0x100282f,
	XK_braille_dots_56 = 0x1002830,
	XK_braille_dots_156 = 0x1002831,
	XK_braille_dots_256 = 0x1002832,
	XK_braille_dots_1256 = 0x1002833,
	XK_braille_dots_356 = 0x1002834,
	XK_braille_dots_1356 = 0x1002835,
	XK_braille_dots_2356 = 0x1002836,
	XK_braille_dots_12356 = 0x1002837,
	XK_braille_dots_456 = 0x1002838,
	XK_braille_dots_1456 = 0x1002839,
	XK_braille_dots_2456 = 0x100283a,
	XK_braille_dots_12456 = 0x100283b,
	XK_braille_dots_3456 = 0x100283c,
	XK_braille_dots_13456 = 0x100283d,
	XK_braille_dots_23456 = 0x100283e,
	XK_braille_dots_123456 = 0x100283f,
	XK_braille_dots_7 = 0x1002840,
	XK_braille_dots_17 = 0x1002841,
	XK_braille_dots_27 = 0x1002842,
	XK_braille_dots_127 = 0x1002843,
	XK_braille_dots_37 = 0x1002844,
	XK_braille_dots_137 = 0x1002845,
	XK_braille_dots_237 = 0x1002846,
	XK_braille_dots_1237 = 0x1002847,
	XK_braille_dots_47 = 0x1002848,
	XK_braille_dots_147 = 0x1002849,
	XK_braille_dots_247 = 0x100284a,
	XK_braille_dots_1247 = 0x100284b,
	XK_braille_dots_347 = 0x100284c,
	XK_braille_dots_1347 = 0x100284d,
	XK_braille_dots_2347 = 0x100284e,
	XK_braille_dots_12347 = 0x100284f,
	XK_braille_dots_57 = 0x1002850,
	XK_braille_dots_157 = 0x1002851,
	XK_braille_dots_257 = 0x1002852,
	XK_braille_dots_1257 = 0x1002853,
	XK_braille_dots_357 = 0x1002854,
	XK_braille_dots_1357 = 0x1002855,
	XK_braille_dots_2357 = 0x1002856,
	XK_braille_dots_12357 = 0x1002857,
	XK_braille_dots_457 = 0x1002858,
	XK_braille_dots_1457 = 0x1002859,
	XK_braille_dots_2457 = 0x100285a,
	XK_braille_dots_12457 = 0x100285b,
	XK_braille_dots_3457 = 0x100285c,
	XK_braille_dots_13457 = 0x100285d,
	XK_braille_dots_23457 = 0x100285e,
	XK_braille_dots_123457 = 0x100285f,
	XK_braille_dots_67 = 0x1002860,
	XK_braille_dots_167 = 0x1002861,
	XK_braille_dots_267 = 0x1002862,
	XK_braille_dots_1267 = 0x1002863,
	XK_braille_dots_367 = 0x1002864,
	XK_braille_dots_1367 = 0x1002865,
	XK_braille_dots_2367 = 0x1002866,
	XK_braille_dots_12367 = 0x1002867,
	XK_braille_dots_467 = 0x1002868,
	XK_braille_dots_1467 = 0x1002869,
	XK_braille_dots_2467 = 0x100286a,
	XK_braille_dots_12467 = 0x100286b,
	XK_braille_dots_3467 = 0x100286c,
	XK_braille_dots_13467 = 0x100286d,
	XK_braille_dots_23467 = 0x100286e,
	XK_braille_dots_123467 = 0x100286f,
	XK_braille_dots_567 = 0x1002870,
	XK_braille_dots_1567 = 0x1002871,
	XK_braille_dots_2567 = 0x1002872,
	XK_braille_dots_12567 = 0x1002873,
	XK_braille_dots_3567 = 0x1002874,
	XK_braille_dots_13567 = 0x1002875,
	XK_braille_dots_23567 = 0x1002876,
	XK_braille_dots_123567 = 0x1002877,
	XK_braille_dots_4567 = 0x1002878,
	XK_braille_dots_14567 = 0x1002879,
	XK_braille_dots_24567 = 0x100287a,
	XK_braille_dots_124567 = 0x100287b,
	XK_braille_dots_34567 = 0x100287c,
	XK_braille_dots_134567 = 0x100287d,
	XK_braille_dots_234567 = 0x100287e,
	XK_braille_dots_1234567 = 0x100287f,
	XK_braille_dots_8 = 0x1002880,
	XK_braille_dots_18 = 0x1002881,
	XK_braille_dots_28 = 0x1002882,
	XK_braille_dots_128 = 0x1002883,
	XK_braille_dots_38 = 0x1002884,
	XK_braille_dots_138 = 0x1002885,
	XK_braille_dots_238 = 0x1002886,
	XK_braille_dots_1238 = 0x1002887,
	XK_braille_dots_48 = 0x1002888,
	XK_braille_dots_148 = 0x1002889,
	XK_braille_dots_248 = 0x100288a,
	XK_braille_dots_1248 = 0x100288b,
	XK_braille_dots_348 = 0x100288c,
	XK_braille_dots_1348 = 0x100288d,
	XK_braille_dots_2348 = 0x100288e,
	XK_braille_dots_12348 = 0x100288f,
	XK_braille_dots_58 = 0x1002890,
	XK_braille_dots_158 = 0x1002891,
	XK_braille_dots_258 = 0x1002892,
	XK_braille_dots_1258 = 0x1002893,
	XK_braille_dots_358 = 0x1002894,
	XK_braille_dots_1358 = 0x1002895,
	XK_braille_dots_2358 = 0x1002896,
	XK_braille_dots_12358 = 0x1002897,
	XK_braille_dots_458 = 0x1002898,
	XK_braille_dots_1458 = 0x1002899,
	XK_braille_dots_2458 = 0x100289a,
	XK_braille_dots_12458 = 0x100289b,
	XK_braille_dots_3458 = 0x100289c,
	XK_braille_dots_13458 = 0x100289d,
	XK_braille_dots_23458 = 0x100289e,
	XK_braille_dots_123458 = 0x100289f,
	XK_braille_dots_68 = 0x10028a0,
	XK_braille_dots_168 = 0x10028a1,
	XK_braille_dots_268 = 0x10028a2,
	XK_braille_dots_1268 = 0x10028a3,
	XK_braille_dots_368 = 0x10028a4,
	XK_braille_dots_1368 = 0x10028a5,
	XK_braille_dots_2368 = 0x10028a6,
	XK_braille_dots_12368 = 0x10028a7,
	XK_braille_dots_468 = 0x10028a8,
	XK_braille_dots_1468 = 0x10028a9,
	XK_braille_dots_2468 = 0x10028aa,
	XK_braille_dots_12468 = 0x10028ab,
	XK_braille_dots_3468 = 0x10028ac,
	XK_braille_dots_13468 = 0x10028ad,
	XK_braille_dots_23468 = 0x10028ae,
	XK_braille_dots_123468 = 0x10028af,
	XK_braille_dots_568 = 0x10028b0,
	XK_braille_dots_1568 = 0x10028b1,
	XK_braille_dots_2568 = 0x10028b2,
	XK_braille_dots_12568 = 0x10028b3,
	XK_braille_dots_3568 = 0x10028b4,
	XK_braille_dots_13568 = 0x10028b5,
	XK_braille_dots_23568 = 0x10028b6,
	XK_braille_dots_123568 = 0x10028b7,
	XK_braille_dots_4568 = 0x10028b8,
	XK_braille_dots_14568 = 0x10028b9,
	XK_braille_dots_24568 = 0x10028ba,
	XK_braille_dots_124568 = 0x10028bb,
	XK_braille_dots_34568 = 0x10028bc,
	XK_braille_dots_134568 = 0x10028bd,
	XK_braille_dots_234568 = 0x10028be,
	XK_braille_dots_1234568 = 0x10028bf,
	XK_braille_dots_78 = 0x10028c0,
	XK_braille_dots_178 = 0x10028c1,
	XK_braille_dots_278 = 0x10028c2,
	XK_braille_dots_1278 = 0x10028c3,
	XK_braille_dots_378 = 0x10028c4,
	XK_braille_dots_1378 = 0x10028c5,
	XK_braille_dots_2378 = 0x10028c6,
	XK_braille_dots_12378 = 0x10028c7,
	XK_braille_dots_478 = 0x10028c8,
	XK_braille_dots_1478 = 0x10028c9,
	XK_braille_dots_2478 = 0x10028ca,
	XK_braille_dots_12478 = 0x10028cb,
	XK_braille_dots_3478 = 0x10028cc,
	XK_braille_dots_13478 = 0x10028cd,
	XK_braille_dots_23478 = 0x10028ce,
	XK_braille_dots_123478 = 0x10028cf,
	XK_braille_dots_578 = 0x10028d0,
	XK_braille_dots_1578 = 0x10028d1,
	XK_braille_dots_2578 = 0x10028d2,
	XK_braille_dots_12578 = 0x10028d3,
	XK_braille_dots_3578 = 0x10028d4,
	XK_braille_dots_13578 = 0x10028d5,
	XK_braille_dots_23578 = 0x10028d6,
	XK_braille_dots_123578 = 0x10028d7,
	XK_braille_dots_4578 = 0x10028d8,
	XK_braille_dots_14578 = 0x10028d9,
	XK_braille_dots_24578 = 0x10028da,
	XK_braille_dots_124578 = 0x10028db,
	XK_braille_dots_34578 = 0x10028dc,
	XK_braille_dots_134578 = 0x10028dd,
	XK_braille_dots_234578 = 0x10028de,
	XK_braille_dots_1234578 = 0x10028df,
	XK_braille_dots_678 = 0x10028e0,
	XK_braille_dots_1678 = 0x10028e1,
	XK_braille_dots_2678 = 0x10028e2,
	XK_braille_dots_12678 = 0x10028e3,
	XK_braille_dots_3678 = 0x10028e4,
	XK_braille_dots_13678 = 0x10028e5,
	XK_braille_dots_23678 = 0x10028e6,
	XK_braille_dots_123678 = 0x10028e7,
	XK_braille_dots_4678 = 0x10028e8,
	XK_braille_dots_14678 = 0x10028e9,
	XK_braille_dots_24678 = 0x10028ea,
	XK_braille_dots_124678 = 0x10028eb,
	XK_braille_dots_34678 = 0x10028ec,
	XK_braille_dots_134678 = 0x10028ed,
	XK_braille_dots_234678 = 0x10028ee,
	XK_braille_dots_1234678 = 0x10028ef,
	XK_braille_dots_5678 = 0x10028f0,
	XK_braille_dots_15678 = 0x10028f1,
	XK_braille_dots_25678 = 0x10028f2,
	XK_braille_dots_125678 = 0x10028f3,
	XK_braille_dots_35678 = 0x10028f4,
	XK_braille_dots_135678 = 0x10028f5,
	XK_braille_dots_235678 = 0x10028f6,
	XK_braille_dots_1235678 = 0x10028f7,
	XK_braille_dots_45678 = 0x10028f8,
	XK_braille_dots_145678 = 0x10028f9,
	XK_braille_dots_245678 = 0x10028fa,
	XK_braille_dots_1245678 = 0x10028fb,
	XK_braille_dots_345678 = 0x10028fc,
	XK_braille_dots_1345678 = 0x10028fd,
	XK_braille_dots_2345678 = 0x10028fe,
	XK_braille_dots_12345678 = 0x10028ff,
	XK_Sinh_ng = 0x1000d82,
	XK_Sinh_h2 = 0x1000d83,
	XK_Sinh_a = 0x1000d85,
	XK_Sinh_aa = 0x1000d86,
	XK_Sinh_ae = 0x1000d87,
	XK_Sinh_aee = 0x1000d88,
	XK_Sinh_i = 0x1000d89,
	XK_Sinh_ii = 0x1000d8a,
	XK_Sinh_u = 0x1000d8b,
	XK_Sinh_uu = 0x1000d8c,
	XK_Sinh_ri = 0x1000d8d,
	XK_Sinh_rii = 0x1000d8e,
	XK_Sinh_lu = 0x1000d8f,
	XK_Sinh_luu = 0x1000d90,
	XK_Sinh_e = 0x1000d91,
	XK_Sinh_ee = 0x1000d92,
	XK_Sinh_ai = 0x1000d93,
	XK_Sinh_o = 0x1000d94,
	XK_Sinh_oo = 0x1000d95,
	XK_Sinh_au = 0x1000d96,
	XK_Sinh_ka = 0x1000d9a,
	XK_Sinh_kha = 0x1000d9b,
	XK_Sinh_ga = 0x1000d9c,
	XK_Sinh_gha = 0x1000d9d,
	XK_Sinh_ng2 = 0x1000d9e,
	XK_Sinh_nga = 0x1000d9f,
	XK_Sinh_ca = 0x1000da0,
	XK_Sinh_cha = 0x1000da1,
	XK_Sinh_ja = 0x1000da2,
	XK_Sinh_jha = 0x1000da3,
	XK_Sinh_nya = 0x1000da4,
	XK_Sinh_jnya = 0x1000da5,
	XK_Sinh_nja = 0x1000da6,
	XK_Sinh_tta = 0x1000da7,
	XK_Sinh_ttha = 0x1000da8,
	XK_Sinh_dda = 0x1000da9,
	XK_Sinh_ddha = 0x1000daa,
	XK_Sinh_nna = 0x1000dab,
	XK_Sinh_ndda = 0x1000dac,
	XK_Sinh_tha = 0x1000dad,
	XK_Sinh_thha = 0x1000dae,
	XK_Sinh_dha = 0x1000daf,
	XK_Sinh_dhha = 0x1000db0,
	XK_Sinh_na = 0x1000db1,
	XK_Sinh_ndha = 0x1000db3,
	XK_Sinh_pa = 0x1000db4,
	XK_Sinh_pha = 0x1000db5,
	XK_Sinh_ba = 0x1000db6,
	XK_Sinh_bha = 0x1000db7,
	XK_Sinh_ma = 0x1000db8,
	XK_Sinh_mba = 0x1000db9,
	XK_Sinh_ya = 0x1000dba,
	XK_Sinh_ra = 0x1000dbb,
	XK_Sinh_la = 0x1000dbd,
	XK_Sinh_va = 0x1000dc0,
	XK_Sinh_sha = 0x1000dc1,
	XK_Sinh_ssha = 0x1000dc2,
	XK_Sinh_sa = 0x1000dc3,
	XK_Sinh_ha = 0x1000dc4,
	XK_Sinh_lla = 0x1000dc5,
	XK_Sinh_fa = 0x1000dc6,
	XK_Sinh_al = 0x1000dca,
	XK_Sinh_aa2 = 0x1000dcf,
	XK_Sinh_ae2 = 0x1000dd0,
	XK_Sinh_aee2 = 0x1000dd1,
	XK_Sinh_i2 = 0x1000dd2,
	XK_Sinh_ii2 = 0x1000dd3,
	XK_Sinh_u2 = 0x1000dd4,
	XK_Sinh_uu2 = 0x1000dd6,
	XK_Sinh_ru2 = 0x1000dd8,
	XK_Sinh_e2 = 0x1000dd9,
	XK_Sinh_ee2 = 0x1000dda,
	XK_Sinh_ai2 = 0x1000ddb,
	XK_Sinh_o2 = 0x1000ddc,
	XK_Sinh_oo2 = 0x1000ddd,
	XK_Sinh_au2 = 0x1000dde,
	XK_Sinh_lu2 = 0x1000ddf,
	XK_Sinh_ruu2 = 0x1000df2,
	XK_Sinh_luu2 = 0x1000df3,
	XK_Sinh_kunddaliya = 0x1000df4,
}

struct Macros {
	@disable this();

	static auto destroyImage(T)(auto ref T ximage) {
		return (*ximage.f.destroy_image)(ximage);
	}

	static auto getPixel(T0, T1, T2)(auto ref T0 ximage, auto ref T1 x, auto ref T2 y) {
		return (*ximage.f.get_pixel)(ximage, x, y);
	}

	static auto putPixel(T0, T1, T2, T3)(auto ref T0 ximage, auto ref T1 x, auto ref T2 y, auto ref T3 pixel) {
		return (*ximage.f.put_pixel)(ximage, x, y, pixel);
	}

	static auto subImage(T0, T1, T2, T3, T4)(auto ref T0 ximage, auto ref T1 x, auto ref T2 y, auto ref T3 width,
			auto ref T4 height) {
		return (*ximage.f.sub_image)(ximage, x, y, width, height);
	}

	static auto addPixel(T0, T1)(auto ref T0 ximage, auto ref T1 value) {
		return (*ximage.f.add_pixel)(ximage, value);
	}

	static auto isKeypadKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= Keysym.XK_KP_Space) && (cast(KeySym) keysym <= Keysym.XK_KP_Equal);
	}

	static auto isPrivateKeypadKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= 0x11000000) && (cast(KeySym) keysym <= 0x1100FFFF);
	}

	static auto isCursorKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= Keysym.XK_Home) && (cast(KeySym) keysym < Keysym.XK_Select);
	}

	static auto isPFKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= Keysym.XK_KP_F1) && (cast(KeySym) keysym <= Keysym.XK_KP_F4);
	}

	static auto isFunctionKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= Keysym.XK_F1) && (cast(KeySym) keysym <= Keysym.XK_F35);
	}

	static auto isMiscFunctionKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= Keysym.XK_Select) && (cast(KeySym) keysym <= Keysym.XK_Break);
	}

	static auto isModifierKey(T)(auto ref T keysym) {
		return ((cast(KeySym) keysym >= Keysym.XK_Shift_L) && (cast(KeySym) keysym <= Keysym.XK_Hyper_R)) || ((cast(
				KeySym) keysym >= Keysym.XK_ISO_Lock) && (cast(KeySym) keysym <= Keysym.XK_ISO_Level5_Lock))
				|| (cast(KeySym) keysym == Keysym.XK_Mode_switch) || (
				cast(KeySym) keysym == Keysym.XK_Num_Lock);
	}

}

interface X11 {
	extern(System) @nogc nothrow:

	void close();

	XFontStruct* loadQueryFont(Display*, const(char)*);
	XFontStruct* queryFont(Display*, XID);
	XTimeCoord* getMotionEvents(Display*, Window, Time, Time, int*);
	XModifierKeymap* deleteModifiermapEntry(XModifierKeymap*, KeyCode, int);
	XModifierKeymap* getModifierMapping(Display*);
	XModifierKeymap* insertModifiermapEntry(XModifierKeymap*, KeyCode, int);
	XModifierKeymap* newModifiermap(int);
	XImage* createImage(Display*, Visual*, uint, int, int, char*, uint, uint, int, int);
	int initImage(XImage*);
	XImage* getImage(Display*, Drawable, int, int, uint, uint, c_ulong, int);
	XImage* getSubImage(Display*, Drawable, int, int, uint, uint, c_ulong, int, XImage*, int, int);
	Display* openDisplay(const(char)*);
	// void rmInitialize();
	char* fetchBytes(Display*, int*);
	char* fetchBuffer(Display*, int*, int);
	char* getAtomName(Display*, Atom);
	int getAtomNames(Display*, Atom*, int, char**);
	char* getDefault(Display*, const(char)*, const(char)*);
	char* displayName(const(char)*);
	char* keysymToString(KeySym);
	int function(Display*, Display*, int) synchronize(Display*, Display*, int);
	int function(Display*, Display*, int function(Display*)) setAfterFunction(Display*, Display*, int function(Display*));
	Atom internAtom(Display*, const(char)*, int);
	int internAtoms(Display*, char**, int, int, Atom*);
	Colormap copyColormapAndFree(Display*, Colormap);
	Colormap createColormap(Display*, Window, Visual*, int);
	Cursor createPixmapCursor(Display*, Pixmap, Pixmap, XColor*, XColor*, uint, uint);
	Cursor createGlyphCursor(Display*, Font, Font, uint, uint, const(XColor)*, const(XColor)*);
	Cursor createFontCursor(Display*, uint);
	Font loadFont(Display*, const(char)*);
	GC createGC(Display*, Drawable, c_ulong, XGCValues*);
	GContext gContextFromGC(GC);
	void flushGC(Display*, GC);
	Pixmap createPixmap(Display*, Drawable, uint, uint, uint);
	Pixmap createBitmapFromData(Display*, Drawable, const(char)*, uint, uint);
	Pixmap createPixmapFromBitmapData(Display*, Drawable, char*, uint, uint, c_ulong, c_ulong, uint);
	Window createSimpleWindow(Display*, Window, int, int, uint, uint, uint, c_ulong, c_ulong);
	Window getSelectionOwner(Display*, Atom);
	Window createWindow(Display*, Window, int, int, uint, uint, uint, int, uint, Visual*, c_ulong, XSetWindowAttributes*);
	Colormap* listInstalledColormaps(Display*, Window, int*);
	char** listFonts(Display*, const(char)*, int, int*);
	char** listFontsWithInfo(Display*, const(char)*, int, int*, XFontStruct**);
	char** getFontPath(Display*, int*);
	char** listExtensions(Display*, int*);
	Atom* listProperties(Display*, Window, int*);
	XHostAddress* listHosts(Display*, int*, int*);
	KeySym keycodeToKeysym(Display*, KeyCode, int);
	KeySym lookupKeysym(XKeyEvent*, int);
	KeySym* getKeyboardMapping(Display*, KeyCode, int, int*);
	KeySym stringToKeysym(const(char)*);
	c_long maxRequestSize(Display*);
	c_long extendedMaxRequestSize(Display*);
	char* resourceManagerString(Display*);
	char* screenResourceString(Screen*);
	c_ulong displayMotionBufferSize(Display*);
	VisualID visualIDFromVisual(Visual*);
	int initThreads();
	void lockDisplay(Display*);
	void unlockDisplay(Display*);
	XExtCodes* initExtension(Display*, const(char)*);
	XExtCodes* addExtension(Display*);
	XExtData* findOnExtensionList(XExtData**, int);
	XExtData** eHeadOfExtensionList(XEDataObject);
	Window rootWindow(Display*, int);
	Window defaultRootWindow(Display*);
	Window rootWindowOfScreen(Screen*);
	Visual* defaultVisual(Display*, int);
	Visual* defaultVisualOfScreen(Screen*);
	GC defaultGC(Display*, int);
	GC defaultGCOfScreen(Screen*);
	c_ulong blackPixel(Display*, int);
	c_ulong whitePixel(Display*, int);
	c_ulong allPlanes();
	c_ulong blackPixelOfScreen(Screen*);
	c_ulong whitePixelOfScreen(Screen*);
	c_ulong nextRequest(Display*);
	c_ulong lastKnownRequestProcessed(Display*);
	char* serverVendor(Display*);
	char* displayString(Display*);
	Colormap defaultColormap(Display*, int);
	Colormap defaultColormapOfScreen(Screen*);
	Display* displayOfScreen(Screen*);
	Screen* screenOfDisplay(Display*, int);
	Screen* defaultScreenOfDisplay(Display*);
	c_long eventMaskOfScreen(Screen*);
	int screenNumberOfScreen(Screen*);
	XErrorHandler setErrorHandler(XErrorHandler);
	XIOErrorHandler setIOErrorHandler(XIOErrorHandler);
	XPixmapFormatValues* listPixmapFormats(Display*, int*);
	int* listDepths(Display*, int, int*);
	int reconfigureWMWindow(Display*, Window, int, uint, XWindowChanges*);
	int getWMProtocols(Display*, Window, Atom**, int*);
	int setWMProtocols(Display*, Window, Atom*, int);
	int iconifyWindow(Display*, Window, int);
	int withdrawWindow(Display*, Window, int);
	int getCommand(Display*, Window, char***, int*);
	int getWMColormapWindows(Display*, Window, Window**, int*);
	int setWMColormapWindows(Display*, Window, Window*, int);
	void freeStringList(char**);
	int setTransientForHint(Display*, Window, Window);
	int activateScreenSaver(Display*);
	int addHost(Display*, XHostAddress*);
	int addHosts(Display*, XHostAddress*, int);
	int addToExtensionList(XExtData**, XExtData*);
	int addToSaveSet(Display*, Window);
	int allocColor(Display*, Colormap, XColor*);
	int allocColorCells(Display*, Colormap, int, c_ulong*, uint, c_ulong*, uint);
	int allocColorPlanes(Display*, Colormap, int, c_ulong*, int, int, int, int, c_ulong*, c_ulong*, c_ulong*);
	int allocNamedColor(Display*, Colormap, const(char)*, XColor*, XColor*);
	int allowEvents(Display*, int, Time);
	int autoRepeatOff(Display*);
	int autoRepeatOn(Display*);
	int bell(Display*, int);
	int bitmapBitOrder(Display*);
	int bitmapPad(Display*);
	int bitmapUnit(Display*);
	int cellsOfScreen(Screen*);
	int changeActivePointerGrab(Display*, uint, Cursor, Time);
	int changeGC(Display*, GC, c_ulong, XGCValues*);
	int changeKeyboardControl(Display*, c_ulong, XKeyboardControl*);
	int changeKeyboardMapping(Display*, int, int, KeySym*, int);
	int changePointerControl(Display*, int, int, int, int, int);
	int changeProperty(Display*, Window, Atom, Atom, int, int, const(ubyte)*, int);
	int changeSaveSet(Display*, Window, int);
	int changeWindowAttributes(Display*, Window, c_ulong, XSetWindowAttributes*);
	int checkIfEvent(Display*, XEvent*, int function(Display*, XEvent*, XPointer), XPointer);
	int checkMaskEvent(Display*, c_long, XEvent*);
	int checkTypedEvent(Display*, int, XEvent*);
	int checkTypedWindowEvent(Display*, Window, int, XEvent*);
	int checkWindowEvent(Display*, Window, c_long, XEvent*);
	int circulateSubwindows(Display*, Window, int);
	int circulateSubwindowsDown(Display*, Window);
	int circulateSubwindowsUp(Display*, Window);
	int clearArea(Display*, Window, int, int, uint, uint, int);
	int clearWindow(Display*, Window);
	int closeDisplay(Display*);
	int configureWindow(Display*, Window, uint, XWindowChanges*);
	int connectionNumber(Display*);
	int convertSelection(Display*, Atom, Atom, Atom, Window, Time);
	int copyArea(Display*, Drawable, Drawable, GC, int, int, uint, uint, int, int);
	int copyGC(Display*, GC, c_ulong, GC);
	int copyPlane(Display*, Drawable, Drawable, GC, int, int, uint, uint, int, int, c_ulong);
	int defaultDepth(Display*, int);
	int defaultDepthOfScreen(Screen*);
	int defaultScreen(Display*);
	int defineCursor(Display*, Window, Cursor);
	int deleteProperty(Display*, Window, Atom);
	int destroyWindow(Display*, Window);
	int destroySubwindows(Display*, Window);
	int doesBackingStore(Screen*);
	int doesSaveUnders(Screen*);
	int disableAccessControl(Display*);
	int displayCells(Display*, int);
	int displayHeight(Display*, int);
	int displayHeightMM(Display*, int);
	int displayKeycodes(Display*, int*, int*);
	int displayPlanes(Display*, int);
	int displayWidth(Display*, int);
	int displayWidthMM(Display*, int);
	int drawArc(Display*, Drawable, GC, int, int, uint, uint, int, int);
	int drawArcs(Display*, Drawable, GC, XArc*, int);
	int drawImageString(Display*, Drawable, GC, int, int, const(char)*, int);
	int drawImageString16(Display*, Drawable, GC, int, int, const(XChar2b)*, int);
	int drawLine(Display*, Drawable, GC, int, int, int, int);
	int drawLines(Display*, Drawable, GC, XPoint*, int, int);
	int drawPoint(Display*, Drawable, GC, int, int);
	int drawPoints(Display*, Drawable, GC, XPoint*, int, int);
	int drawRectangle(Display*, Drawable, GC, int, int, uint, uint);
	int drawRectangles(Display*, Drawable, GC, XRectangle*, int);
	int drawSegments(Display*, Drawable, GC, XSegment*, int);
	int drawString(Display*, Drawable, GC, int, int, const(char)*, int);
	int drawString16(Display*, Drawable, GC, int, int, const(XChar2b)*, int);
	int drawText(Display*, Drawable, GC, int, int, XTextItem*, int);
	int drawText16(Display*, Drawable, GC, int, int, XTextItem16*, int);
	int enableAccessControl(Display*);
	int eventsQueued(Display*, int);
	int fetchName(Display*, Window, char**);
	int fillArc(Display*, Drawable, GC, int, int, uint, uint, int, int);
	int fillArcs(Display*, Drawable, GC, XArc*, int);
	int fillPolygon(Display*, Drawable, GC, XPoint*, int, int, int);
	int fillRectangle(Display*, Drawable, GC, int, int, uint, uint);
	int fillRectangles(Display*, Drawable, GC, XRectangle*, int);
	int flush(Display*);
	int forceScreenSaver(Display*, int);
	int free(void*);
	int freeColormap(Display*, Colormap);
	int freeColors(Display*, Colormap, c_ulong*, int, c_ulong);
	int freeCursor(Display*, Cursor);
	int freeExtensionList(char**);
	int freeFont(Display*, XFontStruct*);
	int freeFontInfo(char**, XFontStruct*, int);
	int freeFontNames(char**);
	int freeFontPath(char**);
	int freeGC(Display*, GC);
	int freeModifiermap(XModifierKeymap*);
	int freePixmap(Display*, Pixmap);
	int geometry(Display*, int, const(char)*, const(char)*, uint, uint, uint, int, int, int*, int*, int*, int*);
	int getErrorDatabaseText(Display*, const(char)*, const(char)*, const(char)*, char*, int);
	int getErrorText(Display*, int, char*, int);
	int getFontProperty(XFontStruct*, Atom, c_ulong*);
	int getGCValues(Display*, GC, c_ulong, XGCValues*);
	int getGeometry(Display*, Drawable, Window*, int*, int*, uint*, uint*, uint*, uint*);
	int getIconName(Display*, Window, char**);
	int getInputFocus(Display*, Window*, int*);
	int getKeyboardControl(Display*, XKeyboardState*);
	int getPointerControl(Display*, int*, int*, int*);
	int getPointerMapping(Display*, ubyte*, int);
	int getScreenSaver(Display*, int*, int*, int*, int*);
	int getTransientForHint(Display*, Window, Window*);
	int getWindowProperty(Display*, Window, Atom, c_long, c_long, int, Atom, Atom*, int*, c_ulong*, c_ulong*, ubyte**);
	int getWindowAttributes(Display*, Window, XWindowAttributes*);
	int grabButton(Display*, uint, uint, Window, int, uint, int, int, Window, Cursor);
	int grabKey(Display*, int, uint, Window, int, int, int);
	int grabKeyboard(Display*, Window, int, int, int, Time);
	int grabPointer(Display*, Window, int, uint, int, int, Window, Cursor, Time);
	int grabServer(Display*);
	int heightMMOfScreen(Screen*);
	int heightOfScreen(Screen*);
	int ifEvent(Display*, XEvent*, int function(Display*, XEvent*, XPointer), XPointer);
	int imageByteOrder(Display*);
	int installColormap(Display*, Colormap);
	KeyCode keysymToKeycode(Display*, KeySym);
	int killClient(Display*, XID);
	int lookupColor(Display*, Colormap, const(char)*, XColor*, XColor*);
	int lowerWindow(Display*, Window);
	int mapRaised(Display*, Window);
	int mapSubwindows(Display*, Window);
	int mapWindow(Display*, Window);
	int maskEvent(Display*, c_long, XEvent*);
	int maxCmapsOfScreen(Screen*);
	int minCmapsOfScreen(Screen*);
	int moveResizeWindow(Display*, Window, int, int, uint, uint);
	int moveWindow(Display*, Window, int, int);
	int nextEvent(Display*, XEvent*);
	int noOp(Display*);
	int parseColor(Display*, Colormap, const(char)*, XColor*);
	int parseGeometry(const(char)*, int*, int*, uint*, uint*);
	int peekEvent(Display*, XEvent*);
	int peekIfEvent(Display*, XEvent*, int function(Display*, XEvent*, XPointer), XPointer);
	int pending(Display*);
	int planesOfScreen(Screen*);
	int protocolRevision(Display*);
	int protocolVersion(Display*);
	int putBackEvent(Display*, XEvent*);
	int putImage(Display*, Drawable, GC, XImage*, int, int, int, int, uint, uint);
	int qLength(Display*);
	int queryBestCursor(Display*, Drawable, uint, uint, uint*, uint*);
	int queryBestSize(Display*, int, Drawable, uint, uint, uint*, uint*);
	int queryBestStipple(Display*, Drawable, uint, uint, uint*, uint*);
	int queryBestTile(Display*, Drawable, uint, uint, uint*, uint*);
	int queryColor(Display*, Colormap, XColor*);
	int queryColors(Display*, Colormap, XColor*, int);
	int queryExtension(Display*, const(char)*, int*, int*, int*);
	int queryKeymap(Display*, ref char[32]);
	int queryPointer(Display*, Window, Window*, Window*, int*, int*, int*, int*, uint*);
	int queryTextExtents(Display*, XID, const(char)*, int, int*, int*, int*, XCharStruct*);
	int queryTextExtents16(Display*, XID, const(XChar2b)*, int, int*, int*, int*, XCharStruct*);
	int queryTree(Display*, Window, Window*, Window*, Window**, uint*);
	int raiseWindow(Display*, Window);
	int readBitmapFile(Display*, Drawable, const(char)*, uint*, uint*, Pixmap*, int*, int*);
	int readBitmapFileData(const(char)*, uint*, uint*, ubyte**, int*, int*);
	int rebindKeysym(Display*, KeySym, KeySym*, int, const(ubyte)*, int);
	int recolorCursor(Display*, Cursor, XColor*, XColor*);
	int refreshKeyboardMapping(XMappingEvent*);
	int removeFromSaveSet(Display*, Window);
	int removeHost(Display*, XHostAddress*);
	int removeHosts(Display*, XHostAddress*, int);
	int reparentWindow(Display*, Window, Window, int, int);
	int resetScreenSaver(Display*);
	int resizeWindow(Display*, Window, uint, uint);
	int restackWindows(Display*, Window*, int);
	int rotateBuffers(Display*, int);
	int rotateWindowProperties(Display*, Window, Atom*, int, int);
	int screenCount(Display*);
	int selectInput(Display*, Window, c_long);
	int sendEvent(Display*, Window, int, c_long, XEvent*);
	int setAccessControl(Display*, int);
	int setArcMode(Display*, GC, int);
	int setBackground(Display*, GC, c_ulong);
	int setClipMask(Display*, GC, Pixmap);
	int setClipOrigin(Display*, GC, int, int);
	int setClipRectangles(Display*, GC, int, int, XRectangle*, int, int);
	int setCloseDownMode(Display*, int);
	int setCommand(Display*, Window, char**, int);
	int setDashes(Display*, GC, int, const(char)*, int);
	int setFillRule(Display*, GC, int);
	int setFillStyle(Display*, GC, int);
	int setFont(Display*, GC, Font);
	int setFontPath(Display*, char**, int);
	int setForeground(Display*, GC, c_ulong);
	int setFunction(Display*, GC, int);
	int setGraphicsExposures(Display*, GC, int);
	int setIconName(Display*, Window, const(char)*);
	int setInputFocus(Display*, Window, int, Time);
	int setLineAttributes(Display*, GC, uint, int, int, int);
	int setModifierMapping(Display*, XModifierKeymap*);
	int setPlaneMask(Display*, GC, c_ulong);
	int setPointerMapping(Display*, const(ubyte)*, int);
	int setScreenSaver(Display*, int, int, int, int);
	int setSelectionOwner(Display*, Atom, Window, Time);
	int setState(Display*, GC, c_ulong, c_ulong, int, c_ulong);
	int setStipple(Display*, GC, Pixmap);
	int setSubwindowMode(Display*, GC, int);
	int setTSOrigin(Display*, GC, int, int);
	int setTile(Display*, GC, Pixmap);
	int setWindowBackground(Display*, Window, c_ulong);
	int setWindowBackgroundPixmap(Display*, Window, Pixmap);
	int setWindowBorder(Display*, Window, c_ulong);
	int setWindowBorderPixmap(Display*, Window, Pixmap);
	int setWindowBorderWidth(Display*, Window, uint);
	int setWindowColormap(Display*, Window, Colormap);
	int storeBuffer(Display*, const(char)*, int, int);
	int storeBytes(Display*, const(char)*, int);
	int storeColor(Display*, Colormap, XColor*);
	int storeColors(Display*, Colormap, XColor*, int);
	int storeName(Display*, Window, const(char)*);
	int storeNamedColor(Display*, Colormap, const(char)*, c_ulong, int);
	int sync(Display*, int);
	int textExtents(XFontStruct*, const(char)*, int, int*, int*, int*, XCharStruct*);
	int textExtents16(XFontStruct*, const(XChar2b)*, int, int*, int*, int*, XCharStruct*);
	int textWidth(XFontStruct*, const(char)*, int);
	int textWidth16(XFontStruct*, const(XChar2b)*, int);
	int translateCoordinates(Display*, Window, Window, int, int, int*, int*, Window*);
	int undefineCursor(Display*, Window);
	int ungrabButton(Display*, uint, uint, Window);
	int ungrabKey(Display*, int, uint, Window);
	int ungrabKeyboard(Display*, Time);
	int ungrabPointer(Display*, Time);
	int ungrabServer(Display*);
	int uninstallColormap(Display*, Colormap);
	int unloadFont(Display*, Font);
	int unmapSubwindows(Display*, Window);
	int unmapWindow(Display*, Window);
	int vendorRelease(Display*);
	int warpPointer(Display*, Window, Window, int, int, uint, uint, int, int);
	int widthMMOfScreen(Screen*);
	int widthOfScreen(Screen*);
	int windowEvent(Display*, Window, c_long, XEvent*);
	int writeBitmapFile(Display*, const(char)*, Pixmap, uint, uint, int, int);
	int supportsLocale();
	char* setLocaleModifiers(const(char)*);
	XOM openOM(Display*, PrivateXrmHashBucketRec*, const(char)*, const(char)*);
	int closeOM(XOM);
	// char* setOMValues(XOM, ...);
	// char* getOMValues(XOM, ...);
	Display* displayOfOM(XOM);
	char* localeOfOM(XOM);
	// XOC createOC(XOM, ...);
	void destroyOC(XOC);
	// char* setOCValues(XOC, ...);
	// char* getOCValues(XOC, ...);
	XFontSet createFontSet(Display*, const(char)*, char***, int*, char**);
	void freeFontSet(Display*, XFontSet);
	int fontsOfFontSet(XFontSet, XFontStruct***, char***);
	char* baseFontNameListOfFontSet(XFontSet);
	char* localeOfFontSet(XFontSet);
	int contextDependentDrawing(XFontSet);
	int directionalDependentDrawing(XFontSet);
	int contextualDrawing(XFontSet);
	XFontSetExtents* extentsOfFontSet(XFontSet);
	// int mbTextEscapement(XFontSet, const(char)*, int);
	// int wcTextEscapement(XFontSet, const(wchar_t)*, int);
	// int utf8TextEscapement(XFontSet, const(char)*, int);
	// int mbTextExtents(XFontSet, const(char)*, int, XRectangle*, XRectangle*);
	// int wcTextExtents(XFontSet, const(wchar_t)*, int, XRectangle*, XRectangle*);
	// int utf8TextExtents(XFontSet, const(char)*, int, XRectangle*, XRectangle*);
	// int mbTextPerCharExtents(XFontSet, const(char)*, int, XRectangle*, XRectangle*, int, int*, XRectangle*, XRectangle*);
	// int wcTextPerCharExtents(XFontSet, const(wchar_t)*, int, XRectangle*, XRectangle*, int, int*, XRectangle*, XRectangle*);
	// int utf8TextPerCharExtents(XFontSet, const(char)*, int, XRectangle*, XRectangle*, int, int*, XRectangle*, XRectangle*);
	// void mbDrawText(Display*, Drawable, GC, int, int, XmbTextItem*, int);
	// void wcDrawText(Display*, Drawable, GC, int, int, XwcTextItem*, int);
	// void utf8DrawText(Display*, Drawable, GC, int, int, XmbTextItem*, int);
	// void mbDrawString(Display*, Drawable, XFontSet, GC, int, int, const(char)*, int);
	// void wcDrawString(Display*, Drawable, XFontSet, GC, int, int, const(wchar_t)*, int);
	// void utf8DrawString(Display*, Drawable, XFontSet, GC, int, int, const(char)*, int);
	// void mbDrawImageString(Display*, Drawable, XFontSet, GC, int, int, const(char)*, int);
	// void wcDrawImageString(Display*, Drawable, XFontSet, GC, int, int, const(wchar_t)*, int);
	// void utf8DrawImageString(Display*, Drawable, XFontSet, GC, int, int, const(char)*, int);
	XIM openIM(Display*, PrivateXrmHashBucketRec*, char*, char*);
	int closeIM(XIM);
	// char* getIMValues(XIM, ...);
	// char* setIMValues(XIM, ...);
	Display* displayOfIM(XIM);
	char* localeOfIM(XIM);
	// XIC createIC(XIM, ...);
	void destroyIC(XIC);
	void setICFocus(XIC);
	void unsetICFocus(XIC);
	// wchar_t* wcResetIC(XIC);
	// char* mbResetIC(XIC);
	// char* utf8ResetIC(XIC);
	// char* setICValues(XIC, ...);
	// char* getICValues(XIC, ...);
	int filterEvent(XEvent*, Window);
	// int mbLookupString(XIC, XKeyPressedEvent*, char*, int, KeySym*, int*);
	// int wcLookupString(XIC, XKeyPressedEvent*, wchar_t*, int, KeySym*, int*);
	// int utf8LookupString(XIC, XKeyPressedEvent*, char*, int, KeySym*, int*);
	// XVaNestedList vaCreateNestedList(int, ...);
	int registerIMInstantiateCallback(Display*, PrivateXrmHashBucketRec*, char*, char*, XIDProc, XPointer);
	int unregisterIMInstantiateCallback(Display*, PrivateXrmHashBucketRec*, char*, char*, XIDProc, XPointer);
	int internalConnectionNumbers(Display*, int**, int*);
	void processInternalConnection(Display*, int);
	int addConnectionWatch(Display*, XConnectionWatchProc, XPointer);
	void removeConnectionWatch(Display*, XConnectionWatchProc, XPointer);
	void setAuthorization(char*, int, char*, int);
	int getEventData(Display*, XGenericEventCookie*);
	void freeEventData(Display*, XGenericEventCookie*);
	XClassHint* allocClassHint();
	XIconSize* allocIconSize();
	XSizeHints* allocSizeHints();
	XStandardColormap* allocStandardColormap();
	XWMHints* allocWMHints();
	int clipBox(Region, XRectangle*);
	Region createRegion();
	const(char)* defaultString();
	int deleteContext(Display*, XID, XContext);
	int destroyRegion(Region);
	int emptyRegion(Region);
	int equalRegion(Region, Region);
	int findContext(Display*, XID, XContext, XPointer*);
	int getClassHint(Display*, Window, XClassHint*);
	int getIconSizes(Display*, Window, XIconSize**, int*);
	int getNormalHints(Display*, Window, XSizeHints*);
	int getRGBColormaps(Display*, Window, XStandardColormap**, int*, Atom);
	int getSizeHints(Display*, Window, XSizeHints*, Atom);
	int getStandardColormap(Display*, Window, XStandardColormap*, Atom);
	int getTextProperty(Display*, Window, XTextProperty*, Atom);
	XVisualInfo* getVisualInfo(Display*, c_long, XVisualInfo*, int*);
	int getWMClientMachine(Display*, Window, XTextProperty*);
	XWMHints* getWMHints(Display*, Window);
	int getWMIconName(Display*, Window, XTextProperty*);
	int getWMName(Display*, Window, XTextProperty*);
	int getWMNormalHints(Display*, Window, XSizeHints*, c_long*);
	int getWMSizeHints(Display*, Window, XSizeHints*, c_long*, Atom);
	int getZoomHints(Display*, Window, XSizeHints*);
	int intersectRegion(Region, Region, Region);
	void convertCase(KeySym, KeySym*, KeySym*);
	int lookupString(XKeyEvent*, char*, int, KeySym*, XComposeStatus*);
	int matchVisualInfo(Display*, int, int, int, XVisualInfo*);
	int offsetRegion(Region, int, int);
	int pointInRegion(Region, int, int);
	Region polygonRegion(XPoint*, int, int);
	int rectInRegion(Region, int, int, uint, uint);
	int saveContext(Display*, XID, XContext, const(char)*);
	int setClassHint(Display*, Window, XClassHint*);
	int setIconSizes(Display*, Window, XIconSize*, int);
	int setNormalHints(Display*, Window, XSizeHints*);
	void setRGBColormaps(Display*, Window, XStandardColormap*, int, Atom);
	int setSizeHints(Display*, Window, XSizeHints*, Atom);
	int setStandardProperties(Display*, Window, const(char)*, const(char)*, Pixmap, char**, int, XSizeHints*);
	void setTextProperty(Display*, Window, XTextProperty*, Atom);
	void setWMClientMachine(Display*, Window, XTextProperty*);
	int setWMHints(Display*, Window, XWMHints*);
	void setWMIconName(Display*, Window, XTextProperty*);
	void setWMName(Display*, Window, XTextProperty*);
	void setWMNormalHints(Display*, Window, XSizeHints*);
	void setWMProperties(Display*, Window, XTextProperty*, XTextProperty*, char**, int, XSizeHints*,
		XWMHints*, XClassHint*);
	// void mbSetWMProperties(Display*, Window, const(char)*, const(char)*, char**, int, XSizeHints*, XWMHints*, XClassHint*);
	// void utf8SetWMProperties(Display*, Window, const(char)*, const(char)*, char**, int, XSizeHints*,
	// 	XWMHints*, XClassHint*);
	void setWMSizeHints(Display*, Window, XSizeHints*, Atom);
	int setRegion(Display*, GC, Region);
	void setStandardColormap(Display*, Window, XStandardColormap*, Atom);
	int setZoomHints(Display*, Window, XSizeHints*);
	int shrinkRegion(Region, int, int);
	int stringListToTextProperty(char**, int, XTextProperty*);
	int subtractRegion(Region, Region, Region);
	// int mbTextListToTextProperty(Display* display, char** list, int count, XICCEncodingStyle style,
	// 	XTextProperty* text_prop_return);
	// int wcTextListToTextProperty(Display* display, wchar_t** list, int count, XICCEncodingStyle style,
	// 	XTextProperty* text_prop_return);
	// int utf8TextListToTextProperty(Display* display, char** list, int count, XICCEncodingStyle style,
	// 	XTextProperty* text_prop_return);
	// void wcFreeStringList(wchar_t** list);
	int textPropertyToStringList(XTextProperty*, char***, int*);
	// int mbTextPropertyToTextList(Display* display, const(XTextProperty)* text_prop, char*** list_return, int* count_return);
	// int wcTextPropertyToTextList(Display* display, const(XTextProperty)* text_prop, wchar_t*** list_return,
	// 	int* count_return);
	// int utf8TextPropertyToTextList(Display* display, const(XTextProperty)* text_prop, char*** list_return,
	// 	int* count_return);
	int unionRectWithRegion(XRectangle*, Region, Region);
	int unionRegion(Region, Region, Region);
	int wMGeometry(Display*, int, const(char)*, const(char)*, uint, XSizeHints*, int*, int*, int*, int*, int*);
	int xorRegion(Region, Region, Region);
	Bool _XkbSetDetectableAutoRepeat(Display*, Bool, Bool*);

}
