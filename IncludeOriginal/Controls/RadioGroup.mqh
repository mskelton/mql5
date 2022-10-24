#ifndef RADIO_GROUP_H
#define RADIO_GROUP_H

#include "RadioButton.mqh"
#include "WndClient.mqh"
#include <Arrays\ArrayLong.mqh>
#include <Arrays\ArrayString.mqh>

class CRadioGroup : public CWndClient {
private:
  CRadioButton m_rows[];

  int m_offset;
  int m_total_view;
  int m_item_height;

  CArrayString m_strings;
  CArrayLong m_values;
  int m_current;

public:
  CRadioGroup(void);
  ~CRadioGroup(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);
  virtual void Destroy(const int reason = 0);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  virtual bool AddItem(const string item, const long value = 0);

  long Value(void) const {
    return (m_values.At(m_current));
  }
  bool Value(const long value);
  bool ValueCheck(long value) const;

  virtual bool Show(void);

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  bool CreateButton(const int index);

  virtual bool OnVScrollShow(void);
  virtual bool OnVScrollHide(void);
  virtual bool OnScrollLineDown(void);
  virtual bool OnScrollLineUp(void);
  virtual bool OnChangeItem(const int row_index);

  bool Redraw(void);
  bool RowState(const int index, const bool select);
  void Select(const int index);
};

EVENT_MAP_BEGIN(CRadioGroup)
ON_INDEXED_EVENT(ON_CHANGE, m_rows, OnChangeItem)
EVENT_MAP_END(CWndClient)

CRadioGroup::CRadioGroup(void)
    : m_offset(0), m_total_view(0), m_item_height(CONTROLS_LIST_ITEM_HEIGHT),
      m_current(CONTROLS_INVALID_INDEX) {
}

CRadioGroup::~CRadioGroup(void) {
}

bool CRadioGroup::Create(const long chart, const string name, const int subwin,
                         const int x1, const int y1, const int x2,
                         const int y2) {

  m_total_view = (y2 - y1) / m_item_height;

  if (m_total_view < 1)
    return (false);

  if (!CWndClient::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!m_background.ColorBackground(CONTROLS_RADIOGROUP_COLOR_BG))
    return (false);
  if (!m_background.ColorBorder(CONTROLS_RADIOGROUP_COLOR_BORDER))
    return (false);

  ArrayResize(m_rows, m_total_view);
  for (int i = 0; i < m_total_view; i++)
    if (!CreateButton(i))
      return (false);

  return (true);
}

void CRadioGroup::Destroy(const int reason) {

  CWndClient::Destroy(reason);

  m_strings.Clear();
  m_values.Clear();
}

bool CRadioGroup::CreateButton(const int index) {

  int x1 = CONTROLS_BORDER_WIDTH;
  int y1 = CONTROLS_BORDER_WIDTH + m_item_height * index;
  int x2 = Width() - CONTROLS_BORDER_WIDTH;
  int y2 = y1 + m_item_height;

  if (!m_rows[index].Create(m_chart_id,
                            m_name + "Item" + IntegerToString(index), m_subwin,
                            x1, y1, x2, y2))
    return (false);
  if (!m_rows[index].Text(""))
    return (false);
  if (!Add(m_rows[index]))
    return (false);
  m_rows[index].Hide();

  return (true);
}

bool CRadioGroup::AddItem(const string item, const long value) {

  if (value != 0 && !ValueCheck(value))
    return (false);

  if (!m_strings.Add(item))
    return (false);
  if (!m_values.Add(value))
    return (false);

  int total = m_strings.Total();

  if (total < m_total_view + 1) {
    if (IS_VISIBLE && total != 0)
      m_rows[total - 1].Show();
    return (Redraw());
  }

  if (total == m_total_view + 1) {

    if (!VScrolled(true))
      return (false);

    if (!IS_VISIBLE)
      m_scroll_v.Visible(false);
  }

  m_scroll_v.MaxPos(m_strings.Total() - m_total_view);

  return (Redraw());
}

bool CRadioGroup::Value(const long value) {

  int total = m_values.Total();

  for (int i = 0; i < total; i++)
    if (m_values.At(i) == value)
      Select(i + m_offset);

  return (true);
}

bool CRadioGroup::ValueCheck(long value) const {

  int total = m_values.Total();

  for (int i = 0; i < total; i++)
    if (m_values.At(i) == value)
      return (false);

  return (true);
}

bool CRadioGroup::Show(void) {

  if (!CWndClient::Show())
    return (false);

  int total = m_values.Total();
  for (int i = total; i < m_total_view; i++)
    m_rows[i].Hide();

  return (true);
}

bool CRadioGroup::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  FileWriteLong(file_handle, Value());

  return (true);
}

bool CRadioGroup::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  if (!FileIsEnding(file_handle))
    Value(FileReadLong(file_handle));

  return (true);
}

void CRadioGroup::Select(const int index) {

  if (m_current != -1)
    RowState(m_current - m_offset, false);

  if (index != -1)
    RowState(index - m_offset, true);

  m_current = index;
}

bool CRadioGroup::Redraw(void) {

  for (int i = 0; i < m_total_view; i++) {

    if (!m_rows[i].Text(m_strings.At(i + m_offset)))
      return (false);

    if (!RowState(i, (m_current == i + m_offset)))
      return (false);
  }

  return (true);
}

bool CRadioGroup::RowState(const int index, const bool select) {

  if (index < 0 || index >= ArraySize(m_rows))
    return (true);

  return (m_rows[index].State(select));
}

bool CRadioGroup::OnVScrollShow(void) {

  for (int i = 0; i < m_total_view; i++) {

    m_rows[i].Width(Width() - (CONTROLS_SCROLL_SIZE + CONTROLS_BORDER_WIDTH));
  }

  if (!IS_VISIBLE) {
    m_scroll_v.Visible(false);
    return (true);
  }

  return (true);
}

bool CRadioGroup::OnVScrollHide(void) {

  if (!IS_VISIBLE)
    return (true);

  for (int i = 0; i < m_total_view; i++) {

    m_rows[i].Width(Width() - CONTROLS_BORDER_WIDTH);
  }

  return (true);
}

bool CRadioGroup::OnScrollLineUp(void) {

  m_offset = m_scroll_v.CurrPos();

  return (Redraw());
}

bool CRadioGroup::OnScrollLineDown(void) {

  m_offset = m_scroll_v.CurrPos();

  return (Redraw());
}

bool CRadioGroup::OnChangeItem(const int row_index) {

  Select(row_index + m_offset);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CHANGE, m_id, 0.0, m_name);

  return (true);
}

#endif
