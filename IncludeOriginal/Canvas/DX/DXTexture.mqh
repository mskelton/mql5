#ifndef DXTEXTURE_H
#define DXTEXTURE_H
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "DXHandle.mqh"
#include <Canvas\Canvas.mqh>
//+------------------------------------------------------------------+
//| Class CDXTexture                                                 |
//+------------------------------------------------------------------+
class CDXTexture : public CDXHandleShared {
public:
  //+------------------------------------------------------------------+
  //| Destructor                                                       |
  //+------------------------------------------------------------------+
  virtual ~CDXTexture(void) {
    Shutdown();
  }
  //+------------------------------------------------------------------+
  //| Create a new texture from bitmap file                            |
  //+------------------------------------------------------------------+
  bool Create(int context, string path, uint data_x = 0, uint data_y = 0,
              uint data_width = 0, uint data_height = 0) {
    uint data[];
    uint width, height;
    //--- load image data
    if (StringFind(path, "::") == 0) {
      //--- load from resource
      if (!ResourceReadImage(path, data, width, height))
        return (false);
    } else {
      //--- load from file
      uint w, h;
      if (!CCanvas::LoadBitmap(path, data, w, h))
        return (false);
      //--- save unsigned dimensions
      width = (uint)w;
      height = (uint)h;
    }
    //--- create texture from bitmap data
    return (Create(context, DX_FORMAT_B8G8R8A8_UNORM, width, height, data,
                   data_x, data_y, data_width, data_height));
  }
  //+------------------------------------------------------------------+
  //| Create a new texture, only 32-bit pixel formats supported        |
  //+------------------------------------------------------------------+
  bool Create(int context, ENUM_DX_FORMAT format, uint width, uint height,
              const uint &data[], uint data_x = 0, uint data_y = 0,
              uint data_width = 0, uint data_height = 0) {
    //--- check dimensions
    if (width < data_x + data_width || height < data_y + data_height)
      return (false);
    //--- shutdown texture
    Shutdown();
    //--- save new context
    m_context = context;
    //---
    if (data_width == 0)
      data_width = width - data_x;
    if (data_height == 0)
      data_height = height - data_y;
    //--- create new texture
    m_handle = DXTextureCreate(context, format, width, height, data, data_x,
                               data_y, data_width, data_height);
    return (m_handle != INVALID_HANDLE);
  }
  //+------------------------------------------------------------------+
  //| Shutdown                                                         |
  //+------------------------------------------------------------------+
  virtual void Shutdown(void) {
    //--- relase handle
    if (m_handle != INVALID_HANDLE)
      DXRelease(m_handle);
    m_handle = INVALID_HANDLE;
  }
};
//+------------------------------------------------------------------+

#endif
