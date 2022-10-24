#ifndef WND_CLIENT_H
#define WND_CLIENT_H

#include "Panel.mqh"
#include "Scrolls.mqh"
#include "WndContainer.mqh"

class CWndClient : public CWndContainer {
protected:
  bool m_v_scrolled;
  bool m_h_scrolled;

  CPanel m_background;
  CScrollV m_scroll_v;
  CScrollH m_scroll_h;

public:
  CWndClient(void);
  ~CWndClient(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  virtual bool ColorBackground(const color value) {
    return (m_background.ColorBackground(value));
  }
  virtual bool ColorBorder(const color value) {
    return (m_background.ColorBorder(value));
  }
  virtual bool BorderType(const ENUM_BORDER_TYPE flag) {
    return (m_background.BorderType(flag));
  }

  virtual bool VScrolled(void) {
    return (m_v_scrolled);
  }
  virtual bool VScrolled(const bool flag);
  virtual bool HScrolled(void) {
    return (m_h_scrolled);
  }
  virtual bool HScrolled(const bool flag);

  virtual long Id(const long id);
  virtual long Id(void) const {
    return (CWnd::Id());
  }

  virtual bool Show(void);

protected:
  virtual bool CreateBack(void);
  virtual bool CreateScrollV(void);
  virtual bool CreateScrollH(void);

  virtual bool OnResize(void);

  virtual bool OnVScrollShow(void) {
    return (true);
  }
  virtual bool OnVScrollHide(void) {
    return (true);
  }
  virtual bool OnHScrollShow(void) {
    return (true);
  }
  virtual bool OnHScrollHide(void) {
    return (true);
  }
  virtual bool OnScrollLineDown(void) {
    return (true);
  }
  virtual bool OnScrollLineUp(void) {
    return (true);
  }
  virtual bool OnScrollLineLeft(void) {
    return (true);
  }
  virtual bool OnScrollLineRight(void) {
    return (true);
  }

  virtual bool Rebound(const CRect &rect);
};

EVENT_MAP_BEGIN(CWndClient)
ON_NAMED_EVENT(ON_SHOW, m_scroll_v, OnVScrollShow)
ON_NAMED_EVENT(ON_HIDE, m_scroll_v, OnVScrollHide)
ON_EVENT(ON_SCROLL_DEC, m_scroll_v, OnScrollLineUp)
ON_EVENT(ON_SCROLL_INC, m_scroll_v, OnScrollLineDown)
ON_NAMED_EVENT(ON_SHOW, m_scroll_h, OnHScrollShow)
ON_NAMED_EVENT(ON_HIDE, m_scroll_h, OnHScrollHide)
ON_EVENT(ON_SCROLL_DEC, m_scroll_h, OnScrollLineLeft)
ON_EVENT(ON_SCROLL_INC, m_scroll_h, OnScrollLineRight)
EVENT_MAP_END(CWndContainer)

CWndClient::CWndClient(void) : m_v_scrolled(false), m_h_scrolled(false) {}

CWndClient::~CWndClient(void) {}

bool CWndClient::Create(const long chart, const string name, const int subwin,
                        const int x1, const int y1, const int x2,
                        const int y2) {

  if (!CWndContainer::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!CreateBack())
    return (false);
  if (m_v_scrolled && !CreateScrollV())
    return (false);
  if (m_h_scrolled && !CreateScrollH())
    return (false);

  return (true);
}

bool CWndClient::CreateBack(void) {

  if (!m_background.Create(m_chart_id, m_name + "Back", m_subwin, 0, 0, Width(),
                           Height()))
    return (false);
  if (!m_background.ColorBorder(CONTROLS_CLIENT_COLOR_BORDER))
    return (false);
  if (!m_background.ColorBackground(CONTROLS_CLIENT_COLOR_BG))
    return (false);
  if (!Add(m_background))
    return (false);

  return (true);
}

bool CWndClient::CreateScrollV(void) {

  int x1 = Width() - CONTROLS_SCROLL_SIZE - CONTROLS_BORDER_WIDTH;
  int y1 = CONTROLS_BORDER_WIDTH;
  int x2 = Width() - CONTROLS_BORDER_WIDTH;
  int y2 = Height() - CONTROLS_BORDER_WIDTH;
  if (m_h_scrolled)
    y2 -= CONTROLS_SCROLL_SIZE;

  if (!m_scroll_v.Create(m_chart_id, m_name + "VScroll", m_subwin, x1, y1, x2,
                         y2))
    return (false);
  if (!Add(m_scroll_v))
    return (false);

  return (true);
}

bool CWndClient::CreateScrollH(void) {

  int x1 = CONTROLS_BORDER_WIDTH;
  int y1 = Height() - CONTROLS_SCROLL_SIZE - CONTROLS_BORDER_WIDTH;
  int x2 = Width() - CONTROLS_BORDER_WIDTH;
  int y2 = Height() - CONTROLS_BORDER_WIDTH;
  if (m_v_scrolled)
    x2 -= CONTROLS_SCROLL_SIZE;

  if (!m_scroll_h.Create(m_chart_id, m_name + "HScroll", m_subwin, x1, y1, x2,
                         y2))
    return (false);
  if (!Add(m_scroll_h))
    return (false);

  return (true);
}

bool CWndClient::VScrolled(const bool flag) {
  if (m_v_scrolled == flag)
    return (true);

  int d_size = 0;
  if (flag) {

    if (!CreateScrollV())
      return (false);

    d_size = -CONTROLS_SCROLL_SIZE;
  } else {

    m_scroll_v.Destroy();
    if (!Delete(m_scroll_v))
      return (false);

    d_size = CONTROLS_SCROLL_SIZE;
  }
  m_v_scrolled = flag;

  if (m_h_scrolled) {
    if (!m_scroll_h.Width(m_scroll_h.Width() + d_size))
      return (false);
  }

  return (true);
}

bool CWndClient::HScrolled(const bool flag) {
  if (m_h_scrolled == flag)
    return (true);

  int d_size = 0;
  if (flag) {

    if (!CreateScrollH())
      return (false);

    d_size = -CONTROLS_SCROLL_SIZE;
  } else {

    m_scroll_h.Destroy();
    if (!Delete(m_scroll_h))
      return (false);

    d_size = CONTROLS_SCROLL_SIZE;
  }
  m_h_scrolled = flag;

  if (m_v_scrolled) {
    if (!m_scroll_v.Height(m_scroll_v.Height() + d_size))
      return (false);
  }

  return (true);
}

long CWndClient::Id(const long id) {

  long id_used = CWndContainer::Id(id);

  if (!m_v_scrolled)
    id_used += m_scroll_v.Id(id + id_used);
  if (!m_h_scrolled)
    id_used += m_scroll_h.Id(id + id_used);

  return (id_used);
}

bool CWndClient::Show(void) {

  CWndContainer::Show();

  if (!m_v_scrolled)
    m_scroll_v.Hide();
  if (!m_h_scrolled)
    m_scroll_h.Hide();

  return (true);
}

bool CWndClient::OnResize(void) {

  if (!CWndContainer::OnResize())
    return (false);

  int d_size = 0;
  m_background.Width(Width());
  m_background.Height(Height());

  if (m_v_scrolled) {

    m_scroll_v.Move(Right() - CONTROLS_SCROLL_SIZE, Top());

    d_size = (m_h_scrolled) ? CONTROLS_SCROLL_SIZE : 0;
    m_scroll_v.Height(Height() - d_size);
  }
  if (m_h_scrolled) {

    m_scroll_h.Move(Left(), Bottom() - CONTROLS_SCROLL_SIZE);

    d_size = (m_v_scrolled) ? CONTROLS_SCROLL_SIZE : 0;
    m_scroll_h.Width(Width() - d_size);
  }

  return (true);
}

bool CWndClient::Rebound(const CRect &rect) {
  m_rect.SetBound(rect);

  return (OnResize());
}

#endif
