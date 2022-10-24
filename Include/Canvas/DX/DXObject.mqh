#ifndef DXOBJECT_H
#define DXOBJECT_H

#include "DXMath.mqh"
#include "DXObjectBase.mqh"

class CCanvas3D;

class CDXObject : public CDXObjectBase {
public:
  virtual bool Render(void) = 0;
};

#endif
