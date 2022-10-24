#ifndef RECT_H
#define RECT_H

struct CPoint {
  int x;
  int y;
};

struct CSize {
  int cx;
  int cy;
};

struct CRect {
  int left;
  int top;
  int right;
  int bottom;

  CPoint LeftTop(void) const;
  void LeftTop(const int x, const int y);
  void LeftTop(const CPoint &point);
  CPoint RightBottom(void) const;
  void RightBottom(const int x, const int y);
  void RightBottom(const CPoint &point);
  CPoint CenterPoint(void) const;
  int Width(void) const;
  void Width(const int w);
  int Height(void) const;
  void Height(const int h);
  CSize Size(void) const;
  void Size(const int cx, const int cy);
  void Size(const CSize &size);
  void SetBound(const int l, const int t, const int r, const int b);
  void SetBound(const CRect &rect);
  void SetBound(const CPoint &point, const CSize &size);
  void SetBound(const CPoint &left_top, const CPoint &right_bottom);
  void Move(const int x, const int y);
  void Move(const CPoint &point);
  void Shift(const int dx, const int dy);
  void Shift(const CPoint &point);
  void Shift(const CSize &size);
  bool Contains(const int x, const int y) const;
  bool Contains(const CPoint &point) const;
  void Normalize(void);
};

#endif
