#ifndef MONEY_NONE_H
#define MONEY_NONE_H

#include <Expert\ExpertMoney.mqh>

class CMoneyNone : public CExpertMoney {
public:
  CMoneyNone(void);
  ~CMoneyNone(void);

  virtual bool ValidationSettings(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
};

void CMoneyNone::CMoneyNone(void) {
}

void CMoneyNone::~CMoneyNone(void) {
}

bool CMoneyNone::ValidationSettings(void) {
  Percent(100.0);

  if (!CExpertMoney::ValidationSettings())
    return (false);

  return (true);
}

double CMoneyNone::CheckOpenLong(double price, double sl) {
  return (m_symbol.LotsMin());
}

double CMoneyNone::CheckOpenShort(double price, double sl) {
  return (m_symbol.LotsMin());
}

#endif
