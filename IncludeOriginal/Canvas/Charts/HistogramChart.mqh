#ifndef HISTOGRAM_CHART_H
#define HISTOGRAM_CHART_H

#include "ChartCanvas.mqh"
#include <Arrays\ArrayObj.mqh>

class CHistogramChart : public CChartCanvas {
private:
  uint m_fill_brush[];

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

  void Gradient(const bool flag = true) {
    m_gradient = flag;
  }
  void BarGap(const uint value) {
    m_bar_gap = value;
  }
  void BarMinSize(const uint value) {
    m_bar_min_size = value;
  }
  void BarBorder(const uint value) {
    m_bar_border = value;
  }

  bool SeriesAdd(const double &value[], const string descr = "",
                 const uint clr = 0);
  bool SeriesInsert(const uint pos, const double &value[],
                    const string descr = "", const uint clr = 0);
  bool SeriesUpdate(const uint pos, const double &value[],
                    const string descr = NULL, const uint clr = 0);
  bool SeriesDelete(const uint pos);
  bool ValueUpdate(const uint series, const uint pos, double value);

protected:
  virtual void DrawData(const uint idx);
  void DrawBar(const int x, const int y, const int w, const int h,
               const uint clr);
  void GradientBrush(const int size, const uint fill_clr);
};

CHistogramChart::CHistogramChart(void)
    : m_gradient(true), m_bar_gap(3), m_bar_min_size(5), m_bar_border(0) {
  ShowFlags(FLAG_SHOW_LEGEND | FLAGS_SHOW_SCALES | FLAG_SHOW_GRID);
}

CHistogramChart::~CHistogramChart(void) {
  if (ArraySize(m_fill_brush) != 0)
    ArrayFree(m_fill_brush);
}

bool CHistogramChart::Create(const string name, const int width,
                             const int height, ENUM_COLOR_FORMAT clrfmt) {

  if ((m_values = new CArrayObj) == NULL)
    return (false);

  m_data = m_values;

  if (!CChartCanvas::Create(name, width, height, clrfmt))
    return (false);

  return (true);
}

bool CHistogramChart::SeriesAdd(const double &value[], const string descr,
                                const uint clr) {

  if (m_data_total == m_max_data)
    return (false);

  CArrayDouble *arr = new CArrayDouble;
  if (!m_values.Add(arr))
    return (false);
  if (!arr.AssignArray(value))
    return (false);
  if (!m_colors.Add((clr == 0) ? GetDefaultColor(m_data_total) : clr))
    return (false);
  if (!m_descriptors.Add(descr))
    return (false);
  m_data_total++;

  Redraw();

  return (true);
}

bool CHistogramChart::SeriesInsert(const uint pos, const double &value[],
                                   const string descr, const uint clr) {

  if (m_data_total == m_max_data)
    return (false);
  if (pos >= m_data_total)
    return (false);

  CArrayDouble *arr = new CArrayDouble;
  if (!m_values.Insert(arr, pos))
    return (false);
  if (!arr.AssignArray(value))
    return (false);
  if (!m_colors.Insert((clr == 0) ? GetDefaultColor(m_data_total) : clr, pos))
    return (false);
  if (!m_descriptors.Insert(descr, pos))
    return (false);
  m_data_total++;

  Redraw();

  return (true);
}

bool CHistogramChart::SeriesUpdate(const uint pos, const double &value[],
                                   const string descr, const uint clr) {

  if (pos >= m_data_total)
    return (false);
  CArrayDouble *data = m_values.At(pos);
  if (data == NULL)
    return (false);

  if (!data.AssignArray(value))
    return (false);
  if (clr != 0 && !m_colors.Update(pos, clr))
    return (false);
  if (descr != NULL && !m_descriptors.Update(pos, descr))
    return (false);

  Redraw();

  return (true);
}

bool CHistogramChart::SeriesDelete(const uint pos) {

  if (pos >= m_data_total && m_data_total != 0)
    return (false);

  if (!m_values.Delete(pos))
    return (false);
  m_data_total--;
  if (!m_colors.Delete(pos))
    return (false);
  if (!m_descriptors.Delete(pos))
    return (false);

  Redraw();

  return (true);
}

