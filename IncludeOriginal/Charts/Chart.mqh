#ifndef CHART_H
#define CHART_H

#include <Object.mqh>

class CChart : public CObject {
protected:
  long m_chart_id;

public:
  CChart(void);
  ~CChart(void);

  long ChartId(void) const {
    return (m_chart_id);
  }

  virtual int Type(void) const {
    return (0x1111);
  }

  ENUM_CHART_MODE Mode(void) const;
  bool Mode(const ENUM_CHART_MODE mode) const;
  bool Foreground(void) const;
  bool Foreground(const bool foreground) const;
  bool Shift(void) const;
  bool Shift(const bool shift) const;
  double ShiftSize(void) const;
  bool ShiftSize(double shift) const;
  bool AutoScroll(void) const;
  bool AutoScroll(const bool auto_scroll) const;
  int Scale(void) const;
  bool Scale(int scale) const;
  bool ScaleFix(void) const;
  bool ScaleFix(const bool scale_fix) const;
  bool ScaleFix_11(void) const;
  bool ScaleFix_11(const bool scale_fix_11) const;
  double FixedMax(void) const;
  bool FixedMax(const double fixed_max) const;
  double FixedMin(void) const;
  bool FixedMin(const double fixed_min) const;
  bool ScalePPB(void) const;
  bool ScalePPB(const bool scale_ppb) const;
  double PointsPerBar(void) const;
  bool PointsPerBar(const double points_per_bar) const;

  bool ShowOHLC(void) const;
  bool ShowOHLC(const bool show) const;
  bool ShowLineBid(void) const;
  bool ShowLineBid(const bool show) const;
  bool ShowLineAsk(void) const;
  bool ShowLineAsk(const bool show) const;
  bool ShowLastLine(void) const;
  bool ShowLastLine(const bool show) const;
  bool ShowPeriodSep(void) const;
  bool ShowPeriodSep(const bool show) const;
  bool ShowGrid(void) const;
  bool ShowGrid(const bool show) const;
  ENUM_CHART_VOLUME_MODE ShowVolumes(void) const;
  bool ShowVolumes(const ENUM_CHART_VOLUME_MODE show) const;
  bool ShowObjectDescr(void) const;
  bool ShowObjectDescr(const bool show) const;
  bool ShowDateScale(const bool show) const;
  bool ShowPriceScale(const bool show) const;

  color ColorBackground(void) const;
  bool ColorBackground(const color new_color) const;
  color ColorForeground(void) const;
  bool ColorForeground(const color new_color) const;
  color ColorGrid(void) const;
  bool ColorGrid(const color new_color) const;
  color ColorBarUp(void) const;
  bool ColorBarUp(const color new_color) const;
  color ColorBarDown(void) const;
  bool ColorBarDown(const color new_color) const;
  color ColorCandleBull(void) const;
  bool ColorCandleBull(const color new_color) const;
  color ColorCandleBear(void) const;
  bool ColorCandleBear(const color new_color) const;
  color ColorChartLine(void) const;
  bool ColorChartLine(const color new_color) const;
  color ColorVolumes(void) const;
  bool ColorVolumes(const color new_color) const;
  color ColorLineBid(void) const;
  bool ColorLineBid(const color new_color) const;
  color ColorLineAsk(void) const;
  bool ColorLineAsk(const color new_color) const;
  color ColorLineLast(void) const;
  bool ColorLineLast(const color new_color) const;
  color ColorStopLevels(void) const;
  bool ColorStopLevels(const color new_color) const;

  bool BringToTop(void) const;
  bool EventObjectCreate(const bool flag = true) const;
  bool EventObjectDelete(const bool flag = true) const;
  bool EventMouseMove(const bool flag = true) const;
  bool MouseScroll(const bool flag = true) const;

  int VisibleBars(void) const;
  int WindowsTotal(void) const;
  bool WindowIsVisible(const int num) const;
  int WindowHandle(void) const;
  int FirstVisibleBar(void) const;
  int WidthInBars(void) const;
  int WidthInPixels(void) const;
  int HeightInPixels(const int num) const;
  int SubwindowY(const int num) const;
  double PriceMin(const int num) const;
  double PriceMax(const int num) const;
  bool IsObject(void) const;

  void Attach(void) {
    m_chart_id = ChartID();
  }
  void Attach(const long chart) {
    m_chart_id = chart;
  }
  void FirstChart(void) {
    m_chart_id = ChartFirst();
  }
  void NextChart(void) {
    m_chart_id = ChartNext(m_chart_id);
  }
  long Open(const string symbol_name, const ENUM_TIMEFRAMES timeframe);
  void Detach(void) {
    m_chart_id = -1;
  }
  void Close(void);

