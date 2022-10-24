#ifndef PICTURE_H
#define PICTURE_H

#include "WndObj.mqh"
#include <ChartObjects/ChartObjectsBmpControls.mqh>

class CPicture : public CWndObj {
private:
  CChartObjectBmpLabel m_picture;

  int m_border;
  string m_bmp_name;

public:
  CPicture(void);
  ~CPicture(void);

  virtual bool Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2);

  int Border(void) const ;
  bool Border(const int value);
  string BmpName(void) const ;
  bool BmpName(const string name);

protected:
  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnChange(void);
};











#endif
