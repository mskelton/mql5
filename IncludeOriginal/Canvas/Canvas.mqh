#ifndef CANVAS_H
#define CANVAS_H

#include <Controls\Rect.mqh>
#include <Files\FileBin.mqh>

#define SIGN(i) ((i < 0) ? -1 : 1)

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

  uint m_pixels[];

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

  string ChartObjectName(void) const {
    return (m_objname);
  }
  string ResourceName(void) const {
    return (m_rcname);
  }
  int Width(void) const {
    return (m_width);
  }
  int Height(void) const {
    return (m_height);
  }

  void Update(const bool redraw = true);
  bool Resize(const int width, const int height);

  void Erase(const uint clr = 0);

  uint PixelGet(const int x, const int y) const;
  void PixelSet(const int x, const int y, const uint clr);

  void LineVertical(int x, int y1, int y2, const uint clr);
  void LineHorizontal(int x1, int x2, int y, const uint clr);
  void Line(int x1, int y1, int x2, int y2, const uint clr);
  void Polyline(int &x[], int &y[], const uint clr);
  void Polygon(int &x[], int &y[], const uint clr);
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
  void FillPolygon(int &x[], int &y[], const uint clr);
  void FillCircle(int x, int y, int r, const uint clr);
  void FillEllipse(int x1, int y1, int x2, int y2, const uint clr);
  void Fill(int x, int y, const uint clr);
  void Fill(int x, int y, const uint clr, const uint threshould);

  void PixelSetAA(const double x, const double y, const uint clr);
  void LineAA(const int x1, const int y1, const int x2, const int y2,
              const uint clr, const uint style = UINT_MAX);
  void PolylineAA(int &x[], int &y[], const uint clr,
                  const uint style = UINT_MAX);
  void PolygonAA(int &x[], int &y[], const uint clr,
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
  void PolylineWu(const int &x[], const int &y[], const uint clr,
                  const uint style = UINT_MAX);
  void PolygonWu(const int &x[], const int &y[], const uint clr,
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
  void PolylineThick(const int &x[], const int &y[], const uint clr,
                     const int size, const uint style, ENUM_LINE_END end_style);
  void PolygonThick(const int &x[], const int &y[], const uint clr,
                    const int size, const uint style, ENUM_LINE_END end_style);

  void PolylineSmooth(const int &x[], const int &y[], const uint clr,
                      const int size, ENUM_LINE_STYLE style = STYLE_SOLID,
                      ENUM_LINE_END end_style = LINE_END_ROUND,
                      double tension = 0.5, double step = 10);
  void PolygonSmooth(int &x[], int &y[], const uint clr, const int size,
                     ENUM_LINE_STYLE style = STYLE_SOLID,
                     ENUM_LINE_END end_style = LINE_END_ROUND,
                     double tension = 0.5, double step = 10);

  void BitBlt(int dst_x, int dst_y, const uint &src[], int src_width,
              int src_height, int src_x, int src_y, int src_dx, int src_dy,
              uint mode = 0);

  bool FontSet(const string name, const int size, const uint flags = 0,
               const uint angle = 0);
  bool FontNameSet(string name);
  bool FontSizeSet(int size);
  bool FontFlagsSet(uint flags);
  bool FontAngleSet(uint angle);
  void FontGet(string &name, int &size, uint &flags, uint &angle);
  string FontNameGet(void) const {
    return (m_fontname);
  }
  int FontSizeGet(void) const {
    return (m_fontsize);
  }
  uint FontFlagsGet(void) const {
    return (m_fontflags);
  }
  uint FontAngleGet(void) const {
    return (m_fontangle);
  }
  void TextOut(int x, int y, string text, const uint clr, uint alignment = 0);
  int TextWidth(const string text);
  int TextHeight(const string text);
  void TextSize(const string text, int &width, int &height);

  static uint GetDefaultColor(const int i);
  void TransparentLevelSet(const uchar value);

  bool LoadFromFile(const string filename);

  uint LineStyleGet(void) const;
  void LineStyleSet(const uint style);

  static bool LoadBitmap(const string filename, uint &data[], int &width,
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
  int PolygonClassify(const CPoint &p[]);
  bool IsPolygonConvex(CPoint &p[]);
  void PolygonNormalize(CPoint &p[]);
  void PolygonIntersect(CPoint &p[], CPoint &add[]);
  void PolygonFill(CPoint &p[], const uint clr);

  void CalcCurveBezierEndp(const double xend, const double yend,
                           const double xadj, const double yadj,
                           const double tension, double &x, double &y);
  void CalcCurveBezier(const int &x[], const int &y[], const int i,
                       const double tension, double &x1, double &y1, double &x2,
                       double &y2);
  double CalcBezierX(const double t, const double x0, const double x1,
                     const double x2, const double x3);
  double CalcBezierY(const double t, const double y0, const double y1,
                     const double y2, const double y3);

protected:
  virtual double FilterFunction(const double x);
};

uint CCanvas::m_default_colors[9] = {
    XRGB(0, 0, 255),   XRGB(255, 0, 0),   XRGB(0, 128, 0),
    XRGB(255, 242, 0), XRGB(255, 0, 128), XRGB(0, 255, 0),
    XRGB(185, 0, 61),  XRGB(0, 183, 239), XRGB(255, 128, 0)};

CCanvas::CCanvas(void)
    : m_chart_id(0), m_objname(NULL), m_objtype(WRONG_VALUE), m_rcname(NULL),
      m_width(0), m_height(0), m_format(COLOR_FORMAT_XRGB_NOALPHA),
      m_fontname("arial"), m_fontsize(-120), m_fontflags(0), m_fontangle(0),
      m_style(UINT_MAX), m_style_idx(0) {
}

CCanvas::~CCanvas(void) {
}

bool CCanvas::Create(const string name, const int width, const int height,
                     ENUM_COLOR_FORMAT clrfmt) {
  Destroy();

  if (width > 0 && height > 0 && ArrayResize(m_pixels, width * height) > 0) {

    m_rcname =
        "::" + name + (string)ChartID() + (string)(GetTickCount() + MathRand());

    ArrayInitialize(m_pixels, 0);

    if (ResourceCreate(m_rcname, m_pixels, width, height, 0, 0, 0, clrfmt)) {

      m_width = width;
      m_height = height;
      m_format = clrfmt;

      return (true);
    }
  }

  Destroy();
  return (false);
}

bool CCanvas::CreateBitmap(const string name, const datetime time,
                           const double price, const int width,
                           const int height, ENUM_COLOR_FORMAT clrfmt) {
  return (CreateBitmap(0, 0, name, time, price, width, height, clrfmt));
}

bool CCanvas::CreateBitmap(const long chart_id, const int subwin,
                           const string name, const datetime time,
                           const double price, const int width,
                           const int height, ENUM_COLOR_FORMAT clrfmt) {

  if (Create(name, width, height, clrfmt)) {

    if (ObjectCreate(chart_id, name, OBJ_BITMAP, subwin, time, price)) {

      if (ObjectSetString(chart_id, name, OBJPROP_BMPFILE, m_rcname)) {

        m_chart_id = chart_id;
        m_objname = name;
        m_objtype = OBJ_BITMAP;

        return (true);
      }
    }
  }

  return (false);
}

bool CCanvas::CreateBitmapLabel(const string name, const int x, const int y,
                                const int width, const int height,
                                ENUM_COLOR_FORMAT clrfmt) {
  return (CreateBitmapLabel(0, 0, name, x, y, width, height, clrfmt));
}

bool CCanvas::CreateBitmapLabel(const long chart_id, const int subwin,
                                const string name, const int x, const int y,
                                const int width, const int height,
                                ENUM_COLOR_FORMAT clrfmt) {

  if (Create(name, width, height, clrfmt)) {

    if (ObjectCreate(chart_id, name, OBJ_BITMAP_LABEL, subwin, 0, 0)) {

      if (ObjectSetInteger(chart_id, name, OBJPROP_XDISTANCE, x) &&
          ObjectSetInteger(chart_id, name, OBJPROP_YDISTANCE, y) &&
          ObjectSetString(chart_id, name, OBJPROP_BMPFILE, m_rcname)) {

        m_chart_id = chart_id;
        m_objname = name;
        m_objtype = OBJ_BITMAP_LABEL;

        return (true);
      }
    }
  }

  return (false);
}

bool CCanvas::Attach(const long chart_id, const string objname,
                     ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA) {
  if (OBJ_BITMAP_LABEL == ObjectGetInteger(chart_id, objname, OBJPROP_TYPE)) {
    string rcname = ObjectGetString(chart_id, objname, OBJPROP_BMPFILE);
    rcname = StringSubstr(rcname, StringFind(rcname, "::"));
    if (ResourceReadImage(rcname, m_pixels, m_width, m_height)) {
      m_chart_id = chart_id;
      m_objname = objname;
      m_rcname = rcname;
      m_format = clrfmt;
      m_objtype = OBJ_BITMAP_LABEL;

      return (true);
    }
  }

  return (false);
}

bool CCanvas::Attach(const long chart_id, const string objname, const int width,
                     const int height,
                     ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_XRGB_NOALPHA) {
  if (OBJ_BITMAP_LABEL == ObjectGetInteger(chart_id, objname, OBJPROP_TYPE)) {
    string rcname = ObjectGetString(chart_id, objname, OBJPROP_BMPFILE);
    if (StringLen(rcname) == 0 && width > 0 && height > 0 &&
        ArrayResize(m_pixels, width * height) > 0) {
      ZeroMemory(m_pixels);
      if (ResourceCreate("::" + objname, m_pixels, width, height, 0, 0, 0,
                         clrfmt) &&
          ObjectSetString(chart_id, objname, OBJPROP_BMPFILE, "::" + objname)) {
        m_chart_id = chart_id;
        m_width = width;
        m_height = height;
        m_objname = objname;
        m_rcname = "::" + objname;
        m_format = clrfmt;
        m_objtype = OBJ_BITMAP_LABEL;

        return (true);
      }
    }
  }

  return (false);
}

void CCanvas::Destroy(void) {

  if (m_objname != NULL) {
    ObjectDelete(m_chart_id, m_objname);
    m_chart_id = 0;
    m_objname = NULL;
    m_objtype = WRONG_VALUE;
  }

  ArrayFree(m_pixels);

  if (m_rcname != NULL) {
    ResourceFree(m_rcname);
    m_rcname = NULL;
  }

  m_width = 0;
  m_height = 0;
}

void CCanvas::Update(const bool redraw) {

  if (m_rcname == NULL)
    return;

  if (ResourceCreate(m_rcname, m_pixels, m_width, m_height, 0, 0, 0,
                     m_format) &&
      redraw)
    ChartRedraw(this.m_chart_id);
}

bool CCanvas::Resize(const int width, const int height) {

  if (m_rcname != NULL && width > 0 && height > 0)
    if (ArrayResize(m_pixels, width * height) > 0) {
      m_width = width;
      m_height = height;

      ArrayInitialize(m_pixels, 0);

      if (ResourceCreate(m_rcname, m_pixels, m_width, m_height, 0, 0, 0,
                         m_format)) {

        if (m_objname != NULL &&
            ObjectSetString(m_chart_id, m_objname, OBJPROP_BMPFILE, m_rcname))
          return (true);
      }
    }

  return (false);
}

void CCanvas::Erase(const uint clr) {
  ArrayInitialize(m_pixels, clr);
}

uint CCanvas::PixelGet(const int x, const int y) const {

  if (x >= 0 && x < m_width && y >= 0 && y < m_height)
    return (m_pixels[y * m_width + x]);

  return (0);
}

void CCanvas::PixelSet(const int x, const int y, const uint clr) {

  if (x >= 0 && x < m_width && y >= 0 && y < m_height)
    m_pixels[y * m_width + x] = clr;
}

void CCanvas::Fill(int x, int y, const uint clr) {

  if (x < 0 || x >= m_width || y < 0 || y >= m_height)
    return;

  int index = y * m_width + x;
  uint old_clr = m_pixels[index];

  if (old_clr == clr)
    return;

  int stack[];
  uint count = 1;
  int idx;
  int total = ArraySize(m_pixels);

  if (ArrayResize(stack, total) == -1)
    return;
  stack[0] = index;
  m_pixels[index] = clr;
  for (uint i = 0; i < count; i++) {
    index = stack[i];
    x = index % m_width;

    idx = index - 1;
    if (x > 0 && m_pixels[idx] == old_clr) {
      m_pixels[idx] = clr;
      stack[count++] = idx;
    }

    idx = index - m_width;
    if (idx >= 0 && m_pixels[idx] == old_clr) {
      m_pixels[idx] = clr;
      stack[count++] = idx;
    }

    idx = index + 1;
    if (x < m_width - 1 && m_pixels[idx] == old_clr) {
      m_pixels[idx] = clr;
      stack[count++] = idx;
    }

    idx = index + m_width;
    if (idx < total && m_pixels[idx] == old_clr) {
      m_pixels[idx] = clr;
      stack[count++] = idx;
    }
  }

  ArrayFree(stack);
}

void CCanvas::Fill(int x, int y, const uint clr, const uint threshould) {

  if (threshould == 0.0) {
    Fill(x, y, clr);
    return;
  }
  if (x < 0 || x >= m_width || y < 0 || y >= m_height || threshould > 255)
    return;

  int index = y * m_width + x;
  uint old_clr = m_pixels[index];

  if (old_clr == clr)
    return;

  int stack[];
  uint count = 1;
  int idx;
  int total = ArraySize(m_pixels);

  if (ArrayResize(stack, total) == -1)
    return;
  stack[0] = index;
  m_pixels[index] = clr;
  for (uint i = 0; i < count; i++) {
    index = stack[i];
    x = index % m_width;

    idx = index - 1;
    if (x > 0 && PixelsSimilar(m_pixels[idx], old_clr, threshould) &&
        m_pixels[idx] != clr) {
      m_pixels[idx] = clr;
      stack[count++] = idx;
    }

    idx = index - m_width;
    if (idx >= 0 && PixelsSimilar(m_pixels[idx], old_clr, threshould) &&
        m_pixels[idx] != clr) {
      m_pixels[idx] = clr;
      stack[count++] = idx;
    }

    idx = index + 1;
    if (x < m_width - 1 && PixelsSimilar(m_pixels[idx], old_clr, threshould) &&
        m_pixels[idx] != clr) {
      m_pixels[idx] = clr;
      stack[count++] = idx;
    }

    idx = index + m_width;
    if (idx < total && PixelsSimilar(m_pixels[idx], old_clr, threshould) &&
        m_pixels[idx] != clr) {
      m_pixels[idx] = clr;
      stack[count++] = idx;
    }
  }

  ArrayFree(stack);
}

void CCanvas::LineVertical(int x, int y1, int y2, const uint clr) {
  int tmp;

  if (y1 > y2) {
    tmp = y1;
    y1 = y2;
    y2 = tmp;
  }

  if (y2 < 0 || y1 >= m_height || x < 0 || x >= m_width)
    return;

  if (y1 < 0)
    y1 = 0;
  if (y2 >= m_height)
    y2 = m_height - 1;

  int index = y1 * m_width + x;
  for (int i = y1; i <= y2; i++, index += m_width)
    m_pixels[index] = clr;
}

void CCanvas::LineHorizontal(int x1, int x2, int y, const uint clr) {
  int tmp;

  if (x1 > x2) {
    tmp = x1;
    x1 = x2;
    x2 = tmp;
  }

  if (x2 < 0 || x1 >= m_width || y < 0 || y >= m_height)
    return;

  if (x1 < 0)
    x1 = 0;
  if (x2 >= m_width)
    x2 = m_width - 1;

  ArrayFill(m_pixels, y * m_width + x1, (x2 - x1) + 1, clr);
}

void CCanvas::Line(int x1, int y1, int x2, int y2, const uint clr) {

  if ((x1 < 0 && x2 < 0) || (y1 < 0 && y2 < 0))
    return;
  if (x1 >= m_width && x2 >= m_width)
    return;
  if (y1 >= m_height && y2 >= m_height)
    return;

  int dx = (x2 > x1) ? x2 - x1 : x1 - x2;
  int dy = (y2 > y1) ? y2 - y1 : y1 - y2;
  if (dx == 0) {

    LineVertical(x1, y1, y2, clr);
    return;
  }
  if (dy == 0) {

    LineHorizontal(x1, x2, y1, clr);
    return;
  }

  int sx = (x1 < x2) ? 1 : -1;
  int sy = (y1 < y2) ? 1 : -1;
  int er = dx - dy;
  bool draw = false;

  while (x1 != x2 || y1 != y2) {
    if (x1 < 0 || x1 >= m_width || y1 < 0 || y1 >= m_height) {
      if (draw)
        return;
    } else {

      m_pixels[y1 * m_width + x1] = clr;
      draw = true;
    }

    int er2 = er << 1;
    if (er2 > -dy) {
      er -= dy;
      x1 += sx;
    }
    if (er2 < dx) {
      er += dx;
      y1 += sy;
    }
  }

  PixelSet(x2, y2, clr);
}

void CCanvas::Polyline(int &x[], int &y[], const uint clr) {
  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 2)
    return;
  total--;

  for (int i = 0; i < total; i++)
    Line(x[i], y[i], x[i + 1], y[i + 1], clr);
}

void CCanvas::Polygon(int &x[], int &y[], const uint clr) {

  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 2)
    return;
  total--;

  for (int i = 0; i < total; i++)
    Line(x[i], y[i], x[i + 1], y[i + 1], clr);

  Line(x[total], y[total], x[0], y[0], clr);
}

