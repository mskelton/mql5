#ifndef LIST_VIEW_H
#define LIST_VIEW_H

#include "Edit.mqh"
#include "WndClient.mqh"
#include <Arrays\ArrayLong.mqh>
#include <Arrays\ArrayString.mqh>

class CListView : public CWndClient {
private:
  CEdit m_rows[];

  int m_offset;
  int m_total_view;
  int m_item_height;
  bool m_height_variable;

  CArrayString m_strings;
  CArrayLong m_values;
  int m_current;

public:
  CListView(void);
  ~CListView(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);
  virtual void Destroy(const int reason = 0);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  bool TotalView(const int value);

  virtual bool AddItem(const string item, const long value = 0);

  virtual bool ItemAdd(const string item, const long value = 0);
  virtual bool ItemInsert(const int index, const string item,
                          const long value = 0);
  virtual bool ItemUpdate(const int index, const string item,
                          const long value = 0);
  virtual bool ItemDelete(const int index);
  virtual bool ItemsClear(void);

  int Current(void) {
    return (m_current);
  }
  string Select(void) {
    return (m_strings.At(m_current));
  }
  bool Select(const int index);
  bool SelectByText(const string text);
  bool SelectByValue(const long value);

  long Value(void) {
    return (m_values.At(m_current));
  }

  virtual bool Show(void);

protected:
  bool CreateRow(const int index);

  virtual bool OnResize(void);

  virtual bool OnVScrollShow(void);
  virtual bool OnVScrollHide(void);
  virtual bool OnScrollLineDown(void);
  virtual bool OnScrollLineUp(void);
  virtual bool OnItemClick(const int index);

  bool Redraw(void);
  bool RowState(const int index, const bool select);
  bool CheckView(void);
};

EVENT_MAP_BEGIN(CListView)
ON_INDEXED_EVENT(ON_CLICK, m_rows, OnItemClick)
EVENT_MAP_END(CWndClient)

CListView::CListView(void)
    : m_offset(0), m_total_view(0), m_item_height(CONTROLS_LIST_ITEM_HEIGHT),
      m_current(CONTROLS_INVALID_INDEX), m_height_variable(false) {}

CListView::~CListView(void) {}

bool CListView::Create(const long chart, const string name, const int subwin,
                       const int x1, const int y1, const int x2, const int y2) {
  int y = y2;

  if (!TotalView((y2 - y1) / m_item_height))
    y = m_item_height + y1 + 2 * CONTROLS_BORDER_WIDTH;

  if (m_total_view < 1)
    return (false);

  if (!CWndClient::Create(chart, name, subwin, x1, y1, x2, y))
    return (false);

  if (!m_background.ColorBackground(CONTROLS_LIST_COLOR_BG))
    return (false);
  if (!m_background.ColorBorder(CONTROLS_LIST_COLOR_BORDER))
    return (false);

  ArrayResize(m_rows, m_total_view);
  for (int i = 0; i < m_total_view; i++) {
    if (!CreateRow(i))
      return (false);
    if (m_height_variable && i > 0)
      m_rows[i].Hide();
  }

  return (true);
}

void CListView::Destroy(const int reason) {

  CWndClient::Destroy(reason);

  m_strings.Clear();
  m_values.Clear();

  m_offset = 0;
  m_total_view = 0;
}

bool CListView::TotalView(const int value) {

  if (m_total_view != 0) {
    m_height_variable = true;
    return (false);
  }

  m_total_view = value;

  return (true);
}

bool CListView::Show(void) {

  CWndClient::Show();

  int total = m_strings.Total();

  if (total == 0)
    total = 1;

  if (m_height_variable && total < m_total_view)
    for (int i = total; i < m_total_view; i++)
      m_rows[i].Hide();

  return (true);
}

bool CListView::CreateRow(const int index) {

  int x1 = CONTROLS_BORDER_WIDTH;
  int y1 = CONTROLS_BORDER_WIDTH + m_item_height * index;
  int x2 = Width() - 2 * CONTROLS_BORDER_WIDTH;
  int y2 = y1 + m_item_height;

  if (!m_rows[index].Create(m_chart_id,
                            m_name + "Item" + IntegerToString(index), m_subwin,
                            x1, y1, x2, y2))
    return (false);
  if (!m_rows[index].Text(""))
    return (false);
  if (!m_rows[index].ReadOnly(true))
    return (false);
  if (!RowState(index, false))
    return (false);
  if (!Add(m_rows[index]))
    return (false);

  return (true);
}

bool CListView::AddItem(const string item, const long value) {

  return (ItemAdd(item, value));
}

bool CListView::ItemAdd(const string item, const long value) {

  if (!m_strings.Add(item))
    return (false);
  if (!m_values.Add((value) ? value : m_values.Total()))
    return (false);

  int total = m_strings.Total();

  if (total < m_total_view + 1) {
    if (m_height_variable && total != 1) {
      Height(total * m_item_height + 2 * CONTROLS_BORDER_WIDTH);
      if (IS_VISIBLE)
        m_rows[total - 1].Show();
    }
    return (Redraw());
  }

  if (total == m_total_view + 1) {

    if (!VScrolled(true))
      return (false);

    if (IS_VISIBLE && !OnVScrollShow())
      return (false);
  }

  m_scroll_v.MaxPos(m_strings.Total() - m_total_view);

  return (Redraw());
}

