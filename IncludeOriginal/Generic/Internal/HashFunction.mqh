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

int GetHashCode(const bool value) {
  return ((value) ? true : false);
}

int GetHashCode(const char value) {
  return ((int)value | ((int)value << 16));
}

int GetHashCode(const uchar value) {
  return ((int)value | ((int)value << 16));
}

int GetHashCode(const short value) {
  return (((int)((ushort)value) | (((int)value) << 16)));
}

int GetHashCode(const ushort value) {
  return ((int)value);
}

int GetHashCode(const color value) {
  return ((int)value);
}

int GetHashCode(const int value) {
  return (value);
}

int GetHashCode(const uint value) {
  return ((int)value);
}

int GetHashCode(const datetime value) {
  long ticks = (long)value;
  return (((int)ticks) ^ (int)(ticks >> 32));
}

int GetHashCode(const long value) {
  return (((int)((long)value)) ^ (int)(value >> 32));
}

int GetHashCode(const ulong value) {
  return (((int)value) ^ (int)(value >> 32));
}

int GetHashCode(const float value) {
  if (value == 0) {

    return (0);
  }
  BitInterpreter convert;
  convert.float_value = value;
  return (convert.int_value);
}

int GetHashCode(const double value) {
  if (value == 0) {

    return (0);
  }
  BitInterpreter convert;
  convert.double_value = value;
  long lvalue = convert.long_value;
  return (((int)lvalue) ^ ((int)(lvalue >> 32)));
}

int GetHashCode(const string value) {
  int len = StringLen(value);
  int hash = 0;

  if (len > 0) {

    for (int i = 0; i < len; i++)
      hash = 31 * hash + value[i];
  }
  return (hash);
}

template <typename T> int GetHashCode(T value) {

  IEqualityComparable<T> *equtable =
      dynamic_cast<IEqualityComparable<T> *>(value);
  if (equtable) {

    return equtable.HashCode();
  } else {

    return GetHashCode(typename(value));
  }
}

#endif
