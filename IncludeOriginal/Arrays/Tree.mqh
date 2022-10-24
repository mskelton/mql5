#ifndef TREE_H
#define TREE_H

#include "TreeNode.mqh"

class CTree : public CTreeNode {
protected:
  CTreeNode *m_root_node;

public:
  CTree(void);
  ~CTree(void);

  CTreeNode *Root(void) const {
    return (m_root_node);
  }

  virtual int Type() const {
    return (0x9999);
  }

  CTreeNode *Insert(CTreeNode *new_node);

  bool Detach(CTreeNode *node);
  bool Delete(CTreeNode *node);
  void Clear(void);

  CTreeNode *Find(const CTreeNode *node);

  virtual CTreeNode *CreateElement() {
    return (NULL);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  void Balance(CTreeNode *node);
};

CTree::CTree(void) : m_root_node(NULL) {
}

CTree::~CTree(void) {
  Clear();
}

CTreeNode *CTree::Insert(CTreeNode *new_node) {
  CTreeNode *p_node;
  CTreeNode *result = m_root_node;

  if (!CheckPointer(new_node))
    return (NULL);

  if (result != NULL) {
    p_node = NULL;
    result = m_root_node;
    while (result != NULL && result.Compare(new_node) != 0) {
      p_node = result;
      result = result.GetNext(new_node);
    }
    if (result != NULL)
      return (result);
    if (p_node.Compare(new_node) > 0)
      p_node.Left(new_node);
    else
      p_node.Right(new_node);
    new_node.Parent(p_node);
    Balance(p_node);
  } else
    m_root_node = new_node;

  return (result);
}

bool CTree::Delete(CTreeNode *node) {

  if (!CheckPointer(node))
    return (false);

  if (Detach(node) && CheckPointer(node) == POINTER_DYNAMIC)
    delete node;

  return (true);
}

bool CTree::Detach(CTreeNode *node) {
  CTreeNode *curr_node, *tmp_node;
  CTreeNode *nodeA, *nodeB;

  curr_node = node;
  if (!CheckPointer(curr_node))
    return (false);

  if (curr_node.BalanceL() > curr_node.BalanceR()) {
    nodeA = curr_node.Left();
    while (nodeA.Right() != NULL)
      nodeA = nodeA.Right();
    nodeB = nodeA.Parent();
    if (nodeB != curr_node) {
      nodeB.Right(nodeA.Left());
      tmp_node = nodeB.Right();
      if (tmp_node != NULL)
        tmp_node.Parent(nodeB);
      tmp_node = curr_node.Left();
      nodeA.Left(tmp_node);
      tmp_node.Parent(nodeA);
    }

    curr_node.Left(NULL);

    nodeA.Right(curr_node.Right());
    tmp_node = curr_node.Right();
    if (tmp_node != NULL)
      tmp_node.Parent(nodeA);
    curr_node.Right(NULL);

    tmp_node = curr_node.Parent();
    nodeA.Parent(tmp_node);
    if (tmp_node != NULL) {
      if (tmp_node.Left() == curr_node)
        tmp_node.Left(nodeA);
      else
        tmp_node.Right(nodeA);
    } else {
      curr_node.Parent(NULL);
      m_root_node = nodeA;
      tmp_node = nodeA;
    }
    Balance(tmp_node);
  } else {
    if (curr_node.BalanceR() > 0) {
      nodeA = curr_node.Right();
      while (nodeA.Left() != NULL)
        nodeA = nodeA.Left();
      nodeB = nodeA.Parent();
      if (nodeB != curr_node) {
        nodeB.Left(nodeA.Right());
        tmp_node = nodeB.Left();
        if (tmp_node != NULL)
          tmp_node.Parent(nodeB);
        tmp_node = curr_node.Right();
        nodeA.Right(tmp_node);
        tmp_node.Parent(nodeA);
      }

      curr_node.Right(NULL);

      nodeA.Left(curr_node.Left());
      tmp_node = curr_node.Left();
      if (tmp_node != NULL)
        tmp_node.Parent(nodeA);
      curr_node.Left(NULL);

      tmp_node = curr_node.Parent();
      nodeA.Parent(tmp_node);
      if (tmp_node != NULL) {
        if (tmp_node.Left() == curr_node)
          tmp_node.Left(nodeA);
        else
          tmp_node.Right(nodeA);
      } else {
        curr_node.Parent(NULL);
        m_root_node = nodeA;
        tmp_node = nodeA;
      }
      Balance(tmp_node);
    } else {

      if (curr_node.Parent() == NULL)
        m_root_node = NULL;
      else {
        tmp_node = curr_node.Parent();
        if (tmp_node.Left() == curr_node)
          tmp_node.Left(NULL);
        else
          tmp_node.Right(NULL);
        curr_node.Parent(NULL);
      }
      Balance(curr_node.Parent());
    }
  }

  return (true);
}

void CTree::Clear(void) {
  if (CheckPointer(m_root_node) == POINTER_DYNAMIC)
    delete m_root_node;
  m_root_node = NULL;
}

CTreeNode *CTree::Find(const CTreeNode *node) {
  CTreeNode *result = m_root_node;

  while (result != NULL && result.Compare(node) != 0)
    result = result.GetNext(node);

  return (result);
}

void CTree::Balance(CTreeNode *node) {
  CTreeNode *nodeA, *nodeB, *nodeC, *curr_node, *tmp_node;

  curr_node = node;
  while (curr_node != NULL) {
    curr_node.RefreshBalance();
    if (MathAbs(curr_node.BalanceL() - curr_node.BalanceR()) <= 1)
      curr_node = curr_node.Parent();
    else {
      if (curr_node.BalanceR() > curr_node.BalanceL()) {

        tmp_node = curr_node.Right();
        if (tmp_node.BalanceL() > tmp_node.BalanceR()) {

          nodeA = curr_node;
          nodeB = nodeA.Right();
          nodeC = nodeB.Left();
          nodeC.Parent(nodeA.Parent());
          tmp_node = nodeC.Parent();
          if (tmp_node != NULL) {
            if (tmp_node.Right() == nodeA)
              tmp_node.Right(nodeC);
            else
              tmp_node.Left(nodeC);
          } else
            m_root_node = nodeC;
          nodeA.Parent(nodeC);
          nodeB.Parent(nodeC);
          nodeA.Right(nodeC.Left());
          tmp_node = nodeA.Right();
          if (tmp_node != NULL)
            tmp_node.Parent(nodeA);
          nodeC.Left(nodeA);
          nodeB.Left(nodeC.Right());
          tmp_node = nodeB.Left();
          if (tmp_node != NULL)
            tmp_node.Parent(nodeB);
          nodeC.Right(nodeB);
          if (m_root_node == nodeA)
            m_root_node = nodeC;
          curr_node = nodeC.Parent();
        } else {

          nodeA = curr_node;
          nodeB = nodeA.Right();
          nodeB.Parent(nodeA.Parent());
          tmp_node = nodeB.Parent();
          if (tmp_node != NULL) {
            if (tmp_node.Right() == nodeA)
              tmp_node.Right(nodeB);
            else
              tmp_node.Left(nodeB);
          } else
            m_root_node = nodeB;
          nodeA.Parent(nodeB);
          nodeA.Right(nodeB.Left());
          tmp_node = nodeA.Right();
          if (tmp_node != NULL)
            tmp_node.Parent(nodeA);
          nodeB.Left(nodeA);
          if (m_root_node == nodeA)
            m_root_node = nodeB;
          curr_node = nodeB.Parent();
        }
      } else {

        tmp_node = curr_node.Left();
        if (tmp_node.BalanceR() > tmp_node.BalanceL()) {

          nodeA = curr_node;
          nodeB = nodeA.Left();
          nodeC = nodeB.Right();
          nodeC.Parent(nodeA.Parent());
          tmp_node = nodeC.Parent();
          if (tmp_node != NULL) {
            if (tmp_node.Right() == nodeA)
              tmp_node.Right(nodeC);
            else
              tmp_node.Left(nodeC);
          } else
            m_root_node = nodeC;
          nodeA.Parent(nodeC);
          nodeB.Parent(nodeC);
          nodeA.Left(nodeC.Right());
          tmp_node = nodeA.Left();
          if (tmp_node != NULL)
            tmp_node.Parent(nodeA);
          nodeC.Right(nodeA);
          nodeB.Right(nodeC.Left());
          tmp_node = nodeB.Right();
          if (tmp_node != NULL)
            tmp_node.Parent(nodeB);
          nodeC.Left(nodeB);
          if (m_root_node == nodeA)
            m_root_node = nodeC;
          curr_node = nodeC.Parent();
        } else {

          nodeA = curr_node;
          nodeB = nodeA.Left();
          nodeB.Parent(nodeA.Parent());
          tmp_node = nodeB.Parent();
          if (tmp_node != NULL) {
            if (tmp_node.Right() == nodeA)
              tmp_node.Right(nodeB);
            else
              tmp_node.Left(nodeB);
          } else
            m_root_node = nodeB;
          nodeA.Parent(nodeB);
          nodeA.Left(nodeB.Right());
          tmp_node = nodeA.Left();
          if (tmp_node != NULL)
            tmp_node.Parent(nodeA);
          nodeB.Right(nodeA);
          if (m_root_node == nodeA)
            m_root_node = nodeB;
          curr_node = nodeB.Parent();
        }
      }
    }
  }
}

bool CTree::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);
  if (m_root_node == NULL)
    return (true);

  return (m_root_node.SaveNode(file_handle));
}

bool CTree::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  Clear();
  Insert(CreateElement());

  return (m_root_node.LoadNode(file_handle, m_root_node));
}

#endif
