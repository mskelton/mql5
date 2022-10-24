#ifndef WND_OBJ_H
#define WND_OBJ_H

#include "Wnd.mqh"

class CWndObj : public CWnd {
private:
  bool m_undeletable;
  bool m_unchangeable;
  bool m_unmoveable;

protected:
  string m_text;
  color m_color;
  color m_color_background;
  color m_color_border;
  string m_font;
  int m_font_size;
  long m_zorder;

public:
  CWndObj(void);
  ~CWndObj(void);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  string Text(void) const ;
  bool Text(const string value);
  color Color(void) const ;
  bool Color(const color value);
  color ColorBackground(void) const ;
  bool ColorBackground(const color value);
  color ColorBorder(void) const ;
  bool ColorBorder(const color value);
  string Font(void) const ;
  bool Font(const string value);
  int FontSize(void) const ;
  bool FontSize(const int value);
  long ZOrder(void) const ;
  bool ZOrder(const long value);

protected:
  virtual bool OnObjectCreate(void);
  virtual bool OnObjectChange(void);
  virtual bool OnObjectDelete(void);
  virtual bool OnObjectDrag(void);

  virtual bool OnSetText(void) ;
  virtual bool OnSetColor(void) ;
  virtual bool OnSetColorBackground(void) ;
  virtual bool OnSetColorBorder(void) ;
  virtual bool OnSetFont(void) ;
  virtual bool OnSetFontSize(void) ;
  virtual bool OnSetZOrder(void) ;

  virtual bool OnDestroy(void) ;
  virtual bool OnChange(void);
};
















#endif
