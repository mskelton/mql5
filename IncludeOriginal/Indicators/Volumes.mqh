#ifndef VOLUMES_H
#define VOLUMES_H

#include "Indicator.mqh"

class CiAD : public CIndicator {
protected:
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiAD(void);
  ~CiAD(void);

  ENUM_APPLIED_VOLUME Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_AD);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const ENUM_APPLIED_VOLUME applied);
};

CiAD::CiAD(void) : m_applied(WRONG_VALUE) {
}

CiAD::~CiAD(void) {
}

bool CiAD::Create(const string symbol, const ENUM_TIMEFRAMES period,
                  const ENUM_APPLIED_VOLUME applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iAD(symbol, period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiAD::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                      const int num_params, const MqlParam &params[]) {
  return (
      Initialize(symbol, period, (ENUM_APPLIED_VOLUME)params[0].integer_value));
}

bool CiAD::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                      const ENUM_APPLIED_VOLUME applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "AD";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               VolumeDescription(applied) + ") H=" + IntegerToString(m_handle);

    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiAD::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiMFI : public CIndicator {
protected:
  int m_ma_period;
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiMFI(void);
  ~CiMFI(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  ENUM_APPLIED_VOLUME Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_MFI);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const ENUM_APPLIED_VOLUME applied);
};

CiMFI::CiMFI(void) : m_ma_period(-1), m_applied(WRONG_VALUE) {
}

CiMFI::~CiMFI(void) {
}

bool CiMFI::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const int ma_period, const ENUM_APPLIED_VOLUME applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iMFI(symbol, period, ma_period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiMFI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (ENUM_APPLIED_VOLUME)params[1].integer_value));
}

bool CiMFI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int ma_period, const ENUM_APPLIED_VOLUME applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "MFI";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + VolumeDescription(applied) +
               "," + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiMFI::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiOBV : public CIndicator {
protected:
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiOBV(void);
  ~CiOBV(void);

  ENUM_APPLIED_VOLUME Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_OBV);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const ENUM_APPLIED_VOLUME applied);
};

CiOBV::CiOBV(void) : m_applied(WRONG_VALUE) {
}

CiOBV::~CiOBV(void) {
}

bool CiOBV::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const ENUM_APPLIED_VOLUME applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iOBV(symbol, period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiOBV::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (
      Initialize(symbol, period, (ENUM_APPLIED_VOLUME)params[0].integer_value));
}

bool CiOBV::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const ENUM_APPLIED_VOLUME applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "OBV";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               VolumeDescription(applied) + "," +
               ") H=" + IntegerToString(m_handle);

    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiOBV::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiVolumes : public CIndicator {
protected:
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiVolumes(void);
  ~CiVolumes(void);

  ENUM_APPLIED_VOLUME Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_VOLUMES);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const ENUM_APPLIED_VOLUME applied);
};

CiVolumes::CiVolumes(void) : m_applied(WRONG_VALUE) {
}

CiVolumes::~CiVolumes(void) {
}

bool CiVolumes::Create(const string symbol, const ENUM_TIMEFRAMES period,
                       const ENUM_APPLIED_VOLUME applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iVolumes(symbol, period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiVolumes::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                           const int num_params, const MqlParam &params[]) {
  return (
      Initialize(symbol, period, (ENUM_APPLIED_VOLUME)params[0].integer_value));
}

bool CiVolumes::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                           const ENUM_APPLIED_VOLUME applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "Volumes";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               VolumeDescription(applied) + "," +
               ") H=" + IntegerToString(m_handle);

    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiVolumes::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

#endif
