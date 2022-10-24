#ifndef ILIST_H
#define ILIST_H

#include "ICollection.mqh"

template <typename T> interface IList : public ICollection<T> {

  bool TryGetValue(const int index, T &value);
  bool TrySetValue(const int index, T value);

  bool Insert(const int index, T item);

  int IndexOf(T item);
  int LastIndexOf(T item);

  bool RemoveAt(const int index);
};

#endif
