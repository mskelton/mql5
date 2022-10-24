#ifndef PANEL_H
#define PANEL_H

#include "WndObj.mqh"
#include <ChartObjects/ChartObjectsTxtControls.mqh>

class CPanel : public CWndObj {
private:
  CChartObjectRectLabel m_rectangle;

  ENUM_BORDER_TYPE m_border;

public:
  CPanel(void);
  ~CPanel(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  ENUM_BORDER_TYPE BorderType(void) const;
  bool BorderType(const ENUM_BORDER_TYPE type);

protected:
  virtual bool OnSetText(void);
  virtual bool OnSetColorBackground(void);
  virtual bool OnSetColorBorder(void);

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnResize(void);
  virtual bool OnChange(void);
};

#endif
