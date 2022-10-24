#ifndef SIGNAL_BULLS_POWER_H
#define SIGNAL_BULLS_POWER_H

#include <Expert/ExpertSignal.mqh>

class CSignalBullsPower : public CExpertSignal {
protected:
  CiBullsPower m_bulls;

  int m_period_bulls;

  int m_pattern_0;
  int m_pattern_1;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalBullsPower(void);
  ~CSignalBullsPower(void);

  void PeriodBulls(int value);

  void Pattern_0(int value);
  void Pattern_1(int value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int ShortCondition(void);

protected:
  bool InitBears(CIndicators *indicators);

  double Bulls(int ind);
  double DiffBulls(int ind);
  int StateBulls(int ind);
  bool ExtStateBulls(int ind);
};

#endif
