#ifndef SIGNAL_ENVELOPES_H
#define SIGNAL_ENVELOPES_H

#include <Expert/ExpertSignal.mqh>

class CSignalEnvelopes : public CExpertSignal {
protected:
  CiEnvelopes m_env;

  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_PRICE m_ma_applied;
  double m_deviation;
  double m_limit_in;
  double m_limit_out;

  int m_pattern_0;
  int m_pattern_1;

public:
  CSignalEnvelopes(void);
  ~CSignalEnvelopes(void);

  void PeriodMA(int value);
  void Shift(int value);
  void Method(ENUM_MA_METHOD value);
  void Applied(ENUM_APPLIED_PRICE value);
  void Deviation(double value);
  void LimitIn(double value);
  void LimitOut(double value);

  void Pattern_0(int value);
  void Pattern_1(int value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitMA(CIndicators *indicators);

  double Upper(int ind);
  double Lower(int ind);
};

#endif
