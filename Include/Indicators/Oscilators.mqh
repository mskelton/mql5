#ifndef OSCILATORS_H
#define OSCILATORS_H

#include "Indicator.mqh"

class CiATR : public CIndicator {
protected:
  int m_ma_period;

public:
  CiATR(void);
  ~CiATR(void);

  int MaPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};







class CiBearsPower : public CIndicator {
protected:
  int m_ma_period;

public:
  CiBearsPower(void);
  ~CiBearsPower(void);

  int MaPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};







class CiBullsPower : public CIndicator {
protected:
  int m_ma_period;

public:
  CiBullsPower(void);
  ~CiBullsPower(void);

  int MaPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};







class CiCCI : public CIndicator {
protected:
  int m_ma_period;
  int m_applied;

public:
  CiCCI(void);
  ~CiCCI(void);

  int MaPeriod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int applied);
};







class CiChaikin : public CIndicator {
protected:
  int m_fast_ma_period;
  int m_slow_ma_period;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiChaikin(void);
  ~CiChaikin(void);

  int FastMaPeriod(void) const ;
  int SlowMaPeriod(void) const ;
  ENUM_MA_METHOD MaMethod(void) const ;
  ENUM_APPLIED_VOLUME Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int fast_ma_period, const int slow_ma_period,
              const ENUM_MA_METHOD ma_method,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int fast_ma_period, const int slow_ma_period,
                  const ENUM_MA_METHOD ma_method,
                  const ENUM_APPLIED_VOLUME applied);
};







class CiDeMarker : public CIndicator {
protected:
  int m_ma_period;

public:
  CiDeMarker(void);
  ~CiDeMarker(void);

  int MaPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};







class CiForce : public CIndicator {
protected:
  int m_ma_period;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiForce(void);
  ~CiForce(void);

  int MaPeriod(void) const ;
  ENUM_MA_METHOD MaMethod(void) const ;
  ENUM_APPLIED_VOLUME Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const ENUM_MA_METHOD ma_method,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const ENUM_MA_METHOD ma_method,
                  const ENUM_APPLIED_VOLUME applied);
};







class CiMACD : public CIndicator {
protected:
  int m_fast_ema_period;
  int m_slow_ema_period;
  int m_signal_period;
  int m_applied;

public:
  CiMACD(void);
  ~CiMACD(void);

  int FastEmaPeriod(void) const ;
  int SlowEmaPeriod(void) const ;
  int SignalPeriod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int fast_ema_period, const int slow_ema_period,
              const int signal_period, const int applied);

  double Main(const int index) const;
  double Signal(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int fast_ema_period, const int slow_ema_period,
                  const int signal_period, const int applied);
};








class CiMomentum : public CIndicator {
protected:
  int m_ma_period;
  int m_applied;

public:
  CiMomentum(void);
  ~CiMomentum(void);

  int MaPeriod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int applied);
};







class CiOsMA : public CIndicator {
protected:
  int m_fast_ema_period;
  int m_slow_ema_period;
  int m_signal_period;
  int m_applied;

public:
  CiOsMA(void);
  ~CiOsMA(void);

  int FastEmaPeriod(void) const ;
  int SlowEmaPeriod(void) const ;
  int SignalPeriod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int fast_ema_period, const int slow_ema_period,
              const int signal_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int fast_ema_period, const int slow_ema_period,
                  const int signal_period, const int applied);
};







class CiRSI : public CIndicator {
protected:
  int m_ma_period;
  int m_applied;

public:
  CiRSI(void);
  ~CiRSI(void);

  int MaPeriod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int applied);
};







class CiRVI : public CIndicator {
protected:
  int m_ma_period;

public:
  CiRVI(void);
  ~CiRVI(void);

  int MaPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;
  double Signal(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};








class CiStochastic : public CIndicator {
protected:
  int m_Kperiod;
  int m_Dperiod;
  int m_slowing;
  ENUM_MA_METHOD m_ma_method;
  ENUM_STO_PRICE m_price_field;

public:
  CiStochastic(void);
  ~CiStochastic(void);

  int Kperiod(void) const ;
  int Dperiod(void) const ;
  int Slowing(void) const ;
  ENUM_MA_METHOD MaMethod(void) const ;
  ENUM_STO_PRICE PriceField(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int Kperiod, const int Dperiod, const int slowing,
              const ENUM_MA_METHOD ma_method, const ENUM_STO_PRICE price_field);

  double Main(const int index) const;
  double Signal(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int Kperiod, const int Dperiod, const int slowing,
                  const ENUM_MA_METHOD ma_method,
                  const ENUM_STO_PRICE price_field);
};








class CiWPR : public CIndicator {
protected:
  int m_calc_period;

public:
  CiWPR(void);
  ~CiWPR(void);

  int CalcPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int calc_period);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int calc_period);
};







class CiTriX : public CIndicator {
protected:
  int m_ma_period;
  int m_applied;

public:
  CiTriX(void);
  ~CiTriX(void);

  int MaPeriod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int applied);
};







#endif
