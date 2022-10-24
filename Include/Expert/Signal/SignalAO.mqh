#ifndef SIGNAL_AO_H
#define SIGNAL_AO_H

#include <Expert/ExpertSignal.mqh>

class CSignalAO : public CExpertSignal {
protected:
  CiAO m_ao;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalAO(void);
  ~CSignalAO(void);

  void Pattern_0(int value) ;
  void Pattern_1(int value) ;
  void Pattern_2(int value) ;
  void Pattern_3(int value) ;

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitAO(CIndicators *indicators);

  double AO(int ind) ;
  double DiffAO(int ind) ;
  int StateAO(int ind);
  bool ExtStateAO(int ind);
};









#endif
