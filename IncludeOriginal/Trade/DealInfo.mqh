#ifndef DEAL_INFO_H
#define DEAL_INFO_H

#include <Object.mqh>

class CDealInfo : public CObject {
protected:
  ulong m_ticket;

public:
  CDealInfo(void);
  ~CDealInfo(void);

  void Ticket(const ulong ticket) {
    m_ticket = ticket;
  }
  ulong Ticket(void) const {
    return (m_ticket);
  }

  long Order(void) const;
  datetime Time(void) const;
  ulong TimeMsc(void) const;
  ENUM_DEAL_TYPE DealType(void) const;
  string TypeDescription(void) const;
  ENUM_DEAL_ENTRY Entry(void) const;
  string EntryDescription(void) const;
  long Magic(void) const;
  long PositionId(void) const;

  double Volume(void) const;
  double Price(void) const;
  double Commission(void) const;
  double Swap(void) const;
  double Profit(void) const;

  string Symbol(void) const;
  string Comment(void) const;
  string ExternalId(void) const;

  bool InfoInteger(ENUM_DEAL_PROPERTY_INTEGER prop_id, long &var) const;
  bool InfoDouble(ENUM_DEAL_PROPERTY_DOUBLE prop_id, double &var) const;
  bool InfoString(ENUM_DEAL_PROPERTY_STRING prop_id, string &var) const;

  string FormatAction(string &str, const uint action) const;
  string FormatEntry(string &str, const uint entry) const;
  string FormatDeal(string &str) const;

  bool SelectByIndex(const int index);
};

CDealInfo::CDealInfo(void) {
}

CDealInfo::~CDealInfo(void) {
}

long CDealInfo::Order(void) const {
  return (HistoryDealGetInteger(m_ticket, DEAL_ORDER));
}

datetime CDealInfo::Time(void) const {
  return ((datetime)HistoryDealGetInteger(m_ticket, DEAL_TIME));
}

ulong CDealInfo::TimeMsc(void) const {
  return (HistoryDealGetInteger(m_ticket, DEAL_TIME_MSC));
}

ENUM_DEAL_TYPE CDealInfo::DealType(void) const {
  return ((ENUM_DEAL_TYPE)HistoryDealGetInteger(m_ticket, DEAL_TYPE));
}

string CDealInfo::TypeDescription(void) const {
  string str;

  switch (DealType()) {
  case DEAL_TYPE_BUY:
    str = "Buy type";
    break;
  case DEAL_TYPE_SELL:
    str = "Sell type";
    break;
  case DEAL_TYPE_BALANCE:
    str = "Balance type";
    break;
  case DEAL_TYPE_CREDIT:
    str = "Credit type";
    break;
  case DEAL_TYPE_CHARGE:
    str = "Charge type";
    break;
  case DEAL_TYPE_CORRECTION:
    str = "Correction type";
    break;
  case DEAL_TYPE_BONUS:
    str = "Bonus type";
    break;
  case DEAL_TYPE_COMMISSION:
    str = "Commission type";
    break;
  case DEAL_TYPE_COMMISSION_DAILY:
    str = "Daily Commission type";
    break;
  case DEAL_TYPE_COMMISSION_MONTHLY:
    str = "Monthly Commission type";
    break;
  case DEAL_TYPE_COMMISSION_AGENT_DAILY:
    str = "Daily Agent Commission type";
    break;
  case DEAL_TYPE_COMMISSION_AGENT_MONTHLY:
    str = "Monthly Agent Commission type";
    break;
  case DEAL_TYPE_INTEREST:
    str = "Interest Rate type";
    break;
  case DEAL_TYPE_BUY_CANCELED:
    str = "Canceled Buy type";
    break;
  case DEAL_TYPE_SELL_CANCELED:
    str = "Canceled Sell type";
    break;
  default:
    str = "Unknown type";
  }

  return (str);
}

ENUM_DEAL_ENTRY CDealInfo::Entry(void) const {
  return ((ENUM_DEAL_ENTRY)HistoryDealGetInteger(m_ticket, DEAL_ENTRY));
}

string CDealInfo::EntryDescription(void) const {
  string str;

  switch (CDealInfo::Entry()) {
  case DEAL_ENTRY_IN:
    str = "In entry";
    break;
  case DEAL_ENTRY_OUT:
    str = "Out entry";
    break;
  case DEAL_ENTRY_INOUT:
    str = "InOut entry";
    break;
  case DEAL_ENTRY_STATE:
    str = "Status record";
    break;
  case DEAL_ENTRY_OUT_BY:
    str = "Out By entry";
    break;
  default:
    str = "Unknown entry";
  }

  return (str);
}

long CDealInfo::Magic(void) const {
  return (HistoryDealGetInteger(m_ticket, DEAL_MAGIC));
}

long CDealInfo::PositionId(void) const {
  return (HistoryDealGetInteger(m_ticket, DEAL_POSITION_ID));
}

double CDealInfo::Volume(void) const {
  return (HistoryDealGetDouble(m_ticket, DEAL_VOLUME));
}

double CDealInfo::Price(void) const {
  return (HistoryDealGetDouble(m_ticket, DEAL_PRICE));
}

