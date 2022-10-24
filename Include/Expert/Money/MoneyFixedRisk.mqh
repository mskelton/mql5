#ifndef MONEY_FIXED_RISK_H
#define MONEY_FIXED_RISK_H

#include <Expert/ExpertMoney.mqh>

class CMoneyFixedRisk : public CExpertMoney {
public:
  CMoneyFixedRisk(void);
  ~CMoneyFixedRisk(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
  virtual double CheckClose(CPositionInfo *position);
};

#endif
