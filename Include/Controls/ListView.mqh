#ifndef LIST_VIEW_H
#define LIST_VIEW_H

#include "Edit.mqh"
#include "WndClient.mqh"
#include <Arrays/ArrayLong.mqh>
#include <Arrays/ArrayString.mqh>

class CListView : public CWndClient {
private:
  CEdit m_rows;

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

  int Current(void);
  string Select(void);
  bool Select(const int index);
  bool SelectByText(const string text);
  bool SelectByValue(const long value);

  long Value(void);

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

#endif
