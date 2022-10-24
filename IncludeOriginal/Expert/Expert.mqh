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
  void CheckVolumeBeforeTrade(const bool flag) {
    m_check_volume = flag;
  }

  virtual bool InitSignal(CExpertSignal *signal = NULL);
  virtual bool InitTrailing(CExpertTrailing *trailing = NULL);
  virtual bool InitMoney(CExpertMoney *money = NULL);
  virtual bool InitTrade(ulong magic, CExpertTrade *trade = NULL);

  virtual void Deinit(void);

  void OnTickProcess(bool value) {
    m_on_tick_process = value;
  }
  void OnTradeProcess(bool value) {
    m_on_trade_process = value;
  }
  void OnTimerProcess(bool value) {
    m_on_timer_process = value;
  }
  void OnChartEventProcess(bool value) {
    m_on_chart_event_process = value;
  }
  void OnBookEventProcess(bool value) {
    m_on_book_event_process = value;
  }
  int MaxOrders(void) const {
    return (m_max_orders);
  }
  void MaxOrders(int value) {
    m_max_orders = value;
  }

  CExpertSignal *Signal(void) const {
    return (m_signal);
  }

  virtual bool ValidationSettings();

  virtual bool InitIndicators(CIndicators *indicators = NULL);

  virtual void OnTick(void);
  virtual void OnTrade(void);
  virtual void OnTimer(void);
  virtual void OnChartEvent(const int id, const long &lparam,
                            const double &dparam, const string &sparam);
  virtual void OnBookEvent(const string &symbol);

protected:
  virtual bool InitParameters(void) {
    return (true);
  }

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

  void WaitEvent(ENUM_TRADE_EVENTS event) {
    m_waiting_event |= event;
  }
  void NoWaitEvent(ENUM_TRADE_EVENTS event) {
    m_waiting_event &= ~event;
  }

  virtual bool TradeEventPositionStopTake(void) {
    return (true);
  }
  virtual bool TradeEventOrderTriggered(void) {
    return (true);
  }
  virtual bool TradeEventPositionOpened(void) {
    return (true);
  }
  virtual bool TradeEventPositionVolumeChanged(void) {
    return (true);
  }
  virtual bool TradeEventPositionModified(void) {
    return (true);
  }
  virtual bool TradeEventPositionClosed(void) {
    return (true);
  }
  virtual bool TradeEventOrderPlaced(void) {
    return (true);
  }
  virtual bool TradeEventOrderModified(void) {
    return (true);
  }
  virtual bool TradeEventOrderDeleted(void) {
    return (true);
  }
  virtual bool TradeEventNotIdentified(void) {
    return (true);
  }

  void TimeframeAdd(ENUM_TIMEFRAMES period);
  int TimeframesFlags(MqlDateTime &time);
};

CExpert::CExpert(void)
    : m_period_flags(0), m_expiration(0), m_pos_tot(0), m_deal_tot(0),
      m_ord_tot(0), m_hist_ord_tot(0), m_beg_date(0), m_trade(NULL),
      m_signal(NULL), m_money(NULL), m_trailing(NULL), m_check_volume(false),
      m_on_tick_process(true), m_on_trade_process(false),
      m_on_timer_process(false), m_on_chart_event_process(false),
      m_on_book_event_process(false), m_max_orders(1) {
  m_other_symbol = true;
  m_other_period = true;
  m_adjusted_point = 10;
  m_period = WRONG_VALUE;
  m_last_tick_time.min = -1;
}

CExpert::~CExpert(void) {
  Deinit();
}

