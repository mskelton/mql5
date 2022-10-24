#ifndef MONEY_FIXED_MARGIN_H
#define MONEY_FIXED_MARGIN_H

#include <Expert/ExpertMoney.mqh>

class CMoneyFixedMargin : public CExpertMoney {
public:
  CMoneyFixedMargin(void);
  ~CMoneyFixedMargin(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
};





#endif
