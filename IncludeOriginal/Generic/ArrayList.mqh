#ifndef ARRAY_LIST_H
#define ARRAY_LIST_H
//|                   Copyright 2016-2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <Generic\Interfaces\IComparer.mqh>
#include <Generic\Interfaces\IList.mqh>
#include <Generic\Internal\ArrayFunction.mqh>
#include <Generic\Internal\DefaultComparer.mqh>
#include <Generic\Internal\EqualFunction.mqh>
#include <Generic\Internal\Introsort.mqh>
//+------------------------------------------------------------------+
//| Class CArrayList<T>.                                             |
//| Usage: Represents a strongly typed list of values that can be    |
//|        accessed by index. Provides methods to search, sort, and  |
//|        manipulate lists.                                         |
//+------------------------------------------------------------------+
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
  //--- methods of access to protected data
  int Capacity(void);
  void Capacity(const int capacity);
  int Count(void);
  bool Contains(T item);
  void TrimExcess(void);
  //--- method of access to the data
  bool TryGetValue(const int index, T &value);
  bool TrySetValue(const int index, T value);
  //--- methods of filling the array
  bool Add(T item);
  bool AddRange(T &array[]);
  bool AddRange(ICollection<T> *collection);
  bool Insert(const int index, T item);
  bool InsertRange(const int index, T &array[]);
  bool InsertRange(const int index, ICollection<T> *collection);
  //--- methods of copy data from collection
  int CopyTo(T &dst_array[], const int dst_start = 0);
  //--- methods for binary searching index
  int BinarySearch(T item);
  int BinarySearch(T item, IComparer<T> *comparer);
  int BinarySearch(const int index, const int count, T item,
                   IComparer<T> *comparer);
  //--- methods for searching index
  int IndexOf(T item);
  int IndexOf(T item, const int start_index);
  int IndexOf(T item, const int start_index, const int count);
  int LastIndexOf(T item);
  int LastIndexOf(T item, const int start_index);
  int LastIndexOf(T item, const int start_index, const int count);
  //--- methods of cleaning and deleting
  void Clear(void);
  bool Remove(T item);
  bool RemoveAt(const int index);
  bool RemoveRange(const int start_index, const int count);
  //--- reversing method
  bool Reverse(void);
  bool Reverse(const int start_index, const int count);
  //--- sorting method
  bool Sort(void);
  bool Sort(IComparer<T> *comparer);
  bool Sort(const int start_index, const int count, IComparer<T> *comparer);

