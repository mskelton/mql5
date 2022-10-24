#ifndef GRAPHIC_H
#define GRAPHIC_H

#include "Axis.mqh"
#include "ColorGenerator.mqh"
#include "Curve.mqh"
#include <Arrays/ArrayObj.mqh>

enum ENUM_MARK_POSITION { MARK_EXTERNAL, MARK_INTERNAL, MARK_MIDDLE };

struct CBackground {
  uint clr;
  uint clr_main;
  uint clr_sub;
  string main;
  string sub;
  int size_main;
  int size_sub;
};

struct CCurveHistory {
  int name_width;
  int name_size;
  int symbol_size;
  int count_total;
  int count_points;
  int count_lines;
  int count_histogram;
  int count_custom;
};

struct CGrid {
  uint clr_line;
  uint clr_background;
  uint clr_circle;
  uint clr_axis_line;
  uint clr_frame;
  int r_circle;
  bool has_circle;
};

class CGraphic {
protected:
  CArrayObj m_arr_curves;
  CCanvas m_canvas;

  int m_height;
  int m_width;

  int m_left;
  int m_right;
  int m_up;
  int m_down;

  int m_left0;
  int m_right0;
  int m_up0;
  int m_down0;

  int m_mark_size;

  double m_dx;
  double m_dy;

  CAxis m_x;
  CAxis m_y;
  CGrid m_grid;
  CBackground m_background;
  CCurveHistory m_history;

  CColorGenerator m_generator;

  int m_gap;

  int m_xc;
  int m_yc;
  string m_xvalues;
  string m_yvalues;
  int m_xsize;
  int m_ysize;
  bool m_xupdate;
  bool m_yupdate;

public:
  CGraphic(void);
  ~CGraphic(void);

  int Width(void) const;
  int Height(void) const;

  int IndentUp(void) const;
  void IndentUp(const int up);
  int IndentDown(void) const;
  void IndentDown(const int down);
  int IndentLeft(void) const;
  void IndentLeft(const int left);
  int IndentRight(void) const;
  void IndentRight(const int right);

  int GapSize(void) const;
  void GapSize(const int size);

  int MajorMarkSize(void) const;
  void MajorMarkSize(const int size);

  CAxis *XAxis(void);
  CAxis *YAxis(void);

  int HistoryNameWidth(void) const;
  int HistoryNameSize(void) const;
  int HistorySymbolSize(void) const;

  void HistoryNameWidth(const int width);
  void HistoryNameSize(const int size);
  void HistorySymbolSize(const int size);

  uint GridLineColor(void) const;
  uint GridAxisLineColor(void) const;
  uint GridBackgroundColor(void) const;
  int GridCircleRadius(void) const;
  uint GridCircleColor(void) const;
  bool GridHasCircle(void) const;

  void GridLineColor(const uint clr);
  void GridAxisLineColor(const uint clr);
  void GridBackgroundColor(const uint clr);
  void GridCircleRadius(const int r);
  void GridCircleColor(const uint clr);
  void GridHasCircle(const bool has);

  uint BackgroundColor(void) const;
  uint BackgroundMainColor(void) const;
  uint BackgroundSubColor(void) const;
  string BackgroundMain(void) const;
  string BackgroundSub(void) const;
  int BackgroundMainSize(void) const;
  int BackgroundSubSize(void) const;

  void BackgroundColor(const uint clr);
  void BackgroundMainColor(const uint clr);
  void BackgroundSubColor(const uint clr);
  void BackgroundMain(const string main);
  void BackgroundSub(const string sub);
  void BackgroundMainSize(const int size);
  void BackgroundSubSize(const int size);

  bool Create(const long chart, const string name, const int subwin,
              const int x1, const int y1, const int x2, const int y2);
  bool Attach(const long chart_id, const string objname);
  bool Attach(const long chart_id, const string objname, const int width,
              const int height);
  void Destroy(void);

  string ChartObjectName(void) const;
  string ResourceName(void) const;

  bool Redraw(const bool rescale = false);

  void Update(const bool redraw = true);

