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

  int DXContext(void) const ;

  CDXShader *ShaderCreateDefault(ENUM_DX_SHADER_TYPE shader_type);
  CDXShader *ShaderCreateFromFile(ENUM_DX_SHADER_TYPE shader_type, string path,
                                  string entry_point);
  CDXShader *ShaderCreateFromSource(ENUM_DX_SHADER_TYPE shader_type,
                                    string source, string entry_point);

  template <typename TVertex>
  CDXVertexBuffer *VertexBufferCreate(const TVertex vertices[], uint start = 0,
                                      uint count = WHOLE_ARRAY);
  CDXIndexBuffer *IndexBufferCreate(const uint indicies[], uint start = 0,
                                    uint count = WHOLE_ARRAY);

  template <typename TInput> CDXInput *InputCreate(void);
  CDXTexture *TextureCreateFromFile(string path, uint data_x = 0,
                                    uint data_y = 0, uint data_width = 0,
                                    uint data_height = 0);
  CDXTexture *TextureCreateFromData(ENUM_DX_FORMAT format, uint width,
                                    uint height, const uint data[],
                                    uint data_x = 0, uint data_y = 0,
                                    uint data_width = 0, uint data_height = 0);

private:
  bool ResourceAdd(CDXObjectBase *resource);

  void ResourcesCheck(void);
};








CDXShader *







#endif