private:
  void EnsureCapacity(const int min);
};
//+------------------------------------------------------------------+
//| Initializes a new instance of the CArrayList<T> class that is    |
//| empty and has the default initial capacity.                      |
//+------------------------------------------------------------------+
template <typename T>
CArrayList::CArrayList(void) : m_default_capacity(4), m_size(0) {
  ArrayResize(m_items, m_default_capacity);
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CArrayList<T> class that is    |
//| empty and has the specified initial capacity.                    |
//+------------------------------------------------------------------+
template <typename T>
CArrayList::CArrayList(const int capacity) : m_default_capacity(4), m_size(0) {
  ArrayResize(m_items, capacity);
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CArrayList<T> class that       |
//| contains elements copied from the specified array and has        |
//| sufficient capacity to accommodate the number of elements copied.|
//+------------------------------------------------------------------+
template <typename T>
CArrayList::CArrayList(T &array[]) : m_default_capacity(4), m_size(0) {
  m_size = ArrayCopy(m_items, array);
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CArrayList<T> class that       |
//| contains elements copied from the specified collection and has   |
//| sufficient capacity to accommodate the number of elements copied.|
//+------------------------------------------------------------------+
template <typename T>
CArrayList::CArrayList(ICollection<T> *collection)
    : m_default_capacity(4), m_size(0) {
  //--- check collection
  if (CheckPointer(collection) != POINTER_INVALID)
    m_size = collection.CopyTo(m_items, 0);
}
//+------------------------------------------------------------------+
//| Destructor.                                                      |
//+------------------------------------------------------------------+
template <typename T> CArrayList::~CArrayList(void) {
}
//+------------------------------------------------------------------+
//| Gets the total number of elements the internal data structure can|
//| hold without resizing.                                           |
//+------------------------------------------------------------------+
template <typename T> int CArrayList::Capacity(void) {
  return ArraySize(m_items);
}
//+------------------------------------------------------------------+
//| Sets the total number of elements the internal data structure can|
//| hold without resizing.                                           |
//+------------------------------------------------------------------+
template <typename T> void CArrayList::Capacity(const int capacity) {
  //--- check new capacity should be greater than current size
  if (capacity >= m_size && capacity != ArraySize(m_items)) {
    if (capacity > 0)
      ArrayResize(m_items, capacity);
    else
      ArrayFree(m_items);
  }
}
//+------------------------------------------------------------------+
//| Gets the number of elements.                                     |
//+------------------------------------------------------------------+
template <typename T> int CArrayList::Count(void) {
  return (m_size);
}
//+------------------------------------------------------------------+
//| Determines whether an element is in the list.                    |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::Contains(T item) {
  //--- try to find item in array
  for (int i = 0; i < m_size; i++) {
    //--- use default equality function
    if (::Equals(m_items[i], item))
      return (true);
  }
  return (false);
}
//+------------------------------------------------------------------+
//| Gets the element at the specified index.                         |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::TryGetValue(const int index, T &value) {
  //--- check index
  if ((uint)index < (uint)m_size) {
    //--- get value by index
    value = m_items[index];
    return (true);
  }
  return (false);
}
//+------------------------------------------------------------------+
//| Sets the element at the specified index.                         |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::TrySetValue(const int index, T value) {
  //--- check index
  if ((uint)index < (uint)m_size) {
    //--- set value by index
    m_items[index] = value;
    return (true);
  }
  return (false);
}
//+------------------------------------------------------------------+
//| Sets the capacity to the actual number of elements in the list,  |
//| if that number is less than a threshold value.                   |
//+------------------------------------------------------------------+
template <typename T> void CArrayList::TrimExcess(void) {
  //--- calculate threshold value
  int threshold = (int)(((double)ArraySize(m_items)) * 0.9);
  //--- set a Ñapacity equal to the size
  if (m_size < threshold)
    Capacity(m_size);
}
//+------------------------------------------------------------------+
//| Adds an value to the end of the list.                            |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::Add(T item) {
  //--- increse capacity if its necessary
  if (m_size == ArraySize(m_items))
    EnsureCapacity(m_size + 1);
  //--- add value to the end
  m_items[m_size++] = item;
  return (true);
}
//+------------------------------------------------------------------+
//| Adds the elements of the specified array to the end of the list. |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::AddRange(T &array[]) {
  //--- increse capacity if its necessary
  if (m_size == ArraySize(m_items))
    EnsureCapacity(m_size + ArraySize(array));
  //--- add values to the end
  m_size += ArrayCopy(m_items, array, m_size);
  return (true);
}
//+------------------------------------------------------------------+
//| Adds the elements of the specified collection to the end of the  |
//| list.                                                            |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::AddRange(ICollection<T> *collection) {
  //--- check collection
  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);
  //--- increse capacity if its necessary
  if (m_size == ArraySize(m_items))
    EnsureCapacity(m_size + collection.Count());
  //--- add value to the end
  m_size += collection.CopyTo(m_items, m_size);
  return (true);
}
//+------------------------------------------------------------------+
//| Inserts an element into the list at the specified index.         |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::Insert(const int index, T item) {
  //--- check index
  if ((uint)index > (uint)m_size)
    return (false);
  //--- increse capacity if its necessary
  if (m_size == ArraySize(m_items))
    EnsureCapacity(m_size + 1);
  //--- shift the values to the right
  if (index < m_size)
    ArrayCopy(m_items, m_items, index + 1, index, m_size - index);
  //--- insert value by index
  m_items[index] = item;
  m_size++;
  return (true);
}
//+------------------------------------------------------------------+
//| Inserts the elements of a array into the list at the specified   |
//| index.                                                           |
//+------------------------------------------------------------------+
template <typename T>
bool CArrayList::InsertRange(const int index, T &array[]) {
  //--- check index
  if ((uint)index > (uint)m_size)
    return (false);
  int size = ArraySize(array);
  //--- check size of inserted array
  if (size > 0) {
    //--- increse capacity if its necessary
    EnsureCapacity(m_size + size);
    //--- shift the values to the right
    if (index < m_size)
      ArrayCopy(m_items, m_items, index + size, index, m_size - index);
    //--- insert values by index
    m_size += ArrayCopy(m_items, array, index);
  }
  return (true);
}
//+------------------------------------------------------------------+
//| Inserts the elements of a collection into the list at the        |
//| specified index.                                                 |
//+------------------------------------------------------------------+
template <typename T>
bool CArrayList::InsertRange(const int index, ICollection<T> *collection) {
  //--- check collection
  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);
  //--- check index
  if ((uint)index > (uint)m_size)
    return (false);
  int count = collection.Count();
  //--- check count of inserted collection
  if (count > 0) {
    //--- increse capacity if its necessary
    EnsureCapacity(m_size + count);
    //--- shift the values to the right
    if (index < m_size)
      ArrayCopy(m_items, m_items, index + count, index, m_size - index);
    //--- insert values by index
    m_size += collection.CopyTo(m_items, index);
  }
  return (true);
}
//+------------------------------------------------------------------+
//| Copies a range of elements from the list to a compatible         |
//| one-dimensional array.                                           |
//+------------------------------------------------------------------+
template <typename T>
int CArrayList::CopyTo(T &dst_array[], const int dst_start = 0) {
  return ArrayCopy(dst_array, m_items, dst_start, 0, m_size);
}
//+------------------------------------------------------------------+
//| Searches a range of elements in the sorted list for an element   |
//| using the specified comparer and returns the zero-based index of |
//| the element.                                                     |
//+------------------------------------------------------------------+
template <typename T>
int CArrayList::BinarySearch(const int start_index, const int count, T item,
                             IComparer<T> *comparer) {
  //--- check index
  if (start_index < 0 || count < 0 || m_size - start_index < count)
    return (-1);
  //--- check comparer
  if (CheckPointer(comparer) != POINTER_INVALID) {
    //--- use specified comparer
    return ArrayBinarySearch(m_items, start_index, count, item, comparer);
  } else {
    CDefaultComparer<T> def_comparer;
    //--- use default comparer
    return ArrayBinarySearch(m_items, start_index, count, item,
                             GetPointer(def_comparer));
  }
}
//+------------------------------------------------------------------+
//| Searches the entire sorted list for an element using the         |
//| specified comparer and returns the zero-based index of the       |
//| element.                                                         |
//+------------------------------------------------------------------+
template <typename T>
int CArrayList::BinarySearch(T item, IComparer<T> *comparer) {
  return BinarySearch(0, m_size, item, comparer);
}
//+------------------------------------------------------------------+
//| Searches the entire sorted list for an element using the default |
//| comparer and returns the zero-based index of the element.        |
//+------------------------------------------------------------------+
template <typename T> int CArrayList::BinarySearch(T item) {
  return BinarySearch(item, NULL);
}
//+------------------------------------------------------------------+
//| Searches for the specified value and returns the zero-based index|
//| of the first occurrence within the entire list.                  |
//+------------------------------------------------------------------+
template <typename T> int CArrayList::IndexOf(T item) {
  return ArrayIndexOf(m_items, item, 0, m_size);
}
//+------------------------------------------------------------------+
//| Searches for the specified value and returns the zero-based index|
//| of the first occurrence within the range of elements in the list |
//| that extends from the specified index to the last element.       |
//+------------------------------------------------------------------+
template <typename T> int CArrayList::IndexOf(T item, const int start_index) {
  //--- check start index
  if (start_index >= m_size)
    return (-1);

  return ArrayIndexOf(m_items, item, start_index, m_size - start_index);
}
//+------------------------------------------------------------------+
//| Searches for the specified value and returns the zero-based index|
//| of the first occurrence within the range of elements in the list |
//| that starts at the specified index and contains the specified    |
//| number of elements.                                              |
//+------------------------------------------------------------------+
template <typename T>
int CArrayList::IndexOf(T item, const int start_index, const int count) {
  //--- check start index and count
  if (start_index < 0 || count < 0 || start_index >= m_size)
    return (-1);

  return ArrayIndexOf(m_items, item, start_index,
                      MathMin(m_size - start_index, count));
}
//+------------------------------------------------------------------+
//| Searches for the specified value and returns the zero-based index|
//| of the last occurrence within the entire list.                   |
//+------------------------------------------------------------------+
template <typename T> int CArrayList::LastIndexOf(T item) {
  return LastIndexOf(item, m_size - 1, m_size);
}
//+------------------------------------------------------------------+
//| Searches for the specified value and returns the zero-based index|
//| of the last occurrence within the range of elements in the list  |
//| that extends from the first element to the specified index.      |
//+------------------------------------------------------------------+
template <typename T>
int CArrayList::LastIndexOf(T item, const int start_index) {
  //--- check start index
  if (start_index >= m_size)
    return (-1);

  return ArrayLastIndexOf(m_items, item, start_index, start_index + 1);
}
//+------------------------------------------------------------------+
//| Searches for the specified value and returns the zero-based      |
//| index of the last occurrence within the range of elements in the |
//| list that contains the specified number of elements and ends at  |
//| the specified index.                                             |
//+------------------------------------------------------------------+
template <typename T>
int CArrayList::LastIndexOf(T item, const int start_index, const int count) {
  //--- check start index and count
  if (start_index < 0 || count < 0 || start_index >= m_size)
    return (-1);

  return ArrayLastIndexOf(m_items, item, start_index,
                          MathMin(start_index + 1, count));
}
//+------------------------------------------------------------------+
//| Removes all elements from the list.                              |
//+------------------------------------------------------------------+
template <typename T> void CArrayList::Clear(void) {
  //--- check current size
  if (m_size > 0) {
    ZeroMemory(m_items);
    m_size = 0;
  }
}
//+------------------------------------------------------------------+
//| Removes the element at the specified index of the list.          |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::RemoveAt(const int index) {
  //--- check index
  if ((uint)index >= (uint)m_size)
    return (false);
  //--- decrement size
  m_size--;
  //--- shift the values to the left
  if (index < m_size)
    ArrayCopy(m_items, m_items, index, index + 1, m_size - index);
  return (true);
}
//+------------------------------------------------------------------+
//| Removes the first occurrence of a specific object from the list. |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::Remove(T item) {
  //--- find index of value
  int index = IndexOf(item);
  //--- delete element by index
  if (index >= 0)
    return RemoveAt(index);
  else
    return (false);
}
//+------------------------------------------------------------------+
//| Removes a range of elements from the list.                       |
//+------------------------------------------------------------------+
template <typename T>
bool CArrayList::RemoveRange(const int start_index, const int count) {
  //--- check start index and count
  if (start_index < 0 || count < 0 || m_size - start_index < count)
    return (false);
  if (count > 0) {
    //--- decrement size
    m_size -= count;
    //--- shift the values to the left
    if (start_index < m_size)
      ArrayCopy(m_items, m_items, start_index, start_index + count,
                m_size - start_index);
  }
  return (true);
}
//+------------------------------------------------------------------+
//| Reverses the order of the elements in the entire list.           |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::Reverse(void) {
  return Reverse(0, m_size);
}
//+------------------------------------------------------------------+
//| Reverses the order of the elements in the specified range.       |
//+------------------------------------------------------------------+
template <typename T>
bool CArrayList::Reverse(const int start_index, const int count) {
  //--- check start index and count
  if (start_index < 0 || count < 0 || m_size - start_index < count)
    return (false);
  return ArrayReverse(m_items, start_index, count);
}
//+------------------------------------------------------------------+
//| Sorts the elements in the entire list using the default comparer.|
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::Sort(void) {
  return Sort(0, m_size, NULL);
}
//+------------------------------------------------------------------+
//| Sorts the elements in the entire list using the specified        |
//| comparer.                                                        |
//+------------------------------------------------------------------+
template <typename T> bool CArrayList::Sort(IComparer<T> *comparer) {
  return Sort(0, m_size, comparer);
}
//+------------------------------------------------------------------+
//| Sorts the elements in a range of elements in list using the      |
//| specified comparer.                                              |
//+------------------------------------------------------------------+
template <typename T>
bool CArrayList::Sort(const int start_index, const int count,
                      IComparer<T> *comparer) {
  //--- check start index and count
  if (start_index < 0 || count < 0 || m_size - start_index < count)
    return (false);
  //--- create instances of sorter
  Introsort<T, T> sorter();
  //--- set array to sorter
  ArrayCopy(sorter.keys, m_items);
  //--- check comparer
  if (CheckPointer(comparer) != POINTER_INVALID) {
    //--- use specified comparer
    sorter.comparer = comparer;
    //--- sort array
    sorter.Sort(start_index, count);
  } else {
    //--- use default comparer
    CDefaultComparer<T> def_comparer;
    sorter.comparer = GetPointer(def_comparer);
    //--- sort array
    sorter.Sort(start_index, count);
  }
  //--- store the sorted array
  ArrayCopy(m_items, sorter.keys);
  return (true);
}
//+------------------------------------------------------------------+
//| Ensures that the capacity of this list is at least the given     |
//| minimum value. If the currect capacity of the list is less than  |
//| min, the capacity is increased to twice the current capacity or  |
//| to min, whichever is larger.                                     |
//+------------------------------------------------------------------+
template <typename T> void CArrayList::EnsureCapacity(const int min) {
  int size = ArraySize(m_items);
  //--- check current size
  if (size < min) {
    int new_capacity = (size == 0) ? m_default_capacity : size * 2;
    //--- allow the list to grow to maximum possible capacity before
    //encountering overflow
    if ((uint)new_capacity > INT_MAX)
      new_capacity = INT_MAX;
    if (new_capacity < min)
      new_capacity = min;
    //--- set new capacity
    Capacity(new_capacity);
  }
}
//+------------------------------------------------------------------+

#endif
