#ifndef FASTTRANSFORMS_H
#define FASTTRANSFORMS_H

#include "alglibinternal.mqh"
#include "complex.mqh"

class CFastFourierTransform {
public:
  CFastFourierTransform(void);
  ~CFastFourierTransform(void);

  static void FFTC1D(al_complex &a[], const int n);
  static void FFTC1DInv(al_complex &a[], const int n);
  static void FFTR1D(double &a[], const int n, al_complex &f[]);
  static void FFTR1DInv(al_complex &f[], const int n, double &a[]);
  static void FFTR1DInternalEven(double &a[], const int n, double &buf[],
                                 CFtPlan &plan);
  static void FFTR1DInvInternalEven(double &a[], const int n, double &buf[],
                                    CFtPlan &plan);
};

CFastFourierTransform::CFastFourierTransform(void) {}

CFastFourierTransform::~CFastFourierTransform(void) {}

static void CFastFourierTransform::FFTC1D(al_complex &a[], const int n) {

  int i = 0;

  double buf[];

  CFtPlan plan;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (!CAp::Assert(CAp::Len(a) >= n, __FUNCTION__ + ": Length(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteComplexVector(a, n),
                   __FUNCTION__ + ": A contains infinite or NAN values!"))
    return;

  if (n == 1)
    return;

  ArrayResizeAL(buf, 2 * n);
  for (i = 0; i <= n - 1; i++) {
    buf[2 * i + 0] = a[i].re;
    buf[2 * i + 1] = a[i].im;
  }

  CFtBase::FtBaseGenerateComplexFFtPlan(n, plan);
  CFtBase::FtBaseExecutePlan(buf, 0, n, plan);

  for (i = 0; i <= n - 1; i++) {
    a[i].re = buf[2 * i + 0];
    a[i].im = buf[2 * i + 1];
  }
}

static void CFastFourierTransform::FFTC1DInv(al_complex &a[], const int n) {

  int i = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (!CAp::Assert(CAp::Len(a) >= n, __FUNCTION__ + ": Length(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteComplexVector(a, n),
                   __FUNCTION__ + ": A contains infinite or NAN values!"))
    return;

  for (i = 0; i <= n - 1; i++)
    a[i].im = -a[i].im;

  FFTC1D(a, n);

  for (i = 0; i <= n - 1; i++) {
    a[i].re = a[i].re / n;
    a[i].im = -(a[i].im / n);
  }
}

static void CFastFourierTransform::FFTR1D(double &a[], const int n,
                                          al_complex &f[]) {

  int i = 0;
  int n2 = 0;
  int idx = 0;
  al_complex hn = 0;
  al_complex hmnc = 0;
  al_complex v = 0;
  int i_ = 0;

  double buf[];

  CFtPlan plan;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (!CAp::Assert(CAp::Len(a) >= n, __FUNCTION__ + ": Length(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(a, n),
                   __FUNCTION__ + ": A contains infinite or NAN values!"))
    return;

  if (n == 1) {

    ArrayResizeAL(f, 1);
    f[0] = a[0];

    return;
  }

  if (n == 2) {

    ArrayResizeAL(f, 2);
    f[0].re = a[0] + a[1];
    f[0].im = 0;
    f[1].re = a[0] - a[1];
    f[1].im = 0;

    return;
  }

  if (n % 2 == 0) {

    n2 = n / 2;

    ArrayResizeAL(buf, n);
    for (i_ = 0; i_ <= n - 1; i_++)
      buf[i_] = a[i_];

    CFtBase::FtBaseGenerateComplexFFtPlan(n2, plan);
    CFtBase::FtBaseExecutePlan(buf, 0, n2, plan);

    ArrayResizeAL(f, n);

    for (i = 0; i <= n2; i++) {
      idx = 2 * (i % n2);
      hn.re = buf[idx + 0];
      hn.im = buf[idx + 1];
      idx = 2 * ((n2 - i) % n2);
      hmnc.re = buf[idx + 0];
      hmnc.im = -buf[idx + 1];
      v.re = -MathSin(-(2 * M_PI * i / n));
      v.im = MathCos(-(2 * M_PI * i / n));
      f[i] = hn + hmnc - v * (hn - hmnc);
      f[i].re = 0.5 * f[i].re;
      f[i].im = 0.5 * f[i].im;
    }

    for (i = n2 + 1; i <= n - 1; i++)
      f[i] = CMath::Conj(f[n - i]);
  } else {

    ArrayResizeAL(f, n);

    for (i = 0; i <= n - 1; i++)
      f[i] = a[i];

    FFTC1D(f, n);
  }
}

static void CFastFourierTransform::FFTR1DInv(al_complex &f[], const int n,
                                             double &a[]) {

  int i = 0;

  double h[];
  al_complex fh[];

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (!CAp::Assert(CAp::Len(f) >= (int)MathFloor((double)n / 2.0) + 1,
                   __FUNCTION__ + ": Length(F)<Floor(N/2)+1!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(f[0].re),
                   __FUNCTION__ + ": F contains infinite or NAN values!"))
    return;
  for (i = 1; i <= (int)MathFloor((double)n / 2.0) - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(f[i].re) && CMath::IsFinite(f[i].im),
                     __FUNCTION__ + ": F contains infinite or NAN values!"))
      return;
  }

  if (!CAp::Assert(CMath::IsFinite(f[(int)MathFloor((double)n / 2.0)].re),
                   __FUNCTION__ + ": F contains infinite or NAN values!"))
    return;

  if (n % 2 != 0) {

    if (!CAp::Assert(CMath::IsFinite(f[(int)MathFloor((double)n / 2.0)].im),
                     __FUNCTION__ + ": F contains infinite or NAN values!"))
      return;
  }

  if (n == 1) {

    ArrayResizeAL(a, 1);
    a[0] = f[0].re;

    return;
  }

  ArrayResizeAL(h, n);
  ArrayResizeAL(a, n);

  h[0] = f[0].re;
  for (i = 1; i <= (int)MathFloor((double)n / 2.0) - 1; i++) {
    h[i] = f[i].re - f[i].im;
    h[n - i] = f[i].re + f[i].im;
  }

  if (n % 2 == 0)
    h[(int)MathFloor((double)n / 2.0)] = f[(int)MathFloor((double)n / 2.0)].re;
  else {
    h[(int)MathFloor((double)n / 2.0)] = f[(int)MathFloor((double)n / 2.0)].re -
                                         f[(int)MathFloor((double)n / 2.0)].im;
    h[(int)MathFloor((double)n / 2.0) + 1] =
        f[(int)MathFloor((double)n / 2.0)].re +
        f[(int)MathFloor((double)n / 2.0)].im;
  }

  FFTR1D(h, n, fh);

  for (i = 0; i <= n - 1; i++)
    a[i] = (fh[i].re - fh[i].im) / n;
}

