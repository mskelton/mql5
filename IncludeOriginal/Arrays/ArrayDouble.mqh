#ifndef ARRAY_DOUBLE_H
#define ARRAY_DOUBLE_H

#include "Array.mqh"

class CArrayDouble : public CArray {
protected:
  double m_data[];
  double m_delta;

public:
  CArrayDouble(void);
  ~CArrayDouble(void);

  void Delta(const double delta) {
    m_delta = MathAbs(delta);
  }

  virtual int Type(void) const {
    return (TYPE_DOUBLE);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const double element);
  bool AddArray(const double &src[]);
  bool AddArray(const CArrayDouble *src);
  bool Insert(const double element, const int pos);
  bool InsertArray(const double &src[], const int pos);
  bool InsertArray(const CArrayDouble *src, const int pos);
  bool AssignArray(const double &src[]);
  bool AssignArray(const CArrayDouble *src);

  double At(const int index) const;
  double operator[](const int index) const {
    return (At(index));
  }

  int Minimum(const int start, const int count) const {
    return (CArray::Minimum(m_data, start, count));
  }
  int Maximum(const int start, const int count) const {
    return (CArray::Maximum(m_data, start, count));
  }

  bool Update(const int index, const double element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const double &array[]) const;
  bool CompareArray(const CArrayDouble *array) const;

  bool InsertSort(const double element);
  int Search(const double element) const;
  int SearchGreat(const double element) const;
  int SearchLess(const double element) const;
  int SearchGreatOrEqual(const double element) const;
  int SearchLessOrEqual(const double element) const;
  int SearchFirst(const double element) const;
  int SearchLast(const double element) const;
  int SearchLinear(const double element) const;

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0);
  int QuickSearch(const double element) const;
  int MemMove(const int dest, const int src, int count);
};

CArrayDouble::CArrayDouble(void) : m_delta(0.0) {
  m_data_max = ArraySize(m_data);
}

CArrayDouble::~CArrayDouble(void) {
  if (m_data_max != 0)
    Shutdown();
}

