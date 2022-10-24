#ifndef DXHANDLE_H
#define DXHANDLE_H

#include "DXObjectBase.mqh"

class CDXHandle : public CDXObjectBase {
protected:
  int m_handle;

protected:
  CDXHandle(void);
  virtual ~CDXHandle(void);

public:
  int Handle(void) const {
    return (m_handle);
  }
};

CDXHandle::CDXHandle(void) : m_handle(-1) {
}

CDXHandle::~CDXHandle(void) {
  if (m_handle != -1) {
    DXRelease(m_handle);
    m_handle = -1;
  }
}

class CDXHandleShared : public CDXHandle {
protected:
  ulong m_references;

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

CDXHandleShared::CDXHandleShared(void) : m_references(1) {
}

CDXHandleShared::~CDXHandleShared(void) {

#ifdef _DEBUG
  if (m_references) {
    Alert("CDXHandleShared object was deleted with non-zero references count!");
    DebugBreak();
  }
#endif
}

ulong CDXHandleShared::AddRef(void) {

  return (++m_references);
}

ulong CDXHandleShared::References(void) {

  return (m_references);
}

ulong CDXHandleShared::Release(void) {
  if (!m_references)
    return (0);

  m_references--;

  if (!m_references) {
    delete &this;
    return (0);
  }

  return (m_references);
}

#endif
