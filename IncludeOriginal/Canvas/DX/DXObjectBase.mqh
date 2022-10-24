#ifndef DXOBJECT_BASE_H
#define DXOBJECT_BASE_H
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <Object.mqh>
//+------------------------------------------------------------------+
//| Class CDXObjectBase                                              |
//+------------------------------------------------------------------+
class CDXObjectBase : public CObject {
protected:
  int m_context;

public:
  virtual ~CDXObjectBase(void) {
    CObject *next = Next();
    CObject *prev = Prev();
    //--- exclude themself from a list
    if (CheckPointer(next))
      next.Prev(prev);
    if (CheckPointer(prev))
      prev.Next(next);
  }
};
//+------------------------------------------------------------------+

#endif
