#ifndef CHART_OBJECTS_ARROWS_H
#define CHART_OBJECTS_ARROWS_H

#include "ChartObject.mqh"

class CChartObjectArrow : public CChartObject {
public:
  CChartObjectArrow(void);
  ~CChartObjectArrow(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price, const char code);

  virtual int Type(void) const {
    return (OBJ_ARROW);
  }

  char ArrowCode(void) const;
  virtual bool ArrowCode(const char code) const;
  ENUM_ARROW_ANCHOR Anchor(void) const;
  virtual bool Anchor(const ENUM_ARROW_ANCHOR anchor) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectArrow::CChartObjectArrow(void) {}

CChartObjectArrow::~CChartObjectArrow(void) {}

bool CChartObjectArrow::Create(long chart_id, const string name,
                               const int window, const datetime time,
                               const double price, const char code) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);
  if (!ArrowCode(code))
    return (false);

  return (true);
}

char CChartObjectArrow::ArrowCode(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((char)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ARROWCODE));
}

bool CChartObjectArrow::ArrowCode(const char code) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_ARROWCODE, code));
}

ENUM_ARROW_ANCHOR CChartObjectArrow::Anchor(void) const {

  return (
      (ENUM_ARROW_ANCHOR)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ANCHOR));
}

bool CChartObjectArrow::Anchor(const ENUM_ARROW_ANCHOR anchor) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_ANCHOR, anchor));
}

bool CChartObjectArrow::Save(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CObject::Save(file_handle))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ARROWCODE),
          CHAR_VALUE) != sizeof(char))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ANCHOR),
          INT_VALUE) != sizeof(int))
    return (false);

  return (true);
}

bool CChartObjectArrow::Load(const int file_handle) {

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CObject::Load(file_handle))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_ARROWCODE,
                        FileReadInteger(file_handle, CHAR_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_ANCHOR,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  return (true);
}

class CChartObjectArrowThumbUp : public CChartObjectArrow {
public:
  CChartObjectArrowThumbUp(void);
  ~CChartObjectArrowThumbUp(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_ARROW_THUMB_UP);
  }

  virtual bool ArrowCode(const char code) const override {
    return (false);
  }
  char ArrowCode(void) const {
    return (CChartObjectArrow::ArrowCode());
  }
};

CChartObjectArrowThumbUp::CChartObjectArrowThumbUp(void) {}

CChartObjectArrowThumbUp::~CChartObjectArrowThumbUp(void) {}

bool CChartObjectArrowThumbUp::Create(long chart_id, const string name,
                                      const int window, const datetime time,
                                      const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW_THUMB_UP, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectArrowThumbDown : public CChartObjectArrow {
public:
  CChartObjectArrowThumbDown(void);
  ~CChartObjectArrowThumbDown(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_ARROW_THUMB_DOWN);
  }

  virtual bool ArrowCode(const char code) const override {
    return (false);
  }
  char ArrowCode(void) const {
    return (CChartObjectArrow::ArrowCode());
  }
};

CChartObjectArrowThumbDown::CChartObjectArrowThumbDown(void) {}

CChartObjectArrowThumbDown::~CChartObjectArrowThumbDown(void) {}

bool CChartObjectArrowThumbDown::Create(long chart_id, const string name,
                                        const int window, const datetime time,
                                        const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW_THUMB_DOWN, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectArrowUp : public CChartObjectArrow {
public:
  CChartObjectArrowUp(void);
  ~CChartObjectArrowUp(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_ARROW_UP);
  }

  virtual bool ArrowCode(const char code) const override {
    return (false);
  }
  char ArrowCode(void) const {
    return (CChartObjectArrow::ArrowCode());
  }
};

CChartObjectArrowUp::CChartObjectArrowUp(void) {}

CChartObjectArrowUp::~CChartObjectArrowUp(void) {}

