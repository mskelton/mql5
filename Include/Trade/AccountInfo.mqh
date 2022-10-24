#ifndef ACCOUNT_INFO_H
#define ACCOUNT_INFO_H

#include <Object.mqh>

class CAccountInfo : public CObject {
public:
  CAccountInfo(void);
  ~CAccountInfo(void);

  long Login(void) const;
  ENUM_ACCOUNT_TRADE_MODE TradeMode(void) const;
  string TradeModeDescription(void) const;
  long Leverage(void) const;
  ENUM_ACCOUNT_STOPOUT_MODE StopoutMode(void) const;
  string StopoutModeDescription(void) const;
  ENUM_ACCOUNT_MARGIN_MODE MarginMode(void) const;
  string MarginModeDescription(void) const;
  bool TradeAllowed(void) const;
  bool TradeExpert(void) const;
  int LimitOrders(void) const;

  double Balance(void) const;
  double Credit(void) const;
  double Profit(void) const;
  double Equity(void) const;
  double Margin(void) const;
  double FreeMargin(void) const;
  double MarginLevel(void) const;
  double MarginCall(void) const;
  double MarginStopOut(void) const;

  string Name(void) const;
  string Server(void) const;
  string Currency(void) const;
  string Company(void) const;

  long InfoInteger(const ENUM_ACCOUNT_INFO_INTEGER prop_id) const;
  double InfoDouble(const ENUM_ACCOUNT_INFO_DOUBLE prop_id) const;
  string InfoString(const ENUM_ACCOUNT_INFO_STRING prop_id) const;

  double OrderProfitCheck(const string symbol,
                          const ENUM_ORDER_TYPE trade_operation,
                          const double volume, const double price_open,
                          const double price_close) const;
  double MarginCheck(const string symbol, const ENUM_ORDER_TYPE trade_operation,
                     const double volume, const double price) const;
  double FreeMarginCheck(const string symbol,
                         const ENUM_ORDER_TYPE trade_operation,
                         const double volume, const double price) const;
  double MaxLotCheck(const string symbol, const ENUM_ORDER_TYPE trade_operation,
                     const double price, const double percent = 100) const;
};

#endif
