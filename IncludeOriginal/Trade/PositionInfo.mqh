#ifndef POSITION_INFO_H
#define POSITION_INFO_H

#include <Object.mqh>

class CPositionInfo : public CObject {
protected:
  ENUM_POSITION_TYPE m_type;
  double m_volume;
  double m_price;
  double m_stop_loss;
  double m_take_profit;

public:
  CPositionInfo(void);
  ~CPositionInfo(void);

  ulong Ticket(void) const;
  datetime Time(void) const;
  ulong TimeMsc(void) const;
  datetime TimeUpdate(void) const;
  ulong TimeUpdateMsc(void) const;
  ENUM_POSITION_TYPE PositionType(void) const;
  string TypeDescription(void) const;
  long Magic(void) const;
  long Identifier(void) const;

  double Volume(void) const;
  double PriceOpen(void) const;
  double StopLoss(void) const;
  double TakeProfit(void) const;
  double PriceCurrent(void) const;
  double Commission(void) const;
  double Swap(void) const;
  double Profit(void) const;

  string Symbol(void) const;
  string Comment(void) const;

  bool InfoInteger(const ENUM_POSITION_PROPERTY_INTEGER prop_id,
                   long &var) const;
  bool InfoDouble(const ENUM_POSITION_PROPERTY_DOUBLE prop_id,
                  double &var) const;
  bool InfoString(const ENUM_POSITION_PROPERTY_STRING prop_id,
                  string &var) const;

  string FormatType(string &str, const uint type) const;
  string FormatPosition(string &str) const;

  bool Select(const string symbol);
  bool SelectByMagic(const string symbol, const ulong magic);
  bool SelectByTicket(const ulong ticket);
  bool SelectByIndex(const int index);

  void StoreState(void);
  bool CheckState(void);
};

CPositionInfo::CPositionInfo(void)
    : m_type(WRONG_VALUE), m_volume(0.0), m_price(0.0), m_stop_loss(0.0),
      m_take_profit(0.0) {}

CPositionInfo::~CPositionInfo(void) {}

ulong CPositionInfo::Ticket(void) const {
  return ((ulong)PositionGetInteger(POSITION_TICKET));
}

datetime CPositionInfo::Time(void) const {
  return ((datetime)PositionGetInteger(POSITION_TIME));
}

ulong CPositionInfo::TimeMsc(void) const {
  return ((ulong)PositionGetInteger(POSITION_TIME_MSC));
}

datetime CPositionInfo::TimeUpdate(void) const {
  return ((datetime)PositionGetInteger(POSITION_TIME_UPDATE));
}

ulong CPositionInfo::TimeUpdateMsc(void) const {
  return ((ulong)PositionGetInteger(POSITION_TIME_UPDATE_MSC));
}

ENUM_POSITION_TYPE CPositionInfo::PositionType(void) const {
  return ((ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE));
}

string CPositionInfo::TypeDescription(void) const {
  string str;

  return (FormatType(str, PositionType()));
}

long CPositionInfo::Magic(void) const {
  return (PositionGetInteger(POSITION_MAGIC));
}

long CPositionInfo::Identifier(void) const {
  return (PositionGetInteger(POSITION_IDENTIFIER));
}

double CPositionInfo::Volume(void) const {
  return (PositionGetDouble(POSITION_VOLUME));
}

double CPositionInfo::PriceOpen(void) const {
  return (PositionGetDouble(POSITION_PRICE_OPEN));
}

double CPositionInfo::StopLoss(void) const {
  return (PositionGetDouble(POSITION_SL));
}

double CPositionInfo::TakeProfit(void) const {
  return (PositionGetDouble(POSITION_TP));
}

double CPositionInfo::PriceCurrent(void) const {
  return (PositionGetDouble(POSITION_PRICE_CURRENT));
}

double CPositionInfo::Commission(void) const {
  return (PositionGetDouble(POSITION_COMMISSION));
}

