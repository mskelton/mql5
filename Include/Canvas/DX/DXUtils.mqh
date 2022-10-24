#ifndef DXUTILS_H
#define DXUTILS_H

#include "DXData.mqh"
#include "DXMath.mqh"

#define OBJ_DATA_UNKNOWN 0
#define OBJ_DATA_V 1
#define OBJ_DATA_VT 2
#define OBJ_DATA_VN 3
#define OBJ_DATA_F 4

struct OBJFaceType {
  int total;
  int v[4];
  int t[4];
  int n[4];
};

template <typename TVertex>
void DXInverseWinding(TVertex vertices[], uint indices[]) ;

bool DXLoadObjData(const string filename, DXVector4 v_positions[],
                   DXVector2 v_tcoords[], DXVector4 v_normals[],
                   OBJFaceType faces[], bool show_debug = false) ;

template <typename TVertex>
bool DXLoadObjModel(const string filename, TVertex vertices[], uint indices[],
                    float scale = 1.0f) ;

template <typename TVertex>
bool DXComputeBox(const DXVector3 &from, const DXVector3 &to,
                  TVertex vertices[], uint indices[]) ;

template <typename TVertex>
bool DXComputeSphere(float radius, uint tessellation, TVertex vertices[],
                     uint indices[]) ;

template <typename TVertex>
bool DXComputeTorus(float outer_radius, float inner_radius, uint tessellation,
                    TVertex vertices[], uint indices[]) ;

template <typename TVertex>
bool DXComputeCylinder(float radius, float height, uint tessellation,
                       TVertex vertices[], uint indices[]) ;

template <typename TVertex>
bool DXComputeTruncatedCone(float radius_top, float radius_bottom, float height,
                            uint tessellation, TVertex vertices[],
                            uint indices[]) ;

template <typename TVertex>
bool DXComputeCone(float radius, float height, uint tessellation,
                   TVertex vertices[], uint indices[]) ;

template <typename TVertex>
bool DXComputeSurface(double data[], uint data_width, uint data_height,
                      double data_range, const DXVector3 &from,
                      const DXVector3 &to, DXVector2 &texture_size,
                      bool two_sided, bool use_normals, TVertex vertices[],
                      uint indices[]) ;

void DXComputeColorJet(const float value, DXColor &cout) ;

void DXComputeColorColdToHot(const float value, DXColor &cout) ;

void DXComputeColorRedToGreen(const float value, DXColor &cout) ;

#endif
