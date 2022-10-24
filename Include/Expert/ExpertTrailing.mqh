#ifndef EXPERT_TRAILING_H
#define EXPERT_TRAILING_H

#include "ExpertBase.mqh"

class CExpertTrailing : public CExpertBase {
public:
  CExpertTrailing(void);
  ~CExpertTrailing(void);

  virtual bool CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                     double &tp) ;
  virtual bool CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                      double &tp) ;
};



#endif
