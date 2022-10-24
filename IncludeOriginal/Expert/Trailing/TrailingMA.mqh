#ifndef TRAILING_MA_H
#define TRAILING_MA_H

#include <Expert\ExpertTrailing.mqh>

class CTrailingMA : public CExpertTrailing {
protected:
  CiMA *m_MA;

  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_PRICE m_ma_applied;

public:
  CTrailingMA(void);
  ~CTrailingMA(void);

  void Period(int period) {
    m_ma_period = period;
  }
  void Shift(int shift) {
    m_ma_shift = shift;
  }

  void Method(ENUM_MA_METHOD method) {
    m_ma_method = method;
  }
  void Applied(ENUM_APPLIED_PRICE applied) {
    m_ma_applied = applied;
  }
  virtual bool InitIndicators(CIndicators *indicators);
  virtual bool ValidationSettings(void);

  virtual bool CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                     double &tp);
  virtual bool CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                      double &tp);
};

void CTrailingMA::CTrailingMA(void)
    : m_MA(NULL), m_ma_period(12), m_ma_shift(0), m_ma_method(MODE_SMA),
      m_ma_applied(PRICE_CLOSE) {
}

void CTrailingMA::~CTrailingMA(void) {
}

bool CTrailingMA::ValidationSettings(void) {
  if (!CExpertTrailing::ValidationSettings())
    return (false);

  if (m_ma_period <= 0) {
    printf(__FUNCTION__ + ": period MA must be greater than 0");
    return (false);
  }

  return (true);
}

bool CTrailingMA::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (m_MA == NULL)
    if ((m_MA = new CiMA) == NULL) {
      printf(__FUNCTION__ + ": error creating object");
      return (false);
    }

  if (!indicators.Add(m_MA)) {
    printf(__FUNCTION__ + ": error adding object");
    delete m_MA;
    return (false);
  }

  if (!m_MA.Create(m_symbol.Name(), m_period, m_ma_period, m_ma_shift,
                   m_ma_method, m_ma_applied)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }
  m_MA.BufferResize(3 + m_ma_shift);

  return (true);
}

bool CTrailingMA::CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                        double &tp) {

  if (position == NULL)
    return (false);

  double level =
      NormalizeDouble(m_symbol.Bid() - m_symbol.StopsLevel() * m_symbol.Point(),
                      m_symbol.Digits());
  double new_sl = NormalizeDouble(m_MA.Main(1), m_symbol.Digits());
  double pos_sl = position.StopLoss();
  double base = (pos_sl == 0.0) ? position.PriceOpen() : pos_sl;

  sl = EMPTY_VALUE;
  tp = EMPTY_VALUE;
  if (new_sl > base && new_sl < level)
    sl = new_sl;

  return (sl != EMPTY_VALUE);
}

bool CTrailingMA::CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                         double &tp) {

  if (position == NULL)
    return (false);

  double level =
      NormalizeDouble(m_symbol.Ask() + m_symbol.StopsLevel() * m_symbol.Point(),
                      m_symbol.Digits());
  double new_sl = NormalizeDouble(
      m_MA.Main(1) + m_symbol.Spread() * m_symbol.Point(), m_symbol.Digits());
  double pos_sl = position.StopLoss();
  double base = (pos_sl == 0.0) ? position.PriceOpen() : pos_sl;

  sl = EMPTY_VALUE;
  tp = EMPTY_VALUE;
  if (new_sl < base && new_sl > level)
    sl = new_sl;

  return (sl != EMPTY_VALUE);
}

#endif
