#ifndef DIALOG_H
#define DIALOG_H

#include "BmpButton.mqh"
#include "Edit.mqh"
#include "Panel.mqh"
#include "WndClient.mqh"
#include "WndContainer.mqh"
#include <Charts\Chart.mqh>

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

  string Caption(void) const {
    return (m_caption.Text());
  }
  bool Caption(const string text) {
    return (m_caption.Text(text));
  }

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
                        const int right, const int bottom) {
    m_caption.Alignment(flags, left, top, right, bottom);
  }

  bool ClientAreaVisible(const bool visible) {
    return (m_client_area.Visible(visible));
  }
  int ClientAreaLeft(void) const {
    return (m_client_area.Left());
  }
  int ClientAreaTop(void) const {
    return (m_client_area.Top());
  }
  int ClientAreaRight(void) const {
    return (m_client_area.Right());
  }
  int ClientAreaBottom(void) const {
    return (m_client_area.Bottom());
  }
  int ClientAreaWidth(void) const {
    return (m_client_area.Width());
  }
  int ClientAreaHeight(void) const {
    return (m_client_area.Height());
  }

  virtual bool OnDialogDragStart(void);
  virtual bool OnDialogDragProcess(void);
  virtual bool OnDialogDragEnd(void);
};

EVENT_MAP_BEGIN(CDialog)
ON_EVENT(ON_CLICK, m_button_close, OnClickButtonClose)
ON_EVENT(ON_CLICK, m_caption, OnClickCaption)
ON_EVENT(ON_DRAG_START, m_caption, OnDialogDragStart)
ON_EVENT_PTR(ON_DRAG_PROCESS, m_drag_object, OnDialogDragProcess)
ON_EVENT_PTR(ON_DRAG_END, m_drag_object, OnDialogDragEnd)
EVENT_MAP_END(CWndContainer)

CDialog::CDialog(void) : m_panel_flag(false), m_minimized(false) {
}

CDialog::~CDialog(void) {
}

bool CDialog::Create(const long chart, const string name, const int subwin,
                     const int x1, const int y1, const int x2, const int y2) {

  if (!CWndContainer::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!m_panel_flag && !CreateWhiteBorder())
    return (false);
  if (!CreateBackground())
    return (false);
  if (!CreateCaption())
    return (false);
  if (!CreateButtonClose())
    return (false);
  if (!CreateClientArea())
    return (false);

  m_norm_rect.SetBound(m_rect);

  return (true);
}

bool CDialog::Add(CWnd *control) {
  return (m_client_area.Add(control));
}

bool CDialog::Add(CWnd &control) {
  return (m_client_area.Add(control));
}

bool CDialog::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE)
    return (false);

  FileWriteStruct(file_handle, m_norm_rect);
  FileWriteInteger(file_handle, m_min_rect.left);
  FileWriteInteger(file_handle, m_min_rect.top);
  FileWriteInteger(file_handle, m_minimized);

  return (CWndContainer::Save(file_handle));
}

bool CDialog::Load(const int file_handle) {
  if (file_handle == INVALID_HANDLE)
    return (false);

  if (!FileIsEnding(file_handle)) {
    FileReadStruct(file_handle, m_norm_rect);
    int left = FileReadInteger(file_handle);
    int top = FileReadInteger(file_handle);
    m_min_rect.Move(left, top);
    m_minimized = FileReadInteger(file_handle);
  }

  return (CWndContainer::Load(file_handle));
}

bool CDialog::CreateWhiteBorder(void) {

  int x1 = 0;
  int y1 = 0;
  int x2 = Width();
  int y2 = Height();

  if (!m_white_border.Create(m_chart_id, m_name + "Border", m_subwin, x1, y1,
                             x2, y2))
    return (false);
  if (!m_white_border.ColorBackground(CONTROLS_DIALOG_COLOR_BG))
    return (false);
  if (!m_white_border.ColorBorder(CONTROLS_DIALOG_COLOR_BORDER_LIGHT))
    return (false);
  if (!CWndContainer::Add(m_white_border))
    return (false);
  m_white_border.Alignment(WND_ALIGN_CLIENT, 0, 0, 0, 0);

  return (true);
}

