#ifndef MONEY_FIXED_LOT_H
#define MONEY_FIXED_LOT_H

#include <Expert\ExpertMoney.mqh>

class CMoneyFixedLot : public CExpertMoney {
protected:
  double m_lots;

public:
  CMoneyFixedLot(void);
  ~CMoneyFixedLot(void);

  void Lots(double lots) {
    m_lots = lots;
  }
  virtual bool ValidationSettings(void);

  virtual double CheckOpenLong(double price, double sl) {
    return (m_lots);
  }
  virtual double CheckOpenShort(double price, double sl) {
    return (m_lots);
  }
};

void CMoneyFixedLot::CMoneyFixedLot(void) : m_lots(0.1) {}

void CMoneyFixedLot::~CMoneyFixedLot(void) {}

bool CMoneyFixedLot::ValidationSettings(void) {
  if (!CExpertMoney::ValidationSettings())
    return (false);

  if (m_lots < m_symbol.LotsMin() || m_lots > m_symbol.LotsMax()) {
    printf(__FUNCTION__ + ": lots amount must be in the range from %f to %f",
           m_symbol.LotsMin(), m_symbol.LotsMax());
    return (false);
  }
  if (MathAbs(m_lots / m_symbol.LotsStep() -
              MathRound(m_lots / m_symbol.LotsStep())) > 1.0E-10) {
    printf(__FUNCTION__ + ": lots amount is not corresponding with lot step %f",
           m_symbol.LotsStep());
    return (false);
  }

  return (true);
}

#endif
