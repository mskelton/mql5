#ifndef CANVAS3D_H
#define CANVAS3D_H

#include "DX\DXDispatcher.mqh"
#include "DX\DXHandle.mqh"
#include "DX\DXMath.mqh"
#include "DX\DXObject.mqh"
#include "DX\DXObjectBase.mqh"
#include "DX\DXShader.mqh"
#include "DX\DXTexture.mqh"
#include "DX\DXUtils.mqh"
#include <Canvas\Canvas.mqh>

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

  int DXContext(void) const {
    return (m_dx_context);
  }
  CDXDispatcher *DXDispatcher(void) {
    return (&m_dx_dispatcher);
  }
  CDXInput *InputScene(void) {
    return (m_input_scene);
  }

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

void CCanvas3D::ViewMatrixGet(DXMatrix &view_matrix) {
  view_matrix = m_view_matrix;
}

void CCanvas3D::ViewMatrixSet(const DXMatrix &view_matrix) {
  m_view_matrix = view_matrix;
}

void CCanvas3D::ViewPositionSet(const DXVector3 &position) {

  m_view_position = position;

  DXMatrixLookAtLH(m_view_matrix, m_view_position, m_view_target,
                   m_view_up_dir);
}

void CCanvas3D::ViewRotationSet(const DXVector3 &rotation) {

  DXMatrix rot;
  DXMatrixRotationYawPitchRoll(rot, rotation.y, rotation.x, rotation.z);

  m_view_target.x = 0.0;
  m_view_target.x = 0.0;
  m_view_target.x = 1.0;
  DXVec3TransformCoord(m_view_target, m_view_target, rot);

  m_view_up_dir.x = 0.0;
  m_view_up_dir.y = 1.0;
  m_view_up_dir.y = 0.0;
  DXVec3TransformCoord(m_view_up_dir, m_view_up_dir, rot);

  DXVec3Scale(m_view_target, m_view_target, 1000.0);
  DXVec3Add(m_view_target, m_view_position, m_view_target);

  DXMatrixLookAtLH(m_view_matrix, m_view_position, m_view_target,
                   m_view_up_dir);
}

void CCanvas3D::ViewTargetSet(const DXVector3 &target) {

  m_view_target = target;

  DXMatrixLookAtLH(m_view_matrix, m_view_position, m_view_target,
                   m_view_up_dir);
}

void CCanvas3D::ViewUpDirectionSet(const DXVector3 &up_direction) {

  m_view_up_dir = up_direction;

  DXMatrixLookAtLH(m_view_matrix, m_view_position, m_view_target,
                   m_view_up_dir);
}

void CCanvas3D::ProjectionMatrixGet(DXMatrix &projection_matrix) {
  projection_matrix = m_projection_matrix;
}

void CCanvas3D::ProjectionMatrixSet(float fov, float aspect_ratio, float z_near,
                                    float z_far) {
  DXMatrixPerspectiveFovLH(m_projection_matrix, fov, aspect_ratio, z_near,
                           z_far);
}

void CCanvas3D::LightDirectionSet(const DXVector3 &light_direction) {
  float len = DXVec3Length(light_direction);
  m_light_directon.x = light_direction.x / len;
  m_light_directon.y = light_direction.y / len;
  m_light_directon.z = light_direction.z / len;

  m_light_directon.w = 0.0;
}

void CCanvas3D::LightDirectionGet(DXVector3 &light_direction) {
  light_direction = DXVector3(m_light_directon);
}

void CCanvas3D::LightColorSet(const DXColor &light_color) {
  m_light_color = light_color;
}

void CCanvas3D::LightColorGet(DXColor &light_color) {
  light_color = m_light_color;
}

void CCanvas3D::AmbientColorSet(const DXColor &ambient_color) {
  m_ambient_color = ambient_color;
}

void CCanvas3D::AmbientColorGet(DXColor &ambient_color) {
  ambient_color = m_ambient_color;
}

CCanvas3D::CCanvas3D(void) : m_dx_context(-1) {

  DXMatrixIdentity(m_view_matrix);
  DXMatrixIdentity(m_projection_matrix);

  m_light_directon = DXVector4(0.0);
  m_light_color = DXColor(0.0, 0.0, 0.0, 0.0);

  m_ambient_color = DXColor(1.0, 1.0, 1.0, 1.0);
}

