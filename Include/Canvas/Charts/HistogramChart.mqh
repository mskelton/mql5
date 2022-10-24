#ifndef HISTOGRAM_CHART_H
#define HISTOGRAM_CHART_H

#include "ChartCanvas.mqh"
#include <Arrays/ArrayObj.mqh>

class CHistogramChart : public CChartCanvas {
private:
  uint m_fill_brush;

  bool m_gradient;
  uint m_bar_gap;
  uint m_bar_min_size;
  uint m_bar_border;

  CArrayObj *m_values;

public:
  CHistogramChart(void);
  ~CHistogramChart(void);

  virtual bool Create(const string name, const int width, const int height,
                      ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_ARGB_NORMALIZE);

  void Gradient(const bool flag = true);
  void BarGap(const uint value);
  void BarMinSize(const uint value);
  void BarBorder(const uint value);

  bool SeriesAdd(const double value[], const string descr = "",
                 const uint clr = 0);
  bool SeriesInsert(const uint pos, const double value[],
                    const string descr = "", const uint clr = 0);
  bool SeriesUpdate(const uint pos, const double value[],
                    const string descr = NULL, const uint clr = 0);
  bool SeriesDelete(const uint pos);
  bool ValueUpdate(const uint series, const uint pos, double value);

protected:
  virtual void DrawData(const uint idx);
  void DrawBar(const int x, const int y, const int w, const int h,
               const uint clr);
  void GradientBrush(const int size, const uint fill_clr);
};

#endif
