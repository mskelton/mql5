#ifndef SIGNAL_MA_H
#define SIGNAL_MA_H

#include <Expert\ExpertSignal.mqh>

class CSignalMA : public CExpertSignal {
protected:
  CiMA m_ma;

  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_PRICE m_ma_applied;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;

public:
  CSignalMA(void);
  ~CSignalMA(void);

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

  void Pattern_0(int value) {
    m_pattern_0 = value;
  }
  void Pattern_1(int value) {
    m_pattern_1 = value;
  }
  void Pattern_2(int value) {
    m_pattern_2 = value;
  }
  void Pattern_3(int value) {
    m_pattern_3 = value;
  }

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitMA(CIndicators *indicators);

  double MA(int ind) {
    return (m_ma.Main(ind));
  }
  double DiffMA(int ind) {
    return (MA(ind) - MA(ind + 1));
  }
  double DiffOpenMA(int ind) {
    return (Open(ind) - MA(ind));
  }
  double DiffHighMA(int ind) {
    return (High(ind) - MA(ind));
  }
  double DiffLowMA(int ind) {
    return (Low(ind) - MA(ind));
  }
  double DiffCloseMA(int ind) {
    return (Close(ind) - MA(ind));
  }
};

CSignalMA::CSignalMA(void)
    : m_ma_period(12), m_ma_shift(0), m_ma_method(MODE_SMA),
      m_ma_applied(PRICE_CLOSE), m_pattern_0(80), m_pattern_1(10),
      m_pattern_2(60), m_pattern_3(60) {

  m_used_series =
      USE_SERIES_OPEN + USE_SERIES_HIGH + USE_SERIES_LOW + USE_SERIES_CLOSE;
}

CSignalMA::~CSignalMA(void) {
}

bool CSignalMA::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_ma_period <= 0) {
    printf(__FUNCTION__ + ": period MA must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalMA::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitMA(indicators))
    return (false);

  return (true);
}

bool CSignalMA::InitMA(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_ma))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_ma.Create(m_symbol.Name(), m_period, m_ma_period, m_ma_shift,
                   m_ma_method, m_ma_applied)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalMA::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffCloseMA(idx) < 0.0) {

    if (IS_PATTERN_USAGE(1) && DiffOpenMA(idx) > 0.0 && DiffMA(idx) > 0.0) {

      result = m_pattern_1;

      m_base_price = 0.0;
    }
  } else {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (DiffMA(idx) > 0.0) {
      if (DiffOpenMA(idx) < 0.0) {

        if (IS_PATTERN_USAGE(2)) {

          result = m_pattern_2;

          m_base_price = m_symbol.NormalizePrice(MA(idx));
        }
      } else {

        if (IS_PATTERN_USAGE(3) && DiffLowMA(idx) < 0.0) {

          result = m_pattern_3;

          m_base_price = 0.0;
        }
      }
    }
  }

  return (result);
}

int CSignalMA::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffCloseMA(idx) > 0.0) {

    if (IS_PATTERN_USAGE(1) && DiffOpenMA(idx) < 0.0 && DiffMA(idx) < 0.0) {

      result = m_pattern_1;

      m_base_price = 0.0;
    }
  } else {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (DiffMA(idx) < 0.0) {
      if (DiffOpenMA(idx) > 0.0) {

        if (IS_PATTERN_USAGE(2)) {

          result = m_pattern_2;

          m_base_price = m_symbol.NormalizePrice(MA(idx));
        }
      } else {

        if (IS_PATTERN_USAGE(3) && DiffHighMA(idx) > 0.0) {

          result = m_pattern_3;

          m_base_price = 0.0;
        }
      }
    }
  }

  return (result);
}

#endif
