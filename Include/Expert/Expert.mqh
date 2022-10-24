#ifndef EXPERT_H
#define EXPERT_H

#include "ExpertBase.mqh"
#include "ExpertMoney.mqh"
#include "ExpertSignal.mqh"
#include "ExpertTrade.mqh"
#include "ExpertTrailing.mqh"

enum ENUM_TRADE_EVENTS {
  TRADE_EVENT_NO_EVENT = 0,
  TRADE_EVENT_POSITION_OPEN = 0x1,
  TRADE_EVENT_POSITION_VOLUME_CHANGE = 0x2,
  TRADE_EVENT_POSITION_MODIFY = 0x4,
  TRADE_EVENT_POSITION_CLOSE = 0x8,
  TRADE_EVENT_POSITION_STOP_TAKE = 0x10,
  TRADE_EVENT_ORDER_PLACE = 0x20,
  TRADE_EVENT_ORDER_MODIFY = 0x40,
  TRADE_EVENT_ORDER_DELETE = 0x80,
  TRADE_EVENT_ORDER_TRIGGER = 0x100
};

#define IS_WAITING_POSITION_OPENED                                             \
  ((m_waiting_event & TRADE_EVENT_POSITION_OPEN) != 0)
#define IS_WAITING_POSITION_VOLUME_CHANGED                                     \
  ((m_waiting_event & TRADE_EVENT_POSITION_VOLUME_CHANGE) != 0)
#define IS_WAITING_POSITION_MODIFIED                                           \
  ((m_waiting_event & TRADE_EVENT_POSITION_MODIFY) != 0)
#define IS_WAITING_POSITION_CLOSED                                             \
  ((m_waiting_event & TRADE_EVENT_POSITION_CLOSE) != 0)
#define IS_WAITING_POSITION_STOP_TAKE                                          \
  ((m_waiting_event & TRADE_EVENT_POSITION_STOP_TAKE) != 0)
#define IS_WAITING_ORDER_PLACED                                                \
  ((m_waiting_event & TRADE_EVENT_ORDER_PLACE) != 0)
#define IS_WAITING_ORDER_MODIFIED                                              \
  ((m_waiting_event & TRADE_EVENT_ORDER_MODIFY) != 0)
#define IS_WAITING_ORDER_DELETED                                               \
  ((m_waiting_event & TRADE_EVENT_ORDER_DELETE) != 0)
#define IS_WAITING_ORDER_TRIGGERED                                             \
  ((m_waiting_event & TRADE_EVENT_ORDER_TRIGGER) != 0)

class CExpert : public CExpertBase {
protected:
  int m_period_flags;
  int m_max_orders;
  MqlDateTime m_last_tick_time;
  datetime m_expiration;

  int m_pos_tot;
  int m_deal_tot;
  int m_ord_tot;
  int m_hist_ord_tot;
  datetime m_beg_date;

  int m_waiting_event;

  CExpertTrade *m_trade;
  CExpertSignal *m_signal;
  CExpertMoney *m_money;
  CExpertTrailing *m_trailing;
  bool m_check_volume;

  CIndicators m_indicators;

  CPositionInfo m_position;
  COrderInfo m_order;

  bool m_on_tick_process;
  bool m_on_trade_process;
  bool m_on_timer_process;
  bool m_on_chart_event_process;
  bool m_on_book_event_process;

public:
  CExpert(void);
  ~CExpert(void);

  bool Init(string symbol, ENUM_TIMEFRAMES period, bool every_tick,
            ulong magic = 0);
  void Magic(ulong value);
  void CheckVolumeBeforeTrade(const bool flag) ;

  virtual bool InitSignal(CExpertSignal *signal = NULL);
  virtual bool InitTrailing(CExpertTrailing *trailing = NULL);
  virtual bool InitMoney(CExpertMoney *money = NULL);
  virtual bool InitTrade(ulong magic, CExpertTrade *trade = NULL);

  virtual void Deinit(void);

