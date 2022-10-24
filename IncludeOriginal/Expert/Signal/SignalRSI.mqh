#ifndef SIGNAL_RSI_H
#define SIGNAL_RSI_H

#include <Expert\ExpertSignal.mqh>

class CSignalRSI : public CExpertSignal {
protected:
  CiRSI m_rsi;

  int m_periodRSI;
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
  CSignalRSI(void);
  ~CSignalRSI(void);

  void PeriodRSI(int value) {
    m_periodRSI = value;
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
  bool InitRSI(CIndicators *indicators);

  double RSI(int ind) {
    return (m_rsi.Main(ind));
  }
  double DiffRSI(int ind) {
    return (RSI(ind) - RSI(ind + 1));
  }
  int StateRSI(int ind);
  bool ExtStateRSI(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

CSignalRSI::CSignalRSI(void)
    : m_periodRSI(14), m_applied(PRICE_CLOSE), m_pattern_0(70),
      m_pattern_1(100), m_pattern_2(90), m_pattern_3(80), m_pattern_4(100),
      m_pattern_5(20) {

  m_used_series = USE_SERIES_HIGH + USE_SERIES_LOW;
}

CSignalRSI::~CSignalRSI(void) {
}

bool CSignalRSI::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_periodRSI <= 0) {
    printf(__FUNCTION__ +
           ": period of the RSI oscillator must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalRSI::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitRSI(indicators))
    return (false);

  return (true);
}

bool CSignalRSI::InitRSI(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_rsi))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_rsi.Create(m_symbol.Name(), m_period, m_periodRSI, m_applied)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalRSI::StateRSI(int ind) {
  int res = 0;
  double var;

  for (int i = ind;; i++) {
    if (RSI(i + 1) == EMPTY_VALUE)
      break;
    var = DiffRSI(i);
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

bool CSignalRSI::ExtStateRSI(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = StateRSI(pos);
    if (off > 0) {

      pos += off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = RSI(pos);
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
      m_extr_osc[i] = RSI(pos);
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

bool CSignalRSI::CompareMaps(int map, int count, bool minimax, int start) {
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

int CSignalRSI::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffRSI(idx) > 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && DiffRSI(idx + 1) < 0.0 && RSI(idx + 1) < 30.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) || IS_PATTERN_USAGE(3) || IS_PATTERN_USAGE(4) ||
        IS_PATTERN_USAGE(5)) {
      ExtStateRSI(idx);

      if (IS_PATTERN_USAGE(2) && RSI(idx) > m_extr_osc[1])
        result = m_pattern_2;

      if (IS_PATTERN_USAGE(3) && CompareMaps(1, 1))
        result = m_pattern_3;

      if (IS_PATTERN_USAGE(4) && CompareMaps(0x11, 2))
        return (m_pattern_4);

      if (IS_PATTERN_USAGE(5) && CompareMaps(0x62662, 5, true) &&
          RSI(idx) > m_extr_osc[1])
        result = m_pattern_5;
    }
  }

  return (result);
}

int CSignalRSI::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffRSI(idx) < 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && DiffRSI(idx + 1) > 0.0 && RSI(idx + 1) > 70.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) || IS_PATTERN_USAGE(3) || IS_PATTERN_USAGE(4) ||
        IS_PATTERN_USAGE(5)) {
      ExtStateRSI(idx);

      if (IS_PATTERN_USAGE(2) && RSI(idx) < m_extr_osc[1])
        result = m_pattern_2;

      if (IS_PATTERN_USAGE(3) && CompareMaps(1, 1))
        result = m_pattern_3;

      if (IS_PATTERN_USAGE(4) && CompareMaps(0x11, 2))
        return (m_pattern_4);

      if (IS_PATTERN_USAGE(5) && CompareMaps(0x62662, 5, true) &&
          RSI(idx) < m_extr_osc[1])
        result = m_pattern_5;
    }
  }

  return (result);
}

#endif
