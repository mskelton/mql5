#ifndef SORTED_SET_H
#define SORTED_SET_H

#include "HashSet.mqh"
#include "RedBlackTree.mqh"
#include <Generic\Interfaces\ISet.mqh>
#include <Generic\Internal\Introsort.mqh>

template <typename T> class CSortedSet : public ISet<T> {
protected:
  CRedBlackTree<T> *m_tree;

public:
  CSortedSet(void);
  CSortedSet(IComparer<T> *comparer);
  CSortedSet(ICollection<T> *collection);
  CSortedSet(ICollection<T> *collection, IComparer<T> *comparer);
  CSortedSet(T &array[]);
  CSortedSet(T &array[], IComparer<T> *comparer);
  ~CSortedSet(void);

  bool Add(T value) {
    return (m_tree.Add(value));
  }

  int Count(void) {
    return (m_tree.Count());
  }
  bool Contains(T item) {
    return (m_tree.Contains(item));
  }
  IComparer<T> *Comparer(void) const {
    return (m_tree.Comparer());
  }
  bool TryGetMin(T &min) {
    return (m_tree.TryGetMin(min));
  }
  bool TryGetMax(T &max) {
    return (m_tree.TryGetMax(max));
  }

  int CopyTo(T &dst_array[], const int dst_start = 0);

  void Clear(void) {
    m_tree.Clear();
  }
  bool Remove(T item) {
    return (m_tree.Remove(item));
  }

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

  bool GetViewBetween(T &array[], T lower_value, T upper_value);
  bool GetReverse(T &array[]);
};

template <typename T> CSortedSet::CSortedSet(void) {
  m_tree = new CRedBlackTree<T>();
}

template <typename T> CSortedSet::CSortedSet(IComparer<T> *comparer) {
  m_tree = new CRedBlackTree<T>(comparer);
}

template <typename T> CSortedSet::CSortedSet(ICollection<T> *collection) {
  m_tree = new CRedBlackTree<T>(collection);
}

template <typename T>
CSortedSet::CSortedSet(ICollection<T> *collection, IComparer<T> *comparer) {
  m_tree = new CRedBlackTree<T>(collection, comparer);
}

template <typename T> CSortedSet::CSortedSet(T &array[]) {
  m_tree = new CRedBlackTree<T>(array);
}

template <typename T>
CSortedSet::CSortedSet(T &array[], IComparer<T> *comparer) {
  m_tree = new CRedBlackTree<T>(array, comparer);
}

template <typename T> CSortedSet::~CSortedSet(void) {
  delete m_tree;
}

template <typename T>
int CSortedSet::CopyTo(T &dst_array[], const int dst_start = 0) {
  return (m_tree.CopyTo(dst_array, dst_start));
}

template <typename T> void CSortedSet::ExceptWith(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  if (m_tree.Count() == 0)
    return;

  if (collection == GetPointer(this)) {
    Clear();
    return;
  }

  T array[];
  int size = collection.CopyTo(array);

  T max;
  T min;

  IComparer<T> *comparer = Comparer();
  if (!m_tree.TryGetMax(max))
    return;
  if (!m_tree.TryGetMin(min))
    return;

  for (int i = 0; i < size; i++) {
    T item = array[i];
    if (!(comparer.Compare(item, min) < 0 || comparer.Compare(item, max) > 0) &&
        Contains(item))
      m_tree.Remove(item);
  }
}

template <typename T> void CSortedSet::ExceptWith(T &array[]) {

  if (m_tree.Count() == 0)
    return;

  int size = ArraySize(array);

  T max;
  T min;

  IComparer<T> *comparer = Comparer();
  if (!m_tree.TryGetMax(max))
    return;
  if (!m_tree.TryGetMin(min))
    return;

  for (int i = 0; i < size; i++) {
    T item = array[i];
    if (!(comparer.Compare(item, min) < 0 || comparer.Compare(item, max) > 0) &&
        Contains(item))
      m_tree.Remove(item);
  }
}

