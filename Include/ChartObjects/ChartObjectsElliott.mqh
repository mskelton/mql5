#ifndef CHART_OBJECTS_ELLIOTT_H
#define CHART_OBJECTS_ELLIOTT_H

#include "ChartObject.mqh"

class CChartObjectElliottWave3 : public CChartObject {
public:
  CChartObjectElliottWave3(void);
  ~CChartObjectElliottWave3(void);

  ENUM_ELLIOT_WAVE_DEGREE Degree(void) const;
  bool Degree(const ENUM_ELLIOT_WAVE_DEGREE degree) const;
  bool Lines(void) const;
  bool Lines(const bool lines) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3);

  virtual int Type(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};










class CChartObjectElliottWave5 : public CChartObjectElliottWave3 {
public:
  CChartObjectElliottWave5(void);
  ~CChartObjectElliottWave5(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time1, const double price1, const datetime time2,
              const double price2, const datetime time3, const double price3,
              const datetime time4, const double price4, const datetime time5,
              const double price5);

  virtual int Type(void) const ;
};




#endif
