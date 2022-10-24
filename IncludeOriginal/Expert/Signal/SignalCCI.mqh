#ifndef SIGNAL_CCI_H
#define SIGNAL_CCI_H

#include <Expert\ExpertSignal.mqh>

class CSignalCCI : public CExpertSignal {
protected:
  CiCCI m_cci;

  int m_periodCCI;
  ENUM_APPLIED_PRICE m_applied;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalCCI(void);
  ~CSignalCCI(void);

  void PeriodCCI(int value) {
    m_periodCCI = value;
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

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitStoch(CIndicators *indicators);

  double CCI(int ind) {
    return (m_cci.Main(ind));
  }
  double Diff(int ind) {
    return (CCI(ind) - CCI(ind + 1));
  }
  int State(int ind);
  bool ExtState(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

CSignalCCI::CSignalCCI(void)
    : m_periodCCI(14), m_applied(PRICE_CLOSE), m_pattern_0(90), m_pattern_1(60),
      m_pattern_2(100), m_pattern_3(50) {

  m_used_series = USE_SERIES_HIGH + USE_SERIES_LOW;
}

CSignalCCI::~CSignalCCI(void) {
}

bool CSignalCCI::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_periodCCI <= 0) {
    printf(__FUNCTION__ +
           ": period of the CCI oscillator must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalCCI::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitStoch(indicators))
    return (false);

  return (true);
}

bool CSignalCCI::InitStoch(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_cci))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_cci.Create(m_symbol.Name(), m_period, m_periodCCI, m_applied)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalCCI::State(int ind) {
  int res = 0;
  double var;

  for (int i = ind;; i++) {
    if (CCI(i + 1) == EMPTY_VALUE)
      break;
    var = Diff(i);
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

bool CSignalCCI::ExtState(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = State(pos);
    if (off > 0) {

      pos += off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = CCI(pos);
      if (i > 1) {
        m_extr_pr[i] = m_low.MinValue(pos - 2, 5, index);

        map = 0;
        if (m_extr_pr[i - 2] < m_extr_pr[i])
          map += 1;
        if (m_extr_osc[i - 2] < m_extr_osc[i])
          map += 4;

        m_extr_map += map << (4 * (i - 2));
      } else
        m_extr_pr[i] = m_low.MinValue(pos - 1, 3, index);
    } else {

      pos -= off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = CCI(pos);
      if (i > 1) {
        m_extr_pr[i] = m_high.MaxValue(pos - 2, 5, index);

        map = 0;
        if (m_extr_pr[i - 2] > m_extr_pr[i])
          map += 1;
        if (m_extr_osc[i - 2] > m_extr_osc[i])
          map += 4;

        m_extr_map += map << (4 * (i - 2));
      } else
        m_extr_pr[i] = m_high.MaxValue(pos - 1, 3, index);
    }
  }

  return (true);
}

bool CSignalCCI::CompareMaps(int map, int count, bool minimax, int start) {
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

int CSignalCCI::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (Diff(idx) > 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && Diff(idx + 1) < 0.0 && CCI(idx + 1) < -100.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) || IS_PATTERN_USAGE(3)) {
      ExtState(idx);

      if (IS_PATTERN_USAGE(2) && CompareMaps(1, 1))
        result = m_pattern_2;

      if (IS_PATTERN_USAGE(3) && CompareMaps(0x11, 2))
        return (m_pattern_3);
    }
  }

  return (result);
}

int CSignalCCI::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (Diff(idx) < 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && Diff(idx + 1) > 0.0 && CCI(idx + 1) > 100.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) || IS_PATTERN_USAGE(3)) {
      ExtState(idx);

      if (IS_PATTERN_USAGE(2) && CompareMaps(1, 1))
        result = m_pattern_2;

      if (IS_PATTERN_USAGE(3) && CompareMaps(0x11, 2))
        return (m_pattern_3);
    }
  }

  return (result);
}

#endif
