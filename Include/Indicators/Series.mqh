#ifndef SERIES_H
#define SERIES_H

#include <Arrays/ArrayDouble.mqh>
#include <Arrays/ArrayObj.mqh>

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

  string Name(void) const ;
  int BuffersTotal(void) const ;
  int BufferSize(void) const ;
  int Timeframe(void) const ;
  string Symbol(void) const ;
  ENUM_TIMEFRAMES Period(void) const ;
  string PeriodDescription(const int val = 0);
  void RefreshCurrent(const bool flag) ;

  virtual bool BufferResize(const int size);

  virtual void Refresh(const int flags) ;

protected:
  bool SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
  void PeriodToTimeframeFlag(const ENUM_TIMEFRAMES period);

  bool CheckLoadHistory(const int size);
  bool CheckTerminalHistory(const int size);
  bool CheckServerHistory(const int size);
};










class CDoubleBuffer : public CArrayDouble {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_size;

public:
  CDoubleBuffer(void);
  ~CDoubleBuffer(void);

  void Size(const int size) ;

  double At(const int index) const;

  virtual bool Refresh(void) ;
  virtual bool RefreshCurrent(void) ;

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};





#endif
