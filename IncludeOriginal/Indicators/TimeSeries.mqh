#ifndef TIME_SERIES_H
#define TIME_SERIES_H

#include "Series.mqh"
#include <Arrays\ArrayInt.mqh>
#include <Arrays\ArrayLong.mqh>

class CPriceSeries : public CSeries {
public:
  CPriceSeries(void);
  ~CPriceSeries(void);

  virtual bool BufferResize(const int size);

  virtual int MinIndex(const int start, const int count) const;
  virtual double MinValue(const int start, const int count, int &index) const;
  virtual int MaxIndex(const int start, const int count) const;
  virtual double MaxValue(const int start, const int count, int &index) const;

  double GetData(const int index) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};

CPriceSeries::CPriceSeries(void) {
}

CPriceSeries::~CPriceSeries(void) {
}

bool CPriceSeries::BufferResize(const int size) {
  if (size > m_buffer_size && !CSeries::BufferResize(size))
    return (false);

  CDoubleBuffer *buff = At(0);

  if (buff == NULL)
    return (false);

  buff.Size(size);

  return (true);
}

int CPriceSeries::MinIndex(const int start, const int count) const {
  CDoubleBuffer *buff = At(0);

  if (buff == NULL)
    return (-1);

  return (buff.Minimum(start, count));
}

double CPriceSeries::MinValue(const int start, const int count,
                              int &index) const {
  int idx = MinIndex(start, count);
  double res = EMPTY_VALUE;

  if (idx != -1) {
    CDoubleBuffer *buff = At(0);
    res = buff.At(idx);
    index = idx;
  }

  return (res);
}

int CPriceSeries::MaxIndex(const int start, const int count) const {
  CDoubleBuffer *buff = At(0);

  if (buff == NULL)
    return (-1);

  return (buff.Maximum(start, count));
}

double CPriceSeries::MaxValue(const int start, const int count,
                              int &index) const {
  int idx = MaxIndex(start, count);
  double res = EMPTY_VALUE;

  if (idx != -1) {
    CDoubleBuffer *buff = At(0);
    res = buff.At(idx);
    index = idx;
  }

  return (res);
}

double CPriceSeries::GetData(const int index) const {
  CDoubleBuffer *buff = At(0);

  if (buff == NULL) {
    Print(__FUNCTION__, ": invalid buffer");
    return (EMPTY_VALUE);
  }

  return (buff.At(index));
}

void CPriceSeries::Refresh(const int flags) {
  CDoubleBuffer *buff = At(0);

  if (buff == NULL)
    return;

  if (!(flags & m_timeframe_flags)) {
    if (m_refresh_current)
      buff.RefreshCurrent();
  } else
    buff.Refresh();
}

class COpenBuffer : public CDoubleBuffer {
public:
  COpenBuffer(void);
  ~COpenBuffer(void);

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);
};

COpenBuffer::COpenBuffer(void) {
}

COpenBuffer::~COpenBuffer(void) {
}

bool COpenBuffer::Refresh(void) {
  m_data_total = CopyOpen(m_symbol, m_period, 0, m_size, m_data);

  return (m_data_total > 0);
}

