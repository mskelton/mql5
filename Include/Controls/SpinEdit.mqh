#ifndef SPIN_EDIT_H
#define SPIN_EDIT_H

#include "BmpButton.mqh"
#include "Edit.mqh"
#include "WndContainer.mqh"

class CSpinEdit : public CWndContainer {
private:
  CEdit m_edit;
  CBmpButton m_inc;
  CBmpButton m_dec;

  int m_min_value;
  int m_max_value;

  int m_value;

public:
  CSpinEdit(void);
  ~CSpinEdit(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  int MinValue(void) const;
  void MinValue(const int value);
  int MaxValue(void) const;
  void MaxValue(const int value);

  int Value(void) const;
  bool Value(int value);

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  virtual bool CreateEdit(void);
  virtual bool CreateInc(void);
  virtual bool CreateDec(void);

  virtual bool OnClickInc(void);
  virtual bool OnClickDec(void);

  virtual bool OnChangeValue(void);
};

#endif
