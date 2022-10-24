#ifndef PIE_CHART_H
#define PIE_CHART_H

#include "ChartCanvas.mqh"

class CPieChart : public CChartCanvas {
private:
  CArrayDouble *m_values;

  int m_x0;
  int m_y0;
  int m_r;

public:
  CPieChart(void);
  ~CPieChart(void);

  virtual bool Create(const string name, const int width, const int height,
                      ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);

  bool SeriesSet(const double value[], const string text[], const uint clr[]);
  bool ValueAdd(const double value, const string descr = "",
                const uint clr = 0);
  bool ValueInsert(const uint pos, const double value, const string descr = "",
                   const uint clr = 0);
  bool ValueUpdate(const uint pos, const double value,
                   const string descr = NULL, const uint clr = 0);
  bool ValueDelete(const uint pos);

protected:
  virtual void DrawChart(void);
  void DrawPie(double fi3, double fi4, int idx, CPoint p[], const uint clr);
  string LabelMake(const string text, const double value, const bool to_left);
};

#endif
