#ifndef ARRAY_FUNCTION_H
#define ARRAY_FUNCTION_H

#include "CompareFunction.mqh"
#include <Generic/Interfaces/IComparer.mqh>

template <typename T>
int ArrayBinarySearch(T array[], const int start_index, const int count,
                      T value, IComparer<T> *comparer);

template <typename T>
int ArrayIndexOf(T array[], T value, const int start_index, const int count);

template <typename T>
int ArrayLastIndexOf(T array[], T value, const int start_index,
                     const int count);

template <typename T>
bool ArrayReverse(T array[], const int start_index, const int count);

#endif
