#ifndef RED_BLACK_TREE_H
#define RED_BLACK_TREE_H

#include "Stack.mqh"
#include <Generic\Interfaces\ICollection.mqh>
#include <Generic\Interfaces\IComparer.mqh>
#include <Generic\Internal\ArrayFunction.mqh>
#include <Generic\Internal\DefaultComparer.mqh>

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

  T Value(void) {
    return (m_value);
  }
  void Value(T value) {
    m_value = value;
  }
  CRedBlackTreeNode<T> *Parent(void) {
    return (m_parent);
  }
  void Parent(CRedBlackTreeNode<T> *node) {
    m_parent = node;
  }
  CRedBlackTreeNode<T> *Left(void) {
    return (m_left);
  }
  void Left(CRedBlackTreeNode<T> *node) {
    m_left = node;
  }
  CRedBlackTreeNode<T> *Right(void) {
    return (m_right);
  }
  void Right(CRedBlackTreeNode<T> *node) {
    m_right = node;
  }
  ENUM_RED_BLACK_TREE_NODE_TYPE Color(void) {
    return (m_clr);
  }
  void Color(ENUM_RED_BLACK_TREE_NODE_TYPE clr) {
    m_clr = clr;
  }

  bool IsLeaf(void);

  static CRedBlackTreeNode<T> *CreateEmptyNode(void);
};

template <typename T>
CRedBlackTreeNode::CRedBlackTreeNode(void) : m_clr(RED_BLACK_TREE_NODE_RED) {
}

template <typename T> CRedBlackTreeNode::CRedBlackTreeNode(T value) {
  m_value = value;
  m_clr = RED_BLACK_TREE_NODE_RED;
  m_left = CreateEmptyNode();
  m_right = CreateEmptyNode();
}

template <typename T> CRedBlackTreeNode::~CRedBlackTreeNode(void) {
  if (CheckPointer(m_left) == POINTER_DYNAMIC)
    delete m_left;
  if (CheckPointer(m_right) == POINTER_DYNAMIC)
    delete m_right;
}

template <typename T> bool CRedBlackTreeNode::IsLeaf(void) {
  return (m_clr == RED_BLACK_TREE_NODE_BLACK &&
          CheckPointer(m_left) == POINTER_INVALID &&
          CheckPointer(m_right) == POINTER_INVALID);
}

template <typename T>
CRedBlackTreeNode<T> *CRedBlackTreeNode::CreateEmptyNode(void) {
  CRedBlackTreeNode<T> *new_node = new CRedBlackTreeNode<T>();
  new_node.m_clr = RED_BLACK_TREE_NODE_BLACK;
  new_node.m_parent = NULL;
  new_node.m_left = NULL;
  new_node.m_right = NULL;

  return (new_node);
}

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
  CRedBlackTree(T &array[]);
  CRedBlackTree(T &array[], IComparer<T> *comparer);
  ~CRedBlackTree(void);

  bool Add(T value);

  CRedBlackTreeNode<T> *Root(void) {
    return (m_root_node);
  }
  int Count(void) {
    return (m_count);
  }
  bool Contains(T item);
  IComparer<T> *Comparer(void) const {
    return (m_comparer);
  }
  bool TryGetMin(T &min);
  bool TryGetMax(T &max);

  int CopyTo(T &dst_array[], const int dst_start = 0);

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
  static void WalkNextLevel(CRedBlackTreeNode<T> *node, T &array[], int &index);
};

template <typename T> CRedBlackTree::CRedBlackTree(void) : m_count(0) {

  m_comparer = new CDefaultComparer<T>();
  m_delete_comparer = true;
}

template <typename T>
CRedBlackTree::CRedBlackTree(IComparer<T> *comparer) : m_count(0) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultComparer<T>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }
}

template <typename T>
CRedBlackTree::CRedBlackTree(ICollection<T> *collection) : m_count(0) {

  m_comparer = new CDefaultComparer<T>();
  m_delete_comparer = true;

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  T array[];
  int size = collection.CopyTo(array);

  for (int i = 0; i < size; i++)
    Add(array[i]);
}