void CCanvas::Rectangle(int x1, int y1, int x2, int y2, const uint clr) {
  LineHorizontal(x1, x2, y1, clr);
  LineVertical(x2, y1, y2, clr);
  LineHorizontal(x2, x1, y2, clr);
  LineVertical(x1, y2, y1, clr);
}

void CCanvas::Triangle(int x1, int y1, int x2, int y2, int x3, int y3,
                       const uint clr) {
  Line(x1, y1, x2, y2, clr);
  Line(x2, y2, x3, y3, clr);
  Line(x3, y3, x1, y1, clr);
}

void CCanvas::Circle(int x, int y, int r, const uint clr) {
  int f = 1 - r;
  int dd_x = 1;
  int dd_y = -2 * r;
  int dx = 0;
  int dy = r;
  int xx, yy;

  while (dy >= dx) {
    xx = x + dx;
    if (xx >= 0 && xx < m_width) {
      yy = y + dy;
      if (yy >= 0 && yy < m_height)
        m_pixels[yy * m_width + xx] = clr;
      yy = y - dy;
      if (yy >= 0 && yy < m_height)
        m_pixels[yy * m_width + xx] = clr;
    }
    xx = x - dx;
    if (xx >= 0 && xx < m_width) {
      yy = y + dy;
      if (yy >= 0 && yy < m_height)
        m_pixels[yy * m_width + xx] = clr;
      yy = y - dy;
      if (yy >= 0 && yy < m_height)
        m_pixels[yy * m_width + xx] = clr;
    }
    xx = x + dy;
    if (xx >= 0 && xx < m_width) {
      yy = y + dx;
      if (yy >= 0 && yy < m_height)
        m_pixels[yy * m_width + xx] = clr;
      yy = y - dx;
      if (yy >= 0 && yy < m_height)
        m_pixels[yy * m_width + xx] = clr;
    }
    xx = x - dy;
    if (xx >= 0 && xx < m_width) {
      yy = y + dx;
      if (yy >= 0 && yy < m_height)
        m_pixels[yy * m_width + xx] = clr;
      yy = y - dx;
      if (yy >= 0 && yy < m_height)
        m_pixels[yy * m_width + xx] = clr;
    }

    if (f >= 0) {
      dy--;
      dd_y += 2;
      f += dd_y;
    }
    dx++;
    dd_x += 2;
    f += dd_x;
  }
}

void CCanvas::Ellipse(int x1, int y1, int x2, int y2, const uint clr) {
  int x, y;
  int rx, ry;
  int dx, dy;
  int xx, yy;
  int rx_sq, ry_sq;
  int f;
  int tmp;

  if (x1 == x2) {
    if (y1 == y2)
      PixelSet(x1, y1, clr);
    else
      LineVertical(x1, y1, y2, clr);
    return;
  }
  if (y1 == y2) {
    LineHorizontal(x1, x2, y1, clr);
    return;
  }

  if (x1 > x2) {
    tmp = x1;
    x1 = x2;
    x2 = tmp;
  }

  if (y1 > y2) {
    tmp = y1;
    y1 = y2;
    y2 = tmp;
  }
  x = (x2 + x1) >> 1;
  y = (y2 + y1) >> 1;
  rx = (x2 - x1) >> 1;
  ry = (y2 - y1) >> 1;
  dx = 0;
  dy = ry;
  rx_sq = rx * rx;
  ry_sq = ry * ry;
  f = (rx_sq << 1) * ((dy - 1) * dy) + rx_sq + (ry_sq << 1) * (1 - rx_sq);
  while (rx_sq * dy > ry_sq * dx) {
    yy = y + dy;
    if (yy >= 0 && yy < m_height) {
      yy *= m_width;
      xx = x + dx;
      if (xx >= 0 && xx < m_width)
        m_pixels[yy + xx] = clr;
      xx = x - dx;
      if (xx >= 0 && xx < m_width)
        m_pixels[yy + xx] = clr;
    }
    yy = y - dy;
    if (yy >= 0 && yy < m_height) {
      yy *= m_width;
      xx = x + dx;
      if (xx >= 0 && xx < m_width)
        m_pixels[yy + xx] = clr;
      xx = x - dx;
      if (xx >= 0 && xx < m_width)
        m_pixels[yy + xx] = clr;
    }
    if (f >= 0) {
      dy--;
      f -= (rx_sq << 2) * dy;
    }
    f += (ry_sq << 1) * (3 + (dx << 1));
    dx++;
  }
  f = (ry_sq << 1) * (dx + 1) * dx + (rx_sq << 1) * (dy * (dy - 2) + 1) +
      (1 - (rx_sq << 1)) * ry_sq;
  while (dy >= 0) {
    yy = y + dy;
    if (yy >= 0 && yy < m_height) {
      yy *= m_width;
      xx = x + dx;
      if (xx >= 0 && xx < m_width)
        m_pixels[yy + xx] = clr;
      xx = x - dx;
      if (xx >= 0 && xx < m_width)
        m_pixels[yy + xx] = clr;
    }
    yy = y - dy;
    if (yy >= 0 && yy < m_height) {
      yy *= m_width;
      xx = x + dx;
      if (xx >= 0 && xx < m_width)
        m_pixels[yy + xx] = clr;
      xx = x - dx;
      if (xx >= 0 && xx < m_width)
        m_pixels[yy + xx] = clr;
    }
    if (f <= 0) {
      dx++;
      f += (ry_sq << 2) * dx;
    }
    dy--;
    f += (rx_sq << 1) * (3 - (dy << 1));
  }
}

void CCanvas::Arc(int x1, int y1, int x2, int y2, int x3, int y3, int x4,
                  int y4, const uint clr) {
  int tmp;
  int x, y;
  double fi3;
  double fi4;

  if (x1 == x2 || y1 == y2)
    return;

  if (x1 > x2) {
    tmp = x1;
    x1 = x2;
    x2 = tmp;
  }

  if (y1 > y2) {
    tmp = y1;
    y1 = y2;
    y2 = tmp;
  }
  x = (x2 + x1) >> 1;
  y = (y2 + y1) >> 1;

  if (x3 == x && y3 == y)
    return;
  if (x4 == x && y4 == y)
    return;

  fi3 = AngleCalc(x, y, x3, y3);

  fi4 = AngleCalc(x, y, x4, y4);

  Arc(x, y, x2 - x, y2 - y, fi3, fi4, clr);
}

void CCanvas::Arc(int x, int y, int rx, int ry, double fi3, double fi4,
                  const uint clr) {
  int x3, y3, x4, y4;

  if (rx < 10 || ry < 10)
    return;
  if (rx < 0)
    rx = -rx;
  if (ry < 0)
    ry = -ry;

  if (fi3 == fi4)
    return;

  if (fi4 < fi3)
    fi4 += 2 * M_PI;

  Arc(x, y, rx, ry, fi3, fi4, x3, y3, x4, y4, clr);
}

double CCanvas::AngleCalc(int x1, int y1, int x2, int y2) {
  double fi;

  if (x1 == x2) {
    if (y1 == y2)
      return (EMPTY_VALUE);
    fi = (y2 < y1) ? M_PI_2 : 3 * M_PI_2;
  } else {

    fi = atan((double)(y1 - y2) / (x2 - x1));

    if (x2 < x1)
      fi += M_PI;
    else {
      if (fi < 0)
        fi += 2 * M_PI;
    }
  }

  return (fi);
}

