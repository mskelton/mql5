#ifndef HASH_MAP_H
#define HASH_MAP_H

#include "HashSet.mqh"
#include <Generic/Interfaces/IComparable.mqh>
#include <Generic/Interfaces/IEqualityComparer.mqh>
#include <Generic/Interfaces/IMap.mqh>
#include <Generic/Internal/CompareFunction.mqh>
#include <Generic/Internal/DefaultEqualityComparer.mqh>

template <typename TKey, typename TValue> struct Entry;

template <typename TKey, typename TValue>
class CKeyValuePair : public IComparable<CKeyValuePair<TKey, TValue> *> {
protected:
  TKey m_key;
  TValue m_value;

public:
  CKeyValuePair(void);
  CKeyValuePair(TKey key, TValue value);
  ~CKeyValuePair(void);

  TKey Key(void);
  void Key(TKey key);
  TValue Value(void);
  void Value(TValue value);

  CKeyValuePair<TKey, TValue> *Clone(void);

  int Compare(CKeyValuePair<TKey, TValue> *pair);

  bool Equals(CKeyValuePair<TKey, TValue> *pair);

  int HashCode(void);
};

template <typename TKey, typename TValue>
class CKeyValuePairComparer : public IComparer<CKeyValuePair<TKey, TValue> *> {
private:
  IComparer<TKey> *m_comparer;

public:
  CKeyValuePairComparer(IComparer<TKey> *comaprer);
  int Compare(CKeyValuePair<TKey, TValue> *x, CKeyValuePair<TKey, TValue> *y);
};

template <typename TKey, typename TValue>
class CHashMap : public IMap<TKey, TValue> {
protected:
  int m_buckets;
  Entry<TKey, TValue> m_entries;
  int m_count;
  int m_capacity;
  int m_free_list;
  int m_free_count;
  IEqualityComparer<TKey> *m_comparer;
  bool m_delete_comparer;

public:
  CHashMap(void);
  CHashMap(const int capacity);
  CHashMap(IEqualityComparer<TKey> *comparer);
  CHashMap(const int capacity, IEqualityComparer<TKey> *comparer);
  CHashMap(IMap<TKey, TValue> *map);
  CHashMap(IMap<TKey, TValue> *map, IEqualityComparer<TKey> *comparer);
  ~CHashMap(void);

  bool Add(CKeyValuePair<TKey, TValue> *pair);
  bool Add(TKey key, TValue value);

  int Count(void);
  IEqualityComparer<TKey> *Comparer(void) const;
  bool Contains(CKeyValuePair<TKey, TValue> *item);
  bool Contains(TKey key, TValue value);
  bool ContainsKey(TKey key);
  bool ContainsValue(TValue value);

  int CopyTo(CKeyValuePair<TKey, TValue> *dst_array[], const int dst_start = 0);
  int CopyTo(TKey dst_keys[], TValue dst_values[], const int dst_start = 0);

  void Clear(void);
  bool Remove(CKeyValuePair<TKey, TValue> *item);
  bool Remove(TKey key);

  bool TryGetValue(TKey key, TValue &value);
  bool TrySetValue(TKey key, TValue value);

private:
  void Initialize(const int capacity);
  bool Resize(int new_size);
  int FindEntry(TKey key);
  bool Insert(TKey key, TValue value, const bool add);
  static int m_collision_threshold;
};
