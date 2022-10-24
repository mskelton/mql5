#ifndef OBJECT_H
#define OBJECT_H

#include "StdLibErr.mqh"

class CObject {
private:
  CObject *m_prev;
  CObject *m_next;

public:
  CObject(void);
  ~CObject(void);

  CObject *Prev(void) const;
  void Prev(CObject *node);
  CObject *Next(void) const;
  void Next(CObject *node);

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

  virtual int Type(void) const;

  virtual int Compare(const CObject *node, const int mode = 0) const;
};

#endif
