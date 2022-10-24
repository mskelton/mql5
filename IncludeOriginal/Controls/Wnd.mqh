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

  string Name(void) const {
    return (m_name);
  }

  int ControlsTotal(void) const {
    return (0);
  }
  CWnd *Control(const int ind) const {
    return (NULL);
  }
  virtual CWnd *ControlFind(const long id);

  const CRect Rect(void) const {
    return (m_rect);
  }
  int Left(void) const {
    return (m_rect.left);
  }
  virtual void Left(const int x) {
    m_rect.left = x;
  }
  int Top(void) const {
    return (m_rect.top);
  }
  virtual void Top(const int y) {
    m_rect.top = y;
  }
  int Right(void) const {
    return (m_rect.right);
  }
  virtual void Right(const int x) {
    m_rect.right = x;
  }
  int Bottom(void) const {
    return (m_rect.bottom);
  }
  virtual void Bottom(const int y) {
    m_rect.bottom = y;
  }
  int Width(void) const {
    return (m_rect.Width());
  }
  virtual bool Width(const int w);
  int Height(void) const {
    return (m_rect.Height());
  }
  virtual bool Height(const int h);
  CSize Size(void) const {
    return (m_rect.Size());
  }
  virtual bool Size(const int w, const int h);
  virtual bool Size(const CSize &size);
  virtual bool Move(const int x, const int y);
  virtual bool Move(const CPoint &point);
  virtual bool Shift(const int dx, const int dy);
  bool Contains(const int x, const int y) const {
    return (m_rect.Contains(x, y));
  }
  bool Contains(CWnd *control) const;

  void Alignment(const int flags, const int left, const int top,
                 const int right, const int bottom);
  virtual bool Align(const CRect &rect);

  virtual long Id(const long id);
  long Id(void) const {
    return (m_id);
  }

  bool IsEnabled(void) const {
    return (IS_ENABLED);
  }
  virtual bool Enable(void);
  virtual bool Disable(void);
  bool IsVisible(void) const {
    return (IS_VISIBLE);
  }
  virtual bool Visible(const bool flag);
  virtual bool Show(void);
  virtual bool Hide(void);
  bool IsActive(void) const {
    return (IS_ACTIVE);
  }
  virtual bool Activate(void);
  virtual bool Deactivate(void);

  int StateFlags(void) const {
    return (m_state_flags);
  }
  void StateFlags(const int flags) {
    m_state_flags = flags;
  }
  void StateFlagsSet(const int flags) {
    m_state_flags |= flags;
  }
  void StateFlagsReset(const int flags) {
    m_state_flags &= ~flags;
  }

  int PropFlags(void) const {
    return (m_prop_flags);
  }
  void PropFlags(const int flags) {
    m_prop_flags = flags;
  }
  void PropFlagsSet(const int flags) {
    m_prop_flags |= flags;
  }
  void PropFlagsReset(const int flags) {
    m_prop_flags &= ~flags;
  }

  int MouseX(void) const {
    return (m_mouse_x);
  }
  void MouseX(const int value) {
    m_mouse_x = value;
  }
  int MouseY(void) const {
    return (m_mouse_y);
  }
  void MouseY(const int value) {
    m_mouse_y = value;
  }
  int MouseFlags(void) const {
    return (m_mouse_flags);
  }
  virtual void MouseFlags(const int value) {
    m_mouse_flags = value;
  }
  bool MouseFocusKill(const long id = CONTROLS_INVALID_ID);
  bool BringToTop(void);

protected:
  virtual bool OnCreate(void) {
    return (true);
  }
  virtual bool OnDestroy(void) {
    return (true);
  }
  virtual bool OnMove(void) {
    return (true);
  }
  virtual bool OnResize(void) {
    return (true);
  }
  virtual bool OnEnable(void) {
    return (true);
  }
  virtual bool OnDisable(void) {
    return (true);
  }
  virtual bool OnShow(void) {
    return (true);
  }
  virtual bool OnHide(void) {
    return (true);
  }
  virtual bool OnActivate(void) {
    return (true);
  }
  virtual bool OnDeactivate(void) {
    return (true);
  }
  virtual bool OnClick(void);
  virtual bool OnDblClick(void);
  virtual bool OnChange(void) {
    return (true);
  }

  virtual bool OnMouseDown(void);
  virtual bool OnMouseUp(void);

  virtual bool OnDragStart(void);
  virtual bool OnDragProcess(const int x, const int y);
  virtual bool OnDragEnd(void);

  virtual bool DragObjectCreate(void) {
    return (false);
  }
  virtual bool DragObjectDestroy(void);
};

bool CWnd::OnEvent(const int id, const long &lparam, const double &dparam,
                   const string &sparam) {
  if ((id != CHARTEVENT_MOUSE_MOVE))
    return (false);
  if (!IS_VISIBLE)
    return (false);
  int x = (int)lparam;
  int y = (int)dparam;
  int flags = (int)StringToInteger(sparam);

  if (m_drag_object != NULL)
    return (m_drag_object.OnMouseEvent(x, y, flags));

  return (OnMouseEvent(x, y, flags));
}