  bool Navigate(const ENUM_CHART_POSITION position, const int shift = 0) const;

  string Symbol(void) const {
    return (ChartSymbol(m_chart_id));
  }
  ENUM_TIMEFRAMES Period(void) const {
    return (ChartPeriod(m_chart_id));
  }
  void Redraw(void) const {
    ChartRedraw(m_chart_id);
  }
  long GetInteger(const ENUM_CHART_PROPERTY_INTEGER prop_id,
                  const int sub_window = 0) const;
  bool GetInteger(const ENUM_CHART_PROPERTY_INTEGER prop_id,
                  const int sub_window, long &value) const;
  bool SetInteger(const ENUM_CHART_PROPERTY_INTEGER prop_id,
                  const long value) const;
  double GetDouble(const ENUM_CHART_PROPERTY_DOUBLE prop_id,
                   const int sub_window = 0) const;
  bool GetDouble(const ENUM_CHART_PROPERTY_DOUBLE prop_id, const int sub_window,
                 double &value) const;
  bool SetDouble(const ENUM_CHART_PROPERTY_DOUBLE prop_id,
                 const double value) const;
  string GetString(const ENUM_CHART_PROPERTY_STRING prop_id) const;
  bool GetString(const ENUM_CHART_PROPERTY_STRING prop_id, string &value) const;
  bool SetString(const ENUM_CHART_PROPERTY_STRING prop_id,
                 const string value) const;
  bool SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period) const;
  bool ApplyTemplate(const string filename) const;
  bool ScreenShot(const string filename, const int width, const int height,
                  const ENUM_ALIGN_MODE align_mode = ALIGN_RIGHT) const;
  int WindowOnDropped(void) const;
  double PriceOnDropped(void) const;
  datetime TimeOnDropped(void) const;
  int XOnDropped(void) const;
  int YOnDropped(void) const;

  bool IndicatorAdd(const int subwin, const int handle) const;
  bool IndicatorDelete(const int subwin, const string name) const;
  int IndicatorsTotal(const int subwin) const;
  string IndicatorName(const int subwin, const int index) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChart::CChart(void) : m_chart_id(-1) {
}

CChart::~CChart(void) {
  if (m_chart_id != -1)
    Close();
}

long CChart::Open(const string symbol_name, const ENUM_TIMEFRAMES timeframe) {
  m_chart_id = ChartOpen(symbol_name, timeframe);
  if (m_chart_id == 0)
    m_chart_id = -1;
  return (m_chart_id);
}

ENUM_CHART_MODE CChart::Mode(void) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);

  return ((ENUM_CHART_MODE)ChartGetInteger(m_chart_id, CHART_MODE));
}

bool CChart::Mode(const ENUM_CHART_MODE mode) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_MODE, mode));
}

bool CChart::Foreground(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_FOREGROUND));
}

bool CChart::Foreground(const bool foreground) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_FOREGROUND, foreground));
}

bool CChart::Shift(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SHIFT));
}

bool CChart::Shift(const bool shift) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHIFT, shift));
}

double CChart::ShiftSize(void) const {

  if (m_chart_id == -1)
    return (DBL_MAX);

  return (ChartGetDouble(m_chart_id, CHART_SHIFT_SIZE));
}

bool CChart::ShiftSize(double shift) const {

  if (m_chart_id == -1)
    return (false);
  if (shift < 10)
    shift = 10;
  if (shift > 50)
    shift = 50;

  return (ChartSetDouble(m_chart_id, CHART_SHIFT_SIZE, shift));
}

bool CChart::AutoScroll(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_AUTOSCROLL));
}

bool CChart::AutoScroll(const bool auto_scroll) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_AUTOSCROLL, auto_scroll));
}

int CChart::Scale(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ChartGetInteger(m_chart_id, CHART_SCALE));
}

bool CChart::Scale(int shift) const {

  if (m_chart_id == -1)
    return (false);
  if (shift < 0)
    shift = 0;
  if (shift > 32)
    shift = 32;

  return (ChartSetInteger(m_chart_id, CHART_SCALE, shift));
}

bool CChart::ScaleFix(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SCALEFIX));
}

bool CChart::ScaleFix(const bool scale_fix) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SCALEFIX, scale_fix));
}

bool CChart::ScaleFix_11(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SCALEFIX_11));
}

bool CChart::ScaleFix_11(const bool scale_fix_11) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SCALEFIX_11, scale_fix_11));
}

