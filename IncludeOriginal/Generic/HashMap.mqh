#ifndef HASH_MAP_H
#define HASH_MAP_H

#include "HashSet.mqh"
#include <Generic\Interfaces\IComparable.mqh>
#include <Generic\Interfaces\IEqualityComparer.mqh>
#include <Generic\Interfaces\IMap.mqh>
#include <Generic\Internal\CompareFunction.mqh>
#include <Generic\Internal\DefaultEqualityComparer.mqh>

template <typename TKey, typename TValue> struct Entry : public Slot<TValue> {
public:
  TKey key;
  Entry(void) : key((TKey)NULL) {}
};

template <typename TKey, typename TValue>
class CKeyValuePair : public IComparable<CKeyValuePair<TKey, TValue> *> {
protected:
  TKey m_key;
  TValue m_value;

public:
  CKeyValuePair(void) {}
  CKeyValuePair(TKey key, TValue value) : m_key(key), m_value(value) {}
  ~CKeyValuePair(void) {}

  TKey Key(void) {
    return (m_key);
  }
  void Key(TKey key) {
    m_key = key;
  }
  TValue Value(void) {
    return (m_value);
  }
  void Value(TValue value) {
    m_value = value;
  }

  CKeyValuePair<TKey, TValue> *Clone(void) {
    return new CKeyValuePair<TKey, TValue>(m_key, m_value);
  }

  int Compare(CKeyValuePair<TKey, TValue> *pair) {
    return ::Compare(m_key, pair.m_key);
  }

  bool Equals(CKeyValuePair<TKey, TValue> *pair) {
    return ::Equals(m_key, pair.m_key);
  }

  int HashCode(void) {
    return ::GetHashCode(m_key);
  }
};

template <typename TKey, typename TValue>
class CKeyValuePairComparer : public IComparer<CKeyValuePair<TKey, TValue> *> {
private:
  IComparer<TKey> *m_comparer;

public:
  CKeyValuePairComparer(IComparer<TKey> *comaprer) {
    m_comparer = comaprer;
  }
  int Compare(CKeyValuePair<TKey, TValue> *x, CKeyValuePair<TKey, TValue> *y) {
    return (m_comparer.Compare(x.Key(), y.Key()));
  }
};

template <typename TKey, typename TValue>
class CHashMap : public IMap<TKey, TValue> {
protected:
  int m_buckets[];
  Entry<TKey, TValue> m_entries[];
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

  int Count(void) {
    return (m_count - m_free_count);
  }
  IEqualityComparer<TKey> *Comparer(void) const {
    return (m_comparer);
  }
  bool Contains(CKeyValuePair<TKey, TValue> *item);
  bool Contains(TKey key, TValue value);
  bool ContainsKey(TKey key);
  bool ContainsValue(TValue value);

  int CopyTo(CKeyValuePair<TKey, TValue> *&dst_array[],
             const int dst_start = 0);
  int CopyTo(TKey &dst_keys[], TValue &dst_values[], const int dst_start = 0);

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

template <typename TKey, typename TValue>
CHashMap::CHashMap(void)
    : m_count(0), m_free_list(0), m_free_count(0), m_capacity(0) {

  m_comparer = new CDefaultEqualityComparer<TKey>();
  m_delete_comparer = true;
}

template <typename TKey, typename TValue>
CHashMap::CHashMap(const int capacity)
    : m_count(0), m_free_list(0), m_free_count(0), m_capacity(0) {

  if (capacity > 0)
    Initialize(capacity);

  m_comparer = new CDefaultEqualityComparer<TKey>();
  m_delete_comparer = true;
}

template <typename TKey, typename TValue>
CHashMap::CHashMap(IEqualityComparer<TKey> *comparer)
    : m_count(0), m_free_list(0), m_free_count(0), m_capacity(0) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultEqualityComparer<TKey>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }
}

template <typename TKey, typename TValue>
CHashMap::CHashMap(const int capacity, IEqualityComparer<TKey> *comparer)
    : m_count(0), m_free_list(0), m_free_count(0), m_capacity(0) {
  if (capacity > 0)
    Initialize(capacity);

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultEqualityComparer<TKey>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }
}

template <typename TKey, typename TValue>
CHashMap::CHashMap(IMap<TKey, TValue> *map)
    : m_count(0), m_free_list(0), m_free_count(0), m_capacity(0) {

  m_comparer = new CDefaultEqualityComparer<TKey>();
  m_delete_comparer = true;

  if (CheckPointer(map) != POINTER_INVALID && map.Count() > 0) {

    Initialize(map.Count());
    TKey keys[];
    TValue values[];
    map.CopyTo(keys, values);

    for (int i = 0; i < map.Count(); i++)
      Add(keys[i], values[i]);
  }
}

