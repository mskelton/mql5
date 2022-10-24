#ifndef VOLUMES_H
#define VOLUMES_H

#include "Indicator.mqh"

class CiAD : public CIndicator {
protected:
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiAD(void);
  ~CiAD(void);

  ENUM_APPLIED_VOLUME Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const ENUM_APPLIED_VOLUME applied);
};







class CiMFI : public CIndicator {
protected:
  int m_ma_period;
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiMFI(void);
  ~CiMFI(void);

  int MaPeriod(void) const ;
  ENUM_APPLIED_VOLUME Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const ENUM_APPLIED_VOLUME applied);
};







class CiOBV : public CIndicator {
protected:
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiOBV(void);
  ~CiOBV(void);

  ENUM_APPLIED_VOLUME Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const ENUM_APPLIED_VOLUME applied);
};







class CiVolumes : public CIndicator {
protected:
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiVolumes(void);
  ~CiVolumes(void);

  ENUM_APPLIED_VOLUME Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const ENUM_APPLIED_VOLUME applied);
};







#endif
