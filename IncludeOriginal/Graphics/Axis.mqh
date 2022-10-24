#ifndef AXIS_H
#define AXIS_H

typedef string (*DoubleToStringFunction)(double, void *);

enum ENUM_AXIS_TYPE {
  AXIS_TYPE_DOUBLE,
  AXIS_TYPE_DATETIME,
  AXIS_TYPE_CUSTOM,
};

class CAxis {
private:
  double m_min;
  double m_max;
  double m_step;
  uint m_clr;
  string m_name;
  int m_name_size;
  int m_values_size;
  int m_values_width;
  string m_values_format;
  string m_values_fontname;
  uint m_values_fontflags;
  uint m_values_fontangle;
  bool m_auto_scale;
  double m_zero_lever;
  double m_default_step;
  double m_max_labels;
  double m_min_grace;
  double m_max_grace;
  int m_values_dt_mode;
  DoubleToStringFunction m_values_func;
  void *m_values_cbdata;
  ENUM_AXIS_TYPE m_type;

public:
  CAxis(void);
  ~CAxis(void);

  double Step(void) const {
    return (m_step);
  }
  double Min(void) const {
    return (m_min);
  }
  void Min(const double min) {
    m_min = min;
  }
  double Max(void) const {
    return (m_max);
  }
  void Max(const double max) {
    m_max = max;
  }
  string Name(void) const {
    return (m_name);
  }
  void Name(const string name) {
    m_name = name;
  }
  ENUM_AXIS_TYPE Type(void) const {
    return (m_type);
  }
  void Type(ENUM_AXIS_TYPE type) {
    m_type = type;
  }

  uint Color(void) const {
    return (m_clr);
  }
  void Color(const uint clr) {
    m_clr = clr;
  }
  bool AutoScale(void) const {
    return (m_auto_scale);
  }
  void AutoScale(const bool auto) {
    m_auto_scale = auto;
  }
  int ValuesSize(void) const {
    return (m_values_size);
  }
  void ValuesSize(const int size) {
    m_values_size = size;
  }
  int ValuesWidth(void) const {
    return (m_values_width);
  }
  void ValuesWidth(const int width) {
    m_values_width = width;
  }
  string ValuesFormat(void) const {
    return (m_values_format);
  }
  void ValuesFormat(const string format) {
    m_values_format = format;
  }
  int ValuesDateTimeMode(void) const {
    return (m_values_dt_mode);
  }
  void ValuesDateTimeMode(const int mode) {
    m_values_dt_mode = mode;
  }
  DoubleToStringFunction ValuesFunctionFormat(void) const {
    return (m_values_func);
  }
  void ValuesFunctionFormat(DoubleToStringFunction func) {
    m_values_func = func;
  }
  void *ValuesFunctionFormatCBData(void) const {
    return (m_values_cbdata);
  }
  void ValuesFunctionFormatCBData(void *cbdata) {
    m_values_cbdata = cbdata;
  }
  string ValuesFontName(void) const {
    return (m_values_fontname);
  }
  void ValuesFontName(const string fontname) {
    m_values_fontname = fontname;
  }
  uint ValuesFontAngle(void) const {
    return (m_values_fontangle);
  }
  void ValuesFontAngle(const uint fontangle) {
    m_values_fontangle = fontangle;
  }
  uint ValuesFontFlags(void) const {
    return (m_values_fontflags);
  }
  void ValuesFontFlags(const uint fontflags) {
    m_values_fontflags = fontflags;
  }
  int NameSize(void) const {
    return (m_name_size);
  }
  void NameSize(const int size) {
    m_name_size = size;
  }
  double ZeroLever(void) const {
    return (m_zero_lever);
  }
  void ZeroLever(const double value) {
    m_zero_lever = value;
  }
  double DefaultStep(void) const {
    return (m_default_step);
  }
  void DefaultStep(const double value) {
    m_default_step = value;
  }
  double MaxLabels(void) const {
    return (m_max_labels);
  }
  void MaxLabels(const double value) {
    m_max_labels = value;
  }
  double MinGrace(void) const {
    return (m_min_grace);
  }
  void MinGrace(const double value) {
    m_min_grace = value;
  }
  double MaxGrace(void) const {
    return (m_max_grace);
  }
  void MaxGrace(const double value) {
    m_max_grace = value;
  }

