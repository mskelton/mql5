#ifndef DXBOX_H
#define DXBOX_H

#include "DXMath.mqh"
#include "DXMesh.mqh"
#include "DXUtils.mqh"

class CDXBox : public CDXMesh {
public:
  CDXBox();
  ~CDXBox();

  bool Create(CDXDispatcher &dispatcher, CDXInput *buffer_scene,
              const DXVector3 &from, const DXVector3 &to);

  bool Update(const DXVector3 &from, const DXVector3 &to);

private:
  void PrepareVertices(const DXVector3 &from, const DXVector3 &to);
};

#endif
