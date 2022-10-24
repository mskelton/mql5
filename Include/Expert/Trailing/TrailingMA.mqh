#ifndef TRAILING_MA_H
#define TRAILING_MA_H

#include <Expert/ExpertTrailing.mqh>

class CTrailingMA : public CExpertTrailing {
protected:
  CiMA *m_MA;

  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_PRICE m_ma_applied;

public:
  CTrailingMA(void);
  ~CTrailingMA(void);

  void Period(int period) ;
  void Shift(int shift) ;

  void Method(ENUM_MA_METHOD method) ;
  void Applied(ENUM_APPLIED_PRICE applied) ;
  virtual bool InitIndicators(CIndicators *indicators);
  virtual bool ValidationSettings(void);

  virtual bool CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                     double &tp);
  virtual bool CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                      double &tp);
};







#endif
