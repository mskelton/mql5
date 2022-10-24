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

  string Name(void) const;
  bool Name(const string name);
  bool Refresh(void);
  bool RefreshRates(void);

  bool Select(void) const;
  bool Select(const bool select);
  bool IsSynchronized(void) const;

  ulong Volume(void) const;
  ulong VolumeHigh(void) const;
  ulong VolumeLow(void) const;

  datetime Time(void) const;
  int Spread(void) const;
  bool SpreadFloat(void) const;
  int TicksBookDepth(void) const;

  int StopsLevel(void) const;
  int FreezeLevel(void) const;

  double Bid(void) const;
  double BidHigh(void) const;
  double BidLow(void) const;

  double Ask(void) const;
  double AskHigh(void) const;
  double AskLow(void) const;

  double Last(void) const;
  double LastHigh(void) const;
  double LastLow(void) const;

  int OrderMode(void) const;

  ENUM_SYMBOL_CALC_MODE TradeCalcMode(void) const;
  string TradeCalcModeDescription(void) const;
  ENUM_SYMBOL_TRADE_MODE TradeMode(void) const;
  string TradeModeDescription(void) const;

  ENUM_SYMBOL_TRADE_EXECUTION TradeExecution(void) const;
  string TradeExecutionDescription(void) const;

  ENUM_SYMBOL_SWAP_MODE SwapMode(void) const;
  string SwapModeDescription(void) const;
  ENUM_DAY_OF_WEEK SwapRollover3days(void) const;
  string SwapRollover3daysDescription(void) const;

  datetime StartTime(void) const;
  datetime ExpirationTime(void) const;

  double MarginInitial(void) const;
  double MarginMaintenance(void) const;
  bool MarginHedgedUseLeg(void) const;
  double MarginHedged(void) const;

  double MarginLong(void) const;
  double MarginShort(void) const;
  double MarginLimit(void) const;
  double MarginStop(void) const;
  double MarginStopLimit(void) const;

  int TradeTimeFlags(void) const;
  int TradeFillFlags(void) const;

  int Digits(void) const;
  double Point(void) const;
  double TickValue(void) const;
  double TickValueProfit(void) const;
  double TickValueLoss(void) const;
  double TickSize(void) const;

  double ContractSize(void) const;
  double LotsMin(void) const;
  double LotsMax(void) const;
  double LotsStep(void) const;
  double LotsLimit(void) const;

  double SwapLong(void) const;
  double SwapShort(void) const;

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

#endif
