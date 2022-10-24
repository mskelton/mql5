#ifndef ARRAY_INT_H
#define ARRAY_INT_H

#include "Array.mqh"

class CArrayInt : public CArray {
protected:
  int m_data[];

public:
  CArrayInt(void);
  ~CArrayInt(void);

  virtual int Type(void) const {
    return (TYPE_INT);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const int element);
  bool AddArray(const int &src[]);
  bool AddArray(const CArrayInt *src);
  bool Insert(const int element, const int pos);
  bool InsertArray(const int &src[], const int pos);
  bool InsertArray(const CArrayInt *src, const int pos);
  bool AssignArray(const int &src[]);
  bool AssignArray(const CArrayInt *src);

  int At(const int index) const;
  int operator[](const int index) const {
    return (At(index));
  }

  int Minimum(const int start, const int count) const {
    return (CArray::Minimum(m_data, start, count));
  }
  int Maximum(const int start, const int count) const {
    return (CArray::Maximum(m_data, start, count));
  }

  bool Update(const int index, const int element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const int &array[]) const;
  bool CompareArray(const CArrayInt *array) const;

  bool InsertSort(const int element);
  int Search(const int element) const;
  int SearchGreat(const int element) const;
  int SearchLess(const int element) const;
  int SearchGreatOrEqual(const int element) const;
  int SearchLessOrEqual(const int element) const;
  int SearchFirst(const int element) const;
  int SearchLast(const int element) const;
  int SearchLinear(const int element) const;

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0);
  int QuickSearch(const int element) const;
  int MemMove(const int dest, const int src, int count);
};

CArrayInt::CArrayInt(void) {

  m_data_max = ArraySize(m_data);
}

CArrayInt::~CArrayInt(void) {
  if (m_data_max != 0)
    Shutdown();
}

int CArrayInt::MemMove(const int dest, const int src, int count) {
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

    for (i = 0; i < count; i++)
      m_data[dest + i] = m_data[src + i];
  } else {

    for (i = count - 1; i >= 0; i--)
      m_data[dest + i] = m_data[src + i];
  }

  return (dest);
}

bool CArrayInt::Reserve(const int size) {
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
  }

  return (Available() >= size);
}

bool CArrayInt::Resize(const int size) {
  int new_size;

  if (size < 0)
    return (false);

  new_size = m_step_resize * (1 + size / m_step_resize);
  if (m_data_max != new_size) {
    if ((m_data_max = ArrayResize(m_data, new_size)) == -1) {
      m_data_max = ArraySize(m_data);
      return (false);
    }
  }
  if (m_data_total > size)
    m_data_total = size;

  return (m_data_max == new_size);
}

bool CArrayInt::Shutdown(void) {

  if (m_data_max == 0)
    return (true);

  if (ArrayResize(m_data, 0) == -1)
    return (false);
  m_data_total = 0;
  m_data_max = 0;

  return (true);
}

bool CArrayInt::Add(const int element) {

  if (!Reserve(1))
    return (false);

  m_data[m_data_total++] = element;
  m_sort_mode = -1;

  return (true);
}

bool CArrayInt::AddArray(const int &src[]) {
  int num = ArraySize(src);

  if (!Reserve(num))
    return (false);

  for (int i = 0; i < num; i++)
    m_data[m_data_total++] = src[i];
  m_sort_mode = -1;

  return (true);
}

