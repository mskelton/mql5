#ifndef SIGNAL_BEARS_POWER_H
#define SIGNAL_BEARS_POWER_H

#include <Expert\ExpertSignal.mqh>

class CSignalBearsPower : public CExpertSignal {
protected:
  CiBearsPower m_bears;

  int m_period_bears;

  int m_pattern_0;
  int m_pattern_1;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalBearsPower(void);
  ~CSignalBearsPower(void);

  void PeriodBears(int value) {
    m_period_bears = value;
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

protected:
  bool InitBears(CIndicators *indicators);

  double Bears(int ind) {
    return (m_bears.Main(ind));
  }
  double DiffBears(int ind) {
    return (Bears(ind) - Bears(ind + 1));
  }
  int StateBears(int ind);
  bool ExtStateBears(int ind);
};

CSignalBearsPower::CSignalBearsPower(void)
    : m_period_bears(13), m_pattern_0(20), m_pattern_1(80) {

  m_used_series = USE_SERIES_HIGH + USE_SERIES_LOW;
}

CSignalBearsPower::~CSignalBearsPower(void) {
}

bool CSignalBearsPower::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_period_bears <= 0) {
    printf(__FUNCTION__ + ": period Bears must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalBearsPower::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitBears(indicators))
    return (false);

  return (true);
}

bool CSignalBearsPower::InitBears(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_bears))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_bears.Create(m_symbol.Name(), m_period, m_period_bears)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalBearsPower::StateBears(int ind) {
  int res = 0;
  double var;

  for (int i = ind;; i++) {
    if (Bears(i + 1) == EMPTY_VALUE)
      break;
    var = DiffBears(i);
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

bool CSignalBearsPower::ExtStateBears(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = StateBears(pos);
    if (off > 0) {

      pos += off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = Bears(pos);
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
      m_extr_osc[i] = Bears(pos);
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

int CSignalBearsPower::LongCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (Bears(idx) > 0.0)
    return (result);

  if (StateBears(idx) > 0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1)) {
      ExtStateBears(idx);
      if ((m_extr_map & 0xF) == 1) {
        if (m_extr_osc[0] < 0.0 && m_extr_osc[2] < 0.0) {

          result = m_pattern_1;
        }
      }
    }
  }

  return (result);
}

#endif
