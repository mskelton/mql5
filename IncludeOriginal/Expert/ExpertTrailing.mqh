#ifndef EXPERT_TRAILING_H
#define EXPERT_TRAILING_H

#include "ExpertBase.mqh"

class CExpertTrailing : public CExpertBase {
public:
  CExpertTrailing(void);
  ~CExpertTrailing(void);

  virtual bool CheckTrailingStopLong(CPositionInfo *position, double &sl,
                                     double &tp) {
    return (false);
  }
  virtual bool CheckTrailingStopShort(CPositionInfo *position, double &sl,
                                      double &tp) {
    return (false);
  }
};

CExpertTrailing::CExpertTrailing(void) {
}

CExpertTrailing::~CExpertTrailing(void) {
}

#endif