bool CDialog::CreateBackground(void) {
  int off = (m_panel_flag) ? 0 : CONTROLS_BORDER_WIDTH;

  int x1 = off;
  int y1 = off;
  int x2 = Width() - off;
  int y2 = Height() - off;

  if (!m_background.Create(m_chart_id, m_name + "Back", m_subwin, x1, y1, x2,
                           y2))
    return (false);
  if (!m_background.ColorBackground(CONTROLS_DIALOG_COLOR_BG))
    return (false);
  color border = (m_panel_flag) ? CONTROLS_DIALOG_COLOR_BG
                                : CONTROLS_DIALOG_COLOR_BORDER_DARK;
  if (!m_background.ColorBorder(border))
    return (false);
  if (!CWndContainer::Add(m_background))
    return (false);
  m_background.Alignment(WND_ALIGN_CLIENT, off, off, off, off);

  return (true);
}

bool CDialog::CreateCaption(void) {
  int off = (m_panel_flag) ? 0 : 2 * CONTROLS_BORDER_WIDTH;

  int x1 = off;
  int y1 = off;
  int x2 = Width() - off;
  int y2 = y1 + CONTROLS_DIALOG_CAPTION_HEIGHT;

  if (!m_caption.Create(m_chart_id, m_name + "Caption", m_subwin, x1, y1, x2,
                        y2))
    return (false);
  if (!m_caption.Color(CONTROLS_DIALOG_COLOR_CAPTION_TEXT))
    return (false);
  if (!m_caption.ColorBackground(CONTROLS_DIALOG_COLOR_BG))
    return (false);
  if (!m_caption.ColorBorder(CONTROLS_DIALOG_COLOR_BG))
    return (false);
  if (!m_caption.ReadOnly(true))
    return (false);
  if (!m_caption.Text(m_name))
    return (false);
  if (!CWndContainer::Add(m_caption))
    return (false);
  m_caption.Alignment(WND_ALIGN_WIDTH, off, 0, off, 0);
  if (!m_panel_flag)
    m_caption.PropFlags(WND_PROP_FLAG_CAN_DRAG);

  return (true);
}

bool CDialog::CreateButtonClose(void) {
  int off = (m_panel_flag) ? 0 : 2 * CONTROLS_BORDER_WIDTH;

  int x1 = Width() - off - (CONTROLS_BUTTON_SIZE + CONTROLS_DIALOG_BUTTON_OFF);
  int y1 = off + CONTROLS_DIALOG_BUTTON_OFF;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_button_close.Create(m_chart_id, m_name + "Close", m_subwin, x1, y1, x2,
                             y2))
    return (false);
  if (!m_button_close.BmpNames("::res\Close.bmp"))
    return (false);
  if (!CWndContainer::Add(m_button_close))
    return (false);
  m_button_close.Alignment(WND_ALIGN_RIGHT, 0, 0,
                           off + CONTROLS_DIALOG_BUTTON_OFF, 0);

  CaptionAlignment(WND_ALIGN_WIDTH, off, 0,
                   off + (CONTROLS_BUTTON_SIZE + CONTROLS_DIALOG_BUTTON_OFF),
                   0);

  return (true);
}

bool CDialog::CreateClientArea(void) {
  int off = (m_panel_flag) ? 0 : 2 * CONTROLS_BORDER_WIDTH;

  int x1 = off + CONTROLS_DIALOG_CLIENT_OFF;
  int y1 = off + CONTROLS_DIALOG_CAPTION_HEIGHT;
  int x2 = Width() - (off + CONTROLS_DIALOG_CLIENT_OFF);
  int y2 = Height() - (off + CONTROLS_DIALOG_CLIENT_OFF);

  if (!m_client_area.Create(m_chart_id, m_name + "Client", m_subwin, x1, y1, x2,
                            y2))
    return (false);
  if (!m_client_area.ColorBackground(CONTROLS_DIALOG_COLOR_CLIENT_BG))
    return (false);
  if (!m_client_area.ColorBorder(CONTROLS_DIALOG_COLOR_CLIENT_BORDER))
    return (false);
  CWndContainer::Add(m_client_area);
  m_client_area.Alignment(WND_ALIGN_CLIENT, x1, y1, x1, x1);

  return (true);
}

