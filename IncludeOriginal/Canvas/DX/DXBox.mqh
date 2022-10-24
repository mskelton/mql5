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

void CDXBox::CDXBox() : CDXMesh() {}

void CDXBox::~CDXBox(void) {}

bool CDXBox::Create(CDXDispatcher &dispatcher, CDXInput *buffer_scene,
                    const DXVector3 &from, const DXVector3 &to) {

  Shutdown();

  DXVertex vertices[];
  uint indices[];

  DXColor white = DXColor(1.0f, 1.0f, 1.0f, 1.0f);
  if (!DXComputeBox(from, to, vertices, indices))
    return (false);
  for (int i = 0; i < ArraySize(vertices); i++)
    vertices[i].vcolor = white;

  return (CDXMesh::Create(dispatcher, buffer_scene, vertices, indices));
}

bool CDXBox::Update(const DXVector3 &from, const DXVector3 &to) {

  DXVertex vertices[];
  uint indices[];

  DXColor white = DXColor(1.0f, 1.0f, 1.0f, 1.0f);
  if (!DXComputeBox(from, to, vertices, indices))
    return (false);
  for (int i = 0; i < ArraySize(vertices); i++)
    vertices[i].vcolor = white;

  return (CDXMesh::VerticesSet(vertices));
}

#endif
