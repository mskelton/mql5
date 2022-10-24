#ifndef OSCILATORS_H
#define OSCILATORS_H

#include "Indicator.mqh"

class CiATR : public CIndicator {
protected:
  int m_ma_period;

public:
  CiATR(void);
  ~CiATR(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_ATR);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};

CiATR::CiATR(void) : m_ma_period(-1) {
}

CiATR::~CiATR(void) {
}

bool CiATR::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const int ma_period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iATR(symbol, period, ma_period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiATR::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value));
}

bool CiATR::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int ma_period) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "ATR";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiATR::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiBearsPower : public CIndicator {
protected:
  int m_ma_period;

public:
  CiBearsPower(void);
  ~CiBearsPower(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_BEARS);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};

CiBearsPower::CiBearsPower(void) : m_ma_period(-1) {
}

CiBearsPower::~CiBearsPower(void) {
}

bool CiBearsPower::Create(const string symbol, const ENUM_TIMEFRAMES period,
                          const int ma_period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iBearsPower(symbol, period, ma_period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiBearsPower::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                              const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value));
}

bool CiBearsPower::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                              const int ma_period) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "BearsPower";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiBearsPower::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiBullsPower : public CIndicator {
protected:
  int m_ma_period;

public:
  CiBullsPower(void);
  ~CiBullsPower(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_BULLS);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};

CiBullsPower::CiBullsPower(void) : m_ma_period(-1) {
}

CiBullsPower::~CiBullsPower(void) {
}

bool CiBullsPower::Create(const string symbol, const ENUM_TIMEFRAMES period,
                          const int ma_period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iBullsPower(symbol, period, ma_period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiBullsPower::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                              const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value));
}

bool CiBullsPower::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                              const int ma_period) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "BullsPower";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiBullsPower::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiCCI : public CIndicator {
protected:
  int m_ma_period;
  int m_applied;

public:
  CiCCI(void);
  ~CiCCI(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_CCI);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int applied);
};

CiCCI::CiCCI(void) : m_ma_period(-1), m_applied(-1) {
}

CiCCI::~CiCCI(void) {
}

bool CiCCI::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const int ma_period, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iCCI(symbol, period, ma_period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiCCI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value));
}

bool CiCCI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int ma_period, const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "CCI";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + PriceDescription(applied) +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiCCI::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiChaikin : public CIndicator {
protected:
  int m_fast_ma_period;
  int m_slow_ma_period;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiChaikin(void);
  ~CiChaikin(void);

  int FastMaPeriod(void) const {
    return (m_fast_ma_period);
  }
  int SlowMaPeriod(void) const {
    return (m_slow_ma_period);
  }
  ENUM_MA_METHOD MaMethod(void) const {
    return (m_ma_method);
  }
  ENUM_APPLIED_VOLUME Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int fast_ma_period, const int slow_ma_period,
              const ENUM_MA_METHOD ma_method,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_CHAIKIN);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int fast_ma_period, const int slow_ma_period,
                  const ENUM_MA_METHOD ma_method,
                  const ENUM_APPLIED_VOLUME applied);
};

CiChaikin::CiChaikin(void)
    : m_fast_ma_period(-1), m_slow_ma_period(-1), m_ma_method(WRONG_VALUE),
      m_applied(WRONG_VALUE) {
}

CiChaikin::~CiChaikin(void) {
}

bool CiChaikin::Create(const string symbol, const ENUM_TIMEFRAMES period,
                       const int fast_ma_period, const int slow_ma_period,
                       const ENUM_MA_METHOD ma_method,
                       const ENUM_APPLIED_VOLUME applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iChaikin(symbol, period, fast_ma_period, slow_ma_period, ma_method,
                      applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, fast_ma_period, slow_ma_period, ma_method,
                  applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiChaikin::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                           const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value,
                     (ENUM_MA_METHOD)params[2].integer_value,
                     (ENUM_APPLIED_VOLUME)params[3].integer_value));
}

