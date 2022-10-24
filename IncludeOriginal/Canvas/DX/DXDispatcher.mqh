#ifndef DXDISPATCHER_H
#define DXDISPATCHER_H

#include "DXBuffers.mqh"
#include "DXData.mqh"
#include "DXInput.mqh"
#include "DXObjectBase.mqh"
#include "DXShader.mqh"
#include "DXTexture.mqh"

class CDXDispatcher : public CDXObjectBase {
protected:
  CDXObjectBase m_dx_resources;

  CDXShader *m_default_vs;
  CDXShader *m_default_ps;

public:
  CDXDispatcher(void);
  ~CDXDispatcher(void);

  bool Create(int context);
  void Destroy(void);

  void Check(void);

  int DXContext(void) const {
    return (m_context);
  }

  CDXShader *ShaderCreateDefault(ENUM_DX_SHADER_TYPE shader_type);
  CDXShader *ShaderCreateFromFile(ENUM_DX_SHADER_TYPE shader_type, string path,
                                  string entry_point);
  CDXShader *ShaderCreateFromSource(ENUM_DX_SHADER_TYPE shader_type,
                                    string source, string entry_point);

  template <typename TVertex>
  CDXVertexBuffer *VertexBufferCreate(const TVertex &vertices[], uint start = 0,
                                      uint count = WHOLE_ARRAY);
  CDXIndexBuffer *IndexBufferCreate(const uint &indicies[], uint start = 0,
                                    uint count = WHOLE_ARRAY);

  template <typename TInput> CDXInput *InputCreate(void);
  CDXTexture *TextureCreateFromFile(string path, uint data_x = 0,
                                    uint data_y = 0, uint data_width = 0,
                                    uint data_height = 0);
  CDXTexture *TextureCreateFromData(ENUM_DX_FORMAT format, uint width,
                                    uint height, const uint &data[],
                                    uint data_x = 0, uint data_y = 0,
                                    uint data_width = 0, uint data_height = 0);

private:
  bool ResourceAdd(CDXObjectBase *resource);

  void ResourcesCheck(void);
};

CDXDispatcher::CDXDispatcher(void) {
}

CDXDispatcher::~CDXDispatcher(void) {
  Destroy();
}

bool CDXDispatcher::Create(int context) {

  if (m_context != INVALID_HANDLE)
    return (false);

  m_context = context;

  return (true);
}

void CDXDispatcher::Destroy(void) {

  if (m_default_ps) {
    m_default_ps.Release();
    m_default_ps = NULL;
  }
  if (m_default_vs) {
    m_default_vs.Release();
    m_default_vs = NULL;
  }

  while (m_dx_resources.Next()) {
    CDXHandleShared *resource = (CDXHandleShared *)m_dx_resources.Next();
    resource.Release();
  }

  m_context = INVALID_HANDLE;
}

void CDXDispatcher::Check(void) {

  CDXHandleShared *resource = (CDXHandleShared *)m_dx_resources.Next();

  while (CheckPointer(resource) != POINTER_INVALID) {
    CDXHandleShared *next = (CDXHandleShared *)resource.Next();

    if (resource.References() <= 1)
      resource.Release();

    resource = next;
  }
}

CDXShader *CDXDispatcher::ShaderCreateDefault(ENUM_DX_SHADER_TYPE shader_type) {
  switch (shader_type) {

  case DX_SHADER_PIXEL: {
    if (m_default_ps == NULL)
      m_default_ps = ShaderCreateFromSource(DX_SHADER_PIXEL,
                                            ExtDefaultShaderPixel, "PSMain");
    return (m_default_ps);
  }

  case DX_SHADER_VERTEX: {
    if (m_default_vs == NULL) {
      m_default_vs = ShaderCreateFromSource(DX_SHADER_VERTEX,
                                            ExtDefaultShaderVertex, "VSMain");
      if (m_default_vs && !m_default_vs.LayoutSet<DXVertex>()) {
        m_default_vs.Release();
        m_default_vs = NULL;
      }
    }
    return (m_default_vs);
  }
  }

  return (NULL);
}

CDXShader *CDXDispatcher::ShaderCreateFromFile(ENUM_DX_SHADER_TYPE shader_type,
                                               string path,
                                               string entry_point) {

  int file = FileOpen(path, FILE_READ);
  if (file == INVALID_HANDLE)
    return (NULL);

  uint size = (uint)FileSize(file);
  FileClose(file);
  if (size > 16 * 1024 * 1024)
    return (NULL);

  char buffer[];
  ArrayResize(buffer, size);

  int read = (int)FileLoad(path, buffer);
  if (read <= 0)
    return (NULL);

  string source = CharArrayToString(buffer, 0, WHOLE_ARRAY, CP_UTF8);

  return (ShaderCreateFromSource(shader_type, source, entry_point));
}

