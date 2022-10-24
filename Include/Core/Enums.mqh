#ifndef CORE_ENUMS_H
#define CORE_ENUMS_H

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

#endif
