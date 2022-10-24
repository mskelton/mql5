#ifndef CANVAS_H
#define CANVAS_H

#include <Controls/Rect.mqh>
#include <Files/FileBin.mqh>

#define SIGN(i) ((i < 0) ? -1 ;

#define XRGB(r, g, b)                                                          \
  (0xFF000000 | (uchar(r) << 16) | (uchar(g) << 8) | uchar(b))
#define ARGB(a, r, g, b)                                                       \
  ((uchar(a) << 24) | (uchar(r) << 16) | (uchar(g) << 8) | uchar(b))
#define TRGB(a, rgb) ((uchar(a) << 24) | (rgb))
#define GETRGB(clr) ((clr)&0xFFFFFF)
#define GETRGBA(clr) uchar((clr) >> 24)
#define GETRGBR(clr) uchar((clr) >> 16)
#define GETRGBG(clr) uchar((clr) >> 8)
#define GETRGBB(clr) uchar(clr)
#define COLOR2RGB(clr)                                                         \
  (0xFF000000 | (uchar(clr) << 16) | (uchar((clr) >> 8) << 8) |                \
   uchar((clr) >> 16))
#define RGB2COLOR(rgb)                                                         \
  ((uchar(rgb) << 16) | (uchar((rgb) >> 8) << 8) | uchar((rgb) >> 16))

enum ENUM_LINE_END {
  LINE_END_ROUND,
  LINE_END_BUTT,
  LINE_END_SQUARE,
};

class CCanvas {
private:
  uint m_style;
  uint m_style_idx;
  static uint m_default_colors[9];

protected:
  long m_chart_id;
  string m_objname;
  ENUM_OBJECT m_objtype;
  string m_rcname;
  int m_width;
  int m_height;
  ENUM_COLOR_FORMAT m_format;

  string m_fontname;
  int m_fontsize;
  uint m_fontflags;
  uint m_fontangle;

  uint m_pixels;

public:
  CCanvas(void);
  ~CCanvas(void);

  virtual bool Create(const string name, const int width, const int height,
                      ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);
  bool CreateBitmap(const string name, const datetime time, const double price,
                    const int width, const int height,
                    ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);
  bool CreateBitmap(const long chart_id, const int subwin, const string name,
                    const datetime time, const double price, const int width,
                    const int height,
                    ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);
  bool CreateBitmapLabel(const string name, const int x, const int y,
                         const int width, const int height,
                         ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);
  bool CreateBitmapLabel(const long chart_id, const int subwin,
                         const string name, const int x, const int y,
                         const int width, const int height,
                         ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);
  virtual bool Attach(const long chart_id, const string objname,
                      ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);
  virtual bool Attach(const long chart_id, const string objname,
                      const int width, const int height,
                      ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA);
  virtual void Destroy(void);

  string ChartObjectName(void) const ;
  string ResourceName(void) const ;
  int Width(void) const ;
  int Height(void) const ;

  void Update(const bool redraw = true);
  bool Resize(const int width, const int height);

  void Erase(const uint clr = 0);

  uint PixelGet(const int x, const int y) const;
  void PixelSet(const int x, const int y, const uint clr);

  void LineVertical(int x, int y1, int y2, const uint clr);
  void LineHorizontal(int x1, int x2, int y, const uint clr);
  void Line(int x1, int y1, int x2, int y2, const uint clr);
  void Polyline(int x[], int y[], const uint clr);
  void Polygon(int x[], int y[], const uint clr);
  void Rectangle(int x1, int y1, int x2, int y2, const uint clr);
  void Triangle(int x1, int y1, int x2, int y2, int x3, int y3, const uint clr);
  void Circle(int x, int y, int r, const uint clr);
  void Ellipse(int x1, int y1, int x2, int y2, const uint clr);
  void Arc(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4,
           const uint clr);
  void Arc(int x, int y, int rx, int ry, double fi3, double fi4,
           const uint clr);
  void Arc(int x, int y, int rx, int ry, double fi3, double fi4, int &x3,
           int &y3, int &x4, int &y4, const uint clr);
  void Pie(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4,
           const uint clr, const uint fill_clr);
  void Pie(int x, int y, int rx, int ry, double fi3, double fi4, const uint clr,
           const uint fill_clr);

  void FillRectangle(int x1, int y1, int x2, int y2, const uint clr);
  void FillTriangle(int x1, int y1, int x2, int y2, int x3, int y3,
                    const uint clr);
  void FillPolygon(int x[], int y[], const uint clr);
  void FillCircle(int x, int y, int r, const uint clr);
  void FillEllipse(int x1, int y1, int x2, int y2, const uint clr);
  void Fill(int x, int y, const uint clr);
  void Fill(int x, int y, const uint clr, const uint threshould);

  void PixelSetAA(const double x, const double y, const uint clr);
  void LineAA(const int x1, const int y1, const int x2, const int y2,
              const uint clr, const uint style = UINT_MAX);
  void PolylineAA(int x[], int y[], const uint clr,
                  const uint style = UINT_MAX);
  void PolygonAA(int x[], int y[], const uint clr,
                 const uint style = UINT_MAX);
  void TriangleAA(const int x1, const int y1, const int x2, const int y2,
                  const int x3, const int y3, const uint clr,
                  const uint style = UINT_MAX);
  void CircleAA(const int x, const int y, const double r, const uint clr,
                const uint style = UINT_MAX);
  void EllipseAA(const double x1, const double y1, const double x2,
                 const double y2, const uint clr, const uint style = UINT_MAX);

