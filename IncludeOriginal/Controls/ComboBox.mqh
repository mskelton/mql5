#ifndef COMBO_BOX_H
#define COMBO_BOX_H

#include "BmpButton.mqh"
#include "Edit.mqh"
#include "ListView.mqh"
#include "WndContainer.mqh"

class CComboBox : public CWndContainer {
private:
  CEdit m_edit;
  CBmpButton m_drop;
  CListView m_list;

  int m_item_height;
  int m_view_items;

public:
  CComboBox(void);
  ~CComboBox(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  bool AddItem(const string item, const long value = 0);

  void ListViewItems(const int value) {
    m_view_items = value;
  }

  virtual bool ItemAdd(const string item, const long value = 0) {
    return (m_list.ItemAdd(item, value));
  }
  virtual bool ItemInsert(const int index, const string item,
                          const long value = 0) {
    return (m_list.ItemInsert(index, item, value));
  }
  virtual bool ItemUpdate(const int index, const string item,
                          const long value = 0) {
    return (m_list.ItemUpdate(index, item, value));
  }
  virtual bool ItemDelete(const int index) {
    return (m_list.ItemDelete(index));
  }
  virtual bool ItemsClear(void) {
    return (m_list.ItemsClear());
  }

  string Select(void) {
    return (m_edit.Text());
  }
  bool Select(const int index);
  bool SelectByText(const string text);
  bool SelectByValue(const long value);

  long Value(void) {
    return (m_list.Value());
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

EVENT_MAP_BEGIN(CComboBox)
ON_EVENT(ON_CLICK, m_edit, OnClickEdit)
ON_EVENT(ON_CLICK, m_drop, OnClickButton)
ON_EVENT(ON_CHANGE, m_list, OnChangeList)
CheckListHide(id, (int)lparam, (int)dparam);

EVENT_MAP_END(CWndContainer)

CComboBox::CComboBox(void)
    : m_item_height(CONTROLS_COMBO_ITEM_HEIGHT),
      m_view_items(CONTROLS_COMBO_ITEMS_VIEW)

{}

CComboBox::~CComboBox(void) {}

bool CComboBox::Create(const long chart, const string name, const int subwin,
                       const int x1, const int y1, const int x2, const int y2) {

  if (y2 - y1 < CONTROLS_COMBO_MIN_HEIGHT)
    return (false);

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

bool CComboBox::CreateEdit(void) {

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

bool CComboBox::CreateButton(void) {

  int x1 = Width() - (CONTROLS_BUTTON_SIZE + CONTROLS_COMBO_BUTTON_X_OFF);
  int y1 = (Height() - CONTROLS_BUTTON_SIZE) / 2;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_drop.Create(m_chart_id, m_name + "Drop", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_drop.BmpNames("::res\DropOff.bmp", "::res\DropOn.bmp"))
    return (false);
  if (!Add(m_drop))
    return (false);
  m_drop.Locking(true);

  return (true);
}

bool CComboBox::CreateList(void) {

  if (m_list.TotalView(m_view_items)) {
    if (!m_list.Create(m_chart_id, m_name + "List", m_subwin, 0, Height(),
                       Width(), 0))
      return (false);
    if (!Add(m_list))
      return (false);
    m_list.Hide();
  }

  return (true);
}

bool CComboBox::AddItem(const string item, const long value) {

  return (m_list.AddItem(item, value));
}

bool CComboBox::Select(const int index) {
  if (!m_list.Select(index))
    return (false);

  return (OnChangeList());
}

bool CComboBox::SelectByText(const string text) {
  if (!m_list.SelectByText(text))
    return (false);

  return (OnChangeList());
}

bool CComboBox::SelectByValue(const long value) {
  if (!m_list.SelectByValue(value))
    return (false);

  return (OnChangeList());
}

bool CComboBox::Show(void) {
  m_edit.Show();
  m_drop.Show();
  m_list.Hide();

  return (CWnd::Show());
}

bool CComboBox::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  FileWriteLong(file_handle, Value());

  return (true);
}

bool CComboBox::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  if (!FileIsEnding(file_handle))
    SelectByValue(FileReadLong(file_handle));

  return (true);
}

bool CComboBox::OnClickEdit(void) {

  if (!m_drop.Pressed(!m_drop.Pressed()))
    return (false);

  return (OnClickButton());
}

bool CComboBox::OnClickButton(void) {

  return ((m_drop.Pressed()) ? ListShow() : ListHide());
}

bool CComboBox::OnChangeList(void) {
  string text = m_list.Select();

  ListHide();
  m_drop.Pressed(false);

  m_edit.Text(text);

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CHANGE, m_id, 0.0, m_name);

  return (true);
}

bool CComboBox::ListShow(void) {
  BringToTop();

  return (m_list.Show());
}

bool CComboBox::ListHide(void) {

  return (m_list.Hide());
}

void CComboBox::CheckListHide(const int id, int x, int y) {

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
