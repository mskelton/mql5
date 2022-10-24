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

  virtual int Type(void) const;
};

class CChartObjectStdDevChannel : public CChartObjectTrend {
public:
  CChartObjectStdDevChannel(void);
  ~CChartObjectStdDevChannel(void);

  double Deviations(void) const;
  bool Deviations(const double deviation) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const datetime time2,
              const double deviation);

  virtual int Type(void) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

class CChartObjectRegression : public CChartObjectTrend {
public:
  CChartObjectRegression(void);
  ~CChartObjectRegression(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const datetime time2);

  virtual int Type(void) const;
};

class CChartObjectPitchfork : public CChartObjectTrend {
public:
  CChartObjectPitchfork(void);
  ~CChartObjectPitchfork(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const;
};

#endif
