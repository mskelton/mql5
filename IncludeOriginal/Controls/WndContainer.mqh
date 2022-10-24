#ifndef WND_CONTAINER_H
#define WND_CONTAINER_H

#include "Wnd.mqh"
#include <Arrays\ArrayObj.mqh>

class CWndContainer : public CWnd {
private:
  CArrayObj m_controls;

public:
  CWndContainer(void);
  ~CWndContainer(void);

  virtual void Destroy(const int reason = 0);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);
  virtual bool OnMouseEvent(const int x, const int y, const int flags);

  int ControlsTotal(void) const {
    return (m_controls.Total());
  }
  CWnd *Control(const int ind) const {
    return (dynamic_cast<CWnd *>(m_controls.At(ind)));
  }
  virtual CWnd *ControlFind(const long id);

  virtual bool MouseFocusKill(const long id = -1);

  bool Add(CWnd *control);
  bool Add(CWnd &control);

  bool Delete(CWnd *control);
  bool Delete(CWnd &control);

  virtual bool Move(const int x, const int y);
  virtual bool Move(const CPoint &point);
  virtual bool Shift(const int dx, const int dy);

  virtual long Id(const long id);
  long Id(void) const {
    return (CWnd::Id());
  }

  virtual bool Enable(void);
  virtual bool Disable(void);
  virtual bool Show(void);
  virtual bool Hide(void);

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  virtual bool OnResize(void);
  virtual bool OnActivate(void);
  virtual bool OnDeactivate(void);
};

bool CWndContainer::OnEvent(const int id, const long &lparam,
                            const double &dparam, const string &sparam) {

  if (m_drag_object != NULL &&
      m_drag_object.OnEvent(id, lparam, dparam, sparam))
    return (true);

  int total = m_controls.Total();
  for (int i = total - 1; i >= 0; i--) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    if (control.OnEvent(id, lparam, dparam, sparam))
      return (true);
  }

  return (false);
}

bool CWndContainer::OnMouseEvent(const int x, const int y, const int flags) {
  if (!IS_VISIBLE)
    return (false);

  if (m_drag_object != NULL && m_drag_object.OnMouseEvent(x, y, flags))
    return (true);

  int total = m_controls.Total();
  for (int i = total - 1; i >= 0; i--) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    if (control.OnMouseEvent(x, y, flags))
      return (true);
  }

  return (CWnd::OnMouseEvent(x, y, flags));
}

CWndContainer::CWndContainer(void) {}

CWndContainer::~CWndContainer(void) {}

void CWndContainer::Destroy(const int reason) {

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(0);

    if (control == NULL)
      continue;
    control.Destroy();
    m_controls.Delete(0);
  }
}

CWnd *CWndContainer::ControlFind(const long id) {
  CWnd *result = CWnd::ControlFind(id);

  if (result != NULL)
    return (result);

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    result = control.ControlFind(id);
    if (result != NULL)
      break;
  }

  return (result);
}

bool CWndContainer::MouseFocusKill(const long id = -1) {
  if (!IS_ACTIVE)
    return (false);
  Deactivate();

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    control.MouseFocusKill();
  }

  return (true);
}

bool CWndContainer::Add(CWnd *control) {

  if (control == NULL)
    return (false);

  control.Shift(Left(), Top());

  if (IS_VISIBLE && control.IsVisible()) {

    control.Visible(Contains(control));
  } else
    control.Hide();

  if (IS_ENABLED)
    control.Enable();
  else
    control.Disable();

  return (m_controls.Add(control));
}

bool CWndContainer::Add(CWnd &control) {

  return (Add((CWnd *)GetPointer(control)));
}

bool CWndContainer::Delete(CWnd *control) {

  if (control == NULL)
    return (false);

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *pointer = Control(i);

    if (pointer == NULL)
      continue;

    if (pointer == control)
      return (m_controls.Delete(i));
  }

  return (false);
}

bool CWndContainer::Delete(CWnd &control) {

  return (Delete((CWnd *)GetPointer(control)));
}

bool CWndContainer::Move(const int x, const int y) {

  return (Shift(x - Left(), y - Top()));
}

bool CWndContainer::Move(const CPoint &point) {

  return (Shift(point.x - Left(), point.y - Top()));
}

bool CWndContainer::Shift(const int dx, const int dy) {

  if (!CWnd::Shift(dx, dy))
    return (false);

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;

    control.Shift(dx, dy);
  }

  return (true);
}

long CWndContainer::Id(const long id) {

  long id_used = 1;

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    id_used += control.Id(id + id_used);
  }
  m_id = id;

  return (id_used);
}

bool CWndContainer::Enable(void) {

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    control.Enable();
  }

  return (CWnd::Enable());
}

bool CWndContainer::Disable(void) {

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    control.Disable();
  }

  return (CWnd::Disable());
}

bool CWndContainer::Show(void) {

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    control.Show();
  }

  return (CWnd::Show());
}

bool CWndContainer::Hide(void) {

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    control.Hide();
  }

  return (CWnd::Hide());
}

bool CWndContainer::OnResize() {

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    if (!control.Align(Rect()))
      return (false);
  }

  return (true);
}

bool CWndContainer::OnActivate(void) {
  if (IS_ACTIVE)
    return (false);
  Activate();

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    control.Activate();
  }

  return (true);
}

bool CWndContainer::OnDeactivate(void) {
  if (!IS_ACTIVE)
    return (false);
  Deactivate();

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    control.Deactivate();
  }

  return (true);
}

bool CWndContainer::Save(const int file_handle) {
  bool result = true;

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    result &= control.Save(file_handle);
  }

  return (result);
}

bool CWndContainer::Load(const int file_handle) {
  bool result = true;

  int total = m_controls.Total();
  for (int i = 0; i < total; i++) {
    CWnd *control = Control(i);

    if (control == NULL)
      continue;
    result &= control.Load(file_handle);
  }

  return (result);
}

#endif
