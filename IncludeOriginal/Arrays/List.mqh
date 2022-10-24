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

  bool FreeMode(void) const {
    return (m_free_mode);
  }
  void FreeMode(bool mode) {
    m_free_mode = mode;
  }
  int Total(void) const {
    return (m_data_total);
  }
  bool IsSorted(void) const {
    return (m_data_sort);
  }
  int SortMode(void) const {
    return (m_sort_mode);
  }

  virtual int Type(void) const {
    return (0x7779);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  virtual CObject *CreateElement(void) {
    return (NULL);
  }

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

CList::CList(void)
    : m_first_node(NULL), m_last_node(NULL), m_curr_node(NULL), m_curr_idx(-1),
      m_data_total(0), m_free_mode(true), m_data_sort(false), m_sort_mode(0) {}

CList::~CList(void) {
  Clear();
}

void CList::QuickSort(int beg, int end, int mode) {
  int i, j, k;
  CObject *i_ptr, *j_ptr, *k_ptr;

  i_ptr = GetNodeAtIndex(i = beg);
  j_ptr = GetNodeAtIndex(j = end);
  while (i < end) {

    k_ptr = GetNodeAtIndex(k = (beg + end) >> 1);
    while (i < j) {
      while (i_ptr.Compare(k_ptr, mode) < 0) {

        if (i == m_data_total - 1)
          break;
        i++;
        i_ptr = i_ptr.Next();
      }
      while (j_ptr.Compare(k_ptr, mode) > 0) {

        if (j == 0)
          break;
        j--;
        j_ptr = j_ptr.Prev();
      }
      if (i <= j) {
        Exchange(i_ptr, j_ptr);
        i++;
        i_ptr = GetNodeAtIndex(i);

        if (j == 0)
          break;
        else {
          j--;
          j_ptr = GetNodeAtIndex(j);
        }
      }
    }
    if (beg < j)
      QuickSort(beg, j, mode);
    beg = i;
    i_ptr = GetNodeAtIndex(i = beg);
    j_ptr = GetNodeAtIndex(j = end);
  }
}

int CList::IndexOf(CObject *node) {

  if (!CheckPointer(node) || !CheckPointer(m_curr_node))
    return (-1);

  if (node == m_curr_node)
    return (m_curr_idx);
  if (GetFirstNode() == node)
    return (0);
  for (int i = 1; i < m_data_total; i++)
    if (GetNextNode() == node)
      return (i);

  return (-1);
}

int CList::Add(CObject *new_node) {

  if (!CheckPointer(new_node))
    return (-1);

  if (m_first_node == NULL)
    m_first_node = new_node;
  else {
    m_last_node.Next(new_node);
    new_node.Prev(m_last_node);
  }
  m_curr_node = new_node;
  m_curr_idx = m_data_total;
  m_last_node = new_node;
  m_data_sort = false;

  return (m_data_total++);
}

int CList::Insert(CObject *new_node, int index) {
  CObject *tmp_node;

  if (!CheckPointer(new_node))
    return (-1);
  if (index > m_data_total || index < 0)
    return (-1);

  if (index == -1) {
    if (m_curr_node == NULL)
      return (Add(new_node));
  } else {
    if (GetNodeAtIndex(index) == NULL)
      return (Add(new_node));
  }

  tmp_node = m_curr_node.Prev();
  new_node.Prev(tmp_node);
  if (tmp_node != NULL)
    tmp_node.Next(new_node);
  else
    m_first_node = new_node;
  new_node.Next(m_curr_node);
  m_curr_node.Prev(new_node);
  m_data_total++;
  m_data_sort = false;
  m_curr_node = new_node;

  return (index);
}

CObject *CList::GetNodeAtIndex(int index) {
  int i;
  bool revers;
  CObject *result;

  if (index >= m_data_total)
    return (NULL);
  if (index == m_curr_idx)
    return (m_curr_node);

  if (index < m_curr_idx) {

    if (m_curr_idx - index < index) {

      i = m_curr_idx;
      revers = true;
      result = m_curr_node;
    } else {

      i = 0;
      revers = false;
      result = m_first_node;
    }
  } else {

    if (index - m_curr_idx < m_data_total - index - 1) {

      i = m_curr_idx;
      revers = false;
      result = m_curr_node;
    } else {

      i = m_data_total - 1;
      revers = true;
      result = m_last_node;
    }
  }
  if (!CheckPointer(result))
    return (NULL);

  if (revers) {

    for (; i > index; i--) {
      result = result.Prev();
      if (result == NULL)
        return (NULL);
    }
  } else {

    for (; i < index; i++) {
      result = result.Next();
      if (result == NULL)
        return (NULL);
    }
  }
  m_curr_idx = index;

  return (m_curr_node = result);
}

CObject *CList::GetFirstNode(void) {

  if (!CheckPointer(m_first_node))
    return (NULL);

  m_curr_idx = 0;

  return (m_curr_node = m_first_node);
}

CObject *CList::GetPrevNode(void) {

  if (!CheckPointer(m_curr_node) || m_curr_node.Prev() == NULL)
    return (NULL);

  m_curr_idx--;

  return (m_curr_node = m_curr_node.Prev());
}

CObject *CList::GetCurrentNode(void) {
  return (m_curr_node);
}

CObject *CList::GetNextNode(void) {

  if (!CheckPointer(m_curr_node) || m_curr_node.Next() == NULL)
    return (NULL);

  m_curr_idx++;

  return (m_curr_node = m_curr_node.Next());
}

CObject *CList::GetLastNode(void) {

  if (!CheckPointer(m_last_node))
    return (NULL);

  m_curr_idx = m_data_total - 1;

  return (m_curr_node = m_last_node);
}

CObject *CList::DetachCurrent(void) {
  CObject *tmp_node, *result = NULL;

  if (!CheckPointer(m_curr_node))
    return (result);

  result = m_curr_node;
  m_curr_node = NULL;

  if ((tmp_node = result.Next()) != NULL) {
    tmp_node.Prev(result.Prev());
    m_curr_node = tmp_node;
  }

  if ((tmp_node = result.Prev()) != NULL) {
    tmp_node.Next(result.Next());

    if (m_curr_node == NULL) {
      m_curr_node = tmp_node;
      m_curr_idx = m_data_total - 2;
    }
  }
  m_data_total--;

  if (m_first_node == result)
    m_first_node = result.Next();
  if (m_last_node == result)
    m_last_node = result.Prev();

  result.Prev(NULL);
  result.Next(NULL);

  return (result);
}

bool CList::DeleteCurrent(void) {
  CObject *result = DetachCurrent();

  if (result == NULL)
    return (false);

  if (m_free_mode) {

    if (CheckPointer(result) == POINTER_DYNAMIC)
      delete result;
  }

  return (true);
}

bool CList::Delete(int index) {
  if (GetNodeAtIndex(index) == NULL)
    return (false);

  return (DeleteCurrent());
}

void CList::Clear(void) {
  GetFirstNode();
  while (m_data_total != 0)
    if (!DeleteCurrent())
      break;
}

bool CList::CompareList(CList *List) {
  CObject *node, *lnode;

  if (!CheckPointer(List))
    return (false);
  if ((node = GetFirstNode()) == NULL)
    return (false);
  if ((lnode = List.GetFirstNode()) == NULL)
    return (false);

  if (node.Compare(lnode) != 0)
    return (false);
  while ((node = GetNextNode()) != NULL) {
    if ((lnode = List.GetNextNode()) == NULL)
      return (false);
    if (node.Compare(lnode) != 0)
      return (false);
  }

  return (true);
}

void CList::Sort(int mode) {

  if (m_data_total == 0)
    return;
  if (m_data_sort && m_sort_mode == mode)
    return;

  QuickSort(0, m_data_total - 1, mode);
  m_sort_mode = mode;
  m_data_sort = true;
}

bool CList::MoveToIndex(int index) {

  if (index >= m_data_total || !CheckPointer(m_curr_node))
    return (false);

  if (m_curr_idx == index)
    return (true);
  if (m_curr_idx < index)
    index--;

  Insert(DetachCurrent(), index);

  return (true);
}

bool CList::Exchange(CObject *node1, CObject *node2) {
  CObject *tmp_node, *node;

  if (!CheckPointer(node1) || !CheckPointer(node2))
    return (false);

  tmp_node = node1.Prev();
  node1.Prev(node2.Prev());
  if (node1.Prev() != NULL) {
    node = node1.Prev();
    node.Next(node1);
  } else
    m_first_node = node1;
  node2.Prev(tmp_node);
  if (node2.Prev() != NULL) {
    node = node2.Prev();
    node.Next(node2);
  } else
    m_first_node = node2;
  tmp_node = node1.Next();
  node1.Next(node2.Next());
  if (node1.Next() != NULL) {
    node = node1.Next();
    node.Prev(node1);
  } else
    m_last_node = node1;
  node2.Next(tmp_node);
  if (node2.Next() != NULL) {
    node = node2.Next();
    node.Prev(node2);
  } else
    m_last_node = node2;

  m_curr_idx = 0;
  m_curr_node = m_first_node;
  m_data_sort = false;

  return (true);
}

CObject *CList::QuickSearch(CObject *element) {
  int i, j, m;
  CObject *t_node = NULL;

  if (m_data_total == 0)
    return (NULL);

  i = 0;
  j = m_data_total;
  while (j >= i) {

    m = (j + i) >> 1;
    if (m < 0 || m >= m_data_total)
      break;
    t_node = GetNodeAtIndex(m);
    if (t_node.Compare(element, m_sort_mode) == 0)
      break;
    if (t_node.Compare(element, m_sort_mode) > 0)
      j = m - 1;
    else
      i = m + 1;
    t_node = NULL;
  }

  return (t_node);
}

CObject *CList::Search(CObject *element) {
  CObject *result;

  if (!CheckPointer(element) || !m_data_sort)
    return (NULL);

  result = QuickSearch(element);

  return (result);
}

bool CList::Save(const int file_handle) {
  CObject *node;
  bool result = true;

  if (!CheckPointer(m_curr_node) || file_handle == INVALID_HANDLE)
    return (false);

  if (FileWriteLong(file_handle, -1) != sizeof(long))
    return (false);

  if (FileWriteInteger(file_handle, Type(), INT_VALUE) != INT_VALUE)
    return (false);

  if (FileWriteInteger(file_handle, m_data_total, INT_VALUE) != INT_VALUE)
    return (false);

  node = m_first_node;
  while (node != NULL) {
    result &= node.Save(file_handle);
    node = node.Next();
  }

  return (result);
}

bool CList::Load(const int file_handle) {
  uint i, num;
  CObject *node;
  bool result = true;

  if (file_handle == INVALID_HANDLE)
    return (false);

  if (FileReadLong(file_handle) != -1)
    return (false);

  if (FileReadInteger(file_handle, INT_VALUE) != Type())
    return (false);

  num = FileReadInteger(file_handle, INT_VALUE);

  Clear();
  for (i = 0; i < num; i++) {
    node = CreateElement();
    if (node == NULL)
      return (false);
    Add(node);
    result &= node.Load(file_handle);
  }

  return (result);
}

#endif
