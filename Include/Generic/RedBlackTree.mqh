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

template <typename T> class CRedBlackTreeNode;

template <typename T> class CRedBlackTree;

#endif
