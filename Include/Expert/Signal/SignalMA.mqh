#ifndef SIGNAL_MA_H
#define SIGNAL_MA_H

#include <Expert/ExpertSignal.mqh>

class CSignalMA : public CExpertSignal {
protected:
  CiMA m_ma;

  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_PRICE m_ma_applied;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;

public:
  CSignalMA(void);
  ~CSignalMA(void);

  void PeriodMA(int value) ;
  void Shift(int value) ;
  void Method(ENUM_MA_METHOD value) ;
  void Applied(ENUM_APPLIED_PRICE value) ;

  void Pattern_0(int value) ;
  void Pattern_1(int value) ;
  void Pattern_2(int value) ;
  void Pattern_3(int value) ;

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitMA(CIndicators *indicators);

  double MA(int ind) ;
  double DiffMA(int ind) ;
  double DiffOpenMA(int ind) ;
  double DiffHighMA(int ind) ;
  double DiffLowMA(int ind) ;
  double DiffCloseMA(int ind) ;
};








#endif