bool CExpert::Init(string symbol, ENUM_TIMEFRAMES period, bool every_tick,
                   ulong magic) {

  if (symbol != ::Symbol() || period != ::Period()) {
    PrintFormat(__FUNCTION__ + ": wrong symbol or timeframe (must be %s:%s)",
                symbol, EnumToString(period));
    return (false);
  }

  if (m_symbol == NULL) {
    if ((m_symbol = new CSymbolInfo) == NULL)
      return (false);
  }
  if (!m_symbol.Name(symbol))
    return (false);
  m_period = period;
  m_every_tick = every_tick;
  m_magic = magic;
  SetMarginMode();
  if (every_tick)
    TimeframeAdd(WRONG_VALUE);
  else
    TimeframeAdd(period);

  int digits_adjust =
      (m_symbol.Digits() == 3 || m_symbol.Digits() == 5) ? 10 : 1;
  m_adjusted_point = m_symbol.Point() * digits_adjust;

  if (!InitTrade(magic)) {
    Print(__FUNCTION__ + ": error initialization trade object");
    return (false);
  }
  if (!InitSignal()) {
    Print(__FUNCTION__ + ": error initialization signal object");
    return (false);
  }
  if (!InitTrailing()) {
    Print(__FUNCTION__ + ": error initialization trailing object");
    return (false);
  }
  if (!InitMoney()) {
    Print(__FUNCTION__ + ": error initialization money object");
    return (false);
  }
  if (!InitParameters()) {
    Print(__FUNCTION__ + ": error initialization parameters");
    return (false);
  }

  PrepareHistoryDate();
  HistoryPoint();

  m_init_phase = INIT_PHASE_TUNING;

  return (true);
}

void CExpert::Magic(ulong value) {
  if (m_trade != NULL)
    m_trade.SetExpertMagicNumber(value);
  if (m_signal != NULL)
    m_signal.Magic(value);
  if (m_money != NULL)
    m_money.Magic(value);
  if (m_trailing != NULL)
    m_trailing.Magic(value);

  CExpertBase::Magic(value);
}

bool CExpert::InitTrade(ulong magic, CExpertTrade *trade = NULL) {

  if (m_trade != NULL)
    delete m_trade;

  if (trade == NULL) {
    if ((m_trade = new CExpertTrade) == NULL)
      return (false);
  } else
    m_trade = trade;

  m_trade.SetSymbol(GetPointer(m_symbol));
  m_trade.SetExpertMagicNumber(magic);
  m_trade.SetMarginMode();

  m_trade.SetDeviationInPoints(
      (ulong)(3 * m_adjusted_point / m_symbol.Point()));

  return (true);
}

bool CExpert::InitSignal(CExpertSignal *signal) {
  if (m_signal != NULL)
    delete m_signal;

  if (signal == NULL) {
    if ((m_signal = new CExpertSignal) == NULL)
      return (false);
  } else
    m_signal = signal;

  if (!m_signal.Init(GetPointer(m_symbol), m_period, m_adjusted_point))
    return (false);
  m_signal.EveryTick(m_every_tick);
  m_signal.Magic(m_magic);

  return (true);
}

bool CExpert::InitTrailing(CExpertTrailing *trailing) {
  if (m_trailing != NULL)
    delete m_trailing;

  if (trailing == NULL) {
    if ((m_trailing = new CExpertTrailing) == NULL)
      return (false);
  } else
    m_trailing = trailing;

  if (!m_trailing.Init(GetPointer(m_symbol), m_period, m_adjusted_point))
    return (false);
  m_trailing.EveryTick(m_every_tick);
  m_trailing.Magic(m_magic);

  return (true);
}

bool CExpert::InitMoney(CExpertMoney *money) {
  if (m_money != NULL)
    delete m_money;

  if (money == NULL) {
    if ((m_money = new CExpertMoney) == NULL)
      return (false);
  } else
    m_money = money;

  if (!m_money.Init(GetPointer(m_symbol), m_period, m_adjusted_point))
    return (false);
  m_money.EveryTick(m_every_tick);
  m_money.Magic(m_magic);

  return (true);
}

bool CExpert::ValidationSettings(void) {
  if (!CExpertBase::ValidationSettings())
    return (false);

  if (!m_signal.ValidationSettings()) {
    Print(__FUNCTION__ + ": error signal parameters");
    return (false);
  }

  if (!m_trailing.ValidationSettings()) {
    Print(__FUNCTION__ + ": error trailing parameters");
    return (false);
  }

  if (!m_money.ValidationSettings()) {
    Print(__FUNCTION__ + ": error money parameters");
    return (false);
  }

  return (true);
}

