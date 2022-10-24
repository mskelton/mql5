#ifndef DEFAULT_COMPARER_H
#define DEFAULT_COMPARER_H

#include "CompareFunction.mqh"
#include <Generic\Interfaces\IComparer.mqh>

template <typename T> class CDefaultComparer : public IComparer<T> {
public:
  CDefaultComparer(void) {
  }
  ~CDefaultComparer(void) {
  }

  int Compare(T x, T y) {
    return ::Compare(x, y);
  }
};

#endif