template <typename T>
void CSortedSet::IntersectWith(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  if (m_tree.Count() == 0)
    return;

  if (collection == GetPointer(this))
    return;

  T array[];
  int size = collection.CopyTo(array);

  CRedBlackTree<T> *tree = new CRedBlackTree<T>();

  for (int i = 0; i < size; i++)
    if (m_tree.Contains(array[i]))
      tree.Add(array[i]);

  delete m_tree;
  m_tree = tree;
}

template <typename T> void CSortedSet::IntersectWith(T &array[]) {

  if (m_tree.Count() == 0)
    return;

  int size = ArraySize(array);

  CRedBlackTree<T> *tree = new CRedBlackTree<T>();

  for (int i = 0; i < size; i++)
    if (m_tree.Contains(array[i]))
      tree.Add(array[i]);

  delete m_tree;
  m_tree = tree;
}

template <typename T>
void CSortedSet::SymmetricExceptWith(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  if (collection.Count() == 0)
    return;

  if (m_tree.Count() == 0) {
    UnionWith(collection);
    return;
  }

  if (collection == GetPointer(this)) {
    Clear();
    return;
  }

  T array[];
  int size = collection.CopyTo(array);

  IComparer<T> *comparer = m_tree.Comparer();

  Introsort<T, T> sort;
  ArrayCopy(sort.keys, array);
  sort.comparer = comparer;
  sort.Sort(0, size);
  ArrayCopy(array, sort.keys);

  T last = array[0];
  for (int i = 0; i < size; i++) {
    while (i < size && i != 0 && comparer.Compare(array[i], last) == 0)
      i++;
    if (i >= size)
      break;

    if (m_tree.Contains(array[i]))
      m_tree.Remove(array[i]);
    else
      m_tree.Add(array[i]);

    last = array[i];
  }
}

template <typename T> void CSortedSet::SymmetricExceptWith(T &array[]) {

  if (ArraySize(array) == 0)
    return;

  if (m_tree.Count() == 0) {
    UnionWith(array);
    return;
  }

  int size = ArraySize(array);

  IComparer<T> *comparer = m_tree.Comparer();

  Introsort<T, T> sort;
  ArrayCopy(sort.keys, array);
  sort.comparer = comparer;
  sort.Sort(0, size);
  ArrayReverse(sort.keys, 0, ArraySize(sort.keys));

  T last = sort.keys[0];
  for (int i = 0; i < size; i++) {
    while (i < size && i != 0 && comparer.Compare(sort.keys[i], last) == 0)
      i++;
    if (i >= size)
      break;

    if (m_tree.Contains(sort.keys[i]))
      m_tree.Remove(sort.keys[i]);
    else
      m_tree.Add(sort.keys[i]);

    last = sort.keys[i];
  }
}

template <typename T> void CSortedSet::UnionWith(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  T array[];
  int size = collection.CopyTo(array);

  for (int i = 0; i < size; i++)
    m_tree.Add(array[i]);
}

template <typename T> void CSortedSet::UnionWith(T &array[]) {

  int size = ArraySize(array);

  for (int i = 0; i < size; i++)
    m_tree.Add(array[i]);
}

template <typename T>
bool CSortedSet::IsProperSubsetOf(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);

  if (m_tree.Count() == 0)
    return (collection.Count() > 0);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    return (ptr_set.IsProperSupersetOf(m_tree));
  } else {

    CHashSet<T> set(collection);
    return (set.IsProperSupersetOf(m_tree));
  }
}

template <typename T> bool CSortedSet::IsProperSubsetOf(T &array[]) {
  if (m_tree.Count() == 0)
    return (ArraySize(array) > 0);

  CHashSet<T> set(array);
  if (m_tree.Count() >= set.Count())
    return (false);
  return (set.IsProperSupersetOf(m_tree));
}

template <typename T>
bool CSortedSet::IsProperSupersetOf(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (m_tree.Count() > 0);

  if (m_tree.Count() == 0)
    return (false);

  if (collection.Count() == 0)
    return (true);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    return (ptr_set.IsProperSubsetOf(m_tree));
  } else {

    CHashSet<T> set(collection);
    return (set.IsProperSubsetOf(m_tree));
  }
}

