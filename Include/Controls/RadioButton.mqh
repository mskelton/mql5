#ifndef RADIO_BUTTON_H
#define RADIO_BUTTON_H

#include "BmpButton.mqh"
#include "Edit.mqh"
#include "WndContainer.mqh"

class CRadioButton : public CWndContainer {
private:
  CBmpButton m_button;
  CEdit m_label;

public:
  CRadioButton(void);
  ~CRadioButton(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  string Text(void) const ;
  bool Text(const string value) ;
  color Color(void) const ;
  bool Color(const color value) ;

  bool State(void) const ;
  bool State(const bool flag) ;

protected:
  virtual bool CreateButton(void);
  virtual bool CreateLabel(void);

  virtual bool OnClickButton(void);
  virtual bool OnClickLabel(void);
};

EVENT_MAP_BEGIN(CRadioButton)
ON_EVENT(ON_CLICK, m_button, OnClickButton)
ON_EVENT(ON_CLICK, m_label, OnClickLabel)
EVENT_MAP_END(CWndContainer)








#endif
