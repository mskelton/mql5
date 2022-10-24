#ifndef DXOBJECT_BASE_H
#define DXOBJECT_BASE_H

#include <Object.mqh>

class CDXObjectBase : public CObject {
protected:
  int m_context;

public:
  virtual ~CDXObjectBase(void);
};

#endif
