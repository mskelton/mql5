#ifndef MQL5_H
#define MQL5_H

#define input __attribute__((no_sanitize_address))
#define NULL nullptr

typedef int color;
typedef char *string;
typedef int datetime;
typedef unsigned char uchar;
typedef unsigned int uint;
typedef unsigned long ulong;
typedef unsigned short ushort;

/**
 * Minimal value, which can be represented by char type.
 */
char CHAR_MIN;

/**
 * Maximal value, which can be represented by char type.
 */
char CHAR_MAX;

/**
 * Maximal value, which can be represented by uchar type.
 */
uchar UCHAR_MAX;

/**
 * Minimal value, which can be represented by short type.
 */
short SHORT_MIN;

/**
 * Maximal value, which can be represented by short type
 */
short SHORT_MAX;

/**
 * Maximal value, which can be represented by ushort type.
 */
ushort USHORT_MAX;

/**
 * Minimal value, which can be represented by int type.
 */
int INT_MIN;

/**
 * Maximal value, which can be represented by int type.
 */
int INT_MAX;

/**
 * Maximal value, which can be represented by uint type.
 */
uint UINT_MAX;

/**
 * Minimal value, which can be represented by long type.
 */
long LONG_MIN;

/**
 * Maximal value, which can be represented by long type.
 */
long LONG_MAX;

/**
 * Maximal value, which can be represented by ulong type.
 */
ulong ULONG_MAX;

/**
 * Minimal positive value, which can be represented by double type.
 */
double DBL_MIN;

/**
 * Maximal value, which can be represented by double type.
 */
double DBL_MAX;

/**
 * Minimal value, which satisfies the condition:.
 */
double DBL_EPSILON;

/**
 * Number of significant decimal digits for double type.
 */
double DBL_DIG;

/**
 * Number of bits in a mantissa for double type.
 */
double DBL_MANT_DIG;

/**
 * Maximal decimal value of exponent degree for double type.
 */
double DBL_MAX_10_EXP;

/**
 * Maximal binary value of exponent degree for double type.
 */
double DBL_MAX_EXP;

/**
 * Minimal decimal value of exponent degree for double type.
 */
double DBL_MIN_10_EXP;

/**
 * Minimal binary value of exponent degree for double type.
 */
double DBL_MIN_EXP;

/**
 * Minimal positive value, which can be represented by float type.
 */
float FLT_MIN;

/**
 * Maximal value, which can be represented by float type.
 */
float FLT_MAX;

/**
 * Minimal value, which satisfies the condition:.
 */
float FLT_EPSILON;

/**
 * Number of significant decimal digits for float type.
 */
float FLT_DIG;

/**
 * Number of bits in a mantissa for float type.
 */
float FLT_MANT_DIG;

/**
 * Maximal decimal value of exponent degree for float type.
 */
float FLT_MAX_10_EXP;

/**
 * Maximal binary value of exponent degree for float type.
 */
float FLT_MAX_EXP;

/**
 * Minimal decimal value of exponent degree for float type.
 */
float FLT_MIN_10_EXP;

/**
 * Minimal binary value of exponent degree for float type
 */
float FLT_MIN_EXP;

/**
 * Initialization successful, EA test can be continued.
 * This code means the same as the zero value – the EA initialization in the
 * tester is successful.
 */
int INIT_SUCCEEDED;

/**
 * Initialization failed. There is no point in continuing the test due to
 * unavoidable errors. For example, it is impossible to create an indicator
 * necessary for the EA operation.
 *
 * The return of this value means the same as returning the value different from
 * zero – EA initialization in the tester failed.
 */
int INIT_FAILED;

/**
 * Designed to denote an incorrect set of input parameters by a programmer. In
 * the general optimization table, the result string with this return code is
 * highlighted in red.
 *
 * A test for such a set of EA inputs is not performed. The agent is ready to
 * receive a new task.
 *
 * When this value is received, the strategy tester does not pass this task to
 * other agents for repeated execution.
 */
int INIT_PARAMETERS_INCORRECT;

/**
 * No program execution errors during initialization. However, for some
 * reasons, the agent is not suitable for conducting a test. For example, there
 * is not enough RAM, no OpenCL support, etc.
 *
 * After returning this code, the agent no longer receives tasks until the very
 * end of this optimization.
 */
int INIT_AGENT_NOT_SUITABLE;

/**
 * The _AppliedTo variable allows finding out the type of data, used for
 * indicator calculation:
 */
int _AppliedTo;

/**
 * The _Digits variable stores number of digits after a decimal point, which
 * defines the price accuracy of the symbol of the current chart.
 *
 * You may also use the Digits() function.
 */
uint _Digits;

/**
 * The _Point variable contains the point size of the current symbol in the
 * quote currency.
 *
 * You may also use the Point() function.
 */
double _Point;

/**
 * The _LastError variable contains code of the last error, that occurred during
 * the mql5-program run. Its value can be reset to zero by ResetLastError().
 *
 * To obtain the code of the last error, you may also use the GetLastError()
 * function.
 */
int _LastError;

/**
 * Variable for storing the current state when generating pseudo-random
 * integers. _RandomSeed changes its value when calling MathRand(). Use
 * MathSrand() to set the required initial condition.
 *
 * x random number received by MathRand() function is calculated in the
 * following way at each call:
 */
int _RandomSeed;

/**
 * The _StopFlag variable contains the flag of the mql5-program stop. When the
 * client terminal is trying to stop the program, it sets the _StopFlag variable
 * to true.
 *
 * To check the state of the _StopFlag you may also use the IsStopped()
 * function.
 */
bool _StopFlag;

/**
 * The _Symbol variable contains the symbol name of the current chart.
 *
 * You may also use the Symbol() function.
 */
string _Symbol;

/**
 * The _UninitReason variable contains the code of the program uninitialization
 * reason.
 *
 * Usually, this code is obtained by UninitializeReason() the function.
 */
int _UninitReason;

/**
 * The _IsX64 variable allows finding out the bit version of the terminal, in
 * which an MQL5 application is running: _IsX64=0 for the 32-bit terminal and
 * _IsX64!=0 for the 64-bit terminal.
 *
 * Also, function TerminalInfoInteger(TERMINAL_X64) can be used.
 */
int _IsX64;

/**
 * Print headers for the structure array
 */
int ARRAYPRINT_HEADER;

/**
 * Print index at the left side
 */
int ARRAYPRINT_INDEX;

/**
 * Print only the first 100 and the last 100 array elements. Use if you want
 * to print only a part of a large array.
 */
int ARRAYPRINT_LIMIT;

/**
 * Enable alignment of the printed values – numbers are aligned to the right,
 * while lines to the left.
 */
int ARRAYPRINT_ALIGN;

/**
 * When printing datetime, print the date in the dd.mm.yyyy format
 */
int ARRAYPRINT_DATE;

/**
 * When printing datetime, print the time in the HH:MM format
 */
int ARRAYPRINT_MINUTES;

/**
 * When printing datetime, print the time in the HH:MM:SS format
 */
int ARRAYPRINT_SECONDS;

/**
 * The current Windows ANSI code page.
 */
int CP_ACP = 0;

/**
 * The current system OEM code page.
 */
int CP_OEMCP = 1;

/**
 * The current system Macintosh code page.
 * Note: This value is mostly used in earlier created program codes and is of no
 * use now, since modern Macintosh computers use Unicode for encoding.
 */
int CP_MACCP = 2;

/**
 * The Windows ANSI code page for the current thread.
 */
int CP_THREAD_ACP = 3;

/**
 * Symbol code page
 */
int CP_SYMBOL = 42;

/**
 * UTF-7 code page.
 */
int CP_UTF7 = 65000;

/**
 * UTF-8 code page.
 */
int CP_UTF8 = 65001;

/**
 * Gets result as "yyyy.mm.dd"
 */
int TIME_DATE;

/**
 * Gets result as "hh:mi"
 */
int TIME_MINUTES;

/**
 * Gets results as "hh:mi:ss"
 */
int TIME_SECONDS;

/**
 * The EA has stopped working calling the ExpertRemove() function
 */
int REASON_PROGRAM;

/**
 * Program removed from a chart
 */
int REASON_REMOVE;

/**
 * Program recompiled
 */
int REASON_RECOMPILE;

/**
 * A symbol or a chart period is changed
 */
int REASON_CHARTCHANGE;

/**
 * Chart closed
 */
int REASON_CHARTCLOSE;

/**
 * Inputs changed by a user
 */
int REASON_PARAMETERS;

/**
 * Another account has been activated or reconnection to the trade server has
 * occurred due to changes in the account settings
 */
int REASON_ACCOUNT;

/**
 * Another chart template applied
 */
int REASON_TEMPLATE;

/**
 * The OnInit() handler returned a non-zero value
 */
int REASON_INITFAILED;

/**
 * Terminal closed
 */
int REASON_CLOSE;

/**
 * File open dialog;
 */
int FSD_WRITE_FILE;

/**
 * Allow selection of folders only;
 */
int FSD_SELECT_FOLDER;

/**
 * Allow selection of multiple files;
 */
int FSD_ALLOW_MULTISELECT;

/**
 * Selected files should exist;
 */
int FSD_FILE_MUST_EXIST;

/**
 * File is located in the common folder of all client terminals
 * \\Terminal\\Common\\Files.
 */
int FSD_COMMON_FOLDER;

/**
 * File is opened for reading. Flag is used in FileOpen(). When opening a file
 * specification of FILE_WRITE and/or FILE_READ is required.
 */
int FILE_READ;

/**
 * File is opened for writing. Flag is used in FileOpen(). When opening a file
 * specification of FILE_WRITE and/or FILE_READ is required.
 */
int FILE_WRITE;

/**
 * Binary read/write mode (without string to string conversion). Flag is used in
 * FileOpen().
 */
int FILE_BIN;

/**
 * CSV file (all its elements are converted to strings of the appropriate type,
 * Unicode or ANSI, and separated by separator). Flag is used in FileOpen().
 */
int FILE_CSV;

/**
 * Simple text file (the same as csv file, but without taking into account the
 * separators). Flag is used in FileOpen().
 */
int FILE_TXT;

/**
 * Strings of ANSI type (one byte symbols). Flag is used in FileOpen().
 */
int FILE_ANSI;

/**
 * Strings of UNICODE type (two byte symbols). Flag is used in FileOpen().
 */
int FILE_UNICODE;

/**
 * Shared access for reading from several programs. Flag is used in FileOpen(),
 * but it does not replace the necessity to indicate FILE_WRITE and/or the
 * FILE_READ flag when opening a file.
 */
int FILE_SHARE_READ;

/**
 * Possibility for the file rewrite using functions FileCopy() and FileMove().
 * The file should exist or should be opened for writing, otherwise the file
 * will not be opened.
 */
int FILE_SHARE_WRITE;

/**
 * The file path in the common folder of all client terminals
 * \\Terminal\\Common\\Files. Flag is used in FileOpen(), FileCopy(), FileMove()
 * and in FileIsExist() functions.
 */
int FILE_COMMON;

int CHAR_VALUE = 1;
int SHORT_VALUE = 2;
int INT_VALUE = 4;
int FONT_ITALIC;
int FONT_UNDERLINE;
int FONT_STRIKEOUT;
int FW_DONTCARE;
int FW_THIN;
int FW_EXTRALIGHT;
int FW_ULTRALIGHT;
int FW_LIGHT;
int FW_NORMAL;
int FW_REGULAR;
int FW_MEDIUM;
int FW_SEMIBOLD;
int FW_DEMIBOLD;
int FW_BOLD;
int FW_EXTRABOLD;
int FW_ULTRABOLD;
int FW_HEAVY;
int FW_BLACK;

/**
 * The maximum possible number of simultaneously open charts in the terminal
 */
int CHARTS_MAX;

/**
 * Absence of color
 */
int clrNONE;

/**
 * Empty value in an indicator buffer
 */
double EMPTY_VALUE;

/**
 * Incorrect handle
 */
int INVALID_HANDLE;

/**
 * Flag that a mq5-program operates in debug mode. It is non zero in debug mode,
 * otherwise zero.
 */
int IS_DEBUG_MODE;

/**
 * Flag that a mq5-program operates in profiling mode. It is non zero in
 * profiling mode, otherwise zero.
 */
int IS_PROFILE_MODE;

/**
 * Means the number of items remaining until the end of the array, i.e., the
 * entire array will be processed
 */
int WHOLE_ARRAY;

/**
 * The constant can be implicitly cast to any enumeration type
 */
int WRONG_VALUE;

/**
 * Display a string with field names
 */
int DATABASE_EXPORT_HEADER;

/**
 * Display string indices
 */
int DATABASE_EXPORT_INDEX;

/**
 * Do not insert BOM mark at the beginning of the file (BOM is inserted by
 * default)
 */
int DATABASE_EXPORT_NO_BOM;

/**
 * Use CRLF for line break (the default is LF)
 */
int DATABASE_EXPORT_CRLF;

/**
 * Add data to the end of an existing file (by default, the file is
 * overwritten). If the file does not exist, it will be created.
 */
int DATABASE_EXPORT_APPEND;

/**
 * Display string values in double quotes.
 */
int DATABASE_EXPORT_QUOTED_STRINGS;

/**
 * A CSV file is created in the common folder of all client terminals
 * \\Terminal\\Common\\File.
 */
int DATABASE_EXPORT_COMMON_FOLDER;

/**
 * Do not display table column names (field names)
 */
int DATABASE_PRINT_NO_HEADER;

/**
 * Do not display string indices
 */
int DATABASE_PRINT_NO_INDEX;

/**
 * Do not display a frame separating a header and data
 */
int DATABASE_PRINT_NO_FRAME;

/**
 * Align strings to the right.
 */
int DATABASE_PRINT_STRINGS_RIGHT;

/**
 * Any available device with OpenCL support is allowed;
 */
int CL_USE_ANY;

/**
 * Only OpenCL emulation on CPU is allowed;
 */
int CL_USE_CPU_ONLY;

/**
 * OpenCL emulation is prohibited and only specialized devices with OpenCL
 * support (video cards) can be used.
 */
int CL_USE_GPU_ONLY;

int CL_MEM_READ_WRITE;
int CL_MEM_WRITE_ONLY;
int CL_MEM_READ_ONLY;
int CL_MEM_ALLOC_HOST_PTR;
int CL_COMPLETE;
int CL_RUNNING;
int CL_SUBMITTED;
int CL_QUEUED;

/**
 * Ticks with Bid and/or Ask changes
 */
uint COPY_TICKS_INFO;

/**
 * Ticks with changes in Last and Volume
 */
uint COPY_TICKS_TRADE;

/**
 * All ticks
 */
uint COPY_TICKS_ALL;

typedef enum ENUM_ACCOUNT_INFO_INTEGER {
  /**
   * Account number
   */
  ACCOUNT_LOGIN,
  /**
   * Account trade mode
   */
  ACCOUNT_TRADE_MODE,
  /**
   * Account leverage
   */
  ACCOUNT_LEVERAGE,
  /**
   * Maximum allowed number of active pending orders
   */
  ACCOUNT_LIMIT_ORDERS,
  /**
   * Mode for setting the minimal allowed margin
   */
  ACCOUNT_MARGIN_SO_MODE,
  /**
   * Allowed trade for the current account
   */
  ACCOUNT_TRADE_ALLOWED,
  /**
   * Allowed trade for an Expert Advisor
   */
  ACCOUNT_TRADE_EXPERT,
  /**
   * Margin calculation mode
   */
  ACCOUNT_MARGIN_MODE,
  /**
   * The number of decimal places in the account currency, which are required
   * for an accurate display of trading results
   */
  ACCOUNT_CURRENCY_DIGITS,
  /**
   * An indication showing that positions can only be closed by FIFO rule. If
   * the property value is set to true, then each symbol positions will be
   * closed in the same order, in which they are opened, starting with the
   * oldest one. In case of an attempt to close positions in a different order,
   * the trader will receive an appropriate error.
   */
  ACCOUNT_FIFO_CLOSE,
} ENUM_ACCOUNT_INFO_INTEGER;

typedef enum ENUM_ACCOUNT_INFO_DOUBLE {
  /**
   * Account balance in the deposit currency
   */
  ACCOUNT_BALANCE,
  /**
   * Account credit in the deposit currency
   */
  ACCOUNT_CREDIT,
  /**
   * Current profit of an account in the deposit currency
   */
  ACCOUNT_PROFIT,
  /**
   * Account equity in the deposit currency
   */
  ACCOUNT_EQUITY,
  /**
   * Account margin used in the deposit currency
   */
  ACCOUNT_MARGIN,
  /**
   * Free margin of an account in the deposit currency
   */
  ACCOUNT_MARGIN_FREE,
  /**
   * Account margin level in percents
   */
  ACCOUNT_MARGIN_LEVEL,
  /**
   * Margin call level. Depending on the set ACCOUNT_MARGIN_SO_MODE is expressed
   * in percents or in the deposit currency
   */
  ACCOUNT_MARGIN_SO_CALL,
  /**
   * Margin stop out level. Depending on the set ACCOUNT_MARGIN_SO_MODE is
   * expressed in percents or in the deposit currency
   */
  ACCOUNT_MARGIN_SO_SO,
  /**
   * Initial margin. The amount reserved on an account to cover the margin of
   * all pending orders
   */
  ACCOUNT_MARGIN_INITIAL,
  /**
   * Maintenance margin. The minimum equity reserved on an account to cover the
   * minimum amount of all open positions
   */
  ACCOUNT_MARGIN_MAINTENANCE,
  /**
   * The current assets of an account
   */
  ACCOUNT_ASSETS,
  /**
   * The current liabilities on an account
   */
  ACCOUNT_LIABILITIES,
  /**
   * The current blocked commission amount on an account
   */
  ACCOUNT_COMMISSION_BLOCKED,
} ENUM_ACCOUNT_INFO_DOUBLE;

typedef enum ENUM_ACCOUNT_INFO_STRING {
  /**
   * Client name
   */
  ACCOUNT_NAME,
  /**
   * Trade server name
   */
  ACCOUNT_SERVER,
  /**
   * Account currency
   */
  ACCOUNT_CURRENCY,
  /**
   * Name of a company that serves the account
   */
  ACCOUNT_COMPANY
} ENUM_ACCOUNT_INFO_STRING;

typedef enum ENUM_ACCOUNT_TRADE_MODE {
  /**
   * Demo account
   */
  ACCOUNT_TRADE_MODE_DEMO,
  /**
   * Contest account
   */
  ACCOUNT_TRADE_MODE_CONTEST,
  /**
   * Real account
   */
  ACCOUNT_TRADE_MODE_REAL,
} ENUM_ACCOUNT_TRADE_MODE;

typedef enum ENUM_ACCOUNT_STOPOUT_MODE {
  /**
   * Account stop out mode in percents
   */
  ACCOUNT_STOPOUT_MODE_PERCENT,
  /**
   * Account stop out mode in money
   */
  ACCOUNT_STOPOUT_MODE_MONEY,
} ENUM_ACCOUNT_STOPOUT_MODE;

typedef enum ENUM_ACCOUNT_MARGIN_MODE {
  /**
   * Used for the OTC markets to interpret positions in the "netting" mode (only
   * one position can exist for one symbol). The margin is calculated based on
   * the symbol type (SYMBOL_TRADE_CALC_MODE).
   */
  ACCOUNT_MARGIN_MODE_RETAIL_NETTING,
  /**
   * Used for the exchange markets. Margin is calculated based on the discounts
   * specified in symbol settings. Discounts are set by the broker, but not less
   * than the values set by the exchange.
   */
  ACCOUNT_MARGIN_MODE_EXCHANGE,
  /**
   * Used for the exchange markets where individual positions are possible
   * (hedging, multiple positions can exist for one symbol). The margin is
   * calculated based on the symbol type (SYMBOL_TRADE_CALC_MODE) taking into
   * account the hedged margin (SYMBOL_MARGIN_HEDGED).
   */
  ACCOUNT_MARGIN_MODE_RETAIL_HEDGING,
} ENUM_ACCOUNT_MARGIN_MODE;

typedef enum ENUM_CHART_PROPERTY_INTEGER {
  /**
   * Price chart drawing. If false, drawing any price chart attributes is
   * disabled and all chart border indents are eliminated, including time and
   * price scales, quick navigation bar, Calendar event labels, trade labels,
   * indicator and bar tooltips, indicator subwindows, volume histograms, etc.
   * Disabling the drawing is a perfect solution for creating a custom program
   * interface using the graphical resources. The graphical objects are always
   * drawn regardless of the CHART_SHOW property value.
   */
  CHART_SHOW,
  /**
   * Identifying "Chart" (OBJ_CHART) object – returns true for a graphical
   * object. Returns false for a real chart
   */
  CHART_IS_OBJECT,
  /**
   * Show chart on top of other charts
   */
  CHART_BRING_TO_TOP,
  /**
   * Enabling/disabling access to the context menu using the right click.
   * When CHART_CONTEXT_MENU=false, only the chart context menu is disabled. The
   * context menu of objects on the chart remains available.
   */
  CHART_CONTEXT_MENU,
  /**
   * Enabling/disabling access to the Crosshair tool using the middle click.
   */
  CHART_CROSSHAIR_TOOL,
  /**
   * Scrolling the chart horizontally using the left mouse button. Vertical
   * scrolling is also available if the value of any following properties is set
   * to true: CHART_SCALEFIX, CHART_SCALEFIX_11 or CHART_SCALE_PT_PER_BAR When
   * CHART_MOUSE_SCROLL=false, chart scrolling with the mouse wheel is
   * unavailable
   */
  CHART_MOUSE_SCROLL,
  /**
   * Sending messages about mouse wheel events (CHARTEVENT_MOUSE_WHEEL) to all
   * mql5 programs on a chart
   */
  CHART_EVENT_MOUSE_WHEEL,
  /**
   * Send notifications of mouse move and mouse click events
   * (CHARTEVENT_MOUSE_MOVE) to all mql5 programs on a chart
   */
  CHART_EVENT_MOUSE_MOVE,
  /**
   * Send a notification of an event of new object creation
   * (CHARTEVENT_OBJECT_CREATE) to all mql5-programs on a chart
   */
  CHART_EVENT_OBJECT_CREATE,
  /**
   * Send a notification of an event of object deletion
   * (CHARTEVENT_OBJECT_DELETE) to all mql5-programs on a chart
   */
  CHART_EVENT_OBJECT_DELETE,
  /**
   * Chart type (candlesticks, bars or line)
   */
  CHART_MODE,
  /**
   * Price chart in the foreground
   */
  CHART_FOREGROUND,
  /**
   * Mode of price chart indent from the right border
   */
  CHART_SHIFT,
  /**
   * Mode of automatic moving to the right border of the chart
   */
  CHART_AUTOSCROLL,
  /**
   * Allow managing the chart using a keyboard ("Home", "End", "PageUp", "+",
   * "-", "Up arrow", etc.). Setting CHART_KEYBOARD_CONTROL to false disables
   * chart scrolling and scaling while leaving intact the ability to receive the
   * keys pressing events in OnChartEvent().
   */
  CHART_KEYBOARD_CONTROL,
  /**
   * Allow the chart to intercept Space and Enter key strokes to activate the
   * quick navigation bar. The quick navigation bar automatically appears at the
   * bottom of the chart after double-clicking the mouse or pressing
   * Space/Enter. It allows you to quickly change a symbol, timeframe and first
   * visible bar date.
   */
  CHART_QUICK_NAVIGATION,
  /**
   * Scale
   */
  CHART_SCALE,
  /**
   * Fixed scale mode
   */
  CHART_SCALEFIX,
  /**
   * Scale 1:1 mode
   */
  CHART_SCALEFIX_11,
  /**
   * Scale to be specified in points per bar
   */
  CHART_SCALE_PT_PER_BAR,
  /**
   * Display a symbol ticker in the upper left corner. Setting CHART_SHOW_TICKER
   * to 'false' also sets CHART_SHOW_OHLC to 'false' and disables OHLC
   */
  CHART_SHOW_TICKER,
  /**
   * Display OHLC values in the upper left corner. Setting CHART_SHOW_OHLC to
   * 'true' also sets CHART_SHOW_TICKER to 'true' and enables the ticker
   */
  CHART_SHOW_OHLC,
  /**
   * Display Bid values as a horizontal line in a chart
   */
  CHART_SHOW_BID_LINE,
  /**
   * Display Ask values as a horizontal line in a chart
   */
  CHART_SHOW_ASK_LINE,
  /**
   * Display Last values as a horizontal line in a chart
   */
  CHART_SHOW_LAST_LINE,
  /**
   * Display vertical separators between adjacent periods
   */
  CHART_SHOW_PERIOD_SEP,
  /**
   * Display grid in the chart
   */
  CHART_SHOW_GRID,
  /**
   * Display volume in the chart
   */
  CHART_SHOW_VOLUMES,
  /**
   * Display textual descriptions of objects (not available for all objects)
   */
  CHART_SHOW_OBJECT_DESCR,
  /**
   * The number of bars on the chart that can be displayed
   */
  CHART_VISIBLE_BARS,
  /**
   * The total number of chart windows, including indicator subwindows
   */
  CHART_WINDOWS_TOTAL,
  /**
   * Visibility of subwindows
   */
  CHART_WINDOW_IS_VISIBLE,
  /**
   * Chart window handle (HWND)
   */
  CHART_WINDOW_HANDLE,
  /**
   * The distance between the upper frame of the indicator subwindow and the
   * upper frame of the main chart window, along the vertical Y axis, in pixels.
   * In case of a mouse event, the cursor coordinates are passed in terms of the
   * coordinates of the main chart window, while the coordinates of graphical
   * objects in an indicator subwindow are set relative to the upper left corner
   * of the subwindow.
   *
   * The value is required for converting the absolute
   * coordinates of the main chart to the local coordinates of a subwindow for
   * correct work with the graphical objects, whose coordinates are set relative
   * to  the upper left corner of the subwindow frame.
   */
  CHART_WINDOW_YDISTANCE,
  /**
   * Number of the first visible bar in the chart. Indexing of bars is the same
   * as for timeseries.
   */
  CHART_FIRST_VISIBLE_BAR,
  /**
   * Chart width in bars
   */
  CHART_WIDTH_IN_BARS,
  /**
   * Chart width in pixels
   */
  CHART_WIDTH_IN_PIXELS,
  /**
   * Chart height in pixels
   */
  CHART_HEIGHT_IN_PIXELS,
  /**
   * Chart background color
   */
  CHART_COLOR_BACKGROUND,
  /**
   * Color of axes, scales and OHLC line
   */
  CHART_COLOR_FOREGROUND,
  /**
   * Grid color
   */
  CHART_COLOR_GRID,
  /**
   * Color of volumes and position opening levels
   */
  CHART_COLOR_VOLUME,
  /**
   * Color for the up bar, shadows and body borders of bull candlesticks
   */
  CHART_COLOR_CHART_UP,
  /**
   * Color for the down bar, shadows and body borders of bear candlesticks
   */
  CHART_COLOR_CHART_DOWN,
  /**
   * Line chart color and color of "Doji" Japanese candlesticks
   */
  CHART_COLOR_CHART_LINE,
  /**
   * Body color of a bull candlestick
   */
  CHART_COLOR_CANDLE_BULL,
  /**
   * Body color of a bear candlestick
   */
  CHART_COLOR_CANDLE_BEAR,
  /**
   * Bid price level color
   */
  CHART_COLOR_BID,
  /**
   * Ask price level color
   */
  CHART_COLOR_ASK,
  /**
   * Line color of the last executed deal price (Last)
   */
  CHART_COLOR_LAST,
  /**
   * Color of stop order levels (Stop Loss and Take Profit)
   */
  CHART_COLOR_STOP_LEVEL,
  /**
   * Displaying trade levels in the chart (levels of open positions, Stop Loss,
   * Take Profit and pending orders)
   */
  CHART_SHOW_TRADE_LEVELS,
  /**
   * Permission to drag trading levels on a chart with a mouse. The drag mode is
   * enabled by default (true value)
   */
  CHART_DRAG_TRADE_LEVELS,
  /**
   * Showing the time scale on a chart
   */
  CHART_SHOW_DATE_SCALE,
  /**
   * Showing the price scale on a chart
   */
  CHART_SHOW_PRICE_SCALE,
  /**
   * Showing the "One click trading" panel on a chart
   */
  CHART_SHOW_ONE_CLICK,
  /**
   * Chart window is maximized
   */
  CHART_IS_MAXIMIZED,
  /**
   * Chart window is minimized
   */
  CHART_IS_MINIMIZED,
  /**
   * The chart window is docked. If set to false, the chart can be dragged
   * outside the terminal area
   */
  CHART_IS_DOCKED,
  /**
   * The left coordinate of the undocked chart window relative to the virtual
   * screen
   */
  CHART_FLOAT_LEFT,
  /**
   * The top coordinate of the undocked chart window relative to the virtual
   * screen
   */
  CHART_FLOAT_TOP,
  /**
   * The right coordinate of the undocked chart window relative to the virtual
   * screen
   */
  CHART_FLOAT_RIGHT,
  /**
   * The bottom coordinate of the undocked chart window relative to the virtual
   * screen
   */
  CHART_FLOAT_BOTTOM,
} ENUM_CHART_PROPERTY_INTEGER;

typedef enum ENUM_CHART_PROPERTY_DOUBLE {
  /**
   * The size of the zero bar indent from the right border in percents
   */
  CHART_SHIFT_SIZE,
  /**
   * Chart fixed position from the left border in percent value. Chart fixed
   * position is marked by a small gray triangle on the horizontal time axis. It
   * is displayed only if the automatic chart scrolling to the right on tick
   * incoming is disabled (see CHART_AUTOSCROLL property). The bar on a fixed
   * position remains in the same place when zooming in and out.
   */
  CHART_FIXED_POSITION,
  /**
   * Fixed  chart maximum
   */
  CHART_FIXED_MAX,
  /**
   * Fixed  chart minimum
   */
  CHART_FIXED_MIN,
  /**
   * Scale in points per bar
   */
  CHART_POINTS_PER_BAR,
  /**
   * Chart minimum
   */
  CHART_PRICE_MIN,
  /**
   * Chart maximum
   */
  CHART_PRICE_MAX,
} ENUM_CHART_PROPERTY_DOUBLE;

typedef enum ENUM_CHART_PROPERTY_STRING {
  /**
   * Text of a comment in a chart
   */
  CHART_COMMENT,
  /**
   * The name of the Expert Advisor running on the chart with the specified
   * chart_id
   */
  CHART_EXPERT_NAME,
  /**
   * The name of the script running on the chart with the specified chart_id
   */
  CHART_SCRIPT_NAME,
} ENUM_CHART_PROPERTY_STRING;

typedef enum ENUM_CHART_POSITION {
  /**
   * Chart beginning (the oldest prices)
   */
  CHART_BEGIN,
  /**
   * Current position
   */
  CHART_CURRENT_POS,
  /**
   * Chart end (the latest prices)
   */
  CHART_END,
} ENUM_CHART_POSITION;

typedef enum ENUM_INDEXBUFFER_TYPE {
  /**
   * Data to draw
   */
  INDICATOR_DATA,
  /**
   * Color
   */
  INDICATOR_COLOR_INDEX,
  /**
   * Auxiliary buffers for intermediate calculations
   */
  INDICATOR_CALCULATIONS,
} ENUM_INDEXBUFFER_TYPE;

typedef enum ENUM_CUSTOMIND_PROPERTY_INTEGER {
  /**
   * Accuracy of drawing of indicator values
   */
  INDICATOR_DIGITS,
  /**
   * Fixed height of the indicator's window (the preprocessor command #property
   * indicator_height)
   */
  INDICATOR_HEIGHT,
  /**
   * Number of levels in the indicator window
   */
  INDICATOR_LEVELS,
  /**
   * Color of the level line
   */
  INDICATOR_LEVELCOLOR,
  /**
   * Style of the level line
   */
  INDICATOR_LEVELSTYLE,
  /**
   * Thickness of the level line
   */
  INDICATOR_LEVELWIDTH,
} ENUM_CUSTOMIND_PROPERTY_INTEGER;

typedef enum ENUM_CUSTOMIND_PROPERTY_DOUBLE {
  /**
   * Minimum of the indicator window
   */
  INDICATOR_MINIMUM,
  /**
   * Maximum of the indicator window
   */
  INDICATOR_MAXIMUM,
  /**
   * Level value
   */
  INDICATOR_LEVELVALUE,
} ENUM_CUSTOMIND_PROPERTY_DOUBLE;

typedef enum ENUM_CUSTOMIND_PROPERTY_STRING {
  /**
   * Short indicator name
   */
  INDICATOR_SHORTNAME,
  /**
   * Level description
   */
  INDICATOR_LEVELTEXT,
} ENUM_CUSTOMIND_PROPERTY_STRING;

typedef enum ENUM_CRYPT_METHOD {
  /**
   * BASE64
   */
  CRYPT_BASE64,
  /**
   * AES encryption with 128 bit key (16 bytes)
   */
  CRYPT_AES128,
  /**
   * AES encryption with 256 bit key (32 bytes)
   */
  CRYPT_AES256,
  /**
   * DES encryption with 56 bit key (7 bytes)
   */
  CRYPT_DES,
  /**
   * SHA1 HASH calculation
   */
  CRYPT_HASH_SHA1,
  /**
   * SHA256 HASH calculation
   */
  CRYPT_HASH_SHA256,
  /**
   * MD5 HASH calculation
   */
  CRYPT_HASH_MD5,
  /**
   * ZIP archives
   */
  CRYPT_ARCH_ZIP,
} ENUM_CRYPT_METHOD;

typedef enum ENUM_DATABASE_OPEN_FLAGS {
  /**
   * Read only
   */
  DATABASE_OPEN_READONLY,
  /**
   * Open for reading and writing
   */
  DATABASE_OPEN_READWRITE,
  /**
   * Create the file on a disk if necessary
   */
  DATABASE_OPEN_CREATE,
  /**
   * Create a database in RAM
   */
  DATABASE_OPEN_MEMORY,
  /**
   * The file is in the common folder of all terminals
   */
  DATABASE_OPEN_COMMON
} ENUM_DATABASE_OPEN_FLAGS;

typedef enum ENUM_DEAL_PROPERTY_INTEGER {
  /**
   * Deal ticket. Unique number assigned to each deal
   */
  DEAL_TICKET,
  /**
   * Deal order number
   */
  DEAL_ORDER,
  /**
   * Deal time
   */
  DEAL_TIME,
  /**
   * The time of a deal execution in milliseconds since 01.01.1970
   */
  DEAL_TIME_MSC,
  /**
   * Deal type
   */
  DEAL_TYPE,
  /**
   * Deal entry - entry in, entry out, reverse
   */
  DEAL_ENTRY,
  /**
   * Deal magic number (see ORDER_MAGIC)
   */
  DEAL_MAGIC,
  /**
   * The reason or source for deal execution
   */
  DEAL_REASON,
  /**
   * Identifier of a position, in the opening, modification or closing of which
   * this deal took part. Each position has a unique identifier that is assigned
   * to all deals executed for the symbol during the entire lifetime of the
   * position.
   */
  DEAL_POSITION_ID,
} ENUM_DEAL_PROPERTY_INTEGER;

typedef enum ENUM_DEAL_PROPERTY_DOUBLE {
  /**
   * Deal volume
   */
  DEAL_VOLUME,
  /**
   * Deal price
   */
  DEAL_PRICE,
  /**
   * Deal commission
   */
  DEAL_COMMISSION,
  /**
   * Cumulative swap on close
   */
  DEAL_SWAP,
  /**
   * Deal profit
   */
  DEAL_PROFIT,
  /**
   * Fee for making a deal charged immediately after performing a deal
   */
  DEAL_FEE,
} ENUM_DEAL_PROPERTY_DOUBLE;

typedef enum ENUM_DEAL_PROPERTY_STRING {
  /**
   * Deal symbol
   */
  DEAL_SYMBOL,
  /**
   * Deal comment
   */
  DEAL_COMMENT,
  /**
   * Deal identifier in an external trading system (on the Exchange)
   */
  DEAL_EXTERNAL_ID,
} ENUM_DEAL_PROPERTY_STRING;

typedef enum ENUM_DEAL_TYPE {
  /**
   * Buy
   */
  DEAL_TYPE_BUY,
  /**
   * Sell
   */
  DEAL_TYPE_SELL,
  /**
   * Balance
   */
  DEAL_TYPE_BALANCE,
  /**
   * Credit
   */
  DEAL_TYPE_CREDIT,
  /**
   * Additional charge
   */
  DEAL_TYPE_CHARGE,
  /**
   * Correction
   */
  DEAL_TYPE_CORRECTION,
  /**
   * Bonus
   */
  DEAL_TYPE_BONUS,
  /**
   * Additional commission
   */
  DEAL_TYPE_COMMISSION,
  /**
   * Daily commission
   */
  DEAL_TYPE_COMMISSION_DAILY,
  /**
   * Monthly commission
   */
  DEAL_TYPE_COMMISSION_MONTHLY,
  /**
   * Daily agent commission
   */
  DEAL_TYPE_COMMISSION_AGENT_DAILY,
  /**
   * Monthly agent commission
   */
  DEAL_TYPE_COMMISSION_AGENT_MONTHLY,
  /**
   * Interest rate
   */
  DEAL_TYPE_INTEREST,
  /**
   * Canceled buy deal. There can be a situation when a previously executed buy
   * deal is canceled. In this case, the type of the previously executed deal
   * (DEAL_TYPE_BUY) is changed to DEAL_TYPE_BUY_CANCELED, and its profit/loss
   * is zeroized. Previously obtained profit/loss is charged/withdrawn using a
   * separated balance operation
   */
  DEAL_TYPE_BUY_CANCELED,
  /**
   * Canceled sell deal. There can be a situation when a previously executed
   * sell deal is canceled. In this case, the type of the previously executed
   * deal (DEAL_TYPE_SELL) is changed to DEAL_TYPE_SELL_CANCELED, and its
   * profit/loss is zeroized. Previously obtained profit/loss is
   * charged/withdrawn using a separated balance operation
   */
  DEAL_TYPE_SELL_CANCELED,
  /**
   * Dividend operations
   */
  DEAL_DIVIDEND,
  /**
   * Franked (non-taxable) dividend operations
   */
  DEAL_DIVIDEND_FRANKED,
  /**
   * Tax charges
   */
  DEAL_TAX,
} ENUM_DEAL_TYPE;

typedef enum ENUM_DEAL_ENTRY {
  /**
   * Entry in
   */
  DEAL_ENTRY_IN,
  /**
   * Entry out
   */
  DEAL_ENTRY_OUT,
  /**
   * Reverse
   */
  DEAL_ENTRY_INOUT,
  /**
   * Close a position by an opposite one
   */
  DEAL_ENTRY_OUT_BY,
} ENUM_DEAL_ENTRY;

typedef enum ENUM_DEAL_REASON {
  /**
   * The deal was executed as a result of activation of an order placed from a
   * desktop terminal
   */
  DEAL_REASON_CLIENT,
  /**
   * The deal was executed as a result of activation of an order placed from a
   * mobile application
   */
  DEAL_REASON_MOBILE,
  /**
   * The deal was executed as a result of activation of an order placed from the
   * web platform
   */
  DEAL_REASON_WEB,
  /**
   * The deal was executed as a result of activation of an order placed from an
   * MQL5 program, i.e. an Expert Advisor or a script
   */
  DEAL_REASON_EXPERT,
  /**
   * The deal was executed as a result of Stop Loss activation
   */
  DEAL_REASON_SL,
  /**
   * The deal was executed as a result of Take Profit activation
   */
  DEAL_REASON_TP,
  /**
   * The deal was executed as a result of the Stop Out event
   */
  DEAL_REASON_SO,
  /**
   * The deal was executed due to a rollover
   */
  DEAL_REASON_ROLLOVER,
  /**
   * The deal was executed after charging the variation margin
   */
  DEAL_REASON_VMARGIN,
  /**
   * The deal was executed after the split (price reduction) of an instrument,
   * which had an open position during split announcement
   */
  DEAL_REASON_SPLIT,
} ENUM_DEAL_REASON;

typedef enum ENUM_DRAW_TYPE {
  /**
   * Not drawn
   */
  DRAW_NONE,
  /**
   * Line
   */
  DRAW_LINE,
  /**
   * Section
   */
  DRAW_SECTION,
  /**
   * Histogram from the zero line
   */
  DRAW_HISTOGRAM,
  /**
   * Histogram of the two indicator buffers
   */
  DRAW_HISTOGRAM2,
  /**
   * Drawing arrows
   */
  DRAW_ARROW,
  /**
   * Style Zigzag allows vertical section on the bar
   */
  DRAW_ZIGZAG,
  /**
   * Color fill between the two levels
   */
  DRAW_FILLING,
  /**
   * Display as a sequence of bars
   */
  DRAW_BARS,
  /**
   * Display as a sequence of candlesticks
   */
  DRAW_CANDLES,
  /**
   * Multicolored line
   */
  DRAW_COLOR_LINE,
  /**
   * Multicolored section
   */
  DRAW_COLOR_SECTION,
  /**
   * Multicolored histogram from the zero line
   */
  DRAW_COLOR_HISTOGRAM,
  /**
   * Multicolored histogram of the two indicator buffers
   */
  DRAW_COLOR_HISTOGRAM2,
  /**
   * Drawing multicolored arrows
   */
  DRAW_COLOR_ARROW,
  /**
   * Multicolored ZigZag
   */
  DRAW_COLOR_ZIGZAG,
  /**
   * Multicolored bars
   */
  DRAW_COLOR_BARS,
  /**
   * Multicolored candlesticks
   */
  DRAW_COLOR_CANDLES,
} ENUM_DRAW_TYPE;

typedef enum ENUM_PLOT_PROPERTY_INTEGER {
  /**
   * Arrow code for style DRAW_ARROW
   */
  PLOT_ARROW,
  /**
   * Vertical shift of arrows for style DRAW_ARROW
   */
  PLOT_ARROW_SHIFT,
  /**
   * Number of initial bars without drawing and values in the DataWindow
   */
  PLOT_DRAW_BEGIN,
  /**
   * Type of graphical construction
   */
  PLOT_DRAW_TYPE,
  /**
   * Sign of display of construction values in the DataWindow
   */
  PLOT_SHOW_DATA,
  /**
   * Shift of indicator plotting along the time axis in bars
   */
  PLOT_SHIFT,
  /**
   * Drawing line style
   */
  PLOT_LINE_STYLE,
  /**
   * The thickness of the drawing line
   */
  PLOT_LINE_WIDTH,
  /**
   * The number of colors
   */
  PLOT_COLOR_INDEXES,
  /**
   * The index of a buffer containing the drawing color
   */
  PLOT_LINE_COLOR,
} ENUM_PLOT_PROPERTY_INTEGER;

typedef enum ENUM_PLOT_PROPERTY_DOUBLE {
  /**
   * An empty value for plotting, for which there is no drawing
   */
  PLOT_EMPTY_VALUE,
} ENUM_PLOT_PROPERTY_DOUBLE;

typedef enum ENUM_PLOT_PROPERTY_STRING {
  /**
   * The name of the indicator graphical series to display in the DataWindow.
   * When working with complex graphical styles requiring several indicator
   * buffers for display, the names for each buffer can be specified using ";
"
   * as a separator. Sample code is shown in DRAW_CANDLES
   */
  PLOT_LABEL,
} ENUM_PLOT_PROPERTY_STRING;

typedef enum ENUM_LINE_STYLE {
  /**
   * Solid line
   */
  STYLE_SOLID,
  /**
   * Broken line
   */
  STYLE_DASH,
  /**
   * Dotted line
   */
  STYLE_DOT,
  /**
   * Dash-dot line
   */
  STYLE_DASHDOT,
  /**
   * Dash - two points
   */
  STYLE_DASHDOTDOT,
} ENUM_LINE_STYLE;

typedef enum ENUM_CALENDAR_EVENT_FREQUENCY {
  /**
   * Release frequency is not set
   */
  CALENDAR_FREQUENCY_NONE,
  /**
   * Released once a week
   */
  CALENDAR_FREQUENCY_WEEK,
  /**
   * Released once a month
   */
  CALENDAR_FREQUENCY_MONTH,
  /**
   * Released once a quarter
   */
  CALENDAR_FREQUENCY_QUARTER,
  /**
   * Released once a year
   */
  CALENDAR_FREQUENCY_YEAR,
  /**
   * Released once a day
   */
  CALENDAR_FREQUENCY_DAY,
} ENUM_CALENDAR_EVENT_FREQUENCY;

typedef enum ENUM_CALENDAR_EVENT_TYPE {
  /**
   * Event (meeting, speech, etc.)
   */
  CALENDAR_TYPE_EVENT,
  /**
   * Indicator
   */
  CALENDAR_TYPE_INDICATOR,
  /**
   * Holiday
   */
  CALENDAR_TYPE_HOLIDAY,
} ENUM_CALENDAR_EVENT_TYPE;

typedef enum ENUM_CALENDAR_EVENT_SECTOR {
  /**
   * Sector is not set
   */
  CALENDAR_SECTOR_NONE,
  /**
   * Market, exchange
   */
  CALENDAR_SECTOR_MARKET,
  /**
   * Gross Domestic Product (GDP)
   */
  CALENDAR_SECTOR_GDP,
  /**
   * Labor market
   */
  CALENDAR_SECTOR_JOBS,
  /**
   * Prices
   */
  CALENDAR_SECTOR_PRICES,
  /**
   * Money
   */
  CALENDAR_SECTOR_MONEY,
  /**
   * Trading
   */
  CALENDAR_SECTOR_TRADE,
  /**
   * Government
   */
  CALENDAR_SECTOR_GOVERNMENT,
  /**
   * Business
   */
  CALENDAR_SECTOR_BUSINESS,
  /**
   * Consumption
   */
  CALENDAR_SECTOR_CONSUMER,
  /**
   * Housing
   */
  CALENDAR_SECTOR_HOUSING,
  /**
   * Taxes
   */
  CALENDAR_SECTOR_TAXES,
  /**
   * Holidays
   */
  CALENDAR_SECTOR_HOLIDAYS,
} ENUM_CALENDAR_EVENT_SECTOR;

typedef enum ENUM_CALENDAR_EVENT_IMPORTANCE {
  CALENDAR_IMPORTANCE_NONE,
  CALENDAR_IMPORTANCE_LOW,
  CALENDAR_IMPORTANCE_MODERATE,
  CALENDAR_IMPORTANCE_HIGH,
} ENUM_CALENDAR_EVENT_IMPORTANCE;

typedef enum ENUM_CALENDAR_EVENT_UNIT {
  /**
   * Measurement unit is not set
   */
  CALENDAR_UNIT_NONE,
  /**
   * Percentage
   */
  CALENDAR_UNIT_PERCENT,
  /**
   * National currency
   */
  CALENDAR_UNIT_CURRENCY,
  /**
   * Hours
   */
  CALENDAR_UNIT_HOUR,
  /**
   * Jobs
   */
  CALENDAR_UNIT_JOB,
  /**
   * Drilling rigs
   */
  CALENDAR_UNIT_RIG,
  /**
   * USD
   */
  CALENDAR_UNIT_USD,
  /**
   * People
   */
  CALENDAR_UNIT_PEOPLE,
  /**
   * Mortgage loans
   */
  CALENDAR_UNIT_MORTGAGE,
  /**
   * Votes
   */
  CALENDAR_UNIT_VOTE,
  /**
   * Barrels
   */
  CALENDAR_UNIT_BARREL,
  /**
   * Cubic feet
   */
  CALENDAR_UNIT_CUBICFEET,
  /**
   * Non-commercial net positions
   */
  CALENDAR_UNIT_POSITION,
  /**
   * Buildings
   */
  CALENDAR_UNIT_BUILDING,
} ENUM_CALENDAR_EVENT_UNIT;

typedef enum ENUM_CALENDAR_EVENT_MULTIPLIER {
  CALENDAR_MULTIPLIER_NONE,
  CALENDAR_MULTIPLIER_THOUSANDS,
  CALENDAR_MULTIPLIER_MILLIONS,
  CALENDAR_MULTIPLIER_BILLIONS,
  CALENDAR_MULTIPLIER_TRILLIONS,
} ENUM_CALENDAR_EVENT_MULTIPLIER;

typedef enum ENUM_CALENDAR_EVENT_IMPACT {
  CALENDAR_IMPACT_NA,
  CALENDAR_IMPACT_POSITIVE,
  CALENDAR_IMPACT_NEGATIVE,
} ENUM_CALENDAR_EVENT_IMPACT;

typedef enum ENUM_CALENDAR_EVENT_TIMEMODE {
  /**
   * Source publishes an exact time of an event
   */
  CALENDAR_TIMEMODE_DATETIME,
  /**
   * Event takes all day
   */
  CALENDAR_TIMEMODE_DATE,
  /**
   * Source publishes no time of an event
   */
  CALENDAR_TIMEMODE_NOTIME,
  /**
   * Source publishes a day of an event rather than its exact time. The time is
   * specified upon the occurrence of the event.
   */
  CALENDAR_TIMEMODE_TENTATIVE,
} ENUM_CALENDAR_EVENT_TIMEMODE;

typedef enum ENUM_FILE_PROPERTY_INTEGER {
  /**
   * Check the existence
   */
  FILE_EXISTS,
  /**
   * Date of creation
   */
  FILE_CREATE_DATE,
  /**
   * Date of the last modification
   */
  FILE_MODIFY_DATE,
  /**
   * Date of the last access to the file
   */
  FILE_ACCESS_DATE,
  /**
   * File size in bytes
   */
  FILE_SIZE,
  /**
   * Position of a pointer in the file
   */
  FILE_POSITION,
  /**
   * Get the end of file sign
   */
  FILE_END,
  /**
   * Get the end of line sign
   */
  FILE_LINE_END,
  /**
   * The file is opened in a shared folder of all terminals (see FILE_COMMON)
   */
  FILE_IS_COMMON,
  /**
   * The file is opened as a text file (see FILE_TXT)
   */
  FILE_IS_TEXT,
  /**
   * The file is opened as a binary file (see FILE_BIN)
   */
  FILE_IS_BINARY,
  /**
   * The file is opened as CSV (see FILE_CSV)
   */
  FILE_IS_CSV,
  /**
   * The file is opened as ANSI (see FILE_ANSI)
   */
  FILE_IS_ANSI,
  /**
   * The opened file is readable (see FILE_READ)
   */
  FILE_IS_READABLE,
  /**
   * The opened file is writable (see FILE_WRITE)
   */
  FILE_IS_WRITABLE,
} ENUM_FILE_PROPERTY_INTEGER;

#undef SEEK_SET
#undef SEEK_CUR
#undef SEEK_END

typedef enum ENUM_FILE_POSITION {
  /**
   * File beginning
   */
  SEEK_SET,
  /**
   * Current position of a file pointer
   */
  SEEK_CUR,
  /**
   * File end
   */
  SEEK_END,
} ENUM_FILE_POSITION;

typedef enum ENUM_POINTER_TYPE {
  /**
   * Incorrect pointer
   */
  POINTER_INVALID,
  /**
   * Pointer of the object created by the new() operator
   */
  POINTER_DYNAMIC,
  /**
   * Pointer of any objects created automatically (not using new())
   */
  POINTER_AUTOMATIC,

} ENUM_POINTER_TYPE;

typedef enum ENUM_INDICATOR {
  /**
   * Accelerator Oscillator
   */
  IND_AC,
  /**
   * Accumulation/Distribution
   */
  IND_AD,
  /**
   * Average Directional Index
   */
  IND_ADX,
  /**
   * ADX by Welles Wilder
   */
  IND_ADXW,
  /**
   * Alligator
   */
  IND_ALLIGATOR,
  /**
   * Adaptive Moving Average
   */
  IND_AMA,
  /**
   * Awesome Oscillator
   */
  IND_AO,
  /**
   * Average True Range
   */
  IND_ATR,
  /**
   * Bollinger Bands®
   */
  IND_BANDS,
  /**
   * Bears Power
   */
  IND_BEARS,
  /**
   * Bulls Power
   */
  IND_BULLS,
  /**
   * Market Facilitation Index
   */
  IND_BWMFI,
  /**
   * Commodity Channel Index
   */
  IND_CCI,
  /**
   * Chaikin Oscillator
   */
  IND_CHAIKIN,
  /**
   * Custom indicator
   */
  IND_CUSTOM,
  /**
   * Double Exponential Moving Average
   */
  IND_DEMA,
  /**
   * DeMarker
   */
  IND_DEMARKER,
  /**
   * Envelopes
   */
  IND_ENVELOPES,
  /**
   * Force Index
   */
  IND_FORCE,
  /**
   * Fractals
   */
  IND_FRACTALS,
  /**
   * Fractal Adaptive Moving Average
   */
  IND_FRAMA,
  /**
   * Gator Oscillator
   */
  IND_GATOR,
  /**
   * Ichimoku Kinko Hyo
   */
  IND_ICHIMOKU,
  /**
   * Moving Average
   */
  IND_MA,
  /**
   * MACD
   */
  IND_MACD,
  /**
   * Money Flow Index
   */
  IND_MFI,
  /**
   * Momentum
   */
  IND_MOMENTUM,
  /**
   * On Balance Volume
   */
  IND_OBV,
  /**
   * OsMA
   */
  IND_OSMA,
  /**
   * Relative Strength Index
   */
  IND_RSI,
  /**
   * Relative Vigor Index
   */
  IND_RVI,
  /**
   * Parabolic SAR
   */
  IND_SAR,
  /**
   * Standard Deviation
   */
  IND_STDDEV,
  /**
   * Stochastic Oscillator
   */
  IND_STOCHASTIC,
  /**
   * Triple Exponential Moving Average
   */
  IND_TEMA,
  /**
   * Triple Exponential Moving Averages Oscillator
   */
  IND_TRIX,
  /**
   * Variable Index Dynamic Average
   */
  IND_VIDYA,
  /**
   * Volumes
   */
  IND_VOLUMES,
  /**
   * Williams' Percent Range
   */
  IND_WPR,
} ENUM_INDICATOR;

typedef enum ENUM_DATATYPE {
  TYPE_BOOL,
  TYPE_CHAR,
  TYPE_UCHAR,
  TYPE_SHORT,
  TYPE_USHORT,
  TYPE_COLOR,
  TYPE_INT,
  TYPE_UINT,
  TYPE_DATETIME,
  TYPE_LONG,
  TYPE_ULONG,
  TYPE_FLOAT,
  TYPE_DOUBLE,
  TYPE_STRING,
} ENUM_DATATYPE;

typedef enum ENUM_MA_METHOD {
  /**
   * Simple averaging
   */
  MODE_SMA,
  /**
   * Exponential averaging
   */
  MODE_EMA,
  /**
   * Smoothed averaging
   */
  MODE_SMMA,
  /**
   * Linear-weighted averaging
   */
  MODE_LWMA,
} ENUM_MA_METHOD;

typedef enum ENUM_FP_CLASS {
  /**
   * A subnormal number which is closer to zero than the smallest representable
   * normal number DBL_MIN (2.2250738585072014e-308)
   */
  FP_SUBNORMAL,
  /**
   * A normal number in the range between 2.2250738585072014e-308
   * and 1.7976931348623158e+308
   */
  FP_NORMAL,
  /**
   * A positive or a negative zero
   */
  FP_ZERO,
  /**
   * A number which cannot be represented by the appropriate type, positive or
   * negative infinity
   */
  FP_INFINITE,
  /**
   * Not a number.
   */
  FP_NAN,
} ENUM_FP_CLASS;

typedef enum ENUM_COLOR_FORMAT {
  /**
   * The component of the alpha channel is ignored
   */
  COLOR_FORMAT_XRGB_NOALPHA,
  /**
   * Color components are not handled by the terminal (must be correctly set by
   * the user)
   */
  COLOR_FORMAT_ARGB_RAW,
  /**
   * Color components are handled by the terminal
   */
  COLOR_FORMAT_ARGB_NORMALIZE
} ENUM_COLOR_FORMAT;

typedef enum ENUM_OBJECT {
  /**
   * Vertical Line
   */
  OBJ_VLINE,
  /**
   * Horizontal Line
   */
  OBJ_HLINE,
  /**
   * Trend Line
   */
  OBJ_TREND,
  /**
   * Trend Line By Angle
   */
  OBJ_TRENDBYANGLE,
  /**
   * Cycle Lines
   */
  OBJ_CYCLES,
  /**
   * Arrowed Line
   */
  OBJ_ARROWED_LINE,
  /**
   * Equidistant Channel
   */
  OBJ_CHANNEL,
  /**
   * Standard Deviation Channel
   */
  OBJ_STDDEVCHANNEL,
  /**
   * Linear Regression Channel
   */
  OBJ_REGRESSION,
  /**
   * Andrews’ Pitchfork
   */
  OBJ_PITCHFORK,
  /**
   * Gann Line
   */
  OBJ_GANNLINE,
  /**
   * Gann Fan
   */
  OBJ_GANNFAN,
  /**
   * Gann Grid
   */
  OBJ_GANNGRID,
  /**
   * Fibonacci Retracement
   */
  OBJ_FIBO,
  /**
   * Fibonacci Time Zones
   */
  OBJ_FIBOTIMES,
  /**
   * Fibonacci Fan
   */
  OBJ_FIBOFAN,
  /**
   * Fibonacci Arcs
   */
  OBJ_FIBOARC,
  /**
   * Fibonacci Channel
   */
  OBJ_FIBOCHANNEL,
  /**
   * Fibonacci Expansion
   */
  OBJ_EXPANSION,
  /**
   * Elliott Motive Wave
   */
  OBJ_ELLIOTWAVE5,
  /**
   * Elliott Correction Wave
   */
  OBJ_ELLIOTWAVE3,
  /**
   * Rectangle
   */
  OBJ_RECTANGLE,
  /**
   * Triangle
   */
  OBJ_TRIANGLE,
  /**
   * Ellipse
   */
  OBJ_ELLIPSE,
  /**
   * Thumbs Up
   */
  OBJ_ARROW_THUMB_UP,
  /**
   * Thumbs Down
   */
  OBJ_ARROW_THUMB_DOWN,
  /**
   * Arrow Up
   */
  OBJ_ARROW_UP,
  /**
   * Arrow Down
   */
  OBJ_ARROW_DOWN,
  /**
   * Stop Sign
   */
  OBJ_ARROW_STOP,
  /**
   * Check Sign
   */
  OBJ_ARROW_CHECK,
  /**
   * Left Price Label
   */
  OBJ_ARROW_LEFT_PRICE,
  /**
   * Right Price Label
   */
  OBJ_ARROW_RIGHT_PRICE,
  /**
   * Buy Sign
   */
  OBJ_ARROW_BUY,
  /**
   * Sell Sign
   */
  OBJ_ARROW_SELL,
  /**
   * Arrow
   */
  OBJ_ARROW,
  /**
   * Text
   */
  OBJ_TEXT,
  /**
   * Label
   */
  OBJ_LABEL,
  /**
   * Button
   */
  OBJ_BUTTON,
  /**
   * Chart
   */
  OBJ_CHART,
  /**
   * Bitmap
   */
  OBJ_BITMAP,
  /**
   * Bitmap Label
   */
  OBJ_BITMAP_LABEL,
  /**
   * Edit
   */
  OBJ_EDIT,
  /**
   * The "Event" object corresponding to an event in the economic calendar
   */
  OBJ_EVENT,
  /**
   * The "Rectangle label" object for creating and designing the custom
   * graphical interface.
   */
  OBJ_RECTANGLE_LABEL
} ENUM_OBJECT;

typedef enum ENUM_OBJECT_PROPERTY_INTEGER {
  /**
   * Color
   */
  OBJPROP_COLOR,
  /**
   * Style
   */
  OBJPROP_STYLE,
  /**
   * Line thickness
   */
  OBJPROP_WIDTH,
  /**
   * Object in the background
   */
  OBJPROP_BACK,
  /**
   * Priority of a graphical object for receiving events of clicking on a chart
   * (CHARTEVENT_CLICK). The default zero value is set when creating an object;

   * the priority can be increased if necessary. When objects are placed one
   * atop another, only one of them with the highest priority will receive the
   * CHARTEVENT_CLICK event.
   */
  OBJPROP_ZORDER,
  /**
   * Fill an object with color (for OBJ_RECTANGLE, OBJ_TRIANGLE, OBJ_ELLIPSE,
   * OBJ_CHANNEL, OBJ_STDDEVCHANNEL, OBJ_REGRESSION)
   */
  OBJPROP_FILL,
  /**
   * Prohibit showing of the name of a graphical object in the list of objects
   * from the terminal menu "Charts" - "Objects" - "List of objects". The true
   * value allows to hide an object from the list. By default, true is set to
   * the objects that display calendar events, trading history and to the
   * objects created from MQL5 programs. To see such graphical objects and
   * access their properties, click on the "All" button in the "List of objects"
   * window.
   */
  OBJPROP_HIDDEN,
  /**
   * Object is selected
   */
  OBJPROP_SELECTED,
  /**
   * Ability to edit text in the Edit object
   */
  OBJPROP_READONLY,
  /**
   * Object type
   */
  OBJPROP_TYPE,
  /**
   * Time coordinate
   */
  OBJPROP_TIME,
  /**
   * Object availability
   */
  OBJPROP_SELECTABLE,
  /**
   * Time of object creation
   */
  OBJPROP_CREATETIME,
  /**
   * Number of levels
   */
  OBJPROP_LEVELS,
  /**
   * Color of the line-level
   */
  OBJPROP_LEVELCOLOR,
  /**
   * Style of the line-level
   */
  OBJPROP_LEVELSTYLE,
  /**
   * Thickness of the line-level
   */
  OBJPROP_LEVELWIDTH,
  /**
   * Horizontal text alignment in the "Edit" object (OBJ_EDIT)
   */
  OBJPROP_ALIGN,
  /**
   * Font size
   */
  OBJPROP_FONTSIZE,
  /**
   * Ray goes to the left
   */
  OBJPROP_RAY_LEFT,
  /**
   * Ray goes to the right
   */
  OBJPROP_RAY_RIGHT,
  /**
   * A vertical line goes through all the windows of a chart
   */
  OBJPROP_RAY,
  /**
   * Showing the full ellipse of the Fibonacci Arc object (OBJ_FIBOARC)
   */
  OBJPROP_ELLIPSE,
  /**
   * Arrow code for the Arrow object
   */
  OBJPROP_ARROWCODE,
  /**
   * Visibility of an object at timeframes
   */
  OBJPROP_TIMEFRAMES,
  /**
   * Location of the anchor point of a graphical object
   */
  OBJPROP_ANCHOR,
  /**
   * The distance in pixels along the X axis from the binding corner (see note)
   */
  OBJPROP_XDISTANCE,
  /**
   * The distance in pixels along the Y axis from the binding corner (see note)
   */
  OBJPROP_YDISTANCE,
  /**
   * Trend of the Gann object
   */
  OBJPROP_DIRECTION,
  /**
   * Level of the Elliott Wave Marking
   */
  OBJPROP_DEGREE,
  /**
   * Displaying lines for marking the Elliott Wave
   */
  OBJPROP_DRAWLINES,
  /**
   * Button state (pressed / depressed)
   */
  OBJPROP_STATE,
  /**
   * ID of the "Chart" object (OBJ_CHART). It allows working with the properties
   * of this object like with a normal chart using the functions described in
   * Chart Operations, but there some exceptions.
   */
  OBJPROP_CHART_ID,
  /**
   * The object's width along the X axis in pixels. Specified for  OBJ_LABEL
   * (read only), OBJ_BUTTON, OBJ_CHART, OBJ_BITMAP, OBJ_BITMAP_LABEL, OBJ_EDIT,
   * OBJ_RECTANGLE_LABEL objects.
   */
  OBJPROP_XSIZE,
  /**
   * The object's height along the Y axis in pixels. Specified for  OBJ_LABEL
   * (read only), OBJ_BUTTON, OBJ_CHART, OBJ_BITMAP, OBJ_BITMAP_LABEL, OBJ_EDIT,
   * OBJ_RECTANGLE_LABEL objects.
   */
  OBJPROP_YSIZE,
  /**
   * The X coordinate of the upper left corner of the rectangular visible area
   * in the graphical objects "Bitmap Label" and "Bitmap" (OBJ_BITMAP_LABEL and
   * OBJ_BITMAP). The value is set in pixels relative to the upper left corner
   * of the original image.
   */
  OBJPROP_XOFFSET,
  /**
   * The Y coordinate of the upper left corner of the rectangular visible area
   * in the graphical objects "Bitmap Label" and "Bitmap" (OBJ_BITMAP_LABEL and
   * OBJ_BITMAP). The value is set in pixels relative to the upper left corner
   * of the original image.
   */
  OBJPROP_YOFFSET,
  /**
   * Timeframe for the Chart object
   */
  OBJPROP_PERIOD,
  /**
   * Displaying the time scale for the Chart object
   */
  OBJPROP_DATE_SCALE,
  /**
   * Displaying the price scale for the Chart object
   */
  OBJPROP_PRICE_SCALE,
  /**
   * The scale for the Chart object
   */
  OBJPROP_CHART_SCALE,
  /**
   * The background color for  OBJ_EDIT, OBJ_BUTTON, OBJ_RECTANGLE_LABEL
   */
  OBJPROP_BGCOLOR,
  /**
   * The corner of the chart to link a graphical object
   */
  OBJPROP_CORNER,
  /**
   * Border type for the "Rectangle label" object
   */
  OBJPROP_BORDER_TYPE,
  /**
   * Border color for the OBJ_EDIT and OBJ_BUTTON objects
   */
  OBJPROP_BORDER_COLOR,
} ENUM_OBJECT_PROPERTY_INTEGER;

typedef enum ENUM_OBJECT_PROPERTY_DOUBLE {
  /**
   * Price coordinate
   */
  OBJPROP_PRICE,
  /**
   * Level value
   */
  OBJPROP_LEVELVALUE,
  /**
   * Scale (properties of Gann objects and Fibonacci Arcs)
   */
  OBJPROP_SCALE,
  /**
   * Angle.  For the objects with no angle specified, created from a program,
   * the value is equal to EMPTY_VALUE
   */
  OBJPROP_ANGLE,
  /**
   * Deviation for the Standard Deviation Channel
   */
  OBJPROP_DEVIATION,
} ENUM_OBJECT_PROPERTY_DOUBLE;

typedef enum ENUM_OBJECT_PROPERTY_STRING {
  /**
   * Object name
   */
  OBJPROP_NAME,
  /**
   * Description of the object (the text contained in the object)
   */
  OBJPROP_TEXT,
  /**
   * The text of a tooltip. If the property is not set, then the tooltip
   * generated automatically by the terminal is shown. A tooltip can be disabled
   * by setting the "\n" (line feed) value to it
   */
  OBJPROP_TOOLTIP,
  /**
   * Level description
   */
  OBJPROP_LEVELTEXT,
  /**
   * Font
   */
  OBJPROP_FONT,
  /**
   * The name of BMP-file for Bitmap Label. See also Resources
   */
  OBJPROP_BMPFILE,
  /**
   * Symbol for the Chart object
   */
  OBJPROP_SYMBOL,
} ENUM_OBJECT_PROPERTY_STRING;

typedef enum ENUM_OPENCL_HANDLE_TYPE {
  /**
   * Incorrect handle
   */
  OPENCL_INVALID,
  /**
   * A handle of the OpenCL context
   */
  OPENCL_CONTEXT,
  /**
   * A handle of the OpenCL program
   */
  OPENCL_PROGRAM,
  /**
   * A handle of the OpenCL kernel
   */
  OPENCL_KERNEL,
  /**
   * A handle of the OpenCL buffer
   */
  OPENCL_BUFFER
} ENUM_OPENCL_HANDLE_TYPE;

typedef enum ENUM_OPENCL_PROPERTY_INTEGER {
  /**
   * Dedicated OpenCL accelerators (for example, the IBM CELL Blade). These
   * devices communicate with the host processor using a peripheral interconnect
   * such as PCIe.
   */
  CL_DEVICE_ACCELERATOR,
  /**
   * An OpenCL device that is the host processor. The host processor runs the
   * OpenCL implementations and is a single or multi-core CPU.
   */
  CL_DEVICE_CPU,
  /**
   * An OpenCL device that is a GPU.
   */
  CL_DEVICE_GPU,
  /**
   * The default OpenCL device in the system. The default device cannot be a
   * CL_DEVICE_TYPE_CUSTOM device.
   */
  CL_DEVICE_DEFAULT,
  /**
   * Dedicated accelerators that do not support programs written in OpenCL C.
   */
  CL_DEVICE_CUSTOM
} ENUM_OPENCL_PROPERTY_INTEGER;

typedef enum ENUM_CL_DEVICE_TYPE {
  /**
   * The number of devices with OpenCL support. This property does not require
   * specification of the first parameter, i.e. you can pass a zero value for
   * the handle parameter.
   */
  CL_DEVICE_COUNT,
  /**
   * Type of device
   */
  CL_DEVICE_TYPE,
  /**
   * Unique vendor identifier
   */
  CL_DEVICE_VENDOR_ID,
  /**
   * Number of parallel calculated tasks in OpenCL device. One working group
   * solves one computational task. The lowest value is 1
   */
  CL_DEVICE_MAX_COMPUTE_UNITS,
  /**
   * Highest set frequency of the device in MHz.
   */
  CL_DEVICE_MAX_CLOCK_FREQUENCY,
  /**
   * Size of the global memory of the device in bytes
   */
  CL_DEVICE_GLOBAL_MEM_SIZE,
  /**
   * Size of the processed data (scene) local memory in bytes
   */
  CL_DEVICE_LOCAL_MEM_SIZE,
  /**
   * The total number of the local working groups available for an OpenCL
   * device.
   */
  CL_DEVICE_MAX_WORK_GROUP_SIZE
} ENUM_CL_DEVICE_TYPE;

typedef enum ENUM_OPENCL_PROPERTY_STRING {
  /**
   * CL_PLATFORM_PROFILE - OpenCL Profile.  Profile name may be one of the
   * following values:
   *
   * FULL_PROFILE - implementation supports OpenCL (functionality is defined as
   * the part of the kernel specification without requiring additional
   * extensions for OpenCL support);

   * EMBEDDED_PROFILE - implementation supports OpenCL as a supplement. Amended
   * profile is defined as a subset for each OpenCL version.
   */
  CL_PLATFORM_PROFILE,
  /**
   * OpenCL version
   */
  CL_PLATFORM_VERSION,
  /**
   * Platform vendor name
   */
  CL_PLATFORM_VENDOR,
  /**
   * List of extensions supported by the platform. Extension names should be
   * supported by all devices related to this platform
   */
  CL_PLATFORM_EXTENSIONS,
  /**
   * Device name
   */
  CL_DEVICE_NAME,
  /**
   * Vendor name
   */
  CL_DEVICE_VENDOR,
  /**
   * OpenCL driver version in major_number.minor_number format
   */
  CL_DRIVER_VENDOR,
  /**
   * OpenCL device profile. Profile name may be one of the following values:
   *
   * FULL_PROFILE - implementation supports OpenCL (functionality is defined as
   * the part of the kernel specification without requiring additional
   * extensions for OpenCL support);

   * EMBEDDED_PROFILE - implementation supports OpenCL as a supplement. Amended
   * profile is defined as a subset for each OpenCL version.
   */
  CL_DEVICE_PROFILE,
  /**
   * OpenCL version in
   * "OpenCL<space><major_version.minor_version><space><vendor-specific
   * information>" format
   */
  CL_DEVICE_VERSION,
  /**
   * List of extensions supported by the device. The list may contain extensions
   * supported by the vendor, as well as one or more approved names:
   *
   * • cl_khr_int64_base_atomics
   * • cl_khr_int64_extended_atomics
   * • cl_khr_fp16
   * • cl_khr_gl_sharing
   * • cl_khr_gl_event
   * • cl_khr_d3d10_sharing
   * • cl_khr_dx9_media_sharing
   * • cl_khr_d3d11_sharing
   */
  CL_DEVICE_EXTENSIONS,
  /**
   * The list of supported kernels separated by ";
".
   */
  CL_DEVICE_BUILT_IN_KERNELS,
  /**
   * The maximum version supported by the compiler for this device. Version
   * format:
   * "OpenCL<space>C<space><major_version.minor_version><space><vendor-specific
   * information>"
   */
  CL_DEVICE_OPENCL_C_VERSION
} ENUM_OPENCL_PROPERTY_STRING;

typedef enum ENUM_BORDER_TYPE {
  /**
   * Flat form
   */
  BORDER_FLAT,
  /**
   * Prominent form
   */
  BORDER_RAISED,
  /**
   * Concave form
   */
  BORDER_SUNKEN
} ENUM_BORDER_TYPE;

typedef enum ENUM_ALIGN_MODE {
  /**
   * Left alignment
   */
  ALIGN_LEFT,
  /**
   * Centered (only for the Edit object)
   */
  ALIGN_CENTER,
  /**
   * Right alignment
   */
  ALIGN_RIGHT
} ENUM_ALIGN_MODE;

typedef enum ENUM_POSITION_PROPERTY_INTEGER {
  /**
   * Position ticket. Unique number assigned to each newly opened position. It
   * usually matches the ticket of an order used to open the position except
   * when the ticket is changed as a result of service operations on the server,
   * for example, when charging swaps with position re-opening. To find an order
   * used to open a position, apply the POSITION_IDENTIFIER property.  
   *
   * POSITION_TICKET value corresponds to MqlTradeRequest::position.
   */
  POSITION_TICKET,
  /**
   * Position open time
   */
  POSITION_TIME,
  /**
   * Position opening time in milliseconds since 01.01.1970
   */
  POSITION_TIME_MSC,
  /**
   * Position changing time
   */
  POSITION_TIME_UPDATE,
  /**
   * Position changing time in milliseconds since 01.01.1970
   */
  POSITION_TIME_UPDATE_MSC,
  /**
   * Position type
   */
  POSITION_TYPE,
  /**
   * Position magic number (see ORDER_MAGIC)
   */
  POSITION_MAGIC,
  /**
   * Position identifier is a unique number assigned to each re-opened position.
   * It does not change throughout its life cycle and corresponds to the ticket
   * of an order used to open a position.
   *
   * Position identifier is specified in each order (ORDER_POSITION_ID) and deal
   * (DEAL_POSITION_ID) used to open, modify, or close it. Use this property to
   * search for orders and deals related to the position.
   *
   * When reversing a position in netting mode (using a single in/out trade),
   * POSITION_IDENTIFIER does not change. However, POSITION_TICKET is replaced
   * with the ticket of the order that led to the reversal. Position reversal is
   * not provided in hedging mode.
   */
  POSITION_IDENTIFIER,
  /**
   * The reason for opening a position
   */
  POSITION_REASON,
} ENUM_POSITION_PROPERTY_INTEGER;

typedef enum ENUM_POSITION_PROPERTY_DOUBLE {
  /**
   * Position volume
   */
  POSITION_VOLUME,
  /**
   * Position open price
   */
  POSITION_PRICE_OPEN,
  /**
   * Stop Loss level of opened position
   */
  POSITION_SL,
  /**
   * Take Profit level of opened position
   */
  POSITION_TP,
  /**
   * Current price of the position symbol
   */
  POSITION_PRICE_CURRENT,
  /**
   * Cumulative swap
   */
  POSITION_SWAP,
  /**
   * Current profit
   */
  POSITION_PROFIT,
} ENUM_POSITION_PROPERTY_DOUBLE;

typedef enum ENUM_POSITION_PROPERTY_STRING {
  /**
   * Symbol of the position
   */
  POSITION_SYMBOL,
  /**
   * Position comment
   */
  POSITION_COMMENT,
  /**
   * Position identifier in an external trading system (on the Exchange)
   */
  POSITION_EXTERNAL_ID,
} ENUM_POSITION_PROPERTY_STRING;

typedef enum ENUM_POSITION_TYPE {
  POSITION_TYPE_BUY,
  POSITION_TYPE_SELL,
} ENUM_POSITION_TYPE;

typedef enum ENUM_POSITION_REASON {
  /**
   * The position was opened as a result of activation of an order placed from a
   * desktop terminal
   */
  POSITION_REASON_CLIENT,
  /**
   * The position was opened as a result of activation of an order placed from a
   * mobile application
   */
  POSITION_REASON_MOBILE,
  /**
   * The position was opened as a result of activation of an order placed from
   * the web platform
   */
  POSITION_REASON_WEB,
  /**
   * The position was opened as a result of activation of an order placed from
   * an MQL5 program, i.e. an Expert Advisor or a script
   */
  POSITION_REASON_EXPERT,
} ENUM_POSITION_REASON;

typedef enum ENUM_APPLIED_PRICE {
  /**
   * Close price
   */
  PRICE_CLOSE,
  /**
   * Open price
   */
  PRICE_OPEN,
  /**
   * The maximum price for the period
   */
  PRICE_HIGH,
  /**
   * The minimum price for the period
   */
  PRICE_LOW,
  /**
   * Median price, (high + low)/2
   */
  PRICE_MEDIAN,
  /**
   * Typical price, (high + low + close)/3
   */
  PRICE_TYPICAL,
  /**
   * Average price, (high + low + close + close)/4
   */
  PRICE_WEIGHTED,
} ENUM_APPLIED_PRICE;

typedef enum ENUM_APPLIED_VOLUME {
  /**
   * Tick volume
   */
  VOLUME_TICK,
  /**
   * Trade volume
   */
  VOLUME_REAL,
} ENUM_APPLIED_VOLUME;

typedef enum ENUM_STATISTICS {
  /**
   * The value of the initial deposit
   */
  STAT_INITIAL_DEPOSIT,
  /**
   * Money withdrawn from an account
   */
  STAT_WITHDRAWAL,
  /**
   * Net profit after testing, the sum of STAT_GROSS_PROFIT and
   * STAT_GROSS_LOSS (STAT_GROSS_LOSS is always less than or equal to zero)
   */
  STAT_PROFIT,
  /**
   * Total profit, the sum of all profitable (positive) trades. The value is
   * greater than or equal to zero
   */
  STAT_GROSS_PROFIT,
  /**
   * Total loss, the sum of all negative trades. The value is less than or
   * equal to zero
   */
  STAT_GROSS_LOSS,
  /**
   * Maximum profit – the largest value of all profitable trades. The value is
   * greater than or equal to zero
   */
  STAT_MAX_PROFITTRADE,
  /**
   * Maximum loss – the lowest value of all losing trades. The value is less
   * than or equal to zero
   */
  STAT_MAX_LOSSTRADE,
  /**
   * Maximum profit in a series of profitable trades. The value is greater
   * than or equal to zero
   */
  STAT_CONPROFITMAX,
  /**
   * The number of trades that have formed STAT_CONPROFITMAX (maximum profit
   * in a series of profitable trades)
   */
  STAT_CONPROFITMAX_TRADES,
  /**
   * The total profit of the longest series of profitable trades
   */
  STAT_MAX_CONWINS,
  /**
   * The number of trades in the longest series of profitable trades
   * STAT_MAX_CONWINS
   */
  STAT_MAX_CONPROFIT_TRADES,
  /**
   * Maximum loss in a series of losing trades. The value is less than or
   * equal to zero
   */
  STAT_CONLOSSMAX,
  /**
   * The number of trades that have formed STAT_CONLOSSMAX (maximum loss in a
   * series of losing trades)
   */
  STAT_CONLOSSMAX_TRADES,
  /**
   * The total loss of the longest series of losing trades
   */
  STAT_MAX_CONLOSSES,
  /**
   * The number of trades in the longest series of losing trades
   * STAT_MAX_CONLOSSES
   */
  STAT_MAX_CONLOSS_TRADES,
  /**
   * Minimum balance value
   */
  STAT_BALANCEMIN,
  /**
   * Maximum balance drawdown in monetary terms. In the process of trading, a
   * balance may have numerous drawdowns; here the largest value is taken
   */
  STAT_BALANCE_DD,
  /**
   * Balance drawdown as a percentage that was recorded at the moment of the
   * maximum balance drawdown in monetary terms (STAT_BALANCE_DD).
   */
  STAT_BALANCEDD_PERCENT,
  /**
   * Maximum balance drawdown as a percentage. In the process of trading, a
   * balance may have numerous drawdowns, for each of which the relative
   * drawdown value in percents is calculated. The greatest value is returned
   */
  STAT_BALANCE_DDREL_PERCENT,
  /**
   * Balance drawdown in monetary terms that was recorded at the moment of the
   * maximum balance drawdown as a percentage (STAT_BALANCE_DDREL_PERCENT).
   */
  STAT_BALANCE_DD_RELATIVE,
  /**
   * Minimum equity value
   */
  STAT_EQUITYMIN,
  /**
   * Maximum equity drawdown in monetary terms. In the process of trading,
   * numerous drawdowns may appear on the equity; here the largest value is
   * taken
   */
  STAT_EQUITY_DD,
  /**
   * Drawdown in percent that was recorded at the moment of the maximum equity
   * drawdown in monetary terms (STAT_EQUITY_DD).
   */
  STAT_EQUITYDD_PERCENT,
  /**
   * Maximum equity drawdown as a percentage. In the process of trading, an
   * equity may have numerous drawdowns, for each of which the relative
   * drawdown value in percents is calculated. The greatest value is returned
   */
  STAT_EQUITY_DDREL_PERCENT,
  /**
   * Equity drawdown in monetary terms that was recorded at the moment of the
   * maximum equity drawdown in percent (STAT_EQUITY_DDREL_PERCENT).
   */
  STAT_EQUITY_DD_RELATIVE,
  /**
   * Expected payoff
   */
  STAT_EXPECTED_PAYOFF,
  /**
   * Profit factor, equal to  the ratio of STAT_GROSS_PROFIT/STAT_GROSS_LOSS.
   * If STAT_GROSS_LOSS=0, the profit factor is equal to DBL_MAX
   */
  STAT_PROFIT_FACTOR,
  /**
   * Recovery factor, equal to the ratio of STAT_PROFIT/STAT_BALANCE_DD
   */
  STAT_RECOVERY_FACTOR,
  /**
   * Sharpe ratio
   */
  STAT_SHARPE_RATIO,
  /**
   * Minimum value of the margin level
   */
  STAT_MIN_MARGINLEVEL,
  /**
   * The value of the calculated custom optimization criterion returned by the
   * OnTester() function
   */
  STAT_CUSTOM_ONTESTER,
  /**
   * The number of deals
   */
  STAT_DEALS,
  /**
   * The number of trades
   */
  STAT_TRADES,
  /**
   * Profitable trades
   */
  STAT_PROFIT_TRADES,
  /**
   * Losing trades
   */
  STAT_LOSS_TRADES,
  /**
   * Short trades
   */
  STAT_SHORT_TRADES,
  /**
   * Long trades
   */
  STAT_LONG_TRADES,
  /**
   * Profitable short trades
   */
  STAT_PROFIT_SHORTTRADES,
  /**
   * Profitable long trades
   */
  STAT_PROFIT_LONGTRADES,
  /**
   * Average length of a profitable series of trades
   */
  STAT_PROFITTRADES_AVGCON,
  /**
   * Average length of a losing series of trades
   */
  STAT_LOSSTRADES_AVGCON,
} ENUM_STATISTICS;

typedef enum ENUM_STO_PRICE {
  /**
   * Calculation is based on Low/High prices
   */
  STO_LOWHIGH,
  /**
   * Calculation is based on Close/Close prices
   */
  STO_CLOSECLOSE,
} ENUM_STO_PRICE;

typedef enum ENUM_MQL_INFO_INTEGER {
  /**
   * Maximum possible amount of dynamic memory for MQL5 program in MB
   */
  MQL_MEMORY_LIMIT,
  /**
   * Memory used by MQL5 program in MB
   */
  MQL_MEMORY_USED,
  /**
   * Type of the MQL5 program
   */
  MQL_PROGRAM_TYPE,
  /**
   * The permission to use DLL for the given running program
   */
  MQL_DLLS_ALLOWED,
  /**
   * The permission to trade for the given running program
   */
  MQL_TRADE_ALLOWED,
  /**
   * The permission to modify the Signals for the given running program
   */
  MQL_SIGNALS_ALLOWED,
  /**
   * Indication that the program is running in the debugging mode
   */
  MQL_DEBUG,
  /**
   * Indication that the program is running in the code profiling mode
   */
  MQL_PROFILER,
  /**
   * Indication that the program is running in the tester
   */
  MQL_TESTER,
  /**
   * Indication that the program is running in the forward testing process
   */
  MQL_FORWARD,
  /**
   * Indication that the program is running in the optimization mode
   */
  MQL_OPTIMIZATION,
  /**
   * Indication that the program is running in the visual testing mode
   */
  MQL_VISUAL_MODE,
  /**
   * Indication that the Expert Advisor is running in gathering optimization
   * result frames mode
   */
  MQL_FRAME_MODE,
  /**
   * Type of license of the EX5 module. The license refers to the EX5 module,
   * from which a request is made using MQLInfoInteger(MQL_LICENSE_TYPE).
   */
  MQL_LICENSE_TYPE,
} ENUM_MQL_INFO_INTEGER;

typedef enum ENUM_MQL_INFO_STRING {
  /**
   * Name of the running mql5-program
   */
  MQL_PROGRAM_NAME,
  /**
   * Path for the given running program
   */
  MQL5_PROGRAM_PATH,
} ENUM_MQL_INFO_STRING;

typedef enum ENUM_PROGRAM_TYPE {
  PROGRAM_SCRIPT,
  PROGRAM_EXPERT,
  PROGRAM_INDICATOR,
} ENUM_PROGRAM_TYPE;

typedef enum ENUM_LICENSE_TYPE {
  /**
   * A free unlimited version
   */
  LICENSE_FREE,
  /**
   * A trial version of a paid product from the Market. It works only in the
   * strategy tester
   */
  LICENSE_DEMO,
  /**
   * A purchased licensed version allows at least 5 activations. The number of
   * activations is specified by seller. Seller may increase the allowed number
   * of activations
   */
  LICENSE_FULL,
  /**
   * A version with a limited term license
   */
  LICENSE_TIME,
} ENUM_LICENSE_TYPE;

typedef enum ENUM_SYMBOL_TRADE_EXECUTION {
  /**
   * Execution by request
   */
  SYMBOL_TRADE_EXECUTION_REQUEST,
  /**
   * Instant execution
   */
  SYMBOL_TRADE_EXECUTION_INSTANT,
  /**
   * Market execution
   */
  SYMBOL_TRADE_EXECUTION_MARKET,
  /**
   * Exchange execution
   */
  SYMBOL_TRADE_EXECUTION_EXCHANGE,

} ENUM_SYMBOL_TRADE_EXECUTION;

typedef enum ENUM_SYMBOL_INFO_INTEGER {
  /**
   * The sector of the economy to which the asset belongs
   */
  SYMBOL_SECTOR,
  /**
   * The industry or the economy branch to which the symbol belongs
   */
  SYMBOL_INDUSTRY,
  /**
   * It is a custom symbol – the symbol has been created synthetically based on
   * other symbols from the Market Watch and/or external data sources
   */
  SYMBOL_CUSTOM,
  /**
   * The color of the background used for the symbol in Market Watch
   */
  SYMBOL_BACKGROUND_COLOR,
  /**
   * The price type used for generating symbols bars, i.e. Bid or Last
   */
  SYMBOL_CHART_MODE,
  /**
   * Symbol with this name exists
   */
  SYMBOL_EXIST,
  /**
   * Symbol is selected in Market Watch
   */
  SYMBOL_SELECT,
  /**
   * Symbol is visible in Market Watch.
   *  
   * Some symbols (mostly, these are cross rates required for calculation of
   * margin requirements or profits in deposit currency) are selected
   * automatically, but may not be visible in Market Watch. To be displayed such
   * symbols have to be explicitly selected.
   */
  SYMBOL_VISIBLE,
  /**
   * Number of deals in the current session
   */
  SYMBOL_SESSION_DEALS,
  /**
   * Number of Buy orders at the moment
   */
  SYMBOL_SESSION_BUY_ORDERS,
  /**
   * Number of Sell orders at the moment
   */
  SYMBOL_SESSION_SELL_ORDERS,
  /**
   * Volume of the last deal
   */
  SYMBOL_VOLUME,
  /**
   * Maximal day volume
   */
  SYMBOL_VOLUMEHIGH,
  /**
   * Minimal day volume
   */
  SYMBOL_VOLUMELOW,
  /**
   * Time of the last quote
   */
  SYMBOL_TIME,
  /**
   * Time of the last quote in milliseconds since 1970.01.01
   */
  SYMBOL_TIME_MSC,
  /**
   * Digits after a decimal point
   */
  SYMBOL_DIGITS,
  /**
   * Indication of a floating spread
   */
  SYMBOL_SPREAD_FLOAT,
  /**
   * Spread value in points
   */
  SYMBOL_SPREAD,
  /**
   * Maximal number of requests shown in Depth of Market. For symbols that have
   * no queue of requests, the value is equal to zero.
   */
  SYMBOL_TICKS_BOOKDEPTH,
  /**
   * Contract price calculation mode
   */
  SYMBOL_TRADE_CALC_MODE,
  /**
   * Order execution type
   */
  SYMBOL_TRADE_MODE,
  /**
   * Date of the symbol trade beginning (usually used for futures)
   */
  SYMBOL_START_TIME,
  /**
   * Date of the symbol trade end (usually used for futures)
   */
  SYMBOL_EXPIRATION_TIME,
  /**
   * Minimal indention in points from the current close price to place Stop
   * orders
   */
  SYMBOL_TRADE_STOPS_LEVEL,
  /**
   * Distance to freeze trade operations in points
   */
  SYMBOL_TRADE_FREEZE_LEVEL,
  /**
   * Deal execution mode
   */
  SYMBOL_TRADE_EXEMODE,
  /**
   * Swap calculation model
   */
  SYMBOL_SWAP_MODE,
  /**
   * Day of week to charge 3 days swap rollover
   */
  SYMBOL_SWAP_ROLLOVER3DAYS,
  /**
   * Calculating hedging margin using the larger leg (Buy or Sell)
   */
  SYMBOL_MARGIN_HEDGED_USE_LEG,
  /**
   * Flags of allowed order expiration modes
   */
  SYMBOL_EXPIRATION_MODE,
  /**
   * Flags of allowed order filling modes
   */
  SYMBOL_FILLING_MODE,
  /**
   * Flags of allowed order types
   */
  SYMBOL_ORDER_MODE,
  /**
   * Expiration of Stop Loss and Take Profit orders, if
   * SYMBOL_EXPIRATION_MODE=SYMBOL_EXPIRATION_GTC (Good till canceled)
   */
  SYMBOL_ORDER_GTC_MODE,
  /**
   * Option type
   */
  SYMBOL_OPTION_MODE,
  /**
   * Option right (Call/Put)
   */
  SYMBOL_OPTION_RIGHT,
} ENUM_SYMBOL_INFO_INTEGER;

typedef enum ENUM_SYMBOL_INFO_DOUBLE {
  /**
   * Bid - best sell offer
   */
  SYMBOL_BID,
  /**
   * Maximal Bid of the day
   */
  SYMBOL_BIDHIGH,
  /**
   * Minimal Bid of the day
   */
  SYMBOL_BIDLOW,
  /**
   * Ask - best buy offer
   */
  SYMBOL_ASK,
  /**
   * Maximal Ask of the day
   */
  SYMBOL_ASKHIGH,
  /**
   * Minimal Ask of the day
   */
  SYMBOL_ASKLOW,
  /**
   * Price of the last deal
   */
  SYMBOL_LAST,
  /**
   * Maximal Last of the day
   */
  SYMBOL_LASTHIGH,
  /**
   * Minimal Last of the day
   */
  SYMBOL_LASTLOW,
  /**
   * Volume of the last deal
   */
  SYMBOL_VOLUME_REAL,
  /**
   * Maximum Volume of the day
   */
  SYMBOL_VOLUMEHIGH_REAL,
  /**
   * Minimum Volume of the day
   */
  SYMBOL_VOLUMELOW_REAL,
  /**
   * The strike price of an option. The price at which an option buyer can buy
   * (in a Call option) or sell (in a Put option) the underlying asset, and the
   * option seller is obliged to sell or buy the appropriate amount of the
   * underlying asset.
   */
  SYMBOL_OPTION_STRIKE,
  /**
   * Symbol point value
   */
  SYMBOL_POINT,
  /**
   * Value of SYMBOL_TRADE_TICK_VALUE_PROFIT
   */
  SYMBOL_TRADE_TICK_VALUE,
  /**
   * Calculated tick price for a profitable position
   */
  SYMBOL_TRADE_TICK_VALUE_PROFIT,
  /**
   * Calculated tick price for a losing position
   */
  SYMBOL_TRADE_TICK_VALUE_LOSS,
  /**
   * Minimal price change
   */
  SYMBOL_TRADE_TICK_SIZE,
  /**
   * Trade contract size
   */
  SYMBOL_TRADE_CONTRACT_SIZE,
  /**
   * Accrued interest – accumulated coupon interest, i.e. part of the coupon
   * interest calculated in proportion to the number of days since the coupon
   * bond issuance or the last coupon interest payment
   */
  SYMBOL_TRADE_ACCRUED_INTEREST,
  /**
   * Face value – initial bond value set by the issuer
   */
  SYMBOL_TRADE_FACE_VALUE,
  /**
   * Liquidity Rate is the share of the asset that can be used for the margin.
   */
  SYMBOL_TRADE_LIQUIDITY_RATE,
  /**
   * Minimal volume for a deal
   */
  SYMBOL_VOLUME_MIN,
  /**
   * Maximal volume for a deal
   */
  SYMBOL_VOLUME_MAX,
  /**
   * Minimal volume change step for deal execution
   */
  SYMBOL_VOLUME_STEP,
  /**
   * Maximum allowed aggregate volume of an open position and pending orders in
   * one direction (buy or sell) for the symbol. For example, with the
   * limitation of 5 lots, you can have an open buy position with the volume of
   * 5 lots and place a pending order Sell Limit with the volume of 5 lots. But
   * in this case you cannot place a Buy Limit pending order (since the total
   * volume in one direction will exceed the limitation) or place Sell Limit
   * with the volume more than 5 lots.
   */
  SYMBOL_VOLUME_LIMIT,
  /**
   * Long swap value
   */
  SYMBOL_SWAP_LONG,
  /**
   * Short swap value
   */
  SYMBOL_SWAP_SHORT,
  /**
   * Initial margin means the amount in the margin currency required for opening
   * a position with the volume of one lot. It is used for checking a client's
   * assets when he or she enters the market.
   *
   * The SymbolInfoMarginRate() function provides data on the amount of charged
   * margin depending on the order type and direction.
   */
  SYMBOL_MARGIN_INITIAL,
  /**
   * The maintenance margin. If it is set, it sets the margin amount in the
   * margin currency of the symbol, charged from one lot. It is used for
   * checking a client's assets when his/her account state changes. If the
   * maintenance margin is equal to 0, the initial margin is used.
   *
   * The SymbolInfoMarginRate() function provides data on the amount of charged
   * margin depending on the order type and direction.
   */
  SYMBOL_MARGIN_MAINTENANCE,
  /**
   * Summary volume of current session deals
   */
  SYMBOL_SESSION_VOLUME,
  /**
   * Summary turnover of the current session
   */
  SYMBOL_SESSION_TURNOVER,
  /**
   * Summary open interest
   */
  SYMBOL_SESSION_INTEREST,
  /**
   * Current volume of Buy orders
   */
  SYMBOL_SESSION_BUY_ORDERS_VOLUME,
  /**
   * Current volume of Sell orders
   */
  SYMBOL_SESSION_SELL_ORDERS_VOLUME,
  /**
   * Open price of the current session
   */
  SYMBOL_SESSION_OPEN,
  /**
   * Close price of the current session
   */
  SYMBOL_SESSION_CLOSE,
  /**
   * Average weighted price of the current session
   */
  SYMBOL_SESSION_AW,
  /**
   * Settlement price of the current session
   */
  SYMBOL_SESSION_PRICE_SETTLEMENT,
  /**
   * Minimal price of the current session
   */
  SYMBOL_SESSION_PRICE_LIMIT_MIN,
  /**
   * Maximal price of the current session
   */
  SYMBOL_SESSION_PRICE_LIMIT_MAX,
  /**
   * Contract size or margin value per one lot of hedged positions (oppositely
   * directed positions of one symbol). Two margin calculation methods are
   * possible for hedged positions. The calculation method is defined by the
   * broker.
   *
   * Basic calculation: If the initial margin (SYMBOL_MARGIN_INITIAL) is
   * specified for a symbol, the hedged margin is specified as an absolute value
   * (in monetary terms).If the initial margin is not specified (equal to 0),
   * SYMBOL_MARGIN_HEDGED is equal to the size of the contract, that will be
   * used to calculate the margin by the appropriate formula in accordance with
   * the type of the financial instrument (SYMBOL_TRADE_CALC_MODE).  
   *
   * Calculation for the largest position: The SYMBOL_MARGIN_HEDGED value is not
   * taken into account.The volume of all short and all long positions of a
   * symbol is calculated.For each direction, a weighted average open price and
   * a weighted average rate of conversion to the deposit currency is
   * calculated.Next, using the appropriate formula chosen in accordance with
   * the symbol type (SYMBOL_TRADE_CALC_MODE) the margin is calculated for the
   * short and the long part.The largest one of the values is used as the
   * margin.
   */
  SYMBOL_MARGIN_HEDGED,
  /**
   * Change of the current price relative to the end of the previous trading day
   * in %
   */
  SYMBOL_PRICE_CHANGE,
  /**
   * Price volatility in %
   */
  SYMBOL_PRICE_VOLATILITY,
  /**
   * Theoretical option price
   */
  SYMBOL_PRICE_THEORETICAL,
  /**
   * Option/warrant delta shows the value the option price changes by, when the
   * underlying asset price changes by 1
   */
  SYMBOL_PRICE_DELTA,
  /**
   * Option/warrant theta shows the number of points the option price is to lose
   * every day due to a temporary breakup, i.e. when the expiration date
   * approaches
   */
  SYMBOL_PRICE_THETA,
  /**
   * Option/warrant gamma shows the change rate of delta – how quickly or slowly
   * the option premium changes
   */
  SYMBOL_PRICE_GAMMA,
  /**
   * Option/warrant vega shows the number of points the option price changes by
   * when the volatility changes by 1%
   */
  SYMBOL_PRICE_VEGA,
  /**
   * Option/warrant rho reflects the sensitivity of the theoretical option price
   * to the interest rate changing by 1%
   */
  SYMBOL_PRICE_RHO,
  /**
   * Option/warrant omega. Option elasticity shows a relative percentage change
   * of the option price by the percentage change of the underlying asset price
   */
  SYMBOL_PRICE_OMEGA,
  /**
   * Option/warrant sensitivity shows by how many points the price of the
   * option's underlying asset should change so that the price of the option
   * changes by one point
   */
  SYMBOL_PRICE_SENSITIVITY,
} ENUM_SYMBOL_INFO_DOUBLE;

typedef enum ENUM_SYMBOL_INFO_STRING {
  /**
   * The underlying asset of a derivative
   */
  SYMBOL_BASIS,
  /**
   * The name of the sector or category to which the financial symbol belongs
   */
  SYMBOL_CATEGORY,
  /**
   * The country to which the financial symbol belongs
   */
  SYMBOL_COUNTRY,
  /**
   * The sector of the economy to which the financial symbol belongs
   */
  SYMBOL_SECTOR_NAME,
  /**
   * The industry branch or the industry to which the financial symbol belongs
   */
  SYMBOL_INDUSTRY_NAME,
  /**
   * Basic currency of a symbol
   */
  SYMBOL_CURRENCY_BASE,
  /**
   * Profit currency
   */
  SYMBOL_CURRENCY_PROFIT,
  /**
   * Margin currency
   */
  SYMBOL_CURRENCY_MARGIN,
  /**
   * Feeder of the current quote
   */
  SYMBOL_BANK,
  /**
   * Symbol description
   */
  SYMBOL_DESCRIPTION,
  /**
   * The name of the exchange in which the financial symbol is traded
   */
  SYMBOL_EXCHANGE,
  /**
   * The formula used for the custom symbol pricing. If the name of a financial
   * symbol used in the formula starts with a digit or contains a special
   * character (">" ", ".", "-", "&", "#" and so on) quotation marks should be
   * used around this symbol name.
   *
   * Synthetic symbol: "\@ESU19"/iEURCAD
   * Calendar spread: "Si-9.13"-"Si-6.13"
   * Euro index: 34.38805726 * pow(EURUSD,0.3155) * pow(EURGBP,0.3056) *
   * pow(EURJPY,0.1891) * pow(EURCHF,0.1113) * pow(EURSEK,0.0785)
   */
  SYMBOL_FORMULA,
  /**
   * The name of a symbol in the ISIN system (International Securities
   * Identification Number). The International Securities Identification Number
   * is a 12-digit alphanumeric code that uniquely identifies a security. The
   * presence of this symbol property is determined on the side of a trade
   * server.
   */
  SYMBOL_ISIN,
  /**
   * The address of the web page containing symbol information. This address
   * will be displayed as a link when viewing symbol properties in the terminal
   */
  SYMBOL_PAGE,
  /**
   * Path in the symbol tree
   */
  SYMBOL_PATH,
} ENUM_SYMBOL_INFO_STRING;

typedef enum ENUM_SYMBOL_CHART_MODE {
  /**
   * Bars are based on Bid prices
   */
  SYMBOL_CHART_MODE_BID,
  /**
   * Bars are based on Last prices
   */
  SYMBOL_CHART_MODE_LAST,
} ENUM_SYMBOL_CHART_MODE;

typedef enum SYMBOL_EXPIRATION {
  /**
   * The order is valid during the unlimited time period, until it is explicitly
   * canceled
   */
  SYMBOL_EXPIRATION_GTC,
  /**
   * The order is valid till the end of the day
   */
  SYMBOL_EXPIRATION_DAY,
  /**
   * The expiration time is specified in the order
   */
  SYMBOL_EXPIRATION_SPECIFIED,
  /**
   * The expiration date is specified in the order
   */
  SYMBOL_EXPIRATION_SPECIFIED_DAY,
} SYMBOL_EXPIRATION;

typedef enum ENUM_SYMBOL_ORDER_GTC_MODE {
  /**
   * Pending orders and Stop Loss/Take Profit levels are valid for an unlimited
   * period until their explicit cancellation
   */
  SYMBOL_ORDERS_GTC,
  /**
   * Orders are valid during one trading day. At the end of the day, all Stop
   * Loss and Take Profit levels, as well as pending orders are deleted.
   */
  SYMBOL_ORDERS_DAILY,
  /**
   * When a trade day changes, only pending orders are deleted, while Stop Loss
   * and Take Profit levels are preserved.
   */
  SYMBOL_ORDERS_DAILY_EXCLUDING_STOPS,
} ENUM_SYMBOL_ORDER_GTC_MODE;

typedef enum ENUM_SYMBOL_ORDER {
  /**
   * Market orders are allowed (Buy and Sell)
   */
  SYMBOL_ORDER_MARKET,
  /**
   * Limit orders are allowed (Buy Limit and Sell Limit)
   */
  SYMBOL_ORDER_LIMIT,
  /**
   * Stop orders are allowed (Buy Stop and Sell Stop)
   */
  SYMBOL_ORDER_STOP,
  /**
   * Stop-limit orders are allowed (Buy Stop Limit and Sell Stop Limit)
   */
  SYMBOL_ORDER_STOP_LIMIT,
  /**
   * Stop Loss is allowed
   */
  SYMBOL_ORDER_SL,
  /**
   * Take Profit is allowed
   */
  SYMBOL_ORDER_TP,
  /**
   * Close By operation is allowed, i.e. closing a position by another open
   * position on the same instruments but in the opposite direction. The
   * property is set for accounts with the hedging accounting system
   * (ACCOUNT_MARGIN_MODE_RETAIL_HEDGING)
   */
  SYMBOL_ORDER_CLOSEBY,
} ENUM_SYMBOL_ORDER;

typedef enum ENUM_SYMBOL_CALC_MODE {
  /**
   * Forex mode - calculation of profit and margin for Forex
   */
  SYMBOL_CALC_MODE_FOREX,
  /**
   * Forex No Leverage mode – calculation of profit and margin for Forex symbols
   * without taking into account the leverage
   */
  SYMBOL_CALC_MODE_FOREX_NO_LEVERAGE,
  /**
   * Futures mode - calculation of margin and profit for futures
   */
  SYMBOL_CALC_MODE_FUTURES,
  /**
   * CFD mode - calculation of margin and profit for CFD
   */
  SYMBOL_CALC_MODE_CFD,
  /**
   * CFD index mode - calculation of margin and profit for CFD by indexes
   */
  SYMBOL_CALC_MODE_CFDINDEX,
  /**
   * CFD Leverage mode - calculation of margin and profit for CFD at leverage
   * trading
   */
  SYMBOL_CALC_MODE_CFDLEVERAGE,
  /**
   * Exchange mode – calculation of margin and profit for trading securities on
   * a stock exchange
   */
  SYMBOL_CALC_MODE_EXCH_STOCKS,
  /**
   * Futures mode –  calculation of margin and profit for trading futures
   * contracts on a stock exchange
   */
  SYMBOL_CALC_MODE_EXCH_FUTURES,
  /**
   * FORTS Futures mode –  calculation of margin and profit for trading futures
   * contracts on FORTS. The margin may be reduced by the amount of
   * MarginDiscount deviation according to the following rules:
   *
   * 1. If the price of a long position (buy order) is less than the estimated
   * price, MarginDiscount = Lots*((PriceSettle-PriceOrder)*TickPrice/TickSize)
   * 2. If the price of a short position (sell order) exceeds the estimated
   * price, MarginDiscount = Lots*((PriceOrder-PriceSettle)*TickPrice/TickSize)
   * where:
   *
   * PriceSettle – estimated (clearing) price of the previous session
   * PriceOrder – average weighted position price or open price set in the order
   * (request)
   * TickPrice – tick price (cost of the price change by one
   * point)
   * TickSize – tick size (minimum price change step)
   */
  SYMBOL_CALC_MODE_EXCH_FUTURES_FORTS,
  /**
   * Exchange Bonds mode – calculation of margin and profit for trading bonds on
   * a stock exchange
   */
  SYMBOL_CALC_MODE_EXCH_BONDS,
  /**
   * Exchange MOEX Stocks mode – calculation of margin and profit for trading
   * securities on MOEX
   */
  SYMBOL_CALC_MODE_EXCH_STOCKS_MOEX,
  /**
   * Exchange MOEX Bonds mode – calculation of margin and profit for trading
   * bonds on MOEX
   */
  SYMBOL_CALC_MODE_EXCH_BONDS_MOEX,
  /**
   * Collateral mode - a symbol is used as a non-tradable asset on a trading
   * account. The market value of an open position is calculated based on the
   * volume, current market price, contract size and liquidity ratio. The value
   * is included into Assets, which are added to Equity. Open positions of such
   * symbols increase the Free Margin amount and are used as additional margin
   * (collateral) for open positions of tradable instruments.
   */
  SYMBOL_CALC_MODE_SERV_COLLATERAL,
} ENUM_SYMBOL_CALC_MODE;

typedef enum ENUM_SYMBOL_TRADE_MODE {
  /**
   * Trade is disabled for the symbol
   */
  SYMBOL_TRADE_MODE_DISABLED,
  /**
   * Allowed only long positions
   */
  SYMBOL_TRADE_MODE_LONGONLY,
  /**
   * Allowed only short positions
   */
  SYMBOL_TRADE_MODE_SHORTONLY,
  /**
   * Allowed only position close operations
   */
  SYMBOL_TRADE_MODE_CLOSEONLY,
  /**
   * No trade restrictions
   */
  SYMBOL_TRADE_MODE_FULL,
} ENUM_SYMBOL_TRADE_MODE;

typedef enum ENUM_SYMBOL_SWAP_MODE {
  /**
   * Swaps disabled (no swaps)
   */
  SYMBOL_SWAP_MODE_DISABLED,
  /**
   * Swaps are charged in points
   */
  SYMBOL_SWAP_MODE_POINTS,
  /**
   * Swaps are charged in money in base currency of the symbol
   */
  SYMBOL_SWAP_MODE_CURRENCY_SYMBOL,
  /**
   * Swaps are charged in money in margin currency of the symbol
   */
  SYMBOL_SWAP_MODE_CURRENCY_MARGIN,
  /**
   * Swaps are charged in money, in client deposit currency
   */
  SYMBOL_SWAP_MODE_CURRENCY_DEPOSIT,
  /**
   * Swaps are charged as the specified annual interest from the instrument
   * price at calculation of swap (standard bank year is 360 days)
   */
  SYMBOL_SWAP_MODE_INTEREST_CURRENT,
  /**
   * Swaps are charged as the specified annual interest from the open price of
   * position (standard bank year is 360 days)
   */
  SYMBOL_SWAP_MODE_INTEREST_OPEN,
  /**
   * Swaps are charged by reopening positions. At the end of a trading day the
   * position is closed. Next day it is reopened by the close price +/-
   * specified number of points (parameters SYMBOL_SWAP_LONG and
   * SYMBOL_SWAP_SHORT)
   */
  SYMBOL_SWAP_MODE_REOPEN_CURRENT,
  /**
   * Swaps are charged by reopening positions. At the end of a trading day the
   * position is closed. Next day it is reopened by the current Bid price +/-
   * specified number of points (parameters SYMBOL_SWAP_LONG and
   * SYMBOL_SWAP_SHORT)
   */
  SYMBOL_SWAP_MODE_REOPEN_BID,
} ENUM_SYMBOL_SWAP_MODE;

typedef enum ENUM_DAY_OF_WEEK {
  SUNDAY,
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY,
} ENUM_DAY_OF_WEEK;

typedef enum ENUM_SYMBOL_OPTION_RIGHT {
  /**
   * A call option gives you the right to buy an asset at a specified price
   */
  SYMBOL_OPTION_RIGHT_CALL,
  /**
   * A put option gives you the right to sell an asset at a specified price
   */
  SYMBOL_OPTION_RIGHT_PUT,
} ENUM_SYMBOL_OPTION_RIGHT;

typedef enum ENUM_SYMBOL_SECTOR {
  SECTOR_UNDEFINED,
  SECTOR_BASIC_MATERIALS,
  SECTOR_COMMUNICATION_SERVICES,
  SECTOR_CONSUMER_CYCLICAL,
  SECTOR_CONSUMER_DEFENSIVE,
  SECTOR_CURRENCY,
  SECTOR_CURRENCY_CRYPTO,
  SECTOR_ENERGY,
  SECTOR_FINANCIAL,
  SECTOR_HEALTHCARE,
  SECTOR_INDUSTRIALS,
  SECTOR_REAL_ESTATE,
  SECTOR_TECHNOLOGY,
  SECTOR_UTILITIES
} ENUM_SYMBOL_SECTOR;

typedef enum ENUM_SYMBOL_INDUSTRY {
  /**
   * Undefined
   */
  INDUSTRY_UNDEFINED,
  /**
   * Agricultural inputs
   */
  INDUSTRY_AGRICULTURAL_INPUTS,
  /**
   * Aluminium
   */
  INDUSTRY_ALUMINIUM,
  /**
   * Building materials
   */
  INDUSTRY_BUILDING_MATERIALS,
  /**
   * Chemicals
   */
  INDUSTRY_CHEMICALS,
  /**
   * Coking coal
   */
  INDUSTRY_COKING_COAL,
  /**
   * Copper
   */
  INDUSTRY_COPPER,
  /**
   * Gold
   */
  INDUSTRY_GOLD,
  /**
   * Lumber and wood production
   */
  INDUSTRY_LUMBER_WOOD,
  /**
   * Other industrial metals and mining
   */
  INDUSTRY_INDUSTRIAL_METALS,
  /**
   * Other precious metals and mining
   */
  INDUSTRY_PRECIOUS_METALS,
  /**
   * Paper and paper products
   */
  INDUSTRY_PAPER,
  /**
   * Silver
   */
  INDUSTRY_SILVER,
  /**
   * Specialty chemicals
   */
  INDUSTRY_SPECIALTY_CHEMICALS,
  /**
   * Steel
   */
  INDUSTRY_STEEL,
  /**
   * Advertising agencies
   */
  INDUSTRY_ADVERTISING,
  /**
   * Broadcasting
   */
  INDUSTRY_BROADCASTING,
  /**
   * Electronic gaming and multimedia
   */
  INDUSTRY_GAMING_MULTIMEDIA,
  /**
   * Entertainment
   */
  INDUSTRY_ENTERTAINMENT,
  /**
   * Internet content and information
   */
  INDUSTRY_INTERNET_CONTENT,
  /**
   * Publishing
   */
  INDUSTRY_PUBLISHING,
  /**
   * Telecom services
   */
  INDUSTRY_TELECOM,
  /**
   * Apparel manufacturing
   */
  INDUSTRY_APPAREL_MANUFACTURING,
  /**
   * Apparel retail
   */
  INDUSTRY_APPAREL_RETAIL,
  /**
   * Auto manufacturers
   */
  INDUSTRY_AUTO_MANUFACTURERS,
  /**
   * Auto parts
   */
  INDUSTRY_AUTO_PARTS,
  /**
   * Auto and truck dealerships
   */
  INDUSTRY_AUTO_DEALERSHIP,
  /**
   * Department stores
   */
  INDUSTRY_DEPARTMENT_STORES,
  /**
   * Footwear and accessories
   */
  INDUSTRY_FOOTWEAR_ACCESSORIES,
  /**
   * Furnishing, fixtures and appliances
   */
  INDUSTRY_FURNISHINGS,
  /**
   * Gambling
   */
  INDUSTRY_GAMBLING,
  /**
   * Home improvement retail
   */
  INDUSTRY_HOME_IMPROV_RETAIL,
  /**
   * Internet retail
   */
  INDUSTRY_INTERNET_RETAIL,
  /**
   * Leisure
   */
  INDUSTRY_LEISURE,
  /**
   * Lodging
   */
  INDUSTRY_LODGING,
  /**
   * Luxury goods
   */
  INDUSTRY_LUXURY_GOODS,
  /**
   * Packaging and containers
   */
  INDUSTRY_PACKAGING_CONTAINERS,
  /**
   * Personal services
   */
  INDUSTRY_PERSONAL_SERVICES,
  /**
   * Recreational vehicles
   */
  INDUSTRY_RECREATIONAL_VEHICLES,
  /**
   * Residential construction
   */
  INDUSTRY_RESIDENT_CONSTRUCTION,
  /**
   * Resorts and casinos
   */
  INDUSTRY_RESORTS_CASINOS,
  /**
   * Restaurants
   */
  INDUSTRY_RESTAURANTS,
  /**
   * Specialty retail
   */
  INDUSTRY_SPECIALTY_RETAIL,
  /**
   * Textile manufacturing
   */
  INDUSTRY_TEXTILE_MANUFACTURING,
  /**
   * Travel services
   */
  INDUSTRY_TRAVEL_SERVICES,
  /**
   * Beverages - Brewers
   */
  INDUSTRY_BEVERAGES_BREWERS,
  /**
   * Beverages - Non-alcoholic
   */
  INDUSTRY_BEVERAGES_NON_ALCO,
  /**
   * Beverages - Wineries and distilleries
   */
  INDUSTRY_BEVERAGES_WINERIES,
  /**
   * Confectioners
   */
  INDUSTRY_CONFECTIONERS,
  /**
   * Discount stores
   */
  INDUSTRY_DISCOUNT_STORES,
  /**
   * Education and training services
   */
  INDUSTRY_EDUCATION_TRAINIG,
  /**
   * Farm products
   */
  INDUSTRY_FARM_PRODUCTS,
  /**
   * Food distribution
   */
  INDUSTRY_FOOD_DISTRIBUTION,
  /**
   * Grocery stores
   */
  INDUSTRY_GROCERY_STORES,
  /**
   * Household and personal products
   */
  INDUSTRY_HOUSEHOLD_PRODUCTS,
  /**
   * Packaged foods
   */
  INDUSTRY_PACKAGED_FOODS,
  /**
   * Tobacco
   */
  INDUSTRY_TOBACCO,
  /**
   * Oil and gas drilling
   */
  INDUSTRY_OIL_GAS_DRILLING,
  /**
   * Oil and gas extraction and processing
   */
  INDUSTRY_OIL_GAS_EP,
  /**
   * Oil and gas equipment and services
   */
  INDUSTRY_OIL_GAS_EQUIPMENT,
  /**
   * Oil and gas integrated
   */
  INDUSTRY_OIL_GAS_INTEGRATED,
  /**
   * Oil and gas midstream
   */
  INDUSTRY_OIL_GAS_MIDSTREAM,
  /**
   * Oil and gas refining and marketing
   */
  INDUSTRY_OIL_GAS_REFINING,
  /**
   * Thermal coal
   */
  INDUSTRY_THERMAL_COAL,
  /**
   * Uranium
   */
  INDUSTRY_URANIUM,
  /**
   * Exchange traded fund
   */
  INDUSTRY_EXCHANGE_TRADED_FUND,
  /**
   * Assets management
   */
  INDUSTRY_ASSETS_MANAGEMENT,
  /**
   * Banks - Diversified
   */
  INDUSTRY_BANKS_DIVERSIFIED,
  /**
   * Banks - Regional
   */
  INDUSTRY_BANKS_REGIONAL,
  /**
   * Capital markets
   */
  INDUSTRY_CAPITAL_MARKETS,
  /**
   * Closed-End fund - Debt
   */
  INDUSTRY_CLOSE_END_FUND_DEBT,
  /**
   * Closed-end fund - Equity
   */
  INDUSTRY_CLOSE_END_FUND_EQUITY,
  /**
   * Closed-end fund - Foreign
   */
  INDUSTRY_CLOSE_END_FUND_FOREIGN,
  /**
   * Credit services
   */
  INDUSTRY_CREDIT_SERVICES,
  /**
   * Financial conglomerates
   */
  INDUSTRY_FINANCIAL_CONGLOMERATE,
  /**
   * Financial data and stock exchange
   */
  INDUSTRY_FINANCIAL_DATA_EXCHANGE,
  /**
   * Insurance brokers
   */
  INDUSTRY_INSURANCE_BROKERS,
  /**
   * Insurance - Diversified
   */
  INDUSTRY_INSURANCE_DIVERSIFIED,
  /**
   * Insurance - Life
   */
  INDUSTRY_INSURANCE_LIFE,
  /**
   * Insurance - Property and casualty
   */
  INDUSTRY_INSURANCE_PROPERTY,
  /**
   * Insurance - Reinsurance
   */
  INDUSTRY_INSURANCE_REINSURANCE,
  /**
   * Insurance - Specialty
   */
  INDUSTRY_INSURANCE_SPECIALTY,
  /**
   * Mortgage finance
   */
  INDUSTRY_MORTGAGE_FINANCE,
  /**
   * Shell companies
   */
  INDUSTRY_SHELL_COMPANIES,
  /**
   * Biotechnology
   */
  INDUSTRY_BIOTECHNOLOGY,
  /**
   * Diagnostics and research
   */
  INDUSTRY_DIAGNOSTICS_RESEARCH,
  /**
   * Drugs manufacturers - general
   */
  INDUSTRY_DRUGS_MANUFACTURERS,
  /**
   * Drugs manufacturers - Specialty and generic
   */
  INDUSTRY_DRUGS_MANUFACTURERS_SPEC,
  /**
   * Healthcare plans
   */
  INDUSTRY_HEALTHCARE_PLANS,
  /**
   * Health information services
   */
  INDUSTRY_HEALTH_INFORMATION,
  /**
   * Medical care facilities
   */
  INDUSTRY_MEDICAL_FACILITIES,
  /**
   * Medical devices
   */
  INDUSTRY_MEDICAL_DEVICES,
  /**
   * Medical distribution
   */
  INDUSTRY_MEDICAL_DISTRIBUTION,
  /**
   * Medical instruments and supplies
   */
  INDUSTRY_MEDICAL_INSTRUMENTS,
  /**
   * Pharmaceutical retailers
   */
  INDUSTRY_PHARM_RETAILERS,
  /**
   * Aerospace and defense
   */
  INDUSTRY_AEROSPACE_DEFENSE,
  /**
   * Airlines
   */
  INDUSTRY_AIRLINES,
  /**
   * Airports and air services
   */
  INDUSTRY_AIRPORTS_SERVICES,
  /**
   * Building products and equipment
   */
  INDUSTRY_BUILDING_PRODUCTS,
  /**
   * Business equipment and supplies
   */
  INDUSTRY_BUSINESS_EQUIPMENT,
  /**
   * Conglomerates
   */
  INDUSTRY_CONGLOMERATES,
  /**
   * Consulting services
   */
  INDUSTRY_CONSULTING_SERVICES,
  /**
   * Electrical equipment and parts
   */
  INDUSTRY_ELECTRICAL_EQUIPMENT,
  /**
   * Engineering and construction
   */
  INDUSTRY_ENGINEERING_CONSTRUCTION,
  /**
   * Farm and heavy construction machinery
   */
  INDUSTRY_FARM_HEAVY_MACHINERY,
  /**
   * Industrial distribution
   */
  INDUSTRY_INDUSTRIAL_DISTRIBUTION,
  /**
   * Infrastructure operations
   */
  INDUSTRY_INFRASTRUCTURE_OPERATIONS,
  /**
   * Integrated freight and logistics
   */
  INDUSTRY_FREIGHT_LOGISTICS,
  /**
   * Marine shipping
   */
  INDUSTRY_MARINE_SHIPPING,
  /**
   * Metal fabrication
   */
  INDUSTRY_METAL_FABRICATION,
  /**
   * Pollution and treatment controls
   */
  INDUSTRY_POLLUTION_CONTROL,
  /**
   * Railroads
   */
  INDUSTRY_RAILROADS,
  /**
   * Rental and leasing services
   */
  INDUSTRY_RENTAL_LEASING,
  /**
   * Security and protection services
   */
  INDUSTRY_SECURITY_PROTECTION,
  /**
   * Specialty business services
   */
  INDUSTRY_SPEALITY_BUSINESS_SERVICES,
  /**
   * Specialty industrial machinery
   */
  INDUSTRY_SPEALITY_MACHINERY,
  /**
   * Stuffing and employment services
   */
  INDUSTRY_STUFFING_EMPLOYMENT,
  /**
   * Tools and accessories
   */
  INDUSTRY_TOOLS_ACCESSORIES,
  /**
   * Trucking
   */
  INDUSTRY_TRUCKING,
  /**
   * Waste management
   */
  INDUSTRY_WASTE_MANAGEMENT,
  /**
   * Real estate - Development
   */
  INDUSTRY_REAL_ESTATE_DEVELOPMENT,
  /**
   * Real estate - Diversified
   */
  INDUSTRY_REAL_ESTATE_DIVERSIFIED,
  /**
   * Real estate services
   */
  INDUSTRY_REAL_ESTATE_SERVICES,
  /**
   * REIT - Diversified
   */
  INDUSTRY_REIT_DIVERSIFIED,
  /**
   * REIT - Healthcase facilities
   */
  INDUSTRY_REIT_HEALTCARE,
  /**
   * REIT - Hotel and motel
   */
  INDUSTRY_REIT_HOTEL_MOTEL,
  /**
   * REIT - Industrial
   */
  INDUSTRY_REIT_INDUSTRIAL,
  /**
   * REIT - Mortgage
   */
  INDUSTRY_REIT_MORTAGE,
  /**
   * REIT - Office
   */
  INDUSTRY_REIT_OFFICE,
  /**
   * REIT - Residential
   */
  INDUSTRY_REIT_RESIDENTAL,
  /**
   * REIT - Retail
   */
  INDUSTRY_REIT_RETAIL,
  /**
   * REIT - Specialty
   */
  INDUSTRY_REIT_SPECIALITY,
  /**
   * Communication equipment
   */
  INDUSTRY_COMMUNICATION_EQUIPMENT,
  /**
   * Computer hardware
   */
  INDUSTRY_COMPUTER_HARDWARE,
  /**
   * Consumer electronics
   */
  INDUSTRY_CONSUMER_ELECTRONICS,
  /**
   * Electronic components
   */
  INDUSTRY_ELECTRONIC_COMPONENTS,
  /**
   * Electronics and computer distribution
   */
  INDUSTRY_ELECTRONIC_DISTRIBUTION,
  /**
   * Information technology services
   */
  INDUSTRY_IT_SERVICES,
  /**
   * Scientific and technical instruments
   */
  INDUSTRY_SCIENTIFIC_INSTRUMENTS,
  /**
   * Semiconductor equipment and materials
   */
  INDUSTRY_SEMICONDUCTOR_EQUIPMENT,
  /**
   * Semiconductors
   */
  INDUSTRY_SEMICONDUCTORS,
  /**
   * Software - Application
   */
  INDUSTRY_SOFTWARE_APPLICATION,
  /**
   * Software - Infrastructure
   */
  INDUSTRY_SOFTWARE_INFRASTRUCTURE,
  /**
   * Solar
   */
  INDUSTRY_SOLAR,
  /**
   * Utilities - Diversified
   */
  INDUSTRY_UTILITIES_DIVERSIFIED,
  /**
   * Utilities - Independent power producers
   */
  INDUSTRY_UTILITIES_POWERPRODUCERS,
  /**
   * Utilities - Renewable
   */
  INDUSTRY_UTILITIES_RENEWABLE,
  /**
   * Utilities - Regulated electric
   */
  INDUSTRY_UTILITIES_REGULATED_ELECTRIC,
  /**
   * Utilities - Regulated gas
   */
  INDUSTRY_UTILITIES_REGULATED_GAS,
  /**
   * Utilities - Regulated water
   */
  INDUSTRY_UTILITIES_REGULATED_WATER,
  /**
   * Start of the utilities services types enumeration. Corresponds to
   * INDUSTRY_UTILITIES_DIVERSIFIED.
   */
  INDUSTRY_UTILITIES_FIRST,
  /**
   * End of the utilities services types enumeration. Corresponds to
   * INDUSTRY_UTILITIES_REGULATED_WATER.
   */
  INDUSTRY_UTILITIES_LAST
} ENUM_SYMBOL_INDUSTRY;

typedef enum ENUM_SYMBOL_OPTION_MODE {
  /**
   * European option may only be exercised on a specified date (expiration,
   * execution date, delivery date)
   */
  SYMBOL_OPTION_MODE_EUROPEAN,
  /**
   * American option may be exercised on any trading day or before expiry. The
   * period within which a buyer can exercise the option is specified for it
   */
  SYMBOL_OPTION_MODE_AMERICAN,
} ENUM_SYMBOL_OPTION_MODE;

typedef enum ENUM_TERMINAL_INFO_INTEGER {
  /**
   * The client terminal build number
   */
  TERMINAL_BUILD,
  /**
   * The flag indicates the presence of MQL5.community authorization data in the
   * terminal
   */
  TERMINAL_COMMUNITY_ACCOUNT,
  /**
   * Connection to MQL5.community
   */
  TERMINAL_COMMUNITY_CONNECTION,
  /**
   * Connection to a trade server
   */
  TERMINAL_CONNECTED,
  /**
   * Permission to use DLL
   */
  TERMINAL_DLLS_ALLOWED,
  /**
   * Permission to trade
   */
  TERMINAL_TRADE_ALLOWED,
  /**
   * Permission to send e-mails using SMTP-server and login, specified in the
   * terminal settings
   */
  TERMINAL_EMAIL_ENABLED,
  /**
   * Permission to send reports using FTP-server and login, specified in the
   * terminal settings
   */
  TERMINAL_FTP_ENABLED,
  /**
   * Permission to send notifications to smartphone
   */
  TERMINAL_NOTIFICATIONS_ENABLED,
  /**
   * The maximal bars count on the chart
   */
  TERMINAL_MAXBARS,
  /**
   * The flag indicates the presence of MetaQuotes ID data for Push
   * notifications
   */
  TERMINAL_MQID,
  /**
   * Number of the code page of the language installed in the client terminal
   */
  TERMINAL_CODEPAGE,
  /**
   * The number of CPU cores in the system
   */
  TERMINAL_CPU_CORES,
  /**
   * Free disk space for the MQL5\Files folder of the terminal (agent), MB
   */
  TERMINAL_DISK_SPACE,
  /**
   * Physical memory in the system, MB
   */
  TERMINAL_MEMORY_PHYSICAL,
  /**
   * Memory available to the process of the terminal (agent), MB
   */
  TERMINAL_MEMORY_TOTAL,
  /**
   * Free memory of the terminal (agent) process, MB
   */
  TERMINAL_MEMORY_AVAILABLE,
  /**
   * Memory used by the terminal (agent), MB
   */
  TERMINAL_MEMORY_USED,
  /**
   * Indication of the "64-bit terminal"
   */
  TERMINAL_X64,
  /**
   * The version of the supported OpenCL in the format of 0x00010002 = 1.2.  "0"
   * means that OpenCL is not supported
   */
  TERMINAL_OPENCL_SUPPORT,
  /**
   * The resolution of information display on the screen is measured as number
   * of Dots in a line per Inch (DPI).
   */
  TERMINAL_SCREEN_DPI,
  /**
   * Knowing the parameter value, you can set the size of graphical objects so
   * that they look the same on monitors with different resolution
   * characteristics.
   */
  TERMINAL_SCREEN_LEFT,
  /**
   * The left coordinate of the virtual screen. A virtual screen is a rectangle
   * that covers all monitors. If the system has two monitors ordered from right
   * to left, then the left coordinate of the virtual screen can be on the
   * border of two monitors.
   */
  TERMINAL_SCREEN_TOP,
  /**
   * The top coordinate of the virtual screen
   */
  TERMINAL_SCREEN_WIDTH,
  /**
   * Terminal width
   */
  TERMINAL_SCREEN_HEIGHT,
  /**
   * Terminal height
   */
  TERMINAL_LEFT,
  /**
   * The left coordinate of the terminal relative to the virtual screen
   */
  TERMINAL_TOP,
  /**
   * The top coordinate of the terminal relative to the virtual screen
   */
  TERMINAL_RIGHT,
  /**
   * The right coordinate of the terminal relative to the virtual screen
   */
  TERMINAL_BOTTOM,
  /**
   * The bottom coordinate of the terminal relative to the virtual screen
   */
  TERMINAL_PING_LAST,
  /**
   * The last known value of a ping to a trade server in microseconds. One
   * second comprises of one million microseconds
   */
  TERMINAL_VPS,
  /**
   * Indication that the terminal is launched on the MetaTrader Virtual Hosting
   * server (MetaTrader VPS)
   */
  TERMINAL_KEYSTATE_LEFT,
  /**
   * State of the "Left arrow" key
   */
  TERMINAL_KEYSTATE_UP,
  /**
   * State of the "Up arrow" key
   */
  TERMINAL_KEYSTATE_RIGHT,
  /**
   * State of the "Right arrow" key
   */
  TERMINAL_KEYSTATE_DOWN,
  /**
   * State of the "Down arrow" key
   */
  TERMINAL_KEYSTATE_SHIFT,
  /**
   * State of the "Shift" key
   */
  TERMINAL_KEYSTATE_CONTROL,
  /**
   * State of the "Ctrl" key
   */
  TERMINAL_KEYSTATE_MENU,
  /**
   * State of the "Windows" key
   */
  TERMINAL_KEYSTATE_CAPSLOCK,
  /**
   * State of the "CapsLock" key
   */
  TERMINAL_KEYSTATE_NUMLOCK,
  /**
   * State of the "NumLock" key
   */
  TERMINAL_KEYSTATE_SCRLOCK,
  /**
   * State of the "ScrollLock" key
   */
  TERMINAL_KEYSTATE_ENTER,
  /**
   * State of the "Enter" key
   */
  TERMINAL_KEYSTATE_INSERT,
  /**
   * State of the "Insert" key
   */
  TERMINAL_KEYSTATE_DELETE,
  /**
   * State of the "Delete" key
   */
  TERMINAL_KEYSTATE_HOME,
  /**
   * State of the "Home" key
   */
  TERMINAL_KEYSTATE_END,
  /**
   * State of the "End" key
   */
  TERMINAL_KEYSTATE_TAB,
  /**
   * State of the "Tab" key
   */
  TERMINAL_KEYSTATE_PAGEUP,
  /**
   * State of the "PageUp" key
   */
  TERMINAL_KEYSTATE_PAGEDOWN,
  /**
   * State of the "PageDown" key
   */
  TERMINAL_KEYSTATE_ESCAPE,
} ENUM_TERMINAL_INFO_INTEGER;

typedef enum ENUM_TERMINAL_INFO_DOUBLE {
  /**
   * Balance in MQL5.community
   */
  TERMINAL_COMMUNITY_BALANCE,
  /**
   * Percentage of resent network packets in the TCP/IP protocol for all running
   * applications and services on the given computer. Packet loss occurs even in
   * the fastest and correctly configured networks. In this case, there is no
   * confirmation of packet delivery between the recipient and the sender,
   * therefore lost packets are resent.
   */
  TERMINAL_RETRANSMISSION,
} ENUM_TERMINAL_INFO_DOUBLE;

typedef enum ENUM_TERMINAL_INFO_STRING {
  /**
   * Language of the terminal
   */
  TERMINAL_LANGUAGE,
  /**
   * Company name
   */
  TERMINAL_COMPANY,
  /**
   * Terminal name
   */
  TERMINAL_NAME,
  /**
   * Folder from which the terminal is started
   */
  TERMINAL_PATH,
  /**
   * Folder in which terminal data are stored
   */
  TERMINAL_DATA_PATH,
  /**
   * Common path for all of the terminals installed on a computer
   */
  TERMINAL_COMMONDATA_PATH,
} ENUM_TERMINAL_INFO_STRING;

typedef enum ENUM_TIMEFRAMES {
  PERIOD_CURRENT,
  PERIOD_M1,
  PERIOD_M2,
  PERIOD_M3,
  PERIOD_M4,
  PERIOD_M5,
  PERIOD_M6,
  PERIOD_M10,
  PERIOD_M12,
  PERIOD_M15,
  PERIOD_M20,
  PERIOD_M30,
  PERIOD_H1,
  PERIOD_H2,
  PERIOD_H3,
  PERIOD_H4,
  PERIOD_H6,
  PERIOD_H8,
  PERIOD_H12,
  PERIOD_D1,
  PERIOD_W1,
  PERIOD_MN1,
} ENUM_TIMEFRAMES;

/**
 * The _Period variable contains the value of the timeframe of the current
 * chart.
 *
 * Also you may use the Period() function.
 */
ENUM_TIMEFRAMES _Period;

typedef enum ENUM_SERIESMODE {
  MODE_OPEN,
  MODE_LOW,
  MODE_HIGH,
  MODE_CLOSE,
  MODE_VOLUME,
  MODE_REAL_VOLUME,
  MODE_SPREAD,
} ENUM_SERIESMODE;

typedef enum ENUM_SERIES_INFO_INTEGER {
  /**
   * Bars count for the symbol-period for the current moment
   */
  SERIES_BARS_COUNT,
  /**
   * The very first date for the symbol-period for the current moment
   */
  SERIES_FIRSTDATE,
  /**
   * Open time of the last bar of the symbol-period
   */
  SERIES_LASTBAR_DATE,
  /**
   * The very first date in the history of the symbol on the server regardless
   * of the timeframe
   */
  SERIES_SERVER_FIRSTDATE,
  /**
   * The very first date in the history of the symbol in the client terminal,
   * regardless of the timeframe
   */
  SERIES_TERMINAL_FIRSTDATE,
  /**
   * Symbol/period data synchronization flag for the current moment
   */
  SERIES_SYNCHRONIZED,
} ENUM_SERIES_INFO_INTEGER;

typedef enum ENUM_ORDER_PROPERTY_INTEGER {
  /**
   * Order ticket. Unique number assigned to each order
   */
  ORDER_TICKET,
  /**
   * Order setup time
   */
  ORDER_TIME_SETUP,
  /**
   * Order type
   */
  ORDER_TYPE,
  /**
   * Order state
   */
  ORDER_STATE,
  /**
   * Order expiration time
   */
  ORDER_TIME_EXPIRATION,
  /**
   * Order execution or cancellation time
   */
  ORDER_TIME_DONE,
  /**
   * The time of placing an order for execution in milliseconds since 01.01.1970
   */
  ORDER_TIME_SETUP_MSC,
  /**
   * Order execution/cancellation time in milliseconds since 01.01.1970
   */
  ORDER_TIME_DONE_MSC,
  /**
   * Order filling type
   */
  ORDER_TYPE_FILLING,
  /**
   * Order lifetime
   */
  ORDER_TYPE_TIME,
  /**
   * ID of an Expert Advisor that has placed the order (designed to ensure that
   * each Expert Advisor places its own unique number)
   */
  ORDER_MAGIC,
  /**
   * The reason or source for placing an order
   */
  ORDER_REASON,
  /**
   * Position identifier that is set to an order as soon as it is executed. Each
   * executed order results in a deal that opens or modifies an already existing
   * position. The identifier of exactly this position is set to the executed
   * order at this moment.
   */
  ORDER_POSITION_ID,
  /**
   * Identifier of an opposite position used for closing by order
   *  ORDER_TYPE_CLOSE_BY
   */
  ORDER_POSITION_BY_ID,
} ENUM_ORDER_PROPERTY_INTEGER;

typedef enum ENUM_ORDER_PROPERTY_DOUBLE {
  /**
   * Order initial volume
   */
  ORDER_VOLUME_INITIAL,
  /**
   * Order current volume
   */
  ORDER_VOLUME_CURRENT,
  /**
   * Price specified in the order
   */
  ORDER_PRICE_OPEN,
  /**
   * Stop Loss value
   */
  ORDER_SL,
  /**
   * Take Profit value
   */
  ORDER_TP,
  /**
   * The current price of the order symbol
   */
  ORDER_PRICE_CURRENT,
  /**
   * The Limit order price for the StopLimit order
   */
  ORDER_PRICE_STOPLIMIT,
} ENUM_ORDER_PROPERTY_DOUBLE;

typedef enum ENUM_ORDER_PROPERTY_STRING {
  /**
   * Symbol of the order
   */
  ORDER_SYMBOL,
  /**
   * Order comment
   */
  ORDER_COMMENT,
  /**
   * Order identifier in an external trading system (on the Exchange)
   */
  ORDER_EXTERNAL_ID,
} ENUM_ORDER_PROPERTY_STRING;

typedef enum ENUM_ORDER_TYPE {
  /**
   * Market Buy order
   */
  ORDER_TYPE_BUY,
  /**
   * Market Sell order
   */
  ORDER_TYPE_SELL,
  /**
   * Buy Limit pending order
   */
  ORDER_TYPE_BUY_LIMIT,
  /**
   * Sell Limit pending order
   */
  ORDER_TYPE_SELL_LIMIT,
  /**
   * Buy Stop pending order
   */
  ORDER_TYPE_BUY_STOP,
  /**
   * Sell Stop pending order
   */
  ORDER_TYPE_SELL_STOP,
  /**
   * Upon reaching the order price, a pending Buy Limit order is placed at the
   * StopLimit price
   */
  ORDER_TYPE_BUY_STOP_LIMIT,
  /**
   * Upon reaching the order price, a pending Sell Limit order is placed at the
   * StopLimit price
   */
  ORDER_TYPE_SELL_STOP_LIMIT,
  /**
   * Order to close a position by an opposite one
   */
  ORDER_TYPE_CLOSE_BY,
} ENUM_ORDER_TYPE;

typedef enum ENUM_ORDER_STATE {
  /**
   * Order checked, but not yet accepted by broker
   */
  ORDER_STATE_STARTED,
  /**
   * Order accepted
   */
  ORDER_STATE_PLACED,
  /**
   * Order canceled by client
   */
  ORDER_STATE_CANCELED,
  /**
   * Order partially executed
   */
  ORDER_STATE_PARTIAL,
  /**
   * Order fully executed
   */
  ORDER_STATE_FILLED,
  /**
   * Order rejected
   */
  ORDER_STATE_REJECTED,
  /**
   * Order expired
   */
  ORDER_STATE_EXPIRED,
  /**
   * Order is being registered (placing to the trading system)
   */
  ORDER_STATE_REQUEST_ADD,
  /**
   * Order is being modified (changing its parameters)
   */
  ORDER_STATE_REQUEST_MODIFY,
  /**
   * Order is being deleted (deleting from the trading system)
   */
  ORDER_STATE_REQUEST_CANCEL,
} ENUM_ORDER_STATE;

typedef enum ENUM_ORDER_TYPE_FILLING {
  /**
   * This filling policy means that an order can be filled only in the specified
   * amount. If the necessary amount of a financial instrument is currently
   * unavailable in the market, the order will not be executed. The required
   * volume can be filled using several offers available on the market at the
   * moment.
   */
  ORDER_FILLING_FOK,
  /**
   * This mode means that a trader agrees to execute a deal with the volume
   * maximally available in the market within that indicated in the order. In
   * case the the entire volume of an order cannot be filled, the available
   * volume of it will be filled, and the remaining volume will be canceled.
   */
  ORDER_FILLING_IOC,
  /**
   * This policy is used only for market orders (ORDER_TYPE_BUY and
   * ORDER_TYPE_SELL), limit and stop limit orders (ORDER_TYPE_BUY_LIMIT,
   * ORDER_TYPE_SELL_LIMIT, ORDER_TYPE_BUY_STOP_LIMIT and
   * ORDER_TYPE_SELL_STOP_LIMIT) and only for the symbols with Market or
   * Exchange execution. In case of partial filling a market or limit order with
   * remaining volume is not canceled but processed further.
   *
   * For the activation of the ORDER_TYPE_BUY_STOP_LIMIT and
   * ORDER_TYPE_SELL_STOP_LIMIT orders, a corresponding limit order
   * ORDER_TYPE_BUY_LIMIT/ORDER_TYPE_SELL_LIMIT with the ORDER_FILLING_RETURN
   * execution type is created.
   */
  ORDER_FILLING_RETURN,
} ENUM_ORDER_TYPE_FILLING;

typedef enum ENUM_ORDER_TYPE_TIME {
  /**
   * Good till cancel order
   */
  ORDER_TIME_GTC,
  /**
   * Good till current trade day order
   */
  ORDER_TIME_DAY,
  /**
   * Good till expired order
   */
  ORDER_TIME_SPECIFIED,
  /**
   * The order will be effective till 23:59:59 of the specified day. If this
   * time is outside a trading session, the order expires in the nearest trading
   * time.
   */
  ORDER_TIME_SPECIFIED_DAY,
} ENUM_ORDER_TYPE_TIME;

typedef enum ENUM_ORDER_REASON {
  /**
   * The order was placed from a desktop terminal
   */
  ORDER_REASON_CLIENT,
  /**
   * The order was placed from a mobile application
   */
  ORDER_REASON_MOBILE,
  /**
   * The order was placed from a web platform
   */
  ORDER_REASON_WEB,
  /**
   * The order was placed from an MQL5-program, i.e. by an Expert Advisor or a
   * script
   */
  ORDER_REASON_EXPERT,
  /**
   * The order was placed as a result of Stop Loss activation
   */
  ORDER_REASON_SL,
  /**
   * The order was placed as a result of Take Profit activation
   */
  ORDER_REASON_TP,
  /**
   * The order was placed as a result of the Stop Out event
   */
  ORDER_REASON_SO,
} ENUM_ORDER_REASON;

typedef enum ENUM_BOOK_TYPE {
  /**
   * Sell order (Offer)
   */
  BOOK_TYPE_SELL,
  /**
   * Buy order (Bid)
   */
  BOOK_TYPE_BUY,
  /**
   * Sell order by Market
   */
  BOOK_TYPE_SELL_MARKET,
  /**
   * Buy order by Market
   */
  BOOK_TYPE_BUY_MARKET,
} ENUM_BOOK_TYPE;

typedef enum ENUM_SIGNAL_BASE_DOUBLE {
  /**
   * Account balance
   */
  SIGNAL_BASE_BALANCE,
  /**
   * Account equity
   */
  SIGNAL_BASE_EQUITY,
  /**
   * Account gain
   */
  SIGNAL_BASE_GAIN,
  /**
   * Account maximum drawdown
   */
  SIGNAL_BASE_MAX_DRAWDOWN,
  /**
   * Signal subscription price
   */
  SIGNAL_BASE_PRICE,
  /**
   * Return on Investment (%)
   */
  SIGNAL_BASE_ROI
} ENUM_SIGNAL_BASE_DOUBLE;

typedef enum ENUM_SIGNAL_BASE_INTEGER {
  /**
   * Publication date (date when it become available for subscription)
   */
  SIGNAL_BASE_DATE_PUBLISHED,
  /**
   * Monitoring starting date
   */
  SIGNAL_BASE_DATE_STARTED,
  /**
   * The date of the last update of the signal's trading statistics
   */
  SIGNAL_BASE_DATE_UPDATED,
  /**
   * Signal ID
   */
  SIGNAL_BASE_ID,
  /**
   * Account leverage
   */
  SIGNAL_BASE_LEVERAGE,
  /**
   * Profit in pips
   */
  SIGNAL_BASE_PIPS,
  /**
   * Position in rating
   */
  SIGNAL_BASE_RATING,
  /**
   * Number of subscribers
   */
  SIGNAL_BASE_SUBSCRIBERS,
  /**
   * Number of trades
   */
  SIGNAL_BASE_TRADES,
  /**
   * Account type (0-real, 1-demo, 2-contest)
   */
  SIGNAL_BASE_TRADE_MODE
} ENUM_SIGNAL_BASE_INTEGER;

typedef enum ENUM_SIGNAL_BASE_STRING {
  /**
   * Author login
   */
  SIGNAL_BASE_AUTHOR_LOGIN,
  /**
   * Broker name (company)
   */
  SIGNAL_BASE_BROKER,
  /**
   * Broker server
   */
  SIGNAL_BASE_BROKER_SERVER,
  /**
   * Signal name
   */
  SIGNAL_BASE_NAME,
  /**
   * Signal base currency
   */
  SIGNAL_BASE_CURRENCY
} ENUM_SIGNAL_BASE_STRING;

typedef enum ENUM_SIGNAL_INFO_DOUBLE {
  /**
   * Equity limit
   */
  SIGNAL_INFO_EQUITY_LIMIT,
  /**
   * Slippage (used when placing market orders in synchronization of positions
   * and copying of trades)
   */
  SIGNAL_INFO_SLIPPAGE,
  /**
   * Maximum percent of deposit used (%), r/o
   */
  SIGNAL_INFO_VOLUME_PERCENT
} ENUM_SIGNAL_INFO_DOUBLE;

typedef enum ENUM_SIGNAL_INFO_INTEGER {
  /**
   * The flag enables synchronization without confirmation dialog
   */
  SIGNAL_INFO_CONFIRMATIONS_DISABLED,
  /**
   * Copy Stop Loss and Take Profit flag
   */
  SIGNAL_INFO_COPY_SLTP,
  /**
   * Deposit percent (%)
   */
  SIGNAL_INFO_DEPOSIT_PERCENT,
  /**
   * Signal id, r/o
   */
  SIGNAL_INFO_ID,
  /**
   * "Copy trades by subscription" permission flag
   */
  SIGNAL_INFO_SUBSCRIPTION_ENABLED,
  /**
   * "Agree to terms of use of Signals service" flag, r/o
   */
  SIGNAL_INFO_TERMS_AGREE,
} ENUM_SIGNAL_INFO_INTEGER;

typedef enum ENUM_SIGNAL_INFO_STRING {
  /**
   * Signal name, r/o
   */
  SIGNAL_INFO_NAME
} ENUM_SIGNAL_INFO_STRING;

typedef enum ENUM_TRADE_REQUEST_ACTIONS {
  /**
   * Place a trade order for an immediate execution with the specified
   * parameters (market order)
   */
  TRADE_ACTION_DEAL,
  /**
   * Place a trade order for the execution under specified conditions (pending
   * order)
   */
  TRADE_ACTION_PENDING,
  /**
   * Modify Stop Loss and Take Profit values of an opened position
   */
  TRADE_ACTION_SLTP,
  /**
   * Modify the parameters of the order placed previously
   */
  TRADE_ACTION_MODIFY,
  /**
   * Delete the pending order placed previously
   */
  TRADE_ACTION_REMOVE,
  /**
   * Close a position by an opposite one
   */
  TRADE_ACTION_CLOSE_BY,
} ENUM_TRADE_REQUEST_ACTIONS;

typedef enum ENUM_TRADE_TRANSACTION_TYPE {

  /**
   * Adding a new open order.
   */
  TRADE_TRANSACTION_ORDER_ADD,
  /**
   * Updating an open order. The updates include not only evident changes from
   * the client terminal or a trade server sides but also changes of an order
   * state when setting it (for example, transition from ORDER_STATE_STARTED to
   * ORDER_STATE_PLACED or from ORDER_STATE_PLACED to ORDER_STATE_PARTIAL,
   * etc.).
   */
  TRADE_TRANSACTION_ORDER_UPDATE,
  /**
   * Removing an order from the list of the open ones. An order can be deleted
   * from the open ones as a result of setting an appropriate request or
   * execution (filling) and moving to the history.
   */
  TRADE_TRANSACTION_ORDER_DELETE,
  /**
   * Adding a deal to the history. The action is performed as a result of an
   * order execution or performing operations with an account balance.
   */
  TRADE_TRANSACTION_DEAL_ADD,
  /**
   * Updating a deal in the history. There may be cases when a previously
   * executed deal is changed on a server. For example, a deal has been changed
   * in an external trading system (exchange) where it was previously
   * transferred by a broker.
   */
  TRADE_TRANSACTION_DEAL_UPDATE,
  /**
   * Deleting a deal from the history. There may be cases when a previously
   * executed deal is deleted from a server. For example, a deal has been
   * deleted in an external trading system (exchange) where it was previously
   * transferred by a broker.
   */
  TRADE_TRANSACTION_DEAL_DELETE,
  /**
   * Adding an order to the history as a result of execution or cancellation.
   */
  TRADE_TRANSACTION_HISTORY_ADD,
  /**
   * Changing an order located in the orders history. This type is provided for
   * enhancing functionality on a trade server side.
   */
  TRADE_TRANSACTION_HISTORY_UPDATE,
  /**
   * Deleting an order from the orders history. This type is provided for
   * enhancing functionality on a trade server side.
   */
  TRADE_TRANSACTION_HISTORY_DELETE,
  /**
   * Changing a position not related to a deal execution. This type of
   * transaction shows that a position has been changed on a trade server side.
   * Position volume, open price, Stop Loss and Take Profit levels can be
   * changed. Data on changes are submitted in MqlTradeTransaction structure via
   * OnTradeTransaction handler. Position change (adding, changing or closing),
   * as a result of a deal execution, does not lead to the occurrence of
   * TRADE_TRANSACTION_POSITION transaction.
   */
  TRADE_TRANSACTION_POSITION,
  /**
   * Notification of the fact that a trade request has been processed by a
   * server and processing result has been received. Only type field (trade
   * transaction type) must be analyzed for such transactions in
   * MqlTradeTransaction structure. The second and third parameters of
   * OnTradeTransaction (request and result) must be analyzed for additional
   * data.
   */
  TRADE_TRANSACTION_REQUEST,
} ENUM_TRADE_TRANSACTION_TYPE;

/**
 * Returns the contents of the system variable _LastError.
 *
 * @returns Returns the value of the last error that occurred during the
 * execution of an mql5 program.
 */
int GetLastError();

/**
 * Checks the forced shutdown of an mql5 program.
 *
 * @returns Returns true, if the _StopFlag system variable contains a value
 * other than 0. A nonzero value is written into _StopFlag, if a mql5 program
 * has been commanded to complete its operation. In this case, you must
 * immediately terminate the program, otherwise the program will be completed
 * forcibly from the outside after 3 seconds.
 */
bool IsStopped();

/**
 * Returns the code of a reason for deinitialization.
 *
 * @returns Returns the value of _UninitReason which is formed before OnDeinit()
 * is called. Value depends on the reasons that led to deinitialization.
 */
int UninitializeReason();

/**
 * Returns the value of a corresponding property of the mql5 program
 * environment.
 *
 * @param property_id Identifier of a property. Can be one of the values of the
 * ENUM_TERMINAL_INFO_INTEGER enumeration.
 * @returns Value of int type.
 */
int TerminalInfoInteger(ENUM_TERMINAL_INFO_INTEGER property_id);

/**
 * Returns the value of a corresponding property of the mql5 program
 * environment.
 *
 * @param property_id Identifier of a property. Can be one of the values of the
 * ENUM_TERMINAL_INFO_DOUBLE enumeration.
 * @returns Value of double type.
 */
double TerminalInfoDouble(ENUM_TERMINAL_INFO_DOUBLE property_id);

/**
 * Returns the value of a corresponding property of the mql5 program
 * environment. The property must be of string type.
 *
 * @param property_id Identifier of a property. Can be one of the values of the
 * ENUM_TERMINAL_INFO_STRING enumeration.
 * @returns Value of string type.
 */
string TerminalInfoString(ENUM_TERMINAL_INFO_STRING property_id);

/**
 * Returns the value of a corresponding property of a running mql5 program.
 *
 * @param property_id Identifier of a property. Can be one of values of the
 * ENUM_MQL_INFO_INTEGER enumeration.
 * @returns Value of int type.
 */
int MQLInfoInteger(ENUM_MQL_INFO_INTEGER property_id);

/**
 * Returns the value of a corresponding property of a running mql5 program.
 *
 * @param property_id Identifier of a property. Can be one of the
 * ENUM_MQL_INFO_STRING enumeration.
 * @returns Value of string type.
 */
string MQLInfoString(ENUM_MQL_INFO_STRING property_id);

/**
 * Returns the name of a symbol of the current chart.
 *
 * @returns Value of the _Symbol system variable, which stores the name of the
 * current chart symbol.
 */
string Symbol();

/**
 * Returns the current chart timeframe.
 *
 * @returns The contents of the _Period variable that contains the value of the
 * current chart timeframe. The value can be one of the values of the
 * ENUM_TIMEFRAMES enumeration.
 */
ENUM_TIMEFRAMES Period();

/**
 * Returns the number of decimal digits determining the accuracy of price of the
 * current chart symbol.
 *
 * @returns The value of the _Digits variable which stores the number of decimal
 * digits determining the accuracy of price of the current chart symbol.
 */
int Digits();

/**
 * Returns the point size of the current symbol in the quote currency.
 *
 * @returns The value of the _Point variable which stores the point size of the
 * current symbol in the quote currency.
 */
double Point();

struct MqlDateTime {
  int year;
  int mon;
  int day;
  int hour;
  int min;
  int sec;
  int day_of_week;
  int day_of_year;
};

struct MqlCalendarCountry {
  /**
   * Country ID (ISO 3166-1)
   */
  ulong id;
  /**
   * Country text name (in the current terminal encoding)
   */
  string name;
  /**
   * Country code name (ISO 3166-1 alpha-2)
   */
  string code;
  /**
   * Country currency code
   */
  string currency;
  /**
   * Country currency symbol
   */
  string currency_symbol;
  /**
   * Country name used in the mql5.com website URL
   */
  string url_name;
};

struct MqlCalendarEvent {
  /**
   * Event ID
   */
  ulong id;
  /**
   * Event type from the ENUM_CALENDAR_EVENT_TYPE enumeration
   */
  ENUM_CALENDAR_EVENT_TYPE type;
  /**
   * Sector an event is related to
   */
  ENUM_CALENDAR_EVENT_SECTOR sector;
  /**
   * Event frequency
   */
  ENUM_CALENDAR_EVENT_FREQUENCY frequency;
  /**
   * Event time mode
   */
  ENUM_CALENDAR_EVENT_TIMEMODE time_mode;
  /**
   * Country ID
   */
  ulong country_id;
  /**
   * Economic indicator value's unit of measure
   */
  ENUM_CALENDAR_EVENT_UNIT unit;
  /**
   * Event importance
   */
  ENUM_CALENDAR_EVENT_IMPORTANCE importance;
  /**
   * Economic indicator value multiplier
   */
  ENUM_CALENDAR_EVENT_MULTIPLIER multiplier;
  /**
   * Number of decimal places
   */
  uint digits;
  /**
   * URL of a source where an event is published
   */
  string source_url;
  /**
   * Event code
   */
  string event_code;
  /**
   * Event text name in the terminal language (in the current terminal encoding)
   */
  string name;
};

struct MqlCalendarValue {
  /**
   * Value ID
   */
  ulong id;
  /**
   * Event ID
   */
  ulong event_id;
  /**
   * Event time and date
   */
  datetime time;
  /**
   * Event report period
   */
  datetime period;
  /**
   * Released indicator's revision in relation to a report period
   */
  int revision;
  /**
   * Indicator's actual value
   */
  long actual_value;
  /**
   * Indicator's previous value
   */
  long prev_value;
  /**
   * Indicator's revised previous value
   */
  long revised_prev_value;
  /**
   * Indicator's forecast value
   */
  long forecast_value;
  /**
   * Potential impact on an exchange rate
   */
  ENUM_CALENDAR_EVENT_IMPACT impact_type;
};

struct MqlRates {
  /**
   * Period start time
   */
  datetime time;
  /**
   * Open price
   */
  double open;
  /**
   * The highest price of the period
   */
  double high;
  /**
   * The lowest price of the period
   */
  double low;
  /**
   * Close price
   */
  double close;
  /**
   * Tick volume
   */
  long tick_volume;
  /**
   * Spread
   */
  int spread;
  /**
   * Trade volume
   */
  long real_volume;
};

struct MqlParam {
  /**
   * Type of the input parameter, value of ENUM_DATATYPE
   */
  ENUM_DATATYPE type;
  /**
   * Field to store an integer type
   */
  long integer_value;
  /**
   * Field to store a double type
   */
  double double_value;
  /**
   * Field to store a string type
   */
  string string_value;
};

struct MqlBookInfo {
  /**
   * Order type from ENUM_BOOK_TYPE enumeration
   */
  ENUM_BOOK_TYPE type;
  /**
   * Price
   */
  double price;
  /**
   * Volume
   */
  long volume;
  /**
   * Volume with greater accuracy
   */
  double volume_real;
};

struct MqlTick {
  /**
   * Time of the last prices update
   */
  datetime time;
  /**
   * Current Bid price
   */
  double bid;
  /**
   * Current Ask price
   */
  double ask;
  /**
   * Price of the last deal (Last)
   */
  double last;
  /**
   * Volume for the current Last price
   */
  ulong volume;
  /**
   * Time of a price last update in milliseconds
   */
  long time_msc;
  /**
   * Tick flags
   */
  uint flags;
  /**
   * Volume for the current Last price with greater accuracy
   */
  double volume_real;
};

struct MqlTradeTransaction {
  /**
   * Deal ticket.
   */
  ulong deal;
  /**
   * Order ticket.
   */
  ulong order;
  /**
   * The name of the trading symbol, for which transaction is performed.
   */
  string symbol;
  /**
   * Trade transaction type. The value can be one of ENUM_TRADE_TRANSACTION_TYPE
   * enumeration values.
   */
  ENUM_TRADE_TRANSACTION_TYPE type;
  /**
   * Trade order type. The value can be one of ENUM_ORDER_TYPE enumeration
   * values.
   */
  ENUM_ORDER_TYPE order_type;
  /**
   * Trade order state. The value can be one of ENUM_ORDER_STATE enumeration
   * values.
   */
  ENUM_ORDER_STATE order_state;
  /**
   * Deal type. The value can be one of ENUM_DEAL_TYPE enumeration values.
   */
  ENUM_DEAL_TYPE deal_type;
  /**
   * Order type upon expiration. The value can be one of ENUM_ORDER_TYPE_TIME
   * values.
   */
  ENUM_ORDER_TYPE_TIME time_type;
  /**
   * Pending order expiration term (for orders of ORDER_TIME_SPECIFIED and
   * ORDER_TIME_SPECIFIED_DAY types).
   */
  datetime time_expiration;
  /**
   * Price. Depending on a trade transaction type, it may be a price of an
   * order, a deal or a position.
   */
  double price;
  /**
   * Stop limit order stop (activation) price (ORDER_TYPE_BUY_STOP_LIMIT and
   * ORDER_TYPE_SELL_STOP_LIMIT).
   */
  double price_trigger;
  /**
   * Stop Loss price. Depending on a trade transaction type, it may relate to an
   * order, a deal or a position.
   */
  double price_sl;
  /**
   * Take Profit price. Depending on a trade transaction type, it may relate to
   * an order, a deal or a position.
   */
  double price_tp;
  /**
   * Volume in lots. Depending on a trade transaction type, it may indicate the
   * current volume of an order, a deal or a position.
   */
  double volume;
  /**
   * The ticket of the position affected by the transaction.
   */
  ulong position;
  /**
   * The ticket of the opposite position. Used when closing a position by an
   * opposite one, i.e. by a position of the same symbol that was opened in the
   * opposite direction.
   */
  ulong position_by;
};

struct MqlTradeRequest {
  /**
   * Trade operation type. Can be one of the ENUM_TRADE_REQUEST_ACTIONS
   * enumeration values.
   */
  ENUM_TRADE_REQUEST_ACTIONS action;
  /**
   * Expert Advisor ID. It allows organizing analytical processing of trade
   * orders. Each Expert Advisor can set its own unique ID when sending a trade
   * request.
   */
  ulong magic;
  /**
   * Order ticket. It is used for modifying pending orders.
   */
  ulong order;
  /**
   * Symbol of the order. It is not necessary for order modification and
   * position close operations.
   */
  string symbol;
  /**
   * Requested order volume in lots. Note that the real volume of a deal will
   * depend on the order execution type.
   */
  double volume;
  /**
   * Price, reaching which the order must be executed. Market orders of symbols,
   * whose execution type is "Market Execution" (SYMBOL_TRADE_EXECUTION_MARKET),
   * of TRADE_ACTION_DEAL type, do not require specification of price.
   */
  double price;
  /**
   * The price value, at which the Limit pending order will be placed, when
   * price reaches the price value (this condition is obligatory). Until then
   * the pending order is not placed.
   */
  double stoplimit;
  /**
   * Stop Loss price in case of the unfavorable price movement
   */
  double sl;
  /**
   * Take Profit price in the case of the favorable price movement
   */
  double tp;
  /**
   * The maximal price deviation, specified in points
   */
  ulong deviation;
  /**
   * Order type. Can be one of the ENUM_ORDER_TYPE enumeration values.
   */
  ENUM_ORDER_TYPE type;
  /**
   * Order execution type. Can be one of the enumeration ENUM_ORDER_TYPE_FILLING
   * values.
   */
  ENUM_ORDER_TYPE_FILLING type_filling;
  /**
   * Order expiration type. Can be one of the enumeration ENUM_ORDER_TYPE_TIME
   * values.
   */
  ENUM_ORDER_TYPE_TIME type_time;
  /**
   * Order expiration time (for orders of ORDER_TIME_SPECIFIED type)
   */
  datetime expiration;
  /**
   * Order comment
   */
  string comment;
  /**
   * Ticket of a position. Should be filled in when a position is modified or
   * closed to identify the position. As a rule it is equal to the ticket of the
   * order, based on which the position was opened.
   */
  ulong position;
  /**
   * Ticket of an opposite position. Used when a position is closed by an
   * opposite one open for the same symbol in the opposite direction.
   */
  ulong position_by;
};

struct MqlTradeResult {
  /**
   * Return code of a trade server
   */
  uint retcode;
  /**
   * Deal ticket, if a deal has been performed. It is available for a trade
   * operation of TRADE_ACTION_DEAL type
   */
  ulong deal;
  /**
   * Order ticket, if a ticket has been placed. It is available for a trade
   * operation of TRADE_ACTION_PENDING type
   */
  ulong order;
  /**
   * Deal volume, confirmed by broker. It depends on the order filling type
   */
  double volume;
  /**
   * Deal price, confirmed by broker. It depends on the deviation field of the
   * trade request and/or on the trade operation
   */
  double price;
  /**
   * The current market Bid price (requote price)
   */
  double bid;
  /**
   * The current market Ask price (requote price)
   */
  double ask;
  /**
   * The broker comment to operation (by default it is filled by description of
   * trade server return code)
   */
  string comment;
  /**
   * Request ID set by the terminal when sending to the trade server
   */
  uint request_id;
  /**
   * The code of the error returned by an external trading system. The use and
   * types of these errors depend on the broker and the external trading system,
   * to which trading operations are sent.
   */
  uint retcode_external;
};

struct MqlTradeCheckResult {
  /**
   * Return code
   */
  uint retcode;
  /**
   * Balance value that will be after the execution of the trade operation
   */
  double balance;
  /**
   * Equity value that will be after the execution of the trade operation
   */
  double equity;
  /**
   * Value of the floating profit that will be after the execution of the trade
   * operation
   */
  double profit;
  /**
   * Margin required for the trade operation
   */
  double margin;
  /**
   * Free margin that will be left after the execution of the trade operation
   */
  double margin_free;
  /**
   * Margin level that will be set after the execution of the trade operation
   */
  double margin_level;
  /**
   * Comment to the reply code, error description
   */
  string comment;
};

/**
 * Returns the value of the appropriate account property.
 *
 * @param property_id Property identifier. The value can be one of the values of
 * ENUM_ACCOUNT_INFO_DOUBLE.
 * @returns Value of double type.
 */
double AccountInfoDouble(ENUM_ACCOUNT_INFO_DOUBLE property_id);

/**
 * Returns the value of the appropriate account property.
 *
 * @param property_id Property identifier. The value can be one of the values of
 * ENUM_ACCOUNT_INFO_INTEGER.
 * @returns Value of long type.
 */
long AccountInfoInteger(ENUM_ACCOUNT_INFO_INTEGER property_id);

/**
 * Returns the value of the appropriate account property.
 *
 * @param property_id Property identifier. The value can be one of the values of
 * ENUM_ACCOUNT_INFO_STRING.
 * @returns Value of string type.
 */
string AccountInfoString(ENUM_ACCOUNT_INFO_STRING property_id);

/**
 * Searches for a specified value in a multidimensional numeric array sorted
 * ascending. Search is performed through the elements of the first dimension.
 *
 * @param array Numeric array for search.
 * @param value Value for search.
 * @returns The function returns index of a found element. If the wanted value
 * isn't found, the function returns the index of an element nearest in value.
 */
int ArrayBsearch(const double array[], double value);
int ArrayBsearch(const float array[], float value);
int ArrayBsearch(const long array[], long value);
int ArrayBsearch(const int array[], int value);
int ArrayBsearch(const short array[], short value);
int ArrayBsearch(const char array[], char value);

/**
 * It copies an array into another one.
 *
 * @param dst_array Destination array
 * @param src_array Source array
 * @param dst_start Starting index from the destination array. By default, start
 * index is 0.
 * @param src_start Starting index for the source array. By default, start index
 * is 0.
 * @param count Number of elements that should be copied. By default, the whole
 * array is copied (count=WHOLE_ARRAY).
 * @returns It returns the number of copied elements.
 */
template <typename T>
int ArrayCopy(T dst_array[], const T src_array[], int dst_start = 0,
              int src_start = 0, int count = WHOLE_ARRAY);

/**
 * The function returns the result of comparing two arrays of the same type. It
 * can be used to compare arrays of simple types or custom structures without
 * complex objects, that is the custom structures that do not contain strings,
 * dynamic arrays, classes and other structures with complex objects.
 *
 * @param array1 First array.
 * @param array2 Second array.
 * @param start1 The element's initial index in the first array, from which
 * comparison starts. The default start index - 0.
 * @param start2 The element's initial index in the second array, from which
 * comparison starts. The default start index - 0.
 * @param count Number of elements to be compared. All elements of both arrays
 * participate in comparison by default (count=WHOLE_ARRAY).
 */
template <typename T>
int ArrayCompare(const T array1[], const T array2[], int start1 = 0,
                 int start2 = 0, int count = WHOLE_ARRAY);

/**
 * It frees up a buffer of any dynamic array and sets the size of the zero
 * dimension to 0.
 *
 * @param array Dynamic array.
 */
template <typename T> void ArrayFree(T array[]);

/**
 * It checks direction of an array index.
 *
 * @param array Checked array.
 * @returns Returns true, if the specified array has the AS_SERIES flag set,
 * i.e. access to the array is performed back to front as in timeseries. A
 * timeseries differs from a usual array in that the indexing of timeseries
 * elements is performed from its end to beginning (from the newest data to
 * old).
 */
template <typename T> bool ArrayGetAsSeries(const T array[]);

/**
 * The function initializes a numeric array by a preset value.
 *
 * @param array Numeric array that should be initialized.
 * @param value New value that should be set to all array elements.
 * @returns Number of initialized elements.
 */
int ArrayInitialize(char array[], char value);
int ArrayInitialize(short array[], short value);
int ArrayInitialize(int array[], int value);
int ArrayInitialize(long array[], long value);
int ArrayInitialize(float array[], float value);
int ArrayInitialize(double array[], double value);
int ArrayInitialize(bool array[], bool value);
int ArrayInitialize(uint array[], uint value);

/**
 * The function fills an array with the specified value.
 *
 * @param array Array of simple type (char, uchar, short, ushort, int, uint,
 * long, ulong, bool, color, datetime, float, double).
 * @param start Starting index. In such a case, specified AS_SERIES flag is
 * ignored.
 * @param count Number of elements to fill.
 * @param value Value to fill the array with.
 */
template <typename T> void ArrayFill(T array[], int start, int count, T value);

/**
 * The function checks whether an array is dynamic.
 *
 * @param array Checked array.
 * @returns It returns true if the selected array is dynamic, otherwise it
 * returns false.
 */
template <typename T> bool ArrayIsDynamic(const T array[]);

/**
 * The function checks whether an array is a timeseries.
 *
 * @param array Checked array.
 * @returns It returns true, if a checked array is an array timeseries,
 * otherwise it returns false. Arrays passed as a parameter to the OnCalculate()
 * function must be checked for the order of accessing the array elements by
 * ArrayGetAsSeries().
 */
template <typename T> bool ArrayIsSeries(const T array[]);

/**
 * Searches for the largest element in the first dimension of a multidimensional
 * numeric array.
 *
 * @param array A numeric array, in which search is made.
 * @param start Index to start checking with.
 * @param count Number of elements for search. By default, searches in the
 * entire array (count=WHOLE_ARRAY).
 * @returns The function returns an index of a found element taking into account
 * the array serial. In case of failure it returns -1.
 */
template <typename T>
int ArrayMaximum(const T array[], int start = 0, int count = WHOLE_ARRAY);

/**
 * Searches for the lowest element in the first dimension of a multidimensional
 * numeric array.
 *
 * @param array A numeric array, in which search is made.
 * @param start Index to start checking with.
 * @param count Number of elements for search. By default, searches in the
 * entire array (count=WHOLE_ARRAY).
 * @returns The function returns an index of a found element taking into account
 * the array serial. In case of failure it returns -1.
 */
template <typename T>
int ArrayMinimum(const T array[], int start = 0, int count = WHOLE_ARRAY);

/**
 * Prints an array of a simple type or a simple structure into journal.
 *
 * @param array Array of a simple type or a simple structure.
 * @param digits The number of decimal places for real types. The default value
 * is _Digits.
 * @param separator Separator of the structure element field values. The default
 * value NULL means an empty line. A space is used as a separator in that case.
 * @param start The index of the first printed array element. It is printed from
 * the zero index by default.
 * @param count Number of the array elements to be printed. The entire array is
 * displayed by default (count=WHOLE_ARRAY).
 * @param flags Combination of flags setting the output mode. All flags are
 * enabled by default:
 */
template <typename T>
void ArrayPrint(const T array[], uint digits = _Digits,
                const string separator = "", ulong start = 0,
                ulong count = WHOLE_ARRAY,
                ulong flags = ARRAYPRINT_HEADER | ARRAYPRINT_INDEX |
                              ARRAYPRINT_LIMIT | ARRAYPRINT_ALIGN);

/**
 * The function returns the number of elements in a selected array dimension.
 *
 * @param array Checked array.
 * @param rank_index Index of dimension.
 * @returns Number of elements in a selected array dimension.
 */
template <typename T> int ArrayRange(const T array[], int rank_index);

/**
 * The function sets a new size for the first dimension
 *
 * @param array Array for changing sizes.
 * @param new_size New size for the first dimension.
 * @param reserve_size Distributed size to get reserve.
 * @returns If executed successfully, it returns count of all elements contained
 * in the array after resizing, otherwise, returns -1, and array is not resized.
 */
template <typename T>
int ArrayResize(T array[], int new_size, int reserve_size = 0);

/**
 * Inserts the specified number of elements from a source array to a receiving
 * one starting from a specified index.
 *
 * @param dst_array Receiving array the elements should be added to.
 * @param src_array Source array the elements are to be added from.
 * @param dst_start Index in the receiving array for inserting elements from the
 * source array.
 * @param src_start Index in the receiving array, starting from which the
 * elements of the source array are taken for insertion.
 * @param count Number of elements to be added from the source array. The
 * WHOLE_ARRAY means all elements from the specified index up to the end of the
 * array.
 * @returns Returns true if successful, otherwise - false. To get information
 * about the error, call the GetLastError() function. Possible errors:
 */
template <typename T>
bool ArrayInsert(T dst_array[], const T src_array[], uint dst_start,
                 uint src_start = 0, uint count = WHOLE_ARRAY);

/**
 * Removes the specified number of elements from the array starting with a
 * specified index.
 *
 * @param array Array.
 * @param start Index, starting from which the array elements are removed.
 * @param count Number of removed elements. The WHOLE_ARRAY value means removing
 * all elements from the specified index up the end of the array.
 * @returns Returns true if successful, otherwise - false. To get information
 * about the error, call the GetLastError() function. Possible errors:
 */
template <typename T>
bool ArrayRemove(T array[], uint start, uint count = WHOLE_ARRAY);

/**
 * Reverses the specified number of elements in the array starting with a
 * specified index.
 *
 * @param array Array.
 * @param start Index the array reversal starts from.
 * @param count Number of reversed elements. If WHOLE_ARRAY, then all array
 * elements are moved in the inversed manner starting with the specified start
 * index up to the end of the array.
 * @returns Returns true if successful, otherwise - false.
 */
template <typename T>
bool ArrayReverse(T array[], uint start = 0, uint count = WHOLE_ARRAY);

/**
 * The function sets the AS_SERIES flag to a selected object of a dynamic array,
 * and elements will be indexed like in timeseries.
 *
 * @param array Numeric array to set.
 * @param flag Array indexing direction.
 * @returns The function returns true on success, otherwise - false.
 */
template <typename T> bool ArraySetAsSeries(const T array[], bool flag);

/**
 * The function returns the number of elements of a selected array.
 *
 * @param array Array of any type.
 * @returns Value of int type.
 */
template <typename T> int ArraySize(const T array[]);

/**
 * Sorts the values in the first dimension of a multidimensional numeric array
 * in the ascending order.
 *
 * @param array Numeric array for sorting.
 * @returns The function returns true on success, otherwise - false.
 */
template <typename T> bool ArraySort(T array[]);

/**
 * Swaps the contents of two dynamic arrays of the same type. For
 * multidimensional arrays, the number of elements in all dimensions except the
 * first one should match.
 *
 * @param array1 Array of numerical type.
 * @param array2 Array of numerical type.
 * @returns Returns true if successful, otherwise false. In this case,
 * GetLastError() returns the ERR_INVALID_ARRAY error code.
 */
template <typename T> bool ArraySwap(T array1[], T array2[]);

/**
 * Applies a specific template from a specified file to the chart. The command
 * is added to chart messages queue and will be executed after processing of all
 * previous commands.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param filename The name of the file containing the template.
 * @returns Returns true if the command has been added to chart queue, otherwise
 * false. To get an information about the error, call the GetLastError()
 * function.
 */
bool ChartApplyTemplate(long chart_id, const string filename);

/**
 * Saves current chart settings in a template with a specified name.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param filename The filename to save the template. The ".tpl" extension will
 * be added to the filename automatically; there is no need to specify it. The
 * template is saved in data_folder\\Profiles\\Templates\\ and can be used for
 * manual application in the terminal. If a template with the same filename
 * already exists, the contents of this file will be overwritten.
 * @returns If successful, the function returns true, otherwise it returns
 * false. To get information about the error, call the GetLastError() function.
 */
bool ChartSaveTemplate(long chart_id, const string filename);

/**
 * The function returns the number of a subwindow where an indicator is drawn.
 * There are 2 variants of the function.
 *
 * @param chart_id Chart ID. 0 denotes the current chart.
 * @param indicator_shortname Short name of the indicator.
 * @returns Subwindow number in case of success. In case of failure the function
 * returns -1.
 */
int ChartWindowFind(long chart_id, string indicator_shortname);
int ChartWindowFind();

/**
 * Converts the coordinates of a chart from the time/price representation to the
 * X and Y coordinates.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param sub_window The number of the chart subwindow. 0 means the main chart
 * window.
 * @param time The time value on the chart, for which the value in pixels along
 * the X axis will be received. The origin is in the upper left corner of the
 * main chart window.
 * @param price The price value on the chart, for which the value in pixels
 * along the Y axis will be received. The origin is in the upper left corner of
 * the main chart window.
 * @param x The variable, into which the conversion of time to X will be
 * received.
 * @param y The variable, into which the conversion of price to Y will be
 * received.
 * @returns Returns true if successful, otherwise false. To get information
 * about the error, call the GetLastError() function.
 */
bool ChartTimePriceToXY(long chart_id, int sub_window, datetime time,
                        double price, int &x, int &y);

/**
 * Converts the X and Y coordinates on a chart to the time and price values.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param x The X coordinate.
 * @param y The Y coordinate.
 * @param sub_window The variable, into which the chart subwindow number will be
 * written. 0 means the main chart window.
 * @param time The time value on the chart, for which the value in pixels along
 * the X axis will be received. The origin is in the upper left corner of the
 * main chart window.
 * @param price The price value on the chart, for which the value in pixels
 * along the Y axis will be received. The origin is in the upper left corner of
 * the main chart window.
 * @returns Returns true if successful, otherwise false. To get information
 * about the error, call the GetLastError() function.
 */
bool ChartXYToTimePrice(long chart_id, int x, int y, int &sub_window,
                        datetime &time, double &price);

/**
 * Opens a new chart with the specified symbol and period.
 *
 * @param symbol Chart symbol. NULL means the symbol of the current chart (the
 * Expert Advisor is attached to).
 * @param period Chart period (timeframe). Can be one of the ENUM_TIMEFRAMES
 * values. 0 means the current chart period.
 * @returns If successful, it returns the opened chart ID. Otherwise returns 0.
 */
long ChartOpen(string symbol, ENUM_TIMEFRAMES period);

/**
 * Returns the ID of the first chart of the client terminal.
 *
 * @returns Chart ID.
 */
long ChartFirst();

/**
 * Returns the chart ID of the chart next to the specified one.
 *
 * @param chart_id Chart ID. 0 does not mean the current chart. 0 means "return
 * the first chart ID".
 * @returns Chart ID. If this is the end of the chart list, it returns -1.
 */
long ChartNext(long chart_id);

/**
 * Closes the specified chart.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @returns If successful, returns true, otherwise false.
 */
bool ChartClose(long chart_id = 0);

/**
 * Returns the symbol name for the specified chart.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @returns If chart does not exist, the result will be an empty string.
 */
string ChartSymbol(long chart_id = 0);

/**
 * Returns the timeframe period of specified chart.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @returns The function returns one of the ENUM_TIMEFRAMES values. If chart
 * does not exist, it returns 0.
 */
ENUM_TIMEFRAMES ChartPeriod(long chart_id = 0);

/**
 * This function calls a forced redrawing of a specified chart.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 */
void ChartRedraw(long chart_id = 0);

/**
 * Sets a value for a corresponding property of the specified chart. Chart
 * property should be of a double type. The command is added to chart messages
 * queue and will be executed after processing of all previous commands.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param prop_id Chart property ID. Can be one of the
 * ENUM_CHART_PROPERTY_DOUBLE values (except the read-only properties).
 * @param value Property value.
 * @returns Returns true if the command has been added to chart queue, otherwise
 * false. To get an information about the error, call the GetLastError()
 * function.
 */
bool ChartSetDouble(long chart_id, ENUM_CHART_PROPERTY_DOUBLE prop_id,
                    double value);

/**
 * Sets a value for a corresponding property of the specified chart. Chart
 * property must be datetime, int, color, bool or char. The command is added to
 * chart messages queue and will be executed after processing of all previous
 * commands.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param prop_id Chart property ID. It can be one of the
 * ENUM_CHART_PROPERTY_INTEGER value (except the read-only properties).
 * @param sub_window Number of the chart subwindow. For the first case, the
 * default value is 0 (main chart window). The most of the properties do not
 * require a subwindow number.
 * @param value Property value.
 * @returns Returns true if the command has been added to chart queue, otherwise
 * false. To get an information about the error, call the GetLastError()
 * function.
 */
bool ChartSetInteger(long chart_id, ENUM_CHART_PROPERTY_INTEGER prop_id,
                     long value);
bool ChartSetInteger(long chart_id, ENUM_CHART_PROPERTY_INTEGER prop_id,
                     int sub_window, long value);

/**
 * Sets a value for a corresponding property of the specified chart. Chart
 * property must be of the string type. The command is added to chart messages
 * queue and will be executed after processing of all previous commands.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param prop_id Chart property ID. Its value can be one of the
 * ENUM_CHART_PROPERTY_STRING values (except the read-only properties).
 * @param str_value Property value string. String length cannot exceed 2045
 * characters (extra characters will be truncated).
 * @returns Returns true if the command has been added to chart queue, otherwise
 * false. To get an information about the error, call the GetLastError()
 * function.
 */
bool ChartSetString(long chart_id, ENUM_CHART_PROPERTY_STRING prop_id,
                    string str_value);

/**
 * Returns the value of a corresponding property of the specified chart. Chart
 * property must be of double type. There are 2 variants of the function calls.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param prop_id Chart property ID. This value can be one of the
 * ENUM_CHART_PROPERTY_DOUBLE values.
 * @param sub_window Number of the chart subwindow. For the first case, the
 * default value is 0 (main chart window). The most of the properties do not
 * require a subwindow number.
 * @param double_var Target variable of double type for the requested property.
 * @returns For the second call case it returns true if the specified property
 * is available and its value has been placed into double_var variable,
 * otherwise returns false. To get an additional information about the error, it
 * is necessary to call the function GetLastError().
 */
double ChartGetDouble(long chart_id, ENUM_CHART_PROPERTY_DOUBLE prop_id,
                      int sub_window = 0);
bool ChartGetDouble(long chart_id, ENUM_CHART_PROPERTY_DOUBLE prop_id,
                    int sub_window, double &double_var);

/**
 * Returns the value of a corresponding property of the specified chart. Chart
 * property must be of datetime, int or bool type. There are 2 variants of the
 * function calls.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param prop_id Chart property ID. This value can be one of the
 * ENUM_CHART_PROPERTY_INTEGER values.
 * @param sub_window Number of the chart subwindow. For the first case, the
 * default value is 0 (main chart window). The most of the properties do not
 * require a subwindow number.
 * @param long_var Target variable of long type for the requested property.
 * @returns For the second call case it returns true if specified property is
 * available and its value has been stored into long_var variable, otherwise
 * returns false. To get additional information about the error, it is necessary
 * to call the function GetLastError().
 */
long ChartGetInteger(long chart_id, ENUM_CHART_PROPERTY_INTEGER prop_id,
                     int sub_window = 0);
bool ChartGetInteger(long chart_id, ENUM_CHART_PROPERTY_INTEGER prop_id,
                     int sub_window, long &long_var);

/**
 * Returns the value of a corresponding property of the specified chart. Chart
 * property must be of string type. There are 2 variants of the function call.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param prop_id Chart property ID. This value can be one of the
 * ENUM_CHART_PROPERTY_STRING values.
 * @param string_var Target variable of string type for the requested property.
 * @returns For the second call case it returns true if the specified property
 * is available and its value has been stored into string_var variable,
 * otherwise returns false. To get additional information about the error, it is
 * necessary to call the function GetLastError().
 */
string ChartGetString(long chart_id, ENUM_CHART_PROPERTY_STRING prop_id);
bool ChartGetString(long chart_id, ENUM_CHART_PROPERTY_STRING prop_id,
                    string &string_var);

/**
 * Performs shift of the specified chart by the specified number of bars
 * relative to the specified position in the chart.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param position Chart position to perform a shift. Can be one of the
 * ENUM_CHART_POSITION values.
 * @param shift Number of bars to shift the chart. Positive value means the
 * right shift (to the end of chart), negative value means the left shift (to
 * the beginning of chart). The zero shift can be used to navigate to the
 * beginning or end of chart.
 * @returns Returns true if successful, otherwise returns false.
 */
bool ChartNavigate(long chart_id, ENUM_CHART_POSITION position, int shift = 0);

/**
 * Returns the ID of the current chart.
 *
 * @returns Value of long type.
 */
long ChartID();

/**
 * Adds an indicator with the specified handle into a specified chart window.
 * Indicator and chart should be generated on the same symbol and time frame.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param sub_window The number of the chart sub-window. 0 means the main chart
 * window. To add an indicator in a new window, the parameter must be one
 * greater than the index of the last existing window, i.e. equal to
 * CHART_WINDOWS_TOTAL. If the value of the parameter is greater than
 * CHART_WINDOWS_TOTAL, a new window will not be created, and the indicator will
 * not be added.
 * @param indicator_handle The handle of the indicator.
 * @returns The function returns true in case of success, otherwise it returns
 * false. In order to obtain information about the error, call the
 * GetLastError() function. Error 4114 means that a chart and an added indicator
 * differ by their symbol or time frame.
 */
bool ChartIndicatorAdd(long chart_id, int sub_window, int indicator_handle);

/**
 * Removes an indicator with a specified name from the specified chart window.
 *
 * @param chart_id Chart ID. 0 denotes the current chart.
 * @param sub_window Number of the chart subwindow. 0 denotes the main chart
 * subwindow.
 * @param const indicator_shortname The short name of the indicator which is set
 * in the INDICATOR_SHORTNAME property with the IndicatorSetString() function.
 * To get the short name of an indicator use the ChartIndicatorName() function.
 * @returns Returns true in case of successful deletion of the indicator.
 * Otherwise it returns false. To get error details use the GetLastError()
 * function.
 */
bool ChartIndicatorDelete(long chart_id, int sub_window,
                          const string indicator_shortname);

/**
 * Returns the handle of the indicator with the specified short name in the
 * specified chart window.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param sub_window The number of the chart subwindow. 0 means the main chart
 * window.
 * @param const indicator_shortname The short name if the indicator, which is
 * set in the INDICATOR_SHORTNAME property using the IndicatorSetString()
 * function. To get the short name of an indicator, use the ChartIndicatorName()
 * function.
 * @returns Returns an indicator handle if successful, otherwise returns
 * INVALID_HANDLE. To get information about the error, call the GetLastError()
 * function.
 */
int ChartIndicatorGet(long chart_id, int sub_window,
                      const string indicator_shortname);

/**
 * Returns the short name of the indicator by the number in the indicators list
 * on the specified chart window.
 *
 * @param chart_id Chart ID. 0 denotes the current chart.
 * @param sub_window Number of the chart subwindow. 0 denotes the main chart
 * subwindow.
 * @param index the index of the indicator in the list of indicators. The
 * numeration of indicators start with zero, i.e. the first indicator in the
 * list has the 0 index. To obtain the number of indicators in the list use the
 * ChartIndicatorsTotal() function.
 * @returns The short name of the indicator which is set in the
 * INDICATOR_SHORTNAME property with the IndicatorSetString() function. To get
 * error details use the GetLastError() function.
 */
string ChartIndicatorName(long chart_id, int sub_window, int index);

/**
 * Returns the number of all indicators applied to the specified chart window.
 *
 * @param chart_id Chart ID. 0 denotes the current chart.
 * @param sub_window Number of the chart subwindow. 0 denotes the main chart
 * subwindow.
 * @returns The number of indicators in the specified chart window. To get error
 * details use the GetLastError() function.
 */
int ChartIndicatorsTotal(long chart_id, int sub_window);

/**
 * Returns the number (index) of the chart subwindow the Expert Advisor or
 * script has been dropped to. 0 means the main chart window.
 *
 * @returns Value of int type.
 */
int ChartWindowOnDropped();

/**
 * Returns the price coordinate corresponding to the chart point the Expert
 * Advisor or script has been dropped to.
 *
 * @returns Value of double type.
 */
double ChartPriceOnDropped();

/**
 * Returns the time coordinate corresponding to the chart point the Expert
 * Advisor or script has been dropped to.
 *
 * @returns Value of datetime type.
 */
datetime ChartTimeOnDropped();

/**
 * Returns the X coordinate of the chart point the Expert Advisor or script has
 * been dropped to.
 *
 * @returns The X coordinate value.
 */
int ChartXOnDropped();

/**
 * Returns the Y coordinateof the chart point the Expert Advisor or script has
 * been dropped to.
 *
 * @returns The Y coordinate value.
 */
int ChartYOnDropped();

/**
 * Changes the symbol and period of the specified chart. The function is
 * asynchronous, i.e. it sends the command and does not wait for its execution
 * completion. The command is added to chart messages queue and will be executed
 * after processing of all previous commands.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param symbol Chart symbol. NULL value means the current chart symbol (Expert
 * Advisor is attached to)
 * @param period Chart period (timeframe). Can be one of the ENUM_TIMEFRAMES
 * values. 0 means the current chart period.
 * @returns Returns true if the command has been added to chart queue, otherwise
 * false. To get an information about the error, call the GetLastError()
 * function.
 */
bool ChartSetSymbolPeriod(long chart_id, string symbol, ENUM_TIMEFRAMES period);

/**
 * The function provides a screenshot of the chart in its current state in the
 * GIF, PNG or BMP format depending on specified extension.
 *
 * @param chart_id Chart ID. 0 means the current chart.
 * @param filename Screenshot file name. Cannot exceed 63 characters. Screenshot
 * files are placed in the \\Files directory.
 * @param width Screenshot width in pixels.
 * @param height Screenshot height in pixels.
 * @param align_mode Output mode of a narrow screenshot.
 * @returns Returns true if successful, otherwise false.
 */
bool ChartScreenShot(long chart_id, string filename, int width, int height,
                     ENUM_ALIGN_MODE align_mode = ALIGN_RIGHT);

/**
 * Displays a message in a separate window.
 *
 * @param ... Any values separated by commas. To split the information
 * output in several lines you can use the line feed character "\\n" or
 * "\\r\\n". The number of parameters can not exceed 64.
 */
void Alert(...);

/**
 * The function returns the type of the object pointer.
 *
 * @param anyobject Object pointer.
 * @returns Returns a value from the ENUM_POINTER_TYPE enumeration.
 */
template <typename T> ENUM_POINTER_TYPE CheckPointer(T anyobject);

/**
 * This function outputs a comment defined by a user in the top left corner of a
 * chart.
 *
 * @param ... Any values, separated by commas. To delimit output information
 * into several lines, a line break symbol "\\n" or "\\r\\n" is used. Number of
 * parameters cannot exceed 64. Total length of the input comment (including
 * invisible symbols) cannot exceed 2045 characters (excess symbols will be cut
 * out during output).
 */
void Comment(...);

/**
 * Transforms the data from array with the specified method.
 *
 * @param method Data transformation method. Can be one of the values of
 * ENUM_CRYPT_METHOD enumeration.
 * @param data Source array.
 * @param key Key array.
 * @param result Destination array.
 * @returns Amount of bytes in the destination array or 0 in case of error. To
 * obtain information about the error call the GetLastError() function.
 */
int CryptEncode(ENUM_CRYPT_METHOD method, const uchar data[], const uchar key[],
                uchar result[]);

/**
 * Performs the inverse transformation of the data from array, tranformed by
 * CryptEncode().
 *
 * @param method Data transformation method. Can be one of the values of
 * ENUM_CRYPT_METHOD enumeration.
 * @param data[] Source array.
 * @param key[] Key array.
 * @param result[] Destination array.
 * @returns Amount of bytes in the destination array or 0 in case of error. To
 * obtain information about the error call the GetLastError() function.
 */
int CryptEncode(ENUM_CRYPT_METHOD method, const uchar data[], const uchar key[],
                uchar result[]);

/**
 * It is a program breakpoint in debugging.
 */
void DebugBreak();

/**
 * The function stops an Expert Advisor and unloads it from a chart.
 */
void ExpertRemove();

/**
 * The function returns the object pointer.
 *
 * @param anyobject Object of any class.
 * @returns The function returns the object pointer.
 */
template <typename T> void *GetPointer(T anyobject);

/**
 * The GetTickCount() function returns the number of milliseconds that elapsed
 * since the system start.
 *
 * @returns Value of uint type.
 */
uint GetTickCount();

/**
 * The GetTickCount64() function returns the number of milliseconds that have
 * elapsed since the system was launched.
 *
 * @returns A ulong type value.
 */
ulong GetTickCount64();

/**
 * The GetMicrosecondCount() function returns the number of microseconds that
 * have elapsed since the start of MQL5-program.
 *
 * @returns Value of ulong type.
 */
ulong GetMicrosecondCount();

/**
 * It creates and shows a message box and manages it. A message box contains a
 * message and header, any combination of predefined signs and command buttons.
 *
 * @param text Text, containing message to output.
 * @param caption Optional text to be displayed in the box header. If the
 * parameter is empty, Expert Advisor name is shown in the box header.
 * @param flags Optional flags defining appearance and behavior of a message
 * box. Flags can be a combination of a special group of flags.
 * @returns If the function is successfully performed, the returned value is one
 * of values of MessageBox() return codes.
 */
int MessageBox(string text, string caption = "", int flags = 0);

/**
 * This function returns number of seconds in a period.
 *
 * @param period Value of a chart period from the enumeration ENUM_TIMEFRAMES.
 * If the parameter isn't specified, it returns the number of seconds of the
 * current chart period, at which the program runs.
 * @returns Number of seconds in a selected period.
 */
int PeriodSeconds(ENUM_TIMEFRAMES period = PERIOD_CURRENT);

/**
 * It plays a sound file.
 *
 * @param filename Path to a sound file. If filename=NULL, the playback is
 * stopped.
 * @returns true – if the file is found, otherwise - false.
 */
bool PlaySound(string filename);

/**
 * It enters a message in the Expert Advisor log. Parameters can be of any type.
 *
 * @param ... Any values separated by commas. The number of parameters cannot
 * exceed 64.
 */
void Print(...);

/**
 * It formats and enters sets of symbols and values in the Expert Advisor log in
 * accordance with a preset format.
 *
 * @param format_string A format string consists of simple symbols, and if the
 * format string is followed by arguments, it also contains format
 * specifications.
 * @param ... Any values of simple types separated by commas. Total number of
 * parameters can't exceed 64 including the format string.
 * @returns String.
 */
void PrintFormat(string format_string, ...);

/**
 * Sets the value of the predefined variable _LastError into zero.
 */
void ResetLastError();

/**
 * Creates an image resource based on a data set. There are two variants of the
function: Creating a resource based on a file
 *
 * @param resource_name Resource name.
 * @param data A one-dimensional or two-dimensional array for creating a
complete image.
 * @param img_width The width of the rectangular image area in pixels to be
placed in the resource in the form of an image. It cannot be greater than the
data_width value.
 * @param img_height The height of the rectangular image area in pixels to be
placed in the resource in the form of an image.
 * @param data_xoffset The horizontal rightward offset of the rectangular area
of the image.
 * @param data_yoffset The vertical downward offset of the rectangular area of
the image.
 * @param data_width Required only for one-dimensional arrays. It denotes the
full width of the image from the data set. If data_width=0, it is assumed to be
equal to img_width. For two-dimensional arrays the parameter is ignored and is
assumed to be equal to the second dimension of the data[] array.
 * @param color_format Color processing method, from a value from the
ENUM_COLOR_FORMAT enumeration.
 * @returns Returns true if successful, otherwise false. To get information
about the error call the GetLastError() function. The following errors may
occur:
 */
bool ResourceCreate(const string resource_name, const string path);
bool ResourceCreate(const string resource_name, const uint data[],
                    uint img_width, uint img_height, uint data_xoffset,
                    uint data_yoffset, uint data_width,
                    ENUM_COLOR_FORMAT color_format);

/**
 * The function deletes dynamically created resource (freeing the memory
 * allocated for it).
 *
 * @param resource_name Resource name should start with "::".
 * @returns True if successful, otherwise false. To get information about the
 * error, call the GetLastError() function.
 */
bool ResourceFree(const string resource_name);

/**
 * The function reads data from the graphical resource created by
 * ResourceCreate() function or saved in EX5 file during compilation.
 *
 * @param resource_name Name of the graphical resource containing an image. To
 * gain access to its own resources, the name is used in brief form
 * "::resourcename". If we download a resource from a compiled EX5 file, the
 * full name should be used with the path relative to MQL5 directory, file and
 * resource names – "path\\\\filename.ex5::resourcename".
 * @param data One- or two-dimensional array for receiving data from the
 * graphical resource.
 * @param img_width Graphical resource image width in pixels.
 * @param img_height Graphical resource image height in pixels.
 * @returns true if successful, otherwise false. To get information about the
 * error, call the GetLastError() function.
 */
bool ResourceReadImage(const string resource_name, uint data[], uint &width,
                       uint &height);

/**
 * Saves a resource into the specified file.
 *
 * @param resource_name The name of the resource, must start with "::".
 * @param file_name The name of the file relative to MQL5\\Files.
 * @returns true – in case of success, otherwise false. For the error
 * information call GetLastError().
 */
bool ResourceSave(const string resource_name, const string file_name);

/**
 * Sets the code that returns the terminal process when completing the
 * operation.
 *
 * @param ret_code The code to be returned by the client terminal process when
 * completing the operation.
 */
void SetReturnError(int ret_code);

/**
 * Sets the predefined variable _LastError into the value equal to
 * ERR_USER_ERROR_FIRST + user_error
 *
 * @param user_error Error number set by a user.
 */
void SetUserError(ushort user_error);

/**
 * The function suspends execution of the current Expert Advisor or script
 * within a specified interval.
 *
 * @param milliseconds Delay interval in milliseconds.
 */
void Sleep(int milliseconds);

/**
 * The function commands the terminal to complete operation.
 *
 * @param ret_code Return code, returned by the process of the client terminal
 * at the operation completion.
 * @returns The function returns true on success, otherwise - false.
 */
bool TerminalClose(int ret_code);

/**
 * Sets the mode of displaying/hiding indicators used in an EA. The function is
 * intended for managing the visibility of used indicators only during testing.
 *
 * @param hide Flag for hiding indicators when testing. Set true to hide created
 * indicators, otherwise false.
 */
void TesterHideIndicators(bool hide);

/**
 * The function returns the value of the specified statistical parameter
 * calculated based on testing results.
 *
 * @param statistic_id The ID of the statistical parameter from the
 * ENUM_STATISTICS enumeration.
 * @returns The value of the statistical parameter from testing results.
 */
double TesterStatistics(ENUM_STATISTICS statistic_id);

/**
 * Gives program operation completion command when testing.
 */
void TesterStop();

/**
 * The special function that emulates depositing funds during a test. It can be
 * used in some money management systems.
 *
 * @param money Money to be deposited to an account in the deposit currency.
 * @returns Returns true if successful, otherwise - false.
 */
bool TesterDeposit(double money);

/**
 * The special function to emulate the operation of money withdrawal in the
 * process of testing. Can be used in some asset management systems.
 *
 * @param money The sum of money that we need to withdraw (in the deposit
 * currency).
 * @returns If successful, returns true, otherwise - false.
 */
bool TesterWithdrawal(double money);

/**
 * Returns a Unicode character by a virtual key code considering the current
 * input language and the status of control keys.
 *
 * @param key_code Key code.
 * @returns Unicode character in case of a successful conversion. The function
 * returns -1 in case of an error.
 */
short TranslateKey(int key_code);

/**
 * The function resets a variable passed to it by reference.
 *
 * @param variable Variable passed by reference, you want to reset
 * (initialize by zero values).
 */
template <typename T> void ZeroMemory(T variable);

/**
 * Converting a symbol code into a one-character string.
 *
 * @param char_code Code of ANSI symbol.
 * @returns String with a ANSI symbol.
 */
string CharToString(uchar char_code);

/**
 * It copies and converts part of array of uchar type into a returned string.
 *
 * @param array Array of uchar type.
 * @param start Position from which copying starts. by default 0 is used.
 * @param count Number of array elements for copying. Defines the length of a
 * resulting string. Default value is -1, which means copying up to the array
 * end, or till terminal 0.
 * @param codepage The value of the code page. There is a number of built-in
 * constants for the most used code pages.
 */
string CharArrayToString(uchar array[], int start = 0, int count = -1,
                         uint codepage = CP_ACP);

/**
 * Copy uchar type array to POD structure.
 *
 * @param struct_object Reference to any type of POD structure (containing only
 * simple data types).
 * @param char_array uchar type array.
 * @param start_pos Position in the array, data copying starts from.
 * @returns Returns true if successful, otherwise false.
 */
template <typename T>
bool CharArrayToStruct(T struct_object, const uchar char_array[],
                       uint start_pos = 0);

/**
 * Copy POD structure to uchar type array.
 *
 * @param struct_object Reference to any type of POD structure (containing only
 * simple data types).
 * @param char_array uchar type array.
 * @param start_pos Position in the array, starting from which the copied data
 * are added.
 * @returns Returns true if successful, otherwise false.
 */
template <typename T>
bool StructToCharArray(const T struct_object, uchar char_array[],
                       uint start_pos = 0);

/**
 * The function converts color type into uint type to get ARGB representation of
 * the color. ARGB color format is used to generate a graphical resource, text
 * display, as well as for CCanvas standard library class.
 *
 * @param clr Color value in color type variable.
 * @param alpha The value of the alpha channel used to receive the color in ARGB
 * format. The value may be set from 0 (a color of a foreground pixel does not
 * change the display of an underlying one) up to 255 (a color of an underlying
 * pixel is completely replaced by the foreground pixel's one). Color
 * transparency in percentage terms is calculated as (1-alpha/255)*100%. In
 * other words, the lesser value of the alpha channel leads to more transparent
 * color.
 * @returns Presenting the color in ARGB format where Alfa, Red, Green, Blue
 * (alpha channel, red, green, blue) values are set in series in four uint type
 * bytes.
 */
uint ColorToARGB(color clr, uchar alpha = 255);

/**
 * It converts color value into string of "R,G,B" form.
 *
 * @param color_value Color value in color type variable.
 * @param color_name Return color name if it is identical to one of predefined
 * color constants.
 * @returns String presentation of color as "R,G,B", where R, G and B are
 * decimal constants from 0 to 255 converted into a string. If the
 * color_name=true parameter is set, it will try to convert color value into
 * color name.
 */
string ColorToString(color color_value, bool color_name);

/**
 * Converting numeric value into text string.
 *
 * @param value Value with a floating point.
 * @param digits Accuracy format. If the digits value is in the range between 0
 * and 16, a string presentation of a number with the specified number of digits
 * after the point will be obtained. If the digits value is in the range between
 * -1 and -16, a string representation of a number in the scientific format with
 * the specified number of digits after the decimal point will be obtained. In
 * all other cases the string value will contain 8 digits after the decimal
 * point.
 * @returns String containing a symbol representation of a number with the
 * specified accuracy.
 */
string DoubleToString(double value, int digits = 8);

/**
 * Converting an enumeration value of any type to a text form.
 *
 * @param value Any type enumeration value.
 * @returns A string with a text representation of the enumeration. To get the
 * error message call the GetLastError() function.
 */
template <typename T> string EnumToString(T value);

/**
 * This function converts value of integer type into a string of a specified
 * length and returns the obtained string.
 *
 * @param number Number for conversion.
 * @param str_len String length. If the resulting string length is larger than
 * the specified one, the string is not cut off. If it is smaller, filler
 * symbols will be added to the left.
 * @param fill_symbol Filler symbol. By default it is a space.
 */
string IntegerToString(long number, int str_len = 0, ushort fill_symbol = ' ');

/**
 * It converts the symbol code (unicode) into one-symbol string and returns
 * resulting string.
 *
 * @param symbol_code Symbol code. Instead of a symbol code you can use literal
 * string containing a symbol or a literal string with 2-byte hexadecimal code
 * corresponding to the symbol from the Unicode table.
 */
string ShortToString(ushort symbol_code);

/**
 * It copies part of array into a returned string.
 *
 * @param array Array of ushort type (analog of wchar_t type).
 * @param start Position, from which copying starts, Default - 0.
 * @param count Number of array elements to copy. Defines the length of a
 * resulting string. Default value is -1, which means copying up to the array
 * end, or till terminal 0.
 */
string ShortArrayToString(ushort array[], int start = 0, int count = -1);

/**
 * Converting a value containing time in seconds elapsed since 01.01.1970 into a
string of "yyyy.mm.dd hh:mi" format.
 *
 * @param value Time in seconds from 00:00 1970/01/01.
 * @param mode Additional data input mode. Can be one or combined flag.
 */
string TimeToString(datetime value, int mode = TIME_DATE | TIME_MINUTES);

/**
 * Rounding floating point number to a specified accuracy.
 *
 * @param value Value with a floating point.
 * @param digits Accuracy format, number of digits after point (0-8).
 * @returns Value of double type with preset accuracy.
 */
double NormalizeDouble(double value, int digits);

/**
 * Symbol-wise copies a string converted from Unicode to ANSI, to a selected
 * place of array of uchar type. It returns the number of copied elements.
 *
 * @param text_string String to copy.
 * @param array Array of uchar type.
 * @param start Position from which copying starts. Default - 0.
 * @param count Number of array elements to copy. Defines length of a resulting
 * string. Default value is -1, which means copying up to the array end, or till
 * terminal 0. Terminal 0 will also be copied to the recipient array, in this
 * case the size of a dynamic array can be increased if necessary to the size of
 * the string. If the size of the dynamic array exceeds the length of the
 * string, the size of the array will not be reduced.
 * @param codepage The value of the code page. For the most-used code pages
 * provide appropriate constants.
 * @returns Number of copied elements.
 */
int StringToCharArray(string text_string, uchar array[], int start = 0,
                      int count = -1, uint codepage = CP_ACP);

/**
 * Converting "R,G,B" string or string with color name into color type value.
 *
 * @param color_string String representation of a color of "R,G,B" type or name
 * of one of predefined Web-colors.
 * @returns Color value.
 */
color StringToColor(string color_string);

/**
 * The function converts string containing a symbol representation of number
 * into number of double type.
 *
 * @param value String containing a symbol representation of a number.
 * @returns Value of double type.
 */
double StringToDouble(string value);

/**
 * The function converts string containing a symbol representation of number
 * into number of long (integer) type.
 *
 * @param value String containing a number.
 * @returns Value of long type.
 */
long StringToInteger(string value);

/**
 * The function symbol-wise copies a string into a specified place of an array
 * of ushort type. It returns the number of copied elements.
 *
 * @param text_string String to copy
 * @param array Array of ushort type (analog of wchar_t type).
 * @param start Position, from which copying starts. Default - 0.
 * @param count Number of array elements to copy. Defines length of a resulting
 * string. Default value is -1, which means copying up to the array end, or till
 * terminal 0.Terminal 0 will also be copied to the recipient array, in this
 * case the size of a dynamic array can be increased if necessary to the size of
 * the string. If the size of the dynamic array exceeds the length of the
 * string, the size of the array will not be reduced.
 * @returns Number of copied elements.
 */
int StringToShortArray(string text_string, ushort array[], int start = 0,
                       int count = -1);

/**
 * Transforms the string containing time and/or date in the "yyyy.mm.dd [hh:mi]"
 * format into the datetime type number.
 *
 * @param time_string String in one of the specified formats:
 * @returns datetime type value containing the number of seconds elapsed since
 * 01.01.1970.
 */
datetime StringToTime(const string time_string);

/**
 * The function formats obtained parameters and returns a string.
 *
 * @param format String containing method of formatting. Formatting rules are
 * the same as for the PrintFormat function.
 * @param ... Parameters, separated by a comma.
 */
string StringFormat(string format, ...);

/**
 * The function binds a specified indicator buffer with one-dimensional dynamic
 * array of the double type.
 *
 * @param index Number of the indicator buffer. The numbering starts with 0. The
 * number must be less than the value declared in #property indicator_buffers.
 * @param buffer An array declared in the custom indicator program.
 * @param data_type Type of data stored in the indicator array. By default it is
 * INDICATOR_DATA (values of the calculated indicator). It may also take the
 * value of INDICATOR_COLOR_INDEX; in this case this buffer is used for storing
 * color indexes for the previous indicator buffer. You can specify up to 64
 * colors in the #property indicator_colorN line. The INDICATOR_CALCULATIONS
 * value means that the buffer is used in intermediate calculations of the
 * indicator and is not intended for drawing.
 * @returns If successful, returns true, otherwise - false.
 */
bool SetIndexBuffer(int index, double buffer[],
                    ENUM_INDEXBUFFER_TYPE data_type);

/**
 * The function sets the value of the corresponding indicator property.
 * Indicator property must be of the double type. There are two variants of the
 * function.
 *
 * @param prop_id Identifier of the indicator property. The value can be one of
 * the values of the ENUM_CUSTOMIND_PROPERTY_DOUBLE enumeration.
 * @param prop_modifier Modifier of the specified property. Only level
 * properties require a modifier. Numbering of levels starts from 0. It means
 * that in order to set property for the second level you need to specify 1 (1
 * less than when using compiler directive).
 * @param prop_value Value of property.
 * @returns In case of successful execution, returns true, otherwise - false.
 */
bool IndicatorSetDouble(ENUM_CUSTOMIND_PROPERTY_DOUBLE prop_id,
                        double prop_value);
bool IndicatorSetDouble(ENUM_CUSTOMIND_PROPERTY_DOUBLE prop_id,
                        int prop_modifier, double prop_value);

/**
 * The function sets the value of the corresponding indicator property.
 * Indicator property must be of the int or color type. There are two variants
 * of the function.
 *
 * @param prop_id Identifier of the indicator property. The value can be one of
 * the values of the ENUM_CUSTOMIND_PROPERTY_INTEGER enumeration.
 * @param prop_modifier Modifier of the specified property. Only level
 * properties require a modifier.
 * @param prop_value Value of property.
 * @returns In case of successful execution, returns true, otherwise - false.
 */
bool IndicatorSetInteger(ENUM_CUSTOMIND_PROPERTY_INTEGER prop_id,
                         int prop_value);
bool IndicatorSetInteger(ENUM_CUSTOMIND_PROPERTY_INTEGER prop_id,
                         int prop_modifier, int prop_value);

/**
 * The function sets the value of the corresponding indicator property.
 * Indicator property must be of the string type. There are two variants of
 * the function.
 *
 * @param prop_id Identifier of the indicator property. The value can be one
 * of the values of the ENUM_CUSTOMIND_PROPERTY_STRING enumeration.
 * @param prop_modifier Modifier of the specified property. Only level
 * properties require a modifier.
 * @param prop_value Value of property.
 * @returns In case of successful execution, returns true, otherwise -
 * false.
 */
bool IndicatorSetString(ENUM_CUSTOMIND_PROPERTY_STRING prop_id,
                        string prop_value);
bool IndicatorSetString(ENUM_CUSTOMIND_PROPERTY_STRING prop_id,
                        int prop_modifier, string prop_value);

/**
 * The function sets the value of the corresponding property of the
 * corresponding indicator line. The indicator property must be of the
 * double type.
 *
 * @param plot_index Index of the graphical plotting
 * @param prop_id The value can be one of the values of the
 * ENUM_PLOT_PROPERTY_DOUBLE enumeration.
 * @param prop_value The value of the property.
 * @returns If successful, returns true, otherwise false.
 */
bool PlotIndexSetDouble(int plot_index, ENUM_PLOT_PROPERTY_DOUBLE prop_id,
                        double prop_value);

/**
 * The function sets the value of the corresponding property of the
 * corresponding indicator line. The indicator property must be of the int,
 * char, bool or color type. There are 2 variants of the function.
 *
 * @param plot_index Index of the graphical plotting
 * @param prop_id The value can be one of the values of the
 * ENUM_PLOT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier Modifier of the specified property. Only color index
 * properties require a modifier.
 * @param prop_value The value of the property.
 * @returns If successful, returns true, otherwise false.
 */
bool PlotIndexSetInteger(int plot_index, ENUM_PLOT_PROPERTY_INTEGER prop_id,
                         int prop_value);
bool PlotIndexSetInteger(int plot_index, ENUM_PLOT_PROPERTY_INTEGER prop_id,
                         int prop_modifier, int prop_value);

/**
 * The function sets the value of the corresponding property of the
 * corresponding indicator line. The indicator property must be of the string
 * type.
 *
 * @param plot_index Index of graphical plot
 * @param prop_id The value can be one of the values of the
 * ENUM_PLOT_PROPERTY_STRING enumeration.
 * @param prop_value The value of the property.
 * @returns If successful, returns true, otherwise false.
 */
bool PlotIndexSetString(int plot_index, ENUM_PLOT_PROPERTY_STRING prop_id,
                        string prop_value);

/**
 * The function sets the value of the corresponding property of the
 * corresponding indicator line. The indicator property must be of the int,
 * color, bool or char type. There are 2 variants of the function.
 *
 * @param plot_index Index of the graphical plotting
 * @param prop_id The value can be one of the values of the
 * ENUM_PLOT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier Modifier of the specified property. Only color index
 * properties require a modifier.
 */
int PlotIndexGetInteger(int plot_index, ENUM_PLOT_PROPERTY_INTEGER prop_id);
int PlotIndexGetInteger(int plot_index, ENUM_PLOT_PROPERTY_INTEGER prop_id,
                        int prop_modifier);

/**
 * Creates a custom symbol with the specified name in the specified group.
 *
 * @param symbol_name Custom symbol name. It should not contain groups or
 * subgroups the symbol is located in.
 * @param symbol_path The group name a symbol is located in.
 * @param symbol_origin Name of a symbol the properties of a created custom
 * symbol are to be copied from. After creating a custom symbol, any property
 * value can be changed to a necessary one using the appropriate functions.
 * @returns true – success, otherwise – false. To get information about the
 * error, call the GetLastError() function.
 */
bool CustomSymbolCreate(const string symbol_name, const string symbol_path = "",
                        const string symbol_origin = "");

/**
 * Deletes a custom symbol with the specified name.
 *
 * @param symbol Custom symbol name. It should not match the name of an already
 * existing symbol.
 * @returns true – success, otherwise – false. To get information about the
 * error, call the GetLastError() function.
 */
bool CustomSymbolDelete(const string symbol_name);

/**
 * Sets the integer type property value for a custom symbol.
 *
 * @param symbol_name Custom symbol name.
 * @param property_id Symbol property ID. The value can be one of the values of
 * the ENUM_SYMBOL_INFO_INTEGER enumeration.
 * @param property_value A long type variable containing the property value.
 * @returns true – success, otherwise – false. To get information about the
 * error, call the GetLastError() function.
 */
bool CustomSymbolSetInteger(const string symbol_name,
                            ENUM_SYMBOL_INFO_INTEGER property_id,
                            long property_value);

/**
 * Sets the real type property value for a custom symbol.
 *
 * @param symbol_name Custom symbol name.
 * @param property_id Symbol property ID. The value can be one of the values of
 * the ENUM_SYMBOL_INFO_DOUBLE enumeration.
 * @param property_value A double type variable containing the property value.
 * @returns true – success, otherwise – false. To get information about the
 * error, call the GetLastError() function.
 */
bool CustomSymbolSetDouble(const string symbol_name,
                           ENUM_SYMBOL_INFO_DOUBLE property_id,
                           double property_value);

/**
 * Sets the string type property value for a custom symbol.
 *
 * @param symbol_name Custom symbol name.
 * @param property_id Symbol property ID. The value can be one of the values of
 * the ENUM_SYMBOL_INFO_STRING enumeration.
 * @param property_value A string type variable containing the property value.
 * @returns true – success, otherwise – false. To get information about the
 * error, call the GetLastError() function.
 */
bool CustomSymbolSetString(const string symbol_name,
                           ENUM_SYMBOL_INFO_STRING property_id,
                           string property_value);

/**
 * Sets the margin rates depending on the order type and direction for a custom
 * symbol.
 *
 * @param symbol_name Custom symbol name.
 * @param order_type Order type.
 * @param initial_margin_rate A double type variable with an initial margin
 * rate. Initial margin is a security deposit for 1 lot deal in the appropriate
 * direction. Multiplying the rate by the initial margin, we receive the amount
 * of funds to be reserved on the account when placing an order of the specified
 * type.
 * @param maintenance_margin_rate A double type variable with a maintenance
 * margin rate. Maintenance margin is a minimum amount for maintaining an open
 * position of 1 lot in the appropriate direction. Multiplying the rate by the
 * maintenance margin, we receive the amount of funds to be reserved on the
 * account after an order of the specified type is activated.
 * @returns true – success, otherwise – false. To get information about the
 * error, call the GetLastError() function.
 */
bool CustomSymbolSetMarginRate(const string symbol_name,
                               ENUM_ORDER_TYPE order_type,
                               double initial_margin_rate,
                               double maintenance_margin_rate);

/**
 * Sets the start and end time of the specified quotation session for the
 * specified symbol and week day.
 *
 * @param symbol_name Custom symbol name.
 * @param ENUM_DAY_OF_WEEK Week day, value from the ENUM_DAY_OF_WEEK
 * enumeration.
 * @param uint Index of the session, for which start and end times are to be
 * set. Session indexing starts from 0.
 * @param from Session start time in seconds from 00:00, data value in the
 * variable is ignored.
 * @param to Session end time in seconds from 00:00, data value in the variable
 * is ignored.
 * @returns true – success, otherwise – false. To get information about the
 * error, call the GetLastError() function.
 */
bool CustomSymbolSetSessionQuote(const string symbol_name,
                                 ENUM_DAY_OF_WEEK day_of_week,
                                 uint session_index, datetime from,
                                 datetime to);

/**
 * Sets the start and end time of the specified trading session for the
 * specified symbol and week day.
 *
 * @param symbol_name Custom symbol name.
 * @param ENUM_DAY_OF_WEEK Week day, value from the ENUM_DAY_OF_WEEK
 * enumeration.
 * @param uint Index of the session, for which start and end times are to be
 * set. Session indexing starts from 0.
 * @param from Session start time in seconds from 00:00, data value in the
 * variable is ignored.
 * @param to Session end time in seconds from 00:00, data value in the variable
 * is ignored.
 * @returns true – success, otherwise – false. To get information about the
 * error, call the GetLastError() function.
 */
bool CustomSymbolSetSessionTrade(const string symbol_name,
                                 ENUM_DAY_OF_WEEK day_of_week,
                                 uint session_index, datetime from,
                                 datetime to);

/**
 * Deletes all bars from the price history of the custom symbol in the specified
 * time interval.
 *
 * @param symbol Custom symbol name.
 * @param from Time of the first bar in the price history within the specified
 * range to be removed.
 * @param to Time of the last bar in the price history within the specified
 * range to be removed.
 * @returns Number of deleted bars or -1 in case of an error.
 */
int CustomRatesDelete(const string symbol, datetime from, datetime to);

/**
 * Fully replaces the price history of the custom symbol within the specified
 * time interval with the data from the MqlRates type array.
 *
 * @param symbol Custom symbol name.
 * @param from Time of the first bar in the price history within the specified
 * range to be updated.
 * @param to Time of the last bar in the price history within the specified
 * range to be updated.
 * @param rates Array of the MqlRates type history data for M1.
 * @param count Number of the rates[] array elements to be used for replacement.
 * WHOLE_ARRAY means that all rates[] array elements should be used for
 * replacement.
 * @returns Number of updated bars or -1 in case of an error.
 */
int CustomRatesReplace(const string symbol, datetime from, datetime to,
                       const MqlRates rates[], uint count = WHOLE_ARRAY);

/**
 * Adds missing bars to the custom symbol history and replaces existing data
 * with the ones from the MqlRates type array.
 *
 * @param symbol Custom symbol name.
 * @param rates Array of the MqlRates type history data for M1.
 * @param count Number of the rates[] array elements to be used for update.
 * WHOLE_ARRAY means that all rates[] array elements should be used.
 * @returns Number of updated bars or -1 in case of an error.
 */
int CustomRatesUpdate(const string symbol, const MqlRates rates[],
                      uint count = WHOLE_ARRAY);

/**
 * Adds data from an array of the MqlTick type to the price history of a custom
 * symbol. The custom symbol must be selected in the Market Watch window.
 *
 * @param symbol The name of the custom symbol.
 * @param ticks An array of tick data of the MqlTick type arranged in order of
 * time from earlier data to more recent ones, i.e. ticks[k].time_msc <=
 * ticks[n].time_msc, if k<n.
 * @param count Number of the ticks[] array elements to be used for adding.
 * WHOLE_ARRAY means that all ticks[] array elements should be used.
 * @returns The number of added ticks or -1 in case of an error.
 */
int CustomTicksAdd(const string symbol, const MqlTick ticks[],
                   uint count = WHOLE_ARRAY);

/**
 * Deletes all ticks from the price history of the custom symbol in the
 * specified time interval.
 *
 * @param symbol Custom symbol name.
 * @param from_msc Time of the first tick in the price history within the
 * specified range to be removed. Time in milliseconds since 01.01.1970.
 * @param to_msc Time of the last tick in the price history within the specified
 * range to be removed. Time in milliseconds since 01.01.1970.
 * @returns Number of deleted ticks or -1 in case of an error.
 */
int CustomTicksDelete(const string symbol, long from_msc, long to_msc);

/**
 * Fully replaces the price history of the custom symbol within the specified
 * time interval with the data from the MqlTick type array.
 *
 * @param symbol Custom symbol name.
 * @param from_msc Time of the first tick in the price history within the
 * specified range to be removed. Time in milliseconds since 01.01.1970.
 * @param to_msc Time of the last tick in the price history within the specified
 * range to be removed. Time in milliseconds since 01.01.1970.
 * @param ticks Array of the MqlTick type tick data ordered in time in ascending
 * order.
 * @param count Number of the ticks[] array elements to be used for replacement
 * in the specified time interval. WHOLE_ARRAY means that all ticks[] array
 * elements should be used.
 * @returns Number of updated ticks or -1 in case of an error.
 */
int CustomTicksReplace(const string symbol, long from_msc, long to_msc,
                       const MqlTick ticks[], uint count = WHOLE_ARRAY);

/**
 * Passes the status of the Depth of Market for a custom symbol. The function
 * allows broadcasting the Depth of Market as if the prices arrive from a
 * broker's server.
 *
 * @param symbol Custom symbol name.
 * @param books The array of MqlBookInfo type data fully describing the Depth of
 * Market status — all buy and sell requests. The passed Depth of Market status
 * completely replaces the previous one.
 * @param count The number of 'books' array elements to be passed to the
 * function. The entire array is used by default.
 * @returns Number of added ticks or -1 in case of an error.
 */
int CustomBookAdd(const string symbol, const MqlBookInfo books[],
                  uint count = WHOLE_ARRAY);

/**
 * Opens or creates a database in a specified file.
 *
 * @param filename File name relative to the "MQL5\\Files" folder.
 * @param flags Combination of flags from the ENUM_DATABASE_OPEN_FLAGS
 * enumeration.
 * @returns If executed successfully, the function returns the database handle,
 * which is then used to access the database. Otherwise, it returns
 * INVALID_HANDLE. To get the error code, use GetLastError(), the possible
 * responses are:
 *
 * • ERR_INTERNAL_ERROR (4001) - critical runtime error;
 * • ERR_WRONG_INTERNAL_PARAMETER (4002)  - internal error, while accessing the
 * "MQL5\Files" folder;
 * • ERR_INVALID_PARAMETER (4003) - path to the database file contains an empty
 * string, or an incompatible combination of flags is set;
 * • ERR_NOT_ENOUGH_MEMORY (4004) - insufficient memory;
 * • ERR_WRONG_FILENAME (5002) - wrong database file name;
 * • ERR_DATABASE_TOO_MANY_OBJECTS (5122) - exceeded the maximum acceptable
 * number of Database objects;
 * • ERR_DATABASE_CONNECT (5123) - database connection error;
 * • ERR_DATABASE_MISUSE (5621) - incorrect use of the SQLite library.
 */
int DatabaseOpen(string filename, uint flags);

/**
 * Closes a database.
 *
 * @param database Database handle received in DatabaseOpen().
 */
void DatabaseClose(int database);

/**
 * Imports data from a file into a table.
 *
 * @param database Database handle received in DatabaseOpen().
 * @param table Name of a table the data from a file is to be added to.
 * @param filename CSV file or ZIP archive for reading data. The name may
 * contain subdirectories and is set relative to the MQL5\\Files folder.
 * @param flags Combination of flags.
 * @param separator Data separator in CSV file.
 * @param skip_rows Number of initial strings to be skipped when reading data
 * from the file.
 * @param skip_comments String of characters for designating strings as
 * comments. If any character from skip_comments is detected at the beginning of
 * a string, such a string is considered a comment and is not imported.
 * @returns Return the number of imported strings or -1 in case of an error. To
 * get the error code, use GetLastError(), the possible responses are:
 *
 * ERR_INVALID_PARAMETER (4003) - no table name specified (empty string or
 * NULL);
 * ERR_DATABASE_INTERNAL (5120) - internal database error;
 * ERR_DATABASE_INVALID_HANDLE (5121) - invalid database handle.
 */
long DatabaseImport(int database, const string table, const string filename,
                    uint flags, const string separator, ulong skip_rows,
                    const string skip_comments);

/**
 * Exports a table or an SQL request execution result to a CSV file. The file is
 * created in the UTF-8 encoding.
 *
 * @param database Database handle received in DatabaseOpen().
 * @param table_or_sql A name of a table or a text of an SQL request whose
 * results are to be exported to a specified file.
 * @param filename A file name for data export. The path is set relative to the
 * MQL5\\Files folder.
 * @param flags Combination of flags defining the output to a file.
 * @param separator Data separator. If NULL is specified, the '\\t' tabulation
 * character is used as a separator. An empty string "" is considered a valid
 * separator but the obtained CSV file cannot be read as a table – it is
 * considered as a set of strings.
 * @returns Return the number of exported entries or a negative value in case of
 * an error. To get the error code, use GetLastError(), the possible responses
 * are:
 *
 * ERR_INTERNAL_ERROR (4001) - critical runtime error;
 * ERR_INVALID_PARAMETER (4003) - path to the database file contains an empty
 * string, or an incompatible combination of flags is set;
 * ERR_NOT_ENOUGH_MEMORY (4004) - insufficient memory;
 * ERR_FUNCTION_NOT_ALLOWED(4014) - specified pipe is not allowed;
 * ERR_PROGRAM_STOPPED(4022) - operation canceled (MQL program stopped);
 * ERR_WRONG_FILENAME (5002) - invalid file name;
 * ERR_TOO_LONG_FILENAME (5003) - absolute path to the file exceeds the maximum
 * length;
 * ERR_CANNOT_OPEN_FILE(5004) - unable to open the file for writing;
 * ERR_FILE_WRITEERROR(5026) - unable to write to the file;
 * ERR_DATABASE_INTERNAL (5120) - internal database error;
 * ERR_DATABASE_INVALID_HANDLE (5121) - invalid database handle;
 * ERR_DATABASE_QUERY_PREPARE(5125) - request generation error;
 * ERR_DATABASE_QUERY_NOT_READONLY - read-only request is allowed.
 */
long DatabaseExport(int database, const string table_or_sql,
                    const string filename, uint flags, const string separator);

/**
 * Prints a table or an SQL request execution result in the Experts journal.
 *
 * @param database Database handle received in DatabaseOpen().
 * @param table_or_sql A name of a table or a text of an SQL request whose
 * results are displayed in the Experts journal.
 * @param flags Combination of flags defining the output formatting. If flags=0,
 * the columns and the strings are displayed, the header and the data are
 * separated by the frame, while the strings are aligned to the left.
 * @returns Return the number of exported strings or -1 in case of an error. To
 * get the error code, use GetLastError(), the possible responses are:
 *
 * ERR_INTERNAL_ERROR (4001) - critical runtime error;
 * ERR_NOT_ENOUGH_MEMORY (4004) - insufficient memory;
 * ERR_DATABASE_INTERNAL (5120) - internal database error;
 * ERR_DATABASE_INVALID_HANDLE (5121) - invalid database handle;
 */
long DatabasePrint(int database, const string table_or_sql, uint flags);

/**
 * Checks the presence of the table in a database.
 *
 * @param database Database handle received in DatabaseOpen().
 * @param table Table name.
 * @returns Return true if successful, otherwise false. To get the error code,
 * use GetLastError(), the possible responses are:
 *
 * ERR_INVALID_PARAMETER (4003) - no table name specified (empty string or NULL)
 * ERR_WRONG_STRING_PARAMETER (5040) - error converting a request into a UTF-8
 * string;
 * ERR_DATABASE_INTERNAL (5120) - internal database error;
 * ERR_DATABASE_INVALID_HANDLE (5121) - invalid database handle;
 * ERR_DATABASE_EXECUTE (5124) - request execution error;
 * ERR_DATABASE_NO_MORE_DATA (5126) - no table exists (not an error, normal
 * completion).
 */
bool DatabaseTableExists(int database, string table);

/**
 * Returns the last known server time, time of the last quote receipt for one of
 * the symbols selected in the "Market Watch" window. In the OnTick() handler,
 * this function returns the time of the received handled tick. In other cases
 * (for example, call in handlers OnInit(), OnDeinit(), OnTimer() and so on)
 * this is the time of the last quote receipt for any symbol available in the
 * "Market Watch" window, the time shown in the title of this window. The time
 * value is formed on a trade server and does not depend on the time settings on
 * your computer. There are 2 variants of the function.
 *
 * @param dt_struct MqlDateTime structure type variable.
 * @returns Value of datetime type
 */
datetime TimeCurrent();
datetime TimeCurrent(MqlDateTime &dt_struct);

/**
 * Returns the calculated current time of the trade server. Unlike
 * TimeCurrent(), the calculation of the time value is performed in the client
 * terminal and depends on the time settings on your computer. There are 2
 * variants of the function.
 *
 * @param dt_struct Variable of structure type MqlDateTime.
 * @returns Value of datetime type
 */
datetime TimeTradeServer();
datetime TimeTradeServer(MqlDateTime &dt_struct);

/**
 * Returns the local time of a computer, where the client terminal is running.
 * There are 2 variants of the function.
 *
 * @param dt_struct Variable of structure type MqlDateTime.
 * @returns Value of datetime type
 */
datetime TimeLocal();
datetime TimeLocal(MqlDateTime &dt_struct);

/**
 * Returns the GMT, which is calculated taking into account the DST switch by
 * the local time on the computer where the client terminal is running. There
 * are 2 variants of the function.
 *
 * @param dt_struct Variable of structure type MqlDateTime.
 * @returns Value of datetime type
 */
datetime TimeGMT();
datetime TimeGMT(MqlDateTime &dt_struct);

/**
 * Returns correction for daylight saving time in seconds, if the switch to
 * summer time has been made. It depends on the time settings of your computer.
 *
 * @returns If switch to winter (standard) time has been made, it returns 0.
 */
int TimeDaylightSavings();

/**
 * Returns the current difference between GMT time and the local computer time
 * in seconds, taking into account switch to winter or summer time. Depends on
 * the time settings of your computer.
 *
 * @returns The value of int type, representing the current difference between
 * GMT time and the local time of the computer TimeLocal in seconds.
 */
int TimeGMTOffset();

/**
 * Converts a value of datetime type (number of seconds since 01.01.1970) into a
 * structure variable MqlDateTime.
 *
 * @param dt Date value to convert.
 * @param dt_struct Variable of structure type MqlDateTime.
 * @returns True if successful, otherwise false. To get information about the
 * error, call the GetLastError() function.
 */
bool TimeToStruct(datetime dt, MqlDateTime &dt_struct);

/**
 * Converts a structure variable MqlDateTime into a value of datetime type and
 * returns the resulting value.
 *
 * @param dt_struct Variable of structure type MqlDateTime.
 * @returns The value of datetime type containing the number of seconds since
 * 01.01.1970.
 */
datetime StructToTime(MqlDateTime &dt_struct);

/**
 * Get a country description by its ID.
 *
 * @param country_id Country ID (ISO 3166-1).
 * @param country MqlCalendarCountry type variable for receiving a country
 * description.
 * @returns Returns true if successful, otherwise - false. To get information
 * about an error, call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 5402 – ERR_CALENDAR_NO_DATA (country is not found),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded).
 */
bool CalendarCountryById(const long country_id, MqlCalendarCountry &country);

/**
 * Get an event description by its ID.
 *
 * @param event_id Event ID.
 * @param event MqlCalendarEvent type variable for receiving an event
 * description.
 * @returns Returns true if successful, otherwise - false. To get information
 * about an error, call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 5402 – ERR_CALENDAR_NO_DATA (country is not found),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded).
 */
bool CalendarEventById(ulong event_id, MqlCalendarEvent &event);

/**
 * Get an event value description by its ID.
 *
 * @param value_id Event value ID.
 * @param value MqlCalendarValue type variable for receiving an event
 * description.
 * @returns Returns true if successful, otherwise - false. To get information
 * about an error, call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 5402 – ERR_CALENDAR_NO_DATA (country is not found),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded).
 */
bool CalendarValueById(ulong value_id, MqlCalendarValue &value);

/**
 * Get the array of descriptions of all events available in the Calendar by a
 * specified country code.
 *
 * @param country_code Country code name (ISO 3166-1 alpha-2)
 * @param events MqlCalendarEvent type array for receiving descriptions of all
 * events for a specified country.
 * @returns Number of received descriptions. To get information about an error,
 * call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 4004 – ERR_NOT_ENOUGH_MEMORY (not enough memory for executing a request),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded),
 * errors of failed execution of ArrayResize()
 */
int CalendarEventByCountry(string country_code, MqlCalendarEvent events[]);

/**
 * Get the array of descriptions of all events available in the Calendar by a
 * specified currency.
 *
 * @param currency Country currency code name.
 * @param events MqlCalendarEvent type array for receiving descriptions of all
 * events for a specified currency.
 * @returns Number of received descriptions. To get information about an error,
 * call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 4004 – ERR_NOT_ENOUGH_MEMORY (not enough memory for executing a request),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded),
 * errors of failed execution of ArrayResize()
 */
int CalendarEventByCurrency(const string currency, MqlCalendarEvent events[]);

/**
 * Get the array of values for all events in a specified time range by an event
 * ID.
 *
 * @param event_id Event ID.
 * @param values MqlCalendarValue type array for receiving event values.
 * @param datetime_from Initial date of a time range events are selected from by
 * a specified ID, while datetime_from < datetime_to.
 * @param datetime_to End date of a time range events are selected from by a
 * specified ID. If the datetime_to is not set (or is 0), all event values
 * beginning from the specified datetime_from date in the Calendar database are
 * returned (including the values of future events).
 * @returns Returns true if successful, otherwise - false. To get information
 * about an error, call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 4004 – ERR_NOT_ENOUGH_MEMORY (not enough memory for executing a request),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded),
 * 5400 – ERR_CALENDAR_MORE_DATA (array size is insufficient for receiving
 * descriptions of all values, only the ones that managed to fit in were
 * received), errors of failed execution of ArrayResize()
 */
bool CalendarValueHistoryByEvent(ulong event_id, MqlCalendarValue values[],
                                 datetime datetime_from,
                                 datetime datetime_to = 0);

/**
 * Get the array of values for all events in a specified time range with the
 * ability to sort by country and/or currency.
 *
 * @param values MqlCalendarValue type array for receiving event values.
 * @param datetime_from Initial date of a time range events are selected from by
 * a specified ID, while datetime_from < datetime_to.
 * @param datetime_to End date of a time range events are selected from by a
 * specified ID. If the datetime_to is not set (or is 0), all event values
 * beginning from the specified datetime_from date in the Calendar database are
 * returned (including the values of future events).
 * @param country_code Country code name (ISO 3166-1 alpha-2)
 * @param currency Country currency code name.
 * @returns Returns true if successful, otherwise - false. To get information
 * about an error, call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 4004 – ERR_NOT_ENOUGH_MEMORY (not enough memory for executing a request),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded),
 * 5400 – ERR_CALENDAR_MORE_DATA (array size is insufficient for receiving
 * descriptions of all values, only the ones that managed to fit in were
 * received),
 * errors of failed execution of ArrayResize()
 */
bool CalendarValueHistory(MqlCalendarValue values[], datetime datetime_from,
                          datetime datetime_to = 0,
                          const string country_code = "",
                          const string currency = "");

/**
 * Get the array of values for all events in a specified time range with the
 * ability to sort by country and/or currency.
 *
 * @param values MqlCalendarValue type array for receiving event values.
 * @param datetime_from Initial date of a time range events are selected from by
 * a specified ID, while datetime_from < datetime_to.
 * @param datetime_to End date of a time range events are selected from by a
 * specified ID. If the datetime_to is not set (or is 0), all event values
 * beginning from the specified datetime_from date in the Calendar database are
 * returned (including the values of future events).
 * @param country_code Country code name (ISO 3166-1 alpha-2)
 * @param currency Country currency code name.
 * @returns Returns true if successful, otherwise - false. To get information
 * about an error, call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 4004 – ERR_NOT_ENOUGH_MEMORY (not enough memory for executing a request),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded),
 * 5400 – ERR_CALENDAR_MORE_DATA (array size is insufficient for receiving
 * descriptions of all values, only the ones that managed to fit in were
 * received), errors of failed execution of ArrayResize()
 */
bool CalendarValueHistory(MqlCalendarValue values[], datetime datetime_from,
                          datetime datetime_to, const string country_code,
                          const string currency);

/**
 * Get the array of event values by its ID since the Calendar database status
 * with a specified change_id.
 *
 * @param event_id Event ID.
 * @param change_id Change ID.
 * @param values MqlCalendarValue type array for receiving event values.
 * @returns Number of received event values. To get information about an error,
 * call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 4004 – ERR_NOT_ENOUGH_MEMORY (not enough memory for executing a request),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded),
 * 5400 – ERR_CALENDAR_MORE_DATA (array size is insufficient for receiving
 * descriptions of all values, only the ones that managed to fit in were
 * received), errors of failed execution of ArrayResize()
 */
int CalendarValueLastByEvent(ulong event_id, ulong &change_id,
                             MqlCalendarValue values[]);

/**
 * Get the array of values for all events with the ability to sort by country
 * and/or currency since the calendar database status with a specified
 * change_id.
 *
 * @param change_id Change ID.
 * @param values MqlCalendarValue type array for receiving event values.
 * @param country_code Country code name (ISO 3166-1 alpha-2)
 * @param currency Country currency code name.
 * @returns Number of received event values. To get information about an error,
 * call the GetLastError() function. Possible errors:
 *
 * 4001 – ERR_INTERNAL_ERROR  (general runtime error),
 * 4004 – ERR_NOT_ENOUGH_MEMORY (not enough memory for executing a request),
 * 5401 – ERR_CALENDAR_TIMEOUT (request time limit exceeded),
 * 5400 – ERR_CALENDAR_MORE_DATA (array size is insufficient for receiving
 * descriptions of all values, only the ones that managed to fit in were
 * received), errors of failed execution of ArrayResize()
 */
int CalendarValueLast(ulong &change_id, MqlCalendarValue values[],
                      const string country_code = "",
                      const string currency = "");

/**
 * The function indicates to the client terminal that timer events should be
 * generated at intervals less than one second for this Expert Advisor or
 * indicator.
 *
 * @param milliseconds Number of milliseconds defining the frequency of timer
 * events.
 * @returns In case of successful execution, returns true, otherwise - false. To
 * receive an error code, GetLastError() function should be called.
 */
bool EventSetMillisecondTimer(int milliseconds);

/**
 * The function indicates to the client terminal, that for this indicator or
 * Expert Advisor, events from the timer must be generated with the specified
 * periodicity.
 *
 * @param seconds Number of seconds that determine the frequency of the timer
 * event occurrence.
 * @returns In case of success returns true, otherwise false. In order to get an
 * error code, the GetLastError() function should be called.
 */
bool EventSetTimer(int seconds);

/**
 * Specifies the client terminal that is necessary to stop the generation of
 * events from Timer.
 */
void EventKillTimer();

/**
 * The function generates a custom event for the specified chart.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param custom_event_id ID of the user events. This identifier is
 * automatically added to the value CHARTEVENT_CUSTOM and converted to the
 * integer type.
 * @param lparam Event parameter of the long type passed to the OnChartEvent
 * function.
 * @param dparam Event parameter of the double type passed to the OnChartEvent
 * function.
 * @param sparam Event parameter of the string type passed to the OnChartEvent
 * function. If the string is longer than 63 characters, it is truncated.
 * @returns Returns true if a custom event has been successfully placed in the
 * events queue of the chart that receives the events. In case of failure, it
 * returns false. Use GetLastError() to get an error code.
 */
bool EventChartCustom(long chart_id, ushort custom_event_id, long lparam,
                      double dparam, string sparam);

/**
 * Create a file or folder opening/creation dialog.
 *
 * @param caption Dialog window header.
 * @param initial_dir Initial directory name relative to MQL5\\Files, the
 * contents of which is to be displayed in the dialog box. If the value is NULL,
 * MQL5\\Files is displayed in the dialog.
 * @param filter Extension filter of the files to be displayed in the selection
 * dialog window. Files of other formats are hidden.
 * @param flags Combination of flags defining the dialog window mode.
 * @param filenames Array of strings the names of selected files/folders are
 * placed to.
 * @param default_filename Default file/folder name. If specified, a name is
 * automatically added to the open dialog and returned in the filenames[] array
 * when testing.
 * @returns In case of a successful completion, the function returns the number
 * of selected files whose names can be obtained in filenames[]. If a user
 * closes the dialog without selecting a file, the function returns 0. In case
 * of unsuccessful execution, a value less than 0 is returned. The error code
 * can be obtained using GetLastError().
 */
int FileSelectDialog(string caption, string initial_dir, string filter,
                     uint flags, string filenames[], string default_filename);

/**
 * The function starts the search of files or subdirectories in a directory in
 * accordance with the specified filter.
 *
 * @param file_filter Search filter. A subdirectory (or sequence of nested
 * subdirectories) relative to the \\Files directory, in which files should be
 * searched for, can be specified in the filter.
 * @param returned_filename The returned parameter, where, in case of success,
 * the name of the first found file or subdirectory is placed. Only the file
 * name is returned (including the extension), the directories and
 * subdirectories are not included no matter if they are specified or not in the
 * search filter.
 * @param common_flag Flag determining the location of the file. If common_flag
 * = FILE_COMMON, then the file is located in a shared folder for all client
 * terminals \\Terminal\\Common\\Files. Otherwise, the file is located in a
 * local folder.
 * @returns Returns handle of the object searched, which should be used for
 * further sorting of files and subdirectories by the FileFindNext() function,
 * or INVALID_HANDLE when there is no file and subdirectory corresponding to the
 * filter (in the particular case - when the directory is empty). After
 * searching, the handle must be closed using the FileFindClose() function.
 */
long FileFindFirst(const string file_filter, string &returned_filename,
                   int common_flag = 0);

/**
 * The function continues the search started by FileFindFirst().
 *
 * @param search_handle Search handle, retrieved by FileFindFirst().
 * @param returned_filename The name of the next file or subdirectory found.
 * Only the file name is returned (including the extension), the directories and
 * subdirectories are not included no matter if they are specified or not in the
 * search filter.
 * @returns If successful returns true, otherwise false.
 */
bool FileFindNext(long search_handle, string &returned_filename);

/**
 * The function closes the search handle.
 *
 * @param search_handle Search handle, retrieved by FileFindFirst().
 * @returns No value returned.
 */
void FileFindClose(long search_handle);

/**
 * Checks the existence of a file.
 *
 * @param file_name The name of the file being checked
 * @param common_flag Flag determining the location of the file. If common_flag
 * = FILE_COMMON, then the file is located in a shared folder for all client
 * terminals \\Terminal\\Common\\Files. Otherwise, the file is located in a
 * local folder.
 * @returns Returns true, if the specified file exists.
 */
bool FileIsExist(const string file_name, int common_flag = 0);

/**
 * The function opens the file with the specified name and flag.
 *
 * @param file_name The name of the file can contain subfolders. If the file is
 * opened for writing, these subfolders will be created if there are no such
 * ones.
 * @param open_flags combination of flags determining the operation mode for the
 * file.
 * @param delimiter value to be used as a separator in txt or csv-file. If the
 * csv-file delimiter is not specified, it defaults to a tab. If the txt-file
 * delimiter is not specified, then no separator is used. If the separator is
 * clearly set to 0, then no separator is used.
 * @param codepage The value of the code page. For the most-used code pages
 * provide appropriate constants.
 * @returns If a file has been opened successfully, the function returns the
 * file handle, which is then used to access the file data. In case of failure
 * returns INVALID_HANDLE.
 */
int FileOpen(string file_name, int open_flags, short delimiter = '\t',
             uint codepage = CP_ACP);

/**
 * Close the file previously opened by FileOpen().
 *
 * @param file_handle File descriptor returned by FileOpen().
 */
void FileClose(int file_handle);

/**
 * The function copies the original file from a local or shared folder to
 * another file.
 *
 * @param src_file_name File name to copy.
 * @param common_flag Flag determining the location of the file. If common_flag
 * = FILE_COMMON, then the file is located in a shared folder for all client
 * terminals \\Terminal\\Common\\Files. Otherwise, the file is located in a
 * local folder (for example, common_flag=0).
 * @param dst_file_name Result file name.
 * @param mode_flags Access flags. The parameter can contain only 2 flags:
 * FILE_REWRITE and/or FILE_COMMON - other flags are ignored. If the file
 * already exists, and the FILE_REWRITE flag hasn't been specified, then the
 * file will not be rewritten, and the function will return false.
 * @returns In case of failure the function returns false.
 */
bool FileCopy(const string src_file_name, int common_flag,
              const string dst_file_name, int mode_flags);

/**
 * Deletes the specified file in a local folder of the client terminal.
 *
 * @param file_name File name.
 * @param common_flag Flag determining the file location. If common_flag =
 * FILE_COMMON, then the file is located in a shared folder for all client
 * terminals \\Terminal\\Common\\Files. Otherwise, the file is located in a
 * local folder.
 * @returns In case of failure the function returns false.
 */
bool FileDelete(const string file_name, int common_flag = 0);

/**
 * Moves a file from a local or shared folder to another folder.
 *
 * @param src_file_name File name to move/rename.
 * @param common_flag Flag determining the location of the file. If common_flag
 * = FILE_COMMON, then the file is located in a shared folder for all client
 * terminals \\Terminal\\Common\\Files. Otherwise, the file is located in a
 * local folder (common_flag=0).
 * @param dst_file_name File name after operation
 * @param mode_flags Access flags. The parameter can contain only 2 flags:
 * FILE_REWRITE and/or FILE_COMMON - other flags are ignored. If the file
 * already exists and the FILE_REWRITE flag isn't specified, the file will not
 * be rewritten, and the function will return false.
 * @returns In case of failure the function returns false.
 */
bool FileMove(const string src_file_name, int common_flag,
              const string dst_file_name, int mode_flags);

/**
 * Writes to a disk all data remaining in the input/output file buffer.
 *
 * @param file_handle File descriptor returned by FileOpen().
 */
void FileFlush(int file_handle);

/**
 * Gets an integer property of a file. There are two variants of the function.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param file_name File name.
 * @param property_id File property ID. The value can be one of the values of
 * the ENUM_FILE_PROPERTY_INTEGER enumeration. If the second variant of the
 * function is used, you can receive only the values of the following
 * properties: FILE_EXISTS, FILE_CREATE_DATE, FILE_MODIFY_DATE, FILE_ACCESS_DATE
 * and FILE_SIZE.
 * @param common_folder Points to the file location. If the parameter is false,
 * terminal data folder is viewed. Otherwise it is assumed that the file is in
 * the shared folder of all terminals \\Terminal\\Common\\Files (FILE_COMMON).
 * @returns The value of the property. In case of an error, -1 is returned. To
 * get an error code use the GetLastError() function.
 */
long FileGetInteger(int file_handle, ENUM_FILE_PROPERTY_INTEGER property_id);
long FileGetInteger(const string file_name,
                    ENUM_FILE_PROPERTY_INTEGER property_id,
                    bool common_folder = false);

/**
 * Defines the end of a file in the process of reading.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns The function returns true if the file end has been reached in the
 * process of reading or moving of the file pointer.
 */
bool FileIsEnding(int file_handle);

/**
 * Defines the line end in a text file in the process of reading.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns Returns true if in the process of reading txt or csv-file reached
 * the end of the line (the characters CR-LF).
 */
bool FileIsLineEnding(int file_handle);

/**
 * Reads from a file of BIN type arrays of any type except string (may be an
 * array of structures, not containing strings, and dynamic arrays).
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param array An array where the data will be loaded.
 * @param start Start position to read from the array.
 * @param count Number of elements to read. By default, reads the entire array
 * (count=WHOLE_ARRAY).
 * @returns Number of elements read.
 */
template <typename T>
uint FileReadArray(int file_handle, T array[], int start = 0,
                   int count = WHOLE_ARRAY);

/**
 * Reads from the file of CSV type string from the current position to a
 * delimiter (or till the end of the text line) and converts the read string to
 * a bool type value.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns Line read may be set to "true", "false" or the symbolic
 * representation of integers "0" or "1". A nonzero value is converted to a
 * logical true. The function returns the converted value.
 */
bool FileReadBool(int file_handle);

/**
 * Reads from the file of CSV type a string of one of the formats: "YYYY.MM.DD
 * HH:MI:SS", "YYYY.MM.DD" or "HH:MI:SS" - and converts it into a value of
 * datetime type.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns The value of datetime type.
 */
datetime FileReadDatetime(int file_handle);

/**
 * Reads from the file of CSV type a string of one of the formats: "YYYY.MM.DD
 * HH:MI:SS", "YYYY.MM.DD" or "HH:MI:SS" - and converts it into a value of
 * datetime type.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns The value of datetime type.
 */
datetime FileReadDatetime(int file_handle);

/**
 * Reads from the file of CSV type a string of one of the formats: "YYYY.MM.DD
 * HH:MI:SS", "YYYY.MM.DD" or "HH:MI:SS" - and converts it into a value of
 * datetime type.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns The value of datetime type.
 */
datetime FileReadDatetime(int file_handle);

/**
 * The function reads int, short or char value from the current position of the
 * file pointer depending on the length specified in bytes.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param size Number of bytes (up to 4 inclusive) that should be read. The
 * corresponding constants are provided: CHAR_VALUE = 1, SHORT_VALUE = 2 and
 * INT_VALUE = 4, so the function can read the whole value of char, short or int
 * type.
 * @returns A value of the int type. The result of this function must be
 * explicitly cast to a target type, i.e. to the type of data that you need to
 * read. Since a value of the int type is returned, it can be easily converted
 * to any integer value. The file pointer is shifted by the number of bytes
 * read.
 */
int FileReadInteger(int file_handle, int size = INT_VALUE);

/**
 * The function reads an integer of long type (8 bytes) from the current
 * position of the binary file.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns The value of long type.
 */
long FileReadLong(int file_handle);

/**
 * The function reads from the CSV file a string from the current position till
 * a separator (or till the end of a text string) and converts the read string
 * to a value of double type.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns The value of double type.
 */
double FileReadNumber(int file_handle);

/**
 * The function reads a string from the current position of a file pointer in a
 * file.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param length Number of characters to read.
 * @returns Line read (string).
 */
string FileReadString(int file_handle, int length = -1);

/**
 * The function reads contents into a structure passed as a parameter from a
 * binary-file, starting with the current position of the file pointer.
 *
 * @param file_handle File descriptor of an open bin-file.
 * @param struct_object The object of this structure. The structure should not
 * contain strings, dynamic arrays or virtual functions.
 * @param size Number of bytes that should be read. If size is not specified or
 * the indicated value is greater than the size of the structure, the exact size
 * of the specified structure is used.
 * @returns If successful the function returns the number of bytes read. File
 * pointer is moved by the same number of bytes.
 */
template <typename T>
uint FileReadStruct(int file_handle, const T struct_object, int size = -1);

/**
 * The function moves the position of the file pointer by a specified number of
 * bytes relative to the specified position.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param offset The shift in bytes (may take a negative value).
 * @param origin The starting point for the displacement. Can be one of values
 * of ENUM_FILE_POSITION.
 * @returns If successful the function returns true, otherwise false. To obtain
 * information about the error call the GetLastError() function.
 */
bool FileSeek(int file_handle, long offset, ENUM_FILE_POSITION origin);

/**
 * The function returns the file size in bytes.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns The value of type int.
 */
ulong FileSize(int file_handle);

/**
 * The file returns the current position of the file pointer of an open file.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @returns Current position of the file descriptor in bytes from the beginning
 * of the file.
 */
ulong FileTell(int file_handle);

/**
 * The function is intended for writing of data into a CSV file, delimiter being
 * inserted automatically unless it is equal to 0. After writing into the file,
 * the line end character "\r\n" will be added.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param ... The list of parameters separated by commas, to write to the file.
 * The number of written parameters can be up to 63.
 * @returns Number of bytes written.
 */
uint FileWrite(int file_handle, ...);

/**
 * The function writes arrays of any type except for string to a BIN file (can
 * be an array of structures not containing strings or dynamic arrays).
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param array Array for recording.
 * @param start Initial index in the array (number of the first recorded
 * element).
 * @param count Number of items to write (WHOLE_ARRAY means that all items
 * starting with the number start until the end of the array will be written).
 * @returns Number of recorded items.
 */
template <typename T>
uint FileWriteArray(int file_handle, const T array[], int start = 0,
                    int count = WHOLE_ARRAY);

/**
 * The function writes the value of a double parameter to a a bin-file, starting
 * from the current position of the file pointer.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param value The value of double type.
 * @returns If successful the function returns the number of bytes written (in
 * this case sizeof(double)=8). The file pointer is shifted by the same number
 * of bytes.
 */
uint FileWriteDouble(int file_handle, double value);

/**
 * The function writes the value of the float parameter to a bin-file, starting
 * from the current position of the file pointer.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param value The value of float type.
 * @returns If successful the function returns the number of bytes written (in
 * this case sizeof(float)=4). The file pointer is shifted by the same number of
 * bytes.
 */
uint FileWriteFloat(int file_handle, float value);

/**
 * The function writes the value of the int parameter to a bin-file, starting
 * from the current position of the file pointer.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param value Integer value.
 * @param size Number of bytes (up to 4 inclusive), that should be written. The
 * corresponding constants are provided: CHAR_VALUE=1, SHORT_VALUE=2 and
 * INT_VALUE=4, so the function can write the integer value of char, uchar,
 * short, ushort, int, or uint type.
 * @returns If successful the function returns the number of bytes written. The
 * file pointer is shifted by the same number of bytes.
 */
uint FileWriteInteger(int file_handle, int value, int size = INT_VALUE);

/**
 * The function writes the value of the long-type parameter to a bin-file,
 * starting from the current position of the file pointer.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param value Value of type long.
 * @returns If successful the function returns the number of bytes written (in
 * this case sizeof(long)=8). The file pointer is shifted by the same number of
 * bytes.
 */
uint FileWriteLong(int file_handle, long value);

/**
 * The function writes the value of a string-type parameter into a BIN, CSV or
 * TXT file starting from the current position of the file pointer. When writing
 * to a CSV or TXT file: if there is a symbol in the string '\n' (LF) without
 * previous character '\r' (CR), then before '\n' the missing '\r' is added.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param text_string String.
 * @param length The number of characters that you want to write. This option is
 * needed for writing a string into a BIN file. If the size is not specified,
 * then the entire string without the trailer 0 is written. If you specify a
 * size smaller than the length of the string, then a part of the string without
 * the trailer 0 is written. If you specify a size greater than the length of
 * the string, the string is filled by the appropriate number of zeros. For
 * files of CSV and TXT type, this parameter is ignored and the string is
 * written entirely.
 * @returns If successful the function returns the number of bytes written. The
 * file pointer is shifted by the same number of bytes.
 */
uint FileWriteString(int file_handle, const string text_string,
                     int length = -1);

/**
 * The function writes into a bin-file contents of a structure passed as a
 * parameter, starting from the current position of the file pointer.
 *
 * @param file_handle File descriptor returned by FileOpen().
 * @param struct_object Reference to the object of this structure. The structure
 * should not contain strings, dynamic arrays or virtual functions.
 * @param size Number of bytes that you want to record. If size is not specified
 * or the specified number of bytes is greater than the size of the structure,
 * the entire structure is written.
 * @returns If successful the function returns the number of bytes written. The
 * file pointer is shifted by the same number of bytes.
 */
template <typename T>
uint FileWriteStruct(int file_handle, const T struct_object, int size = -1);

/**
 * Reads all data of a specified binary file into a passed array of numeric
 * types or simple structures. The function allows you to quickly read data of a
 * known type into the appropriate array.
 *
 * @param file_name The name of the file from which data will be read.
 * @param buffer An array of numeric types or simple structures.
 * @param common_flag A file flag indicating the operation mode. If the
 * parameter is not specified, the file is searched in the subfolder MQL5\\Files
 * (or in <testing_agent_directory>\\MQL5\\Files in case of testing).
 * @returns The number of elements read or -1 in case of an error.
 */
template <typename T>
long FileLoad(const string file_name, T buffer[], int common_flag = 0);

/**
 * Writes to a binary file all elements of an array passed as a parameter. The
 * function allows you to quickly write arrays of numeric types or simple
 * structures as one string.
 *
 * @param file_name The name of the file, to the data array will be written.
 * @param buffer An array of numeric types or simple structures.
 * @param common_flag A file flag indicating the operation mode. If the
 * parameter is not specified, the file will be written to the subfolder
 * MQL5\\Files (or to <testing_agent_directory>\\MQL5\\Files in case of
 * testing).
 * @returns In case of failure returns false.
 */
template <typename T>
bool FileSave(const string file_name, T buffer[], int common_flag = 0);

/**
 * Creates a directory in the Files folder (depending on the common_flag value)
 *
 * @param folder_name Name of the directory to be created. Contains the relative
 * path to the folder.
 * @param common_flag Flag defining the directory location. If
 * common_flag=FILE_COMMON, the directory is located in the common folder of all
 * client terminals \\Terminal\\Common\\Files. Otherwise, the directory is in
 * the local folder (MQL5\\Files or MQL5\\Tester\\Files when testing).
 * @returns Returns true if successful, otherwise false.
 */
bool FolderCreate(string folder_name, int common_flag = 0);

/**
 * The function removes the specified directory. If the folder is not empty,
 * then it can't be removed.
 *
 * @param folder_name The name of the directory you want to delete. Contains the
 * full path to the folder.
 * @param common_flag Flag determining the location of the directory. If
 * common_flag=FILE_COMMON, then the directory is in the shared folder for all
 * client terminals \\Terminal\\Common\\Files. Otherwise, the directory is in a
 * local folder (MQL5\\Files or MQL5\\Tester\\Files in the case of testing).
 * @returns Returns true if successful, otherwise false.
 */
bool FolderDelete(string folder_name, int common_flag = 0);

/**
 * The function deletes all files in a specified folder.
 *
 * @param folder_name The name of the directory where you want to delete all
 * files. Contains the full path to the folder.
 * @param common_flag Flag determining the location of the directory. If
 * common_flag = FILE_COMMON, then the directory is in the shared folder for all
 * client terminals \\Terminal\\Common\\Files. Otherwise, the directory is in a
 * local folder(MQL5\\Files or MQL5\\Tester\\Files in case of testing).
 * @returns Returns true if successful, otherwise false.
 */
bool FolderClean(string folder_name, int common_flag = 0);

/**
 * Checks the existence of a global variable with the specified name
 *
 * @param name Global variable name.
 * @returns Returns true, if the global variable exists, otherwise returns
 * false.
 */
bool GlobalVariableCheck(string name);

/**
 * Returns the time when the global variable was last accessed.
 *
 * @param name Name of the global variable.
 * @returns The function returns time of last accessing the specified global
 * variable. Addressing a variable for its value, for example using the
 * GlobalVariableGet() and GlobalVariableCheck() functions, also modifies the
 * time of last access. In order to obtain error details, call the
 * GetLastError() function.
 */
datetime GlobalVariableTime(string name);

/**
 * Deletes a global variable from the client terminal.
 *
 * @param name Global variable name.
 * @returns If successful, the function returns true, otherwise it returns
 * false. To obtain an information about the error it is necessary to call the
 * function GetLastError().
 */
bool GlobalVariableDel(string name);

/**
 * Returns the value of an existing global variable of the client terminal.
 * There are 2 variants of the function.
 *
 * @param name Global variable name.
 * @param double_var Target variable of the double type, which accepts the value
 * stored in a the global variable of the client terminal.
 * @returns The value of the existing global variable or 0 in case of an error.
 * For more details about the error, call GetLastError().
 */
double GlobalVariableGet(string name);
bool GlobalVariableGet(string name, double &double_var);

/**
 * Returns the name of a global variable by its ordinal number.
 *
 * @param index Sequence number in the list of global variables. It should be
 * greater than or equal to 0 and less than GlobalVariablesTotal().
 * @returns Global variable name by its ordinal number in the list of global
 * variables. For more details about the error, call GetLastError().
 */
string GlobalVariableName(int index);

/**
 * Sets a new value for a global variable. If the variable does not exist, the
 * system creates a new global variable.
 *
 * @param name Global variable name.
 * @param value The new numerical value.
 * @returns If successful, the function returns the last modification time,
 * otherwise 0. For more details about the error, call GetLastError().
 */
datetime GlobalVariableSet(string name, double value);

/**
 * Forcibly saves contents of all global variables to a disk.
 */
void GlobalVariablesFlush();

/**
 * The function attempts to create a temporary global variable. If the variable
 * doesn't exist, the system creates a new temporary global variable.
 *
 * @param name The name of a temporary global variable.
 * @returns If successful, the function returns true, otherwise - false. To get
 * details about the error, you should call the GetLastError() function.
 */
bool GlobalVariableTemp(string name);

/**
 * Sets the new value of the existing global variable if the current value
 * equals to the third parameter check_value. If there is no global variable,
 * the function will generate an error ERR_GLOBALVARIABLE_NOT_FOUND (4501) and
 * return false.
 *
 * @param name The name of a global variable.
 * @param value New value.
 * @param check_value The value to check the current value of the global
 * variable.
 * @returns If successful, the function returns true, otherwise it returns
 * false. For details about the error call GetLastError(). If the current value
 * of the global variable is different from check_value, the function returns
 * false.
 */
bool GlobalVariableSetOnCondition(string name, double value,
                                  double check_value);

/**
 * Deletes global variables of the client terminal.
 *
 * @param prefix_name Name prefix global variables to remove. If you specify a
 * prefix NULL or empty string, then all variables that meet the data criterion
 * will be deleted.
 * @param limit_data Date to select global variables by the time of their last
 * modification. The function removes global variables, which were changed
 * before this date. If the parameter is zero, then all variables that meet the
 * first criterion (prefix) are deleted.
 * @returns The number of deleted variables.
 */
int GlobalVariablesDeleteAll(string prefix_name, datetime limit_data);

/**
 * Returns the total number of global variables of the client terminal.
 *
 * @returns Number of global variables.
 */
int GlobalVariablesTotal();

/**
 * Returns the number of bars of a corresponding symbol and period, available in
 * history.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @returns The number of bars of a corresponding symbol and period, available
 * in history, but no more than allowed by the "Max bars in chart" parameter in
 * platform settings.
 */
int iBars(const string symbol, ENUM_TIMEFRAMES timeframe);

/**
 * Search bar by time. The function returns the index of the bar corresponding
 * to the specified time.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. PERIOD_CURRENT means the current chart period.
 * @param time Time value to search for.
 * @param exact A return value, in case the bar with the specified time is not
 * found. If exact=false, iBarShift returns the index of the nearest bar, the
 * Open time of which is less than the specified time (time_open<time). If such
 * a bar is not found (history before the specified time is not available), then
 * the function returns -1. If exact=true, iBarShift does not search for a
 * nearest bar but immediately returns -1.
 * @returns The index of the bar corresponding to the specified time. If the bar
 * corresponding to the specified time is not found (there is a gap in the
 * history), the function returns -1 or the index of the nearest bar (depending
 * on the 'exact' parameter).
 */
int iBarShift(const string symbol, ENUM_TIMEFRAMES timeframe, datetime time,
              bool exact = false);

/**
 * Returns the Close price of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The Close price of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
double iClose(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the Close price of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The Close price of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
double iClose(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the index of the highest value found on the corresponding chart
 * (shift relative to the current bar).
 *
 * @param symbol The symbol, on which the search will be performed. NULL means
 * the current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param type The identifier of the timeseries, in which the search will be
 * performed. Can be equal to any value from ENUM_SERIESMODE.
 * @param count The number of elements in the timeseries (from the current bar
 * towards index increasing direction), among which the search should be
 * performed.
 * @param start The index (shift relative to the current bar) of the initial
 * bar, from which search for the highest value begins. Negative values
 * ​​are ignored and replaced with a zero value.
 * @returns The index of the highest value found on the corresponding chart
 * (shift relative to the current bar) or -1 in case of an error. For error
 * details, call the GetLastError() function.
 */
int iHighest(const string symbol, ENUM_TIMEFRAMES timeframe,
             ENUM_SERIESMODE type, int count = WHOLE_ARRAY, int start = 0);

/**
 * Returns the Low price of the bar (indicated by the 'shift' parameter) on the
 * corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The Low price of the bar (indicated by the 'shift' parameter) on the
 * corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
double iLow(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the index of the smallest value found on the corresponding chart
 * (shift relative to the current bar).
 *
 * @param symbol The symbol, on which the search will be performed. NULL means
 * the current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param type The identifier of the timeseries, in which the search will be
 * performed. Can be equal to any value from ENUM_SERIESMODE.
 * @param count The number of elements in the timeseries (from the current bar
 * towards index increasing direction), among which the search should be
 * performed.
 * @param start The index (shift relative to the current bar) of the initial
 * bar, from which search for the lowest value begins. Negative values ​​are
 * ignored and replaced with a zero value.
 * @returns The index of the lowest value found on the corresponding chart
 * (shift relative to the current bar) or -1 in case of an error. For error
 * details, call the GetLastError() function.
 */
int iLowest(const string symbol, ENUM_TIMEFRAMES timeframe,
            ENUM_SERIESMODE type, int count = WHOLE_ARRAY, int start = 0);

/**
 * Returns the Open price of the bar (indicated by the 'shift' parameter) on the
 * corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The Open price of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
double iOpen(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the opening time of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The opening time of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
datetime iTime(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the tick volume of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The tick volume of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
long iTickVolume(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the real volume of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The real volume of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
long iRealVolume(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the tick volume of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The tick volume of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
long iVolume(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the spread value of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart.
 *
 * @param symbol The symbol name of the financial instrument. NULL means the
 * current symbol.
 * @param timeframe Period. It can be one of the values of the ENUM_TIMEFRAMES
 * enumeration. 0 means the current chart period.
 * @param shift The index of the received value from the timeseries (backward
 * shift by specified number of bars relative to the current bar).
 * @returns The Spread value of the bar (indicated by the 'shift' parameter) on
 * the corresponding chart or 0 in case of an error. For error details, call the
 * GetLastError() function.
 */
long iSpread(const string symbol, ENUM_TIMEFRAMES timeframe, int shift);

/**
 * Returns the number of available (selected in Market Watch or all) symbols.
 *
 * @param selected Request mode. Can be true or false.
 * @returns If the 'selected' parameter is true, the function returns the number
 * of symbols selected in MarketWatch. If the value is false, it returns the
 * total number of all symbols.
 */
int SymbolsTotal(bool selected);

/**
 * Checks if a symbol with a specified name exists.
 *
 * @param name Symbol name.
 * @param is_custom Custom symbol property set upon successful execution. If
 * true, the detected symbol is a custom one.
 * @returns If false, the symbol is not found among standard and custom ones.
 */
bool SymbolExist(const string name, bool &is_custom);

/**
 * Returns the name of a symbol.
 *
 * @param pos Order number of a symbol.
 * @param selected Request mode. If the value is true, the symbol is taken from
 * the list of symbols selected in MarketWatch. If the value is false, the
 * symbol is taken from the general list.
 * @returns Value of string type with the symbol name.
 */
string SymbolName(int pos, bool selected);

/**
 * Selects a symbol in the Market Watch window or removes a symbol from the
 * window.
 *
 * @param name Symbol name.
 * @param select Switch. If the value is false, a symbol should be removed from
 * MarketWatch, otherwise a symbol should be selected in this window. A symbol
 * can't be removed if the symbol chart is open, or there are open positions for
 * this symbol.
 * @returns In case of failure returns false.
 */
bool SymbolSelect(string name, bool select);

/**
 * The function checks whether data of a selected symbol in the terminal are
 * synchronized with data on the trade server.
 *
 * @param name Symbol name.
 * @returns If data are synchronized, returns 'true'; otherwise returns 'false'.
 */
bool SymbolIsSynchronized(string name);

/**
 * Returns the corresponding property of a specified symbol. There are 2
 * variants of the function.
 *
 * @param name Symbol name.
 * @param prop_id Identifier of a symbol property. The value can be one of the
 * values of the ENUM_SYMBOL_INFO_DOUBLE enumeration.
 * @param double_var Variable of double type receiving the value of the
 * requested property.
 * @returns The value of double type. In case of execution failure, information
 * about the error can be obtained using GetLastError() function:
 */
double SymbolInfoDouble(string name, ENUM_SYMBOL_INFO_DOUBLE prop_id);
bool SymbolInfoDouble(string name, ENUM_SYMBOL_INFO_DOUBLE prop_id,
                      double &double_var);

/**
 * Returns the corresponding property of a specified symbol. There are 2
 * variants of the function.
 *
 * @param name Symbol name.
 * @param prop_id Identifier of a symbol property. The value can be one of the
 * values of the ENUM_SYMBOL_INFO_INTEGER enumeration.
 * @param long_var Variable of the long type receiving the value of the
 * requested property.
 * @returns The value of long type. In case of execution failure, information
 * about the error can be obtained using GetLastError() function:
 */
long SymbolInfoInteger(string name, ENUM_SYMBOL_INFO_INTEGER prop_id);
bool SymbolInfoInteger(string name, ENUM_SYMBOL_INFO_INTEGER prop_id,
                       long &long_var);

/**
 * Returns the corresponding property of a specified symbol. There are 2
 * variants of the function.
 *
 * @param name Symbol name.
 * @param prop_id Identifier of a symbol property. The value can be one of the
 * values of the ENUM_SYMBOL_INFO_STRING enumeration.
 * @param string_var Variable of the string type receiving the value of the
 * requested property.
 * @returns The value of string type. In case of execution failure, information
 * about the error can be obtained using GetLastError() function:
 */
string SymbolInfoString(string name, ENUM_SYMBOL_INFO_STRING prop_id);
bool SymbolInfoString(string name, ENUM_SYMBOL_INFO_STRING prop_id,
                      string &string_var);

/**
 * Returns the margin rates depending on the order type and direction.
 *
 * @param name Symbol name.
 * @param order_type Order type.
 * @param initial_margin_rate A double type variable for receiving an initial
 * margin rate. Initial margin is a security deposit for 1 lot deal in the
 * appropriate direction. Multiplying the rate by the initial margin, we receive
 * the amount of funds to be reserved on the account when placing an order of
 * the specified type.
 * @param maintenance_margin_rate A double type variable for receiving a
 * maintenance margin rate. Maintenance margin is a minimum amount for
 * maintaining an open position of 1 lot in the appropriate direction.
 * Multiplying the rate by the maintenance margin, we receive the amount of
 * funds to be reserved on the account after an order of the specified type is
 * activated.
 * @returns Returns true if request for properties is successful, otherwise
 * false.
 */
bool SymbolInfoMarginRate(string name, ENUM_ORDER_TYPE order_type,
                          double &initial_margin_rate,
                          double &maintenance_margin_rate);

/**
 * The function returns current prices of a specified symbol in a variable of
 * the MqlTick type.
 *
 * @param symbol Symbol name.
 * @param tick Link to the structure of the MqlTick type, to which the current
 * prices and time of the last price update will be placed.
 * @returns The function returns true if successful, otherwise returns false.
 */
bool SymbolInfoTick(string symbol, MqlTick &tick);

/**
 * Allows receiving time of beginning and end of the specified quoting sessions
 * for a specified symbol and day of week.
 *
 * @param name Symbol name.
 * @param ENUM_DAY_OF_WEEK Day of the week, value of enumeration
 * ENUM_DAY_OF_WEEK.
 * @param uint Ordinal number of a session, whose beginning and end time we want
 * to receive. Indexing of sessions starts with 0.
 * @param from Session beginning time in seconds from 00 hours 00 minutes, in
 * the returned value date should be ignored.
 * @param to Session end time in seconds from 00 hours 00 minutes, in the
 * returned value date should be ignored.
 * @returns If data for the specified session, symbol and day of the week are
 * received, returns true, otherwise returns false.
 */
bool SymbolInfoSessionQuote(string name, ENUM_DAY_OF_WEEK day_of_week,
                            uint session_index, datetime &from, datetime &to);

/**
 * Allows receiving time of beginning and end of the specified trading sessions
 * for a specified symbol and day of week.
 *
 * @param name Symbol name.
 * @param ENUM_DAY_OF_WEEK Day of the week, value of enumeration
 * ENUM_DAY_OF_WEEK.
 * @param uint Ordinal number of a session, whose beginning and end time we want
 * to receive. Indexing of sessions starts with 0.
 * @param from Session beginning time in seconds from 00 hours 00 minutes, in
 * the returned value date should be ignored.
 * @param to Session end time in seconds from 00 hours 00 minutes, in the
 * returned value date should be ignored.
 * @returns If data for the specified session, symbol and day of the week are
 * received, returns true, otherwise returns false.
 */
bool SymbolInfoSessionTrade(string name, ENUM_DAY_OF_WEEK day_of_week,
                            uint session_index, datetime &from, datetime &to);

/**
 * Provides opening of Depth of Market for a selected symbol, and subscribes for
 * receiving notifications of the DOM changes.
 *
 * @param symbol The name of a symbol, whose Depth of Market is to be used in
 * the Expert Advisor or script.
 * @returns The true value if opened successfully, otherwise false.
 */
bool MarketBookAdd(string symbol);

/**
 * Provides closing of Depth of Market for a selected symbol, and cancels the
 * subscription for receiving notifications of the DOM changes.
 *
 * @param symbol Symbol name.
 * @returns The true value if closed successfully, otherwise false.
 */
bool MarketBookRelease(string symbol);

/**
 * Returns a structure array MqlBookInfo containing records of the Depth of
 * Market of a specified symbol.
 *
 * @param symbol Symbol name.
 * @param book Reference to an array of Depth of Market records. The array can
 * be pre-allocated for a sufficient number of records. If a dynamic array
 * hasn't been pre-allocated in the operating memory, the client terminal will
 * distribute the array itself.
 * @returns Returns true in case of success, otherwise false.
 */
bool MarketBookGet(string symbol, MqlBookInfo book[]);

/**
 * The function returns the absolute value (modulus) of the specified numeric
 * value.
 *
 * @param value Numeric value.
 * @returns Value of double type more than or equal to zero.
 */
double MathAbs(double value);

/**
 * The function returns the arccosine of x within the range 0 to π in radians.
 *
 * @param val The val value between -1 and 1, the arc cosine of which is to be
 * calculated.
 * @returns Arc cosine of a number in radians. If val is less than -1 or more
 * than 1, the function returns NaN (indeterminate value).
 */
double MathArccos(double val);

/**
 * The function returns the arc sine of x within the range of -π/2 to π/2
 * radians.
 *
 * @param val The val value between -1 and 1, the arc sine of which is to be
 * calculated.
 * @returns Arc sine of the val number in radians within the range of -π/2 to
 * π/2 radians. If val is less than -1 or more than 1, the function returns NaN
 * (indeterminate value).
 */
double MathArcsin(double val);

/**
 * The function returns the arc tangent of x. If x is equal to 0, the function
 * returns 0.
 *
 * @param value A number representing a tangent.
 * @returns MathArctan returns a value within the range of -π/2 to π/2 radians.
 */
double MathArctan(double value);

/**
 * Return the angle (in radians) whose tangent is the quotient of two specified
 * numbers.
 *
 * @param y Y coordinate value.
 * @param x X coordinate value.
 * @returns MathArctan2 returns an angle, θ, within the range from -π to π
 * radians, so that MathTan(θ)=y/x.
 */
double MathArctan2(double y, double x);

/**
 * Determines the type of a real number and returns a result as a value from the
 * ENUM_FP_CLASS enumeration
 *
 * @param value The real number to be checked
 * @returns A value from the ENUM_FP_CLASS enumeration
 */
ENUM_FP_CLASS MathClassify(double value);

/**
 * The function returns integer numeric value closest from above.
 *
 * @param val Numeric value.
 * @returns Numeric value representing the smallest integer that exceeds or
 * equals to val.
 */
double MathCeil(double val);

/**
 * The function returns the cosine of an angle.
 *
 * @param value Angle in radians.
 * @returns Value of double type within the range of -1 to 1.
 */
double MathCos(double value);

/**
 * The function returns the value of e raised to the power of d.
 *
 * @param value A number specifying the power.
 * @returns A number of double type. In case of overflow the function returns
 * INF (infinity), in case of underflow MathExp returns 0.
 */
double MathExp(double value);

/**
 * The function returns integer numeric value closest from below.
 *
 * @param val Numeric value.
 * @returns A numeric value representing the largest integer that is less than
 * or equal to val.
 */
double MathFloor(double val);

/**
 * The function returns a natural logarithm.
 *
 * @param val Value logarithm of which is to be found.
 * @returns The natural logarithm of val in case of success. If val is negative,
 * the function returns NaN (undetermined value). If val is equal to 0, the
 * function returns INF (infinity).
 */
double MathLog(double val);

/**
 * Returns the logarithm of a number by base 10.
 *
 * @param val Numeric value the common logarithm of which is to be calculated.
 * @returns The common logarithm in case of success. If val is negative, the
 * function returns NaN (undetermined value). If val is equal to 0, the function
 * returns INF (infinity).
 */
double MathLog10(double val);

/**
 * The function returns the maximal value of two values.
 *
 * @param value1 First numeric value.
 * @param value2 Second numeric value.
 * @returns The largest of the two values.
 */
double MathMax(double value1, double value2);

/**
 * The function returns the minimal value of two values.
 *
 * @param value1 First numeric value.
 * @param value2 Second numeric value.
 * @returns The smallest of the two values.
 */
double MathMin(double value1, double value2);

/**
 * The function returns the real remainder of division of two numbers.
 *
 * @param value Dividend value.
 * @param value2 Divisor value.
 * @returns The MathMod function calculates the real remainder f from expression
 * val/y so that val = i * y + f , where i is an integer, f has the same sign as
 * val, and the absolute value of f is less than the absolute value of y.
 */
double MathMod(double value, double value2);

/**
 * The function raises a base to a specified power.
 *
 * @param base Base.
 * @param exponent Exponent value.
 * @returns Value of base raised to the specified power.
 */
double MathPow(double base, double exponent);

/**
 * Returns a pseudorandom integer within the range of 0 to 32767.
 *
 * @returns Integer value within the range of 0 to 32767.
 */
int MathRand();

/**
 * The function returns a value rounded off to the nearest integer of the
 * specified numeric value.
 *
 * @param value Numeric value before rounding.
 * @returns Value rounded till to the nearest integer.
 */
double MathRound(double value);

/**
 * Returns the sine of a specified angle.
 *
 * @param value Angle in radians.
 * @returns Sine of an angle measured in radians. Returns value within the range
 * of -1 to 1.
 */
double MathSin(double value);

/**
 * Returns the square root of a number.
 *
 * @param value Positive numeric value.
 * @returns Square root of value. If value is negative, MathSqrt returns NaN
 * (indeterminate value).
 */
double MathSqrt(double value);

/**
 * Sets the starting point for generating a series of pseudorandom integers.
 *
 * @param seed Starting number for the sequence of random numbers.
 */
void MathSrand(int seed);

/**
 * The function returns a tangent of a number.
 *
 * @param rad Angle in radians.
 * @returns Tangent of rad. If rad is greater than or equal to 263, or less than
 * or equal to -263, a loss of significance in the result occurs, in which case
 * the function returns an indefinite number.
 */
double MathTan(double rad);

/**
 * It checks the correctness of a real number.
 *
 * @param number Checked numeric value.
 * @returns It returns true, if the checked value is an acceptable real number.
 * If the checked value is a plus or minus infinity, or "not a number" (NaN),
 * the function returns false.
 */
bool MathIsValidNumber(double number);

/**
 * Returns the value of the expression MathExp(x)-1.
 *
 * @param value The number specifying the power.
 * @returns A value of the double type. In case of overflow the function returns
 * INF (infinity), in case of underflow MathExpm1 returns 0.
 */
double MathExpm1(double value);

/**
 * Returns the value of the expression MathLog(1+x).
 *
 * @param value The value, the logarithm of which is to be calculated.
 * @returns The natural logarithm of the value (value + 1) if successful. If
 * value is < -1, the function returns NaN (undefined value). If value is equal
 * to -1, the function returns INF (infinity).
 */
double MathLog1p(double value);

/**
 * Returns the hyperbolic arccosine.
 *
 * @param value The value, the hyperbolic arccosine of which is to be
 * calculated.
 * @returns The hyperbolic arccosine of the number. If value is less than +1,
 * the function returns NaN (undefined value).
 */
double MathArccosh(double value);

/**
 * Returns the hyperbolic arcsine.
 *
 * @param val The value, the hyperbolic arcsine of which is to be calculated.
 * @returns The hyperbolic arcsine of the number.
 */
double MathArcsinh(double value);

/**
 * Returns the hyperbolic arctangent.
 *
 * @param value Number within the range of -1 < value < 1, which represents the
 * tangent.
 * @returns The hyperbolic arctangent of the number.
 */
double MathArctanh(double value);

/**
 * Returns the hyperbolic cosine of the number.
 *
 * @param value Value.
 * @returns The hyperbolic cosine of the number, value within the range of +1 to
 * positive infinity.
 */
double MathCosh(double value);

/**
 * Returns the hyperbolic sine of the number.
 *
 * @param value Value.
 * @returns The hyperbolic sine of the number.
 */
double MathSinh(double value);

/**
 * Returns the hyperbolic tangent of the number.
 *
 * @param value Value.
 * @returns The hyperbolic tangent of the number, value within the range of -1
 * to +1.
 */
double MathTanh(double value);

/**
 * Change the order of bytes in the ushort type value.
 *
 * @param value Value for changing the order of bytes.
 * @returns Value with the reverse byte order.
 */
ushort MathSwap(ushort value);
uint MathSwap(uint value);
ulong MathSwap(ulong value);

/**
 * Create a socket with specified flags and return its handle.
 *
 * @param flags Combination of flags defining the mode of working with a socket.
 * Currently, only one flag is supported — SOCKET_DEFAULT.
 * @returns In case of a successful socket creation, return its handle,
 * otherwise INVALID_HANDLE.
 */
int SocketCreate(uint flags);

/**
 * Close a socket.
 *
 * @param socket Handle of a socket to be closed. The handle is returned by the
 * SocketCreate function. When an incorrect handle is passed, the error 5270
 * (ERR_NETSOCKET_INVALIDHANDLE) is written to _LastError.
 * @returns Returns true if successful, otherwise false.
 */
bool SocketClose(const int socket);

/**
 * Connect to the server with timeout control.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is
 * written to _LastError.
 * @param server Domain name of the server you want to connect to or its IP
 * address.
 * @param port Connection port number.
 * @param timeout_receive_ms Connection timeout in milliseconds. If connection
 * is not established within that time interval, attempts are stopped.
 * @returns If connection is successful, return true, otherwise false.
 */
bool SocketConnect(int socket, const string server, uint port,
                   uint timeout_receive_ms);

/**
 * Checks if the socket is currently connected.
 *
 * @param socket Socket handle returned by the SocketCreate() function. When an
 * incorrect handle is passed to _LastError, the error 5270
 * (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @returns Returns true if the socket is connected, otherwise - false.
 */
bool SocketIsConnected(const int socket);

/**
 * Get a number of bytes that can be read from a socket.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed to _LastError, the error 5270
 * (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @returns Number of bytes that can be read. In case of an error, 0 is
 * returned.
 */
uint SocketIsReadable(const int socket);

/**
 * Check whether data can be written to a socket at the current time.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is
 * written to _LastError.
 * @returns Return true if writing is possible, otherwise false.
 */
bool SocketIsWritable(const int socket);

/**
 * Set timeouts for receiving and sending data for a socket system object.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is
 * written to _LastError.
 * @param timeout_send_ms Data sending timeout in milliseconds.
 * @param timeout_receive_ms Data obtaining timeout in milliseconds.
 * @returns Returns true if successful, otherwise false.
 */
bool SocketTimeouts(int socket, uint timeout_send_ms, uint timeout_receive_ms);

/**
 * Read data from a socket.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed to _LastError, the error 5270
 * (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @param buffer Reference to the uchar type array the data is read in. Dynamic
 * array size is increased by the number of read bytes. The array size cannot
 * exceed INT_MAX (2147483647).
 * @param buffer_maxlen Number of bytes to read to the buffer[] array. Data not
 * fitting into the array remain in the socket. They can be received by the next
 * SocketRead call. buffer_maxlen cannot exceed INT_MAX (2147483647).
 * @param timeout_ms Data reading timeout in milliseconds. If data is not
 * obtained within this time, attempts are stopped and the function returns -1.
 * @returns If successful, return the number of read bytes. In case of an error,
 * -1 is returned.
 */
int SocketRead(int socket, uchar buffer[], uint buffer_maxlen, uint timeout_ms);

/**
 * Write data to a socket.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is
 * written to _LastError.
 * @param buffer Reference to the uchar type array with the data to be sent to
 * the socket.
 * @param buffer_len 'buffer' array size.
 * @returns If successful, return the number of bytes written to a socket. In
 * case of an error, -1 is returned.
 */
int SocketSend(int socket, const uchar buffer[], uint buffer_len);

/**
 * Initiate secure TLS (SSL) connection to a specified host via TLS Handshake
 * protocol. During Handshake, a client and a server agree on connection
 * parameters: applied protocol version and data encryption method.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is
 * written to _LastError.
 * @param host Address of a host a secure connection is established with.
 * @returns Returns true if successful, otherwise false.
 */
bool SocketTlsHandshake(int socket, const string host);

/**
 * Get data on the certificate used to secure network connection.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is
 * written to _LastError.
 * @param subject Certificate owner name. Corresponds to the Subject field.
 * @param issuer Certificate issuer name. Corresponds to the Issuer field.
 * @param serial Certificate serial number. Corresponds to the SerialNumber
 * field.
 * @param thumbprint Certificate print. Corresponds to the SHA-1 hash from the
 * entire certificate file (all fields including the issuer signature).
 * @param expiration Certificate expiration date in the datetime format.
 * @returns Returns true if successful, otherwise false.
 */
int SocketTlsCertificate(int socket, string &subject, string &issuer,
                         string &serial, string &thumbprint,
                         datetime &expiration);

/**
 * Read data from secure TLS connection.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed to _LastError, the error 5270
 * (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @param buffer Reference to the uchar type array the data is read in. Dynamic
 * array size is increased by the number of read bytes. The array size cannot
 * exceed INT_MAX (2147483647).
 * @param buffer_maxlen Number of bytes to read to the buffer[] array. Data not
 * fitting into the array remain in the socket. They can be received by the next
 * SocketTLSRead call. buffer_maxlen cannot exceed INT_MAX (2147483647).
 * @returns If successful, return the number of read bytes. In case of an error,
 * -1 is returned.
 */
int SocketTlsRead(int socket, uchar buffer[], uint buffer_maxlen);

/**
 * Read all available data from secure TLS connection.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed to _LastError, the error 5270
 * (ERR_NETSOCKET_INVALIDHANDLE) is activated.
 * @param buffer Reference to the uchar type array the data is read in. Dynamic
 * array size is increased by the number of read bytes. The array size cannot
 * exceed INT_MAX (2147483647).
 * @param buffer_maxlen Number of bytes to read to the buffer[] array. Data not
 * fitting into the array remain in the socket. They can be received by the next
 * SocketTlsReadAvailable or SocketTlsRead call. buffer_maxlen cannot exceed
 * INT_MAX (2147483647).
 * @returns If successful, return the number of read bytes. In case of an error,
 * -1 is returned.
 */
int SocketTlsReadAvailable(int socket, uchar buffer[],
                           const uint buffer_maxlen);

/**
 * Send data via secure TLS connection.
 *
 * @param socket Socket handle returned by the SocketCreate function. When an
 * incorrect handle is passed, the error 5270 (ERR_NETSOCKET_INVALIDHANDLE) is
 * written to _LastError.
 * @param buffer Reference to the uchar type array with the data to be sent.
 * @param buffer_len 'buffer' array size.
 * @returns If successful, return the number of bytes written to a socket. In
 * case of an error, -1 is returned.
 */
int SocketTlsSend(int socket, const uchar buffer[], uint buffer_len);

/**
 * The function sends an HTTP request to a specified server. The function has
 * two versions:
 *
 * @param method HTTP method.
 * @param url URL.
 * @param headers Request headers of type "key: value", separated by a line
 * break "\\r\\n".
 * @param cookie Cookie value.
 * @param referer Value of the Referer header of the HTTP request.
 * @param timeout Timeout in milliseconds.
 * @param data Data array of the HTTP message body.
 * @param data_size Size of the data[] array.
 * @param result An array containing server response data.
 * @param result_headers Server response headers.
 * @returns HTTP server response code or -1 for an error.
 */
int WebRequest(const string method, const string url, const string cookie,
               const string referer, int timeout, const char data[],
               int data_size, char result[], string &result_headers);
int WebRequest(const string method, const string url, const string headers,
               int timeout, const char data[], char result[],
               string &result_headers);

/**
 * Sends a file at the address, specified in the setting window of the "FTP"
 * tab.
 *
 * @param filename Name of sent file.
 * @param ftp_path FTP catalog. If a directory is not specified, directory
 * described in settings is used.
 * @returns In case of failure returns 'false'.
 */
bool SendFTP(string filename, string ftp_path = NULL);

/**
 * Sends an email at the address specified in the settings window of the "Email"
 * tab.
 *
 * @param subject Email header.
 * @param some_text Email body.
 * @returns true – if an email is put into the send queue, otherwise - false.
 */
bool SendMail(string subject, string some_text);

/**
 * Sends push notifications to the mobile terminals, whose MetaQuotes IDs are
 * specified in the "Notifications" tab.
 *
 * @param text The text of the notification. The message length should not
 * exceed 255 characters.
 * @returns true if a notification has been successfully sent from the terminal;
 * in case of failure returns false. When checking after a failed push of
 * notification, GetLastError () may return one of the following errors:
 *
 * 4515 – ERR_NOTIFICATION_SEND_FAILED,
 * 4516 – ERR_NOTIFICATION_WRONG_PARAMETER,
 * 4517 – ERR_NOTIFICATION_WRONG_SETTINGS,
 * 4518 – ERR_NOTIFICATION_TOO_FREQUENT.
 */
bool SendNotification(string text);

/**
 * The function creates an object with the specified name, type, and the initial
 * coordinates in the specified chart subwindow. During creation up to 30
 * coordinates can be specified.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object. The name must be unique within a chart,
 * including its subwindows.
 * @param type Object type. The value can be one of the values of the
 * ENUM_OBJECT enumeration.
 * @param sub_window Number of the chart subwindow. 0 means the main chart
 * window. The specified subwindow must exist, otherwise the function returns
 * false.
 * @param time1 The time coordinate of the first anchor.
 * @param price1 The price coordinate of the first anchor point.
 * @returns The function returns true if the command has been successfully added
 * to the queue of the specified chart, or false otherwise. If an object has
 * already been created, an attempt is made to change its coordinates.
 */
bool ObjectCreate(long chart_id, string name, ENUM_OBJECT type, int sub_window,
                  datetime time1, double price1, ...);

/**
 * The function returns the name of the corresponding object in the specified
 * chart, in the specified subwindow, of the specified type.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param pos Ordinal number of the object according to the specified filter by
 * the number and type of the subwindow.
 * @param sub_window Number of the chart subwindow. 0 means the main chart
 * window, -1 means all the subwindows of the chart, including the main window.
 * @param type Type of the object. The value can be one of the values of the
 * ENUM_OBJECT enumeration. -1 means all types.
 * @returns Name of the object is returned in case of success.
 */
string ObjectName(long chart_id, int pos, int sub_window = -1, int type = -1);

/**
 * The function removes the object with the specified name from the specified
 * chart.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of object to be deleted.
 * @returns The function returns true if the command has been successfully added
 * to the queue of the specified chart, or false otherwise.
 */
bool ObjectDelete(long chart_id, string name);

/**
 * Removes all objects from the specified chart, specified chart subwindow, of
 * the specified type.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param prefix Prefix in object names. All objects whose names start with this
 * set of characters will be removed from chart. You can specify prefix as
 * 'name' or 'name*' – both variants will work the same. If an empty string is
 * specified as the prefix, objects with all possible names will be removed.
 * @param sub_window Number of the chart subwindow. 0 means the main chart
 * window, -1 means all the subwindows of the chart, including the main window.
 * @param type Type of the object. The value can be one of the values of the
 * ENUM_OBJECT enumeration. -1 means all types.
 * @returns Returns the number of deleted objects. To read more about the error
 * call GetLastError().
 */
int ObjectsDeleteAll(long chart_id, int sub_window = -1, int type = -1);
int ObjectsDeleteAll(long chart_id, const string prefix, int sub_window = -1,
                     int object_type = -1);

/**
 * The function searches for an object with the specified name in the chart with
 * the specified ID.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name The name of the searched object.
 * @returns If successful the function returns the number of the subwindow (0
 * means the main window of the chart), in which the object is found. If the
 * object is not found, the function returns a negative number. To read more
 * about the error call GetLastError().
 */
int ObjectFind(long chart_id, string name);

/**
 * The function returns the time value for the specified price value of the
 * specified object.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param value Price value.
 * @param line_id Line identifier.
 * @returns The time value for the specified price value of the specified
 * object.
 */
datetime ObjectGetTimeByValue(long chart_id, string name, double value,
                              int line_id);

/**
 * The function returns the price value for the specified time value of the
 * specified object.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param time Time value.
 * @param line_id Line ID.
 * @returns The price value for the specified time value of the specified
 * object.
 */
double ObjectGetValueByTime(long chart_id, string name, datetime time,
                            int line_id);

/**
 * The function changes coordinates of the specified anchor point of the object.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param point_index Index of the anchor point. The number of anchor points
 * depends on the type of object.
 * @param price Price coordinate of the selected anchor point.
 * @returns The function returns true if the command has been successfully added
 * to the queue of the specified chart, or false otherwise.
 */
bool ObjectMove(long chart_id, string name, int point_index, datetime time,
                double price);

/**
 * The function returns the number of objects in the specified chart, specified
 * subwindow, of the specified type.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param sub_window Number of the chart subwindow. 0 means the main chart
 * window, -1 means all the subwindows of the chart, including the main window.
 * @param type Type of the object. The value can be one of the values of the
 * ENUM_OBJECT enumeration. -1 means all types.
 * @returns The number of objects.
 */
int ObjectsTotal(long chart_id, int sub_window = -1, int type = -1);

/**
 * The function sets the value of the corresponding object property. The object
 * property must be of the double type. There are 2 variants of the function.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param prop_id ID of the object property. The value can be one of the values
 * of the ENUM_OBJECT_PROPERTY_DOUBLE enumeration.
 * @param prop_modifier Modifier of the specified property. It denotes the
 * number of the level in Fibonacci tools and in the graphical object Andrew's
 * pitchfork. The numeration of levels starts from zero.
 * @param prop_value The value of the property.
 * @returns The function returns true only if the command to change properties
 * of a graphical object has been sent to a chart successfully. Otherwise it
 * returns false. To read more about the error call GetLastError().
 */
bool ObjectSetDouble(long chart_id, string name,
                     ENUM_OBJECT_PROPERTY_DOUBLE prop_id, double prop_value);
bool ObjectSetDouble(long chart_id, string name,
                     ENUM_OBJECT_PROPERTY_DOUBLE prop_id, int prop_modifier,
                     double prop_value);

/**
 * The function sets the value of the corresponding object property. The object
 * property must be of the datetime, int, color, bool or char type. There are 2
 * variants of the function.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param prop_id ID of the object property. The value can be one of the values
 * of the ENUM_OBJECT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier Modifier of the specified property. It denotes the
 * number of the level in Fibonacci tools and in the graphical object Andrew's
 * pitchfork. The numeration of levels starts from zero.
 * @param prop_value The value of the property.
 * @returns The function returns true only if the command to change properties
 * of a graphical object has been sent to a chart successfully. Otherwise it
 * returns false. To read more about the error call GetLastError().
 */
bool ObjectSetInteger(long chart_id, string name,
                      ENUM_OBJECT_PROPERTY_INTEGER prop_id, long prop_value);
bool ObjectSetInteger(long chart_id, string name,
                      ENUM_OBJECT_PROPERTY_INTEGER prop_id, int prop_modifier,
                      long prop_value);

/**
 * The function sets the value of the corresponding object property. The object
 * property must be of the string type. There are 2 variants of the function.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param prop_id ID of the object property. The value can be one of the values
 * of the ENUM_OBJECT_PROPERTY_STRING enumeration.
 * @param prop_modifier Modifier of the specified property. It denotes the
 * number of the level in Fibonacci tools and in the graphical object Andrew's
 * pitchfork. The numeration of levels starts from zero.
 * @param prop_value The value of the property.
 * @returns The function returns true only if the command to change properties
 * of a graphical object has been sent to a chart successfully. Otherwise it
 * returns false. To read more about the error call GetLastError().
 */
bool ObjectSetString(long chart_id, string name,
                     ENUM_OBJECT_PROPERTY_STRING prop_id, string prop_value);
bool ObjectSetString(long chart_id, string name,
                     ENUM_OBJECT_PROPERTY_STRING prop_id, int prop_modifier,
                     string prop_value);

/**
 * The function returns the value of the corresponding object property. The
 * object property must be of the double type. There are 2 variants of the
 * function.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param prop_id ID of the object property. The value can be one of the values
 * of the ENUM_OBJECT_PROPERTY_DOUBLE enumeration.
 * @param prop_modifier Modifier of the specified property. For the first
 * variant, the default modifier value is equal to 0. Most properties do not
 * require a modifier. It denotes the number of the level in Fibonacci tools and
 * in the graphical object Andrew's pitchfork. The numeration of levels starts
 * from zero.
 * @param double_var Variable of the double type that received the value of the
 * requested property.
 * @returns Value of the double type for the first calling variant. For the
 * second variant the function returns true, if this property is maintained and
 * the value has been placed into the double_var variable, otherwise returns
 * false. To read more about the error call GetLastError().
 */
double ObjectGetDouble(long chart_id, string name,
                       ENUM_OBJECT_PROPERTY_DOUBLE prop_id,
                       int prop_modifier = 0);
bool ObjectGetDouble(long chart_id, string name,
                     ENUM_OBJECT_PROPERTY_DOUBLE prop_id, int prop_modifier,
                     double &double_var);

/**
 * The function returns the value of the corresponding object property. The
 * object property must be of the datetime, int, color, bool or char type. There
 * are 2 variants of the function.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param prop_id ID of the object property. The value can be one of the values
 * of the ENUM_OBJECT_PROPERTY_INTEGER enumeration.
 * @param prop_modifier Modifier of the specified property. For the first
 * variant, the default modifier value is equal to 0. Most properties do not
 * require a modifier. It denotes the number of the level in Fibonacci tools and
 * in the graphical object Andrew's pitchfork. The numeration of levels starts
 * from zero.
 * @param long_var Variable of the long type that receives the value of the
 * requested property.
 * @returns The long value for the first calling variant. For the second variant
 * the function returns true, if this property is maintained and the value has
 * been placed into the long_var variable, otherwise returns false. To read more
 * about the error call GetLastError().
 */
long ObjectGetInteger(long chart_id, string name,
                      ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                      int prop_modifier = 0);
bool ObjectGetInteger(long chart_id, string name,
                      ENUM_OBJECT_PROPERTY_INTEGER prop_id, int prop_modifier,
                      long &long_var);

/**
 * The function returns the value of the corresponding object property. The
 * object property must be of the string type. There are 2 variants of the
 * function.
 *
 * @param chart_id Chart identifier. 0 means the current chart.
 * @param name Name of the object.
 * @param prop_id ID of the object property. The value can be one of the values
 * of the ENUM_OBJECT_PROPERTY_STRING enumeration.
 * @param prop_modifier Modifier of the specified property. For the first
 * variant, the default modifier value is equal to 0. Most properties do not
 * require a modifier. It denotes the number of the level in Fibonacci tools and
 * in the graphical object Andrew's pitchfork. The numeration of levels starts
 * from zero.
 * @param string_var Variable of the string type that receives the value of the
 * requested properties.
 * @returns String value for the first version of the call. For the second
 * version of the call returns true, if this property is maintained and the
 * value has been placed into the string_var variable, otherwise returns false.
 * To read more about the error call GetLastError().
 */
string ObjectGetString(long chart_id, string name,
                       ENUM_OBJECT_PROPERTY_STRING prop_id,
                       int prop_modifier = 0);
bool ObjectGetString(long chart_id, string name,
                     ENUM_OBJECT_PROPERTY_STRING prop_id, int prop_modifier,
                     string &string_var);

/**
 * The function sets the font for displaying the text using drawing methods and
 * returns the result of that operation. Arial font with the size -120 (12 pt)
 * is used by default.
 *
 * @param name Font name in the system or the name of the resource containing
 * the font or the path to font file on the disk.
 * @param size The font size that can be set using positive and negative values.
 * In case of positive values, the size of a displayed text does not depend on
 * the operating system's font size settings. In case of negative values, the
 * value is set in tenths of a point and the text size depends on the operating
 * system settings ("standard scale" or "large scale"). See the Note below for
 * more information about the differences between the modes.
 * @param flags Combination of flags describing font style.
 * @param orientation Text's horizontal inclination to X axis, the unit of
 * measurement is 0.1 degrees. It means that orientation=450 stands for
 * inclination equal to 45 degrees.
 * @returns Returns true if the current font is successfully installed,
 * otherwise false. Possible code errors:
 *
 * ERR_INVALID_PARAMETER(4003) - name presents NULL or "" (empty string),
 * ERR_INTERNAL_ERROR(4001) - operating system error (for example, an attempt to
 * create a non-existent font).
 */
bool TextSetFont(const string name, int size, uint flags, int orientation = 0);

/**
 * The function displays a text in a custom array (buffer) and returns the
 * result of that operation. The array is designed to create the graphical
 * resource.
 *
 * @param text Displayed text that will be written to the buffer. Only one-lined
 * text is displayed.
 * @param x X coordinate of the anchor point of the displayed text.
 * @param y Y coordinate of the anchor point of the displayed text.
 * @param anchor The value out of the 9 pre-defined methods of the displayed
 * text's anchor point location. The value is set by a combination of two flags
 * – flags of horizontal and vertical text align.
 * @param data Buffer, in which text is displayed. The buffer is used to create
 * the graphical resource.
 * @param width Buffer width in pixels.
 * @param height Buffer height in pixels.
 * @param color Text color.
 * @param color_format Color format is set by ENUM_COLOR_FORMAT enumeration
 * value.
 * @returns Returns true if successful, otherwise false.
 */
bool TextOut(const string text, int x, int y, uint anchor, uint data[],
             uint width, uint height, uint color,
             ENUM_COLOR_FORMAT color_format);

/**
 * The function returns the line width and height at the current font settings.
 *
 * @param text String, for which length and width should be obtained.
 * @param width Input parameter for receiving width.
 * @param height Input parameter for receiving height.
 * @returns Returns true if successful, otherwise false. Possible code errors:
 */
bool TextGetSize(const string text, uint &width, uint &height);

/**
 * Returns the type of an OpenCL handle as a value of the
 * ENUM_OPENCL_HANDLE_TYPE enumeration.
 *
 * @param handle A handle to an OpenCL object: a context, a kernel or an OpenCL
 * program.
 * @returns The type of the OpenCL handle as a value of the
 * ENUM_OPENCL_HANDLE_TYPE enumeration.
 */
ENUM_OPENCL_HANDLE_TYPE CLHandleType(int handle);

/**
 * Returns the value of an integer property for an OpenCL object or device.
 *
 * @param handle A handle to the OpenCL object or number of the OpenCL device.
 * Numbering of OpenCL devices starts with zero.
 * @param prop The type of a requested property from the
 * ENUM_OPENCL_PROPERTY_INTEGER enumeration, the value of which you want to
 * obtain.
 * @returns The value of the property if successful or -1 in case of an error.
 * For information about the error, use the GetLastError() function.
 */
long CLGetInfoInteger(int handle, ENUM_OPENCL_PROPERTY_INTEGER prop);

/**
 * Returns string value of a property for OpenCL object or device.
 *
 * @param handle OpenCL object handle or OpenCL device number. The numbering of
 * OpenCL devices starts with zero.
 * @param prop Type of requested property from ENUM_OPENCL_PROPERTY_STRING
 * enumeration, the value of which should be obtained.
 * @param value String for receiving the property value.
 * @returns true if successful, otherwise false. For information about the
 * error, use the GetLastError() function.
 */
bool CLGetInfoString(int handle, ENUM_OPENCL_PROPERTY_STRING prop,
                     string &value);

/**
 * Creates an OpenCL context and returns its handle.
 *
 * @param device The ordinal number of the OpenCL-device in the system. Instead
 * of a specific number, you can specify one of the following values:
 * @returns A handle to the OpenCL context if successful, otherwise -1. For
 * information about the error, use the GetLastError() function.
 */
int CLContextCreate(int device);

/**
 * Removes an OpenCL context.
 *
 * @param context Handle of the OpenCL context.
 * @returns None. In the case of an internal error the value of _LastError
 * changes. For information about the error, use the GetLastError() function.
 */
void CLContextFree(int context);

/**
 * The function receives device property from OpenCL driver.
 *
 * @param handle OpenCL device index or OpenCL handle created by
 * CLContextCreate() function.
 * @param property_id ID of the OpenCL device property that should be received.
 * The values can be of one of the predetermined ones listed in the table below.
 * @param data The array for receiving data on the requested property.
 * @param size Size of the received data in the array data[].
 * @returns true if successful, otherwise false. For information about the
 * error, use the GetLastError() function.
 */
bool CLGetDeviceInfo(int handle, int property_id, uchar data[], uint &size);

/**
 * Creates an OpenCL program from a source code.
 *
 * @param context Handle of the OpenCL context.
 * @param source String with the source code of the OpenCL program.
 * @param &build_log A string for receiving the OpenCL compiler messages.
 * @returns A handle to an OpenCL object if successful. In case of error -1 is
 * returned. For information about the error, use the GetLastError() function.
 */
int CLProgramCreate(int context, const string source);
int CLProgramCreate(int context, const string source, string &build_log);

/**
 * Removes an OpenCL program.
 *
 * @param program Handle of the OpenCL object.
 * @returns None. In the case of an internal error the value of _LastError
 * changes. For information about the error, use the GetLastError() function.
 */
void CLProgramFree(int program);

/**
 * Creates the OpenCL program kernel and returns its handle.
 *
 * @param program Handle to an object of the OpenCL program.
 * @param kernel_name The name of the kernel function in the appropriate OpenCL
 * program, in which execution begins.
 * @returns A handle to an OpenCL object if successful. In case of error -1 is
 * returned. For information about the error, use the GetLastError() function.
 */
int CLKernelCreate(int program, const string kernel_name);

/**
 * Removes an OpenCL start function.
 *
 * @param kernel_name Handle of the kernel object.
 * @returns None. In the case of an internal error the value of _LastError
 * changes. For information about the error, use the GetLastError() function.
 */
void CLKernelFree(int kernel);

/**
 * Sets a parameter for the OpenCL function.
 *
 * @param kernel Handle to a kernel of the OpenCL program.
 * @param arg_index The number of the function argument, numbering starts with
 * zero.
 * @param arg_value The value of the function argument.
 * @returns Returns true if successful, otherwise returns false. For information
 * about the error, use the GetLastError() function.
 */
template <typename T>
bool CLSetKernelArg(int kernel, uint arg_index, T arg_value);

/**
 * Sets an OpenCL buffer as a parameter of the OpenCL function.
 *
 * @param kernel Handle to a kernel of the OpenCL program.
 * @param arg_index The number of the function argument, numbering starts with
 * zero.
 * @param cl_mem_handle A handle to an OpenCL buffer.
 * @returns Returns true if successful, otherwise returns false. For information
 * about the error, use the GetLastError() function.
 */
bool CLSetKernelArgMem(int kernel, uint arg_index, int cl_mem_handle);

/**
 * Sets the local buffer as an argument of the kernel function.
 *
 * @param kernel Handle to a kernel of the OpenCL program.
 * @param arg_index The number of the function argument, numbering starts with
 * zero.
 * @param local_mem_size Buffer size in bytes.
 * @returns Returns true if successful, otherwise returns false. For information
 * about the error, use the GetLastError() function.
 */
bool CLSetKernelArgMemLocal(int kernel, uint arg_index, ulong local_mem_size);

/**
 * Creates an OpenCL buffer and returns its handle.
 *
 * @param context A handle to context OpenCL.
 * @param size Buffer size in bytes.
 * @param flags Buffer properties that are set using a combination of flags.
 * @returns A handle to an OpenCL buffer if successful. In case of error -1 is
 * returned. For information about the error, use the GetLastError() function.
 */
int CLBufferCreate(int context, uint size, uint flags);

/**
 * Deletes an OpenCL buffer.
 *
 * @param buffer A handle to an OpenCL buffer.
 * @returns None. In the case of an internal error the value of _LastError
 * changes. For information about the error, use the GetLastError() function.
 */
void CLBufferFree(int buffer);

/**
 * Writes into the OpenCL buffer and returns the number of written elements.
 *
 * @param buffer A handle of the OpenCL buffer.
 * @param data An array of values that should be written in the OpenCL buffer.
 * Passed by reference.
 * @param buffer_offset An offset in the OpenCL buffer in bytes, from which
 * writing begins. By default, writing start with the very beginning of the
 * buffer.
 * @param data_offset The index of the first array element, starting from which
 * values from the array are written in the OpenCL buffer. By default, values
 * from the very beginning of the array are taken.
 * @param data_count The number of values that should be written. All the values
 * of the array, by default.
 * @returns The number of written elements. 0 is returned in case of an error.
 * For information about the error, use the GetLastError() function.
 */
template <typename T>
uint CLBufferWrite(int buffer, const T data[], uint buffer_offset = 0,
                   uint data_offset = 0, uint data_count = WHOLE_ARRAY);

/**
 * Reads an OpenCL buffer into an array and returns the number of read elements.
 *
 * @param buffer A handle of the OpenCL buffer.
 * @param data An array for receiving values from the OpenCL buffer. Passed by
 * reference.
 * @param buffer_offset An offset in the OpenCL buffer in bytes, from which
 * reading begins. By default, reading start with the very beginning of the
 * buffer.
 * @param data_offset The index of the first array element for writing the
 * values of the OpenCL buffer. By default, writing of the read values into an
 * array starts from the zero index.
 * @param data_count The number of values that should be read. The whole OpenCL
 * buffer is read by default.
 * @returns The number of read elements. 0 is returned in case of an error. For
 * information about the error, use the GetLastError() function.
 */
template <typename T>
uint CLBufferRead(int buffer, const T data[], uint buffer_offset = 0,
                  uint data_offset = 0, uint data_count = WHOLE_ARRAY);

/**
 * The function runs an OpenCL program. There are 3 versions of the function:
 *
 * @param kernel Handle to the OpenCL kernel.
 * @param work_dim Dimension of the tasks space.
 * @param global_work_offset Initial offset in the tasks space.
 * @param global_work_size The size of a subset of tasks.
 * @param local_work_size The size of the group's local task subset.
 * @returns Returns true if successful, otherwise returns false. For information
 * about the error, use the GetLastError() function.
 */
bool CLExecute(int kernel);
bool CLExecute(int kernel, uint work_dim, const uint global_work_offset[],
               const uint global_work_size[]);
bool CLExecute(int kernel, uint work_dim, const uint global_work_offset[],
               const uint global_work_size[], const uint local_work_size[]);

/**
 * Returns the OpenCL program execution status.
 *
 * @param kernel Handle to a kernel of the OpenCL program.
 * @returns Returns the OpenCL program status. The value can be one of the
 * following:
 */
int CLExecutionStatus(int kernel);

/**
 * Moves a pointer of frame reading to the beginning and resets a set filter.
 *
 * @returns Returns true if successful, otherwise false. To get information
 * about the error, call the GetLastError() function.
 */
bool FrameFirst();

/**
 * Sets the frame reading filter and moves the pointer to the beginning.
 *
 * @returns Returns true if successful, otherwise false. To get information
 * about the error, call the GetLastError() function.
 */
bool FrameFilter(const string name, long id);

/**
 * Reads a frame and moves the pointer to the next one. There are two variants
 * of the function.
 *
 * @param pass The number of a pass during optimization in the strategy tester.
 * @param name The name of the identifier.
 * @param id The value of the identifier.
 * @param value A single numeric value.
 * @param data An array of any type.
 * @returns Returns true if successful, otherwise false. To get information
 * about the error, call the GetLastError() function.
 */
bool FrameNext(ulong &pass, string &name, long &id, double &value);
template <typename T>
bool FrameNext(ulong &pass, string &name, long &id, double &value, T data[]);

/**
 * Receives input parameters, on which the frame with the specified pass number
 * is formed.
 *
 * @param pass The number of a pass during optimization in the strategy tester.
 * @param parameters A string array with the description of names and parameter
 * values
 * @param parameters_count The number of elements in the array parameters[].
 * @returns Returns true if successful, otherwise false. To get information
 * about the error, call the GetLastError() function.
 */
bool FrameInputs(ulong pass, string parameters[], uint &parameters_count);

/**
 * Adds a frame with data. There are two variants of the function.
 *
 * @param name Public frame label. It can be used for a filter in the
 * FrameFilter() function.
 * @param id A public identifier of the frame. It can be used for a filter in
 * the FrameFilter() function.
 * @param value A numeric value to write into the frame. It is used to transmit
 * a single pass result like in the OnTester() function.
 * @param filename The name of the file that contains data to add to the frame.
 * The file must be locate in the folder MQL5/Files.
 * @param data An array of any type to write into the frame. Passed by
 * reference.
 * @returns Returns true if successful, otherwise false. To get information
 * about the error, call the GetLastError() function.
 */
bool FrameAdd(const string name, long id, double value, const string filename);
template <typename T>
bool FrameAdd(const string name, long id, double value, const T data[]);

/**
 * Receives data on the values range and the change step for an input variable
 * when optimizing an Expert Advisor in the Strategy Tester. There are 2
 * variants of the function.
 *
 * @param name input variable ID. These variables are external parameters of an
 * application. Their values can be specified when launching on a chart or
 * during a single test.
 * @param enable Flag that this parameter can be used to enumerate the values
 * during the optimization in the Strategy Tester.
 * @param value Parameter value.
 * @param start Initial parameter value during the optimization.
 * @param step Parameter change step when enumerating its values.
 * @param stop Final parameter value during the optimization.
 * @returns Returns true if successful, otherwise false. For information about
 * the error, use the GetLastError() function.
 */
bool ParameterGetRange(const string name, bool &enable, long &value,
                       long &start, long &step, long &stop);
bool ParameterGetRange(const string name, bool &enable, double &value,
                       double &start, double &step, double &stop);

/**
 * Specifies the use of input variable when optimizing an Expert Advisor in the
 * Strategy Tester: value, change step, initial and final values. There are 2
 * variants of the function.
 *
 * @param name input or sinput variable ID. These variables are external
 * parameters of an application. Their values can be specified when launching
 * the program.
 * @param enable Enable this parameter to enumerate the values during the
 * optimization in the Strategy Tester.
 * @param value Parameter value.
 * @param start Initial parameter value during the optimization.
 * @param step Parameter change step when enumerating its values.
 * @param stop Final parameter value during the optimization.
 * @returns Returns true if successful, otherwise false. For information about
 * the error, use the GetLastError() function.
 */
bool ParameterSetRange(const string name, bool enable, long value, long start,
                       long step, long stop);
bool ParameterSetRange(const string name, bool enable, double value,
                       double start, double step, double stop);

/**
 * The function adds a substring to the end of a string.
 *
 * @param string_var String, to which another one is added.
 * @param add_substring String that is added to the end of a source string.
 * @returns In case of success returns true, otherwise false. In order to get an
 * error code, the GetLastError() function should be called.
 */
bool StringAdd(string &string_var, string add_substring);

/**
 * The function returns the size of buffer allocated for the string.
 *
 * @param string_var String.
 * @returns The value 0 means that the string is constant and buffer size can't
 * be changed. -1 means that the string belongs to the client terminal, and
 * modification of the buffer contents can have indeterminate results.
 */
int StringBufferLen(string string_var);

/**
 * The function compares two strings and returns the comparison result in form
 * of an integer.
 *
 * @param string1 The first string.
 * @param string2 The second string.
 * @param case_sensitive Case sensitivity mode selection. If it is true, then
 * "A">"a". If it is false, then "A"="a". By default the value is equal to true.
 */
int StringCompare(const string &string1, const string &string2,
                  bool case_sensitive = true);

/**
 * The function forms a string of passed parameters and returns the size of the
 * formed string. Parameters can be of any type. Number of parameters can't be
 * less than 2 or more than 64.
 *
 * @param string_var String that will be formed as a result of concatenation.
 * @param ... Any comma separated values. From 2 to 63 parameters of any
 * simple type.
 * @returns Returns the string length, formed by concatenation of parameters
 * transformed into string type. Parameters are transformed into strings
 * according to the same rules as in Print() and Comment().
 */
int StringConcatenate(string &string_var, ...);

/**
 * It fills out a selected string by specified symbols.
 *
 * @param string_var String, that will be filled out by the selected symbol.
 * @param character Symbol, by which the string will be filled out.
 * @returns In case of success returns true, otherwise - false. To get the error
 * code call GetLastError().
 */
bool StringFill(string &string_var, ushort character);

/**
 * Search for a substring in a string.
 *
 * @param string_value String, in which search is made.
 * @param match_substring Searched substring.
 * @param start_pos Position in the string from which search is started.
 * @returns Returns position number in a string, from which the searched
 * substring starts, or -1, if the substring is not found.
 */
int StringFind(string string_value, string match_substring, int start_pos = 0);

/**
 * Returns value of a symbol, located in the specified position of a string.
 *
 * @param string_value String.
 * @param pos Position of a symbol in the string. Can be from 0 to
 * StringLen(text) -1.
 * @returns Symbol code or 0 in case of an error. To get the error code call
 * GetLastError().
 */
ushort StringGetCharacter(string string_value, int pos);

/**
 * Initializes a string by specified symbols and provides the specified string
 * size.
 *
 * @param string_var String that should be initialized and deinitialized.
 * @param new_len String length after initialization. If length=0, it
 * deinitializes the string, i.e. the string buffer is cleared and the buffer
 * address is zeroed.
 * @param character Symbol to fill the string.
 * @returns In case of success returns true, otherwise - false. To get the error
 * code call GetLastError().
 */
bool StringInit(string &string_var, int new_len = 0, ushort character = 0);

/**
 * Returns the number of symbols in a string.
 *
 * @param string_value String to calculate length.
 * @returns Number of symbols in a string without the ending zero.
 */
int StringLen(string string_value);

/**
 * Sets a specified length (in characters) for a string.
 *
 * @param string_var String, for which a new length in characters should be set.
 * @param new_capacity Required string length in characters. If new_length is
 * less than the current size, the excessive characters are discarded.
 * @returns In case of successful execution, returns true, otherwise - false. To
 * receive an error code, the GetLastError() function should be called.
 */
bool StringSetLength(string &string_var, uint new_length);

/**
 * It replaces all the found substrings of a string by a set sequence of
 * symbols.
 *
 * @param str The string in which you are going to replace substrings.
 * @param find The desired substring to replace.
 * @param replacement The string that will be inserted instead of the found one.
 * @returns The function returns the number of replacements in case of success,
 * otherwise -1. To get an error code call the GetLastError() function.
 */
int StringReplace(string &str, const string find, const string replacement);

/**
 * Reserves the buffer of a specified size for a string in memory.
 *
 * @param string_var String the buffer size should change the size for.
 * @param new_capacity Buffer size required for a string. If the new_capacity
 * size is less than the string length, the size of the current buffer does not
 * change.
 * @returns In case of successful execution, returns true, otherwise - false. To
 * receive an error code, the GetLastError() function should be called.
 */
bool StringReserve(string &string_var, uint new_capacity);

/**
 * Returns copy of a string with a changed character in a specified position.
 *
 * @param string_var String.
 * @param pos Position of a character in a string. Can be from 0 to
 * StringLen(text).
 * @param character Symbol code Unicode.
 * @returns In case of success returns true, otherwise false. In order to get an
 * error code, the GetLastError() function should be called.
 */
bool StringSetCharacter(string &string_var, int pos, ushort character);

/**
 * Gets substrings by a specified separator from the specified string, returns
 * the number of substrings obtained.
 *
 * @param string_value The string from which you need to get substrings. The
 * string will not change.
 * @param pos The code of the separator character. To get the code, you can use
 * the StringGetCharacter() function.
 * @param result An array of strings where the obtained substrings are located.
 * @returns The number of substrings in the result[] array. If the separator is
 * not found in the passed string, only one source string will be placed in the
 * array.
 */
int StringSplit(const string string_value, const ushort separator,
                string result[]);

/**
 * Extracts a substring from a text string starting from the specified position.
 *
 * @param string_value String to extract a substring from.
 * @param start_pos Initial position of a substring. Can be from 0 to
 * StringLen(text) -1.
 * @param length Length of an extracted substring. If the parameter value is
 * equal to -1 or parameter isn't set, the substring will be extracted from the
 * indicated position till the string end.
 * @returns Copy of a extracted substring, if possible. Otherwise returns an
 * empty string.
 */
string StringSubstr(string string_value, int start_pos, int length = -1);

/**
 * Transforms all symbols of a selected string into lowercase.
 *
 * @param string_var String.
 * @returns In case of success returns true, otherwise - false. To get the error
 * code call GetLastError().
 */
bool StringToLower(string &string_var);

/**
 * Transforms all symbols of a selected string into capitals.
 *
 * @param string_var String.
 * @returns In case of success returns true, otherwise - false. To get the error
 * code call GetLastError().
 */
bool StringToUpper(string &string_var);

/**
 * The function cuts line feed characters, spaces and tabs in the left part of
 * the string till the first meaningful symbol. The string is modified at place.
 *
 * @param string_var String that will be cut from the left.
 * @returns Returns the number of cut symbols.
 */
int StringTrimLeft(string &string_var);

/**
 * The function cuts line feed characters, spaces and tabs in the right part of
 * the string after the last meaningful symbol. The string is modified at place.
 *
 * @param string_var String that will be cut from the right.
 * @returns Returns the number of cut symbols.
 */
int StringTrimRight(string &string_var);

/**
 * The function creates Accelerator Oscillator in a global cache of the client
 * terminal and returns its handle. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * enumeration values, 0 means the current timeframe.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iAC(string symbol, ENUM_TIMEFRAMES period);

/**
 * The function returns the handle of the Accumulation/Distribution indicator.
 * It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * enumeration values, 0 means the current timeframe.
 * @param applied_volume The volume used. Can be any of ENUM_APPLIED_VOLUME
 * values.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iAD(string symbol, ENUM_TIMEFRAMES period,
        ENUM_APPLIED_VOLUME applied_volume);

/**
 * The function returns the handle of the Average Directional Movement Index
 * indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param adx_period Period to calculate the index.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iADX(string symbol, ENUM_TIMEFRAMES period, int adx_period);

/**
 * The function returns the handle of Average Directional Movement Index by
 * Welles Wilder.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param adx_period Period to calculate the index.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iADXWilder(string symbol, ENUM_TIMEFRAMES period, int adx_period);

/**
 * The function returns the handle of the Alligator indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param jaw_period Averaging period for the blue line (Alligator's Jaw)
 * @param jaw_shift The shift of the blue line relative to the price chart.
 * @param teeth_period Averaging period for the red line (Alligator's Teeth).
 * @param teeth_shift The shift of the red line relative to the price chart.
 * @param lips_period Averaging period for the green line (Alligator's lips).
 * @param lips_shift The shift of the green line relative to the price chart.
 * @param ma_method The method of averaging. Can be any of the ENUM_MA_METHOD
 * values.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iAlligator(string symbol, ENUM_TIMEFRAMES period, int jaw_period,
               int jaw_shift, int teeth_period, int teeth_shift,
               int lips_period, int lips_shift, ENUM_MA_METHOD ma_method,
               ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Adaptive Moving Average indicator. It
 * has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ama_period The calculation period, on which the efficiency coefficient
 * is calculated.
 * @param fast_ma_period Fast period for the smoothing coefficient calculation
 * for a rapid market.
 * @param slow_ma_period Slow period for the smoothing coefficient calculation
 * in the absence of trend.
 * @param ama_shift Shift of the indicator relative to the price chart.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iAMA(string symbol, ENUM_TIMEFRAMES period, int ama_period,
         int fast_ma_period, int slow_ma_period, int ama_shift,
         ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Awesome Oscillator indicator. It has
 * only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iAO(string symbol, ENUM_TIMEFRAMES period);

/**
 * The function returns the handle of the Average True Range indicator. It has
 * only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period The value of the averaging period for the indicator
 * calculation.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iATR(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/**
 * The function returns the handle of the Bears Power indicator. It has only one
 * buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period The value of the averaging period for the indicator
 * calculation.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iBearsPower(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/**
 * The function returns the handle of the Bollinger Bands® indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param bands_period The averaging period of the main line of the indicator.
 * @param bands_shift The shift the indicator relative to the price chart.
 * @param deviation Deviation from the main line.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iBands(string symbol, ENUM_TIMEFRAMES period, int bands_period,
           int bands_shift, double deviation, ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Bulls Power indicator. It has only one
 * buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period The averaging period for the indicator calculation.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iBullsPower(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/**
 * The function returns the handle of the Commodity Channel Index indicator. It
 * has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period The averaging period for the indicator calculation.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iCCI(string symbol, ENUM_TIMEFRAMES period, int ma_period,
         ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Chaikin Oscillator indicator. It has
 * only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param fast_ma_period Fast averaging period for calculations.
 * @param slow_ma_period Slow averaging period for calculations.
 * @param ma_method Smoothing type. Can be one of the averaging constants of
 * ENUM_MA_METHOD.
 * @param applied_volume The volume used. Can be one of the constants of
 * ENUM_APPLIED_VOLUME.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iChaikin(string symbol, ENUM_TIMEFRAMES period, int fast_ma_period,
             int slow_ma_period, ENUM_MA_METHOD ma_method,
             ENUM_APPLIED_VOLUME applied_volume);

/**
 * The function returns the handle of a specified custom indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param name Custom indicator name. If the name starts with the reverse slash
 * '\\', the EX5 indicator file is searched for relative to the MQL5\\Indicators
 * indicator root directory. Thus, when calling iCustom(Symbol(), Period(),
 * "\\FirstIndicator"...), the indicator is downloaded as
 * MQL5\\Indicators\\FirstIndicator.ex5. If the path contains no file, the error
 * 4802 (ERR_INDICATOR_CANNOT_CREATE) occurs.
 *
 * If the path does not start with '\', the indicator is searched and downloaded
 * as follows:
 *
 * First, the indicator EX5 file is searched for in the folder where the EX5
 * file of the calling program is located. For example, the CrossMA.EX5 EA is
 * located in MQL5\Experts\MyExperts and contains the iCustom call (Symbol(),
 * Period(), "SecondIndicator"...). In this case, the indicator is searched for
 * in MQL5\Experts\MyExperts\SecondIndicator.ex5.
 *
 * If the indicator is not found in the same directory, the search is performed
 * relative to the MQL5\Indicators indicator root directory. In other words, the
 * search for the MQL5\Indicators\SecondIndicator.ex5 file is performed. If the
 * indicator is still not found, the function returns INVALID_HANDLE and the
 * error 4802 (ERR_INDICATOR_CANNOT_CREATE) is triggered.
 *
 * If the path to the indicator is set in the subdirectory (for example,
 * MyIndicators\ThirdIndicator), the search is first performed in the calling
 * program folder (the EA is located in MQL5\Experts\MyExperts) in
 * MQL5\Experts\MyExperts\MyIndicators\ThirdIndicator.ex5. If unsuccessful, the
 * search for the MQL5\Indicators\MyIndicators\ThirdIndicator.ex5 file is
 * performed. Make sure to use the double reverse slash '\\' as a separator in
 * the path, for example iCustom(Symbol(), Period(),
 * "MyIndicators\\ThirdIndicator"...)
 * @param ... input-parameters of a custom indicator, separated by commas. Type
 * and order of parameters must match. If there is no parameters specified, then
 * default values will be used.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iCustom(string symbol, ENUM_TIMEFRAMES period, string name, ...);

/**
 * The function returns the handle of the Double Exponential Moving Average
 * indicator. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period (bars count) for calculations.
 * @param ma_shift Shift of the indicator relative to the price chart.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iDEMA(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift,
          ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the DeMarker indicator. It has only one
 * buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period (bars count) for calculations.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iDeMarker(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/**
 * The function returns the handle of the Envelopes indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period for the main line.
 * @param ma_shift The shift of the indicator relative to the price chart.
 * @param ma_method Smoothing type. Can be one of the values of ENUM_MA_METHOD.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @param deviation The deviation from the main line (in percents).
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iEnvelopes(string symbol, ENUM_TIMEFRAMES period, int ma_period,
               int ma_shift, ENUM_MA_METHOD ma_method,
               ENUM_APPLIED_PRICE applied_price, double deviation);

/**
 * The function returns the handle of the Force Index indicator. It has only one
 * buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period for the indicator calculations.
 * @param ma_method Smoothing type. Can be one of the values of ENUM_MA_METHOD.
 * @param applied_volume The volume used. Can be one of the values of
 * ENUM_APPLIED_VOLUME.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iForce(string symbol, ENUM_TIMEFRAMES period, int ma_period,
           ENUM_MA_METHOD ma_method, ENUM_APPLIED_VOLUME applied_volume);

/**
 * The function returns the handle of the Fractals indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iFractals(string symbol, ENUM_TIMEFRAMES period);

/**
 * The function returns the handle of the Fractal Adaptive Moving Average
 * indicator. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Period (bars count) for the indicator calculations.
 * @param ma_shift Shift of the indicator in the price chart.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iFrAMA(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift,
           ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Gator indicator. The Oscillator shows
 * the difference between the blue and red lines of Alligator (upper histogram)
 * and difference between red and green lines (lower histogram).
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param jaw_period Averaging period for the blue line (Alligator's Jaw).
 * @param jaw_shift The shift of the blue line relative to the price chart. It
 * isn't directly connected with the visual shift of the indicator histogram.
 * @param teeth_period Averaging period for the red line (Alligator's Teeth).
 * @param teeth_shift The shift of the red line relative to the price chart. It
 * isn't directly connected with the visual shift of the indicator histogram.
 * @param lips_period Averaging period for the green line (Alligator's lips).
 * @param lips_shift The shift of the green line relative to the price charts.
 * It isn't directly connected with the visual shift of the indicator histogram.
 * @param ma_method Smoothing type. Can be one of the values of ENUM_MA_METHOD.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iGator(string symbol, ENUM_TIMEFRAMES period, int jaw_period, int jaw_shift,
           int teeth_period, int teeth_shift, int lips_period, int lips_shift,
           ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Ichimoku Kinko Hyo indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param tenkan_sen Averaging period for Tenkan Sen.
 * @param kijun_sen Averaging period for Kijun Sen.
 * @param senkou_span_b Averaging period for Senkou Span B.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iIchimoku(string symbol, ENUM_TIMEFRAMES period, int tenkan_sen,
              int kijun_sen, int senkou_span_b);

/**
 * The function returns the handle of the Market Facilitation Index indicator.
 * It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param applied_volume The volume used. Can be one of the constants of
 * ENUM_APPLIED_VOLUME.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iBWMFI(string symbol, ENUM_TIMEFRAMES period,
           ENUM_APPLIED_VOLUME applied_volume);

/**
 * The function returns the handle of the Momentum indicator. It has only one
 * buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param mom_period Averaging period (bars count) for the calculation of the
 * price change.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iMomentum(string symbol, ENUM_TIMEFRAMES period, int mom_period,
              ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Money Flow Index indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period (bars count) for the calculation.
 * @param applied_volume The volume used. Can be any of the ENUM_APPLIED_VOLUME
 * values.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iMFI(string symbol, ENUM_TIMEFRAMES period, int ma_period,
         ENUM_APPLIED_VOLUME applied_volume);

/**
 * The function returns the handle of the Moving Average indicator. It has only
 * one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period for the calculation of the moving average.
 * @param ma_shift Shift of the indicator relative to the price chart.
 * @param ma_method Smoothing type. Can be one of the ENUM_MA_METHOD values.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iMA(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift,
        ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Moving Average of Oscillator
 * indicator. The OsMA oscillator shows the difference between values of MACD
 * and its signal line. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param fast_ema_period Period for Fast Moving Average calculation.
 * @param slow_ema_period Period for Slow Moving Average calculation.
 * @param signal_period Averaging period for signal line calculation.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iOsMA(string symbol, ENUM_TIMEFRAMES period, int fast_ema_period,
          int slow_ema_period, int signal_period,
          ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Moving Averages Convergence/Divergence
 * indicator. In systems where OsMA is called MACD Histogram, this indicator is
 * shown as two lines. In the client terminal the Moving Averages
 * Convergence/Divergence looks like a histogram.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param fast_ema_period Period for Fast Moving Average calculation.
 * @param slow_ema_period Period for Slow Moving Average calculation.
 * @param signal_period Period for Signal line calculation.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iMACD(string symbol, ENUM_TIMEFRAMES period, int fast_ema_period,
          int slow_ema_period, int signal_period,
          ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the On Balance Volume indicator. It has
 * only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param applied_volume The volume used. Can be any of the ENUM_APPLIED_VOLUME
 * values.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iOBV(string symbol, ENUM_TIMEFRAMES period,
         ENUM_APPLIED_VOLUME applied_volume);

/**
 * The function returns the handle of the Parabolic Stop and Reverse system
 * indicator. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param step The step of price increment, usually 0.02.
 * @param maximum The maximum step, usually 0.2.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iSAR(string symbol, ENUM_TIMEFRAMES period, double step, double maximum);

/**
 * The function returns the handle of the Relative Strength Index indicator. It
 * has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period for the RSI calculation.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iRSI(string symbol, ENUM_TIMEFRAMES period, int ma_period,
         ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Relative Vigor Index indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period for the RVI calculation.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iRVI(string symbol, ENUM_TIMEFRAMES period, int ma_period);

/**
 * The function returns the handle of the Standard Deviation indicator. It has
 * only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period for the indicator calculations.
 * @param ma_shift Shift of the indicator relative to the price chart.
 * @param ma_method Type of averaging. Can be any of the ENUM_MA_METHOD values.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iStdDev(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift,
            ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Stochastic Oscillator indicator.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param Kperiod Averaging period (bars count) for the %K line calculation.
 * @param Dperiod Averaging period (bars count) for the %D line calculation.
 * @param slowing Slowing value.
 * @param ma_method Type of averaging. Can be any of the ENUM_MA_METHOD values.
 * @param price_field Parameter of price selection for calculations. Can be one
 * of the ENUM_STO_PRICE values.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iStochastic(string symbol, ENUM_TIMEFRAMES period, int Kperiod, int Dperiod,
                int slowing, ENUM_MA_METHOD ma_method,
                ENUM_STO_PRICE price_field);

/**
 * The function returns the handle of the Triple Exponential Moving Average
 * indicator. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period (bars count) for calculation.
 * @param ma_shift Shift of indicator relative to the price chart.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iTEMA(string symbol, ENUM_TIMEFRAMES period, int ma_period, int ma_shift,
          ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Triple Exponential Moving Averages
 * Oscillator indicator. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param ma_period Averaging period (bars count) for calculations.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iTriX(string symbol, ENUM_TIMEFRAMES period, int ma_period,
          ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Larry Williams' Percent Range
 * indicator. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param calc_period Period (bars count) for the indicator calculation.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iWPR(string symbol, ENUM_TIMEFRAMES period, int calc_period);

/**
 * The function returns the handle of the Variable Index Dynamic Average
 * indicator. It has only one buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param cmo_period Period (bars count) for the Chande Momentum Oscillator
 * calculation.
 * @param ema_period EMA period (bars count) for smoothing factor calculation.
 * @param ma_shift Shift of the indicator relative to the price chart.
 * @param applied_price The price used. Can be any of the price constants
 * ENUM_APPLIED_PRICE or a handle of another indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iVIDyA(string symbol, ENUM_TIMEFRAMES period, int cmo_period,
           int ema_period, int ma_shift, ENUM_APPLIED_PRICE applied_price);

/**
 * The function returns the handle of the Volumes indicator. It has an only one
 * buffer.
 *
 * @param symbol The symbol name of the security, the data of which should be
 * used to calculate the indicator. The NULL value means the current symbol.
 * @param period The value of the period can be one of the ENUM_TIMEFRAMES
 * values, 0 means the current timeframe.
 * @param applied_volume The volume used. Can be any of the ENUM_APPLIED_VOLUME
 * values.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE. The computer memory can be freed from an
 * indicator that is no more utilized, using the IndicatorRelease() function, to
 * which the indicator handle is passed.
 */
int iVolumes(string symbol, ENUM_TIMEFRAMES period,
             ENUM_APPLIED_VOLUME applied_volume);

/**
 * Returns information about the state of historical data. There are 2
 * variants of function calls.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param prop_id Identifier of the requested property, value of the
 * ENUM_SERIES_INFO_INTEGER enumeration.
 * @param long_var Variable to which the value of the requested property is
 * placed.
 * @returns In the first case, it returns value of the long type.
 *
 * For the second case,  it returns true, if the specified property is
 * available and its value has been placed into long_var variable, otherwise
 * it returns false. For more details about an error, call GetLastError().
 */
long SeriesInfoInteger(string symbol_name, ENUM_TIMEFRAMES timeframe,
                       ENUM_SERIES_INFO_INTEGER prop_id);
bool SeriesInfoInteger(string symbol_name, ENUM_TIMEFRAMES timeframe,
                       ENUM_SERIES_INFO_INTEGER prop_id, long &long_var);

/**
 * Returns the number of bars count in the history for a specified symbol and
 * period. There are 2 variants of functions calls.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_time Bar time corresponding to the first element.
 * @param stop_time Bar time corresponding to the last element.
 * @returns If the start_time and stop_time parameters are defined, the function
 * returns the number of bars in the specified time interval, otherwise it
 * returns the total number of bars.
 */
int Bars(string symbol_name, ENUM_TIMEFRAMES timeframe);
int Bars(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
         datetime stop_time);

/**
 * Returns the number of calculated data for the specified indicator.
 *
 * @param indicator_handle The indicator handle, returned by the corresponding
 * indicator function.
 * @returns Returns the amount of calculated data in the indicator buffer or -1
 * in the case of error (data not calculated yet)
 */
int BarsCalculated(int indicator_handle);

/**
 * The function returns the handle of a specified technical indicator created
 * based on the array of parameters of MqlParam type.
 *
 * @param symbol Name of a symbol, on data of which the indicator is calculated.
 * NULL means the current symbol.
 * @param period The value of the timeframe can be one of values of the
 * ENUM_TIMEFRAMES enumeration, 0 means the current timeframe.
 * @param indicator_type Indicator type, can be one of values of the
 * ENUM_INDICATOR enumeration.
 * @param parameters_cnt The number of parameters passed in the
 * parameters_array[] array. The array elements have a special structure type
 * MqlParam. By default, zero - parameters are not passed. If you specify a
 * non-zero number of parameters, the parameter parameters_array is obligatory.
 * You can pass no more than 64 parameters.
 * @param parameters_array An array of MqlParam type, whose elements contain the
 * type and value of each input parameter of a technical indicator.
 * @returns Returns the handle of a specified technical indicator, in case of
 * failure returns INVALID_HANDLE.
 */
int IndicatorCreate(string symbol, ENUM_TIMEFRAMES period,
                    ENUM_INDICATOR indicator_type, int parameters_cnt = 0,
                    const MqlParam parameters_array[] = NULL);

/**
 * Based on the specified handle, returns the number of input parameters of the
 * indicator, as well as the values and types of the parameters.
 *
 * @param indicator_handle The handle of the indicator, for which you need to
 * know the number of parameters its is calculated on.
 * @param indicator_type A variable if the ENUM_INDICATOR type, into which the
 * indicator type will be written.
 * @param parameters A dynamic array for receiving values of the MqlParam type,
 * into which the list of indicator parameters will be written. The array size
 * is returned by the IndicatorParameters() function.
 * @returns The number of input parameters of the indicator with the specified
 * handle. In case of an error returns -1. For more details about the error call
 * the GetLastError() function.
 */
int IndicatorParameters(int indicator_handle, ENUM_INDICATOR &indicator_type,
                        MqlParam parameters[]);

/**
 * The function removes an indicator handle and releases the calculation block
 * of the indicator, if it's not used by anyone else.
 *
 * @returns Returns true in case of success, otherwise returns false.
 */
bool IndicatorRelease(int indicator_handle);

/**
 * Gets data of a specified buffer of a certain indicator in the necessary
 * quantity.
 *
 * @param indicator_handle The indicator handle, returned by the corresponding
 * indicator function.
 * @param buffer_num The indicator buffer number.
 * @param start_pos The position of the first element to copy.
 * @param count Data count to copy.
 * @param start_time Bar time, corresponding to the first element.
 * @param stop_time Bar time, corresponding to the last element.
 * @param buffer Array of double type.
 * @returns Returns the copied data count or -1 in case of an error.
 */
int CopyBuffer(int indicator_handle, int buffer_num, int start_pos, int count,
               double buffer[]);
int CopyBuffer(int indicator_handle, int buffer_num, datetime start_time,
               int count, double buffer[]);
int CopyBuffer(int indicator_handle, int buffer_num, datetime start_time,
               datetime stop_time, double buffer[]);

/**
 * Gets history data of MqlRates structure of a specified symbol-period in
 * specified quantity into the rates_array array. The elements ordering of the
 * copied data is from present to the past, i.e., starting position of 0 means
 * the current bar.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_time Bar time for the first element to copy.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param stop_time Bar time, corresponding to the last element to copy.
 * @param rates_array Array of MqlRates type.
 * @returns Returns the number of copied elements or -1 in case of an error.
 */
int CopyRates(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
              int count, MqlRates rates_array[]);
int CopyRates(string symbol_name, ENUM_TIMEFRAMES timeframe,
              datetime start_time, int count, MqlRates rates_array[]);
int CopyRates(string symbol_name, ENUM_TIMEFRAMES timeframe,
              datetime start_time, datetime stop_time, MqlRates rates_array[]);

/**
 * The function gets to time_array history data of bar opening time for the
 * specified symbol-period pair in the specified quantity. It should be noted
 * that elements ordering is from present to past, i.e., starting position of 0
 * means the current bar.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param start_time The start time for the first element to copy.
 * @param stop_time Bar time corresponding to the last element to copy.
 * @param time_array Array of datetime type.
 * @returns Returns the copied data count or -1 in case of an error.
 */
int CopyTime(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
             int count, datetime time_array[]);
int CopyTime(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
             int count, datetime time_array[]);
int CopyTime(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
             datetime stop_time, datetime time_array[]);

/**
 * The function gets into open_array the history data of bar open prices for the
 * selected symbol-period pair in the specified quantity. It should be noted
 * that elements ordering is from present to past, i.e., starting position of 0
 * means the current bar.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param start_time The start time for the first element to copy.
 * @param stop_time The start time for the last element to copy.
 * @param open_array Array of double type.
 * @returns Returns the number of element in the array or -1 in case of an
 * error.
 */
int CopyOpen(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
             int count, double open_array[]);
int CopyOpen(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
             int count, double open_array[]);
int CopyOpen(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
             datetime stop_time, double open_array[]);

/**
 * The function gets into high_array the history data of highest bar prices for
 * the selected symbol-period pair in the specified quantity. It should be noted
 * that elements ordering is from present to past, i.e., starting position of 0
 * means the current bar.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param start_time The start time for the first element to copy.
 * @param stop_time Bar time, corresponding to the last element to copy.
 * @param high_array Array of double type.
 * @returns Returns the copied data count or -1 in case of an error.
 */
int CopyHigh(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
             int count, double high_array[]);
int CopyHigh(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
             int count, double high_array[]);
int CopyHigh(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
             datetime stop_time, double high_array[]);

/**
 * The function gets into low_array the history data of minimal bar prices for
 * the selected symbol-period pair in the specified quantity. It should be noted
 * that elements ordering is from present to past, i.e., starting position of 0
 * means the current bar.
 *
 * @param symbol_name Symbol.
 * @param timeframe Period.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param start_time Bar time, corresponding to the first element to copy.
 * @param stop_time Bar time, corresponding to the last element to copy.
 * @param low_array Array of double type.
 * @returns Returns the copied data count or -1 in case of an error.
 */
int CopyLow(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
            int count, double low_array[]);
int CopyLow(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
            int count, double low_array[]);
int CopyLow(string symbol_name, ENUM_TIMEFRAMES timeframe, datetime start_time,
            datetime stop_time, double low_array[]);

/**
 * The function gets into close_array the history data of bar close prices for
 * the selected symbol-period pair in the specified quantity. It should be noted
 * that elements ordering is from present to past, i.e., starting position of 0
 * means the current bar.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param start_time The start time for the first element to copy.
 * @param stop_time Bar time, corresponding to the last element to copy.
 * @param close_array Array of double type.
 * @returns Returns the copied data count or -1 in case of an error.
 */
int CopyClose(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
              int count, double close_array[]);
int CopyClose(string symbol_name, ENUM_TIMEFRAMES timeframe,
              datetime start_time, int count, double close_array[]);
int CopyClose(string symbol_name, ENUM_TIMEFRAMES timeframe,
              datetime start_time, datetime stop_time, double close_array[]);

/**
 * The function gets into volume_array the history data of tick volumes for the
 * selected symbol-period pair in the specified quantity. It should be noted
 * that elements ordering is from present to past, i.e., starting position of 0
 * means the current bar.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param start_time The start time for the first element to copy.
 * @param stop_time Bar time, corresponding to the last element to copy.
 * @param volume_array Array of long type.
 * @returns Returns the copied data count or -1 in case of an error.
 */
int CopyTickVolume(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
                   int count, long volume_array[]);
int CopyTickVolume(string symbol_name, ENUM_TIMEFRAMES timeframe,
                   datetime start_time, int count, long volume_array[]);
int CopyTickVolume(string symbol_name, ENUM_TIMEFRAMES timeframe,
                   datetime start_time, datetime stop_time,
                   long volume_array[]);

/**
 * The function gets into volume_array the history data of trade volumes for the
 * selected symbol-period pair in the specified quantity. It should be noted
 * that elements ordering is from present to past, i.e., starting position of 0
 * means the current bar.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param start_time The start time for the first element to copy.
 * @param stop_time Bar time, corresponding to the last element to copy.
 * @param volume_array Array of long type.
 * @returns Returns the copied data count or -1 in the case of error.
 */
int CopyRealVolume(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
                   int count, long volume_array[]);
int CopyRealVolume(string symbol_name, ENUM_TIMEFRAMES timeframe,
                   datetime start_time, int count, long volume_array[]);
int CopyRealVolume(string symbol_name, ENUM_TIMEFRAMES timeframe,
                   datetime start_time, datetime stop_time,
                   long volume_array[]);

/**
 * The function gets into spread_array the history data of spread values for the
 * selected symbol-period pair in the specified quantity. It should be noted
 * that elements ordering is from present to past, i.e., starting position of 0
 * means the current bar.
 *
 * @param symbol_name Symbol name.
 * @param timeframe Period.
 * @param start_pos The start position for the first element to copy.
 * @param count Data count to copy.
 * @param start_time The start time for the first element to copy.
 * @param stop_time Bar time, corresponding to the last element to copy.
 * @param spread_array Array of int type.
 * @returns Returns the copied data count or -1 in case of an error.
 */
int CopySpread(string symbol_name, ENUM_TIMEFRAMES timeframe, int start_pos,
               int count, int spread_array[]);
int CopySpread(string symbol_name, ENUM_TIMEFRAMES timeframe,
               datetime start_time, int count, int spread_array[]);
int CopySpread(string symbol_name, ENUM_TIMEFRAMES timeframe,
               datetime start_time, datetime stop_time, int spread_array[]);

/**
 * The function receives ticks in the MqlTick format into ticks_array. In this
 * case, ticks are indexed from the past to the present, i.e. the 0 indexed tick
 * is the oldest one in the array. For tick analysis, check the flags field,
 * which shows what exactly has changed in the tick.
 *
 * @param symbol_name Symbol.
 * @param ticks_array An array of the MqlTick type for receiving ticks.
 * @param flags A flag to define the type of the requested ticks.
 * COPY_TICKS_INFO – ticks with Bid and/or Ask changes, COPY_TICKS_TRADE – ticks
 * with changes in Last and Volume, COPY_TICKS_ALL – all ticks. For any type of
 * request, the values of the previous tick are added to the remaining fields of
 * the MqlTick structure.
 * @param from The date from which you want to request ticks. In milliseconds
 * since 1970.01.01. If from=0, the last count ticks will be returned.
 * @param count The number of requested ticks. If the 'from' and 'count'
 * parameters are not specified, all available recent ticks (but not more than
 * 2000) will be written to ticks_array[].
 * @returns The number of copied tick or -1 in case of an error.
 */
int CopyTicks(string symbol_name, MqlTick ticks_array[],
              uint flags = COPY_TICKS_ALL, ulong from = 0, uint count = 0);

/**
 * The function receives ticks in the MqlTick format within the specified date
 * range to ticks_array. Indexing goes from the past to the present meaning that
 * a tick with the index 0 is the oldest one in the array. For tick analysis,
 * check the flags field, which shows what exactly has changed.
 *
 * @param symbol_name Symbol.
 * @param ticks_array MqlTick static or dynamic array for receiving ticks. If
 * the static array cannot hold all the ticks from the requested time interval,
 * the maximum possible amount of ticks is received. In this case, the function
 * generates the error ERR_HISTORY_SMALL_BUFFER (4407).
 * @param flags A flag to define the type of the requested ticks. For any type
 * of request, the values of the previous tick are added to the remaining fields
 * of the MqlTick structure.
 * @param from_msc The date, from which you want to request ticks. In
 * milliseconds since 1970.01.01. If the from_msc parameter is not specified,
 * ticks from the beginning of the history are sent. Ticks with the time >=
 * from_msc are sent.
 * @param to_msc The date, up to which you want to request ticks. In
 * milliseconds since 01.01.1970. Ticks with the time <= to_msc are sent. If the
 * to_msc parameter is not specified, all ticks up to the end of the history are
 * sent.
 * @returns The number of copied tick or -1 in case of an error. GetLastError()
 * is able to return the following errors:
 *
 * ERR_HISTORY_TIMEOUT – ticks synchronization waiting time is up, the function
 * has sent all it had.
 * ERR_HISTORY_SMALL_BUFFER – static buffer is too small. Only the amount the
 * array can store has been sent.
 * ERR_NOT_ENOUGH_MEMORY – insufficient memory for receiving a history from the
 * specified range to the dynamic tick array. Failed to allocate enough memory
 * for the tick array.
 */
int CopyTicksRange(const string symbol_name, MqlTick ticks_array[],
                   uint flags = COPY_TICKS_ALL, ulong from_msc = 0,
                   ulong to_msc = 0);

/**
 * The function calculates the margin required for the specified order type, on
 * the current account, in the current market environment not taking into
 * account current pending orders and open positions. It allows the evaluation
 * of margin for the trade operation planned. The value is returned in the
 * account currency.
 *
 * @param action The order type, can be one of the values of the ENUM_ORDER_TYPE
 * enumeration.
 * @param symbol Symbol name.
 * @param volume Volume of the trade operation.
 * @param price Open price.
 * @param margin The variable, to which the value of the required margin will be
 * written in case the function is successfully executed. The calculation is
 * performed as if there were no pending orders and open positions on the
 * current account. The margin value depends on many factors, and can differ in
 * different market environments.
 * @returns The function returns true in case of success; otherwise it returns
 * false. In order to obtain information about the error, call the
 * GetLastError() function.
 */
bool OrderCalcMargin(ENUM_ORDER_TYPE action, string symbol, double volume,
                     double price, double &margin);

/**
 * The function calculates the profit for the current account, in the current
 * market conditions, based on the parameters passed. The function is used for
 * pre-evaluation of the result of a trade operation. The value is returned in
 * the account currency.
 *
 * @param action Type of the order, can be one of the two values of the
 * ENUM_ORDER_TYPE enumeration: ORDER_TYPE_BUY or ORDER_TYPE_SELL.
 * @param symbol Symbol name.
 * @param volume Volume of the trade operation.
 * @param price_open Open price.
 * @param price_close Close price.
 * @param profit The variable, to which the calculated value of the profit will
 * be written in case the function is successfully executed. The estimated
 * profit value depends on many factors, and can differ in different market
 * environments.
 * @returns The function returns true in case of success; otherwise it returns
 * false. If an invalid order type is specified, the function will return false.
 * In order to obtain information about the error, call GetLastError().
 */
bool OrderCalcProfit(ENUM_ORDER_TYPE action, string symbol, double volume,
                     double price_open, double price_close, double &profit);

/**
 * The OrderCheck() function checks if there are enough money to execute a
 * required trade operation. The check results are placed to the fields of the
 * MqlTradeCheckResult structure.
 *
 * @param request Pointer to the structure of the MqlTradeRequest type, which
 * describes the required trade action.
 * @param result [in,out] Pointer to the structure of the MqlTradeCheckResult
 * type, to which the check result will be placed.
 * @returns If funds are not enough for the operation, or parameters are filled
 * out incorrectly, the function returns false. In case of a successful basic
 * check of structures (check of pointers), it returns true. However, this is
 * not an indication that the requested trade operation is sure to be
 * successfully executed. For a more detailed description of the function
 * execution result, analyze the fields of the result structure.
 */
bool OrderCheck(MqlTradeRequest &request, MqlTradeCheckResult &result);

/**
 * The OrderSend() function is used for executing trade operations by sending
 * requests to a trade server.
 *
 * @param request Pointer to a structure of MqlTradeRequest type describing the
 * trade activity of the client.
 * @param result [in,out] Pointer to a structure of MqlTradeResult type
 * describing the result of trade operation in case of a successful completion
 * (if true is returned).
 * @returns In case of a successful basic check of structures (index checking)
 * returns true. However, this is not a sign of successful execution of a trade
 * operation. For a more detailed description of the function execution result,
 * analyze the fields of result structure.
 */
bool OrderSend(MqlTradeRequest &request, MqlTradeResult &result);

/**
 * The OrderSendAsync() function is used for conducting asynchronous trade
 * operations without waiting for the trade server's response to a sent request.
 * The function is designed for high-frequency trading, when under the terms of
 * the trading algorithm it is unacceptable to waste time waiting for a response
 * from the server.
 *
 * @param request A pointer to a structure of the MqlTradeRequest type that
 * describes the trade action of the client.
 * @param result A pointer to a structure of the MqlTradeResult type
 * that describes the result of a trade operation in case of successful
 * execution of the function (if true is returned).
 * @returns Returns true if the request is sent to a trade server. In case the
 * request is not sent, it returns false. In case the request is sent, in the
 * result variable the response code contains TRADE_RETCODE_PLACED value (code
 * 10008) – "order placed". Successful execution means only the fact of sending,
 * but does not give any guarantee that the request has reached the trade server
 * and has been accepted for processing. When processing the received request, a
 * trade server sends a reply to a client terminal notifying of change in the
 * current state of positions, orders and deals, which leads to the generation
 * of the Trade event.
 *
 * The result of executing the trade request on a server
 * sent by OrderSendAsync() function can be tracked by OnTradeTransaction
 * handler. It should be noted that OnTradeTransaction handler will be called
 * several times when executing one trade request.
 *
 * For example, when sending a market buy order, it is handled, an appropriate
 * buy order is created for the account, the order is then executed and removed
 * from the list of the open ones, then it is added to the orders history, an
 * appropriate deal is added to the history and a new position is created.
 * OnTradeTransaction function will be called for each of these events. To get
 * such a data, the function parameters should be analyzed:
 *
 * trans - this parameter gets MqlTradeTransaction structure describing a trade
 * transaction applied to a trade account; request - this parameter gets
 * MqlTradeRequest structure describing the trade request resulted in a trade
 * transaction; result - this parameter gets MqlTradeResult structure describing
 * a trade request execution result.
 */
bool OrderSendAsync(MqlTradeRequest &request, MqlTradeResult &result);

/**
 * Returns the number of open positions.
 *
 * @returns Value of int type.
 */
int PositionsTotal();

/**
 * Returns the symbol corresponding to the open position and automatically
 * selects the position for further working with it using functions
 * PositionGetDouble, PositionGetInteger, PositionGetString.
 *
 * @param index Number of the position in the list of open positions.
 * @returns Value of the string type. If the position was not found, an empty
 * string will be returned. To get an error code, call the GetLastError()
 * function.
 */
string PositionGetSymbol(int index);

/**
 * Chooses an open position for further working with it. Returns true if the
 * function is successfully completed.
 *
 * @param symbol Name of the financial security.
 * @returns false in case of failure. To obtain information about the error,
 * call GetLastError().
 */
bool PositionSelect(string symbol);

/**
 * Selects an open position to work with based on the ticket number specified in
 * the position. If successful, returns true. Returns false if the function
 * failed. Call GetLastError() for error details.
 *
 * @param ticket Position ticket.
 * @returns A value of the bool type.
 */
bool PositionSelectByTicket(ulong ticket);

/**
 * The function returns the requested property of an open position, pre-selected
 * using PositionGetSymbol or PositionSelect. The position property must be of
 * the double type. There are 2 variants of the function.
 *
 * @param property_id Identifier of a position property. The value can be one of
 * the values of the ENUM_POSITION_PROPERTY_DOUBLE enumeration.
 * @param double_var Variable of the double type, accepting the value of the
 * requested property.
 * @returns Value of the double type. If the function fails, 0 is returned.
 */
double PositionGetDouble(ENUM_POSITION_PROPERTY_DOUBLE property_id);
bool PositionGetDouble(ENUM_POSITION_PROPERTY_DOUBLE property_id,
                       double &double_var);

/**
 * The function returns the requested property of an open position, pre-selected
 * using PositionGetSymbol or PositionSelect. The position property should be of
 * datetime, int type. There are 2 variants of the function.
 *
 * @param property_id Identifier of a position property. The value can be one of
 * the values of the ENUM_POSITION_PROPERTY_INTEGER enumeration.
 * @param long_var Variable of the long type accepting the value of the
 * requested property.
 * @returns Value of the long type. If the function fails, 0 is returned.
 */
long PositionGetInteger(ENUM_POSITION_PROPERTY_INTEGER property_id);
bool PositionGetInteger(ENUM_POSITION_PROPERTY_INTEGER property_id,
                        long &long_var);

/**
 * The function returns the requested property of an open position, pre-selected
 * using PositionGetSymbol or PositionSelect. The position property should be of
 * the string type. There are 2 variants of the function.
 *
 * @param property_id Identifier of a position property. The value can be one of
 * the values of the ENUM_POSITION_PROPERTY_STRING enumeration.
 * @param string_var Variable of the string type accepting the value of the
 * requested property.
 * @returns Value of the string type. If the function fails, an empty string is
 * returned.
 */
string PositionGetString(ENUM_POSITION_PROPERTY_STRING property_id);
bool PositionGetString(ENUM_POSITION_PROPERTY_STRING property_id,
                       string &string_var);

/**
 * The function returns the ticket of a position with the specified index in the
 * list of open positions and automatically selects the position to work with
 * using functions PositionGetDouble, PositionGetInteger, PositionGetString.
 *
 * @param index The index of a position in the list of open positions,
 * numeration starts with 0.
 * @returns The ticket of the position. Returns 0 if the function fails.
 */
ulong PositionGetTicket(int index);

/**
 * Returns the number of current orders.
 */
int OrdersTotal();

/**
 * Returns ticket of a corresponding order and automatically selects the order
 * for further working with it using functions.
 *
 * @param index Number of an order in the list of current orders.
 * @returns Value of the ulong type. If the function fails, 0 is returned.
 */
ulong OrderGetTicket(int index);

/**
 * Selects an order to work with. Returns true if the function has been
 * successfully completed. Returns false if the function completion has failed.
 * For more information about an error call GetLastError().
 *
 * @param ticket Order ticket.
 * @returns Value of the bool type.
 */
bool OrderSelect(ulong ticket);

/**
 * Returns the requested property of an order, pre-selected using OrderGetTicket
 * or OrderSelect. The order property must be of the double type. There are 2
 * variants of the function.
 *
 * @param property_id Identifier of the order property. The value can be one of
 * the values of the ENUM_ORDER_PROPERTY_DOUBLE enumeration.
 * @param double_var Variable of the double type that accepts the value of the
 * requested property.
 * @returns Value of the double type. If the function fails, 0 is returned.
 */
double OrderGetDouble(ENUM_ORDER_PROPERTY_DOUBLE property_id);
bool OrderGetDouble(ENUM_ORDER_PROPERTY_DOUBLE property_id, double &double_var);

/**
 * Returns the requested order property, pre-selected using OrderGetTicket or
 * OrderSelect. Order property must be of the datetime, int type. There are 2
 * variants of the function.
 *
 * @param property_id Identifier of the order property. The value can be one of
 * the values of the ENUM_ORDER_PROPERTY_INTEGER enumeration.
 * @param long_var Variable of the long type that accepts the value of the
 * requested property.
 * @returns Value of the long type. If the function fails, 0 is returned.
 */
long OrderGetInteger(ENUM_ORDER_PROPERTY_INTEGER property_id);
bool OrderGetInteger(ENUM_ORDER_PROPERTY_INTEGER property_id, long &long_var);

/**
 * Returns the requested order property, pre-selected using OrderGetTicket or
 * OrderSelect. The order property must be of the string type. There are 2
 * variants of the function.
 *
 * @param property_id Identifier of the order property. The value can be one of
 * the values of the ENUM_ORDER_PROPERTY_STRING enumeration.
 * @param string_var Variable of the string type that accepts the value of the
 * requested property.
 * @returns Value of the string type.
 */
string OrderGetString(ENUM_ORDER_PROPERTY_STRING property_id);
bool OrderGetString(ENUM_ORDER_PROPERTY_STRING property_id, string &string_var);

/**
 * Retrieves the history of deals and orders for the specified period of server
 * time.
 *
 * @param from_date Start date of the request.
 * @param to_date End date of the request.
 * @returns It returns true if successful, otherwise returns false.
 */
bool HistorySelect(datetime from_date, datetime to_date);

/**
 * Retrieves the history of deals and orders having the specified position
 * identifier.
 *
 * @param position_id Position identifier that is set to every executed order
 * and every deal.
 * @returns It returns true if successful, otherwise returns false.
 */
bool HistorySelectByPosition(long position_id);

/**
 * Selects an order from the history for further calling it through appropriate
 * functions. It returns true if the function has been successfully completed.
 * Returns false if the function has failed. For more details on error call
 * GetLastError().
 *
 * @param ticket Order ticket.
 * @returns Returns true if successful, otherwise false.
 */
bool HistoryOrderSelect(ulong ticket);

/**
 * Returns the number of orders in the history. Prior to calling
 * HistoryOrdersTotal(), first it is necessary to receive the history of deals
 * and orders using the HistorySelect() or HistorySelectByPosition() function.
 *
 * @returns Value of the int type.
 */
int HistoryOrdersTotal();

/**
 * Return the ticket of a corresponding order in the history. Prior to calling
 * HistoryOrderGetTicket(), first it is necessary to receive the history of
 * deals and orders using the HistorySelect() or HistorySelectByPosition()
 * function.
 *
 * @param index Number of the order in the list of orders.
 * @returns Value of the ulong type. If the function fails, 0 is returned.
 */
ulong HistoryOrderGetTicket(int index);

/**
 * Returns the requested order property. The order property must be of the
 * double type. There are 2 variants of the function.
 *
 * @param ticket_number Order ticket.
 * @param property_id Identifier of the order property. The value can be one of
 * the values of the ENUM_ORDER_PROPERTY_DOUBLE enumeration.
 * @param double_var Variable of the double type that accepts the value of the
 * requested property.
 * @returns Value of the double type.
 */
double HistoryOrderGetDouble(ulong ticket_number,
                             ENUM_ORDER_PROPERTY_DOUBLE property_id);
bool HistoryOrderGetDouble(ulong ticket_number,
                           ENUM_ORDER_PROPERTY_DOUBLE property_id,
                           double &double_var);

/**
 * Returns the requested property of an order. The order property must be of
 * datetime, int type. There are 2 variants of the function.
 *
 * @param ticket_number Order ticket.
 * @param property_id Identifier of the order property. The value can be one of
 * the values of the ENUM_ORDER_PROPERTY_INTEGER enumeration.
 * @param long_var Variable of the long type that accepts the value of the
 * requested property.
 * @returns Value of the long type.
 */
long HistoryOrderGetInteger(ulong ticket_number,
                            ENUM_ORDER_PROPERTY_INTEGER property_id);
bool HistoryOrderGetInteger(ulong ticket_number,
                            ENUM_ORDER_PROPERTY_INTEGER property_id,
                            long &long_var);

/**
 * Returns the requested property of an order. The order property must be of the
 * string type. There are 2 variants of the function.
 *
 * @param ticket_number Order ticket.
 * @param property_id Identifier of the order property. The value can be one of
 * the values of the ENUM_ORDER_PROPERTY_STRING enumeration.
 * @param string_var Variable of the string type.
 * @returns Value of the string type.
 */
string HistoryOrderGetString(ulong ticket_number,
                             ENUM_ORDER_PROPERTY_STRING property_id);
bool HistoryOrderGetString(ulong ticket_number,
                           ENUM_ORDER_PROPERTY_STRING property_id,
                           string &string_var);

/**
 * Selects a deal in the history for further calling it through appropriate
 * functions. It returns true if the function has been successfully completed.
 * Returns false if the function has failed. For more details on error call
 * GetLastError().
 *
 * @param ticket Deal ticket.
 * @returns Returns true if successful, otherwise false.
 */
bool HistoryDealSelect(ulong ticket);

/**
 * Returns the number of deal in history. Prior to calling HistoryDealsTotal(),
 * first it is necessary to receive the history of deals and orders using the
 * HistorySelect() or HistorySelectByPosition() function.
 *
 * @returns Value of the int type.
 */
int HistoryDealsTotal();

/**
 * The function selects a deal for further processing and returns the deal
 * ticket in history. Prior to calling HistoryDealGetTicket(), first it is
 * necessary to receive the history of deals and orders using the
 * HistorySelect() or HistorySelectByPosition() function.
 *
 * @param index Number of a deal in the list of deals
 * @returns Value of the ulong type. If the function fails, 0 is returned.
 */
ulong HistoryDealGetTicket(int index);

/**
 * Returns the requested property of a deal. The deal property must be of the
 * double type. There are 2 variants of the function.
 *
 * @param ticket_number Deal ticket.
 * @param property_id Identifier of a deal property. The value can be one of the
 * values of the ENUM_DEAL_PROPERTY_DOUBLE enumeration.
 * @param double_var Variable of the double type that accepts the value of the
 * requested property.
 * @returns Value of the double type.
 */
double HistoryDealGetDouble(ulong ticket_number,
                            ENUM_DEAL_PROPERTY_DOUBLE property_id);
bool HistoryDealGetDouble(ulong ticket_number,
                          ENUM_DEAL_PROPERTY_DOUBLE property_id,
                          double &double_var);

/**
 * Returns the requested property of a deal. The deal property must be of the
 * datetime, int type. There are 2 variants of the function.
 *
 * @param ticket_number Trade ticket.
 * @param property_id Identifier of the deal property. The value can be one of
 * the values of the ENUM_DEAL_PROPERTY_INTEGER enumeration.
 * @param long_var Variable of the long type that accepts the value of the
 * requested property.
 * @returns Value of the long type.
 */
long HistoryDealGetInteger(ulong ticket_number,
                           ENUM_DEAL_PROPERTY_INTEGER property_id);
bool HistoryDealGetInteger(ulong ticket_number,
                           ENUM_DEAL_PROPERTY_INTEGER property_id,
                           long &long_var);

/**
 * Returns the requested property of a deal. The deal property must be of the
 * string type. There are 2 variants of the function.
 *
 * @param ticket_number Deal ticket.
 * @param property_id Identifier of the deal property. The value can be one of
 * the values of the ENUM_DEAL_PROPERTY_STRING enumeration.
 * @param string_var Variable of the string type that accepts the value of the
 * requested property.
 * @returns Value of the string type.
 */
string HistoryDealGetString(ulong ticket_number,
                            ENUM_DEAL_PROPERTY_STRING property_id);
bool HistoryDealGetString(ulong ticket_number,
                          ENUM_DEAL_PROPERTY_STRING property_id,
                          string &string_var);

/**
 * Returns the value of double type property for selected signal.
 *
 * @param property_id Signal property identifier. The value can be one of the
 * values of the ENUM_SIGNAL_BASE_DOUBLE enumeration.
 * @returns The value of double type property of the selected signal.
 */
double SignalBaseGetDouble(ENUM_SIGNAL_BASE_DOUBLE property_id);

/**
 * Returns the value of integer type property for selected signal.
 *
 * @param property_id Signal property identifier. The value can be one of the
 * values of the ENUM_SIGNAL_BASE_INTEGER enumeration.
 * @returns The value of integer type property of the selected signal.
 */
long SignalBaseGetInteger(ENUM_SIGNAL_BASE_INTEGER property_id);

/**
 * Returns the value of string type property for selected signal.
 *
 * @param property_id Signal property identifier. The value can be one of the
 * values of the ENUM_SIGNAL_BASE_STRING enumeration.
 * @returns The value of string type property of the selected signal.
 */
string SignalBaseGetString(ENUM_SIGNAL_BASE_STRING property_id);

/**
 * Selects a signal from signals, available in terminal for further working with
 * it.
 *
 * @param index Signal index in base of trading signals.
 * @returns Returns true if successful, otherwise returns false. To read more
 * about the error call GetLastError().
 */
bool SignalBaseSelect(int index);

/**
 * Returns the total amount of signals, available in terminal.
 *
 * @returns The total amount of signals, available in terminal.
 */
int SignalBaseTotal();

/**
 * Returns the value of double type property of signal copy settings.
 *
 * @param property_id Signal copy settings property identifier. The value can be
 * one of the values of the ENUM_SIGNAL_INFO_DOUBLE enumeration.
 * @returns The value of double type property of signal copy settings.
 */
double SignalInfoGetDouble(ENUM_SIGNAL_INFO_DOUBLE property_id);

/**
 * Returns the value of integer type property of signal copy settings.
 *
 * @param property_id Signal copy settings property identifier. The value can be
 * one of the values of the ENUM_SIGNAL_INFO_INTEGER enumeration.
 * @returns The value of integer type property of signal copy settings.
 */
long SignalInfoGetInteger(ENUM_SIGNAL_INFO_INTEGER property_id);

/**
 * Returns the value of string type property of signal copy settings.
 *
 * @param property_id Signal copy settings property identifier. The value can be
 * one of the values of the ENUM_SIGNAL_INFO_STRING enumeration.
 * @returns The value of string type property of signal copy settings.
 */
string SignalInfoGetString(ENUM_SIGNAL_INFO_STRING property_id);

/**
 * Sets the value of double type property of signal copy settings.
 *
 * @param property_id Signal copy settings property identifier. The value can be
 * one of the values of the ENUM_SIGNAL_INFO_DOUBLE enumeration.
 * @param value The value of signal copy settings property.
 * @returns Returns true if property has been changed, otherwise returns false.
 * To read more about the error call GetLastError().
 */
bool SignalInfoSetDouble(ENUM_SIGNAL_INFO_DOUBLE property_id, double value);

/**
 * Sets the value of integer type property of signal copy settings.
 *
 * @param property_id Signal copy settings property identifier. The value can be
 * one of the values of the ENUM_SIGNAL_INFO_INTEGER enumeration.
 * @param value The value of signal copy settings property.
 * @returns Returns true if property has been changed, otherwise returns false.
 * To read more about the error call GetLastError().
 */
bool SignalInfoSetInteger(ENUM_SIGNAL_INFO_INTEGER property_id, long value);

/**
 * Subscribes to the trading signal.
 *
 * @param signal_id Signal identifier.
 * @returns Returns true if subscription was successful, otherwise returns
 * false. To read more about the error call GetLastError().
 */
bool SignalSubscribe(long signal_id);

/**
 * Cancels subscription.
 *
 * @returns Returns true if subscription has been canceled successfully,
 * otherwise returns false. To read more about the error call GetLastError().
 */
bool SignalUnsubscribe();

#endif
