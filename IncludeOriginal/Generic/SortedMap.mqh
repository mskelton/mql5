#ifndef SORTED_MAP_H
#define SORTED_MAP_H

#include "HashMap.mqh"
#include "SortedSet.mqh"
#include <Generic\Interfaces\IComparer.mqh>
#include <Generic\Interfaces\IMap.mqh>
#include <Generic\Internal\CompareFunction.mqh>
#include <Generic\Internal\DefaultComparer.mqh>

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

  bool Add(CKeyValuePair<TKey, TValue> *value) {
    return m_tree.Add(value);
  }
  bool Add(TKey key, TValue value);

  int Count(void) {
    return m_tree.Count();
  }
  bool Contains(CKeyValuePair<TKey, TValue> *item) {
    return m_tree.Contains(item);
  }
  bool Contains(TKey key, TValue value);
  bool ContainsKey(TKey key);
  bool ContainsValue(TValue value);
  IComparer<TKey> *Comparer(void) const {
    return (m_comparer);
  }

  int CopyTo(CKeyValuePair<TKey, TValue> *&dst_array[],
             const int dst_start = 0);
  int CopyTo(TKey &dst_keys[], TValue &dst_values[], const int dst_start = 0);

  void Clear(void);
  bool Remove(CKeyValuePair<TKey, TValue> *item) {
    return m_tree.Remove(item);
  }
  bool Remove(TKey key);

  bool TryGetValue(TKey key, TValue &value);
  bool TrySetValue(TKey key, TValue value);

private:
  static void ClearNodes(
      CRedBlackTreeNode<CKeyValuePair<TKey, TValue> *> *node);
};

template <typename TKey, typename TValue> CSortedMap::CSortedMap(void) {

  m_comparer = new CDefaultComparer<TKey>();
  m_delete_comparer = true;
  m_tree = new CRedBlackTree<CKeyValuePair<TKey, TValue> *>(
      new CKeyValuePairComparer<TKey, TValue>(m_comparer));
}

template <typename TKey, typename TValue>
CSortedMap::CSortedMap(IComparer<TKey> *comparer) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultComparer<TKey>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }
  m_tree = new CRedBlackTree<CKeyValuePair<TKey, TValue> *>(
      new CKeyValuePairComparer<TKey, TValue>(m_comparer));
}

template <typename TKey, typename TValue>
CSortedMap::CSortedMap(IMap<TKey, TValue> *map) {

  m_comparer = new CDefaultComparer<TKey>();
  m_delete_comparer = true;
  m_tree = new CRedBlackTree<CKeyValuePair<TKey, TValue> *>(
      map, new CKeyValuePairComparer<TKey, TValue>(m_comparer));
}

template <typename TKey, typename TValue>
CSortedMap::CSortedMap(IMap<TKey, TValue> *map, IComparer<TKey> *comparer) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultComparer<TKey>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }
  m_tree = new CRedBlackTree<CKeyValuePair<TKey, TValue> *>(
      map, new CKeyValuePairComparer<TKey, TValue>(m_comparer));
}

template <typename TKey, typename TValue> CSortedMap::~CSortedMap(void) {

  if (m_delete_comparer)
    delete m_comparer;

  delete m_tree.Comparer();

  ClearNodes(m_tree.Root());

  delete m_tree;
}

template <typename TKey, typename TValue>
static void CSortedMap::ClearNodes(
    CRedBlackTreeNode<CKeyValuePair<TKey, TValue> *> *node) {

  if (CheckPointer(node) == POINTER_INVALID)
    return;

  if (!node.Right().IsLeaf())
    ClearNodes(node.Right());

  delete node.Value();

  if (!node.Left().IsLeaf())
    ClearNodes(node.Left());
}

template <typename TKey, typename TValue>
bool CSortedMap::Add(TKey key, TValue value) {

  CKeyValuePair<TKey, TValue> *pair =
      new CKeyValuePair<TKey, TValue>(key, value);

  bool success = m_tree.Add(pair);

  if (!success)
    delete pair;
  return (success);
}

