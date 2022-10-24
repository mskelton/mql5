#ifndef SORTED_SET_H
#define SORTED_SET_H

#include "HashSet.mqh"
#include "RedBlackTree.mqh"
#include <Generic/Interfaces/ISet.mqh>
#include <Generic/Internal/Introsort.mqh>

template <typename T> class CSortedSet : public ISet<T> {
protected:
  CRedBlackTree<T> *m_tree;

public:
  CSortedSet(void);
  CSortedSet(IComparer<T> *comparer);
  CSortedSet(ICollection<T> *collection);
  CSortedSet(ICollection<T> *collection, IComparer<T> *comparer);
  CSortedSet(T array[]);
  CSortedSet(T array[], IComparer<T> *comparer);
  ~CSortedSet(void);

  bool Add(T value) ;

  int Count(void) ;
  bool Contains(T item) ;
  IComparer<T> *Comparer(void) const ;
  bool TryGetMin(T &min) ;
  bool TryGetMax(T &max) ;

  int CopyTo(T dst_array[], const int dst_start = 0);

  void Clear(void) ;
  bool Remove(T item) ;

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

  bool GetViewBetween(T array[], T lower_value, T upper_value);
  bool GetReverse(T array[]);
};































#endif