void CCanvas::Arc(int x, int y, int rx, int ry, double fi3, double fi4, int &x3,
                  int &y3, int &x4, int &y4, const uint clr) {

  if (rx < 10 || ry < 10)
    return;

  int dx, dy;
  int xx, yy;
  int rx_sq, ry_sq;
  int f;
  double fi;

  bool ray3 = false;
  bool ray4 = false;
  bool ckw = false;
  int xx_c = 0, yy_c = 0;
  double fi_c = 0.0;
  bool ackw = false;
  int xx_a = 0, yy_a = 0;
  double fi_a = 0.0;

  rx_sq = rx * rx;
  ry_sq = ry * ry;

  fi = MathMod(fi4, 2 * M_PI);
  if ((fi3 < M_PI && fi3 > 0) || (fi < M_PI && fi > 0) || (fi4 - fi3 >= M_PI)) {
    dx = 0;
    dy = ry;
    f = (rx_sq << 1) * ((dy - 1) * dy) + rx_sq + (ry_sq << 1) * (1 - rx_sq);
    while (rx_sq * dy >= ry_sq * dx) {
      yy = y - dy;
      if (dx == 0) {

        fi = AngleCalc(0, 0, 0, -dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(x, yy, clr);
          ckw = ackw = true;
        } else
          ckw = ackw = false;
        xx_c = x;
        yy_c = yy;
        fi_c = fi;
        xx_a = x;
        yy_a = yy;
        fi_a = fi;
      } else {

        xx = x + dx;
        fi = AngleCalc(0, 0, dx, -dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, yy, clr);

          if (!ckw) {
            ckw = true;
            if (!ray4) {
              if (MathAbs(fi_c - MathMod(fi4, 2 * M_PI)) <
                  MathAbs(fi - MathMod(fi4, 2 * M_PI)))
                PixelSet(x4 = xx_c, y4 = yy_c, clr);
              else {
                x4 = xx;
                y4 = yy;
              }
              ray4 = true;
            }
          }
        } else {

          if (ckw && !ray3) {
            if (MathAbs(fi_c - fi3) > MathAbs(fi - fi3))
              PixelSet(x3 = xx, y3 = yy, clr);
            else {
              x3 = xx_c;
              y3 = yy_c;
            }
            ray3 = true;
          }
          ckw = false;
        }

        xx_c = xx;
        yy_c = yy;
        fi_c = fi;

        xx = x - dx;
        fi = AngleCalc(0, 0, -dx, -dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, yy, clr);

          if (!ackw) {
            ackw = true;
            if (!ray3) {
              if (MathAbs(fi_a - fi3) < MathAbs(fi - fi3))
                PixelSet(x3 = xx_a, y3 = yy_a, clr);
              else {
                x3 = xx;
                y3 = yy;
              }
              ray3 = true;
            }
          }
        } else {

          if (ackw && !ray4) {
            if (MathAbs(fi_a - MathMod(fi4, 2 * M_PI)) >
                MathAbs(fi - MathMod(fi4, 2 * M_PI)))
              PixelSet(x4 = xx, y4 = yy, clr);
            else {
              x4 = xx_a;
              y4 = yy_a;
            }
            ray4 = true;
          }
          ackw = false;
        }

        xx_a = xx;
        yy_a = yy;
        fi_a = fi;
      }

      if (f >= 0) {
        dy--;
        f -= (rx_sq << 2) * dy;
      }
      f += (ry_sq << 1) * (3 + (dx << 1));
      dx++;
    }

    if (ckw && !ray3) {
      fi = AngleCalc(0, 0, dx, -dy);
      if (MathAbs(fi_c - fi3) > MathAbs(fi - fi3))
        PixelSet(x3 = x + dx, y3 = y - dy, clr);
      else {
        x3 = xx_c;
        y3 = yy_c;
      }
    }

    if (ackw && !ray4) {
      fi = AngleCalc(0, 0, -dx, -dy);
      if (MathAbs(fi_a - MathMod(fi4, 2 * M_PI)) >
          MathAbs(fi - MathMod(fi4, 2 * M_PI)))
        PixelSet(x4 = x - dx, y4 = y - dy, clr);
      else {
        x4 = xx_a;
        y4 = yy_a;
      }
    }
  }

  fi = MathMod(fi4, 2 * M_PI);
  if ((fi3 > M_PI_2 && fi3 < 3 * M_PI_2) || (fi > M_PI_2 && fi < 3 * M_PI_2) ||
      (fi4 - fi3 >= M_PI)) {
    dx = rx;
    dy = 0;
    f = (ry_sq << 1) * ((dx - 1) * dx) + ry_sq + (rx_sq << 1) * (1 - ry_sq);
    while (ry_sq * dx >= rx_sq * dy) {
      xx = x - dx;
      if (dy == 0) {

        fi = AngleCalc(0, 0, -dx, 0);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, y, clr);
          ckw = ackw = true;
        } else
          ckw = ackw = false;
        xx_c = xx;
        yy_c = y;
        fi_c = fi;
        xx_a = xx;
        yy_a = y;
        fi_a = fi;
      } else {

        yy = y - dy;
        fi = AngleCalc(0, 0, -dx, -dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, yy, clr);

          if (!ckw) {
            ckw = true;
            if (!ray4) {
              if (MathAbs(fi_c - MathMod(fi4, 2 * M_PI)) <
                  MathAbs(fi - MathMod(fi4, 2 * M_PI)))
                PixelSet(x4 = xx_c, y4 = yy_c, clr);
              else {
                x4 = xx;
                y4 = yy;
              }
              ray4 = true;
            }
          }
        } else {

          if (ckw && !ray3) {
            if (MathAbs(fi_c - fi3) > MathAbs(fi - fi3))
              PixelSet(x3 = xx, y3 = yy, clr);
            else {
              x3 = xx_c;
              y3 = yy_c;
            }
            ray3 = true;
          }
          ckw = false;
        }

        xx_c = xx;
        yy_c = yy;
        fi_c = fi;

        yy = y + dy;
        fi = AngleCalc(0, 0, -dx, dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, yy, clr);

          if (!ackw) {
            ackw = true;
            if (!ray3) {
              if (MathAbs(fi_a - fi3) < MathAbs(fi - fi3))
                PixelSet(x3 = xx_a, y3 = yy_a, clr);
              else {
                x3 = xx;
                y3 = yy;
              }
              ray3 = true;
            }
          }
        } else {

          if (ackw && !ray4) {
            if (MathAbs(fi_a - MathMod(fi4, 2 * M_PI)) >
                MathAbs(fi - MathMod(fi4, 2 * M_PI)))
              PixelSet(x4 = xx, y4 = yy, clr);
            else {
              x4 = xx_a;
              y4 = yy_a;
            }
            ray4 = true;
          }
          ackw = false;
        }

        xx_a = xx;
        yy_a = yy;
        fi_a = fi;
      }

      if (f >= 0) {
        dx--;
        f -= (ry_sq << 2) * dx;
      }
      f += (rx_sq << 1) * (3 + (dy << 1));
      dy++;
    }

    if (ckw && !ray3) {
      fi = AngleCalc(0, 0, -dx, -dy);
      if (MathAbs(fi_c - fi3) > MathAbs(fi - fi3))
        PixelSet(x3 = x - dx, y3 = y - dy, clr);
      else {
        x3 = xx_c;
        y3 = yy_c;
      }
    }

    if (ackw && !ray4) {
      fi = AngleCalc(0, 0, -dx, dy);
      if (MathAbs(fi_a - MathMod(fi4, 2 * M_PI)) >
          MathAbs(fi - MathMod(fi4, 2 * M_PI)))
        PixelSet(x4 = x - dx, y4 = y + dy, clr);
      else {
        x4 = xx_a;
        y4 = yy_a;
      }
    }
  }

  fi = MathMod(fi4, 2 * M_PI);
  if ((fi3 > M_PI && fi3 < 2 * M_PI) || (fi > M_PI && fi < 2 * M_PI) ||
      (fi4 - fi3 >= M_PI)) {
    dx = 0;
    dy = ry;
    f = (rx_sq << 1) * ((dy - 1) * dy) + rx_sq + (ry_sq << 1) * (1 - rx_sq);
    while (rx_sq * dy >= ry_sq * dx) {
      yy = y + dy;
      if (dx == 0) {

        fi = AngleCalc(0, 0, 0, dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(x, yy, clr);
          ckw = ackw = true;
        } else
          ckw = ackw = false;
        xx_c = x;
        yy_c = yy;
        fi_c = fi;
        xx_a = x;
        yy_a = yy;
        fi_a = fi;
      } else {

        xx = x - dx;
        fi = AngleCalc(0, 0, -dx, dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, yy, clr);

          if (!ckw) {
            ckw = true;
            if (!ray4) {
              if (MathAbs(fi_c - MathMod(fi4, 2 * M_PI)) <
                  MathAbs(fi - MathMod(fi4, 2 * M_PI)))
                PixelSet(x4 = xx_c, y4 = yy_c, clr);
              else {
                x4 = xx;
                y4 = yy;
              }
              ray4 = true;
            }
          }
        } else {

          if (ckw && !ray3) {
            if (MathAbs(fi_c - fi3) > MathAbs(fi - fi3))
              PixelSet(x3 = xx, y3 = yy, clr);
            else {
              x3 = xx_c;
              y3 = yy_c;
            }
            ray3 = true;
          }
          ckw = false;
        }

        xx_c = xx;
        yy_c = yy;
        fi_c = fi;

        xx = x + dx;
        fi = AngleCalc(0, 0, dx, dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, yy, clr);

          if (!ackw) {
            ackw = true;
            if (!ray3) {
              if (MathAbs(fi_a - fi3) < MathAbs(fi - fi3))
                PixelSet(x3 = xx_a, y3 = yy_a, clr);
              else {
                x3 = xx;
                y3 = yy;
              }
              ray3 = true;
            }
          }
        } else {

          if (ackw && !ray4) {
            if (MathAbs(fi_a - MathMod(fi4, 2 * M_PI)) >
                MathAbs(fi - MathMod(fi4, 2 * M_PI)))
              PixelSet(x4 = xx, y4 = yy, clr);
            else {
              x4 = xx_a;
              y4 = yy_a;
            }
            ray4 = true;
          }
          ackw = false;
        }

        xx_a = xx;
        yy_a = yy;
        fi_a = fi;
      }

      if (f >= 0) {
        dy--;
        f -= (rx_sq << 2) * dy;
      }
      f += (ry_sq << 1) * (3 + (dx << 1));
      dx++;
    }

    if (ckw && !ray3) {
      fi = AngleCalc(0, 0, -dx, dy);
      if (MathAbs(fi_c - fi3) > MathAbs(fi - fi3))
        PixelSet(x3 = x - dx, y3 = y + dy, clr);
      else {
        x3 = xx_c;
        y3 = yy_c;
      }
    }

    if (ackw && !ray4) {
      fi = AngleCalc(0, 0, dx, dy);
      if (MathAbs(fi_a - MathMod(fi4, 2 * M_PI)) >
          MathAbs(fi - MathMod(fi4, 2 * M_PI)))
        PixelSet(x4 = x + dx, y4 = y + dy, clr);
      else {
        x4 = xx_a;
        y4 = yy_a;
      }
    }
  }

  fi = MathMod(fi4, 2 * M_PI);
  if ((fi3 < M_PI_2 || fi3 > 3 * M_PI_2) || (fi < M_PI_2 || fi > 3 * M_PI_2) ||
      (fi4 - fi3 >= M_PI)) {
    dx = rx;
    dy = 0;
    f = (ry_sq << 1) * ((dx - 1) * dx) + ry_sq + (rx_sq << 1) * (1 - ry_sq);
    while (ry_sq * dx >= rx_sq * dy) {
      xx = x + dx;
      if (dy == 0) {

        fi = AngleCalc(0, 0, dx, 0);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, y, clr);
          ckw = ackw = true;
        } else
          ckw = ackw = false;
        xx_c = xx;
        yy_c = y;
        fi_c = fi;
        xx_a = xx;
        yy_a = y;
        fi_a = fi;
      } else {

        yy = y + dy;
        fi = AngleCalc(0, 0, dx, dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, yy, clr);

          if (!ckw) {
            ckw = true;
            if (!ray4) {
              if (MathAbs(fi_c - MathMod(fi4, 2 * M_PI)) <
                  MathAbs(fi - MathMod(fi4, 2 * M_PI)))
                PixelSet(x4 = xx_c, y4 = yy_c, clr);
              else {
                x4 = xx;
                y4 = yy;
              }
              ray4 = true;
            }
          }
        } else {

          if (ckw && !ray3) {
            if (MathAbs(fi_c - fi3) > MathAbs(fi - fi3))
              PixelSet(x3 = xx, y3 = yy, clr);
            else {
              x3 = xx_c;
              y3 = yy_c;
            }
            ray3 = true;
          }
          ckw = false;
        }

        xx_c = xx;
        yy_c = yy;
        fi_c = fi;

        yy = y - dy;
        fi = AngleCalc(0, 0, dx, -dy);
        if ((fi <= fi4 && fi3 <= fi) ||
            (fi4 >= 2 * M_PI && fi <= fi4 - 2 * M_PI)) {
          PixelSet(xx, yy, clr);

          if (!ackw) {
            ackw = true;
            if (!ray3) {
              if (MathAbs(MathMod(fi_a, 2 * M_PI) - fi3) < MathAbs(fi - fi3))
                PixelSet(x3 = xx_a, y3 = yy_a, clr);
              else {
                x3 = xx;
                y3 = yy;
              }
              ray3 = true;
            }
          }
        } else {

          if (ackw && !ray4) {
            if (MathAbs(MathMod(fi_a, 2 * M_PI) - MathMod(fi4, 2 * M_PI)) >
                MathAbs(fi - MathMod(fi4, 2 * M_PI)))
              PixelSet(x4 = xx, y4 = yy, clr);
            else {
              x4 = xx_a;
              y4 = yy_a;
            }
            ray4 = true;
          }
          ackw = false;
        }

        xx_a = xx;
        yy_a = yy;
        fi_a = fi;
      }

      if (f >= 0) {
        dx--;
        f -= (ry_sq << 2) * dx;
      }
      f += (rx_sq << 1) * (3 + (dy << 1));
      dy++;
    }

    if (ckw && !ray3) {
      fi = AngleCalc(0, 0, dx, dy);
      if (MathAbs(fi_c - fi3) > MathAbs(fi - fi3))
        PixelSet(x3 = x + dx, y3 = y + dy, clr);
      else {
        x3 = xx_c;
        y3 = yy_c;
      }
    }

    if (ackw && !ray4) {
      fi = AngleCalc(0, 0, dx, -dy);
      if (MathAbs(MathMod(fi_a, 2 * M_PI) - MathMod(fi4, 2 * M_PI)) >
          MathAbs(fi - MathMod(fi4, 2 * M_PI)))
        PixelSet(x4 = x + dx, y4 = y - dy, clr);
      else {
        x4 = xx_a;
        y4 = yy_a;
      }
    }
  }
}

void CCanvas::Pie(int x1, int y1, int x2, int y2, int x3, int y3, int x4,
                  int y4, const uint clr, const uint fill_clr) {
  int tmp;
  int x, y;

  double fi3;
  double fi4;

  if (x1 == x2 || y1 == y2)
    return;

  if (x1 > x2) {
    tmp = x1;
    x1 = x2;
    x2 = tmp;
  }

  if (y1 > y2) {
    tmp = y1;
    y1 = y2;
    y2 = tmp;
  }
  x = (x2 + x1) >> 1;
  y = (y2 + y1) >> 1;

  if (x3 == x && y3 == y)
    return;
  if (x4 == x && y4 == y)
    return;

  fi3 = AngleCalc(x, y, x3, y3);

  fi4 = AngleCalc(x, y, x4, y4);

  Pie(x, y, x2 - x, y2 - y, fi3, fi4, clr, fill_clr);
}

void CCanvas::Pie(int x, int y, int rx, int ry, double fi3, double fi4,
                  const uint clr, const uint fill_clr) {
  int x3 = x;
  int y3 = y;
  int x4 = x;
  int y4 = y;

  if (rx == 0 || ry == 0)
    return;
  if (rx < 0)
    rx = -rx;
  if (ry < 0)
    ry = -ry;

  if (fi3 == fi4)
    return;

  if (fi4 < fi3)
    fi4 += 2 * M_PI;

  Arc(x, y, rx, ry, fi3, fi4, x3, y3, x4, y4, clr);
  if ((x == x3 && y == y3) || (x == x4 && y == y4))
    return;
  Line(x, y, x3, y3, clr);
  Line(x, y, x4, y4, clr);

  if (rx > ry)
    rx = ry;
  double fi = (fi3 + fi4) / 2;
  int xf = x + (int)(0.9 * rx * cos(fi));
  int yf = y - (int)(0.9 * rx * sin(fi));
  Fill(xf, yf, fill_clr);
}

void CCanvas::FillCircle(int x, int y, int r, const uint clr) {
  int f = 1 - r;
  int dd_x = 1;
  int dd_y = -2 * r;
  int dx = 0;
  int dy = r;

  while (dy >= dx) {
    LineHorizontal(x - dy, x + dy, y - dx, clr);
    LineHorizontal(x - dy, x + dy, y + dx, clr);

    if (f >= 0) {
      LineHorizontal(x - dx, x + dx, y - dy, clr);
      LineHorizontal(x - dx, x + dx, y + dy, clr);
      dy--;
      dd_y += 2;
      f += dd_y;
    }
    dx++;
    dd_x += 2;
    f += dd_x;
  }
}

