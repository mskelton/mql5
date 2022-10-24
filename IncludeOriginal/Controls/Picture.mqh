#ifndef PICTURE_H
#define PICTURE_H

#include "WndObj.mqh"
#include <ChartObjects\ChartObjectsBmpControls.mqh>

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

  int Border(void) const {
    return (m_border);
  }
  bool Border(const int value);
  string BmpName(void) const {
    return (m_bmp_name);
  }
  bool BmpName(const string name);

protected:
  virtual bool OnCreate(void);
  virtual bool OnShow(void);
  virtual bool OnHide(void);
  virtual bool OnMove(void);
  virtual bool OnChange(void);
};

CPicture::CPicture(void) : m_border(0), m_bmp_name(NULL) {}

CPicture::~CPicture(void) {}

bool CPicture::Create(const long chart, const string name, const int subwin,
                      const int x1, const int y1, const int x2, const int y2) {

  if (!CWndObj::Create(chart, name, subwin, x1, y1, x2, y2))
    return (false);

  if (!m_picture.Create(chart, name, subwin, x1, y1))
    return (false);

  return (OnChange());
}

bool CPicture::Border(const int value) {

  m_border = value;

  return (m_picture.Width(value));
}

bool CPicture::BmpName(const string name) {

  m_bmp_name = name;

  return (m_picture.BmpFileOn(name));
}

bool CPicture::OnCreate(void) {

  return (
      m_picture.Create(m_chart_id, m_name, m_subwin, m_rect.left, m_rect.top));
}

bool CPicture::OnShow(void) {
  return (m_picture.Timeframes(OBJ_ALL_PERIODS));
}

bool CPicture::OnHide(void) {
  return (m_picture.Timeframes(OBJ_NO_PERIODS));
}

bool CPicture::OnMove(void) {

  return (m_picture.X_Distance(m_rect.left) &&
          m_picture.Y_Distance(m_rect.top));
}

bool CPicture::OnChange(void) {

  return (m_picture.Width(m_border) && m_picture.BmpFileOn(m_bmp_name));
}

#endif
