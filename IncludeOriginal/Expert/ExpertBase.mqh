#ifndef EXPERT_BASE_H
#define EXPERT_BASE_H

#include <Indicators\Indicators.mqh>
#include <Trade\AccountInfo.mqh>
#include <Trade\DealInfo.mqh>
#include <Trade\HistoryOrderInfo.mqh>
#include <Trade\OrderInfo.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\SymbolInfo.mqh>

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

  ENUM_INIT_PHASE InitPhase(void) const {
    return (m_init_phase);
  }
  void TrendType(ENUM_TYPE_TREND value) {
    m_trend_type = value;
  }
  int UsedSeries(void) const;
  void EveryTick(bool value) {
    m_every_tick = value;
  }

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
  void Magic(ulong value) {
    m_magic = value;
  }
  void SetMarginMode(void) {
    m_margin_mode =
        (ENUM_ACCOUNT_MARGIN_MODE)AccountInfoInteger(ACCOUNT_MARGIN_MODE);
  }

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

  virtual double PriceLevelUnit(void) {
    return (m_adjusted_point);
  }

  virtual int StartIndex(void) {
    return ((m_every_tick ? 0 : 1));
  }
  virtual bool CompareMagic(ulong magic) {
    return (m_magic == magic);
  }
  bool IsHedging(void) const {
    return (m_margin_mode == ACCOUNT_MARGIN_MODE_RETAIL_HEDGING);
  }
};

void CExpertBase::CExpertBase(void)
    : m_magic(0), m_margin_mode(ACCOUNT_MARGIN_MODE_RETAIL_NETTING),
      m_init_phase(INIT_PHASE_FIRST), m_other_symbol(false), m_symbol(NULL),
      m_other_period(false), m_period(PERIOD_CURRENT), m_adjusted_point(1.0),
      m_trend_type(TYPE_TREND_FLAT), m_every_tick(false), m_used_series(0),
      m_open(NULL), m_high(NULL), m_low(NULL), m_close(NULL), m_spread(NULL),
      m_time(NULL), m_tick_volume(NULL), m_real_volume(NULL)

{}

void CExpertBase::~CExpertBase(void) {

  if (m_other_symbol && m_symbol != NULL)
    delete m_symbol;

  if (m_other_symbol || m_other_period) {
    if (IS_OPEN_SERIES_USAGE && CheckPointer(m_open) == POINTER_DYNAMIC)
      delete m_open;
    if (IS_HIGH_SERIES_USAGE && CheckPointer(m_high) == POINTER_DYNAMIC)
      delete m_high;
    if (IS_LOW_SERIES_USAGE && CheckPointer(m_low) == POINTER_DYNAMIC)
      delete m_low;
    if (IS_CLOSE_SERIES_USAGE && CheckPointer(m_close) == POINTER_DYNAMIC)
      delete m_close;
    if (IS_SPREAD_SERIES_USAGE && CheckPointer(m_spread) == POINTER_DYNAMIC)
      delete m_spread;
    if (IS_TIME_SERIES_USAGE && CheckPointer(m_time) == POINTER_DYNAMIC)
      delete m_time;
    if (IS_TICK_VOLUME_SERIES_USAGE &&
        CheckPointer(m_tick_volume) == POINTER_DYNAMIC)
      delete m_tick_volume;
    if (IS_REAL_VOLUME_SERIES_USAGE &&
        CheckPointer(m_real_volume) == POINTER_DYNAMIC)
      delete m_real_volume;
  }
}

int CExpertBase::UsedSeries(void) const {
  if (m_other_symbol || m_other_period)
    return (0);

  return (m_used_series);
}

bool CExpertBase::Init(CSymbolInfo *symbol, ENUM_TIMEFRAMES period,
                       double point) {

  if (m_init_phase != INIT_PHASE_FIRST) {
    Print(__FUNCTION__ + ": attempt of re-initialization");
    return (false);
  }

  if (symbol == NULL) {
    Print(__FUNCTION__ + ": error initialization");
    return (false);
  }

  m_symbol = symbol;
  m_period = period;
  m_adjusted_point = point;
  m_other_symbol = false;
  m_other_period = false;
  SetMarginMode();

  m_init_phase = INIT_PHASE_TUNING;

  return (true);
}