bool COpenBuffer::RefreshCurrent(void) {
  double array[1];

  if (CopyOpen(m_symbol, m_period, 0, 1, array) == 1 && m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

class CiOpen : public CPriceSeries {
public:
  CiOpen(void);
  ~CiOpen(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double GetData(const int index) const {
    return (CPriceSeries::GetData(index));
  }
  int GetData(const int start_pos, const int count, double &buffer[]) const;
  int GetData(const datetime start_time, const int count,
              double &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              double &buffer[]) const;
};

CiOpen::CiOpen(void) {
  m_name = "Open";
}

CiOpen::~CiOpen(void) {
}

bool CiOpen::Create(const string symbol, const ENUM_TIMEFRAMES period) {
  CDoubleBuffer *buff;

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  if ((buff = new COpenBuffer) == NULL)
    return (false);

  if (!Add(buff)) {
    delete buff;
    return (false);
  }

  buff.SetSymbolPeriod(m_symbol, m_period);

  return (true);
}

int CiOpen::GetData(const int start_pos, const int count,
                    double &buffer[]) const {
  return (CopyOpen(m_symbol, m_period, start_pos, count, buffer));
}

int CiOpen::GetData(const datetime start_time, const int count,
                    double &buffer[]) const {
  return (CopyOpen(m_symbol, m_period, start_time, count, buffer));
}

int CiOpen::GetData(const datetime start_time, const datetime stop_time,
                    double &buffer[]) const {
  return (CopyOpen(m_symbol, m_period, start_time, stop_time, buffer));
}

class CHighBuffer : public CDoubleBuffer {
public:
  CHighBuffer(void);
  ~CHighBuffer(void);

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);
};

CHighBuffer::CHighBuffer(void) {
}

CHighBuffer::~CHighBuffer(void) {
}

bool CHighBuffer::Refresh(void) {
  m_data_total = CopyHigh(m_symbol, m_period, 0, m_size, m_data);

  return (m_data_total > 0);
}

bool CHighBuffer::RefreshCurrent(void) {
  double array[1];

  if (CopyHigh(m_symbol, m_period, 0, 1, array) > 0 && m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

class CiHigh : public CPriceSeries {
public:
  CiHigh(void);
  ~CiHigh(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double GetData(const int index) const {
    return (CPriceSeries::GetData(index));
  }
  int GetData(const int start_pos, const int count, double &buffer[]) const;
  int GetData(const datetime start_time, const int count,
              double &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              double &buffer[]) const;
};

CiHigh::CiHigh(void) {
  m_name = "High";
}

CiHigh::~CiHigh(void) {
}

bool CiHigh::Create(const string symbol, const ENUM_TIMEFRAMES period) {
  CDoubleBuffer *buff;

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  if ((buff = new CHighBuffer) == NULL)
    return (false);

  if (!Add(buff)) {
    delete buff;
    return (false);
  }

  buff.SetSymbolPeriod(m_symbol, m_period);

  return (true);
}

int CiHigh::GetData(const int start_pos, const int count,
                    double &buffer[]) const {
  return (CopyHigh(m_symbol, m_period, start_pos, count, buffer));
}

int CiHigh::GetData(const datetime start_time, const int count,
                    double &buffer[]) const {
  return (CopyHigh(m_symbol, m_period, start_time, count, buffer));
}

int CiHigh::GetData(const datetime start_time, const datetime stop_time,
                    double &buffer[]) const {
  return (CopyHigh(m_symbol, m_period, start_time, stop_time, buffer));
}

class CLowBuffer : public CDoubleBuffer {
public:
  CLowBuffer(void);
  ~CLowBuffer(void);

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);
};

CLowBuffer::CLowBuffer(void) {
}

CLowBuffer::~CLowBuffer(void) {
}

bool CLowBuffer::Refresh(void) {
  m_data_total = CopyLow(m_symbol, m_period, 0, m_size, m_data);

  return (m_data_total > 0);
}

bool CLowBuffer::RefreshCurrent(void) {
  double array[1];

  if (CopyLow(m_symbol, m_period, 0, 1, array) > 0 && m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

class CiLow : public CPriceSeries {
public:
  CiLow(void);
  ~CiLow(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double GetData(const int index) const {
    return (CPriceSeries::GetData(index));
  }
  int GetData(const int start_pos, const int count, double &buffer[]) const;
  int GetData(const datetime start_time, const int count,
              double &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              double &buffer[]) const;
};

CiLow::CiLow(void) {
  m_name = "Low";
}

CiLow::~CiLow(void) {
}

bool CiLow::Create(const string symbol, const ENUM_TIMEFRAMES period) {
  CDoubleBuffer *buff;

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  if ((buff = new CLowBuffer) == NULL)
    return (false);

  if (!Add(buff)) {
    delete buff;
    return (false);
  }

  buff.SetSymbolPeriod(m_symbol, m_period);

  return (true);
}

int CiLow::GetData(const int start_pos, const int count,
                   double &buffer[]) const {
  return (CopyLow(m_symbol, m_period, start_pos, count, buffer));
}

int CiLow::GetData(const datetime start_time, const int count,
                   double &buffer[]) const {
  return (CopyLow(m_symbol, m_period, start_time, count, buffer));
}

int CiLow::GetData(const datetime start_time, const datetime stop_time,
                   double &buffer[]) const {
  return (CopyLow(m_symbol, m_period, start_time, stop_time, buffer));
}

class CCloseBuffer : public CDoubleBuffer {
public:
  CCloseBuffer(void);
  ~CCloseBuffer(void);

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);
};

CCloseBuffer::CCloseBuffer(void) {
}

CCloseBuffer::~CCloseBuffer(void) {
}

bool CCloseBuffer::Refresh(void) {
  m_data_total = CopyClose(m_symbol, m_period, 0, m_size, m_data);

  return (m_data_total > 0);
}

bool CCloseBuffer::RefreshCurrent(void) {
  double array[1];

  if (CopyClose(m_symbol, m_period, 0, 1, array) > 0 && m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

class CiClose : public CPriceSeries {
public:
  CiClose(void);
  ~CiClose(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double GetData(const int index) const {
    return (CPriceSeries::GetData(index));
  }
  int GetData(const int start_pos, const int count, double &buffer[]) const;
  int GetData(const datetime start_time, const int count,
              double &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              double &buffer[]) const;
};

CiClose::CiClose(void) {
  m_name = "Close";
}

CiClose::~CiClose(void) {
}

bool CiClose::Create(const string symbol, const ENUM_TIMEFRAMES period) {
  CDoubleBuffer *buff;

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  if ((buff = new CCloseBuffer) == NULL)
    return (false);

  if (!Add(buff)) {
    delete buff;
    return (false);
  }

  buff.SetSymbolPeriod(m_symbol, m_period);

  return (true);
}

int CiClose::GetData(const int start_pos, const int count,
                     double &buffer[]) const {
  return (CopyClose(m_symbol, m_period, start_pos, count, buffer));
}

int CiClose::GetData(const datetime start_time, const int count,
                     double &buffer[]) const {
  return (CopyClose(m_symbol, m_period, start_time, count, buffer));
}

int CiClose::GetData(const datetime start_time, const datetime stop_time,
                     double &buffer[]) const {
  return (CopyClose(m_symbol, m_period, start_time, stop_time, buffer));
}

class CSpreadBuffer : public CArrayInt {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_freshed_data;
  int m_size;

public:
  CSpreadBuffer(void);
  ~CSpreadBuffer(void);

  void Size(const int size) {
    m_size = size;
  }

  int At(const int index) const;

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};

CSpreadBuffer::CSpreadBuffer(void)
    : m_symbol(""), m_period(WRONG_VALUE), m_freshed_data(0),
      m_size(DEFAULT_BUFFER_SIZE) {
  ArraySetAsSeries(m_data, true);
}

CSpreadBuffer::~CSpreadBuffer(void) {
}

int CSpreadBuffer::At(const int index) const {

  if (index >= m_data_total)
    return (0);

  return (CArrayInt::At(index));
}

bool CSpreadBuffer::Refresh(void) {
  m_freshed_data = CopySpread(m_symbol, m_period, 0, m_size, m_data);

  if (m_freshed_data > 0) {
    m_data_total = ArraySize(m_data);
    return (true);
  }

  return (false);
}

bool CSpreadBuffer::RefreshCurrent(void) {
  int array[1];

  if (CopySpread(m_symbol, m_period, 0, 1, array) == 1 && m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

void CSpreadBuffer::SetSymbolPeriod(const string symbol,
                                    const ENUM_TIMEFRAMES period) {
  m_symbol = (symbol == NULL) ? ChartSymbol() : symbol;
  m_period = (period == 0) ? ChartPeriod() : period;
}

class CiSpread : public CSeries {
public:
  CiSpread(void);
  ~CiSpread(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);
  virtual bool BufferResize(const int size);

  int GetData(const int index) const;
  int GetData(const int start_pos, const int count, int &buffer[]) const;
  int GetData(const datetime start_time, const int count, int &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              int &buffer[]) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};

CiSpread::CiSpread(void) {
  m_name = "Spread";
}

CiSpread::~CiSpread(void) {
}

bool CiSpread::Create(const string symbol, const ENUM_TIMEFRAMES period) {
  CSpreadBuffer *buff;

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  if ((buff = new CSpreadBuffer) == NULL)
    return (false);

  if (!Add(buff)) {
    delete buff;
    return (false);
  }

  buff.SetSymbolPeriod(m_symbol, m_period);

  return (true);
}

int CiSpread::GetData(const int index) const {
  CSpreadBuffer *buff = At(0);

  if (buff == NULL) {
    Print(__FUNCTION__, ": invalid buffer");
    return (0);
  }

  return (buff.At(index));
}

int CiSpread::GetData(const int start_pos, const int count,
                      int &buffer[]) const {
  return (CopySpread(m_symbol, m_period, start_pos, count, buffer));
}

int CiSpread::GetData(const datetime start_time, const int count,
                      int &buffer[]) const {
  return (CopySpread(m_symbol, m_period, start_time, count, buffer));
}

int CiSpread::GetData(const datetime start_time, const datetime stop_time,
                      int &buffer[]) const {
  return (CopySpread(m_symbol, m_period, start_time, stop_time, buffer));
}

bool CiSpread::BufferResize(const int size) {
  if (size > m_buffer_size && !CSeries::BufferResize(size))
    return (false);

  CSpreadBuffer *buff = At(0);

  if (buff == NULL)
    return (false);

  buff.Size(size);

  return (true);
}

void CiSpread::Refresh(const int flags) {
  CSpreadBuffer *buff = At(0);

  if (buff == NULL)
    return;

  if (!(flags & m_timeframe_flags)) {
    if (m_refresh_current)
      buff.RefreshCurrent();
  } else
    buff.Refresh();
}

class CTimeBuffer : public CArrayLong {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_freshed_data;
  int m_size;

public:
  CTimeBuffer(void);
  ~CTimeBuffer(void);

  void Size(const int size) {
    m_size = size;
  }

  long At(const int index) const;

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};

CTimeBuffer::CTimeBuffer(void)
    : m_symbol(""), m_period(WRONG_VALUE), m_freshed_data(0),
      m_size(DEFAULT_BUFFER_SIZE) {
  ArraySetAsSeries(m_data, true);
}

CTimeBuffer::~CTimeBuffer(void) {
}

long CTimeBuffer::At(const int index) const {

  if (index >= m_data_total)
    return (0);

  return ((datetime)CArrayLong::At(index));
}

bool CTimeBuffer::Refresh(void) {
  m_freshed_data = CopyTime(m_symbol, m_period, 0, m_size, m_data);

  if (m_freshed_data > 0) {
    m_data_total = ArraySize(m_data);
    return (true);
  }

  return (false);
}

bool CTimeBuffer::RefreshCurrent(void) {
  long array[1];

  if (CopyTime(m_symbol, m_period, 0, 1, array) == 1 && m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

void CTimeBuffer::SetSymbolPeriod(const string symbol,
                                  const ENUM_TIMEFRAMES period) {
  m_symbol = (symbol == NULL) ? ChartSymbol() : symbol;
  m_period = (period == 0) ? ChartPeriod() : period;
}

class CiTime : public CSeries {
public:
  CiTime(void);
  ~CiTime(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);
  virtual bool BufferResize(const int size);

  datetime GetData(const int index) const;
  int GetData(const int start_pos, const int count, datetime &buffer[]) const;
  int GetData(const datetime start_time, const int count,
              datetime &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              datetime &buffer[]) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};

CiTime::CiTime(void) {
  m_name = "Time";
}

CiTime::~CiTime(void) {
}

bool CiTime::Create(const string symbol, const ENUM_TIMEFRAMES period) {
  CTimeBuffer *buff;

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  if ((buff = new CTimeBuffer) == NULL)
    return (false);

  if (!Add(buff)) {
    delete buff;
    return (false);
  }

  buff.SetSymbolPeriod(m_symbol, m_period);

  return (true);
}

datetime CiTime::GetData(const int index) const {
  CTimeBuffer *buff = At(0);

  if (buff == NULL) {
    Print(__FUNCTION__, ": invalid buffer");
    return (0);
  }

  return ((datetime)buff.At(index));
}

int CiTime::GetData(const int start_pos, const int count,
                    datetime &buffer[]) const {
  return (CopyTime(m_symbol, m_period, start_pos, count, buffer));
}

int CiTime::GetData(const datetime start_time, const int count,
                    datetime &buffer[]) const {
  return (CopyTime(m_symbol, m_period, start_time, count, buffer));
}

int CiTime::GetData(const datetime start_time, const datetime stop_time,
                    datetime &buffer[]) const {
  return (CopyTime(m_symbol, m_period, start_time, stop_time, buffer));
}

bool CiTime::BufferResize(const int size) {
  if (size > m_buffer_size && !CSeries::BufferResize(size))
    return (false);

  CTimeBuffer *buff = At(0);

  if (buff == NULL)
    return (false);

  buff.Size(size);

  return (true);
}

void CiTime::Refresh(const int flags) {
  CTimeBuffer *buff = At(0);

  if (buff == NULL)
    return;

  if (!(flags & m_timeframe_flags)) {
    if (m_refresh_current)
      buff.RefreshCurrent();
  } else
    buff.Refresh();
}

class CTickVolumeBuffer : public CArrayLong {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_freshed_data;
  int m_size;

public:
  CTickVolumeBuffer(void);
  ~CTickVolumeBuffer(void);

  void Size(const int size) {
    m_size = size;
  }

  long At(const int index) const;

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};

CTickVolumeBuffer::CTickVolumeBuffer(void)
    : m_symbol(""), m_period(WRONG_VALUE), m_freshed_data(0),
      m_size(DEFAULT_BUFFER_SIZE) {
  ArraySetAsSeries(m_data, true);
}

CTickVolumeBuffer::~CTickVolumeBuffer(void) {
}

long CTickVolumeBuffer::At(const int index) const {

  if (index >= m_data_total)
    return (0);

  return ((datetime)CArrayLong::At(index));
}

bool CTickVolumeBuffer::Refresh(void) {
  m_freshed_data = CopyTickVolume(m_symbol, m_period, 0, m_size, m_data);

  if (m_freshed_data > 0) {
    m_data_total = ArraySize(m_data);
    return (true);
  }

  return (false);
}

bool CTickVolumeBuffer::RefreshCurrent(void) {
  long array[1];

  if (CopyTickVolume(m_symbol, m_period, 0, 1, array) == 1 &&
      m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

void CTickVolumeBuffer::SetSymbolPeriod(const string symbol,
                                        const ENUM_TIMEFRAMES period) {
  m_symbol = (symbol == NULL) ? ChartSymbol() : symbol;
  m_period = (period == 0) ? ChartPeriod() : period;
}

class CiTickVolume : public CSeries {
public:
  CiTickVolume(void);
  ~CiTickVolume(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);
  virtual bool BufferResize(const int size);

  long GetData(const int index) const;
  int GetData(const int start_pos, const int count, long &buffer[]) const;
  int GetData(const datetime start_time, const int count, long &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              long &buffer[]) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};

CiTickVolume::CiTickVolume(void) {
  m_name = "Volume";
}

CiTickVolume::~CiTickVolume(void) {
}

bool CiTickVolume::Create(const string symbol, const ENUM_TIMEFRAMES period) {
  CTickVolumeBuffer *buff;

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  if ((buff = new CTickVolumeBuffer) == NULL)
    return (false);

  if (!Add(buff)) {
    delete buff;
    return (false);
  }

  buff.SetSymbolPeriod(m_symbol, m_period);

  return (true);
}

long CiTickVolume::GetData(const int index) const {
  CTickVolumeBuffer *buff = At(0);

  if (buff == NULL) {
    Print(__FUNCTION__, ": invalid buffer");
    return (0);
  }

  return (buff.At(index));
}

int CiTickVolume::GetData(const int start_pos, const int count,
                          long &buffer[]) const {
  return (CopyTickVolume(m_symbol, m_period, start_pos, count, buffer));
}

int CiTickVolume::GetData(const datetime start_time, const int count,
                          long &buffer[]) const {
  return (CopyTickVolume(m_symbol, m_period, start_time, count, buffer));
}

int CiTickVolume::GetData(const datetime start_time, const datetime stop_time,
                          long &buffer[]) const {
  return (CopyTickVolume(m_symbol, m_period, start_time, stop_time, buffer));
}

bool CiTickVolume::BufferResize(const int size) {
  if (size > m_buffer_size && !CSeries::BufferResize(size))
    return (false);

  CTickVolumeBuffer *buff = At(0);

  if (buff == NULL)
    return (false);

  buff.Size(size);

  return (true);
}

void CiTickVolume::Refresh(const int flags) {
  CTickVolumeBuffer *buff = At(0);

  if (buff == NULL)
    return;

  if (!(flags & m_timeframe_flags)) {
    if (m_refresh_current)
      buff.RefreshCurrent();
  } else
    buff.Refresh();
}

class CRealVolumeBuffer : public CArrayLong {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_freshed_data;
  int m_size;

public:
  CRealVolumeBuffer(void);
  ~CRealVolumeBuffer(void);

  void Size(const int size) {
    m_size = size;
  }

  long At(const int index) const;

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};

CRealVolumeBuffer::CRealVolumeBuffer(void)
    : m_symbol(""), m_period(WRONG_VALUE), m_freshed_data(0),
      m_size(DEFAULT_BUFFER_SIZE) {
  ArraySetAsSeries(m_data, true);
}

CRealVolumeBuffer::~CRealVolumeBuffer(void) {
}

long CRealVolumeBuffer::At(const int index) const {

  if (index >= m_data_total)
    return (0);

  return ((datetime)CArrayLong::At(index));
}

bool CRealVolumeBuffer::Refresh(void) {
  m_freshed_data = CopyRealVolume(m_symbol, m_period, 0, m_size, m_data);

  if (m_freshed_data > 0) {
    m_data_total = ArraySize(m_data);
    return (true);
  }

  return (false);
}

bool CRealVolumeBuffer::RefreshCurrent(void) {
  long array[1];

  if (CopyRealVolume(m_symbol, m_period, 0, 1, array) == 1 &&
      m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

void CRealVolumeBuffer::SetSymbolPeriod(const string symbol,
                                        const ENUM_TIMEFRAMES period) {
  m_symbol = (symbol == NULL) ? ChartSymbol() : symbol;
  m_period = (period == 0) ? ChartPeriod() : period;
}

class CiRealVolume : public CSeries {
public:
  CiRealVolume(void);
  ~CiRealVolume(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);
  virtual bool BufferResize(const int size);

  long GetData(const int index) const;
  int GetData(const int start_pos, const int count, long &buffer[]) const;
  int GetData(const datetime start_time, const int count, long &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              long &buffer[]) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};

CiRealVolume::CiRealVolume(void) {
  m_name = "RealVolume";
}

CiRealVolume::~CiRealVolume(void) {
}

bool CiRealVolume::Create(const string symbol, const ENUM_TIMEFRAMES period) {
  CRealVolumeBuffer *buff;

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  if ((buff = new CRealVolumeBuffer) == NULL)
    return (false);

  if (!Add(buff)) {
    delete buff;
    return (false);
  }

  buff.SetSymbolPeriod(m_symbol, m_period);

  return (true);
}

long CiRealVolume::GetData(const int index) const {
  CRealVolumeBuffer *buff = At(0);

  if (buff == NULL) {
    Print(__FUNCTION__, ": invalid buffer");
    return (0);
  }

  return (buff.At(index));
}

int CiRealVolume::GetData(const int start_pos, const int count,
                          long &buffer[]) const {
  return (CopyRealVolume(m_symbol, m_period, start_pos, count, buffer));
}

int CiRealVolume::GetData(const datetime start_time, const int count,
                          long &buffer[]) const {
  return (CopyRealVolume(m_symbol, m_period, start_time, count, buffer));
}

int CiRealVolume::GetData(const datetime start_time, const datetime stop_time,
                          long &buffer[]) const {
  return (CopyRealVolume(m_symbol, m_period, start_time, stop_time, buffer));
}

bool CiRealVolume::BufferResize(const int size) {
  if (size > m_buffer_size && !CSeries::BufferResize(size))
    return (false);

  CRealVolumeBuffer *buff = At(0);

  if (buff == NULL)
    return (false);

  buff.Size(size);

  return (true);
}

void CiRealVolume::Refresh(const int flags) {
  CRealVolumeBuffer *buff = At(0);

  if (buff == NULL)
    return;

  if (!(flags & m_timeframe_flags)) {
    if (m_refresh_current)
      buff.RefreshCurrent();
  } else
    buff.Refresh();
}

#endif
