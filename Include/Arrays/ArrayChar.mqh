#ifndef ARRAY_CHAR_H
#define ARRAY_CHAR_H

#include "Array.mqh"

class CArrayChar : public CArray {
protected:
  char m_data;

public:
  CArrayChar(void);
  ~CArrayChar(void);

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const char element);
  bool AddArray(const char src[]);
  bool AddArray(const CArrayChar *src);
  bool Insert(const char element, const int pos);
  bool InsertArray(const char src[], const int pos);
  bool InsertArray(const CArrayChar *src, const int pos);
  bool AssignArray(const char src[]);
  bool AssignArray(const CArrayChar *src);

  char At(const int index) const;
  char operator[](const int index) const ;

  int Minimum(const int start, const int count) const ;
  int Maximum(const int start, const int count) const ;

  bool Update(const int index, const char element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const char array[]) const;
  bool CompareArray(const CArrayChar *array) const;

  bool InsertSort(const char element);
  int Search(const char element) const;
  int SearchGreat(const char element) const;
  int SearchLess(const char element) const;
  int SearchGreatOrEqual(const char element) const;
  int SearchLessOrEqual(const char element) const;
  int SearchFirst(const char element) const;
  int SearchLast(const char element) const;
  int SearchLinear(const char element) const;

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0);
  int QuickSearch(const char element) const;
  int MemMove(const int dest, const int src, int count);
};



































#endif
