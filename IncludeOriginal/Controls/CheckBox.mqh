#ifndef CHECK_BOX_H
#define CHECK_BOX_H

#include "BmpButton.mqh"
#include "Edit.mqh"
#include "WndContainer.mqh"

class CCheckBox : public CWndContainer {
private:
  CBmpButton m_button;
  CEdit m_label;

  int m_value;

public:
  CCheckBox(void);
  ~CCheckBox(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  string Text(void) const {
    return (m_label.Text());
  }
  bool Text(const string value) {
    return (m_label.Text(value));
  }
  color Color(void) const {
    return (m_label.Color());
  }
  bool Color(const color value) {
    return (m_label.Color(value));
  }

  bool Checked(void) const {
    return (m_button.Pressed());
  }
  bool Checked(const bool flag) {
    return (m_button.Pressed(flag));
  }

  int Value(void) const {
    return (m_value);
  }
  void Value(const int value) {
    m_value = value;
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  virtual bool CreateButton(void);
  virtual bool CreateLabel(void);

  virtual bool OnClickButton(void);
  virtual bool OnClickLabel(void);
};

EVENT_MAP_BEGIN(CCheckBox)
ON_EVENT(ON_CLICK, m_button, OnClickButton)
ON_EVENT(ON_CLICK, m_label, OnClickLabel)
EVENT_MAP_END(CWndContainer)

CCheckBox::CCheckBox(void) : m_value(0) {
}

CCheckBox::~CCheckBox(void) {
}

bool CCheckBox::Create(const long chart, const string name, const int subwin,
                       const int x1, const int y1, const int x2, const int y2) {

  if (!CWndContainer::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!CreateButton())
    return (false);
  if (!CreateLabel())
    return (false);

  return (true);
}

bool CCheckBox::CreateButton(void) {

  int x1 = CONTROLS_CHECK_BUTTON_X_OFF;
  int y1 = CONTROLS_CHECK_BUTTON_Y_OFF;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE - CONTROLS_BORDER_WIDTH;

  if (!m_button.Create(m_chart_id, m_name + "Button", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_button.BmpNames("::res\CheckBoxOff.bmp", "::res\CheckBoxOn.bmp"))
    return (false);
  if (!Add(m_button))
    return (false);
  m_button.Locking(true);

  return (true);
}

bool CCheckBox::CreateLabel(void) {

  int x1 = CONTROLS_CHECK_LABEL_X_OFF;
  int y1 = CONTROLS_CHECK_LABEL_Y_OFF;
  int x2 = Width();
  int y2 = Height();

  if (!m_label.Create(m_chart_id, m_name + "Label", m_subwin, x1, y1, x2, y2))
    return (false);
  if (!m_label.Text(m_name))
    return (false);
  if (!Add(m_label))
    return (false);
  m_label.ReadOnly(true);
  m_label.ColorBackground(CONTROLS_CHECKGROUP_COLOR_BG);
  m_label.ColorBorder(CONTROLS_CHECKGROUP_COLOR_BG);

  return (true);
}

bool CCheckBox::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  FileWriteInteger(file_handle, Checked());

  return (true);
}

bool CCheckBox::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  if (!FileIsEnding(file_handle))
    Checked(FileReadInteger(file_handle));

  return (true);
}

bool CCheckBox::OnClickButton(void) {

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_CHANGE, m_id, 0.0, m_name);

  return (true);
}

bool CCheckBox::OnClickLabel(void) {

  m_button.Pressed(!m_button.Pressed());

  return (OnClickButton());
}

#endif
