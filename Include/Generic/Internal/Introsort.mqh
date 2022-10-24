#ifndef INTROSORT_H
#define INTROSORT_H

#include <Generic/Interfaces/IComparer.mqh>

template <typename TKey, typename TItem> struct Introsort {
public:
  IComparer<TKey> *comparer;
  TKey keys;
  TItem items;

  Introsort(void);
  ~Introsort(void);

  void Sort(const int index, const int length);

private:
  void IntroSort(const int lo, const int hi, int depthLimit);
  int PickPivotAndPartition(const int lo, const int hi);
  void InsertionSort(const int lo, const int hi);

  void Heapsort(const int lo, const int hi);
  void DownHeap(const int i, const int n, const int lo);

  void SwapIfGreaterWithItems(const int a, const int b);
  void Swap(const int i, const int j);

  int FloorLog2(int n) const;
};

#endif