bool CWnd::OnMouseEvent(const int x, const int y, const int flags) {
  if (!Contains(x, y)) {

    if (IS_ACTIVE) {

      m_mouse_x = 0;
      m_mouse_y = 0;
      m_mouse_flags = MOUSE_INVALID_FLAGS;

      Deactivate();
    }
    return (false);
  }

  if ((flags & MOUSE_LEFT) != 0) {

    if (m_mouse_flags == MOUSE_INVALID_FLAGS) {

      if (!IS_ACTIVE) {

        EventChartCustom(CONTROLS_SELF_MESSAGE, ON_MOUSE_FOCUS_SET, m_id, 0.0,
                         m_name);

        return (Activate());
      }
      return (true);
    }
    if ((m_mouse_flags & MOUSE_LEFT) != 0) {

      if (IS_CAN_DRAG)
        return (OnDragProcess(x, y));
      if (IS_CLICKS_BY_PRESS) {
        EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CLICK, m_id, 0.0, m_name);

        return (true);
      }
    } else {

      m_mouse_flags = flags;
      m_mouse_x = x;
      m_mouse_y = y;

      return (OnMouseDown());
    }
  } else {

    if (m_mouse_flags == MOUSE_INVALID_FLAGS) {

      m_mouse_flags = flags;

      EventChartCustom(CONTROLS_SELF_MESSAGE, ON_MOUSE_FOCUS_SET, m_id, 0.0,
                       m_name);

      return (Activate());
    }
    if ((m_mouse_flags & MOUSE_LEFT) != 0) {

      m_mouse_flags = flags;
      m_mouse_x = x;
      m_mouse_y = y;

      return (OnMouseUp());
    }
  }

  return (true);
}

CWnd::CWnd(void)
    : m_chart_id(CONTROLS_INVALID_ID), m_subwin(CONTROLS_INVALID_ID),
      m_name(NULL), m_id(CONTROLS_INVALID_ID),
      m_state_flags(WND_STATE_FLAG_ENABLE + WND_STATE_FLAG_VISIBLE),
      m_prop_flags(0), m_align_flags(WND_ALIGN_NONE), m_align_left(0),
      m_align_top(0), m_align_right(0), m_align_bottom(0), m_mouse_x(0),
      m_mouse_y(0), m_mouse_flags(MOUSE_INVALID_FLAGS), m_last_click(0),
      m_drag_object(NULL) {
}

CWnd::~CWnd(void) {
}

bool CWnd::Create(const long chart, const string name, const int subwin,
                  const int x1, const int y1, const int x2, const int y2) {

  m_chart_id = chart;
  m_name = name;
  m_subwin = subwin;

  Left(x1);
  Top(y1);
  Right(x2);
  Bottom(y2);

  return (true);
}

void CWnd::Destroy(const int reason) {

  if (OnDestroy())
    m_name = "";
}

CWnd *CWnd::ControlFind(const long id) {
  CWnd *result = NULL;

  if (id == m_id)
    result = GetPointer(this);

  return (result);
}

bool CWnd::Width(const int w) {

  m_rect.Width(w);

  return (OnResize());
}

bool CWnd::Height(const int h) {

  m_rect.Height(h);

  return (OnResize());
}

bool CWnd::Size(const int w, const int h) {

  m_rect.Size(w, h);

  return (OnResize());
}

bool CWnd::Size(const CSize &size) {

  m_rect.Size(size);

  return (OnResize());
}

bool CWnd::Move(const int x, const int y) {

  m_rect.Move(x, y);

  return (OnMove());
}

bool CWnd::Move(const CPoint &point) {

  m_rect.Move(point);

  return (OnMove());
}

bool CWnd::Shift(const int dx, const int dy) {

  m_rect.Shift(dx, dy);

  return (OnMove());
}

bool CWnd::Contains(CWnd *control) const {

  if (control == NULL)
    return (false);

  return (Contains(control.Left(), control.Top()) &&
          Contains(control.Right(), control.Bottom()));
}

bool CWnd::Enable(void) {

  if (IS_ENABLED)
    return (true);

  StateFlagsSet(WND_STATE_FLAG_ENABLE);

  return (OnEnable());
}

bool CWnd::Disable(void) {

  if (!IS_ENABLED)
    return (true);

  StateFlagsReset(WND_STATE_FLAG_ENABLE);

  return (OnDisable());
}

bool CWnd::Visible(const bool flag) {

  if (IS_VISIBLE == flag)
    return (true);

  return (flag ? Show() : Hide());
}

bool CWnd::Show(void) {

  StateFlagsSet(WND_STATE_FLAG_VISIBLE);

  return (OnShow());
}

bool CWnd::Hide(void) {

  StateFlagsReset(WND_STATE_FLAG_VISIBLE);

  return (OnHide());
}

bool CWnd::Activate(void) {

  if (IS_ACTIVE)
    return (true);

  StateFlagsSet(WND_STATE_FLAG_ACTIVE);

  return (OnActivate());
}

