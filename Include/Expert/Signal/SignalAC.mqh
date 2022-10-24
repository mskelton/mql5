#ifndef SIGNAL_AC_H
#define SIGNAL_AC_H

#include <Expert/ExpertSignal.mqh>

class CSignalAC : public CExpertSignal {
protected:
  CiAC m_ac;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;

public:
  CSignalAC(void);
  ~CSignalAC(void);

  void Pattern_0(int value);
  void Pattern_1(int value);
  void Pattern_2(int value);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitAC(CIndicators *indicators);

  double AC(int ind);
  double DiffAC(int ind);
};

#endif
