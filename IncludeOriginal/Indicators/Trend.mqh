#ifndef TREND_H
#define TREND_H

#include "Indicator.mqh"

class CiADX : public CIndicator {
protected:
  int m_ma_period;

public:
  CiADX(void);
  ~CiADX(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;
  double Plus(const int index) const;
  double Minus(const int index) const;

  virtual int Type(void) const {
    return (IND_ADX);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};

CiADX::CiADX(void) : m_ma_period(-1) {}

CiADX::~CiADX(void) {}

bool CiADX::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const int ma_period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iADX(symbol, period, ma_period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiADX::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value));
}

bool CiADX::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int ma_period) {
  if (CreateBuffers(symbol, period, 3)) {

    m_name = "ADX";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(1)).Name("PLUS_LINE");
    ((CIndicatorBuffer *)At(2)).Name("MINUS_LINE");

    return (true);
  }

  return (false);
}

double CiADX::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiADX::Plus(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiADX::Minus(const int index) const {
  CIndicatorBuffer *buffer = At(2);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiADXWilder : public CIndicator {
protected:
  int m_ma_period;

public:
  CiADXWilder(void);
  ~CiADXWilder(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period);

  double Main(const int index) const;
  double Plus(const int index) const;
  double Minus(const int index) const;

  virtual int Type(void) const {
    return (IND_ADXW);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period);
};

CiADXWilder::CiADXWilder(void) : m_ma_period(-1) {}

CiADXWilder::~CiADXWilder(void) {}

bool CiADXWilder::Create(const string symbol, const ENUM_TIMEFRAMES period,
                         const int ma_period) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iADXWilder(symbol, period, ma_period);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiADXWilder::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                             const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value));
}

bool CiADXWilder::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                             const int ma_period) {
  if (CreateBuffers(symbol, period, 3)) {

    m_name = "ADXWilder";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(1)).Name("PLUS_LINE");
    ((CIndicatorBuffer *)At(2)).Name("MINUS_LINE");

    return (true);
  }

  return (false);
}

