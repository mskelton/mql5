#ifndef CHART_OBJECT_H
#define CHART_OBJECT_H

#include <Object.mqh>

class CChartObject : public CObject {
protected:
  long m_chart_id;
  int m_window;
  string m_name;
  int m_num_points;

public:
  CChartObject(void);
  ~CChartObject(void);

  virtual int Type(void) const ;

  long ChartId(void) const ;
  int Window(void) const ;
  string Name(void) const ;
  bool Name(const string name);
  int NumPoints(void) const ;

  bool Attach(long chart_id, const string name, const int window,
              const int points);
  bool SetPoint(const int point, const datetime time, const double price) const;

  bool Delete(void);
  void Detach(void);

  datetime Time(const int point) const;
  bool Time(const int point, const datetime time) const;
  double Price(const int point) const;
  bool Price(const int point, const double price) const;
  color Color(void) const;
  bool Color(const color new_color) const;
  ENUM_LINE_STYLE Style(void) const;
  bool Style(const ENUM_LINE_STYLE new_style) const;
  int Width(void) const;
  bool Width(const int new_width) const;
  bool Background(void) const;
  bool Background(const bool new_back) const;
  bool Fill(void) const;
  bool Fill(const bool new_fill) const;
  long Z_Order(void) const;
  bool Z_Order(const long value) const;
  bool Selected(void) const;
  bool Selected(const bool new_sel) const;
  bool Selectable(void) const;
  bool Selectable(const bool new_sel) const;
  string Description(void) const;
  bool Description(const string new_text) const;
  string Tooltip(void) const;
  bool Tooltip(const string new_text) const;
  int Timeframes(void) const;
  virtual bool Timeframes(const int timeframes) const;
  datetime CreateTime(void) const;
  int LevelsCount(void) const;
  bool LevelsCount(const int new_count) const;

  color LevelColor(const int level) const;
  bool LevelColor(const int level, const color new_color) const;
  ENUM_LINE_STYLE LevelStyle(const int level) const;
  bool LevelStyle(const int level, const ENUM_LINE_STYLE new_style) const;
  int LevelWidth(const int level) const;
  bool LevelWidth(const int level, const int new_width) const;
  double LevelValue(const int level) const;
  bool LevelValue(const int level, const double new_value) const;
  string LevelDescription(const int level) const;
  bool LevelDescription(const int level, const string new_text) const;

  long GetInteger(const ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                  const int modifier = -1) const;
  bool GetInteger(const ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                  const int modifier, long &value) const;
  bool SetInteger(const ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                  const int modifier, const long value) const;
  bool SetInteger(const ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                  const long value) const;
  double GetDouble(const ENUM_OBJECT_PROPERTY_DOUBLE prop_id,
                   const int modifier = -1) const;
  bool GetDouble(const ENUM_OBJECT_PROPERTY_DOUBLE prop_id, const int modifier,
                 double &value) const;
  bool SetDouble(const ENUM_OBJECT_PROPERTY_DOUBLE prop_id, const int modifier,
                 const double value) const;
  bool SetDouble(const ENUM_OBJECT_PROPERTY_DOUBLE prop_id,
                 const double value) const;
  string GetString(const ENUM_OBJECT_PROPERTY_STRING prop_id,
                   const int modifier = -1) const;
  bool GetString(const ENUM_OBJECT_PROPERTY_STRING prop_id, const int modifier,
                 string &value) const;
  bool SetString(const ENUM_OBJECT_PROPERTY_STRING prop_id, const int modifier,
                 const string value) const;
  bool SetString(const ENUM_OBJECT_PROPERTY_STRING prop_id,
                 const string value) const;

  bool ShiftObject(const datetime d_time, const double d_price) const;
  bool ShiftPoint(const int point, const datetime d_time,
                  const double d_price) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};































































#endif