void CDialog::OnClickCaption(void) {
}

void CDialog::OnClickButtonClose(void) {
  Visible(false);
}

bool CDialog::OnDialogDragStart(void) {
  if (m_drag_object == NULL) {
    m_drag_object = new CDragWnd;
    if (m_drag_object == NULL)
      return (false);
  }

  int x1 = Left() - CONTROLS_DRAG_SPACING;
  int y1 = Top() - CONTROLS_DRAG_SPACING;
  int x2 = Right() + CONTROLS_DRAG_SPACING;
  int y2 = Bottom() + CONTROLS_DRAG_SPACING;

  m_drag_object.Create(m_chart_id, "", m_subwin, x1, y1, x2, y2);
  m_drag_object.PropFlags(WND_PROP_FLAG_CAN_DRAG);

  CChart chart;
  chart.Attach(m_chart_id);
  m_drag_object.Limits(-CONTROLS_DRAG_SPACING, -CONTROLS_DRAG_SPACING,
                       chart.WidthInPixels() + CONTROLS_DRAG_SPACING,
                       chart.HeightInPixels(m_subwin) + CONTROLS_DRAG_SPACING);
  chart.Detach();

  m_drag_object.MouseX(m_caption.MouseX());
  m_drag_object.MouseY(m_caption.MouseY());
  m_drag_object.MouseFlags(m_caption.MouseFlags());

  return (true);
}

bool CDialog::OnDialogDragProcess(void) {

  if (m_drag_object == NULL)
    return (false);

  int x = m_drag_object.Left() + 50;
  int y = m_drag_object.Top() + 50;

  Move(x, y);

  return (true);
}

bool CDialog::OnDialogDragEnd(void) {
  if (m_drag_object != NULL) {
    m_caption.MouseFlags(m_drag_object.MouseFlags());
    delete m_drag_object;
    m_drag_object = NULL;
  }

  if (m_minimized)
    m_min_rect.SetBound(m_rect);
  else
    m_norm_rect.SetBound(m_rect);

  return (true);
}

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

  void Minimized(const bool flag) {
    m_minimized = flag;
  }

  void IniFileSave(void);
  void IniFileLoad(void);
  virtual string IniFileName(void) const;
  virtual string IniFileExt(void) const {
    return (".dat");
  }
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
  string ProgramName(void) const {
    return (m_program_name);
  }
  void SubwinOff(void);
};

EVENT_MAP_BEGIN(CAppDialog)
ON_EVENT(ON_CLICK, m_button_minmax, OnClickButtonMinMax)
ON_EXTERNAL_EVENT(ON_APP_CLOSE, OnAnotherApplicationClose)
EVENT_MAP_END(CDialog)

CAppDialog::CAppDialog(void)
    : m_program_type(WRONG_VALUE), m_deinit_reason(WRONG_VALUE),
      m_subwin_Yoff(0), m_focused_wnd(NULL), m_top_wnd(NULL) {
}

CAppDialog::~CAppDialog(void) {
}

bool CAppDialog::Create(const long chart, const string name, const int subwin,
                        const int x1, const int y1, const int x2,
                        const int y2) {
  if (!CreateCommon(chart, name, subwin))
    return (false);

  switch (m_program_type) {
  case PROGRAM_EXPERT:
    if (!CreateExpert(x1, y1, x2, y2))
      return (false);
    break;
  case PROGRAM_INDICATOR:
    if (!CreateIndicator(x1, y1, x2, y2))
      return (false);
    break;
  default:
    Print("CAppDialog: invalid program type");
    return (false);
  }

  if (!Caption(m_program_name))
    return (false);

  if (!CreateButtonMinMax())
    return (false);

  SubwinOff();

  if (m_minimized)
    Minimize();

  return (true);
}

