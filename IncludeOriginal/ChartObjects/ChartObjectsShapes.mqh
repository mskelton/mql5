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

  virtual int Type(void) const {
    return (OBJ_RECTANGLE);
  }
};

CChartObjectRectangle::CChartObjectRectangle(void) {
}

CChartObjectRectangle::~CChartObjectRectangle(void) {
}

bool CChartObjectRectangle::Create(long chart_id, const string name,
                                   const int window, const datetime time1,
                                   const double price1, const datetime time2,
                                   const double price2) {
  if (!ObjectCreate(chart_id, name, OBJ_RECTANGLE, window, time1, price1, time2,
                    price2))
    return (false);
  if (!Attach(chart_id, name, window, 2))
    return (false);

  return (true);
}

class CChartObjectTriangle : public CChartObject {
public:
  CChartObjectTriangle(void);
  ~CChartObjectTriangle(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const {
    return (OBJ_TRIANGLE);
  }
};

CChartObjectTriangle::CChartObjectTriangle(void) {
}

CChartObjectTriangle::~CChartObjectTriangle(void) {
}

bool CChartObjectTriangle::Create(long chart_id, const string name,
                                  const int window, const datetime time1,
                                  const double price1, const datetime time2,
                                  const double price2, const datetime time3,
                                  const double price3) {
  if (!ObjectCreate(chart_id, name, OBJ_TRIANGLE, window, time1, price1, time2,
                    price2, time3, price3))
    return (false);
  if (!Attach(chart_id, name, window, 3))
    return (false);

  return (true);
}

class CChartObjectEllipse : public CChartObject {
public:
  CChartObjectEllipse(void);
  ~CChartObjectEllipse(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const {
    return (OBJ_ELLIPSE);
  }
};

CChartObjectEllipse::CChartObjectEllipse(void) {
}

CChartObjectEllipse::~CChartObjectEllipse(void) {
}

bool CChartObjectEllipse::Create(long chart_id, const string name,
                                 const int window, const datetime time1,
                                 const double price1, const datetime time2,
                                 const double price2, const datetime time3,
                                 const double price3) {
  if (!ObjectCreate(chart_id, name, OBJ_ELLIPSE, window, time1, price1, time2,
                    price2, time3, price3))
    return (false);
  if (!Attach(chart_id, name, window, 3))
    return (false);

  return (true);
}

#endif