bool CExpert::InitIndicators(CIndicators *indicators) {

  CIndicators *indicators_ptr = GetPointer(m_indicators);

  m_used_series |= m_signal.UsedSeries();
  m_used_series |= m_trailing.UsedSeries();
  m_used_series |= m_money.UsedSeries();

  if (!CExpertBase::InitIndicators(indicators_ptr))
    return (false);
  m_signal.SetPriceSeries(m_open, m_high, m_low, m_close);
  m_signal.SetOtherSeries(m_spread, m_time, m_tick_volume, m_real_volume);
  if (!m_signal.InitIndicators(indicators_ptr)) {
    Print(__FUNCTION__ + ": error initialization indicators of signal object");
    return (false);
  }
  m_trailing.SetPriceSeries(m_open, m_high, m_low, m_close);
  m_trailing.SetOtherSeries(m_spread, m_time, m_tick_volume, m_real_volume);
  if (!m_trailing.InitIndicators(indicators_ptr)) {
    Print(__FUNCTION__ +
          ": error initialization indicators of trailing object");
    return (false);
  }
  m_money.SetPriceSeries(m_open, m_high, m_low, m_close);
  m_money.SetOtherSeries(m_spread, m_time, m_tick_volume, m_real_volume);
  if (!m_money.InitIndicators(indicators_ptr)) {
    Print(__FUNCTION__ + ": error initialization indicators of money object");
    return (false);
  }

  return (true);
}

void CExpert::Deinit(void) {

  DeinitTrade();

  DeinitSignal();

  DeinitTrailing();

  DeinitMoney();

  DeinitIndicators();
}

void CExpert::DeinitTrade(void) {
  if (m_trade != NULL) {
    delete m_trade;
    m_trade = NULL;
  }
}

void CExpert::DeinitSignal(void) {
  if (m_signal != NULL) {
    delete m_signal;
    m_signal = NULL;
  }
}

void CExpert::DeinitTrailing(void) {
  if (m_trailing != NULL) {
    delete m_trailing;
    m_trailing = NULL;
  }
}

void CExpert::DeinitMoney(void) {
  if (m_money != NULL) {
    delete m_money;
    m_money = NULL;
  }
}

void CExpert::DeinitIndicators(void) {
  m_indicators.Clear();
}

bool CExpert::Refresh(void) {
  MqlDateTime time;

  if (!m_symbol.RefreshRates())
    return (false);

  TimeToStruct(m_symbol.Time(), time);
  if (m_period_flags != WRONG_VALUE && m_period_flags != 0)
    if ((m_period_flags & TimeframesFlags(time)) == 0)
      return (false);
  m_last_tick_time = time;

  m_indicators.Refresh();

  return (true);
}

bool CExpert::SelectPosition(void) {
  bool res = false;

  if (IsHedging())
    res = m_position.SelectByMagic(m_symbol.Name(), m_magic);
  else
    res = m_position.Select(m_symbol.Name());

  return (res);
}

bool CExpert::Processing(void) {

  m_signal.SetDirection();

  if (SelectPosition()) {

    if (CheckReverse())
      return (true);

    if (!CheckClose()) {

      if (CheckTrailingStop())
        return (true);

      return (false);
    }
  }

  int total = OrdersTotal();
  if (total != 0) {
    for (int i = total - 1; i >= 0; i--) {
      m_order.SelectByIndex(i);
      if (m_order.Symbol() != m_symbol.Name())
        continue;
      if (m_order.OrderType() == ORDER_TYPE_BUY_LIMIT ||
          m_order.OrderType() == ORDER_TYPE_BUY_STOP) {

        if (CheckDeleteOrderLong())
          return (true);

        if (CheckTrailingOrderLong())
          return (true);
      } else {

        if (CheckDeleteOrderShort())
          return (true);

        if (CheckTrailingOrderShort())
          return (true);
      }

      return (false);
    }
  }

  if (CheckOpen())
    return (true);

  return (false);
}

void CExpert::OnTick(void) {

  if (!m_on_tick_process)
    return;

  if (!Refresh())
    return;

  Processing();
}

void CExpert::OnTrade(void) {

  if (!m_on_trade_process)
    return;
  CheckTradeState();
}

void CExpert::OnTimer(void) {

  if (!m_on_timer_process)
    return;
}

void CExpert::OnChartEvent(const int id, const long &lparam,
                           const double &dparam, const string &sparam) {

  if (!m_on_chart_event_process)
    return;
}

void CExpert::OnBookEvent(const string &symbol) {

  if (!m_on_book_event_process)
    return;
}

bool CExpert::CheckOpen(void) {
  if (CheckOpenLong())
    return (true);
  if (CheckOpenShort())
    return (true);

  return (false);
}

