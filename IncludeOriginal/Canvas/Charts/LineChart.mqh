#ifndef LINE_CHART_H
#define LINE_CHART_H

#include "ChartCanvas.mqh"
#include <Arrays\ArrayObj.mqh>

class CLineChart : public CChartCanvas {
private:
  CArrayObj *m_values;

  bool m_filled;

public:
  CLineChart(void);
  ~CLineChart(void);

  virtual bool Create(const string name, const int width, const int height,
                      ENUM_COLOR_FORMAT clrfmt = COLOR_FORMAT_ARGB_NORMALIZE);

  void Filled(const bool flag = true) {
    m_filled = flag;
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
  virtual void DrawChart(void);
  virtual void DrawData(const uint index = 0);

private:
  double CalcArea(const uint index);
};

CLineChart::CLineChart(void) : m_filled(false) {
  ShowFlags(FLAG_SHOW_LEGEND | FLAGS_SHOW_SCALES | FLAG_SHOW_GRID);
}

CLineChart::~CLineChart(void) {
}

bool CLineChart::Create(const string name, const int width, const int height,
                        ENUM_COLOR_FORMAT clrfmt) {

  if ((m_values = new CArrayObj) == NULL)
    return (false);

  m_data = m_values;

  if (!CChartCanvas::Create(name, width, height, clrfmt))
    return (false);

  return (true);
}

bool CLineChart::SeriesAdd(const double &value[], const string descr,
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

bool CLineChart::SeriesInsert(const uint pos, const double &value[],
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

bool CLineChart::SeriesUpdate(const uint pos, const double &value[],
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

bool CLineChart::SeriesDelete(const uint pos) {

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

bool CLineChart::ValueUpdate(const uint series, const uint pos, double value) {
  CArrayDouble *data = m_values.At(series);

  if (data == NULL)
    return (false);

  if (!data.Update(pos, value))
    return (false);

  Redraw();

  return (true);
}

void CLineChart::DrawChart(void) {
  if (m_filled) {

    double s[];
    ArrayResize(s, m_data_total);
    ArrayInitialize(s, 0);
    for (uint i = 0; i < m_data_total; i++) {
      CArrayDouble *data = m_values.At(i);
      if (data == NULL)
        continue;
      int total = data.Total();
      if (total <= 1)
        continue;
      s[i] = CalcArea(i);
    }
    int index = ArrayMaximum(s);
    while (index != -1 && s[index] != 0.0) {

      DrawData(index);
      s[index] = 0.0;
      index = ArrayMaximum(s);
    }
  } else
    for (uint i = 0; i < m_data_total; i++)
      DrawData(i);
}

void CLineChart::DrawData(const uint index) {
  double value = 0.0;

  CArrayDouble *data = m_values.At(index);
  if (data == NULL)
    return;
  int total = data.Total();
  if (total <= 1)
    return;

  int dx = m_data_area.Width() / (total - 1);
  int x = m_data_area.left + 1;
  int y1 = 0;
  int y2 = (int)(m_y_0 - data[0] * m_scale_y);

  for (int i = 1; i < total; i++, x += dx) {
    y1 = y2;
    double val = data[i];
    if (val == EMPTY_VALUE)
      continue;
    if (m_accumulative)
      value += val;
    else
      value = val;
    y2 = (int)(m_y_0 - value * m_scale_y);
    if (m_filled) {
      if ((y1 > m_y_0 && y2 < m_y_0) || (y1 < m_y_0 && y2 > m_y_0)) {

        int x3;
        if (y1 > y2) {
          x3 = x + dx * (y1 - m_y_0) / (y1 - y2);
          FillTriangle(x, y1, x3, m_y_0, x, m_y_0, (uint)m_colors[index]);
          FillTriangle(x + dx, y2, x3, m_y_0, x + dx, m_y_0,
                       (uint)m_colors[index]);
        } else {
          x3 = x + dx * (m_y_0 - y1) / (y2 - y1);
          FillTriangle(x, y1, x3, m_y_0, x, m_y_0, (uint)m_colors[index]);
          FillTriangle(x + dx, y2, x3, m_y_0, x + dx, m_y_0,
                       (uint)m_colors[index]);
        }
        continue;
      }
      if (y1 < m_y_0 || y2 < m_y_0) {
        if (y1 > y2)
          FillTriangle(x, y1, x + dx, y2, x + dx, y1, (uint)m_colors[index]);
        if (y1 < y2) {
          FillTriangle(x, y1, x + dx, y2, x, y2, (uint)m_colors[index]);
          y1 = y2;
        }
      }
      if (y1 > m_y_0 || y2 > m_y_0) {
        if (y1 < y2)
          FillTriangle(x, y1, x + dx, y2, x + dx, y1, (uint)m_colors[index]);
        if (y1 > y2) {
          FillTriangle(x, y1, x + dx, y2, x, y2, (uint)m_colors[index]);
          y1 = y2;
        }
      }
      FillRectangle(x, m_y_0, x + dx, y1, (uint)m_colors[index]);
    } else
      LineAA(x, y1, x + dx, y2, (uint)m_colors[index], STYLE_SOLID);
  }
}

double CLineChart::CalcArea(const uint index) {
  double area = 0;
  double value = 0;
  int dx = 100;

  CArrayDouble *data = m_values.At(index);
  if (data == NULL)
    return (0);
  int total = data.Total();
  if (total <= 1)
    return (0);
  int y1 = 0;
  int y2 = (int)(m_y_0 - data[0] * m_scale_y);
  for (int i = 0; i < total; i++) {
    y1 = y2;
    double val = data[i];
    if (val == EMPTY_VALUE)
      continue;
    if (m_accumulative)
      value += val;
    else
      value = val;
    y2 = (int)(m_y_0 - value * m_scale_y);
    if ((y1 > m_y_0 && y2 < m_y_0) || (y1 < m_y_0 && y2 > m_y_0)) {

      int x;
      if (y1 > y2) {

        x = dx * (y1 - m_y_0) / (y1 - y2);

        area += x * (y1 - m_y_0) / 2;

        area += (dx - x) * (m_y_0 - y2) / 2;
      } else {

        x = dx * (m_y_0 - y1) / (y2 - y1);

        area += x * (m_y_0 - y1) / 2;

        area += (dx - x) * (y2 - m_y_0) / 2;
      }
      continue;
    }
    if (y1 < m_y_0 || y2 < m_y_0) {

      if (y1 > y2) {

        area += dx * (y1 - y2) / 2;

        area += dx * (m_y_0 - y2);
      }
      if (y1 < y2) {

        area += dx * (y2 - y1) / 2;

        area += dx * (m_y_0 - y1);
      }
    }
    if (y1 > m_y_0 || y2 > m_y_0) {

      if (y1 < y2) {

        area += dx * (y2 - y1) / 2;

        area += dx * (y1 - m_y_0);
      }
      if (y1 > y2) {

        area += dx * (y1 - y2) / 2;

        area += dx * (y2 - m_y_0);
      }
    }
  }

  return (area);
}

#endif