void CCanvas::FillEllipse(int x1, int y1, int x2, int y2, const uint clr) {
  int x, y;
  int rx, ry;
  int dx, dy;
  int rx_sq, ry_sq;
  int f;
  int tmp;

  if (x1 == x2) {
    if (y1 == y2)
      PixelSet(x1, y1, clr);
    else
      LineVertical(x1, y1, y2, clr);
    return;
  }
  if (y1 == y2) {
    LineHorizontal(x1, x2, y1, clr);
    return;
  }

  if (x1 > x2) {
    tmp = x1;
    x1 = x2;
    x2 = tmp;
  }

  if (y1 > y2) {
    tmp = y1;
    y1 = y2;
    y2 = tmp;
  }
  x = (x2 + x1) >> 1;
  y = (y2 + y1) >> 1;
  rx = (x2 - x1) >> 1;
  ry = (y2 - y1) >> 1;
  dx = 0;
  dy = ry;
  rx_sq = rx * rx;
  ry_sq = ry * ry;
  f = (rx_sq << 1) * ((dy - 1) * dy) + rx_sq + (ry_sq << 1) * (1 - rx_sq);
  while (rx_sq * dy > ry_sq * (dx)) {
    LineHorizontal(x - dx, x + dx, y + dy, clr);
    LineHorizontal(x - dx, x + dx, y - dy, clr);
    if (f >= 0) {
      dy--;
      f -= (rx_sq << 2) * dy;
    }
    f += (ry_sq << 1) * (3 + (dx << 1));
    dx++;
  }
  f = (ry_sq << 1) * (dx + 1) * dx + (rx_sq << 1) * (dy * (dy - 2) + 1) +
      (1 - (rx_sq << 1)) * ry_sq;
  while (dy >= 0) {
    LineHorizontal(x - dx, x + dx, y + dy, clr);
    LineHorizontal(x - dx, x + dx, y - dy, clr);
    if (f <= 0) {
      dx++;
      f += (ry_sq << 2) * dx;
    }
    dy--;
    f += (rx_sq << 1) * (3 - (dy << 1));
  }
}

void CCanvas::FillRectangle(int x1, int y1, int x2, int y2, const uint clr) {
  int tmp;

  if (x2 < x1) {
    tmp = x1;
    x1 = x2;
    x2 = tmp;
  }
  if (y2 < y1) {
    tmp = y1;
    y1 = y2;
    y2 = tmp;
  }

  if (x2 < 0 || y2 < 0 || x1 >= m_width || y1 >= m_height)
    return;

  if (x1 < 0)
    x1 = 0;
  if (y1 < 0)
    y1 = 0;
  if (x2 >= m_width)
    x2 = m_width - 1;
  if (y2 >= m_height)
    y2 = m_height - 1;
  int len = (x2 - x1) + 1;

  for (; y1 <= y2; y1++)
    ArrayFill(m_pixels, y1 * m_width + x1, len, clr);
}

void CCanvas::FillTriangle(int x1, int y1, int x2, int y2, int x3, int y3,
                           const uint clr) {
  int xx1, xx2, tmp;
  double k1 = 0, k2 = 0, xd1, xd2;

  if (y1 > y2) {
    tmp = y2;
    y2 = y1;
    y1 = tmp;
    tmp = x2;
    x2 = x1;
    x1 = tmp;
  }
  if (y1 > y3) {
    tmp = y1;
    y1 = y3;
    y3 = tmp;
    tmp = x1;
    x1 = x3;
    x3 = tmp;
  }
  if (y2 > y3) {
    tmp = y2;
    y2 = y3;
    y3 = tmp;
    tmp = x2;
    x2 = x3;
    x3 = tmp;
  }

  if (y3 < 0 || y1 > m_height)
    return;
  if (x1 < 0 && x2 < 0 && x3 < 0)
    return;
  if (x1 > m_width && x2 > m_width && x3 > m_width)
    return;

  if ((tmp = y1 - y2) != 0)
    k1 = (x1 - x2) / (double)tmp;
  if ((tmp = y1 - y3) != 0)
    k2 = (x1 - x3) / (double)tmp;

  xd1 = x1;
  xd2 = x1;

  for (int i = y1; i <= y3; i++) {
    if (i == y2) {
      if ((tmp = y2 - y3) != 0)
        k1 = (x2 - x3) / (double)tmp;
      xd1 = x2;
    }

    xx1 = (int)xd1;
    xd1 += k1;
    xx2 = (int)xd2;
    xd2 += k2;

    if (i < 0 || i >= m_height)
      continue;

    if (xx1 > xx2) {
      tmp = xx1;
      xx1 = xx2;
      xx2 = tmp;
    }

    if (xx2 < 0 || xx1 >= m_width)
      continue;

    if (xx1 < 0)
      xx1 = 0;
    if (xx2 >= m_width)
      xx2 = m_width - 1;

    ArrayFill(m_pixels, i * m_width + xx1, xx2 - xx1, clr);
  }
}

void CCanvas::FillPolygon(int &x[], int &y[], const uint clr) {
  static CPoint p[];
  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 3)
    return;

  ArrayResize(p, total);

  int imin = 0;
  int xmin = x[0];
  int ymin = y[0];
  for (int i = 1; i < total; i++) {
    if (y[i] > ymin)
      continue;
    if (y[i] == ymin) {
      if (x[i] < xmin) {
        xmin = x[i];
        imin = i;
      }
      continue;
    }
    xmin = x[i];
    ymin = y[i];
    imin = i;
  }

  for (int i = 0; i < total; i++, imin++) {
    p[i].x = x[imin % total];
    p[i].y = y[imin % total];
  }
  PolygonFill(p, clr);
  ArrayFree(p);
}

void CCanvas::PixelSetAA(const double x, const double y, const uint clr) {
  static double rr[4];
  static int xx[4];
  static int yy[4];

  int ix = (int)MathRound(x);
  int iy = (int)MathRound(y);
  double rrr = 0;
  double k;
  double dx = x - ix;
  double dy = y - iy;
  uchar a, r, g, b;
  uint c;

  if (dx == 0.0 && dy == 0.0) {
    PixelSet(ix, iy, clr);
    return;
  }

  xx[0] = xx[2] = ix;
  yy[0] = yy[1] = iy;
  if (dx < 0.0)
    xx[1] = xx[3] = ix - 1;
  if (dx == 0.0)
    xx[1] = xx[3] = ix;
  if (dx > 0.0)
    xx[1] = xx[3] = ix + 1;
  if (dy < 0.0)
    yy[2] = yy[2] = iy - 1;
  if (dy == 0.0)
    yy[2] = yy[2] = iy;
  if (dy > 0.0)
    yy[2] = yy[2] = iy + 1;

  for (int i = 0; i < 4; i++) {
    dx = xx[i] - x;
    dy = yy[i] - y;
    rr[i] = 1 / (dx * dx + dy * dy);
    rrr += rr[i];
  }

  for (int i = 0; i < 4; i++) {
    k = rr[i] / rrr;
    c = PixelGet(xx[i], yy[i]);
    a = (uchar)(k * GETRGBA(clr) + (1 - k) * GETRGBA(c));
    r = (uchar)(k * GETRGBR(clr) + (1 - k) * GETRGBR(c));
    g = (uchar)(k * GETRGBG(clr) + (1 - k) * GETRGBG(c));
    b = (uchar)(k * GETRGBB(clr) + (1 - k) * GETRGBB(c));
    PixelSet(xx[i], yy[i], ARGB(a, r, g, b));
  }
}

uint CCanvas::LineStyleGet(void) const {
  switch (m_style) {
  case 0xFFFFFF:
    return (STYLE_SOLID);
    break;
  case 0x3FFFF:
    return (STYLE_DASH);
    break;
  case 0x1C71C7:
    return (STYLE_DOT);
    break;
  case 0x381FF:
    return (STYLE_DASHDOT);
    break;
  case 0x1C71FF:
    return (STYLE_DASHDOTDOT);
    break;
  default:
    return (m_style);
    break;
  }
}

void CCanvas::LineStyleSet(const uint style) {
  switch (style) {
  case STYLE_SOLID:
    m_style = 0xFFFFFF;
    break;
  case STYLE_DASH:
    m_style = 0x3FFFF;
    break;
  case STYLE_DOT:
    m_style = 0x1C71C7;
    break;
  case STYLE_DASHDOT:
    m_style = 0x381FF;
    break;
  case STYLE_DASHDOTDOT:
    m_style = 0x1C71FF;
    break;
  default:

    if ((style & 0x80000000) != 0) {
      m_style = style;
    }
    break;
  }
  m_style_idx = 0;
}

