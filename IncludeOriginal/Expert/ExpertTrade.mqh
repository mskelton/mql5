#ifndef EXPERT_TRADE_H
#define EXPERT_TRADE_H

#include <Trade\AccountInfo.mqh>
#include <Trade\OrderInfo.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\SymbolInfo.mqh>
#include <Trade\Trade.mqh>

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

void CExpertTrade::CExpertTrade(void)
    : m_symbol(NULL), m_order_type_time(ORDER_TIME_GTC), m_order_expiration(0) {
}

CExpertTrade::~CExpertTrade(void) {}

bool CExpertTrade::SetSymbol(CSymbolInfo *symbol) {
  if (symbol != NULL) {
    m_symbol = symbol;
    return (true);
  }

  return (false);
}

bool CExpertTrade::SetOrderTypeTime(ENUM_ORDER_TYPE_TIME order_type_time) {
  if (m_symbol == NULL)
    return (false);

  if (order_type_time == ORDER_TIME_SPECIFIED) {
    if ((m_symbol.TradeTimeFlags() & SYMBOL_EXPIRATION_SPECIFIED) == 0) {
      m_order_type_time = ORDER_TIME_GTC;
      m_order_expiration = 0;
      return (false);
    }
  }

  m_order_type_time = order_type_time;

  return (true);
}

bool CExpertTrade::SetOrderExpiration(datetime order_expiration) {
  if (m_symbol == NULL)
    return (false);

  if (order_expiration >= TimeCurrent() + 60) {
    if (!SetOrderTypeTime(ORDER_TIME_SPECIFIED))
      return (false);
    m_order_expiration = order_expiration;
  } else {
    m_order_type_time = ORDER_TIME_GTC;
    m_order_expiration = 0;
  }

  return (true);
}

bool CExpertTrade::Buy(double volume, double price, double sl, double tp,
                       const string comment = "") {
  double ask, stops_level;

  if (m_symbol == NULL)
    return (false);
  string symbol = m_symbol.Name();
  if (symbol == "")
    return (false);

  ask = m_symbol.Ask();
  stops_level = m_symbol.StopsLevel() * m_symbol.Point();
  if (price != 0.0) {
    if (price > ask + stops_level) {

      return (OrderOpen(symbol, ORDER_TYPE_BUY_STOP, volume, 0.0, price, sl, tp,
                        m_order_type_time, m_order_expiration, comment));
    }
    if (price < ask - stops_level) {

      return (OrderOpen(symbol, ORDER_TYPE_BUY_LIMIT, volume, 0.0, price, sl,
                        tp, m_order_type_time, m_order_expiration, comment));
    }
  }

  return (PositionOpen(symbol, ORDER_TYPE_BUY, volume, ask, sl, tp, comment));
}

bool CExpertTrade::Sell(double volume, double price, double sl, double tp,
                        const string comment = "") {
  double bid, stops_level;

  if (m_symbol == NULL)
    return (false);
  string symbol = m_symbol.Name();
  if (symbol == "")
    return (false);

  bid = m_symbol.Bid();
  stops_level = m_symbol.StopsLevel() * m_symbol.Point();
  if (price != 0.0) {
    if (price > bid + stops_level) {

      return (OrderOpen(symbol, ORDER_TYPE_SELL_LIMIT, volume, 0.0, price, sl,
                        tp, m_order_type_time, m_order_expiration, comment));
    }
    if (price < bid - stops_level) {

      return (OrderOpen(symbol, ORDER_TYPE_SELL_STOP, volume, 0.0, price, sl,
                        tp, m_order_type_time, m_order_expiration, comment));
    }
  }

  return (PositionOpen(symbol, ORDER_TYPE_SELL, volume, bid, sl, tp, comment));
}

#endif
