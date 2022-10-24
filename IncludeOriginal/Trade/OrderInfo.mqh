#ifndef ORDER_INFO_H
#define ORDER_INFO_H

#include <Object.mqh>

class COrderInfo : public CObject {
protected:
  ulong m_ticket;
  ENUM_ORDER_TYPE m_type;
  ENUM_ORDER_STATE m_state;
  datetime m_expiration;
  double m_volume_curr;
  double m_price_open;
  double m_stop_loss;
  double m_take_profit;

public:
  COrderInfo(void);
  ~COrderInfo(void);

  ulong Ticket(void) const {
    return (m_ticket);
  }

  datetime TimeSetup(void) const;
  ulong TimeSetupMsc(void) const;
  datetime TimeDone(void) const;
  ulong TimeDoneMsc(void) const;
  ENUM_ORDER_TYPE OrderType(void) const;
  string TypeDescription(void) const;
  ENUM_ORDER_STATE State(void) const;
  string StateDescription(void) const;
  datetime TimeExpiration(void) const;
  ENUM_ORDER_TYPE_FILLING TypeFilling(void) const;
  string TypeFillingDescription(void) const;
  ENUM_ORDER_TYPE_TIME TypeTime(void) const;
  string TypeTimeDescription(void) const;
  long Magic(void) const;
  long PositionId(void) const;
  long PositionById(void) const;

  double VolumeInitial(void) const;
  double VolumeCurrent(void) const;
  double PriceOpen(void) const;
  double StopLoss(void) const;
  double TakeProfit(void) const;
  double PriceCurrent(void) const;
  double PriceStopLimit(void) const;

  string Symbol(void) const;
  string Comment(void) const;
  string ExternalId(void) const;

  bool InfoInteger(const ENUM_ORDER_PROPERTY_INTEGER prop_id, long &var) const;
  bool InfoDouble(const ENUM_ORDER_PROPERTY_DOUBLE prop_id, double &var) const;
  bool InfoString(const ENUM_ORDER_PROPERTY_STRING prop_id, string &var) const;

  string FormatType(string &str, const uint type) const;
  string FormatStatus(string &str, const uint status) const;
  string FormatTypeFilling(string &str, const uint type) const;
  string FormatTypeTime(string &str, const uint type) const;
  string FormatOrder(string &str) const;
  string FormatPrice(string &str, const double price_order,
                     const double price_trigger, const uint digits) const;

  bool Select(void);
  bool Select(const ulong ticket);
  bool SelectByIndex(const int index);

  void StoreState(void);
  bool CheckState(void);
};

COrderInfo::COrderInfo(void)
    : m_ticket(ULONG_MAX), m_type(WRONG_VALUE), m_state(WRONG_VALUE),
      m_expiration(0), m_volume_curr(0.0), m_price_open(0.0), m_stop_loss(0.0),
      m_take_profit(0.0) {}

COrderInfo::~COrderInfo(void) {}

datetime COrderInfo::TimeSetup(void) const {
  return ((datetime)OrderGetInteger(ORDER_TIME_SETUP));
}

ulong COrderInfo::TimeSetupMsc(void) const {
  return (OrderGetInteger(ORDER_TIME_SETUP_MSC));
}

datetime COrderInfo::TimeDone(void) const {
  return ((datetime)OrderGetInteger(ORDER_TIME_DONE));
}

ulong COrderInfo::TimeDoneMsc(void) const {
  return (OrderGetInteger(ORDER_TIME_DONE_MSC));
}

ENUM_ORDER_TYPE COrderInfo::OrderType(void) const {
  return ((ENUM_ORDER_TYPE)OrderGetInteger(ORDER_TYPE));
}

string COrderInfo::TypeDescription(void) const {
  string str;

  return (FormatType(str, OrderType()));
}

ENUM_ORDER_STATE COrderInfo::State(void) const {
  return ((ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE));
}

string COrderInfo::StateDescription(void) const {
  string str;

  return (FormatStatus(str, State()));
}

