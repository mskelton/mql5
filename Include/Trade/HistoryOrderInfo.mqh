#ifndef HISTORY_ORDER_INFO_H
#define HISTORY_ORDER_INFO_H

#include <Object.mqh>

class CHistoryOrderInfo : public CObject {
protected:
  ulong m_ticket;

public:
  CHistoryOrderInfo(void);
  ~CHistoryOrderInfo(void);

  void Ticket(const ulong ticket);
  ulong Ticket(void) const;

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

#endif
