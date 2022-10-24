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

  int Offset(void) const ;
  void Offset(const int offset) ;
  string Name(void) const ;
  void Name(const string name) ;

  double At(const int index) const;

  bool Refresh(const int handle, const int num);
  bool RefreshCurrent(const int handle, const int num);

private:
  virtual bool Refresh(void) ;
  virtual bool RefreshCurrent(void) ;
};






class CIndicator : public CSeries {
protected:
  int m_handle;
  string m_status;
  bool m_full_release;
  bool m_redrawer;

public:
  CIndicator(void);
  ~CIndicator(void);

  int Handle(void) const ;
  string Status(void) const ;
  void FullRelease(const bool flag = true) ;
  void Redrawer(const bool flag = true) ;

  bool Create(const string symbol, const ENUM_TIMEFRAMES period,
              const ENUM_INDICATOR type, const int num_params,
              const MqlParam params[]);
  virtual bool BufferResize(const int size);

  int BarsCalculated(void) const;
  double GetData(const int buffer_num, const int index) const;
  int GetData(const int start_pos, const int count, const int buffer_num,
              double buffer[]) const;
  int GetData(const datetime start_time, const int count, const int buffer_num,
              double buffer[]) const;
  int GetData(const datetime start_time, const datetime stop_time,
              const int buffer_num, double buffer[]) const;

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
                          const int num_params, const MqlParam params[]) ;
};





















#endif
