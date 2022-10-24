#ifndef ARRAY_OBJ_H
#define ARRAY_OBJ_H

#include "Array.mqh"

class CArrayObj : public CArray {
protected:
  CObject *m_data[];
  bool m_free_mode;

public:
  CArrayObj(void);
  ~CArrayObj(void);

  bool FreeMode(void) const {
    return (m_free_mode);
  }
  void FreeMode(const bool mode) {
    m_free_mode = mode;
  }

  virtual int Type(void) const {
    return (0x7778);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  virtual bool CreateElement(const int index) {
    return (false);
  }

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(CObject *element);
  bool AddArray(const CArrayObj *src);
  bool Insert(CObject *element, const int pos);
  bool InsertArray(const CArrayObj *src, const int pos);
  bool AssignArray(const CArrayObj *src);

  CObject *At(const int index) const;

  bool Update(const int index, CObject *element);
  bool Shift(const int index, const int shift);

  CObject *Detach(const int index);
  bool Delete(const int index);
  bool DeleteRange(int from, int to);
  void Clear(void);

  bool CompareArray(const CArrayObj *array) const;

  bool InsertSort(CObject *element);
  int Search(const CObject *element) const;
  int SearchGreat(const CObject *element) const;
  int SearchLess(const CObject *element) const;
  int SearchGreatOrEqual(const CObject *element) const;
  int SearchLessOrEqual(const CObject *element) const;
  int SearchFirst(const CObject *element) const;
  int SearchLast(const CObject *element) const;

protected:
  void QuickSort(int beg, int end, const int mode);
  int QuickSearch(const CObject *element) const;
  int MemMove(const int dest, const int src, int count);
};

CArrayObj::CArrayObj(void) : m_free_mode(true) {

  m_data_max = ArraySize(m_data);
}

CArrayObj::~CArrayObj(void) {
  if (m_data_max != 0)
    Shutdown();
}

int CArrayObj::MemMove(const int dest, const int src, int count) {
  int i;

  if (dest < 0 || src < 0 || count < 0)
    return (-1);

  if (src + count > m_data_total)
    count = m_data_total - src;
  if (count < 0)
    return (-1);

  if (dest == src || count == 0)
    return (dest);

  if (dest + count > m_data_total) {
    if (m_data_max < dest + count)
      return (-1);
    m_data_total = dest + count;
  }

  if (dest < src) {

    for (i = 0; i < count; i++) {

      if (m_free_mode && CheckPointer(m_data[dest + i]) == POINTER_DYNAMIC)
        delete m_data[dest + i];

      m_data[dest + i] = m_data[src + i];
      m_data[src + i] = NULL;
    }
  } else {

    for (i = count - 1; i >= 0; i--) {

      if (m_free_mode && CheckPointer(m_data[dest + i]) == POINTER_DYNAMIC)
        delete m_data[dest + i];

      m_data[dest + i] = m_data[src + i];
      m_data[src + i] = NULL;
    }
  }

  return (dest);
}

bool CArrayObj::Reserve(const int size) {
  int new_size;

  if (size <= 0)
    return (false);

  if (Available() < size) {
    new_size =
        m_data_max + m_step_resize * (1 + (size - Available()) / m_step_resize);
    if (new_size < 0)

      return (false);
    if ((m_data_max = ArrayResize(m_data, new_size)) == -1)
      m_data_max = ArraySize(m_data);

    for (int i = m_data_total; i < m_data_max; i++)
      m_data[i] = NULL;
  }

  return (Available() >= size);
}

bool CArrayObj::Resize(const int size) {
  int new_size;

  if (size < 0)
    return (false);

  new_size = m_step_resize * (1 + size / m_step_resize);
  if (m_data_total > size) {

    if (m_free_mode)
      for (int i = size; i < m_data_total; i++)
        if (CheckPointer(m_data[i]) == POINTER_DYNAMIC)
          delete m_data[i];
    m_data_total = size;
  }
  if (m_data_max != new_size) {
    if ((m_data_max = ArrayResize(m_data, new_size)) == -1) {
      m_data_max = ArraySize(m_data);
      return (false);
    }
  }

  return (m_data_max == new_size);
}

bool CArrayObj::Shutdown(void) {

  if (m_data_max == 0)
    return (true);

  Clear();
  if (ArrayResize(m_data, 0) == -1)
    return (false);
  m_data_max = 0;

  return (true);
}

bool CArrayObj::Add(CObject *element) {

  if (!CheckPointer(element))
    return (false);

  if (!Reserve(1))
    return (false);

  m_data[m_data_total++] = element;
  m_sort_mode = -1;

  return (true);
}

bool CArrayObj::AddArray(const CArrayObj *src) {
  int num;

  if (!CheckPointer(src))
    return (false);

  num = src.Total();
  if (!Reserve(num))
    return (false);

  for (int i = 0; i < num; i++)
    m_data[m_data_total++] = src.m_data[i];
  m_sort_mode = -1;

  return (true);
}

bool CArrayObj::Insert(CObject *element, const int pos) {

  if (pos < 0 || !CheckPointer(element))
    return (false);

  if (!Reserve(1))
    return (false);

  m_data_total++;
  if (pos < m_data_total - 1) {
    if (MemMove(pos + 1, pos, m_data_total - pos - 1) < 0)
      return (false);
    m_data[pos] = element;
  } else
    m_data[m_data_total - 1] = element;
  m_sort_mode = -1;

  return (true);
}

bool CArrayObj::InsertArray(const CArrayObj *src, const int pos) {
  int num;

  if (!CheckPointer(src))
    return (false);

  num = src.Total();
  if (!Reserve(num))
    return (false);

  if (MemMove(num + pos, pos, m_data_total - pos) < 0)
    return (false);
  for (int i = 0; i < num; i++)
    m_data[i + pos] = src.m_data[i];
  m_sort_mode = -1;

  return (true);
}

bool CArrayObj::AssignArray(const CArrayObj *src) {
  int num;

  if (!CheckPointer(src))
    return (false);

  num = src.m_data_total;
  Clear();
  if (m_data_max < num) {
    if (!Reserve(num))
      return (false);
  } else
    Resize(num);

  for (int i = 0; i < num; i++) {
    m_data[i] = src.m_data[i];
    m_data_total++;
  }
  m_sort_mode = src.SortMode();

  return (true);
}

CObject *CArrayObj::At(const int index) const {

  if (index < 0 || index >= m_data_total)
    return (NULL);

  return (m_data[index]);
}

bool CArrayObj::Update(const int index, CObject *element) {

  if (index < 0 || !CheckPointer(element) || index >= m_data_total)
    return (false);

  if (m_free_mode && CheckPointer(m_data[index]) == POINTER_DYNAMIC)
    delete m_data[index];

  m_data[index] = element;
  m_sort_mode = -1;

  return (true);
}

bool CArrayObj::Shift(const int index, const int shift) {
  CObject *tmp_node;

  if (index < 0 || index + shift < 0 || index + shift >= m_data_total)
    return (false);
  if (shift == 0)
    return (true);

  tmp_node = m_data[index];
  m_data[index] = NULL;
  if (shift > 0) {
    if (MemMove(index, index + 1, shift) < 0)
      return (false);
  } else {
    if (MemMove(index + shift + 1, index + shift, -shift) < 0)
      return (false);
  }
  m_data[index + shift] = tmp_node;
  m_sort_mode = -1;

  return (true);
}

bool CArrayObj::Delete(const int index) {

  if (index >= m_data_total)
    return (false);

  if (index < m_data_total - 1) {
    if (index >= 0 && MemMove(index, index + 1, m_data_total - index - 1) < 0)
      return (false);
  } else if (m_free_mode && CheckPointer(m_data[index]) == POINTER_DYNAMIC)
    delete m_data[index];
  m_data_total--;

  return (true);
}

CObject *CArrayObj::Detach(const int index) {
  CObject *result;

  if (index >= m_data_total)
    return (NULL);

  result = m_data[index];

  m_data[index] = NULL;
  if (index < m_data_total - 1 &&
      MemMove(index, index + 1, m_data_total - index - 1) < 0)
    return (NULL);
  m_data_total--;

  return (result);
}

bool CArrayObj::DeleteRange(int from, int to) {

  if (from < 0 || to < 0)
    return (false);
  if (from > to || from >= m_data_total)
    return (false);

  if (to >= m_data_total - 1)
    to = m_data_total - 1;
  if (MemMove(from, to + 1, m_data_total - to - 1) < 0)
    return (false);
  for (int i = to - from + 1; i > 0; i--, m_data_total--)
    if (m_free_mode &&
        CheckPointer(m_data[m_data_total - 1]) == POINTER_DYNAMIC)
      delete m_data[m_data_total - 1];

  return (true);
}

void CArrayObj::Clear(void) {

  if (m_free_mode) {
    for (int i = 0; i < m_data_total; i++) {
      if (CheckPointer(m_data[i]) == POINTER_DYNAMIC)
        delete m_data[i];
      m_data[i] = NULL;
    }
  }
  m_data_total = 0;
}

bool CArrayObj::CompareArray(const CArrayObj *array) const {

  if (!CheckPointer(array))
    return (false);

  if (m_data_total != array.m_data_total)
    return (false);
  for (int i = 0; i < m_data_total; i++)
    if (m_data[i].Compare(array.m_data[i], 0) != 0)
      return (false);

  return (true);
}

void CArrayObj::QuickSort(int beg, int end, const int mode) {
  int i, j;
  CObject *p_node;
  CObject *t_node;

  i = beg;
  j = end;
  while (i < end) {

    p_node = m_data[(beg + end) >> 1];
    while (i < j) {
      while (m_data[i].Compare(p_node, mode) < 0) {

        if (i == m_data_total - 1)
          break;
        i++;
      }
      while (m_data[j].Compare(p_node, mode) > 0) {

        if (j == 0)
          break;
        j--;
      }
      if (i <= j) {
        t_node = m_data[i];
        m_data[i++] = m_data[j];
        m_data[j] = t_node;

        if (j == 0)
          break;
        j--;
      }
    }
    if (beg < j)
      QuickSort(beg, j, mode);
    beg = i;
    j = end;
  }
}

bool CArrayObj::InsertSort(CObject *element) {
  int pos;

  if (!CheckPointer(element) || m_sort_mode == -1)
    return (false);

  if (!Reserve(1))
    return (false);

  if (m_data_total == 0) {
    m_data[m_data_total++] = element;
    return (true);
  }

  int mode = m_sort_mode;
  pos = QuickSearch(element);
  if (m_data[pos].Compare(element, m_sort_mode) > 0)
    Insert(element, pos);
  else
    Insert(element, pos + 1);

  m_sort_mode = mode;

  return (true);
}

int CArrayObj::QuickSearch(const CObject *element) const {
  int i, j, m = -1;
  CObject *t_node;

  i = 0;
  j = m_data_total - 1;
  while (j >= i) {

    m = (j + i) >> 1;
    if (m < 0 || m == m_data_total - 1)
      break;
    t_node = m_data[m];
    if (t_node.Compare(element, m_sort_mode) == 0)
      break;
    if (t_node.Compare(element, m_sort_mode) > 0)
      j = m - 1;
    else
      i = m + 1;
  }

  return (m);
}

int CArrayObj::Search(const CObject *element) const {
  int pos;

  if (m_data_total == 0 || !CheckPointer(element) || m_sort_mode == -1)
    return (-1);

  pos = QuickSearch(element);
  if (m_data[pos].Compare(element, m_sort_mode) == 0)
    return (pos);

  return (-1);
}

int CArrayObj::SearchGreat(const CObject *element) const {
  int pos;

  if (m_data_total == 0 || !CheckPointer(element) || m_sort_mode == -1)
    return (-1);

  pos = QuickSearch(element);
  while (m_data[pos].Compare(element, m_sort_mode) <= 0)
    if (++pos == m_data_total)
      return (-1);

  return (pos);
}

int CArrayObj::SearchLess(const CObject *element) const {
  int pos;

  if (m_data_total == 0 || !CheckPointer(element) || m_sort_mode == -1)
    return (-1);

  pos = QuickSearch(element);
  while (m_data[pos].Compare(element, m_sort_mode) >= 0)
    if (pos-- == 0)
      return (-1);

  return (pos);
}

int CArrayObj::SearchGreatOrEqual(const CObject *element) const {

  if (m_data_total == 0 || !CheckPointer(element) || m_sort_mode == -1)
    return (-1);

  for (int pos = QuickSearch(element); pos < m_data_total; pos++)
    if (m_data[pos].Compare(element, m_sort_mode) >= 0)
      return (pos);

  return (-1);
}

int CArrayObj::SearchLessOrEqual(const CObject *element) const {

  if (m_data_total == 0 || !CheckPointer(element) || m_sort_mode == -1)
    return (-1);

  for (int pos = QuickSearch(element); pos >= 0; pos--)
    if (m_data[pos].Compare(element, m_sort_mode) <= 0)
      return (pos);

  return (-1);
}

int CArrayObj::SearchFirst(const CObject *element) const {
  int pos;

  if (m_data_total == 0 || !CheckPointer(element) || m_sort_mode == -1)
    return (-1);

  pos = QuickSearch(element);
  if (m_data[pos].Compare(element, m_sort_mode) == 0) {
    while (m_data[pos].Compare(element, m_sort_mode) == 0)
      if (pos-- == 0)
        break;
    return (pos + 1);
  }

  return (-1);
}

int CArrayObj::SearchLast(const CObject *element) const {
  int pos;

  if (m_data_total == 0 || !CheckPointer(element) || m_sort_mode == -1)
    return (-1);

  pos = QuickSearch(element);
  if (m_data[pos].Compare(element, m_sort_mode) == 0) {
    while (m_data[pos].Compare(element, m_sort_mode) == 0)
      if (++pos == m_data_total)
        break;
    return (pos - 1);
  }

  return (-1);
}

bool CArrayObj::Save(const int file_handle) {
  int i = 0;

  if (!CArray::Save(file_handle))
    return (false);

  if (FileWriteInteger(file_handle, m_data_total, INT_VALUE) != INT_VALUE)
    return (false);

  for (i = 0; i < m_data_total; i++)
    if (m_data[i].Save(file_handle) != true)
      break;

  return (i == m_data_total);
}

bool CArrayObj::Load(const int file_handle) {
  int i = 0, num;

  if (!CArray::Load(file_handle))
    return (false);

  num = FileReadInteger(file_handle, INT_VALUE);

  Clear();
  if (num != 0) {
    if (!Reserve(num))
      return (false);
    for (i = 0; i < num; i++) {

      if (!CreateElement(i))
        break;
      if (m_data[i].Load(file_handle) != true)
        break;
      m_data_total++;
    }
  }
  m_sort_mode = -1;

  return (m_data_total == num);
}

#endif
