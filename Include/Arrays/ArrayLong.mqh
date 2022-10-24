#ifndef ARRAY_LONG_H
#define ARRAY_LONG_H

#include "Array.mqh"

class CArrayLong : public CArray {
protected:
  long m_data;

public:
  CArrayLong(void);
  ~CArrayLong(void);

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const long element);
  bool AddArray(const long src[]);
  bool AddArray(const CArrayLong *src);
  bool Insert(const long element, const int pos);
  bool InsertArray(const long src[], const int pos);
  bool InsertArray(const CArrayLong *src, const int pos);
  bool AssignArray(const long src[]);
  bool AssignArray(const CArrayLong *src);

  long At(const int index) const;
  long operator[](const int index) const ;

  int Minimum(const int start, const int count) const ;
  int Maximum(const int start, const int count) const ;

  bool Update(const int index, const long element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const long array[]) const;
  bool CompareArray(const CArrayLong *array) const;

  bool InsertSort(const long element);
  int Search(const long element) const;
  int SearchGreat(const long element) const;
  int SearchLess(const long element) const;
  int SearchGreatOrEqual(const long element) const;
  int SearchLessOrEqual(const long element) const;
  int SearchFirst(const long element) const;
  int SearchLast(const long element) const;
  int SearchLinear(const long element) const;

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0);
  int QuickSearch(const long element) const;
  int MemMove(const int dest, const int src, int count);
};



































#endif
