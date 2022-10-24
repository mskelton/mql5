#ifndef ARRAY_LIST_H
#define ARRAY_LIST_H

#include <Generic\Interfaces\IComparer.mqh>
#include <Generic\Interfaces\IList.mqh>
#include <Generic\Internal\ArrayFunction.mqh>
#include <Generic\Internal\DefaultComparer.mqh>
#include <Generic\Internal\EqualFunction.mqh>
#include <Generic\Internal\Introsort.mqh>

template <typename T> class CArrayList : public IList<T> {
protected:
  T m_items[];
  int m_size;
  const int m_default_capacity;

public:
  CArrayList(void);
  CArrayList(const int capacity);
  CArrayList(ICollection<T> *collection);
  CArrayList(T &array[]);
  ~CArrayList(void);

  int Capacity(void);
  void Capacity(const int capacity);
  int Count(void);
  bool Contains(T item);
  void TrimExcess(void);

  bool TryGetValue(const int index, T &value);
  bool TrySetValue(const int index, T value);

  bool Add(T item);
  bool AddRange(T &array[]);
  bool AddRange(ICollection<T> *collection);
  bool Insert(const int index, T item);
  bool InsertRange(const int index, T &array[]);
  bool InsertRange(const int index, ICollection<T> *collection);

  int CopyTo(T &dst_array[], const int dst_start = 0);

  int BinarySearch(T item);
  int BinarySearch(T item, IComparer<T> *comparer);
  int BinarySearch(const int index, const int count, T item,
                   IComparer<T> *comparer);

  int IndexOf(T item);
  int IndexOf(T item, const int start_index);
  int IndexOf(T item, const int start_index, const int count);
  int LastIndexOf(T item);
  int LastIndexOf(T item, const int start_index);
  int LastIndexOf(T item, const int start_index, const int count);

  void Clear(void);
  bool Remove(T item);
  bool RemoveAt(const int index);
  bool RemoveRange(const int start_index, const int count);

  bool Reverse(void);
  bool Reverse(const int start_index, const int count);

  bool Sort(void);
  bool Sort(IComparer<T> *comparer);
  bool Sort(const int start_index, const int count, IComparer<T> *comparer);

private:
  void EnsureCapacity(const int min);
};

template <typename T>
CArrayList::CArrayList(void) : m_default_capacity(4), m_size(0) {
  ArrayResize(m_items, m_default_capacity);
}

template <typename T>
CArrayList::CArrayList(const int capacity) : m_default_capacity(4), m_size(0) {
  ArrayResize(m_items, capacity);
}

template <typename T>
CArrayList::CArrayList(T &array[]) : m_default_capacity(4), m_size(0) {
  m_size = ArrayCopy(m_items, array);
}

template <typename T>
CArrayList::CArrayList(ICollection<T> *collection)
    : m_default_capacity(4), m_size(0) {

  if (CheckPointer(collection) != POINTER_INVALID)
    m_size = collection.CopyTo(m_items, 0);
}

template <typename T> CArrayList::~CArrayList(void) {}

template <typename T> int CArrayList::Capacity(void) {
  return ArraySize(m_items);
}

template <typename T> void CArrayList::Capacity(const int capacity) {

  if (capacity >= m_size && capacity != ArraySize(m_items)) {
    if (capacity > 0)
      ArrayResize(m_items, capacity);
    else
      ArrayFree(m_items);
  }
}

template <typename T> int CArrayList::Count(void) {
  return (m_size);
}

template <typename T> bool CArrayList::Contains(T item) {

  for (int i = 0; i < m_size; i++) {

    if (::Equals(m_items[i], item))
      return (true);
  }
  return (false);
}

template <typename T> bool CArrayList::TryGetValue(const int index, T &value) {

  if ((uint)index < (uint)m_size) {

    value = m_items[index];
    return (true);
  }
  return (false);
}

template <typename T> bool CArrayList::TrySetValue(const int index, T value) {

  if ((uint)index < (uint)m_size) {

    m_items[index] = value;
    return (true);
  }
  return (false);
}

template <typename T> void CArrayList::TrimExcess(void) {

  int threshold = (int)(((double)ArraySize(m_items)) * 0.9);

  if (m_size < threshold)
    Capacity(m_size);
}

template <typename T> bool CArrayList::Add(T item) {

  if (m_size == ArraySize(m_items))
    EnsureCapacity(m_size + 1);

  m_items[m_size++] = item;
  return (true);
}

template <typename T> bool CArrayList::AddRange(T &array[]) {

  if (m_size == ArraySize(m_items))
    EnsureCapacity(m_size + ArraySize(array));

  m_size += ArrayCopy(m_items, array, m_size);
  return (true);
}

template <typename T> bool CArrayList::AddRange(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);

  if (m_size == ArraySize(m_items))
    EnsureCapacity(m_size + collection.Count());

  m_size += collection.CopyTo(m_items, m_size);
  return (true);
}

template <typename T> bool CArrayList::Insert(const int index, T item) {

  if ((uint)index > (uint)m_size)
    return (false);

  if (m_size == ArraySize(m_items))
    EnsureCapacity(m_size + 1);

  if (index < m_size)
    ArrayCopy(m_items, m_items, index + 1, index, m_size - index);

  m_items[index] = item;
  m_size++;
  return (true);
}

