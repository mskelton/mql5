#ifndef DATE_DROP_LIST_H
#define DATE_DROP_LIST_H

#include "BmpButton.mqh"
#include "Picture.mqh"
#include "WndContainer.mqh"
#include <Canvas/Canvas.mqh>
#include <Tools/DateTime.mqh>

enum ENUM_DATE_MODES { DATE_MODE_MON, DATE_MODE_YEAR };

class CDateDropList : public CWndContainer {
private:
  CBmpButton m_dec;
  CBmpButton m_inc;
  CPicture m_list;
  CCanvas m_canvas;

  CDateTime m_value;

  ENUM_DATE_MODES m_mode;
  CRect m_click_rect[32];

public:
  CDateDropList(void);
  ~CDateDropList(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);

  datetime Value(void) ;
  void Value(datetime value) ;
  void Value(MqlDateTime &value) ;

  virtual bool Show(void);

protected:
  virtual bool OnClick(void);

  virtual bool CreateButtons(void);
  virtual bool CreateList(void);

  void DrawCanvas(void);
  void DrawClickRect(const int idx, int x, int y, string text, const uint clr,
                     uint alignment = 0);

  virtual bool OnClickDec(void);
  virtual bool OnClickInc(void);
  virtual bool OnClickList(void);
};

EVENT_MAP_BEGIN(CDateDropList)
ON_EVENT(ON_CLICK, m_dec, OnClickDec)
ON_EVENT(ON_CLICK, m_inc, OnClickInc)
ON_EVENT(ON_CLICK, m_list, OnClickList)
EVENT_MAP_END(CWndContainer)













#endif
