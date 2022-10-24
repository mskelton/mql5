#ifndef LINE_CHART_H
#define LINE_CHART_H

#include "ChartCanvas.mqh"
#include <Arrays/ArrayObj.mqh>

class CLineChart : public CChartCanvas {
private:
  CArrayObj *m_values;

  bool m_filled;

public:
  CLineChart(void);
  ~CLineChart(void);

  virtual bool Create(const string name, const int width, const int height,
                      ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_ARGB_NORMALIZE);

  void Filled(const bool flag = true);

  bool SeriesAdd(const double value[], const string descr = "",
                 const uint clr = 0);
  bool SeriesInsert(const uint pos, const double value[],
                    const string descr = "", const uint clr = 0);
  bool SeriesUpdate(const uint pos, const double value[],
                    const string descr = NULL, const uint clr = 0);
  bool SeriesDelete(const uint pos);
  bool ValueUpdate(const uint series, const uint pos, double value);

protected:
  virtual void DrawChart(void);
  virtual void DrawData(const uint index = 0);

private:
  double CalcArea(const uint index);
};

#endif
