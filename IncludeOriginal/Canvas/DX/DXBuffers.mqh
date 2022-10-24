#ifndef DXBUFFERS_H
#define DXBUFFERS_H

#include "DXHandle.mqh"

class CDXVertexBuffer : public CDXHandleShared {
public:
  virtual ~CDXVertexBuffer(void) {
    Shutdown();
  }

  template <typename TVertex>
  bool Create(int context_handle, const TVertex &vertices[], uint start = 0,
              uint count = WHOLE_ARRAY) {
    Shutdown();
    m_context = context_handle;
    m_handle =
        DXBufferCreate(m_context, DX_BUFFER_VERTEX, vertices, start, count);
    return (m_handle != INVALID_HANDLE);
  }

  bool Render(uint start = 0, uint count = WHOLE_ARRAY) {
    return (DXBufferSet(m_context, m_handle, start, count));
  }

  void Shutdown(void) {

    if (m_handle != INVALID_HANDLE)
      DXRelease(m_handle);
    m_handle = INVALID_HANDLE;
  }
};

class CDXIndexBuffer : public CDXHandleShared {
public:
  virtual ~CDXIndexBuffer(void) {
    Shutdown();
  }

  bool Create(int context_handle, const uint &indices[], uint start = 0,
              uint count = WHOLE_ARRAY) {
    Shutdown();
    m_context = context_handle;
    m_handle =
        DXBufferCreate(m_context, DX_BUFFER_INDEX, indices, start, count);
    return (m_handle != INVALID_HANDLE);
  }

  bool Render(uint start = 0, uint count = WHOLE_ARRAY) {
    return (DXBufferSet(m_context, m_handle, start, count));
  }

  void Shutdown(void) {

    if (m_handle != INVALID_HANDLE)
      DXRelease(m_handle);
    m_handle = INVALID_HANDLE;
  }
};

#endif
