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

  virtual int Type(void) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

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

  virtual int Type(void) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

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

  virtual int Type(void) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

#endif
