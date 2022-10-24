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

  virtual int Type(void) const ;
};




class CChartObjectFiboTimes : public CChartObject {
public:
  CChartObjectFiboTimes(void);
  ~CChartObjectFiboTimes(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const ;
};




class CChartObjectFiboFan : public CChartObject {
public:
  CChartObjectFiboFan(void);
  ~CChartObjectFiboFan(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const ;
};




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

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};










class CChartObjectFiboChannel : public CChartObjectTrend {
public:
  CChartObjectFiboChannel(void);
  ~CChartObjectFiboChannel(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const ;
};




class CChartObjectFiboExpansion : public CChartObjectTrend {
public:
  CChartObjectFiboExpansion(void);
  ~CChartObjectFiboExpansion(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const ;
};




#endif
