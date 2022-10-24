#ifndef GRAPHIC_H
#define GRAPHIC_H

#include "Axis.mqh"
#include "ColorGenerator.mqh"
#include "Curve.mqh"
#include <Arrays\ArrayObj.mqh>

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

  int m_xc[];
  int m_yc[];
  string m_xvalues[];
  string m_yvalues[];
  int m_xsize;
  int m_ysize;
  bool m_xupdate;
  bool m_yupdate;

public:
  CGraphic(void);
  ~CGraphic(void);

  int Width(void) const {
    return (m_width);
  }
  int Height(void) const {
    return (m_height);
  }

  int IndentUp(void) const {
    return (m_up0);
  }
  void IndentUp(const int up) {
    m_up0 = up;
  }
  int IndentDown(void) const {
    return (m_down0);
  }
  void IndentDown(const int down) {
    m_down0 = down;
  }
  int IndentLeft(void) const {
    return (m_left0);
  }
  void IndentLeft(const int left) {
    m_left0 = left;
  }
  int IndentRight(void) const {
    return (m_right0);
  }
  void IndentRight(const int right) {
    m_right0 = right;
  }

  int GapSize(void) const {
    return (m_gap);
  }
  void GapSize(const int size) {
    m_gap = size;
  }

  int MajorMarkSize(void) const {
    return (m_mark_size);
  }
  void MajorMarkSize(const int size) {
    m_mark_size = size;
  }

  CAxis *XAxis(void) {
    return GetPointer(m_x);
  }
  CAxis *YAxis(void) {
    return GetPointer(m_y);
  }

  int HistoryNameWidth(void) const {
    return (m_history.name_width);
  }
  int HistoryNameSize(void) const {
    return (m_history.name_size);
  }
  int HistorySymbolSize(void) const {
    return (m_history.symbol_size);
  }

  void HistoryNameWidth(const int width) {
    m_history.name_width = width;
  }
  void HistoryNameSize(const int size) {
    m_history.name_size = size;
  }
  void HistorySymbolSize(const int size) {
    m_history.symbol_size = size;
  }

  uint GridLineColor(void) const {
    return (m_grid.clr_line);
  }
  uint GridAxisLineColor(void) const {
    return (m_grid.clr_axis_line);
  }
  uint GridBackgroundColor(void) const {
    return (m_grid.clr_background);
  }
  int GridCircleRadius(void) const {
    return (m_grid.r_circle);
  }
  uint GridCircleColor(void) const {
    return (m_grid.clr_circle);
  }
  bool GridHasCircle(void) const {
    return (m_grid.has_circle);
  }

  void GridLineColor(const uint clr) {
    m_grid.clr_line = clr;
  }
  void GridAxisLineColor(const uint clr) {
    m_grid.clr_axis_line = clr;
  }
  void GridBackgroundColor(const uint clr) {
    m_grid.clr_background = clr;
  }
  void GridCircleRadius(const int r) {
    m_grid.r_circle = r;
  }
  void GridCircleColor(const uint clr) {
    m_grid.clr_circle = clr;
  }
  void GridHasCircle(const bool has) {
    m_grid.has_circle = has;
  }

  uint BackgroundColor(void) const {
    return (m_background.clr);
  }
  uint BackgroundMainColor(void) const {
    return (m_background.clr_main);
  }
  uint BackgroundSubColor(void) const {
    return (m_background.clr_sub);
  }
  string BackgroundMain(void) const {
    return (m_background.main);
  }
  string BackgroundSub(void) const {
    return (m_background.sub);
  }
  int BackgroundMainSize(void) const {
    return (m_background.size_main);
  }
  int BackgroundSubSize(void) const {
    return (m_background.size_sub);
  }

  void BackgroundColor(const uint clr) {
    m_background.clr = clr;
  }
  void BackgroundMainColor(const uint clr) {
    m_background.clr_main = clr;
  }
  void BackgroundSubColor(const uint clr) {
    m_background.clr_sub = clr;
  }
  void BackgroundMain(const string main) {
    m_background.main = main;
  }
  void BackgroundSub(const string sub) {
    m_background.sub = sub;
  }
  void BackgroundMainSize(const int size) {
    m_background.size_main = size;
  }
  void BackgroundSubSize(const int size) {
    m_background.size_sub = size;
  }

  bool Create(const long chart, const string name, const int subwin,
              const int x1, const int y1, const int x2, const int y2);
  bool Attach(const long chart_id, const string objname);
  bool Attach(const long chart_id, const string objname, const int width,
              const int height);
  void Destroy(void);

  string ChartObjectName(void) const {
    return (m_canvas.ChartObjectName());
  }
  string ResourceName(void) const {
    return (m_canvas.ResourceName());
  }

  bool Redraw(const bool rescale = false);

  void Update(const bool redraw = true);

  CCurve *CurveAdd(const double &y[], ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(const double &x[], const double &y[], ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(const CPoint2D &points[], ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(CurveFunction function, const double from, const double to,
                   const double step, ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(const double &x[], const double &y[], const uint clr,
                   ENUM_CURVE_TYPE type, const string name = NULL);
  CCurve *CurveAdd(const double &y[], const uint clr, ENUM_CURVE_TYPE type,
                   const string name = NULL);
  CCurve *CurveAdd(const CPoint2D &points[], const uint clr,
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

  bool MarksToAxisAdd(const double &marks[], const int mark_size,
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
               const uint angle = 0) {
    return (m_canvas.FontSet(name, size, flags, angle));
  }
  void FontGet(string &name, int &size, uint &flags, uint &angle) {
    m_canvas.FontGet(name, size, flags, angle);
  }

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

CGraphic::CGraphic(void) : m_height(0.0), m_width(0.0) {
  SetDefaultParameters();
}

CGraphic::~CGraphic(void) {}

void CGraphic::CreateWorkspace(void) {

  int x1 = m_left;
  int y1 = m_up;
  int x2 = m_width - m_right;
  int y2 = m_height - m_down;

  m_canvas.FillRectangle(x1 + 1, y1 + 1, x2 - 1, y2 - 1, m_grid.clr_background);
}

void CGraphic::CreateGrid(void) {
  int xc0 = -1.0;
  int yc0 = -1.0;
  for (int i = 1; i < m_ysize - 1; i++) {
    if (StringToDouble(m_yvalues[i]) == 0.0)
      yc0 = m_yc[i];
    else
      m_canvas.LineHorizontal(m_left + 1, m_width - m_right, m_yc[i],
                              m_grid.clr_line);
    for (int j = 1; j < m_xsize - 1; j++) {
      if (i == 1) {
        if (StringToDouble(m_xvalues[j]) == 0.0)
          xc0 = m_xc[j];
        else
          m_canvas.LineVertical(m_xc[j], m_height - m_down - 1, m_up + 1,
                                m_grid.clr_line);
      }

      if (m_grid.has_circle) {
        m_canvas.FillCircle(m_xc[j], m_yc[i], m_grid.r_circle,
                            m_grid.clr_circle);
        m_canvas.CircleWu(m_xc[j], m_yc[i], m_grid.r_circle, m_grid.clr_circle);
      }
    }
  }

  if (yc0 > 0)
    m_canvas.LineHorizontal(m_left + 1, m_width - m_right, yc0,
                            m_grid.clr_axis_line);
  if (xc0 > 0)
    m_canvas.LineVertical(xc0, m_height - m_down - 1, m_up + 1,
                          m_grid.clr_axis_line);
}

void CGraphic::CreateBackground(void) {

  int x1 = 0;
  int y1 = 0;
  int x2 = m_width;
  int y2 = m_height;

  m_canvas.FillRectangle(0, 0, m_width, m_up - 1, m_background.clr);
  m_canvas.FillRectangle(0, m_height - m_down + 1, m_width, m_height,
                         m_background.clr);
  m_canvas.FillRectangle(0, m_up, m_left - 1, m_height - m_down,
                         m_background.clr);
  m_canvas.FillRectangle(m_width - m_right + 1, m_up, m_width,
                         m_height - m_down, m_background.clr);

  if (m_background.main != NULL && m_background.size_main != 0) {
    m_canvas.FontSet("Arial", m_background.size_main, FW_HEAVY);
    int xc = int((x2 + x1 - m_canvas.TextWidth(m_background.main)) / 2.0);
    int yc = m_up - m_background.size_main - m_gap;
    m_canvas.TextOut(xc, yc, m_background.main, m_background.clr_main);
    m_canvas.FontFlagsSet(0);
  }

  if (m_background.sub != NULL && m_background.size_sub != 0) {
    m_canvas.FontSet("Arial", m_background.size_sub, FW_MEDIUM);
    int xc = int((x2 + x1 - m_canvas.TextWidth(m_background.sub)) / 2.0);
    int yc = m_height - m_down + m_mark_size + m_y.ValuesSize() +
             m_y.NameSize() + m_gap * 3;
    m_canvas.TextOut(xc, yc, m_background.sub, m_background.clr_sub);
    m_canvas.FontFlagsSet(0);
  }
}

void CGraphic::CreateXName(void) {
  if (m_x.NameSize() != 0 && m_x.Name() != NULL) {
    m_canvas.FontSizeSet(m_x.NameSize());
    int yc = m_height - m_down + m_mark_size + m_x.ValuesSize() + m_gap * 2;
    m_canvas.TextOut((int)((m_width - m_canvas.TextWidth(m_x.Name())) / 2.0),
                     yc, m_x.Name(), m_x.Color());
  }
}

void CGraphic::CreateYName(void) {
  if (m_y.NameSize() != 0 && m_y.Name() != NULL) {
    m_canvas.FontSizeSet(m_y.NameSize());
    m_canvas.FontAngleSet(900);
    int xc =
        m_left - m_y.NameSize() - m_mark_size - m_y.ValuesWidth() - m_gap * 2;
    m_canvas.TextOut(xc,
                     (int)((m_height + m_canvas.TextWidth(m_y.Name())) / 2.0),
                     m_y.Name(), m_y.Color());
    m_canvas.FontAngleSet(0);
  }
}

void CGraphic::CreateAxes(void) {

  int x1 = m_left;
  int x2 = m_left - m_mark_size;
  int y1 = m_height - m_down;
  int y2 = m_height - m_down + m_mark_size;

  m_canvas.Rectangle(m_left, m_up, m_width - m_right, m_height - m_down,
                     m_grid.clr_frame);

  m_canvas.FontSet(m_y.ValuesFontName(), m_y.ValuesSize(),
                   m_y.ValuesFontFlags(), m_y.ValuesFontAngle());

  for (int i = 0; i < m_ysize; i++) {
    string yvalue = m_yvalues[i];
    int yh = m_canvas.TextHeight(yvalue);
    if (m_canvas.TextWidth(yvalue) > m_y.ValuesWidth()) {
      if (m_canvas.TextWidth("...") > m_y.ValuesWidth()) {
        yvalue = NULL;
      } else {
        while (m_canvas.TextWidth(yvalue + "...") > m_y.ValuesWidth()) {
          yvalue = StringSubstr(yvalue, 0, StringLen(yvalue) - 1);
        }
        yvalue += "...";
      }
    }

    int yi_width = m_canvas.TextWidth(yvalue);
    m_canvas.TextOut(m_left - yi_width - m_mark_size - m_gap, m_yc[i] - yh / 2,
                     yvalue, ColorToARGB(clrBlack), TA_LEFT);
    if (m_mark_size > 0.0)
      m_canvas.LineHorizontal(x1, x2, m_yc[i], ColorToARGB(clrBlack));
  }

  m_canvas.FontSet(m_x.ValuesFontName(), m_x.ValuesSize(),
                   m_x.ValuesFontFlags(), m_x.ValuesFontAngle());

  for (int i = 0; i < m_xsize; i++) {
    string xvalue = m_xvalues[i];
    int xw = m_canvas.TextWidth(xvalue);

    m_canvas.TextOut(m_xc[i] - xw / 2, y2 + m_gap, xvalue,
                     ColorToARGB(clrBlack));
    if (m_mark_size > 0.0)
      m_canvas.LineVertical(m_xc[i], y1, y2, ColorToARGB(clrBlack));
  }
}

bool CGraphic::Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2) {

  if (ObjectFind(chart, name) >= 0)
    return (false);

  int width = x2 - x1;
  int height = y2 - y1;
  if (width > 0 && height > 0) {
    m_width = width;
    m_height = height;

    if (!ObjectCreate(chart, name, OBJ_BITMAP_LABEL, subwin, 0, 0))
      return (false);

    if (!ObjectSetInteger(chart, name, OBJPROP_XDISTANCE, x1) ||
        !ObjectSetInteger(chart, name, OBJPROP_YDISTANCE, y1)) {
      ObjectDelete(chart, name);
      return (false);
    }

    if (!m_canvas.Attach(chart, name, width, height)) {
      ObjectDelete(chart, name);
      return (false);
    }
  }

  return (true);
}

bool CGraphic::Attach(const long chart_id, const string objname) {
  if (m_canvas.Attach(chart_id, objname)) {
    m_width = m_canvas.Width();
    m_height = m_canvas.Height();

    return (true);
  }

  return (false);
}

bool CGraphic::Attach(const long chart_id, const string objname,
                      const int width, const int height) {
  if (m_canvas.Attach(chart_id, objname, width, height)) {
    m_width = m_canvas.Width();
    m_height = m_canvas.Height();

    return (true);
  }

  return (false);
}

void CGraphic::Destroy(void) {
  SetDefaultParameters();
  m_generator.Reset();
  m_canvas.Destroy();
}

CCurve *CGraphic::CurveAdd(const double &y[], ENUM_CURVE_TYPE type,
                           const string name = NULL) {
  return CurveAdd(y, m_generator.Next(), type, name);
}

CCurve *CGraphic::CurveAdd(const double &x[], const double &y[],
                           ENUM_CURVE_TYPE type, const string name = NULL) {
  return CurveAdd(x, y, m_generator.Next(), type, name);
}

CCurve *CGraphic::CurveAdd(const CPoint2D &points[], ENUM_CURVE_TYPE type,
                           const string name = NULL) {
  return CurveAdd(points, m_generator.Next(), type, name);
}

CCurve *CGraphic::CurveAdd(CurveFunction function, const double from,
                           const double to, const double step,
                           ENUM_CURVE_TYPE type, const string name = NULL) {
  return CurveAdd(function, from, to, step, m_generator.Next(), type, name);
}

CCurve *CGraphic::CurveAdd(const double &y[], const uint clr,
                           ENUM_CURVE_TYPE type, const string name = NULL) {

  CCurve *curve = new CCurve(y, clr, type, name);

  if (m_arr_curves.Total() == 0) {
    if (m_x.AutoScale()) {
      m_x.Max(curve.XMax());
      m_x.Min(curve.XMin());
    }
    if (m_y.AutoScale()) {
      m_y.Max(curve.YMax());
      m_y.Min(curve.YMin());
    }
    m_xupdate = true;
    m_yupdate = true;
  } else {

    if (m_x.Max() < curve.XMax() && m_x.AutoScale()) {
      m_x.Max(curve.XMax());
      m_xupdate = true;
    }

    if (m_x.Min() > curve.XMin() && m_x.AutoScale()) {
      m_x.Min(curve.XMin());
      m_xupdate = true;
    }

    if (m_y.Max() < curve.YMax() && m_y.AutoScale()) {
      m_y.Max(curve.YMax());
      m_yupdate = true;
    }

    if (m_y.Min() > curve.YMin() && m_y.AutoScale()) {
      m_y.Min(curve.YMin());
      m_yupdate = true;
    }
  }

  m_arr_curves.Add(curve);
  return (curve);
}

CCurve *CGraphic::CurveAdd(const double &x[], const double &y[], const uint clr,
                           ENUM_CURVE_TYPE type, const string name = NULL) {
  int xSize = ArraySize(x);
  int ySize = ArraySize(y);

  if (xSize != ySize)
    return (NULL);

  CCurve *curve = new CCurve(x, y, clr, type, name);

  if (m_arr_curves.Total() == 0) {
    if (m_x.AutoScale()) {
      m_x.Max(curve.XMax());
      m_x.Min(curve.XMin());
    }
    if (m_y.AutoScale()) {
      m_y.Max(curve.YMax());
      m_y.Min(curve.YMin());
    }
    m_xupdate = true;
    m_yupdate = true;
  } else {

    if (m_x.Max() < curve.XMax() && m_x.AutoScale()) {
      m_x.Max(curve.XMax());
      m_xupdate = true;
    }

    if (m_x.Min() > curve.XMin() && m_x.AutoScale()) {
      m_x.Min(curve.XMin());
      m_xupdate = true;
    }

    if (m_y.Max() < curve.YMax() && m_y.AutoScale()) {
      m_y.Max(curve.YMax());
      m_yupdate = true;
    }

    if (m_y.Min() > curve.YMin() && m_y.AutoScale()) {
      m_y.Min(curve.YMin());
      m_yupdate = true;
    }
  }

  m_arr_curves.Add(curve);
  return (curve);
}

CCurve *CGraphic::CurveAdd(const CPoint2D &points[], const uint clr,
                           ENUM_CURVE_TYPE type, const string name = NULL) {

  CCurve *curve = new CCurve(points, clr, type, name);

  if (m_arr_curves.Total() == 0) {
    if (m_x.AutoScale()) {
      m_x.Max(curve.XMax());
      m_x.Min(curve.XMin());
    }
    if (m_y.AutoScale()) {
      m_y.Max(curve.YMax());
      m_y.Min(curve.YMin());
    }
    m_xupdate = true;
    m_yupdate = true;
  } else {

    if (m_x.Max() < curve.XMax() && m_x.AutoScale()) {
      m_x.Max(curve.XMax());
      m_xupdate = true;
    }

    if (m_x.Min() > curve.XMin() && m_x.AutoScale()) {
      m_x.Min(curve.XMin());
      m_xupdate = true;
    }

    if (m_y.Max() < curve.YMax() && m_y.AutoScale()) {
      m_y.Max(curve.YMax());
      m_yupdate = true;
    }

    if (m_y.Min() > curve.YMin() && m_y.AutoScale()) {
      m_y.Min(curve.YMin());
      m_yupdate = true;
    }
  }

  m_arr_curves.Add(curve);
  return (curve);
}

CCurve *CGraphic::CurveAdd(CurveFunction function, const double from,
                           const double to, const double step, const uint clr,
                           ENUM_CURVE_TYPE type, const string name = NULL) {

  if (from >= to || step <= 0 || step >= MathAbs(to - from))
    return (NULL);

  CCurve *curve = new CCurve(function, from, to, step, clr, type, name);

  if (m_arr_curves.Total() == 0) {
    if (m_x.AutoScale()) {
      m_x.Max(curve.XMax());
      m_x.Min(curve.XMin());
    }
    if (m_y.AutoScale()) {
      m_y.Max(curve.YMax());
      m_y.Min(curve.YMin());
    }
    m_xupdate = true;
    m_yupdate = true;
  } else {

    if (m_x.Max() < curve.XMax() && m_x.AutoScale()) {
      m_x.Max(curve.XMax());
      m_xupdate = true;
    }

    if (m_x.Min() > curve.XMin() && m_x.AutoScale()) {
      m_x.Min(curve.XMin());
      m_xupdate = true;
    }

    if (m_y.Max() < curve.YMax() && m_y.AutoScale()) {
      m_y.Max(curve.YMax());
      m_yupdate = true;
    }

    if (m_y.Min() > curve.YMin() && m_y.AutoScale()) {
      m_y.Min(curve.YMin());
      m_yupdate = true;
    }
  }

  m_arr_curves.Add(curve);
  return (curve);
}

bool CGraphic::MarksToAxisAdd(const double &marks[], const int mark_size,
                              ENUM_MARK_POSITION position,
                              const int dimension = 0) {
  int originalX = m_left;
  int originalY = m_height - m_down;

  if (dimension == 0) {
    int y1 = m_height - m_down;
    int y2 = m_height - m_down;

    switch (position) {
    case MARK_INTERNAL:
      y1 -= mark_size;
      break;
    case MARK_EXTERNAL:
      y2 += mark_size;
      break;
    case MARK_MIDDLE:
      y1 -= mark_size / 2;
      y2 += mark_size / 2;
      break;
    }

    for (int i = 0; i < ArraySize(marks); i++) {
      int x = originalX + (int)((marks[i] - m_x.Min()) * m_dx);
      m_canvas.LineVertical(x, y1, y2, ColorToARGB(clrBlack));
    }
  } else if (dimension == 1) {
    int x1 = m_left;
    int x2 = m_left;

    switch (position) {
    case MARK_INTERNAL:
      x2 += mark_size;
      break;
    case MARK_EXTERNAL:
      x1 -= mark_size;
      break;
    case MARK_MIDDLE:
      x2 += mark_size / 2;
      x1 -= mark_size / 2;
      break;
    }

    for (int i = 0; i < ArraySize(marks); i++) {
      int y = originalY - (int)((marks[i] - m_y.Min()) * m_dy);
      m_canvas.LineHorizontal(x1, x2, y, ColorToARGB(clrBlack));
    }
  } else
    return (false);

  return (true);
}

void CGraphic::TextAdd(const int x, const int y, const string text,
                       const uint clr, const uint alignment = 0) {

  if (StringLen(text) < 1)
    return;

  m_canvas.TextOut(x, y, text, clr, alignment);
}

void CGraphic::TextAdd(const CPoint &point, const string text, const uint clr,
                       const uint alignment = 0) {

  if (StringLen(text) < 1)
    return;

  m_canvas.TextOut(point.x, point.y, text, clr, alignment);
}

void CGraphic::LineAdd(const int x1, const int y1, const int x2, const int y2,
                       const uint clr, const uint style) {
  m_canvas.LineWu(x1, y1, x2, y2, clr, style);
}

void CGraphic::LineAdd(const CPoint &point1, const CPoint &point2,
                       const uint clr, const uint style) {
  m_canvas.LineWu(point1.x, point1.y, point2.x, point2.y, clr, style);
}

bool CGraphic::CurvePlotAll(void) {
  ResetParameters();
  CalculateBoundaries();

  if (m_xupdate)
    CalculateXAxis();
  if (m_yupdate)
    CalculateYAxis();

  CreateWorkspace();
  CreateGrid();

  for (int i = 0; i < m_arr_curves.Total(); i++) {

    CCurve *curve = m_arr_curves.At(i);

    if (!CheckPointer(curve))
      return (false);
    curve.Visible(true);

    switch (curve.Type()) {
    case CURVE_CUSTOM:
      CustomPlot(curve);
      break;
    case CURVE_POINTS:
      PointsPlot(curve);
      break;
    case CURVE_LINES:
      LinesPlot(curve);
      break;
    case CURVE_POINTS_AND_LINES:
      PointsAndLinesPlot(curve);
      break;
    case CURVE_STEPS:
      StepsPlot(curve);
      break;
    case CURVE_HISTOGRAM:
      HistogramPlot(curve);
      break;
    case CURVE_NONE:
      break;
    }

    if (curve.TrendLineVisible())
      TrendLinePlot(curve);
  }

  CreateBackground();

  CreateXName();
  CreateYName();

  CreateAxes();

  CreateHistory();

  return (true);
}

bool CGraphic::CurvePlot(const int index) {
  CCurve *curve = dynamic_cast<CCurve *>(m_arr_curves.At(index));
  if (CheckPointer(curve) == POINTER_DYNAMIC)
    curve.Visible(true);
  else
    return (false);

  ResetParameters();
  CalculateBoundaries();

  if (m_xupdate)
    CalculateXAxis();
  if (m_yupdate)
    CalculateYAxis();

  CreateWorkspace();
  CreateGrid();

  for (int i = 0; i < m_arr_curves.Total(); i++) {

    curve = dynamic_cast<CCurve *>(m_arr_curves.At(i));

    if (CheckPointer(curve) != POINTER_DYNAMIC)
      return (false);
    if (!curve.Visible())
      continue;

    switch (curve.Type()) {
    case CURVE_CUSTOM:
      CustomPlot(curve);
      break;
    case CURVE_POINTS:
      PointsPlot(curve);
      break;
    case CURVE_LINES:
      LinesPlot(curve);
      break;
    case CURVE_POINTS_AND_LINES:
      PointsAndLinesPlot(curve);
      break;
    case CURVE_STEPS:
      StepsPlot(curve);
      break;
    case CURVE_HISTOGRAM:
      HistogramPlot(curve);
      break;
    case CURVE_NONE:
      break;
    }

    if (curve.TrendLineVisible())
      TrendLinePlot(curve);
  }

  CreateBackground();

  CreateXName();
  CreateYName();

  CreateAxes();

  CreateHistory();

  return (true);
}

bool CGraphic::Redraw(const bool rescale = false) {
  ResetParameters();
  CalculateBoundaries();
  if (rescale) {
    CalculateMaxMinValues();
  }

  if (m_xupdate)
    CalculateXAxis();
  if (m_yupdate)
    CalculateYAxis();

  CreateWorkspace();
  CreateGrid();

  for (int i = 0; i < m_arr_curves.Total(); i++) {

    CCurve *curve = dynamic_cast<CCurve *>(m_arr_curves.At(i));

    if (CheckPointer(curve) != POINTER_DYNAMIC)
      return (false);
    if (!curve.Visible())
      continue;

    switch (curve.Type()) {
    case CURVE_CUSTOM:
      CustomPlot(curve);
      break;
    case CURVE_POINTS:
      PointsPlot(curve);
      break;
    case CURVE_LINES:
      LinesPlot(curve);
      break;
    case CURVE_POINTS_AND_LINES:
      PointsAndLinesPlot(curve);
      break;
    case CURVE_STEPS:
      StepsPlot(curve);
      break;
    case CURVE_HISTOGRAM:
      HistogramPlot(curve);
      break;
    case CURVE_NONE:
      break;
    }

    if (curve.TrendLineVisible())
      TrendLinePlot(curve);
  }

  CreateBackground();

  CreateXName();
  CreateYName();

  CreateAxes();

  CreateHistory();

  return (true);
}

void CGraphic::Update(const bool redraw = true) {
  m_canvas.Update(redraw);
}

int CGraphic::CurvesTotal(void) {
  return (m_arr_curves.Total());
}

CCurve *CGraphic::CurveGetByIndex(const int index) {
  return (m_arr_curves.At(index));
}

CCurve *CGraphic::CurveGetByName(const string name) {

  for (int i = 0; i < m_arr_curves.Total(); i++) {
    CCurve *curve = dynamic_cast<CCurve *>(m_arr_curves.At(i));
    if (curve.Name() == name)
      return (curve);
  }

  return (NULL);
}

bool CGraphic::CurveRemoveByIndex(const int index) {
  CCurve *curve = dynamic_cast<CCurve *>(m_arr_curves.Detach(index));
  if (CheckPointer(curve) == POINTER_DYNAMIC) {
    delete curve;
    return (true);
  } else {
    return (false);
  }
}

bool CGraphic::CurveRemoveByName(const string name) {
  for (int i = 0; i < m_arr_curves.Total(); i++) {
    CCurve *curve = m_arr_curves.At(i);
    if (curve.Name() == name) {
      if (CheckPointer(curve) == POINTER_DYNAMIC) {
        delete m_arr_curves.Detach(i);
        return (true);
      } else {
        return (false);
      }
    }
  }
  return (false);
}

int CGraphic::ScaleX(const double x) {
  int xc = m_left + (int)((x - m_x.Min()) * m_dx);

  return (xc);
}

int CGraphic::ScaleY(const double y) {
  int yc = m_height - m_down - (int)((y - m_y.Min()) * m_dy);

  return (yc);
}

void CGraphic::CustomPlot(CCurve *curve) {
  int size = curve.Size();
  double x[], y[];

  curve.GetX(x);
  curve.GetY(y);

  if (ArraySize(x) == 0 || ArraySize(y) == 0)
    return;

  PlotFucntion plot = curve.CustomPlotFunction();
  if (plot == NULL)
    return;

  CGraphic *graphic = GetPointer(this);
  CCanvas *canvas = GetPointer(m_canvas);
  void *cbdata = curve.CustomPlotCBData();

  plot(x, y, size, graphic, canvas, cbdata);
}

void CGraphic::PointsPlot(CCurve *curve) {
  int size = curve.Size();
  double x[], y[];

  curve.GetX(x);
  curve.GetY(y);

  if (ArraySize(x) == 0 || ArraySize(y) == 0)
    return;

  if (curve.PointsSize() == 0)
    return;

  uint clr0 = curve.Color();
  uint clr1 = curve.PointsColor();

  for (int i = 0; i < size; i++) {

    if (!MathIsValidNumber(x[i]) || !MathIsValidNumber(y[i]))
      continue;
    int xc = ScaleX(x[i]);
    int yc = ScaleY(y[i]);
    int r = curve.PointsSize() / 2;
    if (r > 0) {
      switch (curve.PointsType()) {
      case POINT_CIRCLE: {

        if (curve.PointsFill())
          m_canvas.FillCircle(xc, yc, r, clr1);

        m_canvas.CircleWu(xc, yc, r, clr0);
        break;
      }
      case POINT_SQUARE: {

        m_canvas.Rectangle(xc - r, yc - r, xc + r, yc + r, clr0);

        if (curve.PointsFill())
          m_canvas.FillRectangle(xc - r + 1, yc - r + 1, xc + r - 1, yc + r - 1,
                                 clr1);
        break;
      }
      case POINT_DIAMOND: {
        int xc1 = xc + 1 - r;
        int yc1 = yc;
        int xc2 = xc;
        int yc2 = yc + 1 - r;

        m_canvas.Line(xc - r, yc, xc, yc - r, clr0);
        m_canvas.Line(xc, yc - r, xc + r, yc, clr0);
        m_canvas.Line(xc + r, yc, xc, yc + r, clr0);
        m_canvas.Line(xc, yc + r, xc - r, yc, clr0);

        if (curve.PointsFill()) {
          int count = (curve.PointsSize() % 2 == 0) ? curve.PointsSize() - 1
                                                    : curve.PointsSize() - 2;
          for (int j = 0; j < count; j++) {
            m_canvas.Line(xc1, yc1, xc2, yc2, clr1);
            if (j % 2 == 0) {
              yc2++;
              xc1++;
            } else {
              xc2++;
              yc1++;
            }
          }
        }
        break;
      }
      case POINT_TRIANGLE: {

        m_canvas.TriangleWu(xc, yc - r, xc - r, yc + r, xc + r, yc + r, clr0);

        if (curve.PointsFill()) {
          int dy = -r;
          int dx = 0;
          int count = (curve.PointsSize() % 2 == 0) ? curve.PointsSize() - 1
                                                    : curve.PointsSize() - 2;
          for (int j = 0; j < count; j++, dy++) {
            m_canvas.LineHorizontal(xc - dx + 1, xc + dx, yc + 1 + dy, clr1);
            if (j % 2 == 0)
              dx++;
          }
        }
        break;
      }
      case POINT_TRIANGLE_DOWN: {

        m_canvas.TriangleWu(xc, yc + r, xc - r, yc - r, xc + r, yc - r, clr0);

        if (curve.PointsFill()) {
          int dy = r;
          int dx = 0;
          int count = (curve.PointsSize() % 2 == 0) ? curve.PointsSize() - 1
                                                    : curve.PointsSize() - 2;
          for (int j = 0; j < count; j++, dy--) {
            m_canvas.LineHorizontal(xc - dx + 1, xc + dx, yc - 1 + dy, clr1);
            if (j % 2 == 0)
              dx++;
          }
        }
        break;
      }
      case POINT_X_CROSS: {

        m_canvas.Line(xc + r, yc + r, xc - r, yc - r, clr0);
        m_canvas.Line(xc - r, yc + r, xc + r, yc - r, clr0);
        break;
      }
      case POINT_PLUS: {

        m_canvas.LineHorizontal(xc + r + 1, xc - r, yc, clr0);
        m_canvas.LineVertical(xc, yc + r, yc - r, clr0);
        break;
      }
      case POINT_STAR: {

        m_canvas.LineHorizontal(xc + r + 1, xc - r, yc, clr0);
        m_canvas.LineVertical(xc, yc + r, yc - r, clr0);

        m_canvas.Line(xc + r, yc + r, xc - r, yc - r, clr0);
        m_canvas.Line(xc - r, yc + r, xc + r, yc - r, clr0);
        break;
      }
      case POINT_HORIZONTAL_DASH: {

        m_canvas.LineHorizontal(xc + r + 1, xc - r, yc, clr0);
        break;
      }
      case POINT_VERTICAL_DASH: {

        m_canvas.LineVertical(xc, yc + r, yc - r, clr0);
        break;
      }
      }
    } else {
      m_canvas.PixelSet(xc, yc, clr0);
    }
  }
}

void CGraphic::LinesPlot(CCurve *curve) {
  int size;
  double x[], y[];

  size = curve.Size();
  curve.GetX(x);
  curve.GetY(y);

  if (ArraySize(x) == 0 || ArraySize(y) == 0)
    return;

  int xc[];
  int yc[];
  int discontinuity[];

  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(x[i]) || !MathIsValidNumber(y[i])) {
      ArrayResize(discontinuity, ArraySize(discontinuity) + 1, size);
      discontinuity[ArraySize(discontinuity) - 1] = i;
    }
  }

  double tension = curve.LinesSmoothTension();

  if (ArraySize(discontinuity) == 0) {

    ArrayResize(xc, size);
    ArrayResize(yc, size);
    for (int i = 0; i < size; i++) {
      xc[i] = ScaleX(x[i]);
      yc[i] = ScaleY(y[i]);
    }

    if (curve.LinesSmooth() && size > 2 && tension > 0.0 && tension <= 1.0)
      m_canvas.PolylineSmooth(xc, yc, curve.Color(), curve.LinesWidth(),
                              curve.LinesStyle(), curve.LinesEndStyle(),
                              tension, curve.LinesSmoothStep());
    else if (size > 1)
      m_canvas.PolylineThick(xc, yc, curve.Color(), curve.LinesWidth(),
                             curve.LinesStyle(), curve.LinesEndStyle());
    else if (size == 1)
      m_canvas.PixelSet(xc[0], yc[0], curve.Color());
  } else {
    int index = 0;
    for (int j = 0; j <= ArraySize(discontinuity); j++) {
      double xj[];
      double yj[];
      int sizej = 0;
      if (j == 0) {
        sizej = discontinuity[0];
        ArrayCopy(xj, x, 0, 0, sizej);
        ArrayCopy(yj, y, 0, 0, sizej);
      } else if (j == ArraySize(discontinuity)) {
        sizej = size - discontinuity[j - 1] - 1;
        ArrayCopy(xj, x, 0, discontinuity[j - 1] + 1, sizej);
        ArrayCopy(yj, y, 0, discontinuity[j - 1] + 1, sizej);
      } else {
        sizej = discontinuity[j] - discontinuity[j - 1] - 1;
        ArrayCopy(xj, x, 0, discontinuity[j - 1] + 1, sizej);
        ArrayCopy(yj, y, 0, discontinuity[j - 1] + 1, sizej);
      }

      ArrayResize(xc, sizej, size);
      ArrayResize(yc, sizej, size);
      for (int i = 0; i < sizej; i++) {
        xc[i] = ScaleX(xj[i]);
        yc[i] = ScaleY(yj[i]);
        index++;
      }

      if (curve.LinesSmooth() && size > 2 && tension > 0.0 && tension <= 1.0)
        m_canvas.PolylineSmooth(xc, yc, curve.Color(), curve.LinesWidth(),
                                curve.LinesStyle(), curve.LinesEndStyle(),
                                tension, curve.LinesSmoothStep());
      else if (sizej > 1)
        m_canvas.PolylineThick(xc, yc, curve.Color(), curve.LinesWidth(),
                               curve.LinesStyle(), curve.LinesEndStyle());
      else if (sizej == 1)
        m_canvas.PixelSet(xc[0], yc[0], curve.Color());
    }
  }
}

void CGraphic::PointsAndLinesPlot(CCurve *curve) {
  LinesPlot(curve);
  PointsPlot(curve);
}

void CGraphic::StepsPlot(CCurve *curve) {
  int size = curve.Size();
  double x[], y[];

  curve.GetX(x);
  curve.GetY(y);

  int xc[], yc[];
  size = (size * 2) - 1;
  ArrayResize(xc, size);
  ArrayResize(yc, size);
  int index = 0;
  if (curve.StepsDimension() == 0) {

    for (int i = 0; i < size - 1; i += 2, index++) {
      xc[i] = ScaleX(x[index]);
      xc[i + 1] = ScaleX(x[index + 1]);
      yc[i] = ScaleY(y[index]);
      yc[i + 1] = yc[i];
    }
  } else if (curve.StepsDimension() == 1) {

    for (int i = 0; i < size - 1; i += 2, index++) {
      xc[i] = ScaleX(x[index]);
      xc[i + 1] = xc[i];
      yc[i] = ScaleY(y[index]);
      yc[i + 1] = ScaleY(y[index + 1]);
    }
  } else {

    return;
  }

  xc[size - 1] = ScaleX(x[index]);
  yc[size - 1] = ScaleY(y[index]);
  m_canvas.PolylineWu(xc, yc, curve.Color(), curve.LinesStyle());
}

void CGraphic::HistogramPlot(CCurve *curve) {
  int size = curve.Size();
  double x[], y[];

  int histogram_width = curve.HistogramWidth();

  if (histogram_width <= 0)
    return;

  curve.GetX(x);
  curve.GetY(y);

  if (ArraySize(x) == 0 || ArraySize(y) == 0)
    return;

  int originalY = m_height - m_down;
  int yc0 = ScaleY(0.0);

  uint clr = curve.Color();

  for (int i = 0; i < size; i++) {

    if (!MathIsValidNumber(x[i]) || !MathIsValidNumber(y[i]))
      continue;
    int xc = ScaleX(x[i]);
    int yc = ScaleY(y[i]);
    int xc1 = xc - histogram_width / 2;
    int xc2 = xc + histogram_width / 2;
    int yc1 = yc;
    int yc2 = (originalY > yc0 && yc0 > 0) ? yc0 : originalY;

    if (yc1 > yc2)
      yc2++;
    else
      yc2--;

    m_canvas.FillRectangle(xc1, yc1, xc2, yc2, clr);
  }
}

void CGraphic::TrendLinePlot(CCurve *curve) {

  double coeff[];
  curve.TrendLineCoefficients(coeff);

  double x0 = curve.XMin();
  double x1 = curve.XMax();
  double y0 = coeff[0] * x0 + coeff[1];
  double y1 = coeff[0] * x1 + coeff[1];

  int xc0 = ScaleX(x0);
  int xc1 = ScaleX(x1);
  int yc0 = ScaleY(y0);
  int yc1 = ScaleY(y1);
  uint clr = curve.Color();

  m_canvas.LineWu(xc0, yc0, xc1, yc1, curve.TrendLineColor());
}

void CGraphic::CreateHistory(void) {
  for (int i = 0; i < m_arr_curves.Total(); i++) {
    CCurve *curve = dynamic_cast<CCurve *>(m_arr_curves.At(i));

    if (CheckPointer(curve) != POINTER_DYNAMIC)
      return;
    if (!curve.Visible())
      continue;

    int yc = m_up + m_history.name_size / 2 +
             m_history.name_size * m_history.count_total;

    string name = curve.Name();

    switch (curve.Type()) {
    case CURVE_STEPS:
    case CURVE_POINTS_AND_LINES:
    case CURVE_LINES: {

      int xc1 = m_width - m_right + m_gap;
      int xc2 = m_width - m_right + m_gap + m_history.symbol_size;
      if (m_history.symbol_size > 0)
        m_canvas.LineWu(xc1, yc, xc2, yc, curve.Color(), curve.LinesStyle());
      if (curve.Type() == CURVE_LINES) {
        if (name == NULL) {
          name = "Lines " + IntegerToString(m_history.count_lines++);
          curve.Name(name);
        }
        break;
      } else if (curve.Type() == CURVE_STEPS) {
        if (name == NULL) {
          name = "Steps " + IntegerToString(m_history.count_lines++);
          curve.Name(name);
        }
        break;
      }
    }
    case CURVE_POINTS: {

      int xc = m_width - m_right + m_gap + m_history.symbol_size / 2;
      int r = (m_history.symbol_size) / 3;
      if (r > 0) {
        switch (curve.PointsType()) {
        case POINT_CIRCLE: {

          if (curve.PointsFill())
            m_canvas.FillCircle(xc, yc, r, curve.PointsColor());

          m_canvas.CircleWu(xc, yc, r, curve.Color());
          break;
        }
        case POINT_SQUARE: {

          m_canvas.Rectangle(xc - r, yc - r, xc + r, yc + r, curve.Color());

          if (curve.PointsFill())
            m_canvas.FillRectangle(xc - r + 1, yc - r + 1, xc + r - 1,
                                   yc + r - 1, curve.PointsColor());
          break;
        }
        case POINT_DIAMOND: {
          int xc1 = xc + 1 - r;
          int yc1 = yc;
          int xc2 = xc;
          int yc2 = yc + 1 - r;

          m_canvas.Line(xc - r, yc, xc, yc - r, curve.Color());
          m_canvas.Line(xc, yc - r, xc + r, yc, curve.Color());
          m_canvas.Line(xc + r, yc, xc, yc + r, curve.Color());
          m_canvas.Line(xc, yc + r, xc - r, yc, curve.Color());

          if (curve.PointsFill()) {
            int count = ((r * 2) % 2 == 0) ? (r * 2) - 1 : (r * 2) - 2;
            for (int j = 0; j < count; j++) {
              m_canvas.Line(xc1, yc1, xc2, yc2, curve.PointsColor());
              if (j % 2 == 0) {
                yc2++;
                xc1++;
              } else {
                xc2++;
                yc1++;
              }
            }
          }
          break;
        }
        case POINT_TRIANGLE: {

          m_canvas.TriangleWu(xc, yc - r, xc - r, yc + r, xc + r, yc + r,
                              curve.Color());

          if (curve.PointsFill()) {
            int dy = -r;
            int dx = 0;
            int count = ((r * 2) % 2 == 0) ? (r * 2) - 1 : (r * 2) - 2;
            for (int j = 0; j < count; j++, dy++) {
              m_canvas.LineHorizontal(xc - dx + 1, xc + dx, yc + 1 + dy,
                                      curve.PointsColor());
              if (j % 2 == 0)
                dx++;
            }
          }
          break;
        }
        case POINT_TRIANGLE_DOWN: {

          m_canvas.TriangleWu(xc, yc + r, xc - r, yc - r, xc + r, yc - r,
                              curve.Color());

          if (curve.PointsFill()) {
            int dy = r;
            int dx = 0;
            int count = ((r * 2) % 2 == 0) ? (r * 2) - 1 : (r * 2) - 2;
            for (int j = 0; j < count; j++, dy--) {
              m_canvas.LineHorizontal(xc - dx + 1, xc + dx, yc - 1 + dy,
                                      curve.PointsColor());
              if (j % 2 == 0)
                dx++;
            }
          }
          break;
        }
        case POINT_X_CROSS: {

          m_canvas.Line(xc + r, yc + r, xc - r, yc - r, curve.Color());
          m_canvas.Line(xc - r, yc + r, xc + r, yc - r, curve.Color());
          break;
        }
        case POINT_PLUS: {

          m_canvas.LineHorizontal(xc + r + 1, xc - r, yc, curve.Color());
          m_canvas.LineVertical(xc, yc + r, yc - r, curve.Color());
          break;
        }
        case POINT_STAR: {

          m_canvas.LineHorizontal(xc + r + 1, xc - r, yc, curve.Color());
          m_canvas.LineVertical(xc, yc + r, yc - r, curve.Color());

          m_canvas.Line(xc + r, yc + r, xc - r, yc - r, curve.Color());
          m_canvas.Line(xc - r, yc + r, xc + r, yc - r, curve.Color());
          break;
        }
        case POINT_HORIZONTAL_DASH: {

          m_canvas.LineHorizontal(xc + r + 1, xc - r, yc, curve.Color());
          break;
        }
        case POINT_VERTICAL_DASH: {

          m_canvas.LineVertical(xc, yc + r, yc - r, curve.Color());
          break;
        }
        }
      } else {
        if (curve.PointsSize() > 0)
          m_canvas.PixelSet(xc, yc, curve.Color());
      }
      if (curve.Type() == CURVE_POINTS) {
        if (name == NULL) {
          name = "Points " + IntegerToString(m_history.count_points++);
          curve.Name(name);
        }
      } else if (curve.Type() == CURVE_POINTS_AND_LINES) {
        if (name == NULL) {
          name =
              "Points and Lines " + IntegerToString(m_history.count_points++);
          curve.Name(name);
        }
      }
      break;
    }
    case CURVE_HISTOGRAM: {

      int xc1 = m_width - m_right + m_gap + m_history.symbol_size / 6;
      int yc1 = yc - m_history.symbol_size * 1 / 3;
      int xc2 = m_width - m_right + m_gap + (m_history.symbol_size * 5) / 6;
      int yc2 = yc + m_history.symbol_size * 1 / 3;
      if (m_history.symbol_size > 0)
        m_canvas.FillRectangle(xc1, yc1, xc2, yc2, curve.Color());
      if (name == NULL) {
        name = "Histogram " + IntegerToString(m_history.count_histogram++);
        curve.Name(name);
      }
      break;
    }
    case CURVE_CUSTOM: {
      if (name == NULL) {
        name = "Custom " + IntegerToString(m_history.count_custom++);
        curve.Name(name);
      }
      break;
    }
    };

    m_canvas.FontSet("arial", m_history.name_size);
    if (m_canvas.TextWidth(name) > m_history.name_width) {
      if (m_canvas.TextWidth("...") > m_history.name_width) {
        name = NULL;
      } else {
        while (m_canvas.TextWidth(name + "...") > m_history.name_width)
          name = StringSubstr(name, 0, StringLen(name) - 1);
        name += "...";
      }
    }

    int xct = m_width - m_right + 2 * m_gap + m_history.symbol_size;
    int yct = yc - m_history.name_size / 2;

    m_canvas.TextOut(xct, yct, name, ColorToARGB(clrBlack));
    m_history.count_total++;
  }
}

void CGraphic::SetDefaultParameters(void) {

  m_xupdate = false;
  m_yupdate = false;
  m_xsize = 0;
  m_ysize = 0;

  m_left0 = 0;
  m_right0 = 5;
  m_up0 = 5;
  m_down0 = 0;

  m_mark_size = 3;
  m_gap = 4;

  m_history.name_width = 60;
  m_history.symbol_size = 12;
  m_history.name_size = 12;
  m_history.count_points = 0;
  m_history.count_lines = 0;
  m_history.count_histogram = 0;
  m_history.count_custom = 0;

  m_x.Name(NULL);
  m_y.Name(NULL);

  m_grid.clr_line = clrWhiteSmoke;
  m_grid.clr_axis_line = clrSilver;
  m_grid.clr_frame = clrBlack;
  m_grid.clr_background = clrWhite;
  m_grid.r_circle = 0;
  m_grid.clr_circle = clrWhite;
  m_grid.has_circle = false;

  m_background.clr = clrWhite;
  m_background.clr_main = clrBlack;
  m_background.clr_sub = clrBlack;
  m_background.main = NULL;
  m_background.sub = NULL;
  m_background.size_main = 0;
  m_background.size_sub = 0;
}

void CGraphic::ResetParameters(void) {

  m_left = m_left0;
  m_right = m_right0;
  m_up = m_up0;
  m_down = m_down0;

  m_history.count_total = 0;
}

void CGraphic::CalculateBoundaries(void) {
  if (m_width > 0 && m_height > 0) {
    m_right += m_history.symbol_size + m_history.name_width + 3 * m_gap;
    m_up += m_background.size_main + 2 * m_gap;
    m_down +=
        m_background.size_sub + m_x.ValuesSize() + m_x.NameSize() + 4 * m_gap;
    m_left += m_y.NameSize() + m_mark_size + m_y.ValuesWidth() + 4 * m_gap;
  } else {
    ZeroMemory(m_right);
    ZeroMemory(m_up);
    ZeroMemory(m_down);
    ZeroMemory(m_left);
  }
}

void CGraphic::CalculateMaxMinValues(void) {
  int size = m_arr_curves.Total();
  double xmax = 0.0;
  double xmin = 0.0;
  double ymax = 0.0;
  double ymin = 0.0;
  if (size > 0) {
    bool valid = false;
    for (int i = 0; i < size; i++) {
      CCurve *curve = dynamic_cast<CCurve *>(m_arr_curves.At(i));
      if (CheckPointer(curve) == POINTER_DYNAMIC) {
        if (!valid) {
          xmax = curve.XMax();
          xmin = curve.XMin();
          ymax = curve.YMax();
          ymin = curve.YMin();
          valid = true;
        } else {

          if (xmax < curve.XMax())
            xmax = curve.XMax();

          if (xmin > curve.XMin())
            xmin = curve.XMin();

          if (ymax < curve.YMax())
            ymax = curve.YMax();

          if (ymin > curve.YMin())
            ymin = curve.YMin();
        }
      }
    }
  }
  if (m_x.AutoScale()) {
    m_x.Max(xmax);
    m_x.Min(xmin);
  }
  if (m_y.AutoScale()) {
    m_y.Max(ymax);
    m_y.Min(ymin);
  }
  m_xupdate = true;
  m_yupdate = true;
}

void CGraphic::CalculateXAxis(void) {

  m_x.SelectAxisScale();

  double max = m_x.Max();
  double min = m_x.Min();
  double step = m_x.Step();
  ENUM_AXIS_TYPE xtype = m_x.Type();
  string xformat = m_x.ValuesFormat() == NULL ? "%.7g" : m_x.ValuesFormat();
  int xmode = m_x.ValuesDateTimeMode();
  DoubleToStringFunction xfunc = m_x.ValuesFunctionFormat();
  void *xcbdata = m_x.ValuesFunctionFormatCBData();

  double xf1 = m_left;
  double xf2 = m_width - m_right;

  double x_size = max - min;
  double xf_size = xf2 - xf1;

  m_dx = xf_size / x_size;

  m_xsize = (int)MathRound((max - min) / step) + 1;
  ArrayResize(m_xc, m_xsize);
  ArrayResize(m_xvalues, m_xsize);

  double factor = AxisFactorPrecision(min, max, step);
  for (int i = 0; i < m_xsize; i++) {
    double x = min + (i * step);

    if (factor != 1.0)
      x = MathRound(x / factor) * factor;
    if (x > max)
      x = max;

    if (i == 0)
      m_xc[i] = m_left;
    else if (i == m_xsize - 1)
      m_xc[i] = m_width - m_right;
    else
      m_xc[i] = m_left + (int)((x - min) * m_dx);

    switch (xtype) {
    case AXIS_TYPE_DOUBLE: {
      m_xvalues[i] = StringFormat(xformat, x);
      break;
    }
    case AXIS_TYPE_DATETIME: {
      m_xvalues[i] = TimeToString((datetime)x, xmode);
      break;
    }
    case AXIS_TYPE_CUSTOM: {
      m_xvalues[i] = (xfunc == NULL) ? NULL : xfunc(x, xcbdata);
      break;
    }
    };
  }

  m_xupdate = false;
}

void CGraphic::CalculateYAxis(void) {

  m_y.SelectAxisScale();

  double max = m_y.Max();
  double min = m_y.Min();
  double step = m_y.Step();
  ENUM_AXIS_TYPE ytype = m_y.Type();
  string yformat = m_y.ValuesFormat() == NULL ? "%.7g" : m_y.ValuesFormat();
  int ymode = m_y.ValuesDateTimeMode();
  DoubleToStringFunction yfunc = m_y.ValuesFunctionFormat();
  void *ycbdata = m_y.ValuesFunctionFormatCBData();

  double yf1 = m_up;
  double yf2 = m_height - m_down;

  double y_size = max - min;
  double yf_size = yf2 - yf1;

  m_dy = yf_size / y_size;

  m_ysize = (int)MathRound((max - min) / step) + 1;
  ArrayResize(m_yc, m_ysize);
  ArrayResize(m_yvalues, m_ysize);

  double factor = AxisFactorPrecision(min, max, step);
  for (int i = 0; i < m_ysize; i++) {
    double y = min + (i * step);

    if (factor != 1.0)
      y = MathRound(y / factor) * factor;
    if (y > max)
      y = max;

    if (i == 0)
      m_yc[i] = m_height - m_down;
    else if (i == m_ysize - 1)
      m_yc[i] = m_up;
    else
      m_yc[i] = m_height - m_down - (int)((y - min) * m_dy);

    switch (ytype) {
    case AXIS_TYPE_DOUBLE: {
      m_yvalues[i] = StringFormat(yformat, y);
      StringTrimLeft(m_yvalues[i]);
      StringTrimRight(m_yvalues[i]);
      break;
    }
    case AXIS_TYPE_DATETIME: {
      m_yvalues[i] = TimeToString((datetime)y, ymode);
      break;
    }
    case AXIS_TYPE_CUSTOM: {
      m_yvalues[i] = (yfunc == NULL) ? NULL : yfunc(y, ycbdata);
      break;
    }
    };
  }

  m_yupdate = false;
}

double CGraphic::AxisFactorPrecision(const double min, const double max,
                                     const double step) {
  static const double big_value = 4097.0;

  double big_min = big_value * min;
  double big_max = big_value * max;
  double big_step = big_value * step;

  double delta_min = big_min - min;
  double delta_max = big_max - max;
  double delta_step = big_step - step;

  double error_min = MathAbs(min - (big_min - delta_min));
  double error_max = MathAbs(max - (big_max - delta_max));
  double error_step = MathAbs(step - (big_step - delta_step));

  double error = MathMax(MathMax(error_min, error_max), error_step);

  double factor = 1.0;
  if (error != 0) {
    double log10_val = MathLog10(MathAbs(error));
    log10_val = (log10_val > 0) ? MathCeil(log10_val) : MathFloor(log10_val);
    if (log10_val <= -308)
      factor = 1e-308;
    else if (log10_val >= 308)
      factor = 1e308;
    else
      factor = MathPow(10, log10_val);
  }
  return (factor);
}

string GraphPlot(const double &y[], ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(y, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(const double &x[], const double &y[],
                 ENUM_CURVE_TYPE type = CURVE_POINTS, string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(x, y, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(const double &x1[], const double &y1[], const double &x2[],
                 const double &y2[], ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(x1, y1, type);
  graphic.CurveAdd(x2, y2, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(const double &x1[], const double &y1[], const double &x2[],
                 const double &y2[], const double &x3[], const double &y3[],
                 ENUM_CURVE_TYPE type = CURVE_POINTS, string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(x1, y1, type);
  graphic.CurveAdd(x2, y2, type);
  graphic.CurveAdd(x3, y3, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(const CPoint2D &points[], ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(points, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(const CPoint2D &points1[], const CPoint2D &points2[],
                 ENUM_CURVE_TYPE type = CURVE_POINTS, string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(points1, type);
  graphic.CurveAdd(points2, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(const CPoint2D &points1[], const CPoint2D &points2[],
                 const CPoint2D &points3[], ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(points1, type);
  graphic.CurveAdd(points2, type);
  graphic.CurveAdd(points3, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(CurveFunction function, const double from, const double to,
                 const double step, ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(function, from, to, step, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(CurveFunction function1, CurveFunction function2,
                 const double from, const double to, const double step,
                 ENUM_CURVE_TYPE type = CURVE_POINTS, string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(function1, from, to, step, type);
  graphic.CurveAdd(function2, from, to, step, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

string GraphPlot(CurveFunction function1, CurveFunction function2,
                 CurveFunction function3, const double from, const double to,
                 const double step, ENUM_CURVE_TYPE type = CURVE_POINTS,
                 string objname = NULL) {
  CGraphic graphic;
  ulong width = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
  ulong height = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

  bool res = false;
  objname = (objname == NULL) ? "Graphic" : objname;
  if (ObjectFind(0, objname) >= 0)
    res = graphic.Attach(0, objname);
  else
    res = graphic.Create(0, objname, 0, 65, 45, (int)(0.6 * width),
                         (int)(0.65 * height));
  if (!res)
    return (NULL);

  graphic.CurveAdd(function1, from, to, step, type);
  graphic.CurveAdd(function2, from, to, step, type);
  graphic.CurveAdd(function3, from, to, step, type);

  graphic.CurvePlotAll();
  graphic.Update();

  return graphic.ChartObjectName();
}

#endif
