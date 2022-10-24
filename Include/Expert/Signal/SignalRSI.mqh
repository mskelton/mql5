#ifndef SIGNAL_RSI_H
#define SIGNAL_RSI_H

#include <Expert/ExpertSignal.mqh>

class CSignalRSI : public CExpertSignal {
protected:
  CiRSI m_rsi;

  int m_periodRSI;
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
  CSignalRSI(void);
  ~CSignalRSI(void);

  void PeriodRSI(int value) ;
  void Applied(ENUM_APPLIED_PRICE value) ;

  void Pattern_0(int value) ;
  void Pattern_1(int value) ;
  void Pattern_2(int value) ;
  void Pattern_3(int value) ;
  void Pattern_4(int value) ;
  void Pattern_5(int value) ;

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitRSI(CIndicators *indicators);

  double RSI(int ind) ;
  double DiffRSI(int ind) ;
  int StateRSI(int ind);
  bool ExtStateRSI(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};











#endif
