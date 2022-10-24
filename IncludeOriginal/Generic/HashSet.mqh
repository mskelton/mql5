#ifndef HASH_SET_H
#define HASH_SET_H

#include <Generic\Interfaces\IEqualityComparer.mqh>
#include <Generic\Interfaces\ISet.mqh>
#include <Generic\Internal\DefaultEqualityComparer.mqh>
#include <Generic\Internal\PrimeGenerator.mqh>

template <typename T> struct Slot {
public:
  int hash_code;
  T value;
  int next;
  Slot(void) : hash_code(0), value((T)NULL), next(0) {
  }
};

template <typename T> class CHashSet : public ISet<T> {
protected:
  int m_buckets[];
  Slot<T> m_slots[];
  int m_count;
  int m_last_index;
  int m_free_list;
  IEqualityComparer<T> *m_comparer;
  bool m_delete_comparer;

public:
  CHashSet(void);
  CHashSet(IEqualityComparer<T> *comparer);
  CHashSet(ICollection<T> *collection);
  CHashSet(ICollection<T> *collection, IEqualityComparer<T> *comparer);
  CHashSet(T &array[]);
  CHashSet(T &array[], IEqualityComparer<T> *comparer);
  ~CHashSet(void);

  bool Add(T value);

  int Count(void) {
    return (m_count);
  }
  IEqualityComparer<T> *Comparer(void) const {
    return (m_comparer);
  }
  bool Contains(T item);
  void TrimExcess(void);

  int CopyTo(T &ds_array[], const int dst_start = 0);

  void Clear(void);
  bool Remove(T item);

  void ExceptWith(ICollection<T> *collection);
  void ExceptWith(T &array[]);
  void IntersectWith(ICollection<T> *collection);
  void IntersectWith(T &array[]);
  void SymmetricExceptWith(ICollection<T> *collection);
  void SymmetricExceptWith(T &array[]);
  void UnionWith(ICollection<T> *collection);
  void UnionWith(T &array[]);

  bool IsProperSubsetOf(ICollection<T> *collection);
  bool IsProperSubsetOf(T &array[]);
  bool IsProperSupersetOf(ICollection<T> *collection);
  bool IsProperSupersetOf(T &array[]);
  bool IsSubsetOf(ICollection<T> *collection);
  bool IsSubsetOf(T &array[]);
  bool IsSupersetOf(ICollection<T> *collection);
  bool IsSupersetOf(T &array[]);
  bool Overlaps(ICollection<T> *collection);
  bool Overlaps(T &array[]);
  bool SetEquals(ICollection<T> *collection);
  bool SetEquals(T &array[]);

private:
  void SetCapacity(const int new_size, bool new_hash_codes);
  bool AddIfNotPresent(T value);
  void Initialize(const int capacity);
  void InternalSymmetricExceptWith(CHashSet<T> *set);
  bool InternalIsSubsetOf(CHashSet<T> *set);
  bool InternalIsSupersetOf(CHashSet<T> *set);
  bool InternalIsProperSubsetOf(CHashSet<T> *set);
  bool InternalIsProperSupersetOf(CHashSet<T> *set);
};

template <typename T>
CHashSet::CHashSet(void) : m_count(0), m_last_index(0), m_free_list(-1) {

  m_comparer = new CDefaultEqualityComparer<T>();
  m_delete_comparer = true;
}

template <typename T>
CHashSet::CHashSet(IEqualityComparer<T> *comparer)
    : m_count(0), m_last_index(0), m_free_list(-1) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultEqualityComparer<T>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }
}

template <typename T>
CHashSet::CHashSet(ICollection<T> *collection)
    : m_count(0), m_last_index(0), m_free_list(-1) {

  m_comparer = new CDefaultEqualityComparer<T>();
  m_delete_comparer = true;

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  int count = collection.Count();
  Initialize(count);

  this.UnionWith(collection);
  if ((m_count == 0 && ArraySize(m_slots) > 3) ||
      (m_count > 0 && ArraySize(m_slots) / m_count > 3))
    TrimExcess();
}

template <typename T>
CHashSet::CHashSet(ICollection<T> *collection, IEqualityComparer<T> *comparer)
    : m_count(0), m_last_index(0), m_free_list(-1) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultEqualityComparer<T>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  int count = collection.Count();
  Initialize(count);

  this.UnionWith(collection);
  if ((m_count == 0 && ArraySize(m_slots) > 3) ||
      (m_count > 0 && ArraySize(m_slots) / m_count > 3))
    TrimExcess();
}

