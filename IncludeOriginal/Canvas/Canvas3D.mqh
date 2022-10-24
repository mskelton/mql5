#ifndef CANVAS3D_H
#define CANVAS3D_H
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//#include "Canvas.mqh"
#include "DX\DXDispatcher.mqh"
#include "DX\DXHandle.mqh"
#include "DX\DXMath.mqh"
#include "DX\DXObject.mqh"
#include "DX\DXObjectBase.mqh"
#include "DX\DXShader.mqh"
#include "DX\DXTexture.mqh"
#include "DX\DXUtils.mqh"
#include <Canvas\Canvas.mqh>
//+------------------------------------------------------------------+
//| Render flags                                                     |
//+------------------------------------------------------------------+
enum ENUM_DX_RENDER_FLAGS {
  DX_CLEAR_COLOR = 1, // clear colors buffer
  DX_CLEAR_DEPTH = 2  // clear z-buffer
};
//+------------------------------------------------------------------+
//| Class CCanvas3D                                                  |
//| Usage: class for render 3D graphics through DirectX              |
//+------------------------------------------------------------------+
class CCanvas3D : public CCanvas {
protected:
  int m_dx_context;              // DX Context Handle
  CDXDispatcher m_dx_dispatcher; // DX resource dispatcher
  CDXObjectBase m_dx_objects;    // DX scene objects array
  CDXInput *m_input_scene;       // Scene input of DXInputScene type
  DXMatrix m_view_matrix;        // View matrix
  DXVector3 m_view_position;     // Point of view
  DXVector3 m_view_target;       // View target point
  DXVector3 m_view_up_dir;       // View up direction
  DXMatrix m_projection_matrix;  // Projection matrix
  DXVector4 m_light_directon;    // Light direction
  DXColor m_light_color;         // Directional light color
  DXColor m_ambient_color;       // Ambient light color

public:
  CCanvas3D(void);
  ~CCanvas3D(void);
  //--- get DX Context Handle
  int DXContext(void) const {
    return (m_dx_context);
  }
  CDXDispatcher *DXDispatcher(void) {
    return (&m_dx_dispatcher);
  }
  CDXInput *InputScene(void) {
    return (m_input_scene);
  }
  //--- create/attach/destroy
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
  //--- create/delete 3D Objects
  bool ObjectAdd(CDXObject *object);
  //--- render functions
  bool Render(uint flags, uint background_color = 0);
  virtual bool RenderBegin(uint flags, uint background_color = 0);
  virtual bool RenderEnd(bool redraw = false);
  //--- view control function
  void ViewMatrixGet(DXMatrix &view_matrix);
  void ViewMatrixSet(const DXMatrix &view_matrix);
  void ViewPositionSet(const DXVector3 &posiiton);
  void ViewRotationSet(const DXVector3 &rotation);
  void ViewTargetSet(const DXVector3 &target);
  void ViewUpDirectionSet(const DXVector3 &up_direction);
  //--- projection control functions
  void ProjectionMatrixGet(DXMatrix &projection_matrix);
  void ProjectionMatrixSet(float fov, float aspect_ratio, float z_near,
                           float z_far);
  //--- light control functions
  void LightDirectionSet(const DXVector3 &light_direction);
  void LightDirectionGet(DXVector3 &light_direction);
  void LightColorSet(const DXColor &light_color);
  void LightColorGet(DXColor &light_color);
  void AmbientColorSet(const DXColor &ambient_color);
  void AmbientColorGet(DXColor &ambient_color);
};

