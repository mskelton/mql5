#ifndef CHART_OBJECTS_ELLIOTT_H
#define CHART_OBJECTS_ELLIOTT_H

#include "ChartObject.mqh"

class CChartObjectElliottWave3 : public CChartObject {
public:
  CChartObjectElliottWave3(void);
  ~CChartObjectElliottWave3(void);

  ENUM_ELLIOT_WAVE_DEGREE Degree(void) const;
  bool Degree(const ENUM_ELLIOT_WAVE_DEGREE degree) const;
  bool Lines(void) const;
  bool Lines(const bool lines) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const {
    return (OBJ_ELLIOTWAVE3);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectElliottWave3::CChartObjectElliottWave3(void) {}

CChartObjectElliottWave3::~CChartObjectElliottWave3(void) {}

bool CChartObjectElliottWave3::Create(long chart_id, const string name,
                                      const int window, const datetime time1,
                                      const double price1, const datetime time2,
                                      const double price2, const datetime time3,
                                      const double price3) {
  if (!ObjectCreate(chart_id, name, OBJ_ELLIOTWAVE3, window, time1, price1,
                    time2, price2, time3, price3))
    return (false);
  if (!Attach(chart_id, name, window, 3))
    return (false);

  return (true);
}

ENUM_ELLIOT_WAVE_DEGREE CChartObjectElliottWave3::Degree(void) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);

  return ((ENUM_ELLIOT_WAVE_DEGREE)ObjectGetInteger(m_chart_id, m_name,
                                                    OBJPROP_DEGREE));
}

bool CChartObjectElliottWave3::Degree(
    const ENUM_ELLIOT_WAVE_DEGREE degree) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_DEGREE, degree));
}

bool CChartObjectElliottWave3::Lines(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DRAWLINES));
}

bool CChartObjectElliottWave3::Lines(const bool lines) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_DRAWLINES, lines));
}

bool CChartObjectElliottWave3::Save(const int file_handle) {
  bool result;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  result = CChartObject::Save(file_handle);
  if (result) {

    if (FileWriteInteger(
            file_handle,
            (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DEGREE),
            INT_VALUE) != sizeof(int))
      return (false);

    if (FileWriteInteger(
            file_handle,
            (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DRAWLINES),
            INT_VALUE) != sizeof(int))
      return (false);
  }

  return (result);
}

bool CChartObjectElliottWave3::Load(const int file_handle) {
  bool result;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  result = CChartObject::Load(file_handle);
  if (result) {

    if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_DEGREE,
                          FileReadInteger(file_handle, INT_VALUE)))
      return (false);

    if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_DRAWLINES,
                          FileReadInteger(file_handle, INT_VALUE)))
      return (false);
  }

  return (result);
}

class CChartObjectElliottWave5 : public CChartObjectElliottWave3 {
public:
  CChartObjectElliottWave5(void);
  ~CChartObjectElliottWave5(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3,
              const datetime time4, const double price4, const datetime time5,
              const double price5);

  virtual int Type(void) const {
    return (OBJ_ELLIOTWAVE5);
  }
};

CChartObjectElliottWave5::CChartObjectElliottWave5(void) {}

CChartObjectElliottWave5::~CChartObjectElliottWave5(void) {}

bool CChartObjectElliottWave5::Create(long chart_id, const string name,
                                      const int window, const datetime time1,
                                      const double price1, const datetime time2,
                                      const double price2, const datetime time3,
                                      const double price3, const datetime time4,
                                      const double price4, const datetime time5,
                                      const double price5) {
  if (!ObjectCreate(chart_id, name, OBJ_ELLIOTWAVE5, window, time1, price1,
                    time2, price2, time3, price3, time4, price4, time5, price5))
    return (false);
  if (!Attach(chart_id, name, window, 5))
    return (false);

  return (true);
}

#endif
