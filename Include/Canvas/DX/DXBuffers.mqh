#ifndef DXBUFFERS_H
#define DXBUFFERS_H

#include "DXHandle.mqh"

class CDXVertexBuffer : public CDXHandleShared {
public:
  virtual ~CDXVertexBuffer(void);

  template <typename TVertex>
  bool Create(int context_handle, const TVertex vertices[], uint start = 0,
              uint count = WHOLE_ARRAY);

  bool Render(uint start = 0, uint count = WHOLE_ARRAY);

  void Shutdown(void);
};

class CDXIndexBuffer : public CDXHandleShared {
public:
  virtual ~CDXIndexBuffer(void);

  bool Create(int context_handle, const uint indices[], uint start = 0,
              uint count = WHOLE_ARRAY);

  bool Render(uint start = 0, uint count = WHOLE_ARRAY);

  void Shutdown(void);
};

#endif
