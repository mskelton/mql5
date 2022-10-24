#ifndef CANVAS3D_H
#define CANVAS3D_H

#include "DX/DXDispatcher.mqh"
#include "DX/DXHandle.mqh"
#include "DX/DXMath.mqh"
#include "DX/DXObject.mqh"
#include "DX/DXObjectBase.mqh"
#include "DX/DXShader.mqh"
#include "DX/DXTexture.mqh"
#include "DX/DXUtils.mqh"
#include <Canvas/Canvas.mqh>

enum ENUM_DX_RENDER_FLAGS { DX_CLEAR_COLOR = 1, DX_CLEAR_DEPTH = 2 };

class CCanvas3D : public CCanvas {
protected:
  int m_dx_context;
  CDXDispatcher m_dx_dispatcher;
  CDXObjectBase m_dx_objects;
  CDXInput *m_input_scene;
  DXMatrix m_view_matrix;
  DXVector3 m_view_position;
  DXVector3 m_view_target;
  DXVector3 m_view_up_dir;
  DXMatrix m_projection_matrix;
  DXVector4 m_light_directon;
  DXColor m_light_color;
  DXColor m_ambient_color;

public:
  CCanvas3D(void);
  ~CCanvas3D(void);

  int DXContext(void) const;
  CDXDispatcher *DXDispatcher(void);
  CDXInput *InputScene(void);

  virtual bool
  Create(const string name, const int width, const int height,
         ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA) override;
  virtual bool
  Attach(const long chart_id, const string objname,
         ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA) override;
  virtual bool
  Attach(const long chart_id, const string objname, const int width,
         const int height,
         ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA) override;
  virtual void Destroy(void) override;

  bool ObjectAdd(CDXObject *object);

  bool Render(uint flags, uint background_color = 0);
  virtual bool RenderBegin(uint flags, uint background_color = 0);
  virtual bool RenderEnd(bool redraw = false);

  void ViewMatrixGet(DXMatrix &view_matrix);
  void ViewMatrixSet(const DXMatrix &view_matrix);
  void ViewPositionSet(const DXVector3 &posiiton);
  void ViewRotationSet(const DXVector3 &rotation);
  void ViewTargetSet(const DXVector3 &target);
  void ViewUpDirectionSet(const DXVector3 &up_direction);

  void ProjectionMatrixGet(DXMatrix &projection_matrix);
  void ProjectionMatrixSet(float fov, float aspect_ratio, float z_near,
                           float z_far);

  void LightDirectionSet(const DXVector3 &light_direction);
  void LightDirectionGet(DXVector3 &light_direction);
  void LightColorSet(const DXColor &light_color);
  void LightColorGet(DXColor &light_color);
  void AmbientColorSet(const DXColor &ambient_color);
  void AmbientColorGet(DXColor &ambient_color);
};

#endif
