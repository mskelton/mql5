#ifndef LABEL_H
#define LABEL_H

#include "WndObj.mqh"
#include <ChartObjects/ChartObjectsTxtControls.mqh>

class CLabel : public CWndObj {
private:
  CChartObjectLabel m_label;

public:
  CLabel(void);
  ~CLabel(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

protected:
  virtual bool OnSetText(void);
  virtual bool OnSetColor(void);
  virtual bool OnSetFont(void);
  virtual bool OnSetFontSize(void);

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
};

#endif
