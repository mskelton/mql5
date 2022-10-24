#ifndef SIGNAL_DE_MARKER_H
#define SIGNAL_DE_MARKER_H

#include <Expert/ExpertSignal.mqh>

class CSignalDeM : public CExpertSignal {
protected:
  CiDeMarker m_dem;

  int m_periodDeM;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalDeM(void);
  ~CSignalDeM(void);

  void PeriodDeM(int value);

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

  double DeM(int ind);
  double DiffDeM(int ind);
  int StateDeM(int ind);
  bool ExtStateDeM(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

#endif
