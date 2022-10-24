#ifndef TREE_H
#define TREE_H

#include "TreeNode.mqh"

class CTree : public CTreeNode {
protected:
  CTreeNode *m_root_node;

public:
  CTree(void);
  ~CTree(void);

  CTreeNode *Root(void) const ;

  virtual int Type() const ;

  CTreeNode *Insert(CTreeNode *new_node);

  bool Detach(CTreeNode *node);
  bool Delete(CTreeNode *node);
  void Clear(void);

  CTreeNode *Find(const CTreeNode *node);

  virtual CTreeNode *CreateElement() ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  void Balance(CTreeNode *node);
};











#endif