double CiADXWilder::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiADXWilder::Plus(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiADXWilder::Minus(const int index) const {
  CIndicatorBuffer *buffer = At(2);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiBands : public CIndicator {
protected:
  int m_ma_period;
  int m_ma_shift;
  double m_deviation;
  int m_applied;

public:
  CiBands(void);
  ~CiBands(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int MaShift(void) const {
    return (m_ma_shift);
  }
  double Deviation(void) const {
    return (m_deviation);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift, const double deviation,
              const int applied);

  double Base(const int index) const;
  double Upper(const int index) const;
  double Lower(const int index) const;

  virtual int Type(void) const {
    return (IND_BANDS);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const double deviation, const int applied);
};

CiBands::CiBands(void)
    : m_ma_period(-1), m_ma_shift(-1), m_deviation(EMPTY_VALUE), m_applied(-1) {
}

CiBands::~CiBands(void) {}

bool CiBands::Create(const string symbol, const ENUM_TIMEFRAMES period,
                     const int ma_period, const int ma_shift,
                     const double deviation, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iBands(symbol, period, ma_period, ma_shift, deviation, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, ma_shift, deviation, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiBands::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value, params[2].double_value,
                     (int)params[3].integer_value));
}

bool CiBands::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int ma_period, const int ma_shift,
                         const double deviation, const int applied) {
  if (CreateBuffers(symbol, period, 3)) {

    m_name = "Bands";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + IntegerToString(ma_shift) +
               "," + DoubleToString(deviation) + "," +
               PriceDescription(applied) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_ma_shift = ma_shift;
    m_deviation = deviation;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("BASE_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ma_shift);
    ((CIndicatorBuffer *)At(1)).Name("UPPER_BAND");
    ((CIndicatorBuffer *)At(1)).Offset(ma_shift);
    ((CIndicatorBuffer *)At(2)).Name("LOWER_BAND");
    ((CIndicatorBuffer *)At(2)).Offset(ma_shift);

    return (true);
  }

  return (false);
}

double CiBands::Base(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiBands::Upper(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiBands::Lower(const int index) const {
  CIndicatorBuffer *buffer = At(2);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

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

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int MaShift(void) const {
    return (m_ma_shift);
  }
  ENUM_MA_METHOD MaMethod(void) const {
    return (m_ma_method);
  }
  int Applied(void) const {
    return (m_applied);
  }
  double Deviation(void) const {
    return (m_deviation);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift,
              const ENUM_MA_METHOD ma_method, const int applied,
              const double deviation);

  double Upper(const int index) const;
  double Lower(const int index) const;

  virtual int Type(void) const {
    return (IND_ENVELOPES);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const ENUM_MA_METHOD ma_method, const int applied,
                  const double deviation);
};

CiEnvelopes::CiEnvelopes(void)
    : m_ma_period(-1), m_ma_shift(-1), m_ma_method(WRONG_VALUE), m_applied(-1),
      m_deviation(EMPTY_VALUE) {}

CiEnvelopes::~CiEnvelopes(void) {}

bool CiEnvelopes::Create(const string symbol, const ENUM_TIMEFRAMES period,
                         const int ma_period, const int ma_shift,
                         const ENUM_MA_METHOD ma_method, const int applied,
                         const double deviation) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iEnvelopes(symbol, period, ma_period, ma_shift, ma_method, applied,
                        deviation);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, ma_shift, ma_method, applied,
                  deviation)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiEnvelopes::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                             const int num_params, const MqlParam &params[]) {
  return (Initialize(
      symbol, period, (int)params[0].integer_value,
      (int)params[1].integer_value, (ENUM_MA_METHOD)params[2].integer_value,
      (int)params[3].integer_value, (int)params[4].double_value));
}

bool CiEnvelopes::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                             const int ma_period, const int ma_shift,
                             const ENUM_MA_METHOD ma_method, const int applied,
                             const double deviation) {
  if (CreateBuffers(symbol, period, 2)) {

    m_name = "Envelopes";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + IntegerToString(ma_shift) +
               "," + MethodDescription(ma_method) + "," +
               PriceDescription(applied) + "," + DoubleToString(deviation) +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_ma_shift = ma_shift;
    m_ma_method = ma_method;
    m_applied = applied;
    m_deviation = deviation;

    ((CIndicatorBuffer *)At(0)).Name("UPPER_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ma_shift);
    ((CIndicatorBuffer *)At(1)).Name("LOWER_LINE");
    ((CIndicatorBuffer *)At(1)).Offset(ma_shift);

    return (true);
  }

  return (false);
}

double CiEnvelopes::Upper(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiEnvelopes::Lower(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiIchimoku : public CIndicator {
protected:
  int m_tenkan_sen;
  int m_kijun_sen;
  int m_senkou_span_b;

public:
  CiIchimoku(void);
  ~CiIchimoku(void);

  int TenkanSenPeriod(void) const {
    return (m_tenkan_sen);
  }
  int KijunSenPeriod(void) const {
    return (m_kijun_sen);
  }
  int SenkouSpanBPeriod(void) const {
    return (m_senkou_span_b);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int tenkan_sen, const int kijun_sen,
              const int senkou_span_b);

  double TenkanSen(const int index) const;
  double KijunSen(const int index) const;
  double SenkouSpanA(const int index) const;
  double SenkouSpanB(const int index) const;
  double ChinkouSpan(const int index) const;

  virtual int Type(void) const {
    return (IND_ICHIMOKU);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int tenkan_sen, const int kijun_sen,
                  const int senkou_span_b);
};

CiIchimoku::CiIchimoku(void)
    : m_tenkan_sen(-1), m_kijun_sen(-1), m_senkou_span_b(-1) {}

CiIchimoku::~CiIchimoku(void) {}

bool CiIchimoku::Create(const string symbol, const ENUM_TIMEFRAMES period,
                        const int tenkan_sen, const int kijun_sen,
                        const int senkou_span_b) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iIchimoku(symbol, period, tenkan_sen, kijun_sen, senkou_span_b);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, tenkan_sen, kijun_sen, senkou_span_b)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiIchimoku::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                            const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value,
                     (int)params[2].integer_value));
}

