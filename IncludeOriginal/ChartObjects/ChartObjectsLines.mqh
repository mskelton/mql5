#ifndef CHART_OBJECTS_LINES_H
#define CHART_OBJECTS_LINES_H

#include "ChartObject.mqh"

class CChartObjectVLine : public CChartObject {
public:
  CChartObjectVLine(void);
  ~CChartObjectVLine(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time);

  virtual int Type(void) const {
    return (OBJ_VLINE);
  }
};

CChartObjectVLine::CChartObjectVLine(void) {
}

CChartObjectVLine::~CChartObjectVLine(void) {
}

bool CChartObjectVLine::Create(long chart_id, const string name,
                               const int window, const datetime time) {
  if (!ObjectCreate(chart_id, name, OBJ_VLINE, window, time, 0.0))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectHLine : public CChartObject {
public:
  CChartObjectHLine(void);
  ~CChartObjectHLine(void);

  bool Create(long chart_id, const string name, const int window,
              const double price);

  virtual int Type(void) const {
    return (OBJ_HLINE);
  }
};

CChartObjectHLine::CChartObjectHLine(void) {
}

CChartObjectHLine::~CChartObjectHLine(void) {
}

bool CChartObjectHLine::Create(long chart_id, const string name,
                               const int window, const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_HLINE, window, 0, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectTrend : public CChartObject {
public:
  CChartObjectTrend(void);
  ~CChartObjectTrend(void);

  bool RayLeft(void) const;
  bool RayLeft(const bool new_sel) const;
  bool RayRight(void) const;
  bool RayRight(const bool new_sel) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const {
    return (OBJ_TREND);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectTrend::CChartObjectTrend(void) {
}

CChartObjectTrend::~CChartObjectTrend(void) {
}

bool CChartObjectTrend::Create(long chart_id, const string name,
                               const int window, const datetime time1,
                               const double price1, const datetime time2,
                               const double price2) {
  if (!ObjectCreate(chart_id, name, OBJ_TREND, window, time1, price1, time2,
                    price2))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);

  return (true);
}

bool CChartObjectTrend::RayLeft(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_RAY_LEFT));
}

bool CChartObjectTrend::RayLeft(const bool new_ray) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_RAY_LEFT, new_ray));
}

bool CChartObjectTrend::RayRight(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_RAY_RIGHT));
}

bool CChartObjectTrend::RayRight(const bool new_ray) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_RAY_RIGHT, new_ray));
}

bool CChartObjectTrend::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Save(file_handle))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_RAY_LEFT),
          CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_RAY_RIGHT),
          CHAR_VALUE) != sizeof(char))
    return (false);

  return (true);
}

bool CChartObjectTrend::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Load(file_handle))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_RAY_LEFT,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_RAY_RIGHT,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  return (true);
}

class CChartObjectTrendByAngle : public CChartObjectTrend {
public:
  CChartObjectTrendByAngle(void);
  ~CChartObjectTrendByAngle(void);

  double Angle(void) const;
  bool Angle(const double angle) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const {
    return (OBJ_TRENDBYANGLE);
  }
};

CChartObjectTrendByAngle::CChartObjectTrendByAngle(void) {
}

CChartObjectTrendByAngle::~CChartObjectTrendByAngle(void) {
}

bool CChartObjectTrendByAngle::Create(long chart_id, const string name,
                                      const int window, const datetime time1,
                                      const double price1, const datetime time2,
                                      const double price2) {
  if (!ObjectCreate(chart_id, name, OBJ_TRENDBYANGLE, window, time1, price1,
                    time2, price2))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);

  return (true);
}

double CChartObjectTrendByAngle::Angle(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_ANGLE));
}

bool CChartObjectTrendByAngle::Angle(const double angle) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_ANGLE, angle));
}

class CChartObjectCycles : public CChartObject {
public:
  CChartObjectCycles(void);
  ~CChartObjectCycles(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const {
    return (OBJ_CYCLES);
  }
};

CChartObjectCycles::CChartObjectCycles(void) {
}

CChartObjectCycles::~CChartObjectCycles(void) {
}

bool CChartObjectCycles::Create(long chart_id, const string name,
                                const int window, const datetime time1,
                                const double price1, const datetime time2,
                                const double price2) {
  if (!ObjectCreate(chart_id, name, OBJ_CYCLES, window, time1, price1, time2,
                    price2))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);

  return (true);
}

#endif
