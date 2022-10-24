#ifndef QUEUE_H
#define QUEUE_H

#include <Generic/Interfaces/ICollection.mqh>
#include <Generic/Internal/ArrayFunction.mqh>
#include <Generic/Internal/EqualFunction.mqh>

template <typename T> class CQueue : public ICollection<T> {
protected:
  T m_array;
  int m_size;
  int m_head;
  int m_tail;

public:
  CQueue(void);
  CQueue(const int capacity);
  CQueue(ICollection<T> collection[]);
  CQueue(const T array[]);
  CQueue(const CQueue &queue);

  ~CQueue(void);

  bool operator=(const CQueue &queue);

  bool Add(T value) override;
  bool Enqueue(T value);

  int Count(void) override;
  int Capacity(void) const;
  bool Contains(T item) override;
  bool SetCapacity(const int capacity);
  void TrimExcess(double threshold_k = 0.9);

  int CopyTo(T dst_array[], const int dst_start = 0) override;

  void Clear(void) override;
  bool Remove(T item) override;
  bool Dequeue(T &item);
  T Dequeue(void);
  bool Peek(T &item) const;
  T Peek(void) const;
};






















#endif
