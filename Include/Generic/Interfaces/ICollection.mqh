#ifndef ICOLLECTION_H
#define ICOLLECTION_H

template <typename T> class ICollection {

  bool Add(T value);

  int Count(void);
  bool Contains(T item);

  int CopyTo(T dst_array[], const int dst_start = 0);

  void Clear(void);
  bool Remove(T item);
};

#endif
