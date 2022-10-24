#ifndef MONEY_SIZE_OPTIMIZED_H
#define MONEY_SIZE_OPTIMIZED_H

#include <Expert/ExpertMoney.mqh>
#include <Trade/DealInfo.mqh>

class CMoneySizeOptimized : public CExpertMoney {
protected:
  double m_decrease_factor;

public:
  CMoneySizeOptimized(void);
  ~CMoneySizeOptimized(void);

  void DecreaseFactor(double decrease_factor) ;
  virtual bool ValidationSettings(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);

protected:
  double Optimize(double lots);
};







#endif
