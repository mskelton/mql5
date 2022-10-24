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
                     const MqlParam &params[]);
  bool BufferResize(const int size);

  int Refresh(void);

protected:
  int TimeframesFlags(const MqlDateTime &time);
};

CIndicators::CIndicators(void) {
  m_prev_time.min = -1;
}

CIndicators::~CIndicators(void) {
}

CIndicator *CIndicators::Create(const string symbol,
                                const ENUM_TIMEFRAMES period,
                                const ENUM_INDICATOR type, const int count,
                                const MqlParam &params[]) {
  CIndicator *result = NULL;

  switch (type) {
  case IND_AC:

    if (count == 0)
      result = new CiAC;
    break;
  case IND_AD:

    if (count == 1)
      result = new CiAD;
    break;
  case IND_ALLIGATOR:

    if (count == 8)
      result = new CiAlligator;
    break;
  case IND_ADX:

    if (count == 1)
      result = new CiADX;
    break;
  case IND_ADXW:

    if (count == 1)
      result = new CiADXWilder;
    break;
  case IND_ATR:

    if (count == 1)
      result = new CiATR;
    break;
  case IND_AO:

    if (count == 0)
      result = new CiAO;
    break;
  case IND_BEARS:

    if (count == 1)
      result = new CiBearsPower;
    break;
  case IND_BANDS:

    if (count == 4)
      result = new CiBands;
    break;
  case IND_BULLS:

    if (count == 1)
      result = new CiBullsPower;
    break;
  case IND_CCI:

    if (count == 2)
      result = new CiCCI;
    break;
  case IND_CHAIKIN:

    if (count == 4)
      result = new CiChaikin;
    break;
  case IND_DEMARKER:

    if (count == 1)
      result = new CiDeMarker;
    break;
  case IND_ENVELOPES:

    if (count == 5)
      result = new CiEnvelopes;
    break;
  case IND_FORCE:

    if (count == 3)
      result = new CiForce;
    break;
  case IND_FRACTALS:

    if (count == 0)
      result = new CiFractals;
    break;
  case IND_GATOR:

    if (count == 8)
      result = new CiGator;
    break;
  case IND_ICHIMOKU:

    if (count == 3)
      result = new CiIchimoku;
    break;
  case IND_MACD:

    if (count == 4)
      result = new CiMACD;
    break;
  case IND_BWMFI:

    if (count == 1)
      result = new CiBWMFI;
    break;
  case IND_MOMENTUM:

    if (count == 2)
      result = new CiMomentum;
    break;
  case IND_MFI:

    if (count == 2)
      result = new CiMFI;
    break;
  case IND_MA:

    if (count == 4)
      result = new CiMA;
    break;
  case IND_OSMA:

    if (count == 4)
      result = new CiOsMA;
    break;
  case IND_OBV:

    if (count == 1)
      result = new CiOBV;
    break;
  case IND_SAR:

    if (count == 2)
      result = new CiSAR;
    break;
  case IND_RSI:

    if (count == 2)
      result = new CiRSI;
    break;
  case IND_RVI:

    if (count == 1)
      result = new CiRVI;
    break;
  case IND_STDDEV:

    if (count == 4)
      result = new CiStdDev;
    break;
  case IND_STOCHASTIC:

    if (count == 5)
      result = new CiStochastic;
    break;
  case IND_WPR:

    if (count == 1)
      result = new CiWPR;
    break;
  case IND_DEMA:

    if (count == 3)
      result = new CiDEMA;
    break;
  case IND_TEMA:

    if (count == 3)
      result = new CiTEMA;
    break;
  case IND_TRIX:

    if (count == 2)
      result = new CiTriX;
    break;
  case IND_FRAMA:

    if (count == 3)
      result = new CiFrAMA;
    break;
  case IND_AMA:

    if (count == 5)
      result = new CiAMA;
    break;
  case IND_VIDYA:

    if (count == 4)
      result = new CiVIDyA;
    break;
  case IND_VOLUMES:

    if (count == 1)
      result = new CiVolumes;
    break;

  case IND_CUSTOM:
    if (count > 0)
      result = new CiCustom;
    break;
  }
  if (result != NULL) {
    if (result.Create(symbol, period, type, count, params))
      Add(result);
    else {
      delete result;
      result = NULL;
    }
  }

  return (result);
}

bool CIndicators::BufferResize(const int size) {
  int total = Total();
  for (int i = 0; i < total; i++) {
    CSeries *series = At(i);

    if (series == NULL)
      return (false);
    if (!series.BufferResize(size))
      return (false);
  }

  return (true);
}

int CIndicators::Refresh(void) {
  MqlDateTime time;
  TimeCurrent(time);

  int flags = TimeframesFlags(time);
  int total = Total();

  for (int i = 0; i < total; i++) {
    CSeries *indicator = At(i);
    if (indicator != NULL)
      indicator.Refresh(flags);
  }

  m_prev_time = time;

  return (flags);
}

int CIndicators::TimeframesFlags(const MqlDateTime &time) {

  int result = OBJ_ALL_PERIODS;

  if (m_prev_time.min == -1)
    return (result);

  if (time.min == m_prev_time.min && time.hour == m_prev_time.hour &&
      time.day == m_prev_time.day && time.mon == m_prev_time.mon)
    return (OBJ_NO_PERIODS);

  if (time.mon != m_prev_time.mon)
    return (result);

  result ^= OBJ_PERIOD_MN1;

  if (time.day != m_prev_time.day)
    return (result);

  result ^= OBJ_PERIOD_D1 + OBJ_PERIOD_W1;

  int curr, delta;

  curr = time.hour;
  delta = curr - m_prev_time.hour;
  if (delta != 0) {
    if (curr % 2 >= delta)
      result ^= OBJ_PERIOD_H2;
    if (curr % 3 >= delta)
      result ^= OBJ_PERIOD_H3;
    if (curr % 4 >= delta)
      result ^= OBJ_PERIOD_H4;
    if (curr % 6 >= delta)
      result ^= OBJ_PERIOD_H6;
    if (curr % 8 >= delta)
      result ^= OBJ_PERIOD_H8;
    if (curr % 12 >= delta)
      result ^= OBJ_PERIOD_H12;
    return (result);
  }

  result ^= OBJ_PERIOD_H1 + OBJ_PERIOD_H2 + OBJ_PERIOD_H3 + OBJ_PERIOD_H4 +
            OBJ_PERIOD_H6 + OBJ_PERIOD_H8 + OBJ_PERIOD_H12;

  curr = time.min;
  delta = curr - m_prev_time.min;
  if (delta != 0) {
    if (curr % 2 >= delta)
      result ^= OBJ_PERIOD_M2;
    if (curr % 3 >= delta)
      result ^= OBJ_PERIOD_M3;
    if (curr % 4 >= delta)
      result ^= OBJ_PERIOD_M4;
    if (curr % 5 >= delta)
      result ^= OBJ_PERIOD_M5;
    if (curr % 6 >= delta)
      result ^= OBJ_PERIOD_M6;
    if (curr % 10 >= delta)
      result ^= OBJ_PERIOD_M10;
    if (curr % 12 >= delta)
      result ^= OBJ_PERIOD_M12;
    if (curr % 15 >= delta)
      result ^= OBJ_PERIOD_M15;
    if (curr % 20 >= delta)
      result ^= OBJ_PERIOD_M20;
    if (curr % 30 >= delta)
      result ^= OBJ_PERIOD_M30;
  }

  return (result);
}

#endif
