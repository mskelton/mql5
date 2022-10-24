#ifndef SCROLLS_H
#define SCROLLS_H

#include "BmpButton.mqh"
#include "Panel.mqh"
#include "WndContainer.mqh"

class CScroll : public CWndContainer {
protected:
  CPanel m_back;
  CBmpButton m_inc;
  CBmpButton m_dec;
  CBmpButton m_thumb;

  int m_min_pos;
  int m_max_pos;

  int m_curr_pos;

public:
  CScroll(void);
  ~CScroll(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  int MinPos(void) const {
    return (m_min_pos);
  }
  void MinPos(const int value);
  int MaxPos(void) const {
    return (m_max_pos);
  }
  void MaxPos(const int value);

  int CurrPos(void) const {
    return (m_curr_pos);
  }
  bool CurrPos(int value);

protected:
  virtual bool CreateBack(void);
  virtual bool CreateInc(void) {
    return (true);
  }
  virtual bool CreateDec(void) {
    return (true);
  }
  virtual bool CreateThumb(void) {
    return (true);
  }

  virtual bool OnClickInc(void);
  virtual bool OnClickDec(void);

  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnChangePos(void) {
    return (true);
  }

  virtual bool OnThumbDragStart(void) {
    return (true);
  }
  virtual bool OnThumbDragProcess(void) {
    return (true);
  }
  virtual bool OnThumbDragEnd(void) {
    return (true);
  }

  virtual int CalcPos(const int coord) {
    return (0);
  }
};

EVENT_MAP_BEGIN(CScroll)
ON_EVENT(ON_CLICK, m_inc, OnClickInc)
ON_EVENT(ON_CLICK, m_dec, OnClickDec)
ON_EVENT(ON_DRAG_START, m_thumb, OnThumbDragStart)
ON_EVENT_PTR(ON_DRAG_PROCESS, m_drag_object, OnThumbDragProcess)
ON_EVENT_PTR(ON_DRAG_END, m_drag_object, OnThumbDragEnd)
EVENT_MAP_END(CWndContainer)

CScroll::CScroll(void) : m_curr_pos(0), m_min_pos(0), m_max_pos(0) {
}

CScroll::~CScroll(void) {
}

bool CScroll::Create(const long chart, const string name, const int subwin,
                     const int x1, const int y1, const int x2, const int y2) {

  if (!CWndContainer::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!CreateBack())
    return (false);
  if (!CreateInc())
    return (false);
  if (!CreateDec())
    return (false);
  if (!CreateThumb())
    return (false);

  return (true);
}

bool CScroll::CreateBack(void) {

  if (!m_back.Create(m_chart_id, m_name + "Back", m_subwin, 0, 0, Width(),
                     Height()))
    return (false);
  if (!m_back.ColorBackground(CONTROLS_SCROLL_COLOR_BG))
    return (false);
  if (!m_back.ColorBorder(CONTROLS_SCROLL_COLOR_BORDER))
    return (false);
  if (!Add(m_back))
    return (false);

  return (true);
}

bool CScroll::CurrPos(int value) {

  if (value < m_min_pos)
    value = m_min_pos;
  if (value > m_max_pos)
    value = m_max_pos;

  if (m_curr_pos != value) {
    m_curr_pos = value;

    return (OnChangePos());
  }

  return (false);
}

void CScroll::MinPos(const int value) {

  if (m_min_pos != value) {
    m_min_pos = value;

    CurrPos(m_curr_pos);
  }
}

void CScroll::MaxPos(const int value) {

  if (m_max_pos != value) {
    m_max_pos = value;

    CurrPos(m_curr_pos);
  }
}

bool CScroll::OnShow(void) {
  if (m_id == CONTROLS_INVALID_ID)
    return (true);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_SHOW, m_id, 0.0, m_name);

  return (true);
}

bool CScroll::OnHide(void) {
  if (m_id == CONTROLS_INVALID_ID)
    return (true);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_HIDE, m_id, 0.0, m_name);

  return (true);
}