bool CArrayInt::AddArray(const CArrayInt *src) {
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

bool CArrayInt::Insert(const int element, const int pos) {

  if (pos < 0 || !Reserve(1))
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

bool CArrayInt::InsertArray(const int &src[], const int pos) {
  int num = ArraySize(src);

  if (!Reserve(num))
    return (false);

  if (MemMove(num + pos, pos, m_data_total - pos) < 0)
    return (false);
  for (int i = 0; i < num; i++)
    m_data[i + pos] = src[i];
  m_sort_mode = -1;

  return (true);
}

bool CArrayInt::InsertArray(const CArrayInt *src, const int pos) {
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

bool CArrayInt::AssignArray(const int &src[]) {
  int num = ArraySize(src);

  Clear();
  if (m_data_max < num) {
    if (!Reserve(num))
      return (false);
  } else
    Resize(num);

  for (int i = 0; i < num; i++) {
    m_data[i] = src[i];
    m_data_total++;
  }
  m_sort_mode = -1;

  return (true);
}

bool CArrayInt::AssignArray(const CArrayInt *src) {
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

int CArrayInt::At(const int index) const {

  if (index < 0 || index >= m_data_total)
    return (INT_MAX);

  return (m_data[index]);
}

bool CArrayInt::Update(const int index, const int element) {

  if (index < 0 || index >= m_data_total)
    return (false);

  m_data[index] = element;
  m_sort_mode = -1;

  return (true);
}

bool CArrayInt::Shift(const int index, const int shift) {
  int tmp_int;

  if (index < 0 || index + shift < 0 || index + shift >= m_data_total)
    return (false);
  if (shift == 0)
    return (true);

  tmp_int = m_data[index];
  if (shift > 0) {
    if (MemMove(index, index + 1, shift) < 0)
      return (false);
  } else {
    if (MemMove(index + shift + 1, index + shift, -shift) < 0)
      return (false);
  }
  m_data[index + shift] = tmp_int;
  m_sort_mode = -1;

  return (true);
}

bool CArrayInt::Delete(const int index) {

  if (index < 0 || index >= m_data_total)
    return (false);

  if (index < m_data_total - 1 &&
      MemMove(index, index + 1, m_data_total - index - 1) < 0)
    return (false);
  m_data_total--;

  return (true);
}

bool CArrayInt::DeleteRange(int from, int to) {

  if (from < 0 || to < 0)
    return (false);
  if (from > to || from >= m_data_total)
    return (false);

  if (to >= m_data_total - 1)
    to = m_data_total - 1;
  if (MemMove(from, to + 1, m_data_total - to - 1) < 0)
    return (false);
  m_data_total -= to - from + 1;

  return (true);
}

bool CArrayInt::CompareArray(const int &array[]) const {

  if (m_data_total != ArraySize(array))
    return (false);
  for (int i = 0; i < m_data_total; i++)
    if (m_data[i] != array[i])
      return (false);

  return (true);
}

bool CArrayInt::CompareArray(const CArrayInt *array) const {

  if (!CheckPointer(array))
    return (false);

  if (m_data_total != array.m_data_total)
    return (false);
  for (int i = 0; i < m_data_total; i++)
    if (m_data[i] != array.m_data[i])
      return (false);

  return (true);
}

void CArrayInt::QuickSort(int beg, int end, const int mode) {
  int i, j;
  int p_int, t_int;

  if (beg < 0 || end < 0)
    return;

  i = beg;
  j = end;
  while (i < end) {

    p_int = m_data[(beg + end) >> 1];
    while (i < j) {
      while (m_data[i] < p_int) {

        if (i == m_data_total - 1)
          break;
        i++;
      }
      while (m_data[j] > p_int) {

        if (j == 0)
          break;
        j--;
      }
      if (i <= j) {
        t_int = m_data[i];
        m_data[i++] = m_data[j];
        m_data[j] = t_int;

        if (j == 0)
          break;
        j--;
      }
    }
    if (beg < j)
      QuickSort(beg, j);
    beg = i;
    j = end;
  }
}

bool CArrayInt::InsertSort(const int element) {
  int pos;

  if (!IsSorted())
    return (false);

  if (!Reserve(1))
    return (false);

  if (m_data_total == 0) {
    m_data[m_data_total++] = element;
    return (true);
  }

  pos = QuickSearch(element);
  if (m_data[pos] > element)
    Insert(element, pos);
  else
    Insert(element, pos + 1);

  m_sort_mode = 0;

  return (true);
}

int CArrayInt::SearchLinear(const int element) const {

  if (m_data_total == 0)
    return (-1);

  for (int i = 0; i < m_data_total; i++)
    if (m_data[i] == element)
      return (i);

  return (-1);
}

int CArrayInt::QuickSearch(const int element) const {
  int i, j, m = -1;
  int t_int;

  i = 0;
  j = m_data_total - 1;
  while (j >= i) {

    m = (j + i) >> 1;
    if (m < 0 || m >= m_data_total)
      break;
    t_int = m_data[m];
    if (t_int == element)
      break;
    if (t_int > element)
      j = m - 1;
    else
      i = m + 1;
  }

  return (m);
}

int CArrayInt::Search(const int element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);
  if (m_data[pos] == element)
    return (pos);

  return (-1);
}

int CArrayInt::SearchGreat(const int element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);
  while (m_data[pos] <= element)
    if (++pos == m_data_total)
      return (-1);

  return (pos);
}

int CArrayInt::SearchLess(const int element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);
  while (m_data[pos] >= element)
    if (pos-- == 0)
      return (-1);

  return (pos);
}

int CArrayInt::SearchGreatOrEqual(const int element) const {

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  for (int pos = QuickSearch(element); pos < m_data_total; pos++)
    if (m_data[pos] >= element)
      return (pos);

  return (-1);
}

int CArrayInt::SearchLessOrEqual(const int element) const {

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  for (int pos = QuickSearch(element); pos >= 0; pos--)
    if (m_data[pos] <= element)
      return (pos);

  return (-1);
}

int CArrayInt::SearchFirst(const int element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);
  if (m_data[pos] == element) {
    while (m_data[pos] == element)
      if (pos-- == 0)
        break;
    return (pos + 1);
  }

  return (-1);
}

int CArrayInt::SearchLast(const int element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);
  if (m_data[pos] == element) {
    while (m_data[pos] == element)
      if (++pos == m_data_total)
        break;
    return (pos - 1);
  }

  return (-1);
}

bool CArrayInt::Save(const int file_handle) {
  int i = 0;

  if (!CArray::Save(file_handle))
    return (false);

  if (FileWriteInteger(file_handle, m_data_total, INT_VALUE) != INT_VALUE)
    return (false);

  for (i = 0; i < m_data_total; i++)
    if (FileWriteInteger(file_handle, m_data[i], INT_VALUE) != INT_VALUE)
      break;

  return (i == m_data_total);
}

bool CArrayInt::Load(const int file_handle) {
  int i = 0, num;

  if (!CArray::Load(file_handle))
    return (false);

  num = FileReadInteger(file_handle, INT_VALUE);

  Clear();
  if (num != 0) {
    if (!Reserve(num))
      return (false);
    for (i = 0; i < num; i++) {
      m_data[i] = FileReadInteger(file_handle, INT_VALUE);
      m_data_total++;
      if (FileIsEnding(file_handle))
        break;
    }
  }
  m_sort_mode = -1;

  return (m_data_total == num);
}

#endif
