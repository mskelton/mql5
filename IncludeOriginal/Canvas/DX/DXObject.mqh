#ifndef DXOBJECT_H
#define DXOBJECT_H
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "DXMath.mqh"
#include "DXObjectBase.mqh"

//--- forward declaration
class CCanvas3D;
//+------------------------------------------------------------------+
//| Class CDXObject                                                  |
//+------------------------------------------------------------------+
class CDXObject : public CDXObjectBase {
public:
  //--- render function
  virtual bool Render(void) = 0;
};
//+------------------------------------------------------------------+

#endif
