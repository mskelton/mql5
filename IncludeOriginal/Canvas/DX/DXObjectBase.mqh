#ifndef DXOBJECT_BASE_H
#define DXOBJECT_BASE_H

#include <Object.mqh>

class CDXObjectBase : public CObject {
protected:
  int m_context;

public:
  virtual ~CDXObjectBase(void) {
    CObject *next = Next();
    CObject *prev = Prev();

    if (CheckPointer(next))
      next.Prev(prev);
    if (CheckPointer(prev))
      prev.Next(next);
  }
};

#endif
