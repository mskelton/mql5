#ifndef SIGNAL_BULLS_POWER_H
#define SIGNAL_BULLS_POWER_H

#include <Expert\ExpertSignal.mqh>

class CSignalBullsPower : public CExpertSignal {
protected:
  CiBullsPower m_bulls;

  int m_period_bulls;

  int m_pattern_0;
  int m_pattern_1;

  double m_extr_osc[10];
  double m_extr_pr[10];
  int m_extr_pos[10];
  uint m_extr_map;

public:
  CSignalBullsPower(void);
  ~CSignalBullsPower(void);

  void PeriodBulls(int value) {
    m_period_bulls = value;
  }

  void Pattern_0(int value) {
    m_pattern_0 = value;
  }
  void Pattern_1(int value) {
    m_pattern_1 = value;
  }

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual int ShortCondition(void);

protected:
  bool InitBears(CIndicators *indicators);

  double Bulls(int ind) {
    return (m_bulls.Main(ind));
  }
  double DiffBulls(int ind) {
    return (Bulls(ind) - Bulls(ind + 1));
  }
  int StateBulls(int ind);
  bool ExtStateBulls(int ind);
};

CSignalBullsPower::CSignalBullsPower(void)
    : m_period_bulls(13), m_pattern_0(20), m_pattern_1(80) {

  m_used_series = USE_SERIES_HIGH + USE_SERIES_LOW;
}

CSignalBullsPower::~CSignalBullsPower(void) {}

bool CSignalBullsPower::ValidationSettings(void) {

  if (!CExpertSignal::ValidationSettings())
    return (false);

  if (m_period_bulls <= 0) {
    printf(__FUNCTION__ + ": period Bulls must be greater than 0");
    return (false);
  }

  return (true);
}

bool CSignalBullsPower::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!CExpertSignal::InitIndicators(indicators))
    return (false);

  if (!InitBears(indicators))
    return (false);

  return (true);
}

bool CSignalBullsPower::InitBears(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_bulls))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_bulls.Create(m_symbol.Name(), m_period, m_period_bulls)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

int CSignalBullsPower::StateBulls(int ind) {
  int res = 0;
  double var;

  for (int i = ind;; i++) {
    if (Bulls(i + 1) == EMPTY_VALUE)
      break;
    var = DiffBulls(i);
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

bool CSignalBullsPower::ExtStateBulls(int ind) {

  int pos = ind, off, index;
  uint map;

  m_extr_map = 0;
  for (int i = 0; i < 10; i++) {
    off = StateBulls(pos);
    if (off > 0) {

      pos += off;
      m_extr_pos[i] = pos;
      m_extr_osc[i] = Bulls(pos);
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
      m_extr_osc[i] = Bulls(pos);
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

int CSignalBullsPower::ShortCondition(void) {
  int result = 0;
  int idx = StartIndex();

  if (Bulls(idx) < 0.0)
    return (result);

  if (StateBulls(idx) < 0) {

    if (IS_PATTERN_USAGE(0))
      result = m_pattern_0;

    if (IS_PATTERN_USAGE(1)) {
      ExtStateBulls(idx);
      if ((m_extr_map & 0xF) == 1) {
        if (m_extr_osc[0] > 0.0 && m_extr_osc[2] > 0.0) {

          result = m_pattern_1;
        }
      }
    }
  }

  return (result);
}

#endif
