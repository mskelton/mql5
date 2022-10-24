#ifndef CORE_FUNCTIONS_H
#define CORE_FUNCTIONS_H

#include <Core/Constants.mqh>
#include <Core/DataTypes.mqh>
#include <Core/Enums.mqh>
#include <Core/Structs.mqh>

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