template <typename TKey, typename TValue>
CHashMap::CHashMap(IMap<TKey, TValue> *map, IEqualityComparer<TKey> *comparer)
    : m_count(0), m_free_list(0), m_free_count(0), m_capacity(0) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultEqualityComparer<TKey>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }

  if (CheckPointer(map) != POINTER_INVALID && map.Count() > 0) {

    Initialize(map.Count());
    TKey keys[];
    TValue values[];
    map.CopyTo(keys, values);

    for (int i = 0; i < map.Count(); i++)
      Add(keys[i], values[i]);
  }
}

template <typename TKey, typename TValue> CHashMap::~CHashMap(void) {
  if (m_delete_comparer)
    delete m_comparer;
}

template <typename TKey, typename TValue>
bool CHashMap::Add(CKeyValuePair<TKey, TValue> *pair) {

  if (CheckPointer(pair) == POINTER_INVALID)
    return (false);
  return (Add(pair.Key(), pair.Value()));
}

template <typename TKey, typename TValue>
bool CHashMap::Add(TKey key, TValue value) {
  return (Insert(key, value, true));
}

template <typename TKey, typename TValue>
bool CHashMap::Contains(CKeyValuePair<TKey, TValue> *item) {

  if (CheckPointer(item) == POINTER_INVALID)
    return (false);

  int i = FindEntry(item.Key());

  CDefaultEqualityComparer<TValue> comparer;

  if (i >= 0 && comparer.Equals(m_entries[i].value, item.Value()))
    return (true);
  else
    return (false);
}

template <typename TKey, typename TValue>
bool CHashMap::Contains(TKey key, TValue value) {

  int i = FindEntry(key);

  CDefaultEqualityComparer<TValue> comparer;

  if (i >= 0 && comparer.Equals(m_entries[i].value, value))
    return (true);
  else
    return (false);
}

template <typename TKey, typename TValue> bool CHashMap::ContainsKey(TKey key) {
  return (FindEntry(key) >= 0);
}

template <typename TKey, typename TValue>
bool CHashMap::ContainsValue(TValue value) {

  CDefaultEqualityComparer<TValue> comparer_value();

  for (int i = 0; i < m_count; i++)
    if (m_entries[i].hash_code >= 0 &&
        comparer_value.Equals(m_entries[i].value, value))
      return (true);
  return (false);
}

template <typename TKey, typename TValue>
int CHashMap::CopyTo(CKeyValuePair<TKey, TValue> *&dst_array[],
                     const int dst_start = 0) {

  if (dst_start + m_count > ArraySize(dst_array))
    ArrayResize(dst_array, dst_start + m_count);

  int index = 0;
  for (int i = 0; i < ArraySize(m_entries); i++)
    if (m_entries[i].hash_code >= 0) {

      if (dst_start + index >= ArraySize(dst_array) || index >= m_count)
        return (index);
      dst_array[dst_start + index++] =
          new CKeyValuePair<TKey, TValue>(m_entries[i].key, m_entries[i].value);
    }
  return (index);
}

template <typename TKey, typename TValue>
int CHashMap::CopyTo(TKey &dst_keys[], TValue &dst_values[],
                     const int dst_start = 0) {
  int count = m_count - m_free_count;

  if (dst_start + count > ArraySize(dst_keys))
    ArrayResize(dst_keys, dst_start + count);

  if (dst_start + count > ArraySize(dst_values))
    ArrayResize(dst_values, MathMin(ArraySize(dst_keys), dst_start + count));

  int index = 0;
  for (int i = 0; i < ArraySize(m_entries); i++)
    if (m_entries[i].hash_code >= 0) {

      if (dst_start + index >= ArraySize(dst_keys) ||
          dst_start + index >= ArraySize(dst_values) || index >= count)
        return (index);
      dst_keys[dst_start + index] = m_entries[i].key;
      dst_values[dst_start + index] = m_entries[i].value;
      index++;
    }
  return (index);
}

template <typename TKey, typename TValue> void CHashMap::Clear(void) {

  if (m_count > 0) {
    ArrayFill(m_buckets, 0, m_capacity, -1);
    ArrayFree(m_entries);
    m_count = 0;
    m_free_list = -1;
    m_free_count = 0;
  }
}

template <typename TKey, typename TValue>
bool CHashMap::Remove(CKeyValuePair<TKey, TValue> *item) {

  if (CheckPointer(item) == POINTER_INVALID)
    return (false);

  int i = FindEntry(item.Key());

  CDefaultEqualityComparer<TValue> comparer_value();

  if (i >= 0 && comparer_value.Equals(m_entries[i].value, item.Value()))
    return Remove(item.Key());
  return (false);
}

