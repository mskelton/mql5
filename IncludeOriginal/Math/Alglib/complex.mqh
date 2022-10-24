#ifndef COMPLEX_H
#define COMPLEX_H

struct al_complex {
public:
  double re;
  double im;

public:
  al_complex(void);
  al_complex(const double x);
  al_complex(const double x, const double y);
  ~al_complex(void);

  void Copy(const al_complex &rhs);
  bool Eq(const al_complex &lhs, const al_complex &rhs);
  bool NotEq(const al_complex &lhs, const al_complex &rhs);
  al_complex Add(const al_complex &lhs, const al_complex &rhs);
  al_complex Sub(const al_complex &lhs, const al_complex &rhs);
  al_complex Mul(const al_complex &lhs, const al_complex &rhs);
  al_complex Div(const al_complex &lhs, const al_complex &rhs);
  al_complex Conjugate(void);

  void operator=(const double rhs);
  void operator=(const al_complex &rhs);
  void operator+=(const al_complex &rhs);
  void operator-=(const al_complex &rhs);
  bool operator==(const al_complex &rhs);
  bool operator==(const double rhs);
  bool operator!=(const al_complex &rhs);
  bool operator!=(const double rhs);
  al_complex operator+(const al_complex &rhs);
  al_complex operator+(const double rhs);
  al_complex operator+(void);
  al_complex operator-(const al_complex &rhs);
  al_complex operator-(const double rhs);
  al_complex operator-(void);
  al_complex operator*(const al_complex &rhs);
  al_complex operator*(const double rhs);
  al_complex operator/(const al_complex &rhs);
  al_complex operator/(const double rhs);
};

al_complex::al_complex(void) : re(0), im(0) {}

al_complex::al_complex(const double x) : re(x), im(0) {}

al_complex::al_complex(const double x, const double y) : re(x), im(y) {}

al_complex::~al_complex(void) {}

void al_complex::Copy(const al_complex &rhs) {
  re = rhs.re;
  im = rhs.im;
}

bool al_complex::Eq(const al_complex &lhs, const al_complex &rhs) {

  if (lhs.re == rhs.re && lhs.im == rhs.im)
    return (true);

  return (false);
}

bool al_complex::NotEq(const al_complex &lhs, const al_complex &rhs) {

  if (lhs.re != rhs.re || lhs.im != rhs.im)
    return (true);

  return (false);
}

al_complex al_complex::Add(const al_complex &lhs, const al_complex &rhs) {
  al_complex res;

  res.re = lhs.re + rhs.re;
  res.im = lhs.im + rhs.im;

  return (res);
}

al_complex al_complex::Sub(const al_complex &lhs, const al_complex &rhs) {
  al_complex res;

  res.re = lhs.re - rhs.re;
  res.im = lhs.im - rhs.im;

  return (res);
}

al_complex al_complex::Mul(const al_complex &lhs, const al_complex &rhs) {
  al_complex res;

  res.re = lhs.re * rhs.re - lhs.im * rhs.im;
  res.im = lhs.re * rhs.im + lhs.im * rhs.re;

  return (res);
}

al_complex al_complex::Div(const al_complex &lhs, const al_complex &rhs) {

  al_complex res(EMPTY_VALUE, EMPTY_VALUE);

  if (rhs.re == 0 && rhs.im == 0) {
    Print(__FUNCTION__ + ": number is zero");
    return (res);
  }

  double e;
  double f;

  if (MathAbs(rhs.im) < MathAbs(rhs.re)) {
    e = rhs.im / rhs.re;
    f = rhs.re + rhs.im * e;
    res.re = (lhs.re + lhs.im * e) / f;
    res.im = (lhs.im - lhs.re * e) / f;

    return (res);
  }
  e = rhs.re / rhs.im;
  f = rhs.im + rhs.re * e;
  res.re = (lhs.im + lhs.re * e) / f;
  res.im = (-lhs.re + lhs.im * e) / f;

  return (res);
}

al_complex al_complex::Conjugate(void) {

  al_complex res(re, -im);

  return res;
}

void al_complex::operator=(const double rhs) {
  re = rhs;
  im = 0;
}

void al_complex::operator=(const al_complex &rhs) {
  this.Copy(rhs);
}

void al_complex::operator+=(const al_complex &rhs) {
  re += rhs.re;
  im += rhs.im;
}

void al_complex::operator-=(const al_complex &rhs) {
  re -= rhs.re;
  im -= rhs.im;
}

bool al_complex::operator==(const al_complex &rhs) {
  return (Eq(this, rhs));
}

bool al_complex::operator==(const double rhs) {
  al_complex r(rhs, 0);

  return (Eq(this, r));
}

bool al_complex::operator!=(const al_complex &rhs) {
  return (NotEq(this, rhs));
}

bool al_complex::operator!=(const double rhs) {
  al_complex r(rhs, 0);

  return (NotEq(this, r));
}

al_complex al_complex::operator+(const al_complex &rhs) {
  return (Add(this, rhs));
}

al_complex al_complex::operator+(const double rhs) {
  al_complex r(rhs, 0);

  return (Add(this, r));
}

al_complex al_complex::operator+(void) {

  return (this);
}

al_complex al_complex::operator-(const al_complex &rhs) {
  return (Sub(this, rhs));
}

al_complex al_complex::operator-(const double rhs) {
  al_complex r(rhs, 0);

  return (Sub(this, r));
}

al_complex al_complex::operator-(void) {
  al_complex c(-this.re, -this.im);

  return (c);
}

al_complex al_complex::operator*(const al_complex &rhs) {
  return (Mul(this, rhs));
}

al_complex al_complex::operator*(const double rhs) {
  al_complex r(rhs, 0);

  return (Mul(this, r));
}

al_complex al_complex::operator/(const al_complex &rhs) {
  return (Div(this, rhs));
}

al_complex al_complex::operator/(const double rhs) {
  al_complex r(rhs, 0);

  return (Div(this, r));
}

#endif
