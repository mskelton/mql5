#ifndef STACK_H
#define STACK_H

#include <Generic\Interfaces\ICollection.mqh>
#include <Generic\Internal\ArrayFunction.mqh>
#include <Generic\Internal\EqualFunction.mqh>

template <typename T> class CStack : public ICollection<T> {
protected:
  T m_array[];
  int m_size;
  const int m_default_capacity;

public:
  CStack(void);
  CStack(const int capacity);
  CStack(ICollection<T> &collection[]);
  CStack(T &array[]);
  ~CStack(void);

  bool Add(T value);
  bool Push(T value);

  int Count(void);
  bool Contains(T item);
  void TrimExcess(void);

  int CopyTo(T &dst_array[], const int dst_start = 0);

  void Clear(void);
  bool Remove(T item);

  T Peek(void);
  T Pop(void);
};

template <typename T> CStack::CStack(void) : m_default_capacity(4), m_size(0) {}

template <typename T>
CStack::CStack(const int capacity) : m_default_capacity(4), m_size(0) {
  ArrayResize(m_array, capacity);
}

template <typename T>
CStack::CStack(T &array[]) : m_default_capacity(4), m_size(0) {
  m_size = ArrayCopy(m_array, array);
}

template <typename T>
CStack::CStack(ICollection<T> *collection) : m_default_capacity(4), m_size(0) {

  if (CheckPointer(collection) != POINTER_INVALID)
    m_size = collection.CopyTo(m_array, 0);
}

template <typename T> CStack::~CStack(void) {}

template <typename T> bool CStack::Add(T value) {
  return Push(value);
}

template <typename T> int CStack::Count(void) {
  return (m_size);
}

template <typename T> bool CStack::Contains(T item) {
  int count = m_size;

  while (count-- > 0) {

    if (::Equals(m_array[count], item))
      return (true);
  }
  return (false);
}

template <typename T>
int CStack::CopyTo(T &dst_array[], const int dst_start = 0) {

  if (dst_start + m_size > ArraySize(dst_array))
    ArrayResize(dst_array, dst_start + m_size);

  int src_index = m_size - 1;
  int dst_index = dst_start;
  while (src_index >= 0 && dst_index < ArraySize(dst_array))
    dst_array[dst_index++] = m_array[src_index--];
  return (dst_index - dst_start);
}

template <typename T> void CStack::Clear(void) {

  if (m_size > 0) {
    ZeroMemory(m_array);
    m_size = 0;
  }
}

template <typename T> bool CStack::Remove(T item) {

  int index = ArrayIndexOf(m_array, item, 0, m_size);

  if (index == -1)
    return (false);

  ArrayCopy(m_array, m_array, index, index + 1);

  m_size--;
  return (true);
}

template <typename T> bool CStack::Push(T value) {
  int size = ArraySize(m_array);

  if (m_size == size) {

    if (size == 0)
      ArrayResize(m_array, m_default_capacity);
    else
      ArrayResize(m_array, 2 * size);
  }

  m_array[m_size++] = value;
  return (true);
}

template <typename T> T CStack::Peek(void) {

  return (m_array[m_size - 1]);
}

template <typename T> T CStack::Pop(void) {

  T item = m_array[--m_size];
  return (item);
}

template <typename T> void CStack::TrimExcess(void) {

  int threshold = (int)(((double)ArraySize(m_array) * 0.9));

  if (m_size < threshold)
    ArrayResize(m_array, m_size);
}

#endif
