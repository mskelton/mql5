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

  virtual int Type(void) const {
    return (0x8888);
  }

  long ChartId(void) const {
    return (m_chart_id);
  }
  int Window(void) const {
    return (m_window);
  }
  string Name(void) const {
    return (m_name);
  }
  bool Name(const string name);
  int NumPoints(void) const {
    return (m_num_points);
  }

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

CChartObject::CChartObject(void) {

  Detach();
}

CChartObject::~CChartObject(void) {
  if (m_chart_id != -1)
    ObjectDelete(m_chart_id, m_name);
}

bool CChartObject::Name(const string name) {

  if (m_chart_id == -1)
    return (false);

  if (ObjectSetString(m_chart_id, m_name, OBJPROP_NAME, name)) {
    m_name = name;
    return (true);
  }

  return (false);
};

bool CChartObject::Attach(long chart_id, const string name, const int window,
                          const int points) {

  if (ObjectFind(chart_id, name) < 0)
    return (false);

  if (chart_id == 0)
    chart_id = ChartID();
  m_chart_id = chart_id;
  m_window = window;
  m_name = name;
  m_num_points = points;

  return (true);
}

bool CChartObject::SetPoint(const int point, const datetime time,
                            const double price) const {

  if (m_chart_id == -1)
    return (false);
  if (point >= m_num_points)
    return (false);

  return (ObjectMove(m_chart_id, m_name, point, time, price));
}

bool CChartObject::Delete(void) {

  if (m_chart_id == -1)
    return (false);

  bool result = ObjectDelete(m_chart_id, m_name);
  Detach();

  return (result);
}

void CChartObject::Detach(void) {
  m_chart_id = -1;
  m_window = -1;
  m_name = NULL;
  m_num_points = 0;
}

datetime CChartObject::Time(const int point) const {

  if (m_chart_id == -1)
    return (0);
  if (point >= m_num_points)
    return (0);

  return ((datetime)ObjectGetInteger(m_chart_id, m_name, OBJPROP_TIME, point));
}

bool CChartObject::Time(const int point, const datetime time) const {

  if (m_chart_id == -1)
    return (false);
  if (point >= m_num_points)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_TIME, point, time));
}

double CChartObject::Price(const int point) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);
  if (point >= m_num_points)
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_PRICE, point));
}

bool CChartObject::Price(const int point, const double price) const {

  if (m_chart_id == -1)
    return (false);
  if (point >= m_num_points)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_PRICE, point, price));
}

color CChartObject::Color(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ObjectGetInteger(m_chart_id, m_name, OBJPROP_COLOR));
}

bool CChartObject::Color(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_COLOR, new_color));
}

ENUM_LINE_STYLE CChartObject::Style(void) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);

  return ((ENUM_LINE_STYLE)ObjectGetInteger(m_chart_id, m_name, OBJPROP_STYLE));
}

bool CChartObject::Style(const ENUM_LINE_STYLE new_style) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_STYLE, new_style));
}

int CChartObject::Width(void) const {

  if (m_chart_id == -1)
    return (-1);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_WIDTH));
}

bool CChartObject::Width(const int new_width) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_WIDTH, new_width));
}

bool CChartObject::Background(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_BACK));
}

bool CChartObject::Background(const bool new_back) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_BACK, new_back));
}

bool CChartObject::Fill(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_FILL));
}

bool CChartObject::Fill(const bool new_fill) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_FILL, new_fill));
}

long CChartObject::Z_Order(void) const {

  if (m_chart_id == -1)
    return (0);

  return (ObjectGetInteger(m_chart_id, m_name, OBJPROP_ZORDER));
}

bool CChartObject::Z_Order(const long value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_ZORDER, value));
}

bool CChartObject::Selected(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_SELECTED));
}

bool CChartObject::Selected(const bool new_sel) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_SELECTED, new_sel));
}

bool CChartObject::Selectable(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_SELECTABLE));
}

bool CChartObject::Selectable(const bool new_sel) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_SELECTABLE, new_sel));
}

string CChartObject::Description(void) const {

  if (m_chart_id == -1)
    return ("");

  return (ObjectGetString(m_chart_id, m_name, OBJPROP_TEXT));
}

