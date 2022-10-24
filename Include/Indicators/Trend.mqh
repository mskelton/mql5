#ifndef TREND_H
#define TREND_H

#include "Indicator.mqh"

class CiADX : public CIndicator {
protected:
  int m_ma_period;

public:
  CiADX(void);
  ~CiADX(void);

  int MaPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;
  double Plus(const int index) const;
  double Minus(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};









class CiADXWilder : public CIndicator {
protected:
  int m_ma_period;

public:
  CiADXWilder(void);
  ~CiADXWilder(void);

  int MaPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;
  double Plus(const int index) const;
  double Minus(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};









class CiBands : public CIndicator {
protected:
  int m_ma_period;
  int m_ma_shift;
  double m_deviation;
  int m_applied;

public:
  CiBands(void);
  ~CiBands(void);

  int MaPeriod(void) const ;
  int MaShift(void) const ;
  double Deviation(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift, const double deviation,
              const int applied);

  double Base(const int index) const;
  double Upper(const int index) const;
  double Lower(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const double deviation, const int applied);
};









class CiEnvelopes : public CIndicator {
protected:
  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  int m_applied;
  double m_deviation;

public:
  CiEnvelopes(void);
  ~CiEnvelopes(void);

  int MaPeriod(void) const ;
  int MaShift(void) const ;
  ENUM_MA_METHOD MaMethod(void) const ;
  int Applied(void) const ;
  double Deviation(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift,
              const ENUM_MA_METHOD ma_method, const int applied,
              const double deviation);

  double Upper(const int index) const;
  double Lower(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const ENUM_MA_METHOD ma_method, const int applied,
                  const double deviation);
};








class CiIchimoku : public CIndicator {
protected:
  int m_tenkan_sen;
  int m_kijun_sen;
  int m_senkou_span_b;

public:
  CiIchimoku(void);
  ~CiIchimoku(void);

  int TenkanSenPeriod(void) const ;
  int KijunSenPeriod(void) const ;
  int SenkouSpanBPeriod(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int tenkan_sen, const int kijun_sen,
              const int senkou_span_b);

  double TenkanSen(const int index) const;
  double KijunSen(const int index) const;
  double SenkouSpanA(const int index) const;
  double SenkouSpanB(const int index) const;
  double ChinkouSpan(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int tenkan_sen, const int kijun_sen,
                  const int senkou_span_b);
};











class CiMA : public CIndicator {
protected:
  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  int m_applied;

public:
  CiMA(void);
  ~CiMA(void);

  int MaPeriod(void) const ;
  int MaShift(void) const ;
  ENUM_MA_METHOD MaMethod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift,
              const ENUM_MA_METHOD ma_method, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const ENUM_MA_METHOD ma_method, const int applied);
};







class CiSAR : public CIndicator {
protected:
  double m_step;
  double m_maximum;

public:
  CiSAR(void);
  ~CiSAR(void);

  double SarStep(void) const ;
  double Maximum(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const double step, const double maximum);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const double step, const double maximum);
};







class CiStdDev : public CIndicator {
protected:
  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  int m_applied;

public:
  CiStdDev(void);
  ~CiStdDev(void);

  int MaPeriod(void) const ;
  int MaShift(void) const ;
  ENUM_MA_METHOD MaMethod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift,
              const ENUM_MA_METHOD ma_method, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const ENUM_MA_METHOD ma_method, const int applied);
};







class CiDEMA : public CIndicator {
protected:
  int m_ma_period;
  int m_ind_shift;
  int m_applied;

public:
  CiDEMA(void);
  ~CiDEMA(void);

  int MaPeriod(void) const ;
  int IndShift(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ind_shift, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ind_shift, const int applied);
};







class CiTEMA : public CIndicator {
protected:
  int m_ma_period;
  int m_ind_shift;
  int m_applied;

public:
  CiTEMA(void);
  ~CiTEMA(void);

  int MaPeriod(void) const ;
  int IndShift(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift, const int applied);
};







class CiFrAMA : public CIndicator {
protected:
  int m_ma_period;
  int m_ind_shift;
  int m_applied;

public:
  CiFrAMA(void);
  ~CiFrAMA(void);

  int MaPeriod(void) const ;
  int IndShift(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ind_shift, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ind_shift, const int applied);
};







class CiAMA : public CIndicator {
protected:
  int m_ma_period;
  int m_fast_ema_period;
  int m_slow_ema_period;
  int m_ind_shift;
  int m_applied;

public:
  CiAMA(void);
  ~CiAMA(void);

  int MaPeriod(void) const ;
  int FastEmaPeriod(void) const ;
  int SlowEmaPeriod(void) const ;
  int IndShift(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int fast_ema_period,
              const int slow_ema_period, const int ind_shift,
              const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int fast_ema_period,
                  const int slow_ema_period, const int ind_shift,
                  const int applied);
};







class CiVIDyA : public CIndicator {
protected:
  int m_cmo_period;
  int m_ema_period;
  int m_ind_shift;
  int m_applied;

public:
  CiVIDyA(void);
  ~CiVIDyA(void);

  int CmoPeriod(void) const ;
  int EmaPeriod(void) const ;
  int IndShift(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int cmo_period, const int ema_period, const int ind_shift,
              const int applied);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int cmo_period, const int ema_period,
                  const int ind_shift, const int applied);
};







#endif