bool CiIchimoku::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                            const int tenkan_sen, const int kijun_sen,
                            const int senkou_span_b) {
  if (CreateBuffers(symbol, period, 5)) {

    m_name = "Ichimoku";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(tenkan_sen) + "," + IntegerToString(kijun_sen) +
               "," + IntegerToString(senkou_span_b) +
               ") H=" + IntegerToString(m_handle);

    m_tenkan_sen = tenkan_sen;
    m_kijun_sen = kijun_sen;
    m_senkou_span_b = senkou_span_b;

    ((CIndicatorBuffer *)At(0)).Name("TENKANSEN_LINE");
    ((CIndicatorBuffer *)At(1)).Name("KIJUNSEN_LINE");
    ((CIndicatorBuffer *)At(2)).Name("SENKOUSPANA_LINE");
    ((CIndicatorBuffer *)At(2)).Offset(kijun_sen);
    ((CIndicatorBuffer *)At(3)).Name("SENKOUSPANB_LINE");
    ((CIndicatorBuffer *)At(3)).Offset(kijun_sen);
    ((CIndicatorBuffer *)At(4)).Name("CHIKOUSPAN_LINE");
    ((CIndicatorBuffer *)At(4)).Offset(-kijun_sen);

    return (true);
  }

  return (false);
}

double CiIchimoku::TenkanSen(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiIchimoku::KijunSen(const int index) const {
  CIndicatorBuffer *buffer = At(1);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiIchimoku::SenkouSpanA(const int index) const {
  CIndicatorBuffer *buffer = At(2);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiIchimoku::SenkouSpanB(const int index) const {
  CIndicatorBuffer *buffer = At(3);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

double CiIchimoku::ChinkouSpan(const int index) const {
  CIndicatorBuffer *buffer = At(4);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiMA : public CIndicator {
protected:
  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  int m_applied;

public:
  CiMA(void);
  ~CiMA(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int MaShift(void) const {
    return (m_ma_shift);
  }
  ENUM_MA_METHOD MaMethod(void) const {
    return (m_ma_method);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift,
              const ENUM_MA_METHOD ma_method, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_MA);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const ENUM_MA_METHOD ma_method, const int applied);
};

CiMA::CiMA(void)
    : m_ma_period(-1), m_ma_shift(-1), m_ma_method(WRONG_VALUE), m_applied(-1) {
}

CiMA::~CiMA(void) {}

bool CiMA::Create(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const ENUM_MA_METHOD ma_method, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iMA(symbol, period, ma_period, ma_shift, ma_method, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, ma_shift, ma_method, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                      const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value,
                     (ENUM_MA_METHOD)params[2].integer_value,
                     (int)params[3].integer_value));
}

bool CiMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                      const int ma_period, const int ma_shift,
                      const ENUM_MA_METHOD ma_method, const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "MA";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + IntegerToString(ma_shift) +
               "," + MethodDescription(ma_method) + "," +
               PriceDescription(applied) + ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_ma_shift = ma_shift;
    m_ma_method = ma_method;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ma_shift);

    return (true);
  }

  return (false);
}

double CiMA::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiSAR : public CIndicator {
protected:
  double m_step;
  double m_maximum;

public:
  CiSAR(void);
  ~CiSAR(void);

  double SarStep(void) const {
    return (m_step);
  }
  double Maximum(void) const {
    return (m_maximum);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const double step, const double maximum);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_SAR);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const double step, const double maximum);
};

CiSAR::CiSAR(void) : m_step(EMPTY_VALUE), m_maximum(EMPTY_VALUE) {}

CiSAR::~CiSAR(void) {}

bool CiSAR::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const double step, const double maximum) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iSAR(symbol, period, step, maximum);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, step, maximum)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiSAR::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, params[0].double_value,
                     params[1].double_value));
}

bool CiSAR::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const double step, const double maximum) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "SAR";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               DoubleToString(step, 4) + "," + DoubleToString(maximum, 4) +
               "," + ") H=" + IntegerToString(m_handle);

    m_step = step;
    m_maximum = maximum;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");

    return (true);
  }

  return (false);
}

double CiSAR::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiStdDev : public CIndicator {
protected:
  int m_ma_period;
  int m_ma_shift;
  ENUM_MA_METHOD m_ma_method;
  int m_applied;

public:
  CiStdDev(void);
  ~CiStdDev(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int MaShift(void) const {
    return (m_ma_shift);
  }
  ENUM_MA_METHOD MaMethod(void) const {
    return (m_ma_method);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift,
              const ENUM_MA_METHOD ma_method, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_STDDEV);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift,
                  const ENUM_MA_METHOD ma_method, const int applied);
};

CiStdDev::CiStdDev(void)
    : m_ma_period(-1), m_ma_shift(-1), m_ma_method(WRONG_VALUE), m_applied(-1) {
}

