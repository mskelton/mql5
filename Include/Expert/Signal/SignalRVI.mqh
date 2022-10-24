#ifndef SIGNAL_RVI_H
#define SIGNAL_RVI_H

#include <Expert/ExpertSignal.mqh>

class CSignalRVI : public CExpertSignal {
protected:
  CiRVI m_rvi;

  int m_periodRVI;

  int m_pattern_0;
  int m_pattern_1;

public:
  CSignalRVI(void);
  ~CSignalRVI(void);

  void PeriodRVI(int value) ;

  void Pattern_0(int value) ;
  void Pattern_1(int value) ;

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitRVI(CIndicators *indicators);

  double Main(int ind) ;
  double DiffMain(int ind) ;
  double Signal(int ind) ;
  double DiffSignal(int ind) ;
  double DiffMainSignal(int ind) ;
};








#endif