bool CExpert::CheckOpenLong(void) {
  double price = EMPTY_VALUE;
  double sl = 0.0;
  double tp = 0.0;
  datetime expiration = TimeCurrent();

  if (m_signal.CheckOpenLong(price, sl, tp, expiration)) {
    if (!m_trade.SetOrderExpiration(expiration))
      m_expiration = expiration;
    return (OpenLong(price, sl, tp));
  }

  return (false);
}

bool CExpert::CheckOpenShort(void) {
  double price = EMPTY_VALUE;
  double sl = 0.0;
  double tp = 0.0;
  datetime expiration = TimeCurrent();

  if (m_signal.CheckOpenShort(price, sl, tp, expiration)) {
    if (!m_trade.SetOrderExpiration(expiration))
      m_expiration = expiration;
    return (OpenShort(price, sl, tp));
  }

  return (false);
}

bool CExpert::OpenLong(double price, double sl, double tp) {
  if (price == EMPTY_VALUE)
    return (false);

  double lot = LotOpenLong(price, sl);

  lot = LotCheck(lot, price, ORDER_TYPE_BUY);
  if (lot == 0.0)
    return (false);

  return (m_trade.Buy(lot, price, sl, tp));
}

bool CExpert::OpenShort(double price, double sl, double tp) {
  if (price == EMPTY_VALUE)
    return (false);

  double lot = LotOpenShort(price, sl);

  lot = LotCheck(lot, price, ORDER_TYPE_SELL);
  if (lot == 0.0)
    return (false);

  return (m_trade.Sell(lot, price, sl, tp));
}

bool CExpert::CheckReverse(void) {
  if (m_position.PositionType() == POSITION_TYPE_BUY) {

    if (CheckReverseLong())
      return (true);
  } else {

    if (CheckReverseShort())
      return (true);
  }

  return (false);
}

bool CExpert::CheckReverseLong(void) {
  double price = EMPTY_VALUE;
  double sl = 0.0;
  double tp = 0.0;
  datetime expiration = TimeCurrent();

  if (m_signal.CheckReverseLong(price, sl, tp, expiration))
    return (ReverseLong(price, sl, tp));

  return (false);
}

bool CExpert::CheckReverseShort(void) {
  double price = EMPTY_VALUE;
  double sl = 0.0;
  double tp = 0.0;
  datetime expiration = TimeCurrent();

  if (m_signal.CheckReverseShort(price, sl, tp, expiration))
    return (ReverseShort(price, sl, tp));

  return (false);
}

bool CExpert::ReverseLong(double price, double sl, double tp) {
  if (price == EMPTY_VALUE)
    return (false);

  double lot = LotReverse(sl);

  if (lot == 0.0)
    return (false);

  bool result = true;
  if (IsHedging()) {

    lot -= m_position.Volume();
    result = m_trade.PositionClose(m_position.Ticket());
  }
  if (result) {
    lot = LotCheck(lot, price, ORDER_TYPE_SELL);
    if (lot == 0.0)
      result = false;
    else
      result = m_trade.Sell(lot, price, sl, tp);
  }

  return (result);
}

bool CExpert::ReverseShort(double price, double sl, double tp) {
  if (price == EMPTY_VALUE)
    return (false);

  double lot = LotReverse(sl);

  if (lot == 0.0)
    return (false);

  bool result = true;
  if (IsHedging()) {

    lot -= m_position.Volume();
    result = m_trade.PositionClose(m_position.Ticket());
  }
  if (result) {
    lot = LotCheck(lot, price, ORDER_TYPE_BUY);
    if (lot == 0.0)
      result = false;
    else
      result = m_trade.Buy(lot, price, sl, tp);
  }

  return (result);
}

bool CExpert::CheckClose(void) {
  double lot;

  if ((lot = m_money.CheckClose(GetPointer(m_position))) != 0.0)
    return (CloseAll(lot));

  if (m_position.PositionType() == POSITION_TYPE_BUY) {

    if (CheckCloseLong()) {
      DeleteOrdersLong();
      return (true);
    }
  } else {

    if (CheckCloseShort()) {
      DeleteOrdersShort();
      return (true);
    }
  }

  return (false);
}

bool CExpert::CheckCloseLong(void) {
  double price = EMPTY_VALUE;

  if (m_signal.CheckCloseLong(price))
    return (CloseLong(price));

  return (false);
}

bool CExpert::CheckCloseShort(void) {
  double price = EMPTY_VALUE;

  if (m_signal.CheckCloseShort(price))
    return (CloseShort(price));

  return (false);
}

