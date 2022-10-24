#ifndef ARRAY_OBJ_H
#define ARRAY_OBJ_H

#include "Array.mqh"

class CArrayObj : public CArray {
protected:
  CObject *m_data;
  bool m_free_mode;

public:
  CArrayObj(void);
  ~CArrayObj(void);

  bool FreeMode(void) const;
  void FreeMode(const bool mode);

  virtual int Type(void) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  virtual bool CreateElement(const int index);

  bool Reserve(const int size);
  bool Resize(const int size);
  bool Shutdown(void);

  bool Add(CObject *element);
  bool AddArray(const CArrayObj *src);
  bool Insert(CObject *element, const int pos);
  bool InsertArray(const CArrayObj *src, const int pos);
  bool AssignArray(const CArrayObj *src);

  CObject *At(const int index) const;

  bool Update(const int index, CObject *element);
  bool Shift(const int index, const int shift);

  CObject *Detach(const int index);
  bool Delete(const int index);
  bool DeleteRange(int from, int to);
  void Clear(void);

  bool CompareArray(const CArrayObj *array) const;

  bool InsertSort(CObject *element);
  int Search(const CObject *element) const;
  int SearchGreat(const CObject *element) const;
  int SearchLess(const CObject *element) const;
  int SearchGreatOrEqual(const CObject *element) const;
  int SearchLessOrEqual(const CObject *element) const;
  int SearchFirst(const CObject *element) const;
  int SearchLast(const CObject *element) const;

protected:
  void QuickSort(int beg, int end, const int mode);
  int QuickSearch(const CObject *element) const;
  int MemMove(const int dest, const int src, int count);
};

#endif
