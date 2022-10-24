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

  int Step(void) const ;
  bool Step(const int step);
  int Total(void) const ;
  int Available(void) const ;
  int Max(void) const ;
  bool IsSorted(const int mode = 0) const ;
  int SortMode(void) const ;

  void Clear(void) ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  void Sort(const int mode = 0);

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0) ;

  template <typename T>
  int Minimum(const T data[], const int start, const int count) const;
  template <typename T>
  int Maximum(const T data[], const int start, const int count) const;
};









#endif