int CArrayDouble::MemMove(const int dest, const int src, int count) {
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

bool CArrayDouble::Reserve(const int size) {
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

bool CArrayDouble::Resize(const int size) {
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

bool CArrayDouble::Shutdown(void) {

  if (m_data_max == 0)
    return (true);

  if (ArrayResize(m_data, 0) == -1)
    return (false);
  m_data_total = 0;
  m_data_max = 0;

  return (true);
}

bool CArrayDouble::Add(const double element) {

  if (!Reserve(1))
    return (false);

  m_data[m_data_total++] = element;
  m_sort_mode = -1;

  return (true);
}

bool CArrayDouble::AddArray(const double &src[]) {
  int num = ArraySize(src);

  if (!Reserve(num))
    return (false);

  for (int i = 0; i < num; i++)
    m_data[m_data_total++] = src[i];
  m_sort_mode = -1;

  return (true);
}

bool CArrayDouble::AddArray(const CArrayDouble *src) {
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

bool CArrayDouble::Insert(const double element, const int pos) {

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

bool CArrayDouble::InsertArray(const double &src[], const int pos) {
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

bool CArrayDouble::InsertArray(const CArrayDouble *src, const int pos) {
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

bool CArrayDouble::AssignArray(const double &src[]) {
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

bool CArrayDouble::AssignArray(const CArrayDouble *src) {
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

double CArrayDouble::At(const int index) const {

  if (index < 0 || index >= m_data_total)
    return (DBL_MAX);

  return (m_data[index]);
}

bool CArrayDouble::Update(const int index, const double element) {

  if (index < 0 || index >= m_data_total)
    return (false);

  m_data[index] = element;
  m_sort_mode = -1;

  return (true);
}

bool CArrayDouble::Shift(const int index, const int shift) {
  double tmp_double;

  if (index < 0 || index + shift < 0 || index + shift >= m_data_total)
    return (false);
  if (shift == 0)
    return (true);

  tmp_double = m_data[index];
  if (shift > 0) {
    if (MemMove(index, index + 1, shift) < 0)
      return (false);
  } else {
    if (MemMove(index + shift + 1, index + shift, -shift) < 0)
      return (false);
  }
  m_data[index + shift] = tmp_double;
  m_sort_mode = -1;

  return (true);
}

bool CArrayDouble::Delete(const int index) {

  if (index < 0 || index >= m_data_total)
    return (false);

  if (index < m_data_total - 1 &&
      MemMove(index, index + 1, m_data_total - index - 1) < 0)
    return (false);
  m_data_total--;

  return (true);
}

bool CArrayDouble::DeleteRange(int from, int to) {

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

bool CArrayDouble::CompareArray(const double &array[]) const {

  if (m_data_total != ArraySize(array))
    return (false);
  for (int i = 0; i < m_data_total; i++)
    if (m_data[i] != array[i])
      return (false);

  return (true);
}

bool CArrayDouble::CompareArray(const CArrayDouble *array) const {

  if (!CheckPointer(array))
    return (false);

  if (m_data_total != array.m_data_total)
    return (false);
  for (int i = 0; i < m_data_total; i++)
    if (m_data[i] != array.m_data[i])
      return (false);

  return (true);
}

void CArrayDouble::QuickSort(int beg, int end, const int mode) {
  int i, j;
  double p_double, t_double;

  if (beg < 0 || end < 0)
    return;

  i = beg;
  j = end;
  while (i < end) {

    p_double = m_data[(beg + end) >> 1];
    while (i < j) {
      while (m_data[i] < p_double) {

        if (i == m_data_total - 1)
          break;
        i++;
      }
      while (m_data[j] > p_double) {

        if (j == 0)
          break;
        j--;
      }
      if (i <= j) {
        t_double = m_data[i];
        m_data[i++] = m_data[j];
        m_data[j] = t_double;

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

bool CArrayDouble::InsertSort(const double element) {
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

int CArrayDouble::SearchLinear(const double element) const {

  if (m_data_total == 0)
    return (-1);

  for (int i = 0; i < m_data_total; i++)
    if (MathAbs(m_data[i] - element) <= m_delta)
      return (i);

  return (-1);
}

int CArrayDouble::QuickSearch(const double element) const {
  int i, j, m = -1;
  double t_double;

  i = 0;
  j = m_data_total - 1;
  while (j >= i) {

    m = (j + i) >> 1;
    if (m < 0 || m >= m_data_total)
      break;
    t_double = m_data[m];

    if (MathAbs(t_double - element) <= m_delta)
      break;
    if (t_double > element)
      j = m - 1;
    else
      i = m + 1;
  }

  return (m);
}

int CArrayDouble::Search(const double element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);

  if (MathAbs(m_data[pos] - element) <= m_delta)
    return (pos);

  return (-1);
}

int CArrayDouble::SearchGreat(const double element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);

  while (m_data[pos] <= element + m_delta)
    if (++pos == m_data_total)
      return (-1);

  return (pos);
}

int CArrayDouble::SearchLess(const double element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);

  while (m_data[pos] >= element - m_delta)
    if (pos-- == 0)
      return (-1);

  return (pos);
}

int CArrayDouble::SearchGreatOrEqual(const double element) const {

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  for (int pos = QuickSearch(element); pos < m_data_total; pos++)
    if (m_data[pos] >= element)
      return (pos);

  return (-1);
}

int CArrayDouble::SearchLessOrEqual(const double element) const {

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  for (int pos = QuickSearch(element); pos >= 0; pos--)
    if (m_data[pos] <= element)
      return (pos);

  return (-1);
}

int CArrayDouble::SearchFirst(const double element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);
  if (m_data[pos] == element) {

    while (MathAbs(m_data[pos] - element) <= m_delta)
      if (pos-- == 0)
        break;
    return (pos + 1);
  }

  return (-1);
}

int CArrayDouble::SearchLast(const double element) const {
  int pos;

  if (m_data_total == 0 || !IsSorted())
    return (-1);

  pos = QuickSearch(element);
  if (m_data[pos] == element) {

    while (MathAbs(m_data[pos] - element) <= m_delta)
      if (++pos == m_data_total)
        break;
    return (pos - 1);
  }

  return (-1);
}

bool CArrayDouble::Save(const int file_handle) {
  int i = 0;

  if (!CArray::Save(file_handle))
    return (false);

  if (FileWriteInteger(file_handle, m_data_total, INT_VALUE) != INT_VALUE)
    return (false);

  for (i = 0; i < m_data_total; i++)
    if (FileWriteDouble(file_handle, m_data[i]) != sizeof(double))
      break;

  return (i == m_data_total);
}

bool CArrayDouble::Load(const int file_handle) {
  int i = 0, num;

  if (!CArray::Load(file_handle))
    return (false);

  num = FileReadInteger(file_handle, INT_VALUE);

  Clear();
  if (num != 0) {
    if (!Reserve(num))
      return (false);
    for (i = 0; i < num; i++) {
      m_data[i] = FileReadDouble(file_handle);
      m_data_total++;
      if (FileIsEnding(file_handle))
        break;
    }
  }
  m_sort_mode = -1;

  return (m_data_total == num);
}

#endif