  void SelectAxisScale(void);

private:
  void ExtensionBoundaries(void);
  double CalcStepSize(const double range, const double steps);
  double Mod(const double x, const double y);
  double CalcBoundedStepSize(const double range, const double max_steps);
};

CAxis::CAxis(void)
    : m_auto_scale(true), m_zero_lever(0.25), m_default_step(25.0),
      m_max_labels(15), m_min_grace(0.01), m_max_grace(0.01), m_clr(clrBlack),
      m_name_size(0), m_values_size(12), m_values_fontname("arial"),
      m_values_fontflags(0), m_values_fontangle(0), m_values_func(NULL),
      m_values_cbdata(NULL), m_values_dt_mode(TIME_MINUTES),
      m_type(AXIS_TYPE_DOUBLE), m_values_width(30) {}

CAxis::~CAxis(void) {}

void CAxis::SelectAxisScale(void) {
  if (m_min > m_max)
    m_max = m_min;
  if (!m_auto_scale) {
    if (m_max <= m_min)
      ExtensionBoundaries();
    m_step = ((m_max - m_min) > m_default_step && m_default_step > 0)
                 ? m_default_step
                 : m_max - m_min;
    return;
  }
  ExtensionBoundaries();

  if (m_max - m_min < 1.0e-30) {
    m_max = m_max + 0.2 * (m_max == 0 ? 1.0 : MathAbs(m_max));
    m_min = m_min - 0.2 * (m_min == 0 ? 1.0 : MathAbs(m_min));
  }

  if (m_min > 0 && m_min / (m_max - m_min) < m_zero_lever)
    m_min = 0;

  if (m_max < 0 && MathAbs(m_max / (m_max - m_min)) < m_zero_lever)
    m_max = 0;

  double target_step = (m_default_step != 0) ? m_default_step : m_max - m_min;

  m_step = CalcStepSize(m_max - m_min, target_step);
  double labels = MathCeil((m_max - m_min) / m_step);
  if (m_max_labels < labels && m_max_labels > 0)
    m_step = CalcBoundedStepSize(m_max - m_min, m_max_labels);
  else
    m_step = CalcBoundedStepSize(m_max - m_min, labels);

  m_min = m_min - Mod(m_min, m_step);

  m_max =
      Mod(m_max, m_step) == 0.0 ? m_max : m_max + m_step - Mod(m_max, m_step);
}

void CAxis::ExtensionBoundaries(void) {
  double range = m_max - m_min;

  if (m_min < 0 || m_min - m_min_grace * range >= 0.0)
    m_min = m_min - m_min_grace * range;

  if (m_max > 0 || m_max + m_max_grace * range <= 0.0)
    m_max = m_max + m_max_grace * range;

  if (m_max == m_min) {
    if (MathAbs(m_max) > 1e-100) {
      m_max *= (m_min < 0 ? 0.95 : 1.05);
      m_min *= (m_min < 0 ? 1.05 : 0.95);
    } else {
      m_max = 1.0;
      m_min = -1.0;
    }
  }
}

double CAxis::CalcStepSize(const double range, const double steps) {

  double temp = range / steps;

  double mag = MathFloor(MathLog10(temp));
  double magPow = MathPow(10.0, mag);

  double magMsd = NormalizeDouble(temp / magPow + .5, 0);

  if (magMsd > 5.0)
    magMsd = 10.0;
  else if (magMsd > 2.0)
    magMsd = 5.0;
  else if (magMsd > 1.0)
    magMsd = 2.0;

  return (magMsd * magPow);
}

double CAxis::Mod(const double x, const double y) {

  if (y == 0)
    return (0);

  return (x > 0) ? MathMod(x, y) : MathMod(x, y) + y;
}

double CAxis::CalcBoundedStepSize(const double range, const double max_steps) {

  double temp = range / max_steps;

  double mag = MathFloor(MathLog10(temp));
  double magPow = MathPow((double)10.0, mag);

  double magMsd = MathCeil(temp / magPow);

  if (magMsd > 5.0)
    magMsd = 10.0;
  else if (magMsd > 2.0)
    magMsd = 5.0;
  else if (magMsd > 1.0)
    magMsd = 2.0;

  return (magMsd * magPow);
}

#endif
