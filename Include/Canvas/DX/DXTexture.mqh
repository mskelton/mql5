#ifndef DXTEXTURE_H
#define DXTEXTURE_H

#include "DXHandle.mqh"
#include <Canvas/Canvas.mqh>

class CDXTexture : public CDXHandleShared {
public:
  virtual ~CDXTexture(void);

  bool Create(int context, string path, uint data_x = 0, uint data_y = 0,
              uint data_width = 0, uint data_height = 0);

  bool Create(int context, ENUM_DX_FORMAT format, uint width, uint height,
              const uint data[], uint data_x = 0, uint data_y = 0,
              uint data_width = 0, uint data_height = 0);

  virtual void Shutdown(void);
};

#endif
