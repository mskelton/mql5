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
  int Width(void) const {
    return (right - left);
  }
  void Width(const int w) {
    right = left + w;
  }
  int Height(void) const {
    return (bottom - top);
  }
  void Height(const int h) {
    bottom = top + h;
  }
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

CPoint CRect::LeftTop(void) const {
  CPoint point;

  point.x = left;
  point.y = top;

  return (point);
}

void CRect::LeftTop(const int x, const int y) {
  left = x;
  top = y;
}

void CRect::LeftTop(const CPoint &point) {
  left = point.x;
  top = point.y;
}

CPoint CRect::RightBottom(void) const {
  CPoint point;

  point.x = right;
  point.y = bottom;

  return (point);
}

void CRect::RightBottom(const int x, const int y) {
  right = x;
  bottom = y;
}

void CRect::RightBottom(const CPoint &point) {
  right = point.x;
  bottom = point.y;
}

CPoint CRect::CenterPoint(void) const {
  CPoint point;

  point.x = left + Width() / 2;
  point.y = top + Height() / 2;

  return (point);
}

CSize CRect::Size(void) const {
  CSize size;

  size.cx = right - left;
  size.cy = bottom - top;

  return (size);
}

void CRect::Size(const int cx, const int cy) {
  right = left + cx;
  bottom = top + cy;
}

void CRect::Size(const CSize &size) {
  right = left + size.cx;
  bottom = top + size.cy;
}

void CRect::SetBound(const int l, const int t, const int r, const int b) {
  left = l;
  top = t;
  right = r;
  bottom = b;
}

void CRect::SetBound(const CRect &rect) {
  left = rect.left;
  top = rect.top;
  right = rect.right;
  bottom = rect.bottom;
}

void CRect::SetBound(const CPoint &point, const CSize &size) {
  LeftTop(point);
  Size(size);
}

void CRect::SetBound(const CPoint &left_top, const CPoint &right_bottom) {
  LeftTop(left_top);
  RightBottom(right_bottom);
}

void CRect::Move(const int x, const int y) {
  right += x - left;
  bottom += y - top;
  left = x;
  top = y;
}

void CRect::Move(const CPoint &point) {
  right += point.x - left;
  bottom += point.y - top;
  left = point.x;
  top = point.y;
}

void CRect::Shift(const int dx, const int dy) {
  left += dx;
  top += dy;
  right += dx;
  bottom += dy;
}

void CRect::Shift(const CPoint &point) {
  left += point.x;
  top += point.y;
  right += point.x;
  bottom += point.y;
}

void CRect::Shift(const CSize &size) {
  left += size.cx;
  top += size.cy;
  right += size.cx;
  bottom += size.cy;
}

bool CRect::Contains(const int x, const int y) const {

  return (x >= left && x <= right && y >= top && y <= bottom);
}

bool CRect::Contains(const CPoint &point) const {

  return (point.x >= left && point.x <= right && point.y >= top &&
          point.y <= bottom);
}

void CRect::Normalize(void) {
  if (left > right) {
    int tmp1 = left;
    left = right;
    right = tmp1;
  }
  if (top > bottom) {
    int tmp2 = top;
    top = bottom;
    bottom = tmp2;
  }
}

#endif
