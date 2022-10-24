#ifndef ARRAY_STRING_H
#define ARRAY_STRING_H

#include "Array.mqh"

class CArrayString : public CArray {
protected:
  string m_data;

public:
  CArrayString(void);
  ~CArrayString(void);

  virtual int Type(void) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(const string element);
  bool AddArray(const string src[]);
  bool AddArray(const CArrayString *src);
  bool Insert(const string element, const int pos);
  bool InsertArray(const string src[], const int pos);
  bool InsertArray(const CArrayString *src, const int pos);
  bool AssignArray(const string src[]);
  bool AssignArray(const CArrayString *src);

  string At(const int index) const;
  string operator[](const int index) const;

  bool Update(const int index, const string element);
  bool Shift(const int index, const int shift);

  bool Delete(const int index);
  bool DeleteRange(int from, int to);

  bool CompareArray(const string array[]) const;
  bool CompareArray(const CArrayString *array) const;

  bool InsertSort(const string element);
  int Search(const string element) const;
  int SearchGreat(const string element) const;
  int SearchLess(const string element) const;
  int SearchGreatOrEqual(const string element) const;
  int SearchLessOrEqual(const string element) const;
  int SearchFirst(const string element) const;
  int SearchLast(const string element) const;
  int SearchLinear(const string element) const;

protected:
  virtual void QuickSort(int beg, int end, const int mode = 0);
  int QuickSearch(const string element) const;
  int MemMove(const int dest, const int src, int count);
};

#endif
