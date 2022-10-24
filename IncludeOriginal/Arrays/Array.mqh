#ifndef ARRAY_H
#define ARRAY_H

#include <Object.mqh>

class CArray : public CObject {
protected:
  int m_step_resize;
  int m_data_total;
  int m_data_max;
  int m_sort_mode;

public:
  CArray(void);
  ~CArray(void);

  int Step(void) const {
    return (m_step_resize);
  }
  bool Step(const int step);
  int Total(void) const {
    return (m_data_total);
  }
  int Available(void) const {
    return (m_data_max - m_data_total);
  }
  int Max(void) const {
    return (m_data_max);
  }
  bool IsSorted(const int mode = 0) const {
    return (m_sort_mode == mode);
  }
  int SortMode(void) const {
    return (m_sort_mode);
  }

  void Clear(void) {
    m_data_total = 0;
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  void Sort(const int mode = 0);

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0) {
    m_sort_mode = -1;
  }

  template <typename T>
  int Minimum(const T &data[], const int start, const int count) const;
  template <typename T>
  int Maximum(const T &data[], const int start, const int count) const;
};

CArray::CArray(void)
    : m_step_resize(16), m_data_total(0), m_data_max(0), m_sort_mode(-1) {}

CArray::~CArray(void) {}

bool CArray::Step(const int step) {

  if (step > 0) {
    m_step_resize = step;
    return (true);
  }

  return (false);
}

void CArray::Sort(const int mode) {

  if (IsSorted(mode))
    return;
  m_sort_mode = mode;
  if (m_data_total <= 1)
    return;

  QuickSort(0, m_data_total - 1, mode);
}

bool CArray::Save(const int file_handle) {

  if (file_handle != INVALID_HANDLE) {

    if (FileWriteLong(file_handle, -1) == sizeof(long)) {

      if (FileWriteInteger(file_handle, Type(), INT_VALUE) == INT_VALUE)
        return (true);
    }
  }

  return (false);
}

bool CArray::Load(const int file_handle) {

  if (file_handle != INVALID_HANDLE) {

    if (FileReadLong(file_handle) == -1) {

      if (FileReadInteger(file_handle, INT_VALUE) == Type())
        return (true);
    }
  }

  return (false);
}

template <typename T>
int CArray::Minimum(const T &data[], const int start, const int count) const {
  int real_count;

  if (m_data_total < 1) {
    SetUserError(ERR_USER_ARRAY_IS_EMPTY);
    return (-1);
  }

  if (start < 0 || start >= m_data_total) {
    SetUserError(ERR_USER_ITEM_NOT_FOUND);
    return (-1);
  }

  real_count = (count == WHOLE_ARRAY || start + count > m_data_total)
                   ? m_data_total - start
                   : count;
#ifdef __MQL5__
  return (ArrayMinimum(data, start, real_count));
#else
  return (ArrayMinimum(data, real_count, start));
#endif
}

template <typename T>
int CArray::Maximum(const T &data[], const int start, const int count) const {
  int real_count;

  if (m_data_total < 1) {
    SetUserError(ERR_USER_ARRAY_IS_EMPTY);
    return (-1);
  }

  if (start < 0 || start >= m_data_total) {
    SetUserError(ERR_USER_ITEM_NOT_FOUND);
    return (-1);
  }

  real_count = (count == WHOLE_ARRAY || start + count > m_data_total)
                   ? m_data_total - start
                   : count;
#ifdef __MQL5__
  return (ArrayMaximum(data, start, real_count));
#else
  return (ArrayMaximum(data, real_count, start));
#endif
}

#endif