template <typename T> bool CSortedSet::IsProperSupersetOf(T &array[]) {
  if (m_tree.Count() == 0)
    return (false);
  if (ArraySize(array) == 0)
    return (true);

  CHashSet<T> set(array);
  return (set.IsProperSubsetOf(m_tree));
}

template <typename T> bool CSortedSet::IsSubsetOf(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (m_tree.Count() == 0);

  if (m_tree.Count() == 0)
    return (true);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) == POINTER_DYNAMIC) {
    return (ptr_set.IsProperSupersetOf(m_tree));
  } else {

    CHashSet<T> set(collection);
    return (set.IsProperSupersetOf(m_tree));
  }
}

template <typename T> bool CSortedSet::IsSubsetOf(T &array[]) {

  if (m_tree.Count() == 0)
    return (true);

  CHashSet<T> set(array);
  if (m_tree.Count() > set.Count())
    return (false);
  return (set.IsProperSupersetOf(m_tree));
}

template <typename T>
bool CSortedSet::IsSupersetOf(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (m_tree.Count() >= 0);

  if (collection.Count() == 0)
    return (true);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    return (ptr_set.IsSupersetOf(m_tree));
  } else {

    CHashSet<T> set(collection);
    return (set.IsSupersetOf(m_tree));
  }
}

template <typename T> bool CSortedSet::IsSupersetOf(T &array[]) {

  if (ArraySize(array) == 0)
    return (true);

  CHashSet<T> set(array);
  return (set.IsSupersetOf(m_tree));
}

template <typename T> bool CSortedSet::Overlaps(ICollection<T> *collection) {

  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);

  if (m_tree.Count() == 0)
    return (false);

  if (collection.Count() == 0)
    return (false);

  CHashSet<T> *ptr_set = dynamic_cast<CHashSet<T> *>(collection);
  if (CheckPointer(ptr_set) != POINTER_INVALID) {
    return (ptr_set.Overlaps(m_tree));
  } else {

    CHashSet<T> set(collection);
    return (set.Overlaps(m_tree));
  }
}

template <typename T> bool CSortedSet::Overlaps(T &array[]) {

  if (m_tree.Count() == 0)
    return (false);

  if (ArraySize(array) == 0)
    return (false);

  CHashSet<T> set(array);
  return (set.Overlaps(m_tree));
}

template <typename T> bool CSortedSet::SetEquals(ICollection<T> *collection) {
  if (CheckPointer(collection) == POINTER_INVALID)
    return (false);

  T array[];
  collection.CopyTo(array);

  return SetEquals(array);
}

template <typename T> bool CSortedSet::SetEquals(T &array[]) {

  for (int i = 0; i < ArraySize(array); i++)
    if (!m_tree.Contains(array[i]))
      return (false);
  return (true);
}

template <typename T>
bool CSortedSet::GetViewBetween(T &array[], T lower_value, T upper_value) {

  IComparer<T> *comparer = m_tree.Comparer();
  if (comparer.Compare(lower_value, upper_value) > 0)
    return (false);

  T buff[];
  int size = m_tree.CopyTo(buff);

  if (size == 0 || comparer.Compare(buff[0], upper_value) > 0 ||
      comparer.Compare(buff[size - 1], lower_value) < 0)
    return (false);

  int index_lower = 0;
  while (index_lower < size &&
         comparer.Compare(buff[index_lower], lower_value) < 0)
    index_lower++;

  int index_upper = size - 1;
  while (index_upper > 0 &&
         comparer.Compare(buff[index_upper], upper_value) > 0)
    index_upper--;

  if (index_lower > index_upper)
    return (false);

  return (ArrayCopy(array, buff, 0, index_lower,
                    index_upper - index_lower + 1) >= 0);
}

template <typename T> bool CSortedSet::GetReverse(T &array[]) {
  int size = m_tree.CopyTo(array);
  return ArrayReverse(array, 0, size);
}

#endif
