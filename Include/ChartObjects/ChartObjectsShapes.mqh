#ifndef CHART_OBJECTS_SHAPES_H
#define CHART_OBJECTS_SHAPES_H

#include "ChartObject.mqh"

class CChartObjectRectangle : public CChartObject {
public:
  CChartObjectRectangle(void);
  ~CChartObjectRectangle(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2);

  virtual int Type(void) const;
};

class CChartObjectTriangle : public CChartObject {
public:
  CChartObjectTriangle(void);
  ~CChartObjectTriangle(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const;
};

class CChartObjectEllipse : public CChartObject {
public:
  CChartObjectEllipse(void);
  ~CChartObjectEllipse(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const;
};

#endif
