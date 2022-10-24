#ifndef TRAILING_FIXED_PIPS_H
#define TRAILING_FIXED_PIPS_H

#include <Expert/ExpertTrailing.mqh>

class CTrailingFixedPips : public CExpertTrailing {
protected:
  int m_stop_level;
  int m_profit_level;

public:
  CTrailingFixedPips(void);
  ~CTrailingFixedPips(void);

  void StopLevel(int stop_level) ;
  void ProfitLevel(int profit_level) ;
  virtual bool ValidationSettings(void);

  virtual bool CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                     double &tp);
  virtual bool CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                      double &tp);
};






#endif
