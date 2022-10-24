#ifndef LINKED_LIST_H
#define LINKED_LIST_H

#include <Generic\Interfaces\ICollection.mqh>
#include <Generic\Internal\EqualFunction.mqh>

template <typename T> class CLinkedListNode {
protected:
  CLinkedList<T> *m_list;
  CLinkedListNode<T> *m_next;
  CLinkedListNode<T> *m_prev;
  T m_item;

public:
  CLinkedListNode(T value) : m_item(value) {}
  CLinkedListNode(CLinkedList<T> *list, T value)
      : m_list(list), m_item(value) {}
  ~CLinkedListNode(void) {}

  CLinkedList<T> *List(void) {
    return (m_list);
  }
  void List(CLinkedList<T> *value) {
    m_list = value;
  }
  CLinkedListNode<T> *Next(void) {
    return (m_next);
  }
  void Next(CLinkedListNode<T> *value) {
    m_next = value;
  }
  CLinkedListNode<T> *Previous(void) {
    return (m_prev);
  }
  void Previous(CLinkedListNode<T> *value) {
    m_prev = value;
  }
  T Value(void) {
    return (m_item);
  }
  void Value(T value) {
    m_item = value;
  }
};

template <typename T> class CLinkedList : public ICollection<T> {
protected:
  CLinkedListNode<T> *m_head;
  int m_count;

public:
  CLinkedList(void);
  CLinkedList(ICollection<T> *collection);
  CLinkedList(T &array[]);
  ~CLinkedList(void);

  bool Add(T value);
  CLinkedListNode<T> *AddAfter(CLinkedListNode<T> *node, T value);
  bool AddAfter(CLinkedListNode<T> *node, CLinkedListNode<T> *new_node);
  CLinkedListNode<T> *AddBefore(CLinkedListNode<T> *node, T value);
  bool AddBefore(CLinkedListNode<T> *node, CLinkedListNode<T> *new_node);
  CLinkedListNode<T> *AddFirst(T value);
  bool AddFirst(CLinkedListNode<T> *node);
  CLinkedListNode<T> *AddLast(T value);
  bool AddLast(CLinkedListNode<T> *node);

  int Count(void);
  CLinkedListNode<T> *Head(void) {
    return (m_head);
  }
  CLinkedListNode<T> *First(void);
  CLinkedListNode<T> *Last(void);
  bool Contains(T item);

  int CopyTo(T &dst_array[], const int dst_start = 0);

  void Clear(void);
  bool Remove(T item);
  bool Remove(CLinkedListNode<T> *node);
  bool RemoveFirst(void);
  bool RemoveLast(void);

  CLinkedListNode<T> *Find(T value);
  CLinkedListNode<T> *FindLast(T value);

private:
  bool ValidateNode(CLinkedListNode<T> *node);
  bool ValidateNewNode(CLinkedListNode<T> *node);
  void InternalInsertNodeBefore(CLinkedListNode<T> *node,
                                CLinkedListNode<T> *new_node);
  void InternalInsertNodeToEmptyList(CLinkedListNode<T> *new_node);
  void InternalRemoveNode(CLinkedListNode<T> *node);
};

template <typename T> CLinkedList::CLinkedList(void) : m_count(0) {}

template <typename T> CLinkedList::CLinkedList(T &array[]) : m_count(0) {
  for (int i = 0; i < ArraySize(array); i++)
    AddLast(array[i]);
}

template <typename T>
CLinkedList::CLinkedList(ICollection<T> *collection) : m_count(0) {

  if (CheckPointer(collection) != POINTER_INVALID) {
    T array[];
    int size = collection.CopyTo(array, 0);
    for (int i = 0; i < size; i++)
      AddLast(array[i]);
  }
}

template <typename T> CLinkedList::~CLinkedList(void) {
  Clear();
}

template <typename T> bool CLinkedList::Add(T value) {
  return (CheckPointer(AddLast(value)) != POINTER_INVALID);
}