  void OnTickProcess(bool value) ;
  void OnTradeProcess(bool value) ;
  void OnTimerProcess(bool value) ;
  void OnChartEventProcess(bool value) ;
  void OnBookEventProcess(bool value) ;
  int MaxOrders(void) const ;
  void MaxOrders(int value) ;

  CExpertSignal *Signal(void) const ;

  virtual bool ValidationSettings();

  virtual bool InitIndicators(CIndicators *indicators = NULL);

  virtual void OnTick(void);
  virtual void OnTrade(void);
  virtual void OnTimer(void);
  virtual void OnChartEvent(const int id, const long &lparam,
                            const double &dparam, const string &sparam);
  virtual void OnBookEvent(const string &symbol);

protected:
  virtual bool InitParameters(void) ;

  virtual void DeinitTrade(void);
  virtual void DeinitSignal(void);
  virtual void DeinitTrailing(void);
  virtual void DeinitMoney(void);
  virtual void DeinitIndicators(void);

  virtual bool Refresh(void);

  virtual bool SelectPosition(void);

  virtual bool Processing(void);

  virtual bool CheckOpen(void);
  virtual bool CheckOpenLong(void);
  virtual bool CheckOpenShort(void);

  virtual bool OpenLong(double price, double sl, double tp);
  virtual bool OpenShort(double price, double sl, double tp);

  virtual bool CheckReverse(void);
  virtual bool CheckReverseLong(void);
  virtual bool CheckReverseShort(void);

  virtual bool ReverseLong(double price, double sl, double tp);
  virtual bool ReverseShort(double price, double sl, double tp);

  virtual bool CheckClose(void);
  virtual bool CheckCloseLong(void);
  virtual bool CheckCloseShort(void);

  virtual bool CloseAll(double lot);
  virtual bool Close(void);
  virtual bool CloseLong(double price);
  virtual bool CloseShort(double price);

  virtual bool CheckTrailingStop(void);
  virtual bool CheckTrailingStopLong(void);
  virtual bool CheckTrailingStopShort(void);

  virtual bool TrailingStopLong(double sl, double tp);
  virtual bool TrailingStopShort(double sl, double tp);

  virtual bool CheckTrailingOrderLong(void);
  virtual bool CheckTrailingOrderShort(void);

  virtual bool TrailingOrderLong(double delta);
  virtual bool TrailingOrderShort(double delta);

  virtual bool CheckDeleteOrderLong(void);
  virtual bool CheckDeleteOrderShort(void);

  virtual bool DeleteOrders(void);
  virtual bool DeleteOrdersLong(void);
  virtual bool DeleteOrdersShort(void);
  virtual bool DeleteOrder(void);
  virtual bool DeleteOrderLong(void);
  virtual bool DeleteOrderShort(void);

  double LotOpenLong(double price, double sl);
  double LotOpenShort(double price, double sl);
  double LotReverse(double sl);
  double LotCheck(double volume, double price, ENUM_ORDER_TYPE order_type);

  void PrepareHistoryDate(void);
  void HistoryPoint(bool from_check_trade = false);
  bool CheckTradeState(void);

  void WaitEvent(ENUM_TRADE_EVENTS event) ;
  void NoWaitEvent(ENUM_TRADE_EVENTS event) ;

  virtual bool TradeEventPositionStopTake(void) ;
  virtual bool TradeEventOrderTriggered(void) ;
  virtual bool TradeEventPositionOpened(void) ;
  virtual bool TradeEventPositionVolumeChanged(void) ;
  virtual bool TradeEventPositionModified(void) ;
  virtual bool TradeEventPositionClosed(void) ;
  virtual bool TradeEventOrderPlaced(void) ;
  virtual bool TradeEventOrderModified(void) ;
  virtual bool TradeEventOrderDeleted(void) ;
  virtual bool TradeEventNotIdentified(void) ;

  void TimeframeAdd(ENUM_TIMEFRAMES period);
  int TimeframesFlags(MqlDateTime &time);
};




































































#endif
