#ifndef SIGNAL_BEARS_POWER_H
#define SIGNAL_BEARS_POWER_H

#include <Expert/ExpertSignal.mqh>

class CSignalBearsPower : public CExpertSignal {
protected:
  CiBearsPower m_bears;

  int m_period_bears;

  int m_pattern_0;
  int m_pattern_1;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalBearsPower(void);
  ~CSignalBearsPower(void);

  void PeriodBears(int value) ;

  void Pattern_0(int value) ;
  void Pattern_1(int value) ;

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);

protected:
  bool InitBears(CIndicators *indicators);

  double Bears(int ind) ;
  double DiffBears(int ind) ;
  int StateBears(int ind);
  bool ExtStateBears(int ind);
};









#endif
