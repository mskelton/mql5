#ifndef RED_BLACK_TREE_H
#define RED_BLACK_TREE_H
//|                   Copyright 2016-2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "Stack.mqh"
#include <Generic\Interfaces\ICollection.mqh>
#include <Generic\Interfaces\IComparer.mqh>
#include <Generic\Internal\ArrayFunction.mqh>
#include <Generic\Internal\DefaultComparer.mqh>
//+------------------------------------------------------------------+
//| Enum ENUM_RED_BLACK_TREE_NODE_TYPE.                              |
//| Usage: Defines possible node colors for red black tree.          |
//+------------------------------------------------------------------+
enum ENUM_RED_BLACK_TREE_NODE_TYPE {
  RED_BLACK_TREE_NODE_RED = 0,
  RED_BLACK_TREE_NODE_BLACK = 1
};
//+------------------------------------------------------------------+
//| Class CRedBlackTreeNode<T>.                                      |
//| Usage: Represents a node of red black tree.                      |
//+------------------------------------------------------------------+
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

  //--- methods of access to protected data
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
  //--- check node is empty
  bool IsLeaf(void);
  //--- create new empty node
  static CRedBlackTreeNode<T> *CreateEmptyNode(void);
};
//+------------------------------------------------------------------+
//| Initializes a new instance of the CRedBlackTreeNode<T> class that|
//| is empty.                                                        |
//+------------------------------------------------------------------+
template <typename T>
CRedBlackTreeNode::CRedBlackTreeNode(void) : m_clr(RED_BLACK_TREE_NODE_RED) {
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CRedBlackTreeNode<T> class with|
//| specified value.                                                 |
//+------------------------------------------------------------------+
template <typename T> CRedBlackTreeNode::CRedBlackTreeNode(T value) {
  m_value = value;
  m_clr = RED_BLACK_TREE_NODE_RED;
  m_left = CreateEmptyNode();
  m_right = CreateEmptyNode();
}
//+------------------------------------------------------------------+
//| Destructor.                                                      |
//+------------------------------------------------------------------+
template <typename T> CRedBlackTreeNode::~CRedBlackTreeNode(void) {
  if (CheckPointer(m_left) == POINTER_DYNAMIC)
    delete m_left;
  if (CheckPointer(m_right) == POINTER_DYNAMIC)
    delete m_right;
}
//+------------------------------------------------------------------+
//| Check node is empty.                                             |
//+------------------------------------------------------------------+
template <typename T> bool CRedBlackTreeNode::IsLeaf(void) {
  return (m_clr == RED_BLACK_TREE_NODE_BLACK &&
          CheckPointer(m_left) == POINTER_INVALID &&
          CheckPointer(m_right) == POINTER_INVALID);
}
//+------------------------------------------------------------------+
//| Create new empty black node.                                     |
//+------------------------------------------------------------------+
template <typename T>
CRedBlackTreeNode<T> *CRedBlackTreeNode::CreateEmptyNode(void) {
  CRedBlackTreeNode<T> *new_node = new CRedBlackTreeNode<T>();
  new_node.m_clr = RED_BLACK_TREE_NODE_BLACK;
  new_node.m_parent = NULL;
  new_node.m_left = NULL;
  new_node.m_right = NULL;
  //--- return new empty node
  return (new_node);
}
//+------------------------------------------------------------------+
//| Class CRedBlackTree<T>.                                          |
//| Usage: A redâblack tree is a data structure which is a type of   |
//|        self-balancing binary search tree.                        |
//+------------------------------------------------------------------+
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
  //--- methods of filling data
  bool Add(T value);
  //--- methods of access to protected data
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
  //--- methods of copy data from collection
  int CopyTo(T &dst_array[], const int dst_start = 0);
  //--- methods of cleaning and removing
  void Clear(void);
  bool Remove(T value);
  bool Remove(CRedBlackTreeNode<T> *node);
  bool RemoveMin(void);
  bool RemoveMax(void);
  //--- method for searching
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
//+------------------------------------------------------------------+
//| Initializes a new instance of the CRedBlackTree<T> class that is |
//| empty and uses the specified comparer.                           |
//+------------------------------------------------------------------+
template <typename T> CRedBlackTree::CRedBlackTree(void) : m_count(0) {
  //--- use default comaprer
  m_comparer = new CDefaultComparer<T>();
  m_delete_comparer = true;
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CRedBlackTree<T> class that is |
//| empty and uses the specified comparer.                           |
//+------------------------------------------------------------------+
template <typename T>
CRedBlackTree::CRedBlackTree(IComparer<T> *comparer) : m_count(0) {
  //--- check comaprer
  if (CheckPointer(comparer) == POINTER_INVALID) {
    //--- use default comaprer
    m_comparer = new CDefaultComparer<T>();
    m_delete_comparer = true;
  } else {
    //--- use specified equality comaprer
    m_comparer = comparer;
    m_delete_comparer = false;
  }
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CRedBlackTree<T> class that    |
//| uses the default equality comparer, contains elements copied from|
//| the specified collection.                                        |
//+------------------------------------------------------------------+
template <typename T>
CRedBlackTree::CRedBlackTree(ICollection<T> *collection) : m_count(0) {
  //--- use default comaprer
  m_comparer = new CDefaultComparer<T>();
  m_delete_comparer = true;
  //--- check collection
  if (CheckPointer(collection) == POINTER_INVALID)
    return;
  //--- copy all elements from specified collection to array
  T array[];
  int size = collection.CopyTo(array);
  //--- fill red black tree by elements from the array
  for (int i = 0; i < size; i++)
    Add(array[i]);
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CRedBlackTree<T> class that    |
//| uses the specified comparer and contains elements  copied from   |
//| the specified collection.                                        |
//+------------------------------------------------------------------+
template <typename T>
CRedBlackTree::CRedBlackTree(ICollection<T> *collection, IComparer<T> *comparer)
    : m_count(0) {
  //--- check comaprer
  if (CheckPointer(comparer) == POINTER_INVALID) {
    //--- use default comaprer
    m_comparer = new CDefaultComparer<T>();
    m_delete_comparer = true;
  } else {
    //--- use specified equality comaprer
    m_comparer = comparer;
    m_delete_comparer = false;
  }
  //--- check collection
  if (CheckPointer(collection) == POINTER_INVALID)
    return;
  //--- copy all elements from specified collection to array
  T array[];
  int size = collection.CopyTo(array);
  //--- fill red black tree by elements from the array
  for (int i = 0; i < size; i++)
    Add(array[i]);
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CRedBlackTree<T> class that    |
//| uses the default equality comparer and contains elements copied  |
//| from the specified array.                                        |
//+------------------------------------------------------------------+
template <typename T> CRedBlackTree::CRedBlackTree(T &array[]) : m_count(0) {
  //--- use default comaprer
  m_comparer = new CDefaultComparer<T>();
  m_delete_comparer = true;
  //--- fill red black tree by elements from the specified array
  for (int i = 0; i < ArraySize(array); i++)
    Add(array[i]);
}
//+------------------------------------------------------------------+
//| Initializes a new instance of the CRedBlackTree<T> class that    |
//| uses the specified comparer and contains elements  copied from   |
//| the specified array.                                             |
//+------------------------------------------------------------------+
template <typename T>
CRedBlackTree::CRedBlackTree(T &array[], IComparer<T> *comparer) : m_count(0) {
  //--- check comaprer
  if (CheckPointer(comparer) == POINTER_INVALID) {
    //--- use default comaprer
    m_comparer = new CDefaultComparer<T>();
    m_delete_comparer = true;
  } else {
    //--- use specified equality comaprer
    m_comparer = comparer;
    m_delete_comparer = false;
  }
  //--- fill red black tree by elements from the specified array
  for (int i = 0; i < ArraySize(array); i++)
    Add(array[i]);
}
//+------------------------------------------------------------------+
//| Destructor.                                                      |
//+------------------------------------------------------------------+
template <typename T> CRedBlackTree::~CRedBlackTree(void) {
  //--- delete comparer
  if (m_delete_comparer)
    delete m_comparer;
  //--- clear tree
  Clear();
}
//+------------------------------------------------------------------+
//| Adds a new item to the tree. If the element already belongs to   |
//| this tree, no new element will be added.                         |
//+------------------------------------------------------------------+
template <typename T> bool CRedBlackTree::Add(T value) {
  //--- traverse tree - find node below
  if (CheckPointer(Find(value)) != POINTER_INVALID)
    return (false);
  //--- create new node
  CRedBlackTreeNode<T> *new_node = new CRedBlackTreeNode<T>(value);
  CRedBlackTreeNode<T> *work_node = m_root_node;
  while (CheckPointer(work_node) != POINTER_INVALID && !work_node.IsLeaf()) {
    //--- find parent
    new_node.Parent(work_node);
    int result = m_comparer.Compare(value, work_node.Value());
    if (result == 0) {
      //--- node with same value already exists
      return (false);
    }
    work_node = (result > 0 ? work_node.Right() : work_node.Left());
  }
  //--- insert node into tree starting at parent's location
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
    //--- first node added
    m_root_node = new_node;
  }
  //--- restore red-black properties
  BalanceTreeAfterInsert(new_node);
  m_last_node = new_node;
  //--- increment count
  m_count++;
  return (true);
}
//+------------------------------------------------------------------+
//| Determines whether this tree contains the specified item.        |
//+------------------------------------------------------------------+
template <typename T> bool CRedBlackTree::Contains(T item) {
  CRedBlackTreeNode<T> *tree_node = Find(item);
  return (CheckPointer(tree_node) != POINTER_INVALID);
}
//+------------------------------------------------------------------+
//| Finds the minimum element stored in the tree.                    |
//+------------------------------------------------------------------+
template <typename T> bool CRedBlackTree::TryGetMin(T &min) {
  CRedBlackTreeNode<T> *work_node = m_root_node;
  //--- check tree is empty
  if (CheckPointer(work_node) == POINTER_INVALID || work_node.IsLeaf())
    return (false);
  //--- traverse to the extreme left to find the smallest key
  while (!work_node.Left().IsLeaf())
    work_node = work_node.Left();
  //--- store min value
  m_last_node = work_node;
  min = work_node.Value();
  return (true);
}
//+------------------------------------------------------------------+
//| Finds the maximum element stored in the tree.                    |
//+------------------------------------------------------------------+
template <typename T> bool CRedBlackTree::TryGetMax(T &max) {
  CRedBlackTreeNode<T> *work_node = m_root_node;
  //--- check tree is empty
  if (CheckPointer(work_node) == POINTER_INVALID || work_node.IsLeaf())
    return (false);
  //--- traverse to the extreme right to find the largest key
  while (!work_node.Right().IsLeaf())
    work_node = work_node.Right();
  //--- store max value
  m_last_node = work_node;
  max = work_node.Value();
  return (true);
}
//+------------------------------------------------------------------+
//| Copies a range of elements from the tree to a compatible         |
//| one-dimensional array.                                           |
//+------------------------------------------------------------------+
template <typename T>
int CRedBlackTree::CopyTo(T &dst_array[], const int dst_start = 0) {
  //--- check root node
  if (CheckPointer(m_root_node) == POINTER_INVALID)
    return (0);
  //--- resize array
  if (dst_start + m_count > ArraySize(dst_array))
    ArrayResize(dst_array, dst_start + m_count);
  //--- start copy
  int index = dst_start;
  if (!m_root_node.IsLeaf()) {
    //--- store all values in the stack
    WalkNextLevel(m_root_node, dst_array, index);
    //--- copy values from stack to array
    return (index - dst_start);
  } else {
    //--- tree is empty
    return (0);
  }
}
//+------------------------------------------------------------------+
//| Removes all nodes from the tree.                                 |
//+------------------------------------------------------------------+
template <typename T> void CRedBlackTree::Clear(void) {
  //--- check count
  if (m_count > 0) {
    //--- delete root node
    if (CheckPointer(m_root_node) == POINTER_DYNAMIC)
      delete m_root_node;
    //--- delete last node
    if (CheckPointer(m_last_node) == POINTER_DYNAMIC)
      delete m_last_node;
    m_count = 0;
  }
}
//+------------------------------------------------------------------+
//| Removes a node with specified value from the tree.               |
//+------------------------------------------------------------------+
template <typename T> bool CRedBlackTree::Remove(T value) {
  //--- try to find node with specified value
  CRedBlackTreeNode<T> *delete_node = Find(value);
  if (CheckPointer(delete_node) != POINTER_INVALID)
    return Remove(delete_node);
  return (false);
}
//+------------------------------------------------------------------+
//| Removes a node from the tree.                                    |
//| A node to be deleted will be:                                    |
//| 1. a leaf with no children                                       |
//| 2. have one child                                                |
//| 3. have two children                                             |
//| If the deleted node is red, the red black properties still hold. |
//| If the deleted node is black, the tree needs rebalancing.        |
//+------------------------------------------------------------------+
template <typename T>
bool CRedBlackTree::Remove(CRedBlackTreeNode<T> *delete_node) {
  //--- check node
  if (CheckPointer(delete_node) == POINTER_INVALID)
    return (false);
  //--- check delete node conatins in tree
  bool contains = false;
  //--- walk of a tree and try to find the delete node
  CRedBlackTreeNode<T> *tree_node = m_root_node;
  while (CheckPointer(tree_node) != POINTER_INVALID && !tree_node.IsLeaf()) {
    //--- check specified node is delete node
    if (tree_node == delete_node) {
      contains = true;
      break;
    } else {
      //--- determine qual between specified node and delete node
      int result = m_comparer.Compare(delete_node.Value(), tree_node.Value());
      if (result > 0)
        tree_node = tree_node.Right(); // walk of a right tree
      else if (result < 0)
        tree_node = tree_node.Left(); // walk of a left tree
      else
        break; // values of nodes are equal, but delete node does not belong to
               // this tree
    }
  }
  //--- check delete node not belong to this tree
  if (!contains)
    return (false);
  //--- work node
  CRedBlackTreeNode<T> *work_node;
  //--- find the replacement node - the node one with at *most* one child.
  if (delete_node.Left().IsLeaf() || delete_node.Right().IsLeaf()) {
    work_node = delete_node;
  } else {
    //--- traverse right subtree
    work_node = delete_node.Right();
    //--- to find next node in sequence
    while (!work_node.Left().IsLeaf())
      work_node = work_node.Left();
  }
  //--- at this point, work_node contains the replacement node. it's content
  //will be copied to the valules in the node to be deleted
  //--- linked_node is the node that will be linked to work_node's old parent.
  CRedBlackTreeNode<T> *linked_node =
      (work_node.Left().IsLeaf() ? work_node.Right() : work_node.Left());
  //--- replace linked_node's parent with work_node's parent and
  //--- link linked_node to proper subtree in parent
  //--- this removes work_node from the chain
  linked_node.Parent(work_node.Parent());
  if (CheckPointer(work_node.Parent()) != POINTER_INVALID) {
    if (work_node == work_node.Parent().Left())
      work_node.Parent().Left(linked_node);
    else
      work_node.Parent().Right(linked_node);
  } else {
    //--- make linked_node the root node
    m_root_node = linked_node;
  }
  //--- copy the values from work_node (the replacement node) to the node being
  //deleted.
  if (work_node != delete_node)
    delete_node.Value(work_node.Value());
  //--- restore red-black properties
  if (work_node.Color() == RED_BLACK_TREE_NODE_BLACK)
    BalanceTreeAfterDelete(linked_node);
  //--- delete node
  if (m_count > 1) {
    if (linked_node == work_node.Left())
      work_node.Left(NULL);
    else
      work_node.Right(NULL);
  }
  delete work_node;
  //--- decrement count
  m_count--;
  return (true);
}
//+------------------------------------------------------------------+
//| Removes a node with minimum value from the tree.                 |
//+------------------------------------------------------------------+
template <typename T> bool CRedBlackTree::RemoveMin(void) {
  //--- check root node
  if (CheckPointer(m_root_node) == POINTER_INVALID)
    return (false);
  //--- find and remove node with minimum value
  return Remove(FindMin());
}
//+------------------------------------------------------------------+
//| Removes a node with maximum value from the tree.                 |
//+------------------------------------------------------------------+
template <typename T> bool CRedBlackTree::RemoveMax(void) {
  //--- check root node
  if (CheckPointer(m_root_node) == POINTER_INVALID)
    return (false);
  //--- find and remove node with maximum value
  return Remove(FindMax());
}
//+------------------------------------------------------------------+
//| Attempts to find a node that contains the specified value.       |
//+------------------------------------------------------------------+
template <typename T> CRedBlackTreeNode<T> *CRedBlackTree::Find(T value) {
  int result;
  //--- check last node
  if (CheckPointer(m_last_node) != POINTER_INVALID && !m_last_node.IsLeaf()) {
    result = m_comparer.Compare(value, m_last_node.Value());
    if (result == 0)
      return (m_last_node);
  }
  //--- begin at root
  CRedBlackTreeNode<T> *tree_node = m_root_node;
  //--- traverse tree until node is found
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
//+------------------------------------------------------------------+
//| Attempts to find a node that contains the minimum value.         |
//+------------------------------------------------------------------+
template <typename T> CRedBlackTreeNode<T> *CRedBlackTree::FindMin(void) {
  CRedBlackTreeNode<T> *work_node = m_root_node;
  //--- check tree is empty
  if (CheckPointer(work_node) == POINTER_INVALID || work_node.IsLeaf())
    return (NULL);
  //--- traverse to the extreme left to find the smallest key
  while (!work_node.Left().IsLeaf())
    work_node = work_node.Left();
  //--- store min value
  m_last_node = work_node;
  return (work_node);
}
//+------------------------------------------------------------------+
//| Attempts to find a node that contains the maximum value.         |
//+------------------------------------------------------------------+
template <typename T> CRedBlackTreeNode<T> *CRedBlackTree::FindMax(void) {
  CRedBlackTreeNode<T> *work_node = m_root_node;
  //--- check tree is empty
  if (CheckPointer(work_node) == POINTER_INVALID || work_node.IsLeaf())
    return (NULL);
  //--- traverse to the extreme right to find the largest key
  while (!work_node.Right().IsLeaf())
    work_node = work_node.Right();
  //--- store max value
  m_last_node = work_node;
  return (work_node);
}
//+------------------------------------------------------------------+
//| Pushing node rotate_node down and to the right to balance the    |
//| tree. rotate_node's Left child (work_node) replaces rotate_node  |
//| (since rotate_node < work_node), and work_node's Right child     |
//| becomes rotate_node's Left child (since it's < rotate_node but > |
//| work_node).                                                      |
//+------------------------------------------------------------------+
template <typename T>
void CRedBlackTree::RotateRight(CRedBlackTreeNode<T> *rotate_node) {
  //--- get rotate_node's Left node, this becomes work_node
  CRedBlackTreeNode<T> *work_node = rotate_node.Left();
  //--- set rotate_node's Right link
  //--- work_node's Right child becomes rotate_node's Left child
  rotate_node.Left(work_node.Right());
  //--- modify parents
  if (!work_node.Right().IsLeaf()) {
    //--- sets work_node's Right Parent to rotate_node
    work_node.Right().Parent(rotate_node);
  }
  if (!work_node.IsLeaf()) {
    //--- set work_node's Parent to rotate_node's Parent
    work_node.Parent(rotate_node.Parent());
  }
  if (CheckPointer(rotate_node.Parent()) != POINTER_INVALID) {
    //--- determine which side of it's Parent rotate_node was on
    if (rotate_node == rotate_node.Parent().Right()) {
      //--- set Right Parent to work_node
      rotate_node.Parent().Right(work_node);
    } else {
      //--- set Left Parent to work_node
      rotate_node.Parent().Left(work_node);
    }
  } else {
    m_root_node = work_node;
  }
  //--- link rotate_node and work_node
  //--- put rotate_node on work_node's Right
  work_node.Right(rotate_node);
  //--- set work_node as rotate_node's Parent
  if (!rotate_node.IsLeaf())
    rotate_node.Parent(work_node);
}
//+------------------------------------------------------------------+
//| Pushing node rotate_node down and to the Left to balance the     |
//| tree. rotate_node's Right child (work_node) replaces rotate_node |
//| (since work_node > rotate_node), and work_node's Left child      |
//| becomes rotate_node's Right child (since it's < work_node but >  |
//| rotate_node).                                                    |
//+------------------------------------------------------------------+
template <typename T>
void CRedBlackTree::RotateLeft(CRedBlackTreeNode<T> *rotate_node) {
  //--- get rotate_node's Right node, this becomes work_node
  CRedBlackTreeNode<T> *work_node = rotate_node.Right();
  //--- set rotate_node's Right link
  //--- work_node's Left child's becomes rotate_node's Right child
  rotate_node.Right(work_node.Left());
  //--- modify parents
  if (!work_node.Left().IsLeaf()) {
    //--- sets work_node's Left Parent to rotate_node
    work_node.Left().Parent(rotate_node);
  }
  if (!work_node.IsLeaf()) {
    //--- set work_node's Parent to rotate_node's Parent
    work_node.Parent(rotate_node.Parent());
  }
  if (CheckPointer(rotate_node.Parent()) != POINTER_INVALID) {
    //--- determine which side of it's Parent rotate_node was on
    if (rotate_node == rotate_node.Parent().Left()) {
      //--- set Left Parent to work_node
      rotate_node.Parent().Left(work_node);
    } else {
      //--- set Right Parent to work_node
      rotate_node.Parent().Right(work_node);
    }
  } else {
    m_root_node = work_node;
  }

  //--- link rotate_node and work_node
  //--- put rotate_node on work_node's Left
  work_node.Left(rotate_node);
  //--- set work_node as rotate_node's Parent
  if (!rotate_node.IsLeaf())
    rotate_node.Parent(work_node);
}
//+------------------------------------------------------------------+
//| Additions to red-black trees usually destroy the red-black       |
//| properties. Examine the tree and restore. Rotations are normally |
//| required to restore it.                                          |
//+------------------------------------------------------------------+
template <typename T>
void CRedBlackTree::BalanceTreeAfterInsert(CRedBlackTreeNode<T> *insert_node) {
  //--- maintain red-black tree properties after adding new node
  while (insert_node != m_root_node &&
         insert_node.Parent().Color() == RED_BLACK_TREE_NODE_RED) {
    //--- parent node is colored red
    CRedBlackTreeNode<T> *work_node;
    //--- determine traversal path
    if (insert_node.Parent() == insert_node.Parent().Parent().Left()) {
      //--- get rigth uncle
      work_node = insert_node.Parent().Parent().Right();
      if (CheckPointer(work_node) != POINTER_INVALID &&
          work_node.Color() == RED_BLACK_TREE_NODE_RED) {
        //--- uncle is red
        //--- change parent and uncle to black
        insert_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        work_node.Color(RED_BLACK_TREE_NODE_BLACK);
        //--- grandparent must be red
        insert_node.Parent().Parent().Color(RED_BLACK_TREE_NODE_RED);
        //--- continue loop with grandparent
        insert_node = insert_node.Parent().Parent();
      } else {
        //--- uncle is black
        //--- determine if new node is greater than parent
        if (insert_node == insert_node.Parent().Right()) {
          //--- new node is greater than parent
          insert_node = insert_node.Parent();
          RotateLeft(insert_node);
        }
        //--- new node is less than parent
        insert_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        insert_node.Parent().Parent().Color(RED_BLACK_TREE_NODE_RED);
        RotateRight(insert_node.Parent().Parent());
      }
    } else {
      //--- get left uncle
      work_node = insert_node.Parent().Parent().Left();
      if (CheckPointer(work_node) != POINTER_INVALID &&
          work_node.Color() == RED_BLACK_TREE_NODE_RED) {
        //--- uncle is red
        //--- change parent and uncle to black
        insert_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        work_node.Color(RED_BLACK_TREE_NODE_BLACK);
        //--- grandparent must be red
        insert_node.Parent().Parent().Color(RED_BLACK_TREE_NODE_RED);
        //--- continue loop with grandparent
        insert_node = insert_node.Parent().Parent();
      } else {
        //--- uncle is black
        //--- determine if new node is greater than parent
        if (insert_node == insert_node.Parent().Left()) {
          //--- new node is greater than parent
          insert_node = insert_node.Parent();
          RotateRight(insert_node);
        }
        //--- new node is less than parent
        insert_node.Parent().Color(RED_BLACK_TREE_NODE_BLACK);
        insert_node.Parent().Parent().Color(RED_BLACK_TREE_NODE_RED);
        RotateLeft(insert_node.Parent().Parent());
      }
    }
  }
  //--- root should always be black
  m_root_node.Color(RED_BLACK_TREE_NODE_BLACK);
}
//+------------------------------------------------------------------+
//| Deletions from red-black trees may destroy the red-black         |
//| properties. Examine the tree and restore. Rotations are normally |
//| required to restore it.                                          |
//+------------------------------------------------------------------+
template <typename T>
void CRedBlackTree::BalanceTreeAfterDelete(CRedBlackTreeNode<T> *linked_node) {
  //--- maintain Red-Black tree balance after deleting node
  while (linked_node != m_root_node &&
         linked_node.Color() == RED_BLACK_TREE_NODE_BLACK) {
    CRedBlackTreeNode<T> *work_node;
    //--- determine traversal path
    if (linked_node == linked_node.Parent().Left()) {
      //--- work node is delete node sibling
      work_node = linked_node.Parent().Right();
      if (work_node.Color() == RED_BLACK_TREE_NODE_RED) {
        //--- delete node is black, work node is red - make both black and
        //rotate
        linked_node.Parent().Color(RED_BLACK_TREE_NODE_RED);
        work_node.Color(RED_BLACK_TREE_NODE_BLACK);
        RotateLeft(linked_node.Parent());
        work_node = linked_node.Parent().Right();
      }
      //--- check work node is not leaf
      if (work_node.IsLeaf())
        return;
      if (work_node.Left().Color() == RED_BLACK_TREE_NODE_BLACK &&
          work_node.Right().Color() == RED_BLACK_TREE_NODE_BLACK) {
        //--- children are both black
        //--- change parent to red
        work_node.Color(RED_BLACK_TREE_NODE_RED);
        //--- move up the tree
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
      //--- work node is delete node sibling
      work_node = linked_node.Parent().Left();
      if (work_node.Color() == RED_BLACK_TREE_NODE_RED) {
        //--- delete node is black, work node is red - make both black and
        //rotate
        linked_node.Parent().Color(RED_BLACK_TREE_NODE_RED);
        work_node.Color(RED_BLACK_TREE_NODE_BLACK);
        RotateRight(linked_node.Parent());
        work_node = linked_node.Parent().Left();
      }
      //--- check work node is not leaf
      if (work_node.IsLeaf())
        return;
      if (work_node.Right().Color() == RED_BLACK_TREE_NODE_BLACK &&
          work_node.Left().Color() == RED_BLACK_TREE_NODE_BLACK) {
        //--- children are both black
        //--- change parent to red
        work_node.Color(RED_BLACK_TREE_NODE_RED);
        //--- move up the tree
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
//+------------------------------------------------------------------+
//| Recursive walk of a tree.                                        |
//+------------------------------------------------------------------+
template <typename T>
void CRedBlackTree::WalkNextLevel(CRedBlackTreeNode<T> *node, T &array[],
                                  int &index) {
  //--- walk of a left subtree
  if (!node.Left().IsLeaf())
    WalkNextLevel(node.Left(), array, index);
  //--- chech index
  if (index >= ArraySize(array))
    return;
  //--- store value in the array
  array[index++] = node.Value();
  //--- walk of a right subtree
  if (!node.Right().IsLeaf())
    WalkNextLevel(node.Right(), array, index);
}
//+------------------------------------------------------------------+

#endif
