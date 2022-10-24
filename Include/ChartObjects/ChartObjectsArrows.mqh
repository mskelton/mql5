#ifndef CHART_OBJECTS_ARROWS_H
#define CHART_OBJECTS_ARROWS_H

#include "ChartObject.mqh"

class CChartObjectArrow : public CChartObject {
public:
  CChartObjectArrow(void);
  ~CChartObjectArrow(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price, const char code);

  virtual int Type(void) const ;

  char ArrowCode(void) const;
  virtual bool ArrowCode(const char code) const;
  ENUM_ARROW_ANCHOR Anchor(void) const;
  virtual bool Anchor(const ENUM_ARROW_ANCHOR anchor) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};










class CChartObjectArrowThumbUp : public CChartObjectArrow {
public:
  CChartObjectArrowThumbUp(void);
  ~CChartObjectArrowThumbUp(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  virtual bool ArrowCode(const char code) const override ;
  char ArrowCode(void) const ;
};




class CChartObjectArrowThumbDown : public CChartObjectArrow {
public:
  CChartObjectArrowThumbDown(void);
  ~CChartObjectArrowThumbDown(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  virtual bool ArrowCode(const char code) const override ;
  char ArrowCode(void) const ;
};




class CChartObjectArrowUp : public CChartObjectArrow {
public:
  CChartObjectArrowUp(void);
  ~CChartObjectArrowUp(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  virtual bool ArrowCode(const char code) const override ;
  char ArrowCode(void) const ;
};




class CChartObjectArrowDown : public CChartObjectArrow {
public:
  CChartObjectArrowDown(void);
  ~CChartObjectArrowDown(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  virtual bool ArrowCode(const char code) const override ;
  char ArrowCode(void) const ;
};




class CChartObjectArrowStop : public CChartObjectArrow {
public:
  CChartObjectArrowStop(void);
  ~CChartObjectArrowStop(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  virtual bool ArrowCode(const char code) const override ;
  char ArrowCode(void) const ;
};




class CChartObjectArrowCheck : public CChartObjectArrow {
public:
  CChartObjectArrowCheck(void);
  ~CChartObjectArrowCheck(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  virtual bool ArrowCode(const char code) const override ;
  char ArrowCode(void) const ;
};




class CChartObjectArrowLeftPrice : public CChartObjectArrow {
public:
  CChartObjectArrowLeftPrice(void);
  ~CChartObjectArrowLeftPrice(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  virtual bool ArrowCode(const char code) const override ;
  char ArrowCode(void) const ;
  virtual bool Anchor(const ENUM_ARROW_ANCHOR anchor) const override ;
  ENUM_ARROW_ANCHOR Anchor(void) const ;
};




class CChartObjectArrowRightPrice : public CChartObjectArrow {
public:
  CChartObjectArrowRightPrice(void);
  ~CChartObjectArrowRightPrice(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override ;

  virtual bool ArrowCode(const char code) const override ;
  char ArrowCode(void) const ;
  virtual bool Anchor(const ENUM_ARROW_ANCHOR anchor) const override ;
  ENUM_ARROW_ANCHOR Anchor(void) const ;
};




#endif
