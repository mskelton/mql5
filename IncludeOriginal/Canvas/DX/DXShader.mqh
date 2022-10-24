#ifndef DXSHADER_H
#define DXSHADER_H

#include "DXHandle.mqh"
#include "DXInput.mqh"
#include "DXTexture.mqh"

#define DX_SHADER_INPUTS_MAX 14

class CDXShader : public CDXHandleShared {
protected:
  ENUM_DX_SHADER_TYPE m_type;

  CDXInput *m_inputs[];
  CDXTexture *m_textures[];

public:
  virtual ~CDXShader(void) {
    Shutdown();
  }

  bool Create(int context, ENUM_DX_SHADER_TYPE shader_type, string source,
              string entry_point) {

    Shutdown();

    m_context = context;

    if (m_context == INVALID_HANDLE)
      return (false);

    m_type = shader_type;

    string error = "";
    m_handle = DXShaderCreate(m_context, m_type, source, entry_point, error);
    if (m_handle == INVALID_HANDLE)
      return (false);

    return (true);
  }

  template <typename TVertex> bool LayoutSet(void) {

    if (m_handle == INVALID_HANDLE)
      return (false);

    if (m_type != DX_SHADER_VERTEX)
      return (false);

    return (DXShaderSetLayout(m_handle, TVertex::s_layout));
  }

  bool InputSet(int index, CDXInput *dx_input) {

    if (index >= DX_SHADER_INPUTS_MAX ||
        CheckPointer(dx_input) == POINTER_INVALID ||
        dx_input.Handle() == INVALID_HANDLE)
      return (false);

    int count = ArraySize(m_inputs);
    if (index < count && CheckPointer(m_inputs[index]) != POINTER_INVALID &&
        m_inputs[index].Handle() == dx_input.Handle())
      return (true);

    if (index >= count)
      ArrayResize(m_inputs, index + 1);
    for (int i = count; i <= index; i++)
      m_inputs[i] = NULL;

    if (m_inputs[index])
      m_inputs[index].Release();

    m_inputs[index] = dx_input;
    dx_input.AddRef();

    return (true);
  }

  bool TextureSet(int index, CDXTexture *texture) {

    if (m_type != DX_SHADER_PIXEL || index >= DX_SHADER_INPUTS_MAX ||
        CheckPointer(texture) == POINTER_INVALID ||
        texture.Handle() == INVALID_HANDLE)
      return (false);

    int count = ArraySize(m_textures);
    if (index < count && CheckPointer(m_textures[index]) != POINTER_INVALID &&
        m_textures[index].Handle() == texture.Handle())
      return (true);

    if (index >= count)
      ArrayResize(m_textures, index + 1);
    for (int i = count; i <= index; i++)
      m_textures[i] = NULL;

    if (m_textures[index])
      m_textures[index].Release();

    m_textures[index] = texture;
    texture.AddRef();

    return (true);
  }

  void TexturesClear() {

    for (int i = 0; i < ArraySize(m_textures); i++)
      if (m_textures[i])
        m_textures[i].Release();
    ArrayFree(m_textures);
  }

  virtual bool Render(void) {

    if (m_context == INVALID_HANDLE || m_handle == INVALID_HANDLE)
      return (false);

    if (!UpdateInputs())
      return (false);

    return (DXShaderSet(m_context, m_handle));
  }

  virtual void Shutdown(void) {

    if (m_handle != INVALID_HANDLE)
      DXRelease(m_handle);
    m_handle = INVALID_HANDLE;

    for (int i = 0; i < ArraySize(m_inputs); i++)
      if (m_inputs[i])
        m_inputs[i].Release();

    for (int i = 0; i < ArraySize(m_textures); i++)
      if (m_textures[i])
        m_textures[i].Release();
    ArrayFree(m_textures);
  }

private:
  bool UpdateInputs(void) {
    int handles[];

    int count = ArraySize(m_inputs);
    if (count > 0) {
      ArrayResize(handles, count);

      for (int i = 0; i < count; i++)
        if (m_inputs[i])
          handles[i] = m_inputs[i].Handle();
        else
          handles[i] = INVALID_HANDLE;
    } else
      ArrayFree(handles);

    if (!DXShaderInputsSet(m_handle, handles))
      return (false);

    if (m_type == DX_SHADER_PIXEL) {
      count = ArraySize(m_textures);
      if (count > 0) {
        ArrayResize(handles, count);

        for (int i = 0; i < count; i++)
          if (m_textures[i])
            handles[i] = m_textures[i].Handle();
          else
            handles[i] = INVALID_HANDLE;
      } else
        ArrayFree(handles);
      ResetLastError();

      if (!DXShaderTexturesSet(m_handle, handles))
        return (false);
    }

    return (true);
  }
};

#endif
