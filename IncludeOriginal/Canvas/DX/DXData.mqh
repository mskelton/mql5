#ifndef DXDATA_H
#define DXDATA_H
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "DXMath.mqh"
//+------------------------------------------------------------------+
//| DXVertex                                                         |
//+------------------------------------------------------------------+
struct DXVertex {
  DXVector4 position;
  DXVector4 normal;
  DXVector2 tcoord;
  DXColor vcolor;
  static const DXVertexLayout s_layout[4];
};
const DXVertexLayout DXVertex::s_layout[4] = {
    {"POSITION", 0, DX_FORMAT_R32G32B32A32_FLOAT},
    {"NORMAL", 0, DX_FORMAT_R32G32B32A32_FLOAT},
    {"TEXCOORD", 0, DX_FORMAT_R32G32_FLOAT},
    {"COLOR", 0, DX_FORMAT_R32G32B32A32_FLOAT}};
//+------------------------------------------------------------------+
//| DXInputScene                                                     |
//+------------------------------------------------------------------+
struct DXInputScene {
  DXMatrix view;
  DXMatrix projection;
  DXVector4 light_direction;
  DXColor light_color;
  DXColor ambient_color;
};
//+------------------------------------------------------------------+
//| DXInputObject                                                    |
//+------------------------------------------------------------------+
struct DXInputObject {
  DXMatrix transform;
  DXColor diffuse_color;
  DXColor emission_color;
  DXColor specular_color;
  float specular_power;
  float dummy[3];
};
//+------------------------------------------------------------------+

#endif
