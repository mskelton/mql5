#ifndef CHECK_GROUP_H
#define CHECK_GROUP_H

#include "CheckBox.mqh"
#include "WndClient.mqh"
#include <Arrays/ArrayInt.mqh>
#include <Arrays/ArrayLong.mqh>
#include <Arrays/ArrayString.mqh>

class CCheckGroup : public CWndClient {
private:
  CCheckBox m_rows;

  int m_offset;
  int m_total_view;
  int m_item_height;

  CArrayString m_strings;
  CArrayLong m_values;
  CArrayInt m_states;
  long m_value;
  int m_current;

public:
  CCheckGroup(void);
  ~CCheckGroup(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);
  virtual void Destroy(const int reason = 0);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  virtual bool AddItem(const string item, const long value = 0);

  long Value(void) const;
  bool Value(const long value);
  int Check(const int idx) const;
  bool Check(const int idx, const int value);

  virtual bool Show(void);

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  bool CreateButton(int index);

  virtual bool OnVScrollShow(void);
  virtual bool OnVScrollHide(void);
  virtual bool OnScrollLineDown(void);
  virtual bool OnScrollLineUp(void);
  virtual bool OnChangeItem(const int row_index);

  bool Redraw(void);
  bool RowState(const int index, const bool select);
};

EVENT_MAP_BEGIN(CCheckGroup)
ON_INDEXED_EVENT(ON_CHANGE, m_rows, OnChangeItem)
EVENT_MAP_END(CWndClient)

#endif
