#ifndef ICOMPARABLE_H
#define ICOMPARABLE_H

#include "IEqualityComparable.mqh"

template <typename T> interface IComparable : public IEqualityComparable<T> {

  int Compare(T value);
};

#endif
