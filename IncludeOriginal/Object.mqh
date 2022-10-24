#ifndef OBJECT_H
#define OBJECT_H

#include "StdLibErr.mqh"

class CObject {
private:
  CObject *m_prev;
  CObject *m_next;

public:
  CObject(void) : m_prev(NULL), m_next(NULL) {
  }
  ~CObject(void) {
  }

  CObject *Prev(void) const {
    return (m_prev);
  }
  void Prev(CObject *node) {
    m_prev = node;
  }
  CObject *Next(void) const {
    return (m_next);
  }
  void Next(CObject *node) {
    m_next = node;
  }

  virtual bool Save(const int file_handle) {
    return (true);
  }
  virtual bool Load(const int file_handle) {
    return (true);
  }

  virtual int Type(void) const {
    return (0);
  }

  virtual int Compare(const CObject *node, const int mode = 0) const {
    return (0);
  }
};

#endif
