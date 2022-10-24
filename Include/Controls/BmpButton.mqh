#ifndef BMP_BUTTON_H
#define BMP_BUTTON_H

#include "WndObj.mqh"
#include <ChartObjects/ChartObjectsBmpControls.mqh>

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

  int Border(void) const;
  bool Border(const int value);
  bool BmpNames(const string off = "", const string on = "");
  string BmpOffName(void) const;
  bool BmpOffName(const string name);
  string BmpOnName(void) const;
  bool BmpOnName(const string name);
  string BmpPassiveName(void) const;
  bool BmpPassiveName(const string name);
  string BmpActiveName(void) const;
  bool BmpActiveName(const string name);

  bool Pressed(void) const;
  bool Pressed(const bool pressed);

  bool Locking(void) const;
  void Locking(const bool locking);

protected:
  virtual bool OnSetZOrder(void);

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

#endif
