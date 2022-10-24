#ifndef SIGNAL_MACD_H
#define SIGNAL_MACD_H

#include <Expert\ExpertSignal.mqh>

class CSignalMACD : public CExpertSignal {
protected:
  CiMACD m_MACD;

  int m_period_fast;
  int m_period_slow;
  int m_period_signal;
  ENUM_APPLIED_PRICE m_applied;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;
  int m_pattern_4;
  int m_pattern_5;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalMACD(void);
  ~CSignalMACD(void);

  void PeriodFast(int value) {
    m_period_fast = value;
  }
  void PeriodSlow(int value) {
    m_period_slow = value;
  }
  void PeriodSignal(int value) {
    m_period_signal = value;
  }
  void Applied(ENUM_APPLIED_PRICE value) {
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
  void Pattern_5(int value) {
    m_pattern_5 = value;
  }

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitMACD(CIndicators *indicators);

  double Main(int ind) {
    return (m_MACD.Main(ind));
  }
  double Signal(int ind) {
    return (m_MACD.Signal(ind));
  }
  double DiffMain(int ind) {
    return (Main(ind) - Main(ind + 1));
  }
  int StateMain(int ind);
  double State(int ind) {
    return (Main(ind) - Signal(ind));
  }
  bool ExtState(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

CSignalMACD::CSignalMACD(void)
    : m_period_fast(12), m_period_slow(24), m_period_signal(9),
      m_applied(PRICE_CLOSE), m_pattern_0(10), m_pattern_1(30), m_pattern_2(80),
      m_pattern_3(50), m_pattern_4(60), m_pattern_5(100) {

  m_used_series = USE_SERIES_HIGH + USE_SERIES_LOW;
}

CSignalMACD::~CSignalMACD(void) {}

bool CSignalMACD::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_period_fast >= m_period_slow) {
    printf(__FUNCTION__ + ": slow period must be greater than fast period");
    return (false);
  }

  return (true);
}

bool CSignalMACD::InitIndicators(CIndicators *indicators) {

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitMACD(indicators))
    return (false);

  return (true);
}

bool CSignalMACD::InitMACD(CIndicators *indicators) {

  if (!indicators.Add(GetPointer(m_MACD))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_MACD.Create(m_symbol.Name(), m_period, m_period_fast, m_period_slow,
                     m_period_signal, m_applied)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalMACD::StateMain(int ind) {
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

bool CSignalMACD::ExtState(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = StateMain(pos);
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

bool CSignalMACD::CompareMaps(int map, int count, bool minimax, int start) {
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

int CSignalMACD::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffMain(idx) > 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && DiffMain(idx + 1) < 0.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) && State(idx) > 0.0 && State(idx + 1) < 0.0)
      result = m_pattern_2;

    if (IS_PATTERN_USAGE(3) && Main(idx) > 0.0 && Main(idx + 1) < 0.0)
      result = m_pattern_3;

    if ((IS_PATTERN_USAGE(4) || IS_PATTERN_USAGE(5)) && Main(idx) < 0.0) {

      ExtState(idx);

      if (IS_PATTERN_USAGE(4) && CompareMaps(1, 1))
        result = m_pattern_4;

      if (IS_PATTERN_USAGE(5) && CompareMaps(0x11, 2))
        return (m_pattern_5);
    }
  }

  return (result);
}

int CSignalMACD::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffMain(idx) < 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && DiffMain(idx + 1) > 0.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) && State(idx) < 0.0 && State(idx + 1) > 0.0)
      result = m_pattern_2;

    if (IS_PATTERN_USAGE(3) && Main(idx) < 0.0 && Main(idx + 1) > 0.0)
      result = m_pattern_3;

    if ((IS_PATTERN_USAGE(4) || IS_PATTERN_USAGE(5)) && Main(idx) > 0.0) {

      ExtState(idx);

      if (IS_PATTERN_USAGE(4) && CompareMaps(1, 1))
        result = m_pattern_4;

      if (IS_PATTERN_USAGE(5) && CompareMaps(0x11, 2))
        return (m_pattern_5);
    }
  }

  return (result);
}

#endif
