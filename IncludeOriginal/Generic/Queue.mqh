#ifndef QUEUE_H
#define QUEUE_H

#include <Generic\Interfaces\ICollection.mqh>
#include <Generic\Internal\ArrayFunction.mqh>
#include <Generic\Internal\EqualFunction.mqh>

template <typename T> class CQueue : public ICollection<T> {
protected:
  T m_array[];
  int m_size;
  int m_head;
  int m_tail;

public:
  CQueue(void);
  CQueue(const int capacity);
  CQueue(ICollection<T> &collection[]);
  CQueue(const T &array[]);
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

  int CopyTo(T &dst_array[], const int dst_start = 0) override;

  void Clear(void) override;
  bool Remove(T item) override;
  bool Dequeue(T &item);
  T Dequeue(void);
  bool Peek(T &item) const;
  T Peek(void) const;
};

template <typename T> CQueue::CQueue(void) : m_size(0), m_head(0), m_tail(0) {
}

template <typename T>
CQueue::CQueue(const int capacity) : m_size(0), m_head(0), m_tail(0) {
  ArrayResize(m_array, capacity);
}

template <typename T> CQueue::CQueue(const T &array[]) : m_head(0) {
  m_size = ArrayCopy(m_array, array);
  m_tail = m_size;
}

template <typename T>
CQueue::CQueue(ICollection<T> *collection) : m_size(0), m_head(0) {

  if (CheckPointer(collection) != POINTER_INVALID)
    m_size = collection.CopyTo(m_array);

  m_tail = m_size;
}

template <typename T> CQueue::CQueue(const CQueue &queue) {
  this = queue;
}

template <typename T> CQueue::~CQueue(void) {
}

template <typename T> bool CQueue::operator=(const CQueue &queue) {
  if (&this != &queue) {
    m_size = 0;
    m_head = 0;
    m_tail = 0;

    if (!SetCapacity(queue.m_size))
      return (false);

    m_size = queue.m_size;

    int size = ArraySize(queue.m_array);

    for (int i = 0; i < queue.m_size; i++)
      m_array[i] = queue.m_array[(queue.m_head + i) % size];
  }

  return (true);
}

template <typename T> bool CQueue::Add(T value) {
  return (Enqueue(value));
}

template <typename T> int CQueue::Count(void) {
  return (m_size);
}

template <typename T> bool CQueue::Contains(T item) {
  int size = ArraySize(m_array);

  for (int i = m_head, const end = m_head + m_size; i < end; i++) {

    if (::Equals(m_array[i % size], item))
      return (true);
  }

  return (false);
}

template <typename T> void CQueue::TrimExcess(double threshold_k = 0.9) {
  if (MathIsValidNumber(threshold_k) && threshold_k > 0.0) {

    int threshold = (int)(ArraySize(m_array) * MathMin(threshold_k, 1.0));

    if (m_size < threshold)
      SetCapacity(m_size);
  }
}

template <typename T>
int CQueue::CopyTo(T &dst_array[], const int dst_start = 0) {

  if ((dst_start + m_size) > ArraySize(dst_array))
    if (ArrayResize(dst_array, dst_start + m_size) < 0)
      return (0);

  if (m_tail >= m_head)
    return (ArrayCopy(dst_array, m_array, dst_start, m_head, m_size));

  int num_copied =
      ArrayCopy(dst_array, m_array, dst_start, m_head, m_size - m_head);

  num_copied +=
      ArrayCopy(dst_array, m_array, dst_start + num_copied, 0, m_tail);

  return (num_copied);
}

template <typename T> void CQueue::Clear(void) {

  if (m_size > 0) {
    ArrayFree(m_array);

    m_size = 0;
    m_head = 0;
    m_tail = 0;
  }
}

template <typename T> bool CQueue::Remove(T item) {

  if (!m_size)
    return (false);

  if (m_tail > m_head) {

    int index = ArrayIndexOf(m_array, item, m_head, m_size);

    if (index != -1) {
      m_size--;

      if (index == m_head)
        m_head++;
      else {

        m_tail--;

        if ((m_size - index) != 0)
          ArrayCopy(m_array, m_array, index, index + 1, m_size - index);
      }

      return (true);
    }
  } else {

    int head_size = m_size - m_tail;
    int index = ArrayIndexOf(m_array, item, m_head, head_size);

    if (index != -1) {
      m_size--;

      if (index == m_head)
        m_head++;
      else {

        head_size--;

        if ((m_head + head_size - index) != 0)
          ArrayCopy(m_array, m_array, index, index + 1,
                    m_head + head_size - index);

        if (m_tail) {
          m_tail--;
          m_array[m_head + head_size] = m_array[0];

          if (m_tail != 0)
            ArrayCopy(m_array, m_array, 0, 1, m_tail);
        } else
          m_tail = m_head + head_size;
      }

      return (true);
    }

    index = ArrayIndexOf(m_array, item, 0, m_tail);

    if (index != -1) {
      m_tail--;
      m_size--;
      if ((m_tail - index) != 0)
        ArrayCopy(m_array, m_array, index, index + 1, m_tail - index);
      return (true);
    }
  }

  return (false);
}

template <typename T> bool CQueue::Enqueue(T value) {
  int size = ArraySize(m_array);

  if (m_size == size) {

    if (size == INT_MAX)
      return (false);

    int new_capacity = MathMax((int)MathMin(size / 2ull + size, INT_MAX), 16);

    if (!SetCapacity(new_capacity))
      return (false);

    size = ArraySize(m_array);
  }

  m_array[m_tail++] = value;

  m_size++;
  m_tail %= size;

  return (true);
}

template <typename T> bool CQueue::Dequeue(T &item) {

  if (!m_size)
    return (false);

  item = m_array[m_head++];

  m_size--;
  m_head %= ArraySize(m_array);
  return (true);
}

template <typename T> T CQueue::Dequeue(void) {
  int index = m_head;

  m_size--;
  m_head = (m_head + 1) % ArraySize(m_array);

  return (m_array[index]);
}

template <typename T> bool CQueue::Peek(T &item) const {

  if (!m_size)
    return (false);

  item = m_array[m_head];
  return (true);
}

template <typename T> T CQueue::Peek(void) const {

  return (m_array[m_head]);
}

template <typename T> bool CQueue::SetCapacity(const int capacity) {

  T new_array[];

  if (ArrayResize(new_array, capacity) != capacity)
    return (false);

  if (m_size > 0) {
    if (m_head < m_tail) {
      ArrayCopy(new_array, m_array, 0, m_head, m_size);
    } else {
      const int head_size = m_size - m_tail;

      ArrayCopy(new_array, m_array, 0, m_head, head_size);

      ArrayCopy(new_array, m_array, head_size, 0, m_tail);
    }
  }

  ArraySwap(m_array, new_array);

  m_head = 0;
  m_tail = m_size;
  return (true);
}

template <typename T> int CQueue::Capacity(void) const {
  return (ArraySize(m_array) - m_size);
}

#endif
