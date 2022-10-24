#ifndef SIGNAL_TRIX_H
#define SIGNAL_TRIX_H

#include <Expert/ExpertSignal.mqh>

class CSignalTriX : public CExpertSignal {
protected:
  CiTriX m_trix;

  int m_period_trix;
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
  CSignalTriX(void);
  ~CSignalTriX(void);

  void PeriodTriX(int value);
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
  bool InitTriX(CIndicators *indicators);

  double TriX(int ind);
  double DiffTriX(int ind);
  int State(int ind);
  bool ExtState(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

#endif
