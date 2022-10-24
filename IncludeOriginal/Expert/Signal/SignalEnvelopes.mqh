#ifndef SIGNAL_ENVELOPES_H
#define SIGNAL_ENVELOPES_H

#include <Expert\ExpertSignal.mqh>

class CSignalEnvelopes : public CExpertSignal {
protected:
  CiEnvelopes m_env;

  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_PRICE m_ma_applied;
  double m_deviation;
  double m_limit_in;
  double m_limit_out;

  int m_pattern_0;
  int m_pattern_1;

public:
  CSignalEnvelopes(void);
  ~CSignalEnvelopes(void);

  void PeriodMA(int value) {
    m_ma_period = value;
  }
  void Shift(int value) {
    m_ma_shift = value;
  }
  void Method(ENUM_MA_METHOD value) {
    m_ma_method = value;
  }
  void Applied(ENUM_APPLIED_PRICE value) {
    m_ma_applied = value;
  }
  void Deviation(double value) {
    m_deviation = value;
  }
  void LimitIn(double value) {
    m_limit_in = value;
  }
  void LimitOut(double value) {
    m_limit_out = value;
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
  bool InitMA(CIndicators *indicators);

  double Upper(int ind) {
    return (m_env.Upper(ind));
  }
  double Lower(int ind) {
    return (m_env.Lower(ind));
  }
};

CSignalEnvelopes::CSignalEnvelopes(void)
    : m_ma_period(45), m_ma_shift(0), m_ma_method(MODE_SMA),
      m_ma_applied(PRICE_CLOSE), m_deviation(0.15), m_limit_in(0.2),
      m_limit_out(0.2), m_pattern_0(90), m_pattern_1(70) {

  m_used_series =
      USE_SERIES_OPEN + USE_SERIES_HIGH + USE_SERIES_LOW + USE_SERIES_CLOSE;
}

CSignalEnvelopes::~CSignalEnvelopes(void) {
}

bool CSignalEnvelopes::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_ma_period <= 0) {
    printf(__FUNCTION__ + ": period MA must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalEnvelopes::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitMA(indicators))
    return (false);

  return (true);
}

bool CSignalEnvelopes::InitMA(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_env))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_env.Create(m_symbol.Name(), m_period, m_ma_period, m_ma_shift,
                    m_ma_method, m_ma_applied, m_deviation)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalEnvelopes::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();
  double close = Close(idx);
  double upper = Upper(idx);
  double lower = Lower(idx);
  double width = upper - lower;

  if (IS_PATTERN_USAGE(0) && close < lower + m_limit_in * width &&
      close > lower - m_limit_out * width)
    result = m_pattern_0;

  if (IS_PATTERN_USAGE(1) && close > upper + m_limit_out * width)
    result = m_pattern_1;

  return (result);
}

int CSignalEnvelopes::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();
  double close = Close(idx);
  double upper = Upper(idx);
  double lower = Lower(idx);
  double width = upper - lower;

  if (IS_PATTERN_USAGE(0) && close > upper - m_limit_in * width &&
      close < upper + m_limit_out * width)
    result = m_pattern_0;

  if (IS_PATTERN_USAGE(1) && close < lower - m_limit_out * width)
    result = m_pattern_1;

  return (result);
}

#endif