CiStdDev::~CiStdDev(void) {}

bool CiStdDev::Create(const string symbol, const ENUM_TIMEFRAMES period,
                      const int ma_period, const int ma_shift,
                      const ENUM_MA_METHOD ma_method, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iStdDev(symbol, period, ma_period, ma_shift, ma_method, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, ma_shift, ma_method, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiStdDev::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value,
                     (ENUM_MA_METHOD)params[2].integer_value,
                     (int)params[3].integer_value));
}

bool CiStdDev::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int ma_period, const int ma_shift,
                          const ENUM_MA_METHOD ma_method, const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "StdDev";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + IntegerToString(ma_shift) +
               "," + MethodDescription(ma_method) +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_ma_shift = ma_shift;
    m_ma_method = ma_method;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ma_shift);

    return (true);
  }

  return (false);
}

double CiStdDev::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiDEMA : public CIndicator {
protected:
  int m_ma_period;
  int m_ind_shift;
  int m_applied;

public:
  CiDEMA(void);
  ~CiDEMA(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int IndShift(void) const {
    return (m_ind_shift);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ind_shift, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_DEMA);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ind_shift, const int applied);
};

CiDEMA::CiDEMA(void) : m_ma_period(-1), m_ind_shift(-1), m_applied(-1) {}

CiDEMA::~CiDEMA(void) {}

bool CiDEMA::Create(const string symbol, const ENUM_TIMEFRAMES period,
                    const int ma_period, const int ind_shift,
                    const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iDEMA(symbol, period, ma_period, ind_shift, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, ind_shift, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiDEMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value,
                     (int)params[2].integer_value));
}

bool CiDEMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int ma_period, const int ind_shift,
                        const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "DEMA";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + IntegerToString(ind_shift) +
               "," + PriceDescription(applied) +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_ind_shift = ind_shift;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ind_shift);

    return (true);
  }

  return (false);
}

double CiDEMA::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiTEMA : public CIndicator {
protected:
  int m_ma_period;
  int m_ind_shift;
  int m_applied;

public:
  CiTEMA(void);
  ~CiTEMA(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int IndShift(void) const {
    return (m_ind_shift);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ma_shift, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_TEMA);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ma_shift, const int applied);
};

CiTEMA::CiTEMA(void) : m_ma_period(-1), m_ind_shift(-1), m_applied(-1) {}

CiTEMA::~CiTEMA(void) {}

bool CiTEMA::Create(const string symbol, const ENUM_TIMEFRAMES period,
                    const int ma_period, const int ind_shift,
                    const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iTEMA(symbol, period, ma_period, ind_shift, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, ind_shift, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiTEMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value,
                     (int)params[2].integer_value));
}

bool CiTEMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                        const int ma_period, const int ind_shift,
                        const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "TEMA";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + IntegerToString(ind_shift) +
               "," + PriceDescription(applied) +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_ind_shift = ind_shift;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ind_shift);

    return (true);
  }

  return (false);
}

double CiTEMA::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiFrAMA : public CIndicator {
protected:
  int m_ma_period;
  int m_ind_shift;
  int m_applied;

public:
  CiFrAMA(void);
  ~CiFrAMA(void);

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int IndShift(void) const {
    return (m_ind_shift);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int ind_shift, const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_FRAMA);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int ind_shift, const int applied);
};

CiFrAMA::CiFrAMA(void) : m_ma_period(-1), m_ind_shift(-1), m_applied(-1) {}

CiFrAMA::~CiFrAMA(void) {}

bool CiFrAMA::Create(const string symbol, const ENUM_TIMEFRAMES period,
                     const int ma_period, const int ind_shift,
                     const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iFrAMA(symbol, period, ma_period, ind_shift, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, ind_shift, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiFrAMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value,
                     (int)params[2].integer_value));
}

bool CiFrAMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int ma_period, const int ind_shift,
                         const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "FrAMA";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," + IntegerToString(ind_shift) +
               "," + PriceDescription(applied) +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ind_shift);

    return (true);
  }

  return (false);
}

double CiFrAMA::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

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

  int MaPeriod(void) const {
    return (m_ma_period);
  }
  int FastEmaPeriod(void) const {
    return (m_fast_ema_period);
  }
  int SlowEmaPeriod(void) const {
    return (m_slow_ema_period);
  }
  int IndShift(void) const {
    return (m_ind_shift);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int ma_period, const int fast_ema_period,
              const int slow_ema_period, const int ind_shift,
              const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_AMA);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int ma_period, const int fast_ema_period,
                  const int slow_ema_period, const int ind_shift,
                  const int applied);
};