template <typename T>
CRedBlackTree::CRedBlackTree(ICollection<T> *collection, IComparer<T> *comparer)
    : m_count(0) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultComparer<T>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }

  if (CheckPointer(collection) == POINTER_INVALID)
    return;

  T array[];
  int size = collection.CopyTo(array);

  for (int i = 0; i < size; i++)
    Add(array[i]);
}

template <typename T> CRedBlackTree::CRedBlackTree(T &array[]) : m_count(0) {

  m_comparer = new CDefaultComparer<T>();
  m_delete_comparer = true;

  for (int i = 0; i < ArraySize(array); i++)
    Add(array[i]);
}

template <typename T>
CRedBlackTree::CRedBlackTree(T &array[], IComparer<T> *comparer) : m_count(0) {

  if (CheckPointer(comparer) == POINTER_INVALID) {

    m_comparer = new CDefaultComparer<T>();
    m_delete_comparer = true;
  } else {

    m_comparer = comparer;
    m_delete_comparer = false;
  }

  for (int i = 0; i < ArraySize(array); i++)
    Add(array[i]);
}

template <typename T> CRedBlackTree::~CRedBlackTree(void) {

  if (m_delete_comparer)
    delete m_comparer;

  Clear();
}

template <typename T> bool CRedBlackTree::Add(T value) {

  if (CheckPointer(Find(value)) != POINTER_INVALID)
    return (false);

  CRedBlackTreeNode<T> *new_node = new CRedBlackTreeNode<T>(value);
  CRedBlackTreeNode<T> *work_node = m_root_node;
  while (CheckPointer(work_node) != POINTER_INVALID && !work_node.IsLeaf()) {

    new_node.Parent(work_node);
    int result = m_comparer.Compare(value, work_node.Value());
    if (result == 0) {

      return (false);
    }
    work_node = (result > 0 ? work_node.Right() : work_node.Left());
  }

  if (CheckPointer(new_node.Parent()) != POINTER_INVALID) {
    if (m_comparer.Compare(new_node.Value(), new_node.Parent().Value()) > 0) {
      if (CheckPointer(new_node.Parent().Right()) == POINTER_DYNAMIC &&
          new_node.Parent().Right().IsLeaf())
        delete new_node.Parent().Right();
      new_node.Parent().Right(new_node);
    } else {
      if (CheckPointer(new_node.Parent().Left()) == POINTER_DYNAMIC &&
          new_node.Parent().Left().IsLeaf())
        delete new_node.Parent().Left();
      new_node.Parent().Left(new_node);
    }
  } else {

    m_root_node = new_node;
  }

  BalanceTreeAfterInsert(new_node);
  m_last_node = new_node;

  m_count++;
  return (true);
}

template <typename T> bool CRedBlackTree::Contains(T item) {
  CRedBlackTreeNode<T> *tree_node = Find(item);
  return (CheckPointer(tree_node) != POINTER_INVALID);
}

template <typename T> bool CRedBlackTree::TryGetMin(T &min) {
  CRedBlackTreeNode<T> *work_node = m_root_node;

  if (CheckPointer(work_node) == POINTER_INVALID || work_node.IsLeaf())
    return (false);

  while (!work_node.Left().IsLeaf())
    work_node = work_node.Left();

  m_last_node = work_node;
  min = work_node.Value();
  return (true);
}

template <typename T> bool CRedBlackTree::TryGetMax(T &max) {
  CRedBlackTreeNode<T> *work_node = m_root_node;

  if (CheckPointer(work_node) == POINTER_INVALID || work_node.IsLeaf())
    return (false);

  while (!work_node.Right().IsLeaf())
    work_node = work_node.Right();

  m_last_node = work_node;
  max = work_node.Value();
  return (true);
}

