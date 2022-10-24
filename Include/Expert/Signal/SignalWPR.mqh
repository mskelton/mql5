#ifndef SIGNAL_WPR_H
#define SIGNAL_WPR_H

#include <Expert/ExpertSignal.mqh>

class CSignalWPR : public CExpertSignal {
protected:
  CiWPR m_wpr;

  int m_period_wpr;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalWPR(void);
  ~CSignalWPR(void);

  void PeriodWPR(int value);

  void Pattern_0(int value);
  void Pattern_1(int value);
  void Pattern_2(int value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitWPR(CIndicators *indicators);

  double WPR(int ind);
  double Diff(int ind);
  int State(int ind);
  bool ExtState(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

#endif
