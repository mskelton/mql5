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

  CTreeNode *Parent(void) const ;
  void Parent(CTreeNode *node) ;
  CTreeNode *Left(void) const ;
  void Left(CTreeNode *node) ;
  CTreeNode *Right(void) const ;
  void Right(CTreeNode *node) ;
  int Balance(void) const ;
  int BalanceL(void) const ;
  int BalanceR(void) const ;

  virtual int Type(void) const ;

  int RefreshBalance(void);
  CTreeNode *GetNext(const CTreeNode *node);

  bool SaveNode(const int file_handle);
  bool LoadNode(const int file_handle, CTreeNode *main);

protected:
  virtual CTreeNode *CreateSample(void) ;
};







#endif