template <typename T>
CLinkedListNode<T> *CLinkedList::AddAfter(CLinkedListNode<T> *node, T value) {

  if (!ValidateNode(node))
    return (NULL);

  CLinkedListNode<T> *result = new CLinkedListNode<T>(node.List(), value);

  InternalInsertNodeBefore(node.Next(), result);
  return (result);
}

template <typename T>
bool CLinkedList::AddAfter(CLinkedListNode<T> *node,
                           CLinkedListNode<T> *new_node) {

  if (!ValidateNode(node))
    return (false);

  if (!ValidateNewNode(new_node))
    return (false);

  InternalInsertNodeBefore(node.Next(), new_node);

  new_node.List(GetPointer(this));
  return (true);
}

template <typename T>
CLinkedListNode<T> *CLinkedList::AddBefore(CLinkedListNode<T> *node, T value) {

  if (!ValidateNode(node))
    return (NULL);

  CLinkedListNode<T> *result = new CLinkedListNode<T>(node.List(), value);

  InternalInsertNodeBefore(node, result);
  if (node == m_head)
    m_head = result;
  return (result);
}

template <typename T>
bool CLinkedList::AddBefore(CLinkedListNode<T> *node,
                            CLinkedListNode<T> *new_node) {

  if (!ValidateNode(node))
    return (false);

  if (!ValidateNewNode(new_node))
    return (false);

  InternalInsertNodeBefore(node, new_node);

  new_node.List(GetPointer(this));
  if (node == m_head)
    m_head = new_node;
  return (true);
}

template <typename T> CLinkedListNode<T> *CLinkedList::AddFirst(T value) {

  CLinkedListNode<T> *node = new CLinkedListNode<T>(GetPointer(this), value);

  if (CheckPointer(m_head) == POINTER_INVALID) {

    InternalInsertNodeToEmptyList(node);
  } else {

    InternalInsertNodeBefore(m_head, node);
    m_head = node;
  }
  return (node);
}

template <typename T> bool CLinkedList::AddFirst(CLinkedListNode<T> *node) {

  if (!ValidateNewNode(node))
    return (false);

  if (CheckPointer(m_head) == POINTER_INVALID) {

    InternalInsertNodeToEmptyList(node);
  } else {

    InternalInsertNodeBefore(m_head, node);
    m_head = node;
  }

  node.List(GetPointer(this));
  return (true);
}

template <typename T> CLinkedListNode<T> *CLinkedList::AddLast(T value) {

  CLinkedListNode<T> *node = new CLinkedListNode<T>(GetPointer(this), value);

  if (CheckPointer(m_head) == POINTER_INVALID) {

    InternalInsertNodeToEmptyList(node);
  } else {

    InternalInsertNodeBefore(m_head, node);
  }
  return (node);
}

template <typename T> bool CLinkedList::AddLast(CLinkedListNode<T> *node) {

  if (!ValidateNewNode(node))
    return (false);

  if (CheckPointer(m_head) == POINTER_INVALID) {

    InternalInsertNodeToEmptyList(node);
  } else {

    InternalInsertNodeBefore(m_head, node);
  }

  node.List(GetPointer(this));
  return (true);
}

template <typename T> int CLinkedList::Count(void) {
  return (m_count);
}

template <typename T> CLinkedListNode<T> *CLinkedList::First(void) {
  return (m_head);
}

template <typename T> CLinkedListNode<T> *CLinkedList::Last(void) {
  return (CheckPointer(m_head) != POINTER_INVALID ? m_head.Previous() : NULL);
}

template <typename T> bool CLinkedList::Contains(T item) {
  return (CheckPointer(Find(item)) != POINTER_INVALID);
}