template <typename TKey, typename TValue> bool CHashMap::Remove(TKey key) {
  if (m_capacity != 0) {
    int hash_code = m_comparer.HashCode(key) & 0x7FFFFFFF;
    int bucket = hash_code % m_capacity;
    int last = -1;

    for (int i = m_buckets[bucket]; i >= 0; last = i, i = m_entries[i].next) {
      if (m_entries[i].hash_code == hash_code &&
          m_comparer.Equals(m_entries[i].key, key)) {
        if (last < 0)
          m_buckets[bucket] = m_entries[i].next;
        else
          m_entries[last].next = m_entries[i].next;

        m_entries[i].hash_code = -1;
        m_entries[i].next = m_free_list;
        m_entries[i].key = (TKey)NULL;
        m_entries[i].value = (TValue)NULL;

        m_free_list = i;
        m_free_count++;
        return (true);
      }
    }
  }
  return (false);
}

template <typename TKey, typename TValue>
bool CHashMap::TryGetValue(TKey key, TValue &value) {

  int i = FindEntry(key);

  if (i >= 0) {

    value = m_entries[i].value;
    return (true);
  }
  return (false);
}

template <typename TKey, typename TValue>
bool CHashMap::TrySetValue(TKey key, TValue value) {
  return (Insert(key, value, false));
}

template <typename TKey, typename TValue>
void CHashMap::Initialize(const int capacity) {
  m_capacity = CPrimeGenerator::GetPrime(capacity);
  ArrayResize(m_buckets, m_capacity);
  ArrayFill(m_buckets, 0, m_capacity, -1);
  ArrayResize(m_entries, m_capacity);
  m_free_list = -1;
}

template <typename TKey, typename TValue>
bool CHashMap::Resize(const int new_size) {

  if (ArrayResize(m_buckets, new_size) != new_size)
    return (false);
  ArrayFill(m_buckets, 0, new_size, -1);

  if (ArrayResize(m_entries, new_size) != new_size)
    return (false);

  for (int i = 0; i < m_count; i++)
    if (m_entries[i].hash_code >= 0) {
      int bucket = m_entries[i].hash_code % new_size;
      m_entries[i].next = m_buckets[bucket];
      m_buckets[bucket] = i;
    }

  m_capacity = new_size;
  return (true);
}

template <typename TKey, typename TValue> int CHashMap::FindEntry(TKey key) {
  if (m_capacity != NULL) {

    int hash_code = m_comparer.HashCode(key) & 0x7FFFFFFF;

    for (int i = m_buckets[hash_code % m_capacity]; i >= 0;
         i = m_entries[i].next)
      if (m_entries[i].hash_code == hash_code &&
          m_comparer.Equals(m_entries[i].key, key))
        return (i);
  }
  return (-1);
}

template <typename TKey, typename TValue>
bool CHashMap::Insert(TKey key, TValue value, const bool add) {
  if (m_capacity == 0)
    Initialize(0);

  int hash_code = m_comparer.HashCode(key) & 0x7FFFFFFF;
  int target_bucket = hash_code % m_capacity;

  int collision_count = 0;

  for (int i = m_buckets[target_bucket]; i >= 0; i = m_entries[i].next) {

    if (m_entries[i].hash_code != hash_code) {
      collision_count++;
      continue;
    }

    if (m_comparer.Equals(m_entries[i].key, key)) {

      if (add)
        return (false);
      m_entries[i].value = value;
      return (true);
    }
  }

  if (collision_count >= m_collision_threshold) {
    int new_size = CPrimeGenerator::ExpandPrime(m_count);
    if (!Resize(new_size))
      return (false);
    target_bucket = hash_code % new_size;
  }

  int index;
  if (m_free_count > 0) {
    index = m_free_list;
    m_free_list = m_entries[index].next;
    m_free_count--;
  } else {
    if (m_count == ArraySize(m_entries)) {
      int new_size = CPrimeGenerator::ExpandPrime(m_count);
      if (!Resize(new_size))
        return (false);
      target_bucket = hash_code % new_size;
    }
    index = m_count;
    m_count++;
  }

  m_entries[index].hash_code = hash_code;
  m_entries[index].next = m_buckets[target_bucket];
  m_entries[index].key = key;
  m_entries[index].value = value;
  m_buckets[target_bucket] = index;
  return (true);
}
template <typename TKey, typename TValue>
static int CHashMap::m_collision_threshold = 8;

#endif
