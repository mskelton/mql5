#ifndef PANEL_H
#define PANEL_H

#include "WndObj.mqh"
#include <ChartObjects\ChartObjectsTxtControls.mqh>

class CPanel : public CWndObj {
private:
  CChartObjectRectLabel m_rectangle;

  ENUM_BORDER_TYPE m_border;

public:
  CPanel(void);
  ~CPanel(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  ENUM_BORDER_TYPE BorderType(void) const {
    return (m_border);
  }
  bool BorderType(const ENUM_BORDER_TYPE type);

protected:
  virtual bool OnSetText(void) {
    return (m_rectangle.Description(m_text));
  }
  virtual bool OnSetColorBackground(void) {
    return (m_rectangle.BackColor(m_color_background));
  }
  virtual bool OnSetColorBorder(void) {
    return (m_rectangle.Color(m_color_border));
  }

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnResize(void);
  virtual bool OnChange(void);
};

CPanel::CPanel(void) : m_border(BORDER_FLAT) {
}

CPanel::~CPanel(void) {
}

bool CPanel::Create(const long chart, const string name, const int subwin,
                    const int x1, const int y1, const int x2, const int y2) {

  if (!CWndObj::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!m_rectangle.Create(chart, name, subwin, x1, y1, Width(), Height()))
    return (false);

  return (OnChange());
}

bool CPanel::BorderType(const ENUM_BORDER_TYPE type) {

  m_border = type;

  return (m_rectangle.BorderType(type));
}

bool CPanel::OnCreate(void) {

  return (m_rectangle.Create(m_chart_id, m_name, m_subwin, m_rect.left,
                             m_rect.top, m_rect.Width(), m_rect.Height()));
}

bool CPanel::OnShow(void) {
  return (m_rectangle.Timeframes(OBJ_ALL_PERIODS));
}

bool CPanel::OnHide(void) {
  return (m_rectangle.Timeframes(OBJ_NO_PERIODS));
}

bool CPanel::OnMove(void) {

  return (m_rectangle.X_Distance(m_rect.left) &&
          m_rectangle.Y_Distance(m_rect.top));
}

bool CPanel::OnResize(void) {

  return (m_rectangle.X_Size(m_rect.Width()) &&
          m_rectangle.Y_Size(m_rect.Height()));
}

bool CPanel::OnChange(void) {

  return (CWndObj::OnChange() && m_rectangle.BorderType(m_border));
}

#endif