template <typename T>
int CRedBlackTree::CopyTo(T &dst_array[], const int dst_start = 0) {

  if (CheckPointer(m_root_node) == POINTER_INVALID)
    return (0);

  if (dst_start + m_count > ArraySize(dst_array))
    ArrayResize(dst_array, dst_start + m_count);

  int index = dst_start;
  if (!m_root_node.IsLeaf()) {

    WalkNextLevel(m_root_node, dst_array, index);

    return (index - dst_start);
  } else {

    return (0);
  }
}

template <typename T> void CRedBlackTree::Clear(void) {

  if (m_count > 0) {

    if (CheckPointer(m_root_node) == POINTER_DYNAMIC)
      delete m_root_node;

    if (CheckPointer(m_last_node) == POINTER_DYNAMIC)
      delete m_last_node;
    m_count = 0;
  }
}

template <typename T> bool CRedBlackTree::Remove(T value) {

  CRedBlackTreeNode<T> *delete_node = Find(value);
  if (CheckPointer(delete_node) != POINTER_INVALID)
    return Remove(delete_node);
  return (false);
}

template <typename T>
bool CRedBlackTree::Remove(CRedBlackTreeNode<T> *delete_node) {

  if (CheckPointer(delete_node) == POINTER_INVALID)
    return (false);

  bool contains = false;

  CRedBlackTreeNode<T> *tree_node = m_root_node;
  while (CheckPointer(tree_node) != POINTER_INVALID && !tree_node.IsLeaf()) {

    if (tree_node == delete_node) {
      contains = true;
      break;
    } else {

      int result = m_comparer.Compare(delete_node.Value(), tree_node.Value());
      if (result > 0)
        tree_node = tree_node.Right();
      else if (result < 0)
        tree_node = tree_node.Left();
      else
        break;
    }
  }

  if (!contains)
    return (false);

  CRedBlackTreeNode<T> *work_node;

  if (delete_node.Left().IsLeaf() || delete_node.Right().IsLeaf()) {
    work_node = delete_node;
  } else {

    work_node = delete_node.Right();

    while (!work_node.Left().IsLeaf())
      work_node = work_node.Left();
  }

  CRedBlackTreeNode<T> *linked_node =
      (work_node.Left().IsLeaf() ? work_node.Right() : work_node.Left());

  linked_node.Parent(work_node.Parent());
  if (CheckPointer(work_node.Parent()) != POINTER_INVALID) {
    if (work_node == work_node.Parent().Left())
      work_node.Parent().Left(linked_node);
    else
      work_node.Parent().Right(linked_node);
  } else {

    m_root_node = linked_node;
  }

  if (work_node != delete_node)
    delete_node.Value(work_node.Value());

  if (work_node.Color() == RED_BLACK_TREE_NODE_BLACK)
    BalanceTreeAfterDelete(linked_node);

  if (m_count > 1) {
    if (linked_node == work_node.Left())
      work_node.Left(NULL);
    else
      work_node.Right(NULL);
  }
  delete work_node;

  m_count--;
  return (true);
}

template <typename T> bool CRedBlackTree::RemoveMin(void) {

  if (CheckPointer(m_root_node) == POINTER_INVALID)
    return (false);

  return Remove(FindMin());
}

template <typename T> bool CRedBlackTree::RemoveMax(void) {

  if (CheckPointer(m_root_node) == POINTER_INVALID)
    return (false);

  return Remove(FindMax());
}

template <typename T> CRedBlackTreeNode<T> *CRedBlackTree::Find(T value) {
  int result;

  if (CheckPointer(m_last_node) != POINTER_INVALID && !m_last_node.IsLeaf()) {
    result = m_comparer.Compare(value, m_last_node.Value());
    if (result == 0)
      return (m_last_node);
  }

  CRedBlackTreeNode<T> *tree_node = m_root_node;

  while (CheckPointer(tree_node) != POINTER_INVALID && !tree_node.IsLeaf()) {
    result = m_comparer.Compare(value, tree_node.Value());
    if (result == 0) {
      m_last_node = tree_node;
      return (tree_node);
    }
    tree_node = (result < 0 ? tree_node.Left() : tree_node.Right());
  }
  return (NULL);
}