bool CWnd::Deactivate(void) {

  if (!IS_ACTIVE)
    return (true);

  StateFlagsReset(WND_STATE_FLAG_ACTIVE);

  return (OnDeactivate());
}

long CWnd::Id(const long id) {
  m_id = id;

  return (1);
}

void CWnd::Alignment(const int flags, const int left, const int top,
                     const int right, const int bottom) {
  m_align_flags = flags;
  m_align_left = left;
  m_align_top = top;
  m_align_right = right;
  m_align_bottom = bottom;
}

bool CWnd::Align(const CRect &rect) {
  int new_value = 0;

  if (m_align_flags == WND_ALIGN_NONE)
    return (true);

  if ((m_align_flags & WND_ALIGN_RIGHT) != 0) {

    if ((m_align_flags & WND_ALIGN_LEFT) != 0) {

      new_value = rect.Width() - m_align_left - m_align_right;
      if (!Size(new_value, Height()))
        return (false);
    } else {

      new_value = rect.right - Width() - m_align_right;
      if (!Move(new_value, Top()))
        return (false);
    }
  }
  if ((m_align_flags & WND_ALIGN_BOTTOM) != 0) {

    if ((m_align_flags & WND_ALIGN_TOP) != 0) {

      new_value = rect.Height() - m_align_top - m_align_bottom;
      if (!Size(Width(), new_value))
        return (false);
    } else {

      new_value = rect.bottom - Height() - m_align_bottom;
      if (!Move(Left(), new_value))
        return (false);
    }
  }

  return (true);
}

bool CWnd::MouseFocusKill(const long id) {

  if (id == m_id)
    return (false);

  Deactivate();

  m_mouse_x = 0;
  m_mouse_y = 0;
  m_mouse_flags = MOUSE_INVALID_FLAGS;

  return (OnDeactivate());
}

bool CWnd::BringToTop(void) {

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_BRING_TO_TOP, m_id, 0.0, m_name);

  return (true);
}

bool CWnd::OnClick(void) {

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CLICK, m_id, 0.0, m_name);

  return (true);
}

bool CWnd::OnDblClick(void) {

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_DBL_CLICK, m_id, 0.0, m_name);

  return (true);
}

bool CWnd::OnMouseDown(void) {
  if (IS_CAN_DRAG)
    return (OnDragStart());
  if (IS_CLICKS_BY_PRESS)
    return (OnClick());

  return (true);
}

bool CWnd::OnMouseUp(void) {
  if (IS_CAN_DBL_CLICK) {
    uint last_time = GetTickCount();
    if (m_last_click == 0 ||
        last_time - m_last_click > CONTROLS_DBL_CLICK_TIME) {
      m_last_click = (last_time == 0) ? 1 : last_time;
    } else {
      m_last_click = 0;
      return (OnDblClick());
    }
  }
  if (IS_CAN_DRAG)
    return (OnDragEnd());
  if (!IS_CLICKS_BY_PRESS)
    return (OnClick());

  return (true);
}

bool CWnd::OnDragStart(void) {
  if (!IS_CAN_DRAG)
    return (true);

  ChartSetInteger(m_chart_id, CHART_MOUSE_SCROLL, false);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_DRAG_START, m_id, 0.0, m_name);

  return (true);
}

bool CWnd::OnDragProcess(const int x, const int y) {
  Shift(x - m_mouse_x, y - m_mouse_y);

  m_mouse_x = x;
  m_mouse_y = y;

  return (true);
}

bool CWnd::OnDragEnd(void) {
  if (!IS_CAN_DRAG)
    return (true);

  ChartSetInteger(m_chart_id, CHART_MOUSE_SCROLL, true);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_DRAG_END, m_id, 0.0, m_name);

  return (true);
}

bool CWnd::DragObjectDestroy(void) {
  if (m_drag_object != NULL) {
    delete m_drag_object;
    m_drag_object = NULL;
  }

  return (true);
}

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

CDragWnd::CDragWnd(void) {
}

CDragWnd::~CDragWnd(void) {
}

void CDragWnd::Limits(const int l, const int t, const int r, const int b) {

  m_limit_left = l;
  m_limit_top = t;
  m_limit_right = r;
  m_limit_bottom = b;
}

bool CDragWnd::OnDragProcess(const int x, const int y) {
  int dx = x - m_mouse_x;
  int dy = y - m_mouse_y;

  if (Right() + dx > m_limit_right)
    dx = m_limit_right - Right();
  if (Left() + dx < m_limit_left)
    dx = m_limit_left - Left();
  if (Bottom() + dy > m_limit_bottom)
    dy = m_limit_bottom - Bottom();
  if (Top() + dy < m_limit_top)
    dy = m_limit_top - Top();

  Shift(dx, dy);

  m_mouse_x = x;
  m_mouse_y = y;

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_DRAG_PROCESS, m_id, 0.0, m_name);

  return (true);
}

#endif
