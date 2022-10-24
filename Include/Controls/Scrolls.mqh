#ifndef SCROLLS_H
#define SCROLLS_H

#include "BmpButton.mqh"
#include "Panel.mqh"
#include "WndContainer.mqh"

class CScroll : public CWndContainer {
protected:
  CPanel m_back;
  CBmpButton m_inc;
  CBmpButton m_dec;
  CBmpButton m_thumb;

  int m_min_pos;
  int m_max_pos;

  int m_curr_pos;

public:
  CScroll(void);
  ~CScroll(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  int MinPos(void) const;
  void MinPos(const int value);
  int MaxPos(void) const;
  void MaxPos(const int value);

  int CurrPos(void) const;
  bool CurrPos(int value);

protected:
  virtual bool CreateBack(void);
  virtual bool CreateInc(void);
  virtual bool CreateDec(void);
  virtual bool CreateThumb(void);

  virtual bool OnClickInc(void);
  virtual bool OnClickDec(void);

  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnChangePos(void);

  virtual bool OnThumbDragStart(void);
  virtual bool OnThumbDragProcess(void);
  virtual bool OnThumbDragEnd(void);

  virtual int CalcPos(const int coord);
};

EVENT_MAP_BEGIN(CScroll)
ON_EVENT(ON_CLICK, m_inc, OnClickInc)
ON_EVENT(ON_CLICK, m_dec, OnClickDec)
ON_EVENT(ON_DRAG_START, m_thumb, OnThumbDragStart)
ON_EVENT_PTR(ON_DRAG_PROCESS, m_drag_object, OnThumbDragProcess)
ON_EVENT_PTR(ON_DRAG_END, m_drag_object, OnThumbDragEnd)
EVENT_MAP_END(CWndContainer)

class CScrollV : public CScroll {
public:
  CScrollV(void);
  ~CScrollV(void);

protected:
  virtual bool CreateInc(void);
  virtual bool CreateDec(void);
  virtual bool CreateThumb(void);

  virtual bool OnResize(void);
  virtual bool OnChangePos(void);

  virtual bool OnThumbDragStart(void);
  virtual bool OnThumbDragProcess(void);
  virtual bool OnThumbDragEnd(void);

  virtual int CalcPos(const int coord);
};

class CScrollH : public CScroll {
public:
  CScrollH(void);
  ~CScrollH(void);

protected:
  virtual bool CreateInc(void);
  virtual bool CreateDec(void);
  virtual bool CreateThumb(void);

  virtual bool OnResize(void);
  virtual bool OnChangePos(void);

  virtual bool OnThumbDragStart(void);
  virtual bool OnThumbDragProcess(void);
  virtual bool OnThumbDragEnd(void);

  virtual int CalcPos(const int coord);
};

#endif