CCanvas3D::~CCanvas3D(void) {
  Destroy();
}

bool CCanvas3D::Create(const string name, const int width, const int height,
                       ENUM_COLOR_FORMAT clrfmt) {

  if (!CCanvas::Create(name, width, height, clrfmt))
    return (false);

  m_dx_context = DXContextCreate(width, height);
  if (m_dx_context != INVALID_HANDLE)
    if (m_dx_dispatcher.Create(m_dx_context)) {
      m_input_scene = m_dx_dispatcher.InputCreate<DXInputScene>();
      if (m_input_scene != NULL) {
        m_input_scene.AddRef();
        return (true);
      }
    }

  Destroy();
  return (false);
}

void CCanvas3D::Destroy(void) {

  CCanvas::Destroy();

  while (m_dx_objects.Next())
    delete m_dx_objects.Next();

  if (CheckPointer(m_input_scene) != POINTER_INVALID) {
    m_input_scene.Release();
    m_input_scene = NULL;
  }

  m_dx_dispatcher.Destroy();

  if (m_dx_context != -1) {
    DXRelease(m_dx_context);
    m_dx_context = -1;
  }
}

bool CCanvas3D::Attach(const long chart_id, const string objname,
                       ENUM_COLOR_FORMAT clrfmt) {

  if (!CCanvas::Attach(chart_id, objname, clrfmt))
    return (false);

  if (m_dx_context == -1) {
    m_dx_context = DXContextCreate(m_width, m_height);
    return (m_dx_context != -1);
  }

  return (DXContextSetSize(m_dx_context, m_width, m_height));
}

bool CCanvas3D::Attach(const long chart_id, const string objname,
                       const int width, const int height,
                       ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA) {

  if (!CCanvas::Attach(chart_id, objname, width, height, clrfmt))
    return (false);

  if (m_dx_context == -1) {
    m_dx_context = DXContextCreate(m_width, m_height);
    return (m_dx_context != -1);
  }

  return (DXContextSetSize(m_dx_context, m_width, m_height));
}

bool CCanvas3D::Render(uint flags, uint background_color) {

  if (!RenderBegin(flags, background_color))
    return (false);

  for (CDXObject *object = m_dx_objects.Next();
       CheckPointer(object) != POINTER_INVALID; object = object.Next())
    object.Render();

  return (RenderEnd(false));
}

bool CCanvas3D::RenderBegin(uint flags, uint background_color) {

  m_dx_dispatcher.Check();

  if ((flags & DX_CLEAR_COLOR) != 0) {
    DXVector v;
    v.x = GETRGBR(background_color) / 255.0f;
    v.y = GETRGBG(background_color) / 255.0f;
    v.z = GETRGBB(background_color) / 255.0f;
    v.w = GETRGBA(background_color) / 255.0f;
    if (!DXContextClearColors(m_dx_context, v))
      return (false);
  }

  if ((flags & DX_CLEAR_DEPTH) != 0)
    if (!DXContextClearDepth(m_dx_context))
      return (false);

  DXInputScene input_data;
  DXMatrixTranspose(input_data.view, m_view_matrix);
  DXMatrixTranspose(input_data.projection, m_projection_matrix);
  DXVec4Transform(input_data.light_direction, m_light_directon, m_view_matrix);
  input_data.light_color = m_light_color;
  input_data.ambient_color = m_ambient_color;

  if (!m_input_scene.InputSet(input_data))
    return (false);

  return (true);
}

bool CCanvas3D::RenderEnd(bool redraw) {

  if (!DXContextGetColors(m_dx_context, m_pixels))
    return (false);

  if (redraw)
    CCanvas::Update(redraw);

  return (true);
}

bool CCanvas3D::ObjectAdd(CDXObject *object) {

  if (!CheckPointer(object))
    return (false);

  CDXObjectBase *last = &m_dx_objects;

  while (CheckPointer(last.Next()) != POINTER_INVALID) {
    if (last == object)
      return (false);

    last = last.Next();
  }

  object.Next(NULL);
  object.Prev(last);
  last.Next(object);
  return (true);
}

#endif
