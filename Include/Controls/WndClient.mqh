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

  virtual bool ColorBackground(const color value);
  virtual bool ColorBorder(const color value);
  virtual bool BorderType(const ENUM_BORDER_TYPE flag);

  virtual bool VScrolled(void);
  virtual bool VScrolled(const bool flag);
  virtual bool HScrolled(void);
  virtual bool HScrolled(const bool flag);

  virtual long Id(const long id);
  virtual long Id(void) const;

  virtual bool Show(void);

protected:
  virtual bool CreateBack(void);
  virtual bool CreateScrollV(void);
  virtual bool CreateScrollH(void);

  virtual bool OnResize(void);

  virtual bool OnVScrollShow(void);
  virtual bool OnVScrollHide(void);
  virtual bool OnHScrollShow(void);
  virtual bool OnHScrollHide(void);
  virtual bool OnScrollLineDown(void);
  virtual bool OnScrollLineUp(void);
  virtual bool OnScrollLineLeft(void);
  virtual bool OnScrollLineRight(void);

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

#endif
