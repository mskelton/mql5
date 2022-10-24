#ifndef SIGNAL_AC_H
#define SIGNAL_AC_H

#include <Expert\ExpertSignal.mqh>

class CSignalAC : public CExpertSignal {
protected:
  CiAC m_ac;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;

public:
  CSignalAC(void);
  ~CSignalAC(void);

  void Pattern_0(int value) {
    m_pattern_0 = value;
  }
  void Pattern_1(int value) {
    m_pattern_1 = value;
  }
  void Pattern_2(int value) {
    m_pattern_2 = value;
  }

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitAC(CIndicators *indicators);

  double AC(int ind) {
    return (m_ac.Main(ind));
  }
  double DiffAC(int ind) {
    return (AC(ind) - AC(ind + 1));
  }
};

CSignalAC::CSignalAC(void) : m_pattern_0(90), m_pattern_1(50), m_pattern_2(30) {
}

CSignalAC::~CSignalAC(void) {
}

bool CSignalAC::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitAC(indicators))
    return (false);

  return (true);
}

bool CSignalAC::InitAC(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_ac))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_ac.Create(m_symbol.Name(), m_period)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalAC::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffAC(idx++) < 0.0)
    return (result);

  if (IS_PATTERN_USAGE(0))
    result = m_pattern_0;

  if (DiffAC(idx) < 0.0)
    return (result);

  if (AC(idx++) < 0.0) {

    if (DiffAC(idx++) < 0.0)
      return (result);
  }

  if (IS_PATTERN_USAGE(1))
    result = m_pattern_1;

  if (IS_PATTERN_USAGE(2) && DiffAC(idx) < 0.0)
    result = m_pattern_2;

  return (result);
}

int CSignalAC::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffAC(idx++) > 0.0)
    return (result);

  if (IS_PATTERN_USAGE(0))
    result = m_pattern_0;

  if (DiffAC(idx) > 0.0)
    return (result);

  if (AC(idx++) > 0.0) {

    if (DiffAC(idx++) > 0.0)
      return (result);
  }

  if (IS_PATTERN_USAGE(1))
    result = m_pattern_1;

  if (IS_PATTERN_USAGE(2) && DiffAC(idx) > 0.0)
    result = m_pattern_2;

  return (result);
}

#endif
