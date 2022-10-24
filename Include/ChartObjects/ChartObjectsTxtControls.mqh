#ifndef CHART_OBJECTS_TXT_CONTROLS_H
#define CHART_OBJECTS_TXT_CONTROLS_H

#include "ChartObject.mqh"

class CChartObjectText : public CChartObject {
public:
  CChartObjectText(void);
  ~CChartObjectText(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  double Angle(void) const;
  bool Angle(const double angle) const;
  string Font(void) const;
  bool Font(const string font) const;
  int FontSize(void) const;
  bool FontSize(const int size) const;
  ENUM_ANCHOR_POINT Anchor(void) const;
  bool Anchor(const ENUM_ANCHOR_POINT anchor) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};














class CChartObjectLabel : public CChartObjectText {
public:
  CChartObjectLabel(void);
  ~CChartObjectLabel(void);

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y);

  virtual int Type(void) const ;

  int X_Distance(void) const;
  bool X_Distance(const int X) const;
  int Y_Distance(void) const;
  bool Y_Distance(const int Y) const;
  int X_Size(void) const;
  int Y_Size(void) const;

  ENUM_BASE_CORNER Corner(void) const;
  bool Corner(const ENUM_BASE_CORNER corner) const;

  datetime Time(const int point) const ;
  bool Time(const int point, const datetime time) const ;
  double Price(const int point) const ;
  bool Price(const int point, const double price) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};














class CChartObjectEdit : public CChartObjectLabel {
public:
  CChartObjectEdit(void);
  ~CChartObjectEdit(void);

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y, const int sizeX, const int sizeY);

  virtual int Type(void) const override ;

  bool X_Size(const int X) const;
  int X_Size(void) const ;
  bool Y_Size(const int Y) const;
  int Y_Size(void) const ;
  color BackColor(void) const;
  bool BackColor(const color new_color) const;
  color BorderColor(void) const;
  bool BorderColor(const color new_color) const;
  bool ReadOnly(void) const;
  bool ReadOnly(const bool flag) const;
  ENUM_ALIGN_MODE TextAlign(void) const;
  bool TextAlign(const ENUM_ALIGN_MODE align) const;

  bool Angle(const double angle) const ;
  double Angle(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};
















class CChartObjectButton : public CChartObjectEdit {
public:
  CChartObjectButton(void);
  ~CChartObjectButton(void);

  virtual int Type(void) const override ;

  bool State(void) const;
  bool State(const bool state) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};







class CChartObjectRectLabel : public CChartObjectLabel {
public:
  CChartObjectRectLabel(void);
  ~CChartObjectRectLabel(void);

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y, const int sizeX, const int sizeY);

  virtual int Type(void) const ;

  bool X_Size(const int X) const;
  int X_Size(void) const ;
  bool Y_Size(const int Y) const;
  int Y_Size(void) const ;
  color BackColor(void) const;
  bool BackColor(const color new_color) const;
  ENUM_BORDER_TYPE BorderType(void) const;
  bool BorderType(const ENUM_BORDER_TYPE flag) const;

  bool Angle(const double angle) const ;
  double Angle(void) const ;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};












#endif
