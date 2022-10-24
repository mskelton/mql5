#ifndef DIALOG_H
#define DIALOG_H

#include "BmpButton.mqh"
#include "Edit.mqh"
#include "Panel.mqh"
#include "WndClient.mqh"
#include "WndContainer.mqh"
#include <Charts/Chart.mqh>

class CDialog : public CWndContainer {
private:
  CPanel m_white_border;
  CPanel m_background;
  CEdit m_caption;
  CBmpButton m_button_close;
  CWndClient m_client_area;

protected:
  bool m_panel_flag;

  bool m_minimized;

  CRect m_min_rect;
  CRect m_norm_rect;

public:
  CDialog(void);
  ~CDialog(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  string Caption(void) const;
  bool Caption(const string text);

  bool Add(CWnd *control);
  bool Add(CWnd &control);

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  virtual bool CreateWhiteBorder(void);
  virtual bool CreateBackground(void);
  virtual bool CreateCaption(void);
  virtual bool CreateButtonClose(void);
  virtual bool CreateClientArea(void);

  virtual void OnClickCaption(void);
  virtual void OnClickButtonClose(void);

  void CaptionAlignment(const int flags, const int left, const int top,
                        const int right, const int bottom);

  bool ClientAreaVisible(const bool visible);
  int ClientAreaLeft(void) const;
  int ClientAreaTop(void) const;
  int ClientAreaRight(void) const;
  int ClientAreaBottom(void) const;
  int ClientAreaWidth(void) const;
  int ClientAreaHeight(void) const;

  virtual bool OnDialogDragStart(void);
  virtual bool OnDialogDragProcess(void);
  virtual bool OnDialogDragEnd(void);
};

class CAppDialog : public CDialog {
private:
  CBmpButton m_button_minmax;

  string m_program_name;
  string m_instance_id;
  ENUM_PROGRAM_TYPE m_program_type;
  string m_indicator_name;
  int m_deinit_reason;

  int m_subwin_Yoff;
  CWnd *m_focused_wnd;
  CWnd *m_top_wnd;

protected:
  CChart m_chart;

public:
  CAppDialog(void);
  ~CAppDialog(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);
  virtual void Destroy(const int reason = REASON_PROGRAM);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  bool Run(void);

  void ChartEvent(const int id, const long &lparam, const double &dparam,
                  const string &sparam);

  void Minimized(const bool flag);

  void IniFileSave(void);
  void IniFileLoad(void);
  virtual string IniFileName(void) const;
  virtual string IniFileExt(void) const;
  virtual bool Load(const int file_handle);
  virtual bool Save(const int file_handle);

private:
  bool CreateCommon(const long chart, const string name, const int subwin);
  bool CreateExpert(const int x1, const int y1, const int x2, const int y2);
  bool CreateIndicator(const int x1, const int y1, const int x2, const int y2);

protected:
  virtual bool CreateButtonMinMax(void);

  virtual void OnClickButtonClose(void);
  virtual void OnClickButtonMinMax(void);

  virtual void OnAnotherApplicationClose(const long &lparam,
                                         const double &dparam,
                                         const string &sparam);

  virtual bool Rebound(const CRect &rect);
  virtual void Minimize(void);
  virtual void Maximize(void);
  string CreateInstanceId(void);
  string ProgramName(void) const;
  void SubwinOff(void);
};

#endif
