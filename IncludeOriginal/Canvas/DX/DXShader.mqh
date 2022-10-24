#ifndef DXSHADER_H
#define DXSHADER_H
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "DXHandle.mqh"
#include "DXInput.mqh"
#include "DXTexture.mqh"
//+------------------------------------------------------------------+
//| Maximum inputs count for shaders                                 |
//| D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT in DX11        |
//+------------------------------------------------------------------+
#define DX_SHADER_INPUTS_MAX 14
//+------------------------------------------------------------------+
//| Class CDXShader                                                  |
//+------------------------------------------------------------------+
class CDXShader : public CDXHandleShared {
protected:
  //--- shader type
  ENUM_DX_SHADER_TYPE m_type;
  //--- input data
  CDXInput *m_inputs[];
  CDXTexture *m_textures[];

public:
  //+------------------------------------------------------------------+
  //| Destructor                                                       |
  //+------------------------------------------------------------------+
  virtual ~CDXShader(void) {
    Shutdown();
  }
  //+------------------------------------------------------------------+
  //| Create a new shader from source code                             |
  //+------------------------------------------------------------------+
  bool Create(int context, ENUM_DX_SHADER_TYPE shader_type, string source,
              string entry_point) {
    //--- shutdown shader
    Shutdown();
    //--- save new context
    m_context = context;
    //--- check context
    if (m_context == INVALID_HANDLE)
      return (false);
    //--- save shader type;
    m_type = shader_type;
    //--- compile shader
    string error = "";
    m_handle = DXShaderCreate(m_context, m_type, source, entry_point, error);
    if (m_handle == INVALID_HANDLE)
      return (false);
    //--- success
    return (true);
  }
  //+------------------------------------------------------------------+
  //| Set vertex shader vertices layout                                |
  //+------------------------------------------------------------------+
  template <typename TVertex> bool LayoutSet(void) {
    //--- check shader handle
    if (m_handle == INVALID_HANDLE)
      return (false);
    //--- layout is available only for vertex shaders
    if (m_type != DX_SHADER_VERTEX)
      return (false);
    //--- set layout
    return (DXShaderSetLayout(m_handle, TVertex::s_layout));
  }
  //+------------------------------------------------------------------+
  //| Set input buffer at specified index                              |
  //+------------------------------------------------------------------+
  bool InputSet(int index, CDXInput *dx_input) {
    //---
    if (index >= DX_SHADER_INPUTS_MAX ||
        CheckPointer(dx_input) == POINTER_INVALID ||
        dx_input.Handle() == INVALID_HANDLE)
      return (false);
    //--- check if input is the same
    int count = ArraySize(m_inputs);
    if (index < count && CheckPointer(m_inputs[index]) != POINTER_INVALID &&
        m_inputs[index].Handle() == dx_input.Handle())
      return (true);
    //--- allocate array for new inputs
    if (index >= count)
      ArrayResize(m_inputs, index + 1);
    for (int i = count; i <= index; i++)
      m_inputs[i] = NULL;
    //--- release previous input buffer
    if (m_inputs[index])
      m_inputs[index].Release();
    //--- set new input buffer
    m_inputs[index] = dx_input;
    dx_input.AddRef();
    //--- successed
    return (true);
  }
  //+------------------------------------------------------------------+
  //| Set texture at specified index                                   |
  //+------------------------------------------------------------------+
  bool TextureSet(int index, CDXTexture *texture) {
    //---
    if (m_type != DX_SHADER_PIXEL || index >= DX_SHADER_INPUTS_MAX ||
        CheckPointer(texture) == POINTER_INVALID ||
        texture.Handle() == INVALID_HANDLE)
      return (false);
    //--- check if texture is the same
    int count = ArraySize(m_textures);
    if (index < count && CheckPointer(m_textures[index]) != POINTER_INVALID &&
        m_textures[index].Handle() == texture.Handle())
      return (true);
    //--- allocate array for new inputs
    if (index >= count)
      ArrayResize(m_textures, index + 1);
    for (int i = count; i <= index; i++)
      m_textures[i] = NULL;
    //--- release previous input buffer
    if (m_textures[index])
      m_textures[index].Release();
    //--- set new input buffer
    m_textures[index] = texture;
    texture.AddRef();
    //--- successed
    return (true);
  }
  //+------------------------------------------------------------------+
  //| Set texture at specified index                                   |
  //+------------------------------------------------------------------+
  void TexturesClear() {
    //--- release textures
    for (int i = 0; i < ArraySize(m_textures); i++)
      if (m_textures[i])
        m_textures[i].Release();
    ArrayFree(m_textures);
  }
  //+------------------------------------------------------------------+
  //| Put shader into render queue                                     |
  //+------------------------------------------------------------------+
  virtual bool Render(void) {
    //--- check handles
    if (m_context == INVALID_HANDLE || m_handle == INVALID_HANDLE)
      return (false);
    //--- update shader inputs
    if (!UpdateInputs())
      return (false);
    //--- set shader
    return (DXShaderSet(m_context, m_handle));
  }
  //+------------------------------------------------------------------+
  //| Shutdown                                                         |
  //+------------------------------------------------------------------+
  virtual void Shutdown(void) {
    //--- relase handle
    if (m_handle != INVALID_HANDLE)
      DXRelease(m_handle);
    m_handle = INVALID_HANDLE;
    //--- release input buffers
    for (int i = 0; i < ArraySize(m_inputs); i++)
      if (m_inputs[i])
        m_inputs[i].Release();
    //--- release textures
    for (int i = 0; i < ArraySize(m_textures); i++)
      if (m_textures[i])
        m_textures[i].Release();
    ArrayFree(m_textures);
  }

private:
  //+------------------------------------------------------------------+
  //| Shutdown                                                         |
  //+------------------------------------------------------------------+
  bool UpdateInputs(void) {
    int handles[];
    //--- set inputs handles
    int count = ArraySize(m_inputs);
    if (count > 0) {
      ArrayResize(handles, count);
      //--- copy inputs handles
      for (int i = 0; i < count; i++)
        if (m_inputs[i])
          handles[i] = m_inputs[i].Handle();
        else
          handles[i] = INVALID_HANDLE;
    } else
      ArrayFree(handles);
    //--- set input handles
    if (!DXShaderInputsSet(m_handle, handles))
      return (false);
    //--- set textures handles
    if (m_type == DX_SHADER_PIXEL) {
      count = ArraySize(m_textures);
      if (count > 0) {
        ArrayResize(handles, count);
        //--- copy inputs handles
        for (int i = 0; i < count; i++)
          if (m_textures[i])
            handles[i] = m_textures[i].Handle();
          else
            handles[i] = INVALID_HANDLE;
      } else
        ArrayFree(handles);
      ResetLastError();
      //--- set taxtures handles
      if (!DXShaderTexturesSet(m_handle, handles))
        return (false);
    }
    //--- succes
    return (true);
  }
};
//+------------------------------------------------------------------+

#endif