datetime COrderInfo::TimeExpiration(void) const {
  return ((datetime)OrderGetInteger(ORDER_TIME_EXPIRATION));
}

ENUM_ORDER_TYPE_FILLING COrderInfo::TypeFilling(void) const {
  return ((ENUM_ORDER_TYPE_FILLING)OrderGetInteger(ORDER_TYPE_FILLING));
}

string COrderInfo::TypeFillingDescription(void) const {
  string str;

  return (FormatTypeFilling(str, TypeFilling()));
}

ENUM_ORDER_TYPE_TIME COrderInfo::TypeTime(void) const {
  return ((ENUM_ORDER_TYPE_TIME)OrderGetInteger(ORDER_TYPE_TIME));
}

string COrderInfo::TypeTimeDescription(void) const {
  string str;

  return (FormatTypeTime(str, TypeFilling()));
}

long COrderInfo::Magic(void) const {
  return (OrderGetInteger(ORDER_MAGIC));
}

long COrderInfo::PositionId(void) const {
  return (OrderGetInteger(ORDER_POSITION_ID));
}

long COrderInfo::PositionById(void) const {
  return (OrderGetInteger(ORDER_POSITION_BY_ID));
}

double COrderInfo::VolumeInitial(void) const {
  return (OrderGetDouble(ORDER_VOLUME_INITIAL));
}

double COrderInfo::VolumeCurrent(void) const {
  return (OrderGetDouble(ORDER_VOLUME_CURRENT));
}

double COrderInfo::PriceOpen(void) const {
  return (OrderGetDouble(ORDER_PRICE_OPEN));
}

double COrderInfo::StopLoss(void) const {
  return (OrderGetDouble(ORDER_SL));
}

double COrderInfo::TakeProfit(void) const {
  return (OrderGetDouble(ORDER_TP));
}

double COrderInfo::PriceCurrent(void) const {
  return (OrderGetDouble(ORDER_PRICE_CURRENT));
}

double COrderInfo::PriceStopLimit(void) const {
  return (OrderGetDouble(ORDER_PRICE_STOPLIMIT));
}

string COrderInfo::Symbol(void) const {
  return (OrderGetString(ORDER_SYMBOL));
}

string COrderInfo::Comment(void) const {
  return (OrderGetString(ORDER_COMMENT));
}

string COrderInfo::ExternalId(void) const {
  return (OrderGetString(ORDER_EXTERNAL_ID));
}

bool COrderInfo::InfoInteger(const ENUM_ORDER_PROPERTY_INTEGER prop_id,
                             long &var) const {
  return (OrderGetInteger(prop_id, var));
}

bool COrderInfo::InfoDouble(const ENUM_ORDER_PROPERTY_DOUBLE prop_id,
                            double &var) const {
  return (OrderGetDouble(prop_id, var));
}

bool COrderInfo::InfoString(const ENUM_ORDER_PROPERTY_STRING prop_id,
                            string &var) const {
  return (OrderGetString(prop_id, var));
}

string COrderInfo::FormatType(string &str, const uint type) const {

  switch (type) {
  case ORDER_TYPE_BUY:
    str = "buy";
    break;
  case ORDER_TYPE_SELL:
    str = "sell";
    break;
  case ORDER_TYPE_BUY_LIMIT:
    str = "buy limit";
    break;
  case ORDER_TYPE_SELL_LIMIT:
    str = "sell limit";
    break;
  case ORDER_TYPE_BUY_STOP:
    str = "buy stop";
    break;
  case ORDER_TYPE_SELL_STOP:
    str = "sell stop";
    break;
  case ORDER_TYPE_BUY_STOP_LIMIT:
    str = "buy stop limit";
    break;
  case ORDER_TYPE_SELL_STOP_LIMIT:
    str = "sell stop limit";
    break;
  case ORDER_TYPE_CLOSE_BY:
    str = "close by";
    break;
  default:
    str = "unknown order type " + (string)type;
  }

  return (str);
}

