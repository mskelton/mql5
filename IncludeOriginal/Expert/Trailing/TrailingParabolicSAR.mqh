#ifndef TRAILING_PARABOLIC_SAR_H
#define TRAILING_PARABOLIC_SAR_H

#include <Expert\ExpertTrailing.mqh>

class CTrailingPSAR : public CExpertTrailing {
protected:
  CiSAR m_sar;

  double m_step;
  double m_maximum;

public:
  CTrailingPSAR(void);
  ~CTrailingPSAR(void);

  void Step(double step) {
    m_step = step;
  }
  void Maximum(double maximum) {
    m_maximum = maximum;
  }

  virtual bool InitIndicators(CIndicators *indicators);

  virtual bool CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                     double &tp);
  virtual bool CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                      double &tp);
};

void CTrailingPSAR::CTrailingPSAR(void)
    : m_step(0.02), m_maximum(0.2)

{}

void CTrailingPSAR::~CTrailingPSAR(void) {}

bool CTrailingPSAR::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  if (!indicators.Add(GetPointer(m_sar))) {
    printf(__FUNCTION__ + ": error adding object");
    return (false);
  }

  if (!m_sar.Create(m_symbol.Name(), m_period, m_step, m_maximum)) {
    printf(__FUNCTION__ + ": error initializing object");
    return (false);
  }

  return (true);
}

bool CTrailingPSAR::CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                          double &tp) {

  if (position == NULL)
    return (false);

  double level =
      NormalizeDouble(m_symbol.Bid() - m_symbol.StopsLevel() * m_symbol.Point(),
                      m_symbol.Digits());
  double new_sl = NormalizeDouble(m_sar.Main(1), m_symbol.Digits());
  double pos_sl = position.StopLoss();
  double base = (pos_sl == 0.0) ? position.PriceOpen() : pos_sl;

  sl = EMPTY_VALUE;
  tp = EMPTY_VALUE;
  if (new_sl > base && new_sl < level)
    sl = new_sl;

  return (sl != EMPTY_VALUE);
}

bool CTrailingPSAR::CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                           double &tp) {

  if (position == NULL)
    return (false);

  double level =
      NormalizeDouble(m_symbol.Ask() + m_symbol.StopsLevel() * m_symbol.Point(),
                      m_symbol.Digits());
  double new_sl = NormalizeDouble(
      m_sar.Main(1) + m_symbol.Spread() * m_symbol.Point(), m_symbol.Digits());
  double pos_sl = position.StopLoss();
  double base = (pos_sl == 0.0) ? position.PriceOpen() : pos_sl;

  sl = EMPTY_VALUE;
  tp = EMPTY_VALUE;
  if (new_sl < base && new_sl > level)
    sl = new_sl;

  return (sl != EMPTY_VALUE);
}

#endif
