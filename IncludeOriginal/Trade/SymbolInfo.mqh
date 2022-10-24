#ifndef SYMBOL_INFO_H
#define SYMBOL_INFO_H

#include <Object.mqh>

class CSymbolInfo : public CObject {
protected:
  string m_name;
  MqlTick m_tick;
  double m_point;
  double m_tick_value;
  double m_tick_value_profit;
  double m_tick_value_loss;
  double m_tick_size;
  double m_contract_size;
  double m_lots_min;
  double m_lots_max;
  double m_lots_step;
  double m_lots_limit;
  double m_swap_long;
  double m_swap_short;
  int m_digits;
  int m_order_mode;
  ENUM_SYMBOL_TRADE_EXECUTION m_trade_execution;
  ENUM_SYMBOL_CALC_MODE m_trade_calcmode;
  ENUM_SYMBOL_TRADE_MODE m_trade_mode;
  ENUM_SYMBOL_SWAP_MODE m_swap_mode;
  ENUM_DAY_OF_WEEK m_swap3;
  double m_margin_initial;
  double m_margin_maintenance;
  bool m_margin_hedged_use_leg;
  double m_margin_hedged;
  int m_trade_time_flags;
  int m_trade_fill_flags;

public:
  CSymbolInfo(void);
  ~CSymbolInfo(void);

  string Name(void) const {
    return (m_name);
  }
  bool Name(const string name);
  bool Refresh(void);
  bool RefreshRates(void);

  bool Select(void) const;
  bool Select(const bool select);
  bool IsSynchronized(void) const;

  ulong Volume(void) const {
    return (m_tick.volume);
  }
  ulong VolumeHigh(void) const;
  ulong VolumeLow(void) const;

  datetime Time(void) const {
    return (m_tick.time);
  }
  int Spread(void) const;
  bool SpreadFloat(void) const;
  int TicksBookDepth(void) const;

  int StopsLevel(void) const;
  int FreezeLevel(void) const;

  double Bid(void) const {
    return (m_tick.bid);
  }
  double BidHigh(void) const;
  double BidLow(void) const;

  double Ask(void) const {
    return (m_tick.ask);
  }
  double AskHigh(void) const;
  double AskLow(void) const;

  double Last(void) const {
    return (m_tick.last);
  }
  double LastHigh(void) const;
  double LastLow(void) const;

  int OrderMode(void) const {
    return (m_order_mode);
  }

  ENUM_SYMBOL_CALC_MODE TradeCalcMode(void) const {
    return (m_trade_calcmode);
  }
  string TradeCalcModeDescription(void) const;
  ENUM_SYMBOL_TRADE_MODE TradeMode(void) const {
    return (m_trade_mode);
  }
  string TradeModeDescription(void) const;

  ENUM_SYMBOL_TRADE_EXECUTION TradeExecution(void) const {
    return (m_trade_execution);
  }
  string TradeExecutionDescription(void) const;

  ENUM_SYMBOL_SWAP_MODE SwapMode(void) const {
    return (m_swap_mode);
  }
  string SwapModeDescription(void) const;
  ENUM_DAY_OF_WEEK SwapRollover3days(void) const {
    return (m_swap3);
  }
  string SwapRollover3daysDescription(void) const;

  datetime StartTime(void) const;
  datetime ExpirationTime(void) const;

  double MarginInitial(void) const {
    return (m_margin_initial);
  }
  double MarginMaintenance(void) const {
    return (m_margin_maintenance);
  }
  bool MarginHedgedUseLeg(void) const {
    return (m_margin_hedged_use_leg);
  }
  double MarginHedged(void) const {
    return (m_margin_hedged);
  }

  double MarginLong(void) const {
    return (0.0);
  }
  double MarginShort(void) const {
    return (0.0);
  }
  double MarginLimit(void) const {
    return (0.0);
  }
  double MarginStop(void) const {
    return (0.0);
  }
  double MarginStopLimit(void) const {
    return (0.0);
  }

  int TradeTimeFlags(void) const {
    return (m_trade_time_flags);
  }
  int TradeFillFlags(void) const {
    return (m_trade_fill_flags);
  }

  int Digits(void) const {
    return (m_digits);
  }
  double Point(void) const {
    return (m_point);
  }
  double TickValue(void) const {
    return (m_tick_value);
  }
  double TickValueProfit(void) const {
    return (m_tick_value_profit);
  }
  double TickValueLoss(void) const {
    return (m_tick_value_loss);
  }
  double TickSize(void) const {
    return (m_tick_size);
  }