static void CFastFourierTransform::FFTR1DInternalEven(double &a[], const int n,
                                                      double &buf[],
                                                      CFtPlan &plan) {

  double x = 0;
  double y = 0;
  int i = 0;
  int n2 = 0;
  int idx = 0;
  al_complex hn = 0;
  al_complex hmnc = 0;
  al_complex v = 0;
  int i_ = 0;

  if (!CAp::Assert(n > 0 && n % 2 == 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (n == 2) {

    x = a[0] + a[1];
    y = a[0] - a[1];
    a[0] = x;
    a[1] = y;

    return;
  }

  n2 = n / 2;

  for (i_ = 0; i_ <= n - 1; i_++)
    buf[i_] = a[i_];

  CFtBase::FtBaseExecutePlan(buf, 0, n2, plan);

  a[0] = buf[0] + buf[1];
  for (i = 1; i <= n2 - 1; i++) {

    idx = 2 * (i % n2);
    hn.re = buf[idx + 0];
    hn.im = buf[idx + 1];
    idx = 2 * (n2 - i);
    hmnc.re = buf[idx + 0];
    hmnc.im = -buf[idx + 1];
    v.re = -MathSin(-(2 * M_PI * i / n));
    v.im = MathCos(-(2 * M_PI * i / n));
    v = hn + hmnc - v * (hn - hmnc);
    a[2 * i + 0] = 0.5 * v.re;
    a[2 * i + 1] = 0.5 * v.im;
  }

  a[1] = buf[0] - buf[1];
}

static void CFastFourierTransform::FFTR1DInvInternalEven(double &a[],
                                                         const int n,
                                                         double &buf[],
                                                         CFtPlan &plan) {

  double x = 0;
  double y = 0;
  double t = 0;
  int i = 0;
  int n2 = 0;

  if (!CAp::Assert(n > 0 && n % 2 == 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (n == 2) {

    x = 0.5 * (a[0] + a[1]);
    y = 0.5 * (a[0] - a[1]);
    a[0] = x;
    a[1] = y;

    return;
  }

  n2 = n / 2;
  buf[0] = a[0];

  for (i = 1; i <= n2 - 1; i++) {
    x = a[2 * i + 0];
    y = a[2 * i + 1];
    buf[i] = x - y;
    buf[n - i] = x + y;
  }
  buf[n2] = a[1];

  FFTR1DInternalEven(buf, n, a, plan);

  a[0] = buf[0] / n;
  t = 1.0 / (double)n;

  for (i = 1; i <= n2 - 1; i++) {
    x = buf[2 * i + 0];
    y = buf[2 * i + 1];
    a[i] = t * (x - y);
    a[n - i] = t * (x + y);
  }

  a[n2] = buf[1] / n;
}

class CConv {
public:
  CConv(void);
  ~CConv(void);

  static void ConvC1D(al_complex &a[], const int m, al_complex &b[],
                      const int n, al_complex &r[]);
  static void ConvC1DInv(al_complex &a[], const int m, al_complex &b[],
                         const int n, al_complex &r[]);
  static void ConvC1DCircular(al_complex &s[], const int m, al_complex &r[],
                              const int n, al_complex &c[]);
  static void ConvC1DCircularInv(al_complex &a[], const int m, al_complex &b[],
                                 const int n, al_complex &r[]);
  static void ConvR1D(double &a[], const int m, double &b[], const int n,
                      double &r[]);
  static void ConvR1DInv(double &a[], const int m, double &b[], const int n,
                         double &r[]);
  static void ConvR1DCircular(double &s[], const int m, double &r[],
                              const int n, double &c[]);
  static void ConvR1DCircularInv(double &a[], const int m, double &b[],
                                 const int n, double &r[]);
  static void ConvC1DX(al_complex &a[], const int m, al_complex &b[],
                       const int n, const bool circular, int alg, int q,
                       al_complex &r[]);
  static void ConvR1DX(double &a[], const int m, double &b[], const int n,
                       const bool circular, int alg, int q, double &r[]);
};

CConv::CConv(void) {}

CConv::~CConv(void) {}

static void CConv::ConvC1D(al_complex &a[], const int m, al_complex &b[],
                           const int n, al_complex &r[]) {

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (m < n) {

    ConvC1D(b, n, a, m, r);
    return;
  }

  ConvC1DX(a, m, b, n, false, -1, 0, r);
}

static void CConv::ConvC1DInv(al_complex &a[], const int m, al_complex &b[],
                              const int n, al_complex &r[]) {

  int i = 0;
  int p = 0;
  al_complex c1 = 0;
  al_complex c2 = 0;
  al_complex c3 = 0;
  double t = 0;

  double buf[];
  double buf2[];

  CFtPlan plan;

  if (!CAp::Assert((n > 0 && m > 0) && n <= m,
                   __FUNCTION__ + ": incorrect N or M!"))
    return;

  p = CFtBase::FtBaseFindSmooth(m);
  CFtBase::FtBaseGenerateComplexFFtPlan(p, plan);

  ArrayResizeAL(buf, 2 * p);

  for (i = 0; i <= m - 1; i++) {
    buf[2 * i + 0] = a[i].re;
    buf[2 * i + 1] = a[i].im;
  }

  for (i = m; i <= p - 1; i++) {
    buf[2 * i + 0] = 0;
    buf[2 * i + 1] = 0;
  }

  ArrayResizeAL(buf2, 2 * p);

  for (i = 0; i <= n - 1; i++) {
    buf2[2 * i + 0] = b[i].re;
    buf2[2 * i + 1] = b[i].im;
  }

  for (i = n; i <= p - 1; i++) {
    buf2[2 * i + 0] = 0;
    buf2[2 * i + 1] = 0;
  }

  CFtBase::FtBaseExecutePlan(buf, 0, p, plan);
  CFtBase::FtBaseExecutePlan(buf2, 0, p, plan);

  for (i = 0; i <= p - 1; i++) {
    c1.re = buf[2 * i + 0];
    c1.im = buf[2 * i + 1];
    c2.re = buf2[2 * i + 0];
    c2.im = buf2[2 * i + 1];
    c3 = c1 / c2;
    buf[2 * i + 0] = c3.re;
    buf[2 * i + 1] = -c3.im;
  }

  CFtBase::FtBaseExecutePlan(buf, 0, p, plan);
  t = 1.0 / (double)p;

  ArrayResizeAL(r, m - n + 1);

  for (i = 0; i <= m - n; i++) {
    r[i].re = t * buf[2 * i + 0];
    r[i].im = -(t * buf[2 * i + 1]);
  }
}

static void CConv::ConvC1DCircular(al_complex &s[], const int m,
                                   al_complex &r[], const int n,
                                   al_complex &c[]) {

  int i1 = 0;
  int i2 = 0;
  int j2 = 0;
  int i_ = 0;
  int i1_ = 0;

  al_complex buf[];

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (m < n) {

    ArrayResizeAL(buf, m);

    for (i1 = 0; i1 <= m - 1; i1++)
      buf[i1] = 0;
    i1 = 0;

    while (i1 < n) {

      i2 = MathMin(i1 + m - 1, n - 1);
      j2 = i2 - i1;
      i1_ = i1;
      for (i_ = 0; i_ <= j2; i_++)
        buf[i_] = buf[i_] + r[i_ + i1_];
      i1 = i1 + m;
    }

    ConvC1DCircular(s, m, buf, m, c);

    return;
  }

  ConvC1DX(s, m, r, n, true, -1, 0, c);
}

static void CConv::ConvC1DCircularInv(al_complex &a[], const int m,
                                      al_complex &b[], const int n,
                                      al_complex &r[]) {

  int i = 0;
  int i1 = 0;
  int i2 = 0;
  int j2 = 0;
  al_complex c1 = 0;
  al_complex c2 = 0;
  al_complex c3 = 0;
  double t = 0;
  int i_ = 0;
  int i1_ = 0;

  double buf[];
  double buf2[];
  al_complex cbuf[];

  CFtPlan plan;

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (m < n) {

    ArrayResizeAL(cbuf, m);

    for (i = 0; i <= m - 1; i++)
      cbuf[i] = 0;
    i1 = 0;

    while (i1 < n) {

      i2 = MathMin(i1 + m - 1, n - 1);
      j2 = i2 - i1;
      i1_ = i1;
      for (i_ = 0; i_ <= j2; i_++)
        cbuf[i_] = cbuf[i_] + b[i_ + i1_];
      i1 = i1 + m;
    }

    ConvC1DCircularInv(a, m, cbuf, m, r);

    return;
  }

  CFtBase::FtBaseGenerateComplexFFtPlan(m, plan);

  ArrayResizeAL(buf, 2 * m);

  for (i = 0; i <= m - 1; i++) {
    buf[2 * i + 0] = a[i].re;
    buf[2 * i + 1] = a[i].im;
  }

  ArrayResizeAL(buf2, 2 * m);

  for (i = 0; i <= n - 1; i++) {
    buf2[2 * i + 0] = b[i].re;
    buf2[2 * i + 1] = b[i].im;
  }

  for (i = n; i <= m - 1; i++) {
    buf2[2 * i + 0] = 0;
    buf2[2 * i + 1] = 0;
  }

  CFtBase::FtBaseExecutePlan(buf, 0, m, plan);
  CFtBase::FtBaseExecutePlan(buf2, 0, m, plan);

  for (i = 0; i <= m - 1; i++) {
    c1.re = buf[2 * i + 0];
    c1.im = buf[2 * i + 1];
    c2.re = buf2[2 * i + 0];
    c2.im = buf2[2 * i + 1];
    c3 = c1 / c2;
    buf[2 * i + 0] = c3.re;
    buf[2 * i + 1] = -c3.im;
  }

  CFtBase::FtBaseExecutePlan(buf, 0, m, plan);
  t = 1.0 / (double)m;

  ArrayResizeAL(r, m);

  for (i = 0; i <= m - 1; i++) {
    r[i].re = t * buf[2 * i + 0];
    r[i].im = -(t * buf[2 * i + 1]);
  }
}

static void CConv::ConvR1D(double &a[], const int m, double &b[], const int n,
                           double &r[]) {

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (m < n) {

    ConvR1D(b, n, a, m, r);
    return;
  }

  ConvR1DX(a, m, b, n, false, -1, 0, r);
}

static void CConv::ConvR1DInv(double &a[], const int m, double &b[],
                              const int n, double &r[]) {

  int i = 0;
  int p = 0;
  al_complex c1 = 0;
  al_complex c2 = 0;
  al_complex c3 = 0;
  int i_ = 0;

  double buf[];
  double buf2[];
  double buf3[];

  CFtPlan plan;

  if (!CAp::Assert((n > 0 && m > 0) && n <= m,
                   __FUNCTION__ + ": incorrect N or M!"))
    return;

  p = CFtBase::FtBaseFindSmoothEven(m);

  ArrayResizeAL(buf, p);

  for (i_ = 0; i_ <= m - 1; i_++)
    buf[i_] = a[i_];

  for (i = m; i <= p - 1; i++)
    buf[i] = 0;

  ArrayResizeAL(buf2, p);
  for (i_ = 0; i_ <= n - 1; i_++)
    buf2[i_] = b[i_];

  for (i = n; i <= p - 1; i++)
    buf2[i] = 0;

  ArrayResizeAL(buf3, p);

  CFtBase::FtBaseGenerateComplexFFtPlan(p / 2, plan);

  CFastFourierTransform::FFTR1DInternalEven(buf, p, buf3, plan);

  CFastFourierTransform::FFTR1DInternalEven(buf2, p, buf3, plan);

  buf[0] = buf[0] / buf2[0];
  buf[1] = buf[1] / buf2[1];

  for (i = 1; i <= p / 2 - 1; i++) {
    c1.re = buf[2 * i + 0];
    c1.im = buf[2 * i + 1];
    c2.re = buf2[2 * i + 0];
    c2.im = buf2[2 * i + 1];
    c3 = c1 / c2;
    buf[2 * i + 0] = c3.re;
    buf[2 * i + 1] = c3.im;
  }

  CFastFourierTransform::FFTR1DInvInternalEven(buf, p, buf3, plan);

  ArrayResizeAL(r, m - n + 1);

  for (i_ = 0; i_ <= m - n; i_++)
    r[i_] = buf[i_];
}

static void CConv::ConvR1DCircular(double &s[], const int m, double &r[],
                                   const int n, double &c[]) {

  int i1 = 0;
  int i2 = 0;
  int j2 = 0;
  int i_ = 0;
  int i1_ = 0;

  double buf[];

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (m < n) {

    ArrayResizeAL(buf, m);

    for (i1 = 0; i1 <= m - 1; i1++)
      buf[i1] = 0;
    i1 = 0;

    while (i1 < n) {
      i2 = MathMin(i1 + m - 1, n - 1);
      j2 = i2 - i1;
      i1_ = i1;
      for (i_ = 0; i_ <= j2; i_++)
        buf[i_] = buf[i_] + r[i_ + i1_];
      i1 = i1 + m;
    }
    ConvR1DCircular(s, m, buf, m, c);

    return;
  }

  ConvR1DX(s, m, r, n, true, -1, 0, c);
}

static void CConv::ConvR1DCircularInv(double &a[], const int m, double &b[],
                                      const int n, double &r[]) {

  int i = 0;
  int i1 = 0;
  int i2 = 0;
  int j2 = 0;
  al_complex c1 = 0;
  al_complex c2 = 0;
  al_complex c3 = 0;
  int i_ = 0;
  int i1_ = 0;

  double buf[];
  double buf2[];
  double buf3[];
  al_complex cbuf[];
  al_complex cbuf2[];

  CFtPlan plan;

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (m < n) {

    ArrayResizeAL(buf, m);

    for (i = 0; i <= m - 1; i++)
      buf[i] = 0;
    i1 = 0;

    while (i1 < n) {
      i2 = MathMin(i1 + m - 1, n - 1);
      j2 = i2 - i1;
      i1_ = i1;
      for (i_ = 0; i_ <= j2; i_++)
        buf[i_] = buf[i_] + b[i_ + i1_];
      i1 = i1 + m;
    }

    ConvR1DCircularInv(a, m, buf, m, r);

    return;
  }

  if (m % 2 == 0) {

    ArrayResizeAL(buf, m);
    for (i_ = 0; i_ <= m - 1; i_++)
      buf[i_] = a[i_];

    ArrayResizeAL(buf2, m);

    for (i_ = 0; i_ <= n - 1; i_++)
      buf2[i_] = b[i_];

    for (i = n; i <= m - 1; i++)
      buf2[i] = 0;

    ArrayResizeAL(buf3, m);

    CFtBase::FtBaseGenerateComplexFFtPlan(m / 2, plan);

    CFastFourierTransform::FFTR1DInternalEven(buf, m, buf3, plan);

    CFastFourierTransform::FFTR1DInternalEven(buf2, m, buf3, plan);

    buf[0] = buf[0] / buf2[0];
    buf[1] = buf[1] / buf2[1];

    for (i = 1; i <= m / 2 - 1; i++) {
      c1.re = buf[2 * i + 0];
      c1.im = buf[2 * i + 1];
      c2.re = buf2[2 * i + 0];
      c2.im = buf2[2 * i + 1];
      c3 = c1 / c2;
      buf[2 * i + 0] = c3.re;
      buf[2 * i + 1] = c3.im;
    }

    CFastFourierTransform::FFTR1DInvInternalEven(buf, m, buf3, plan);

    ArrayResizeAL(r, m);

    for (i_ = 0; i_ <= m - 1; i_++)
      r[i_] = buf[i_];
  } else {

    CFastFourierTransform::FFTR1D(a, m, cbuf);

    ArrayResizeAL(buf2, m);

    for (i_ = 0; i_ <= n - 1; i_++)
      buf2[i_] = b[i_];

    for (i = n; i <= m - 1; i++)
      buf2[i] = 0;

    CFastFourierTransform::FFTR1D(buf2, m, cbuf2);

    for (i = 0; i <= (int)MathFloor((double)m / 2.0); i++)
      cbuf[i] = cbuf[i] / cbuf2[i];

    CFastFourierTransform::FFTR1DInv(cbuf, m, r);
  }
}

static void CConv::ConvC1DX(al_complex &a[], const int m, al_complex &b[],
                            const int n, const bool circular, int alg, int q,
                            al_complex &r[]) {

  int i = 0;
  int j = 0;
  int p = 0;
  int ptotal = 0;
  int i1 = 0;
  int i2 = 0;
  int j1 = 0;
  int j2 = 0;
  al_complex v = 0;
  double ax = 0;
  double ay = 0;
  double bx = 0;
  double by = 0;
  double t = 0;
  double tx = 0;
  double ty = 0;
  double flopcand = 0;
  double flopbest = 0;
  int algbest = 0;
  int i_ = 0;
  int i1_ = 0;

  al_complex bbuf[];
  double buf[];
  double buf2[];

  CFtPlan plan;

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (!CAp::Assert(n <= m, __FUNCTION__ + ": N<M assumption is false!"))
    return;

  if (alg == -1 || alg == -2) {

    algbest = 0;

    if (alg == -1)
      flopbest = 2 * m * n;
    else
      flopbest = CMath::m_maxrealnumber;

    if (alg == -1) {

      if (circular && CFtBase::FtBaseIsSmooth(m)) {

        flopcand = 3 * CFtBase::FtBaseGetFlopEstimate(m) + 6 * m;

        if (flopcand < flopbest) {
          algbest = 1;
          flopbest = flopcand;
        }
      } else {

        p = CFtBase::FtBaseFindSmooth(m + n - 1);
        flopcand = 3 * CFtBase::FtBaseGetFlopEstimate(p) + 6 * p;

        if (flopcand < flopbest) {
          algbest = 1;
          flopbest = flopcand;
        }
      }
    }

    q = 1;
    ptotal = 1;
    while (ptotal < n)
      ptotal = ptotal * 2;

    while (ptotal <= m + n - 1) {

      p = ptotal - n + 1;
      flopcand = (int)MathCeil((double)m / (double)p) *
                 (2 * CFtBase::FtBaseGetFlopEstimate(ptotal) + 8 * ptotal);

      if (flopcand < flopbest) {
        flopbest = flopcand;
        algbest = 2;
        q = p;
      }
      ptotal = ptotal * 2;
    }

    alg = algbest;

    ConvC1DX(a, m, b, n, circular, alg, q, r);

    return;
  }

  if (alg == 0) {

    if (n == 1) {

      ArrayResizeAL(r, m);
      v = b[0];
      for (i_ = 0; i_ <= m - 1; i_++)
        r[i_] = v * a[i_];

      return;
    }

    if (circular) {

      ArrayResizeAL(r, m);

      v = b[0];
      for (i_ = 0; i_ <= m - 1; i_++)
        r[i_] = v * a[i_];

      for (i = 1; i <= n - 1; i++) {

        v = b[i];
        i1 = 0;
        i2 = i - 1;
        j1 = m - i;
        j2 = m - 1;
        i1_ = j1 - i1;

        for (i_ = i1; i_ <= i2; i_++)
          r[i_] = r[i_] + v * a[i_ + i1_];

        i1 = i;
        i2 = m - 1;
        j1 = 0;
        j2 = m - i - 1;
        i1_ = j1 - i1;

        for (i_ = i1; i_ <= i2; i_++)
          r[i_] = r[i_] + v * a[i_ + i1_];
      }
    } else {

      ArrayResizeAL(r, m + n - 1);

      for (i = 0; i <= m + n - 2; i++)
        r[i] = 0;

      for (i = 0; i <= n - 1; i++) {
        v = b[i];
        i1_ = -i;
        for (i_ = i; i_ <= i + m - 1; i_++)
          r[i_] = r[i_] + v * a[i_ + i1_];
      }
    }

    return;
  }

  if (alg == 1) {

    if (circular && CFtBase::FtBaseIsSmooth(m)) {

      CFtBase::FtBaseGenerateComplexFFtPlan(m, plan);

      ArrayResizeAL(buf, 2 * m);

      for (i = 0; i <= m - 1; i++) {
        buf[2 * i + 0] = a[i].re;
        buf[2 * i + 1] = a[i].im;
      }

      ArrayResizeAL(buf2, 2 * m);

      for (i = 0; i <= n - 1; i++) {
        buf2[2 * i + 0] = b[i].re;
        buf2[2 * i + 1] = b[i].im;
      }

      for (i = n; i <= m - 1; i++) {
        buf2[2 * i + 0] = 0;
        buf2[2 * i + 1] = 0;
      }

      CFtBase::FtBaseExecutePlan(buf, 0, m, plan);
      CFtBase::FtBaseExecutePlan(buf2, 0, m, plan);

      for (i = 0; i <= m - 1; i++) {
        ax = buf[2 * i + 0];
        ay = buf[2 * i + 1];
        bx = buf2[2 * i + 0];
        by = buf2[2 * i + 1];
        tx = ax * bx - ay * by;
        ty = ax * by + ay * bx;
        buf[2 * i + 0] = tx;
        buf[2 * i + 1] = -ty;
      }

      CFtBase::FtBaseExecutePlan(buf, 0, m, plan);
      t = 1.0 / (double)m;

      ArrayResizeAL(r, m);

      for (i = 0; i <= m - 1; i++) {
        r[i].re = t * buf[2 * i + 0];
        r[i].im = -(t * buf[2 * i + 1]);
      }
    } else {

      p = CFtBase::FtBaseFindSmooth(m + n - 1);
      CFtBase::FtBaseGenerateComplexFFtPlan(p, plan);

      ArrayResizeAL(buf, 2 * p);

      for (i = 0; i <= m - 1; i++) {
        buf[2 * i + 0] = a[i].re;
        buf[2 * i + 1] = a[i].im;
      }

      for (i = m; i <= p - 1; i++) {
        buf[2 * i + 0] = 0;
        buf[2 * i + 1] = 0;
      }

      ArrayResizeAL(buf2, 2 * p);

      for (i = 0; i <= n - 1; i++) {
        buf2[2 * i + 0] = b[i].re;
        buf2[2 * i + 1] = b[i].im;
      }

      for (i = n; i <= p - 1; i++) {
        buf2[2 * i + 0] = 0;
        buf2[2 * i + 1] = 0;
      }

      CFtBase::FtBaseExecutePlan(buf, 0, p, plan);
      CFtBase::FtBaseExecutePlan(buf2, 0, p, plan);

      for (i = 0; i <= p - 1; i++) {
        ax = buf[2 * i + 0];
        ay = buf[2 * i + 1];
        bx = buf2[2 * i + 0];
        by = buf2[2 * i + 1];
        tx = ax * bx - ay * by;
        ty = ax * by + ay * bx;
        buf[2 * i + 0] = tx;
        buf[2 * i + 1] = -ty;
      }

      CFtBase::FtBaseExecutePlan(buf, 0, p, plan);
      t = 1.0 / (double)p;

      if (circular) {

        ArrayResizeAL(r, m);

        for (i = 0; i <= m - 1; i++) {
          r[i].re = t * buf[2 * i + 0];
          r[i].im = -(t * buf[2 * i + 1]);
        }

        for (i = m; i <= m + n - 2; i++) {
          r[i - m].re = r[i - m].re + t * buf[2 * i + 0];
          r[i - m].im = r[i - m].im - t * buf[2 * i + 1];
        }
      } else {

        ArrayResizeAL(r, m + n - 1);
        for (i = 0; i <= m + n - 2; i++) {
          r[i].re = t * buf[2 * i + 0];
          r[i].im = -(t * buf[2 * i + 1]);
        }
      }
    }

    return;
  }

  if (alg == 2) {

    ArrayResizeAL(buf, 2 * (q + n - 1));

    if (circular) {

      ArrayResizeAL(r, m);
      for (i = 0; i <= m - 1; i++)
        r[i] = 0;
    } else {

      ArrayResizeAL(r, m + n - 1);
      for (i = 0; i <= m + n - 2; i++)
        r[i] = 0;
    }

    ArrayResizeAL(bbuf, q + n - 1);
    for (i_ = 0; i_ <= n - 1; i_++)
      bbuf[i_] = b[i_];
    for (j = n; j <= q + n - 2; j++)
      bbuf[j] = 0;

    CFastFourierTransform::FFTC1D(bbuf, q + n - 1);

    CFtBase::FtBaseGenerateComplexFFtPlan(q + n - 1, plan);

    i = 0;

    while (i <= m - 1) {
      p = MathMin(q, m - i);

      for (j = 0; j <= p - 1; j++) {
        buf[2 * j + 0] = a[i + j].re;
        buf[2 * j + 1] = a[i + j].im;
      }

      for (j = p; j <= q + n - 2; j++) {
        buf[2 * j + 0] = 0;
        buf[2 * j + 1] = 0;
      }

      CFtBase::FtBaseExecutePlan(buf, 0, q + n - 1, plan);

      for (j = 0; j <= q + n - 2; j++) {
        ax = buf[2 * j + 0];
        ay = buf[2 * j + 1];
        bx = bbuf[j].re;
        by = bbuf[j].im;
        tx = ax * bx - ay * by;
        ty = ax * by + ay * bx;
        buf[2 * j + 0] = tx;
        buf[2 * j + 1] = -ty;
      }

      CFtBase::FtBaseExecutePlan(buf, 0, q + n - 1, plan);
      t = 1.0 / (double)(q + n - 1);

      if (circular) {
        j1 = MathMin(i + p + n - 2, m - 1) - i;
        j2 = j1 + 1;
      } else {
        j1 = p + n - 2;
        j2 = j1 + 1;
      }

      for (j = 0; j <= j1; j++) {
        r[i + j].re = r[i + j].re + buf[2 * j + 0] * t;
        r[i + j].im = r[i + j].im - buf[2 * j + 1] * t;
      }

      for (j = j2; j <= p + n - 2; j++) {
        r[j - j2].re = r[j - j2].re + buf[2 * j + 0] * t;
        r[j - j2].im = r[j - j2].im - buf[2 * j + 1] * t;
      }
      i = i + p;
    }

    return;
  }
}

static void CConv::ConvR1DX(double &a[], const int m, double &b[], const int n,
                            const bool circular, int alg, int q, double &r[]) {

  double v = 0;
  int i = 0;
  int j = 0;
  int p = 0;
  int ptotal = 0;
  int i1 = 0;
  int i2 = 0;
  int j1 = 0;
  int j2 = 0;
  double ax = 0;
  double ay = 0;
  double bx = 0;
  double by = 0;
  double tx = 0;
  double ty = 0;
  double flopcand = 0;
  double flopbest = 0;
  int algbest = 0;
  int i_ = 0;
  int i1_ = 0;

  double buf[];
  double buf2[];
  double buf3[];

  CFtPlan plan;

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (!CAp::Assert(n <= m, __FUNCTION__ + ": N<M assumption is false!"))
    return;

  if (MathMin(m, n) <= 2)
    alg = 0;

  if (alg < 0) {

    algbest = 0;

    if (alg == -1)
      flopbest = 0.15 * m * n;
    else
      flopbest = CMath::m_maxrealnumber;

    if (alg == -1) {

      if ((circular && CFtBase::FtBaseIsSmooth(m)) && m % 2 == 0) {

        flopcand =
            3 * CFtBase::FtBaseGetFlopEstimate(m / 2) + (double)(6 * m) / 2.0;

        if (flopcand < flopbest) {
          algbest = 1;
          flopbest = flopcand;
        }
      } else {

        p = CFtBase::FtBaseFindSmoothEven(m + n - 1);
        flopcand =
            3 * CFtBase::FtBaseGetFlopEstimate(p / 2) + (double)(6 * p) / 2.0;

        if (flopcand < flopbest) {
          algbest = 1;
          flopbest = flopcand;
        }
      }
    }

    q = 1;
    ptotal = 1;
    while (ptotal < n)
      ptotal = ptotal * 2;

    while (ptotal <= m + n - 1) {

      p = ptotal - n + 1;
      flopcand =
          (int)MathCeil((double)m / (double)p) *
          (2 * CFtBase::FtBaseGetFlopEstimate(ptotal / 2) + 1 * (ptotal / 2));

      if (flopcand < flopbest) {
        flopbest = flopcand;
        algbest = 2;
        q = p;
      }
      ptotal = ptotal * 2;
    }
    alg = algbest;

    ConvR1DX(a, m, b, n, circular, alg, q, r);

    return;
  }

  if (alg == 0) {

    if (n == 1) {

      ArrayResizeAL(r, m);
      v = b[0];
      for (i_ = 0; i_ <= m - 1; i_++)
        r[i_] = v * a[i_];

      return;
    }

    if (circular) {

      ArrayResizeAL(r, m);
      v = b[0];
      for (i_ = 0; i_ <= m - 1; i_++)
        r[i_] = v * a[i_];

      for (i = 1; i <= n - 1; i++) {

        v = b[i];
        i1 = 0;
        i2 = i - 1;
        j1 = m - i;
        j2 = m - 1;
        i1_ = j1 - i1;

        for (i_ = i1; i_ <= i2; i_++)
          r[i_] = r[i_] + v * a[i_ + i1_];

        i1 = i;
        i2 = m - 1;
        j1 = 0;
        j2 = m - i - 1;
        i1_ = j1 - i1;

        for (i_ = i1; i_ <= i2; i_++)
          r[i_] = r[i_] + v * a[i_ + i1_];
      }
    } else {

      ArrayResizeAL(r, m + n - 1);
      for (i = 0; i <= m + n - 2; i++)
        r[i] = 0;

      for (i = 0; i <= n - 1; i++) {
        v = b[i];
        i1_ = -i;
        for (i_ = i; i_ <= i + m - 1; i_++)
          r[i_] = r[i_] + v * a[i_ + i1_];
      }
    }

    return;
  }

  if (alg == 1) {

    if (!CAp::Assert(m + n - 1 > 2, __FUNCTION__ + ": internal error!"))
      return;

    if ((circular && CFtBase::FtBaseIsSmooth(m)) && m % 2 == 0) {

      ArrayResizeAL(buf, m);
      for (i_ = 0; i_ <= m - 1; i_++)
        buf[i_] = a[i_];

      ArrayResizeAL(buf2, m);
      for (i_ = 0; i_ <= n - 1; i_++)
        buf2[i_] = b[i_];
      for (i = n; i <= m - 1; i++)
        buf2[i] = 0;

      ArrayResizeAL(buf3, m);

      CFtBase::FtBaseGenerateComplexFFtPlan(m / 2, plan);

      CFastFourierTransform::FFTR1DInternalEven(buf, m, buf3, plan);

      CFastFourierTransform::FFTR1DInternalEven(buf2, m, buf3, plan);

      buf[0] = buf[0] * buf2[0];
      buf[1] = buf[1] * buf2[1];

      for (i = 1; i <= m / 2 - 1; i++) {
        ax = buf[2 * i + 0];
        ay = buf[2 * i + 1];
        bx = buf2[2 * i + 0];
        by = buf2[2 * i + 1];
        tx = ax * bx - ay * by;
        ty = ax * by + ay * bx;
        buf[2 * i + 0] = tx;
        buf[2 * i + 1] = ty;
      }

      CFastFourierTransform::FFTR1DInvInternalEven(buf, m, buf3, plan);

      ArrayResizeAL(r, m);

      for (i_ = 0; i_ <= m - 1; i_++)
        r[i_] = buf[i_];
    } else {

      p = CFtBase::FtBaseFindSmoothEven(m + n - 1);

      ArrayResizeAL(buf, p);
      for (i_ = 0; i_ <= m - 1; i_++)
        buf[i_] = a[i_];
      for (i = m; i <= p - 1; i++)
        buf[i] = 0;

      ArrayResizeAL(buf2, p);
      for (i_ = 0; i_ <= n - 1; i_++)
        buf2[i_] = b[i_];
      for (i = n; i <= p - 1; i++)
        buf2[i] = 0;

      ArrayResizeAL(buf3, p);

      CFtBase::FtBaseGenerateComplexFFtPlan(p / 2, plan);

      CFastFourierTransform::FFTR1DInternalEven(buf, p, buf3, plan);

      CFastFourierTransform::FFTR1DInternalEven(buf2, p, buf3, plan);

      buf[0] = buf[0] * buf2[0];
      buf[1] = buf[1] * buf2[1];

      for (i = 1; i <= p / 2 - 1; i++) {
        ax = buf[2 * i + 0];
        ay = buf[2 * i + 1];
        bx = buf2[2 * i + 0];
        by = buf2[2 * i + 1];
        tx = ax * bx - ay * by;
        ty = ax * by + ay * bx;
        buf[2 * i + 0] = tx;
        buf[2 * i + 1] = ty;
      }

      CFastFourierTransform::FFTR1DInvInternalEven(buf, p, buf3, plan);

      if (circular) {

        ArrayResizeAL(r, m);
        for (i_ = 0; i_ <= m - 1; i_++)
          r[i_] = buf[i_];

        if (n >= 2) {
          i1_ = m;
          for (i_ = 0; i_ <= n - 2; i_++)
            r[i_] = r[i_] + buf[i_ + i1_];
        }
      } else {

        ArrayResizeAL(r, m + n - 1);
        for (i_ = 0; i_ <= m + n - 2; i_++)
          r[i_] = buf[i_];
      }
    }

    return;
  }

  if (alg == 2) {

    if (!CAp::Assert((q + n - 1) % 2 == 0, __FUNCTION__ + ": internal error!"))
      return;

    ArrayResizeAL(buf, q + n - 1);
    ArrayResizeAL(buf2, q + n - 1);
    ArrayResizeAL(buf3, q + n - 1);

    CFtBase::FtBaseGenerateComplexFFtPlan((q + n - 1) / 2, plan);

    if (circular) {

      ArrayResizeAL(r, m);
      for (i = 0; i <= m - 1; i++)
        r[i] = 0;
    } else {

      ArrayResizeAL(r, m + n - 1);
      for (i = 0; i <= m + n - 2; i++)
        r[i] = 0;
    }

    for (i_ = 0; i_ <= n - 1; i_++)
      buf2[i_] = b[i_];
    for (j = n; j <= q + n - 2; j++)
      buf2[j] = 0;

    CFastFourierTransform::FFTR1DInternalEven(buf2, q + n - 1, buf3, plan);

    i = 0;

    while (i <= m - 1) {
      p = MathMin(q, m - i);
      i1_ = i;

      for (i_ = 0; i_ <= p - 1; i_++)
        buf[i_] = a[i_ + i1_];

      for (j = p; j <= q + n - 2; j++)
        buf[j] = 0;

      CFastFourierTransform::FFTR1DInternalEven(buf, q + n - 1, buf3, plan);

      buf[0] = buf[0] * buf2[0];
      buf[1] = buf[1] * buf2[1];

      for (j = 1; j <= (q + n - 1) / 2 - 1; j++) {
        ax = buf[2 * j + 0];
        ay = buf[2 * j + 1];
        bx = buf2[2 * j + 0];
        by = buf2[2 * j + 1];
        tx = ax * bx - ay * by;
        ty = ax * by + ay * bx;
        buf[2 * j + 0] = tx;
        buf[2 * j + 1] = ty;
      }

      CFastFourierTransform::FFTR1DInvInternalEven(buf, q + n - 1, buf3, plan);

      if (circular) {
        j1 = MathMin(i + p + n - 2, m - 1) - i;
        j2 = j1 + 1;
      } else {
        j1 = p + n - 2;
        j2 = j1 + 1;
      }

      i1_ = -i;
      for (i_ = i; i_ <= i + j1; i_++)
        r[i_] = r[i_] + buf[i_ + i1_];

      if (p + n - 2 >= j2) {
        i1_ = j2;
        for (i_ = 0; i_ <= p + n - 2 - j2; i_++)
          r[i_] = r[i_] + buf[i_ + i1_];
      }
      i = i + p;
    }

    return;
  }
}

class CCorr {
public:
  CCorr(void);
  ~CCorr(void);

  static void CorrC1D(al_complex &signal[], const int n, al_complex &pattern[],
                      const int m, al_complex &r[]);
  static void CorrC1DCircular(al_complex &signal[], const int m,
                              al_complex &pattern[], const int n,
                              al_complex &c[]);
  static void CorrR1D(double &signal[], const int n, double &pattern[],
                      const int m, double &r[]);
  static void CorrR1DCircular(double &signal[], const int m, double &pattern[],
                              const int n, double &c[]);
};

CCorr::CCorr(void) {}

CCorr::~CCorr(void) {}

static void CCorr::CorrC1D(al_complex &signal[], const int n,
                           al_complex &pattern[], const int m,
                           al_complex &r[]) {

  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  al_complex p[];
  al_complex b[];

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  ArrayResizeAL(p, m);
  for (i = 0; i <= m - 1; i++)
    p[m - 1 - i] = CMath::Conj(pattern[i]);

  CConv::ConvC1D(p, m, signal, n, b);

  ArrayResizeAL(r, m + n - 1);
  i1_ = m - 1;
  for (i_ = 0; i_ <= n - 1; i_++)
    r[i_] = b[i_ + i1_];

  if (m + n - 2 >= n) {
    i1_ = -n;
    for (i_ = n; i_ <= m + n - 2; i_++)
      r[i_] = b[i_ + i1_];
  }
}

static void CCorr::CorrC1DCircular(al_complex &signal[], const int m,
                                   al_complex &pattern[], const int n,
                                   al_complex &c[]) {

  int i1 = 0;
  int i2 = 0;
  int i = 0;
  int j2 = 0;
  int i_ = 0;
  int i1_ = 0;

  al_complex p[];
  al_complex b[];

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (m < n) {

    ArrayResizeAL(b, m);

    for (i1 = 0; i1 <= m - 1; i1++)
      b[i1] = 0;
    i1 = 0;

    while (i1 < n) {

      i2 = MathMin(i1 + m - 1, n - 1);
      j2 = i2 - i1;
      i1_ = i1;
      for (i_ = 0; i_ <= j2; i_++)
        b[i_] = b[i_] + pattern[i_ + i1_];
      i1 = i1 + m;
    }

    CorrC1DCircular(signal, m, b, m, c);

    return;
  }

  ArrayResizeAL(p, n);
  for (i = 0; i <= n - 1; i++)
    p[n - 1 - i] = CMath::Conj(pattern[i]);

  CConv::ConvC1DCircular(signal, m, p, n, b);

  ArrayResizeAL(c, m);
  i1_ = n - 1;

  for (i_ = 0; i_ <= m - n; i_++)
    c[i_] = b[i_ + i1_];

  if (m - n + 1 <= m - 1) {
    i1_ = -(m - n + 1);
    for (i_ = m - n + 1; i_ <= m - 1; i_++)
      c[i_] = b[i_ + i1_];
  }
}

static void CCorr::CorrR1D(double &signal[], const int n, double &pattern[],
                           const int m, double &r[]) {

  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  double p[];
  double b[];

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  ArrayResizeAL(p, m);

  for (i = 0; i <= m - 1; i++)
    p[m - 1 - i] = pattern[i];

  CConv::ConvR1D(p, m, signal, n, b);

  ArrayResizeAL(r, m + n - 1);
  i1_ = m - 1;

  for (i_ = 0; i_ <= n - 1; i_++)
    r[i_] = b[i_ + i1_];

  if (m + n - 2 >= n) {
    i1_ = -n;
    for (i_ = n; i_ <= m + n - 2; i_++)
      r[i_] = b[i_ + i1_];
  }
}

static void CCorr::CorrR1DCircular(double &signal[], const int m,
                                   double &pattern[], const int n,
                                   double &c[]) {

  int i1 = 0;
  int i2 = 0;
  int i = 0;
  int j2 = 0;
  int i_ = 0;
  int i1_ = 0;

  double p[];
  double b[];

  if (!CAp::Assert(n > 0 && m > 0, __FUNCTION__ + ": incorrect N or M!"))
    return;

  if (m < n) {

    ArrayResizeAL(b, m);

    for (i1 = 0; i1 <= m - 1; i1++)
      b[i1] = 0;
    i1 = 0;

    while (i1 < n) {

      i2 = MathMin(i1 + m - 1, n - 1);
      j2 = i2 - i1;
      i1_ = i1;
      for (i_ = 0; i_ <= j2; i_++)
        b[i_] = b[i_] + pattern[i_ + i1_];
      i1 = i1 + m;
    }

    CorrR1DCircular(signal, m, b, m, c);

    return;
  }

  ArrayResizeAL(p, n);
  for (i = 0; i <= n - 1; i++)
    p[n - 1 - i] = pattern[i];

  CConv::ConvR1DCircular(signal, m, p, n, b);

  ArrayResizeAL(c, m);
  i1_ = n - 1;

  for (i_ = 0; i_ <= m - n; i_++)
    c[i_] = b[i_ + i1_];

  if (m - n + 1 <= m - 1) {
    i1_ = -(m - n + 1);
    for (i_ = m - n + 1; i_ <= m - 1; i_++)
      c[i_] = b[i_ + i1_];
  }
}

class CFastHartleyTransform {
public:
  CFastHartleyTransform(void);
  ~CFastHartleyTransform(void);

  static void FHTR1D(double &a[], const int n);
  static void FHTR1DInv(double &a[], const int n);
};

CFastHartleyTransform::CFastHartleyTransform(void) {}

CFastHartleyTransform::~CFastHartleyTransform(void) {}

static void CFastHartleyTransform::FHTR1D(double &a[], const int n) {

  int i = 0;

  al_complex fa[];

  CFtPlan plan;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (n == 1)
    return;

  CFastFourierTransform::FFTR1D(a, n, fa);

  for (i = 0; i <= n - 1; i++)
    a[i] = fa[i].re - fa[i].im;
}

static void CFastHartleyTransform::FHTR1DInv(double &a[], const int n) {

  int i = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (n == 1)
    return;

  FHTR1D(a, n);

  for (i = 0; i <= n - 1; i++)
    a[i] = a[i] / n;
}

#endif