double CChart::FixedMax(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ChartGetDouble(m_chart_id, CHART_FIXED_MAX));
}

bool CChart::FixedMax(const double fixed_max) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetDouble(m_chart_id, CHART_FIXED_MAX, fixed_max));
}

double CChart::FixedMin(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ChartGetDouble(m_chart_id, CHART_FIXED_MIN));
}

bool CChart::FixedMin(const double fixed_min) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetDouble(m_chart_id, CHART_FIXED_MIN, fixed_min));
}

bool CChart::ScalePPB(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SCALE_PT_PER_BAR));
}

bool CChart::ScalePPB(const bool scale_ppb) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SCALE_PT_PER_BAR, scale_ppb));
}

double CChart::PointsPerBar(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ChartGetDouble(m_chart_id, CHART_POINTS_PER_BAR));
}

bool CChart::PointsPerBar(const double points_per_bar) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetDouble(m_chart_id, CHART_POINTS_PER_BAR, points_per_bar));
}

bool CChart::ShowOHLC(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SHOW_OHLC));
}

bool CChart::ShowOHLC(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_OHLC, show));
}

bool CChart::ShowLineBid(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SHOW_BID_LINE));
}

bool CChart::ShowLineBid(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_BID_LINE, show));
}

bool CChart::ShowLineAsk(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SHOW_ASK_LINE));
}

bool CChart::ShowLineAsk(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_ASK_LINE, show));
}

bool CChart::ShowLastLine(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SHOW_LAST_LINE));
}

bool CChart::ShowLastLine(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_LAST_LINE, show));
}

bool CChart::ShowPeriodSep(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SHOW_PERIOD_SEP));
}

bool CChart::ShowPeriodSep(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_PERIOD_SEP, show));
}

bool CChart::ShowGrid(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SHOW_GRID));
}

bool CChart::ShowGrid(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_GRID, show));
}

ENUM_CHART_VOLUME_MODE CChart::ShowVolumes(void) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);

  return (
      (ENUM_CHART_VOLUME_MODE)ChartGetInteger(m_chart_id, CHART_SHOW_VOLUMES));
}

bool CChart::ShowVolumes(const ENUM_CHART_VOLUME_MODE show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_VOLUMES, show));
}

bool CChart::ShowObjectDescr(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_SHOW_OBJECT_DESCR));
}

bool CChart::ShowObjectDescr(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_OBJECT_DESCR, show));
}

bool CChart::ShowDateScale(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_DATE_SCALE, show));
}

bool CChart::ShowPriceScale(const bool show) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_SHOW_PRICE_SCALE, show));
}

color CChart::ColorBackground(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_BACKGROUND));
}

bool CChart::ColorBackground(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_BACKGROUND, new_color));
}

color CChart::ColorForeground(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_FOREGROUND));
}

bool CChart::ColorForeground(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_FOREGROUND, new_color));
}

color CChart::ColorGrid(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_GRID));
}

bool CChart::ColorGrid(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_GRID, new_color));
}

color CChart::ColorBarUp(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_CHART_UP));
}

bool CChart::ColorBarUp(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_CHART_UP, new_color));
}

color CChart::ColorBarDown(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_CHART_DOWN));
}

bool CChart::ColorBarDown(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_CHART_DOWN, new_color));
}

color CChart::ColorCandleBull(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_CANDLE_BULL));
}

bool CChart::ColorCandleBull(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_CANDLE_BULL, new_color));
}

color CChart::ColorCandleBear(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_CANDLE_BEAR));
}

bool CChart::ColorCandleBear(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_CANDLE_BEAR, new_color));
}

color CChart::ColorChartLine(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_CHART_LINE));
}

bool CChart::ColorChartLine(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_CHART_LINE, new_color));
}

color CChart::ColorVolumes(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_VOLUME));
}

bool CChart::ColorVolumes(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_VOLUME, new_color));
}

color CChart::ColorLineBid(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_BID));
}

bool CChart::ColorLineBid(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_BID, new_color));
}

color CChart::ColorLineAsk(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_ASK));
}

bool CChart::ColorLineAsk(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_ASK, new_color));
}

color CChart::ColorLineLast(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_LAST));
}

bool CChart::ColorLineLast(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_LAST, new_color));
}

color CChart::ColorStopLevels(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ChartGetInteger(m_chart_id, CHART_COLOR_STOP_LEVEL));
}

bool CChart::ColorStopLevels(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_COLOR_STOP_LEVEL, new_color));
}

bool CChart::BringToTop(void) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_BRING_TO_TOP, true));
}

bool CChart::EventObjectCreate(const bool flag) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_EVENT_OBJECT_CREATE, flag));
}

