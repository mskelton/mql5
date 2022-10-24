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

  double Step(void) const ;
  double Min(void) const ;
  void Min(const double min) ;
  double Max(void) const ;
  void Max(const double max) ;
  string Name(void) const ;
  void Name(const string name) ;
  ENUM_AXIS_TYPE Type(void) const ;
  void Type(ENUM_AXIS_TYPE type) ;

  uint Color(void) const ;
  void Color(const uint clr) ;
  bool AutoScale(void) const ;
  void AutoScale(const bool auto) ;
  int ValuesSize(void) const ;
  void ValuesSize(const int size) ;
  int ValuesWidth(void) const ;
  void ValuesWidth(const int width) ;
  string ValuesFormat(void) const ;
  void ValuesFormat(const string format) ;
  int ValuesDateTimeMode(void) const ;
  void ValuesDateTimeMode(const int mode) ;
  DoubleToStringFunction ValuesFunctionFormat(void) const ;
  void ValuesFunctionFormat(DoubleToStringFunction func) ;
  void *ValuesFunctionFormatCBData(void) const ;
  void ValuesFunctionFormatCBData(void *cbdata) ;
  string ValuesFontName(void) const ;
  void ValuesFontName(const string fontname) ;
  uint ValuesFontAngle(void) const ;
  void ValuesFontAngle(const uint fontangle) ;
  uint ValuesFontFlags(void) const ;
  void ValuesFontFlags(const uint fontflags) ;
  int NameSize(void) const ;
  void NameSize(const int size) ;
  double ZeroLever(void) const ;
  void ZeroLever(const double value) ;
  double DefaultStep(void) const ;
  void DefaultStep(const double value) ;
  double MaxLabels(void) const ;
  void MaxLabels(const double value) ;
  double MinGrace(void) const ;
  void MinGrace(const double value) ;
  double MaxGrace(void) const ;
  void MaxGrace(const double value) ;

  void SelectAxisScale(void);

private:
  void ExtensionBoundaries(void);
  double CalcStepSize(const double range, const double steps);
  double Mod(const double x, const double y);
  double CalcBoundedStepSize(const double range, const double max_steps);
};








#endif
