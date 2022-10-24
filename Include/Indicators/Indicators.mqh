#ifndef INDICATORS_H
#define INDICATORS_H

#include "BillWilliams.mqh"
#include "Custom.mqh"
#include "Oscilators.mqh"
#include "TimeSeries.mqh"
#include "Trend.mqh"
#include "Volumes.mqh"

class CIndicators : public CArrayObj {
protected:
  MqlDateTime m_prev_time;

public:
  CIndicators(void);
  ~CIndicators(void);

  CIndicator *Create(const string symbol, const ENUM_TIMEFRAMES period,
                     const ENUM_INDICATOR type, const int count,
                     const MqlParam params[]);
  bool BufferResize(const int size);

  int Refresh(void);

protected:
  int TimeframesFlags(const MqlDateTime &time);
};







#endif