CDXShader *
CDXDispatcher::ShaderCreateFromSource(ENUM_DX_SHADER_TYPE shader_type,
                                      string source, string entry_point) {

  if (m_context == INVALID_HANDLE)
    return (NULL);

  CDXShader *shader = new CDXShader();
  if (shader == NULL)
    return (NULL);

  if (!shader.Create(m_context, shader_type, source, entry_point)) {
    shader.Release();
    return (NULL);
  }

  if (!ResourceAdd(shader)) {
    shader.Release();
    return (NULL);
  }

  return (shader);
}

template <typename TVertex>
CDXVertexBuffer *CDXDispatcher::VertexBufferCreate(const TVertex &vertices[],
                                                   uint start = 0,
                                                   uint count = WHOLE_ARRAY) {

  if (m_context == INVALID_HANDLE)
    return (NULL);

  CDXVertexBuffer *buffer = new CDXVertexBuffer();
  if (buffer == NULL)
    return (NULL);

  if (!buffer.Create(m_context, vertices, start, count)) {
    buffer.Release();
    return (NULL);
  }

  if (!ResourceAdd(buffer)) {
    buffer.Release();
    return (NULL);
  }

  return (buffer);
}

CDXIndexBuffer *CDXDispatcher::IndexBufferCreate(const uint &indicies[],
                                                 uint start = 0,
                                                 uint count = WHOLE_ARRAY) {

  if (m_context == INVALID_HANDLE)
    return (NULL);

  CDXIndexBuffer *buffer = new CDXIndexBuffer();
  if (buffer == NULL)
    return (NULL);

  if (!buffer.Create(m_context, indicies, start, count)) {
    buffer.Release();
    return (NULL);
  }

  if (!ResourceAdd(buffer)) {
    buffer.Release();
    return (NULL);
  }

  return (buffer);
}

template <typename TInput> CDXInput *CDXDispatcher::InputCreate(void) {

  if (m_context == INVALID_HANDLE)
    return (NULL);

  CDXInput *input_buffer = new CDXInput();
  if (input_buffer == NULL)
    return (NULL);

  if (!input_buffer.Create<TInput>(m_context)) {
    input_buffer.Release();
    return (NULL);
  }

  if (!ResourceAdd(input_buffer)) {
    input_buffer.Release();
    return (NULL);
  }

  return (input_buffer);
}

CDXTexture *CDXDispatcher::TextureCreateFromFile(string path, uint data_x = 0,
                                                 uint data_y = 0,
                                                 uint data_width = 0,
                                                 uint data_height = 0) {

  if (m_context == INVALID_HANDLE)
    return (NULL);

  CDXTexture *texture = new CDXTexture();
  if (texture == NULL)
    return (NULL);

  if (!texture.Create(m_context, path, data_x, data_y, data_width,
                      data_height)) {
    texture.Release();
    return (NULL);
  }

  if (!ResourceAdd(texture)) {
    texture.Release();
    return (NULL);
  }

  return (texture);
}

CDXTexture *CDXDispatcher::TextureCreateFromData(
    ENUM_DX_FORMAT format, uint width, uint height, const uint &data[],
    uint data_x = 0, uint data_y = 0, uint data_width = 0,
    uint data_height = 0) {

  if (m_context == INVALID_HANDLE)
    return (NULL);

  CDXTexture *texture = new CDXTexture();
  if (texture == NULL)
    return (NULL);

  if (!texture.Create(m_context, format, width, height, data, data_x, data_y,
                      data_width, data_height)) {
    texture.Release();
    return (NULL);
  }

  if (!ResourceAdd(texture)) {
    texture.Release();
    return (NULL);
  }

  return (texture);
}

bool CDXDispatcher::ResourceAdd(CDXObjectBase *resource) {

  if (!CheckPointer(resource))
    return (false);

  CDXObjectBase *last = &m_dx_resources;
  while (CheckPointer(last.Next()) != POINTER_INVALID) {
    if (last == resource)
      return (false);

    last = last.Next();
  }

  resource.Next(NULL);
  resource.Prev(last);
  last.Next(resource);
  return (true);
}

#endif
