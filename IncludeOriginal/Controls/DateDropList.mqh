#ifndef DATE_DROP_LIST_H
#define DATE_DROP_LIST_H

#include "BmpButton.mqh"
#include "Picture.mqh"
#include "WndContainer.mqh"
#include <Canvas\Canvas.mqh>
#include <Tools\DateTime.mqh>

enum ENUM_DATE_MODES { DATE_MODE_MON, DATE_MODE_YEAR };

class CDateDropList : public CWndContainer {
private:
  CBmpButton m_dec;
  CBmpButton m_inc;
  CPicture m_list;
  CCanvas m_canvas;

  CDateTime m_value;

  ENUM_DATE_MODES m_mode;
  CRect m_click_rect[32];

public:
  CDateDropList(void);
  ~CDateDropList(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  datetime Value(void) {
    return (StructToTime(m_value));
  }
  void Value(datetime value) {
    m_value.Date(value);
  }
  void Value(MqlDateTime &value) {
    m_value = value;
  }

  virtual bool Show(void);

protected:
  virtual bool OnClick(void);

  virtual bool CreateButtons(void);
  virtual bool CreateList(void);

  void DrawCanvas(void);
  void DrawClickRect(const int idx, int x, int y, string text, const uint clr,
                     uint alignment = 0);

  virtual bool OnClickDec(void);
  virtual bool OnClickInc(void);
  virtual bool OnClickList(void);
};

EVENT_MAP_BEGIN(CDateDropList)
ON_EVENT(ON_CLICK, m_dec, OnClickDec)
ON_EVENT(ON_CLICK, m_inc, OnClickInc)
ON_EVENT(ON_CLICK, m_list, OnClickList)
EVENT_MAP_END(CWndContainer)

CDateDropList::CDateDropList(void) : m_mode(DATE_MODE_MON) {
  ZeroMemory(m_value);
}

CDateDropList::~CDateDropList(void) {
}

bool CDateDropList::Create(const long chart, const string name,
                           const int subwin, const int x1, const int y1,
                           const int x2, const int y2) {

  int w = 7 * (2 * CONTROLS_FONT_SIZE) + 2 * CONTROLS_FONT_SIZE;

  int h = (CONTROLS_BUTTON_SIZE + 4 * CONTROLS_BORDER_WIDTH) +
          7 * (2 * CONTROLS_FONT_SIZE);

  if (!CWndContainer::Create(chart, name, subwin, x1, y1, x1 + w, y1 + h))
    return (false);

  if (!CreateList())
    return (false);
  if (!CreateButtons())
    return (false);

  return (true);
}

bool CDateDropList::CreateList(void) {

  if (!m_list.Create(m_chart_id, m_name + "List", m_subwin, 0, 0, Width(),
                     Height()))
    return (false);
  if (!Add(m_list))
    return (false);

  if (!m_canvas.Create(m_name, Width(), Height()))
    return (false);
  m_canvas.FontSet(CONTROLS_FONT_NAME, CONTROLS_FONT_SIZE * (-10));
  m_list.BmpName(m_canvas.ResourceName());

  return (true);
}

bool CDateDropList::CreateButtons(void) {

  int x1 = 2 * CONTROLS_BORDER_WIDTH;
  int y1 = 2 * CONTROLS_BORDER_WIDTH;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_dec.Create(m_chart_id, m_name + "Dec", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_dec.BmpNames("::res\LeftTransp.bmp"))
    return (false);
  if (!Add(m_dec))
    return (false);

  x2 = Width() - 2 * CONTROLS_BORDER_WIDTH;
  x1 = x2 - CONTROLS_BUTTON_SIZE;

  if (!m_inc.Create(m_chart_id, m_name + "Inc", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_inc.BmpNames("::res\RightTransp.bmp"))
    return (false);
  if (!Add(m_inc))
    return (false);

  return (true);
}

bool CDateDropList::Show(void) {

  DrawCanvas();

  return (CWndContainer::Show());
}

bool CDateDropList::OnClickDec(void) {
  switch (m_mode) {

  case DATE_MODE_MON:
    m_value.MonDec();
    break;

  case DATE_MODE_YEAR:
    m_value.YearDec();
    break;
  }
  DrawCanvas();

  return (true);
}

bool CDateDropList::OnClickInc(void) {
  switch (m_mode) {

  case DATE_MODE_MON:
    m_value.MonInc();
    break;

  case DATE_MODE_YEAR:
    m_value.YearInc();
    break;
  }
  DrawCanvas();

  return (true);
}

bool CDateDropList::OnClickList(void) {
  m_mouse_x = m_list.MouseX();
  m_mouse_y = m_list.MouseY();

  OnClick();

  m_mouse_x = 0;
  m_mouse_y = 0;

  return (true);
}

bool CDateDropList::OnClick(void) {
  for (int i = 0; i < 32; i++) {
    if (m_click_rect[i].Contains(m_mouse_x, m_mouse_y)) {
      if (i == 0) {

        switch (m_mode) {

        case DATE_MODE_MON:

          m_mode = DATE_MODE_YEAR;
          DrawCanvas();
          break;

        case DATE_MODE_YEAR:

          break;
        }
      } else {

        switch (m_mode) {

        case DATE_MODE_MON:
          m_value.Day(i);
          Hide();

          EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CHANGE, m_id, 0.0, m_name);
          break;

        case DATE_MODE_YEAR:
          m_value.Mon(i);
          m_mode = DATE_MODE_MON;
          DrawCanvas();
          break;
        default:
          break;
        }
      }
      break;
    }
  }

  return (true);
}

void CDateDropList::DrawCanvas(void) {
  int x, y;
  int dx, dy;
  string text;
  uint text_al = TA_CENTER | TA_VCENTER;
  CDateTime tmp_date;
  int rows, cols;
  int idx;

  for (int i = 0; i < 32; i++)
    ZeroMemory(m_click_rect[i]);

  m_canvas.Erase(COLOR2RGB(CONTROLS_EDIT_COLOR_BG));
  m_canvas.Rectangle(0, 0, Width() - 1, Height() - 1,
                     COLOR2RGB(CONTROLS_EDIT_COLOR_BORDER));
  x = Width() / 2;
  y = CONTROLS_BUTTON_SIZE / 2 + 2 * CONTROLS_BORDER_WIDTH;
  switch (m_mode) {

  case DATE_MODE_MON:
    text = m_value.MonthName() + " " + IntegerToString(m_value.year);
    DrawClickRect(0, x, y, text, COLOR2RGB(CONTROLS_EDIT_COLOR), text_al);
    rows = 6;
    cols = 7;
    x = dx = Width() / (cols + 1);
    y += y;
    dy = (Height() - y - 2 * CONTROLS_BORDER_WIDTH) / (rows + 1);
    y += dy / 2;
    for (int i = 0; i < cols; i++, x += dx)
      m_canvas.TextOut(x, y, m_value.ShortDayName(i),
                       COLOR2RGB(CONTROLS_EDIT_COLOR), text_al);

    tmp_date = m_value;

    tmp_date.DayDec(tmp_date.day_of_week);
    while (tmp_date.mon == m_value.mon && tmp_date.day != 1)
      tmp_date.DayDec(cols);

    idx = 1;
    y += dy;
    for (int i = 0; i < rows; i++, y += dy) {
      x = dx;
      for (int j = 0; j < cols; j++, x += dx) {
        text = IntegerToString(tmp_date.day);
        if (tmp_date.mon == m_value.mon) {
          if (tmp_date.day == m_value.day)
            m_canvas.FillRectangle(x - dx / 2, y - dy / 2, x + dx / 2,
                                   y + dy / 2,
                                   COLOR2RGB(CONTROLS_COLOR_BG_SEL));
          DrawClickRect(idx++, x, y, text, COLOR2RGB(CONTROLS_EDIT_COLOR),
                        text_al);
        } else
          m_canvas.TextOut(x, y, text, COLOR2RGB(CONTROLS_BUTTON_COLOR_BORDER),
                           text_al);
        tmp_date.DayInc();
      }
    }
    break;

  case DATE_MODE_YEAR:
    text = IntegerToString(m_value.year);
    DrawClickRect(0, x, y, text, COLOR2RGB(CONTROLS_EDIT_COLOR), text_al);
    rows = 3;
    cols = 4;
    x = dx = Width() / (cols + 1);
    y += y;
    dy = (Height() - y) / rows;
    y += dy / 2;
    for (int i = 0; i < rows * cols; i++) {
      if (i + 1 == m_value.mon)
        m_canvas.FillRectangle(x - dx / 2, y - dy / 4, x + dx / 2, y + dy / 4,
                               COLOR2RGB(CONTROLS_COLOR_BG_SEL));
      DrawClickRect(i + 1, x, y, m_value.ShortMonthName(i + 1),
                    COLOR2RGB(CONTROLS_EDIT_COLOR), text_al);
      if (i % cols == cols - 1) {
        x = dx;
        y += dy;
      } else
        x += dx;
    }
    break;
  default:
    break;
  }
  m_canvas.Update();
}

void CDateDropList::DrawClickRect(const int idx, int x, int y, string text,
                                  const uint clr, uint alignment) {
  int text_w, text_h;

  m_canvas.TextOut(x, y, text, clr, alignment);

  m_canvas.TextSize(text, text_w, text_h);

  x += Left();
  y += Top();

  switch (alignment & (TA_LEFT | TA_CENTER | TA_RIGHT)) {
  case TA_LEFT:
    m_click_rect[idx].left = x;
    break;
  case TA_CENTER:
    m_click_rect[idx].left = x - text_w / 2;
    break;
  case TA_RIGHT:
    m_click_rect[idx].left = x - text_w;
    break;
  }
  m_click_rect[idx].Width(text_w);

  switch (alignment & (TA_TOP | TA_VCENTER | TA_BOTTOM)) {
  case TA_TOP:
    m_click_rect[idx].top = y;
    break;
  case TA_VCENTER:
    m_click_rect[idx].top = y - text_h / 2;
    break;
  case TA_BOTTOM:
    m_click_rect[idx].top = y - text_h;
    break;
  }
  m_click_rect[idx].Height(text_h);
}

#endif
