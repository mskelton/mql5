#ifndef DEAL_INFO_H
#define DEAL_INFO_H

#include <Object.mqh>

class CDealInfo : public CObject {
protected:
  ulong m_ticket;

public:
  CDealInfo(void);
  ~CDealInfo(void);

  void Ticket(const ulong ticket) ;
  ulong Ticket(void) const ;

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



























#endif
