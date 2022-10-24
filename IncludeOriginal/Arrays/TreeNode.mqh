#ifndef TREE_NODE_H
#define TREE_NODE_H

#include <Object.mqh>

class CTreeNode : public CObject {
private:
  CTreeNode *m_p_node;
  CTreeNode *m_l_node;
  CTreeNode *m_r_node;

  int m_balance;
  int m_l_balance;
  int m_r_balance;

public:
  CTreeNode(void);
  ~CTreeNode(void);

  CTreeNode *Parent(void) const {
    return (m_p_node);
  }
  void Parent(CTreeNode *node) {
    m_p_node = node;
  }
  CTreeNode *Left(void) const {
    return (m_l_node);
  }
  void Left(CTreeNode *node) {
    m_l_node = node;
  }
  CTreeNode *Right(void) const {
    return (m_r_node);
  }
  void Right(CTreeNode *node) {
    m_r_node = node;
  }
  int Balance(void) const {
    return (m_balance);
  }
  int BalanceL(void) const {
    return (m_l_balance);
  }
  int BalanceR(void) const {
    return (m_r_balance);
  }

  virtual int Type(void) const {
    return (0x8888);
  }

  int RefreshBalance(void);
  CTreeNode *GetNext(const CTreeNode *node);

  bool SaveNode(const int file_handle);
  bool LoadNode(const int file_handle, CTreeNode *main);

protected:
  virtual CTreeNode *CreateSample(void) {
    return (NULL);
  }
};

CTreeNode::CTreeNode(void)
    : m_p_node(NULL), m_l_node(NULL), m_r_node(NULL), m_balance(0),
      m_l_balance(0), m_r_balance(0) {}

CTreeNode::~CTreeNode(void) {

  if (m_l_node != NULL)
    delete m_l_node;
  if (m_r_node != NULL)
    delete m_r_node;
}

int CTreeNode::RefreshBalance(void) {

  if (m_l_node == NULL)
    m_l_balance = 0;
  else
    m_l_balance = m_l_node.RefreshBalance();

  if (m_r_node == NULL)
    m_r_balance = 0;
  else
    m_r_balance = m_r_node.RefreshBalance();

  if (m_r_balance > m_l_balance)
    m_balance = m_r_balance + 1;
  else
    m_balance = m_l_balance + 1;

  return (m_balance);
}

CTreeNode *CTreeNode::GetNext(const CTreeNode *node) {
  if (Compare(node) > 0)
    return (m_l_node);

  return (m_r_node);
}

bool CTreeNode::SaveNode(const int file_handle) {
  bool result = true;

  if (file_handle == INVALID_HANDLE)
    return (false);

  if (m_l_node != NULL) {
    FileWriteInteger(file_handle, 'L', SHORT_VALUE);
    result &= m_l_node.SaveNode(file_handle);
  } else
    FileWriteInteger(file_handle, 'X', SHORT_VALUE);

  result &= Save(file_handle);

  if (m_r_node != NULL) {
    FileWriteInteger(file_handle, 'R', SHORT_VALUE);
    result &= m_r_node.SaveNode(file_handle);
  } else
    FileWriteInteger(file_handle, 'X', SHORT_VALUE);

  return (true);
}

bool CTreeNode::LoadNode(const int file_handle, CTreeNode *main) {
  bool result = true;
  short s_val;
  CTreeNode *node;

  if (file_handle == INVALID_HANDLE)
    return (false);

  s_val = (short)FileReadInteger(file_handle, SHORT_VALUE);
  if (s_val == 'L') {

    node = CreateSample();
    if (node == NULL)
      return (false);
    m_l_node = node;
    node.Parent(main);
    result &= node.LoadNode(file_handle, node);
  }

  result &= Load(file_handle);

  s_val = (short)FileReadInteger(file_handle, SHORT_VALUE);
  if (s_val == 'R') {

    node = CreateSample();
    if (node == NULL)
      return (false);
    m_r_node = node;
    node.Parent(main);
    result &= node.LoadNode(file_handle, node);
  }

  return (result);
}

#endif
