#ifndef BUTTON_H
#define BUTTON_H

#include "WndObj.mqh"
#include <ChartObjects/ChartObjectsTxtControls.mqh>

class CButton : public CWndObj {
private:
  CChartObjectButton m_button;

public:
  CButton(void);
  ~CButton(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  bool Pressed(void) const ;
  bool Pressed(const bool pressed) ;

  bool Locking(void) const ;
  void Locking(const bool flag);

protected:
  virtual bool OnSetText(void) ;
  virtual bool OnSetColor(void) ;
  virtual bool OnSetColorBackground(void) ;
  virtual bool OnSetColorBorder(void) ;
  virtual bool OnSetFont(void) ;
  virtual bool OnSetFontSize(void) ;

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnResize(void);

  virtual bool OnMouseDown(void);
  virtual bool OnMouseUp(void);
};












#endif
