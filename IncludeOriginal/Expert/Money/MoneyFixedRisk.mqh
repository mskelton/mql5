#ifndef MONEY_FIXED_RISK_H
#define MONEY_FIXED_RISK_H

#include <Expert\ExpertMoney.mqh>

class CMoneyFixedRisk : public CExpertMoney {
public:
  CMoneyFixedRisk(void);
  ~CMoneyFixedRisk(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
  virtual double CheckClose(CPositionInfo *position) {
    return (0.0);
  }
};

void CMoneyFixedRisk::CMoneyFixedRisk(void) {
}

void CMoneyFixedRisk::~CMoneyFixedRisk(void) {
}

double CMoneyFixedRisk::CheckOpenLong(double price, double sl) {
  if (m_symbol == NULL)
    return (0.0);

  double lot;
  double minvol = m_symbol.LotsMin();
  if (sl == 0.0)
    lot = minvol;
  else {
    double loss;
    if (price == 0.0)
      loss = -m_account.OrderProfitCheck(m_symbol.Name(), ORDER_TYPE_BUY, 1.0,
                                         m_symbol.Ask(), sl);
    else
      loss = -m_account.OrderProfitCheck(m_symbol.Name(), ORDER_TYPE_BUY, 1.0,
                                         price, sl);
    double stepvol = m_symbol.LotsStep();
    lot = MathFloor(m_account.Balance() * m_percent / loss / 100.0 / stepvol) *
          stepvol;
  }

  if (lot < minvol)
    lot = minvol;

  double maxvol = m_symbol.LotsMax();
  if (lot > maxvol)
    lot = maxvol;

  return (lot);
}

double CMoneyFixedRisk::CheckOpenShort(double price, double sl) {
  if (m_symbol == NULL)
    return (0.0);

  double lot;
  double minvol = m_symbol.LotsMin();
  if (sl == 0.0)
    lot = minvol;
  else {
    double loss;
    if (price == 0.0)
      loss = -m_account.OrderProfitCheck(m_symbol.Name(), ORDER_TYPE_SELL, 1.0,
                                         m_symbol.Bid(), sl);
    else
      loss = -m_account.OrderProfitCheck(m_symbol.Name(), ORDER_TYPE_SELL, 1.0,
                                         price, sl);
    double stepvol = m_symbol.LotsStep();
    lot = MathFloor(m_account.Balance() * m_percent / loss / 100.0 / stepvol) *
          stepvol;
  }

  if (lot < minvol)
    lot = minvol;

  double maxvol = m_symbol.LotsMax();
  if (lot > maxvol)
    lot = maxvol;

  return (lot);
}

#endif
