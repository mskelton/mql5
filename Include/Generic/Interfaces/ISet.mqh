#ifndef ISET_H
#define ISET_H

#include "ICollection.mqh"

template <typename T> class ISet : public ICollection<T> {

  void ExceptWith(ICollection<T> *collection);
  void ExceptWith(T array[]);
  void IntersectWith(ICollection<T> *collection);
  void IntersectWith(T array[]);
  void SymmetricExceptWith(ICollection<T> *collection);
  void SymmetricExceptWith(T array[]);
  void UnionWith(ICollection<T> *collection);
  void UnionWith(T array[]);

  bool IsProperSubsetOf(ICollection<T> *collection);
  bool IsProperSubsetOf(T array[]);
  bool IsProperSupersetOf(ICollection<T> *collection);
  bool IsProperSupersetOf(T array[]);
  bool IsSubsetOf(ICollection<T> *collection);
  bool IsSubsetOf(T array[]);
  bool IsSupersetOf(ICollection<T> *collection);
  bool IsSupersetOf(T array[]);
  bool Overlaps(ICollection<T> *collection);
  bool Overlaps(T array[]);
  bool SetEquals(ICollection<T> *collection);
  bool SetEquals(T array[]);
};

#endif
