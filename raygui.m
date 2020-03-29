import rlcommon

!basic structs
global record GuiStyleProp=
    u32 controlId
    u32 propertyId
    int32 propertyValue
end

!defines
global const int32 NUM_CONTROLS=16
global const int32 NUM_PROPS_DEFAULT=16
global const int32 NUM_PROPS_EXTENDED=8

global const int32 TEXTEDIT_CURSOR_BLINK_FRAMES=20

!gui control state
 enum (
    GUI_STATE_NORMAL=0,
    GUI_STATE_FOCUSED,
    GUI_STATE_PRESSED,
    GUI_STATE_DISABLED )

!gui text alignment
enum (
    GUI_TEXT_ALIGN_LEFT=0,
    GUI_TEXT_ALIGN_CENTER,
    GUI_TEXT_ALIGN_RIGHT )

!gui control
enum (
    DEFAULT=0,
    LABEL,
    BUTTON,
    TOGGLE,
    SLIDER,
    PROGRESSBAR,
    CHECKBOX,
    COMBOBOX,
    DROPDOWNBOX,
    TEXTBOX,
    VALUEBOX,
    SPINNER,
    LISTVIEW,
    COLORPICKER,
    SCROLLBAR,
    STATUSBAR )

!gui control property
enum (
    BORDER_COLOR_NORMAL=0,
    BASE_COLOR_NORMAL,
    TEXT_COLOR_NORMAL,
    BORDER_COLOR_FOCUSED,
    BASE_COLOR_FOCUSED,
    TEXT_COLOR_FOCUSED,
    BORDER_COLOR_PRESSED,
    BASE_COLOR_PRESSED,
    TEXT_COLOR_PRESSED,
    BORDER_COLOR_DISABLED,
    BASE_COLOR_DISABLED,
    TEXT_COLOR_DISABLED,
    BORDER_WIDTH,
    TEXT_PADDING,
    TEXT_ALIGNMENT,
    RESERVED )

!gui default property
enum (
    TEXT_SIZE=16,
    TEXT_SPACING,
    LINE_COLOR,
    BACKGROUND_COLOR )

!gui toggle property
enum (
    GROUP_PADDING=16 )

!gui slider property
enum (
    SLIDER_WIDTH=16,
    SLIDER_PADDING )

!gui progressbar property
enum (
    PROGRESS_PADDING=16 )

!gui checkbox property
enum (
    CHECK_PADDING=16 )

!gui combobox property
enum (
    COMBO_BUTTON_WIDTH=16,
    COMBO_BUTTON_PADDING )

!gui dropdownbox property
enum (
    ARROW_PADDING=16,
    DROPDOWN_ITEMS_PADDING )

!gui textbox property
enum (
    TEXT_INNER_PADDING=16,
    TEXT_LINES_PADDING,
    COLOR_SELECTED_FG,
    COLOR_SELECTED_BG )

!gui spinner property
enum (
    SPIN_BUTTON_WIDTH=16,
    SPIN_BUTTON_PADDING )

!gui scrollbar property
enum (
    SCROLLBAR_LEFT_SIDE=0,
    SCROLLBAR_RIGHT_SIDE )

!gui listview property
enum (
    LIST_ITEMS_HEIGHT=16,
    LIST_ITEMS_PADDING,
    SCROLLBAR_WIDTH,
    SCROLLBAR_SIDE )

!gui colorpicker property
enum (
    COLOR_SELECTOR_SIZE=16,
    HUEBAR_WIDTH,
    HUEBAR_PADDING,
    HUEBAR_SELECTOR_HEIGHT,
    HUEBAR_SELECTOR_OVERFLOW )

!gui property element
enum (
    BORDER=0,
    BASE,
    TEXT,
    OTHER )

global const guiState=GUI_STATE_NORMAL

global Font guiFont
global const byte guiLocked=0
global const real32 guiAlpha=1.0
global [NUM_CONTROLS*(NUM_PROPS_DEFAULT+NUM_PROPS_EXTENDED)]u32 guiStyle

