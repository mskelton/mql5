#ifndef SIGNAL_CCI_H
#define SIGNAL_CCI_H

#include <Expert/ExpertSignal.mqh>

class CSignalCCI : public CExpertSignal {
protected:
  CiCCI m_cci;

  int m_periodCCI;
  ENUM_APPLIED_PRICE m_applied;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalCCI(void);
  ~CSignalCCI(void);

  void PeriodCCI(int value);
  void Applied(ENUM_APPLIED_PRICE value);

  void Pattern_0(int value);
  void Pattern_1(int value);
  void Pattern_2(int value);
  void Pattern_3(int value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitStoch(CIndicators *indicators);

  double CCI(int ind);
  double Diff(int ind);
  int State(int ind);
  bool ExtState(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

#endif