double CDealInfo::Commission(void) const {
  return (HistoryDealGetDouble(m_ticket, DEAL_COMMISSION));
}

double CDealInfo::Swap(void) const {
  return (HistoryDealGetDouble(m_ticket, DEAL_SWAP));
}

double CDealInfo::Profit(void) const {
  return (HistoryDealGetDouble(m_ticket, DEAL_PROFIT));
}

string CDealInfo::Symbol(void) const {
  return (HistoryDealGetString(m_ticket, DEAL_SYMBOL));
}

string CDealInfo::Comment(void) const {
  return (HistoryDealGetString(m_ticket, DEAL_COMMENT));
}

string CDealInfo::ExternalId(void) const {
  return (HistoryDealGetString(m_ticket, DEAL_EXTERNAL_ID));
}

bool CDealInfo::InfoInteger(ENUM_DEAL_PROPERTY_INTEGER prop_id,
                            long &var) const {
  return (HistoryDealGetInteger(m_ticket, prop_id, var));
}

bool CDealInfo::InfoDouble(ENUM_DEAL_PROPERTY_DOUBLE prop_id,
                           double &var) const {
  return (HistoryDealGetDouble(m_ticket, prop_id, var));
}

bool CDealInfo::InfoString(ENUM_DEAL_PROPERTY_STRING prop_id,
                           string &var) const {
  return (HistoryDealGetString(m_ticket, prop_id, var));
}

string CDealInfo::FormatAction(string &str, const uint action) const {

  switch (action) {
  case DEAL_TYPE_BUY:
    str = "buy";
    break;
  case DEAL_TYPE_SELL:
    str = "sell";
    break;
  case DEAL_TYPE_BALANCE:
    str = "balance";
    break;
  case DEAL_TYPE_CREDIT:
    str = "credit";
    break;
  case DEAL_TYPE_CHARGE:
    str = "charge";
    break;
  case DEAL_TYPE_CORRECTION:
    str = "correction";
    break;
  case DEAL_TYPE_BONUS:
    str = "bonus";
    break;
  case DEAL_TYPE_COMMISSION:
    str = "commission";
    break;
  case DEAL_TYPE_COMMISSION_DAILY:
    str = "daily commission";
    break;
  case DEAL_TYPE_COMMISSION_MONTHLY:
    str = "monthly commission";
    break;
  case DEAL_TYPE_COMMISSION_AGENT_DAILY:
    str = "daily agent commission";
    break;
  case DEAL_TYPE_COMMISSION_AGENT_MONTHLY:
    str = "monthly agent commission";
    break;
  case DEAL_TYPE_INTEREST:
    str = "interest rate";
    break;
  case DEAL_TYPE_BUY_CANCELED:
    str = "canceled buy";
    break;
  case DEAL_TYPE_SELL_CANCELED:
    str = "canceled sell";
    break;
  default:
    str = "unknown deal type " + (string)action;
  }

  return (str);
}

string CDealInfo::FormatEntry(string &str, const uint entry) const {

  switch (entry) {
  case DEAL_ENTRY_IN:
    str = "in";
    break;
  case DEAL_ENTRY_OUT:
    str = "out";
    break;
  case DEAL_ENTRY_INOUT:
    str = "in/out";
    break;
  case DEAL_ENTRY_OUT_BY:
    str = "out by";
    break;
  default:
    str = "unknown deal entry " + (string)entry;
  }

  return (str);
}

string CDealInfo::FormatDeal(string &str) const {
  string type;
  long tmp_long;

  string symbol_name = this.Symbol();
  int digits = _Digits;
  if (SymbolInfoInteger(symbol_name, SYMBOL_DIGITS, tmp_long))
    digits = (int)tmp_long;

  switch (DealType()) {

  case DEAL_TYPE_BUY:
  case DEAL_TYPE_SELL:
    str = StringFormat("#%I64u %s %s %s at %s", Ticket(),
                       FormatAction(type, DealType()),
                       DoubleToString(Volume(), 2), symbol_name,
                       DoubleToString(Price(), digits));
    break;

  case DEAL_TYPE_BALANCE:
  case DEAL_TYPE_CREDIT:
  case DEAL_TYPE_CHARGE:
  case DEAL_TYPE_CORRECTION:
  case DEAL_TYPE_BONUS:
  case DEAL_TYPE_COMMISSION:
  case DEAL_TYPE_COMMISSION_DAILY:
  case DEAL_TYPE_COMMISSION_MONTHLY:
  case DEAL_TYPE_COMMISSION_AGENT_DAILY:
  case DEAL_TYPE_COMMISSION_AGENT_MONTHLY:
  case DEAL_TYPE_INTEREST:
    str = StringFormat("#%I64u %s %s [%s]", Ticket(),
                       FormatAction(type, DealType()),
                       DoubleToString(Profit(), 2), this.Comment());
    break;

  default:
    str = "unknown deal type " + (string)DealType();
  }

  return (str);
}

bool CDealInfo::SelectByIndex(const int index) {
  ulong ticket = HistoryDealGetTicket(index);
  if (ticket == 0)
    return (false);
  Ticket(ticket);

  return (true);
}

#endif
