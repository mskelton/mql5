#ifndef CHART_CANVAS_H
#define CHART_CANVAS_H

#include "../Canvas.mqh"
#include <Arrays/ArrayDouble.mqh>
#include <Arrays/ArrayInt.mqh>
#include <Arrays/ArrayString.mqh>

enum ENUM_SHOW_FLAGS {
  FLAG_SHOW_NONE = 0,
  FLAG_SHOW_LEGEND = 1,
  FLAG_SHOW_SCALE_LEFT = 2,
  FLAG_SHOW_SCALE_RIGHT = 4,
  FLAG_SHOW_SCALE_TOP = 8,
  FLAG_SHOW_SCALE_BOTTOM = 16,
  FLAG_SHOW_GRID = 32,
  FLAG_SHOW_DESCRIPTORS = 64,
  FLAG_SHOW_VALUE = 128,
  FLAG_SHOW_PERCENT = 256,
  FLAGS_SHOW_SCALES = (FLAG_SHOW_SCALE_LEFT + FLAG_SHOW_SCALE_RIGHT +
                       FLAG_SHOW_SCALE_TOP + FLAG_SHOW_SCALE_BOTTOM),
  FLAGS_SHOW_ALL = (FLAG_SHOW_LEGEND + FLAGS_SHOW_SCALES + FLAG_SHOW_GRID +
                    FLAG_SHOW_DESCRIPTORS + FLAG_SHOW_VALUE + FLAG_SHOW_PERCENT)
};
enum ENUM_ALIGNMENT {
  ALIGNMENT_LEFT = 1,
  ALIGNMENT_TOP = 2,
  ALIGNMENT_RIGHT = 4,
  ALIGNMENT_BOTTOM = 8
};

#define IS_SHOW_LEGEND ((m_show_flags & FLAG_SHOW_LEGEND) != 0)
#define IS_SHOW_SCALES ((m_show_flags & FLAGS_SHOW_SCALES) != 0)
#define IS_SHOW_SCALE_LEFT ((m_show_flags & FLAG_SHOW_SCALE_LEFT) != 0)
#define IS_SHOW_SCALE_RIGHT ((m_show_flags & FLAG_SHOW_SCALE_RIGHT) != 0)
#define IS_SHOW_SCALE_TOP ((m_show_flags & FLAG_SHOW_SCALE_TOP) != 0)
#define IS_SHOW_SCALE_BOTTOM ((m_show_flags & FLAG_SHOW_SCALE_BOTTOM) != 0)
#define IS_SHOW_GRID ((m_show_flags & FLAG_SHOW_GRID) != 0)
#define IS_SHOW_DESCRIPTORS ((m_show_flags & FLAG_SHOW_DESCRIPTORS) != 0)
#define IS_SHOW_VALUE ((m_show_flags & FLAG_SHOW_VALUE) != 0)
#define IS_SHOW_PERCENT ((m_show_flags & FLAG_SHOW_PERCENT) != 0)

class CChartCanvas : public CCanvas {
protected:
  uint m_color_background;
  uint m_color_border;
  uint m_color_text;
  uint m_color_grid;

  uint m_max_data;
  uint m_max_descr_len;
  uint m_allowed_show_flags;
  uint m_show_flags;
  ENUM_ALIGNMENT m_legend_alignment;
  uint m_threshold_drawing;
  bool m_accumulative;

  double m_v_scale_min;
  double m_v_scale_max;
  uint m_num_grid;
  int m_scale_digits;

  int m_data_offset;
  uint m_data_total;
  CArray *m_data;
  CArrayInt m_colors;
  CArrayString m_descriptors;

  CArrayInt m_index;
  uint m_index_size;
  double m_sum;
  double m_others;
  uint m_max_descr_width;
  uint m_max_value_width;

  CRect m_data_area;

  double m_scale_x;
  int m_x_min;
  int m_x_0;
  int m_x_max;
  int m_dx_grid;
  double m_scale_y;
  int m_y_min;
  int m_y_0;
  int m_y_max;
  int m_dy_grid;
  string m_scale_text;

public:
  CChartCanvas(void);
  ~CChartCanvas(void);

  virtual bool Create(const string name, const int width, const int height,
                      ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);

  uint ColorBackground(void) const ;
  void ColorBackground(const uint value);
  uint ColorBorder(void) const ;
  void ColorBorder(const uint value);
  uint ColorText(void) const ;
  void ColorText(const uint value);
  uint ColorGrid(void) const ;
  void ColorGrid(const uint value) ;

  uint MaxData(void) const ;
  void MaxData(const uint value);
  uint MaxDescrLen(void) const ;
  void MaxDescrLen(const uint value);

  void AllowedShowFlags(const uint flags);
  uint ShowFlags(void) const ;
  void ShowFlags(const uint flags);
  bool IsShowLegend(void) const ;
  bool IsShowScaleLeft(void) const ;
  bool IsShowScaleRight(void) const ;
  bool IsShowScaleTop(void) const ;
  bool IsShowScaleBottom(void) const ;
  bool IsShowGrid(void) const ;
  bool IsShowDescriptors(void) const ;
  bool IsShowPercent(void) const ;
  void ShowLegend(const bool flag = true);
  void ShowScaleLeft(const bool flag = true);
  void ShowScaleRight(const bool flag = true);
  void ShowScaleTop(const bool flag = true);
  void ShowScaleBottom(const bool flag = true);
  void ShowGrid(const bool flag = true);
  void ShowDescriptors(const bool flag = true);
  void ShowValue(const bool flag = true);
  void ShowPercent(const bool flag = true);
  void LegendAlignment(const ENUM_ALIGNMENT value);
  void Accumulative(const bool flag = true);

  double VScaleMin(void) const ;
  void VScaleMin(const double value);
  double VScaleMax(void) const ;
  void VScaleMax(const double value);
  uint NumGrid(void) const ;
  void NumGrid(const uint value);
  void VScaleParams(const double max, const double min, const uint grid);

  int DataOffset(void) const ;
  void DataOffset(const int value);

  uint DataTotal(void) const ;
  bool DescriptorUpdate(const uint pos, const string descr);
  bool ColorUpdate(const uint pos, const uint clr);

protected:
  virtual void ValuesCheck(void);
  virtual void Redraw(void);
  virtual void DrawBackground(void);
  virtual void DrawLegend(void);
  int DrawLegendVertical(const int w, const int h);
  int DrawLegendHorizontal(const int w, const int h);
  virtual void CalcScales(void);
  virtual void DrawScales(void);
  virtual int DrawScaleLeft(const bool draw = true);
  virtual int DrawScaleRight(const bool draw = true);
  virtual int DrawScaleTop(const bool draw = true);
  virtual int DrawScaleBottom(const bool draw = true);
  virtual void DrawGrid(void);
  virtual void DrawDescriptors(void) ;
  virtual void DrawChart(void);
  virtual void DrawData(const uint idx = 0) ;
};











































#endif
