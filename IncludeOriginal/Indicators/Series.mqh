#ifndef SERIES_H
#define SERIES_H

#include <Arrays\ArrayDouble.mqh>
#include <Arrays\ArrayObj.mqh>

#define DEFAULT_BUFFER_SIZE 1024

class CSeries : public CArrayObj {
protected:
  string m_name;
  int m_buffers_total;
  int m_buffer_size;
  int m_timeframe_flags;
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  bool m_refresh_current;

  datetime m_first_date;

public:
  CSeries(void);
  ~CSeries(void);

  string Name(void) const {
    return (m_name);
  }
  int BuffersTotal(void) const {
    return (m_buffers_total);
  }
  int BufferSize(void) const {
    return (m_buffer_size);
  }
  int Timeframe(void) const {
    return (m_timeframe_flags);
  }
  string Symbol(void) const {
    return (m_symbol);
  }
  ENUM_TIMEFRAMES Period(void) const {
    return (m_period);
  }
  string PeriodDescription(const int val = 0);
  void RefreshCurrent(const bool flag) {
    m_refresh_current = flag;
  }

  virtual bool BufferResize(const int size);

  virtual void Refresh(const int flags) {}

protected:
  bool SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
  void PeriodToTimeframeFlag(const ENUM_TIMEFRAMES period);

  bool CheckLoadHistory(const int size);
  bool CheckTerminalHistory(const int size);
  bool CheckServerHistory(const int size);
};

void CSeries::CSeries(void)
    : m_name(""), m_timeframe_flags(0), m_buffers_total(0), m_buffer_size(0),
      m_symbol(""), m_period(WRONG_VALUE), m_refresh_current(true) {}

CSeries::~CSeries(void) {}

bool CSeries::BufferResize(const int size) {

  if (!CheckLoadHistory(size)) {
    printf("failed to get %d bars for %s,%s", size, m_symbol,
           EnumToString(m_period));
    return (false);
  }

  m_buffer_size = size;

  return (true);
}

bool CSeries::SetSymbolPeriod(const string symbol,
                              const ENUM_TIMEFRAMES period) {
  m_symbol = (symbol == NULL) ? ChartSymbol() : symbol;
  m_period = (period == 0) ? ChartPeriod() : period;
  PeriodToTimeframeFlag(m_period);

  return (true);
}

void CSeries::PeriodToTimeframeFlag(const ENUM_TIMEFRAMES period) {
  static ENUM_TIMEFRAMES _p_int[] = {
      PERIOD_M1,  PERIOD_M2,  PERIOD_M3,  PERIOD_M4,  PERIOD_M5,  PERIOD_M6,
      PERIOD_M10, PERIOD_M12, PERIOD_M15, PERIOD_M20, PERIOD_M30, PERIOD_H1,
      PERIOD_H2,  PERIOD_H3,  PERIOD_H4,  PERIOD_H6,  PERIOD_H8,  PERIOD_H12,
      PERIOD_D1,  PERIOD_W1,  PERIOD_MN1};

  for (int i = 0; i < ArraySize(_p_int); i++)
    if (period == _p_int[i]) {

      m_timeframe_flags = ((int)1) << i;
      return;
    }
}

string CSeries::PeriodDescription(const int val) {
  int i, frame;

  static string _p_str[] = {"M1",  "M2",  "M3",  "M4",     "M5",  "M6",
                            "M10", "M12", "M15", "M20",    "M30", "H1",
                            "H2",  "H3",  "H4",  "H6",     "H8",  "H12",
                            "D1",  "W1",  "MN",  "UNKNOWN"};
  static ENUM_TIMEFRAMES _p_int[] = {
      PERIOD_M1,  PERIOD_M2,  PERIOD_M3,  PERIOD_M4,  PERIOD_M5,  PERIOD_M6,
      PERIOD_M10, PERIOD_M12, PERIOD_M15, PERIOD_M20, PERIOD_M30, PERIOD_H1,
      PERIOD_H2,  PERIOD_H3,  PERIOD_H4,  PERIOD_H6,  PERIOD_H8,  PERIOD_H12,
      PERIOD_D1,  PERIOD_W1,  PERIOD_MN1};

  frame = (val == 0) ? m_period : val;
  if (frame == WRONG_VALUE)
    return ("WRONG_VALUE");

  for (i = 0; i < ArraySize(_p_int); i++)
    if (frame == _p_int[i])
      break;

  return (_p_str[i]);
}

bool CSeries::CheckLoadHistory(const int size) {

  if (MQL5InfoInteger(MQL5_PROGRAM_TYPE) == PROGRAM_INDICATOR &&
      Period() == m_period && Symbol() == m_symbol)
    return (true);
  if (size > TerminalInfoInteger(TERMINAL_MAXBARS)) {

    printf(__FUNCTION__ + ": requested too much data (%d)", size);
    return (false);
  }
  m_first_date = 0;
  if (CheckTerminalHistory(size))
    return (true);
  if (CheckServerHistory(size))
    return (true);

  return (false);
}

bool CSeries::CheckTerminalHistory(const int size) {
  datetime times[1];
  long bars = 0;

  if (Bars(m_symbol, m_period) >= size)
    return (true);

  if (SeriesInfoInteger(m_symbol, PERIOD_M1, SERIES_BARS_COUNT, bars)) {

    if (bars > size * PeriodSeconds(m_period) / 60) {

      CopyTime(m_symbol, m_period, size - 1, 1, times);

      if (SeriesInfoInteger(m_symbol, m_period, SERIES_BARS_COUNT, bars))

        if (bars > size)
          return (true);
    }
  }

  return (false);
}

bool CSeries::CheckServerHistory(const int size) {

  datetime first_server_date = 0;
  while (!SeriesInfoInteger(m_symbol, PERIOD_M1, SERIES_SERVER_FIRSTDATE,
                            first_server_date) &&
         !IsStopped())
    Sleep(5);

  if (first_server_date > TimeCurrent() - size * PeriodSeconds(m_period))
    return (false);

  int fail_cnt = 0;
  datetime times[1];
  while (!IsStopped()) {

    while (!SeriesInfoInteger(m_symbol, m_period, SERIES_SYNCHRONIZED) &&
           !IsStopped())
      Sleep(5);

    int bars = Bars(m_symbol, m_period);
    if (bars > size)
      return (true);

    if (CopyTime(m_symbol, m_period, size - 1, 1, times) == 1)
      return (true);

    if (++fail_cnt >= 100)
      return (false);
    Sleep(10);
  }

  return (false);
}

class CDoubleBuffer : public CArrayDouble {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_size;

public:
  CDoubleBuffer(void);
  ~CDoubleBuffer(void);

  void Size(const int size) {
    m_size = size;
  }

  double At(const int index) const;

  virtual bool Refresh(void) {
    return (true);
  }
  virtual bool RefreshCurrent(void) {
    return (true);
  }

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};

CDoubleBuffer::CDoubleBuffer(void)
    : m_symbol(""), m_period(WRONG_VALUE), m_size(DEFAULT_BUFFER_SIZE) {
  ArraySetAsSeries(m_data, true);
}

CDoubleBuffer::~CDoubleBuffer(void) {}

double CDoubleBuffer::At(const int index) const {

  if (index >= m_data_total)
    return (EMPTY_VALUE);

  double d = CArrayDouble::At(index);

  return (d);
}

void CDoubleBuffer::SetSymbolPeriod(const string symbol,
                                    const ENUM_TIMEFRAMES period) {
  m_symbol = (symbol == NULL) ? ChartSymbol() : symbol;
  m_period = (period == 0) ? ChartPeriod() : period;
}

#endif
