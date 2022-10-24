#ifndef CHART_OBJECT_SUB_CHART_H
#define CHART_OBJECT_SUB_CHART_H

#include "ChartObject.mqh"

class CChartObjectSubChart : public CChartObject {
public:
  CChartObjectSubChart(void);
  ~CChartObjectSubChart(void);

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y, const int sizeX, const int sizeY);

  virtual int Type(void) const {
    return (OBJ_CHART);
  }

  int X_Distance(void) const;
  bool X_Distance(const int X) const;
  int Y_Distance(void) const;
  bool Y_Distance(const int Y) const;
  ENUM_BASE_CORNER Corner(void) const;
  bool Corner(const ENUM_BASE_CORNER corner) const;
  int X_Size(void) const;
  bool X_Size(const int size) const;
  int Y_Size(void) const;
  bool Y_Size(const int size) const;
  string Symbol(void) const;
  bool Symbol(const string symbol) const;
  int Period(void) const;
  bool Period(const int period) const;
  int Scale(void) const;
  bool Scale(const int scale) const;
  bool DateScale(void) const;
  bool DateScale(const bool scale) const;
  bool PriceScale(void) const;
  bool PriceScale(const bool scale) const;

  datetime Time(const int point) const {
    return (CChartObject::Time(point));
  }
  bool Time(const int point, const datetime time) const {
    return (false);
  }
  double Price(const int point) const {
    return (CChartObject::Price(point));
  }
  bool Price(const int point, const double price) const {
    return (false);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectSubChart::CChartObjectSubChart(void) {}

CChartObjectSubChart::~CChartObjectSubChart(void) {}

bool CChartObjectSubChart::Create(long chart_id, const string name,
                                  const int window, const int X, const int Y,
                                  const int sizeX, const int sizeY) {
  if (!ObjectCreate(chart_id, name, OBJ_CHART, window, 0, 0, 0))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);
  if (!X_Distance(X) || !Y_Distance(Y))
    return (false);
  if (!X_Size(sizeX) || !Y_Size(sizeY))
    return (false);

  return (true);
}

int CChartObjectSubChart::X_Distance(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE));
}

bool CChartObjectSubChart::X_Distance(const int X) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE, X));
}

int CChartObjectSubChart::Y_Distance(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE));
}

bool CChartObjectSubChart::Y_Distance(const int Y) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE, Y));
}

ENUM_BASE_CORNER CChartObjectSubChart::Corner(void) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);

  return (
      (ENUM_BASE_CORNER)ObjectGetInteger(m_chart_id, m_name, OBJPROP_CORNER));
}

bool CChartObjectSubChart::Corner(const ENUM_BASE_CORNER corner) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_CORNER, corner));
}

int CChartObjectSubChart::X_Size(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XSIZE));
}

bool CChartObjectSubChart::X_Size(const int size) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_XSIZE, size));
}

int CChartObjectSubChart::Y_Size(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YSIZE));
}

bool CChartObjectSubChart::Y_Size(const int size) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_YSIZE, size));
}

string CChartObjectSubChart::Symbol(void) const {

  if (m_chart_id == -1)
    return ("");

  return (ObjectGetString(m_chart_id, m_name, OBJPROP_SYMBOL));
}

bool CChartObjectSubChart::Symbol(const string symbol) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetString(m_chart_id, m_name, OBJPROP_SYMBOL, symbol));
}

int CChartObjectSubChart::Period(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_PERIOD));
}

bool CChartObjectSubChart::Period(const int period) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_PERIOD, period));
}

int CChartObjectSubChart::Scale(void) const {

  if (m_chart_id == -1)
    return (-1);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_CHART_SCALE));
}

bool CChartObjectSubChart::Scale(const int scale) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_CHART_SCALE, scale));
}

bool CChartObjectSubChart::DateScale(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DATE_SCALE));
}

bool CChartObjectSubChart::DateScale(const bool scale) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_DATE_SCALE, scale));
}

bool CChartObjectSubChart::PriceScale(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_PRICE_SCALE));
}

bool CChartObjectSubChart::PriceScale(const bool scale) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_PRICE_SCALE, scale));
}

bool CChartObjectSubChart::Save(const int file_handle) {
  int len;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Save(file_handle))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE),
          INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE),
          INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_CORNER),
          INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XSIZE),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YSIZE),
                       INT_VALUE) != sizeof(int))
    return (false);

  str = ObjectGetString(m_chart_id, m_name, OBJPROP_SYMBOL);
  len = StringLen(str);
  if (FileWriteInteger(file_handle, len, INT_VALUE) != INT_VALUE)
    return (false);
  if (len != 0 && FileWriteString(file_handle, str, len) != len)
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_PERIOD),
          INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteDouble(file_handle,
                      ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE)) !=
      sizeof(double))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DATE_SCALE),
          CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_PRICE_SCALE),
          CHAR_VALUE) != sizeof(char))
    return (false);

  return (true);
}

bool CChartObjectSubChart::Load(const int file_handle) {
  int len;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Load(file_handle))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_CORNER,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_XSIZE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_YSIZE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  len = FileReadInteger(file_handle, INT_VALUE);
  str = (len != 0) ? FileReadString(file_handle, len) : "";
  if (!ObjectSetString(m_chart_id, m_name, OBJPROP_SYMBOL, str))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_PERIOD,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE,
                       FileReadDatetime(file_handle)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_DATE_SCALE,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_PRICE_SCALE,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  return (true);
}

#endif
