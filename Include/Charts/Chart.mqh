#ifndef CHART_H
#define CHART_H

#include <Object.mqh>

class CChart : public CObject {
protected:
  long m_chart_id;

public:
  CChart(void);
  ~CChart(void);

  long ChartId(void) const;

  virtual int Type(void) const;

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

  void Attach(void);
  void Attach(const long chart);
  void FirstChart(void);
  void NextChart(void);
  long Open(const string symbol_name, const ENUM_TIMEFRAMES timeframe);
  void Detach(void);
  void Close(void);

  bool Navigate(const ENUM_CHART_POSITION position, const int shift = 0) const;

  string Symbol(void) const;
  ENUM_TIMEFRAMES Period(void) const;
  void Redraw(void) const;
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

#endif
