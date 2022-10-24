#ifndef SIGNAL_SAR_H
#define SIGNAL_SAR_H

#include <Expert/ExpertSignal.mqh>

class CSignalSAR : public CExpertSignal {
protected:
  CiSAR m_sar;

  double m_step;
  double m_maximum;

  int m_pattern_0;
  int m_pattern_1;

public:
  CSignalSAR(void);
  ~CSignalSAR(void);

  void Step(double value);
  void Maximum(double value);

  void Pattern_0(int value);
  void Pattern_1(int value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitSAR(CIndicators *indicators);

  double SAR(int ind);
  double Close(int ind);
  double DiffClose(int ind);
};

#endif
