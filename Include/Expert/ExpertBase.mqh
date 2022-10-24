#ifndef EXPERT_BASE_H
#define EXPERT_BASE_H

#include <Indicators/Indicators.mqh>
#include <Trade/AccountInfo.mqh>
#include <Trade/DealInfo.mqh>
#include <Trade/HistoryOrderInfo.mqh>
#include <Trade/OrderInfo.mqh>
#include <Trade/PositionInfo.mqh>
#include <Trade/SymbolInfo.mqh>

enum ENUM_TYPE_TREND {
  TYPE_TREND_HARD_DOWN = 0,
  TYPE_TREND_DOWN = 1,
  TYPE_TREND_SOFT_DOWN = 2,
  TYPE_TREND_FLAT = 3,
  TYPE_TREND_SOFT_UP = 4,
  TYPE_TREND_UP = 5,
  TYPE_TREND_HARD_UP = 6
};

enum ENUM_USED_SERIES {
  USE_SERIES_OPEN = 0x1,
  USE_SERIES_HIGH = 0x2,
  USE_SERIES_LOW = 0x4,
  USE_SERIES_CLOSE = 0x8,
  USE_SERIES_SPREAD = 0x10,
  USE_SERIES_TIME = 0x20,
  USE_SERIES_TICK_VOLUME = 0x40,
  USE_SERIES_REAL_VOLUME = 0x80
};

enum ENUM_INIT_PHASE {
  INIT_PHASE_FIRST = 0,
  INIT_PHASE_TUNING = 1,
  INIT_PHASE_VALIDATION = 2,
  INIT_PHASE_COMPLETE = 3
};

#define IS_OPEN_SERIES_USAGE ((m_used_series & USE_SERIES_OPEN) != 0)
#define IS_HIGH_SERIES_USAGE ((m_used_series & USE_SERIES_HIGH) != 0)
#define IS_LOW_SERIES_USAGE ((m_used_series & USE_SERIES_LOW) != 0)
#define IS_CLOSE_SERIES_USAGE ((m_used_series & USE_SERIES_CLOSE) != 0)
#define IS_SPREAD_SERIES_USAGE ((m_used_series & USE_SERIES_SPREAD) != 0)
#define IS_TIME_SERIES_USAGE ((m_used_series & USE_SERIES_TIME) != 0)
#define IS_TICK_VOLUME_SERIES_USAGE                                            \
  ((m_used_series & USE_SERIES_TICK_VOLUME) != 0)
#define IS_REAL_VOLUME_SERIES_USAGE                                            \
  ((m_used_series & USE_SERIES_REAL_VOLUME) != 0)

class CExpertBase : public CObject {
protected:
  ulong m_magic;
  ENUM_INIT_PHASE m_init_phase;
  bool m_other_symbol;
  CSymbolInfo *m_symbol;
  bool m_other_period;
  ENUM_TIMEFRAMES m_period;
  double m_adjusted_point;
  CAccountInfo m_account;
  ENUM_ACCOUNT_MARGIN_MODE m_margin_mode;
  ENUM_TYPE_TREND m_trend_type;
  bool m_every_tick;

  int m_used_series;
  CiOpen *m_open;
  CiHigh *m_high;
  CiLow *m_low;
  CiClose *m_close;
  CiSpread *m_spread;
  CiTime *m_time;
  CiTickVolume *m_tick_volume;
  CiRealVolume *m_real_volume;

public:
  CExpertBase(void);
  ~CExpertBase(void);

  ENUM_INIT_PHASE InitPhase(void) const;
  void TrendType(ENUM_TYPE_TREND value);
  int UsedSeries(void) const;
  void EveryTick(bool value);

  double Open(int ind) const;
  double High(int ind) const;
  double Low(int ind) const;
  double Close(int ind) const;
  int Spread(int ind) const;
  datetime Time(int ind) const;
  long TickVolume(int ind) const;
  long RealVolume(int ind) const;

  virtual bool Init(CSymbolInfo *symbol, ENUM_TIMEFRAMES period, double point);
  bool Symbol(string name);
  bool Period(ENUM_TIMEFRAMES value);
  void Magic(ulong value);
  void SetMarginMode(void);

  virtual bool ValidationSettings();

  virtual bool SetPriceSeries(CiOpen *open, CiHigh *high, CiLow *low,
                              CiClose *close);
  virtual bool SetOtherSeries(CiSpread *spread, CiTime *time,
                              CiTickVolume *tick_volume,
                              CiRealVolume *real_volume);
  virtual bool InitIndicators(CIndicators *indicators = NULL);

protected:
  bool InitOpen(CIndicators *indicators);
  bool InitHigh(CIndicators *indicators);
  bool InitLow(CIndicators *indicators);
  bool InitClose(CIndicators *indicators);
  bool InitSpread(CIndicators *indicators);
  bool InitTime(CIndicators *indicators);
  bool InitTickVolume(CIndicators *indicators);
  bool InitRealVolume(CIndicators *indicators);

  virtual double PriceLevelUnit(void);

  virtual int StartIndex(void);
  virtual bool CompareMagic(ulong magic);
  bool IsHedging(void) const;
};

#endif
