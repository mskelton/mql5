#ifndef SIGNAL_STOCH_H
#define SIGNAL_STOCH_H

#include <Expert/ExpertSignal.mqh>

class CSignalStoch : public CExpertSignal {
protected:
  CiStochastic m_stoch;
  CPriceSeries *m_app_price_high;
  CPriceSeries *m_app_price_low;

  int m_periodK;
  int m_periodD;
  int m_period_slow;
  ENUM_STO_PRICE m_applied;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;
  int m_pattern_4;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalStoch(void);
  ~CSignalStoch(void);

  void PeriodK(int value);
  void PeriodD(int value);
  void PeriodSlow(int value);
  void Applied(ENUM_STO_PRICE value);

  void Pattern_0(int value);
  void Pattern_1(int value);
  void Pattern_2(int value);
  void Pattern_3(int value);
  void Pattern_4(int value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitStoch(CIndicators *indicators);

  double Main(int ind);
  double DiffMain(int ind);
  double Signal(int ind);
  double DiffSignal(int ind);
  double DiffMainSignal(int ind);
  int StateStoch(int ind);
  bool ExtStateStoch(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
  void DiverDebugPrint();
};

#endif
