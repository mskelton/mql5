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

  string Text(void) const {
    return (m_text);
  }
  bool Text(const string value);
  color Color(void) const {
    return (m_color);
  }
  bool Color(const color value);
  color ColorBackground(void) const {
    return (m_color_background);
  }
  bool ColorBackground(const color value);
  color ColorBorder(void) const {
    return (m_color_border);
  }
  bool ColorBorder(const color value);
  string Font(void) const {
    return (m_font);
  }
  bool Font(const string value);
  int FontSize(void) const {
    return (m_font_size);
  }
  bool FontSize(const int value);
  long ZOrder(void) const {
    return (m_zorder);
  }
  bool ZOrder(const long value);

protected:
  virtual bool OnObjectCreate(void);
  virtual bool OnObjectChange(void);
  virtual bool OnObjectDelete(void);
  virtual bool OnObjectDrag(void);

  virtual bool OnSetText(void) {
    return (true);
  }
  virtual bool OnSetColor(void) {
    return (true);
  }
  virtual bool OnSetColorBackground(void) {
    return (true);
  }
  virtual bool OnSetColorBorder(void) {
    return (true);
  }
  virtual bool OnSetFont(void) {
    return (true);
  }
  virtual bool OnSetFontSize(void) {
    return (true);
  }
  virtual bool OnSetZOrder(void) {
    return (true);
  }

  virtual bool OnDestroy(void) {
    return (ObjectDelete(m_chart_id, m_name));
  }
  virtual bool OnChange(void);
};

bool CWndObj::OnEvent(const int id, const long &lparam, const double &dparam,
                      const string &sparam) {
  if (m_name == sparam) {

    switch (id) {
    case CHARTEVENT_OBJECT_CREATE:
      return (OnObjectCreate());
    case CHARTEVENT_OBJECT_CHANGE:
      return (OnObjectChange());
    case CHARTEVENT_OBJECT_DELETE:
      return (OnObjectDelete());
    case CHARTEVENT_OBJECT_DRAG:
      return (OnObjectDrag());
    }
  }

  return (CWnd::OnEvent(id, lparam, dparam, sparam));
}

CWndObj::CWndObj(void)
    : m_color(clrNONE), m_color_background(clrNONE), m_color_border(clrNONE),
      m_font(CONTROLS_FONT_NAME), m_font_size(CONTROLS_FONT_SIZE), m_zorder(0),
      m_undeletable(true), m_unchangeable(true), m_unmoveable(true) {
}

CWndObj::~CWndObj(void) {
}

bool CWndObj::Text(const string value) {

  m_text = value;

  return (OnSetText());
}

bool CWndObj::Color(const color value) {

  m_color = value;

  return (OnSetColor());
}

bool CWndObj::ColorBackground(const color value) {

  m_color_background = value;

  return (OnSetColorBackground());
}

bool CWndObj::ColorBorder(const color value) {

  m_color_border = value;

  return (OnSetColorBorder());
}

bool CWndObj::Font(const string value) {

  m_font = value;

  return (OnSetFont());
}

bool CWndObj::FontSize(const int value) {

  m_font_size = value;

  return (OnSetFontSize());
}

bool CWndObj::ZOrder(const long value) {

  m_zorder = value;

  return (OnSetZOrder());
}

bool CWndObj::OnObjectCreate(void) {

  return (true);
}

bool CWndObj::OnObjectChange(void) {

  if (m_unchangeable) {

    if (!OnMove())
      return (false);

    if (!OnResize())
      return (false);

    if (!OnChange())
      return (false);
  }

  return (true);
}

bool CWndObj::OnObjectDelete(void) {

  if (m_undeletable) {

    if (!OnCreate())
      return (false);

    if (!OnChange())
      return (false);

    return (IS_VISIBLE ? OnShow() : OnHide());
  }

  return (true);
}

bool CWndObj::OnObjectDrag(void) {

  if (m_unmoveable) {

    return (OnMove());
  }

  return (true);
}

bool CWndObj::OnChange(void) {

  if (!OnSetText())
    return (false);
  if (!OnSetFont())
    return (false);
  if (!OnSetFontSize())
    return (false);
  if (!OnSetColor())
    return (false);
  if (!OnSetColorBackground())
    return (false);
  if (!OnSetColorBorder())
    return (false);

  return (true);
}

#endif