bool CExpert::CloseAll(double lot) {
  bool result = false;

  if (IsHedging())
    result = m_trade.PositionClose(m_position.Ticket());
  else {
    if (m_position.PositionType() == POSITION_TYPE_BUY)
      result = m_trade.Sell(lot, 0, 0, 0);
    else
      result = m_trade.Buy(lot, 0, 0, 0);
  }
  result |= DeleteOrders();

  return (result);
}

bool CExpert::Close(void) {
  return (m_trade.PositionClose(m_symbol.Name()));
}

bool CExpert::CloseLong(double price) {
  bool result = false;

  if (price == EMPTY_VALUE)
    return (false);
  if (IsHedging())
    result = m_trade.PositionClose(m_position.Ticket());
  else
    result = m_trade.Sell(m_position.Volume(), price, 0, 0);

  return (result);
}

bool CExpert::CloseShort(double price) {
  bool result = false;

  if (price == EMPTY_VALUE)
    return (false);
  if (IsHedging())
    result = m_trade.PositionClose(m_position.Ticket());
  else
    result = m_trade.Buy(m_position.Volume(), price, 0, 0);

  return (result);
}

bool CExpert::CheckTrailingStop(void) {

  if (m_position.PositionType() == POSITION_TYPE_BUY) {

    if (CheckTrailingStopLong())
      return (true);
  } else {

    if (CheckTrailingStopShort())
      return (true);
  }

  return (false);
}

bool CExpert::CheckTrailingStopLong(void) {
  double sl = EMPTY_VALUE;
  double tp = EMPTY_VALUE;

  if (m_trailing.CheckTrailingStopLong(GetPointer(m_position), sl, tp)) {
    double position_sl = m_position.StopLoss();
    double position_tp = m_position.TakeProfit();
    if (sl == EMPTY_VALUE)
      sl = position_sl;
    else
      sl = m_symbol.NormalizePrice(sl);
    if (tp == EMPTY_VALUE)
      tp = position_tp;
    else
      tp = m_symbol.NormalizePrice(tp);
    if (sl == position_sl && tp == position_tp)
      return (false);

    return (TrailingStopLong(sl, tp));
  }

  return (false);
}

bool CExpert::CheckTrailingStopShort(void) {
  double sl = EMPTY_VALUE;
  double tp = EMPTY_VALUE;

  if (m_trailing.CheckTrailingStopShort(GetPointer(m_position), sl, tp)) {
    double position_sl = m_position.StopLoss();
    double position_tp = m_position.TakeProfit();
    if (sl == EMPTY_VALUE)
      sl = position_sl;
    else
      sl = m_symbol.NormalizePrice(sl);
    if (tp == EMPTY_VALUE)
      tp = position_tp;
    else
      tp = m_symbol.NormalizePrice(tp);
    if (sl == position_sl && tp == position_tp)
      return (false);

    return (TrailingStopShort(sl, tp));
  }

  return (false);
}

bool CExpert::TrailingStopLong(double sl, double tp) {
  bool result;

  if (IsHedging())
    result = m_trade.PositionModify(m_position.Ticket(), sl, tp);
  else
    result = m_trade.PositionModify(m_symbol.Name(), sl, tp);

  return (result);
}

bool CExpert::TrailingStopShort(double sl, double tp) {
  bool result;

  if (IsHedging())
    result = m_trade.PositionModify(m_position.Ticket(), sl, tp);
  else
    result = m_trade.PositionModify(m_symbol.Name(), sl, tp);

  return (result);
}

bool CExpert::CheckTrailingOrderLong(void) {
  double price;

  if (m_signal.CheckTrailingOrderLong(GetPointer(m_order), price))
    return (TrailingOrderLong(m_order.PriceOpen() - price));

  return (false);
}

bool CExpert::CheckTrailingOrderShort(void) {
  double price;

  if (m_signal.CheckTrailingOrderShort(GetPointer(m_order), price))
    return (TrailingOrderShort(m_order.PriceOpen() - price));

  return (false);
}

bool CExpert::TrailingOrderLong(double delta) {
  ulong ticket = m_order.Ticket();
  double price = m_symbol.NormalizePrice(m_order.PriceOpen() - delta);
  double sl = m_symbol.NormalizePrice(m_order.StopLoss() - delta);
  double tp = m_symbol.NormalizePrice(m_order.TakeProfit() - delta);

  return (m_trade.OrderModify(ticket, price, sl, tp, m_order.TypeTime(),
                              m_order.TimeExpiration()));
}

