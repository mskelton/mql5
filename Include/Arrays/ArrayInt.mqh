#ifndef ARRAY_INT_H
#define ARRAY_INT_H

#include "Array.mqh"

class CArrayInt : public CArray {
protected:
  int m_data;

public:
  CArrayInt(void);
  ~CArrayInt(void);

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const int element);
  bool AddArray(const int src[]);
  bool AddArray(const CArrayInt *src);
  bool Insert(const int element, const int pos);
  bool InsertArray(const int src[], const int pos);
  bool InsertArray(const CArrayInt *src, const int pos);
  bool AssignArray(const int src[]);
  bool AssignArray(const CArrayInt *src);

  int At(const int index) const;
  int operator[](const int index) const ;

  int Minimum(const int start, const int count) const ;
  int Maximum(const int start, const int count) const ;

  bool Update(const int index, const int element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const int array[]) const;
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



































#endif
