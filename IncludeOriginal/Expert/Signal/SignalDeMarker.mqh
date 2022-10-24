#ifndef SIGNAL_DE_MARKER_H
#define SIGNAL_DE_MARKER_H

#include <Expert\ExpertSignal.mqh>

class CSignalDeM : public CExpertSignal {
protected:
  CiDeMarker m_dem;

  int m_periodDeM;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalDeM(void);
  ~CSignalDeM(void);

  void PeriodDeM(int value) {
    m_periodDeM = value;
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

  double DeM(int ind) {
    return (m_dem.Main(ind));
  }
  double DiffDeM(int ind) {
    return (DeM(ind) - DeM(ind + 1));
  }
  int StateDeM(int ind);
  bool ExtStateDeM(int ind);
  bool CompareMaps(int map, int count, bool minimax = false, int start = 0);
};

CSignalDeM::CSignalDeM(void)
    : m_periodDeM(14), m_pattern_0(90), m_pattern_1(60), m_pattern_2(100),
      m_pattern_3(80) {

  m_used_series = USE_SERIES_HIGH + USE_SERIES_LOW;
}

CSignalDeM::~CSignalDeM(void) {
}

bool CSignalDeM::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_periodDeM <= 0) {
    printf(__FUNCTION__ +
           ": period of the DeMarker oscillator must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalDeM::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitStoch(indicators))
    return (false);

  return (true);
}

bool CSignalDeM::InitStoch(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_dem))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_dem.Create(m_symbol.Name(), m_period, m_periodDeM)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalDeM::StateDeM(int ind) {
  int res = 0;
  double var;

  for (int i = ind;; i++) {
    if (DeM(i + 1) == EMPTY_VALUE)
      break;
    var = DiffDeM(i);
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

bool CSignalDeM::ExtStateDeM(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = StateDeM(pos);
    if (off > 0) {

      pos += off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = DeM(pos);
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
      m_extr_osc[i] = DeM(pos);
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

bool CSignalDeM::CompareMaps(int map, int count, bool minimax, int start) {
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

int CSignalDeM::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffDeM(idx) > 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && DiffDeM(idx + 1) < 0.0 && DeM(idx + 1) < 0.3)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) || IS_PATTERN_USAGE(3)) {
      ExtStateDeM(idx);

      if (IS_PATTERN_USAGE(2) && CompareMaps(1, 1))
        result = m_pattern_2;

      if (IS_PATTERN_USAGE(3) && CompareMaps(0x11, 2))
        return (m_pattern_3);
    }
  }

  return (result);
}

int CSignalDeM::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffDeM(idx) < 0.0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1) && DiffDeM(idx + 1) > 0.0 && DeM(idx + 1) > 0.7)
      result = m_pattern_1;

    if (IS_PATTERN_USAGE(2) || IS_PATTERN_USAGE(3)) {
      ExtStateDeM(idx);

      if (IS_PATTERN_USAGE(2) && CompareMaps(1, 1))
        result = m_pattern_2;

      if (IS_PATTERN_USAGE(3) && CompareMaps(0x11, 2))
        return (m_pattern_3);
    }
  }

  return (result);
}

#endif