bool CiChaikin::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                           const int fast_ma_period, const int slow_ma_period,
                           const ENUM_MA_METHOD ma_method,
                           const ENUM_APPLIED_VOLUME applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "Chaikin";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(fast_ma_period) + "," +
               IntegerToString(slow_ma_period) + "," +
               MethodDescription(ma_method) + "," + PriceDescription(applied) +
               ") H=" + IntegerToString(m_handle);

    m_fast_ma_period = fast_ma_period;
    m_slow_ma_period = slow_ma_period;
    m_ma_method = ma_method;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiChaikin::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiDeMarker : public CIndicator {
protected:
  int m_ma_period;

public:
  CiDeMarker(void);
  ~CiDeMarker(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_DEMARKER);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};

CiDeMarker::CiDeMarker(void) : m_ma_period(-1) {
}

CiDeMarker::~CiDeMarker(void) {
}

bool CiDeMarker::Create(const string symbol, const ENUM_TIMEFRAMES period,
                        const int ma_period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iDeMarker(symbol, period, ma_period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiDeMarker::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                            const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value));
}

bool CiDeMarker::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                            const int ma_period) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "DeMarker";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiDeMarker::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiForce : public CIndicator {
protected:
  int m_ma_period;
  ENUM_MA_METHOD m_ma_method;
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiForce(void);
  ~CiForce(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  ENUM_MA_METHOD MaMethod(void) const {
    return (m_ma_method);
  }
  ENUM_APPLIED_VOLUME Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const ENUM_MA_METHOD ma_method,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_FORCE);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const ENUM_MA_METHOD ma_method,
                  const ENUM_APPLIED_VOLUME applied);
};

CiForce::CiForce(void)
    : m_ma_period(-1), m_ma_method(WRONG_VALUE), m_applied(WRONG_VALUE) {
}

CiForce::~CiForce(void) {
}

bool CiForce::Create(const string symbol, const ENUM_TIMEFRAMES period,
                     const int ma_period, const ENUM_MA_METHOD ma_method,
                     const ENUM_APPLIED_VOLUME applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iForce(symbol, period, ma_period, ma_method, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, ma_method, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiForce::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (ENUM_MA_METHOD)params[1].integer_value,
                     (ENUM_APPLIED_VOLUME)params[2].integer_value));
}

bool CiForce::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int ma_period, const ENUM_MA_METHOD ma_method,
                         const ENUM_APPLIED_VOLUME applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "Force";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + MethodDescription(ma_method) +
               "," + VolumeDescription(applied) + "," +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_ma_method = ma_method;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiForce::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiMACD : public CIndicator {
protected:
  int m_fast_ema_period;
  int m_slow_ema_period;
  int m_signal_period;
  int m_applied;

public:
  CiMACD(void);
  ~CiMACD(void);

  int FastEmaPeriod(void) const {
    return (m_fast_ema_period);
  }
  int SlowEmaPeriod(void) const {
    return (m_slow_ema_period);
  }
  int SignalPeriod(void) const {
    return (m_signal_period);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int fast_ema_period, const int slow_ema_period,
              const int signal_period, const int applied);

  double Main(const int index) const;
  double Signal(const int index) const;

  virtual int Type(void) const {
    return (IND_MACD);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int fast_ema_period, const int slow_ema_period,
                  const int signal_period, const int applied);
};

CiMACD::CiMACD(void)
    : m_fast_ema_period(-1), m_slow_ema_period(-1), m_signal_period(-1),
      m_applied(-1) {
}

CiMACD::~CiMACD(void) {
}

bool CiMACD::Create(const string symbol, const ENUM_TIMEFRAMES period,
                    const int fast_ema_period, const int slow_ema_period,
                    const int signal_period, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iMACD(symbol, period, fast_ema_period, slow_ema_period,
                   signal_period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, fast_ema_period, slow_ema_period,
                  signal_period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiMACD::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value, (int)params[2].integer_value,
                     (int)params[3].integer_value));
}