bool CChart::EventObjectDelete(const bool flag) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_EVENT_OBJECT_DELETE, flag));
}

bool CChart::EventMouseMove(const bool flag) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_EVENT_MOUSE_MOVE, flag));
}

bool CChart::MouseScroll(const bool flag) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, CHART_MOUSE_SCROLL, flag));
}

int CChart::VisibleBars(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ChartGetInteger(m_chart_id, CHART_WIDTH_IN_BARS));
}

int CChart::WindowsTotal(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ChartGetInteger(m_chart_id, CHART_WINDOWS_TOTAL));
}

bool CChart::WindowIsVisible(const int num) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_WINDOW_IS_VISIBLE, num));
}

int CChart::WindowHandle(void) const {

  if (m_chart_id == -1)
    return (INVALID_HANDLE);

  return ((int)ChartGetInteger(m_chart_id, CHART_WINDOW_HANDLE));
}

int CChart::FirstVisibleBar(void) const {

  if (m_chart_id == -1)
    return (-1);

  return ((int)ChartGetInteger(m_chart_id, CHART_FIRST_VISIBLE_BAR));
}

int CChart::WidthInBars(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ChartGetInteger(m_chart_id, CHART_WIDTH_IN_BARS));
}

int CChart::WidthInPixels(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ChartGetInteger(m_chart_id, CHART_WIDTH_IN_PIXELS));
}

int CChart::HeightInPixels(const int num) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ChartGetInteger(m_chart_id, CHART_HEIGHT_IN_PIXELS, num));
}

int CChart::SubwindowY(const int num) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ChartGetInteger(m_chart_id, CHART_WINDOW_YDISTANCE, num));
}

double CChart::PriceMin(const int num) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ChartGetDouble(m_chart_id, CHART_PRICE_MIN, num));
}

double CChart::PriceMax(const int num) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ChartGetDouble(m_chart_id, CHART_PRICE_MAX, num));
}

bool CChart::IsObject(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ChartGetInteger(m_chart_id, CHART_IS_OBJECT));
}

void CChart::Close(void) {
  if (m_chart_id != -1) {
    ChartClose(m_chart_id);
    m_chart_id = -1;
  }
}

bool CChart::Navigate(const ENUM_CHART_POSITION position,
                      const int shift) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartNavigate(m_chart_id, position, shift));
}

long CChart::GetInteger(const ENUM_CHART_PROPERTY_INTEGER prop_id,
                        const int subwindow) const {

  if (m_chart_id == -1)
    return (0);

  return (ChartGetInteger(m_chart_id, prop_id, subwindow));
}

bool CChart::GetInteger(const ENUM_CHART_PROPERTY_INTEGER prop_id,
                        const int subwindow, long &value) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartGetInteger(m_chart_id, prop_id, subwindow, value));
}

bool CChart::SetInteger(const ENUM_CHART_PROPERTY_INTEGER prop_id,
                        const long value) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetInteger(m_chart_id, prop_id, value));
}

double CChart::GetDouble(const ENUM_CHART_PROPERTY_DOUBLE prop_id,
                         const int subwindow) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ChartGetDouble(m_chart_id, prop_id, subwindow));
}

bool CChart::GetDouble(const ENUM_CHART_PROPERTY_DOUBLE prop_id,
                       const int subwindow, double &value) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartGetDouble(m_chart_id, prop_id, subwindow, value));
}

bool CChart::SetDouble(const ENUM_CHART_PROPERTY_DOUBLE prop_id,
                       const double value) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetDouble(m_chart_id, prop_id, value));
}

string CChart::GetString(const ENUM_CHART_PROPERTY_STRING prop_id) const {

  if (m_chart_id == -1)
    return ("");

  return (ChartGetString(m_chart_id, prop_id));
}

bool CChart::GetString(const ENUM_CHART_PROPERTY_STRING prop_id,
                       string &value) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartGetString(m_chart_id, prop_id, value));
}

bool CChart::SetString(const ENUM_CHART_PROPERTY_STRING prop_id,
                       const string value) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetString(m_chart_id, prop_id, value));
}

bool CChart::SetSymbolPeriod(const string symbol,
                             const ENUM_TIMEFRAMES period) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartSetSymbolPeriod(m_chart_id, symbol, period));
}

bool CChart::ApplyTemplate(const string filename) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartApplyTemplate(m_chart_id, filename));
}

bool CChart::ScreenShot(const string filename, const int width,
                        const int height,
                        const ENUM_ALIGN_MODE align_mode) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartScreenShot(m_chart_id, filename, width, height, align_mode));
}

