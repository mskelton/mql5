#ifndef MONEY_SIZE_OPTIMIZED_H
#define MONEY_SIZE_OPTIMIZED_H

#include <Expert\ExpertMoney.mqh>
#include <Trade\DealInfo.mqh>

class CMoneySizeOptimized : public CExpertMoney {
protected:
  double m_decrease_factor;

public:
  CMoneySizeOptimized(void);
  ~CMoneySizeOptimized(void);

  void DecreaseFactor(double decrease_factor) {
    m_decrease_factor = decrease_factor;
  }
  virtual bool ValidationSettings(void);

  virtual double CheckOpenLong(double price, double sl);
  virtual double CheckOpenShort(double price, double sl);

protected:
  double Optimize(double lots);
};

void CMoneySizeOptimized::CMoneySizeOptimized(void) : m_decrease_factor(3.0) {
}

void CMoneySizeOptimized::~CMoneySizeOptimized(void) {
}

bool CMoneySizeOptimized::ValidationSettings(void) {
  if (!CExpertMoney::ValidationSettings())
    return (false);

  if (m_decrease_factor <= 0.0) {
    printf(__FUNCTION__ + ": decrease factor must be greater then 0");
    return (false);
  }

  return (true);
}

double CMoneySizeOptimized::CheckOpenLong(double price, double sl) {
  if (m_symbol == NULL)
    return (0.0);

  double lot;
  if (price == 0.0)
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_BUY, m_symbol.Ask(),
                                m_percent);
  else
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_BUY, price,
                                m_percent);

  return (Optimize(lot));
}

double CMoneySizeOptimized::CheckOpenShort(double price, double sl) {
  if (m_symbol == NULL)
    return (0.0);

  double lot;
  if (price == 0.0)
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_SELL,
                                m_symbol.Bid(), m_percent);
  else
    lot = m_account.MaxLotCheck(m_symbol.Name(), ORDER_TYPE_SELL, price,
                                m_percent);

  return (Optimize(lot));
}

double CMoneySizeOptimized::Optimize(double lots) {
  double lot = lots;

  if (m_decrease_factor > 0) {

    HistorySelect(0, TimeCurrent());

    int orders = HistoryDealsTotal();
    int losses = 0;
    CDealInfo deal;

    for (int i = orders - 1; i >= 0; i--) {
      deal.Ticket(HistoryDealGetTicket(i));
      if (deal.Ticket() == 0) {
        Print("CMoneySizeOptimized::Optimize: HistoryDealGetTicket failed, no "
              "trade history");
        break;
      }

      if (deal.Symbol() != m_symbol.Name())
        continue;

      double profit = deal.Profit();
      if (profit > 0.0)
        break;
      if (profit < 0.0)
        losses++;
    }

    if (losses > 1)
      lot = NormalizeDouble(lot - lot * losses / m_decrease_factor, 2);
  }

  double stepvol = m_symbol.LotsStep();
  lot = stepvol * NormalizeDouble(lot / stepvol, 0);

  double minvol = m_symbol.LotsMin();
  if (lot < minvol)
    lot = minvol;

  double maxvol = m_symbol.LotsMax();
  if (lot > maxvol)
    lot = maxvol;

  return (lot);
}

#endif