template <typename T>
CHashSet::CHashSet(T &array[]) : m_count(0), m_last_index(0), m_free_list(-1) {

  m_comparer = new CDefaultEqualityComparer<T>();
  m_delete_comparer = true;

  int count = ArraySize(array);
  Initialize(count);

  this.UnionWith(array);
  if ((m_count == 0 && ArraySize(m_slots) > 3) ||
      (m_count > 0 && ArraySize(m_slots) / m_count > 3))
    TrimExcess();
}

template <typename T>
CHashSet::CHashSet(T &array[], IEqualityComparer<T> *comparer)
    : m_count(0), m_last_index(0), m_free_list(-1) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultEqualityComparer<T>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }

  int count = ArraySize(array);
  Initialize(count);

  this.UnionWith(array);
  if ((m_count == 0 && ArraySize(m_slots) > 3) ||
      (m_count > 0 && ArraySize(m_slots) / m_count > 3))
    TrimExcess();
}

template <typename T> CHashSet::~CHashSet(void) {
  if (m_delete_comparer)
    delete m_comparer;
}

template <typename T> bool CHashSet::Add(T value) {
  return AddIfNotPresent(value);
}

template <typename T> bool CHashSet::Contains(T item) {

  if (ArraySize(m_buckets) != 0) {

    int hash_code = m_comparer.HashCode(item) & 0x7FFFFFFF;

    for (int i = m_buckets[hash_code % ArraySize(m_buckets)] - 1; i >= 0;
         i = m_slots[i].next)
      if (m_slots[i].hash_code == hash_code &&
          m_comparer.Equals(m_slots[i].value, item))
        return (true);
  }
  return (false);
}

template <typename T> void CHashSet::TrimExcess(void) {
  if (m_count == 0) {
    ArrayFree(m_buckets);
    ArrayFree(m_slots);
  } else {

    int new_size = CPrimeGenerator::GetPrime(m_count);

    ArrayResize(m_slots, new_size);
    ArrayResize(m_buckets, new_size);

    int new_index = 0;
    for (int i = 0; i < m_last_index; i++) {
      if (m_slots[i].hash_code >= 0) {
        m_slots[new_index] = m_slots[i];

        int bucket = m_slots[new_index].hash_code % new_size;
        m_slots[new_index].next = m_buckets[bucket] - 1;
        m_buckets[bucket] = new_index + 1;

        new_index++;
      }
    }
    m_last_index = new_index;
    m_free_list = -1;
  }
}

template <typename T>
int CHashSet::CopyTo(T &dst_array[], const int dst_start) {

  if (dst_start + m_count > ArraySize(dst_array))
    ArrayResize(dst_array, dst_start + m_count);

  int index = 0;
  for (int i = 0; i < ArraySize(m_slots); i++)
    if (m_slots[i].hash_code >= 0) {
      if (dst_start + index >= ArraySize(dst_array) || index >= m_count)
        return (index);
      dst_array[dst_start + index++] = m_slots[i].value;
    }
  return (index);
}

template <typename T> void CHashSet::Clear(void) {
  if (m_last_index > 0) {
    ArrayFree(m_slots);
    ArrayFree(m_buckets);
    m_last_index = 0;
    m_count = 0;
    m_free_list = -1;
  }
}

template <typename T> bool CHashSet::Remove(T item) {
  if (ArraySize(m_buckets) != 0) {

    int hash_code = m_comparer.HashCode(item) & 0x7FFFFFFF;
    int bucket = hash_code % ArraySize(m_buckets);
    int last = -1;

    for (int i = m_buckets[bucket] - 1; i >= 0; last = i, i = m_slots[i].next) {
      if (m_slots[i].hash_code == hash_code &&
          m_comparer.Equals(m_slots[i].value, item)) {
        if (last < 0)
          m_buckets[bucket] = m_slots[i].next + 1;
        else
          m_slots[last].next = m_slots[i].next;

        m_slots[i].hash_code = -1;
        m_slots[i].value = (T)NULL;
        m_slots[i].next = m_free_list;

        m_count--;
        if (m_count == 0) {
          m_last_index = 0;
          m_free_list = -1;
        } else {
          m_free_list = i;
        }
        return (true);
      }
    }
  }
  return (false);
}

template <typename T> void CHashSet::ExceptWith(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  if (m_count == 0)
    return;

  if (collection == GetPointer(this)) {
    Clear();
    return;
  }

  T array[];
  collection.CopyTo(array, 0);

  for (int i = 0; i < ArraySize(array); i++)
    Remove(array[i]);
}

