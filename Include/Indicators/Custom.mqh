#ifndef CUSTOM_H
#define CUSTOM_H

#include "Indicator.mqh"

class CiCustom : public CIndicator {
protected:
  int m_num_params;
  MqlParam m_params;

public:
  CiCustom(void);
  ~CiCustom(void);

  bool NumBuffers(const int buffers);
  int NumParams(void) const ;
  ENUM_DATATYPE ParamType(const int ind) const;
  long ParamLong(const int ind) const;
  double ParamDouble(const int ind) const;
  string ParamString(const int ind) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
};









#endif
