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

  void ListViewItems(const int value);

  virtual bool ItemAdd(const string item, const long value = 0);
  virtual bool ItemInsert(const int index, const string item,
                          const long value = 0);
  virtual bool ItemUpdate(const int index, const string item,
                          const long value = 0);
  virtual bool ItemDelete(const int index);
  virtual bool ItemsClear(void);

  string Select(void);
  bool Select(const int index);
  bool SelectByText(const string text);
  bool SelectByValue(const long value);

  long Value(void);

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

#endif