template <typename T> void CHashSet::ExceptWith(T &array[]) {

  if (m_count == 0)
    return;

  for (int i = 0; i < ArraySize(array); i++)
    Remove(array[i]);
}

template <typename T> void CHashSet::IntersectWith(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  if (m_count == 0)
    return;

  if (collection.Count() == 0) {
    Clear();
    return;
  }

  for (int i = 0; i < m_last_index; i++) {
    if (m_slots[i].hash_code >= 0) {
      T item = m_slots[i].value;
      if (!collection.Contains(item))
        Remove(item);
    }
  }
}

template <typename T> void CHashSet::IntersectWith(T &array[]) {

  if (m_count == 0)
    return;

  if (ArraySize(array) == 0) {
    Clear();
    return;
  }

  CHashSet<T> set(array);
  for (int i = 0; i < m_last_index; i++) {
    if (m_slots[i].hash_code >= 0) {
      T item = m_slots[i].value;
      if (!set.Contains(item))
        Remove(item);
    }
  }
}

template <typename T>
void CHashSet::SymmetricExceptWith(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  if (m_count == 0) {
    UnionWith(collection);
    return;
  }

  if (collection == GetPointer(this)) {
    Clear();
    return;
  }

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    InternalSymmetricExceptWith(ptr_set);
  } else {

    CHashSet<T> set(collection);
    InternalSymmetricExceptWith(GetPointer(set));
  }
}

template <typename T> void CHashSet::SymmetricExceptWith(T &array[]) {

  if (m_count == 0) {
    UnionWith(array);
    return;
  }

  CHashSet<T> set(array);
  InternalSymmetricExceptWith(GetPointer(set));
}

template <typename T> void CHashSet::UnionWith(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  T array[];
  collection.CopyTo(array);

  UnionWith(array);
}

template <typename T> void CHashSet::UnionWith(T &array[]) {
  for (int i = 0; i < ArraySize(array); i++)
    AddIfNotPresent(array[i]);
}

template <typename T>
bool CHashSet::IsProperSubsetOf(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);

  if (m_count == 0)
    return (collection.Count() > 0);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    return InternalIsProperSubsetOf(ptr_set);
  } else {

    CHashSet<T> set(collection);
    return InternalIsProperSubsetOf(GetPointer(set));
  }
}

template <typename T> bool CHashSet::IsProperSubsetOf(T &array[]) {

  if (m_count == 0)
    return (ArraySize(array) > 0);

  CHashSet<T> set(array);
  return InternalIsProperSubsetOf(GetPointer(set));
}

template <typename T>
bool CHashSet::IsProperSupersetOf(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (m_count > 0);

  if (m_count == 0)
    return (false);

  if (collection.Count() == 0)
    return (true);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    return InternalIsProperSupersetOf(ptr_set);
  } else {

    CHashSet<T> set(collection);
    return InternalIsProperSupersetOf(GetPointer(set));
  }
}

template <typename T> bool CHashSet::IsProperSupersetOf(T &array[]) {

  if (m_count == 0)
    return (false);

  if (ArraySize(array) == 0)
    return (true);

  CHashSet<T> set(array);
  return InternalIsProperSupersetOf(GetPointer(set));
}

template <typename T> bool CHashSet::IsSubsetOf(ICollection<T> *collection) {
  if (CheckPointer(collection) == POINTER_INVALID)
    return (m_count == 0);

  if (m_count == 0)
    return (true);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    return InternalIsSubsetOf(ptr_set);
  } else {

    CHashSet<T> set(collection);
    return InternalIsSubsetOf(GetPointer(set));
  }
}

template <typename T> bool CHashSet::IsSubsetOf(T &array[]) {

  if (m_count == 0)
    return (true);

  CHashSet<T> set(array);
  return InternalIsSubsetOf(GetPointer(set));
}

template <typename T> bool CHashSet::IsSupersetOf(ICollection<T> *collection) {
  if (CheckPointer(collection) == POINTER_INVALID)
    return (m_count >= 0);

  if (collection.Count() == 0)
    return (true);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    return InternalIsSupersetOf(ptr_set);
  } else {

    CHashSet<T> set(collection);
    return InternalIsSupersetOf(GetPointer(set));
  }
}

template <typename T> bool CHashSet::IsSupersetOf(T &array[]) {

  if (ArraySize(array) == 0)
    return (true);

  CHashSet<T> set(array);
  return InternalIsSupersetOf(GetPointer(set));
}

template <typename T> bool CHashSet::Overlaps(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);

  if (m_count == 0)
    return (false);

  T array[];
  collection.CopyTo(array);

  return Overlaps(array);
}

