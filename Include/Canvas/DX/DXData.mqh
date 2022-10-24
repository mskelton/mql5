#ifndef DXDATA_H
#define DXDATA_H

#include "DXMath.mqh"

struct DXVertex {
  DXVector4 position;
  DXVector4 normal;
  DXVector2 tcoord;
  DXColor vcolor;
  static const DXVertexLayout s_layout[4];
};
struct DXInputScene {

  struct DXInputObject {
    DXMatrix transform;
    DXColor diffuse_color;
    DXColor emission_color;
    DXColor specular_color;
    float specular_power;
    float dummy[3];
  };
};

#endif
