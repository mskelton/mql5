#ifndef EQUAL_FUNCTION_H
#define EQUAL_FUNCTION_H

#include <Generic\Interfaces\IEqualityComparable.mqh>

template <typename T> bool Equals(T x, T y) {

  IEqualityComparable<T> *equtable = dynamic_cast<IEqualityComparable<T> *>(x);
  if (equtable) {

    return equtable.Equals(y);
  } else {

    return (x == y);
  }
}

#endif
