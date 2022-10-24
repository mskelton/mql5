#ifndef STACK_H
#define STACK_H

#include <Generic/Interfaces/ICollection.mqh>
#include <Generic/Internal/ArrayFunction.mqh>
#include <Generic/Internal/EqualFunction.mqh>

template <typename T> class CStack : public ICollection<T> {
protected:
  T m_array;
  int m_size;
  const int m_default_capacity;

public:
  CStack(void);
  CStack(const int capacity);
  CStack(ICollection<T> collection[]);
  CStack(T array[]);
  ~CStack(void);

  bool Add(T value);
  bool Push(T value);

  int Count(void);
  bool Contains(T item);
  void TrimExcess(void);

  int CopyTo(T dst_array[], const int dst_start = 0);

  void Clear(void);
  bool Remove(T item);

  T Peek(void);
  T Pop(void);
};
















#endif