bool CChartObject::Description(const string new_text) const {

  if (m_chart_id == -1)
    return (false);

  if (new_text == "")
    return (ObjectSetString(m_chart_id, m_name, OBJPROP_TEXT, " "));

  return (ObjectSetString(m_chart_id, m_name, OBJPROP_TEXT, new_text));
}

string CChartObject::Tooltip(void) const {

  if (m_chart_id == -1)
    return ("");

  return (ObjectGetString(m_chart_id, m_name, OBJPROP_TOOLTIP));
}

bool CChartObject::Tooltip(const string new_text) const {

  if (m_chart_id == -1)
    return (false);

  if (new_text == "")
    return (ObjectSetString(m_chart_id, m_name, OBJPROP_TOOLTIP, " "));

  return (ObjectSetString(m_chart_id, m_name, OBJPROP_TOOLTIP, new_text));
}

int CChartObject::Timeframes(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_TIMEFRAMES));
}

bool CChartObject::Timeframes(const int timeframes) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_TIMEFRAMES, timeframes));
}

datetime CChartObject::CreateTime(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((datetime)ObjectGetInteger(m_chart_id, m_name, OBJPROP_CREATETIME));
}

int CChartObject::LevelsCount(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_LEVELS));
}

bool CChartObject::LevelsCount(const int new_count) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_LEVELS, new_count));
}

color CChartObject::LevelColor(const int level) const {

  if (m_chart_id == -1)
    return (CLR_NONE);
  if (level >= LevelsCount())
    return (CLR_NONE);

  return (
      (color)ObjectGetInteger(m_chart_id, m_name, OBJPROP_LEVELCOLOR, level));
}

bool CChartObject::LevelColor(const int level, const color new_color) const {

  if (m_chart_id == -1)
    return (false);
  if (level >= LevelsCount())
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_LEVELCOLOR, level,
                           new_color));
}

ENUM_LINE_STYLE CChartObject::LevelStyle(const int level) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);
  if (level >= LevelsCount())
    return (WRONG_VALUE);

  return ((ENUM_LINE_STYLE)ObjectGetInteger(m_chart_id, m_name,
                                            OBJPROP_LEVELSTYLE, level));
}

bool CChartObject::LevelStyle(const int level,
                              const ENUM_LINE_STYLE new_style) const {

  if (m_chart_id == -1)
    return (false);
  if (level >= LevelsCount())
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_LEVELSTYLE, level,
                           new_style));
}

int CChartObject::LevelWidth(const int level) const {

  if (m_chart_id == -1)
    return (-1);
  if (level >= LevelsCount())
    return (-1);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_LEVELWIDTH, level));
}

bool CChartObject::LevelWidth(const int level, const int new_width) const {

  if (m_chart_id == -1)
    return (false);
  if (level >= LevelsCount())
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_LEVELWIDTH, level,
                           new_width));
}

double CChartObject::LevelValue(const int level) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);
  if (level >= LevelsCount())
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_LEVELVALUE, level));
}

bool CChartObject::LevelValue(const int level, const double new_value) const {

  if (m_chart_id == -1)
    return (false);
  if (level >= LevelsCount())
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_LEVELVALUE, level,
                          new_value));
}

string CChartObject::LevelDescription(const int level) const {

  if (m_chart_id == -1)
    return ("");
  if (level >= LevelsCount())
    return ("");

  return (ObjectGetString(m_chart_id, m_name, OBJPROP_LEVELTEXT, level));
}

bool CChartObject::LevelDescription(const int level,
                                    const string new_text) const {

  if (m_chart_id == -1)
    return (false);
  if (level >= LevelsCount())
    return (false);

  return (
      ObjectSetString(m_chart_id, m_name, OBJPROP_LEVELTEXT, level, new_text));
}

long CChartObject::GetInteger(const ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                              const int modifier) const {

  if (m_chart_id == -1)
    return (0);

  if (modifier == -1)
    return (ObjectGetInteger(m_chart_id, m_name, prop_id));

  return (ObjectGetInteger(m_chart_id, m_name, prop_id, modifier));
}

bool CChartObject::GetInteger(const ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                              const int modifier, long &value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectGetInteger(m_chart_id, m_name, prop_id, modifier, value));
}

bool CChartObject::SetInteger(const ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                              const int modifier, const long value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, prop_id, modifier, value));
}

