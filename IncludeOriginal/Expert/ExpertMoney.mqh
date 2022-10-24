#ifndef EXPERT_MONEY_H
#define EXPERT_MONEY_H

#include "ExpertBase.mqh"

class CExpertMoney : public CExpertBase {
protected:
  double m_percent;

public:
  CExpertMoney(void);
  ~CExpertMoney(void);

  void Percent(double percent) {
    m_percent = percent;
  }

  virtual bool ValidationSettings();

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);
  virtual double CheckReverse(CPositionInfo *position, double sl);
  virtual double CheckClose(CPositionInfo *position);
};

void CExpertMoney::CExpertMoney(void) : m_percent(10.0) {
}

void CExpertMoney::~CExpertMoney(void) {
}

bool CExpertMoney::ValidationSettings() {
  if (!CExpertBase::ValidationSettings())
    return (false);

  if (m_percent < 0.0 || m_percent > 100.0) {
    printf(
        __FUNCTION__ +
        ": percentage of risk should be in the range from 0 to 100 inclusive");
    return (false);
  }

  return (true);
}

double CExpertMoney::CheckOpenLong(double price, double sl) {
  if (m_symbol == NULL)
    return (0.0);

  double lot;
  if (price == 0.0)
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_BUY, m_symbol.Ask(),
                                m_percent);
  else
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_BUY, price,
                                m_percent);
  if (lot < m_symbol.LotsMin())
    return (0.0);

  return (m_symbol.LotsMin());
}

double CExpertMoney::CheckOpenShort(double price, double sl) {
  if (m_symbol == NULL)
    return (0.0);

  double lot;
  if (price == 0.0)
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_SELL,
                                m_symbol.Bid(), m_percent);
  else
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_SELL, price,
                                m_percent);
  if (lot < m_symbol.LotsMin())
    return (0.0);

  return (m_symbol.LotsMin());
}

double CExpertMoney::CheckReverse(CPositionInfo *position, double sl) {
  double lots = 0.0;

  if (position.PositionType() == POSITION_TYPE_BUY)
    lots = CheckOpenShort(m_symbol.Bid(), sl);
  if (position.PositionType() == POSITION_TYPE_SELL)
    lots = CheckOpenLong(m_symbol.Ask(), sl);

  if (lots != 0.0)
    lots += position.Volume();

  return (lots);
}

double CExpertMoney::CheckClose(CPositionInfo *position) {
  if (m_percent == 0.0)
    return (0.0);

  if (-position.Profit() > m_account.Balance() * m_percent / 100.0)
    return (position.Volume());

  return (0.0);
}

#endif