bool CiMACD::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int fast_ema_period, const int slow_ema_period,
                        const int signal_period, const int applied) {
  if (CreateBuffers(symbol, period, 2)) {

    m_name = "MACD";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(fast_ema_period) + "," +
               IntegerToString(slow_ema_period) + "," +
               IntegerToString(signal_period) + "," +
               PriceDescription(applied) + "," +
               ") H=" + IntegerToString(m_handle);

    m_fast_ema_period = fast_ema_period;
    m_slow_ema_period = slow_ema_period;
    m_signal_period = signal_period;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(1)).Name("SIGNAL_LINE");

    return (true);
  }

  return (false);
}

double CiMACD::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiMACD::Signal(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiMomentum : public CIndicator {
protected:
  int m_ma_period;
  int m_applied;

public:
  CiMomentum(void);
  ~CiMomentum(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_MOMENTUM);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int applied);
};

CiMomentum::CiMomentum(void) : m_ma_period(-1), m_applied(-1) {
}

CiMomentum::~CiMomentum(void) {
}

bool CiMomentum::Create(const string symbol, const ENUM_TIMEFRAMES period,
                        const int ma_period, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iMomentum(symbol, period, ma_period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiMomentum::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                            const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value));
}

bool CiMomentum::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                            const int ma_period, const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "Momentum";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + PriceDescription(applied) +
               "," + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiMomentum::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiOsMA : public CIndicator {
protected:
  int m_fast_ema_period;
  int m_slow_ema_period;
  int m_signal_period;
  int m_applied;

public:
  CiOsMA(void);
  ~CiOsMA(void);

  int FastEmaPeriod(void) const {
    return (m_fast_ema_period);
  }
  int SlowEmaPeriod(void) const {
    return (m_slow_ema_period);
  }
  int SignalPeriod(void) const {
    return (m_signal_period);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int fast_ema_period, const int slow_ema_period,
              const int signal_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_OSMA);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int fast_ema_period, const int slow_ema_period,
                  const int signal_period, const int applied);
};

CiOsMA::CiOsMA(void)
    : m_fast_ema_period(-1), m_slow_ema_period(-1), m_signal_period(-1),
      m_applied(-1) {
}

CiOsMA::~CiOsMA(void) {
}

bool CiOsMA::Create(const string symbol, const ENUM_TIMEFRAMES period,
                    const int fast_ema_period, const int slow_ema_period,
                    const int signal_period, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iOsMA(symbol, period, fast_ema_period, slow_ema_period,
                   signal_period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, fast_ema_period, slow_ema_period,
                  signal_period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiOsMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value, (int)params[2].integer_value,
                     (int)params[3].integer_value));
}

bool CiOsMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int fast_ema_period, const int slow_ema_period,
                        const int signal_period, const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "OsMA";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(fast_ema_period) + "," +
               IntegerToString(slow_ema_period) + "," +
               IntegerToString(signal_period) + "," +
               PriceDescription(applied) + "," +
               ") H=" + IntegerToString(m_handle);

    m_fast_ema_period = fast_ema_period;
    m_slow_ema_period = slow_ema_period;
    m_signal_period = signal_period;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiOsMA::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiRSI : public CIndicator {
protected:
  int m_ma_period;
  int m_applied;

public:
  CiRSI(void);
  ~CiRSI(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_RSI);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int applied);
};

CiRSI::CiRSI(void) : m_ma_period(-1), m_applied(-1) {
}

CiRSI::~CiRSI(void) {
}

bool CiRSI::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const int ma_period, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iRSI(symbol, period, ma_period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiRSI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value));
}

bool CiRSI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int ma_period, const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "RSI";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + PriceDescription(applied) +
               "," + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiRSI::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiRVI : public CIndicator {
protected:
  int m_ma_period;

public:
  CiRVI(void);
  ~CiRVI(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;
  double Signal(const int index) const;

  virtual int Type(void) const {
    return (IND_RVI);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};

CiRVI::CiRVI(void) : m_ma_period(-1) {
}

CiRVI::~CiRVI(void) {
}

bool CiRVI::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const int ma_period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iRVI(symbol, period, ma_period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiRVI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value));
}