bool CScroll::OnClickInc(void) {

  if (!CurrPos(m_curr_pos + 1))
    return (true);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_SCROLL_INC, m_id, 0.0, m_name);

  return (true);
}

bool CScroll::OnClickDec(void) {

  if (!CurrPos(m_curr_pos - 1))
    return (true);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_SCROLL_DEC, m_id, 0.0, m_name);

  return (true);
}

class CScrollV : public CScroll {
public:
  CScrollV(void);
  ~CScrollV(void);

protected:
  virtual bool CreateInc(void);
  virtual bool CreateDec(void);
  virtual bool CreateThumb(void);

  virtual bool OnResize(void);
  virtual bool OnChangePos(void);

  virtual bool OnThumbDragStart(void);
  virtual bool OnThumbDragProcess(void);
  virtual bool OnThumbDragEnd(void);

  virtual int CalcPos(const int coord);
};

CScrollV::CScrollV(void) {
}

CScrollV::~CScrollV(void) {
}

bool CScrollV::CreateInc(void) {

  int x1 = CONTROLS_BORDER_WIDTH;
  int y1 = Height() - CONTROLS_SCROLL_SIZE + CONTROLS_BORDER_WIDTH;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_inc.Create(m_chart_id, m_name + "Inc", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_inc.BmpNames("::res\Down.bmp"))
    return (false);
  if (!Add(m_inc))
    return (false);

  m_inc.PropFlags(WND_PROP_FLAG_CLICKS_BY_PRESS);

  return (true);
}

bool CScrollV::CreateDec(void) {

  int x1 = CONTROLS_BORDER_WIDTH;
  int y1 = CONTROLS_BORDER_WIDTH;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_dec.Create(m_chart_id, m_name + "Dec", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_dec.BmpNames("::res\Up.bmp"))
    return (false);
  if (!Add(m_dec))
    return (false);

  m_dec.PropFlags(WND_PROP_FLAG_CLICKS_BY_PRESS);

  return (true);
}

