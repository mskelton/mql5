#ifndef MONEY_FIXED_MARGIN_H
#define MONEY_FIXED_MARGIN_H

#include <Expert\ExpertMoney.mqh>

class CMoneyFixedMargin : public CExpertMoney {
public:
  CMoneyFixedMargin(void);
  ~CMoneyFixedMargin(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
};

void CMoneyFixedMargin::CMoneyFixedMargin(void) {}

void CMoneyFixedMargin::~CMoneyFixedMargin(void) {}

double CMoneyFixedMargin::CheckOpenLong(double price, double sl) {
  if (m_symbol == NULL)
    return (0.0);

  double lot;
  if (price == 0.0)
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_BUY, m_symbol.Ask(),
                                m_percent);
  else
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_BUY, price,
                                m_percent);

  return (lot);
}

double CMoneyFixedMargin::CheckOpenShort(double price, double sl) {
  if (m_symbol == NULL)
    return (0.0);

  double lot;
  if (price == 0.0)
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_SELL,
                                m_symbol.Bid(), m_percent);
  else
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_SELL, price,
                                m_percent);

  return (lot);
}

#endif
