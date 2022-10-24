#ifndef EXPERT_SIGNAL_H
#define EXPERT_SIGNAL_H

#include "ExpertBase.mqh"

#define IS_PATTERN_USAGE(p) ((m_patterns_usage & (((int)1) << p)) != 0)

class CExpertSignal : public CExpertBase {
protected:
  double m_base_price;

  CArrayObj m_filters;

  double m_weight;
  int m_patterns_usage;
  int m_general;
  long m_ignore;
  long m_invert;
  int m_threshold_open;
  int m_threshold_close;
  double m_price_level;
  double m_stop_level;
  double m_take_level;
  int m_expiration;
  double m_direction;

public:
  CExpertSignal(void);
  ~CExpertSignal(void);

  void BasePrice(double value) ;
  int UsedSeries(void);

  void Weight(double value) ;
  void PatternsUsage(int value) ;
  void General(int value) ;
  void Ignore(long value) ;
  void Invert(long value) ;
  void ThresholdOpen(int value) ;
  void ThresholdClose(int value) ;
  void PriceLevel(double value) ;
  void StopLevel(double value) ;
  void TakeLevel(double value) ;
  void Expiration(int value) ;

  void Magic(ulong value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual bool AddFilter(CExpertSignal *filter);

  virtual bool CheckOpenLong(double &price, double &sl, double &tp,
                             datetime &expiration);
  virtual bool CheckOpenShort(double &price, double &sl, double &tp,
                              datetime &expiration);

  virtual bool OpenLongParams(double &price, double &sl, double &tp,
                              datetime &expiration);
  virtual bool OpenShortParams(double &price, double &sl, double &tp,
                               datetime &expiration);

  virtual bool CheckCloseLong(double &price);
  virtual bool CheckCloseShort(double &price);

  virtual bool CloseLongParams(double &price);
  virtual bool CloseShortParams(double &price);

  virtual bool CheckReverseLong(double &price, double &sl, double &tp,
                                datetime &expiration);
  virtual bool CheckReverseShort(double &price, double &sl, double &tp,
                                 datetime &expiration);

  virtual bool CheckTrailingOrderLong(COrderInfo *order, double &price) ;
  virtual bool CheckTrailingOrderShort(COrderInfo *order, double &price) ;

  virtual int LongCondition(void) ;
  virtual int ShortCondition(void) ;
  virtual double Direction(void);
  void SetDirection(void) ;
};



















#endif
