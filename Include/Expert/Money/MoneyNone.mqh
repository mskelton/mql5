#ifndef MONEY_NONE_H
#define MONEY_NONE_H

#include <Expert/ExpertMoney.mqh>

class CMoneyNone : public CExpertMoney {
public:
  CMoneyNone(void);
  ~CMoneyNone(void);

  virtual bool ValidationSettings(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
};






#endif