CiAMA::CiAMA(void)
    : m_ma_period(-1), m_fast_ema_period(-1), m_slow_ema_period(-1),
      m_ind_shift(-1), m_applied(-1) {}

CiAMA::~CiAMA(void) {}

bool CiAMA::Create(const string symbol, const ENUM_TIMEFRAMES period,
                   const int ma_period, const int fast_ema_period,
                   const int slow_ema_period, const int ind_shift,
                   const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iAMA(symbol, period, ma_period, fast_ema_period, slow_ema_period,
                  ind_shift, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, ma_period, fast_ema_period, slow_ema_period,
                  ind_shift, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiAMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int num_params, const MqlParam &params[]) {
  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value, (int)params[2].integer_value,
                     (int)params[3].integer_value,
                     (int)params[4].integer_value));
}

bool CiAMA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                       const int ma_period, const int fast_ema_period,
                       const int slow_ema_period, const int ind_shift,
                       const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "AMA";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(ma_period) + "," +
               IntegerToString(fast_ema_period) + "," +
               IntegerToString(slow_ema_period) + "," +
               IntegerToString(ind_shift) + "," + PriceDescription(applied) +
               ") H=" + IntegerToString(m_handle);

    m_ma_period = ma_period;
    m_fast_ema_period = fast_ema_period;
    m_slow_ema_period = slow_ema_period;
    m_ind_shift = ind_shift;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ind_shift);

    return (true);
  }

  return (false);
}

double CiAMA::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

class CiVIDyA : public CIndicator {
protected:
  int m_cmo_period;
  int m_ema_period;
  int m_ind_shift;
  int m_applied;

public:
  CiVIDyA(void);
  ~CiVIDyA(void);

  int CmoPeriod(void) const {
    return (m_cmo_period);
  }
  int EmaPeriod(void) const {
    return (m_ema_period);
  }
  int IndShift(void) const {
    return (m_ind_shift);
  }
  int Applied(void) const {
    return (m_applied);
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const int cmo_period, const int ema_period, const int ind_shift,
              const int applied);

  double Main(const int index) const;

  virtual int Type(void) const {
    return (IND_VIDYA);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
  bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                  const int cmo_period, const int ema_period,
                  const int ind_shift, const int applied);
};

CiVIDyA::CiVIDyA(void)
    : m_cmo_period(-1), m_ema_period(-1), m_ind_shift(-1), m_applied(-1) {}

CiVIDyA::~CiVIDyA(void) {}

bool CiVIDyA::Create(const string symbol, const ENUM_TIMEFRAMES period,
                     const int cmo_period, const int ema_period,
                     const int ind_shift, const int applied) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = iVIDyA(symbol, period, cmo_period, ema_period, ind_shift, applied);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, cmo_period, ema_period, ind_shift, applied)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

bool CiVIDyA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int num_params, const MqlParam &params[]) {

  return (Initialize(symbol, period, (int)params[0].integer_value,
                     (int)params[1].integer_value, (int)params[2].integer_value,
                     (int)params[3].integer_value));
}

bool CiVIDyA::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                         const int cmo_period, const int ema_period,
                         const int ind_shift, const int applied) {
  if (CreateBuffers(symbol, period, 1)) {

    m_name = "VIDyA";
    m_status = "(" + symbol + "," + PeriodDescription() + "," +
               IntegerToString(cmo_period) + "," + IntegerToString(ema_period) +
               "," + IntegerToString(ind_shift) + "," +
               PriceDescription(applied) + ") H=" + IntegerToString(m_handle);

    m_cmo_period = cmo_period;
    m_ema_period = ema_period;
    m_ind_shift = ind_shift;
    m_applied = applied;

    ((CIndicatorBuffer *)At(0)).Name("MAIN_LINE");
    ((CIndicatorBuffer *)At(0)).Offset(ind_shift);

    return (true);
  }

  return (false);
}

double CiVIDyA::Main(const int index) const {
  CIndicatorBuffer *buffer = At(0);

  if (buffer == NULL)
    return (EMPTY_VALUE);

  return (buffer.At(index));
}

#endif
