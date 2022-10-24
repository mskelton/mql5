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

  int MinValue(void) const {
    return (m_min_value);
  }
  void MinValue(const int value);
  int MaxValue(void) const {
    return (m_max_value);
  }
  void MaxValue(const int value);

  int Value(void) const {
    return (m_value);
  }
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

EVENT_MAP_BEGIN(CSpinEdit)
ON_EVENT(ON_CLICK, m_inc, OnClickInc)
ON_EVENT(ON_CLICK, m_dec, OnClickDec)
EVENT_MAP_END(CWndContainer)

CSpinEdit::CSpinEdit(void) : m_min_value(0), m_max_value(0), m_value(0) {
}

CSpinEdit::~CSpinEdit(void) {
}

bool CSpinEdit::Create(const long chart, const string name, const int subwin,
                       const int x1, const int y1, const int x2, const int y2) {

  if (y2 - y1 < CONTROLS_SPIN_MIN_HEIGHT)
    return (false);

  if (!CWndContainer::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!CreateEdit())
    return (false);
  if (!CreateInc())
    return (false);
  if (!CreateDec())
    return (false);

  return (true);
}

bool CSpinEdit::Value(int value) {

  if (value < m_min_value)
    value = m_min_value;
  if (value > m_max_value)
    value = m_max_value;

  if (m_value != value) {
    m_value = value;

    return (OnChangeValue());
  }

  return (false);
}

bool CSpinEdit::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  FileWriteInteger(file_handle, m_value);

  return (true);
}

bool CSpinEdit::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  if (!FileIsEnding(file_handle))
    Value(FileReadInteger(file_handle));

  return (true);
}

void CSpinEdit::MinValue(const int value) {

  if (m_min_value != value) {
    m_min_value = value;

    Value(m_value);
  }
}

void CSpinEdit::MaxValue(const int value) {

  if (m_max_value != value) {
    m_max_value = value;

    Value(m_value);
  }
}

bool CSpinEdit::CreateEdit(void) {

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

bool CSpinEdit::CreateInc(void) {

  int x1 = Width() - (CONTROLS_BUTTON_SIZE + CONTROLS_SPIN_BUTTON_X_OFF);
  int y1 = (Height() - 2 * CONTROLS_SPIN_BUTTON_SIZE) / 2;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_SPIN_BUTTON_SIZE;

  if (!m_inc.Create(m_chart_id, m_name + "Inc", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_inc.BmpNames("::res\SpinInc.bmp"))
    return (false);
  if (!Add(m_inc))
    return (false);

  m_inc.PropFlags(WND_PROP_FLAG_CLICKS_BY_PRESS);

  return (true);
}

bool CSpinEdit::CreateDec(void) {

  int x1 = Width() - (CONTROLS_BUTTON_SIZE + CONTROLS_SPIN_BUTTON_X_OFF);
  int y1 = (Height() - 2 * CONTROLS_SPIN_BUTTON_SIZE) / 2 +
           CONTROLS_SPIN_BUTTON_SIZE;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_SPIN_BUTTON_SIZE;

  if (!m_dec.Create(m_chart_id, m_name + "Dec", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_dec.BmpNames("::res\SpinDec.bmp"))
    return (false);
  if (!Add(m_dec))
    return (false);

  m_dec.PropFlags(WND_PROP_FLAG_CLICKS_BY_PRESS);

  return (true);
}

bool CSpinEdit::OnClickInc(void) {

  return (Value(m_value + 1));
}

bool CSpinEdit::OnClickDec(void) {

  return (Value(m_value - 1));
}

bool CSpinEdit::OnChangeValue(void) {

  m_edit.Text(IntegerToString(m_value));

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CHANGE, m_id, 0.0, m_name);

  return (true);
}

#endif
