#ifndef BILL_WILLIAMS_H
#define BILL_WILLIAMS_H

#include "Indicator.mqh"

class CiAC : public CIndicator {
public:
  CiAC(void);
  ~CiAC(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_AC);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period);
};

CiAC::CiAC(void) {
}

CiAC::~CiAC(void) {
}

bool CiAC::Create(const string symbol, const ENUM_TIMEFRAMES period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iAC(symbol, period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiAC::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                      const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period));
}

bool CiAC::Initialize(const string symbol, const ENUM_TIMEFRAMES period) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "AC";
    m_status = "(" + symbol + "," + PeriodDescription() +
               ") H=" + IntegerToString(m_handle);

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiAC::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

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

  int JawPeriod(void) const {
    return (m_jaw_period);
  }
  int JawShift(void) const {
    return (m_jaw_shift);
  }
  int TeethPeriod(void) const {
    return (m_teeth_period);
  }
  int TeethShift(void) const {
    return (m_teeth_shift);
  }
  int LipsPeriod(void) const {
    return (m_lips_period);
  }
  int LipsShift(void) const {
    return (m_lips_shift);
  }
  ENUM_MA_METHOD MaMethod(void) const {
    return (m_ma_method);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int jaw_period, const int jaw_shift, const int teeth_period,
              const int teeth_shift, const int lips_period,
              const int lips_shift, const ENUM_MA_METHOD ma_method,
              const int applied);

  double Jaw(const int index) const;
  double Teeth(const int index) const;
  double Lips(const int index) const;

  virtual int Type(void) const {
    return (IND_ALLIGATOR);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int jaw_period, const int jaw_shift,
                  const int teeth_period, const int teeth_shift,
                  const int lips_period, const int lips_shift,
                  const ENUM_MA_METHOD ma_method, const int applied);
};

CiAlligator::CiAlligator(void)
    : m_jaw_period(-1), m_jaw_shift(-1), m_teeth_period(-1), m_teeth_shift(-1),
      m_lips_period(-1), m_lips_shift(-1), m_ma_method(WRONG_VALUE),
      m_applied(-1) {
}

CiAlligator::~CiAlligator(void) {
}

bool CiAlligator::Create(const string symbol, const ENUM_TIMEFRAMES period,
                         const int jaw_period, const int jaw_shift,
                         const int teeth_period, const int teeth_shift,
                         const int lips_period, const int lips_shift,
                         const ENUM_MA_METHOD ma_method, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle =
      iAlligator(symbol, period, jaw_period, jaw_shift, teeth_period,
                 teeth_shift, lips_period, lips_shift, ma_method, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, jaw_period, jaw_shift, teeth_period,
                  teeth_shift, lips_period, lips_shift, ma_method, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiAlligator::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                             const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value, (int)params[2].integer_value,
                     (int)params[3].integer_value, (int)params[4].integer_value,
                     (int)params[5].integer_value,
                     (ENUM_MA_METHOD)params[6].integer_value,
                     (int)params[7].integer_value));
}

