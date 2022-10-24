#ifndef DXSHADER_H
#define DXSHADER_H

#include "DXEnums.mqh"
#include "DXHandle.mqh"
#include "DXInput.mqh"
#include "DXTexture.mqh"

class CDXShader : public CDXHandleShared {
protected:
  ENUM_DX_SHADER_TYPE m_type;

  CDXInput *m_inputs;
  CDXTexture *m_textures;

public:
  virtual ~CDXShader(void);

  bool Create(int context, ENUM_DX_SHADER_TYPE shader_type, string source,
              string entry_point);

  template <typename TVertex> bool LayoutSet(void);

  bool InputSet(int index, CDXInput *dx_input);

  bool TextureSet(int index, CDXTexture *texture);

  void TexturesClear();

  virtual bool Render(void);

  virtual void Shutdown(void);

private:
  bool UpdateInputs(void);
};

#endif
