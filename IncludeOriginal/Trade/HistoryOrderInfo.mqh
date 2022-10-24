#ifndef HISTORY_ORDER_INFO_H
#define HISTORY_ORDER_INFO_H

#include <Object.mqh>

class CHistoryOrderInfo : public CObject {
protected:
  ulong m_ticket;

public:
  CHistoryOrderInfo(void);
  ~CHistoryOrderInfo(void);

  void Ticket(const ulong ticket) {
    m_ticket = ticket;
  }
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

  bool SelectByIndex(const int index);
};

CHistoryOrderInfo::CHistoryOrderInfo(void) : m_ticket(0) {
}

CHistoryOrderInfo::~CHistoryOrderInfo(void) {
}

datetime CHistoryOrderInfo::TimeSetup(void) const {
  return ((datetime)HistoryOrderGetInteger(m_ticket, ORDER_TIME_SETUP));
}

ulong CHistoryOrderInfo::TimeSetupMsc(void) const {
  return (HistoryOrderGetInteger(m_ticket, ORDER_TIME_SETUP_MSC));
}

datetime CHistoryOrderInfo::TimeDone(void) const {
  return ((datetime)HistoryOrderGetInteger(m_ticket, ORDER_TIME_DONE));
}

ulong CHistoryOrderInfo::TimeDoneMsc(void) const {
  return (HistoryOrderGetInteger(m_ticket, ORDER_TIME_DONE_MSC));
}

ENUM_ORDER_TYPE CHistoryOrderInfo::OrderType(void) const {
  return ((ENUM_ORDER_TYPE)HistoryOrderGetInteger(m_ticket, ORDER_TYPE));
}

string CHistoryOrderInfo::TypeDescription(void) const {
  string str;

  return (FormatType(str, OrderType()));
}

ENUM_ORDER_STATE CHistoryOrderInfo::State(void) const {
  return ((ENUM_ORDER_STATE)HistoryOrderGetInteger(m_ticket, ORDER_STATE));
}

string CHistoryOrderInfo::StateDescription(void) const {
  string str;

  return (FormatStatus(str, State()));
}

datetime CHistoryOrderInfo::TimeExpiration(void) const {
  return ((datetime)HistoryOrderGetInteger(m_ticket, ORDER_TIME_EXPIRATION));
}

ENUM_ORDER_TYPE_FILLING CHistoryOrderInfo::TypeFilling(void) const {
  return ((ENUM_ORDER_TYPE_FILLING)HistoryOrderGetInteger(m_ticket,
                                                          ORDER_TYPE_FILLING));
}

string CHistoryOrderInfo::TypeFillingDescription(void) const {
  string str;

  return (FormatTypeFilling(str, TypeFilling()));
}

ENUM_ORDER_TYPE_TIME CHistoryOrderInfo::TypeTime(void) const {
  return (
      (ENUM_ORDER_TYPE_TIME)HistoryOrderGetInteger(m_ticket, ORDER_TYPE_TIME));
}

string CHistoryOrderInfo::TypeTimeDescription(void) const {
  string str;

  return (FormatTypeTime(str, TypeTime()));
}

long CHistoryOrderInfo::Magic(void) const {
  return (HistoryOrderGetInteger(m_ticket, ORDER_MAGIC));
}

long CHistoryOrderInfo::PositionId(void) const {
  return (HistoryOrderGetInteger(m_ticket, ORDER_POSITION_ID));
}

long CHistoryOrderInfo::PositionById(void) const {
  return (HistoryOrderGetInteger(m_ticket, ORDER_POSITION_BY_ID));
}

double CHistoryOrderInfo::VolumeInitial(void) const {
  return (HistoryOrderGetDouble(m_ticket, ORDER_VOLUME_INITIAL));
}

double CHistoryOrderInfo::VolumeCurrent(void) const {
  return (HistoryOrderGetDouble(m_ticket, ORDER_VOLUME_CURRENT));
}

double CHistoryOrderInfo::PriceOpen(void) const {
  return (HistoryOrderGetDouble(m_ticket, ORDER_PRICE_OPEN));
}

double CHistoryOrderInfo::StopLoss(void) const {
  return (HistoryOrderGetDouble(m_ticket, ORDER_SL));
}

double CHistoryOrderInfo::TakeProfit(void) const {
  return (HistoryOrderGetDouble(m_ticket, ORDER_TP));
}

double CHistoryOrderInfo::PriceCurrent(void) const {
  return (HistoryOrderGetDouble(m_ticket, ORDER_PRICE_CURRENT));
}

double CHistoryOrderInfo::PriceStopLimit(void) const {
  return (HistoryOrderGetDouble(m_ticket, ORDER_PRICE_STOPLIMIT));
}

string CHistoryOrderInfo::Symbol(void) const {
  return (HistoryOrderGetString(m_ticket, ORDER_SYMBOL));
}

string CHistoryOrderInfo::Comment(void) const {
  return (HistoryOrderGetString(m_ticket, ORDER_COMMENT));
}

string CHistoryOrderInfo::ExternalId(void) const {
  return (HistoryOrderGetString(m_ticket, ORDER_EXTERNAL_ID));
}

bool CHistoryOrderInfo::InfoInteger(const ENUM_ORDER_PROPERTY_INTEGER prop_id,
                                    long &var) const {
  return (HistoryOrderGetInteger(m_ticket, prop_id, var));
}

bool CHistoryOrderInfo::InfoDouble(const ENUM_ORDER_PROPERTY_DOUBLE prop_id,
                                   double &var) const {
  return (HistoryOrderGetDouble(m_ticket, prop_id, var));
}

bool CHistoryOrderInfo::InfoString(const ENUM_ORDER_PROPERTY_STRING prop_id,
                                   string &var) const {
  return (HistoryOrderGetString(m_ticket, prop_id, var));
}

string CHistoryOrderInfo::FormatType(string &str, const uint type) const {

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

string CHistoryOrderInfo::FormatStatus(string &str, const uint status) const {

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
  default:
    str = "unknown order status " + (string)status;
  }

  return (str);
}

string CHistoryOrderInfo::FormatTypeFilling(string &str,
                                            const uint type) const {

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

string CHistoryOrderInfo::FormatTypeTime(string &str, const uint type) const {

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

string CHistoryOrderInfo::FormatOrder(string &str) const {
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

string CHistoryOrderInfo::FormatPrice(string &str, const double price_order,
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

bool CHistoryOrderInfo::SelectByIndex(const int index) {
  ulong ticket = HistoryOrderGetTicket(index);
  if (ticket == 0)
    return (false);
  Ticket(ticket);

  return (true);
}

#endif