  void LineWu(int x1, int y1, int x2, int y2, const uint clr,
              const uint style = UINT_MAX);
  void PolylineWu(const int x[], const int y[], const uint clr,
                  const uint style = UINT_MAX);
  void PolygonWu(const int x[], const int y[], const uint clr,
                 const uint style = UINT_MAX);
  void TriangleWu(const int x1, const int y1, const int x2, const int y2,
                  const int x3, const int y3, const uint clr,
                  const uint style = UINT_MAX);
  void CircleWu(const int x, const int y, const double r, const uint clr,
                const uint style = UINT_MAX);
  void EllipseWu(const int x1, const int y1, const int x2, const int y2,
                 const uint clr, const uint style = UINT_MAX);

  void LineThickVertical(const int x, const int y1, const int y2,
                         const uint clr, const int size, const uint style,
                         ENUM_LINE_END end_style);
  void LineThickHorizontal(const int x1, const int x2, const int y,
                           const uint clr, const int size, const uint style,
                           ENUM_LINE_END end_style);
  void LineThick(const int x1, const int y1, const int x2, const int y2,
                 const uint clr, const int size, const uint style,
                 ENUM_LINE_END end_style);
  void PolylineThick(const int x[], const int y[], const uint clr,
                     const int size, const uint style, ENUM_LINE_END end_style);
  void PolygonThick(const int x[], const int y[], const uint clr,
                    const int size, const uint style, ENUM_LINE_END end_style);

  void PolylineSmooth(const int x[], const int y[], const uint clr,
                      const int size, ENUM_LINE_STYLE style = STYLE_SOLID,
                      ENUM_LINE_END end_style = LINE_END_ROUND,
                      double tension = 0.5, double step = 10);
  void PolygonSmooth(int x[], int y[], const uint clr, const int size,
                     ENUM_LINE_STYLE style = STYLE_SOLID,
                     ENUM_LINE_END end_style = LINE_END_ROUND,
                     double tension = 0.5, double step = 10);

  void BitBlt(int dst_x, int dst_y, const uint src[], int src_width,
              int src_height, int src_x, int src_y, int src_dx, int src_dy,
              uint mode = 0);

  bool FontSet(const string name, const int size, const uint flags = 0,
               const uint angle = 0);
  bool FontNameSet(string name);
  bool FontSizeSet(int size);
  bool FontFlagsSet(uint flags);
  bool FontAngleSet(uint angle);
  void FontGet(string &name, int &size, uint &flags, uint &angle);
  string FontNameGet(void) const ;
  int FontSizeGet(void) const ;
  uint FontFlagsGet(void) const ;
  uint FontAngleGet(void) const ;
  void TextOut(int x, int y, string text, const uint clr, uint alignment = 0);
  int TextWidth(const string text);
  int TextHeight(const string text);
  void TextSize(const string text, int &width, int &height);

  static uint GetDefaultColor(const int i);
  void TransparentLevelSet(const uchar value);

  bool LoadFromFile(const string filename);

  uint LineStyleGet(void) const;
  void LineStyleSet(const uint style);

  static bool LoadBitmap(const string filename, uint data[], int &width,
                         int &height);

private:
  bool FontSet(void);
  void TextOutFast(int x, int y, string text, const uint clr,
                   uint alignment = 0);
  bool PixelsSimilar(const uint clr0, const uint clr1, const uint threshould);

  void PixelTransform(const int x, const int y, const uint clr,
                      const double alpha);

  void PixelTransform4(const int x, const int y, const int dx, const int dy,
                       const uint clr, const double alpha);
  void PixelSet4AA(const double x, const double y, const double dx,
                   const double dy, const uint clr);

  void SegmentVertical(const int x, const int y1, const int y2, const int ysign,
                       const double r, const uint clr, ENUM_LINE_END end_style);
  void SegmentHorizontal(const int x1, const int x2, const int y,
                         const int xsign, const double r, const uint clr,
                         ENUM_LINE_END end_style);
  void Segment(const int x1, const int y1, const int x2, const int y2,
               const double kp0, const double kp1, const int xsign,
               const int ysign, const double rcos_k, const double rsin_k,
               const double r, const uint clr, ENUM_LINE_END end_style);
  double DistancePointSegment(const double px, const double py, const double x1,
                              const double y1, const double x2,
                              const double y2);

  double AngleCalc(int x1, int y1, int x2, int y2);

  int PointClassify(const CPoint &p0, const CPoint &p1, const CPoint &p2);
  int PolygonClassify(const CPoint p[]);
  bool IsPolygonConvex(CPoint p[]);
  void PolygonNormalize(CPoint p[]);
  void PolygonIntersect(CPoint p[], CPoint add[]);
  void PolygonFill(CPoint p[], const uint clr);

  void CalcCurveBezierEndp(const double xend, const double yend,
                           const double xadj, const double yadj,
                           const double tension, double &x, double &y);
  void CalcCurveBezier(const int x[], const int y[], const int i,
                       const double tension, double &x1, double &y1, double &x2,
                       double &y2);
  double CalcBezierX(const double t, const double x0, const double x1,
                     const double x2, const double x3);
  double CalcBezierY(const double t, const double y0, const double y1,
                     const double y2, const double y3);

protected:
  virtual double FilterFunction(const double x);
};

































































































#endif