bool CAppDialog::CreateCommon(const long chart, const string name,
                              const int subwin) {

  m_chart_id = chart;
  m_name = name;
  m_subwin = subwin;
  m_program_name = name;
  m_deinit_reason = WRONG_VALUE;

  m_instance_id = CreateInstanceId();

  m_chart.Attach(chart);

  m_program_type = (ENUM_PROGRAM_TYPE)MQL5InfoInteger(MQL5_PROGRAM_TYPE);

  if (!m_chart.EventObjectCreate() || !m_chart.EventObjectDelete() ||
      !m_chart.EventMouseMove()) {
    Print("CAppDialog: object events specify error");
    m_chart.Detach();
    return (false);
  }

  return (true);
}

bool CAppDialog::CreateExpert(const int x1, const int y1, const int x2,
                              const int y2) {

  m_subwin = 0;

  m_min_rect.SetBound(
      CONTROLS_DIALOG_MINIMIZE_LEFT, CONTROLS_DIALOG_MINIMIZE_TOP,
      CONTROLS_DIALOG_MINIMIZE_LEFT + CONTROLS_DIALOG_MINIMIZE_WIDTH,
      CONTROLS_DIALOG_MINIMIZE_TOP + CONTROLS_DIALOG_MINIMIZE_HEIGHT);

  if (!CDialog::Create(m_chart.ChartId(), m_instance_id, m_subwin, x1, y1, x2,
                       y2)) {
    Print("CAppDialog: expert dialog create error");
    m_chart.Detach();
    return (false);
  }

  return (true);
}

bool CAppDialog::CreateIndicator(const int x1, const int y1, const int x2,
                                 const int y2) {
  int width = m_chart.WidthInPixels();

  m_min_rect.LeftTop(0, 0);
  m_min_rect.Width(width);
  m_min_rect.Height(CONTROLS_DIALOG_MINIMIZE_HEIGHT -
                    2 * CONTROLS_BORDER_WIDTH);

  m_subwin = ChartWindowFind();
  if (m_subwin == -1) {
    Print("CAppDialog: find subwindow error");
    m_chart.Detach();
    return (false);
  }

  int total = ChartIndicatorsTotal(m_chart.ChartId(), m_subwin);
  m_indicator_name = ChartIndicatorName(m_chart.ChartId(), m_subwin, total - 1);

  if (m_subwin == 0)
    return (CreateExpert(x1, y1, x2, y2));

  if (total != 1) {
    Print("CAppDialog: subwindow busy");
    ChartIndicatorDelete(
        m_chart.ChartId(), m_subwin,
        ChartIndicatorName(m_chart.ChartId(), m_subwin, total - 1));
    m_chart.Detach();
    return (false);
  }

  if (!IndicatorSetInteger(INDICATOR_HEIGHT, (y2 - y1) + 1)) {
    Print("CAppDialog: subwindow resize error");
    ChartIndicatorDelete(
        m_chart.ChartId(), m_subwin,
        ChartIndicatorName(m_chart.ChartId(), m_subwin, total - 1));
    m_chart.Detach();
    return (false);
  }

  m_indicator_name = m_program_name + IntegerToString(m_subwin);
  if (!IndicatorSetString(INDICATOR_SHORTNAME, m_indicator_name)) {
    Print("CAppDialog: shortname error");
    ChartIndicatorDelete(
        m_chart.ChartId(), m_subwin,
        ChartIndicatorName(m_chart.ChartId(), m_subwin, total - 1));
    m_chart.Detach();
    return (false);
  }

  m_panel_flag = true;

  if (!CDialog::Create(m_chart.ChartId(), m_instance_id, m_subwin, 0, 0, width,
                       y2 - y1)) {
    Print("CAppDialog: indicator dialog create error");
    ChartIndicatorDelete(
        m_chart.ChartId(), m_subwin,
        ChartIndicatorName(m_chart.ChartId(), m_subwin, total - 1));
    m_chart.Detach();
    return (false);
  }

  return (true);
}

