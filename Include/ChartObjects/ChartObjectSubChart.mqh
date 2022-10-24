#ifndef CHART_OBJECT_SUB_CHART_H
#define CHART_OBJECT_SUB_CHART_H

#include "ChartObject.mqh"

class CChartObjectSubChart : public CChartObject {
public:
  CChartObjectSubChart(void);
  ~CChartObjectSubChart(void);

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y, const int sizeX, const int sizeY);

  virtual int Type(void) const ;

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

  datetime Time(const int point) const ;
  bool Time(const int point, const datetime time) const ;
  double Price(const int point) const ;
  bool Price(const int point, const double price) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};


























#endif
