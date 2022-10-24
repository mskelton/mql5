#ifndef TRAILING_PARABOLIC_SAR_H
#define TRAILING_PARABOLIC_SAR_H

#include <Expert/ExpertTrailing.mqh>

class CTrailingPSAR : public CExpertTrailing {
protected:
  CiSAR m_sar;

  double m_step;
  double m_maximum;

public:
  CTrailingPSAR(void);
  ~CTrailingPSAR(void);

  void Step(double step);
  void Maximum(double maximum);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual bool CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                     double &tp);
  virtual bool CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                      double &tp);
};

#endif