void CAppDialog::Destroy(const int reason) {

  if (m_deinit_reason != WRONG_VALUE)
    return;

  m_deinit_reason = reason;
  IniFileSave();

  m_chart.Detach();

  CDialog::Destroy();

  if (reason == REASON_PROGRAM) {
    if (m_program_type == PROGRAM_EXPERT)
      ExpertRemove();
    if (m_program_type == PROGRAM_INDICATOR)
      ChartIndicatorDelete(m_chart_id, m_subwin, m_indicator_name);
  }

  EventChartCustom(CONTROLS_SELF_MESSAGE, ON_APP_CLOSE, m_subwin, 0.0,
                   m_program_name);
}

void CAppDialog::SubwinOff(void) {
  m_subwin_Yoff = m_chart.SubwindowY(m_subwin);
}

bool CAppDialog::CreateButtonMinMax(void) {
  int off = (m_panel_flag) ? 0 : 2 * CONTROLS_BORDER_WIDTH;

  int x1 =
      Width() - off - 2 * (CONTROLS_BUTTON_SIZE + CONTROLS_DIALOG_BUTTON_OFF);
  int y1 = off + CONTROLS_DIALOG_BUTTON_OFF;
  int x2 = x1 + CONTROLS_BUTTON_SIZE;
  int y2 = y1 + CONTROLS_BUTTON_SIZE;

  if (!m_button_minmax.Create(m_chart_id, m_name + "MinMax", m_subwin, x1, y1,
                              x2, y2))
    return (false);
  if (!m_button_minmax.BmpNames("::res\Turn.bmp", "::res\Restore.bmp"))
    return (false);
  if (!CWndContainer::Add(m_button_minmax))
    return (false);
  m_button_minmax.Locking(true);
  m_button_minmax.Alignment(
      WND_ALIGN_RIGHT, 0, 0,
      off + CONTROLS_BUTTON_SIZE + 2 * CONTROLS_DIALOG_BUTTON_OFF, 0);

  CaptionAlignment(
      WND_ALIGN_WIDTH, off, 0,
      off + 2 * (CONTROLS_BUTTON_SIZE + CONTROLS_DIALOG_BUTTON_OFF), 0);

  return (true);
}

void CAppDialog::ChartEvent(const int id, const long &lparam,
                            const double &dparam, const string &sparam) {
  int mouse_x = (int)lparam;
  int mouse_y = (int)dparam - m_subwin_Yoff;

  switch (id) {
  case CHARTEVENT_CHART_CHANGE:

    break;
  case CHARTEVENT_OBJECT_CLICK:

    return;
  case CHARTEVENT_CUSTOM + ON_MOUSE_FOCUS_SET:

    if (CheckPointer(m_focused_wnd) != POINTER_INVALID) {

      if (!m_focused_wnd.MouseFocusKill(lparam))
        return;
    }
    m_focused_wnd = ControlFind(lparam);
    return;
  case CHARTEVENT_CUSTOM + ON_BRING_TO_TOP:
    m_top_wnd = ControlFind(lparam);
    return;
  case CHARTEVENT_MOUSE_MOVE:

    if (CheckPointer(m_top_wnd) != POINTER_INVALID) {

      if (m_top_wnd.OnMouseEvent(mouse_x, mouse_y,
                                 (int)StringToInteger(sparam))) {

        m_chart.Redraw();
        return;
      }
    }
    if (OnMouseEvent(mouse_x, mouse_y, (int)StringToInteger(sparam)))
      m_chart.Redraw();
    return;
  default:

    if (OnEvent(id, lparam, dparam, sparam))
      m_chart.Redraw();
    return;
  }

  if (id == CHARTEVENT_CHART_CHANGE) {

    if (m_subwin != 0 && m_subwin != ChartWindowFind()) {
      long fiction = 1;
      OnAnotherApplicationClose(fiction, dparam, sparam);
    }

    if (m_chart.HeightInPixels(m_subwin) < Height() + CONTROLS_BORDER_WIDTH) {
      m_button_minmax.Pressed(true);
      Minimize();
      m_chart.Redraw();
    }

    if (m_chart.WidthInPixels() != Width() && m_subwin != 0) {
      Width(m_chart.WidthInPixels());
      m_chart.Redraw();
    }

    SubwinOff();
    return;
  }
}

