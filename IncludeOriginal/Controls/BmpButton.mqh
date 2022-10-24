#ifndef BMP_BUTTON_H
#define BMP_BUTTON_H

#include "WndObj.mqh"
#include <ChartObjects\ChartObjectsBmpControls.mqh>

class CBmpButton : public CWndObj {
private:
  CChartObjectBmpLabel m_button;

  int m_border;
  string m_bmp_off_name;
  string m_bmp_on_name;
  string m_bmp_passive_name;
  string m_bmp_active_name;

public:
  CBmpButton(void);
  ~CBmpButton(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  int Border(void) const {
    return (m_border);
  }
  bool Border(const int value);
  bool BmpNames(const string off = "", const string on = "");
  string BmpOffName(void) const {
    return (m_bmp_off_name);
  }
  bool BmpOffName(const string name);
  string BmpOnName(void) const {
    return (m_bmp_on_name);
  }
  bool BmpOnName(const string name);
  string BmpPassiveName(void) const {
    return (m_bmp_passive_name);
  }
  bool BmpPassiveName(const string name);
  string BmpActiveName(void) const {
    return (m_bmp_active_name);
  }
  bool BmpActiveName(const string name);

  bool Pressed(void) const {
    return (m_button.State());
  }
  bool Pressed(const bool pressed) {
    return (m_button.State(pressed));
  }

  bool Locking(void) const {
    return (IS_CAN_LOCK);
  }
  void Locking(const bool locking);

protected:
  virtual bool OnSetZOrder(void) {
    return (m_button.Z_Order(m_zorder));
  }

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnChange(void);

  virtual bool OnActivate(void);
  virtual bool OnDeactivate(void);
  virtual bool OnMouseDown(void);
  virtual bool OnMouseUp(void);
};

CBmpButton::CBmpButton(void)
    : m_border(0), m_bmp_off_name(NULL), m_bmp_on_name(NULL),
      m_bmp_passive_name(NULL), m_bmp_active_name(NULL) {}

CBmpButton::~CBmpButton(void) {}

bool CBmpButton::Create(const long chart, const string name, const int subwin,
                        const int x1, const int y1, const int x2,
                        const int y2) {

  if (!CWndObj::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!m_button.Create(chart, name, subwin, x1, y1))
    return (false);

  return (OnChange());
}

bool CBmpButton::Border(const int value) {

  m_border = value;

  return (m_button.Width(value));
}

bool CBmpButton::BmpNames(const string off, const string on) {

  m_bmp_off_name = off;
  m_bmp_on_name = on;

  if (!m_button.BmpFileOff(off))
    return (false);
  if (!m_button.BmpFileOn(on))
    return (false);

  return (true);
}

bool CBmpButton::BmpOffName(const string name) {

  m_bmp_off_name = name;

  if (!m_button.BmpFileOff(name))
    return (false);

  Width(m_button.X_Size());
  Height(m_button.Y_Size());

  return (true);
}

bool CBmpButton::BmpOnName(const string name) {

  m_bmp_on_name = name;

  if (!m_button.BmpFileOn(name))
    return (false);

  Width(m_button.X_Size());
  Height(m_button.Y_Size());

  return (true);
}

bool CBmpButton::BmpPassiveName(const string name) {

  m_bmp_passive_name = name;

  if (!IS_ACTIVE)
    return (BmpOffName(name));

  return (true);
}

bool CBmpButton::BmpActiveName(const string name) {

  m_bmp_active_name = name;

  if (IS_ACTIVE)
    return (BmpOffName(name));

  return (true);
}

void CBmpButton::Locking(const bool flag) {
  if (flag)
    PropFlagsSet(WND_PROP_FLAG_CAN_LOCK);
  else
    PropFlagsReset(WND_PROP_FLAG_CAN_LOCK);
}

bool CBmpButton::OnCreate(void) {

  return (
      m_button.Create(m_chart_id, m_name, m_subwin, m_rect.left, m_rect.top));
}

bool CBmpButton::OnShow(void) {
  return (m_button.Timeframes(OBJ_ALL_PERIODS));
}

bool CBmpButton::OnHide(void) {
  return (m_button.Timeframes(OBJ_NO_PERIODS));
}

bool CBmpButton::OnMove(void) {

  return (m_button.X_Distance(m_rect.left) && m_button.Y_Distance(m_rect.top));
}

bool CBmpButton::OnChange(void) {

  return (m_button.Width(m_border) && m_button.BmpFileOff(m_bmp_off_name) &&
          m_button.BmpFileOn(m_bmp_on_name));
}

bool CBmpButton::OnActivate(void) {
  if (m_bmp_active_name != NULL)
    BmpOffName(m_bmp_active_name);

  return (true);
}

bool CBmpButton::OnDeactivate(void) {
  if (m_bmp_passive_name != NULL)
    BmpOffName(m_bmp_passive_name);
  if (!IS_CAN_LOCK)
    Pressed(false);

  return (true);
}

bool CBmpButton::OnMouseDown(void) {
  if (!IS_CAN_LOCK)
    Pressed(!Pressed());

  return (CWnd::OnMouseDown());
}

bool CBmpButton::OnMouseUp(void) {

  if (m_button.State() && !IS_CAN_LOCK)
    m_button.State(false);

  return (CWnd::OnMouseUp());
}

#endif