bool CScrollV::CreateThumb(void) {

  int x1 = CONTROLS_BORDER_WIDTH;
  int y1 = CONTROLS_SCROLL_SIZE - CONTROLS_BORDER_WIDTH;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_SCROLL_THUMB_SIZE;

  if (!m_thumb.Create(m_chart_id, m_name + "Thumb", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_thumb.BmpNames("::res\ThumbVert.bmp"))
    return (false);
  if (!Add(m_thumb))
    return (false);
  m_thumb.PropFlags(WND_PROP_FLAG_CAN_DRAG);

  return (true);
}

bool CScrollV::OnChangePos(void) {

  if (m_max_pos - m_min_pos <= 0)
    return (Visible(false));
  else if (!Visible(true))
    return (false);

  int steps = m_max_pos - m_min_pos;
  int min_coord = m_dec.Bottom();
  int max_coord = m_inc.Top() - m_thumb.Height();
  int new_coord = min_coord + (max_coord - min_coord) * m_curr_pos / steps;

  return (m_thumb.Move(m_thumb.Left(), new_coord));
}

bool CScrollV::OnResize(void) {

  if (Width() != CONTROLS_SCROLL_SIZE)
    m_rect.Width(CONTROLS_SCROLL_SIZE);

  if (!m_back.Size(Size()))
    return (false);

  if (!m_inc.Move(m_inc.Left(), Bottom() - CONTROLS_SCROLL_SIZE))
    return (false);

  return (OnChangePos());
}

bool CScrollV::OnThumbDragStart(void) {
  if (m_drag_object == NULL) {
    m_drag_object = new CDragWnd;
    if (m_drag_object == NULL)
      return (false);
  }

  int x1 = m_thumb.Left() - CONTROLS_DRAG_SPACING;
  int y1 = m_thumb.Top() - CONTROLS_DRAG_SPACING;
  int x2 = m_thumb.Right() + CONTROLS_DRAG_SPACING;
  int y2 = m_thumb.Bottom() + CONTROLS_DRAG_SPACING;

  m_drag_object.Create(m_chart_id, "", m_subwin, x1, y1, x2, y2);
  m_drag_object.PropFlags(WND_PROP_FLAG_CAN_DRAG);

  m_drag_object.Limits(x1, m_dec.Bottom() - CONTROLS_DRAG_SPACING, x2,
                       m_inc.Top() + CONTROLS_DRAG_SPACING);

  m_drag_object.MouseX(m_thumb.MouseX());
  m_drag_object.MouseY(m_thumb.MouseY());
  m_drag_object.MouseFlags(m_thumb.MouseFlags());

  return (true);
}

bool CScrollV::OnThumbDragProcess(void) {

  if (m_drag_object == NULL)
    return (false);

  int x = m_drag_object.Left() + CONTROLS_DRAG_SPACING;
  int y = m_drag_object.Top() + CONTROLS_DRAG_SPACING;

  int new_pos = CalcPos(y);
  if (new_pos != m_curr_pos) {
    ushort event_id = (m_curr_pos < new_pos) ? ON_SCROLL_INC : ON_SCROLL_DEC;
    m_curr_pos = new_pos;
    EventChartCustom(CONTROLS_SELF_MESSAGE, event_id, m_id, 0.0, m_name);
  }

  m_thumb.Move(x, y);

  return (true);
}

bool CScrollV::OnThumbDragEnd(void) {
  if (m_drag_object != NULL) {
    m_thumb.MouseFlags(m_drag_object.MouseFlags());
    delete m_drag_object;
    m_drag_object = NULL;
  }

  return (m_thumb.Pressed(false));
}

int CScrollV::CalcPos(const int coord) {

  int steps = m_max_pos - m_min_pos;
  int min_coord = m_dec.Bottom();
  int max_coord = m_inc.Top() - m_thumb.Height();

  if (max_coord == min_coord)
    return (0);
  if (coord < min_coord || coord > max_coord)
    return (m_curr_pos);

  int new_pos = (int)MathRound(
      (((double)(coord - min_coord)) / (max_coord - min_coord)) * steps);

  return (new_pos);
}

class CScrollH : public CScroll {
public:
  CScrollH(void);
  ~CScrollH(void);

protected:
  virtual bool CreateInc(void);
  virtual bool CreateDec(void);
  virtual bool CreateThumb(void);

  virtual bool OnResize(void);
  virtual bool OnChangePos(void);

  virtual bool OnThumbDragStart(void);
  virtual bool OnThumbDragProcess(void);
  virtual bool OnThumbDragEnd(void);

  virtual int CalcPos(const int coord);
};

CScrollH::CScrollH(void) {
}

CScrollH::~CScrollH(void) {
}

bool CScrollH::CreateInc(void) {

  int x1 = Width() - CONTROLS_SCROLL_SIZE + CONTROLS_BORDER_WIDTH;
  int y1 = CONTROLS_BORDER_WIDTH;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_inc.Create(m_chart_id, m_name + "Inc", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_inc.BmpNames("::res\Right.bmp"))
    return (false);
  if (!Add(m_inc))
    return (false);

  m_inc.PropFlags(WND_PROP_FLAG_CLICKS_BY_PRESS);

  return (true);
}

bool CScrollH::CreateDec(void) {

  int x1 = CONTROLS_BORDER_WIDTH;
  int y1 = CONTROLS_BORDER_WIDTH;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_dec.Create(m_chart_id, m_name + "Dec", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_dec.BmpNames("::res\Left.bmp"))
    return (false);
  if (!Add(m_dec))
    return (false);

  m_dec.PropFlags(WND_PROP_FLAG_CLICKS_BY_PRESS);

  return (true);
}

bool CScrollH::CreateThumb(void) {

  int x1 = CONTROLS_SCROLL_SIZE - CONTROLS_BORDER_WIDTH;
  int y1 = CONTROLS_BORDER_WIDTH;
  int x2 = x1 + CONTROLS_SCROLL_THUMB_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_thumb.Create(m_chart_id, m_name + "Thumb", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_thumb.BmpNames("::res\ThumbHor.bmp"))
    return (false);
  if (!Add(m_thumb))
    return (false);
  m_thumb.PropFlags(WND_PROP_FLAG_CAN_DRAG);

  return (true);
}

bool CScrollH::OnChangePos(void) {

  if (m_max_pos - m_min_pos <= 0)
    return (Visible(false));
  else if (!Visible(true))
    return (false);

  int steps = m_max_pos - m_min_pos;
  int min_coord = m_dec.Right();
  int max_coord = m_inc.Left() - m_thumb.Width();
  int new_coord = min_coord + (max_coord - min_coord) * m_curr_pos / steps;

  return (m_thumb.Move(new_coord, m_thumb.Top()));
}

bool CScrollH::OnResize(void) {

  if (Height() != CONTROLS_SCROLL_SIZE)
    m_rect.Height(CONTROLS_SCROLL_SIZE);

  if (!m_back.Size(Size()))
    return (false);

  if (!m_inc.Move(Right() - CONTROLS_SCROLL_SIZE, m_inc.Top()))
    return (false);

  return (OnChangePos());
}

bool CScrollH::OnThumbDragStart(void) {
  if (m_drag_object == NULL) {
    m_drag_object = new CDragWnd;
    if (m_drag_object == NULL)
      return (false);
  }

  int x1 = m_thumb.Left() - CONTROLS_DRAG_SPACING;
  int y1 = m_thumb.Top() - CONTROLS_DRAG_SPACING;
  int x2 = m_thumb.Right() + CONTROLS_DRAG_SPACING;
  int y2 = m_thumb.Bottom() + CONTROLS_DRAG_SPACING;

  m_drag_object.Create(m_chart_id, "", m_subwin, x1, y1, x2, y2);
  m_drag_object.PropFlags(WND_PROP_FLAG_CAN_DRAG);

  m_drag_object.Limits(m_dec.Right() - CONTROLS_DRAG_SPACING, y1,
                       m_inc.Left() + CONTROLS_DRAG_SPACING, y2);

  m_drag_object.MouseX(m_thumb.MouseX());
  m_drag_object.MouseY(m_thumb.MouseY());
  m_drag_object.MouseFlags(m_thumb.MouseFlags());

  return (true);
}

bool CScrollH::OnThumbDragProcess(void) {

  if (m_drag_object == NULL)
    return (false);

  int x = m_drag_object.Left() + CONTROLS_DRAG_SPACING;
  int y = m_drag_object.Top() + CONTROLS_DRAG_SPACING;

  int new_pos = CalcPos(x);
  if (new_pos != m_curr_pos) {
    ushort event_id = (m_curr_pos < new_pos) ? ON_SCROLL_INC : ON_SCROLL_DEC;
    m_curr_pos = new_pos;
    EventChartCustom(CONTROLS_SELF_MESSAGE, event_id, m_id, 0.0, m_name);
  }

  m_thumb.Move(x, y);

  return (true);
}

bool CScrollH::OnThumbDragEnd(void) {
  if (m_drag_object != NULL) {
    m_thumb.MouseFlags(m_drag_object.MouseFlags());
    delete m_drag_object;
    m_drag_object = NULL;
  }

  return (m_thumb.Pressed(false));
}

int CScrollH::CalcPos(const int coord) {

  int steps = m_max_pos - m_min_pos;
  int min_coord = m_dec.Right();
  int max_coord = m_inc.Left() - m_thumb.Width();

  if (max_coord == min_coord)
    return (0);
  if (coord < min_coord || coord > max_coord)
    return (m_curr_pos);

  int new_pos = (int)MathRound(
      (((double)(coord - min_coord)) / (max_coord - min_coord)) * steps);

  return (new_pos);
}

#endif
