#ifndef CORE_CONSTANTS_H
#define CORE_CONSTANTS_H

#include <Core/DataTypes.mqh>
#include <Core/Enums.mqh>

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

/**
 * The object is drawn in all timeframes
 */
int OBJ_ALL_PERIODS;

/**
 * The _Period variable contains the value of the timeframe of the current
 * chart.
 *
 * Also you may use the Period() function.
 */
ENUM_TIMEFRAMES _Period;

/**
 * "OK" button has been pressed
 */
int IDOK = 1;

/**
 * "Cancel" button has been pressed
 */
int IDCANCEL = 2;

/**
 * "Abort" button has been pressed
 */
int IDABORT = 3;

/**
 * "Retry" button has been pressed
 */
int IDRETRY = 4;

/**
 * "Ignore" button has been pressed
 */
int IDIGNORE = 5;

/**
 * "Yes" button has been pressed
 */
int IDYES = 6;

/**
 * "No" button has been pressed
 */
int IDNO = 7;

/**
 * "Try Again" button has been pressed
 */
int IDTRYAGAIN = 10;

/**
 * "Continue" button has been pressed
 */
int IDCONTINUE = 11;

/**
 * Message window contains only one button: OK. Default
 */
int MB_OK = 0x00000000;

/**
 * Message window contains two buttons: OK and Cancel
 */
int MB_OKCANCEL = 0x00000001;

/**
 * Message window contains three buttons: Abort, Retry and Ignore
 */
int MB_ABORTRETRYIGNORE = 0x00000002;

/**
 * Message window contains three buttons: Yes, No and Cancel
 */
int MB_YESNOCANCEL = 0x00000003;

/**
 * Message window contains two buttons: Yes and No
 */
int MB_YESNO = 0x00000004;

/**
 * Message window contains two buttons: Retry and Cancel
 */
int MB_RETRYCANCEL = 0x00000005;

/**
 * Message window contains three buttons: Cancel, Try Again, Continue
 */
int MB_CANCELTRYCONTINUE = 0x00000006;

/**
 * The STOP sign icon
 */
int MB_ICONSTOP = 0x00000010;

/**
 * The STOP sign icon
 */
int MB_ICONERROR = 0x00000010;

/**
 * The STOP sign icon
 */
int MB_ICONHAND = 0x00000010;

/**
 * The question sign icon
 */
int MB_ICONQUESTION = 0x00000020;

/**
 * The exclamation/warning sign icon
 */
int MB_ICONEXCLAMATION = 0x00000030;

/**
 * The exclamation/warning sign icon
 */
int MB_ICONWARNING = 0x00000030;

/**
 * The encircled i sign
 */
int MB_ICONINFORMATION = 0x00000040;

/**
 * The encircled i sign
 */
int MB_ICONASTERISK = 0x00000040;

/**
 * The first button MB_DEFBUTTON1 - is default, if the other buttons
 * MB_DEFBUTTON2, MB_DEFBUTTON3, or MB_DEFBUTTON4 are not specified
 */
int MB_DEFBUTTON1 = 0x00000000;

/**
 * The second button is default
 */
int MB_DEFBUTTON2 = 0x00000100;

/**
 * The third button is default
 */
int MB_DEFBUTTON3 = 0x00000200;

/**
 * The fourth button is default
 */
int MB_DEFBUTTON4 = 0x00000300;

#endif