template <typename T> CRedBlackTreeNode<T> *CRedBlackTree::FindMin(void) {
  CRedBlackTreeNode<T> *work_node = m_root_node;

  if (CheckPointer(work_node) == POINTER_INVALID || work_node.IsLeaf())
    return (NULL);

  while (!work_node.Left().IsLeaf())
    work_node = work_node.Left();

  m_last_node = work_node;
  return (work_node);
}

template <typename T> CRedBlackTreeNode<T> *CRedBlackTree::FindMax(void) {
  CRedBlackTreeNode<T> *work_node = m_root_node;

  if (CheckPointer(work_node) == POINTER_INVALID || work_node.IsLeaf())
    return (NULL);

  while (!work_node.Right().IsLeaf())
    work_node = work_node.Right();

  m_last_node = work_node;
  return (work_node);
}

template <typename T>
void CRedBlackTree::RotateRight(CRedBlackTreeNode<T> *rotate_node) {

  CRedBlackTreeNode<T> *work_node = rotate_node.Left();

  rotate_node.Left(work_node.Right());

  if (!work_node.Right().IsLeaf()) {

    work_node.Right().Parent(rotate_node);
  }
  if (!work_node.IsLeaf()) {

    work_node.Parent(rotate_node.Parent());
  }
  if (CheckPointer(rotate_node.Parent()) != POINTER_INVALID) {

    if (rotate_node == rotate_node.Parent().Right()) {

      rotate_node.Parent().Right(work_node);
    } else {

      rotate_node.Parent().Left(work_node);
    }
  } else {
    m_root_node = work_node;
  }

  work_node.Right(rotate_node);

  if (!rotate_node.IsLeaf())
    rotate_node.Parent(work_node);
}

template <typename T>
void CRedBlackTree::RotateLeft(CRedBlackTreeNode<T> *rotate_node) {

  CRedBlackTreeNode<T> *work_node = rotate_node.Right();

  rotate_node.Right(work_node.Left());

  if (!work_node.Left().IsLeaf()) {

    work_node.Left().Parent(rotate_node);
  }
  if (!work_node.IsLeaf()) {

    work_node.Parent(rotate_node.Parent());
  }
  if (CheckPointer(rotate_node.Parent()) != POINTER_INVALID) {

    if (rotate_node == rotate_node.Parent().Left()) {

      rotate_node.Parent().Left(work_node);
    } else {

      rotate_node.Parent().Right(work_node);
    }
  } else {
    m_root_node = work_node;
  }

  work_node.Left(rotate_node);

  if (!rotate_node.IsLeaf())
    rotate_node.Parent(work_node);
}

template <typename T>
void CRedBlackTree::BalanceTreeAfterInsert(CRedBlackTreeNode<T> *insert_node) {

  while (insert_node != m_root_node &&
         insert_node.Parent().Color() == RED_BLACK_TREE_NODE_RED) {

    CRedBlackTreeNode<T> *work_node;

    if (insert_node.Parent() == insert_node.Parent().Parent().Left()) {

      work_node = insert_node.Parent().Parent().Right();
      if (CheckPointer(work_node) != POINTER_INVALID &&
          work_node.Color() == RED_BLACK_TREE_NODE_RED) {

        insert_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        work_node.Color(RED_BLACK_TREE_NODE_BLACK);

        insert_node.Parent().Parent().Color(RED_BLACK_TREE_NODE_RED);

        insert_node = insert_node.Parent().Parent();
      } else {

        if (insert_node == insert_node.Parent().Right()) {

          insert_node = insert_node.Parent();
          RotateLeft(insert_node);
        }

        insert_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        insert_node.Parent().Parent().Color(RED_BLACK_TREE_NODE_RED);
        RotateRight(insert_node.Parent().Parent());
      }
    } else {

      work_node = insert_node.Parent().Parent().Left();
      if (CheckPointer(work_node) != POINTER_INVALID &&
          work_node.Color() == RED_BLACK_TREE_NODE_RED) {

        insert_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        work_node.Color(RED_BLACK_TREE_NODE_BLACK);

        insert_node.Parent().Parent().Color(RED_BLACK_TREE_NODE_RED);

        insert_node = insert_node.Parent().Parent();
      } else {

        if (insert_node == insert_node.Parent().Left()) {

          insert_node = insert_node.Parent();
          RotateRight(insert_node);
        }

        insert_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        insert_node.Parent().Parent().Color(RED_BLACK_TREE_NODE_RED);
        RotateLeft(insert_node.Parent().Parent());
      }
    }
  }

  m_root_node.Color(RED_BLACK_TREE_NODE_BLACK);
}

