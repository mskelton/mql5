#ifndef BUTTON_H
#define BUTTON_H

#include "WndObj.mqh"
#include <ChartObjects\ChartObjectsTxtControls.mqh>

class CButton : public CWndObj {
private:
  CChartObjectButton m_button;

public:
  CButton(void);
  ~CButton(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  bool Pressed(void) const {
    return (m_button.State());
  }
  bool Pressed(const bool pressed) {
    return (m_button.State(pressed));
  }

  bool Locking(void) const {
    return (IS_CAN_LOCK);
  }
  void Locking(const bool flag);

protected:
  virtual bool OnSetText(void) {
    return (m_button.Description(m_text));
  }
  virtual bool OnSetColor(void) {
    return (m_button.Color(m_color));
  }
  virtual bool OnSetColorBackground(void) {
    return (m_button.BackColor(m_color_background));
  }
  virtual bool OnSetColorBorder(void) {
    return (m_button.BorderColor(m_color_border));
  }
  virtual bool OnSetFont(void) {
    return (m_button.Font(m_font));
  }
  virtual bool OnSetFontSize(void) {
    return (m_button.FontSize(m_font_size));
  }

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnResize(void);

  virtual bool OnMouseDown(void);
  virtual bool OnMouseUp(void);
};

CButton::CButton(void) {
  m_color = CONTROLS_BUTTON_COLOR;
  m_color_background = CONTROLS_BUTTON_COLOR_BG;
  m_color_border = CONTROLS_BUTTON_COLOR_BORDER;
}

CButton::~CButton(void) {}

bool CButton::Create(const long chart, const string name, const int subwin,
                     const int x1, const int y1, const int x2, const int y2) {

  if (!CWndObj::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!m_button.Create(chart, name, subwin, x1, y1, Width(), Height()))
    return (false);

  return (OnChange());
}

void CButton::Locking(const bool flag) {
  if (flag)
    PropFlagsSet(WND_PROP_FLAG_CAN_LOCK);
  else
    PropFlagsReset(WND_PROP_FLAG_CAN_LOCK);
}

bool CButton::OnCreate(void) {

  return (m_button.Create(m_chart_id, m_name, m_subwin, m_rect.left, m_rect.top,
                          m_rect.Width(), m_rect.Height()));
}

bool CButton::OnShow(void) {
  return (m_button.Timeframes(OBJ_ALL_PERIODS));
}

bool CButton::OnHide(void) {
  return (m_button.Timeframes(OBJ_NO_PERIODS));
}

bool CButton::OnMove(void) {

  return (m_button.X_Distance(m_rect.left) && m_button.Y_Distance(m_rect.top));
}

bool CButton::OnResize(void) {

  return (m_button.X_Size(m_rect.Width()) && m_button.Y_Size(m_rect.Height()));
}

bool CButton::OnMouseDown(void) {
  if (!IS_CAN_LOCK)
    Pressed(!Pressed());

  return (CWnd::OnMouseDown());
}

bool CButton::OnMouseUp(void) {

  if (m_button.State() && !IS_CAN_LOCK)
    m_button.State(false);

  return (CWnd::OnMouseUp());
}

#endif
