#ifndef INDICATOR_H
#define INDICATOR_H

#include "Series.mqh"

class CIndicatorBuffer : public CDoubleBuffer {
protected:
  int m_offset;
  string m_name;

public:
  CIndicatorBuffer(void);
  ~CIndicatorBuffer(void);

  int Offset(void) const {
    return (m_offset);
  }
  void Offset(const int offset) {
    m_offset = offset;
  }
  string Name(void) const {
    return (m_name);
  }
  void Name(const string name) {
    m_name = name;
  }

  double At(const int index) const;

  bool Refresh(const int handle, const int num);
  bool RefreshCurrent(const int handle, const int num);

private:
  virtual bool Refresh(void) {
    return (CDoubleBuffer::Refresh());
  }
  virtual bool RefreshCurrent(void) {
    return (CDoubleBuffer::RefreshCurrent());
  }
};

CIndicatorBuffer::CIndicatorBuffer(void) : m_offset(0), m_name("") {}

CIndicatorBuffer::~CIndicatorBuffer(void) {}

double CIndicatorBuffer::At(const int index) const {
  return (CDoubleBuffer::At(index + m_offset));
}

bool CIndicatorBuffer::Refresh(const int handle, const int num) {

  if (handle == INVALID_HANDLE) {
    SetUserError(ERR_USER_INVALID_HANDLE);
    return (false);
  }

  m_data_total = CopyBuffer(handle, num, -m_offset, m_size, m_data);

  return (m_data_total > 0);
}

bool CIndicatorBuffer::RefreshCurrent(const int handle, const int num) {
  double array[1];

  if (handle == INVALID_HANDLE) {
    SetUserError(ERR_USER_INVALID_HANDLE);
    return (false);
  }

  if (CopyBuffer(handle, num, -m_offset, 1, array) > 0 && m_data_total > 0) {
    m_data[0] = array[0];
    return (true);
  }

  return (false);
}

class CIndicator : public CSeries {
protected:
  int m_handle;
  string m_status;
  bool m_full_release;
  bool m_redrawer;

public:
  CIndicator(void);
  ~CIndicator(void);

  int Handle(void) const {
    return (m_handle);
  }
  string Status(void) const {
    return (m_status);
  }
  void FullRelease(const bool flag = true) {
    m_full_release = flag;
  }
  void Redrawer(const bool flag = true) {
    m_redrawer = flag;
  }

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_INDICATOR type, const int num_params,
              const MqlParam &params[]);
  virtual bool BufferResize(const int size);

  int BarsCalculated(void) const;
  double GetData(const int buffer_num, const int index) const;
  int GetData(const int start_pos, const int count, const int buffer_num,
              double &buffer[]) const;
  int GetData(const datetime start_time, const int count, const int buffer_num,
              double &buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              const int buffer_num, double &buffer[]) const;

  int Minimum(const int buffer_num, const int start, const int count) const;
  double MinValue(const int buffer_num, const int start, const int count,
                  int &index) const;
  int Maximum(const int buffer_num, const int start, const int count) const;
  double MaxValue(const int buffer_num, const int start, const int count,
                  int &index) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);

  bool AddToChart(const long chart, const int subwin);
  bool DeleteFromChart(const long chart, const int subwin);

  static string MethodDescription(const int val);
  static string PriceDescription(const int val);
  static string VolumeDescription(const int val);

protected:
  bool CreateBuffers(const string symbol, const ENUM_TIMEFRAMES period,
                     const int buffers);
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]) {
    return (false);
  }
};

void CIndicator::CIndicator(void)
    : m_handle(INVALID_HANDLE), m_status(""), m_full_release(false),
      m_redrawer(false) {}

void CIndicator::~CIndicator(void) {

  if (m_full_release && m_handle != INVALID_HANDLE) {
    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
  }
}

