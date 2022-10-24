#ifndef HASH_FUNCTION_H
#define HASH_FUNCTION_H

union BitInterpreter {
  bool bool_value;
  char char_value;
  uchar uchar_value;
  short short_value;
  ushort ushort_value;
  color color_value;
  int int_value;
  uint uint_value;
  datetime datetime_value;
  long long_value;
  ulong ulong_value;
  float float_value;
  double double_value;
};

int GetHashCode(const bool value);

int GetHashCode(const char value);

int GetHashCode(const uchar value);

int GetHashCode(const short value);

int GetHashCode(const ushort value);

int GetHashCode(const color value);

int GetHashCode(const int value);

int GetHashCode(const uint value);

int GetHashCode(const datetime value);

int GetHashCode(const long value);

int GetHashCode(const ulong value);

int GetHashCode(const float value);

int GetHashCode(const double value);

int GetHashCode(const string value);

template <typename T> int GetHashCode(T value);

#endif