bool CHistogramChart::ValueUpdate(const uint series, const uint pos,
                                  double value) {
  CArrayDouble *data = m_values.At(series);

  if (data == NULL)
    return (false);

  if (!data.Update(pos, value))
    return (false);

  Redraw();

  return (true);
}

void CHistogramChart::DrawData(const uint idx) {
  double value = 0.0;

  CArrayDouble *data = m_values.At(idx);
  if (data == NULL)
    return;
  int total = data.Total();
  if (total == 0 || (int)idx >= total)
    return;

  int x1 = m_data_area.left;
  int x2 = m_data_area.right;
  int dx = (x2 - x1) / total;
  uint clr = m_colors[idx];
  uint w = dx / m_data_total;
  if (w < m_bar_min_size)
    w = m_bar_min_size;
  int x = x1 + (int)(m_bar_gap + w * idx);

  string fontname;
  int fontsize = 0;
  uint fontflags = 0;
  uint fontangle = 0;
  if (IS_SHOW_VALUE) {
    FontGet(fontname, fontsize, fontflags, fontangle);
    FontSet(fontname, -10 * (w - 3), fontflags, 900);
  }

  GradientBrush(w, clr);

  for (int i = 0; i < total; i++, x += dx) {
    int y, h;
    double val = data[i];
    if (val == EMPTY_VALUE)
      continue;
    if (m_accumulative)
      value += val;
    else
      value = val;

    if (value > 0) {
      y = (m_y_0 - (int)(value * m_scale_y));
      h = m_y_0 - y;
    } else {
      y = m_y_0;
      h = -(int)(value * m_scale_y);
    }
    DrawBar(x, y, w, h, clr);

    if (IS_SHOW_VALUE) {
      string text = DoubleToString(value, 2);
      int width = (int)(TextWidth(text) + w);
      if (value > 0) {
        if (width > y - m_y_max)
          TextOut(x + w / 2, y + w, text, m_color_text, TA_RIGHT | TA_VCENTER);
        else
          TextOut(x + w / 2, y - w, text, m_color_text, TA_LEFT | TA_VCENTER);
      } else {
        if (width > m_y_min - y - h)
          TextOut(x + w / 2, y + h - w, text, m_color_text,
                  TA_LEFT | TA_VCENTER);
        else
          TextOut(x + w / 2, y + h + w, text, m_color_text,
                  TA_RIGHT | TA_VCENTER);
      }
    }
  }
  if (IS_SHOW_VALUE)
    FontSet(fontname, fontsize, fontflags, fontangle);
}

void CHistogramChart::DrawBar(const int x, const int y, const int w,
                              const int h, const uint clr) {

  if (!m_gradient || ArraySize(m_fill_brush) < w)
    FillRectangle(x + 1, y + 1, w - x - 2, h - y - 2, clr);
  else {
    for (int i = 1; i < h; i++)
      ArrayCopy(m_pixels, m_fill_brush, (y + i) * m_width + x + 1, 0, w);
  }

  if (m_bar_border != 0)
    Rectangle(x, y, x + w - 1, y + h - 1, m_color_border);
}

void CHistogramChart::GradientBrush(const int size, const uint fill_clr) {

  if (m_gradient) {

    int r = size;

    if (r < 1)
      return;
    if (r != ArrayResize(m_fill_brush, r))
      return;

    ArrayInitialize(m_fill_brush, m_color_background);

    int f = 1 - r;
    int dd_x = 1;
    int dd_y = -2 * r;
    int dx = 0;
    int dy = r;
    int i1, i2;
    uint clr, dclr;

    i1 = i2 = r >> 1;
    if ((r & 1) == 0)
      i1--;

    while (dy >= dx) {
      clr = fill_clr;
      dclr =
          GETRGB(XRGB((r - dy) * GETRGBR(clr) / r, (r - dy) * GETRGBG(clr) / r,
                      (r - dy) * GETRGBB(clr) / r));
      clr -= dclr;
      m_fill_brush[i1] = clr;
      m_fill_brush[i2] = clr;

      if (f >= 0) {
        dy--;
        dd_y += 2;
        f += dd_y;
      }
      dx++;
      if (--i1 < 0)
        break;
      i2++;
      dd_x += 2;
      f += dd_x;
    }
  } else
    ArrayFree(m_fill_brush);
}

#endif
