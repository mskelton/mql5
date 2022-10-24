#ifndef ARRAY_DOUBLE_H
#define ARRAY_DOUBLE_H

#include "Array.mqh"

class CArrayDouble : public CArray {
protected:
  double m_data;
  double m_delta;

public:
  CArrayDouble(void);
  ~CArrayDouble(void);

  void Delta(const double delta) ;

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const double element);
  bool AddArray(const double src[]);
  bool AddArray(const CArrayDouble *src);
  bool Insert(const double element, const int pos);
  bool InsertArray(const double src[], const int pos);
  bool InsertArray(const CArrayDouble *src, const int pos);
  bool AssignArray(const double src[]);
  bool AssignArray(const CArrayDouble *src);

  double At(const int index) const;
  double operator[](const int index) const ;

  int Minimum(const int start, const int count) const ;
  int Maximum(const int start, const int count) const ;

  bool Update(const int index, const double element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const double array[]) const;
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



































#endif