bool CExpert::TrailingOrderShort(double delta) {
  ulong ticket = m_order.Ticket();
  double price = m_symbol.NormalizePrice(m_order.PriceOpen() - delta);
  double sl = m_symbol.NormalizePrice(m_order.StopLoss() - delta);
  double tp = m_symbol.NormalizePrice(m_order.TakeProfit() - delta);

  return (m_trade.OrderModify(ticket, price, sl, tp, m_order.TypeTime(),
                              m_order.TimeExpiration()));
}

bool CExpert::CheckDeleteOrderLong(void) {
  double price;

  if (m_expiration != 0 && TimeCurrent() > m_expiration) {
    m_expiration = 0;
    return (DeleteOrderLong());
  }
  if (m_signal.CheckCloseLong(price))
    return (DeleteOrderLong());

  return (false);
}

bool CExpert::CheckDeleteOrderShort(void) {
  double price;

  if (m_expiration != 0 && TimeCurrent() > m_expiration) {
    m_expiration = 0;
    return (DeleteOrderShort());
  }
  if (m_signal.CheckCloseShort(price))
    return (DeleteOrderShort());

  return (false);
}

bool CExpert::DeleteOrders(void) {
  bool result = true;
  int total = OrdersTotal();

  for (int i = total - 1; i >= 0; i--)
    if (m_order.Select(OrderGetTicket(i))) {
      if (m_order.Symbol() != m_symbol.Name())
        continue;
      result &= DeleteOrder();
    }

  return (result);
}

bool CExpert::DeleteOrdersLong(void) {
  bool result = true;
  int total = OrdersTotal();

  for (int i = total - 1; i >= 0; i--)
    if (m_order.Select(OrderGetTicket(i))) {
      if (m_order.Symbol() != m_symbol.Name())
        continue;
      if (m_order.OrderType() != ORDER_TYPE_BUY_STOP &&
          m_order.OrderType() != ORDER_TYPE_BUY_LIMIT)
        continue;
      result &= DeleteOrder();
    }

  return (result);
}

bool CExpert::DeleteOrdersShort(void) {
  bool result = true;
  int total = OrdersTotal();

  for (int i = total - 1; i >= 0; i--)
    if (m_order.Select(OrderGetTicket(i))) {
      if (m_order.Symbol() != m_symbol.Name())
        continue;
      if (m_order.OrderType() != ORDER_TYPE_SELL_STOP &&
          m_order.OrderType() != ORDER_TYPE_SELL_LIMIT)
        continue;
      result &= DeleteOrder();
    }

  return (result);
}

bool CExpert::DeleteOrder(void) {
  return (m_trade.OrderDelete(m_order.Ticket()));
}

bool CExpert::DeleteOrderLong(void) {
  return (m_trade.OrderDelete(m_order.Ticket()));
}

bool CExpert::DeleteOrderShort(void) {
  return (m_trade.OrderDelete(m_order.Ticket()));
}

double CExpert::LotOpenLong(double price, double sl) {
  return (m_money.CheckOpenLong(price, sl));
}

double CExpert::LotOpenShort(double price, double sl) {
  return (m_money.CheckOpenShort(price, sl));
}

double CExpert::LotReverse(double sl) {
  return (m_money.CheckReverse(GetPointer(m_position), sl));
}

double CExpert::LotCheck(double volume, double price,
                         ENUM_ORDER_TYPE order_type) {
  if (m_check_volume)
    return (m_trade.CheckVolume(m_symbol.Name(), volume, price, order_type));
  return (volume);
}

void CExpert::PrepareHistoryDate(void) {
  MqlDateTime dts;

  TimeCurrent(dts);

  if (dts.day == 1) {
    if (dts.mon == 1) {
      dts.mon = 12;
      dts.year--;
    } else
      dts.mon--;
  }
  dts.day = 1;
  dts.hour = 0;
  dts.min = 0;
  dts.sec = 0;

  m_beg_date = StructToTime(dts);
}

