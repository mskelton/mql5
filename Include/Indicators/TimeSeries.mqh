#ifndef TIME_SERIES_H
#define TIME_SERIES_H

#include "Series.mqh"
#include <Arrays/ArrayInt.mqh>
#include <Arrays/ArrayLong.mqh>

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










class COpenBuffer : public CDoubleBuffer {
public:
  COpenBuffer(void);
  ~COpenBuffer(void);

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);
};





class CiOpen : public CPriceSeries {
public:
  CiOpen(void);
  ~CiOpen(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double GetData(const int index) const ;
  int GetData(const int start_pos, const int count, double buffer[]) const;
  int GetData(const datetime start_time, const int count,
              double buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              double buffer[]) const;
};







class CHighBuffer : public CDoubleBuffer {
public:
  CHighBuffer(void);
  ~CHighBuffer(void);

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);
};





class CiHigh : public CPriceSeries {
public:
  CiHigh(void);
  ~CiHigh(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double GetData(const int index) const ;
  int GetData(const int start_pos, const int count, double buffer[]) const;
  int GetData(const datetime start_time, const int count,
              double buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              double buffer[]) const;
};







class CLowBuffer : public CDoubleBuffer {
public:
  CLowBuffer(void);
  ~CLowBuffer(void);

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);
};





class CiLow : public CPriceSeries {
public:
  CiLow(void);
  ~CiLow(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double GetData(const int index) const ;
  int GetData(const int start_pos, const int count, double buffer[]) const;
  int GetData(const datetime start_time, const int count,
              double buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              double buffer[]) const;
};







class CCloseBuffer : public CDoubleBuffer {
public:
  CCloseBuffer(void);
  ~CCloseBuffer(void);

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);
};





class CiClose : public CPriceSeries {
public:
  CiClose(void);
  ~CiClose(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);

  double GetData(const int index) const ;
  int GetData(const int start_pos, const int count, double buffer[]) const;
  int GetData(const datetime start_time, const int count,
              double buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              double buffer[]) const;
};







class CSpreadBuffer : public CArrayInt {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_freshed_data;
  int m_size;

public:
  CSpreadBuffer(void);
  ~CSpreadBuffer(void);

  void Size(const int size) ;

  int At(const int index) const;

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};







class CiSpread : public CSeries {
public:
  CiSpread(void);
  ~CiSpread(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);
  virtual bool BufferResize(const int size);

  int GetData(const int index) const;
  int GetData(const int start_pos, const int count, int buffer[]) const;
  int GetData(const datetime start_time, const int count, int buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              int buffer[]) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};










class CTimeBuffer : public CArrayLong {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_freshed_data;
  int m_size;

public:
  CTimeBuffer(void);
  ~CTimeBuffer(void);

  void Size(const int size) ;

  long At(const int index) const;

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};







class CiTime : public CSeries {
public:
  CiTime(void);
  ~CiTime(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);
  virtual bool BufferResize(const int size);

  datetime GetData(const int index) const;
  int GetData(const int start_pos, const int count, datetime buffer[]) const;
  int GetData(const datetime start_time, const int count,
              datetime buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              datetime buffer[]) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};










class CTickVolumeBuffer : public CArrayLong {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_freshed_data;
  int m_size;

public:
  CTickVolumeBuffer(void);
  ~CTickVolumeBuffer(void);

  void Size(const int size) ;

  long At(const int index) const;

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};







class CiTickVolume : public CSeries {
public:
  CiTickVolume(void);
  ~CiTickVolume(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);
  virtual bool BufferResize(const int size);

  long GetData(const int index) const;
  int GetData(const int start_pos, const int count, long buffer[]) const;
  int GetData(const datetime start_time, const int count, long buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              long buffer[]) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};










class CRealVolumeBuffer : public CArrayLong {
protected:
  string m_symbol;
  ENUM_TIMEFRAMES m_period;
  int m_freshed_data;
  int m_size;

public:
  CRealVolumeBuffer(void);
  ~CRealVolumeBuffer(void);

  void Size(const int size) ;

  long At(const int index) const;

  virtual bool Refresh(void);
  virtual bool RefreshCurrent(void);

  void SetSymbolPeriod(const string symbol, const ENUM_TIMEFRAMES period);
};







class CiRealVolume : public CSeries {
public:
  CiRealVolume(void);
  ~CiRealVolume(void);

  bool Create(const string symbol, const ENUM_TIMEFRAMES period);
  virtual bool BufferResize(const int size);

  long GetData(const int index) const;
  int GetData(const int start_pos, const int count, long buffer[]) const;
  int GetData(const datetime start_time, const int count, long buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              long buffer[]) const;

  virtual void Refresh(const int flags = OBJ_ALL_PERIODS);
};










#endif
