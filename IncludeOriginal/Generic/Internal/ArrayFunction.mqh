#ifndef ARRAY_FUNCTION_H
#define ARRAY_FUNCTION_H

#include "CompareFunction.mqh"
#include <Generic\Interfaces\IComparer.mqh>

template <typename T>
int ArrayBinarySearch(T &array[], const int start_index, const int count,
                      T value, IComparer<T> *comparer) {
  int lo = start_index;
  int hi = start_index + count - 1;
  int size = ArraySize(array);

  if (size == 0)
    return (-1);

  if (CheckPointer(comparer) == POINTER_INVALID)
    return (-1);

  if (start_index < 0 || count < 0 || size - start_index < count)
    return (-1);

  while (lo <= hi) {
    int i = lo + ((hi - lo) >> 1);
    int order = comparer.Compare(array[i], value);
    if (order == 0) {
      return (i);
    }
    if (order < 0) {
      lo = i + 1;
    } else {
      hi = i - 1;
    }
  }

  if (lo > 0)
    return (lo - 1);
  return (lo);
}

template <typename T>
int ArrayIndexOf(T &array[], T value, const int start_index, const int count) {
  int size = ArraySize(array);

  if (size == 0)
    return (-1);

  if (start_index < 0 || start_index > size || count < 0 ||
      count > size - start_index)
    return (-1);

  int end_index = start_index + count;
  for (int i = start_index; i < end_index; i++) {

    if (::Equals(array[i], value)) {

      return (i);
    }
  }

  return (-1);
}

template <typename T>
int ArrayLastIndexOf(T &array[], T value, const int start_index,
                     const int count) {
  int size = ArraySize(array);

  if (size == 0)
    return (-1);

  if (start_index < 0 || start_index >= size || count < 0 ||
      count > start_index + 1)
    return (-1);

  int end_index = start_index - count + 1;
  for (int i = start_index; i >= end_index; i--) {

    if (::Equals(array[i], value)) {

      return (i);
    }
  }

  return (-1);
}

template <typename T>
bool ArrayReverse(T &array[], const int start_index, const int count) {
  int size = ArraySize(array);

  if (count < 0 || size - start_index < count)
    return (false);

  int i = start_index;
  int j = start_index + count - 1;
  while (i < j) {
    T temp = array[i];
    array[i] = array[j];
    array[j] = temp;
    i++;
    j--;
  }
  return (true);
}

#endif
