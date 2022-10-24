#ifndef MONEY_FIXED_LOT_H
#define MONEY_FIXED_LOT_H

#include <Expert/ExpertMoney.mqh>

class CMoneyFixedLot : public CExpertMoney {
protected:
  double m_lots;

public:
  CMoneyFixedLot(void);
  ~CMoneyFixedLot(void);

  void Lots(double lots);
  virtual bool ValidationSettings(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
};

#endif
