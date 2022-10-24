#ifndef SIGNAL_SAR_H
#define SIGNAL_SAR_H

#include <Expert\ExpertSignal.mqh>

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

  void Step(double value) {
    m_step = value;
  }
  void Maximum(double value) {
    m_maximum = value;
  }

  void Pattern_0(int value) {
    m_pattern_0 = value;
  }
  void Pattern_1(int value) {
    m_pattern_1 = value;
  }

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitSAR(CIndicators *indicators);

  double SAR(int ind) {
    return (m_sar.Main(ind));
  }
  double Close(int ind) {
    return (m_close.GetData(ind));
  }
  double DiffClose(int ind) {
    return (Close(ind) - SAR(ind));
  }
};

CSignalSAR::CSignalSAR(void)
    : m_step(0.02), m_maximum(0.2), m_pattern_0(40), m_pattern_1(90) {

  m_used_series = USE_SERIES_CLOSE;
}

CSignalSAR::~CSignalSAR(void) {}

bool CSignalSAR::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  return (true);
}

bool CSignalSAR::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitSAR(indicators))
    return (false);

  return (true);
}

bool CSignalSAR::InitSAR(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_sar))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_sar.Create(m_symbol.Name(), m_period, m_step, m_maximum)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalSAR::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffClose(idx++) < 0.0)
    return (result);

  if (IS_PATTERN_USAGE(0))
    result = m_pattern_0;

  if (IS_PATTERN_USAGE(1) && DiffClose(idx) < 0.0)
    return (m_pattern_1);

  return (result);
}

int CSignalSAR::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffClose(idx++) > 0.0)
    return (result);

  if (IS_PATTERN_USAGE(0))
    result = m_pattern_0;

  if (IS_PATTERN_USAGE(1) && DiffClose(idx) > 0.0)
    return (m_pattern_1);

  return (result);
}

#endif
