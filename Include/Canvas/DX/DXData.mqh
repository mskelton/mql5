#ifndef DXDATA_H
#define DXDATA_H

#include "DXEnums.mqh"
#include "DXMath.mqh"

struct DXVertexLayout {
  /**
   * The HLSL semantic associated with this element in a shader input-signature.
   */
  string semantic_name;
  /**
   * The semantic index for the element. A semantic index modifies a semantic,
   * with an integer index number. A semantic index is only needed in a case
   * where there is more than one element with the same semantic
   */
  uint semantic_index;
  /**
   * The data type of the element data.
   */
  ENUM_DX_FORMAT format;
};

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
