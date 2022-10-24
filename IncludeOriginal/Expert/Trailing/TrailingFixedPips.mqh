#ifndef TRAILING_FIXED_PIPS_H
#define TRAILING_FIXED_PIPS_H

#include <Expert\ExpertTrailing.mqh>

class CTrailingFixedPips : public CExpertTrailing {
protected:
  int m_stop_level;
  int m_profit_level;

public:
  CTrailingFixedPips(void);
  ~CTrailingFixedPips(void);

  void StopLevel(int stop_level) {
    m_stop_level = stop_level;
  }
  void ProfitLevel(int profit_level) {
    m_profit_level = profit_level;
  }
  virtual bool ValidationSettings(void);

  virtual bool CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                     double &tp);
  virtual bool CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                      double &tp);
};

void CTrailingFixedPips::CTrailingFixedPips(void)
    : m_stop_level(30), m_profit_level(50) {}

CTrailingFixedPips::~CTrailingFixedPips(void) {}

bool CTrailingFixedPips::ValidationSettings(void) {
  if (!CExpertTrailing::ValidationSettings())
    return (false);

  if (m_profit_level != 0 &&
      m_profit_level * (m_adjusted_point / m_symbol.Point()) <
          m_symbol.StopsLevel()) {
    printf(__FUNCTION__ +
               ": trailing Profit Level must be 0 or greater than %d",
           m_symbol.StopsLevel());
    return (false);
  }
  if (m_stop_level != 0 &&
      m_stop_level * (m_adjusted_point / m_symbol.Point()) <
          m_symbol.StopsLevel()) {
    printf(__FUNCTION__ + ": trailing Stop Level must be 0 or greater than %d",
           m_symbol.StopsLevel());
    return (false);
  }

  return (true);
}

bool CTrailingFixedPips::CheckTrailingStopLong(CPositionInfo *position,
                                               double &sl, double &tp) {

  if (position == NULL)
    return (false);
  if (m_stop_level == 0)
    return (false);

  double delta;
  double pos_sl = position.StopLoss();
  double base = (pos_sl == 0.0) ? position.PriceOpen() : pos_sl;
  double price = m_symbol.Bid();

  sl = EMPTY_VALUE;
  tp = EMPTY_VALUE;
  delta = m_stop_level * m_adjusted_point;
  if (price - base > delta) {
    sl = price - delta;
    if (m_profit_level != 0)
      tp = price + m_profit_level * m_adjusted_point;
  }

  return (sl != EMPTY_VALUE);
}

bool CTrailingFixedPips::CheckTrailingStopShort(CPositionInfo *position,
                                                double &sl, double &tp) {

  if (position == NULL)
    return (false);
  if (m_stop_level == 0)
    return (false);

  double delta;
  double pos_sl = position.StopLoss();
  double base = (pos_sl == 0.0) ? position.PriceOpen() : pos_sl;
  double price = m_symbol.Ask();

  sl = EMPTY_VALUE;
  tp = EMPTY_VALUE;
  delta = m_stop_level * m_adjusted_point;
  if (base - price > delta) {
    sl = price + delta;
    if (m_profit_level != 0)
      tp = price - m_profit_level * m_adjusted_point;
  }

  return (sl != EMPTY_VALUE);
}

#endif