bool CiAlligator::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                             const int jaw_period, const int jaw_shift,
                             const int teeth_period, const int teeth_shift,
                             const int lips_period, const int lips_shift,
                             const ENUM_MA_METHOD ma_method,
                             const int applied) {
  if (CreateBuffers(symbol, period, 3)) {

    m_name = "Alligator";
    m_status =
        "(" + symbol + "," + PeriodDescription() + "," +
        IntegerToString(jaw_period) + "," + IntegerToString(jaw_shift) + "," +
        IntegerToString(teeth_period) + "," + IntegerToString(teeth_shift) +
        "," + IntegerToString(lips_period) + "," + IntegerToString(lips_shift) +
        "," + MethodDescription(ma_method) + "," + PriceDescription(applied) +
        ") H=" + IntegerToString(m_handle);

    m_jaw_period = jaw_period;
    m_jaw_shift = jaw_shift;
    m_teeth_period = teeth_period;
    m_teeth_shift = teeth_shift;
    m_lips_period = lips_period;
    m_lips_shift = lips_shift;
    m_ma_method = ma_method;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("JAW_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(jaw_shift);
    ((CIndicatorBuffer *)At(1)).Name("TEETH_LINE");
    ((CIndicatorBuffer *)At(1)).Offset(teeth_shift);
    ((CIndicatorBuffer *)At(2)).Name("LIPS_LINE");
    ((CIndicatorBuffer *)At(2)).Offset(lips_shift);

    return (true);
  }

  return (false);
}

double CiAlligator::Jaw(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiAlligator::Teeth(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiAlligator::Lips(const int index) const {
  CIndicatorBuffer *buffer = At(2);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiAO : public CIndicator {
public:
  CiAO(void);
  ~CiAO(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_AO);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period);
};

CiAO::CiAO(void) {
}

CiAO::~CiAO(void) {
}

bool CiAO::Create(const string symbol, const ENUM_TIMEFRAMES period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iAO(symbol, period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiAO::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                      const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period));
}

bool CiAO::Initialize(const string symbol, const ENUM_TIMEFRAMES period) {
  if (CreateBuffers(symbol, period, 1)) {

    m_status = "AO(" + symbol + "," + PeriodDescription() +
               ") H=" + IntegerToString(m_handle);

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiAO::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiFractals : public CIndicator {
public:
  CiFractals(void);
  ~CiFractals(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double Upper(const int index) const;
  double Lower(const int index) const;

  virtual int Type(void) const {
    return (IND_FRACTALS);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period);
};

CiFractals::CiFractals(void) {
}

CiFractals::~CiFractals(void) {
}

bool CiFractals::Create(const string symbol, const ENUM_TIMEFRAMES period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iFractals(symbol, period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiFractals::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                            const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period));
}

bool CiFractals::Initialize(const string symbol, const ENUM_TIMEFRAMES period) {
  if (CreateBuffers(symbol, period, 2)) {

    m_name = "Fractals";
    m_status = "(" + symbol + "," + PeriodDescription() +
               ") H=" + IntegerToString(m_handle);

    ((CIndicatorBuffer *)At(0)).Name("UPPER_LINE");
    ((CIndicatorBuffer *)At(1)).Name("LOWER_LINE");

    return (true);
  }

  return (false);
}

double CiFractals::Upper(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiFractals::Lower(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

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

  int JawPeriod(void) const {
    return (m_jaw_period);
  }
  int JawShift(void) const {
    return (m_jaw_shift);
  }
  int TeethPeriod(void) const {
    return (m_teeth_period);
  }
  int TeethShift(void) const {
    return (m_teeth_shift);
  }
  int LipsPeriod(void) const {
    return (m_lips_period);
  }
  int LipsShift(void) const {
    return (m_lips_shift);
  }
  ENUM_MA_METHOD MaMethod(void) const {
    return (m_ma_method);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int jaw_period, const int jaw_shift, const int teeth_period,
              const int teeth_shift, const int lips_period,
              const int lips_shift, const ENUM_MA_METHOD ma_method,
              const int applied);

  double Upper(const int index) const;
  double Lower(const int index) const;

  virtual int Type(void) const {
    return (IND_GATOR);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int jaw_period, const int jaw_shift,
                  const int teeth_period, const int teeth_shift,
                  const int lips_period, const int lips_shift,
                  const ENUM_MA_METHOD ma_method, const int applied);
};

CiGator::CiGator(void)
    : m_jaw_period(-1), m_jaw_shift(-1), m_teeth_period(-1), m_teeth_shift(-1),
      m_lips_period(-1), m_lips_shift(-1), m_ma_method(WRONG_VALUE),
      m_applied(-1) {
}

CiGator::~CiGator(void) {
}

bool CiGator::Create(const string symbol, const ENUM_TIMEFRAMES period,
                     const int jaw_period, const int jaw_shift,
                     const int teeth_period, const int teeth_shift,
                     const int lips_period, const int lips_shift,
                     const ENUM_MA_METHOD ma_method, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iGator(symbol, period, jaw_period, jaw_shift, teeth_period,
                    teeth_shift, lips_period, lips_shift, ma_method, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, jaw_period, jaw_shift, teeth_period,
                  teeth_shift, lips_period, lips_shift, ma_method, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiGator::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value, (int)params[2].integer_value,
                     (int)params[3].integer_value, (int)params[4].integer_value,
                     (int)params[5].integer_value,
                     (ENUM_MA_METHOD)params[6].integer_value,
                     (int)params[7].integer_value));
}

bool CiGator::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int jaw_period, const int jaw_shift,
                         const int teeth_period, const int teeth_shift,
                         const int lips_period, const int lips_shift,
                         const ENUM_MA_METHOD ma_method, const int applied) {
  if (CreateBuffers(symbol, period, 2)) {

    m_name = "Gator";
    m_status =
        "(" + symbol + "," + PeriodDescription() + "," +
        IntegerToString(jaw_period) + "," + IntegerToString(jaw_shift) + "," +
        IntegerToString(teeth_period) + "," + IntegerToString(teeth_shift) +
        "," + IntegerToString(lips_period) + "," + IntegerToString(lips_shift) +
        "," + MethodDescription(ma_method) + "," + PriceDescription(applied) +
        ") H=" + IntegerToString(m_handle);

    m_jaw_period = jaw_period;
    m_jaw_shift = jaw_shift;
    m_teeth_period = teeth_period;
    m_teeth_shift = teeth_shift;
    m_lips_period = lips_period;
    m_lips_shift = lips_shift;
    m_ma_method = ma_method;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("UPPER_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(teeth_shift);
    ((CIndicatorBuffer *)At(1)).Name("LOWER_LINE");
    ((CIndicatorBuffer *)At(1)).Offset(lips_shift);

    return (true);
  }

  return (false);
}

double CiGator::Upper(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiGator::Lower(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiBWMFI : public CIndicator {
protected:
  ENUM_APPLIED_VOLUME m_applied;

public:
  CiBWMFI(void);
  ~CiBWMFI(void);

  ENUM_APPLIED_VOLUME Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_APPLIED_VOLUME applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_BWMFI);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const ENUM_APPLIED_VOLUME applied);
};

CiBWMFI::CiBWMFI(void) : m_applied(WRONG_VALUE) {
}

CiBWMFI::~CiBWMFI(void) {
}

bool CiBWMFI::Create(const string symbol, const ENUM_TIMEFRAMES period,
                     const ENUM_APPLIED_VOLUME applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iBWMFI(symbol, period, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiBWMFI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int num_params, const MqlParam &params[]) {
  return (
      Initialize(symbol, period, (ENUM_APPLIED_VOLUME)params[0].integer_value));
}

bool CiBWMFI::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const ENUM_APPLIED_VOLUME applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "BWMFI";
    m_status = "BWMFI(" + symbol + "," + PeriodDescription() + "," +
               VolumeDescription(applied) + ") H=" + IntegerToString(m_handle);

    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiBWMFI::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

#endif
