#ifndef COMPARE_FUNCTION_H
#define COMPARE_FUNCTION_H

#include <Generic\Interfaces\IComparable.mqh>

int Compare(const bool x, const bool y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const char x, const char y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const uchar x, const uchar y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const short x, const short y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const ushort x, const ushort y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const color x, const color y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const int x, const int y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const uint x, const uint y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const datetime x, const datetime y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const long x, const long y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const ulong x, const ulong y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const float x, const float y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const double x, const double y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

int Compare(const string x, const string y) {
  if (x > y)
    return (1);
  else if (x < y)
    return (-1);
  else
    return (0);
}

template <typename T> int Compare(T x, T y) {

  IComparable<T> *comparable = dynamic_cast<IComparable<T> *>(x);
  if (comparable) {

    return comparable.Compare(y);
  } else {

    return (0);
  }
}

#endif
