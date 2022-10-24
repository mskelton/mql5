#ifndef IEQUALITY_COMPARER_H
#define IEQUALITY_COMPARER_H

template <typename T> interface IEqualityComparer {

  bool Equals(T x, T y);

  int HashCode(T value);
};

#endif
