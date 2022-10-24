#ifndef SIGNAL_STOCH_H
#define SIGNAL_STOCH_H

#include <Expert\ExpertSignal.mqh>

class CSignalStoch : public CExpertSignal {
protected:
  CiStochastic m_stoch;
  CPriceSeries *m_app_price_high;
  CPriceSeries *m_app_price_low;

  int m_periodK;
  int m_periodD;
  int m_period_slow;
  ENUM_STO_PRICE m_applied;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;
  int m_pattern_4;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalStoch(void);
  ~CSignalStoch(void);

  void PeriodK(int value) {
    m_periodK = value;
  }
  void PeriodD(int value) {
    m_periodD = value;
  }
  void PeriodSlow(int value) {
    m_period_slow = value;
  }
  void Applied(ENUM_STO_PRICE value) {
    m_applied = value;
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
  void Pattern_4(int value) {
    m_pattern_4 = value;
  }

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitStoch(CIndicators *indicators);

  double Main(int ind) {
    return (m_stoch.Main(ind));
  }
  double DiffMain(int ind) {
    return (Main(ind) - Main(ind + 1));
  }
  double Signal(int ind) {
    return (m_stoch.Signal(ind));
  }
  double DiffSignal(int ind) {
    return (Signal(ind) - Signal(ind + 1));
  }
  double DiffMainSignal(int ind) {
    return (Main(ind) - Signal(ind));
  }
  int StateStoch(int ind);
  bool ExtStateStoch(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
  void DiverDebugPrint();
};

CSignalStoch::CSignalStoch(void)
    : m_periodK(8), m_periodD(3), m_period_slow(3), m_applied(STO_LOWHIGH),
      m_pattern_0(30), m_pattern_1(60), m_pattern_2(50), m_pattern_3(100),
      m_pattern_4(90) {

  m_used_series =
      USE_SERIES_OPEN + USE_SERIES_HIGH + USE_SERIES_LOW + USE_SERIES_CLOSE;
}

CSignalStoch::~CSignalStoch(void) {
}

bool CSignalStoch::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_periodK <= 0) {
    printf(
        __FUNCTION__ +
        ": the period %K of the Stochastic oscillator must be greater than 0");
    return (false);
  }
  if (m_periodD <= 0) {
    printf(
        __FUNCTION__ +
        ": the period %D of the Stochastic oscillator must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalStoch::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitStoch(indicators))
    return (false);
  if (m_applied == STO_CLOSECLOSE) {

    m_app_price_high = GetPointer(m_close);

    m_app_price_low = GetPointer(m_close);
  } else {

    m_app_price_high = GetPointer(m_high);

    m_app_price_low = GetPointer(m_low);
  }

  return (true);
}

bool CSignalStoch::InitStoch(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_stoch))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_stoch.Create(m_symbol.Name(), m_period, m_periodK, m_periodD,
                      m_period_slow, MODE_SMA, m_applied)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalStoch::StateStoch(int ind) {
  int res = 0;
  double var;

  for (int i = ind;; i++) {
    if (Main(i + 1) == EMPTY_VALUE)
      break;
    var = DiffMain(i);
    if (res > 0) {
      if (var < 0)
        break;
      res++;
      continue;
    }
    if (res < 0) {
      if (var > 0)
        break;
      res--;
      continue;
    }
    if (var > 0)
      res++;
    if (var < 0)
      res--;
  }

  return (res);
}

bool CSignalStoch::ExtStateStoch(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = StateStoch(pos);
    if (off > 0) {

      pos += off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = Main(pos);
      if (i > 1) {
        m_extr_pr[i] = m_low.MinValue(pos - 2, 5, index);

        map = 0;
        if (m_extr_pr[i - 2] < m_extr_pr[i])
          map += 1;
        if (m_extr_osc[i - 2] < m_extr_osc[i])
          map += 4;

        m_extr_map += map << (4 * (i - 2));
      } else
        m_extr_pr[i] = m_low.MinValue(pos - 1, 4, index);
    } else {

      pos -= off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = Main(pos);
      if (i > 1) {
        m_extr_pr[i] = m_high.MaxValue(pos - 2, 5, index);

        map = 0;
        if (m_extr_pr[i - 2] > m_extr_pr[i])
          map += 1;
        if (m_extr_osc[i - 2] > m_extr_osc[i])
          map += 4;

        m_extr_map += map << (4 * (i - 2));
      } else
        m_extr_pr[i] = m_high.MaxValue(pos - 1, 4, index);
    }
  }

  return (true);
}

bool CSignalStoch::CompareMaps(int map, int count, bool minimax = false,
                               int start = 0) {
  int step = (minimax) ? 4 : 8;
  int total = step * (start + count);

  if (total > 32)
    return (false);

  uint inp_map, check_map;
  int i, j;

  for (i = step * start, j = 0; i < total; i += step, j += 4) {

    inp_map = (map >> j) & 3;

    if (inp_map < 2) {

      check_map = (m_extr_map >> i) & 3;
      if (inp_map != check_map)
        return (false);
    }

    inp_map = (map >> (j + 2)) & 3;

    if (inp_map >= 2)
      continue;

    check_map = (m_extr_map >> (i + 2)) & 3;
    if (inp_map != check_map)
      return (false);
  }

  return (true);
}

int CSignalStoch::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffMain(idx) > 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && DiffMain(idx + 1) < 0.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) && DiffMainSignal(idx) > 0.0 &&
        DiffMainSignal(idx + 1) < 0.0)
      result = m_pattern_2;

    if ((IS_PATTERN_USAGE(3) || IS_PATTERN_USAGE(4))) {

      ExtStateStoch(idx);

      if (IS_PATTERN_USAGE(3) && CompareMaps(1, 1))
        result = m_pattern_3;

      if (IS_PATTERN_USAGE(4) && CompareMaps(0x11, 2))
        return (m_pattern_4);
    }
  }

  return (result);
}

int CSignalStoch::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffMain(idx) < 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && DiffMain(idx + 1) > 0.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) && DiffMainSignal(idx) < 0.0 &&
        DiffMainSignal(idx + 1) > 0.0)
      result = m_pattern_2;

    if ((IS_PATTERN_USAGE(3) || IS_PATTERN_USAGE(4))) {

      ExtStateStoch(idx);

      if (IS_PATTERN_USAGE(3) && CompareMaps(1, 1))
        result = m_pattern_3;

      if (IS_PATTERN_USAGE(4) && CompareMaps(0x11, 2))
        return (m_pattern_4);
    }
  }

  return (result);
}

#endif
