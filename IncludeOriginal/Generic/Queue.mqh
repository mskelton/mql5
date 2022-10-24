#ifndef QUEUE_H
#define QUEUE_H
//|                   Copyright 2016-2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <Generic\Interfaces\ICollection.mqh>
#include <Generic\Internal\ArrayFunction.mqh>
#include <Generic\Internal\EqualFunction.mqh>
//+------------------------------------------------------------------+
//| Class CQueue<T>                                                  |
//| Usage: Represents a first-in, first-out collection of objects    |
//+------------------------------------------------------------------+
template <typename T> class CQueue : public ICollection<T> {
protected:
  T m_array[];
  int m_size; // items in queue
  int m_head; // first valid element in the queue
  int m_tail; // last valid element in the queue

public:
  CQueue(void);
  CQueue(const int capacity);
  CQueue(ICollection<T> &collection[]);
  CQueue(const T &array[]);
  CQueue(const CQueue &queue);

  ~CQueue(void);

  bool operator=(const CQueue &queue);
  //--- methods of filling data
  bool Add(T value) override;
  bool Enqueue(T value);
  //--- methods of access to protected data
  int Count(void) override;
  int Capacity(void) const;
  bool Contains(T item) override;
  bool SetCapacity(const int capacity);
  void TrimExcess(double threshold_k = 0.9);
  //--- methods of copy data from collection
  int CopyTo(T &dst_array[], const int dst_start = 0) override;
  //--- methods of cleaning and removing
  void Clear(void) override;
  bool Remove(T item) override;
  bool Dequeue(T &item);
  T Dequeue(void);
  bool Peek(T &item) const;
  T Peek(void) const;
};
//+------------------------------------------------------------------+
//| Initializes a new instance of the CQueue<T> class that is empty  |
//| and has the default initial capacity                             |
//+------------------------------------------------------------------+
template <typename T> CQueue::CQueue(void) : m_size(0), m_head(0), m_tail(0) {
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CQueue<T> class that is empty  |
//| and has the specified initial capacity or the default initial    |
//| capacity, whichever is greater                                   |
//+------------------------------------------------------------------+
template <typename T>
CQueue::CQueue(const int capacity) : m_size(0), m_head(0), m_tail(0) {
  ArrayResize(m_array, capacity);
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CQueue<T> class that contains  |
//| elements copied from the specified array and has sufficient      |
//| capacity to accommodate the number of elements copied            |
//+------------------------------------------------------------------+
template <typename T> CQueue::CQueue(const T &array[]) : m_head(0) {
  m_size = ArrayCopy(m_array, array);
  m_tail = m_size;
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CQueue<T> class that contains  |
//| elements copied from the specified collection and has sufficient |
//| capacity to accommodate the number of elements copied            |
//+------------------------------------------------------------------+
template <typename T>
CQueue::CQueue(ICollection<T> *collection) : m_size(0), m_head(0) {
  //--- check collection
  if (CheckPointer(collection) != POINTER_INVALID)
    m_size = collection.CopyTo(m_array);
  //--- set tail
  m_tail = m_size;
}
//+------------------------------------------------------------------+
//| Copy constructor                                                 |
//+------------------------------------------------------------------+
template <typename T> CQueue::CQueue(const CQueue &queue) {
  this = queue;
}
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
template <typename T> CQueue::~CQueue(void) {
}
//+------------------------------------------------------------------+
//| Copy operator                                                    |
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
//| Inserts an value at the top of the CQueue<T>                     |
//+------------------------------------------------------------------+
template <typename T> bool CQueue::Add(T value) {
  return (Enqueue(value));
}
//+------------------------------------------------------------------+
//| Gets the number of elements                                      |
//+------------------------------------------------------------------+
template <typename T> int CQueue::Count(void) {
  return (m_size);
}
//+------------------------------------------------------------------+
//| Removes all values from the CQueue<T>                            |
//+------------------------------------------------------------------+
template <typename T> bool CQueue::Contains(T item) {
  int size = ArraySize(m_array);
  //--- try to find item in array
  for (int i = m_head, const end = m_head + m_size; i < end; i++) {
    //--- use default equality function
    if (::Equals(m_array[i % size], item))
      return (true);
  }

  return (false);
}
//+------------------------------------------------------------------+
//| Sets the capacity to the actual number of elements in the queue, |
//| if that number is less than a threshold value                    |
//+------------------------------------------------------------------+
template <typename T> void CQueue::TrimExcess(double threshold_k = 0.9) {
  if (MathIsValidNumber(threshold_k) && threshold_k > 0.0) {
    //--- calculate threshold value
    int threshold = (int)(ArraySize(m_array) * MathMin(threshold_k, 1.0));
    //--- set a Ñapacity equal to the size
    if (m_size < threshold)
      SetCapacity(m_size);
  }
}
//+------------------------------------------------------------------+
//| Copies a range of elements from the queue to a compatible        |
//| one-dimensional array                                            |
//+------------------------------------------------------------------+
template <typename T>
int CQueue::CopyTo(T &dst_array[], const int dst_start = 0) {
  //--- resize array
  if ((dst_start + m_size) > ArraySize(dst_array))
    if (ArrayResize(dst_array, dst_start + m_size) < 0)
      return (0);
  //--- copy queue elements from head to tail
  if (m_tail >= m_head)
    return (ArrayCopy(dst_array, m_array, dst_start, m_head, m_size));
  //--- copy queue elements from head to end
  int num_copied =
      ArrayCopy(dst_array, m_array, dst_start, m_head, m_size - m_head);
  //--- copy queue elements from beginning to tail
  num_copied +=
      ArrayCopy(dst_array, m_array, dst_start + num_copied, 0, m_tail);
  //--- return number of copied elements
  return (num_copied);
}
//+------------------------------------------------------------------+
//| Removes all values from the CQueue<T>                            |
//+------------------------------------------------------------------+
template <typename T> void CQueue::Clear(void) {
  //--- check current size
  if (m_size > 0) {
    ArrayFree(m_array);

    m_size = 0;
    m_head = 0;
    m_tail = 0;
  }
}
//+------------------------------------------------------------------+
//| Removes the first occurrence of a specific value from the stack  |
//+------------------------------------------------------------------+
template <typename T> bool CQueue::Remove(T item) {
  //--- check for queue size
  if (!m_size)
    return (false);
  //--- find from head to tail
  if (m_tail > m_head) {
    //--- try to find index of item
    int index = ArrayIndexOf(m_array, item, m_head, m_size);

    if (index != -1) {
      m_size--;
      //--- remove from queue head
      if (index == m_head)
        m_head++;
      else {
        //--- correct tail
        m_tail--;

        if ((m_size - index) != 0)
          ArrayCopy(m_array, m_array, index, index + 1, m_size - index);
      }

      return (true);
    }
  } else {
    //--- try to find in head part
    int head_size = m_size - m_tail;
    int index = ArrayIndexOf(m_array, item, m_head, head_size);

    if (index != -1) {
      m_size--;
      //--- remove from queue head
      if (index == m_head)
        m_head++;
      else {
        //--- remove from head part
        head_size--;

        if ((m_head + head_size - index) != 0)
          ArrayCopy(m_array, m_array, index, index + 1,
                    m_head + head_size - index);
        //--- correct tail
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
    //--- try to find in tail part
    index = ArrayIndexOf(m_array, item, 0, m_tail);

    if (index != -1) {
      m_tail--;
      m_size--;
      if ((m_tail - index) != 0)
        ArrayCopy(m_array, m_array, index, index + 1, m_tail - index);
      return (true);
    }
  }
  //---
  return (false);
}
//+------------------------------------------------------------------+
//| Adds an value to the end of the CQueue<T>                        |
//+------------------------------------------------------------------+
template <typename T> bool CQueue::Enqueue(T value) {
  int size = ArraySize(m_array);
  //--- check queue capacity
  if (m_size == size) {
    //--- check for max size
    if (size == INT_MAX)
      return (false);
    //--- calculate and set new capacity
    int new_capacity = MathMax((int)MathMin(size / 2ull + size, INT_MAX), 16);

    if (!SetCapacity(new_capacity))
      return (false);

    size = ArraySize(m_array);
  }
  //--- add value to the end
  m_array[m_tail++] = value;
  //--- increase size and recalculate tail
  m_size++;
  m_tail %= size;

  return (true);
}
//+------------------------------------------------------------------+
//| Removes and returns the value at the beginning of the CQueue<T>  |
//+------------------------------------------------------------------+
template <typename T> bool CQueue::Dequeue(T &item) {
  //--- check queue is not empty
  if (!m_size)
    return (false);
  //--- get value from the end
  item = m_array[m_head++];
  //--- decrement size and recalculate head
  m_size--;
  m_head %= ArraySize(m_array);
  return (true);
}
//+------------------------------------------------------------------+
//| Removes and returns the value at the beginning of the CQueue<T>  |
//+------------------------------------------------------------------+
template <typename T> T CQueue::Dequeue(void) {
  int index = m_head;
  //--- decrement size and recalculate head
  m_size--;
  m_head = (m_head + 1) % ArraySize(m_array);

  return (m_array[index]);
}
//+------------------------------------------------------------------+
//| Returns the value at the beginning of the CQueue<T> without      |
//| removing                                                         |
//+------------------------------------------------------------------+
template <typename T> bool CQueue::Peek(T &item) const {
  //--- check queue is not empty
  if (!m_size)
    return (false);
  //--- get value from the end
  item = m_array[m_head];
  return (true);
}
//+------------------------------------------------------------------+
//| Returns the value at the beginning of the CQueue<T> without      |
//| removing                                                         |
//+------------------------------------------------------------------+
template <typename T> T CQueue::Peek(void) const {
  //--- get value from the end
  return (m_array[m_head]);
}
//+------------------------------------------------------------------+
//| Grows or shrinks the buffer to hold capacity values              |
//+------------------------------------------------------------------+
template <typename T> bool CQueue::SetCapacity(const int capacity) {
  //--- create a new array array for temporary storage
  T new_array[];

  if (ArrayResize(new_array, capacity) != capacity)
    return (false);
  //--- any items in queue
  if (m_size > 0) {
    if (m_head < m_tail) {
      ArrayCopy(new_array, m_array, 0, m_head, m_size);
    } else {
      const int head_size = m_size - m_tail;
      //--- copy values from head part
      ArrayCopy(new_array, m_array, 0, m_head, head_size);
      //--- copy values from tail part
      ArrayCopy(new_array, m_array, head_size, 0, m_tail);
    }
  }
  //--- set temporary buffer as queue buffer
  ArraySwap(m_array, new_array);
  //--- set new tail and head
  m_head = 0;
  m_tail = m_size;
  return (true);
}
//+------------------------------------------------------------------+
//| Returns queue capacity                                           |
//+------------------------------------------------------------------+
template <typename T> int CQueue::Capacity(void) const {
  return (ArraySize(m_array) - m_size);
}
//+------------------------------------------------------------------+

#endif
