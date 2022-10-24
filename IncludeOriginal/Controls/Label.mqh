#ifndef LABEL_H
#define LABEL_H

#include "WndObj.mqh"
#include <ChartObjects\ChartObjectsTxtControls.mqh>

class CLabel : public CWndObj {
private:
  CChartObjectLabel m_label;

public:
  CLabel(void);
  ~CLabel(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

protected:
  virtual bool OnSetText(void) {
    return (m_label.Description(m_text));
  }
  virtual bool OnSetColor(void) {
    return (m_label.Color(m_color));
  }
  virtual bool OnSetFont(void) {
    return (m_label.Font(m_font));
  }
  virtual bool OnSetFontSize(void) {
    return (m_label.FontSize(m_font_size));
  }

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
};

CLabel::CLabel(void) {
  m_color = CONTROLS_LABEL_COLOR;
}

CLabel::~CLabel(void) {}

bool CLabel::Create(const long chart, const string name, const int subwin,
                    const int x1, const int y1, const int x2, const int y2) {

  if (!CWndObj::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!m_label.Create(chart, name, subwin, x1, y1))
    return (false);

  return (OnChange());
}

bool CLabel::OnCreate(void) {

  return (
      m_label.Create(m_chart_id, m_name, m_subwin, m_rect.left, m_rect.top));
}

bool CLabel::OnShow(void) {
  return (m_label.Timeframes(OBJ_ALL_PERIODS));
}

bool CLabel::OnHide(void) {
  return (m_label.Timeframes(OBJ_NO_PERIODS));
}

bool CLabel::OnMove(void) {

  return (m_label.X_Distance(m_rect.left) && m_label.Y_Distance(m_rect.top));
}

#endif
