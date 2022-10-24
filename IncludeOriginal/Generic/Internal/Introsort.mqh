#ifndef INTROSORT_H
#define INTROSORT_H

template <typename TKey, typename TItem> struct Introsort {
public:
  IComparer<TKey> *comparer;
  TKey keys[];
  TItem items[];

  Introsort(void) {
  }
  ~Introsort(void) {
  }

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

template <typename TKey, typename TItem>
void Introsort::Sort(const int index, const int length) {
  if (length < 2)
    return;
  IntroSort(index, length + index - 1, 2 * FloorLog2(ArraySize(keys)));
}

template <typename TKey, typename TItem>
void Introsort::SwapIfGreaterWithItems(const int a, const int b) {
  if (a != b) {
    if (comparer.Compare(keys[a], keys[b]) > 0) {
      TKey key = keys[a];
      keys[a] = keys[b];
      keys[b] = key;
      if (ArraySize(items) != NULL) {
        TItem item = items[a];
        items[a] = items[b];
        items[b] = item;
      }
    }
  }
}

template <typename TKey, typename TItem>
void Introsort::Swap(const int i, const int j) {
  TKey key = keys[i];
  keys[i] = keys[j];
  keys[j] = key;
  if (ArraySize(items) != NULL) {
    TItem item = items[i];
    items[i] = items[j];
    items[j] = item;
  }
}

template <typename TKey, typename TItem> int Introsort::FloorLog2(int n) const {
  int result = 0;
  while (n >= 1) {
    result++;
    n = n / 2;
  }
  return (result);
}

template <typename TKey, typename TItem>
void Introsort::IntroSort(const int lo, int hi, int depthLimit) {
  const int IntrosortSizeThreshold = 16;
  while (hi > lo) {
    int partitionSize = hi - lo + 1;
    if (partitionSize <= IntrosortSizeThreshold) {
      if (partitionSize == 1) {
        return;
      }
      if (partitionSize == 2) {
        SwapIfGreaterWithItems(lo, hi);
        return;
      }
      if (partitionSize == 3) {
        SwapIfGreaterWithItems(lo, hi - 1);
        SwapIfGreaterWithItems(lo, hi);
        SwapIfGreaterWithItems(hi - 1, hi);
        return;
      }
      InsertionSort(lo, hi);
      return;
    }
    if (depthLimit == 0) {
      Heapsort(lo, hi);
      return;
    }
    depthLimit--;
    int p = PickPivotAndPartition(lo, hi);
    IntroSort(p + 1, hi, depthLimit);
    hi = p - 1;
  }
}

template <typename TKey, typename TItem>
void Introsort::InsertionSort(const int lo, const int hi) {
  int i, j;
  TKey t;
  TItem dt;
  for (i = lo; i < hi; i++) {
    j = i;
    t = keys[i + 1];
    dt = (ArraySize(items) != NULL) ? (TItem)items[i + 1] : (TItem)NULL;
    while (j >= lo && comparer.Compare(t, keys[j]) < 0) {
      keys[j + 1] = keys[j];
      if (ArraySize(items) != NULL) {
        items[j + 1] = items[j];
      }
      j--;
    }
    keys[j + 1] = t;
    if (ArraySize(items) != NULL) {
      items[j + 1] = dt;
    }
  }
}

template <typename TKey, typename TItem>
int Introsort::PickPivotAndPartition(const int lo, const int hi) {

  int mid = lo + (hi - lo) / 2;
  SwapIfGreaterWithItems(lo, mid);
  SwapIfGreaterWithItems(lo, hi);
  SwapIfGreaterWithItems(mid, hi);
  TKey pivot = keys[mid];
  Swap(mid, hi - 1);
  int left = lo, right = hi - 1;
  while (left < right) {
    while (comparer.Compare(keys[++left], pivot) < 0)
      ;
    while (comparer.Compare(pivot, keys[--right]) < 0)
      ;
    if (left >= right)
      break;
    Swap(left, right);
  }

  Swap(left, (hi - 1));
  return (left);
}

template <typename TKey, typename TItem>
void Introsort::Heapsort(const int lo, const int hi) {
  int n = hi - lo + 1;
  for (int i = n / 2; i >= 1; i = i - 1) {
    DownHeap(i, n, lo);
  }
  for (int i = n; i > 1; i = i - 1) {
    Swap(lo, lo + i - 1);
    DownHeap(1, i - 1, lo);
  }
}

template <typename TKey, typename TItem>
void Introsort::DownHeap(int i, const int n, const int lo) {
  TKey d = keys[lo + i - 1];
  TItem dt = items[lo + i - 1];
  int child;
  while (i <= n / 2) {
    child = 2 * i;
    if (child < n &&
        comparer.Compare(keys[lo + child - 1], keys[lo + child]) < 0) {
      child++;
    }
    if (!(comparer.Compare(d, keys[lo + child - 1]) < 0)) {
      break;
    }
    keys[lo + i - 1] = keys[lo + child - 1];
    if (true) {
      items[lo + i - 1] = items[lo + child - 1];
    }
    i = child;
  }
  keys[lo + i - 1] = d;
  if (ArraySize(items) != NULL) {
    items[lo + i - 1] = dt;
  }
}

#endif
