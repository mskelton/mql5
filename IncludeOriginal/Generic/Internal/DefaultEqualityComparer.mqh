#ifndef DEFAULT_EQUALITY_COMPARER_H
#define DEFAULT_EQUALITY_COMPARER_H

#include "EqualFunction.mqh"
#include "HashFunction.mqh"
#include <Generic\Interfaces\IEqualityComparer.mqh>

template <typename T>
class CDefaultEqualityComparer : public IEqualityComparer<T> {
public:
  CDefaultEqualityComparer(void) {
  }
  ~CDefaultEqualityComparer(void) {
  }

  bool Equals(T x, T y) {
    return ::Equals(x, y);
  }

  int HashCode(T value) {
    return ::GetHashCode(value);
  }
};

#endif
