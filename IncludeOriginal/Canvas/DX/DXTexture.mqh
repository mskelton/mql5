#ifndef DXTEXTURE_H
#define DXTEXTURE_H

#include "DXHandle.mqh"
#include <Canvas\Canvas.mqh>

class CDXTexture : public CDXHandleShared {
public:
  virtual ~CDXTexture(void) {
    Shutdown();
  }

  bool Create(int context, string path, uint data_x = 0, uint data_y = 0,
              uint data_width = 0, uint data_height = 0) {
    uint data[];
    uint width, height;

    if (StringFind(path, "::") == 0) {

      if (!ResourceReadImage(path, data, width, height))
        return (false);
    } else {

      uint w, h;
      if (!CCanvas::LoadBitmap(path, data, w, h))
        return (false);

      width = (uint)w;
      height = (uint)h;
    }

    return (Create(context, DX_FORMAT_B8G8R8A8_UNORM, width, height, data,
                   data_x, data_y, data_width, data_height));
  }

  bool Create(int context, ENUM_DX_FORMAT format, uint width, uint height,
              const uint &data[], uint data_x = 0, uint data_y = 0,
              uint data_width = 0, uint data_height = 0) {

    if (width < data_x + data_width || height < data_y + data_height)
      return (false);

    Shutdown();

    m_context = context;

    if (data_width == 0)
      data_width = width - data_x;
    if (data_height == 0)
      data_height = height - data_y;

    m_handle = DXTextureCreate(context, format, width, height, data, data_x,
                               data_y, data_width, data_height);
    return (m_handle != INVALID_HANDLE);
  }

  virtual void Shutdown(void) {

    if (m_handle != INVALID_HANDLE)
      DXRelease(m_handle);
    m_handle = INVALID_HANDLE;
  }
};

#endif
