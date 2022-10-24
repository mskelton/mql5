#ifndef IEQUALITY_COMPARER_H
#define IEQUALITY_COMPARER_H

template <typename T> class IEqualityComparer {

  bool Equals(T x, T y);

  int HashCode(T value);
};

#endif