template <typename TKey, typename TValue>
bool CSortedMap::Contains(TKey key, TValue value) {

  CKeyValuePair<TKey, TValue> pair(key, NULL);
  CRedBlackTreeNode<CKeyValuePair<TKey, TValue> *> *node =
      m_tree.Find(GetPointer(pair));

  CDefaultEqualityComparer<TValue> comaprer;

  if (CheckPointer(node) != POINTER_INVALID &&
      comaprer.Equals(value, node.Value().Value()))
    return (true);
  return (false);
}

template <typename TKey, typename TValue>
bool CSortedMap::ContainsKey(TKey key) {

  CKeyValuePair<TKey, TValue> pair(key, NULL);

  return m_tree.Contains(GetPointer(pair));
}

template <typename TKey, typename TValue>
bool CSortedMap::ContainsValue(TValue value) {

  CKeyValuePair<TKey, TValue> *array[];
  int count = m_tree.CopyTo(array);

  CDefaultEqualityComparer<TValue> comaprer;

  for (int i = 0; i < count; i++)
    if (comaprer.Equals(value, array[i].Value()))
      return (true);
  return (false);
}

template <typename TKey, typename TValue>
int CSortedMap::CopyTo(CKeyValuePair<TKey, TValue> *&dst_array[],
                       const int dst_start = 0) {
  int result = m_tree.CopyTo(dst_array, dst_start);
  if (result > 0) {

    for (int i = 0; i < result; i++)
      dst_array[dst_start + i] = dst_array[dst_start + i].Clone();
  }
  return (result);
}

template <typename TKey, typename TValue>
int CSortedMap::CopyTo(TKey &dst_keys[], TValue &dst_values[],
                       const int dst_start = 0) {

  CKeyValuePair<TKey, TValue> *array[];
  int count = m_tree.CopyTo(array);

  if (count > 0) {

    if (dst_start + count > ArraySize(dst_keys))
      ArrayResize(dst_keys, dst_start + count);

    if (dst_start + count > ArraySize(dst_values))
      ArrayResize(dst_values, MathMin(ArraySize(dst_keys), dst_start + count));

    int index = 0;
    while (index < count && dst_start + index < ArraySize(dst_keys) &&
           dst_start + index < ArraySize(dst_values)) {
      dst_keys[dst_start + index] = array[index].Key();
      dst_values[dst_start + index] = array[index].Value();
      index++;
    }
    return (index);
  }
  return (0);
}

template <typename TKey, typename TValue> void CSortedMap::Clear(void) {

  if (m_tree.Count() > 0) {

    ClearNodes(m_tree.Root());

    m_tree.Clear();
  }
}

template <typename TKey, typename TValue> bool CSortedMap::Remove(TKey key) {

  CKeyValuePair<TKey, TValue> pair(key, NULL);

  CRedBlackTreeNode<CKeyValuePair<TKey, TValue> *> *node =
      m_tree.Find(GetPointer(pair));

  if (CheckPointer(node) != POINTER_INVALID) {
    CKeyValuePair<TKey, TValue> *real_pair = node.Value();

    if (m_tree.Remove(node)) {

      if (CheckPointer(real_pair) == POINTER_DYNAMIC)
        delete real_pair;
      return (true);
    }
  }
  return (false);
}

template <typename TKey, typename TValue>
bool CSortedMap::TryGetValue(TKey key, TValue &value) {

  CKeyValuePair<TKey, TValue> pair(key, NULL);

  CRedBlackTreeNode<CKeyValuePair<TKey, TValue> *> *node =
      m_tree.Find(GetPointer(pair));

  if (CheckPointer(node) == POINTER_INVALID)
    return (false);

  value = node.Value().Value();
  return (true);
}

template <typename TKey, typename TValue>
bool CSortedMap::TrySetValue(TKey key, TValue value) {

  CKeyValuePair<TKey, TValue> pair(key, NULL);

  CRedBlackTreeNode<CKeyValuePair<TKey, TValue> *> *node =
      m_tree.Find(GetPointer(pair));

  if (CheckPointer(node) == POINTER_INVALID)
    return (false);

  node.Value().Value(value);
  return (true);
}

#endif
