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

CAccountInfo::CAccountInfo(void) {}

CAccountInfo::~CAccountInfo(void) {}

long CAccountInfo::Login(void) const {
  return (AccountInfoInteger(ACCOUNT_LOGIN));
}

ENUM_ACCOUNT_TRADE_MODE CAccountInfo::TradeMode(void) const {
  return ((ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE));
}

string CAccountInfo::TradeModeDescription(void) const {
  string str;

  switch (TradeMode()) {
  case ACCOUNT_TRADE_MODE_DEMO:
    str = "Demo trading account";
    break;
  case ACCOUNT_TRADE_MODE_CONTEST:
    str = "Contest trading account";
    break;
  case ACCOUNT_TRADE_MODE_REAL:
    str = "Real trading account";
    break;
  default:
    str = "Unknown trade account";
  }

  return (str);
}

long CAccountInfo::Leverage(void) const {
  return (AccountInfoInteger(ACCOUNT_LEVERAGE));
}

ENUM_ACCOUNT_STOPOUT_MODE CAccountInfo::StopoutMode(void) const {
  return (
      (ENUM_ACCOUNT_STOPOUT_MODE)AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE));
}

string CAccountInfo::StopoutModeDescription(void) const {
  string str;

  switch (StopoutMode()) {
  case ACCOUNT_STOPOUT_MODE_PERCENT:
    str = "Level is specified in percentage";
    break;
  case ACCOUNT_STOPOUT_MODE_MONEY:
    str = "Level is specified in money";
    break;
  default:
    str = "Unknown stopout mode";
  }

  return (str);
}

ENUM_ACCOUNT_MARGIN_MODE CAccountInfo::MarginMode(void) const {
  return ((ENUM_ACCOUNT_MARGIN_MODE)AccountInfoInteger(ACCOUNT_MARGIN_MODE));
}

string CAccountInfo::MarginModeDescription(void) const {
  string str;

  switch (MarginMode()) {
  case ACCOUNT_MARGIN_MODE_RETAIL_NETTING:
    str = "Netting";
    break;
  case ACCOUNT_MARGIN_MODE_EXCHANGE:
    str = "Exchange";
    break;
  case ACCOUNT_MARGIN_MODE_RETAIL_HEDGING:
    str = "Hedging";
    break;
  default:
    str = "Unknown margin mode";
  }

  return (str);
}

bool CAccountInfo::TradeAllowed(void) const {
  return ((bool)AccountInfoInteger(ACCOUNT_TRADE_ALLOWED));
}

bool CAccountInfo::TradeExpert(void) const {
  return ((bool)AccountInfoInteger(ACCOUNT_TRADE_EXPERT));
}

int CAccountInfo::LimitOrders(void) const {
  return ((int)AccountInfoInteger(ACCOUNT_LIMIT_ORDERS));
}

double CAccountInfo::Balance(void) const {
  return (AccountInfoDouble(ACCOUNT_BALANCE));
}

double CAccountInfo::Credit(void) const {
  return (AccountInfoDouble(ACCOUNT_CREDIT));
}

double CAccountInfo::Profit(void) const {
  return (AccountInfoDouble(ACCOUNT_PROFIT));
}

double CAccountInfo::Equity(void) const {
  return (AccountInfoDouble(ACCOUNT_EQUITY));
}

double CAccountInfo::Margin(void) const {
  return (AccountInfoDouble(ACCOUNT_MARGIN));
}

double CAccountInfo::FreeMargin(void) const {
  return (AccountInfoDouble(ACCOUNT_MARGIN_FREE));
}

double CAccountInfo::MarginLevel(void) const {
  return (AccountInfoDouble(ACCOUNT_MARGIN_LEVEL));
}

double CAccountInfo::MarginCall(void) const {
  return (AccountInfoDouble(ACCOUNT_MARGIN_SO_CALL));
}

double CAccountInfo::MarginStopOut(void) const {
  return (AccountInfoDouble(ACCOUNT_MARGIN_SO_SO));
}

string CAccountInfo::Name(void) const {
  return (AccountInfoString(ACCOUNT_NAME));
}

string CAccountInfo::Server(void) const {
  return (AccountInfoString(ACCOUNT_SERVER));
}

string CAccountInfo::Currency(void) const {
  return (AccountInfoString(ACCOUNT_CURRENCY));
}

string CAccountInfo::Company(void) const {
  return (AccountInfoString(ACCOUNT_COMPANY));
}

long CAccountInfo::InfoInteger(const ENUM_ACCOUNT_INFO_INTEGER prop_id) const {
  return (AccountInfoInteger(prop_id));
}

double CAccountInfo::InfoDouble(const ENUM_ACCOUNT_INFO_DOUBLE prop_id) const {
  return (AccountInfoDouble(prop_id));
}

string CAccountInfo::InfoString(const ENUM_ACCOUNT_INFO_STRING prop_id) const {
  return (AccountInfoString(prop_id));
}

double CAccountInfo::OrderProfitCheck(const string symbol,
                                      const ENUM_ORDER_TYPE trade_operation,
                                      const double volume,
                                      const double price_open,
                                      const double price_close) const {
  double profit = EMPTY_VALUE;

  if (!OrderCalcProfit(trade_operation, symbol, volume, price_open, price_close,
                       profit))
    return (EMPTY_VALUE);

  return (profit);
}

double CAccountInfo::MarginCheck(const string symbol,
                                 const ENUM_ORDER_TYPE trade_operation,
                                 const double volume,
                                 const double price) const {
  double margin = EMPTY_VALUE;

  if (!OrderCalcMargin(trade_operation, symbol, volume, price, margin))
    return (EMPTY_VALUE);

  return (margin);
}

double CAccountInfo::FreeMarginCheck(const string symbol,
                                     const ENUM_ORDER_TYPE trade_operation,
                                     const double volume,
                                     const double price) const {
  return (FreeMargin() - MarginCheck(symbol, trade_operation, volume, price));
}

double CAccountInfo::MaxLotCheck(const string symbol,
                                 const ENUM_ORDER_TYPE trade_operation,
                                 const double price,
                                 const double percent) const {
  double margin = 0.0;

  if (symbol == "" || price <= 0.0 || percent < 1 || percent > 100) {
    Print("CAccountInfo::MaxLotCheck invalid parameters");
    return (0.0);
  }

  if (!OrderCalcMargin(trade_operation, symbol, 1.0, price, margin) ||
      margin < 0.0) {
    Print("CAccountInfo::MaxLotCheck margin calculation failed");
    return (0.0);
  }

  if (margin == 0.0)
    return (SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX));

  double volume = NormalizeDouble(FreeMargin() * percent / 100.0 / margin, 2);

  double stepvol = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP);
  if (stepvol > 0.0)
    volume = stepvol * MathFloor(volume / stepvol);

  double minvol = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
  if (volume < minvol)
    volume = 0.0;

  double maxvol = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);
  if (volume > maxvol)
    volume = maxvol;

  return (volume);
}

#endif