bool CAppDialog::Run(void) {

  m_chart.Redraw();

  if (Id(m_subwin * CONTROLS_MAXIMUM_ID) > CONTROLS_MAXIMUM_ID) {
    Print("CAppDialog: too many objects");
    return (false);
  }

  return (true);
}

void CAppDialog::OnClickButtonClose(void) {

  Destroy();
}

void CAppDialog::OnClickButtonMinMax(void) {
  if (m_button_minmax.Pressed())
    Minimize();
  else
    Maximize();

  SubwinOff();
}

bool CAppDialog::Rebound(const CRect &rect) {
  if (!Move(rect.LeftTop()))
    return (false);
  if (!Size(rect.Size()))
    return (false);

  if (m_program_type == PROGRAM_INDICATOR &&
      !IndicatorSetInteger(INDICATOR_HEIGHT, rect.Height() + 1)) {
    Print("CAppDialog: subwindow resize error");
    return (false);
  }

  return (true);
}

void CAppDialog::Minimize(void) {

  m_minimized = true;

  Rebound(m_min_rect);

  ClientAreaVisible(false);
}

void CAppDialog::Maximize(void) {

  m_minimized = false;

  Rebound(m_norm_rect);

  ClientAreaVisible(true);
}

string CAppDialog::CreateInstanceId(void) {
  return (IntegerToString(rand(), 5, '0'));
}

void CAppDialog::OnAnotherApplicationClose(const long &lparam,
                                           const double &dparam,
                                           const string &sparam) {

  if (m_subwin == 0)
    return;

  if (lparam == 0)
    return;

  SubwinOff();

  if (lparam >= m_subwin)
    return;

  m_subwin = ChartWindowFind();

  m_indicator_name = m_program_name + IntegerToString(m_subwin);
  IndicatorSetString(INDICATOR_SHORTNAME, m_indicator_name);

  Caption(m_program_name);

  Run();
}

void CAppDialog::IniFileSave(void) {
  string filename = IniFileName() + IniFileExt();
  int handle = FileOpen(filename, FILE_WRITE | FILE_BIN | FILE_ANSI);

  if (handle != INVALID_HANDLE) {
    Save(handle);
    FileClose(handle);
  }
}

void CAppDialog::IniFileLoad(void) {
  string filename = IniFileName() + IniFileExt();
  int handle = FileOpen(filename, FILE_READ | FILE_BIN | FILE_ANSI);

  if (handle != INVALID_HANDLE) {
    Load(handle);
    FileClose(handle);
  }
}

string CAppDialog::IniFileName(void) const {
  string name;

  name = (m_indicator_name != NULL) ? m_indicator_name : m_program_name;

  name += "_" + Symbol();
  name += "_Ini";

  return (name);
}

bool CAppDialog::Load(const int file_handle) {
  if (CDialog::Load(file_handle)) {
    if (m_minimized) {
      m_button_minmax.Pressed(true);
      Minimize();
    } else {
      m_button_minmax.Pressed(false);
      Maximize();
    }
    int prev_deinit_reason = FileReadInteger(file_handle);
    if (prev_deinit_reason == REASON_CHARTCLOSE ||
        prev_deinit_reason == REASON_CLOSE) {

      string prev_instance_id =
          IntegerToString(FileReadInteger(file_handle), 5, '0');
      if (prev_instance_id != m_instance_id) {
        long chart_id = m_chart.ChartId();
        int total = ObjectsTotal(chart_id, m_subwin);
        for (int i = total - 1; i >= 0; i--) {
          string obj_name = ObjectName(chart_id, i, m_subwin);
          if (StringFind(obj_name, prev_instance_id) == 0)
            ObjectDelete(chart_id, obj_name);
        }
      }
    }
    return (true);
  }

  return (false);
}

bool CAppDialog::Save(const int file_handle) {
  if (CDialog::Save(file_handle)) {
    FileWriteInteger(file_handle, m_deinit_reason);
    FileWriteInteger(file_handle, (int)StringToInteger(m_instance_id));
    return (true);
  }

  return (false);
}

#endif
