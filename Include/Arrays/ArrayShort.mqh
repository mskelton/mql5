#ifndef ARRAY_SHORT_H
#define ARRAY_SHORT_H

#include "Array.mqh"

class CArrayShort : public CArray {
protected:
  short m_data;

public:
  CArrayShort(void);
  ~CArrayShort(void);

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const short element);
  bool AddArray(const short src[]);
  bool AddArray(const CArrayShort *src);
  bool Insert(const short element, const int pos);
  bool InsertArray(const short src[], const int pos);
  bool InsertArray(const CArrayShort *src, const int pos);
  bool AssignArray(const short src[]);
  bool AssignArray(const CArrayShort *src);

  short At(const int index) const;
  short operator[](const int index) const ;

  int Minimum(const int start, const int count) const ;
  int Maximum(const int start, const int count) const ;

  bool Update(const int index, const short element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const short array[]) const;
  bool CompareArray(const CArrayShort *array) const;

  bool InsertSort(const short element);
  int Search(const short element) const;
  int SearchGreat(const short element) const;
  int SearchLess(const short element) const;
  int SearchGreatOrEqual(const short element) const;
  int SearchLessOrEqual(const short element) const;
  int SearchFirst(const short element) const;
  int SearchLast(const short element) const;
  int SearchLinear(const short element) const;

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0);
  int QuickSearch(const short element) const;
  int MemMove(const int dest, const int src, int count);
};



































#endif
