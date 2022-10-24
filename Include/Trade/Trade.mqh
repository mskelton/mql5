#ifndef TRADE_H
#define TRADE_H

#include "DealInfo.mqh"
#include "HistoryOrderInfo.mqh"
#include "OrderInfo.mqh"
#include "PositionInfo.mqh"
#include <Object.mqh>

enum ENUM_LOG_LEVELS {
  LOG_LEVEL_NO = 0,
  LOG_LEVEL_ERRORS = 1,
  LOG_LEVEL_ALL = 2
};

class CTrade : public CObject {
protected:
  MqlTradeRequest m_request;
  MqlTradeResult m_result;
  MqlTradeCheckResult m_check_result;
  bool m_async_mode;
  ulong m_magic;
  ulong m_deviation;
  ENUM_ORDER_TYPE_FILLING m_type_filling;
  ENUM_ACCOUNT_MARGIN_MODE m_margin_mode;

  ENUM_LOG_LEVELS m_log_level;

public:
  CTrade(void);
  ~CTrade(void);

  void LogLevel(const ENUM_LOG_LEVELS log_level) ;
  void Request(MqlTradeRequest &request) const;
  ENUM_TRADE_REQUEST_ACTIONS RequestAction(void) const ;
  string RequestActionDescription(void) const;
  ulong RequestMagic(void) const ;
  ulong RequestOrder(void) const ;
  ulong RequestPosition(void) const ;
  ulong RequestPositionBy(void) const ;
  string RequestSymbol(void) const ;
  double RequestVolume(void) const ;
  double RequestPrice(void) const ;
  double RequestStopLimit(void) const ;
  double RequestSL(void) const ;
  double RequestTP(void) const ;
  ulong RequestDeviation(void) const ;
  ENUM_ORDER_TYPE RequestType(void) const ;
  string RequestTypeDescription(void) const;
  ENUM_ORDER_TYPE_FILLING RequestTypeFilling(void) const ;
  string RequestTypeFillingDescription(void) const;
  ENUM_ORDER_TYPE_TIME RequestTypeTime(void) const ;
  string RequestTypeTimeDescription(void) const;
  datetime RequestExpiration(void) const ;
  string RequestComment(void) const ;

  void Result(MqlTradeResult &result) const;
  uint ResultRetcode(void) const ;
  string ResultRetcodeDescription(void) const;
  int ResultRetcodeExternal(void) const ;
  ulong ResultDeal(void) const ;
  ulong ResultOrder(void) const ;
  double ResultVolume(void) const ;
  double ResultPrice(void) const ;
  double ResultBid(void) const ;
  double ResultAsk(void) const ;
  string ResultComment(void) const ;

  void CheckResult(MqlTradeCheckResult &check_result) const;
  uint CheckResultRetcode(void) const ;
  string CheckResultRetcodeDescription(void) const;
  double CheckResultBalance(void) const ;
  double CheckResultEquity(void) const ;
  double CheckResultProfit(void) const ;
  double CheckResultMargin(void) const ;
  double CheckResultMarginFree(void) const ;
  double CheckResultMarginLevel(void) const ;
  string CheckResultComment(void) const ;

  void SetAsyncMode(const bool mode) ;
  void SetExpertMagicNumber(const ulong magic) ;
  void SetDeviationInPoints(const ulong deviation) ;
  void SetTypeFilling(const ENUM_ORDER_TYPE_FILLING filling) ;
  bool SetTypeFillingBySymbol(const string symbol);
  void SetMarginMode(void) ;

  bool PositionOpen(const string symbol, const ENUM_ORDER_TYPE order_type,
                    const double volume, const double price, const double sl,
                    const double tp, const string comment = "");
  bool PositionModify(const string symbol, const double sl, const double tp);
  bool PositionModify(const ulong ticket, const double sl, const double tp);
  bool PositionClose(const string symbol, const ulong deviation = ULONG_MAX);
  bool PositionClose(const ulong ticket, const ulong deviation = ULONG_MAX);
  bool PositionCloseBy(const ulong ticket, const ulong ticket_by);
  bool PositionClosePartial(const string symbol, const double volume,
                            const ulong deviation = ULONG_MAX);
  bool PositionClosePartial(const ulong ticket, const double volume,
                            const ulong deviation = ULONG_MAX);

  bool OrderOpen(const string symbol, const ENUM_ORDER_TYPE order_type,
                 const double volume, const double limit_price,
                 const double price, const double sl, const double tp,
                 ENUM_ORDER_TYPE_TIME type_time = ORDER_TIME_GTC,
                 const datetime expiration = 0, const string comment = "");
  bool OrderModify(const ulong ticket, const double price, const double sl,
                   const double tp, const ENUM_ORDER_TYPE_TIME type_time,
                   const datetime expiration, const double stoplimit = 0.0);
  bool OrderDelete(const ulong ticket);

  bool Buy(const double volume, const string symbol = NULL, double price = 0.0,
           const double sl = 0.0, const double tp = 0.0,
           const string comment = "");
  bool Sell(const double volume, const string symbol = NULL, double price = 0.0,
            const double sl = 0.0, const double tp = 0.0,
            const string comment = "");
  bool BuyLimit(const double volume, const double price,
                const string symbol = NULL, const double sl = 0.0,
                const double tp = 0.0,
                const ENUM_ORDER_TYPE_TIME type_time = ORDER_TIME_GTC,
                const datetime expiration = 0, const string comment = "");
  bool BuyStop(const double volume, const double price,
               const string symbol = NULL, const double sl = 0.0,
               const double tp = 0.0,
               const ENUM_ORDER_TYPE_TIME type_time = ORDER_TIME_GTC,
               const datetime expiration = 0, const string comment = "");
  bool SellLimit(const double volume, const double price,
                 const string symbol = NULL, const double sl = 0.0,
                 const double tp = 0.0,
                 const ENUM_ORDER_TYPE_TIME type_time = ORDER_TIME_GTC,
                 const datetime expiration = 0, const string comment = "");
  bool SellStop(const double volume, const double price,
                const string symbol = NULL, const double sl = 0.0,
                const double tp = 0.0,
                const ENUM_ORDER_TYPE_TIME type_time = ORDER_TIME_GTC,
                const datetime expiration = 0, const string comment = "");

  virtual double CheckVolume(const string symbol, double volume, double price,
                             ENUM_ORDER_TYPE order_type);
  virtual bool OrderCheck(const MqlTradeRequest &request,
                          MqlTradeCheckResult &check_result);
  virtual bool OrderSend(const MqlTradeRequest &request,
                         MqlTradeResult &result);

  void PrintRequest(void) const;
  void PrintResult(void) const;

  string FormatPositionType(string &str, const uint type) const;

  string FormatOrderType(string &str, const uint type) const;
  string FormatOrderStatus(string &str, const uint status) const;
  string FormatOrderTypeFilling(string &str, const uint type) const;
  string FormatOrderTypeTime(string &str, const uint type) const;
  string FormatOrderPrice(string &str, const double price_order,
                          const double price_trigger, const uint digits) const;

  string FormatRequest(string &str, const MqlTradeRequest &request) const;
  string FormatRequestResult(string &str, const MqlTradeRequest &request,
                             const MqlTradeResult &result) const;

protected:
  bool FillingCheck(const string symbol);
  bool ExpirationCheck(const string symbol);
  bool OrderTypeCheck(const string symbol);
  void ClearStructures(void);
  bool IsStopped(const string function);
  bool IsHedging(void) const ;

  bool SelectPosition(const string symbol);
};
















































#endif
