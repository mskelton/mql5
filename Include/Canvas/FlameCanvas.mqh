#ifndef FLAME_CANVAS_H
#define FLAME_CANVAS_H

#include "Canvas.mqh"
#include <Controls/Defines.mqh>

struct GRADIENT_COLOR {
  uint clr;
  uint pos;
};

struct GRADIENT_SIZE {
  uint size;
  uint pos;
};

class CFlameCanvas : public CCanvas {
private:
  uint m_bar_gap;
  uint m_bar_width;
  uint m_chart_scale;
  double m_chart_price_min;
  double m_chart_price_max;
  ENUM_TIMEFRAMES m_timeframe;
  string m_symbol;
  int m_future_bars;
  int m_back_bars;
  int m_rates_total;
  uint m_palette[256];
  uchar m_flame;
  uint m_time_redraw;
  uint m_delay;

  datetime m_tb1;
  double m_pb1;
  datetime m_te1;
  double m_pe1;
  datetime m_tb2;
  double m_pb2;
  datetime m_te2;
  double m_pe2;

  int m_cloud_axis[100];
  double m_a1;
  double m_b1;
  double m_a2;
  double m_b2;
  int m_xb1;
  int m_yb1;
  int m_xe1;
  int m_ye1;
  int m_xb2;
  int m_yb2;
  int m_xe2;
  int m_ye2;

public:
  CFlameCanvas(void);
  ~CFlameCanvas(void);

  bool FlameCreate(const string name, const datetime time,
                   const int future_bars, const int back_bars = 0);
  void RatesTotal(const int value);

  void PaletteSet(uint clr = 0xFF0000);

  void FlameDraw(const double prices[], const int width, const int lenght);
  void FlameSet(datetime xb1, double yb1, datetime xe1, double ye1,
                datetime xb2, double yb2, datetime xe2, double ye2);

  void ChartEventHandler(const int id, const long &lparam, const double &dparam,
                         const string &sparam);

protected:
  bool Resize(void);
  void ChartScale(void);
  void FlameSet(void);
  void CloudDraw(const double prices[], const int width, const int lenght,
                 GRADIENT_SIZE size[], GRADIENT_COLOR gradient[],
                 const uchar t_level = 255, const bool custom_gradient = true);
  void FlameDraw(const int width, const int lenght, GRADIENT_SIZE size[],
                 GRADIENT_COLOR gradient[]);
  void GradientVertical(const int xb, const int xe, const int yb1,
                        const int ye1, const int yb2, const int ye2,
                        const GRADIENT_COLOR gradient[]);
  void GradientVerticalLine(int x, int y1, int y2,
                            const GRADIENT_COLOR gradient[]);
  void GradientVerticalLineMonochrome(int x, int y1, int y2, uint clr1,
                                      uint clr2);
  void FlameCreate(void);
  void FlameCalculate(void);
  void Delay(const uint value);
};