int CChart::WindowOnDropped(void) const {

  if (m_chart_id == -1)
    return (0);

  return (ChartWindowOnDropped());
}

double CChart::PriceOnDropped(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ChartPriceOnDropped());
}

datetime CChart::TimeOnDropped(void) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartTimeOnDropped());
}

int CChart::XOnDropped(void) const {

  if (m_chart_id == -1)
    return (0);

  return (ChartXOnDropped());
}

int CChart::YOnDropped(void) const {

  if (m_chart_id == -1)
    return (0);

  return (ChartYOnDropped());
}

bool CChart::IndicatorAdd(const int subwin, const int handle) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartIndicatorAdd(m_chart_id, subwin, handle));
}

bool CChart::IndicatorDelete(const int subwin, const string name) const {

  if (m_chart_id == -1)
    return (false);

  return (ChartIndicatorDelete(m_chart_id, subwin, name));
}

int CChart::IndicatorsTotal(const int subwin) const {

  if (m_chart_id == -1)
    return (0);

  return (ChartIndicatorsTotal(m_chart_id, subwin));
}

string CChart::IndicatorName(const int subwin, const int index) const {

  if (m_chart_id == -1)
    return ("");

  return (ChartIndicatorName(m_chart_id, subwin, index));
}

bool CChart::Save(const int file_handle) {
  string work_str;
  int work_int;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (FileWriteLong(file_handle, -1) != sizeof(long))
    return (false);

  if (FileWriteInteger(file_handle, Type(), INT_VALUE) != INT_VALUE)
    return (false);

  work_str = Symbol();
  work_int = StringLen(work_str);
  if (FileWriteInteger(file_handle, work_int, INT_VALUE) != INT_VALUE)
    return (false);
  if (work_int != 0)
    if (FileWriteString(file_handle, work_str, work_int) != work_int)
      return (false);

  if (FileWriteInteger(file_handle, Period(), INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_MODE),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_FOREGROUND),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHIFT),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHIFT),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_AUTOSCROLL),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SCALE),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SCALEFIX),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SCALEFIX_11),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteDouble(file_handle,
                      ChartGetDouble(m_chart_id, CHART_FIXED_MAX)) !=
      sizeof(double))
    return (false);

  if (FileWriteDouble(file_handle,
                      ChartGetDouble(m_chart_id, CHART_FIXED_MIN)) !=
      sizeof(double))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SCALE_PT_PER_BAR),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteDouble(file_handle,
                      ChartGetDouble(m_chart_id, CHART_POINTS_PER_BAR)) !=
      sizeof(double))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHOW_OHLC),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHOW_BID_LINE),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHOW_ASK_LINE),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHOW_LAST_LINE),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHOW_PERIOD_SEP),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHOW_GRID),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ChartGetInteger(m_chart_id, CHART_SHOW_VOLUMES),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ChartGetInteger(m_chart_id, CHART_SHOW_OBJECT_DESCR),
          CHAR_VALUE) != sizeof(char))
    return (false);

  return (true);
}

bool CChart::Load(const int file_handle) {
  bool resutl = true;
  string work_str;
  int work_int;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (FileReadLong(file_handle) != -1)
    return (false);

  if (FileReadInteger(file_handle, INT_VALUE) != Type())
    return (false);

  work_int = FileReadInteger(file_handle);
  if (work_int != 0)
    work_str = FileReadString(file_handle, work_int);
  else
    work_str = "";

  work_int = FileReadInteger(file_handle);
  SetSymbolPeriod(work_str, (ENUM_TIMEFRAMES)work_int);

  if (!ChartSetInteger(m_chart_id, CHART_MODE,
                       FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_FOREGROUND,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHIFT,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHIFT,
                       FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_AUTOSCROLL,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SCALE,
                       FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SCALEFIX,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SCALEFIX_11,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetDouble(m_chart_id, CHART_FIXED_MAX,
                      FileReadDatetime(file_handle)))
    return (false);

  if (!ChartSetDouble(m_chart_id, CHART_FIXED_MIN,
                      FileReadDatetime(file_handle)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SCALE_PT_PER_BAR,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetDouble(m_chart_id, CHART_POINTS_PER_BAR,
                      FileReadDatetime(file_handle)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHOW_OHLC,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHOW_BID_LINE,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHOW_ASK_LINE,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHOW_LAST_LINE,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHOW_PERIOD_SEP,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHOW_GRID,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHOW_VOLUMES,
                       FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ChartSetInteger(m_chart_id, CHART_SHOW_OBJECT_DESCR,
                       FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  return (resutl);
}

#endif
