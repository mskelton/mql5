#ifndef SIGNAL_RVI_H
#define SIGNAL_RVI_H

#include <Expert\ExpertSignal.mqh>

class CSignalRVI : public CExpertSignal {
protected:
  CiRVI m_rvi;

  int m_periodRVI;

  int m_pattern_0;
  int m_pattern_1;

public:
  CSignalRVI(void);
  ~CSignalRVI(void);

  void PeriodRVI(int value) {
    m_periodRVI = value;
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
  bool InitRVI(CIndicators *indicators);

  double Main(int ind) {
    return (m_rvi.Main(ind));
  }
  double DiffMain(int ind) {
    return (Main(ind) - Main(ind + 1));
  }
  double Signal(int ind) {
    return (m_rvi.Signal(ind));
  }
  double DiffSignal(int ind) {
    return (Signal(ind) - Signal(ind + 1));
  }
  double DiffMainSignal(int ind) {
    return (Main(ind) - Signal(ind));
  }
};

CSignalRVI::CSignalRVI(void)
    : m_periodRVI(10), m_pattern_0(60), m_pattern_1(100) {
}

CSignalRVI::~CSignalRVI(void) {
}

bool CSignalRVI::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_periodRVI <= 0) {
    printf(__FUNCTION__ + ": the period of calculation of the RVI oscillator "
                          "must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalRVI::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitRVI(indicators))
    return (false);

  return (true);
}

bool CSignalRVI::InitRVI(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_rvi))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_rvi.Create(m_symbol.Name(), m_period, m_periodRVI)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalRVI::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffMain(idx) > 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (DiffMainSignal(idx) > 0 && DiffMainSignal(idx + 1) < 0) {

      if (IS_PATTERN_USAGE(1))
        result = m_pattern_1;
    }
  }

  return (result);
}

int CSignalRVI::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffMain(idx) < 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (DiffMainSignal(idx) < 0 && DiffMainSignal(idx + 1) > 0) {

      if (IS_PATTERN_USAGE(1))
        result = m_pattern_1;
    }
  }

  return (result);
}

#endif
