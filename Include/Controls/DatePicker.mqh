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

  datetime Value(void) const;
  void Value(datetime value);

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

#endif