bool CiRVI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int ma_period) {
  if (CreateBuffers(symbol, period, 2)) {

    m_name = "RVI";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(1)).Name("SIGNAL_LINE");

    return (true);
  }

  return (false);
}

double CiRVI::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiRVI::Signal(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

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

  int Kperiod(void) const {
    return (m_Kperiod);
  }
  int Dperiod(void) const {
    return (m_Dperiod);
  }
  int Slowing(void) const {
    return (m_slowing);
  }
  ENUM_MA_METHOD MaMethod(void) const {
    return (m_ma_method);
  }
  ENUM_STO_PRICE PriceField(void) const {
    return (m_price_field);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int Kperiod, const int Dperiod, const int slowing,
              const ENUM_MA_METHOD ma_method, const ENUM_STO_PRICE price_field);

  double Main(const int index) const;
  double Signal(const int index) const;

  virtual int Type(void) const {
    return (IND_STOCHASTIC);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int Kperiod, const int Dperiod, const int slowing,
                  const ENUM_MA_METHOD ma_method,
                  const ENUM_STO_PRICE price_field);
};

CiStochastic::CiStochastic(void)
    : m_Kperiod(-1), m_Dperiod(-1), m_slowing(-1), m_ma_method(WRONG_VALUE),
      m_price_field(WRONG_VALUE) {
}

CiStochastic::~CiStochastic(void) {
}

bool CiStochastic::Create(const string symbol, const ENUM_TIMEFRAMES period,
                          const int Kperiod, const int Dperiod,
                          const int slowing, const ENUM_MA_METHOD ma_method,
                          const ENUM_STO_PRICE price_field) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iStochastic(symbol, period, Kperiod, Dperiod, slowing, ma_method,
                         price_field);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, Kperiod, Dperiod, slowing, ma_method,
                  price_field)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiStochastic::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                              const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value, (int)params[2].integer_value,
                     (ENUM_MA_METHOD)params[3].integer_value,
                     (ENUM_STO_PRICE)params[4].integer_value));
}

bool CiStochastic::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                              const int Kperiod, const int Dperiod,
                              const int slowing, const ENUM_MA_METHOD ma_method,
                              const ENUM_STO_PRICE price_field) {
  if (CreateBuffers(symbol, period, 2)) {

    m_name = "Stochastic";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(Kperiod) + "," + IntegerToString(Dperiod) + "," +
               IntegerToString(slowing) + "," + MethodDescription(ma_method) +
               "," + IntegerToString(price_field) +
               ") H=" + IntegerToString(m_handle);

    m_Kperiod = Kperiod;
    m_Dperiod = Dperiod;
    m_slowing = slowing;
    m_ma_method = ma_method;
    m_price_field = price_field;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(1)).Name("SIGNAL_LINE");

    return (true);
  }

  return (false);
}

double CiStochastic::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiStochastic::Signal(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiWPR : public CIndicator {
protected:
  int m_calc_period;

public:
  CiWPR(void);
  ~CiWPR(void);

  int CalcPeriod(void) const {
    return (m_calc_period);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int calc_period);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_WPR);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int calc_period);
};

CiWPR::CiWPR(void) : m_calc_period(-1) {
}

CiWPR::~CiWPR(void) {
}

bool CiWPR::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const int calc_period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iWPR(symbol, period, calc_period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, calc_period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiWPR::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value));
}

bool CiWPR::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int calc_period) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "WPR";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(calc_period) +
               ") H=" + IntegerToString(m_handle);

    m_calc_period = calc_period;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiWPR::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiTriX : public CIndicator {
protected:
  int m_ma_period;
  int m_applied;

public:
  CiTriX(void);
  ~CiTriX(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_TRIX);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int applied);
};

CiTriX::CiTriX(void) : m_ma_period(-1), m_applied(-1) {
}

CiTriX::~CiTriX(void) {
}

bool CiTriX::Create(const string symbol, const ENUM_TIMEFRAMES period,
                    const int ma_period, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iTriX(symbol, period, ma_period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiTriX::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value));
}

bool CiTriX::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int ma_period, const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "TriX";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + PriceDescription(applied) +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiTriX::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

#endif
