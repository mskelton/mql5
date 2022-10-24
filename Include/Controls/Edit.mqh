#ifndef EDIT_H
#define EDIT_H

#include "WndObj.mqh"
#include <ChartObjects/ChartObjectsTxtControls.mqh>

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

  bool ReadOnly(void) const;
  bool ReadOnly(const bool flag);
  ENUM_ALIGN_MODE TextAlign(void) const;
  bool TextAlign(const ENUM_ALIGN_MODE align);

  string Text(void) const;
  bool Text(const string value);

protected:
  virtual bool OnObjectEndEdit(void);

  virtual bool OnSetText(void);
  virtual bool OnSetColor(void);
  virtual bool OnSetColorBackground(void);
  virtual bool OnSetColorBorder(void);
  virtual bool OnSetFont(void);
  virtual bool OnSetFontSize(void);
  virtual bool OnSetZOrder(void);

  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnResize(void);
  virtual bool OnChange(void);
  virtual bool OnClick(void);
};

#endif