string COrderInfo::FormatStatus(string &str, const uint status) const {

  switch (status) {
  case ORDER_STATE_STARTED:
    str = "started";
    break;
  case ORDER_STATE_PLACED:
    str = "placed";
    break;
  case ORDER_STATE_CANCELED:
    str = "canceled";
    break;
  case ORDER_STATE_PARTIAL:
    str = "partial";
    break;
  case ORDER_STATE_FILLED:
    str = "filled";
    break;
  case ORDER_STATE_REJECTED:
    str = "rejected";
    break;
  case ORDER_STATE_EXPIRED:
    str = "expired";
    break;
  case ORDER_STATE_REQUEST_ADD:
    str = "request adding";
    break;
  case ORDER_STATE_REQUEST_MODIFY:
    str = "request modifying";
    break;
  case ORDER_STATE_REQUEST_CANCEL:
    str = "request cancelling";
    break;
  default:
    str = "unknown order status " + (string)status;
  }

  return (str);
}

string COrderInfo::FormatTypeFilling(string &str, const uint type) const {

  switch (type) {
  case ORDER_FILLING_RETURN:
    str = "return remainder";
    break;
  case ORDER_FILLING_IOC:
    str = "cancel remainder";
    break;
  case ORDER_FILLING_FOK:
    str = "fill or kill";
    break;
  default:
    str = "unknown type filling " + (string)type;
  }

  return (str);
}

string COrderInfo::FormatTypeTime(string &str, const uint type) const {

  switch (type) {
  case ORDER_TIME_GTC:
    str = "gtc";
    break;
  case ORDER_TIME_DAY:
    str = "day";
    break;
  case ORDER_TIME_SPECIFIED:
    str = "specified";
    break;
  case ORDER_TIME_SPECIFIED_DAY:
    str = "specified day";
    break;
  default:
    str = "unknown type time " + (string)type;
  }

  return (str);
}

string COrderInfo::FormatOrder(string &str) const {
  string type, price;
  long tmp_long;

  string symbol_name = this.Symbol();
  int digits = _Digits;
  if (SymbolInfoInteger(symbol_name, SYMBOL_DIGITS, tmp_long))
    digits = (int)tmp_long;

  str = StringFormat("#%I64u %s %s %s", Ticket(), FormatType(type, OrderType()),
                     DoubleToString(VolumeInitial(), 2), symbol_name);

  FormatPrice(price, PriceOpen(), PriceStopLimit(), digits);

  if (price != "") {
    str += " at ";
    str += price;
  }

  return (str);
}

string COrderInfo::FormatPrice(string &str, const double price_order,
                               const double price_trigger,
                               const uint digits) const {
  string price, trigger;

  if (price_trigger) {
    price = DoubleToString(price_order, digits);
    trigger = DoubleToString(price_trigger, digits);
    str = StringFormat("%s (%s)", price, trigger);
  } else
    str = DoubleToString(price_order, digits);

  return (str);
}

bool COrderInfo::Select(void) {
  return (OrderSelect(m_ticket));
}

bool COrderInfo::Select(const ulong ticket) {
  if (OrderSelect(ticket)) {
    m_ticket = ticket;
    return (true);
  }
  m_ticket = ULONG_MAX;

  return (false);
}

bool COrderInfo::SelectByIndex(const int index) {
  ulong ticket = OrderGetTicket(index);
  if (ticket == 0) {
    m_ticket = ULONG_MAX;
    return (false);
  }
  m_ticket = ticket;

  return (true);
}

void COrderInfo::StoreState(void) {
  m_type = OrderType();
  m_state = State();
  m_expiration = TimeExpiration();
  m_volume_curr = VolumeCurrent();
  m_price_open = PriceOpen();
  m_stop_loss = StopLoss();
  m_take_profit = TakeProfit();
}

bool COrderInfo::CheckState(void) {
  if (m_type == OrderType() && m_state == State() &&
      m_expiration == TimeExpiration() && m_volume_curr == VolumeCurrent() &&
      m_price_open == PriceOpen() && m_stop_loss == StopLoss() &&
      m_take_profit == TakeProfit())
    return (false);

  return (true);
}

#endif
