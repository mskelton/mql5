#ifndef HASH_SET_H
#define HASH_SET_H

#include <Generic/Interfaces/IEqualityComparer.mqh>
#include <Generic/Interfaces/ISet.mqh>
#include <Generic/Internal/DefaultEqualityComparer.mqh>
#include <Generic/Internal/PrimeGenerator.mqh>

template <typename T> struct Slot ;

template <typename T> class CHashSet : public ISet<T> {
protected:
  int m_buckets;
  Slot<T> m_slots;
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
  CHashSet(T array[]);
  CHashSet(T array[], IEqualityComparer<T> *comparer);
  ~CHashSet(void);

  bool Add(T value);

  int Count(void) ;
  IEqualityComparer<T> *Comparer(void) const ;
  bool Contains(T item);
  void TrimExcess(void);

  int CopyTo(T ds_array[], const int dst_start = 0);

  void Clear(void);
  bool Remove(T item);

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










































#endif
