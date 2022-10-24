#ifndef WND_H
#define WND_H

#include "Defines.mqh"
#include "Rect.mqh"
#include <Object.mqh>
class CDragWnd;

class CWnd : public CObject {
protected:
  long m_chart_id;
  int m_subwin;
  string m_name;

  CRect m_rect;

  long m_id;

  int m_state_flags;

  int m_prop_flags;

  int m_align_flags;
  int m_align_left;
  int m_align_top;
  int m_align_right;
  int m_align_bottom;

  int m_mouse_x;
  int m_mouse_y;
  int m_mouse_flags;
  uint m_last_click;

  CDragWnd *m_drag_object;

public:
  CWnd(void);
  ~CWnd(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual void Destroy(const int reason = 0);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);
  virtual bool OnMouseEvent(const int x, const int y, const int flags);

  string Name(void) const;

  int ControlsTotal(void) const;
  CWnd *Control(const int ind) const;
  virtual CWnd *ControlFind(const long id);

  const CRect Rect(void) const;
  int Left(void) const;
  virtual void Left(const int x);
  int Top(void) const;
  virtual void Top(const int y);
  int Right(void) const;
  virtual void Right(const int x);
  int Bottom(void) const;
  virtual void Bottom(const int y);
  int Width(void) const;
  virtual bool Width(const int w);
  int Height(void) const;
  virtual bool Height(const int h);
  CSize Size(void) const;
  virtual bool Size(const int w, const int h);
  virtual bool Size(const CSize &size);
  virtual bool Move(const int x, const int y);
  virtual bool Move(const CPoint &point);
  virtual bool Shift(const int dx, const int dy);
  bool Contains(const int x, const int y) const;
  bool Contains(CWnd *control) const;

  void Alignment(const int flags, const int left, const int top,
                 const int right, const int bottom);
  virtual bool Align(const CRect &rect);

  virtual long Id(const long id);
  long Id(void) const;

  bool IsEnabled(void) const;
  virtual bool Enable(void);
  virtual bool Disable(void);
  bool IsVisible(void) const;
  virtual bool Visible(const bool flag);
  virtual bool Show(void);
  virtual bool Hide(void);
  bool IsActive(void) const;
  virtual bool Activate(void);
  virtual bool Deactivate(void);

  int StateFlags(void) const;
  void StateFlags(const int flags);
  void StateFlagsSet(const int flags);
  void StateFlagsReset(const int flags);

  int PropFlags(void) const;
  void PropFlags(const int flags);
  void PropFlagsSet(const int flags);
  void PropFlagsReset(const int flags);

  int MouseX(void) const;
  void MouseX(const int value);
  int MouseY(void) const;
  void MouseY(const int value);
  int MouseFlags(void) const;
  virtual void MouseFlags(const int value);
  bool MouseFocusKill(const long id = CONTROLS_INVALID_ID);
  bool BringToTop(void);

protected:
  virtual bool OnCreate(void);
  virtual bool OnDestroy(void);
  virtual bool OnMove(void);
  virtual bool OnResize(void);
  virtual bool OnEnable(void);
  virtual bool OnDisable(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnActivate(void);
  virtual bool OnDeactivate(void);
  virtual bool OnClick(void);
  virtual bool OnDblClick(void);
  virtual bool OnChange(void);

  virtual bool OnMouseDown(void);
  virtual bool OnMouseUp(void);

  virtual bool OnDragStart(void);
  virtual bool OnDragProcess(const int x, const int y);
  virtual bool OnDragEnd(void);

  virtual bool DragObjectCreate(void);
  virtual bool DragObjectDestroy(void);
};

class CDragWnd : public CWnd {
protected:
  int m_limit_left;
  int m_limit_top;
  int m_limit_right;
  int m_limit_bottom;

public:
  CDragWnd(void);
  ~CDragWnd(void);

  void Limits(const int l, const int t, const int r, const int b);

protected:
  virtual bool OnDragProcess(const int x, const int y);
};

#endif