  double ContractSize(void) const {
    return (m_contract_size);
  }
  double LotsMin(void) const {
    return (m_lots_min);
  }
  double LotsMax(void) const {
    return (m_lots_max);
  }
  double LotsStep(void) const {
    return (m_lots_step);
  }
  double LotsLimit(void) const {
    return (m_lots_limit);
  }

  double SwapLong(void) const {
    return (m_swap_long);
  }
  double SwapShort(void) const {
    return (m_swap_short);
  }

  string CurrencyBase(void) const;
  string CurrencyProfit(void) const;
  string CurrencyMargin(void) const;
  string Bank(void) const;
  string Description(void) const;
  string Path(void) const;

  long SessionDeals(void) const;
  long SessionBuyOrders(void) const;
  long SessionSellOrders(void) const;
  double SessionTurnover(void) const;
  double SessionInterest(void) const;
  double SessionBuyOrdersVolume(void) const;
  double SessionSellOrdersVolume(void) const;
  double SessionOpen(void) const;
  double SessionClose(void) const;
  double SessionAW(void) const;
  double SessionPriceSettlement(void) const;
  double SessionPriceLimitMin(void) const;
  double SessionPriceLimitMax(void) const;

  bool InfoInteger(const ENUM_SYMBOL_INFO_INTEGER prop_id, long &var) const;
  bool InfoDouble(const ENUM_SYMBOL_INFO_DOUBLE prop_id, double &var) const;
  bool InfoString(const ENUM_SYMBOL_INFO_STRING prop_id, string &var) const;
  bool InfoMarginRate(const ENUM_ORDER_TYPE order_type,
                      double &initial_margin_rate,
                      double &maintenance_margin_rate) const;

  double NormalizePrice(const double price) const;
  bool CheckMarketWatch(void);
};

CSymbolInfo::CSymbolInfo(void)
    : m_name(NULL), m_point(0.0), m_tick_value(0.0), m_tick_value_profit(0.0),
      m_tick_value_loss(0.0), m_tick_size(0.0), m_contract_size(0.0),
      m_lots_min(0.0), m_lots_max(0.0), m_lots_step(0.0), m_swap_long(0.0),
      m_swap_short(0.0), m_digits(0), m_order_mode(0), m_trade_execution(0),
      m_trade_calcmode(0), m_trade_mode(0), m_swap_mode(0), m_swap3(0),
      m_margin_initial(0.0), m_margin_maintenance(0.0),
      m_margin_hedged_use_leg(false), m_margin_hedged(0.0),
      m_trade_time_flags(0), m_trade_fill_flags(0) {}

CSymbolInfo::~CSymbolInfo(void) {}

bool CSymbolInfo::Name(const string name) {
  string symbol_name = StringLen(name) > 0 ? name : _Symbol;

  if (m_name != symbol_name) {
    m_name = symbol_name;

    if (!CheckMarketWatch())
      return (false);

    if (!Refresh()) {
      m_name = "";
      Print(__FUNCTION__ + ": invalid data of symbol '" + symbol_name + "'");
      return (false);
    }
  }

  return (true);
}