bool CIndicator::Create(const string symbol, const ENUM_TIMEFRAMES period,
                        const ENUM_INDICATOR type, const int num_params,
                        const MqlParam &params[]) {

  if (!SetSymbolPeriod(symbol, period))
    return (false);

  m_handle = IndicatorCreate(symbol, period, type, num_params, params);

  if (m_handle == INVALID_HANDLE)
    return (false);

  if (!Initialize(symbol, period, num_params, params)) {

    IndicatorRelease(m_handle);
    m_handle = INVALID_HANDLE;
    return (false);
  }

  return (true);
}

int CIndicator::BarsCalculated(void) const {
  if (m_handle == INVALID_HANDLE)
    return (-1);

  return (::BarsCalculated(m_handle));
}

double CIndicator::GetData(const int buffer_num, const int index) const {
  CIndicatorBuffer *buffer = At(buffer_num);

  if (buffer == NULL) {
    Print(__FUNCTION__, ": invalid buffer");
    return (EMPTY_VALUE);
  }

  return (buffer.At(index));
}

int CIndicator::GetData(const int start_pos, const int count,
                        const int buffer_num, double &buffer[]) const {

  if (m_handle == INVALID_HANDLE) {
    SetUserError(ERR_USER_INVALID_HANDLE);
    return (-1);
  }
  if (buffer_num >= m_buffers_total) {
    SetUserError(ERR_USER_INVALID_BUFF_NUM);
    return (-1);
  }

  return (CopyBuffer(m_handle, buffer_num, start_pos, count, buffer));
}

int CIndicator::GetData(const datetime start_time, const int count,
                        const int buffer_num, double &buffer[]) const {

  if (m_handle == INVALID_HANDLE) {
    SetUserError(ERR_USER_INVALID_HANDLE);
    return (-1);
  }
  if (buffer_num >= m_buffers_total) {
    SetUserError(ERR_USER_INVALID_BUFF_NUM);
    return (-1);
  }

  return (CopyBuffer(m_handle, buffer_num, start_time, count, buffer));
}

int CIndicator::GetData(const datetime start_time, const datetime stop_time,
                        const int buffer_num, double &buffer[]) const {

  if (m_handle == INVALID_HANDLE) {
    SetUserError(ERR_USER_INVALID_HANDLE);
    return (-1);
  }
  if (buffer_num >= m_buffers_total) {
    SetUserError(ERR_USER_INVALID_BUFF_NUM);
    return (-1);
  }

  return (CopyBuffer(m_handle, buffer_num, start_time, stop_time, buffer));
}

int CIndicator::Minimum(const int buffer_num, const int start,
                        const int count) const {

  if (m_handle == INVALID_HANDLE) {
    SetUserError(ERR_USER_INVALID_HANDLE);
    return (-1);
  }
  if (buffer_num >= m_buffers_total) {
    SetUserError(ERR_USER_INVALID_BUFF_NUM);
    return (-1);
  }

  CIndicatorBuffer *buffer = At(buffer_num);
  if (buffer == NULL)
    return (-1);

  return (buffer.Minimum(start, count));
}

double CIndicator::MinValue(const int buffer_num, const int start,
                            const int count, int &index) const {
  int idx = Minimum(buffer_num, start, count);
  double res = EMPTY_VALUE;

  if (idx != -1) {
    CIndicatorBuffer *buffer = At(buffer_num);
    res = buffer.At(idx);
    index = idx;
  }

  return (res);
}

int CIndicator::Maximum(const int buffer_num, const int start,
                        const int count) const {

  if (m_handle == INVALID_HANDLE) {
    SetUserError(ERR_USER_INVALID_HANDLE);
    return (-1);
  }
  if (buffer_num >= m_buffers_total) {
    SetUserError(ERR_USER_INVALID_BUFF_NUM);
    return (-1);
  }

  CIndicatorBuffer *buffer = At(buffer_num);
  if (buffer == NULL)
    return (-1);

  return (buffer.Maximum(start, count));
}

