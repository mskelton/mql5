#ifndef DXMESH_H
#define DXMESH_H

#include "DXData.mqh"
#include "DXDispatcher.mqh"
#include "DXObject.mqh"
#include "DXUtils.mqh"

class CDXMesh : public CDXObject {
protected:
  CDXVertexBuffer *m_buffer_vertex;
  CDXIndexBuffer *m_buffer_index;
  CDXInput *m_buffer_object;
  CDXInput *m_buffer_scene;
  CDXShader *m_shader_vertex;
  CDXShader *m_shader_pixel;
  CDXTexture *m_texture;

  DXMatrix m_transform_matrix;
  DXColor m_diffuse_color;
  DXColor m_emission_color;
  DXColor m_specular_color;
  float m_specular_power;

  ENUM_DX_PRIMITIVE_TOPOLOGY m_topology;

public:
  CDXMesh(void)
      ;
        m_buffer_scene(NULL), m_shader_vertex(NULL), m_shader_pixel(NULL),
        m_topology(WRONG_VALUE) ;

  ~CDXMesh(void) ;

  bool Create(CDXDispatcher &dispatcher, CDXInput *buffer_scene,
              const DXVertex vertices[], const uint indices[],
              ENUM_DX_PRIMITIVE_TOPOLOGY topology =
                  DX_PRIMITIVE_TOPOLOGY_TRIANGLELIST) ;

  bool Create(CDXDispatcher &dispatcher, CDXInput *buffer_scene,
              string obj_path, float scale = 1.0f,
              bool inverse_winding = false) ;

  bool VerticesSet(const DXVertex vertices[]) ;

  bool IndicesSet(const uint indices[]) ;

  bool TopologySet(ENUM_DX_PRIMITIVE_TOPOLOGY topology) ;

  void TransformMatrixGet(DXMatrix &mat) const ;

  void TransformMatrixSet(const DXMatrix &mat) ;

  void DiffuseColorGet(DXColor &clr) const ;

  void DiffuseColorSet(const DXColor &clr) ;

  void SpecularColorGet(DXColor &clr) const ;

  void SpecularColorSet(const DXColor &clr) ;

  void SpecularPowerGet(float &power) const ;

  void SpecularPowerSet(float power) ;

  void EmissionColorGet(DXColor &clr) const ;

  void EmissionColorSet(const DXColor &clr) ;

  virtual bool Render(void) override ;

  bool TextureSet(CDXDispatcher &dispatcher, string path, uint data_x = 0,
                  uint data_y = 0, uint data_width = 0, uint data_height = 0) ;

  bool TextureSet(CDXDispatcher &dispatcher, ENUM_DX_FORMAT format, uint width,
                  uint height, const uint data[], uint data_x = 0,
                  uint data_y = 0, uint data_width = 0, uint data_height = 0) ;

  void TextureDelete() ;

  virtual void Shutdown(void) ;
};

#endif
