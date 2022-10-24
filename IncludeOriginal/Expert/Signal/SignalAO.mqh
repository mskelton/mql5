#ifndef SIGNAL_AO_H
#define SIGNAL_AO_H

#include <Expert\ExpertSignal.mqh>

class CSignalAO : public CExpertSignal {
protected:
  CiAO m_ao;

  int m_pattern_0;
  int m_pattern_1;
  int m_pattern_2;
  int m_pattern_3;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalAO(void);
  ~CSignalAO(void);

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

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int LongCondition(void);
  virtual int ShortCondition(void);

protected:
  bool InitAO(CIndicators *indicators);

  double AO(int ind) {
    return (m_ao.Main(ind));
  }
  double DiffAO(int ind) {
    return (AO(ind) - AO(ind + 1));
  }
  int StateAO(int ind);
  bool ExtStateAO(int ind);
};

CSignalAO::CSignalAO(void)
    : m_pattern_0(30), m_pattern_1(20), m_pattern_2(70), m_pattern_3(90) {

  m_used_series = USE_SERIES_HIGH + USE_SERIES_LOW;
}

CSignalAO::~CSignalAO(void) {
}

bool CSignalAO::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitAO(indicators))
    return (false);

  return (true);
}

bool CSignalAO::InitAO(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_ao))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_ao.Create(m_symbol.Name(), m_period)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalAO::StateAO(int ind) {
  int res = 0;
  double var;

  for (int i = ind;; i++) {
    if (AO(i + 1) == EMPTY_VALUE)
      break;
    var = DiffAO(i);
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

bool CSignalAO::ExtStateAO(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = StateAO(pos);
    if (off > 0) {

      pos += off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = AO(pos);
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
      m_extr_osc[i] = AO(pos);
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

int CSignalAO::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffAO(idx) < 0.0)
    return (result);

  if (IS_PATTERN_USAGE(0))
    result = m_pattern_0;
  if (AO(idx++) > 0.0) {

    if (IS_PATTERN_USAGE(1) && DiffAO(idx) < 0.0) {

      return (m_pattern_1);
    }
    if (IS_PATTERN_USAGE(2) && AO(idx) < 0.0) {

      return (m_pattern_2);
    }
  } else {

    if (IS_PATTERN_USAGE(3) && DiffAO(idx) < 0.0) {
      idx = StartIndex();

      ExtStateAO(idx);
      if ((m_extr_map & 0xF) == 1) {
        if (m_extr_osc[0] < 0.0 && m_extr_osc[1] < 0.0 && m_extr_osc[2] < 0.0) {

          return (m_pattern_3);
        }
      }
    }
  }

  return (result);
}

int CSignalAO::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (DiffAO(idx) > 0.0)
    return (result);

  if (IS_PATTERN_USAGE(0))
    result = m_pattern_0;
  if (AO(idx++) < 0.0) {

    if (IS_PATTERN_USAGE(1) && DiffAO(idx) > 0.0) {

      return (m_pattern_1);
    }
    if (IS_PATTERN_USAGE(2) && AO(idx) > 0.0) {

      return (m_pattern_2);
    }
  } else {

    if (IS_PATTERN_USAGE(3) && DiffAO(idx) > 0.0) {
      idx = StartIndex();

      ExtStateAO(idx);
      if ((m_extr_map & 0xF) == 1) {
        if (m_extr_osc[0] > 0.0 && m_extr_osc[1] > 0.0 && m_extr_osc[2] > 0.0) {

          return (m_pattern_3);
        }
      }
    }
  }

  return (result);
}

#endif
