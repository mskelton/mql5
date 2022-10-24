#ifndef CHART_OBJECTS_CHANNELS_H
#define CHART_OBJECTS_CHANNELS_H

#include "ChartObjectsLines.mqh"

class CChartObjectChannel : public CChartObjectTrend {
public:
  CChartObjectChannel(void);
  ~CChartObjectChannel(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const {
    return (OBJ_CHANNEL);
  }
};

CChartObjectChannel::CChartObjectChannel(void) {
}

CChartObjectChannel::~CChartObjectChannel(void) {
}

bool CChartObjectChannel::Create(long chart_id, const string name,
                                 const int window, const datetime time1,
                                 const double price1, const datetime time2,
                                 const double price2, const datetime time3,
                                 const double price3) {
  if (!ObjectCreate(chart_id, name, OBJ_CHANNEL, window, time1, price1, time2,
                    price2, time3, price3))
    return (false);
  if (!Attach(chart_id, name, window, 3))
    return (false);

  return (true);
}

class CChartObjectStdDevChannel : public CChartObjectTrend {
public:
  CChartObjectStdDevChannel(void);
  ~CChartObjectStdDevChannel(void);

  double Deviations(void) const;
  bool Deviations(const double deviation) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const datetime time2,
              const double deviation);

  virtual int Type(void) const {
    return (OBJ_STDDEVCHANNEL);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectStdDevChannel::CChartObjectStdDevChannel(void) {
}

CChartObjectStdDevChannel::~CChartObjectStdDevChannel(void) {
}

bool CChartObjectStdDevChannel::Create(long chart_id, const string name,
                                       const int window, const datetime time1,
                                       const datetime time2,
                                       const double deviation) {
  if (!ObjectCreate(chart_id, name, OBJ_STDDEVCHANNEL, window, time1, 0.0,
                    time2, 0.0))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);
  if (!Deviations(deviation))
    return (false);

  return (true);
}

double CChartObjectStdDevChannel::Deviations(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_DEVIATION));
}

bool CChartObjectStdDevChannel::Deviations(const double deviation) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_DEVIATION, deviation));
}

bool CChartObjectStdDevChannel::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectTrend::Save(file_handle))
    return (false);

  if (FileWriteDouble(file_handle,
                      ObjectGetDouble(m_chart_id, m_name, OBJPROP_DEVIATION)) !=
      sizeof(double))
    return (false);

  return (true);
}

bool CChartObjectStdDevChannel::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectTrend::Load(file_handle))
    return (false);

  if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_DEVIATION,
                       FileReadDouble(file_handle)))
    return (false);

  return (true);
}

class CChartObjectRegression : public CChartObjectTrend {
public:
  CChartObjectRegression(void);
  ~CChartObjectRegression(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const datetime time2);

  virtual int Type(void) const {
    return (OBJ_REGRESSION);
  }
};

CChartObjectRegression::CChartObjectRegression(void) {
}

CChartObjectRegression::~CChartObjectRegression(void) {
}

bool CChartObjectRegression::Create(long chart_id, const string name,
                                    const int window, const datetime time1,
                                    const datetime time2) {
  if (!ObjectCreate(chart_id, name, OBJ_REGRESSION, window, time1, 0.0, time2,
                    0.0))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);

  return (true);
}

class CChartObjectPitchfork : public CChartObjectTrend {
public:
  CChartObjectPitchfork(void);
  ~CChartObjectPitchfork(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const {
    return (OBJ_CHANNEL);
  }
};

CChartObjectPitchfork::CChartObjectPitchfork(void) {
}

CChartObjectPitchfork::~CChartObjectPitchfork(void) {
}

bool CChartObjectPitchfork::Create(long chart_id, const string name,
                                   const int window, const datetime time1,
                                   const double price1, const datetime time2,
                                   const double price2, const datetime time3,
                                   const double price3) {
  if (!ObjectCreate(chart_id, name, OBJ_PITCHFORK, window, time1, price1, time2,
                    price2, time3, price3))
    return (false);
  if (!Attach(chart_id, name, window, 3))
    return (false);

  return (true);
}

#endif
