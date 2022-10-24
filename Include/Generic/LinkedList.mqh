#ifndef LINKED_LIST_H
#define LINKED_LIST_H

#include <Generic/Interfaces/ICollection.mqh>
#include <Generic/Internal/EqualFunction.mqh>

template <typename T> class CLinkedList;

template <typename T> class CLinkedListNode {
protected:
  CLinkedList<T> *m_list;
  CLinkedListNode<T> *m_next;
  CLinkedListNode<T> *m_prev;
  T m_item;

public:
  CLinkedListNode(T value);
  CLinkedListNode(CLinkedList<T> *list, T value);
  ~CLinkedListNode(void);

  CLinkedList<T> *List(void);
  void List(CLinkedList<T> *value);
  CLinkedListNode<T> *Next(void);
  void Next(CLinkedListNode<T> *value);
  CLinkedListNode<T> *Previous(void);
  void Previous(CLinkedListNode<T> *value);
  T Value(void);
  void Value(T value);
};

template <typename T> class CLinkedList : public ICollection<T> {
protected:
  CLinkedListNode<T> *m_head;
  int m_count;

public:
  CLinkedList(void);
  CLinkedList(ICollection<T> *collection);
  CLinkedList(T array[]);
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
  CLinkedListNode<T> *Head(void);
  CLinkedListNode<T> *First(void);
  CLinkedListNode<T> *Last(void);
  bool Contains(T item);

  int CopyTo(T dst_array[], const int dst_start = 0);

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

#endif