double CIndicator::MaxValue(const int buffer_num, const int start,
                            const int count, int &index) const {
  int idx = Maximum(buffer_num, start, count);
  double res = EMPTY_VALUE;

  if (idx != -1) {
    CIndicatorBuffer *buffer = At(buffer_num);
    res = buffer.At(idx);
    index = idx;
  }

  return (res);
}

bool CIndicator::CreateBuffers(const string symbol,
                               const ENUM_TIMEFRAMES period,
                               const int buffers) {
  bool result = true;

  if (m_handle == INVALID_HANDLE) {
    SetUserError(ERR_USER_INVALID_HANDLE);
    return (false);
  }
  if (buffers == 0)
    return (false);
  if (!Reserve(buffers))
    return (false);

  for (int i = 0; i < buffers; i++)
    result &= Add(new CIndicatorBuffer);

  if (result)
    m_buffers_total = buffers;

  return (result);
}

bool CIndicator::BufferResize(const int size) {
  if (size > m_buffer_size && !CSeries::BufferResize(size))
    return (false);

  int total = Total();
  for (int i = 0; i < total; i++) {
    CIndicatorBuffer *buff = At(i);

    if (buff == NULL)
      return (false);
    buff.Size(size);
  }

  return (true);
}

void CIndicator::Refresh(const int flags) {
  int i;
  CIndicatorBuffer *buff;

  for (i = 0; i < Total(); i++) {
    buff = At(i);
    if (m_redrawer) {
      buff.Refresh(m_handle, i);
      continue;
    }
    if (!(flags & m_timeframe_flags)) {
      if (m_refresh_current)
        buff.RefreshCurrent(m_handle, i);
    } else
      buff.Refresh(m_handle, i);
  }
}

bool CIndicator::AddToChart(const long chart, const int subwin) {
  if (ChartIndicatorAdd(chart, subwin, m_handle)) {
    m_name = ChartIndicatorName(chart, subwin,
                                ChartIndicatorsTotal(chart, subwin) - 1);
    return (true);
  }

  return (false);
}

bool CIndicator::DeleteFromChart(const long chart, const int subwin) {
  return (ChartIndicatorDelete(chart, subwin, m_name));
}

string CIndicator::MethodDescription(const int val) {

  switch (val) {
  case ENUM_MA_METHOD::MODE_SMA:
    return ("SMA");
  case ENUM_MA_METHOD::MODE_EMA:
    return ("EMA");
  case ENUM_MA_METHOD::MODE_SMMA:
    return ("SMMA");
  case ENUM_MA_METHOD::MODE_LWMA:
    return ("LWMA");
  }

  return ("MethodUnknown=" + IntegerToString(val));
}

string CIndicator::PriceDescription(const int val) {

  switch (val) {
  case ENUM_APPLIED_PRICE::PRICE_CLOSE:
    return ("Close");
  case ENUM_APPLIED_PRICE::PRICE_OPEN:
    return ("Open");
  case ENUM_APPLIED_PRICE::PRICE_HIGH:
    return ("High");
  case ENUM_APPLIED_PRICE::PRICE_LOW:
    return ("Low");
  case ENUM_APPLIED_PRICE::PRICE_MEDIAN:
    return ("Median");
  case ENUM_APPLIED_PRICE::PRICE_TYPICAL:
    return ("Typical");
  case ENUM_APPLIED_PRICE::PRICE_WEIGHTED:
    return ("Weighted");
  default:

    if (val >= 10)
      return ("AppliedHandle=" + IntegerToString(val));

    break;
  }

  return ("PriceUnknown=" + IntegerToString(val));
}

string CIndicator::VolumeDescription(const int val) {

  switch (val) {
  case ENUM_APPLIED_VOLUME::VOLUME_TICK:
    return ("Tick");
  case ENUM_APPLIED_VOLUME::VOLUME_REAL:
    return ("Real");
  }

  return ("VolumeUnknown=" + IntegerToString(val));
}

#endif