bool CExpertBase::Symbol(string name) {

  if (m_init_phase != INIT_PHASE_TUNING) {
    Print(__FUNCTION__ + ": changing of symbol is forbidden");
    return (false);
  }
  if (m_symbol != NULL) {

    if (m_symbol.Name() == name)
      return (true);

    if (m_other_symbol) {
      if (!m_symbol.Name(name)) {

        delete m_symbol;
        return (false);
      }
      return (true);
    }
  }
  m_symbol = new CSymbolInfo;

  if (m_symbol == NULL) {
    Print(__FUNCTION__ + ": error of changing of symbol");
    return (false);
  }
  if (!m_symbol.Name(name)) {

    delete m_symbol;
    return (false);
  }
  m_other_symbol = true;

  return (true);
}

bool CExpertBase::Period(ENUM_TIMEFRAMES value) {

  if (m_init_phase != INIT_PHASE_TUNING) {
    Print(__FUNCTION__ + ": changing of timeframe is forbidden");
    return (false);
  }
  if (m_period == value)
    return (true);

  m_period = value;
  m_other_period = true;

  return (true);
}

bool CExpertBase::ValidationSettings() {

  if (m_init_phase == INIT_PHASE_VALIDATION)
    return (true);

  if (m_init_phase != INIT_PHASE_TUNING) {
    Print(__FUNCTION__ + ": not the right time to check parameters");
    return (false);
  }

  m_init_phase = INIT_PHASE_VALIDATION;

  return (true);
}

bool CExpertBase::SetPriceSeries(CiOpen *open, CiHigh *high, CiLow *low,
                                 CiClose *close) {

  if (m_init_phase != INIT_PHASE_VALIDATION) {
    Print(__FUNCTION__ + ": changing of timeseries is forbidden");
    return (false);
  }

  if ((IS_OPEN_SERIES_USAGE && open == NULL) ||
      (IS_HIGH_SERIES_USAGE && high == NULL) ||
      (IS_LOW_SERIES_USAGE && low == NULL) ||
      (IS_CLOSE_SERIES_USAGE && close == NULL)) {
    Print(__FUNCTION__ + ": NULL pointer");
    return (false);
  }
  m_open = open;
  m_high = high;
  m_low = low;
  m_close = close;

  return (true);
}

bool CExpertBase::SetOtherSeries(CiSpread *spread, CiTime *time,
                                 CiTickVolume *tick_volume,
                                 CiRealVolume *real_volume) {

  if (m_init_phase != INIT_PHASE_VALIDATION) {
    Print(__FUNCTION__ + ": changing of timeseries is forbidden");
    return (false);
  }

  if ((IS_SPREAD_SERIES_USAGE && spread == NULL) ||
      (IS_TIME_SERIES_USAGE && time == NULL) ||
      (IS_TICK_VOLUME_SERIES_USAGE && tick_volume == NULL) ||
      (IS_REAL_VOLUME_SERIES_USAGE && real_volume == NULL)) {
    Print(__FUNCTION__ + ": NULL pointer");
    return (false);
  }
  m_spread = spread;
  m_time = time;
  m_tick_volume = tick_volume;
  m_real_volume = real_volume;

  return (true);
}

bool CExpertBase::InitIndicators(CIndicators *indicators) {

  if (!ValidationSettings())
    return (false);

  if (m_init_phase != INIT_PHASE_VALIDATION) {
    Print(__FUNCTION__ + ": parameters of setting are not checked");
    return (false);
  }
  if (!m_other_symbol && !m_other_period)
    return (true);

  if (m_symbol == NULL)
    return (false);
  if (indicators == NULL)
    return (false);

  if (IS_OPEN_SERIES_USAGE && !InitOpen(indicators))
    return (false);
  if (IS_HIGH_SERIES_USAGE && !InitHigh(indicators))
    return (false);
  if (IS_LOW_SERIES_USAGE && !InitLow(indicators))
    return (false);
  if (IS_CLOSE_SERIES_USAGE && !InitClose(indicators))
    return (false);
  if (IS_SPREAD_SERIES_USAGE && !InitSpread(indicators))
    return (false);
  if (IS_TIME_SERIES_USAGE && !InitTime(indicators))
    return (false);
  if (IS_TICK_VOLUME_SERIES_USAGE && !InitTickVolume(indicators))
    return (false);
  if (IS_REAL_VOLUME_SERIES_USAGE && !InitRealVolume(indicators))
    return (false);

  m_init_phase = INIT_PHASE_COMPLETE;

  return (true);
}

double CExpertBase::Open(int ind) const {

  if (m_open == NULL)
    return (EMPTY_VALUE);

  return (m_open.GetData(ind));
}

double CExpertBase::High(int ind) const {

  if (m_high == NULL)
    return (EMPTY_VALUE);

  return (m_high.GetData(ind));
}

