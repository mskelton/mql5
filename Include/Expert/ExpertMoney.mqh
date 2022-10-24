#ifndef EXPERT_MONEY_H
#define EXPERT_MONEY_H

#include "ExpertBase.mqh"

class CExpertMoney : public CExpertBase {
protected:
  double m_percent;

public:
  CExpertMoney(void);
  ~CExpertMoney(void);

  void Percent(double percent);

  virtual bool ValidationSettings();

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
  virtual double CheckReverse(CPositionInfo *position, double sl);
  virtual double CheckClose(CPositionInfo *position);
};

#endif
