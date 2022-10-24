#ifndef CHART_OBJECTS_GANN_H
#define CHART_OBJECTS_GANN_H

#include "ChartObjectsLines.mqh"

class CChartObjectGannLine : public CChartObjectTrendByAngle {
public:
  CChartObjectGannLine(void);
  ~CChartObjectGannLine(void);

  double PipsPerBar(void) const;
  bool PipsPerBar(const double ppb) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double ppb);

  virtual int Type(void) const {
    return (OBJ_GANNLINE);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectGannLine::CChartObjectGannLine(void) {}

CChartObjectGannLine::~CChartObjectGannLine(void) {}

bool CChartObjectGannLine::Create(long chart_id, const string name,
                                  const int window, const datetime time1,
                                  const double price1, const datetime time2,
                                  const double ppb) {
  if (!ObjectCreate(chart_id, name, OBJ_GANNLINE, window, time1, price1, time2,
                    0.0))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);
  if (!PipsPerBar(ppb))
    return (false);

  return (true);
}

double CChartObjectGannLine::PipsPerBar(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE));
}

bool CChartObjectGannLine::PipsPerBar(const double ppb) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE, ppb));
}

bool CChartObjectGannLine::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectTrend::Save(file_handle))
    return (false);

  if (FileWriteDouble(file_handle,
                      ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE)) !=
      sizeof(double))
    return (false);

  return (true);
}

bool CChartObjectGannLine::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectTrend::Load(file_handle))
    return (false);

  if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE,
                       FileReadDouble(file_handle)))
    return (false);

  return (true);
}

class CChartObjectGannFan : public CChartObjectTrend {
public:
  CChartObjectGannFan(void);
  ~CChartObjectGannFan(void);

  double PipsPerBar(void) const;
  bool PipsPerBar(const double ppb) const;
  bool Downtrend(void) const;
  bool Downtrend(const bool downtrend) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double ppb);

  virtual int Type(void) const {
    return (OBJ_GANNFAN);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectGannFan::CChartObjectGannFan(void) {}

CChartObjectGannFan::~CChartObjectGannFan(void) {}

bool CChartObjectGannFan::Create(long chart_id, const string name,
                                 const int window, const datetime time1,
                                 const double price1, const datetime time2,
                                 const double ppb) {
  if (!ObjectCreate(chart_id, name, OBJ_GANNFAN, window, time1, price1, time2,
                    0.0))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);
  if (!PipsPerBar(ppb))
    return (false);

  return (true);
}

double CChartObjectGannFan::PipsPerBar(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE));
}

bool CChartObjectGannFan::PipsPerBar(const double ppb) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE, ppb));
}

bool CChartObjectGannFan::Downtrend(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DIRECTION));
}

bool CChartObjectGannFan::Downtrend(const bool downtrend) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_DIRECTION, downtrend));
}

bool CChartObjectGannFan::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectTrend::Save(file_handle))
    return (false);

  if (FileWriteDouble(file_handle,
                      ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE)) !=
      sizeof(double))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DIRECTION),
          CHAR_VALUE) != sizeof(char))
    return (false);

  return (true);
}

bool CChartObjectGannFan::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectTrend::Load(file_handle))
    return (false);

  if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE,
                       FileReadDouble(file_handle)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_DIRECTION,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  return (true);
}

class CChartObjectGannGrid : public CChartObjectTrend {
public:
  CChartObjectGannGrid(void);
  ~CChartObjectGannGrid(void);

  double PipsPerBar(void) const;
  bool PipsPerBar(const double ppb) const;
  bool Downtrend(void) const;
  bool Downtrend(const bool downtrend) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double ppb);

  virtual int Type(void) const {
    return (OBJ_GANNGRID);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectGannGrid::CChartObjectGannGrid(void) {}

CChartObjectGannGrid::~CChartObjectGannGrid(void) {}

bool CChartObjectGannGrid::Create(long chart_id, const string name,
                                  const int window, const datetime time1,
                                  const double price1, const datetime time2,
                                  const double ppb) {
  if (!ObjectCreate(chart_id, name, OBJ_GANNGRID, window, time1, price1, time2,
                    0.0))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);
  if (!PipsPerBar(ppb))
    return (false);

  return (true);
}

double CChartObjectGannGrid::PipsPerBar(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE));
}

bool CChartObjectGannGrid::PipsPerBar(const double ppb) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE, ppb));
}

bool CChartObjectGannGrid::Downtrend(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DIRECTION));
}

bool CChartObjectGannGrid::Downtrend(const bool downtrend) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_DIRECTION, downtrend));
}

bool CChartObjectGannGrid::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectTrend::Save(file_handle))
    return (false);

  if (FileWriteDouble(file_handle,
                      ObjectGetDouble(m_chart_id, m_name, OBJPROP_SCALE)) !=
      sizeof(double))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_DIRECTION),
          CHAR_VALUE) != sizeof(char))
    return (false);

  return (true);
}

bool CChartObjectGannGrid::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectTrend::Load(file_handle))
    return (false);

  if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_SCALE,
                       FileReadDouble(file_handle)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_DIRECTION,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  return (true);
}

#endif
