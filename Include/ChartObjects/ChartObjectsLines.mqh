#ifndef CHART_OBJECTS_LINES_H
#define CHART_OBJECTS_LINES_H

#include "ChartObject.mqh"

class CChartObjectVLine : public CChartObject {
public:
  CChartObjectVLine(void);
  ~CChartObjectVLine(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time);

  virtual int Type(void) const ;
};




class CChartObjectHLine : public CChartObject {
public:
  CChartObjectHLine(void);
  ~CChartObjectHLine(void);

  bool Create(long chart_id, const string name, const int window,
              const double price);

  virtual int Type(void) const ;
};




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

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};










class CChartObjectTrendByAngle : public CChartObjectTrend {
public:
  CChartObjectTrendByAngle(void);
  ~CChartObjectTrendByAngle(void);

  double Angle(void) const;
  bool Angle(const double angle) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const ;
};






class CChartObjectCycles : public CChartObject {
public:
  CChartObjectCycles(void);
  ~CChartObjectCycles(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const ;
};




#endif