void CExpert::HistoryPoint(bool from_check_trade) {

  if (!from_check_trade)
    CheckTradeState();

  if (HistorySelect(m_beg_date, TimeCurrent())) {
    m_hist_ord_tot = HistoryOrdersTotal();
    m_deal_tot = HistoryDealsTotal();
  } else {
    m_hist_ord_tot = 0;
    m_deal_tot = 0;
  }
  m_ord_tot = OrdersTotal();
  m_pos_tot = PositionsTotal();
}

bool CExpert::CheckTradeState(void) {
  bool res = false;

  HistorySelect(m_beg_date, INT_MAX);
  int hist_ord_tot = HistoryOrdersTotal();
  int ord_tot = OrdersTotal();
  int deal_tot = HistoryDealsTotal();
  int pos_tot = PositionsTotal();

  if (hist_ord_tot == m_hist_ord_tot && ord_tot == m_ord_tot &&
      deal_tot == m_deal_tot && pos_tot == m_pos_tot) {

    if (IS_WAITING_POSITION_MODIFIED) {
      res = TradeEventPositionModified();
      NoWaitEvent(TRADE_EVENT_POSITION_MODIFY);
    }
    if (IS_WAITING_ORDER_MODIFIED) {
      res = TradeEventOrderModified();
      NoWaitEvent(TRADE_EVENT_ORDER_MODIFY);
    }
    return (true);
  }

  if (hist_ord_tot == m_hist_ord_tot && ord_tot == m_ord_tot + 1 &&
      deal_tot == m_deal_tot && pos_tot == m_pos_tot) {

    res = TradeEventOrderPlaced();

    HistoryPoint(true);
    return (true);
  }

  if (hist_ord_tot == m_hist_ord_tot + 1 && ord_tot == m_ord_tot) {

    if (deal_tot == m_deal_tot + 1) {

      if (pos_tot == m_pos_tot) {

        if (IS_WAITING_POSITION_VOLUME_CHANGED) {
          res = TradeEventPositionVolumeChanged();
          NoWaitEvent(TRADE_EVENT_POSITION_VOLUME_CHANGE);
        }

        HistoryPoint(true);
        return (res);
      }

      if (pos_tot == m_pos_tot + 1) {

        if (IS_WAITING_POSITION_OPENED) {
          res = TradeEventPositionOpened();
          NoWaitEvent(TRADE_EVENT_POSITION_OPEN);
        }

        HistoryPoint(true);
        return (res);
      }

      if (pos_tot == m_pos_tot - 1) {

        if (IS_WAITING_POSITION_CLOSED) {
          res = TradeEventPositionClosed();
          NoWaitEvent(TRADE_EVENT_POSITION_CLOSE);
        } else
          res = TradeEventPositionStopTake();

        HistoryPoint(true);
        return (res);
      }
    } else {

      HistoryPoint(true);
      return (false);
    }
  }

  if (hist_ord_tot == m_hist_ord_tot + 1 && ord_tot == m_ord_tot - 1 &&
      deal_tot == m_deal_tot && pos_tot == m_pos_tot) {

    res = TradeEventOrderDeleted();

    HistoryPoint(true);
    return (res);
  }

  if (hist_ord_tot == m_hist_ord_tot + 1 && ord_tot == m_ord_tot - 1) {

    if (deal_tot == m_deal_tot + 1) {

      if (pos_tot == m_pos_tot) {

        res = TradeEventOrderTriggered();

        HistoryPoint(true);
        return (res);
      }

      if (pos_tot == m_pos_tot + 1) {

        res = TradeEventOrderTriggered();

        HistoryPoint(true);
        return (res);
      }

      if (pos_tot == m_pos_tot - 1) {

        res = TradeEventOrderTriggered();

        HistoryPoint(true);
        return (res);
      }
    } else {

      HistoryPoint(true);
      return (false);
    }
  }

  res = TradeEventNotIdentified();

  HistoryPoint(true);

  return (res);
}

