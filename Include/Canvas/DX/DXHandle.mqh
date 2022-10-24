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
  int Handle(void) const ;
};



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

  bool operator!(void) const ;
};






#endif
