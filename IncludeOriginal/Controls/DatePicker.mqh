#ifndef DATE_PICKER_H
#define DATE_PICKER_H

#include "BmpButton.mqh"
#include "DateDropList.mqh"
#include "Edit.mqh"
#include "WndContainer.mqh"

class CDatePicker : public CWndContainer {
private:
  CEdit m_edit;
  CBmpButton m_drop;
  CDateDropList m_list;

  datetime m_value;

public:
  CDatePicker(void);
  ~CDatePicker(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  datetime Value(void) const {
    return (m_value);
  }
  void Value(datetime value) {
    m_edit.Text(TimeToString(m_value = value, TIME_DATE));
  }

  virtual bool Show(void);

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  virtual bool CreateEdit(void);
  virtual bool CreateButton(void);
  virtual bool CreateList(void);

  virtual bool OnClickEdit(void);
  virtual bool OnClickButton(void);
  virtual bool OnChangeList(void);

  bool ListShow(void);
  bool ListHide(void);
  void CheckListHide(const int id, int x, int y);
};

EVENT_MAP_BEGIN(CDatePicker)
ON_EVENT(ON_CLICK, m_edit, OnClickEdit)
ON_EVENT(ON_CLICK, m_drop, OnClickButton)
ON_EVENT(ON_CHANGE, m_list, OnChangeList)
CheckListHide(id, (int)lparam, (int)dparam);

EVENT_MAP_END(CWndContainer)

CDatePicker::CDatePicker(void) : m_value(0) {
}

CDatePicker::~CDatePicker(void) {
}

bool CDatePicker::Create(const long chart, const string name, const int subwin,
                         const int x1, const int y1, const int x2,
                         const int y2) {

  if (!CWndContainer::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!CreateEdit())
    return (false);
  if (!CreateButton())
    return (false);
  if (!CreateList())
    return (false);

  return (true);
}

bool CDatePicker::CreateEdit(void) {

  if (!m_edit.Create(m_chart_id, m_name + "Edit", m_subwin, 0, 0, Width(),
                     Height()))
    return (false);
  if (!m_edit.Text(""))
    return (false);
  if (!m_edit.ReadOnly(true))
    return (false);
  if (!Add(m_edit))
    return (false);

  return (true);
}

bool CDatePicker::CreateButton(void) {

  int x1 = Width() - (2 * CONTROLS_BUTTON_SIZE + CONTROLS_COMBO_BUTTON_X_OFF);
  int y1 = (Height() - CONTROLS_BUTTON_SIZE) / 2;
  int x2 = x1 + 2 * CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_drop.Create(m_chart_id, m_name + "Drop", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_drop.BmpNames("::res\DateDropOff.bmp", "::res\DateDropOn.bmp"))
    return (false);
  if (!Add(m_drop))
    return (false);
  m_drop.Locking(true);

  return (true);
}

bool CDatePicker::CreateList(void) {

  if (!m_list.Create(m_chart_id, m_name + "List", m_subwin, 0, Height() - 1,
                     Width(), 0))
    return (false);
  if (!Add(m_list))
    return (false);
  m_list.Hide();

  return (true);
}

bool CDatePicker::Show(void) {
  m_edit.Show();
  m_drop.Show();
  m_list.Hide();

  return (CWnd::Show());
}

bool CDatePicker::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  FileWriteLong(file_handle, Value());

  return (true);
}

bool CDatePicker::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  if (!FileIsEnding(file_handle))
    Value(FileReadLong(file_handle));

  return (true);
}

bool CDatePicker::OnClickEdit(void) {

  if (!m_drop.Pressed(!m_drop.Pressed()))
    return (false);

  return (OnClickButton());
}

bool CDatePicker::OnClickButton(void) {

  return ((m_drop.Pressed()) ? ListShow() : ListHide());
}

bool CDatePicker::OnChangeList(void) {
  string text = TimeToString(m_value = m_list.Value(), TIME_DATE);

  ListHide();
  m_drop.Pressed(false);

  m_edit.Text(text);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CHANGE, m_id, 0.0, m_name);

  return (true);
}

bool CDatePicker::ListShow(void) {

  m_list.Value(m_value);

  return (m_list.Show());
}

bool CDatePicker::ListHide(void) {

  return (m_list.Hide());
}

void CDatePicker::CheckListHide(const int id, int x, int y) {

  if (id != CHARTEVENT_CLICK)
    return;

  if (!m_list.IsVisible())
    return;

  y -= (int)ChartGetInteger(m_chart_id, CHART_WINDOW_YDISTANCE, m_subwin);
  if (!m_edit.Contains(x, y) && !m_list.Contains(x, y)) {
    m_drop.Pressed(false);
    m_list.Hide();
  }
}

#endif
