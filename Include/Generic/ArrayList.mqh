#ifndef ARRAY_LIST_H
#define ARRAY_LIST_H

#include <Generic/Interfaces/IComparer.mqh>
#include <Generic/Interfaces/IList.mqh>
#include <Generic/Internal/ArrayFunction.mqh>
#include <Generic/Internal/DefaultComparer.mqh>
#include <Generic/Internal/EqualFunction.mqh>
#include <Generic/Internal/Introsort.mqh>

template <typename T> class CArrayList : public IList<T> {
protected:
  T m_items;
  int m_size;
  const int m_default_capacity;

public:
  CArrayList(void);
  CArrayList(const int capacity);
  CArrayList(ICollection<T> *collection);
  CArrayList(T array[]);
  ~CArrayList(void);

  int Capacity(void);
  void Capacity(const int capacity);
  int Count(void);
  bool Contains(T item);
  void TrimExcess(void);

  bool TryGetValue(const int index, T &value);
  bool TrySetValue(const int index, T value);

  bool Add(T item);
  bool AddRange(T array[]);
  bool AddRange(ICollection<T> *collection);
  bool Insert(const int index, T item);
  bool InsertRange(const int index, T array[]);
  bool InsertRange(const int index, ICollection<T> *collection);

  int CopyTo(T dst_array[], const int dst_start = 0);

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







































#endif
