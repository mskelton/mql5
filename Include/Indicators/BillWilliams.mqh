#ifndef BILL_WILLIAMS_H
#define BILL_WILLIAMS_H

#include "Indicator.mqh"

class CiAC : public CIndicator {
public:
  CiAC(void);
  ~CiAC(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period);
};







class CiAlligator : public CIndicator {
protected:
  int m_jaw_period;
  int m_jaw_shift;
  int m_teeth_period;
  int m_teeth_shift;
  int m_lips_period;
  int m_lips_shift;
  ENUM_MA_METHOD m_ma_method;
  int m_applied;

public:
  CiAlligator(void);
  ~CiAlligator(void);

  int JawPeriod(void) const ;
  int JawShift(void) const ;
  int TeethPeriod(void) const ;
  int TeethShift(void) const ;
  int LipsPeriod(void) const ;
  int LipsShift(void) const ;
  ENUM_MA_METHOD MaMethod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int jaw_period, const int jaw_shift, const int teeth_period,
              const int teeth_shift, const int lips_period,
              const int lips_shift, const ENUM_MA_METHOD ma_method,
              const int applied);

  double Jaw(const int index) const;
  double Teeth(const int index) const;
  double Lips(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int jaw_period, const int jaw_shift,
                  const int teeth_period, const int teeth_shift,
                  const int lips_period, const int lips_shift,
                  const ENUM_MA_METHOD ma_method, const int applied);
};









class CiAO : public CIndicator {
public:
  CiAO(void);
  ~CiAO(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double Main(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period);
};







class CiFractals : public CIndicator {
public:
  CiFractals(void);
  ~CiFractals(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double Upper(const int index) const;
  double Lower(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period);
};








class CiGator : public CIndicator {
protected:
  int m_jaw_period;
  int m_jaw_shift;
  int m_teeth_period;
  int m_teeth_shift;
  int m_lips_period;
  int m_lips_shift;
  ENUM_MA_METHOD m_ma_method;
  int m_applied;

public:
  CiGator(void);
  ~CiGator(void);

  int JawPeriod(void) const ;
  int JawShift(void) const ;
  int TeethPeriod(void) const ;
  int TeethShift(void) const ;
  int LipsPeriod(void) const ;
  int LipsShift(void) const ;
  ENUM_MA_METHOD MaMethod(void) const ;
  int Applied(void) const ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int jaw_period, const int jaw_shift, const int teeth_period,
              const int teeth_shift, const int lips_period,
              const int lips_shift, const ENUM_MA_METHOD ma_method,
              const int applied);

  double Upper(const int index) const;
  double Lower(const int index) const;

  virtual int Type(void) const ;

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int jaw_period, const int jaw_shift,
                  const int teeth_period, const int teeth_shift,
                  const int lips_period, const int lips_shift,
                  const ENUM_MA_METHOD ma_method, const int applied);
};








class CiBWMFI : public CIndicator {
protected:
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiBWMFI(void);
  ~CiBWMFI(void);

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
