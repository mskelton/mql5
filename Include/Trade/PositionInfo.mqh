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

#endif