bool CSymbolInfo::Refresh(void) {
  long tmp_long = 0;

  if (!SymbolInfoDouble(m_name, SYMBOL_POINT, m_point))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_TRADE_TICK_VALUE, m_tick_value))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_TRADE_TICK_VALUE_PROFIT,
                        m_tick_value_profit))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_TRADE_TICK_VALUE_LOSS,
                        m_tick_value_loss))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_TRADE_TICK_SIZE, m_tick_size))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_TRADE_CONTRACT_SIZE, m_contract_size))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_VOLUME_MIN, m_lots_min))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_VOLUME_MAX, m_lots_max))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_VOLUME_STEP, m_lots_step))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_VOLUME_LIMIT, m_lots_limit))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_SWAP_LONG, m_swap_long))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_SWAP_SHORT, m_swap_short))
    return (false);
  if (!SymbolInfoInteger(m_name, SYMBOL_DIGITS, tmp_long))
    return (false);
  m_digits = (int)tmp_long;
  if (!SymbolInfoInteger(m_name, SYMBOL_ORDER_MODE, tmp_long))
    return (false);
  m_order_mode = (int)tmp_long;
  if (!SymbolInfoInteger(m_name, SYMBOL_TRADE_EXEMODE, tmp_long))
    return (false);
  m_trade_execution = (ENUM_SYMBOL_TRADE_EXECUTION)tmp_long;
  if (!SymbolInfoInteger(m_name, SYMBOL_TRADE_CALC_MODE, tmp_long))
    return (false);
  m_trade_calcmode = (ENUM_SYMBOL_CALC_MODE)tmp_long;
  if (!SymbolInfoInteger(m_name, SYMBOL_TRADE_MODE, tmp_long))
    return (false);
  m_trade_mode = (ENUM_SYMBOL_TRADE_MODE)tmp_long;
  if (!SymbolInfoInteger(m_name, SYMBOL_SWAP_MODE, tmp_long))
    return (false);
  m_swap_mode = (ENUM_SYMBOL_SWAP_MODE)tmp_long;
  if (!SymbolInfoInteger(m_name, SYMBOL_SWAP_ROLLOVER3DAYS, tmp_long))
    return (false);
  m_swap3 = (ENUM_DAY_OF_WEEK)tmp_long;
  if (!SymbolInfoDouble(m_name, SYMBOL_MARGIN_INITIAL, m_margin_initial))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_MARGIN_MAINTENANCE,
                        m_margin_maintenance))
    return (false);
  if (!SymbolInfoDouble(m_name, SYMBOL_MARGIN_HEDGED, m_margin_hedged))
    return (false);
  if (!SymbolInfoInteger(m_name, SYMBOL_MARGIN_HEDGED_USE_LEG, tmp_long))
    return (false);
  m_margin_hedged_use_leg = (bool)tmp_long;
  if (!SymbolInfoInteger(m_name, SYMBOL_EXPIRATION_MODE, tmp_long))
    return (false);
  m_trade_time_flags = (int)tmp_long;
  if (!SymbolInfoInteger(m_name, SYMBOL_FILLING_MODE, tmp_long))
    return (false);
  m_trade_fill_flags = (int)tmp_long;

  return (true);
}

bool CSymbolInfo::RefreshRates(void) {
  return (SymbolInfoTick(m_name, m_tick));
}

bool CSymbolInfo::Select(void) const {
  return ((bool)SymbolInfoInteger(m_name, SYMBOL_SELECT));
}

bool CSymbolInfo::Select(const bool select) {
  return (SymbolSelect(m_name, select));
}

bool CSymbolInfo::IsSynchronized(void) const {
  return (SymbolIsSynchronized(m_name));
}

ulong CSymbolInfo::VolumeHigh(void) const {
  return (SymbolInfoInteger(m_name, SYMBOL_VOLUMEHIGH));
}

ulong CSymbolInfo::VolumeLow(void) const {
  return (SymbolInfoInteger(m_name, SYMBOL_VOLUMELOW));
}

int CSymbolInfo::Spread(void) const {
  return ((int)SymbolInfoInteger(m_name, SYMBOL_SPREAD));
}

bool CSymbolInfo::SpreadFloat(void) const {
  return ((bool)SymbolInfoInteger(m_name, SYMBOL_SPREAD_FLOAT));
}

int CSymbolInfo::TicksBookDepth(void) const {
  return ((int)SymbolInfoInteger(m_name, SYMBOL_TICKS_BOOKDEPTH));
}

int CSymbolInfo::StopsLevel(void) const {
  return ((int)SymbolInfoInteger(m_name, SYMBOL_TRADE_STOPS_LEVEL));
}

int CSymbolInfo::FreezeLevel(void) const {
  return ((int)SymbolInfoInteger(m_name, SYMBOL_TRADE_FREEZE_LEVEL));
}

double CSymbolInfo::BidHigh(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_BIDHIGH));
}

double CSymbolInfo::BidLow(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_BIDLOW));
}

double CSymbolInfo::AskHigh(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_ASKHIGH));
}

double CSymbolInfo::AskLow(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_ASKLOW));
}

double CSymbolInfo::LastHigh(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_LASTHIGH));
}

double CSymbolInfo::LastLow(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_LASTLOW));
}

