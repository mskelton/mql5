#ifndef EXPERT_TRADE_H
#define EXPERT_TRADE_H

#include <Trade/AccountInfo.mqh>
#include <Trade/OrderInfo.mqh>
#include <Trade/PositionInfo.mqh>
#include <Trade/SymbolInfo.mqh>
#include <Trade/Trade.mqh>

class CExpertTrade : public CTrade {
protected:
  ENUM_ORDER_TYPE_TIME m_order_type_time;
  datetime m_order_expiration;
  CSymbolInfo *m_symbol;
  CAccountInfo m_account;

public:
  CExpertTrade(void);
  ~CExpertTrade(void);

  bool SetSymbol(CSymbolInfo *symbol);
  bool SetOrderTypeTime(ENUM_ORDER_TYPE_TIME order_type_time);
  bool SetOrderExpiration(datetime order_expiration);
  bool Buy(double volume, double price, double sl, double tp,
           const string comment = "");
  bool Sell(double volume, double price, double sl, double tp,
            const string comment = "");
};

#endif
