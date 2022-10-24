#ifndef SIGNAL_WPR_H
#define SIGNAL_WPR_H

#include <Expert\ExpertSignal.mqh>

class CSignalWPR : public CExpertSignal {
protected:
  CiWPR m_wpr;

  int m_period_wpr;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalWPR(void);
  ~CSignalWPR(void);

  void PeriodWPR(int value) {
    m_period_wpr = value;
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

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitWPR(CIndicators *indicators);

  double WPR(int ind) {
    return (m_wpr.Main(ind));
  }
  double Diff(int ind) {
    return (WPR(ind) - WPR(ind + 1));
  }
  int State(int ind);
  bool ExtState(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

CSignalWPR::CSignalWPR(void)
    : m_period_wpr(14), m_pattern_0(80), m_pattern_1(70), m_pattern_2(90) {

  m_used_series = USE_SERIES_HIGH + USE_SERIES_LOW;
}

CSignalWPR::~CSignalWPR(void) {}

bool CSignalWPR::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_period_wpr <= 0) {
    printf(__FUNCTION__ +
           ": period of the WPR oscillator must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalWPR::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitWPR(indicators))
    return (false);

  return (true);
}

bool CSignalWPR::InitWPR(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_wpr))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_wpr.Create(m_symbol.Name(), m_period, m_period_wpr)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalWPR::State(int ind) {
  int res = 0;
  double var;

  for (int i = ind;; i++) {
    if (WPR(i + 1) == EMPTY_VALUE)
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

bool CSignalWPR::ExtState(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = State(pos);
    if (off > 0) {

      pos += off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = WPR(pos);
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
      m_extr_osc[i] = WPR(pos);
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

bool CSignalWPR::CompareMaps(int map, int count, bool minimax, int start) {
  int step = (minimax) ? 4 : 8;
  int total = step * (start + count);

  if (total > 32)
    return (false);

  uint inp_map, check_map;
  int i, j;

  for (i = step * start, j = 0; i < total; i += step, j += 4) {

    inp_map = (map >> i) & 3;

    if (inp_map < 2) {

      check_map = (m_extr_map >> j) & 3;
      if (inp_map != check_map)
        return (false);
    }

    inp_map = (map >> (i + 2)) & 3;

    if (inp_map >= 2)
      continue;

    check_map = (m_extr_map >> (j + 2)) & 3;
    if (inp_map != check_map)
      return (false);
  }

  return (true);
}

int CSignalWPR::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (Diff(idx) > 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && Diff(idx + 1) < 0.0 && WPR(idx + 1) > -80.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2)) {

      ExtState(idx);

      if (CompareMaps(1, 1))
        result = m_pattern_2;
    }
  }

  return (result);
}

int CSignalWPR::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (Diff(idx) < 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && Diff(idx + 1) > 0.0 && WPR(idx + 1) < -20.0)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2)) {

      ExtState(idx);

      if (CompareMaps(1, 1))
        result = m_pattern_2;
    }
  }

  return (result);
}

#endif