string CSymbolInfo::TradeCalcModeDescription(void) const {
  string str;

  switch (m_trade_calcmode) {
  case SYMBOL_CALC_MODE_FOREX:
    str = "Calculation of profit and margin for Forex";
    break;
  case SYMBOL_CALC_MODE_CFD:
    str = "Calculation of collateral and earnings for CFD";
    break;
  case SYMBOL_CALC_MODE_FUTURES:
    str = "Calculation of collateral and profits for futures";
    break;
  case SYMBOL_CALC_MODE_CFDINDEX:
    str = "Calculation of collateral and earnings for CFD on indices";
    break;
  case SYMBOL_CALC_MODE_CFDLEVERAGE:
    str = "Calculation of collateral and earnings for the CFD when trading "
          "with leverage";
    break;
  case SYMBOL_CALC_MODE_EXCH_STOCKS:
    str = "Calculation for exchange stocks";
    break;
  case SYMBOL_CALC_MODE_EXCH_FUTURES:
    str = "Calculation for exchange futures";
    break;
  case SYMBOL_CALC_MODE_EXCH_FUTURES_FORTS:
    str = "Calculation for FORTS futures";
    break;
  default:
    str = "Unknown calculation mode";
  }

  return (str);
}

string CSymbolInfo::TradeModeDescription(void) const {
  string str;

  switch (m_trade_mode) {
  case SYMBOL_TRADE_MODE_DISABLED:
    str = "Disabled";
    break;
  case SYMBOL_TRADE_MODE_LONGONLY:
    str = "Long only";
    break;
  case SYMBOL_TRADE_MODE_SHORTONLY:
    str = "Short only";
    break;
  case SYMBOL_TRADE_MODE_CLOSEONLY:
    str = "Close only";
    break;
  case SYMBOL_TRADE_MODE_FULL:
    str = "Full access";
    break;
  default:
    str = "Unknown trade mode";
  }

  return (str);
}

string CSymbolInfo::TradeExecutionDescription(void) const {
  string str;

  switch (m_trade_execution) {
  case SYMBOL_TRADE_EXECUTION_REQUEST:
    str = "Trading on request";
    break;
  case SYMBOL_TRADE_EXECUTION_INSTANT:
    str = "Trading on live streaming prices";
    break;
  case SYMBOL_TRADE_EXECUTION_MARKET:
    str = "Execution of orders on the market";
    break;
  case SYMBOL_TRADE_EXECUTION_EXCHANGE:
    str = "Exchange execution";
    break;
  default:
    str = "Unknown trade execution";
  }

  return (str);
}

string CSymbolInfo::SwapModeDescription(void) const {
  string str;

  switch (m_swap_mode) {
  case SYMBOL_SWAP_MODE_DISABLED:
    str = "No swaps";
    break;
  case SYMBOL_SWAP_MODE_POINTS:
    str = "Swaps are calculated in points";
    break;
  case SYMBOL_SWAP_MODE_CURRENCY_SYMBOL:
    str = "Swaps are calculated in base currency";
    break;
  case SYMBOL_SWAP_MODE_CURRENCY_MARGIN:
    str = "Swaps are calculated in margin currency";
    break;
  case SYMBOL_SWAP_MODE_CURRENCY_DEPOSIT:
    str = "Swaps are calculated in deposit currency";
    break;
  case SYMBOL_SWAP_MODE_INTEREST_CURRENT:
    str = "Swaps are calculated as annual interest using the current price";
    break;
  case SYMBOL_SWAP_MODE_INTEREST_OPEN:
    str = "Swaps are calculated as annual interest using the open price";
    break;
  case SYMBOL_SWAP_MODE_REOPEN_CURRENT:
    str = "Swaps are charged by reopening positions at the close price";
    break;
  case SYMBOL_SWAP_MODE_REOPEN_BID:
    str = "Swaps are charged by reopening positions at the Bid price";
    break;
  default:
    str = "Unknown swap mode";
  }

  return (str);
}

string CSymbolInfo::SwapRollover3daysDescription(void) const {
  string str;

  switch (m_swap3) {
  case SUNDAY:
    str = "Sunday";
    break;
  case MONDAY:
    str = "Monday";
    break;
  case TUESDAY:
    str = "Tuesday";
    break;
  case WEDNESDAY:
    str = "Wednesday";
    break;
  case THURSDAY:
    str = "Thursday";
    break;
  case FRIDAY:
    str = "Friday";
    break;
  case SATURDAY:
    str = "Saturday";
    break;
  default:
    str = "Unknown";
  }

  return (str);
}

