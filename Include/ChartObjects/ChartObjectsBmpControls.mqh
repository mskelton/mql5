#ifndef CHART_OBJECTS_BMP_CONTROLS_H
#define CHART_OBJECTS_BMP_CONTROLS_H

#include "ChartObject.mqh"

class CChartObjectBitmap : public CChartObject {
public:
  CChartObjectBitmap(void);
  ~CChartObjectBitmap(void);

  string BmpFile(void) const;
  bool BmpFile(const string name) const;
  int X_Offset(void) const;
  bool X_Offset(const int X) const;
  int Y_Offset(void) const;
  bool Y_Offset(const int Y) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

class CChartObjectBmpLabel : public CChartObject {
public:
  CChartObjectBmpLabel(void);
  ~CChartObjectBmpLabel(void);

  int X_Distance(void) const;
  bool X_Distance(const int X) const;
  int Y_Distance(void) const;
  bool Y_Distance(const int Y) const;
  int X_Size(void) const;
  int Y_Size(void) const;
  ENUM_BASE_CORNER Corner(void) const;
  bool Corner(const ENUM_BASE_CORNER corner) const;
  string BmpFileOn(void) const;
  bool BmpFileOn(const string name) const;
  string BmpFileOff(void) const;
  bool BmpFileOff(const string name) const;
  bool State(void) const;
  bool State(const bool state) const;
  int X_Offset(void) const;
  bool X_Offset(const int X) const;
  int Y_Offset(void) const;
  bool Y_Offset(const int Y) const;

  bool Time(const datetime time) const;
  bool Price(const double price) const;

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y);

  virtual int Type(void) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

#endif