  CCurve *CurveAdd(const double y[], ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(const double x[], const double y[], ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(const CPoint2D points[], ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(CurveFunction function, const double from, const double to,
                   const double step, ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(const double x[], const double y[], const uint clr,
                   ENUM_CURVE_TYPE type, const string name = NULL);
  CCurve *CurveAdd(const double y[], const uint clr, ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(const CPoint2D points[], const uint clr,
                   ENUM_CURVE_TYPE type, const string name = NULL);
  CCurve *CurveAdd(CurveFunction function, const double from, const double to,
                   const double step, const uint clr, ENUM_CURVE_TYPE type,
                   const string name = NULL);

  bool CurvePlotAll(void);
  bool CurvePlot(const int index);

  int CurvesTotal(void);
  CCurve *CurveGetByIndex(const int index);
  CCurve *CurveGetByName(const string name);
  bool CurveRemoveByIndex(const int index);
  bool CurveRemoveByName(const string name);

  bool MarksToAxisAdd(const double marks[], const int mark_size,
                      ENUM_MARK_POSITION position, const int dimension = 0);
  void TextAdd(const int x, const int y, const string text, const uint clr,
               const uint alignment = 0);
  void TextAdd(const CPoint &point, const string text, const uint clr,
               const uint alignment = 0);
  void LineAdd(const int x1, const int y1, const int x2, const int y2,
               const uint clr, const uint style);
  void LineAdd(const CPoint &point1, const CPoint &point2, const uint clr,
               const uint style);

  bool FontSet(const string name, const int size, const uint flags = 0,
               const uint angle = 0);
  void FontGet(string &name, int &size, uint &flags, uint &angle);

  virtual int ScaleX(double x);
  virtual int ScaleY(double y);

  void SetDefaultParameters(void);
  void ResetParameters(void);

  void CalculateMaxMinValues(void);

protected:
  virtual void CustomPlot(CCurve *curve);
  virtual void PointsPlot(CCurve *curve);
  virtual void LinesPlot(CCurve *curve);
  virtual void PointsAndLinesPlot(CCurve *curve);
  virtual void StepsPlot(CCurve *curve);
  virtual void HistogramPlot(CCurve *curve);
  virtual void TrendLinePlot(CCurve *curve);

  virtual void CreateWorkspace(void);
  virtual void CreateGrid(void);
  virtual void CreateBackground(void);
  virtual void CreateXName(void);
  virtual void CreateYName(void);
  virtual void CreateAxes(void);
  virtual void CreateHistory(void);

  virtual void CalculateBoundaries(void);
  virtual void CalculateXAxis(void);
  virtual void CalculateYAxis(void);

  static double AxisFactorPrecision(const double min, const double max,
                                    const double step);
};

string GraphPlot(const double y[], ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL);

string GraphPlot(const double x[], const double y[],
                 ENUM_CURVE_TYPE type = CURVE_POINTS, string objname = NULL);

string GraphPlot(const double x1[], const double y1[], const double x2[],
                 const double y2[], ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL);

string GraphPlot(const double x1[], const double y1[], const double x2[],
                 const double y2[], const double x3[], const double y3[],
                 ENUM_CURVE_TYPE type = CURVE_POINTS, string objname = NULL);

string GraphPlot(const CPoint2D points[], ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL);

string GraphPlot(const CPoint2D points1[], const CPoint2D points2[],
                 ENUM_CURVE_TYPE type = CURVE_POINTS, string objname = NULL);

string GraphPlot(const CPoint2D points1[], const CPoint2D points2[],
                 const CPoint2D points3[], ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL);

string GraphPlot(CurveFunction function, const double from, const double to,
                 const double step, ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL);

string GraphPlot(CurveFunction function1, CurveFunction function2,
                 const double from, const double to, const double step,
                 ENUM_CURVE_TYPE type = CURVE_POINTS, string objname = NULL);

string GraphPlot(CurveFunction function1, CurveFunction function2,
                 CurveFunction function3, const double from, const double to,
                 const double step, ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL);

#endif