double CExpertBase::Low(int ind) const {

  if (m_low == NULL)
    return (EMPTY_VALUE);

  return (m_low.GetData(ind));
}

double CExpertBase::Close(int ind) const {

  if (m_close == NULL)
    return (EMPTY_VALUE);

  return (m_close.GetData(ind));
}

int CExpertBase::Spread(int ind) const {

  if (m_spread == NULL)
    return (INT_MAX);

  return (m_spread.GetData(ind));
}

datetime CExpertBase::Time(int ind) const {

  if (m_time == NULL)
    return (0);

  return (m_time.GetData(ind));
}

long CExpertBase::TickVolume(int ind) const {

  if (m_tick_volume == NULL)
    return (0);

  return (m_tick_volume.GetData(ind));
}

long CExpertBase::RealVolume(int ind) const {

  if (m_real_volume == NULL)
    return (0);

  return (m_real_volume.GetData(ind));
}

bool CExpertBase::InitOpen(CIndicators *indicators) {

  if ((m_open = new CiOpen) == NULL) {
    Print(__FUNCTION__ + ": error creating object");
    return (false);
  }

  if (!indicators.Add(m_open)) {
    Print(__FUNCTION__ + ": error adding object");
    delete m_open;
    return (false);
  }

  if (!m_open.Create(m_symbol.Name(), m_period)) {
    Print(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

bool CExpertBase::InitHigh(CIndicators *indicators) {

  if ((m_high = new CiHigh) == NULL) {
    Print(__FUNCTION__ + ": error creating object");
    return (false);
  }

  if (!indicators.Add(m_high)) {
    Print(__FUNCTION__ + ": error adding object");
    delete m_high;
    return (false);
  }

  if (!m_high.Create(m_symbol.Name(), m_period)) {
    Print(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

bool CExpertBase::InitLow(CIndicators *indicators) {

  if ((m_low = new CiLow) == NULL) {
    Print(__FUNCTION__ + ": error creating object");
    return (false);
  }

  if (!indicators.Add(m_low)) {
    Print(__FUNCTION__ + ": error adding object");
    delete m_low;
    return (false);
  }

  if (!m_low.Create(m_symbol.Name(), m_period)) {
    Print(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

bool CExpertBase::InitClose(CIndicators *indicators) {

  if ((m_close = new CiClose) == NULL) {
    Print(__FUNCTION__ + ": error creating object");
    return (false);
  }

  if (!indicators.Add(m_close)) {
    Print(__FUNCTION__ + ": error adding object");
    delete m_close;
    return (false);
  }

  if (!m_close.Create(m_symbol.Name(), m_period)) {
    Print(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

bool CExpertBase::InitSpread(CIndicators *indicators) {

  if ((m_spread = new CiSpread) == NULL) {
    Print(__FUNCTION__ + ": error creating object");
    return (false);
  }

  if (!indicators.Add(m_spread)) {
    Print(__FUNCTION__ + ": error adding object");
    delete m_spread;
    return (false);
  }

  if (!m_spread.Create(m_symbol.Name(), m_period)) {
    Print(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

bool CExpertBase::InitTime(CIndicators *indicators) {

  if ((m_time = new CiTime) == NULL) {
    Print(__FUNCTION__ + ": error creating object");
    return (false);
  }

  if (!indicators.Add(m_time)) {
    Print(__FUNCTION__ + ": error adding object");
    delete m_time;
    return (false);
  }

  if (!m_time.Create(m_symbol.Name(), m_period)) {
    Print(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

bool CExpertBase::InitTickVolume(CIndicators *indicators) {

  if ((m_tick_volume = new CiTickVolume) == NULL) {
    Print(__FUNCTION__ + ": error creating object");
    return (false);
  }

  if (!indicators.Add(m_tick_volume)) {
    Print(__FUNCTION__ + ": error adding object");
    delete m_tick_volume;
    return (false);
  }

  if (!m_tick_volume.Create(m_symbol.Name(), m_period)) {
    Print(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

bool CExpertBase::InitRealVolume(CIndicators *indicators) {

  if ((m_real_volume = new CiRealVolume) == NULL) {
    Print(__FUNCTION__ + ": error creating object");
    return (false);
  }

  if (!indicators.Add(m_real_volume)) {
    Print(__FUNCTION__ + ": error adding object");
    delete m_real_volume;
    return (false);
  }

  if (!m_real_volume.Create(m_symbol.Name(), m_period)) {
    Print(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

#endif