//+------------------------------------------------------------------+
//| Set view matrix                                                  |
//+------------------------------------------------------------------+
void CCanvas3D::ViewMatrixGet(DXMatrix &view_matrix) {
  view_matrix = m_view_matrix;
}
//+------------------------------------------------------------------+
//| Get view matrix                                                  |
//+------------------------------------------------------------------+
void CCanvas3D::ViewMatrixSet(const DXMatrix &view_matrix) {
  m_view_matrix = view_matrix;
}
//+------------------------------------------------------------------+
//| Set point of view position                                       |
//+------------------------------------------------------------------+
void CCanvas3D::ViewPositionSet(const DXVector3 &position) {
  //--- set position
  m_view_position = position;
  //--- update view matrix
  DXMatrixLookAtLH(m_view_matrix, m_view_position, m_view_target,
                   m_view_up_dir);
}
//+------------------------------------------------------------------+
//| Set point of view position                                       |
//+------------------------------------------------------------------+
void CCanvas3D::ViewRotationSet(const DXVector3 &rotation) {
  //--- get view rotation matrix
  DXMatrix rot;
  DXMatrixRotationYawPitchRoll(rot, rotation.y, rotation.x, rotation.z);
  //--- get direction and up vectors for this matrix
  m_view_target.x = 0.0;
  m_view_target.x = 0.0;
  m_view_target.x = 1.0;
  DXVec3TransformCoord(m_view_target, m_view_target, rot);
  //--- get up vector for this matrix
  m_view_up_dir.x = 0.0;
  m_view_up_dir.y = 1.0;
  m_view_up_dir.y = 0.0;
  DXVec3TransformCoord(m_view_up_dir, m_view_up_dir, rot);
  //--- calculate far target position
  DXVec3Scale(m_view_target, m_view_target, 1000.0);
  DXVec3Add(m_view_target, m_view_position, m_view_target);
  //--- update view matrix
  DXMatrixLookAtLH(m_view_matrix, m_view_position, m_view_target,
                   m_view_up_dir);
}
//+------------------------------------------------------------------+
//| Set view target point                                            |
//+------------------------------------------------------------------+
void CCanvas3D::ViewTargetSet(const DXVector3 &target) {
  //--- set target
  m_view_target = target;
  //--- update view matrix
  DXMatrixLookAtLH(m_view_matrix, m_view_position, m_view_target,
                   m_view_up_dir);
}
//+------------------------------------------------------------------+
//| Set view up direction                                            |
//+------------------------------------------------------------------+
void CCanvas3D::ViewUpDirectionSet(const DXVector3 &up_direction) {
  //--- set up direction
  m_view_up_dir = up_direction;
  //--- update view matrix
  DXMatrixLookAtLH(m_view_matrix, m_view_position, m_view_target,
                   m_view_up_dir);
}
//+------------------------------------------------------------------+
//| Get projection matrix                                            |
//+------------------------------------------------------------------+
void CCanvas3D::ProjectionMatrixGet(DXMatrix &projection_matrix) {
  projection_matrix = m_projection_matrix;
}
//+------------------------------------------------------------------+
//| Set projection matrix                                            |
//+------------------------------------------------------------------+
void CCanvas3D::ProjectionMatrixSet(float fov, float aspect_ratio, float z_near,
                                    float z_far) {
  DXMatrixPerspectiveFovLH(m_projection_matrix, fov, aspect_ratio, z_near,
                           z_far);
}
//+------------------------------------------------------------------+
//| Set directional light direction                                  |
//+------------------------------------------------------------------+
void CCanvas3D::LightDirectionSet(const DXVector3 &light_direction) {
  float len = DXVec3Length(light_direction);
  m_light_directon.x = light_direction.x / len;
  m_light_directon.y = light_direction.y / len;
  m_light_directon.z = light_direction.z / len;
  //--- don't translate the vetor
  m_light_directon.w = 0.0;
}
//+------------------------------------------------------------------+
//| Get directional light direction                                  |
//+------------------------------------------------------------------+
void CCanvas3D::LightDirectionGet(DXVector3 &light_direction) {
  light_direction = DXVector3(m_light_directon);
}
//+------------------------------------------------------------------+
//| Set directional light color                                      |
//+------------------------------------------------------------------+
void CCanvas3D::LightColorSet(const DXColor &light_color) {
  m_light_color = light_color;
}
//+------------------------------------------------------------------+
//| Get directional light color                                      |
//+------------------------------------------------------------------+
void CCanvas3D::LightColorGet(DXColor &light_color) {
  light_color = m_light_color;
}
//+------------------------------------------------------------------+
//| Set ambient light color                                          |
//+------------------------------------------------------------------+
void CCanvas3D::AmbientColorSet(const DXColor &ambient_color) {
  m_ambient_color = ambient_color;
}
//+------------------------------------------------------------------+
//| Get ambient light color                                          |
//+------------------------------------------------------------------+
void CCanvas3D::AmbientColorGet(DXColor &ambient_color) {
  ambient_color = m_ambient_color;
}
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCanvas3D::CCanvas3D(void) : m_dx_context(-1) {
  //--- set identity matrices
  DXMatrixIdentity(m_view_matrix);
  DXMatrixIdentity(m_projection_matrix);
  //--- set zero directional light
  m_light_directon = DXVector4(0.0);
  m_light_color = DXColor(0.0, 0.0, 0.0, 0.0);
  //--- set full white ambient light
  m_ambient_color = DXColor(1.0, 1.0, 1.0, 1.0);
}
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCanvas3D::~CCanvas3D(void) {
  Destroy();
}
//+------------------------------------------------------------------+
//| Create dynamic resource with 3D context                          |
//+------------------------------------------------------------------+
bool CCanvas3D::Create(const string name, const int width, const int height,
                       ENUM_COLOR_FORMAT clrfmt) {
  //--- create 2D canvas
  if (!CCanvas::Create(name, width, height, clrfmt))
    return (false);
  //--- create 3D context
  m_dx_context = DXContextCreate(width, height);
  if (m_dx_context != INVALID_HANDLE)
    if (m_dx_dispatcher.Create(m_dx_context)) {
      m_input_scene = m_dx_dispatcher.InputCreate<DXInputScene>();
      if (m_input_scene != NULL) {
        m_input_scene.AddRef();
        return (true);
      }
    }
  //---
  Destroy();
  return (false);
}
//+------------------------------------------------------------------+
//| Remove object from chart and release DX Context                  |
//+------------------------------------------------------------------+
void CCanvas3D::Destroy(void) {
  //--- destroy 2D canvas
  CCanvas::Destroy();
  //--- delete all scene objects
  while (m_dx_objects.Next())
    delete m_dx_objects.Next();
  //--- release dx resources
  if (CheckPointer(m_input_scene) != POINTER_INVALID) {
    m_input_scene.Release();
    m_input_scene = NULL;
  }
  //--- destroy DX dispatcher
  m_dx_dispatcher.Destroy();
  //--- release context
  if (m_dx_context != -1) {
    DXRelease(m_dx_context);
    m_dx_context = -1;
  }
}
//+------------------------------------------------------------------+
//| Attach new object with bitmap resource                           |
//+------------------------------------------------------------------+
bool CCanvas3D::Attach(const long chart_id, const string objname,
                       ENUM_COLOR_FORMAT clrfmt) {
  //--- attach to the chart object
  if (!CCanvas::Attach(chart_id, objname, clrfmt))
    return (false);
  //--- create new DX Context if it does not exists
  if (m_dx_context == -1) {
    m_dx_context = DXContextCreate(m_width, m_height);
    return (m_dx_context != -1);
  }
  //--- DX Context exists, resize it to the new size
  return (DXContextSetSize(m_dx_context, m_width, m_height));
}
//+------------------------------------------------------------------+
//| Attach new object without bitmap resource                        |
//+------------------------------------------------------------------+
bool CCanvas3D::Attach(const long chart_id, const string objname,
                       const int width, const int height,
                       ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA) {
  //--- attach to the chart object
  if (!CCanvas::Attach(chart_id, objname, width, height, clrfmt))
    return (false);
  //--- create new DX Context if it does not exists
  if (m_dx_context == -1) {
    m_dx_context = DXContextCreate(m_width, m_height);
    return (m_dx_context != -1);
  }
  //--- DX Context exists, resize it to the new size
  return (DXContextSetSize(m_dx_context, m_width, m_height));
}
//+------------------------------------------------------------------+
//| Rendering 3D scene                                               |
//+------------------------------------------------------------------+
bool CCanvas3D::Render(uint flags, uint background_color) {
  //--- start rendering
  if (!RenderBegin(flags, background_color))
    return (false);
  //--- pass all non-skipped objects to render
  for (CDXObject *object = m_dx_objects.Next();
       CheckPointer(object) != POINTER_INVALID; object = object.Next())
    object.Render();
  //--- finish the render
  return (RenderEnd(false));
}
//+------------------------------------------------------------------+
//| Start 3D render                                                  |
//+------------------------------------------------------------------+
bool CCanvas3D::RenderBegin(uint flags, uint background_color) {
  //--- check resource dispatcher
  m_dx_dispatcher.Check();
  //--- clear color buffer
  if ((flags & DX_CLEAR_COLOR) != 0) {
    DXVector v;
    v.x = GETRGBR(background_color) / 255.0f;
    v.y = GETRGBG(background_color) / 255.0f;
    v.z = GETRGBB(background_color) / 255.0f;
    v.w = GETRGBA(background_color) / 255.0f;
    if (!DXContextClearColors(m_dx_context, v))
      return (false);
  }
  //--- clear depth buffer
  if ((flags & DX_CLEAR_DEPTH) != 0)
    if (!DXContextClearDepth(m_dx_context))
      return (false);
  //--- update scene input
  DXInputScene input_data;
  DXMatrixTranspose(input_data.view, m_view_matrix);
  DXMatrixTranspose(input_data.projection, m_projection_matrix);
  DXVec4Transform(input_data.light_direction, m_light_directon, m_view_matrix);
  input_data.light_color = m_light_color;
  input_data.ambient_color = m_ambient_color;
  //--- set input
  if (!m_input_scene.InputSet(input_data))
    return (false);
  //--- succes
  return (true);
}
//+------------------------------------------------------------------+
//| Finish 3D render                                                 |
//+------------------------------------------------------------------+
bool CCanvas3D::RenderEnd(bool redraw) {
  //--- finish render
  if (!DXContextGetColors(m_dx_context, m_pixels))
    return (false);
  //--- update canvas 2D if needed
  if (redraw)
    CCanvas::Update(redraw);
  //---
  return (true);
}
//+------------------------------------------------------------------+
//| Add user 3D object                                               |
//+------------------------------------------------------------------+
bool CCanvas3D::ObjectAdd(CDXObject *object) {
  //--- add user object
  if (!CheckPointer(object))
    return (false);
  //---
  CDXObjectBase *last = &m_dx_objects;

  while (CheckPointer(last.Next()) != POINTER_INVALID) {
    if (last == object)
      return (false);
    //---
    last = last.Next();
  }

  object.Next(NULL);
  object.Prev(last);
  last.Next(object);
  return (true);
}
//+------------------------------------------------------------------+

#endif
