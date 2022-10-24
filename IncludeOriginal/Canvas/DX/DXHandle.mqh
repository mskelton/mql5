#ifndef DXHANDLE_H
#define DXHANDLE_H
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "DXObjectBase.mqh"

//+------------------------------------------------------------------+
//| Class CDXHandle                                                  |
//+------------------------------------------------------------------+
class CDXHandle : public CDXObjectBase {
protected:
  int m_handle; // DX handle

protected:
  CDXHandle(void);
  virtual ~CDXHandle(void);

public:
  int Handle(void) const {
    return (m_handle);
  }
};
//+------------------------------------------------------------------+
//| CDXHandle constructor                                            |
//+------------------------------------------------------------------+
CDXHandle::CDXHandle(void) : m_handle(-1) {
}
//+------------------------------------------------------------------+
//| CDXHandle destructor                                             |
//+------------------------------------------------------------------+
CDXHandle::~CDXHandle(void) {
  if (m_handle != -1) {
    DXRelease(m_handle);
    m_handle = -1;
  }
}
//+------------------------------------------------------------------+
//| Class CDXHandleShared                                            |
//+------------------------------------------------------------------+
class CDXHandleShared : public CDXHandle {
protected:
  ulong m_references; // reference count to the shared object

protected:
  virtual ~CDXHandleShared(void);

public:
  CDXHandleShared(void);

  virtual ulong AddRef(void);
  virtual ulong References(void);
  virtual ulong Release(void);

  bool operator!(void) const {
    return (m_handle == INVALID_HANDLE);
  }
};
//+------------------------------------------------------------------+
//| CDXHandleShared constructor                                      |
//+------------------------------------------------------------------+
CDXHandleShared::CDXHandleShared(void) : m_references(1) {
}
//+------------------------------------------------------------------+
//| CDXHandleShared destructor                                       |
//+------------------------------------------------------------------+
CDXHandleShared::~CDXHandleShared(void) {
//--- check reference count for the debuging reason
#ifdef _DEBUG
  if (m_references) {
    Alert("CDXHandleShared object was deleted with non-zero references count!");
    DebugBreak();
  }
#endif
}
//+------------------------------------------------------------------+
//| Add reference to the shared object                               |
//+------------------------------------------------------------------+
ulong CDXHandleShared::AddRef(void) {
  //--- return new reference count for the debugging reason
  return (++m_references);
}
//+------------------------------------------------------------------+
//| Get references count to the shared object                        |
//+------------------------------------------------------------------+
ulong CDXHandleShared::References(void) {
  //--- return new reference count for the debugging reason
  return (m_references);
}
//+------------------------------------------------------------------+
//| Remove reference from the shared object                          |
//+------------------------------------------------------------------+
ulong CDXHandleShared::Release(void) {
  if (!m_references)
    return (0);
  //---
  m_references--;
  //--- delete shared object if there no any references
  if (!m_references) {
    delete &this;
    return (0);
  }
  //--- return new reference count for the debugging reason
  return (m_references);
}
//+------------------------------------------------------------------+

#endif