bool CChartObject::SetInteger(const ENUM_OBJECT_PROPERTY_INTEGER prop_id,
                              const long value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, prop_id, value));
}

double CChartObject::GetDouble(const ENUM_OBJECT_PROPERTY_DOUBLE prop_id,
                               const int modifier) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  if (modifier == -1)
    return (ObjectGetDouble(m_chart_id, m_name, prop_id));

  return (ObjectGetDouble(m_chart_id, m_name, prop_id, modifier));
}

bool CChartObject::GetDouble(const ENUM_OBJECT_PROPERTY_DOUBLE prop_id,
                             const int modifier, double &value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectGetDouble(m_chart_id, m_name, prop_id, modifier, value));
}

bool CChartObject::SetDouble(const ENUM_OBJECT_PROPERTY_DOUBLE prop_id,
                             const int modifier, const double value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, prop_id, modifier, value));
}

bool CChartObject::SetDouble(const ENUM_OBJECT_PROPERTY_DOUBLE prop_id,
                             const double value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, prop_id, value));
}

string CChartObject::GetString(const ENUM_OBJECT_PROPERTY_STRING prop_id,
                               const int modifier) const {

  if (m_chart_id == -1)
    return ("");

  if (modifier == -1)
    return (ObjectGetString(m_chart_id, m_name, prop_id));

  return (ObjectGetString(m_chart_id, m_name, prop_id, modifier));
}

bool CChartObject::GetString(const ENUM_OBJECT_PROPERTY_STRING prop_id,
                             const int modifier, string &value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectGetString(m_chart_id, m_name, prop_id, modifier, value));
}

bool CChartObject::SetString(const ENUM_OBJECT_PROPERTY_STRING prop_id,
                             const int modifier, const string value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetString(m_chart_id, m_name, prop_id, modifier, value));
}

bool CChartObject::SetString(const ENUM_OBJECT_PROPERTY_STRING prop_id,
                             const string value) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetString(m_chart_id, m_name, prop_id, value));
}

bool CChartObject::ShiftObject(const datetime d_time,
                               const double d_price) const {
  bool result = true;
  int i;

  if (m_chart_id == -1)
    return (false);

  for (i = 0; i < m_num_points; i++)
    result &= ShiftPoint(i, d_time, d_price);

  return (result);
}

bool CChartObject::ShiftPoint(const int point, const datetime d_time,
                              const double d_price) const {

  if (m_chart_id == -1)
    return (false);
  if (point >= m_num_points)
    return (false);

  datetime time =
      (datetime)ObjectGetInteger(m_chart_id, m_name, OBJPROP_TIME, point);
  double price = ObjectGetDouble(m_chart_id, m_name, OBJPROP_PRICE, point);

  return (
      ObjectMove(m_chart_id, m_name, point, time + d_time, price + d_price));
}