bool CChartObjectArrowUp::Create(long chart_id, const string name,
                                 const int window, const datetime time,
                                 const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW_UP, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectArrowDown : public CChartObjectArrow {
public:
  CChartObjectArrowDown(void);
  ~CChartObjectArrowDown(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_ARROW_DOWN);
  }

  virtual bool ArrowCode(const char code) const override {
    return (false);
  }
  char ArrowCode(void) const {
    return (CChartObjectArrow::ArrowCode());
  }
};

CChartObjectArrowDown::CChartObjectArrowDown(void) {}

CChartObjectArrowDown::~CChartObjectArrowDown(void) {}

bool CChartObjectArrowDown::Create(long chart_id, const string name,
                                   const int window, const datetime time,
                                   const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW_DOWN, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectArrowStop : public CChartObjectArrow {
public:
  CChartObjectArrowStop(void);
  ~CChartObjectArrowStop(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_ARROW_STOP);
  }

  virtual bool ArrowCode(const char code) const override {
    return (false);
  }
  char ArrowCode(void) const {
    return (CChartObjectArrow::ArrowCode());
  }
};

CChartObjectArrowStop::CChartObjectArrowStop(void) {}

CChartObjectArrowStop::~CChartObjectArrowStop(void) {}

bool CChartObjectArrowStop::Create(long chart_id, const string name,
                                   const int window, const datetime time,
                                   const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW_STOP, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectArrowCheck : public CChartObjectArrow {
public:
  CChartObjectArrowCheck(void);
  ~CChartObjectArrowCheck(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_ARROW_CHECK);
  }

  virtual bool ArrowCode(const char code) const override {
    return (false);
  }
  char ArrowCode(void) const {
    return (CChartObjectArrow::ArrowCode());
  }
};

CChartObjectArrowCheck::CChartObjectArrowCheck(void) {}

CChartObjectArrowCheck::~CChartObjectArrowCheck(void) {}

bool CChartObjectArrowCheck::Create(long chart_id, const string name,
                                    const int window, const datetime time,
                                    const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW_CHECK, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectArrowLeftPrice : public CChartObjectArrow {
public:
  CChartObjectArrowLeftPrice(void);
  ~CChartObjectArrowLeftPrice(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_ARROW_LEFT_PRICE);
  }

  virtual bool ArrowCode(const char code) const override {
    return (false);
  }
  char ArrowCode(void) const {
    return (CChartObjectArrow::ArrowCode());
  }
  virtual bool Anchor(const ENUM_ARROW_ANCHOR anchor) const override {
    return (false);
  }
  ENUM_ARROW_ANCHOR Anchor(void) const {
    return (CChartObjectArrow::Anchor());
  }
};

CChartObjectArrowLeftPrice::CChartObjectArrowLeftPrice(void) {}

CChartObjectArrowLeftPrice::~CChartObjectArrowLeftPrice(void) {}

bool CChartObjectArrowLeftPrice::Create(long chart_id, const string name,
                                        const int window, const datetime time,
                                        const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW_LEFT_PRICE, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

class CChartObjectArrowRightPrice : public CChartObjectArrow {
public:
  CChartObjectArrowRightPrice(void);
  ~CChartObjectArrowRightPrice(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_ARROW_RIGHT_PRICE);
  }

  virtual bool ArrowCode(const char code) const override {
    return (false);
  }
  char ArrowCode(void) const {
    return (CChartObjectArrow::ArrowCode());
  }
  virtual bool Anchor(const ENUM_ARROW_ANCHOR anchor) const override {
    return (false);
  }
  ENUM_ARROW_ANCHOR Anchor(void) const {
    return (CChartObjectArrow::Anchor());
  }
};

CChartObjectArrowRightPrice::CChartObjectArrowRightPrice(void) {}

CChartObjectArrowRightPrice::~CChartObjectArrowRightPrice(void) {}

bool CChartObjectArrowRightPrice::Create(long chart_id, const string name,
                                         const int window, const datetime time,
                                         const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_ARROW_RIGHT_PRICE, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

#endif