template <typename T>
bool CArrayList::InsertRange(const int index, T &array[]) {

  if ((uint)index > (uint)m_size)
    return (false);
  int size = ArraySize(array);

  if (size > 0) {

    EnsureCapacity(m_size + size);

    if (index < m_size)
      ArrayCopy(m_items, m_items, index + size, index, m_size - index);

    m_size += ArrayCopy(m_items, array, index);
  }
  return (true);
}

template <typename T>
bool CArrayList::InsertRange(const int index, ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);

  if ((uint)index > (uint)m_size)
    return (false);
  int count = collection.Count();

  if (count > 0) {

    EnsureCapacity(m_size + count);

    if (index < m_size)
      ArrayCopy(m_items, m_items, index + count, index, m_size - index);

    m_size += collection.CopyTo(m_items, index);
  }
  return (true);
}

template <typename T>
int CArrayList::CopyTo(T &dst_array[], const int dst_start = 0) {
  return ArrayCopy(dst_array, m_items, dst_start, 0, m_size);
}

template <typename T>
int CArrayList::BinarySearch(const int start_index, const int count, T item,
                             IComparer<T> *comparer) {

  if (start_index < 0 || count < 0 || m_size - start_index < count)
    return (-1);

  if (CheckPointer(comparer) != POINTER_INVALID) {

    return ArrayBinarySearch(m_items, start_index, count, item, comparer);
  } else {
    CDefaultComparer<T> def_comparer;

    return ArrayBinarySearch(m_items, start_index, count, item,
                             GetPointer(def_comparer));
  }
}

template <typename T>
int CArrayList::BinarySearch(T item, IComparer<T> *comparer) {
  return BinarySearch(0, m_size, item, comparer);
}

template <typename T> int CArrayList::BinarySearch(T item) {
  return BinarySearch(item, NULL);
}

template <typename T> int CArrayList::IndexOf(T item) {
  return ArrayIndexOf(m_items, item, 0, m_size);
}

template <typename T> int CArrayList::IndexOf(T item, const int start_index) {

  if (start_index >= m_size)
    return (-1);

  return ArrayIndexOf(m_items, item, start_index, m_size - start_index);
}

template <typename T>
int CArrayList::IndexOf(T item, const int start_index, const int count) {

  if (start_index < 0 || count < 0 || start_index >= m_size)
    return (-1);

  return ArrayIndexOf(m_items, item, start_index,
                      MathMin(m_size - start_index, count));
}

template <typename T> int CArrayList::LastIndexOf(T item) {
  return LastIndexOf(item, m_size - 1, m_size);
}

template <typename T>
int CArrayList::LastIndexOf(T item, const int start_index) {

  if (start_index >= m_size)
    return (-1);

  return ArrayLastIndexOf(m_items, item, start_index, start_index + 1);
}

template <typename T>
int CArrayList::LastIndexOf(T item, const int start_index, const int count) {

  if (start_index < 0 || count < 0 || start_index >= m_size)
    return (-1);

  return ArrayLastIndexOf(m_items, item, start_index,
                          MathMin(start_index + 1, count));
}

template <typename T> void CArrayList::Clear(void) {

  if (m_size > 0) {
    ZeroMemory(m_items);
    m_size = 0;
  }
}

template <typename T> bool CArrayList::RemoveAt(const int index) {

  if ((uint)index >= (uint)m_size)
    return (false);

  m_size--;

  if (index < m_size)
    ArrayCopy(m_items, m_items, index, index + 1, m_size - index);
  return (true);
}

template <typename T> bool CArrayList::Remove(T item) {

  int index = IndexOf(item);

  if (index >= 0)
    return RemoveAt(index);
  else
    return (false);
}

template <typename T>
bool CArrayList::RemoveRange(const int start_index, const int count) {

  if (start_index < 0 || count < 0 || m_size - start_index < count)
    return (false);
  if (count > 0) {

    m_size -= count;

    if (start_index < m_size)
      ArrayCopy(m_items, m_items, start_index, start_index + count,
                m_size - start_index);
  }
  return (true);
}

template <typename T> bool CArrayList::Reverse(void) {
  return Reverse(0, m_size);
}

template <typename T>
bool CArrayList::Reverse(const int start_index, const int count) {

  if (start_index < 0 || count < 0 || m_size - start_index < count)
    return (false);
  return ArrayReverse(m_items, start_index, count);
}

template <typename T> bool CArrayList::Sort(void) {
  return Sort(0, m_size, NULL);
}

template <typename T> bool CArrayList::Sort(IComparer<T> *comparer) {
  return Sort(0, m_size, comparer);
}

template <typename T>
bool CArrayList::Sort(const int start_index, const int count,
                      IComparer<T> *comparer) {

  if (start_index < 0 || count < 0 || m_size - start_index < count)
    return (false);

  Introsort<T, T> sorter();

  ArrayCopy(sorter.keys, m_items);

  if (CheckPointer(comparer) != POINTER_INVALID) {

    sorter.comparer = comparer;

    sorter.Sort(start_index, count);
  } else {

    CDefaultComparer<T> def_comparer;
    sorter.comparer = GetPointer(def_comparer);

    sorter.Sort(start_index, count);
  }

  ArrayCopy(m_items, sorter.keys);
  return (true);
}

template <typename T> void CArrayList::EnsureCapacity(const int min) {
  int size = ArraySize(m_items);

  if (size < min) {
    int new_capacity = (size == 0) ? m_default_capacity : size * 2;

    if ((uint)new_capacity > INT_MAX)
      new_capacity = INT_MAX;
    if (new_capacity < min)
      new_capacity = min;

    Capacity(new_capacity);
  }
}

#endif