template <typename T>
void CRedBlackTree::BalanceTreeAfterDelete(CRedBlackTreeNode<T> *linked_node) {

  while (linked_node != m_root_node &&
         linked_node.Color() == RED_BLACK_TREE_NODE_BLACK) {
    CRedBlackTreeNode<T> *work_node;

    if (linked_node == linked_node.Parent().Left()) {

      work_node = linked_node.Parent().Right();
      if (work_node.Color() == RED_BLACK_TREE_NODE_RED) {

        linked_node.Parent().Color(RED_BLACK_TREE_NODE_RED);
        work_node.Color(RED_BLACK_TREE_NODE_BLACK);
        RotateLeft(linked_node.Parent());
        work_node = linked_node.Parent().Right();
      }

      if (work_node.IsLeaf())
        return;
      if (work_node.Left().Color() == RED_BLACK_TREE_NODE_BLACK &&
          work_node.Right().Color() == RED_BLACK_TREE_NODE_BLACK) {

        work_node.Color(RED_BLACK_TREE_NODE_RED);

        linked_node = linked_node.Parent();
      } else {
        if (work_node.Right().Color() == RED_BLACK_TREE_NODE_BLACK) {
          work_node.Left().Color(RED_BLACK_TREE_NODE_BLACK);
          work_node.Color(RED_BLACK_TREE_NODE_RED);
          RotateRight(work_node);
          work_node = linked_node.Parent().Right();
        }
        linked_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        work_node.Color(linked_node.Parent().Color());
        work_node.Right().Color(RED_BLACK_TREE_NODE_BLACK);
        RotateLeft(linked_node.Parent());
        linked_node = m_root_node;
      }
    } else {

      work_node = linked_node.Parent().Left();
      if (work_node.Color() == RED_BLACK_TREE_NODE_RED) {

        linked_node.Parent().Color(RED_BLACK_TREE_NODE_RED);
        work_node.Color(RED_BLACK_TREE_NODE_BLACK);
        RotateRight(linked_node.Parent());
        work_node = linked_node.Parent().Left();
      }

      if (work_node.IsLeaf())
        return;
      if (work_node.Right().Color() == RED_BLACK_TREE_NODE_BLACK &&
          work_node.Left().Color() == RED_BLACK_TREE_NODE_BLACK) {

        work_node.Color(RED_BLACK_TREE_NODE_RED);

        linked_node = linked_node.Parent();
      } else {
        if (work_node.Left().Color() == RED_BLACK_TREE_NODE_BLACK) {
          work_node.Right().Color(RED_BLACK_TREE_NODE_BLACK);
          work_node.Color(RED_BLACK_TREE_NODE_RED);
          RotateLeft(work_node);
          work_node = linked_node.Parent().Left();
        }
        work_node.Color(linked_node.Parent().Color());
        linked_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        work_node.Left().Color(RED_BLACK_TREE_NODE_BLACK);
        RotateRight(linked_node.Parent());
        linked_node = m_root_node;
      }
    }
  }
  linked_node.Color(RED_BLACK_TREE_NODE_BLACK);
}

template <typename T>
void CRedBlackTree::WalkNextLevel(CRedBlackTreeNode<T> *node, T &array[],
                                  int &index) {

  if (!node.Left().IsLeaf())
    WalkNextLevel(node.Left(), array, index);

  if (index >= ArraySize(array))
    return;

  array[index++] = node.Value();

  if (!node.Right().IsLeaf())
    WalkNextLevel(node.Right(), array, index);
}

#endif