double CPositionInfo::Swap(void) const {
  return (PositionGetDouble(POSITION_SWAP));
}

double CPositionInfo::Profit(void) const {
  return (PositionGetDouble(POSITION_PROFIT));
}

string CPositionInfo::Symbol(void) const {
  return (PositionGetString(POSITION_SYMBOL));
}

string CPositionInfo::Comment(void) const {
  return (PositionGetString(POSITION_COMMENT));
}

bool CPositionInfo::InfoInteger(const ENUM_POSITION_PROPERTY_INTEGER prop_id,
                                long &var) const {
  return (PositionGetInteger(prop_id, var));
}

bool CPositionInfo::InfoDouble(const ENUM_POSITION_PROPERTY_DOUBLE prop_id,
                               double &var) const {
  return (PositionGetDouble(prop_id, var));
}

bool CPositionInfo::InfoString(const ENUM_POSITION_PROPERTY_STRING prop_id,
                               string &var) const {
  return (PositionGetString(prop_id, var));
}

string CPositionInfo::FormatType(string &str, const uint type) const {

  switch (type) {
  case POSITION_TYPE_BUY:
    str = "buy";
    break;
  case POSITION_TYPE_SELL:
    str = "sell";
    break;
  default:
    str = "unknown position type " + (string)type;
  }

  return (str);
}

string CPositionInfo::FormatPosition(string &str) const {
  string tmp, type;
  long tmp_long;
  ENUM_ACCOUNT_MARGIN_MODE margin_mode =
      (ENUM_ACCOUNT_MARGIN_MODE)AccountInfoInteger(ACCOUNT_MARGIN_MODE);

  string symbol_name = this.Symbol();
  int digits = _Digits;
  if (SymbolInfoInteger(symbol_name, SYMBOL_DIGITS, tmp_long))
    digits = (int)tmp_long;

  if (margin_mode == ACCOUNT_MARGIN_MODE_RETAIL_HEDGING)
    str = StringFormat("#%I64u %s %s %s %s", Ticket(),
                       FormatType(type, PositionType()),
                       DoubleToString(Volume(), 2), symbol_name,
                       DoubleToString(PriceOpen(), digits + 3));
  else
    str = StringFormat("%s %s %s %s", FormatType(type, PositionType()),
                       DoubleToString(Volume(), 2), symbol_name,
                       DoubleToString(PriceOpen(), digits + 3));

  double sl = StopLoss();
  double tp = TakeProfit();
  if (sl != 0.0) {
    tmp = StringFormat(" sl: %s", DoubleToString(sl, digits));
    str += tmp;
  }
  if (tp != 0.0) {
    tmp = StringFormat(" tp: %s", DoubleToString(tp, digits));
    str += tmp;
  }

  return (str);
}

bool CPositionInfo::Select(const string symbol) {
  return (PositionSelect(symbol));
}

bool CPositionInfo::SelectByMagic(const string symbol, const ulong magic) {
  bool res = false;
  uint total = PositionsTotal();

  for (uint i = 0; i < total; i++) {
    string position_symbol = PositionGetSymbol(i);
    if (position_symbol == symbol &&
        magic == PositionGetInteger(POSITION_MAGIC)) {
      res = true;
      break;
    }
  }

  return (res);
}

bool CPositionInfo::SelectByTicket(const ulong ticket) {
  return (PositionSelectByTicket(ticket));
}

bool CPositionInfo::SelectByIndex(const int index) {
  ulong ticket = PositionGetTicket(index);
  return (ticket > 0);
}

void CPositionInfo::StoreState(void) {
  m_type = PositionType();
  m_volume = Volume();
  m_price = PriceOpen();
  m_stop_loss = StopLoss();
  m_take_profit = TakeProfit();
}

bool CPositionInfo::CheckState(void) {
  if (m_type == PositionType() && m_volume == Volume() &&
      m_price == PriceOpen() && m_stop_loss == StopLoss() &&
      m_take_profit == TakeProfit())
    return (false);

  return (true);
}

#endif
