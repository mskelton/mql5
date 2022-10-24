#ifndef SIGNAL_MACD_H
#define SIGNAL_MACD_H

#include <Expert/ExpertSignal.mqh>

class CSignalMACD : public CExpertSignal {
protected:
  CiMACD m_MACD;

  int m_period_fast;
  int m_period_slow;
  int m_period_signal;
  ENUM_APPLIED_PRICE m_applied;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;
  int m_pattern_4;
  int m_pattern_5;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalMACD(void);
  ~CSignalMACD(void);

  void PeriodFast(int value);
  void PeriodSlow(int value);
  void PeriodSignal(int value);
  void Applied(ENUM_APPLIED_PRICE value);

  void Pattern_0(int value);
  void Pattern_1(int value);
  void Pattern_2(int value);
  void Pattern_3(int value);
  void Pattern_4(int value);
  void Pattern_5(int value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitMACD(CIndicators *indicators);

  double Main(int ind);
  double Signal(int ind);
  double DiffMain(int ind);
  int StateMain(int ind);
  double State(int ind);
  bool ExtState(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

#endif