importdll raylib=
    clang proc      "GuiEnable"                 ()
    clang proc      "GuiDisable"                ()
    clang proc      "GuiLock"                   ()
    clang proc      "GuiUnlock"                 ()
    clang proc      "GuiFade"                   (real32)
    clang proc      "GuiSetState"               (int32)
    clang function  "GuiGetState"               ()int32

    clang proc      "GuiSetFont"                (ref Font)
    clang function  "GuiGetFont"                ()ref Font

    clang proc      "GuiSetStyle"               (int32, int32, int32)
    clang function  "GuiGetStyle"               (int32, int32)int32
    
    clang proc      "GuiEnableTooltip"          ()
    clang proc      "GuiDisableTooltip"         ()
    clang proc      "GuiSetTooltip"             (ref char)
    clang proc      "GuiClearTooltip"           ()

    clang function  "GuiWindowBox"              (ref Rectangle, ref char)byte
    clang proc      "GuiGroupBox"               (ref Rectangle, ref char)
    clang proc      "GuiLine"                   (ref Rectangle, ref char)
    clang proc      "GuiPanel"                  (ref Rectangle)
    clang proc      "GuiScrollPanel"            (ref Rectangle, ref Rectangle, ref Rectangle, ref Vector2)

    clang proc      "GuiLabel"                  (ref Rectangle, ref char)
    clang function  "GuiButton"                 (ref Rectangle, ref char)byte
    clang function  "GuiLabelButton"            (ref Rectangle, ref char)byte
    clang function  "GuiImageButton"            (ref Rectangle, ref char, ref Texture2D)byte
    clang function  "GuiImageButtonEx"          (ref Rectangle, ref char, ref Texture2D, ref Rectangle)byte
    clang function  "GuiToggle"                 (ref Rectangle, ref char, byte)byte
    clang function  "GuiToggleGroup"            (ref Rectangle, ref char, int32)int32
    clang function  "GuiCheckBox"               (ref Rectangle, ref char, byte)byte
    clang function  "GuiComboBox"               (ref Rectangle, ref char, int32)int32
    clang function  "GuiDropdownBox"            (ref Rectangle, ref char, int32, byte)byte
    clang function  "GuiSpinner"                (ref Rectangle, ref char, ref int32, int32, int32, byte)byte        ! ref[0:]int32?
    clang function  "GuiValueBox"               (ref Rectangle, ref char, ref int32, int32, int32, byte)byte        ! ref[0:]int32?
    clang function  "GuiTextBox"                (ref Rectangle, ref char, ref int32, int32, int32, byte)byte        ! ref[0:]int32?
    clang function  "GuiTextBoxMulti"           (ref Rectangle, ref char, int32, byte)byte
    clang function  "GuiSlider"                 (ref Rectangle, ref char, ref char, real32, real32, real32)real32
    clang function  "GuiSliderBar"              (ref Rectangle, ref char, ref char, real32, real32, real32)real32
    clang function  "GuiProgressBar"            (ref Rectangle, ref char, ref char, real32, real32, real32)real32
    clang proc      "GuiStatusBar"              (ref Rectangle, ref char)
    clang proc      "GuiDummyRec"               (ref Rectangle, ref char)
    clang function  "GuiScrollBar"              (ref Rectangle, int32, int32, int32)int32
    clang function  "GuiGrid"                   (ref Rectangle, real32, int32)Vector2

    clang function  "GuiListView"               (ref Rectangle, ref char, ref int32, int32)int32                    ! ref[0:]int32?
    clang function  "GuiListViewEx"             (ref Rectangle, ref[0:]ichar, int32, ref int32, ref int32, int32)int32  ! ref[0:]int32?
    clang function  "GuiMessageBox"             (ref Rectangle, ref char, ref char, ref char)int32
    clang function  "GuiTextInputBox"           (ref Rectangle, ref char, ref char, ref char, ref char)int32
    clang function  "GuiColorPicker"            (ref Rectangle, Color)Color

    clang proc      "GuiLoadStyle"              (ref char)
    clang proc      "GuiLoadStyleDefault"       ()

    clang function  "GuiIconText"               (int32, ref char)ref char
    
    !the functions after this point won''t work properly until I port ricons.h
    clang proc      "GuiDrawIcon"               (int32, Vector2, int32, Color)
    clang function  "GuiGetIcons"               ()ref u32
    clang function  "GuiGetIconData"            (int32)u32
    clang proc      "GuiSetIconData"            (int32, ref u32)
    
    clang proc      "GuiSetIconPixel"           (int32, int32, int32)
    clang proc      "GuiClearIconPixel"         (int32, int32, int32)
    clang function  "GuiCheckIconPixel"         (int32, int32, int32)byte
    !end functions that won'' work properly until I post ricons.h
    
    !module-specific functions declaration
    clang proc      "ConvertHSVtoRGB"           (ref Vector3, ref Vector3)
    clang proc      "ConvertRGBtoHSV"           (ref Vector3, ref Vector3)

    clang function  "GetTextWidth"              (ref char)int32
    clang proc      "GetTextBounds"             (ref Rectangle, int32, ref Rectangle)
    clang function  "GetTextIcon"               (ref char, ref int32)ref char

    clang proc      "GuiDrawText"               (ref char, ref Rectangle, int32, Color)
    clang proc      "GuiDrawTooltip"            (ref Rectangle)
    clang function  "GuiTextSplit"              (ref char, ref int32, ref int32)ref[0:]ichar
end