#ifndef IEQUALITY_COMPARABLE_H
#define IEQUALITY_COMPARABLE_H

template <typename T> interface IEqualityComparable {

  bool Equals(T value);

  int HashCode(void);
};

#endif