template <typename T>
int CLinkedList::CopyTo(T &dst_array[], const int dst_start = 0) {

  if (dst_start + m_count > ArraySize(dst_array))
    ArrayResize(dst_array, dst_start + m_count);

  if (dst_start > ArraySize(dst_array))
    return (0);

  CLinkedListNode<T> *node = m_head;
  if (CheckPointer(node) != POINTER_INVALID) {
    int dst_index = dst_start;
    do {
      dst_array[dst_index++] = node.Value();
      node = node.Next();
    } while (dst_index < ArraySize(dst_array) && node != m_head);
    return (dst_index - dst_start);
  }

  return (0);
}

template <typename T> void CLinkedList::Clear(void) {

  if (m_count > 0) {

    if (CheckPointer(m_head) != POINTER_INVALID) {
      while (m_head.Next() != m_head) {
        CLinkedListNode<T> *node = m_head.Next();
        m_head.Next(node.Next());
        delete node;
      }
      delete m_head;
    }

    m_count = 0;
  }
}

template <typename T> bool CLinkedList::Remove(T item) {

  CLinkedListNode<T> *node = Find(item);
  if (CheckPointer(node) != POINTER_INVALID) {

    InternalRemoveNode(node);
    return (true);
  }
  return (false);
}

template <typename T> bool CLinkedList::Remove(CLinkedListNode<T> *node) {

  if (ValidateNode(node)) {

    InternalRemoveNode(node);
    return (true);
  }
  return (false);
}

template <typename T> bool CLinkedList::RemoveFirst(void) {

  if (CheckPointer(m_head) == POINTER_INVALID)
    return (false);

  InternalRemoveNode(m_head);
  return (true);
}

template <typename T> bool CLinkedList::RemoveLast(void) {

  if (CheckPointer(m_head) == POINTER_INVALID)
    return (false);

  InternalRemoveNode(m_head.Previous());
  return (true);
}

template <typename T> CLinkedListNode<T> *CLinkedList::Find(T value) {
  CLinkedListNode<T> *node = m_head;

  if (CheckPointer(node) != POINTER_INVALID) {
    do {

      if (::Equals(node.Value(), value))
        return (node);
      node = node.Next();
    } while (node != m_head);
  }
  return (NULL);
}

template <typename T> CLinkedListNode<T> *CLinkedList::FindLast(T value) {

  if (CheckPointer(m_head) == POINTER_INVALID)
    return (NULL);

  CLinkedListNode<T> *last = m_head.Previous();
  CLinkedListNode<T> *node = last;

  if (node != NULL) {
    do {

      if (::Equals(node.Value(), value))
        return (node);
      node = node.Previous();
    } while (node != last);
  }
  return (NULL);
}

template <typename T> bool CLinkedList::ValidateNode(CLinkedListNode<T> *node) {
  return (CheckPointer(node) != POINTER_INVALID &&
          node.List() == GetPointer(this));
}

template <typename T>
bool CLinkedList::ValidateNewNode(CLinkedListNode<T> *node) {
  return (CheckPointer(node) != POINTER_INVALID && node.List() == NULL);
}

template <typename T>
void CLinkedList::InternalInsertNodeBefore(CLinkedListNode<T> *node,
                                           CLinkedListNode<T> *new_node) {

  new_node.Next(node);
  new_node.Previous(node.Previous());
  node.Previous().Next(new_node);
  node.Previous(new_node);

  m_count++;
}

template <typename T>
void CLinkedList::InternalInsertNodeToEmptyList(CLinkedListNode<T> *new_node) {

  new_node.Next(new_node);
  new_node.Previous(new_node);
  m_head = new_node;

  m_count++;
}

template <typename T>
void CLinkedList::InternalRemoveNode(CLinkedListNode<T> *node) {

  if (node.Next() == node) {

    m_head = NULL;
  } else {

    node.Next().Previous(node.Previous());
    node.Previous().Next(node.Next());
    if (m_head == node)
      m_head = node.Next();
  }

  m_count--;
  delete node;
}

#endif
