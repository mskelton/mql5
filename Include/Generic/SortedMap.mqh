#ifndef SORTED_MAP_H
#define SORTED_MAP_H

#include "HashMap.mqh"
#include "SortedSet.mqh"
#include <Generic/Interfaces/IComparer.mqh>
#include <Generic/Interfaces/IMap.mqh>
#include <Generic/Internal/CompareFunction.mqh>
#include <Generic/Internal/DefaultComparer.mqh>

template <typename TKey, typename TValue>
class CSortedMap : public IMap<TKey, TValue> {
protected:
  CRedBlackTree<CKeyValuePair<TKey, TValue> *> *m_tree;
  IComparer<TKey> *m_comparer;
  bool m_delete_comparer;

public:
  CSortedMap(void);
  CSortedMap(IComparer<TKey> *comparer);
  CSortedMap(IMap<TKey, TValue> *map);
  CSortedMap(IMap<TKey, TValue> *map, IComparer<TKey> *comparer);
  ~CSortedMap(void);

  bool Add(CKeyValuePair<TKey, TValue> *value);
  bool Add(TKey key, TValue value);

  int Count(void);
  bool Contains(CKeyValuePair<TKey, TValue> *item);
  bool Contains(TKey key, TValue value);
  bool ContainsKey(TKey key);
  bool ContainsValue(TValue value);
  IComparer<TKey> *Comparer(void) const;

  int CopyTo(CKeyValuePair<TKey, TValue> *dst_array[], const int dst_start = 0);
  int CopyTo(TKey dst_keys[], TValue dst_values[], const int dst_start = 0);

  void Clear(void);
  bool Remove(CKeyValuePair<TKey, TValue> *item);
  bool Remove(TKey key);

  bool TryGetValue(TKey key, TValue &value);
  bool TrySetValue(TKey key, TValue value);

private:
  static void
  ClearNodes(CRedBlackTreeNode<CKeyValuePair<TKey, TValue> *> *node);
};

#endif
