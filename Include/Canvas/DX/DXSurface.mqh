#ifndef DXSURFACE_H
#define DXSURFACE_H

#include "DXMath.mqh"
#include "DXMesh.mqh"
#include "DXUtils.mqh"

class CDXSurface : public CDXMesh {
public:
  enum EN_SURFACE_FLAGS {
    SF_NONE = 0x0,
    SF_TWO_SIDED = 0x1,
    SF_USE_NORMALS = 0x2,
  };

  enum EN_COLOR_SCHEME {
    CS_NONE = 0,
    CS_JET = 1,
    CS_COLD_TO_HOT = 2,
    CS_RED_TO_GREEN = 3
  };

protected:
  uint m_data_width;
  uint m_data_height;
  uint m_flags;
  EN_COLOR_SCHEME m_color_scheme;

public:
  CDXSurface();
  ~CDXSurface();

  bool Create(CDXDispatcher &dispatcher, CDXInput *buffer_scene, double data[],
              uint m_data_widht, uint m_data_height, float data_range,
              const DXVector3 &from, const DXVector3 &to,
              DXVector2 &texture_size, uint flags = SF_NONE,
              EN_COLOR_SCHEME color_scheme = CS_NONE);

  bool Update(double data[], uint m_data_widht, uint m_data_height,
              float data_range, const DXVector3 &from, const DXVector3 &to,
              DXVector2 &texture_size, uint flags = 0,
              EN_COLOR_SCHEME color_scheme = CS_NONE);

private:
  void PrepareColors(DXVertex vertices[], const DXVector3 &from,
                     const DXVector3 &to);
};

#endif
