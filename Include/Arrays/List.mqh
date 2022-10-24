#ifndef LIST_H
#define LIST_H

#include <Object.mqh>

class CList : public CObject {
protected:
  CObject *m_first_node;
  CObject *m_last_node;
  CObject *m_curr_node;
  int m_curr_idx;
  int m_data_total;
  bool m_free_mode;
  bool m_data_sort;
  int m_sort_mode;

public:
  CList(void);
  ~CList(void);

  bool FreeMode(void) const ;
  void FreeMode(bool mode) ;
  int Total(void) const ;
  bool IsSorted(void) const ;
  int SortMode(void) const ;

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  virtual CObject *CreateElement(void) ;

  int Add(CObject *new_node);
  int Insert(CObject *new_node, int index);

  int IndexOf(CObject *node);
  CObject *GetNodeAtIndex(int index);
  CObject *GetFirstNode(void);
  CObject *GetPrevNode(void);
  CObject *GetCurrentNode(void);
  CObject *GetNextNode(void);
  CObject *GetLastNode(void);

  CObject *DetachCurrent(void);
  bool DeleteCurrent(void);
  bool Delete(int index);
  void Clear(void);

  bool CompareList(CList *List);

  void Sort(int mode);
  bool MoveToIndex(int index);
  bool Exchange(CObject *node1, CObject *node2);

  CObject *Search(CObject *element);

protected:
  void QuickSort(int beg, int end, int mode);
  CObject *QuickSearch(CObject *element);
};

























#endif
