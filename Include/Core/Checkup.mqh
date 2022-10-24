#ifndef CORE_CHECKUP_H
#define CORE_CHECKUP_H

#include <Core/DataTypes.mqh>
#include <Core/Enums.mqh>

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

#endif