datetime CSymbolInfo::StartTime(void) const {
  return ((datetime)SymbolInfoInteger(m_name, SYMBOL_START_TIME));
}

datetime CSymbolInfo::ExpirationTime(void) const {
  return ((datetime)SymbolInfoInteger(m_name, SYMBOL_EXPIRATION_TIME));
}

string CSymbolInfo::CurrencyBase(void) const {
  return (SymbolInfoString(m_name, SYMBOL_CURRENCY_BASE));
}

string CSymbolInfo::CurrencyProfit(void) const {
  return (SymbolInfoString(m_name, SYMBOL_CURRENCY_PROFIT));
}

string CSymbolInfo::CurrencyMargin(void) const {
  return (SymbolInfoString(m_name, SYMBOL_CURRENCY_MARGIN));
}

string CSymbolInfo::Bank(void) const {
  return (SymbolInfoString(m_name, SYMBOL_BANK));
}

string CSymbolInfo::Description(void) const {
  return (SymbolInfoString(m_name, SYMBOL_DESCRIPTION));
}

string CSymbolInfo::Path(void) const {
  return (SymbolInfoString(m_name, SYMBOL_PATH));
}

long CSymbolInfo::SessionDeals(void) const {
  return (SymbolInfoInteger(m_name, SYMBOL_SESSION_DEALS));
}

long CSymbolInfo::SessionBuyOrders(void) const {
  return (SymbolInfoInteger(m_name, SYMBOL_SESSION_BUY_ORDERS));
}

long CSymbolInfo::SessionSellOrders(void) const {
  return (SymbolInfoInteger(m_name, SYMBOL_SESSION_SELL_ORDERS));
}

double CSymbolInfo::SessionTurnover(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_TURNOVER));
}

double CSymbolInfo::SessionInterest(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_INTEREST));
}

double CSymbolInfo::SessionBuyOrdersVolume(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_BUY_ORDERS_VOLUME));
}

double CSymbolInfo::SessionSellOrdersVolume(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_SELL_ORDERS_VOLUME));
}

double CSymbolInfo::SessionOpen(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_OPEN));
}

double CSymbolInfo::SessionClose(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_CLOSE));
}

double CSymbolInfo::SessionAW(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_AW));
}

double CSymbolInfo::SessionPriceSettlement(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_PRICE_SETTLEMENT));
}

double CSymbolInfo::SessionPriceLimitMin(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_PRICE_LIMIT_MIN));
}

double CSymbolInfo::SessionPriceLimitMax(void) const {
  return (SymbolInfoDouble(m_name, SYMBOL_SESSION_PRICE_LIMIT_MAX));
}

bool CSymbolInfo::InfoInteger(const ENUM_SYMBOL_INFO_INTEGER prop_id,
                              long &var) const {
  return (SymbolInfoInteger(m_name, prop_id, var));
}

bool CSymbolInfo::InfoDouble(const ENUM_SYMBOL_INFO_DOUBLE prop_id,
                             double &var) const {
  return (SymbolInfoDouble(m_name, prop_id, var));
}

bool CSymbolInfo::InfoString(const ENUM_SYMBOL_INFO_STRING prop_id,
                             string &var) const {
  return (SymbolInfoString(m_name, prop_id, var));
}

bool CSymbolInfo::InfoMarginRate(const ENUM_ORDER_TYPE order_type,
                                 double &initial_margin_rate,
                                 double &maintenance_margin_rate) const {
  return (SymbolInfoMarginRate(m_name, order_type, initial_margin_rate,
                               maintenance_margin_rate));
}

double CSymbolInfo::NormalizePrice(const double price) const {
  if (m_tick_size != 0)
    return (NormalizeDouble(MathRound(price / m_tick_size) * m_tick_size,
                            m_digits));

  return (NormalizeDouble(price, m_digits));
}

bool CSymbolInfo::CheckMarketWatch(void) {

  if (!Select()) {
    if (GetLastError() == ERR_MARKET_UNKNOWN_SYMBOL) {
      printf(__FUNCTION__ + ": Unknown symbol '%s'", m_name);
      return (false);
    }
    if (!Select(true)) {
      printf(__FUNCTION__ + ": Error adding symbol %d", GetLastError());
      return (false);
    }
  }

  return (true);
}

#endif