void CExpert::TimeframeAdd(ENUM_TIMEFRAMES period) {
  switch (period) {
  case PERIOD_M1:
    m_period_flags |= OBJ_PERIOD_M1;
    break;
  case PERIOD_M2:
    m_period_flags |= OBJ_PERIOD_M2;
    break;
  case PERIOD_M3:
    m_period_flags |= OBJ_PERIOD_M3;
    break;
  case PERIOD_M4:
    m_period_flags |= OBJ_PERIOD_M4;
    break;
  case PERIOD_M5:
    m_period_flags |= OBJ_PERIOD_M5;
    break;
  case PERIOD_M6:
    m_period_flags |= OBJ_PERIOD_M6;
    break;
  case PERIOD_M10:
    m_period_flags |= OBJ_PERIOD_M10;
    break;
  case PERIOD_M12:
    m_period_flags |= OBJ_PERIOD_M12;
    break;
  case PERIOD_M15:
    m_period_flags |= OBJ_PERIOD_M15;
    break;
  case PERIOD_M20:
    m_period_flags |= OBJ_PERIOD_M20;
    break;
  case PERIOD_M30:
    m_period_flags |= OBJ_PERIOD_M30;
    break;
  case PERIOD_H1:
    m_period_flags |= OBJ_PERIOD_H1;
    break;
  case PERIOD_H2:
    m_period_flags |= OBJ_PERIOD_H2;
    break;
  case PERIOD_H3:
    m_period_flags |= OBJ_PERIOD_H3;
    break;
  case PERIOD_H4:
    m_period_flags |= OBJ_PERIOD_H4;
    break;
  case PERIOD_H6:
    m_period_flags |= OBJ_PERIOD_H6;
    break;
  case PERIOD_H8:
    m_period_flags |= OBJ_PERIOD_H8;
    break;
  case PERIOD_H12:
    m_period_flags |= OBJ_PERIOD_H12;
    break;
  case PERIOD_D1:
    m_period_flags |= OBJ_PERIOD_D1;
    break;
  case PERIOD_W1:
    m_period_flags |= OBJ_PERIOD_W1;
    break;
  case PERIOD_MN1:
    m_period_flags |= OBJ_PERIOD_MN1;
    break;
  default:
    m_period_flags = WRONG_VALUE;
    break;
  }
}

int CExpert::TimeframesFlags(MqlDateTime &time) {

  int result = OBJ_ALL_PERIODS;

  if (m_last_tick_time.min == -1)
    return (result);

  if (time.min == m_last_tick_time.min && time.hour == m_last_tick_time.hour &&
      time.day == m_last_tick_time.day && time.mon == m_last_tick_time.mon)
    return (OBJ_NO_PERIODS);

  if (time.mon != m_last_tick_time.mon)
    return (result);

  result ^= OBJ_PERIOD_MN1;

  if (time.day != m_last_tick_time.day)
    return (result);

  result ^= OBJ_PERIOD_D1 + OBJ_PERIOD_W1;

  int curr, delta;

  curr = time.hour;
  delta = curr - m_last_tick_time.hour;
  if (delta != 0) {
    if (curr % 2 >= delta)
      result ^= OBJ_PERIOD_H2;
    if (curr % 3 >= delta)
      result ^= OBJ_PERIOD_H3;
    if (curr % 4 >= delta)
      result ^= OBJ_PERIOD_H4;
    if (curr % 6 >= delta)
      result ^= OBJ_PERIOD_H6;
    if (curr % 8 >= delta)
      result ^= OBJ_PERIOD_H8;
    if (curr % 12 >= delta)
      result ^= OBJ_PERIOD_H12;
    return (result);
  }

  result ^= OBJ_PERIOD_H1 + OBJ_PERIOD_H2 + OBJ_PERIOD_H3 + OBJ_PERIOD_H4 +
            OBJ_PERIOD_H6 + OBJ_PERIOD_H8 + OBJ_PERIOD_H12;

  curr = time.min;
  delta = curr - m_last_tick_time.min;
  if (delta != 0) {
    if (curr % 2 >= delta)
      result ^= OBJ_PERIOD_M2;
    if (curr % 3 >= delta)
      result ^= OBJ_PERIOD_M3;
    if (curr % 4 >= delta)
      result ^= OBJ_PERIOD_M4;
    if (curr % 5 >= delta)
      result ^= OBJ_PERIOD_M5;
    if (curr % 6 >= delta)
      result ^= OBJ_PERIOD_M6;
    if (curr % 10 >= delta)
      result ^= OBJ_PERIOD_M10;
    if (curr % 12 >= delta)
      result ^= OBJ_PERIOD_M12;
    if (curr % 15 >= delta)
      result ^= OBJ_PERIOD_M15;
    if (curr % 20 >= delta)
      result ^= OBJ_PERIOD_M20;
    if (curr % 30 >= delta)
      result ^= OBJ_PERIOD_M30;
  }

  return (result);
}

#endif
