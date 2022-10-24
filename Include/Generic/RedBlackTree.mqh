#ifndef RED_BLACK_TREE_H
#define RED_BLACK_TREE_H

#include "Stack.mqh"
#include <Generic/Interfaces/ICollection.mqh>
#include <Generic/Interfaces/IComparer.mqh>
#include <Generic/Internal/ArrayFunction.mqh>
#include <Generic/Internal/DefaultComparer.mqh>

enum ENUM_RED_BLACK_TREE_NODE_TYPE {
  RED_BLACK_TREE_NODE_RED = 0,
  RED_BLACK_TREE_NODE_BLACK = 1
};

template <typename T> class CRedBlackTreeNode {
private:
  T m_value;
  CRedBlackTreeNode<T> *m_left;
  CRedBlackTreeNode<T> *m_right;
  CRedBlackTreeNode<T> *m_parent;
  ENUM_RED_BLACK_TREE_NODE_TYPE m_clr;

public:
  CRedBlackTreeNode(void);
  CRedBlackTreeNode(T value);
  ~CRedBlackTreeNode(void);

  T Value(void);
  void Value(T value);
  CRedBlackTreeNode<T> *Parent(void);
  void Parent(CRedBlackTreeNode<T> *node);
  CRedBlackTreeNode<T> *Left(void);
  void Left(CRedBlackTreeNode<T> *node);
  CRedBlackTreeNode<T> *Right(void);
  void Right(CRedBlackTreeNode<T> *node);
  ENUM_RED_BLACK_TREE_NODE_TYPE Color(void);
  void Color(ENUM_RED_BLACK_TREE_NODE_TYPE clr);

  bool IsLeaf(void);

  static CRedBlackTreeNode<T> *CreateEmptyNode(void);
};

template <typename T> class CRedBlackTree : public ICollection<T> {
protected:
  CRedBlackTreeNode<T> *m_root_node;
  CRedBlackTreeNode<T> *m_last_node;
  IComparer<T> *m_comparer;
  int m_count;
  bool m_delete_comparer;

public:
  CRedBlackTree(void);
  CRedBlackTree(IComparer<T> *comparer);
  CRedBlackTree(ICollection<T> *collection);
  CRedBlackTree(ICollection<T> *collection, IComparer<T> *comparer);
  CRedBlackTree(T array[]);
  CRedBlackTree(T array[], IComparer<T> *comparer);
  ~CRedBlackTree(void);

  bool Add(T value);

  CRedBlackTreeNode<T> *Root(void);
  int Count(void);
  bool Contains(T item);
  IComparer<T> *Comparer(void) const;
  bool TryGetMin(T &min);
  bool TryGetMax(T &max);

  int CopyTo(T dst_array[], const int dst_start = 0);

  void Clear(void);
  bool Remove(T value);
  bool Remove(CRedBlackTreeNode<T> *node);
  bool RemoveMin(void);
  bool RemoveMax(void);

  CRedBlackTreeNode<T> *Find(T value);
  CRedBlackTreeNode<T> *FindMax(void);
  CRedBlackTreeNode<T> *FindMin(void);

private:
  void RotateRight(CRedBlackTreeNode<T> *rotate_node);
  void RotateLeft(CRedBlackTreeNode<T> *rotate_node);
  void BalanceTreeAfterInsert(CRedBlackTreeNode<T> *insert_node);
  void BalanceTreeAfterDelete(CRedBlackTreeNode<T> *linked_node);
  static void WalkNextLevel(CRedBlackTreeNode<T> *node, T array[], int &index);
};

#endif
