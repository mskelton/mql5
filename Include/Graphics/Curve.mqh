#ifndef CURVE_H
#define CURVE_H

#include <Canvas/Canvas.mqh>
#include <Object.mqh>

class CGraphic;

typedef void (*PlotFucntion)(double x[], double y[], int size,
                             CGraphic *graphic, CCanvas *canvas, void *cbdata);

typedef double (*CurveFunction)(double);

enum ENUM_CURVE_TYPE {
  CURVE_POINTS,
  CURVE_LINES,
  CURVE_POINTS_AND_LINES,
  CURVE_STEPS,
  CURVE_HISTOGRAM,
  CURVE_CUSTOM,
  CURVE_NONE
};

enum ENUM_POINT_TYPE {
  POINT_CIRCLE,
  POINT_SQUARE,
  POINT_DIAMOND,
  POINT_TRIANGLE,
  POINT_TRIANGLE_DOWN,
  POINT_X_CROSS,
  POINT_PLUS,
  POINT_STAR,
  POINT_HORIZONTAL_DASH,
  POINT_VERTICAL_DASH
};

struct CPoint2D {
  double x;
  double y;
};

class CCurve : public CObject {
private:
  uint m_clr;
  double m_x;
  double m_y;
  double m_xmin;
  double m_xmax;
  double m_ymin;
  double m_ymax;
  int m_size;
  ENUM_CURVE_TYPE m_type;
  string m_name;

  ENUM_LINE_STYLE m_lines_style;
  ENUM_LINE_END m_lines_end_style;
  int m_lines_width;
  bool m_lines_smooth;
  double m_lines_tension;
  double m_lines_step;

  int m_points_size;
  ENUM_POINT_TYPE m_points_type;
  bool m_points_fill;
  uint m_points_clr;

  int m_steps_dimension;

  int m_hisogram_width;

  PlotFucntion m_custom_plot_func;
  void *m_custom_plot_cbdata;

  bool m_visible;

  uint m_trend_clr;
  bool m_trend_visible;

protected:
  bool m_trend_calc;
  double m_trend_coeff;

public:
  CCurve(const double y[], const uint clr, ENUM_CURVE_TYPE type,
         const string name);
  CCurve(const double x[], const double y[], const uint clr,
         ENUM_CURVE_TYPE type, const string name);
  CCurve(const CPoint2D points[], const uint clr, ENUM_CURVE_TYPE type,
         const string name);
  CCurve(CurveFunction function, const double from, const double to,
         const double step, const uint clr, ENUM_CURVE_TYPE type,
         const string name);
  ~CCurve(void);

  void GetX(double x[]) const;
  void GetY(double y[]) const;
  double XMax(void) const;
  double XMin(void) const;
  double YMax(void) const;
  double YMin(void) const;
  int Size(void) const;

  void Update(const double y[]);
  void Update(const double x[], const double y[]);
  void Update(const CPoint2D points[]);
  void Update(CurveFunction function, const double from, const double to,
              const double step);

  uint Color(void) const;
  int Type(void) const;
  string Name(void) const;
  bool Visible(void) const;
  void Color(const uint clr);
  void Type(const int type);
  void Name(const string name);
  void Visible(const bool visible);

  ENUM_LINE_STYLE LinesStyle(void) const;
  ENUM_LINE_END LinesEndStyle(void) const;
  int LinesWidth(void) const;
  bool LinesSmooth(void) const;
  double LinesSmoothTension(void) const;
  double LinesSmoothStep(void) const;
  void LinesStyle(ENUM_LINE_STYLE style);
  void LinesEndStyle(ENUM_LINE_END end_style);
  void LinesWidth(const int width);
  void LinesSmooth(const bool smooth);
  void LinesSmoothTension(const double tension);
  void LinesSmoothStep(const double step);

  int PointsSize(void) const;
  ENUM_POINT_TYPE PointsType(void) const;
  bool PointsFill(void) const;
  uint PointsColor(void) const;
  void PointsSize(const int size);
  void PointsType(ENUM_POINT_TYPE type);
  void PointsFill(const bool fill);
  void PointsColor(const uint clr);

  int StepsDimension(void) const;
  void StepsDimension(const int dimension);

  int HistogramWidth(void) const;
  void HistogramWidth(const int width);

  PlotFucntion CustomPlotFunction(void) const;
  void *CustomPlotCBData(void) const;
  void CustomPlotFunction(PlotFucntion func);
  void CustomPlotCBData(void *cbdata);

  bool TrendLineVisible(void) const;
  uint TrendLineColor(void) const;
  void TrendLineVisible(const bool visible);
  void TrendLineColor(const uint clr);
  void TrendLineCoefficients(double coefficients[]);

protected:
  virtual void CalculateCoefficients(void);
};

#endif