void CCanvas::LineAA(const int x1, const int y1, const int x2, const int y2,
                     const uint clr, const uint style) {

  if ((x1 < 0 && x2 < 0) || (y1 < 0 && y2 < 0))
    return;
  if (x1 >= m_width && x2 >= m_width)
    return;
  if (y1 >= m_height && y2 >= m_height)
    return;

  if (x1 == x2 && y1 == y2) {
    PixelSet(x1, y1, clr);
    return;
  }

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);

  double dx = x2 - x1;
  double dy = y2 - y1;
  double xy = sqrt(dx * dx + dy * dy);
  double xx = x1;
  double yy = y1;
  uint mask = 1 << m_style_idx;

  dx /= xy;
  dy /= xy;
  do {
    if ((m_style & mask) == mask) {
      PixelSetAA(xx, yy, clr);
    }
    xx += dx;
    yy += dy;
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  } while (fabs(x2 - xx) >= fabs(dx) && fabs(y2 - yy) >= fabs(dy));

  if ((m_style & mask) == mask) {
    PixelSetAA(x2, y2, clr);
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::PolylineAA(int &x[], int &y[], const uint clr, const uint style) {

  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 2)
    return;
  total--;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  for (int i = 0; i < total; i++) {
    int x1 = x[i];
    int y1 = y[i];
    int x2 = x[i + 1];
    int y2 = y[i + 1];

    if ((x1 < 0 && x2 < 0) || (y1 < 0 && y2 < 0)) {

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }
    if (x1 >= m_width && x2 >= m_width) {

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }
    if (y1 >= m_height && y2 >= m_height) {

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }

    if (x1 == x2 && y1 == y2) {
      PixelSet(x1, y1, clr);

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }

    double dx = x2 - x1;
    double dy = y2 - y1;
    double xy = sqrt(dx * dx + dy * dy);
    double xx = x1;
    double yy = y1;

    dx /= xy;
    dy /= xy;
    do {
      if ((m_style & mask) == mask) {
        PixelSetAA(xx, yy, clr);
      }
      xx += dx;
      yy += dy;
      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    } while (fabs(x2 - xx) >= fabs(dx) && fabs(y2 - yy) >= fabs(dy));

    if ((m_style & mask) == mask) {
      PixelSetAA(x2, y2, clr);
    }
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::PolygonAA(int &x[], int &y[], const uint clr, const uint style) {

  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 2)
    return;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  for (int i = 0; i < total; i++) {
    int x1 = x[i];
    int y1 = y[i];
    int x2 = (i + 1 != total) ? x[i + 1] : x[0];
    int y2 = (i + 1 != total) ? y[i + 1] : y[0];

    if ((x1 < 0 && x2 < 0) || (y1 < 0 && y2 < 0)) {

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }
    if (x1 >= m_width && x2 >= m_width) {

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }
    if (y1 >= m_height && y2 >= m_height) {

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }

    if (x1 == x2 && y1 == y2) {
      PixelSet(x1, y1, clr);

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }

    double dx = x2 - x1;
    double dy = y2 - y1;
    double xy = sqrt(dx * dx + dy * dy);
    double xx = x1;
    double yy = y1;

    dx /= xy;
    dy /= xy;
    do {
      if ((m_style & mask) == mask) {
        PixelSetAA(xx, yy, clr);
      }
      xx += dx;
      yy += dy;
      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    } while (fabs(x2 - xx) >= fabs(dx) && fabs(y2 - yy) >= fabs(dy));

    if ((m_style & mask) == mask) {
      PixelSetAA(x2, y2, clr);
    }
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::TriangleAA(const int x1, const int y1, const int x2, const int y2,
                         const int x3, const int y3, const uint clr,
                         const uint style) {

  int x[3];
  int y[3];
  x[0] = x1;
  x[1] = x2;
  x[2] = x3;
  y[0] = y1;
  y[1] = y2;
  y[2] = y3;
  PolygonAA(x, y, clr, style);
}

void CCanvas::CircleAA(const int x, const int y, const double r, const uint clr,
                       const uint style = UINT_MAX) {
  if (r <= 0)
    return;

  double xx = x + r;
  double yy = y;
  double fi = 0;
  double df = M_PI_2 / MathCeil(r);

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  if (r > M_PI)
    df /= 2;
  do {
    xx = x + r * cos(fi);
    yy = y - r * sin(fi);
    if ((m_style & mask) == mask)
      PixelSetAA(xx, yy, clr);
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
    fi += df;
  } while (fabs(2 * M_PI - fi) >= df / 2);

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::EllipseAA(const double x1, const double y1, const double x2,
                        const double y2, const uint clr,
                        const uint style = UINT_MAX) {
  double rx = (x2 - x1) / 2;
  double ry = (y2 - y1) / 2;

  double x = (x2 > x1) ? x1 + rx : x2 + rx;
  double y = (y2 > y1) ? y1 + ry : y2 + ry;
  double rx2 = rx * rx;
  double ry2 = ry * ry;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  double quarter = round(rx2 / sqrt(rx2 + ry2));
  for (double dx = 0; dx <= quarter; dx++) {
    double dy = ry * sqrt(1 - dx * dx / rx2);
    if ((m_style & mask) == mask)
      PixelSet4AA(x, y, dx, dy, clr);
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  }
  quarter = round(ry2 / sqrt(rx2 + ry2));
  for (double dy = 0; dy <= quarter; dy++) {
    double dx = rx * sqrt(1 - dy * dy / ry2);
    if ((m_style & mask) == mask)
      PixelSet4AA(x, y, dx, dy, clr);
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

static uint CCanvas::GetDefaultColor(const int i) {
  if (i < 0)
    return (0);
  if (i < ArraySize(m_default_colors))
    return (m_default_colors[i]);

  return (XRGB((i % 3) * 60 + i * 50, ((i + 1) % 3) * 60 + i * 60,
               ((i + 2) % 3) * 60 + i * 50));
}

void CCanvas::TransparentLevelSet(const uchar value) {
  int total = ArraySize(m_pixels);
  uint value24 = (uint)value << 24;
  for (int i = 0; i < total; i++)
    m_pixels[i] = value24 | (m_pixels[i] & 0xFFFFFF);
}

bool CCanvas::FontSet(const string name, const int size, const uint flags,
                      const uint angle) {
  if (!TextSetFont(name, size, flags, angle))
    return (false);

  m_fontname = name;
  m_fontsize = size;
  m_fontflags = flags;
  m_fontangle = angle;

  return (true);
}

bool CCanvas::FontNameSet(string name) {
  if (!TextSetFont(name, m_fontsize, m_fontflags, m_fontangle))
    return (false);

  m_fontname = name;

  return (true);
}

bool CCanvas::FontSizeSet(int size) {
  if (!TextSetFont(m_fontname, size, m_fontflags, m_fontangle))
    return (false);

  m_fontsize = size;

  return (true);
}

bool CCanvas::FontFlagsSet(uint flags) {
  if (!TextSetFont(m_fontname, m_fontsize, flags, m_fontangle))
    return (false);

  m_fontflags = flags;

  return (true);
}

bool CCanvas::FontAngleSet(uint angle) {
  if (!TextSetFont(m_fontname, m_fontsize, m_fontflags, angle))
    return (false);

  m_fontangle = angle;

  return (true);
}

bool CCanvas::FontSet(void) {
  return (TextSetFont(m_fontname, m_fontsize, m_fontflags, m_fontangle));
}

void CCanvas::FontGet(string &name, int &size, uint &flags, uint &angle) {
  name = m_fontname;
  size = m_fontsize;
  flags = m_fontflags;
  angle = m_fontangle;
}

void CCanvas::TextOut(int x, int y, string text, const uint clr,
                      uint alignment) {
  if (FontSet())
    TextOut(text, x, y, alignment, m_pixels, m_width, m_height, clr, m_format);
}

void CCanvas::TextOutFast(int x, int y, string text, const uint clr,
                          uint alignment) {
  TextOut(text, x, y, alignment, m_pixels, m_width, m_height, clr, m_format);
}

int CCanvas::TextWidth(const string text) {
  if (!FontSet())
    return (0);

  int w, h;
  TextGetSize(text, w, h);

  return (w);
}

int CCanvas::TextHeight(const string text) {
  if (!FontSet())
    return (0);

  int w, h;
  TextGetSize(text, w, h);

  return (h);
}

void CCanvas::TextSize(const string text, int &width, int &height) {
  if (FontSet())
    TextGetSize(text, width, height);
}

bool CCanvas::LoadFromFile(const string filename) {

  if (!CCanvas::LoadBitmap(filename, m_pixels, m_width, m_height))
    return (false);

  if (m_format == COLOR_FORMAT_ARGB_RAW) {
    uchar a, r, g, b;
    int img_size = m_width * m_height;

    for (int i = 0; i < img_size; i++)

    {
      switch (a = GETRGBA(m_pixels[i])) {
      case 0xFF:
        break;
      case 0x00:
        m_pixels[i] = 0;
        break;
      default:
        r = GETRGBR(m_pixels[i]) * a / 255;
        g = GETRGBG(m_pixels[i]) * a / 255;
        b = GETRGBB(m_pixels[i]) * a / 255;
        m_pixels[i] = ARGB(a, r, g, b);
        break;
      }
    }
  }

  return (true);
}

bool CCanvas::LoadBitmap(const string filename, uint &data[], int &width,
                         int &height) {
  struct BitmapHeader {
    ushort type;
    uint size;
    uint reserv;
    uint offbits;
    uint imgSSize;
    uint imgWidth;
    uint imgHeight;
    ushort imgPlanes;
    ushort imgBitCount;
    uint imgCompression;
    uint imgSizeImage;
    uint imgXPelsPerMeter;
    uint imgYPelsPerMeter;
    uint imgClrUsed;
    uint imgClrImportant;
  };
  BitmapHeader header;
  bool result = true;
  CFileBin file;
  uint img_size;
  bool no_alpha, no_flip = false;
  uchar r, g, b;

  if (file.Open(filename, FILE_READ) == INVALID_HANDLE) {
    Print("File not found");
    return (false);
  }

  if (file.ReadStruct(header) != sizeof(header)) {
    Print("Failed to read file header");
    file.Close();
    return (false);
  }
  width = (int)header.imgWidth;
  height = (int)header.imgHeight;
  if (height < 0) {
    height = -height;
    no_flip = true;
  }

  if (header.imgBitCount == 32) {
    no_alpha = true;
    img_size = file.ReadArray(data);

    if (!no_flip)
      for (int i = 0; i < height / 2; i++) {
        uint tmp[];
        ArrayCopy(tmp, data, 0, width * i, width);
        ArrayCopy(data, data, width * i, width * (height - i - 1), width);
        ArrayCopy(data, tmp, width * (height - i - 1), 0, width);
      }

    for (uint i = 0; i < img_size; i++) {

      if (GETRGBA(data[i]) != 0) {
        no_alpha = false;
        break;
      }
    }

    if (no_alpha) {

      for (uint i = 0; i < img_size; i++)
        data[i] |= 0xFF000000;
    }
  } else {

    int byte_width;

    if (ArrayResize(data, width * height) != -1) {

      byte_width = width * 3;
      byte_width = (byte_width + 3) & ~3;
      uchar tmp[];
      for (int i = 0; i < height; i++) {
        if (file.ReadArray(tmp, 0, byte_width) != byte_width) {
          result = false;
          break;
        }
        for (int j = 0, k = 0, p = width * (height - i - 1); j < width;
             j++, p++, k += 3) {
          r = tmp[k + 2];
          g = tmp[k + 1];
          b = tmp[k];
          data[p] = XRGB(r, g, b);
        }
      }
    } else
      result = false;
  }

  file.Close();
  return (result);
}

int CCanvas::PointClassify(const CPoint &p0, const CPoint &p1,
                           const CPoint &p2) {
  return ((p1.x - p0.x) * (p2.y - p0.y) - (p2.x - p0.x) * (p1.y - p0.y));
}

int CCanvas::PolygonClassify(const CPoint &p[]) {
  int total = ArraySize(p);
  int im = 0;
  int xm = p[0].x;
  int ym = p[0].y;

  for (int i = 1; i < total; i++) {
    if (p[i].y > ym)
      continue;
    if ((p[i].y == ym) && (p[i].x > xm))
      continue;
    im = i;
    xm = p[i].x;
    ym = p[i].y;
  }

  return PointClassify(p[(im - 1 + total) % total], p[im], p[(im + 1) % total]);
}

bool CCanvas::IsPolygonConvex(CPoint &p[]) {
  int total = ArraySize(p);

  if (total == 3)
    return (true);
  int res = SIGN(PointClassify(p[0], p[1], p[2]));
  for (int i = 1; i < total; i++) {
    int res1 =
        SIGN(PointClassify(p[i], p[(i + 1) % total], p[(i + 2) % total]));
    if (res != res1)
      return (false);
  }

  return (true);
}

void CCanvas::PolygonNormalize(CPoint &p[]) {
  int total = ArraySize(p);

  int imin = 0;
  int xmin = p[0].x;
  int ymin = p[0].y;
  for (int i = 1; i < total; i++) {
    if (p[i].y > ymin)
      continue;
    if (p[i].y == ymin) {
      if (p[i].x < xmin) {
        xmin = p[i].x;
        imin = i;
      }
      continue;
    }
    xmin = p[i].x;
    ymin = p[i].y;
    imin = i;
  }
  if (imin == 0)
    return;
  for (int i = 0; i < imin; i++) {
    CPoint tmp = p[0];
    ArrayCopy(p, p, 0, 1);
    p[total - 1] = tmp;
  }
}

void CCanvas::PolygonIntersect(CPoint &p[], CPoint &add[]) {
  int total = ArraySize(p);
  int res = SIGN(PolygonClassify(p));

  for (int i = 0; i < total; i++) {
    int rr = SIGN(PointClassify(p[i], p[(i + 1) % total], p[(i + 2) % total]));
    int rl =
        SIGN(PointClassify(p[(total - i - 2) % total],
                           p[(total - i - 1) % total], p[(total - i) % total]));
    if (rl != res || rr != res) {

      res = (total - i - 1) - (i + 1);
      if (res < 0)
        return;
      if (res < 2) {
        ArrayResize(add, total - i);
        add[0] = p[0];
        ArrayCopy(add, p, 1, i + 1, total - i - 1);
        ArrayResize(p, i + 2);
      } else {
        ArrayResize(add, res + 1);
        ArrayCopy(add, p, 0, i + 1, res + 1);
        ArrayCopy(p, p, i + 2, i + res + 1, total - res - i - 1);
        ArrayResize(p, total - res + 1);
      }
      break;
    }
  }
}

void CCanvas::PolygonFill(CPoint &p[], const uint clr) {
  int il, ir;
  double xl, xr;
  int yy;
  double dl = 0.0, dr = 0.0;
  int total = ArraySize(p);

  if (total < 3)
    return;

  while (!IsPolygonConvex(p)) {
    CPoint add[];
    PolygonIntersect(p, add);
    PolygonNormalize(add);
    PolygonFill(add, clr);
    ArrayFree(add);
  }
  total = ArraySize(p);

  il = ir = 0;
  xl = xr = p[0].x;
  yy = p[0].y;

  if (yy == p[1].y)
    xr = p[ir = 1].x;

  LineHorizontal((int)MathCeil(xl), (int)MathFloor(xr), yy, clr);

  do {
    while (yy == p[il].y) {
      il = (il - 1 + total) % total;
      if (yy > p[il].y)
        return;
      if (yy != p[il].y) {
        dl = (p[il].x - xl) / (p[il].y - yy);

        LineHorizontal((int)MathCeil(xl + dl / 2), (int)MathFloor(xl), yy, clr);
        xl += dl / 2;
      } else
        LineHorizontal((int)MathCeil(xl), (int)MathFloor(p[il].x), yy, clr);
    }
    while (yy == p[ir].y) {
      ir = (ir + 1) % total;
      if (yy > p[ir].y)
        return;
      if (yy != p[ir].y) {
        dr = (p[ir].x - xr) / (p[ir].y - yy);

        LineHorizontal((int)MathCeil(xr), (int)MathFloor(xr + dr / 2), yy, clr);
        xr += dr / 2;
      } else
        LineHorizontal((int)MathCeil(p[ir].x), (int)MathFloor(xr), yy, clr);
    }
    yy++;
    if (yy == p[il].y)
      xl = p[il].x;
    else
      xl += dl;
    if (yy == p[ir].y)
      xr = p[ir].x;
    else
      xr += dr;
    LineHorizontal((int)MathCeil(xl), (int)MathFloor(xr), yy, clr);
  } while (il >= ir && ir != 0);
}

void CCanvas::LineWu(int x1, int y1, int x2, int y2, const uint clr,
                     const uint style = UINT_MAX) {

  int dx = (x2 > x1) ? (x2 - x1) : (x1 - x2);
  int dy = (y2 > y1) ? (y2 - y1) : (y1 - y2);

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;
  int tmp;

  if (dx == 0) {

    if (y1 > y2) {
      tmp = y1;
      y1 = y2;
      y2 = tmp;
    }

    if (y2 < 0 || y1 >= m_height || x1 < 0 || x1 >= m_width) {

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }

    if (y1 < 0)
      y1 = 0;
    if (y2 >= m_height - 1)
      y2 = m_height - 1;

    int index = y1 * m_width + x1;
    for (int i = y1; i <= y2; i++, index += m_width) {
      if ((m_style & mask) == mask)
        m_pixels[index] = clr;

      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    }

    if (style != UINT_MAX)
      m_style = prev_style;

    return;
  }

  if (dy == 0) {

    if (x1 > x2) {
      tmp = x1;
      x1 = x2;
      x2 = tmp;
    }

    if (x2 < 0 || x1 >= m_width || y1 < 0 || y1 >= m_height) {

      if (style != UINT_MAX)
        m_style = prev_style;
      return;
    }

    if (x1 < 0)
      x1 = 0;
    if (x2 >= m_width)
      x2 = m_width - 1;

    for (int i = 0, index = y1 * m_width + x1; i < x2 - x1; i++, index++) {
      if ((m_style & mask) == mask)
        m_pixels[index] = clr;

      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    }

    if (style != UINT_MAX)
      m_style = prev_style;

    return;
  }

  if (dx == 0 && dy == 0) {
    PixelSet(x1, y1, clr);

    if (style != UINT_MAX)
      m_style = prev_style;

    return;
  }

  if (dy < dx) {

    if (x2 < x1) {
      x2 += x1;
      x1 = x2 - x1;
      x2 -= x1;
      y2 += y1;
      y1 = y2 - y1;
      y2 -= y1;
    }
    if (y2 < y1) {
      dy *= -1;
    }

    float grad = (float)dy / dx;

    float intery = y1 + grad;

    if ((m_style & mask) == mask)
      PixelSet(x1, y1, clr);

    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
    for (int x = x1 + 1; x < x2; x++) {
      double alpha1 = 1 - (intery - (int)intery);
      double alpha2 = (intery - (int)intery);
      if ((m_style & mask) == mask) {

        PixelTransform(x, (int)(intery), clr, alpha1);

        PixelTransform(x, (int)(intery) + 1, clr, alpha2);
      }

      intery += grad;
      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    }

    if ((m_style & mask) == mask)
      PixelSet(x2, y2, clr);
  }

  else {

    if (y2 < y1) {
      x2 += x1;
      x1 = x2 - x1;
      x2 -= x1;
      y2 += y1;
      y1 = y2 - y1;
      y2 -= y1;
    }
    if (x2 < x1) {
      dx *= -1;
    }

    float grad = (float)dx / dy;

    float interx = x1 + grad;

    if ((m_style & mask) == mask)
      PixelSet(x1, y1, clr);

    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
    for (int y = y1 + 1; y < y2; y++) {
      double alpha1 = 1 - (interx - (int)interx);
      double alpha2 = (interx - (int)interx);
      if ((m_style & mask) == mask) {

        PixelTransform((int)(interx), y, clr, alpha1);

        PixelTransform((int)(interx) + 1, y, clr, alpha2);
      }

      interx += grad;
      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    }

    if ((m_style & mask) == mask)
      PixelSet(x2, y2, clr);
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::PolylineWu(const int &x[], const int &y[], const uint clr,
                         const uint style = UINT_MAX) {

  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 2)
    return;
  total--;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  for (int i = 0; i < total; i++) {
    int x1 = x[i];
    int x2 = x[i + 1];
    int y1 = y[i];
    int y2 = y[i + 1];

    int dx = (x2 > x1) ? (x2 - x1) : (x1 - x2);
    int dy = (y2 > y1) ? (y2 - y1) : (y1 - y2);
    int tmp;

    if (dx == 0) {

      if (y1 > y2) {
        tmp = y1;
        y1 = y2;
        y2 = tmp;
      }

      if (y2 < 0 || y1 >= m_height || x1 < 0 || x1 >= m_width)
        continue;

      if (y1 < 0)
        y1 = 0;
      if (y2 >= m_height - 1)
        y2 = m_height - 1;

      int index = y1 * m_width + x1;
      for (int j = y1; j <= y2; j++, index += m_width) {
        if ((m_style & mask) == mask)
          m_pixels[index] = clr;

        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }
      continue;
    }

    if (dy == 0) {

      if (x1 > x2) {
        tmp = x1;
        x1 = x2;
        x2 = tmp;
      }

      if (x2 < 0 || x1 >= m_width || y1 < 0 || y1 >= m_height)
        continue;

      if (x1 < 0)
        x1 = 0;
      if (x2 >= m_width)
        x2 = m_width - 1;

      for (int j = 0, index = y1 * m_width + x1; j < x2 - x1; j++, index++) {
        if ((m_style & mask) == mask)
          m_pixels[index] = clr;

        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }
      continue;
    }

    if (dx == 0 && dy == 0) {
      PixelSet(x1, y1, clr);

      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
      continue;
    }

    if (dy < dx) {

      if (x2 < x1) {
        x2 += x1;
        x1 = x2 - x1;
        x2 -= x1;
        y2 += y1;
        y1 = y2 - y1;
        y2 -= y1;
      }
      if (y2 < y1) {
        dy *= -1;
      }

      float grad = (float)dy / dx;

      float intery = y1 + grad;

      if ((m_style & mask) == mask)
        PixelSet(x1, y1, clr);

      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
      for (int xc = x1 + 1; xc < x2; xc++) {
        double alpha1 = 1 - (intery - (int)intery);
        double alpha2 = (intery - (int)intery);
        if ((m_style & mask) == mask) {

          PixelTransform(xc, (int)(intery), clr, alpha1);

          PixelTransform(xc, (int)(intery) + 1, clr, alpha2);
        }

        intery += grad;
        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }

      if ((m_style & mask) == mask)
        PixelSet(x2, y2, clr);
    }

    else {

      if (y2 < y1) {
        x2 += x1;
        x1 = x2 - x1;
        x2 -= x1;
        y2 += y1;
        y1 = y2 - y1;
        y2 -= y1;
      }
      if (x2 < x1) {
        dx *= -1;
      }

      float grad = (float)dx / dy;

      float interx = x1 + grad;

      if ((m_style & mask) == mask)
        PixelSet(x1, y1, clr);

      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
      for (int yc = y1 + 1; yc < y2; yc++) {
        double alpha1 = 1 - (interx - (int)interx);
        double alpha2 = (interx - (int)interx);
        if ((m_style & mask) == mask) {

          PixelTransform((int)(interx), yc, clr, alpha1);

          PixelTransform((int)(interx) + 1, yc, clr, alpha2);
        }

        interx += grad;
        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }

      if ((m_style & mask) == mask)
        PixelSet(x2, y2, clr);
    }
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::PolygonWu(const int &x[], const int &y[], const uint clr,
                        const uint style = UINT_MAX) {

  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 2)
    return;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  for (int i = 0; i < total; i++) {
    int x1 = x[i];
    int y1 = y[i];
    int x2 = (i + 1 != total) ? x[i + 1] : x[0];
    int y2 = (i + 1 != total) ? y[i + 1] : y[0];

    int dx = (x2 > x1) ? (x2 - x1) : (x1 - x2);
    int dy = (y2 > y1) ? (y2 - y1) : (y1 - y2);
    int tmp;

    if (dx == 0) {

      if (y1 > y2) {
        tmp = y1;
        y1 = y2;
        y2 = tmp;
      }

      if (y2 < 0 || y1 >= m_height || x1 < 0 || x1 >= m_width)
        continue;

      if (y1 < 0)
        y1 = 0;
      if (y2 >= m_height - 1)
        y2 = m_height - 1;

      int index = y1 * m_width + x1;
      for (int j = y1; j <= y2; j++, index += m_width) {
        if ((m_style & mask) == mask)
          m_pixels[index] = clr;

        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }
      continue;
    }

    if (dy == 0) {

      if (x1 > x2) {
        tmp = x1;
        x1 = x2;
        x2 = tmp;
      }

      if (x2 < 0 || x1 >= m_width || y1 < 0 || y1 >= m_height)
        continue;

      if (x1 < 0)
        x1 = 0;
      if (x2 >= m_width)
        x2 = m_width - 1;

      for (int j = 0, index = y1 * m_width + x1; j < x2 - x1; j++, index++) {
        if ((m_style & mask) == mask)
          m_pixels[index] = clr;

        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }
      continue;
    }

    if (dx == 0 && dy == 0) {
      PixelSet(x1, y1, clr);

      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
      continue;
    }

    if (dy < dx) {

      if (x2 < x1) {
        x2 += x1;
        x1 = x2 - x1;
        x2 -= x1;
        y2 += y1;
        y1 = y2 - y1;
        y2 -= y1;
      }
      if (y2 < y1) {
        dy *= -1;
      }

      float grad = (float)dy / dx;

      float intery = y1 + grad;

      if ((m_style & mask) == mask)
        PixelSet(x1, y1, clr);

      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
      for (int xc = x1 + 1; xc < x2; xc++) {
        double alpha1 = 1 - (intery - (int)intery);
        double alpha2 = (intery - (int)intery);
        if ((m_style & mask) == mask) {

          PixelTransform(xc, (int)(intery), clr, alpha1);

          PixelTransform(xc, (int)(intery) + 1, clr, alpha2);
        }

        intery += grad;
        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }

      if ((m_style & mask) == mask)
        PixelSet(x2, y2, clr);
    }

    else {

      if (y2 < y1) {
        x2 += x1;
        x1 = x2 - x1;
        x2 -= x1;
        y2 += y1;
        y1 = y2 - y1;
        y2 -= y1;
      }
      if (x2 < x1) {
        dx *= -1;
      }

      float grad = (float)dx / dy;

      float interx = x1 + grad;

      if ((m_style & mask) == mask)
        PixelSet(x1, y1, clr);

      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
      for (int yc = y1 + 1; yc < y2; yc++) {
        double alpha1 = 1 - (interx - (int)interx);
        double alpha2 = (interx - (int)interx);
        if ((m_style & mask) == mask) {

          PixelTransform((int)(interx), yc, clr, alpha1);

          PixelTransform((int)(interx) + 1, yc, clr, alpha2);
        }

        interx += grad;
        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }

      if ((m_style & mask) == mask)
        PixelSet(x2, y2, clr);
    }
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::TriangleWu(const int x1, const int y1, const int x2, const int y2,
                         const int x3, const int y3, const uint clr,
                         const uint style = UINT_MAX) {

  int x[3];
  int y[3];
  x[0] = x1;
  x[1] = x2;
  x[2] = x3;
  y[0] = y1;
  y[1] = y2;
  y[2] = y3;
  PolygonWu(x, y, clr, style);
}

void CCanvas::CircleWu(const int x, const int y, const double r, const uint clr,
                       const uint style = UINT_MAX) {
  if (r <= 0)
    return;

  double r2 = r * r;
  double quarter = round(r / sqrt(2.0));

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  for (int d1 = 0; d1 <= quarter; d1++) {
    double d2 = sqrt(r2 - d1 * d1);
    double alpha1 = d2 - floor(d2);
    double alpha2 = 1 - alpha1;
    if ((m_style & mask) == mask) {
      PixelTransform4(x, y, (int)d2 + 1, d1, clr, alpha1);
      PixelTransform4(x, y, d1, (int)(d2) + 1, clr, alpha1);
    }
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
    if ((m_style & mask) == mask) {
      PixelTransform4(x, y, d1, (int)(d2), clr, alpha2);
      PixelTransform4(x, y, (int)d2, d1, clr, alpha2);
    }
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::EllipseWu(const int x1, const int y1, const int x2, const int y2,
                        const uint clr, const uint style = UINT_MAX) {
  int rx = (int)(x2 - x1) / 2;
  int ry = (int)(y2 - y1) / 2;
  int x = (x2 > x1) ? x1 + rx : x2 + rx;
  int y = (y2 > y1) ? y1 + ry : y2 + ry;
  if (rx <= 0 || ry <= 0)
    return;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  double rx2 = rx * rx;
  double ry2 = ry * ry;
  double quarter = round(rx2 / sqrt(rx2 + ry2));

  for (int dx = 0; dx <= quarter; dx++) {
    double dy = ry * sqrt(1 - dx * dx / rx2);
    double alpha1 = dy - floor(dy);
    double alpha2 = 1 - alpha1;
    if ((m_style & mask) == mask) {
      PixelTransform4(x, y, dx, (int)(dy) + 1, clr, alpha1);
      PixelTransform4(x, y, dx, (int)(dy), clr, alpha2);
    }
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  }
  quarter = round(ry2 / sqrt(rx2 + ry2));
  for (int dy = 0; dy <= quarter; dy++) {
    double dx = rx * sqrt(1 - dy * dy / ry2);
    double alpha1 = dx - floor(dx);
    double alpha2 = 1 - alpha1;
    if ((m_style & mask) == mask) {
      PixelTransform4(x, y, (int)(dx) + 1, dy, clr, alpha1);
      PixelTransform4(x, y, (int)(dx), dy, clr, alpha2);
    }
    mask <<= 1;
    if (mask == 0x1000000)
      mask = 1;
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::LineThickVertical(const int x, const int y1, const int y2,
                                const uint clr, const int size,
                                const uint style, ENUM_LINE_END end_style) {
  if (size <= 2) {
    if (size > 0)
      LineWu(x, y1, x, y2, clr, style);
    return;
  }

  double r = (size / 2.0);

  int dy = MathAbs(y2 - y1);
  int sign = (y1 < y2) ? 1 : -1;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  if (style == STYLE_SOLID) {
    SegmentVertical(x, y1, y2, sign, r, clr, end_style);
  } else {
    int ys = 0;
    int ye = 0;
    int steps = (int)MathRound(dy / r);
    bool segment = false;
    for (int i = 0; i <= steps; i++) {
      if ((m_style & mask) == mask && !segment) {
        ys = y1 + (sign) * (int)(i * r);
        segment = true;
      } else if ((m_style & mask) != mask && segment) {
        ye = y1 + (sign) * (int)(i * r);
        SegmentVertical(x, ys, ye, sign, r, clr, end_style);
        segment = false;
      }
      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    }

    if (segment)
      SegmentVertical(x, ys, y2, sign, r, clr, end_style);
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::LineThickHorizontal(const int x1, const int x2, const int y,
                                  const uint clr, const int size,
                                  const uint style, ENUM_LINE_END end_style) {
  if (size <= 2) {
    if (size > 0)
      LineWu(x1, y, x2, y, clr, style);
    return;
  }

  double r = (size / 2.0);

  int dx = MathAbs(x2 - x1);
  int sign = (x1 < x2) ? 1 : -1;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  if (style == STYLE_SOLID) {
    SegmentHorizontal(x1, x2, y, sign, r, clr, end_style);
  } else {
    int xs = 0;
    int xe = 0;
    int steps = (int)MathRound(dx / r);
    bool segment = false;
    for (int i = 0; i <= steps; i++) {
      if ((m_style & mask) == mask && !segment) {
        xs = x1 + (sign) * (int)(i * r);
        segment = true;
      } else if ((m_style & mask) != mask && segment) {
        xe = x1 + (sign) * (int)(i * r);
        SegmentHorizontal(xs, xe, y, sign, r, clr, end_style);
        segment = false;
      }
      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    }

    if (segment)
      SegmentHorizontal(xs, x2, y, sign, r, clr, end_style);
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::LineThick(const int x1, const int y1, const int x2, const int y2,
                        const uint clr, const int size, const uint style,
                        ENUM_LINE_END end_style) {
  if (size <= 2) {
    if (size > 0)
      LineWu(x1, y1, x2, y2, clr, style);
    return;
  }

  double r = (size / 2.0);

  double dx = MathAbs(x2 - x1);
  double dy = MathAbs(y2 - y1);
  if (dx == 0) {
    LineThickVertical(x1, y1, y2, clr, size, style, end_style);
    return;
  }
  if (dy == 0) {
    LineThickHorizontal(x1, x2, y1, clr, size, style, end_style);
    return;
  }

  double k = MathArctan(dx / dy);
  double rcos_k = r * cos(k);
  double rsin_k = r * sin(k);

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  int xsign = (x1 < x2) ? 1 : -1;
  int ysign = (y1 < y2) ? 1 : -1;
  double kp0 = (-xsign * ysign) * (dx / dy);
  double kp1 = -1 / kp0;

  if (style == STYLE_SOLID) {
    Segment(x1, y1, x2, y2, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r, clr,
            end_style);
  } else {
    int xs = 0;
    int ys = 0;
    int xe = 0;
    int ye = 0;
    double length = MathSqrt(dx * dx + dy * dy);
    int steps = (int)MathRound(length / r);
    bool segment = false;
    for (int i = 0; i <= steps; i++) {
      if ((m_style & mask) == mask && !segment) {
        xs = x1 + (xsign) * (int)(i * rsin_k);
        ys = y1 + (ysign) * (int)(i * rcos_k);
        segment = true;
      } else if ((m_style & mask) != mask && segment) {
        xe = x1 + (xsign) * (int)(i * rsin_k);
        ye = y1 + (ysign) * (int)(i * rcos_k);
        Segment(xs, ys, xe, ye, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r, clr,
                end_style);
        segment = false;
      }
      mask <<= 1;
      if (mask == 0x1000000)
        mask = 1;
    }

    if (segment)
      Segment(xs, ys, x2, y2, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r, clr,
              end_style);
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::PolylineThick(const int &x[], const int &y[], const uint clr,
                            const int size, const uint style,
                            ENUM_LINE_END end_style) {
  if (size <= 2) {
    if (size > 0)
      PolylineWu(x, y, clr, style);
    return;
  }

  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 2)
    return;
  total--;

  double r = (size / 2.0);

  double gap = 1.0;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  for (int index = 0; index < total; index++) {
    int x1 = x[index];
    int y1 = y[index];
    int x2 = x[index + 1];
    int y2 = y[index + 1];

    double dx = MathAbs(x2 - x1);
    double dy = MathAbs(y2 - y1);
    if (dx == 0) {
      int sign = (y1 < y2) ? 1 : -1;

      if (style == STYLE_SOLID) {
        SegmentVertical(x1, y1, y2, sign, r, clr, end_style);
      } else {
        int ys = y1;
        int ye = 0;
        double steps = dy / r;
        int isteps = (int)steps;
        bool segment = false;
        for (int i = 0; i < isteps; i++) {
          if ((m_style & mask) == mask && !segment) {
            ys = y1 + (sign) * (int)(i * r);
            segment = true;
          } else if ((m_style & mask) != mask && segment) {
            ye = y1 + (sign) * (int)(i * r);
            SegmentVertical(x1, ys, ye, sign, r, clr, end_style);
            segment = false;
          }
          mask <<= 1;
          if (mask == 0x1000000)
            mask = 1;
        }

        if (segment || (steps < 1 && (m_style & mask) == mask))
          SegmentVertical(x1, ys, y2, sign, r, clr, end_style);
        gap -= steps - isteps;
        if (gap < 0) {
          gap++;
          mask <<= 1;
          if (mask == 0x1000000)
            mask = 1;
        }
      }
      continue;
    }
    if (dy == 0) {
      int sign = (x1 < x2) ? 1 : -1;

      if (style == STYLE_SOLID) {
        SegmentHorizontal(x1, x2, y1, sign, r, clr, end_style);
      } else {
        int xs = x1;
        int xe = 0;
        double steps = dx / r;
        int isteps = (int)steps;
        bool segment = false;
        for (int i = 0; i < isteps; i++) {
          if ((m_style & mask) == mask && !segment) {
            xs = x1 + (sign) * (int)(i * r);
            segment = true;
          } else if ((m_style & mask) != mask && segment) {
            xe = x1 + (sign) * (int)(i * r);
            SegmentHorizontal(xs, xe, y1, sign, r, clr, end_style);
            segment = false;
          }
          mask <<= 1;
          if (mask == 0x1000000)
            mask = 1;
        }

        if (segment || (steps < 1 && (m_style & mask) == mask))
          SegmentHorizontal(xs, x2, y1, sign, r, clr, end_style);
        gap -= steps - isteps;
        if (gap < 0) {
          gap++;
          mask <<= 1;
          if (mask == 0x1000000)
            mask = 1;
        }
      }
      continue;
    }

    double k = MathArctan(dx / dy);
    double rcos_k = r * cos(k);
    double rsin_k = r * sin(k);

    int xsign = (x1 < x2) ? 1 : -1;
    int ysign = (y1 < y2) ? 1 : -1;
    double kp0 = (-xsign * ysign) * (dx / dy);
    double kp1 = -1 / kp0;

    if (style == STYLE_SOLID) {
      Segment(x1, y1, x2, y2, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r, clr,
              end_style);
    } else {
      int xs = x1;
      int ys = y1;
      int xe = 0;
      int ye = 0;
      double length = MathSqrt(dx * dx + dy * dy);
      double steps = length / r;
      int isteps = (int)steps;
      bool segment = false;
      for (int i = 0; i < isteps; i++) {
        if ((m_style & mask) == mask && !segment) {
          xs = x1 + (xsign) * (int)(i * rsin_k);
          ys = y1 + (ysign) * (int)(i * rcos_k);
          segment = true;
        } else if ((m_style & mask) != mask && segment) {
          xe = x1 + (xsign) * (int)(i * rsin_k);
          ye = y1 + (ysign) * (int)(i * rcos_k);
          Segment(xs, ys, xe, ye, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r,
                  clr, end_style);
          segment = false;
        }
        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }

      if (segment || (steps < 1 && (m_style & mask) == mask))
        Segment(xs, ys, x2, y2, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r, clr,
                end_style);
      gap -= steps - isteps;
      if (gap < 0) {
        gap++;
        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }
    }
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

void CCanvas::PolygonThick(const int &x[], const int &y[], const uint clr,
                           const int size, const uint style,
                           ENUM_LINE_END end_style) {
  if (size <= 2) {
    if (size > 0)
      PolylineWu(x, y, clr, style);
    return;
  }

  int total = ArraySize(x);
  if (total > ArraySize(y))
    total = ArraySize(y);

  if (total < 2)
    return;

  double r = (size / 2.0);

  double gap = 1.0;

  uint prev_style = m_style;
  if (style != UINT_MAX)
    LineStyleSet(style);
  uint mask = 1 << m_style_idx;

  for (int index = 0; index < total; index++) {
    int x1 = x[index];
    int y1 = y[index];
    int x2 = (index != total - 1) ? x[index + 1] : x[0];
    int y2 = (index != total - 1) ? y[index + 1] : y[0];

    double dx = MathAbs(x2 - x1);
    double dy = MathAbs(y2 - y1);
    if (dx == 0) {
      int sign = (y1 < y2) ? 1 : -1;

      if (style == STYLE_SOLID) {
        SegmentVertical(x1, y1, y2, sign, r, clr, end_style);
      } else {
        int ys = y1;
        int ye = 0;
        double steps = dy / r;
        int isteps = (int)steps;
        bool segment = false;
        for (int i = 0; i < isteps; i++) {
          if ((m_style & mask) == mask && !segment) {
            ys = y1 + (sign) * (int)(i * r);
            segment = true;
          } else if ((m_style & mask) != mask && segment) {
            ye = y1 + (sign) * (int)(i * r);
            SegmentVertical(x1, ys, ye, sign, r, clr, end_style);
            segment = false;
          }
          mask <<= 1;
          if (mask == 0x1000000)
            mask = 1;
        }

        if (segment || (steps < 1 && (m_style & mask) == mask))
          SegmentVertical(x1, ys, y2, sign, r, clr, end_style);
        gap -= steps - isteps;
        if (gap < 0) {
          gap++;
          mask <<= 1;
          if (mask == 0x1000000)
            mask = 1;
        }
      }
      continue;
    }
    if (dy == 0) {
      int sign = (x1 < x2) ? 1 : -1;

      if (style == STYLE_SOLID) {
        SegmentHorizontal(x1, x2, y1, sign, r, clr, end_style);
      } else {
        int xs = x1;
        int xe = 0;
        double steps = dx / r;
        int isteps = (int)steps;
        bool segment = false;
        for (int i = 0; i < isteps; i++) {
          if ((m_style & mask) == mask && !segment) {
            xs = x1 + (sign) * (int)(i * r);
            segment = true;
          } else if ((m_style & mask) != mask && segment) {
            xe = x1 + (sign) * (int)(i * r);
            SegmentHorizontal(xs, xe, y1, sign, r, clr, end_style);
            segment = false;
          }
          mask <<= 1;
          if (mask == 0x1000000)
            mask = 1;
        }

        if (segment || (steps < 1 && (m_style & mask) == mask))
          SegmentHorizontal(xs, x2, y1, sign, r, clr, end_style);
        gap -= steps - isteps;
        if (gap < 0) {
          gap++;
          mask <<= 1;
          if (mask == 0x1000000)
            mask = 1;
        }
      }
      continue;
    }

    double k = MathArctan(dx / dy);
    double rcos_k = r * cos(k);
    double rsin_k = r * sin(k);

    int xsign = (x1 < x2) ? 1 : -1;
    int ysign = (y1 < y2) ? 1 : -1;
    double kp0 = (-xsign * ysign) * (dx / dy);
    double kp1 = -1 / kp0;

    if (style == STYLE_SOLID) {
      Segment(x1, y1, x2, y2, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r, clr,
              end_style);
    } else {
      int xs = x1;
      int ys = y1;
      int xe = 0;
      int ye = 0;
      double length = MathSqrt(dx * dx + dy * dy);
      double steps = length / r;
      int isteps = (int)steps;
      bool segment = false;
      for (int i = 0; i < isteps; i++) {
        if ((m_style & mask) == mask && !segment) {
          xs = x1 + (xsign) * (int)(i * rsin_k);
          ys = y1 + (ysign) * (int)(i * rcos_k);
          segment = true;
        } else if ((m_style & mask) != mask && segment) {
          xe = x1 + (xsign) * (int)(i * rsin_k);
          ye = y1 + (ysign) * (int)(i * rcos_k);
          Segment(xs, ys, xe, ye, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r,
                  clr, end_style);
          segment = false;
        }
        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }

      if (segment || (steps < 1 && (m_style & mask) == mask))
        Segment(xs, ys, x2, y2, kp0, kp1, xsign, ysign, rcos_k, rsin_k, r, clr,
                end_style);
      gap -= steps - isteps;
      if (gap < 0) {
        gap++;
        mask <<= 1;
        if (mask == 0x1000000)
          mask = 1;
      }
    }
  }

  if (style != UINT_MAX)
    m_style = prev_style;
}

bool CCanvas::PixelsSimilar(const uint clr0, const uint clr1,
                            const uint threshould) {
  uint dr = MathAbs(uint((clr0 >> 16) & 0xff) - uint((clr1 >> 16) & 0xff));
  uint dg = MathAbs(uint((clr0 >> 8) & 0xff) - uint((clr1 >> 8) & 0xff));
  uint db = MathAbs(uint((clr0 >> 0) & 0xff) - uint((clr1 >> 0) & 0xff));

  return (dr <= threshould || dg <= threshould || db <= threshould);
}

void CCanvas::PixelTransform(const int x, const int y, const uint clr,
                             const double alpha) {
  int index = y * m_width + x;

  if (x < 0 || y < 0 || x > m_width || y > m_height ||
      index >= ArraySize(m_pixels))
    return;

  if (alpha == 1) {
    m_pixels[index] = clr;
    return;
  }

  uint clr0 = m_pixels[index];

  double r0 = ((clr0 >> 16) & 0xFF) * (1.0 - alpha);
  double g0 = ((clr0 >> 8) & 0xFF) * (1.0 - alpha);
  double b0 = ((clr0 >> 0) & 0xFF) * (1.0 - alpha);

  double r1 = ((clr >> 16) & 0xFF) * (alpha);
  double g1 = ((clr >> 8) & 0xFF) * (alpha);
  double b1 = ((clr >> 0) & 0xFF) * (alpha);

  int r = (int)(r0 + r1);
  int g = (int)(g0 + g1);
  int b = (int)(b0 + b1);

  m_pixels[y * m_width + x] = ((r << 16) | (g << 8) | (b << 0) | (255 << 24));
}

void CCanvas::PixelTransform4(const int x, const int y, const int dx,
                              const int dy, const uint clr,
                              const double alpha) {
  PixelTransform(x + dx, y + dy, clr, alpha);
  PixelTransform(x - dx, y + dy, clr, alpha);
  PixelTransform(x + dx, y - dy, clr, alpha);
  PixelTransform(x - dx, y - dy, clr, alpha);
}

void CCanvas::PixelSet4AA(const double x, const double y, const double dx,
                          const double dy, const uint clr) {
  PixelSetAA(x + dx, y + dy, clr);
  PixelSetAA(x - dx, y + dy, clr);
  PixelSetAA(x + dx, y - dy, clr);
  PixelSetAA(x - dx, y - dy, clr);
}

void CCanvas::SegmentVertical(const int x, const int y1, const int y2,
                              const int ysign, const double r, const uint clr,
                              ENUM_LINE_END end_style) {

  int ye1, ye2;
  int ys1, ys2;
  switch (end_style) {
  case LINE_END_ROUND: {
    ye1 = y1;
    ye2 = y2;
    ys1 = y1 - (int)(ysign * r);
    ys2 = y2 + (int)(ysign * r);
    break;
  }
  case LINE_END_BUTT: {
    ye1 = y1;
    ye2 = y2;
    ys1 = y1;
    ys2 = y2;
    break;
  }
  case LINE_END_SQUARE: {
    ye1 = y1 - (int)(ysign * r);
    ye2 = y2 + (int)(ysign * r);
    ys1 = ye1;
    ys2 = ye2;
    break;
  }
  default:
    return;
  };

  for (int i = 0; i <= MathAbs(ys2 - ys1); i++) {
    double yi = ys1 + (ysign * i);
    for (int j = 0; j < 2 * r; j++) {
      double xi = x - r + j;
      double dist = DistancePointSegment(xi, yi, x, ye1, x, ye2);
      double val = MathAbs(dist / r);
      PixelTransform((int)xi, (int)yi, clr, FilterFunction(val));
    }
  }
}

void CCanvas::SegmentHorizontal(const int x1, const int x2, const int y,
                                const int xsign, const double r, const uint clr,
                                ENUM_LINE_END end_style) {

  int xe1, xe2;
  int xs1, xs2;
  switch (end_style) {
  case LINE_END_ROUND: {
    xe1 = x1;
    xe2 = x2;
    xs1 = x1 - (int)(xsign * r);
    xs2 = x2 + (int)(xsign * r);
    break;
  }
  case LINE_END_BUTT: {
    xe1 = x1;
    xe2 = x2;
    xs1 = x1;
    xs2 = x2;
    break;
  }
  case LINE_END_SQUARE: {
    xe1 = x1 - (int)(xsign * r);
    xe2 = x2 + (int)(xsign * r);
    xs1 = xe1;
    xs2 = xe2;
    break;
  }
  default:
    return;
  };

  for (int i = 0; i <= MathAbs(xs2 - xs1); i++) {
    double xi = xs1 + (xsign * i);
    for (int j = 0; j < 2 * r; j++) {
      double yi = y - r + j;
      double dist = DistancePointSegment(xi, yi, xe1, y, xe2, y);
      double val = MathAbs(dist / r);
      PixelTransform((int)xi, (int)yi, clr, FilterFunction(val));
    }
  }
}

void CCanvas::Segment(const int x1, const int y1, const int x2, const int y2,
                      const double kp0, const double kp1, const int xsign,
                      const int ysign, const double rcos_k, const double rsin_k,
                      const double r, const uint clr, ENUM_LINE_END end_style) {
  if (x1 == x2 && y1 == y2)
    return;
  if (x1 == x2) {
    SegmentVertical(x1, y1, y2, ysign, r, clr, end_style);
    return;
  }
  if (y1 == y2) {
    SegmentHorizontal(x1, x2, y1, xsign, r, clr, end_style);
    return;
  }

  int xe1, ye1, xe2, ye2;
  int xs1, ys1, xs2, ys2;
  switch (end_style) {
  case LINE_END_ROUND: {
    xe1 = x1;
    ye1 = y1;
    xe2 = x2;
    ye2 = y2;
    xs1 = x1 - (xsign) * (int)(rsin_k);
    ys1 = y1 - (ysign) * (int)(rcos_k);
    xs2 = x2 + (xsign) * (int)(rsin_k);
    ys2 = y2 + (ysign) * (int)(rcos_k);
    break;
  }
  case LINE_END_BUTT: {
    xe1 = x1;
    ye1 = y1;
    xe2 = x2;
    ye2 = y2;
    xs1 = x1;
    ys1 = y1;
    xs2 = x2;
    ys2 = y2;
    break;
  }
  case LINE_END_SQUARE: {
    xe1 = x1 - (xsign) * (int)(rsin_k);
    ye1 = y1 - (ysign) * (int)(rcos_k);
    xe2 = x2 + (xsign) * (int)(rsin_k);
    ye2 = y2 + (ysign) * (int)(rcos_k);
    xs1 = xe1;
    ys1 = ye1;
    xs2 = xe2;
    ys2 = ye2;
    break;
  }
  default:
    return;
  };

  double p0x = xs1 + (xsign) * (rcos_k);
  double p0y = ys1 - (ysign) * (rsin_k);
  double p1x = xs1 - (xsign) * (rcos_k);
  double p1y = ys1 + (ysign) * (rsin_k);
  double p2x = xs2 + (xsign) * (rcos_k);
  double p2y = ys2 - (ysign) * (rsin_k);
  double p3x = xs2 - (xsign) * (rcos_k);
  double p3y = ys2 + (ysign) * (rsin_k);

  if (MathAbs(kp0) >= 1) {
    double xi0, xi1;
    double height = MathAbs(p3y - p0y);
    for (int i = 0; i <= height; i++) {
      double y = p0y + (ysign * i);
      double xi00 = MathRound(p0x + (y - p0y) / kp0);
      double xi01 = MathRound(p1x + (y - p1y) / kp1);
      double xi02 = MathRound(p2x + (y - p2y) / kp1);
      double xi03 = MathRound(p3x + (y - p3y) / kp0);
      if (xsign == 1) {
        xi0 = MathMax(xi00, xi01);
        xi1 = MathMin(xi02, xi03);
      } else {
        xi0 = MathMin(xi00, xi01);
        xi1 = MathMax(xi02, xi03);
      }
      double width = MathAbs(MathRound(xi1 - xi0));
      for (int j = 0; j <= width; j++) {
        double xi = xi0 + (xsign * j);
        double dist = DistancePointSegment(xi, y, xe1, ye1, xe2, ye2);
        double val = MathAbs(dist / r);
        PixelTransform((int)xi, (int)y, clr, FilterFunction(val));
      }
    }
  } else {
    double yi0, yi1;
    double width = MathAbs(p2x - p1x);
    for (int i = 0; i <= width; i++) {
      double x = p1x + (xsign * i);
      double yi00 = MathRound(p0y + (x - p0x) * kp0);
      double yi01 = MathRound(p1y + (x - p1x) * kp1);
      double yi02 = MathRound(p2y + (x - p2x) * kp1);
      double yi03 = MathRound(p3y + (x - p3x) * kp0);
      if (ysign == 1) {
        yi0 = MathMax(yi00, yi02);
        yi1 = MathMin(yi01, yi03);
      } else {
        yi0 = MathMin(yi00, yi02);
        yi1 = MathMax(yi01, yi03);
      }
      double height = MathAbs(yi1 - yi0);
      for (int j = 0; j <= height; j++) {
        double yi = yi0 + (ysign * j);
        double dist = DistancePointSegment(x, yi, xe1, ye1, xe2, ye2);
        double val = MathAbs(dist / r);
        PixelTransform((int)x, (int)yi, clr, FilterFunction(val));
      }
    }
  }
}

double CCanvas::FilterFunction(const double x) {
  if (x <= 0.8)
    return (1.0);
  else
    return MathExp(-(x - 0.8) * (x - 0.8) * 50);
}

double CCanvas::DistancePointSegment(const double px, const double py,
                                     const double x1, const double y1,
                                     const double x2, const double y2) {

  double a = (px - x1) * (px - x1) + (py - y1) * (py - y1);
  double b = (px - x2) * (px - x2) + (py - y2) * (py - y2);
  double c = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);

  if (a >= b + c)
    return (MathSqrt(b));
  if (b >= a + c)
    return (MathSqrt(a));

  a = MathSqrt(a);
  b = MathSqrt(b);
  c = MathSqrt(c);
  double p = (a + b + c) / 2;
  double s = MathSqrt((p - a) * (p - b) * (p - c) * p);

  if (MathIsValidNumber(s))
    return (s * 2.0 / c);
  else
    return (0);
}

void CCanvas::PolylineSmooth(const int &x[], const int &y[], const uint clr,
                             const int size,
                             ENUM_LINE_STYLE style = STYLE_SOLID,
                             ENUM_LINE_END end_style = LINE_END_ROUND,
                             double tension = 0.5, double step = 10) {

  int arr_size = ArraySize(x);
  if (arr_size != ArraySize(y))
    return;

  double x1, x2, y1, y2;
  tension *= 0.3;

  int xc[];
  int yc[];

  double ptX[];
  double ptY[];
  int size_pt = arr_size * 3 - 2;

  ArrayResize(ptX, size_pt);
  ArrayResize(ptY, size_pt);

  CalcCurveBezierEndp(x[0], y[0], x[1], y[1], tension, x1, y1);

  ptX[0] = x[0];
  ptY[0] = y[0];
  ptX[1] = x1;
  ptY[1] = y1;

  for (int i = 0; i < arr_size - 2; i++) {
    CalcCurveBezier(x, y, i, tension, x1, y1, x2, y2);
    ptX[3 * i + 2] = x1;
    ptY[3 * i + 2] = y1;
    ptX[3 * i + 3] = x[i + 1];
    ptY[3 * i + 3] = y[i + 1];
    ptX[3 * i + 4] = x2;
    ptY[3 * i + 4] = y2;
  }
  CalcCurveBezierEndp(x[arr_size - 1], y[arr_size - 1], x[arr_size - 2],
                      y[arr_size - 2], tension, x1, y1);

  ptX[size_pt - 2] = x1;
  ptY[size_pt - 2] = y1;
  ptX[size_pt - 1] = x[arr_size - 1];
  ptY[size_pt - 1] = y[arr_size - 1];

  int index = 0;
  for (int i = 0; i < arr_size - 1; i++) {

    double distance = MathSqrt((x[i + 1] - x[i]) * (x[i + 1] - x[i]) +
                               (y[i + 1] - y[i]) * (y[i + 1] - y[i]));
    int size_i = (step > 0.0) ? (int)(distance / step) : 1;
    if (size_i < 1)
      size_i = 2;
    ArrayResize(xc, ArraySize(xc) + size_i, 1024);
    ArrayResize(yc, ArraySize(yc) + size_i, 1024);
    for (int t = 0; t < size_i; t++, index++) {
      xc[index] = (int)MathRound(CalcBezierX((double)t / size_i, ptX[3 * i],
                                             ptX[3 * i + 1], ptX[3 * i + 2],
                                             ptX[3 * i + 3]));
      yc[index] = (int)MathRound(CalcBezierY((double)t / size_i, ptY[3 * i],
                                             ptY[3 * i + 1], ptY[3 * i + 2],
                                             ptY[3 * i + 3]));
    }
  }
  PolylineThick(xc, yc, clr, size, style, LINE_END_ROUND);
}

void CCanvas::PolygonSmooth(int &x[], int &y[], const uint clr, const int size,
                            ENUM_LINE_STYLE style = STYLE_SOLID,
                            ENUM_LINE_END end_style = LINE_END_ROUND,
                            double tension = 0.5, double step = 10) {

  int size_arr = ArraySize(x);
  if (size_arr != ArraySize(y))
    return;

  double x1, x2, y1, y2;
  tension *= 0.3;

  int xc[];
  int yc[];

  double ptX[];
  double ptY[];
  int size_pt = (size_arr + 1) * 3 - 3;

  ArrayResize(ptX, size_pt);
  ArrayResize(ptY, size_pt);

  int xe[];
  int ye[];
  ArrayResize(xe, size_arr + 2);
  ArrayResize(ye, size_arr + 2);
  xe[0] = x[size_arr - 1];
  ye[0] = y[size_arr - 1];
  xe[size_arr + 1] = x[0];
  ye[size_arr + 1] = y[0];
  ArrayCopy(xe, x, 1, 0, size_arr);
  ArrayCopy(ye, y, 1, 0, size_arr);

  for (int i = 0; i < size_arr; i++) {
    CalcCurveBezier(xe, ye, i, tension, x1, y1, x2, y2);
    ptX[3 * i + 0] = x1;
    ptY[3 * i + 0] = y1;
    ptX[3 * i + 1] = xe[i + 1];
    ptY[3 * i + 1] = ye[i + 1];
    ptX[3 * i + 2] = x2;
    ptY[3 * i + 2] = y2;
  }

  int index = 0;
  for (int i = 0; i < size_arr - 1; i++) {
    double distance = MathSqrt((x[i] - x[i + 1]) * (x[i] - x[i + 1]) +
                               (y[i] - y[i + 1]) * (y[i] - y[i + 1]));
    int size_i = (step > 0.0) ? (int)(distance / step) : 1;
    if (size_i < 1)
      size_i = 2;
    ArrayResize(xc, ArraySize(xc) + size_i, 1024);
    ArrayResize(yc, ArraySize(yc) + size_i, 1024);
    for (int t = 0; t < size_i; t++, index++) {
      xc[index] = (int)MathRound(CalcBezierX((double)t / size_i, ptX[1 + i * 3],
                                             ptX[2 + i * 3], ptX[3 + i * 3],
                                             ptX[4 + i * 3]));
      yc[index] = (int)MathRound(CalcBezierY((double)t / size_i, ptY[1 + i * 3],
                                             ptY[2 + i * 3], ptY[3 + i * 3],
                                             ptY[4 + i * 3]));
    }
  }

  double distance =
      MathSqrt((x[size_arr - 1] - x[0]) * (x[size_arr - 1] - x[0]) +
               (y[size_arr - 1] - y[0]) * (y[size_arr - 1] - y[0]));
  int size_i = (step > 0.0) ? (int)(distance / step) : 1;
  if (size_i < 1)
    size_i = 2;
  ArrayResize(xc, ArraySize(xc) + size_i, 1024);
  ArrayResize(yc, ArraySize(yc) + size_i, 1024);
  for (int t = 0; t < size_i; t++, index++) {
    xc[index] = (int)MathRound(CalcBezierX((double)t / size_i, ptX[size_pt - 2],
                                           ptX[size_pt - 1], ptX[0], ptX[1]));
    yc[index] = (int)MathRound(CalcBezierY((double)t / size_i, ptY[size_pt - 2],
                                           ptY[size_pt - 1], ptY[0], ptY[1]));
  }
  PolygonThick(xc, yc, clr, size, style, LINE_END_ROUND);
}

void CCanvas::CalcCurveBezierEndp(const double xend, const double yend,
                                  const double xadj, const double yadj,
                                  const double tension, double &x, double &y) {
  x = (tension * (xadj - xend) + xend);
  y = (tension * (yadj - yend) + yend);
}

void CCanvas::CalcCurveBezier(const int &x[], const int &y[], const int i,
                              const double tension, double &x1, double &y1,
                              double &x2, double &y2) {
  double xdiff, ydiff;

  xdiff = x[i + 2] - x[i];
  ydiff = y[i + 2] - y[i];

  x1 = x[i + 1] - tension * xdiff;
  y1 = y[i + 1] - tension * ydiff;
  x2 = x[i + 1] + tension * xdiff;
  y2 = y[i + 1] + tension * ydiff;
}

double CCanvas::CalcBezierX(const double t, const double x0, const double x1,
                            const double x2, const double x3) {
  return (x0 * ((1 - t) * (1 - t) * (1 - t)) +
          x1 * 3 * t * ((1 - t) * (1 - t)) + x2 * 3 * (t * t) * (1 - t) +
          x3 * (t * t * t));
}

double CCanvas::CalcBezierY(const double t, const double y0, const double y1,
                            const double y2, const double y3) {
  return (y0 * ((1 - t) * (1 - t) * (1 - t)) +
          y1 * 3 * t * ((1 - t) * (1 - t)) + y2 * 3 * (t * t) * (1 - t) +
          y3 * (t * t * t));
}

void CCanvas::BitBlt(int dst_x, int dst_y, const uint &src[], int src_width,
                     int src_height, int src_x, int src_y, int src_dx,
                     int src_dy, uint mode) {
  for (int y = 0; y < src_dy; y++)
    for (int x = 0; x < src_dx; x++) {
      PixelSet(dst_x + x, dst_y + y, src[(src_y + y) * src_width + src_x + x]);
    }
}

#endif