bool CListView::ItemInsert(const int index, const string item,
                           const long value) {

  if (!m_strings.Insert(item, index))
    return (false);
  if (!m_values.Insert(value, index))
    return (false);

  int total = m_strings.Total();

  if (total < m_total_view + 1) {
    if (m_height_variable && total != 1) {
      Height(total * m_item_height + 2 * CONTROLS_BORDER_WIDTH);
      if (IS_VISIBLE)
        m_rows[total - 1].Show();
    }
    return (Redraw());
  }

  if (total == m_total_view + 1) {

    if (!VScrolled(true))
      return (false);

    if (IS_VISIBLE && !OnVScrollShow())
      return (false);
  }

  m_scroll_v.MaxPos(m_strings.Total() - m_total_view);

  return (Redraw());
}

bool CListView::ItemUpdate(const int index, const string item,
                           const long value) {

  if (!m_strings.Update(index, item))
    return (false);
  if (!m_values.Update(index, value))
    return (false);

  return (Redraw());
}

bool CListView::ItemDelete(const int index) {

  if (!m_strings.Delete(index))
    return (false);
  if (!m_values.Delete(index))
    return (false);

  int total = m_strings.Total();

  if (total < m_total_view) {
    if (m_height_variable && total != 0) {
      Height(total * m_item_height + 2 * CONTROLS_BORDER_WIDTH);
      m_rows[total].Hide();
    }
    return (Redraw());
  }

  if (total == m_total_view) {

    if (!VScrolled(false))
      return (false);

    if (!OnVScrollHide())
      return (false);
  }

  m_scroll_v.MaxPos(m_strings.Total() - m_total_view);

  return (Redraw());
}

bool CListView::ItemsClear(void) {
  m_offset = 0;

  if (!m_strings.Shutdown())
    return (false);
  if (!m_values.Shutdown())
    return (false);

  if (m_height_variable) {
    Height(m_item_height + 2 * CONTROLS_BORDER_WIDTH);
    for (int i = 1; i < m_total_view; i++)
      m_rows[i].Hide();
  }

  if (!VScrolled(false))
    return (false);

  if (!OnVScrollHide())
    return (false);

  return (Redraw());
}

bool CListView::Select(const int index) {

  if (index >= m_strings.Total())
    return (false);
  if (index < 0 && index != CONTROLS_INVALID_INDEX)
    return (false);

  if (m_current != CONTROLS_INVALID_INDEX)
    RowState(m_current - m_offset, false);

  if (index != CONTROLS_INVALID_INDEX)
    RowState(index - m_offset, true);

  m_current = index;

  return (CheckView());
}

bool CListView::SelectByText(const string text) {

  int index = m_strings.SearchLinear(text);

  if (index == CONTROLS_INVALID_INDEX)
    return (false);

  return (Select(index));
}

bool CListView::SelectByValue(const long value) {

  int index = m_values.SearchLinear(value);

  if (index == CONTROLS_INVALID_INDEX)
    return (false);

  return (Select(index));
}

bool CListView::Redraw(void) {

  for (int i = 0; i < m_total_view; i++) {

    if (!m_rows[i].Text(m_strings.At(i + m_offset)))
      return (false);

    if (!RowState(i, (m_current == i + m_offset)))
      return (false);
  }

  return (true);
}

bool CListView::RowState(const int index, const bool select) {

  if (index < 0 || index >= ArraySize(m_rows))
    return (true);

  color text_color = (select) ? CONTROLS_LISTITEM_COLOR_TEXT_SEL
                              : CONTROLS_LISTITEM_COLOR_TEXT;
  color back_color =
      (select) ? CONTROLS_LISTITEM_COLOR_BG_SEL : CONTROLS_LISTITEM_COLOR_BG;

  CEdit *item = GetPointer(m_rows[index]);

  return (item.Color(text_color) && item.ColorBackground(back_color) &&
          item.ColorBorder(back_color));
}

bool CListView::CheckView(void) {

  if (m_current >= m_offset && m_current < m_offset + m_total_view)
    return (true);

  int total = m_strings.Total();
  m_offset =
      (total - m_current > m_total_view) ? m_current : total - m_total_view;

  m_scroll_v.CurrPos(m_offset);

  return (Redraw());
}

bool CListView::OnResize(void) {

  if (!CWndClient::OnResize())
    return (false);

  if (VScrolled())
    OnVScrollShow();
  else
    OnVScrollHide();

  return (true);
}

bool CListView::OnVScrollShow(void) {

  for (int i = 0; i < m_total_view; i++) {

    m_rows[i].Width(Width() - (CONTROLS_SCROLL_SIZE + CONTROLS_BORDER_WIDTH));
  }

  if (!IS_VISIBLE) {
    m_scroll_v.Visible(false);
    return (true);
  }

  return (true);
}

bool CListView::OnVScrollHide(void) {

  if (!IS_VISIBLE)
    return (true);

  for (int i = 0; i < m_total_view; i++) {

    m_rows[i].Width(Width() - 2 * CONTROLS_BORDER_WIDTH);
  }

  return (true);
}

bool CListView::OnScrollLineUp(void) {

  m_offset = m_scroll_v.CurrPos();

  return (Redraw());
}

bool CListView::OnScrollLineDown(void) {

  m_offset = m_scroll_v.CurrPos();

  return (Redraw());
}

bool CListView::OnItemClick(const int index) {

  Select(index + m_offset);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CHANGE, m_id, 0.0, m_name);

  return (true);
}

#endif
