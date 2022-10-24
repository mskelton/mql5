#ifndef EDIT_H
#define EDIT_H

#include "WndObj.mqh"
#include <ChartObjects\ChartObjectsTxtControls.mqh>

class CEdit : public CWndObj {
private:
  CChartObjectEdit m_edit;

  bool m_read_only;
  ENUM_ALIGN_MODE m_align_mode;

public:
  CEdit(void);
  ~CEdit(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  bool ReadOnly(void) const {
    return (m_read_only);
  }
  bool ReadOnly(const bool flag);
  ENUM_ALIGN_MODE TextAlign(void) const {
    return (m_align_mode);
  }
  bool TextAlign(const ENUM_ALIGN_MODE align);

  string Text(void) const {
    return (m_edit.Description());
  }
  bool Text(const string value) {
    return (CWndObj::Text(value));
  }

protected:
  virtual bool OnObjectEndEdit(void);

  virtual bool OnSetText(void) {
    return (m_edit.Description(m_text));
  }
  virtual bool OnSetColor(void) {
    return (m_edit.Color(m_color));
  }
  virtual bool OnSetColorBackground(void) {
    return (m_edit.BackColor(m_color_background));
  }
  virtual bool OnSetColorBorder(void) {
    return (m_edit.BorderColor(m_color_border));
  }
  virtual bool OnSetFont(void) {
    return (m_edit.Font(m_font));
  }
  virtual bool OnSetFontSize(void) {
    return (m_edit.FontSize(m_font_size));
  }
  virtual bool OnSetZOrder(void) {
    return (m_edit.Z_Order(m_zorder));
  }

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnResize(void);
  virtual bool OnChange(void);
  virtual bool OnClick(void);
};

bool CEdit::OnEvent(const int id, const long &lparam, const double &dparam,
                    const string &sparam) {
  if (m_name == sparam && id == CHARTEVENT_OBJECT_ENDEDIT)
    return (OnObjectEndEdit());

  return (CWndObj::OnEvent(id, lparam, dparam, sparam));
}

CEdit::CEdit(void) : m_read_only(false), m_align_mode(ALIGN_LEFT) {
  m_color = CONTROLS_EDIT_COLOR;
  m_color_background = CONTROLS_EDIT_COLOR_BG;
  m_color_border = CONTROLS_EDIT_COLOR_BORDER;
}

CEdit::~CEdit(void) {
}

bool CEdit::Create(const long chart, const string name, const int subwin,
                   const int x1, const int y1, const int x2, const int y2) {

  if (!CWndObj::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!m_edit.Create(chart, name, subwin, x1, y1, Width(), Height()))
    return (false);

  return (OnChange());
}

bool CEdit::ReadOnly(const bool flag) {

  m_read_only = flag;

  return (m_edit.ReadOnly(flag));
}

bool CEdit::TextAlign(const ENUM_ALIGN_MODE align) {

  m_align_mode = align;

  return (m_edit.TextAlign(align));
}

bool CEdit::OnCreate(void) {

  return (m_edit.Create(m_chart_id, m_name, m_subwin, m_rect.left, m_rect.top,
                        m_rect.Width(), m_rect.Height()));
}

bool CEdit::OnShow(void) {
  return (m_edit.Timeframes(OBJ_ALL_PERIODS));
}

bool CEdit::OnHide(void) {
  return (m_edit.Timeframes(OBJ_NO_PERIODS));
}

bool CEdit::OnMove(void) {

  return (m_edit.X_Distance(m_rect.left) && m_edit.Y_Distance(m_rect.top));
}

bool CEdit::OnResize(void) {

  return (m_edit.X_Size(m_rect.Width()) && m_edit.Y_Size(m_rect.Height()));
}

bool CEdit::OnChange(void) {

  return (CWndObj::OnChange() && ReadOnly(m_read_only) &&
          TextAlign(m_align_mode));
}

bool CEdit::OnObjectEndEdit(void) {

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_END_EDIT, m_id, 0.0, m_name);

  return (true);
}

bool CEdit::OnClick(void) {

  if (!m_read_only) {
    EventChartCustom(CONTROLS_SELF_MESSAGE, ON_START_EDIT, m_id, 0.0, m_name);

    return (true);
  }

  return (CWnd::OnClick());
}

#endif
