#ifndef ARRAY_FLOAT_H
#define ARRAY_FLOAT_H

#include "Array.mqh"

class CArrayFloat : public CArray {
protected:
  float m_data;
  float m_delta;

public:
  CArrayFloat(void);
  ~CArrayFloat(void);

  void Delta(const float delta) ;

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const float element);
  bool AddArray(const float src[]);
  bool AddArray(const CArrayFloat *src);
  bool Insert(const float element, const int pos);
  bool InsertArray(const float src[], const int pos);
  bool InsertArray(const CArrayFloat *src, const int pos);
  bool AssignArray(const float src[]);
  bool AssignArray(const CArrayFloat *src);

  float At(const int index) const;
  float operator[](const int index) const ;

  int Minimum(const int start, const int count) const ;
  int Maximum(const int start, const int count) const ;

  bool Update(const int index, const float element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const float array[]) const;
  bool CompareArray(const CArrayFloat *array) const;

  bool InsertSort(const float element);
  int Search(const float element) const;
  int SearchGreat(const float element) const;
  int SearchLess(const float element) const;
  int SearchGreatOrEqual(const float element) const;
  int SearchLessOrEqual(const float element) const;
  int SearchFirst(const float element) const;
  int SearchLast(const float element) const;
  int SearchLinear(const float element) const;

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0);
  int QuickSearch(const float element) const;
  int MemMove(const int dest, const int src, int count);
};



































#endif