bool CChartObject::Save(const int file_handle) {
  int i, len;
  int levels;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (FileWriteLong(file_handle, -1) != sizeof(long))
    return (false);

  if (FileWriteInteger(file_handle, Type(), INT_VALUE) != INT_VALUE)
    return (false);

  str = ObjectGetString(m_chart_id, m_name, OBJPROP_NAME);
  len = StringLen(str);
  if (FileWriteInteger(file_handle, len, INT_VALUE) != INT_VALUE)
    return (false);
  if (len != 0)
    if (FileWriteString(file_handle, str, len) != len)
      return (false);

  if (FileWriteLong(file_handle,
                    ObjectGetInteger(m_chart_id, m_name, OBJPROP_COLOR)) !=
      sizeof(long))
    return (false);

  if (FileWriteInteger(file_handle, (int)ObjectGetInteger(m_chart_id, m_name,
                                                          OBJPROP_STYLE)) !=
      sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle, (int)ObjectGetInteger(m_chart_id, m_name,
                                                          OBJPROP_WIDTH)) !=
      sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_BACK),
                       CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_SELECTABLE),
          CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_TIMEFRAMES),
          INT_VALUE) != sizeof(int))
    return (false);

  str = ObjectGetString(m_chart_id, m_name, OBJPROP_TEXT);
  len = StringLen(str);
  if (FileWriteInteger(file_handle, len, INT_VALUE) != INT_VALUE)
    return (false);
  if (len != 0)
    if (FileWriteString(file_handle, str, len) != len)
      return (false);

  if (FileWriteInteger(file_handle, m_num_points, INT_VALUE) != INT_VALUE)
    return (false);

  for (i = 0; i < m_num_points; i++) {
    if (FileWriteLong(file_handle,
                      ObjectGetInteger(m_chart_id, m_name, OBJPROP_TIME, i)) !=
        sizeof(long))
      return (false);
    if (FileWriteDouble(file_handle, ObjectGetDouble(m_chart_id, m_name,
                                                     OBJPROP_PRICE, i)) !=
        sizeof(double))
      return (false);
  }

  levels = (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_LEVELS);
  if (FileWriteInteger(file_handle, levels, INT_VALUE) != INT_VALUE)
    return (false);

  for (i = 0; i < levels; i++) {

    if (FileWriteLong(file_handle, ObjectGetInteger(m_chart_id, m_name,
                                                    OBJPROP_LEVELCOLOR, i)) !=
        sizeof(long))
      return (false);

    if (FileWriteInteger(file_handle, (int)ObjectGetInteger(m_chart_id, m_name,
                                                            OBJPROP_LEVELSTYLE,
                                                            i)) != sizeof(int))
      return (false);

    if (FileWriteInteger(file_handle, (int)ObjectGetInteger(m_chart_id, m_name,
                                                            OBJPROP_LEVELWIDTH,
                                                            i)) != sizeof(int))
      return (false);

    if (FileWriteDouble(file_handle, ObjectGetDouble(m_chart_id, m_name,
                                                     OBJPROP_LEVELVALUE, i)) !=
        sizeof(double))
      return (false);

    str = ObjectGetString(m_chart_id, m_name, OBJPROP_LEVELTEXT, i);
    len = StringLen(str);
    if (FileWriteInteger(file_handle, len, INT_VALUE) != INT_VALUE)
      return (false);
    if (len != 0)
      if (FileWriteString(file_handle, str, len) != len)
        return (false);
  }

  return (true);
}

bool CChartObject::Load(const int file_handle) {
  int i, len, num;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (FileReadLong(file_handle) != -1)
    return (false);

  if (FileReadInteger(file_handle, INT_VALUE) != Type())
    return (false);

  len = FileReadInteger(file_handle, INT_VALUE);
  str = (len != 0) ? FileReadString(file_handle, len) : "";
  if (!ObjectSetString(m_chart_id, m_name, OBJPROP_NAME, str))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_COLOR,
                        FileReadLong(file_handle)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_STYLE,
                        FileReadInteger(file_handle)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_WIDTH,
                        FileReadInteger(file_handle)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_BACK,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_SELECTABLE,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_TIMEFRAMES,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  len = FileReadInteger(file_handle, INT_VALUE);
  str = (len != 0) ? FileReadString(file_handle, len) : "";
  if (!ObjectSetString(m_chart_id, m_name, OBJPROP_TEXT, str))
    return (false);

  num = FileReadInteger(file_handle, INT_VALUE);

  if (num != 0) {
    for (i = 0; i < num; i++) {
      if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_TIME, i,
                            FileReadLong(file_handle)))
        return (false);
      if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_PRICE, i,
                           FileReadDouble(file_handle)))
        return (false);
    }
  }

  num = FileReadInteger(file_handle, INT_VALUE);
  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_LEVELS, 0, num))
    return (false);

  if (num != 0) {
    for (i = 0; i < num; i++) {

      if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_LEVELCOLOR, i,
                            FileReadLong(file_handle)))
        return (false);

      if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_LEVELSTYLE, i,
                            FileReadInteger(file_handle)))
        return (false);

      if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_LEVELWIDTH, i,
                            FileReadInteger(file_handle)))
        return (false);

      if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_LEVELVALUE, i,
                           FileReadDouble(file_handle)))
        return (false);

      len = FileReadInteger(file_handle, INT_VALUE);
      str = (len != 0) ? FileReadString(file_handle, len) : "";
      if (!ObjectSetString(m_chart_id, m_name, OBJPROP_LEVELTEXT, i, str))
        return (false);
    }
  }

  return (true);
}

#endif