template <typename T> bool CHashSet::Overlaps(T &array[]) {

  if (m_count == 0)
    return (false);

  for (int i = 0; i < ArraySize(array); i++)
    if (Contains(array[i]))
      return (true);
  return (false);
}

template <typename T> bool CHashSet::SetEquals(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);

  if (collection == GetPointer(this))
    return (true);

  T array[];
  collection.CopyTo(array);

  return SetEquals(array);
}

template <typename T> bool CHashSet::SetEquals(T &array[]) {

  if (ArraySize(array) != m_count)
    return (false);

  for (int i = 0; i < ArraySize(array); i++)
    if (!Contains(array[i]))
      return (false);
  return (true);
}

template <typename T>
void CHashSet::SetCapacity(const int new_size, bool new_hash_codes) {

  ArrayResize(m_slots, new_size);

  if (new_hash_codes)
    for (int i = 0; i < m_last_index; i++)
      if (m_slots[i].hash_code != -1)
        m_slots[i].hash_code =
            m_comparer.HashCode(m_slots[i].value) & 0x7FFFFFFF;

  ArrayResize(m_buckets, new_size);
  ArrayFill(m_buckets, 0, new_size, 0);

  for (int i = 0; i < m_last_index; i++) {
    int bucket = m_slots[i].hash_code % new_size;
    m_slots[i].next = m_buckets[bucket] - 1;
    m_buckets[bucket] = i + 1;
  }
}

template <typename T> bool CHashSet::AddIfNotPresent(T value) {

  if (ArraySize(m_buckets) == 0)
    Initialize(0);

  int hash_code = m_comparer.HashCode(value) & 0x7FFFFFFF;
  int bucket = hash_code % ArraySize(m_buckets);

  for (int i = m_buckets[hash_code % ArraySize(m_buckets)] - 1; i >= 0;
       i = m_slots[i].next)
    if (m_slots[i].hash_code == hash_code &&
        m_comparer.Equals(m_slots[i].value, value))
      return (false);

  int index = 0;
  if (m_free_list >= 0) {
    index = m_free_list;
    m_free_list = m_slots[index].next;
  } else {
    if (m_last_index == ArraySize(m_slots)) {
      int new_size = CPrimeGenerator::ExpandPrime(m_count);
      SetCapacity(new_size, false);
      bucket = hash_code % ArraySize(m_buckets);
    }
    index = m_last_index;
    m_last_index++;
  }

  m_slots[index].hash_code = hash_code;
  m_slots[index].value = value;
  m_slots[index].next = m_buckets[bucket] - 1;
  m_buckets[bucket] = index + 1;

  m_count++;
  return (true);
}

template <typename T> void CHashSet::Initialize(const int capacity) {
  int size = CPrimeGenerator::GetPrime(capacity);
  ArrayResize(m_buckets, size);
  ArrayResize(m_slots, size);
  ZeroMemory(m_buckets);
  ZeroMemory(m_slots);
}

template <typename T>
void CHashSet::InternalSymmetricExceptWith(CHashSet<T> *set) {
  for (int i = 0; i < ArraySize(set.m_slots); i++) {
    T item = set.m_slots[i].value;
    if (!Remove(item))
      AddIfNotPresent(item);
  }
}

template <typename T> bool CHashSet::InternalIsSubsetOf(CHashSet<T> *set) {

  if (m_count > set.m_count)
    return (false);

  for (int i = 0; i < m_count; i++) {
    T item = m_slots[i].value;
    if (!set.Contains(item))
      return (false);
  }
  return (true);
}

template <typename T> bool CHashSet::InternalIsSupersetOf(CHashSet<T> *set) {

  if (set.m_count > m_count)
    return (false);

  for (int i = 0; i < set.m_count; i++) {
    T item = set.m_slots[i].value;
    if (!Contains(item))
      return (false);
  }
  return (true);
}

template <typename T>
bool CHashSet::InternalIsProperSubsetOf(CHashSet<T> *set) {

  if (m_count >= set.m_count)
    return (false);

  for (int i = 0; i < m_count; i++) {
    T item = m_slots[i].value;
    if (!set.Contains(item))
      return (false);
  }
  return (true);
}

template <typename T>
bool CHashSet::InternalIsProperSupersetOf(CHashSet<T> *set) {

  if (m_count <= set.m_count)
    return (false);

  for (int i = 0; i < set.m_count; i++) {
    T item = set.m_slots[i].value;
    if (!Contains(item))
      return (false);
  }
  return (true);
}

#endif
