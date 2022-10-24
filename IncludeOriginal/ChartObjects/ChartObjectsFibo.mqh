#ifndef CHART_OBJECTS_FIBO_H
#define CHART_OBJECTS_FIBO_H

#include "ChartObjectsLines.mqh"

class CChartObjectFibo : public CChartObjectTrend {
public:
  CChartObjectFibo(void);
  ~CChartObjectFibo(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const {
    return (OBJ_FIBO);
  }
};

CChartObjectFibo::CChartObjectFibo(void) {
}

CChartObjectFibo::~CChartObjectFibo(void) {
}

bool CChartObjectFibo::Create(long chart_id, const string name,
                              const int window, const datetime time1,
                              const double price1, const datetime time2,
                              const double price2) {
  if (!ObjectCreate(chart_id, name, OBJ_FIBO, window, time1, price1, time2,
                    price2))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);

  return (true);
}

class CChartObjectFiboTimes : public CChartObject {
public:
  CChartObjectFiboTimes(void);
  ~CChartObjectFiboTimes(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const {
    return (OBJ_FIBOTIMES);
  }
};

CChartObjectFiboTimes::CChartObjectFiboTimes(void) {
}

CChartObjectFiboTimes::~CChartObjectFiboTimes(void) {
}

bool CChartObjectFiboTimes::Create(long chart_id, const string name,
                                   const int window, const datetime time1,
                                   const double price1, const datetime time2,
                                   const double price2) {
  if (!ObjectCreate(chart_id, name, OBJ_FIBOTIMES, window, time1, price1, time2,
                    price2))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);

  return (true);
}

class CChartObjectFiboFan : public CChartObject {
public:
  CChartObjectFiboFan(void);
  ~CChartObjectFiboFan(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const {
    return (OBJ_FIBOFAN);
  }
};

CChartObjectFiboFan::CChartObjectFiboFan(void) {
}

CChartObjectFiboFan::~CChartObjectFiboFan(void) {
}

bool CChartObjectFiboFan::Create(long chart_id, const string name,
                                 const int window, const datetime time1,
                                 const double price1, const datetime time2,
                                 const double price2) {
  if (!ObjectCreate(chart_id, name, OBJ_FIBOFAN, window, time1, price1, time2,
                    price2))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);

  return (true);
}

class CChartObjectFiboArc : public CChartObject {
public:
  CChartObjectFiboArc(void);
  ~CChartObjectFiboArc(void);

  double Scale(void) const;
  bool Scale(const double scale) const;
  bool Ellipse(void) const;
  bool Ellipse(const bool ellipse) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const double scale);

  virtual int Type(void) const {
    return (OBJ_FIBOARC);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectFiboArc::CChartObjectFiboArc(void) {
}

CChartObjectFiboArc::~CChartObjectFiboArc(void) {
}

bool CChartObjectFiboArc::Create(long chart_id, const string name,
                                 const int window, const datetime time1,
                                 const double price1, const datetime time2,
                                 const double price2, const double scale) {
  if (!ObjectCreate(chart_id, name, OBJ_FIBOARC, window, time1, price1, time2,
                    price2))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);
  if (!Scale(scale))
    return (false);

  return (true);
}

double CChartObjectFiboArc::Scale(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE));
}

bool CChartObjectFiboArc::Scale(const double scale) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE, scale));
}

bool CChartObjectFiboArc::Ellipse(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ELLIPSE));
}

bool CChartObjectFiboArc::Ellipse(const bool ellipse) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_ELLIPSE, ellipse));
}

bool CChartObjectFiboArc::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Save(file_handle))
    return (false);

  if (FileWriteDouble(file_handle,
                      ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE)) !=
      sizeof(double))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ELLIPSE),
          CHAR_VALUE) != sizeof(char))
    return (false);

  return (true);
}

bool CChartObjectFiboArc::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Load(file_handle))
    return (false);

  if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE,
                       FileReadDouble(file_handle)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_ELLIPSE,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  return (true);
}

class CChartObjectFiboChannel : public CChartObjectTrend {
public:
  CChartObjectFiboChannel(void);
  ~CChartObjectFiboChannel(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const {
    return (OBJ_FIBOCHANNEL);
  }
};

CChartObjectFiboChannel::CChartObjectFiboChannel(void) {
}

CChartObjectFiboChannel::~CChartObjectFiboChannel(void) {
}

bool CChartObjectFiboChannel::Create(long chart_id, const string name,
                                     const int window, const datetime time1,
                                     const double price1, const datetime time2,
                                     const double price2, const datetime time3,
                                     const double price3) {
  if (!ObjectCreate(chart_id, name, OBJ_FIBOCHANNEL, window, time1, price1,
                    time2, price2, time3, price3))
    return (false);
  if (!Attach(chart_id, name, window, 3))
    return (false);

  return (true);
}

class CChartObjectFiboExpansion : public CChartObjectTrend {
public:
  CChartObjectFiboExpansion(void);
  ~CChartObjectFiboExpansion(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const {
    return (OBJ_EXPANSION);
  }
};

CChartObjectFiboExpansion::CChartObjectFiboExpansion(void) {
}

CChartObjectFiboExpansion::~CChartObjectFiboExpansion(void) {
}

bool CChartObjectFiboExpansion::Create(
    long chart_id, const string name, const int window, const datetime time1,
    const double price1, const datetime time2, const double price2,
    const datetime time3, const double price3) {
  if (!ObjectCreate(chart_id, name, OBJ_EXPANSION, window, time1, price1, time2,
                    price2, time3, price3))
    return (false);
  if (!Attach(chart_id, name, window, 3))
    return (false);

  return (true);
}

#endif
