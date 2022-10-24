#ifndef ALGLIBINTERNAL_H
#define ALGLIBINTERNAL_H

#include "ap.mqh"

class CSCodes {
public:
  CSCodes(void);
  ~CSCodes(void);

  static int GetRDFSerializationCode(void) {
    return (1);
  }
  static int GetKDTreeSerializationCode(void) {
    return (2);
  }
  static int GetMLPSerializationCode(void) {
    return (3);
  }
};

CSCodes::CSCodes(void) {}

CSCodes::~CSCodes(void) {}

class CApBuff {
public:
  int m_ia0[];
  int m_ia1[];
  int m_ia2[];
  int m_ia3[];
  double m_ra0[];
  double m_ra1[];
  double m_ra2[];
  double m_ra3[];

  CApBuff(void);
  ~CApBuff(void);

  void Copy(CApBuff &obj);
};

CApBuff::CApBuff(void) {}

CApBuff::~CApBuff(void) {}

void CApBuff::Copy(CApBuff &obj) {

  ArrayCopy(m_ia0, obj.m_ia0);
  ArrayCopy(m_ia1, obj.m_ia1);
  ArrayCopy(m_ia2, obj.m_ia2);
  ArrayCopy(m_ia3, obj.m_ia3);
  ArrayCopy(m_ra0, obj.m_ra0);
  ArrayCopy(m_ra1, obj.m_ra1);
  ArrayCopy(m_ra2, obj.m_ra2);
  ArrayCopy(m_ra3, obj.m_ra3);
}

class CApServ {
public:
  CApServ(void);
  ~CApServ(void);

  static void TaskGenInt1D(const double a, const double b, const int n,
                           double &x[], double &y[]);
  static void TaskGenInt1DEquidist(const double a, const double b, const int n,
                                   double &x[], double &y[]);
  static void TaskGenInt1DCheb1(const double a, const double b, const int n,
                                double &x[], double &y[]);
  static void TaskGenInt1DCheb2(const double a, const double b, const int n,
                                double &x[], double &y[]);

  static bool AreDistinct(double &x[], const int n);

  static void BVectorSetLengthAtLeast(bool &x[], const int n);
  static void IVectorSetLengthAtLeast(int &x[], const int n);
  static void RVectorSetLengthAtLeast(double &x[], const int n);
  static void RMatrixSetLengthAtLeast(CMatrixDouble &x, const int m,
                                      const int n);

  static void RMatrixResize(CMatrixDouble &x, const int m, const int n);

  static bool IsFiniteVector(const double &x[], const int n);
  static bool IsFiniteComplexVector(al_complex &z[], const int n);
  static bool IsFiniteMatrix(const CMatrixDouble &x, const int m, const int n);
  static bool IsFiniteComplexMatrix(CMatrixComplex &x, const int m,
                                    const int n);
  static bool IsFiniteRTrMatrix(CMatrixDouble &x, const int n,
                                const bool isupper);
  static bool IsFiniteCTrMatrix(CMatrixComplex &x, const int n,
                                const bool isupper);
  static bool IsFiniteOrNaNMatrix(CMatrixDouble &x, const int m, const int n);

  static double SafePythag2(const double x, const double y);
  static double SafePythag3(double x, double y, double z);
  static int SafeRDiv(double x, double y, double &r);
  static double SafeMinPosRV(const double x, const double y, const double v);
  static void ApPeriodicMap(double &x, const double a, const double b,
                            double &k);
  static double BoundVal(const double x, const double b1, const double b2);

  static void AllocComplex(CSerializer &s, al_complex &v);
  static void SerializeComplex(CSerializer &s, al_complex &v);
  static al_complex UnserializeComplex(CSerializer &s);
  static void AllocRealArray(CSerializer &s, double &v[], int n);
  static void SerializeRealArray(CSerializer &s, double &v[], int n);
  static void UnserializeRealArray(CSerializer &s, double &v[]);
  static void AllocIntegerArray(CSerializer &s, int &v[], int n);
  static void SerializeIntegerArray(CSerializer &s, int &v[], int n);
  static void UnserializeIntegerArray(CSerializer &s, int &v[]);
  static void AllocRealMatrix(CSerializer &s, CMatrixDouble &v, int n0, int n1);
  static void SerializeRealMatrix(CSerializer &s, CMatrixDouble &v, int n0,
                                  int n1);
  static void UnserializeRealMatrix(CSerializer &s, CMatrixDouble &v);

  static void CopyIntegerArray(int &src[], int &dst[]);
  static void CopyRealArray(double &src[], double &dst[]);
  static void CopyRealMatrix(CMatrixDouble &src, CMatrixDouble &dst);

  static int RecSearch(int &a[], const int nrec, const int nheader, int i0,
                       int i1, int &b[]);
};

CApServ::CApServ(void) {}

CApServ::~CApServ(void) {}

static void CApServ::TaskGenInt1D(const double a, const double b, const int n,
                                  double &x[], double &y[]) {

  int i = 0;
  double h = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  ArrayResizeAL(x, n);
  ArrayResizeAL(y, n);

  if (n > 1) {

    x[0] = a;
    y[0] = 2 * CMath::RandomReal() - 1;
    h = (b - a) / (n - 1);
    for (i = 1; i <= n - 1; i++) {

      if (i != n - 1)
        x[i] = a + (i + 0.2 * (2 * CMath::RandomReal() - 1)) * h;
      else
        x[i] = b;
      y[i] = y[i - 1] + (2 * CMath::RandomReal() - 1) * (x[i] - x[i - 1]);
    }
  } else {

    x[0] = 0.5 * (a + b);
    y[0] = 2 * CMath::RandomReal() - 1;
  }
}

static void CApServ::TaskGenInt1DEquidist(const double a, const double b,
                                          const int n, double &x[],
                                          double &y[]) {

  int i = 0;
  double h = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  ArrayResizeAL(x, n);
  ArrayResizeAL(y, n);

  if (n > 1) {

    x[0] = a;
    y[0] = 2 * CMath::RandomReal() - 1;
    h = (b - a) / (n - 1);
    for (i = 1; i <= n - 1; i++) {
      x[i] = a + i * h;
      y[i] = y[i - 1] + (2 * CMath::RandomReal() - 1) * h;
    }
  } else {

    x[0] = 0.5 * (a + b);
    y[0] = 2 * CMath::RandomReal() - 1;
  }
}

static void CApServ::TaskGenInt1DCheb1(const double a, const double b,
                                       const int n, double &x[], double &y[]) {

  int i = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  ArrayResizeAL(x, n);
  ArrayResizeAL(y, n);

  if (n > 1) {
    for (i = 0; i <= n - 1; i++) {
      x[i] =
          0.5 * (b + a) + 0.5 * (b - a) * MathCos(M_PI * (2 * i + 1) / (2 * n));

      if (i == 0)
        y[i] = 2 * CMath::RandomReal() - 1;
      else
        y[i] = y[i - 1] + (2 * CMath::RandomReal() - 1) * (x[i] - x[i - 1]);
    }
  } else {

    x[0] = 0.5 * (a + b);
    y[0] = 2 * CMath::RandomReal() - 1;
  }
}

static void CApServ::TaskGenInt1DCheb2(const double a, const double b,
                                       const int n, double &x[], double &y[]) {

  int i = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  ArrayResizeAL(x, n);
  ArrayResizeAL(y, n);

  if (n > 1) {
    for (i = 0; i <= n - 1; i++) {
      x[i] = 0.5 * (b + a) + 0.5 * (b - a) * MathCos(M_PI * i / (n - 1));

      if (i == 0)
        y[i] = 2 * CMath::RandomReal() - 1;
      else
        y[i] = y[i - 1] + (2 * CMath::RandomReal() - 1) * (x[i] - x[i - 1]);
    }
  } else {

    x[0] = 0.5 * (a + b);
    y[0] = 2 * CMath::RandomReal() - 1;
  }
}

static bool CApServ::AreDistinct(double &x[], const int n) {

  double a = 0;
  double b = 0;
  int i = 0;
  bool nonsorted;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": internal error (N<1)"))
    return (false);

  if (n == 1) {

    return (true);
  }

  a = x[0];
  b = x[0];
  nonsorted = false;
  for (i = 1; i <= n - 1; i++) {
    a = MathMin(a, x[i]);
    b = MathMax(b, x[i]);
    nonsorted = nonsorted || x[i - 1] >= x[i];
  }

  if (!CAp::Assert(!nonsorted, __FUNCTION__ + ": internal error (not sorted)"))
    return (false);
  for (i = 1; i <= n - 1; i++) {

    if ((x[i] - a) / (b - a) + 1 == (x[i - 1] - a) / (b - a) + 1)
      return (false);
  }

  return (true);
}

static void CApServ::BVectorSetLengthAtLeast(bool &x[], const int n) {

  if (CAp::Len(x) < n)
    ArrayResizeAL(x, n);
}

static void CApServ::IVectorSetLengthAtLeast(int &x[], const int n) {

  if (CAp::Len(x) < n)
    ArrayResizeAL(x, n);
}

static void CApServ::RVectorSetLengthAtLeast(double &x[], const int n) {

  if (CAp::Len(x) < n)
    ArrayResizeAL(x, n);
}

static void CApServ::RMatrixSetLengthAtLeast(CMatrixDouble &x, const int m,
                                             const int n) {

  if (CAp::Rows(x) < m || CAp::Cols(x) < n)
    x.Resize(m, n);
}

static void CApServ::RMatrixResize(CMatrixDouble &x, const int m, const int n) {

  int i = 0;
  int j = 0;
  int m2 = 0;
  int n2 = 0;

  CMatrixDouble oldx;

  m2 = CAp::Rows(x);
  n2 = CAp::Cols(x);

  CAp::Swap(x, oldx);

  x.Resize(m, n);

  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= n - 1; j++) {

      if (i < m2 && j < n2)
        x[i].Set(j, oldx[i][j]);
      else
        x[i].Set(j, 0.0);
    }
  }
}

static bool CApServ::IsFiniteComplexVector(al_complex &z[], const int n) {

  int i = 0;

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": internal error (N<0)"))
    return (false);
  for (i = 0; i <= n - 1; i++) {

    if (!CMath::IsFinite(z[i].re) || !CMath::IsFinite(z[i].im))
      return (false);
  }

  return (true);
}

static bool CApServ::IsFiniteVector(const double &x[], const int n) {

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": the error variable"))
    return (false);

  for (int i = 0; i < n; i++)
    if (!CMath::IsFinite(x[i]))
      return (false);

  return (true);
}

static bool CApServ::IsFiniteMatrix(const CMatrixDouble &x, const int m,
                                    const int n) {

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": the error variable"))
    return (false);

  if (!CAp::Assert(m >= 0, __FUNCTION__ + ": the error variable"))
    return (false);

  for (int i = 0; i < m; i++)
    for (int j = 0; j < n; j++)

      if (!CMath::IsFinite(x[i][j]))
        return (false);

  return (true);
}

static bool CApServ::IsFiniteComplexMatrix(CMatrixComplex &x, const int m,
                                           const int n) {

  int i = 0;
  int j = 0;

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": internal error (N<0)"))
    return (false);

  if (!CAp::Assert(m >= 0, __FUNCTION__ + ": internal error (M<0)"))
    return (false);

  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++)

      if (!CMath::IsFinite(x[i][j].re) || !CMath::IsFinite(x[i][j].im))
        return (false);
  }

  return (true);
}

static bool CApServ::IsFiniteRTrMatrix(CMatrixDouble &x, const int n,
                                       const bool isupper) {

  int i = 0;
  int j1 = 0;
  int j2 = 0;
  int j = 0;

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": internal error (N<0)"))
    return (false);
  for (i = 0; i <= n - 1; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }
    for (j = j1; j <= j2; j++) {

      if (!CMath::IsFinite(x[i][j]))
        return (false);
    }
  }

  return (true);
}

static bool CApServ::IsFiniteCTrMatrix(CMatrixComplex &x, const int n,
                                       const bool isupper) {

  int i = 0;
  int j1 = 0;
  int j2 = 0;
  int j = 0;

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": internal error (N<0)"))
    return (false);
  for (i = 0; i <= n - 1; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }
    for (j = j1; j <= j2; j++) {

      if (!CMath::IsFinite(x[i][j].re) || !CMath::IsFinite(x[i][j].im))
        return (false);
    }
  }

  return (true);
}

static bool CApServ::IsFiniteOrNaNMatrix(CMatrixDouble &x, const int m,
                                         const int n) {

  int i = 0;
  int j = 0;

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": internal error (N<0)"))
    return (false);

  if (!CAp::Assert(m >= 0, __FUNCTION__ + ": internal error (M<0)"))
    return (false);
  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= n - 1; j++) {

      if (!(CMath::IsFinite(x[i][j]) || CInfOrNaN::IsNaN(x[i][j])))
        return (false);
    }
  }

  return (true);
}

static double CApServ::SafePythag2(const double x, const double y) {

  double result = 0;
  double w = 0;
  double xabs = 0;
  double yabs = 0;
  double z = 0;

  xabs = MathAbs(x);
  yabs = MathAbs(y);
  w = MathMax(xabs, yabs);
  z = MathMin(xabs, yabs);

  if (z == 0.0)
    result = w;
  else
    result = w * MathSqrt(1 + CMath::Sqr(z / w));

  return (result);
}

static double CApServ::SafePythag3(double x, double y, double z) {

  double w = 0;

  w = MathMax(MathAbs(x), MathMax(MathAbs(y), MathAbs(z)));

  if (w == 0.0)
    return (0);

  x = x / w;
  y = y / w;
  z = z / w;

  return (w * MathSqrt(CMath::Sqr(x) + CMath::Sqr(y) + CMath::Sqr(z)));
}

static int CApServ::SafeRDiv(double x, double y, double &r) {

  int result = 0;

  r = 0;

  if (y == 0.0) {
    result = 1;

    if (x == 0.0)
      r = CInfOrNaN::NaN();

    if (x > 0.0)
      r = CInfOrNaN::PositiveInfinity();

    if (x < 0.0)
      r = CInfOrNaN::NegativeInfinity();

    return (result);
  }

  if (x == 0.0) {
    r = 0;
    result = 0;

    return (result);
  }

  if (y < 0.0) {
    x = -x;
    y = -y;
  }

  if (y >= 1.0) {
    r = x / y;

    if (MathAbs(r) <= CMath::m_minrealnumber) {
      result = -1;
      r = 0;
    } else
      result = 0;
  } else {

    if (MathAbs(x) >= CMath::m_maxrealnumber * y) {

      if (x > 0.0)
        r = CInfOrNaN::PositiveInfinity();
      else
        r = CInfOrNaN::NegativeInfinity();
      result = 1;
    } else {
      r = x / y;
      result = 0;
    }
  }

  return (result);
}

static double CApServ::SafeMinPosRV(const double x, const double y,
                                    const double v) {

  double result = 0;
  double r = 0;

  if (y >= 1.0) {

    r = x / y;
    result = v;

    if (v > r)
      result = r;
    else
      result = v;
  } else {

    if (x < v * y)
      result = x / y;
    else
      result = v;
  }

  return (result);
}

static void CApServ::ApPeriodicMap(double &x, const double a, const double b,
                                   double &k) {

  k = 0;

  if (!CAp::Assert(a < b, __FUNCTION__ + ": internal error!"))
    return;

  k = (int)MathFloor((x - a) / (b - a));
  x = x - k * (b - a);

  while (x < a) {
    x = x + (b - a);
    k = k - 1;
  }

  while (x > b) {
    x = x - (b - a);
    k = k + 1;
  }

  x = MathMax(x, a);
  x = MathMin(x, b);
}

static double CApServ::BoundVal(const double x, const double b1,
                                const double b2) {

  if (x <= b1)
    return (b1);

  if (x >= b2)
    return (b2);

  return (x);
}

static void CApServ::AllocComplex(CSerializer &s, al_complex &v) {

  s.Alloc_Entry();
  s.Alloc_Entry();
}

static void CApServ::SerializeComplex(CSerializer &s, al_complex &v) {

  s.Serialize_Double(v.re);
  s.Serialize_Double(v.im);
}

static al_complex CApServ::UnserializeComplex(CSerializer &s) {

  al_complex result;

  result.re = s.Unserialize_Double();
  result.im = s.Unserialize_Double();

  return (result);
}

static void CApServ::AllocRealArray(CSerializer &s, double &v[], int n) {

  int i = 0;

  if (n < 0)
    n = CAp::Len(v);

  s.Alloc_Entry();
  for (i = 0; i <= n - 1; i++)
    s.Alloc_Entry();
}

static void CApServ::SerializeRealArray(CSerializer &s, double &v[], int n) {

  int i = 0;

  if (n < 0)
    n = CAp::Len(v);

  s.Serialize_Int(n);
  for (i = 0; i <= n - 1; i++)
    s.Serialize_Double(v[i]);
}

static void CApServ::UnserializeRealArray(CSerializer &s, double &v[]) {

  int n = 0;
  int i = 0;
  double t = 0;

  n = s.Unserialize_Int();

  if (n == 0)
    return;

  ArrayResizeAL(v, n);

  for (i = 0; i <= n - 1; i++) {
    t = s.Unserialize_Double();
    v[i] = t;
  }
}

static void CApServ::AllocIntegerArray(CSerializer &s, int &v[], int n) {

  int i = 0;

  if (n < 0)
    n = CAp::Len(v);

  s.Alloc_Entry();
  for (i = 0; i <= n - 1; i++)
    s.Alloc_Entry();
}

static void CApServ::SerializeIntegerArray(CSerializer &s, int &v[], int n) {

  int i = 0;

  if (n < 0)
    n = CAp::Len(v);

  s.Serialize_Int(n);
  for (i = 0; i <= n - 1; i++)
    s.Serialize_Int(v[i]);
}

static void CApServ::UnserializeIntegerArray(CSerializer &s, int &v[]) {

  int n = 0;
  int i = 0;
  int t = 0;

  n = s.Unserialize_Int();

  if (n == 0)
    return;

  ArrayResizeAL(v, n);
  for (i = 0; i <= n - 1; i++) {
    t = s.Unserialize_Int();
    v[i] = t;
  }
}

static void CApServ::AllocRealMatrix(CSerializer &s, CMatrixDouble &v, int n0,
                                     int n1) {

  int i = 0;
  int j = 0;

  if (n0 < 0)
    n0 = CAp::Rows(v);

  if (n1 < 0)
    n1 = CAp::Cols(v);

  s.Alloc_Entry();
  s.Alloc_Entry();
  for (i = 0; i <= n0 - 1; i++) {
    for (j = 0; j <= n1 - 1; j++)
      s.Alloc_Entry();
  }
}

static void CApServ::SerializeRealMatrix(CSerializer &s, CMatrixDouble &v,
                                         int n0, int n1) {

  int i = 0;
  int j = 0;

  if (n0 < 0)
    n0 = CAp::Rows(v);

  if (n1 < 0)
    n1 = CAp::Cols(v);

  s.Serialize_Int(n0);

  s.Serialize_Int(n1);
  for (i = 0; i <= n0 - 1; i++)
    for (j = 0; j <= n1 - 1; j++)
      s.Serialize_Double(v[i][j]);
}

static void CApServ::UnserializeRealMatrix(CSerializer &s, CMatrixDouble &v) {

  int i = 0;
  int j = 0;
  int n0 = 0;
  int n1 = 0;
  double t = 0;

  n0 = s.Unserialize_Int();
  n1 = s.Unserialize_Int();

  if (n0 == 0 || n1 == 0)
    return;

  v.Resize(n0, n1);

  for (i = 0; i <= n0 - 1; i++)
    for (j = 0; j <= n1 - 1; j++) {
      t = s.Unserialize_Double();
      v[i].Set(j, t);
    }
}

static void CApServ::CopyIntegerArray(int &src[], int &dst[]) {
  int i = 0;

  if (CAp::Len(src) > 0) {

    ArrayResizeAL(dst, CAp::Len(src));

    for (i = 0; i <= CAp::Len(src) - 1; i++)
      dst[i] = src[i];
  }
}

static void CApServ::CopyRealArray(double &src[], double &dst[]) {
  int i = 0;

  if (CAp::Len(src) > 0) {
    ArrayResizeAL(dst, CAp::Len(src));
    for (i = 0; i <= CAp::Len(src) - 1; i++)
      dst[i] = src[i];
  }
}

static void CApServ::CopyRealMatrix(CMatrixDouble &src, CMatrixDouble &dst) {

  int i = 0;
  int j = 0;

  if (CAp::Rows(src) > 0 && CAp::Cols(src) > 0) {
    dst.Resize(CAp::Rows(src), CAp::Cols(src));

    for (i = 0; i <= CAp::Rows(src) - 1; i++)
      for (j = 0; j <= CAp::Cols(src) - 1; j++)
        dst[i].Set(j, src[i][j]);
  }
}

static int CApServ::RecSearch(int &a[], const int nrec, const int nheader,
                              int i0, int i1, int &b[]) {

  int mididx = 0;
  int cflag = 0;
  int k = 0;
  int offs = 0;

  while (true) {

    if (i0 >= i1)
      break;

    mididx = (i0 + i1) / 2;
    offs = nrec * mididx;
    cflag = 0;
    for (k = 0; k <= nheader - 1; k++) {

      if (a[offs + k] < b[k]) {
        cflag = -1;
        break;
      }

      if (a[offs + k] > b[k]) {
        cflag = 1;
        break;
      }
    }

    if (cflag == 0) {
      return (mididx);
    }

    if (cflag < 0)
      i0 = mididx + 1;
    else
      i1 = mididx;
  }

  return (-1);
}

class CTSort {
private:
  static void TagSortFastIRec(double &a[], int &b[], double &bufa[],
                              int &bufb[], const int i1, const int i2);
  static void TagSortFastRRec(double &a[], double &b[], double &bufa[],
                              double &bufb[], const int i1, const int i2);
  static void TagSortFastRec(double &a[], double &bufa[], const int i1,
                             const int i2);

public:
  CTSort(void);
  ~CTSort(void);

  static void TagSort(double &a[], const int n, int &p1[], int &p2[]);
  static void TagSortBuf(double &a[], const int n, int &p1[], int &p2[],
                         CApBuff &buf);
  static void TagSortFastI(double &a[], int &b[], double &bufa[], int &bufb[],
                           const int n);
  static void TagSortFastR(double &a[], double &b[], double &bufa[],
                           double &bufb[], const int n);
  static void TagSortFast(double &a[], double &bufa[], const int n);
  static void TagHeapPushI(double &a[], int &b[], int &n, const double va,
                           const int vb);
  static void TagHeapReplaceTopI(double &a[], int &b[], const int n,
                                 const double va, const int vb);
  static void TagHeapPopI(double &a[], int &b[], int &n);
};

CTSort::CTSort(void) {}

CTSort::~CTSort(void) {}

static void CTSort::TagSort(double &a[], const int n, int &p1[], int &p2[]) {

  CApBuff buf;

  TagSortBuf(a, n, p1, p2, buf);
}

static void CTSort::TagSortBuf(double &a[], const int n, int &p1[], int &p2[],
                               CApBuff &buf) {

  int i = 0;
  int lv = 0;
  int lp = 0;
  int rv = 0;
  int rp = 0;

  if (n <= 0)
    return;

  if (n == 1) {

    CApServ::IVectorSetLengthAtLeast(p1, 1);

    CApServ::IVectorSetLengthAtLeast(p2, 1);
    p1[0] = 0;
    p2[0] = 0;

    return;
  }

  CApServ::IVectorSetLengthAtLeast(p1, n);
  for (i = 0; i <= n - 1; i++)
    p1[i] = i;

  CApServ::RVectorSetLengthAtLeast(buf.m_ra0, n);

  CApServ::IVectorSetLengthAtLeast(buf.m_ia0, n);
  TagSortFastI(a, p1, buf.m_ra0, buf.m_ia0, n);

  CApServ::IVectorSetLengthAtLeast(buf.m_ia0, n);

  CApServ::IVectorSetLengthAtLeast(buf.m_ia1, n);

  CApServ::IVectorSetLengthAtLeast(p2, n);
  for (i = 0; i <= n - 1; i++) {
    buf.m_ia0[i] = i;
    buf.m_ia1[i] = i;
  }
  for (i = 0; i <= n - 1; i++) {

    lp = i;
    lv = buf.m_ia1[lp];
    rv = p1[i];
    rp = buf.m_ia0[rv];

    p2[i] = rp;

    buf.m_ia1[lp] = rv;
    buf.m_ia1[rp] = lv;
    buf.m_ia0[lv] = rp;
    buf.m_ia0[rv] = lp;
  }
}

static void CTSort::TagSortFastI(double &a[], int &b[], double &bufa[],
                                 int &bufb[], const int n) {

  int i = 0;
  int j = 0;
  bool isascending;
  bool isdescending;
  double tmpr = 0;
  int tmpi = 0;

  if (n <= 1)
    return;

  isascending = true;
  isdescending = true;
  for (i = 1; i <= n - 1; i++) {
    isascending = isascending && a[i] >= a[i - 1];
    isdescending = isdescending && a[i] <= a[i - 1];
  }

  if (isascending)
    return;

  if (isdescending) {
    for (i = 0; i <= n - 1; i++) {
      j = n - 1 - i;

      if (j <= i)
        break;

      tmpr = a[i];
      a[i] = a[j];
      a[j] = tmpr;
      tmpi = b[i];
      b[i] = b[j];
      b[j] = tmpi;
    }

    return;
  }

  if (CAp::Len(bufa) < n)
    ArrayResizeAL(bufa, n);

  if (CAp::Len(bufb) < n)
    ArrayResizeAL(bufb, n);

  TagSortFastIRec(a, b, bufa, bufb, 0, n - 1);
}

static void CTSort::TagSortFastR(double &a[], double &b[], double &bufa[],
                                 double &bufb[], const int n) {

  int i = 0;
  int j = 0;
  bool isascending;
  bool isdescending;
  double tmpr = 0;

  if (n <= 1)
    return;

  isascending = true;
  isdescending = true;
  for (i = 1; i <= n - 1; i++) {
    isascending = isascending && a[i] >= a[i - 1];
    isdescending = isdescending && a[i] <= a[i - 1];
  }

  if (isascending)
    return;

  if (isdescending) {
    for (i = 0; i <= n - 1; i++) {
      j = n - 1 - i;

      if (j <= i)
        break;

      tmpr = a[i];
      a[i] = a[j];
      a[j] = tmpr;
      tmpr = b[i];
      b[i] = b[j];
      b[j] = tmpr;
    }

    return;
  }

  if (CAp::Len(bufa) < n)
    ArrayResizeAL(bufa, n);

  if (CAp::Len(bufb) < n)
    ArrayResizeAL(bufb, n);

  TagSortFastRRec(a, b, bufa, bufb, 0, n - 1);
}

static void CTSort::TagSortFast(double &a[], double &bufa[], const int n) {

  if (n <= 1)
    return;

  int i;
  int j;
  bool isAsCending;
  bool isDesCending;
  double tmpr;

  isAsCending = true;
  isDesCending = true;
  for (i = 1; i < n; i++) {
    isAsCending = isAsCending && a[i] >= a[i - 1];
    isDesCending = isDesCending && a[i] <= a[i - 1];
  }

  if (isAsCending)
    return;

  if (isDesCending) {
    for (i = 0; i < n; i++) {
      j = n - 1 - i;
      if (j <= i)
        break;
      tmpr = a[i];
      a[i] = a[j];
      a[j] = tmpr;
    }

    return;
  }

  if (CAp::Len(bufa) < n)
    ArrayResizeAL(bufa, n);

  TagSortFastRec(a, bufa, 0, n - 1);

  return;
}

static void CTSort::TagHeapPushI(double &a[], int &b[], int &n, const double va,
                                 const int vb) {

  int j = 0;
  int k = 0;
  double v = 0;

  if (n < 0)
    return;

  if (n == 0) {
    a[0] = va;
    b[0] = vb;
    n = n + 1;

    return;
  }

  j = n;
  n = n + 1;
  while (j > 0) {
    k = (j - 1) / 2;
    v = a[k];

    if (v < va) {

      a[j] = v;
      b[j] = b[k];
      j = k;
    } else {

      break;
    }
  }

  a[j] = va;
  b[j] = vb;
}

static void CTSort::TagHeapReplaceTopI(double &a[], int &b[], const int n,
                                       const double va, const int vb) {

  int j = 0;
  int k1 = 0;
  int k2 = 0;
  double v = 0;
  double v1 = 0;
  double v2 = 0;

  if (n < 1)
    return;

  if (n == 1) {
    a[0] = va;
    b[0] = vb;

    return;
  }

  j = 0;
  k1 = 1;
  k2 = 2;
  while (k1 < n) {

    if (k2 >= n) {

      v = a[k1];

      if (v > va) {
        a[j] = v;
        b[j] = b[k1];
        j = k1;
      }
      break;
    } else {

      v1 = a[k1];
      v2 = a[k2];

      if (v1 > v2) {

        if (va < v1) {
          a[j] = v1;
          b[j] = b[k1];
          j = k1;
        } else
          break;
      } else {

        if (va < v2) {
          a[j] = v2;
          b[j] = b[k2];
          j = k2;
        } else
          break;
      }

      k1 = 2 * j + 1;
      k2 = 2 * j + 2;
    }
  }

  a[j] = va;
  b[j] = vb;
}

static void CTSort::TagHeapPopI(double &a[], int &b[], int &n) {

  double va = 0;
  int vb = 0;

  if (n < 1)
    return;

  if (n == 1) {
    n = 0;
    return;
  }

  va = a[n - 1];
  vb = b[n - 1];
  a[n - 1] = a[0];
  b[n - 1] = b[0];
  n = n - 1;

  TagHeapReplaceTopI(a, b, n, va, vb);
}

static void CTSort::TagSortFastIRec(double &a[], int &b[], double &bufa[],
                                    int &bufb[], const int i1, const int i2) {

  int i = 0;
  int j = 0;
  int k = 0;
  int cntless = 0;
  int cnteq = 0;
  int cntgreater = 0;
  double tmpr = 0;
  int tmpi = 0;
  double v0 = 0;
  double v1 = 0;
  double v2 = 0;
  double vp = 0;

  if (i2 <= i1)
    return;

  if (i2 - i1 <= 16) {
    for (j = i1 + 1; j <= i2; j++) {

      tmpr = a[j];
      tmpi = j;
      for (k = j - 1; k >= i1; k--) {

        if (a[k] <= tmpr)
          break;
        tmpi = k;
      }
      k = tmpi;

      if (k != j) {

        tmpr = a[j];
        tmpi = b[j];
        for (i = j - 1; i >= k; i--) {
          a[i + 1] = a[i];
          b[i + 1] = b[i];
        }
        a[k] = tmpr;
        b[k] = tmpi;
      }
    }

    return;
  }

  v0 = a[i1];
  v1 = a[i1 + (i2 - i1) / 2];
  v2 = a[i2];

  if (v0 > v1) {
    tmpr = v1;
    v1 = v0;
    v0 = tmpr;
  }

  if (v1 > v2) {
    tmpr = v2;
    v2 = v1;
    v1 = tmpr;
  }

  if (v0 > v1) {
    tmpr = v1;
    v1 = v0;
    v0 = tmpr;
  }
  vp = v1;

  cntless = 0;
  cnteq = 0;
  cntgreater = 0;
  for (i = i1; i <= i2; i++) {
    v0 = a[i];

    if (v0 < vp) {

      k = i1 + cntless;

      if (i != k) {
        a[k] = v0;
        b[k] = b[i];
      }
      cntless = cntless + 1;
      continue;
    }

    if (v0 == vp) {

      k = i2 - cnteq;
      bufa[k] = v0;
      bufb[k] = b[i];
      cnteq = cnteq + 1;
      continue;
    }

    k = i1 + cntgreater;
    bufa[k] = v0;
    bufb[k] = b[i];
    cntgreater = cntgreater + 1;
  }

  for (i = 0; i <= cnteq - 1; i++) {
    j = i1 + cntless + cnteq - 1 - i;
    k = i2 + i - (cnteq - 1);
    a[j] = bufa[k];
    b[j] = bufb[k];
  }

  for (i = 0; i <= cntgreater - 1; i++) {
    j = i1 + cntless + cnteq + i;
    k = i1 + i;
    a[j] = bufa[k];
    b[j] = bufb[k];
  }

  TagSortFastIRec(a, b, bufa, bufb, i1, i1 + cntless - 1);

  TagSortFastIRec(a, b, bufa, bufb, i1 + cntless + cnteq, i2);
}

static void CTSort::TagSortFastRRec(double &a[], double &b[], double &bufa[],
                                    double &bufb[], const int i1,
                                    const int i2) {

  int i = 0;
  int j = 0;
  int k = 0;
  double tmpr = 0;
  double tmpr2 = 0;
  int tmpi = 0;
  int cntless = 0;
  int cnteq = 0;
  int cntgreater = 0;
  double v0 = 0;
  double v1 = 0;
  double v2 = 0;
  double vp = 0;

  if (i2 <= i1)
    return;

  if (i2 - i1 <= 16) {
    for (j = i1 + 1; j <= i2; j++) {

      tmpr = a[j];
      tmpi = j;
      for (k = j - 1; k >= i1; k--) {

        if (a[k] <= tmpr)
          break;
        tmpi = k;
      }
      k = tmpi;

      if (k != j) {

        tmpr = a[j];
        tmpr2 = b[j];
        for (i = j - 1; i >= k; i--) {
          a[i + 1] = a[i];
          b[i + 1] = b[i];
        }
        a[k] = tmpr;
        b[k] = tmpr2;
      }
    }

    return;
  }

  v0 = a[i1];
  v1 = a[i1 + (i2 - i1) / 2];
  v2 = a[i2];

  if (v0 > v1) {
    tmpr = v1;
    v1 = v0;
    v0 = tmpr;
  }

  if (v1 > v2) {
    tmpr = v2;
    v2 = v1;
    v1 = tmpr;
  }

  if (v0 > v1) {
    tmpr = v1;
    v1 = v0;
    v0 = tmpr;
  }
  vp = v1;

  cntless = 0;
  cnteq = 0;
  cntgreater = 0;
  for (i = i1; i <= i2; i++) {
    v0 = a[i];

    if (v0 < vp) {

      k = i1 + cntless;

      if (i != k) {
        a[k] = v0;
        b[k] = b[i];
      }
      cntless = cntless + 1;
      continue;
    }

    if (v0 == vp) {

      k = i2 - cnteq;
      bufa[k] = v0;
      bufb[k] = b[i];
      cnteq = cnteq + 1;
      continue;
    }

    k = i1 + cntgreater;
    bufa[k] = v0;
    bufb[k] = b[i];
    cntgreater = cntgreater + 1;
  }

  for (i = 0; i <= cnteq - 1; i++) {
    j = i1 + cntless + cnteq - 1 - i;
    k = i2 + i - (cnteq - 1);
    a[j] = bufa[k];
    b[j] = bufb[k];
  }

  for (i = 0; i <= cntgreater - 1; i++) {
    j = i1 + cntless + cnteq + i;
    k = i1 + i;
    a[j] = bufa[k];
    b[j] = bufb[k];
  }

  TagSortFastRRec(a, b, bufa, bufb, i1, i1 + cntless - 1);

  TagSortFastRRec(a, b, bufa, bufb, i1 + cntless + cnteq, i2);
}

static void CTSort::TagSortFastRec(double &a[], double &bufa[], const int i1,
                                   const int i2) {

  if (i2 <= i1)
    return;

  int cntLess;
  int cntEq;
  int cntGreat;
  int i;
  int j;
  int k;
  double tmpr;
  int tmpi;
  double v0;
  double v1;
  double v2;
  double vp;

  if (i2 - i1 <= 16) {
    for (j = i1 + 1; j <= i2; j++) {

      tmpr = a[j];
      tmpi = j;
      for (k = j - 1; k >= i1; k--) {

        if (a[k] <= tmpr)
          break;
        tmpi = k;
      }
      k = tmpi;

      if (k != j) {
        tmpr = a[j];
        for (i = j - 1; i >= k; i--)
          a[i + 1] = a[i];
        a[k] = tmpr;
      }
    }
    return;
  }

  v0 = a[i1];
  v1 = a[i1 + (i2 - i1) / 2];
  v2 = a[i2];

  if (v0 > v1) {
    tmpr = v1;
    v1 = v0;
    v0 = tmpr;
  }

  if (v1 > v2) {
    tmpr = v2;
    v2 = v1;
    v1 = tmpr;
  }

  if (v0 > v1) {
    tmpr = v1;
    v1 = v0;
    v0 = tmpr;
  }
  vp = v1;

  cntLess = 0;
  cntEq = 0;
  cntGreat = 0;
  for (i = i1; i <= i2; i++) {
    v0 = a[i];

    if (v0 < vp) {

      k = i1 + cntLess;
      if (i != k)
        a[k] = v0;
      cntLess++;
      continue;
    }

    if (v0 == vp) {

      k = i2 - cntEq;
      bufa[k] = v0;
      cntEq++;
      continue;
    }

    k = i1 + cntGreat;
    bufa[k] = v0;
    cntGreat++;
  }

  for (i = 0; i < cntEq; i++) {
    j = i1 + cntLess + cntEq - 1 - i;
    k = i2 + i - (cntEq - 1);
    a[j] = bufa[k];
  }
  for (i = 0; i < cntGreat; i++) {
    j = i1 + cntLess + cntEq + i;
    k = i1 + i;
    a[j] = bufa[k];
  }

  TagSortFastRec(a, bufa, i1, i1 + cntLess - 1);
  TagSortFastRec(a, bufa, i1 + cntLess + cntEq, i2);
  return;
}

class CBasicStatOps {
public:
  CBasicStatOps(void);
  ~CBasicStatOps(void);

  static void RankX(double &x[], const int n, CApBuff &buf);
};

CBasicStatOps::CBasicStatOps(void) {}

CBasicStatOps::~CBasicStatOps(void) {}

static void CBasicStatOps::RankX(double &x[], const int n, CApBuff &buf) {

  if (n < 1)
    return;

  if (n == 1) {
    x[0] = 1;
    return;
  }

  int i;
  int j;
  int k;
  int t;
  double tmp;
  int tmpi;

  if (CAp::Len(buf.m_ra1) < n)
    ArrayResizeAL(buf.m_ra1, n);

  if (CAp::Len(buf.m_ia1) < n)
    ArrayResizeAL(buf.m_ia1, n);

  for (i = 0; i < n; i++) {
    buf.m_ra1[i] = x[i];
    buf.m_ia1[i] = i;
  }

  if (n != 1) {
    i = 2;

    do {
      t = i;

      while (t != 1) {
        k = t / 2;

        if (buf.m_ra1[k - 1] >= buf.m_ra1[t - 1])
          t = 1;
        else {

          tmp = buf.m_ra1[k - 1];
          buf.m_ra1[k - 1] = buf.m_ra1[t - 1];
          buf.m_ra1[t - 1] = tmp;
          tmpi = buf.m_ia1[k - 1];
          buf.m_ia1[k - 1] = buf.m_ia1[t - 1];
          buf.m_ia1[t - 1] = tmpi;

          t = k;
        }
      }

      i = i + 1;
    } while (i <= n);

    i = n - 1;

    do {

      tmp = buf.m_ra1[i];
      buf.m_ra1[i] = buf.m_ra1[0];
      buf.m_ra1[0] = tmp;
      tmpi = buf.m_ia1[i];
      buf.m_ia1[i] = buf.m_ia1[0];
      buf.m_ia1[0] = tmpi;

      t = 1;
      while (t != 0) {
        k = 2 * t;
        if (k > i)
          t = 0;
        else {

          if (k < i)
            if (buf.m_ra1[k] > buf.m_ra1[k - 1])
              k++;

          if (buf.m_ra1[t - 1] >= buf.m_ra1[k - 1])
            t = 0;
          else {

            tmp = buf.m_ra1[k - 1];
            buf.m_ra1[k - 1] = buf.m_ra1[t - 1];
            buf.m_ra1[t - 1] = tmp;
            tmpi = buf.m_ia1[k - 1];
            buf.m_ia1[k - 1] = buf.m_ia1[t - 1];
            buf.m_ia1[t - 1] = tmpi;

            t = k;
          }
        }
      }
      i = i - 1;
    } while (i >= 1);
  }

  i = 0;
  while (i < n) {
    j = i + 1;
    while (j < n) {

      if (buf.m_ra1[j] != buf.m_ra1[i])
        break;
      j = j + 1;
    }
    for (k = i; k < j; k++)
      buf.m_ra1[k] = 1 + (double)(i + j - 1) / 2.0;

    i = j;
  }

  for (i = 0; i < n; i++)
    x[buf.m_ia1[i]] = buf.m_ra1[i];

  return;
}

class CAblasF {
public:
  CAblasF(void);
  ~CAblasF(void);

  static bool CMatrixRank1F(const int m, const int n, CMatrixComplex &a, int ia,
                            int ja, al_complex &u[], int iu, al_complex &v[],
                            int iv);
  static bool RMatrixRank1F(const int m, const int n, CMatrixDouble &a, int ia,
                            int ja, double &u[], int iu, double &v[], int iv);
  static bool CMatrixMVF(const int m, const int n, CMatrixComplex &a, int ia,
                         int ja, int opa, al_complex &x[], int ix,
                         al_complex &y[], int iy);
  static bool RMatrixMVF(const int m, const int n, CMatrixDouble &a, int ia,
                         int ja, int opa, double &x[], int ix, double &y[],
                         int iy);
  static bool CMatrixRightTrsMF(const int m, const int n, CMatrixComplex &a,
                                const int i1, int j1, const bool isupper,
                                bool isunit, int optype, CMatrixComplex &x,
                                int i2, int j2);
  static bool CMatrixLeftTrsMF(const int m, const int n, CMatrixComplex &a,
                               const int i1, int j1, const bool isupper,
                               bool isunit, int optype, CMatrixComplex &x,
                               int i2, int j2);
  static bool RMatrixRightTrsMF(const int m, const int n, CMatrixDouble &a,
                                const int i1, int j1, const bool isupper,
                                bool isunit, int optype, CMatrixDouble &x,
                                int i2, int j2);
  static bool RMatrixLeftTrsMF(const int m, const int n, CMatrixDouble &a,
                               const int i1, int j1, const bool isupper,
                               bool isunit, int optype, CMatrixDouble &x,
                               int i2, int j2);
  static bool CMatrixSyrkF(const int n, int k, double alpha, CMatrixComplex &a,
                           int ia, int ja, int optypea, double beta,
                           CMatrixComplex &c, int ic, int jc, bool isupper);
  static bool RMatrixSyrkF(const int n, int k, double alpha, CMatrixDouble &a,
                           int ia, int ja, int optypea, double beta,
                           CMatrixDouble &c, int ic, int jc, bool isupper);
  static bool RMatrixGemmF(const int m, const int n, int k, double alpha,
                           CMatrixDouble &a, int ia, int ja, int optypea,
                           CMatrixDouble &b, int ib, int jb, int optypeb,
                           double beta, CMatrixDouble &c, int ic, int jc);
  static bool CMatrixGemmF(const int m, const int n, int k, al_complex &alpha,
                           CMatrixComplex &a, int ia, int ja, int optypea,
                           CMatrixComplex &b, int ib, int jb, int optypeb,
                           al_complex &beta, CMatrixComplex &c, int ic, int jc);
};

CAblasF::CAblasF(void) {}

CAblasF::~CAblasF(void) {}

static bool CAblasF::CMatrixRank1F(const int m, const int n, CMatrixComplex &a,
                                   int ia, int ja, al_complex &u[], int iu,
                                   al_complex &v[], int iv) {

  return (false);
}

static bool CAblasF::RMatrixRank1F(const int m, const int n, CMatrixDouble &a,
                                   int ia, int ja, double &u[], int iu,
                                   double &v[], int iv) {

  return (false);
}

static bool CAblasF::CMatrixMVF(const int m, const int n, CMatrixComplex &a,
                                int ia, int ja, int opa, al_complex &x[],
                                int ix, al_complex &y[], int iy) {

  return (false);
}

static bool CAblasF::RMatrixMVF(const int m, const int n, CMatrixDouble &a,
                                int ia, int ja, int opa, double &x[], int ix,
                                double &y[], int iy) {

  return (false);
}

static bool CAblasF::CMatrixRightTrsMF(const int m, const int n,
                                       CMatrixComplex &a, const int i1, int j1,
                                       const bool isupper, bool isunit,
                                       int optype, CMatrixComplex &x, int i2,
                                       int j2) {

  return (false);
}

static bool CAblasF::CMatrixLeftTrsMF(const int m, const int n,
                                      CMatrixComplex &a, const int i1, int j1,
                                      const bool isupper, bool isunit,
                                      int optype, CMatrixComplex &x, int i2,
                                      int j2) {

  return (false);
}

static bool CAblasF::RMatrixRightTrsMF(const int m, const int n,
                                       CMatrixDouble &a, const int i1, int j1,
                                       const bool isupper, bool isunit,
                                       int optype, CMatrixDouble &x, int i2,
                                       int j2) {

  return (false);
}

static bool CAblasF::RMatrixLeftTrsMF(const int m, const int n,
                                      CMatrixDouble &a, const int i1, int j1,
                                      const bool isupper, bool isunit,
                                      int optype, CMatrixDouble &x, int i2,
                                      int j2) {

  return (false);
}

static bool CAblasF::CMatrixSyrkF(const int n, int k, double alpha,
                                  CMatrixComplex &a, int ia, int ja,
                                  int optypea, double beta, CMatrixComplex &c,
                                  int ic, int jc, bool isupper) {

  return (false);
}

static bool CAblasF::RMatrixSyrkF(const int n, int k, double alpha,
                                  CMatrixDouble &a, int ia, int ja, int optypea,
                                  double beta, CMatrixDouble &c, int ic, int jc,
                                  bool isupper) {

  return (false);
}

static bool CAblasF::RMatrixGemmF(const int m, const int n, int k, double alpha,
                                  CMatrixDouble &a, int ia, int ja, int optypea,
                                  CMatrixDouble &b, int ib, int jb, int optypeb,
                                  double beta, CMatrixDouble &c, int ic,
                                  int jc) {

  return (false);
}

static bool CAblasF::CMatrixGemmF(const int m, const int n, int k,
                                  al_complex &alpha, CMatrixComplex &a, int ia,
                                  int ja, int optypea, CMatrixComplex &b,
                                  int ib, int jb, int optypeb, al_complex &beta,
                                  CMatrixComplex &c, int ic, int jc) {

  return (false);
}

class CBlas {
public:
  CBlas(void);
  ~CBlas(void);

  static double VectorNorm2(double &x[], const int i1, const int i2);
  static int VectorIdxAbsMax(double &x[], const int i1, const int i2);
  static int ColumnIdxAbsMax(CMatrixDouble &x, const int i1, const int i2,
                             const int j);
  static int RowIdxAbsMax(CMatrixDouble &x, const int j1, const int j2,
                          const int i);
  static double UpperHessenberg1Norm(CMatrixDouble &a, const int i1,
                                     const int i2, const int j1, const int j2,
                                     double &work[]);
  static void CopyMatrix(CMatrixDouble &a, const int is1, const int is2,
                         const int js1, const int js2, CMatrixDouble &b,
                         const int id1, const int id2, const int jd1,
                         const int jd2);
  static void InplaceTranspose(CMatrixDouble &a, const int i1, const int i2,
                               const int j1, const int j2, double &work[]);
  static void CopyAndTranspose(CMatrixDouble &a, const int is1, const int is2,
                               const int js1, const int js2, CMatrixDouble &b,
                               const int id1, const int id2, const int jd1,
                               const int jd2);
  static void MatrixVectorMultiply(CMatrixDouble &a, const int i1, const int i2,
                                   const int j1, const int j2, const bool trans,
                                   double &x[], const int ix1, const int ix2,
                                   const double alpha, double &y[],
                                   const int iy1, const int iy2,
                                   const double beta);
  static double PyThag2(double x, double y);
  static void MatrixMatrixMultiply(
      CMatrixDouble &a, const int ai1, const int ai2, const int aj1,
      const int aj2, const bool transa, CMatrixDouble &b, const int bi1,
      const int bi2, const int bj1, const int bj2, const bool transb,
      const double alpha, CMatrixDouble &c, const int ci1, const int ci2,
      const int cj1, const int cj2, const double beta, double &work[]);
};

CBlas::CBlas(void) {}

CBlas::~CBlas(void) {}

static double CBlas::VectorNorm2(double &x[], const int i1, const int i2) {

  int n = i2 - i1 + 1;
  int ix = 0;
  double absxi = 0;
  double scl = 0;
  double ssq = 1;

  if (n < 1)
    return (0);

  if (n == 1)
    return (MathAbs(x[i1]));

  for (ix = i1; ix <= i2; ix++) {

    if (x[ix] != 0.0) {
      absxi = MathAbs(x[ix]);

      if (scl < absxi) {
        ssq = 1 + ssq * CMath::Sqr(scl / absxi);
        scl = absxi;
      } else
        ssq = ssq + CMath::Sqr(absxi / scl);
    }
  }

  return (scl * MathSqrt(ssq));
}

static int CBlas::VectorIdxAbsMax(double &x[], const int i1, const int i2) {

  int i = 0;
  double a = 0;
  int result = i1;

  a = MathAbs(x[result]);
  for (i = i1 + 1; i <= i2; i++) {

    if (MathAbs(x[i]) > MathAbs(x[result]))
      result = i;
  }

  return (result);
}

static int CBlas::ColumnIdxAbsMax(CMatrixDouble &x, const int i1, const int i2,
                                  const int j) {

  int result = i1;
  int i = 0;
  double a = 0;

  a = MathAbs(x[result][j]);
  for (i = i1 + 1; i <= i2; i++) {

    if (MathAbs(x[i][j]) > MathAbs(x[result][j]))
      result = i;
  }

  return (result);
}

static int CBlas::RowIdxAbsMax(CMatrixDouble &x, const int j1, const int j2,
                               const int i) {

  int result = j1;
  int j = 0;
  double a = 0;

  a = MathAbs(x[i][result]);
  for (j = j1 + 1; j <= j2; j++) {

    if (MathAbs(x[i][j]) > MathAbs(x[i][result]))
      result = j;
  }

  return (result);
}

static double CBlas::UpperHessenberg1Norm(CMatrixDouble &a, const int i1,
                                          const int i2, const int j1,
                                          const int j2, double &work[]) {

  double result = 0;
  int i = 0;
  int j = 0;

  if (!CAp::Assert(i2 - i1 == j2 - j1, __FUNCTION__ + ": I2-I1!=J2-J1!"))
    return (EMPTY_VALUE);
  for (j = j1; j <= j2; j++)
    work[j] = 0;
  for (i = i1; i <= i2; i++) {
    for (j = MathMax(j1, j1 + i - i1 - 1); j <= j2; j++)
      work[j] = work[j] + MathAbs(a[i][j]);
  }

  result = 0;
  for (j = j1; j <= j2; j++)
    result = MathMax(result, work[j]);

  return (result);
}

static void CBlas::CopyMatrix(CMatrixDouble &a, const int is1, const int is2,
                              const int js1, const int js2, CMatrixDouble &b,
                              const int id1, const int id2, const int jd1,
                              const int jd2) {

  int isrc = 0;
  int idst = 0;
  int i_ = 0;
  int i1_ = 0;

  if (is1 > is2 || js1 > js2)
    return;

  if (!CAp::Assert(is2 - is1 == id2 - id1, __FUNCTION__ + ": different sizes!"))
    return;

  if (!CAp::Assert(js2 - js1 == jd2 - jd1, __FUNCTION__ + ": different sizes!"))
    return;

  for (isrc = is1; isrc <= is2; isrc++) {
    idst = isrc - is1 + id1;
    i1_ = js1 - jd1;
    for (i_ = jd1; i_ <= jd2; i_++)
      b[idst].Set(i_, a[isrc][i_ + i1_]);
  }
}

static void CBlas::InplaceTranspose(CMatrixDouble &a, const int i1,
                                    const int i2, const int j1, const int j2,
                                    double &work[]) {

  int i = 0;
  int j = 0;
  int ips = 0;
  int jps = 0;
  int l = 0;
  int i_ = 0;
  int i1_ = 0;

  if (i1 > i2 || j1 > j2)
    return;

  if (!CAp::Assert(i1 - i2 == j1 - j2,
                   __FUNCTION__ + ": incorrect array size!"))
    return;
  for (i = i1; i <= i2 - 1; i++) {

    j = j1 + i - i1;
    ips = i + 1;
    jps = j1 + ips - i1;
    l = i2 - i;
    i1_ = ips - 1;

    for (i_ = 1; i_ <= l; i_++)
      work[i_] = a[i_ + i1_][j];
    i1_ = jps - ips;
    for (i_ = ips; i_ <= i2; i_++)
      a[i_].Set(j, a[i][i_ + i1_]);
    i1_ = 1 - jps;
    for (i_ = jps; i_ <= j2; i_++)
      a[i].Set(i_, work[i_ + i1_]);
  }
}

static void CBlas::CopyAndTranspose(CMatrixDouble &a, const int is1,
                                    const int is2, const int js1, const int js2,
                                    CMatrixDouble &b, const int id1,
                                    const int id2, const int jd1,
                                    const int jd2) {

  int isrc = 0;
  int jdst = 0;
  int i_ = 0;
  int i1_ = 0;

  if (is1 > is2 || js1 > js2)
    return;

  if (!CAp::Assert(is2 - is1 == jd2 - jd1, __FUNCTION__ + ": different sizes!"))
    return;

  if (!CAp::Assert(js2 - js1 == id2 - id1, __FUNCTION__ + ": different sizes!"))
    return;

  for (isrc = is1; isrc <= is2; isrc++) {
    jdst = isrc - is1 + jd1;
    i1_ = js1 - id1;
    for (i_ = id1; i_ <= id2; i_++)
      b[i_].Set(jdst, a[isrc][i_ + i1_]);
  }
}

static void CBlas::MatrixVectorMultiply(CMatrixDouble &a, const int i1,
                                        const int i2, const int j1,
                                        const int j2, const bool trans,
                                        double &x[], const int ix1,
                                        const int ix2, const double alpha,
                                        double &y[], const int iy1,
                                        const int iy2, const double beta) {

  int i = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!trans) {

    if (i1 > i2 || j1 > j2)
      return;

    if (!CAp::Assert(j2 - j1 == ix2 - ix1,
                     __FUNCTION__ + ": A and X dont match!"))
      return;

    if (!CAp::Assert(i2 - i1 == iy2 - iy1,
                     __FUNCTION__ + ": A and Y dont match!"))
      return;

    if (beta == 0.0) {
      for (i = iy1; i <= iy2; i++)
        y[i] = 0;
    } else {
      for (i_ = iy1; i_ <= iy2; i_++)
        y[i_] = beta * y[i_];
    }

    for (i = i1; i <= i2; i++) {
      i1_ = ix1 - j1;
      v = 0.0;
      for (i_ = j1; i_ <= j2; i_++)
        v += a[i][i_] * x[i_ + i1_];
      y[iy1 + i - i1] = y[iy1 + i - i1] + alpha * v;
    }
  } else {

    if (i1 > i2 || j1 > j2)
      return;

    if (!CAp::Assert(i2 - i1 == ix2 - ix1,
                     "MatrixVectorMultiply: A and X dont match!"))
      return;

    if (!CAp::Assert(j2 - j1 == iy2 - iy1,
                     "MatrixVectorMultiply: A and Y dont match!"))
      return;

    if (beta == 0.0) {
      for (i = iy1; i <= iy2; i++)
        y[i] = 0;
    } else {
      for (i_ = iy1; i_ <= iy2; i_++)
        y[i_] = beta * y[i_];
    }

    for (i = i1; i <= i2; i++) {
      v = alpha * x[ix1 + i - i1];
      i1_ = j1 - iy1;
      for (i_ = iy1; i_ <= iy2; i_++)
        y[i_] = y[i_] + v * a[i][i_ + i1_];
    }
  }
}

static double CBlas::PyThag2(double x, double y) {

  double result = 0;
  double w = 0;
  double xabs = 0;
  double yabs = 0;
  double z = 0;

  xabs = MathAbs(x);
  yabs = MathAbs(y);
  w = MathMax(xabs, yabs);
  z = MathMin(xabs, yabs);

  if (z == 0.0)
    result = w;
  else
    result = w * MathSqrt(1 + CMath::Sqr(z / w));

  return (result);
}

static void CBlas::MatrixMatrixMultiply(
    CMatrixDouble &a, const int ai1, const int ai2, const int aj1,
    const int aj2, const bool transa, CMatrixDouble &b, const int bi1,
    const int bi2, const int bj1, const int bj2, const bool transb,
    const double alpha, CMatrixDouble &c, const int ci1, const int ci2,
    const int cj1, const int cj2, const double beta, double &work[]) {

  int arows = 0;
  int acols = 0;
  int brows = 0;
  int bcols = 0;
  int crows = 0;
  int ccols = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int l = 0;
  int r = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!transa) {
    arows = ai2 - ai1 + 1;
    acols = aj2 - aj1 + 1;
  } else {
    arows = aj2 - aj1 + 1;
    acols = ai2 - ai1 + 1;
  }

  if (!transb) {
    brows = bi2 - bi1 + 1;
    bcols = bj2 - bj1 + 1;
  } else {
    brows = bj2 - bj1 + 1;
    bcols = bi2 - bi1 + 1;
  }

  if (!CAp::Assert(acols == brows, __FUNCTION__ + ": incorrect matrix sizes!"))
    return;

  if (arows <= 0 || acols <= 0 || brows <= 0 || bcols <= 0)
    return;
  crows = arows;
  ccols = bcols;

  i = MathMax(arows, acols);
  i = MathMax(brows, i);
  i = MathMax(i, bcols);
  work[1] = 0;
  work[i] = 0;

  if (beta == 0.0) {
    for (i = ci1; i <= ci2; i++)
      for (j = cj1; j <= cj2; j++)
        c[i].Set(j, 0);
  } else {
    for (i = ci1; i <= ci2; i++)
      for (i_ = cj1; i_ <= cj2; i_++)
        c[i].Set(i_, beta * c[i][i_]);
  }

  if (!transa && !transb) {
    for (l = ai1; l <= ai2; l++) {
      for (r = bi1; r <= bi2; r++) {

        v = alpha * a[l][aj1 + r - bi1];
        k = ci1 + l - ai1;
        i1_ = bj1 - cj1;
        for (i_ = cj1; i_ <= cj2; i_++)
          c[k].Set(i_, c[k][i_] + v * b[r][i_ + i1_]);
      }
    }

    return;
  }

  if (!transa && transb) {

    if (arows * acols < brows * bcols) {
      for (r = bi1; r <= bi2; r++) {
        for (l = ai1; l <= ai2; l++) {

          i1_ = bj1 - aj1;
          v = 0.0;
          for (i_ = aj1; i_ <= aj2; i_++)
            v += a[l][i_] * b[r][i_ + i1_];
          c[ci1 + l - ai1].Set(cj1 + r - bi1,
                               c[ci1 + l - ai1][cj1 + r - bi1] + alpha * v);
        }
      }

      return;
    } else {
      for (l = ai1; l <= ai2; l++) {
        for (r = bi1; r <= bi2; r++) {

          i1_ = bj1 - aj1;
          v = 0.0;
          for (i_ = aj1; i_ <= aj2; i_++)
            v += a[l][i_] * b[r][i_ + i1_];
          c[ci1 + l - ai1].Set(cj1 + r - bi1,
                               c[ci1 + l - ai1][cj1 + r - bi1] + alpha * v);
        }
      }

      return;
    }
  }

  if (transa && !transb) {
    for (l = aj1; l <= aj2; l++) {
      for (r = bi1; r <= bi2; r++) {

        v = alpha * a[ai1 + r - bi1][l];
        k = ci1 + l - aj1;
        i1_ = bj1 - cj1;
        for (i_ = cj1; i_ <= cj2; i_++)
          c[k].Set(i_, c[k][i_] + v * b[r][i_ + i1_]);
      }
    }

    return;
  }

  if (transa && transb) {

    if (arows * acols < brows * bcols) {
      for (r = bi1; r <= bi2; r++) {
        k = cj1 + r - bi1;
        for (i = 1; i <= crows; i++)
          work[i] = 0.0;
        for (l = ai1; l <= ai2; l++) {

          v = alpha * b[r][bj1 + l - ai1];
          i1_ = aj1 - 1;
          for (i_ = 1; i_ <= crows; i_++)
            work[i_] = work[i_] + v * a[l][i_ + i1_];
        }
        i1_ = 1 - ci1;
        for (i_ = ci1; i_ <= ci2; i_++)
          c[i_].Set(k, c[i_][k] + work[i_ + i1_]);
      }

      return;
    } else {
      for (l = aj1; l <= aj2; l++) {
        k = ai2 - ai1 + 1;
        i1_ = ai1 - 1;
        for (i_ = 1; i_ <= k; i_++)
          work[i_] = a[i_ + i1_][l];
        for (r = bi1; r <= bi2; r++) {

          i1_ = bj1 - 1;
          v = 0.0;
          for (i_ = 1; i_ <= k; i_++)
            v += work[i_] * b[r][i_ + i1_];
          c[ci1 + l - aj1].Set(cj1 + r - bi1,
                               c[ci1 + l - aj1][cj1 + r - bi1] + alpha * v);
        }
      }
    }
  }

  return;
}

class CHblas {
public:
  CHblas(void);
  ~CHblas(void);

  static void HermitianMatrixVectorMultiply(CMatrixComplex &a,
                                            const bool isupper, const int i1,
                                            const int i2, al_complex &x[],
                                            al_complex &alpha, al_complex &y[]);
  static void HermitianRank2Update(CMatrixComplex &a, const bool isupper,
                                   const int i1, const int i2, al_complex &x[],
                                   al_complex &y[], al_complex &t[],
                                   al_complex &alpha);
};

CHblas::CHblas(void) {}

CHblas::~CHblas(void) {}

static void CHblas::HermitianMatrixVectorMultiply(
    CMatrixComplex &a, const bool isupper, const int i1, const int i2,
    al_complex &x[], al_complex &alpha, al_complex &y[]) {

  int i = 0;
  int ba1 = 0;
  int ba2 = 0;
  int by1 = 0;
  int by2 = 0;
  int bx1 = 0;
  int bx2 = 0;
  int n = i2 - i1 + 1;
  int i_ = 0;
  int i1_ = 0;
  al_complex v = 0;

  if (n <= 0)
    return;

  for (i = i1; i <= i2; i++)
    y[i - i1 + 1] = a[i][i] * x[i - i1 + 1];

  if (isupper) {
    for (i = i1; i <= i2 - 1; i++) {

      v = x[i - i1 + 1];
      by1 = i - i1 + 2;
      by2 = n;
      ba1 = i + 1;
      ba2 = i2;
      i1_ = ba1 - by1;
      for (i_ = by1; i_ <= by2; i_++)
        y[i_] = y[i_] + v * CMath::Conj(a[i][i_ + i1_]);

      bx1 = i - i1 + 2;
      bx2 = n;
      ba1 = i + 1;
      ba2 = i2;
      i1_ = ba1 - bx1;
      v = 0.0;
      for (i_ = bx1; i_ <= bx2; i_++)
        v += x[i_] * a[i][i_ + i1_];
      y[i - i1 + 1] = y[i - i1 + 1] + v;
    }
  } else {
    for (i = i1 + 1; i <= i2; i++) {

      bx1 = 1;
      bx2 = i - i1;
      ba1 = i1;
      ba2 = i - 1;
      i1_ = ba1 - bx1;
      v = 0.0;
      for (i_ = bx1; i_ <= bx2; i_++)
        v += x[i_] * a[i][i_ + i1_];
      y[i - i1 + 1] = y[i - i1 + 1] + v;

      v = x[i - i1 + 1];
      by1 = 1;
      by2 = i - i1;
      ba1 = i1;
      ba2 = i - 1;
      i1_ = ba1 - by1;

      for (i_ = by1; i_ <= by2; i_++)
        y[i_] = y[i_] + v * CMath::Conj(a[i][i_ + i1_]);
    }
  }

  for (i_ = 1; i_ <= n; i_++)
    y[i_] = alpha * y[i_];
}

static void CHblas::HermitianRank2Update(CMatrixComplex &a, const bool isupper,
                                         const int i1, const int i2,
                                         al_complex &x[], al_complex &y[],
                                         al_complex &t[], al_complex &alpha) {

  int i = 0;
  int tp1 = 0;
  int tp2 = 0;
  al_complex v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (isupper) {
    for (i = i1; i <= i2; i++) {

      tp1 = i + 1 - i1;
      tp2 = i2 - i1 + 1;
      v = alpha * x[i + 1 - i1];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = v * CMath::Conj(y[i_]);
      v = CMath::Conj(alpha) * y[i + 1 - i1];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = t[i_] + v * CMath::Conj(x[i_]);
      i1_ = tp1 - i;

      for (i_ = i; i_ <= i2; i_++)
        a[i].Set(i_, a[i][i_] + t[i_ + i1_]);
    }
  } else {
    for (i = i1; i <= i2; i++) {

      tp1 = 1;
      tp2 = i + 1 - i1;
      v = alpha * x[i + 1 - i1];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = v * CMath::Conj(y[i_]);
      v = CMath::Conj(alpha) * y[i + 1 - i1];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = t[i_] + v * CMath::Conj(x[i_]);
      i1_ = tp1 - i1;

      for (i_ = i1; i_ <= i; i_++)
        a[i].Set(i_, a[i][i_] + t[i_ + i1_]);
    }
  }
}

class CReflections {
public:
  CReflections(void);
  ~CReflections(void);

  static void GenerateReflection(double &x[], const int n, double &tau);
  static void ApplyReflectionFromTheLeft(CMatrixDouble &c, const double tau,
                                         const double &v[], const int m1,
                                         const int m2, const int n1,
                                         const int n2, double &work[]);
  static void ApplyReflectionFromTheRight(CMatrixDouble &c, const double tau,
                                          const double &v[], const int m1,
                                          const int m2, const int n1,
                                          const int n2, double &work[]);
};

CReflections::CReflections(void) {}

CReflections::~CReflections(void) {}

static void CReflections::GenerateReflection(double &x[], const int n,
                                             double &tau) {

  if (n <= 1) {
    tau = 0;

    return;
  }

  int j = 0;
  double alpha = 0;
  double xnorm = 0;
  double v = 0;
  double beta = 0;
  double mx = 0;
  double s = 0;
  int i_ = 0;

  for (j = 1; j <= n; j++)
    mx = MathMax(MathAbs(x[j]), mx);
  s = 1;

  if (mx != 0.0) {

    if (mx <= CMath::m_minrealnumber / CMath::m_machineepsilon) {

      s = CMath::m_minrealnumber / CMath::m_machineepsilon;
      v = 1 / s;

      for (i_ = 1; i_ <= n; i_++)
        x[i_] = v * x[i_];
      mx = mx * v;
    } else {

      if (mx >= CMath::m_maxrealnumber * CMath::m_machineepsilon) {

        s = CMath::m_maxrealnumber * CMath::m_machineepsilon;
        v = 1 / s;

        for (i_ = 1; i_ <= n; i_++)
          x[i_] = v * x[i_];
        mx = mx * v;
      }
    }
  }

  alpha = x[1];
  xnorm = 0;

  if (mx != 0.0) {
    for (j = 2; j <= n; j++)
      xnorm = xnorm + CMath::Sqr(x[j] / mx);
    xnorm = MathSqrt(xnorm) * mx;
  }

  if (xnorm == 0.0) {

    tau = 0;
    x[1] = x[1] * s;

    return;
  }

  mx = MathMax(MathAbs(alpha), MathAbs(xnorm));
  beta = -(mx * MathSqrt(CMath::Sqr(alpha / mx) + CMath::Sqr(xnorm / mx)));

  if (alpha < 0.0)
    beta = -beta;

  tau = (beta - alpha) / beta;
  v = 1 / (alpha - beta);

  for (i_ = 2; i_ <= n; i_++)
    x[i_] = v * x[i_];
  x[1] = beta;

  x[1] = x[1] * s;
}

static void CReflections::ApplyReflectionFromTheLeft(
    CMatrixDouble &c, const double tau, const double &v[], const int m1,
    const int m2, const int n1, const int n2, double &work[]) {

  if (tau == 0.0 || n1 > n2 || m1 > m2)
    return;

  double t = 0;
  int i = 0;
  int vm = 0;
  int i_ = 0;

  vm = m2 - m1 + 1;
  for (i = n1; i <= n2; i++)
    work[i] = 0;
  for (i = m1; i <= m2; i++) {
    t = v[i + 1 - m1];

    for (i_ = n1; i_ <= n2; i_++)
      work[i_] += t * c[i][i_];
  }

  for (i = m1; i <= m2; i++) {
    t = v[i - m1 + 1] * tau;
    for (i_ = n1; i_ <= n2; i_++)
      c[i].Set(i_, c[i][i_] - t * work[i_]);
  }
}

static void CReflections::ApplyReflectionFromTheRight(
    CMatrixDouble &c, const double tau, const double &v[], const int m1,
    const int m2, const int n1, const int n2, double &work[]) {

  if (tau == 0.0 || n1 > n2 || m1 > m2)
    return;

  double t = 0;
  int i = 0;
  int vm = n2 - n1 + 1;
  int i_ = 0;
  int i1_ = 0;

  for (i = m1; i <= m2; i++) {
    i1_ = 1 - n1;
    t = 0.0;

    for (i_ = n1; i_ <= n2; i_++)
      t += c[i][i_] * v[i_ + i1_];
    t = t * tau;
    i1_ = 1 - n1;
    for (i_ = n1; i_ <= n2; i_++)
      c[i].Set(i_, c[i][i_] - t * v[i_ + i1_]);
  }
}

class CComplexReflections {
public:
  void CComplexReflections(void);
  void ~CComplexReflections(void);

  static void ComplexGenerateReflection(al_complex &x[], const int n,
                                        al_complex &tau);
  static void ComplexApplyReflectionFromTheLeft(
      CMatrixComplex &c, al_complex &tau, al_complex &v[], const int m1,
      const int m2, const int n1, const int n2, al_complex &work[]);
  static void ComplexApplyReflectionFromTheRight(
      CMatrixComplex &c, al_complex &tau, al_complex &v[], const int m1,
      const int m2, const int n1, const int n2, al_complex &work[]);
};

CComplexReflections::CComplexReflections(void) {}

CComplexReflections::~CComplexReflections(void) {}

static void CComplexReflections::ComplexGenerateReflection(al_complex &x[],
                                                           const int n,
                                                           al_complex &tau) {

  if (n <= 0) {
    tau = 0;

    return;
  }

  int j = 0;
  al_complex alpha = 0;
  double alphi = 0;
  double alphr = 0;
  double beta = 0;
  double xnorm = 0;
  double mx = 0;
  al_complex t = 0;
  double s = 1;
  al_complex v = 0;
  int i_ = 0;
  al_complex One(1, 0);

  for (j = 1; j <= n; j++)
    mx = MathMax(CMath::AbsComplex(x[j]), mx);

  if (mx != 0) {

    if (mx < 1) {
      s = MathSqrt(CMath::m_minrealnumber);
      v = 1 / s;

      for (i_ = 1; i_ <= n; i_++)
        x[i_] = v * x[i_];
    } else {
      s = MathSqrt(CMath::m_maxrealnumber);
      v = 1 / s;

      for (i_ = 1; i_ <= n; i_++)
        x[i_] = v * x[i_];
    }
  }

  alpha = x[1];
  mx = 0;
  for (j = 2; j <= n; j++)
    mx = MathMax(CMath::AbsComplex(x[j]), mx);
  xnorm = 0;

  if (mx != 0) {
    for (j = 2; j <= n; j++) {
      t = x[j] / mx;
      xnorm = xnorm + (t * CMath::Conj(t)).re;
    }
    xnorm = MathSqrt(xnorm) * mx;
  }

  alphr = alpha.re;
  alphi = alpha.im;

  if ((xnorm == 0) && (alphi == 0)) {
    tau = 0;
    x[1] = x[1] * s;

    return;
  }

  mx = MathMax(MathAbs(alphr), MathAbs(alphi));
  mx = MathMax(mx, MathAbs(xnorm));
  beta = -(mx * MathSqrt(CMath::Sqr(alphr / mx) + CMath::Sqr(alphi / mx) +
                         CMath::Sqr(xnorm / mx)));

  if (alphr < 0)
    beta = -beta;

  tau.re = (beta - alphr) / beta;
  tau.im = -(alphi / beta);
  alpha = One / (alpha - beta);

  if (n > 1) {

    for (i_ = 2; i_ <= n; i_++)
      x[i_] = alpha * x[i_];
  }
  alpha = beta;
  x[1] = alpha;

  x[1] = x[1] * s;
}

static void CComplexReflections::ComplexApplyReflectionFromTheLeft(
    CMatrixComplex &c, al_complex &tau, al_complex &v[], const int m1,
    const int m2, const int n1, const int n2, al_complex &work[]) {
  al_complex Zero(0, 0);

  if (tau == Zero || n1 > n2 || m1 > m2)
    return;

  al_complex t = 0;
  int i = 0;
  int vm = 0;
  int i_ = 0;

  vm = m2 - m1 + 1;
  for (i = n1; i <= n2; i++)
    work[i] = 0;
  for (i = m1; i <= m2; i++) {
    t = CMath::Conj(v[i + 1 - m1]);
    for (i_ = n1; i_ <= n2; i_++)
      work[i_] = work[i_] + t * c[i][i_];
  }

  for (i = m1; i <= m2; i++) {
    t = v[i - m1 + 1] * tau;
    for (i_ = n1; i_ <= n2; i_++)
      c[i].Set(i_, c[i][i_] - t * work[i_]);
  }
}

static void CComplexReflections::ComplexApplyReflectionFromTheRight(
    CMatrixComplex &c, al_complex &tau, al_complex &v[], const int m1,
    const int m2, const int n1, const int n2, al_complex &work[]) {
  al_complex Zero(0, 0);

  if (tau == Zero || n1 > n2 || m1 > m2)
    return;

  al_complex t = 0;
  int i = 0;
  int vm = 0;
  int i_ = 0;
  int i1_ = 0;

  vm = n2 - n1 + 1;
  for (i = m1; i <= m2; i++) {
    i1_ = 1 - n1;
    t = 0.0;

    for (i_ = n1; i_ <= n2; i_++)
      t += c[i][i_] * v[i_ + i1_];
    work[i] = t;
  }

  for (i_ = 1; i_ <= vm; i_++)
    v[i_] = CMath::Conj(v[i_]);

  for (i = m1; i <= m2; i++) {
    t = work[i] * tau;
    i1_ = 1 - n1;
    for (i_ = n1; i_ <= n2; i_++)
      c[i].Set(i_, c[i][i_] - t * v[i_ + i1_]);
  }
  for (i_ = 1; i_ <= vm; i_++)
    v[i_] = CMath::Conj(v[i_]);
}

class CSblas {
public:
  CSblas(void);
  ~CSblas(void);

  static void SymmetricMatrixVectorMultiply(const CMatrixDouble &a,
                                            const bool isupper, const int i1,
                                            const int i2, const double &x[],
                                            const double alpha, double &y[]);
  static void SymmetricRank2Update(CMatrixDouble &a, const bool isupper,
                                   const int i1, const int i2,
                                   const double &x[], const double &y[],
                                   double &t[], const double alpha);
};

CSblas::CSblas(void) {}

CSblas::~CSblas(void) {}

static void CSblas::SymmetricMatrixVectorMultiply(
    const CMatrixDouble &a, const bool isupper, const int i1, const int i2,
    const double &x[], const double alpha, double &y[]) {

  int i = 0;
  int ba1 = 0;
  int ba2 = 0;
  int by1 = 0;
  int by2 = 0;
  int bx1 = 0;
  int bx2 = 0;
  int n = i2 - i1 + 1;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (n <= 0)
    return;

  for (i = i1; i <= i2; i++)
    y[i - i1 + 1] = a[i][i] * x[i - i1 + 1];

  if (isupper) {
    for (i = i1; i < i2; i++) {

      v = x[i - i1 + 1];
      by1 = i - i1 + 2;
      by2 = n;
      ba1 = i + 1;
      ba2 = i2;
      i1_ = ba1 - by1;
      for (i_ = by1; i_ <= by2; i_++)
        y[i_] = y[i_] + v * a[i][i_ + i1_];

      bx1 = i - i1 + 2;
      bx2 = n;
      ba1 = i + 1;
      ba2 = i2;
      i1_ = ba1 - bx1;
      v = 0.0;
      for (i_ = bx1; i_ <= bx2; i_++)
        v += x[i_] * a[i][i_ + i1_];
      y[i - i1 + 1] = y[i - i1 + 1] + v;
    }
  } else {
    for (i = i1 + 1; i <= i2; i++) {

      bx1 = 1;
      bx2 = i - i1;
      ba1 = i1;
      ba2 = i - 1;
      i1_ = (ba1) - (bx1);
      v = 0.0;
      for (i_ = bx1; i_ <= bx2; i_++)
        v += x[i_] * a[i][i_ + i1_];
      y[i - i1 + 1] = y[i - i1 + 1] + v;

      v = x[i - i1 + 1];
      by1 = 1;
      by2 = i - i1;
      ba1 = i1;
      ba2 = i - 1;
      i1_ = ba1 - by1;
      for (i_ = by1; i_ <= by2; i_++)
        y[i_] = y[i_] + v * a[i][i_ + i1_];
    }
  }

  for (i_ = 1; i_ <= n; i_++)
    y[i_] = alpha * y[i_];
}

static void CSblas::SymmetricRank2Update(CMatrixDouble &a, const bool isupper,
                                         const int i1, const int i2,
                                         const double &x[], const double &y[],
                                         double &t[], const double alpha) {

  int i = 0;
  int tp1 = 0;
  int tp2 = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (isupper) {
    for (i = i1; i <= i2; i++) {

      tp1 = i + 1 - i1;
      tp2 = i2 - i1 + 1;
      v = x[i + 1 - i1];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = v * y[i_];
      v = y[i + 1 - i1];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = t[i_] + v * x[i_];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = alpha * t[i_];
      i1_ = tp1 - i;

      for (i_ = i; i_ <= i2; i_++)
        a[i].Set(i_, a[i][i_] + t[i_ + i1_]);
    }
  } else {
    for (i = i1; i <= i2; i++) {

      tp1 = 1;
      tp2 = i + 1 - i1;
      v = x[i + 1 - i1];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = v * y[i_];
      v = y[i + 1 - i1];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = t[i_] + v * x[i_];

      for (i_ = tp1; i_ <= tp2; i_++)
        t[i_] = alpha * t[i_];
      i1_ = tp1 - i1;

      for (i_ = i1; i_ <= i; i_++)
        a[i].Set(i_, a[i][i_] + t[i_ + i1_]);
    }
  }
}

class CRotations {
public:
  CRotations(void);
  ~CRotations(void);

  static void ApplyRotationsFromTheLeft(const bool isforward, const int m1,
                                        const int m2, const int n1,
                                        const int n2, double &c[], double &s[],
                                        CMatrixDouble &a, double &work[]);
  static void ApplyRotationsFromTheRight(const bool isforward, const int m1,
                                         const int m2, const int n1,
                                         const int n2, double &c[], double &s[],
                                         CMatrixDouble &a, double &work[]);
  static void GenerateRotation(const double f, const double g, double &cs,
                               double &sn, double &r);
};

CRotations::CRotations(void) {}

CRotations::~CRotations(void) {}

static void CRotations::ApplyRotationsFromTheLeft(
    const bool isforward, const int m1, const int m2, const int n1,
    const int n2, double &c[], double &s[], CMatrixDouble &a, double &work[]) {

  int j = 0;
  int jp1 = 0;
  double ctemp = 0;
  double stemp = 0;
  double temp = 0;
  int i_ = 0;

  if (m1 > m2 || n1 > n2)
    return;

  if (isforward) {

    if (n1 != n2) {

      for (j = m1; j < m2; j++) {
        ctemp = c[j - m1 + 1];
        stemp = s[j - m1 + 1];

        if (ctemp != 1.0 || stemp != 0.0) {
          jp1 = j + 1;

          for (i_ = n1; i_ <= n2; i_++)
            work[i_] = ctemp * a[jp1][i_];
          for (i_ = n1; i_ <= n2; i_++)
            work[i_] = work[i_] - stemp * a[j][i_];

          for (i_ = n1; i_ <= n2; i_++)
            a[j].Set(i_, ctemp * a[j][i_]);
          for (i_ = n1; i_ <= n2; i_++)
            a[j].Set(i_, a[j][i_] + stemp * a[jp1][i_]);
          for (i_ = n1; i_ <= n2; i_++)
            a[jp1].Set(i_, work[i_]);
        }
      }
    } else {

      for (j = m1; j < m2; j++) {
        ctemp = c[j - m1 + 1];
        stemp = s[j - m1 + 1];

        if (ctemp != 1.0 || stemp != 0.0) {
          temp = a[j + 1][n1];

          a[j + 1].Set(n1, ctemp * temp - stemp * a[j][n1]);
          a[j].Set(n1, stemp * temp + ctemp * a[j][n1]);
        }
      }
    }
  } else {
    if (n1 != n2) {

      for (j = m2 - 1; j >= m1; j--) {
        ctemp = c[j - m1 + 1];
        stemp = s[j - m1 + 1];

        if (ctemp != 1.0 || stemp != 0.0) {
          jp1 = j + 1;

          for (i_ = n1; i_ <= n2; i_++)
            work[i_] = ctemp * a[jp1][i_];
          for (i_ = n1; i_ <= n2; i_++)
            work[i_] = work[i_] - stemp * a[j][i_];
          for (i_ = n1; i_ <= n2; i_++)
            a[j].Set(i_, ctemp * a[j][i_]);

          for (i_ = n1; i_ <= n2; i_++)
            a[j].Set(i_, a[j][i_] + stemp * a[jp1][i_]);
          for (i_ = n1; i_ <= n2; i_++)
            a[jp1].Set(i_, work[i_]);
        }
      }
    } else {

      for (j = m2 - 1; j >= m1; j--) {
        ctemp = c[j - m1 + 1];
        stemp = s[j - m1 + 1];

        if (ctemp != 1.0 || stemp != 0.0) {
          temp = a[j + 1][n1];

          a[j + 1].Set(n1, ctemp * temp - stemp * a[j][n1]);
          a[j].Set(n1, stemp * temp + ctemp * a[j][n1]);
        }
      }
    }
  }
}

static void CRotations::ApplyRotationsFromTheRight(
    const bool isforward, const int m1, const int m2, const int n1,
    const int n2, double &c[], double &s[], CMatrixDouble &a, double &work[]) {

  int j = 0;
  int jp1 = 0;
  double ctemp = 0;
  double stemp = 0;
  double temp = 0;
  int i_ = 0;

  if (isforward) {

    if (m1 != m2) {

      for (j = n1; j <= n2 - 1; j++) {
        ctemp = c[j - n1 + 1];
        stemp = s[j - n1 + 1];

        if (ctemp != 1.0 || stemp != 0.0) {
          jp1 = j + 1;

          for (i_ = m1; i_ <= m2; i_++)
            work[i_] = ctemp * a[i_][jp1];
          for (i_ = m1; i_ <= m2; i_++)
            work[i_] = work[i_] - stemp * a[i_][j];

          for (i_ = m1; i_ <= m2; i_++)
            a[i_].Set(j, ctemp * a[i_][j]);
          for (i_ = m1; i_ <= m2; i_++)
            a[i_].Set(j, a[i_][j] + stemp * a[i_][jp1]);
          for (i_ = m1; i_ <= m2; i_++)
            a[i_].Set(jp1, work[i_]);
        }
      }
    } else {

      for (j = n1; j <= n2 - 1; j++) {
        ctemp = c[j - n1 + 1];
        stemp = s[j - n1 + 1];

        if (ctemp != 1.0 || stemp != 0.0) {
          temp = a[m1][j + 1];

          a[m1].Set(j + 1, ctemp * temp - stemp * a[m1][j]);
          a[m1].Set(j, stemp * temp + ctemp * a[m1][j]);
        }
      }
    }
  } else {

    if (m1 != m2) {

      for (j = n2 - 1; j >= n1; j--) {
        ctemp = c[j - n1 + 1];
        stemp = s[j - n1 + 1];

        if (ctemp != 1.0 || stemp != 0.0) {
          jp1 = j + 1;

          for (i_ = m1; i_ <= m2; i_++)
            work[i_] = ctemp * a[i_][jp1];
          for (i_ = m1; i_ <= m2; i_++)
            work[i_] = work[i_] - stemp * a[i_][j];

          for (i_ = m1; i_ <= m2; i_++)
            a[i_].Set(j, ctemp * a[i_][j]);
          for (i_ = m1; i_ <= m2; i_++)
            a[i_].Set(j, a[i_][j] + stemp * a[i_][jp1]);
          for (i_ = m1; i_ <= m2; i_++)
            a[i_].Set(jp1, work[i_]);
        }
      }
    } else {

      for (j = n2 - 1; j >= n1; j--) {
        ctemp = c[j - n1 + 1];
        stemp = s[j - n1 + 1];

        if (ctemp != 1.0 || stemp != 0.0) {
          temp = a[m1][j + 1];

          a[m1].Set(j + 1, ctemp * temp - stemp * a[m1][j]);
          a[m1].Set(j, stemp * temp + ctemp * a[m1][j]);
        }
      }
    }
  }
}

static void CRotations::GenerateRotation(const double f, const double g,
                                         double &cs, double &sn, double &r) {

  double f1 = 0;
  double g1 = 0;

  if (g == 0.0) {

    cs = 1;
    sn = 0;
    r = f;
  } else {

    if (f == 0.0) {

      cs = 0;
      sn = 1;
      r = g;
    } else {
      f1 = f;
      g1 = g;

      if (MathAbs(f1) > MathAbs(g1))
        r = MathAbs(f1) * MathSqrt(1 + CMath::Sqr(g1 / f1));
      else
        r = MathAbs(g1) * MathSqrt(1 + CMath::Sqr(f1 / g1));
      cs = f1 / r;
      sn = g1 / r;

      if (MathAbs(f) > MathAbs(g) && cs < 0.0) {

        cs = -cs;
        sn = -sn;
        r = -r;
      }
    }
  }
}

class CHsSchur {
private:
  static void InternalAuxSchur(const bool wantt, const bool wantz, const int n,
                               const int ilo, const int ihi, CMatrixDouble &h,
                               double &wr[], double &wi[], const int iloz,
                               const int ihiz, CMatrixDouble &z, double &work[],
                               double &workv3[], double &workc1[],
                               double &works1[], int &info);
  static void Aux2x2Schur(double &a, double &b, double &c, double &d,
                          double &rt1r, double &rt1i, double &rt2r,
                          double &rt2i, double &cs, double &sn);
  static double ExtSchurSign(const double a, const double b);
  static int ExtSchurSignToone(const double b);

public:
  CHsSchur(void);
  ~CHsSchur(void);

  static bool UpperHessenbergSchurDecomposition(CMatrixDouble &h, const int n,
                                                CMatrixDouble &s);
  static void InternalSchurDecomposition(CMatrixDouble &h, const int n,
                                         const int tneeded, const int zneeded,
                                         double &wr[], double &wi[],
                                         CMatrixDouble &z, int &info);
};

CHsSchur::CHsSchur(void) {}

CHsSchur::~CHsSchur(void) {}

static bool CHsSchur::UpperHessenbergSchurDecomposition(CMatrixDouble &h,
                                                        const int n,
                                                        CMatrixDouble &s) {

  bool result;
  int info = 0;

  double wi[];
  double wr[];

  InternalSchurDecomposition(h, n, 1, 2, wr, wi, s, info);
  result = info == 0;

  return (result);
}

static void CHsSchur::InternalSchurDecomposition(CMatrixDouble &h, const int n,
                                                 const int tneeded,
                                                 const int zneeded,
                                                 double &wr[], double &wi[],
                                                 CMatrixDouble &z, int &info) {

  int i = 0;
  int i1 = 0;
  int i2 = 0;
  int ierr = 0;
  int ii = 0;
  int itemp = 0;
  int itn = 0;
  int its = 0;
  int j = 0;
  int k = 0;
  int l = 0;
  int maxb = 0;
  int nr = 0;
  int ns = 0;
  int nv = 0;
  double absw = 0;
  double ovfl = 0;
  double smlnum = 0;
  double tau = 0;
  double temp = 0;
  double tst1 = 0;
  double ulp = 0;
  double unfl = 0;
  bool initz;
  bool wantt;
  bool wantz;
  double cnst = 0;
  bool failflag;
  int p1 = 0;
  int p2 = 0;
  double vt = 0;
  int i_ = 0;
  int i1_ = 0;

  double v[];
  double vv[];
  double work[];
  double workc1[];
  double works1[];
  double workv3[];
  double tmpwr[];
  double tmpwi[];
  CMatrixDouble s;

  info = 0;

  ns = 12;
  maxb = 50;

  maxb = (int)MathMax(3, maxb);
  ns = MathMin(maxb, ns);

  cnst = 1.5;

  ArrayResizeAL(work, (int)MathMax(n, 1) + 1);
  s.Resize(ns + 1, ns + 1);
  ArrayResizeAL(v, ns + 2);
  ArrayResizeAL(vv, ns + 2);
  ArrayResizeAL(wr, (int)MathMax(n, 1) + 1);
  ArrayResizeAL(wi, (int)MathMax(n, 1) + 1);
  ArrayResizeAL(workc1, 2);
  ArrayResizeAL(works1, 2);
  ArrayResizeAL(workv3, 4);
  ArrayResizeAL(tmpwr, (int)MathMax(n, 1) + 1);
  ArrayResizeAL(tmpwi, (int)MathMax(n, 1) + 1);

  if (!CAp::Assert(n >= 0, "InternalSchurDecomposition: incorrect N!"))
    return;

  if (!CAp::Assert(tneeded == 0 || tneeded == 1,
                   "InternalSchurDecomposition: incorrect TNeeded!"))
    return;

  if (!CAp::Assert((zneeded == 0 || zneeded == 1) || zneeded == 2,
                   "InternalSchurDecomposition: incorrect ZNeeded!"))
    return;

  wantt = tneeded == 1;
  initz = zneeded == 2;
  wantz = zneeded != 0;
  info = 0;

  if (initz) {
    z.Resize(n + 1, n + 1);
    for (i = 1; i <= n; i++) {
      for (j = 1; j <= n; j++) {

        if (i == j)
          z[i].Set(j, 1);
        else
          z[i].Set(j, 0);
      }
    }
  }

  if (n == 0)
    return;

  if (n == 1) {
    wr[1] = h[1][1];
    wi[1] = 0;

    return;
  }

  for (j = 1; j <= n - 2; j++)
    for (i = j + 2; i <= n; i++)
      h[i].Set(j, 0);

  if ((ns <= 2 || ns > n) || maxb >= n) {

    InternalAuxSchur(wantt, wantz, n, 1, n, h, wr, wi, 1, n, z, work, workv3,
                     workc1, works1, info);

    if (wantt) {
      j = 1;
      while (j <= n) {

        if (wi[j] == 0.0) {
          for (i = j + 1; i <= n; i++)
            h[i].Set(j, 0);
          j = j + 1;
        } else {
          for (i = j + 2; i <= n; i++) {
            h[i].Set(j, 0);
            h[i].Set(j + 1, 0);
          }
          j = j + 2;
        }
      }
    }

    return;
  }

  unfl = CMath::m_minrealnumber;
  ovfl = 1 / unfl;
  ulp = 2 * CMath::m_machineepsilon;
  smlnum = unfl * (n / ulp);

  i1 = 1;
  i2 = n;

  itn = 30 * n;

  i = n;
  while (true) {
    l = 1;

    if (i < 1) {

      if (wantt) {
        j = 1;
        while (j <= n) {

          if (wi[j] == 0.0) {
            for (i = j + 1; i <= n; i++)
              h[i].Set(j, 0);
            j = j + 1;
          } else {
            for (i = j + 2; i <= n; i++) {
              h[i].Set(j, 0);
              h[i].Set(j + 1, 0);
            }
            j = j + 2;
          }
        }
      }

      return;
    }

    failflag = true;
    for (its = 0; its <= itn; its++) {

      for (k = i; k >= l + 1; k--) {
        tst1 = MathAbs(h[k - 1][k - 1]) + MathAbs(h[k][k]);

        if (tst1 == 0.0)
          tst1 = CBlas::UpperHessenberg1Norm(h, l, i, l, i, work);

        if (MathAbs(h[k][k - 1]) <= MathMax(ulp * tst1, smlnum))
          break;
      }
      l = k;

      if (l > 1)

        h[l].Set(l - 1, 0);

      if (l >= i - maxb + 1) {
        failflag = false;
        break;
      }

      if (its == 20 || its == 30) {

        for (ii = i - ns + 1; ii <= i; ii++) {
          wr[ii] = cnst * (MathAbs(h[ii][ii - 1]) + MathAbs(h[ii][ii]));
          wi[ii] = 0;
        }
      } else {

        CBlas::CopyMatrix(h, i - ns + 1, i, i - ns + 1, i, s, 1, ns, 1, ns);

        InternalAuxSchur(false, false, ns, 1, ns, s, tmpwr, tmpwi, 1, ns, z,
                         work, workv3, workc1, works1, ierr);
        for (p1 = 1; p1 <= ns; p1++) {
          wr[i - ns + p1] = tmpwr[p1];
          wi[i - ns + p1] = tmpwi[p1];
        }

        if (ierr > 0) {

          for (ii = 1; ii <= ierr; ii++) {
            wr[i - ns + ii] = s[ii][ii];
            wi[i - ns + ii] = 0;
          }
        }
      }

      v[1] = 1;
      for (ii = 2; ii <= ns + 1; ii++)
        v[ii] = 0;
      nv = 1;
      for (j = i - ns + 1; j <= i; j++) {

        if (wi[j] >= 0.0) {

          if (wi[j] == 0.0) {

            p1 = nv + 1;
            for (i_ = 1; i_ <= p1; i_++)
              vv[i_] = v[i_];

            CBlas::MatrixVectorMultiply(h, l, l + nv, l, l + nv - 1, false, vv,
                                        1, nv, 1.0, v, 1, nv + 1, -wr[j]);
            nv = nv + 1;
          } else {

            if (wi[j] > 0.0) {

              p1 = nv + 1;
              for (i_ = 1; i_ <= p1; i_++)
                vv[i_] = v[i_];

              CBlas::MatrixVectorMultiply(h, l, l + nv, l, l + nv - 1, false, v,
                                          1, nv, 1.0, vv, 1, nv + 1,
                                          -(2 * wr[j]));

              itemp = CBlas::VectorIdxAbsMax(vv, 1, nv + 1);
              temp = 1 / MathMax(MathAbs(vv[itemp]), smlnum);
              p1 = nv + 1;
              for (i_ = 1; i_ <= p1; i_++)
                vv[i_] = temp * vv[i_];

              absw = CBlas::PyThag2(wr[j], wi[j]);
              temp = temp * absw * absw;

              CBlas::MatrixVectorMultiply(h, l, l + nv + 1, l, l + nv, false,
                                          vv, 1, nv + 1, 1.0, v, 1, nv + 2,
                                          temp);
              nv = nv + 2;
            }
          }

          itemp = CBlas::VectorIdxAbsMax(v, 1, nv);
          temp = MathAbs(v[itemp]);

          if (temp == 0.0) {
            v[1] = 1;
            for (ii = 2; ii <= nv; ii++)
              v[ii] = 0;
          } else {
            temp = MathMax(temp, smlnum);
            vt = 1 / temp;
            for (i_ = 1; i_ <= nv; i_++)
              v[i_] = vt * v[i_];
          }
        }
      }

      for (k = l; k <= i - 1; k++) {

        nr = MathMin(ns + 1, i - k + 1);

        if (k > l) {

          p1 = k - 1;
          p2 = k + nr - 1;
          i1_ = k - 1;
          for (i_ = 1; i_ <= nr; i_++)
            v[i_] = h[i_ + i1_][p1];
        }

        CReflections::GenerateReflection(v, nr, tau);

        if (k > l) {
          h[k].Set(k - 1, v[1]);
          for (ii = k + 1; ii <= i; ii++)
            h[ii].Set(k - 1, 0);
        }
        v[1] = 1;

        CReflections::ApplyReflectionFromTheLeft(h, tau, v, k, k + nr - 1, k,
                                                 i2, work);

        CReflections::ApplyReflectionFromTheRight(
            h, tau, v, i1, MathMin(k + nr, i), k, k + nr - 1, work);

        if (wantz)

          CReflections::ApplyReflectionFromTheRight(z, tau, v, 1, n, k,
                                                    k + nr - 1, work);
      }
    }

    if (failflag) {
      info = i;

      return;
    }

    InternalAuxSchur(wantt, wantz, n, l, i, h, wr, wi, 1, n, z, work, workv3,
                     workc1, works1, info);

    if (info > 0)
      return;

    itn = itn - its;
    i = l - 1;
  }
}

static void CHsSchur::InternalAuxSchur(
    const bool wantt, const bool wantz, const int n, const int ilo,
    const int ihi, CMatrixDouble &h, double &wr[], double &wi[], const int iloz,
    const int ihiz, CMatrixDouble &z, double &work[], double &workv3[],
    double &workc1[], double &works1[], int &info) {

  int i = 0;
  int i1 = 0;
  int i2 = 0;
  int itn = 0;
  int its = 0;
  int j = 0;
  int k = 0;
  int l = 0;
  int m = 0;
  int nh = 0;
  int nr = 0;
  int nz = 0;
  double ave = 0;
  double cs = 0;
  double disc = 0;
  double h00 = 0;
  double h10 = 0;
  double h11 = 0;
  double h12 = 0;
  double h21 = 0;
  double h22 = 0;
  double h33 = 0;
  double h33s = 0;
  double h43h34 = 0;
  double h44 = 0;
  double h44s = 0;
  double ovfl = 0;
  double s = 0;
  double smlnum = 0;
  double sn = 0;
  double sum = 0;
  double t1 = 0;
  double t2 = 0;
  double t3 = 0;
  double tst1 = 0;
  double unfl = 0;
  double v1 = 0;
  double v2 = 0;
  double v3 = 0;
  bool failflag;
  double dat1 = 0;
  double dat2 = 0;
  int p1 = 0;
  double him1im1 = 0;
  double him1i = 0;
  double hiim1 = 0;
  double hii = 0;
  double wrim1 = 0;
  double wri = 0;
  double wiim1 = 0;
  double wii = 0;
  double ulp = 0;

  info = 0;
  dat1 = 0.75;
  dat2 = -0.4375;
  ulp = CMath::m_machineepsilon;

  if (n == 0)
    return;

  if (ilo == ihi) {
    wr[ilo] = h[ilo][ilo];
    wi[ilo] = 0;

    return;
  }

  nh = ihi - ilo + 1;
  nz = ihiz - iloz + 1;

  unfl = CMath::m_minrealnumber;
  ovfl = 1 / unfl;
  smlnum = unfl * (nh / ulp);

  i1 = 1;
  i2 = n;

  itn = 30 * nh;

  i = ihi;
  while (true) {
    l = ilo;

    if (i < ilo)
      return;

    failflag = true;
    for (its = 0; its <= itn; its++) {

      for (k = i; k >= l + 1; k--) {
        tst1 = MathAbs(h[k - 1][k - 1]) + MathAbs(h[k][k]);

        if (tst1 == 0.0)
          tst1 = CBlas::UpperHessenberg1Norm(h, l, i, l, i, work);

        if (MathAbs(h[k][k - 1]) <= MathMax(ulp * tst1, smlnum))
          break;
      }
      l = k;

      if (l > ilo)

        h[l].Set(l - 1, 0);

      if (l >= i - 1) {
        failflag = false;
        break;
      }

      if (its == 10 || its == 20) {

        s = MathAbs(h[i][i - 1]) + MathAbs(h[i - 1][i - 2]);
        h44 = dat1 * s + h[i][i];
        h33 = h44;
        h43h34 = dat2 * s * s;
      } else {

        h44 = h[i][i];
        h33 = h[i - 1][i - 1];
        h43h34 = h[i][i - 1] * h[i - 1][i];
        s = h[i - 1][i - 2] * h[i - 1][i - 2];
        disc = (h33 - h44) * 0.5;
        disc = disc * disc + h43h34;

        if (disc > 0.0) {

          disc = MathSqrt(disc);
          ave = 0.5 * (h33 + h44);

          if (MathAbs(h33) - MathAbs(h44) > 0.0) {
            h33 = h33 * h44 - h43h34;
            h44 = h33 / (ExtSchurSign(disc, ave) + ave);
          } else
            h44 = ExtSchurSign(disc, ave) + ave;
          h33 = h44;
          h43h34 = 0;
        }
      }

      for (m = i - 2; m >= l; m--) {

        h11 = h[m][m];
        h22 = h[m + 1][m + 1];
        h21 = h[m + 1][m];
        h12 = h[m][m + 1];
        h44s = h44 - h11;
        h33s = h33 - h11;
        v1 = (h33s * h44s - h43h34) / h21 + h12;
        v2 = h22 - h11 - h33s - h44s;
        v3 = h[m + 2][m + 1];
        s = MathAbs(v1) + MathAbs(v2) + MathAbs(v3);
        v1 = v1 / s;
        v2 = v2 / s;
        v3 = v3 / s;
        workv3[1] = v1;
        workv3[2] = v2;
        workv3[3] = v3;

        if (m == l)
          break;
        h00 = h[m - 1][m - 1];
        h10 = h[m][m - 1];
        tst1 = MathAbs(v1) * (MathAbs(h00) + MathAbs(h11) + MathAbs(h22));

        if (MathAbs(h10) * (MathAbs(v2) + MathAbs(v3)) <= ulp * tst1)
          break;
      }

      for (k = m; k <= i - 1; k++) {

        nr = (int)MathMin(3, i - k + 1);

        if (k > m) {
          for (p1 = 1; p1 <= nr; p1++)
            workv3[p1] = h[k + p1 - 1][k - 1];
        }

        CReflections::GenerateReflection(workv3, nr, t1);

        if (k > m) {
          h[k].Set(k - 1, workv3[1]);
          h[k + 1].Set(k - 1, 0);

          if (k < i - 1)
            h[k + 2].Set(k - 1, 0);
        } else {

          if (m > l)
            h[k].Set(k - 1, -h[k][k - 1]);
        }
        v2 = workv3[2];
        t2 = t1 * v2;

        if (nr == 3) {
          v3 = workv3[3];
          t3 = t1 * v3;

          for (j = k; j <= i2; j++) {
            sum = h[k][j] + v2 * h[k + 1][j] + v3 * h[k + 2][j];
            h[k].Set(j, h[k][j] - sum * t1);
            h[k + 1].Set(j, h[k + 1][j] - sum * t2);
            h[k + 2].Set(j, h[k + 2][j] - sum * t3);
          }

          for (j = i1; j <= MathMin(k + 3, i); j++) {
            sum = h[j][k] + v2 * h[j][k + 1] + v3 * h[j][k + 2];
            h[j].Set(k, h[j][k] - sum * t1);
            h[j].Set(k + 1, h[j][k + 1] - sum * t2);
            h[j].Set(k + 2, h[j][k + 2] - sum * t3);
          }

          if (wantz) {

            for (j = iloz; j <= ihiz; j++) {
              sum = z[j][k] + v2 * z[j][k + 1] + v3 * z[j][k + 2];
              z[j].Set(k, z[j][k] - sum * t1);
              z[j].Set(k + 1, z[j][k + 1] - sum * t2);
              z[j].Set(k + 2, z[j][k + 2] - sum * t3);
            }
          }
        } else {

          if (nr == 2) {

            for (j = k; j <= i2; j++) {
              sum = h[k][j] + v2 * h[k + 1][j];
              h[k].Set(j, h[k][j] - sum * t1);
              h[k + 1].Set(j, h[k + 1][j] - sum * t2);
            }

            for (j = i1; j <= i; j++) {
              sum = h[j][k] + v2 * h[j][k + 1];
              h[j].Set(k, h[j][k] - sum * t1);
              h[j].Set(k + 1, h[j][k + 1] - sum * t2);
            }

            if (wantz) {

              for (j = iloz; j <= ihiz; j++) {
                sum = z[j][k] + v2 * z[j][k + 1];
                z[j].Set(k, z[j][k] - sum * t1);
                z[j].Set(k + 1, z[j][k + 1] - sum * t2);
              }
            }
          }
        }
      }
    }

    if (failflag) {

      info = i;

      return;
    }

    if (l == i) {

      wr[i] = h[i][i];
      wi[i] = 0;
    } else {

      if (l == i - 1) {

        him1im1 = h[i - 1][i - 1];
        him1i = h[i - 1][i];
        hiim1 = h[i][i - 1];
        hii = h[i][i];

        Aux2x2Schur(him1im1, him1i, hiim1, hii, wrim1, wiim1, wri, wii, cs, sn);

        wr[i - 1] = wrim1;
        wi[i - 1] = wiim1;
        wr[i] = wri;
        wi[i] = wii;
        h[i - 1].Set(i - 1, him1im1);
        h[i - 1].Set(i, him1i);
        h[i].Set(i - 1, hiim1);
        h[i].Set(i, hii);

        if (wantt) {

          if (i2 > i) {
            workc1[1] = cs;
            works1[1] = sn;

            CRotations::ApplyRotationsFromTheLeft(true, i - 1, i, i + 1, i2,
                                                  workc1, works1, h, work);
          }
          workc1[1] = cs;
          works1[1] = sn;

          CRotations::ApplyRotationsFromTheRight(true, i1, i - 2, i - 1, i,
                                                 workc1, works1, h, work);
        }

        if (wantz) {

          workc1[1] = cs;
          works1[1] = sn;

          CRotations::ApplyRotationsFromTheRight(
              true, iloz, iloz + nz - 1, i - 1, i, workc1, works1, z, work);
        }
      }
    }

    itn = itn - its;
    i = l - 1;
  }
}

static void CHsSchur::Aux2x2Schur(double &a, double &b, double &c, double &d,
                                  double &rt1r, double &rt1i, double &rt2r,
                                  double &rt2i, double &cs, double &sn) {

  double multpl = 0;
  double aa = 0;
  double bb = 0;
  double bcmax = 0;
  double bcmis = 0;
  double cc = 0;
  double cs1 = 0;
  double dd = 0;
  double eps = 0;
  double p = 0;
  double sab = 0;
  double sac = 0;
  double scl = 0;
  double sigma = 0;
  double sn1 = 0;
  double tau = 0;
  double temp = 0;
  double z = 0;

  rt1r = 0;
  rt1i = 0;
  rt2r = 0;
  rt2i = 0;
  cs = 0;
  sn = 0;
  multpl = 4.0;
  eps = CMath::m_machineepsilon;

  if (c == 0.0) {
    cs = 1;
    sn = 0;
  } else {

    if (b == 0.0) {

      cs = 0;
      sn = 1;
      temp = d;
      d = a;
      a = temp;
      b = -c;
      c = 0;
    } else {

      if (a - d == 0.0 && ExtSchurSignToone(b) != ExtSchurSignToone(c)) {
        cs = 1;
        sn = 0;
      } else {

        temp = a - d;
        p = 0.5 * temp;
        bcmax = MathMax(MathAbs(b), MathAbs(c));
        bcmis = MathMin(MathAbs(b), MathAbs(c)) * ExtSchurSignToone(b) *
                ExtSchurSignToone(c);
        scl = MathMax(MathAbs(p), bcmax);
        z = p / scl * p + bcmax / scl * bcmis;

        if (z >= multpl * eps) {

          z = p + ExtSchurSign(MathSqrt(scl) * MathSqrt(z), p);
          a = d + z;
          d = d - bcmax / z * bcmis;

          tau = CBlas::PyThag2(c, z);
          cs = z / tau;
          sn = c / tau;
          b = b - c;
          c = 0;
        } else {

          sigma = b + c;
          tau = CBlas::PyThag2(sigma, temp);
          cs = MathSqrt(0.5 * (1 + MathAbs(sigma) / tau));
          sn = -(p / (tau * cs) * ExtSchurSign(1, sigma));

          aa = a * cs + b * sn;
          bb = -(a * sn) + b * cs;
          cc = c * cs + d * sn;
          dd = -(c * sn) + d * cs;

          a = aa * cs + cc * sn;
          b = bb * cs + dd * sn;
          c = -(aa * sn) + cc * cs;
          d = -(bb * sn) + dd * cs;
          temp = 0.5 * (a + d);
          a = temp;
          d = temp;

          if (c != 0.0) {

            if (b != 0.0) {

              if (ExtSchurSignToone(b) == ExtSchurSignToone(c)) {

                sab = MathSqrt(MathAbs(b));
                sac = MathSqrt(MathAbs(c));

                p = ExtSchurSign(sab * sac, c);
                tau = 1 / MathSqrt(MathAbs(b + c));
                a = temp + p;
                d = temp - p;
                b = b - c;
                c = 0;
                cs1 = sab * tau;
                sn1 = sac * tau;
                temp = cs * cs1 - sn * sn1;
                sn = cs * sn1 + sn * cs1;
                cs = temp;
              }
            } else {

              b = -c;
              c = 0;
              temp = cs;
              cs = -sn;
              sn = temp;
            }
          }
        }
      }
    }
  }

  rt1r = a;
  rt2r = d;

  if (c == 0.0) {
    rt1i = 0;
    rt2i = 0;
  } else {
    rt1i = MathSqrt(MathAbs(b)) * MathSqrt(MathAbs(c));
    rt2i = -rt1i;
  }
}

static double CHsSchur::ExtSchurSign(const double a, const double b) {

  double result = 0;

  if (b >= 0.0)
    result = MathAbs(a);
  else
    result = -MathAbs(a);

  return (result);
}

static int CHsSchur::ExtSchurSignToone(const double b) {

  int result = 0;

  if (b >= 0.0)
    result = 1;
  else
    result = -1;

  return (result);
}

class CTrLinSolve {
public:
  CTrLinSolve(void);
  ~CTrLinSolve(void);

  static void RMatrixTrSafeSolve(CMatrixDouble &a, const int n, double &x[],
                                 double &s, const bool isupper,
                                 const bool istrans, const bool isunit);
  static void SafeSolveTriangular(CMatrixDouble &a, const int n, double &x[],
                                  double &s, const bool isupper,
                                  const bool istrans, const bool isunit,
                                  const bool normin, double &cnorm[]);
};

CTrLinSolve::CTrLinSolve(void) {}

CTrLinSolve::~CTrLinSolve(void) {}

static void CTrLinSolve::RMatrixTrSafeSolve(CMatrixDouble &a, const int n,
                                            double &x[], double &s,
                                            const bool isupper,
                                            const bool istrans,
                                            const bool isunit) {

  bool normin;
  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  double cnorm[];
  double x1[];

  CMatrixDouble a1;

  s = 0;

  normin = false;

  a1.Resize(n + 1, n + 1);
  ArrayResizeAL(x1, n + 1);
  for (i = 1; i <= n; i++) {
    i1_ = -1;
    for (i_ = 1; i_ <= n; i_++)
      a1[i].Set(i_, a[i - 1][i_ + i1_]);
  }

  i1_ = -1;
  for (i_ = 1; i_ <= n; i_++)
    x1[i_] = x[i_ + i1_];

  SafeSolveTriangular(a1, n, x1, s, isupper, istrans, isunit, normin, cnorm);

  i1_ = 1;
  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = x1[i_ + i1_];
}

static void CTrLinSolve::SafeSolveTriangular(
    CMatrixDouble &a, const int n, double &x[], double &s, const bool isupper,
    const bool istrans, const bool isunit, const bool normin, double &cnorm[]) {

  int i = 0;
  int imax = 0;
  int j = 0;
  int jfirst = 0;
  int jinc = 0;
  int jlast = 0;
  int jm1 = 0;
  int jp1 = 0;
  int ip1 = 0;
  int im1 = 0;
  int k = 0;
  int flg = 0;
  double v = 0;
  double vd = 0;
  double bignum = 0;
  double grow = 0;
  double rec = 0;
  double smlnum = 0;
  double sumj = 0;
  double tjj = 0;
  double tjjs = 0;
  double tmax = 0;
  double tscal = 0;
  double uscal = 0;
  double xbnd = 0;
  double xj = 0;
  double xmax = 0;
  bool notran;
  bool upper;
  bool nounit;
  int i_ = 0;

  s = 0;
  upper = isupper;
  notran = !istrans;
  nounit = !isunit;

  tjjs = 0;

  if (n == 0)
    return;

  smlnum = CMath::m_minrealnumber / (CMath::m_machineepsilon * 2);
  bignum = 1 / smlnum;
  s = 1;

  if (!normin) {
    ArrayResizeAL(cnorm, n + 1);

    if (upper) {

      for (j = 1; j <= n; j++) {
        v = 0;
        for (k = 1; k <= j - 1; k++)
          v = v + MathAbs(a[k][j]);
        cnorm[j] = v;
      }
    } else {

      for (j = 1; j <= n - 1; j++) {
        v = 0;
        for (k = j + 1; k <= n; k++)
          v = v + MathAbs(a[k][j]);
        cnorm[j] = v;
      }
      cnorm[n] = 0;
    }
  }

  imax = 1;
  for (k = 2; k <= n; k++) {

    if (cnorm[k] > cnorm[imax])
      imax = k;
  }
  tmax = cnorm[imax];

  if (tmax <= bignum)
    tscal = 1;
  else {
    tscal = 1 / (smlnum * tmax);
    for (i_ = 1; i_ <= n; i_++)
      cnorm[i_] = tscal * cnorm[i_];
  }

  j = 1;
  for (k = 2; k <= n; k++) {

    if (MathAbs(x[k]) > MathAbs(x[j]))
      j = k;
  }

  xmax = MathAbs(x[j]);
  xbnd = xmax;

  if (notran) {

    if (upper) {
      jfirst = n;
      jlast = 1;
      jinc = -1;
    } else {
      jfirst = 1;
      jlast = n;
      jinc = 1;
    }

    if (tscal != 1.0)
      grow = 0;
    else {

      if (nounit) {

        grow = 1 / MathMax(xbnd, smlnum);
        xbnd = grow;
        j = jfirst;
        while ((jinc > 0 && j <= jlast) || (jinc < 0 && j >= jlast)) {

          if (grow <= smlnum)
            break;

          tjj = MathAbs(a[j][j]);
          xbnd = MathMin(xbnd, MathMin(1, tjj) * grow);

          if (tjj + cnorm[j] >= smlnum) {

            grow = grow * (tjj / (tjj + cnorm[j]));
          } else {

            grow = 0;
          }

          if (j == jlast)
            grow = xbnd;
          j = j + jinc;
        }
      } else {

        grow = MathMin(1, 1 / MathMax(xbnd, smlnum));
        j = jfirst;
        while ((jinc > 0 && j <= jlast) || (jinc < 0 && j >= jlast)) {

          if (grow <= smlnum)
            break;

          grow = grow * (1 / (1 + cnorm[j]));
          j = j + jinc;
        }
      }
    }
  } else {

    if (upper) {
      jfirst = 1;
      jlast = n;
      jinc = 1;
    } else {
      jfirst = n;
      jlast = 1;
      jinc = -1;
    }

    if (tscal != 1.0)
      grow = 0;
    else {

      if (nounit) {

        grow = 1 / MathMax(xbnd, smlnum);
        xbnd = grow;
        j = jfirst;
        while ((jinc > 0 && j <= jlast) || (jinc < 0 && j >= jlast)) {

          if (grow <= smlnum)
            break;

          xj = 1 + cnorm[j];
          grow = MathMin(grow, xbnd / xj);

          tjj = MathAbs(a[j][j]);

          if (xj > tjj)
            xbnd = xbnd * (tjj / xj);

          if (j == jlast)
            grow = MathMin(grow, xbnd);
          j = j + jinc;
        }
      } else {

        grow = MathMin(1, 1 / MathMax(xbnd, smlnum));
        j = jfirst;
        while ((jinc > 0 && j <= jlast) || (jinc < 0 && j >= jlast)) {

          if (grow <= smlnum)
            break;

          xj = 1 + cnorm[j];
          grow = grow / xj;
          j = j + jinc;
        }
      }
    }
  }
  if (grow * tscal > smlnum) {

    if ((upper && notran) || (!upper && !notran)) {

      if (nounit)
        vd = a[n][n];
      else
        vd = 1;
      x[n] = x[n] / vd;
      for (i = n - 1; i >= 1; i--) {
        ip1 = i + 1;

        if (upper) {
          v = 0.0;
          for (i_ = ip1; i_ <= n; i_++)
            v += a[i][i_] * x[i_];
        } else {
          v = 0.0;
          for (i_ = ip1; i_ <= n; i_++)
            v += a[i_][i] * x[i_];
        }

        if (nounit)
          vd = a[i][i];
        else
          vd = 1;
        x[i] = (x[i] - v) / vd;
      }
    } else {

      if (nounit)
        vd = a[1][1];
      else
        vd = 1;
      x[1] = x[1] / vd;
      for (i = 2; i <= n; i++) {
        im1 = i - 1;

        if (upper) {
          v = 0.0;
          for (i_ = 1; i_ <= im1; i_++)
            v += a[i_][i] * x[i_];
        } else {
          v = 0.0;
          for (i_ = 1; i_ <= im1; i_++)
            v += a[i][i_] * x[i_];
        }

        if (nounit)
          vd = a[i][i];
        else
          vd = 1;
        x[i] = (x[i] - v) / vd;
      }
    }
  } else {

    if (xmax > bignum) {

      s = bignum / xmax;
      for (i_ = 1; i_ <= n; i_++)
        x[i_] = s * x[i_];
      xmax = bignum;
    }

    if (notran) {

      j = jfirst;
      while ((jinc > 0 && j <= jlast) || (jinc < 0 && j >= jlast)) {

        xj = MathAbs(x[j]);
        flg = 0;

        if (nounit)
          tjjs = a[j][j] * tscal;
        else {
          tjjs = tscal;

          if (tscal == 1.0)
            flg = 100;
        }

        if (flg != 100) {
          tjj = MathAbs(tjjs);
          if (tjj > smlnum) {

            if (tjj < 1.0) {

              if (xj > (double)(tjj * bignum)) {

                rec = 1 / xj;
                for (i_ = 1; i_ <= n; i_++) {
                  x[i_] = rec * x[i_];
                }
                s = s * rec;
                xmax = xmax * rec;
              }
            }
            x[j] = x[j] / tjjs;
            xj = MathAbs(x[j]);
          } else {

            if (tjj > 0.0) {

              if (xj > (double)(tjj * bignum)) {

                rec = tjj * bignum / xj;

                if (cnorm[j] > 1.0) {

                  rec = rec / cnorm[j];
                }
                for (i_ = 1; i_ <= n; i_++)
                  x[i_] = rec * x[i_];
                s = s * rec;
                xmax = xmax * rec;
              }
              x[j] = x[j] / tjjs;
              xj = MathAbs(x[j]);
            } else {

              for (i = 1; i <= n; i++)
                x[i] = 0;

              x[j] = 1;
              xj = 1;
              s = 0;
              xmax = 0;
            }
          }
        }

        if (xj > 1.0) {
          rec = 1 / xj;

          if (cnorm[j] > (bignum - xmax) * rec) {

            rec = rec * 0.5;
            for (i_ = 1; i_ <= n; i_++)
              x[i_] = rec * x[i_];
            s = s * rec;
          }
        } else {

          if (xj * cnorm[j] > bignum - xmax) {

            for (i_ = 1; i_ <= n; i_++)
              x[i_] = 0.5 * x[i_];
            s = s * 0.5;
          }
        }

        if (upper) {

          if (j > 1) {

            v = x[j] * tscal;
            jm1 = j - 1;

            for (i_ = 1; i_ <= jm1; i_++)
              x[i_] = x[i_] - v * a[i_][j];
            i = 1;
            for (k = 2; k <= j - 1; k++) {

              if (MathAbs(x[k]) > MathAbs(x[i]))
                i = k;
            }
            xmax = MathAbs(x[i]);
          }
        } else {

          if (j < n) {

            jp1 = j + 1;
            v = x[j] * tscal;

            for (i_ = jp1; i_ <= n; i_++)
              x[i_] = x[i_] - v * a[i_][j];
            i = j + 1;
            for (k = j + 2; k <= n; k++) {

              if (MathAbs(x[k]) > MathAbs(x[i]))
                i = k;
            }
            xmax = MathAbs(x[i]);
          }
        }
        j = j + jinc;
      }
    } else {

      j = jfirst;
      while ((jinc > 0 && j <= jlast) || (jinc < 0 && j >= jlast)) {

        xj = MathAbs(x[j]);
        uscal = tscal;
        rec = 1 / MathMax(xmax, 1);

        if (cnorm[j] > (bignum - xj) * rec) {

          rec = rec * 0.5;

          if (nounit)
            tjjs = a[j][j] * tscal;
          else
            tjjs = tscal;
          tjj = MathAbs(tjjs);

          if (tjj > 1.0) {

            rec = MathMin(1, rec * tjj);
            uscal = uscal / tjjs;
          }

          if (rec < 1.0) {
            for (i_ = 1; i_ <= n; i_++)
              x[i_] = rec * x[i_];
            s = s * rec;
            xmax = xmax * rec;
          }
        }
        sumj = 0;

        if (uscal == 1.0) {

          if (upper) {

            if (j > 1) {
              jm1 = j - 1;
              sumj = 0.0;
              for (i_ = 1; i_ <= jm1; i_++)
                sumj += a[i_][j] * x[i_];
            } else
              sumj = 0;
          } else {

            if (j < n) {
              jp1 = j + 1;
              sumj = 0.0;
              for (i_ = jp1; i_ <= n; i_++)
                sumj += a[i_][j] * x[i_];
            }
          }
        } else {

          if (upper) {
            for (i = 1; i <= j - 1; i++) {
              v = a[i][j] * uscal;
              sumj = sumj + v * x[i];
            }
          } else {

            if (j < n) {
              for (i = j + 1; i <= n; i++) {
                v = a[i][j] * uscal;
                sumj = sumj + v * x[i];
              }
            }
          }
        }
        if (uscal == tscal) {

          x[j] = x[j] - sumj;
          xj = MathAbs(x[j]);
          flg = 0;

          if (nounit)
            tjjs = a[j][j] * tscal;
          else {
            tjjs = tscal;

            if (tscal == 1.0)
              flg = 150;
          }

          if (flg != 150) {
            tjj = MathAbs(tjjs);

            if (tjj > smlnum) {

              if (tjj < 1.0) {

                if (xj > (double)(tjj * bignum)) {

                  rec = 1 / xj;
                  for (i_ = 1; i_ <= n; i_++)
                    x[i_] = rec * x[i_];
                  s = s * rec;
                  xmax = xmax * rec;
                }
              }
              x[j] = x[j] / tjjs;
            } else {

              if (tjj > 0.0) {

                if (xj > (double)(tjj * bignum)) {

                  rec = tjj * bignum / xj;
                  for (i_ = 1; i_ <= n; i_++)
                    x[i_] = rec * x[i_];
                  s = s * rec;
                  xmax = xmax * rec;
                }
                x[j] = x[j] / tjjs;
              } else {

                for (i = 1; i <= n; i++)
                  x[i] = 0;
                x[j] = 1;
                s = 0;
                xmax = 0;
              }
            }
          }
        } else {

          x[j] = x[j] / tjjs - sumj;
        }
        xmax = MathMax(xmax, MathAbs(x[j]));
        j = j + jinc;
      }
    }
    s = s / tscal;
  }

  if (tscal != 1.0) {
    v = 1 / tscal;
    for (i_ = 1; i_ <= n; i_++)
      cnorm[i_] = v * cnorm[i_];
  }
}

class CSafeSolve {
private:
  static bool CBasicSolveAndUpdate(al_complex &alpha, al_complex &beta,
                                   const double lnmax, const double bnorm,
                                   const double maxgrowth, double &xnorm,
                                   al_complex &x);

public:
  CSafeSolve(void);
  ~CSafeSolve(void);

  static bool RMatrixScaledTrSafeSolve(CMatrixDouble &a, const double sa,
                                       const int n, double &x[],
                                       const bool isupper, const int trans,
                                       const bool isunit,
                                       const double maxgrowth);
  static bool CMatrixScaledTrSafeSolve(CMatrixComplex &a, const double sa,
                                       const int n, al_complex &x[],
                                       const bool isupper, const int trans,
                                       const bool isunit,
                                       const double maxgrowth);
};

CSafeSolve::CSafeSolve(void) {}

CSafeSolve::~CSafeSolve(void) {}

static bool CSafeSolve::RMatrixScaledTrSafeSolve(
    CMatrixDouble &a, const double sa, const int n, double &x[],
    const bool isupper, const int trans, const bool isunit,
    const double maxgrowth) {

  bool result;
  double lnmax = 0;
  double nrmb = 0;
  double nrmx = 0;
  double vr = 0;
  al_complex alpha = 0;
  al_complex beta = 0;
  al_complex cx = 0;
  int i_ = 0;
  int i = 0;

  double tmp[];

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return (false);

  if (!CAp::Assert(trans == 0 || trans == 1,
                   __FUNCTION__ + ": incorrect Trans!"))
    return (false);

  result = true;
  lnmax = MathLog(CMath::m_maxrealnumber);

  if (n <= 0)
    return (result);

  nrmb = 0;
  for (i = 0; i < n; i++)
    nrmb = MathMax(nrmb, MathAbs(x[i]));
  nrmx = 0;

  ArrayResizeAL(tmp, n);
  result = true;

  if (isupper && trans == 0) {

    for (i = n - 1; i >= 0; i--) {

      if (isunit)
        alpha = sa;
      else
        alpha = a[i][i] * sa;

      if (i < n - 1) {
        for (i_ = i + 1; i_ < n; i_++)
          tmp[i_] = sa * a[i][i_];

        vr = 0.0;
        for (i_ = i + 1; i_ < n; i_++)
          vr += tmp[i_] * x[i_];
        beta = x[i] - vr;
      } else
        beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, cx);

      if (!result)
        return (result);

      x[i] = cx.re;
    }

    return (result);
  }

  if (!isupper && trans == 0) {

    for (i = 0; i < n; i++) {

      if (isunit)
        alpha = sa;
      else
        alpha = a[i][i] * sa;

      if (i > 0) {
        for (i_ = 0; i_ < i; i_++)
          tmp[i_] = sa * a[i][i_];

        vr = 0.0;
        for (i_ = 0; i_ < i; i_++)
          vr += tmp[i_] * x[i_];
        beta = x[i] - vr;
      } else
        beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, cx);

      if (!result)
        return (result);

      x[i] = cx.re;
    }

    return (result);
  }

  if (isupper && trans == 1) {

    for (i = 0; i < n; i++) {

      if (isunit)
        alpha = sa;
      else
        alpha = a[i][i] * sa;
      beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, cx);

      if (!result)
        return (result);

      x[i] = cx.re;

      if (i < n - 1) {
        vr = cx.re;
        for (i_ = i + 1; i_ < n; i_++)
          tmp[i_] = sa * a[i][i_];
        for (i_ = i + 1; i_ < n; i_++)
          x[i_] = x[i_] - vr * tmp[i_];
      }
    }

    return (result);
  }

  if (!isupper && trans == 1) {

    for (i = n - 1; i >= 0; i--) {

      if (isunit)
        alpha = sa;
      else
        alpha = a[i][i] * sa;
      beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, cx);

      if (!result)
        return (result);

      x[i] = cx.re;

      if (i > 0) {
        vr = cx.re;
        for (i_ = 0; i_ < i; i_++)
          tmp[i_] = sa * a[i][i_];
        for (i_ = 0; i_ < i; i_++)
          x[i_] = x[i_] - vr * tmp[i_];
      }
    }

    return (result);
  }

  return (false);
}

static bool CSafeSolve::CMatrixScaledTrSafeSolve(
    CMatrixComplex &a, const double sa, const int n, al_complex &x[],
    const bool isupper, const int trans, const bool isunit,
    const double maxgrowth) {

  al_complex Csa;
  bool result;
  double lnmax = 0;
  double nrmb = 0;
  double nrmx = 0;
  al_complex alpha = 0;
  al_complex beta = 0;
  al_complex vc = 0;
  int i = 0;
  int i_ = 0;

  al_complex tmp[];

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return (false);

  if (!CAp::Assert((trans == 0 || trans == 1) || trans == 2,
                   __FUNCTION__ + ": incorrect Trans!"))
    return (false);

  result = true;
  lnmax = MathLog(CMath::m_maxrealnumber);

  if (n <= 0)
    return (result);

  nrmb = 0;
  for (i = 0; i < n; i++)
    nrmb = MathMax(nrmb, CMath::AbsComplex(x[i]));
  nrmx = 0;

  ArrayResizeAL(tmp, n);
  result = true;

  if (isupper && trans == 0) {

    for (i = n - 1; i >= 0; i--) {

      if (isunit)
        alpha = sa;
      else
        alpha = a[i][i] * sa;

      if (i < n - 1) {
        for (i_ = i + 1; i_ < n; i_++) {
          Csa = sa;
          tmp[i_] = Csa * a[i][i_];
        }

        vc = 0.0;
        for (i_ = i + 1; i_ < n; i_++)
          vc += tmp[i_] * x[i_];
        beta = x[i] - vc;
      } else
        beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, vc);

      if (!result)
        return (result);
      x[i] = vc;
    }

    return (result);
  }

  if (!isupper && trans == 0) {

    for (i = 0; i < n; i++) {

      if (isunit)
        alpha = sa;
      else
        alpha = a[i][i] * sa;

      if (i > 0) {
        for (i_ = 0; i_ < i; i_++) {
          Csa = sa;
          tmp[i_] = Csa * a[i][i_];
        }

        vc = 0.0;
        for (i_ = 0; i_ < i; i_++)
          vc += tmp[i_] * x[i_];
        beta = x[i] - vc;
      } else
        beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, vc);

      if (!result)
        return (result);
      x[i] = vc;
    }

    return (result);
  }

  if (isupper && trans == 1) {

    for (i = 0; i < n; i++) {

      if (isunit)
        alpha = sa;
      else
        alpha = a[i][i] * sa;
      beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, vc);

      if (!result)
        return (result);
      x[i] = vc;

      if (i < n - 1) {
        for (i_ = i + 1; i_ < n; i_++) {
          Csa = sa;
          tmp[i_] = Csa * a[i][i_];
        }
        for (i_ = i + 1; i_ < n; i_++) {
          x[i_] = x[i_] - vc * tmp[i_];
        }
      }
    }

    return (result);
  }

  if (!isupper && trans == 1) {

    for (i = n - 1; i >= 0; i--) {

      if (isunit)
        alpha = sa;
      else
        alpha = a[i][i] * sa;
      beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, vc);

      if (!result)
        return (result);
      x[i] = vc;

      if (i > 0) {
        for (i_ = 0; i_ < i; i_++) {
          Csa = sa;
          tmp[i_] = Csa * a[i][i_];
        }
        for (i_ = 0; i_ < i; i_++) {
          x[i_] = x[i_] - vc * tmp[i_];
        }
      }
    }

    return (result);
  }

  if (isupper && trans == 2) {

    for (i = 0; i < n; i++) {

      if (isunit)
        alpha = sa;
      else
        alpha = CMath::Conj(a[i][i]) * sa;
      beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, vc);

      if (!result)
        return (result);
      x[i] = vc;

      if (i < n - 1) {
        for (i_ = i + 1; i_ < n; i_++) {
          Csa = sa;
          tmp[i_] = Csa * CMath::Conj(a[i][i_]);
        }
        for (i_ = i + 1; i_ < n; i_++) {
          x[i_] = x[i_] - vc * tmp[i_];
        }
      }
    }

    return (result);
  }

  if (!isupper && trans == 2) {

    for (i = n - 1; i >= 0; i--) {

      if (isunit)
        alpha = sa;
      else
        alpha = CMath::Conj(a[i][i]) * sa;
      beta = x[i];

      result =
          CBasicSolveAndUpdate(alpha, beta, lnmax, nrmb, maxgrowth, nrmx, vc);

      if (!result)
        return (result);
      x[i] = vc;

      if (i > 0) {
        for (i_ = 0; i_ < i; i_++) {
          Csa = sa;
          tmp[i_] = Csa * CMath::Conj(a[i][i_]);
        }
        for (i_ = 0; i_ < i; i_++) {
          x[i_] = x[i_] - vc * tmp[i_];
        }
      }
    }

    return (result);
  }

  return (false);
}

static bool CSafeSolve::CBasicSolveAndUpdate(
    al_complex &alpha, al_complex &beta, const double lnmax, const double bnorm,
    const double maxgrowth, double &xnorm, al_complex &x) {

  bool result;
  double v = 0;

  x = 0;
  result = false;

  if (alpha == 0)
    return (result);

  if (beta != 0) {

    v = MathLog(CMath::AbsComplex(beta)) - MathLog(CMath::AbsComplex(alpha));

    if (v > lnmax)
      return (result);
    x = beta / alpha;
  } else {

    x = 0;
  }

  xnorm = MathMax(xnorm, CMath::AbsComplex(x));

  if (xnorm > maxgrowth * bnorm)
    return (result);

  return (true);
}

class CXblas {
private:
  static void XSum(double &w[], const double mx, const int n, double &r,
                   double &rerr);
  static double XFastPow(const double r, const int n);

public:
  CXblas(void);
  ~CXblas(void);

  static void XDot(double &a[], double &b[], const int n, double &temp[],
                   double &r, double &rerr);
  static void XCDot(al_complex &a[], al_complex &b[], const int n,
                    double &temp[], al_complex &r, double &rerr);
};

CXblas::CXblas(void) {}

CXblas::~CXblas(void) {}

static void CXblas::XDot(double &a[], double &b[], const int n, double &temp[],
                         double &r, double &rerr) {

  int i = 0;
  double mx = 0;
  double v = 0;

  r = 0;
  rerr = 0;

  if (n == 0) {
    r = 0;
    rerr = 0;

    return;
  }
  mx = 0;

  for (i = 0; i <= n - 1; i++) {
    v = a[i] * b[i];
    temp[i] = v;
    mx = MathMax(mx, MathAbs(v));
  }

  if (mx == 0.0) {
    r = 0;
    rerr = 0;

    return;
  }

  XSum(temp, mx, n, r, rerr);
}

static void CXblas::XCDot(al_complex &a[], al_complex &b[], const int n,
                          double &temp[], al_complex &r, double &rerr) {

  int i = 0;
  double mx = 0;
  double v = 0;
  double rerrx = 0;
  double rerry = 0;

  r = 0;
  rerr = 0;

  if (n == 0) {
    r = 0;
    rerr = 0;

    return;
  }

  mx = 0;
  for (i = 0; i <= n - 1; i++) {

    v = a[i].re * b[i].re;
    temp[2 * i + 0] = v;
    mx = MathMax(mx, MathAbs(v));
    v = -(a[i].im * b[i].im);
    temp[2 * i + 1] = v;
    mx = MathMax(mx, MathAbs(v));
  }

  if (mx == 0.0) {
    r.re = 0;
    rerrx = 0;
  } else
    XSum(temp, mx, 2 * n, r.re, rerrx);

  mx = 0;
  for (i = 0; i <= n - 1; i++) {

    v = a[i].re * b[i].im;
    temp[2 * i + 0] = v;
    mx = MathMax(mx, MathAbs(v));
    v = a[i].im * b[i].re;
    temp[2 * i + 1] = v;
    mx = MathMax(mx, MathAbs(v));
  }

  if (mx == 0.0) {
    r.im = 0;
    rerry = 0;
  } else
    XSum(temp, mx, 2 * n, r.im, rerry);

  if (rerrx == 0.0 && rerry == 0.0)
    rerr = 0;
  else
    rerr =
        MathMax(rerrx, rerry) *
        MathSqrt(1 + CMath::Sqr(MathMin(rerrx, rerry) / MathMax(rerrx, rerry)));
}

static void CXblas::XSum(double &w[], const double mx, const int n, double &r,
                         double &rerr) {

  int i = 0;
  int k = 0;
  int ks = 0;
  double v = 0;
  double s = 0;
  double ln2 = 0;
  double chunk = 0;
  double invchunk = 0;
  bool allzeros;
  int i_ = 0;

  r = 0;
  rerr = 0;

  if (n == 0) {
    r = 0;
    rerr = 0;

    return;
  }

  if (mx == 0.0) {
    r = 0;
    rerr = 0;

    return;
  }

  if (!CAp::Assert(n < 536870912, __FUNCTION__ + ": N is too large!"))
    return;

  ln2 = MathLog(2);
  rerr = mx * CMath::m_machineepsilon;

  k = (int)MathRound(MathLog(mx) / ln2);
  s = XFastPow(2, -k);

  while (s * mx >= 1.0)
    s = 0.5 * s;
  while (s * mx < 0.5)
    s = 2 * s;
  for (i_ = 0; i_ <= n - 1; i_++)
    w[i_] = s * w[i_];
  s = 1 / s;

  k = (int)(MathLog((double)536870912 / (double)n) / ln2);
  chunk = XFastPow(2, k);

  if (chunk < 2.0)
    chunk = 2;
  invchunk = 1 / chunk;

  r = 0;
  for (i_ = 0; i_ <= n - 1; i_++)
    w[i_] = chunk * w[i_];

  while (true) {

    s = s * invchunk;
    allzeros = true;
    ks = 0;
    for (i = 0; i <= n - 1; i++) {
      v = w[i];
      k = (int)(v);

      if (v != k)
        allzeros = false;
      w[i] = chunk * (v - k);
      ks = ks + k;
    }
    r = r + s * ks;
    v = MathAbs(r);

    if (allzeros || s * n + mx == mx)
      break;
  }

  rerr = MathMax(rerr, MathAbs(r) * CMath::m_machineepsilon);
}

static double CXblas::XFastPow(const double r, const int n) {

  double result = 0;

  if (n > 0) {

    if (n % 2 == 0)
      result = CMath::Sqr(XFastPow(r, n / 2));
    else
      result = r * XFastPow(r, n - 1);

    return (result);
  }

  if (n == 0)
    result = 1;

  if (n < 0)
    result = XFastPow(1 / r, -n);

  return (result);
}

class CLinMinState {
public:
  bool m_brackt;
  bool m_stage1;
  int m_infoc;
  double m_dg;
  double m_dgm;
  double m_dginit;
  double m_dgtest;
  double m_dgx;
  double m_dgxm;
  double m_dgy;
  double m_dgym;
  double m_finit;
  double m_ftest1;
  double m_fm;
  double m_fx;
  double m_fxm;
  double m_fy;
  double m_fym;
  double m_stx;
  double m_sty;
  double m_stmin;
  double m_stmax;
  double m_width;
  double m_width1;
  double m_xtrapf;

  CLinMinState(void);
  ~CLinMinState(void);

  void Copy(CLinMinState &obj);
};

CLinMinState::CLinMinState(void) {}

CLinMinState::~CLinMinState(void) {}

void CLinMinState::Copy(CLinMinState &obj) {

  m_brackt = obj.m_brackt;
  m_stage1 = obj.m_stage1;
  m_infoc = obj.m_infoc;
  m_dg = obj.m_dg;
  m_dgm = obj.m_dgm;
  m_dginit = obj.m_dginit;
  m_dgtest = obj.m_dgtest;
  m_dgx = obj.m_dgx;
  m_dgxm = obj.m_dgxm;
  m_dgy = obj.m_dgy;
  m_dgym = obj.m_dgym;
  m_finit = obj.m_finit;
  m_ftest1 = obj.m_ftest1;
  m_fm = obj.m_fm;
  m_fx = obj.m_fx;
  m_fxm = obj.m_fxm;
  m_fy = obj.m_fy;
  m_fym = obj.m_fym;
  m_stx = obj.m_stx;
  m_sty = obj.m_sty;
  m_stmin = obj.m_stmin;
  m_stmax = obj.m_stmax;
  m_width = obj.m_width;
  m_width1 = obj.m_width1;
  m_xtrapf = obj.m_xtrapf;
}

class CArmijoState {
public:
  bool m_needf;
  double m_x[];
  double m_f;
  int m_n;
  double m_xbase[];
  double m_s[];
  double m_stplen;
  double m_fcur;
  double m_stpmax;
  int m_fmax;
  int m_nfev;
  int m_info;
  RCommState m_rstate;

  CArmijoState(void);
  ~CArmijoState(void);
};

CArmijoState::CArmijoState(void) {}

CArmijoState::~CArmijoState(void) {}

class CLinMin {
private:
  static void MCStep(double &stx, double &fx, double &dx, double &sty,
                     double &fy, double &dy, double &stp, double fp, double dp,
                     bool &m_brackt, double stmin, double stmax, int &info);

  static void Func_lbl_rcomm(CArmijoState &state, int n, double v);
  static bool Func_lbl_6(CArmijoState &state, int &n, double &v);
  static bool Func_lbl_10(CArmijoState &state, int &n, double &v);

public:
  static const double m_ftol;
  static const double m_xtol;
  static const int m_maxfev;
  static const double m_stpmin;
  static const double m_defstpmax;
  static const double m_armijofactor;

  CLinMin(void);
  ~CLinMin(void);

  static void LinMinNormalized(double &d[], double &stp, const int n);
  static void MCSrch(const int n, double &x[], double &f, double &g[],
                     double &s[], double &stp, double stpmax, double gtol,
                     int &info, int &nfev, double &wa[], CLinMinState &state,
                     int &stage);
  static void ArmijoCreate(const int n, double &x[], const double f,
                           double &s[], const double stp, const double stpmax,
                           const int ffmax, CArmijoState &state);
  static void ArmijoResults(CArmijoState &state, int &info, double &stp,
                            double &f);
  static bool ArmijoIteration(CArmijoState &state);
};

const double CLinMin::m_ftol = 0.001;
const double CLinMin::m_xtol = 100 * CMath::m_machineepsilon;
const int CLinMin::m_maxfev = 20;
const double CLinMin::m_stpmin = 1.0E-50;
const double CLinMin::m_defstpmax = 1.0E+50;
const double CLinMin::m_armijofactor = 1.3;

CLinMin::CLinMin(void) {}

CLinMin::~CLinMin(void) {}

static void CLinMin::LinMinNormalized(double &d[], double &stp, const int n) {

  double mx = 0;
  double s = 0;
  int i = 0;
  int i_ = 0;

  mx = 0;
  for (i = 0; i <= n - 1; i++)
    mx = MathMax(mx, MathAbs(d[i]));

  if (mx == 0.0)
    return;
  s = 1 / mx;
  for (i_ = 0; i_ <= n - 1; i_++)
    d[i_] = s * d[i_];
  stp = stp / s;

  s = 0.0;
  for (i_ = 0; i_ <= n - 1; i_++)
    s += d[i_] * d[i_];
  s = 1 / MathSqrt(s);
  for (i_ = 0; i_ <= n - 1; i_++)
    d[i_] = s * d[i_];
  stp = stp / s;
}

static void CLinMin::MCSrch(const int n, double &x[], double &f, double &g[],
                            double &s[], double &stp, double stpmax,
                            double gtol, int &info, int &nfev, double &wa[],
                            CLinMinState &state, int &stage) {

  double v = 0;
  double p5 = 0;
  double p66 = 0;
  double zero = 0;
  int i_ = 0;

  p5 = 0.5;
  p66 = 0.66;
  state.m_xtrapf = 4.0;
  zero = 0;

  if (stpmax == 0.0)
    stpmax = m_defstpmax;

  if (stp < m_stpmin)
    stp = m_stpmin;

  if (stp > stpmax)
    stp = stpmax;

  while (true) {

    if (stage == 0) {

      stage = 2;
      continue;
    }

    if (stage == 2) {
      state.m_infoc = 1;
      info = 0;

      if (stpmax < m_stpmin && stpmax > 0.0) {
        info = 5;
        stp = 0.0;

        return;
      }

      if (n <= 0 || stp <= 0.0 || m_ftol < 0.0 || gtol < zero ||
          m_xtol < zero || m_stpmin < zero || stpmax < m_stpmin ||
          m_maxfev <= 0) {
        stage = 0;
        return;
      }

      v = 0.0;
      for (i_ = 0; i_ <= n - 1; i_++)
        v += g[i_] * s[i_];
      state.m_dginit = v;

      if (state.m_dginit >= 0.0) {
        stage = 0;
        return;
      }

      state.m_brackt = false;
      state.m_stage1 = true;
      nfev = 0;
      state.m_finit = f;
      state.m_dgtest = m_ftol * state.m_dginit;
      state.m_width = stpmax - m_stpmin;
      state.m_width1 = state.m_width / p5;
      for (i_ = 0; i_ <= n - 1; i_++)
        wa[i_] = x[i_];

      state.m_stx = 0;
      state.m_fx = state.m_finit;
      state.m_dgx = state.m_dginit;
      state.m_sty = 0;
      state.m_fy = state.m_finit;
      state.m_dgy = state.m_dginit;

      stage = 3;
      continue;
    }

    if (stage == 3) {

      if (state.m_brackt) {

        if (state.m_stx < state.m_sty) {
          state.m_stmin = state.m_stx;
          state.m_stmax = state.m_sty;
        } else {
          state.m_stmin = state.m_sty;
          state.m_stmax = state.m_stx;
        }
      } else {
        state.m_stmin = state.m_stx;
        state.m_stmax = stp + state.m_xtrapf * (stp - state.m_stx);
      }

      if (stp > stpmax)
        stp = stpmax;

      if (stp < m_stpmin)
        stp = m_stpmin;

      if ((state.m_brackt && (stp <= state.m_stmin || stp >= state.m_stmax)) ||
          nfev >= m_maxfev - 1 || state.m_infoc == 0 ||
          (state.m_brackt &&
           state.m_stmax - state.m_stmin <= m_xtol * state.m_stmax)) {
        stp = state.m_stx;
      }

      for (i_ = 0; i_ <= n - 1; i_++)
        x[i_] = wa[i_];
      for (i_ = 0; i_ <= n - 1; i_++)
        x[i_] = x[i_] + stp * s[i_];

      stage = 4;
      return;
    }

    if (stage == 4) {
      info = 0;
      nfev = nfev + 1;
      v = 0.0;
      for (i_ = 0; i_ <= n - 1; i_++)
        v += g[i_] * s[i_];
      state.m_dg = v;
      state.m_ftest1 = state.m_finit + stp * state.m_dgtest;

      if ((state.m_brackt && (stp <= state.m_stmin || stp >= state.m_stmax)) ||
          state.m_infoc == 0)
        info = 6;

      if ((stp == stpmax && f <= state.m_ftest1) &&
          state.m_dg <= state.m_dgtest)
        info = 5;

      if (stp == m_stpmin &&
          (f > state.m_ftest1 || state.m_dg >= state.m_dgtest))
        info = 4;

      if (nfev >= m_maxfev)
        info = 3;

      if (state.m_brackt &&
          state.m_stmax - state.m_stmin <= m_xtol * state.m_stmax)
        info = 2;

      if (f <= state.m_ftest1 &&
          MathAbs(state.m_dg) <= -(gtol * state.m_dginit))
        info = 1;

      if (info != 0) {
        stage = 0;
        return;
      }

      if ((state.m_stage1 && f <= state.m_ftest1) &&
          state.m_dg >= MathMin(m_ftol, gtol) * state.m_dginit)
        state.m_stage1 = false;

      if ((state.m_stage1 && f <= state.m_fx) && f > state.m_ftest1) {

        state.m_fm = f - stp * state.m_dgtest;
        state.m_fxm = state.m_fx - state.m_stx * state.m_dgtest;
        state.m_fym = state.m_fy - state.m_sty * state.m_dgtest;
        state.m_dgm = state.m_dg - state.m_dgtest;
        state.m_dgxm = state.m_dgx - state.m_dgtest;
        state.m_dgym = state.m_dgy - state.m_dgtest;

        MCStep(state.m_stx, state.m_fxm, state.m_dgxm, state.m_sty, state.m_fym,
               state.m_dgym, stp, state.m_fm, state.m_dgm, state.m_brackt,
               state.m_stmin, state.m_stmax, state.m_infoc);

        state.m_fx = state.m_fxm + state.m_stx * state.m_dgtest;
        state.m_fy = state.m_fym + state.m_sty * state.m_dgtest;
        state.m_dgx = state.m_dgxm + state.m_dgtest;
        state.m_dgy = state.m_dgym + state.m_dgtest;
      } else {

        MCStep(state.m_stx, state.m_fx, state.m_dgx, state.m_sty, state.m_fy,
               state.m_dgy, stp, f, state.m_dg, state.m_brackt, state.m_stmin,
               state.m_stmax, state.m_infoc);
      }

      if (state.m_brackt) {

        if (MathAbs(state.m_sty - state.m_stx) >= p66 * state.m_width1)
          stp = state.m_stx + p5 * (state.m_sty - state.m_stx);
        state.m_width1 = state.m_width;
        state.m_width = MathAbs(state.m_sty - state.m_stx);
      }

      stage = 3;
      continue;
    }
  }
}

static void CLinMin::ArmijoCreate(const int n, double &x[], const double f,
                                  double &s[], const double stp,
                                  const double stpmax, const int ffmax,
                                  CArmijoState &state) {

  int i_ = 0;

  if (CAp::Len(state.m_x) < n)
    ArrayResizeAL(state.m_x, n);

  if (CAp::Len(state.m_xbase) < n)
    ArrayResizeAL(state.m_xbase, n);

  if (CAp::Len(state.m_s) < n)
    ArrayResizeAL(state.m_s, n);

  state.m_stpmax = stpmax;
  state.m_fmax = ffmax;
  state.m_stplen = stp;
  state.m_fcur = f;
  state.m_n = n;
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_xbase[i_] = x[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_s[i_] = s[i_];

  ArrayResizeAL(state.m_rstate.ia, 1);
  ArrayResizeAL(state.m_rstate.ra, 1);
  state.m_rstate.stage = -1;
}

static void CLinMin::ArmijoResults(CArmijoState &state, int &info, double &stp,
                                   double &f) {

  info = state.m_info;
  stp = state.m_stplen;
  f = state.m_fcur;
}

static void CLinMin::MCStep(double &stx, double &fx, double &dx, double &sty,
                            double &fy, double &dy, double &stp, double fp,
                            double dp, bool &m_brackt, double stmin,
                            double stmax, int &info) {

  bool bound;
  double gamma = 0;
  double p = 0;
  double q = 0;
  double r = 0;
  double s = 0;
  double sgnd = 0;
  double stpc = 0;
  double stpf = 0;
  double stpq = 0;
  double theta = 0;

  info = 0;

  if (((m_brackt && (stp <= MathMin(stx, sty) || stp >= MathMax(stx, sty))) ||
       dx * (stp - stx) >= 0.0) ||
      stmax < stmin)
    return;

  sgnd = dp * (dx / MathAbs(dx));

  if (fp > fx) {

    info = 1;
    bound = true;
    theta = 3 * (fx - fp) / (stp - stx) + dx + dp;
    s = MathMax(MathAbs(theta), MathMax(MathAbs(dx), MathAbs(dp)));
    gamma = s * MathSqrt(CMath::Sqr(theta / s) - dx / s * (dp / s));

    if (stp < stx)
      gamma = -gamma;

    p = gamma - dx + theta;
    q = gamma - dx + gamma + dp;
    r = p / q;
    stpc = stx + r * (stp - stx);
    stpq = stx + dx / ((fx - fp) / (stp - stx) + dx) / 2 * (stp - stx);

    if (MathAbs(stpc - stx) < MathAbs(stpq - stx))
      stpf = stpc;
    else
      stpf = stpc + (stpq - stpc) / 2;
    m_brackt = true;
  } else {

    if (sgnd < 0.0) {

      info = 2;
      bound = false;
      theta = 3 * (fx - fp) / (stp - stx) + dx + dp;
      s = MathMax(MathAbs(theta), MathMax(MathAbs(dx), MathAbs(dp)));
      gamma = s * MathSqrt(CMath::Sqr(theta / s) - dx / s * (dp / s));

      if (stp > stx)
        gamma = -gamma;

      p = gamma - dp + theta;
      q = gamma - dp + gamma + dx;
      r = p / q;
      stpc = stp + r * (stx - stp);
      stpq = stp + dp / (dp - dx) * (stx - stp);

      if (MathAbs(stpc - stp) > MathAbs(stpq - stp))
        stpf = stpc;
      else
        stpf = stpq;
      m_brackt = true;
    } else {

      if (MathAbs(dp) < MathAbs(dx)) {

        info = 3;
        bound = true;
        theta = 3 * (fx - fp) / (stp - stx) + dx + dp;
        s = MathMax(MathAbs(theta), MathMax(MathAbs(dx), MathAbs(dp)));

        gamma =
            s * MathSqrt(MathMax(0, CMath::Sqr(theta / s) - dx / s * (dp / s)));

        if (stp > stx)
          gamma = -gamma;
        p = gamma - dp + theta;
        q = gamma + (dx - dp) + gamma;
        r = p / q;

        if (r < 0.0 && (double)(gamma) != 0.0)
          stpc = stp + r * (stx - stp);
        else {

          if (stp > stx)
            stpc = stmax;
          else
            stpc = stmin;
        }
        stpq = stp + dp / (dp - dx) * (stx - stp);

        if (m_brackt) {

          if (MathAbs(stp - stpc) < MathAbs(stp - stpq))
            stpf = stpc;
          else
            stpf = stpq;
        } else {

          if (MathAbs(stp - stpc) > MathAbs(stp - stpq))
            stpf = stpc;
          else
            stpf = stpq;
        }
      } else {

        info = 4;
        bound = false;

        if (m_brackt) {
          theta = 3 * (fp - fy) / (sty - stp) + dy + dp;
          s = MathMax(MathAbs(theta), MathMax(MathAbs(dy), MathAbs(dp)));
          gamma = s * MathSqrt(CMath::Sqr(theta / s) - dy / s * (dp / s));

          if (stp > sty)
            gamma = -gamma;

          p = gamma - dp + theta;
          q = gamma - dp + gamma + dy;
          r = p / q;
          stpc = stp + r * (sty - stp);
          stpf = stpc;
        } else {

          if (stp > stx)
            stpf = stmax;
          else
            stpf = stmin;
        }
      }
    }
  }

  if (fp > fx) {

    sty = stp;
    fy = fp;
    dy = dp;
  } else {

    if (sgnd < 0.0) {

      sty = stx;
      fy = fx;
      dy = dx;
    }

    stx = stp;
    fx = fp;
    dx = dp;
  }

  stpf = MathMin(stmax, stpf);
  stpf = MathMax(stmin, stpf);
  stp = stpf;

  if (m_brackt && bound) {

    if (sty > stx)
      stp = MathMin(stx + 0.66 * (sty - stx), stp);
    else
      stp = MathMax(stx + 0.66 * (sty - stx), stp);
  }
}

static bool CLinMin::ArmijoIteration(CArmijoState &state) {

  double v = 0;
  int n = 0;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    v = state.m_rstate.ra[0];
  } else {

    n = -983;
    v = -989;
  }

  if (state.m_rstate.stage == 0) {
    state.m_nfev = state.m_nfev + 1;

    if (state.m_f >= state.m_fcur) {

      v = state.m_stplen / m_armijofactor;

      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_x[i_] = state.m_xbase[i_];
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_x[i_] = state.m_x[i_] + v * state.m_s[i_];
      state.m_rstate.stage = 2;

      Func_lbl_rcomm(state, n, v);

      return (true);
    }

    state.m_stplen = v;
    state.m_fcur = state.m_f;

    return (Func_lbl_6(state, n, v));
  }

  if (state.m_rstate.stage == 1) {
    state.m_nfev = state.m_nfev + 1;

    if (state.m_f < state.m_fcur) {

      state.m_stplen = v;
      state.m_fcur = state.m_f;
    } else {
      state.m_info = 1;

      return (false);
    }

    return (Func_lbl_6(state, n, v));
  }

  if (state.m_rstate.stage == 2) {
    state.m_nfev = state.m_nfev + 1;

    if (state.m_f >= state.m_fcur) {

      state.m_info = 1;

      return (false);
    }

    state.m_stplen = state.m_stplen / m_armijofactor;
    state.m_fcur = state.m_f;

    return (Func_lbl_10(state, n, v));
  }

  if (state.m_rstate.stage == 3) {
    state.m_nfev = state.m_nfev + 1;

    if (state.m_f < state.m_fcur) {

      state.m_stplen = state.m_stplen / m_armijofactor;
      state.m_fcur = state.m_f;
    } else {
      state.m_info = 1;

      return (false);
    }
    return (Func_lbl_10(state, n, v));
  }

  if ((state.m_stplen <= 0.0 || state.m_stpmax < 0.0) || state.m_fmax < 2) {
    state.m_info = 0;

    return (false);
  }

  if (state.m_stplen <= m_stpmin) {
    state.m_info = 4;

    return (false);
  }

  n = state.m_n;
  state.m_nfev = 0;

  state.m_needf = true;

  if (state.m_stplen > state.m_stpmax && state.m_stpmax != 0.0)
    state.m_stplen = state.m_stpmax;

  v = state.m_stplen * m_armijofactor;

  if (v > state.m_stpmax && state.m_stpmax != 0.0)
    v = state.m_stpmax;

  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_x[i_] + v * state.m_s[i_];
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, v);

  return (true);
}

static void CLinMin::Func_lbl_rcomm(CArmijoState &state, int n, double v) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ra[0] = v;
}

static bool CLinMin::Func_lbl_6(CArmijoState &state, int &n, double &v) {

  if (state.m_nfev >= state.m_fmax) {
    state.m_info = 3;

    return (false);
  }

  if (state.m_stplen >= state.m_stpmax) {
    state.m_info = 5;

    return (false);
  }

  v = state.m_stplen * m_armijofactor;

  if (v > state.m_stpmax && state.m_stpmax != 0.0)
    v = state.m_stpmax;

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_x[i_] + v * state.m_s[i_];
  state.m_rstate.stage = 1;

  Func_lbl_rcomm(state, n, v);

  return (true);
}

static bool CLinMin::Func_lbl_10(CArmijoState &state, int &n, double &v) {

  if (state.m_nfev >= state.m_fmax) {
    state.m_info = 3;

    return (false);
  }

  if (state.m_stplen <= m_stpmin) {
    state.m_info = 4;

    return (false);
  }

  v = state.m_stplen / m_armijofactor;

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_x[i_] + v * state.m_s[i_];
  state.m_rstate.stage = 3;

  Func_lbl_rcomm(state, n, v);

  return (true);
}

class COptServ {
public:
  COptServ(void);
  ~COptServ(void);

  static void TrimPrepare(const double f, double &threshold);
  static void TrimFunction(double &f, double &g[], const int n,
                           const double threshold);
};

COptServ::COptServ(void) {}

COptServ::~COptServ(void) {}

static void COptServ::TrimPrepare(const double f, double &threshold) {

  threshold = 10 * (MathAbs(f) + 1);
}

static void COptServ::TrimFunction(double &f, double &g[], const int n,
                                   const double threshold) {

  int i = 0;

  if (f >= threshold) {
    f = threshold;
    for (i = 0; i <= n - 1; i++)
      g[i] = 0.0;
  }
}

class CFtPlan {
public:
  int m_plan[];
  double m_precomputed[];
  double m_tmpbuf[];
  double m_stackbuf[];

  CFtPlan(void);
  ~CFtPlan(void);
};

CFtPlan::CFtPlan(void) {}

CFtPlan::~CFtPlan(void) {}

class CFtBase {
private:
  static void FtBaseGeneratePlanRec(const int n, int tasktype, CFtPlan &plan,
                                    int &plansize, int &precomputedsize,
                                    int &planarraysize, int &tmpmemsize,
                                    int &stackmemsize, int stackptr);
  static void FtBasePrecomputePlanRec(CFtPlan &plan, const int entryoffset,
                                      const int stackptr);
  static void FFtTwCalc(double &a[], const int aoffset, const int n1,
                        const int n2);
  static void InternalComplexLinTranspose(double &a[], const int m, const int n,
                                          const int astart, double &buf[]);
  static void InternalRealLinTranspose(double &a[], const int m, const int n,
                                       const int astart, double &buf[]);
  static void FFtICLTRec(double &a[], const int astart, const int astride,
                         double &b[], const int bstart, const int bstride,
                         const int m, const int n);
  static void FFtIRLTRec(double &a[], const int astart, const int astride,
                         double &b[], const int bstart, const int bstride,
                         const int m, const int n);
  static void FtBaseFindSmoothRec(const int n, const int seed,
                                  const int leastfactor, int &best);
  static void FFtArrayResize(int &a[], int &asize, const int newasize);
  static void ReFFHt(double &a[], const int n, const int offs);

public:
  static const int m_ftbaseplanentrysize;
  static const int m_ftbasecffttask;
  static const int m_ftbaserfhttask;
  static const int m_ftbaserffttask;
  static const int m_fftcooleytukeyplan;
  static const int m_fftbluesteinplan;
  static const int m_fftcodeletplan;
  static const int m_fhtcooleytukeyplan;
  static const int m_fhtcodeletplan;
  static const int m_fftrealcooleytukeyplan;
  static const int m_fftemptyplan;
  static const int m_fhtn2plan;
  static const int m_ftbaseupdatetw;
  static const int m_ftbasecodeletrecommended;
  static const double m_ftbaseinefficiencyfactor;
  static const int m_ftbasemaxsmoothfactor;

  CFtBase(void);
  ~CFtBase(void);

  static void FtBaseGenerateComplexFFtPlan(const int n, CFtPlan &plan);
  static void FtBaseGenerateRealFFtPlan(const int n, CFtPlan &plan);
  static void FtBaseGenerateRealFHtPlan(const int n, CFtPlan &plan);
  static void FtBaseExecutePlan(double &a[], const int aoffset, const int n,
                                CFtPlan &plan);
  static void FtBaseExecutePlanRec(double &a[], const int aoffset,
                                   CFtPlan &plan, const int entryoffset,
                                   const int stackptr);
  static void FtBaseFactorize(const int n, const int tasktype, int &n1,
                              int &n2);
  static bool FtBaseIsSmooth(int n);
  static int FtBaseFindSmooth(const int n);
  static int FtBaseFindSmoothEven(const int n);
  static double FtBaseGetFlopEstimate(const int n);
};

CFtBase::CFtBase(void) {}

CFtBase::~CFtBase(void) {}

const int CFtBase::m_ftbaseplanentrysize = 8;
const int CFtBase::m_ftbasecffttask = 0;
const int CFtBase::m_ftbaserfhttask = 1;
const int CFtBase::m_ftbaserffttask = 2;
const int CFtBase::m_fftcooleytukeyplan = 0;
const int CFtBase::m_fftbluesteinplan = 1;
const int CFtBase::m_fftcodeletplan = 2;
const int CFtBase::m_fhtcooleytukeyplan = 3;
const int CFtBase::m_fhtcodeletplan = 4;
const int CFtBase::m_fftrealcooleytukeyplan = 5;
const int CFtBase::m_fftemptyplan = 6;
const int CFtBase::m_fhtn2plan = 999;
const int CFtBase::m_ftbaseupdatetw = 4;
const int CFtBase::m_ftbasecodeletrecommended = 5;
const double CFtBase::m_ftbaseinefficiencyfactor = 1.3;
const int CFtBase::m_ftbasemaxsmoothfactor = 5;

static void CFtBase::FtBaseGenerateComplexFFtPlan(const int n, CFtPlan &plan) {

  int planarraysize = 0;
  int plansize = 0;
  int precomputedsize = 0;
  int tmpmemsize = 0;
  int stackmemsize = 0;
  int stackptr = 0;

  planarraysize = 1;
  plansize = 0;
  precomputedsize = 0;
  stackmemsize = 0;
  stackptr = 0;
  tmpmemsize = 2 * n;

  ArrayResizeAL(plan.m_plan, planarraysize);

  FtBaseGeneratePlanRec(n, m_ftbasecffttask, plan, plansize, precomputedsize,
                        planarraysize, tmpmemsize, stackmemsize, stackptr);

  if (!CAp::Assert(stackptr == 0, __FUNCTION__ + ": stack ptr!"))
    return;

  ArrayResizeAL(plan.m_stackbuf, (int)MathMax(stackmemsize, 1));

  ArrayResizeAL(plan.m_tmpbuf, (int)MathMax(tmpmemsize, 1));

  ArrayResizeAL(plan.m_precomputed, (int)MathMax(precomputedsize, 1));
  stackptr = 0;

  FtBasePrecomputePlanRec(plan, 0, stackptr);

  if (!CAp::Assert(stackptr == 0, __FUNCTION__ + ": stack ptr!"))
    return;
}

static void CFtBase::FtBaseGenerateRealFFtPlan(const int n, CFtPlan &plan) {

  int planarraysize = 0;
  int plansize = 0;
  int precomputedsize = 0;
  int tmpmemsize = 0;
  int stackmemsize = 0;
  int stackptr = 0;

  planarraysize = 1;
  plansize = 0;
  precomputedsize = 0;
  stackmemsize = 0;
  stackptr = 0;
  tmpmemsize = 2 * n;

  ArrayResizeAL(plan.m_plan, planarraysize);

  FtBaseGeneratePlanRec(n, m_ftbaserffttask, plan, plansize, precomputedsize,
                        planarraysize, tmpmemsize, stackmemsize, stackptr);

  if (!CAp::Assert(stackptr == 0, __FUNCTION__ + ": stack ptr!"))
    return;

  ArrayResizeAL(plan.m_stackbuf, (int)MathMax(stackmemsize, 1));

  ArrayResizeAL(plan.m_tmpbuf, (int)MathMax(tmpmemsize, 1));

  ArrayResizeAL(plan.m_precomputed, (int)MathMax(precomputedsize, 1));
  stackptr = 0;

  FtBasePrecomputePlanRec(plan, 0, stackptr);

  if (!CAp::Assert(stackptr == 0, __FUNCTION__ + ": stack ptr!"))
    return;
}

static void CFtBase::FtBaseGenerateRealFHtPlan(const int n, CFtPlan &plan) {

  int planarraysize = 0;
  int plansize = 0;
  int precomputedsize = 0;
  int tmpmemsize = 0;
  int stackmemsize = 0;
  int stackptr = 0;

  planarraysize = 1;
  plansize = 0;
  precomputedsize = 0;
  stackmemsize = 0;
  stackptr = 0;
  tmpmemsize = n;

  ArrayResizeAL(plan.m_plan, planarraysize);

  FtBaseGeneratePlanRec(n, m_ftbaserfhttask, plan, plansize, precomputedsize,
                        planarraysize, tmpmemsize, stackmemsize, stackptr);

  if (!CAp::Assert(stackptr == 0, __FUNCTION__ + ": stack ptr!"))
    return;

  ArrayResizeAL(plan.m_stackbuf, (int)MathMax(stackmemsize, 1));

  ArrayResizeAL(plan.m_tmpbuf, (int)MathMax(tmpmemsize, 1));

  ArrayResizeAL(plan.m_precomputed, (int)MathMax(precomputedsize, 1));
  stackptr = 0;

  FtBasePrecomputePlanRec(plan, 0, stackptr);

  if (!CAp::Assert(stackptr == 0, __FUNCTION__ + ": stack ptr!"))
    return;
}

static void CFtBase::FtBaseExecutePlan(double &a[], const int aoffset,
                                       const int n, CFtPlan &plan) {

  int stackptr = 0;

  FtBaseExecutePlanRec(a, aoffset, plan, 0, stackptr);
}

static void CFtBase::FtBaseExecutePlanRec(double &a[], const int aoffset,
                                          CFtPlan &plan, const int entryoffset,
                                          const int stackptr) {

  int i = 0;
  int j = 0;
  int k = 0;
  int n1 = 0;
  int n2 = 0;
  int n = 0;
  int m = 0;
  int offs = 0;
  int offs1 = 0;
  int offs2 = 0;
  int offsa = 0;
  int offsb = 0;
  int offsp = 0;
  double hk = 0;
  double hnk = 0;
  double x = 0;
  double y = 0;
  double bx = 0;
  double by = 0;
  double emptyarray[];
  double a0x = 0;
  double a0y = 0;
  double a1x = 0;
  double a1y = 0;
  double a2x = 0;
  double a2y = 0;
  double a3x = 0;
  double a3y = 0;
  double v0 = 0;
  double v1 = 0;
  double v2 = 0;
  double v3 = 0;
  double t1x = 0;
  double t1y = 0;
  double t2x = 0;
  double t2y = 0;
  double t3x = 0;
  double t3y = 0;
  double t4x = 0;
  double t4y = 0;
  double t5x = 0;
  double t5y = 0;
  double m1x = 0;
  double m1y = 0;
  double m2x = 0;
  double m2y = 0;
  double m3x = 0;
  double m3y = 0;
  double m4x = 0;
  double m4y = 0;
  double m5x = 0;
  double m5y = 0;
  double s1x = 0;
  double s1y = 0;
  double s2x = 0;
  double s2y = 0;
  double s3x = 0;
  double s3y = 0;
  double s4x = 0;
  double s4y = 0;
  double s5x = 0;
  double s5y = 0;
  double c1 = 0;
  double c2 = 0;
  double c3 = 0;
  double c4 = 0;
  double c5 = 0;
  double tmp[];
  int i_ = 0;
  int i1_ = 0;

  if (plan.m_plan[entryoffset + 3] == m_fftemptyplan)
    return;

  if (plan.m_plan[entryoffset + 3] == m_fftcooleytukeyplan) {

    n1 = plan.m_plan[entryoffset + 1];
    n2 = plan.m_plan[entryoffset + 2];

    InternalComplexLinTranspose(a, n1, n2, aoffset, plan.m_tmpbuf);
    for (i = 0; i <= n2 - 1; i++) {

      FtBaseExecutePlanRec(a, aoffset + i * n1 * 2, plan,
                           plan.m_plan[entryoffset + 5], stackptr);
    }

    FFtTwCalc(a, aoffset, n1, n2);

    InternalComplexLinTranspose(a, n2, n1, aoffset, plan.m_tmpbuf);
    for (i = 0; i <= n1 - 1; i++) {

      FtBaseExecutePlanRec(a, aoffset + i * n2 * 2, plan,
                           plan.m_plan[entryoffset + 6], stackptr);
    }

    InternalComplexLinTranspose(a, n1, n2, aoffset, plan.m_tmpbuf);

    return;
  }

  if (plan.m_plan[entryoffset + 3] == m_fftrealcooleytukeyplan) {

    n1 = plan.m_plan[entryoffset + 1];
    n2 = plan.m_plan[entryoffset + 2];

    InternalComplexLinTranspose(a, n2, n1, aoffset, plan.m_tmpbuf);
    for (i = 0; i <= n1 / 2 - 1; i++) {

      offs = aoffset + 2 * i * n2 * 2;
      for (k = 0; k <= n2 - 1; k++)
        a[offs + 2 * k + 1] = a[offs + 2 * n2 + 2 * k + 0];

      FtBaseExecutePlanRec(a, offs, plan, plan.m_plan[entryoffset + 6],
                           stackptr);

      plan.m_tmpbuf[0] = a[offs + 0];
      plan.m_tmpbuf[1] = 0;
      plan.m_tmpbuf[2 * n2 + 0] = a[offs + 1];
      plan.m_tmpbuf[2 * n2 + 1] = 0;
      for (k = 1; k <= n2 - 1; k++) {

        offs1 = 2 * k;
        offs2 = 2 * n2 + 2 * k;
        hk = a[offs + 2 * k + 0];
        hnk = a[offs + 2 * (n2 - k) + 0];
        plan.m_tmpbuf[offs1 + 0] = 0.5 * (hk + hnk);
        plan.m_tmpbuf[offs2 + 1] = -(0.5 * (hk - hnk));
        hk = a[offs + 2 * k + 1];
        hnk = a[offs + 2 * (n2 - k) + 1];
        plan.m_tmpbuf[offs2 + 0] = 0.5 * (hk + hnk);
        plan.m_tmpbuf[offs1 + 1] = 0.5 * (hk - hnk);
      }
      i1_ = -offs;
      for (i_ = offs; i_ <= offs + 2 * n2 * 2 - 1; i_++)
        a[i_] = plan.m_tmpbuf[i_ + i1_];
    }

    if (n1 % 2 != 0) {

      FtBaseExecutePlanRec(a, aoffset + (n1 - 1) * n2 * 2, plan,
                           plan.m_plan[entryoffset + 6], stackptr);
    }

    FFtTwCalc(a, aoffset, n2, n1);

    InternalComplexLinTranspose(a, n1, n2, aoffset, plan.m_tmpbuf);
    for (i = 0; i <= n2 - 1; i++) {

      FtBaseExecutePlanRec(a, aoffset + i * n1 * 2, plan,
                           plan.m_plan[entryoffset + 5], stackptr);
    }

    InternalComplexLinTranspose(a, n2, n1, aoffset, plan.m_tmpbuf);

    return;
  }

  if (plan.m_plan[entryoffset + 3] == m_fhtcooleytukeyplan) {

    n1 = plan.m_plan[entryoffset + 1];
    n2 = plan.m_plan[entryoffset + 2];
    n = n1 * n2;

    InternalRealLinTranspose(a, n1, n2, aoffset, plan.m_tmpbuf);
    for (i = 0; i <= n2 - 1; i++) {

      FtBaseExecutePlanRec(a, aoffset + i * n1, plan,
                           plan.m_plan[entryoffset + 5], stackptr);
    }
    for (i = 0; i <= n2 - 1; i++) {
      for (j = 0; j <= n1 - 1; j++) {

        offsa = aoffset + i * n1;
        hk = a[offsa + j];
        hnk = a[offsa + (n1 - j) % n1];
        offs = 2 * (i * n1 + j);
        plan.m_tmpbuf[offs + 0] = -(0.5 * (hnk - hk));
        plan.m_tmpbuf[offs + 1] = 0.5 * (hk + hnk);
      }
    }

    FFtTwCalc(plan.m_tmpbuf, 0, n1, n2);
    for (j = 0; j <= n1 - 1; j++)
      a[aoffset + j] = plan.m_tmpbuf[2 * j + 0] + plan.m_tmpbuf[2 * j + 1];

    if (n2 % 2 == 0) {
      offs = 2 * (n2 / 2) * n1;
      offsa = aoffset + n2 / 2 * n1;
      for (j = 0; j <= n1 - 1; j++)
        a[offsa + j] =
            plan.m_tmpbuf[offs + 2 * j + 0] + plan.m_tmpbuf[offs + 2 * j + 1];
    }
    for (i = 1; i <= (n2 + 1) / 2 - 1; i++) {

      offs = 2 * i * n1;
      offs2 = 2 * (n2 - i) * n1;
      offsa = aoffset + i * n1;
      for (j = 0; j <= n1 - 1; j++)
        a[offsa + j] =
            plan.m_tmpbuf[offs + 2 * j + 1] + plan.m_tmpbuf[offs2 + 2 * j + 0];
      offsa = aoffset + (n2 - i) * n1;
      for (j = 0; j <= n1 - 1; j++)
        a[offsa + j] =
            plan.m_tmpbuf[offs + 2 * j + 0] + plan.m_tmpbuf[offs2 + 2 * j + 1];
    }

    InternalRealLinTranspose(a, n2, n1, aoffset, plan.m_tmpbuf);
    for (i = 0; i <= n1 - 1; i++) {

      FtBaseExecutePlanRec(a, aoffset + i * n2, plan,
                           plan.m_plan[entryoffset + 6], stackptr);
    }

    InternalRealLinTranspose(a, n1, n2, aoffset, plan.m_tmpbuf);

    return;
  }

  if (plan.m_plan[entryoffset + 3] == m_fhtn2plan) {

    n1 = plan.m_plan[entryoffset + 1];
    n2 = plan.m_plan[entryoffset + 2];
    n = n1 * n2;
    ReFFHt(a, n, aoffset);

    return;
  }

  if (plan.m_plan[entryoffset + 3] == m_fftcodeletplan) {
    n1 = plan.m_plan[entryoffset + 1];
    n2 = plan.m_plan[entryoffset + 2];
    n = n1 * n2;

    if (n == 2) {

      a0x = a[aoffset + 0];
      a0y = a[aoffset + 1];
      a1x = a[aoffset + 2];
      a1y = a[aoffset + 3];
      v0 = a0x + a1x;
      v1 = a0y + a1y;
      v2 = a0x - a1x;
      v3 = a0y - a1y;
      a[aoffset + 0] = v0;
      a[aoffset + 1] = v1;
      a[aoffset + 2] = v2;
      a[aoffset + 3] = v3;

      return;
    }

    if (n == 3) {

      offs = plan.m_plan[entryoffset + 7];
      c1 = plan.m_precomputed[offs + 0];
      c2 = plan.m_precomputed[offs + 1];
      a0x = a[aoffset + 0];
      a0y = a[aoffset + 1];
      a1x = a[aoffset + 2];
      a1y = a[aoffset + 3];
      a2x = a[aoffset + 4];
      a2y = a[aoffset + 5];
      t1x = a1x + a2x;
      t1y = a1y + a2y;
      a0x = a0x + t1x;
      a0y = a0y + t1y;
      m1x = c1 * t1x;
      m1y = c1 * t1y;
      m2x = c2 * (a1y - a2y);
      m2y = c2 * (a2x - a1x);
      s1x = a0x + m1x;
      s1y = a0y + m1y;
      a1x = s1x + m2x;
      a1y = s1y + m2y;
      a2x = s1x - m2x;
      a2y = s1y - m2y;
      a[aoffset + 0] = a0x;
      a[aoffset + 1] = a0y;
      a[aoffset + 2] = a1x;
      a[aoffset + 3] = a1y;
      a[aoffset + 4] = a2x;
      a[aoffset + 5] = a2y;

      return;
    }

    if (n == 4) {

      a0x = a[aoffset + 0];
      a0y = a[aoffset + 1];
      a1x = a[aoffset + 2];
      a1y = a[aoffset + 3];
      a2x = a[aoffset + 4];
      a2y = a[aoffset + 5];
      a3x = a[aoffset + 6];
      a3y = a[aoffset + 7];
      t1x = a0x + a2x;
      t1y = a0y + a2y;
      t2x = a1x + a3x;
      t2y = a1y + a3y;
      m2x = a0x - a2x;
      m2y = a0y - a2y;
      m3x = a1y - a3y;
      m3y = a3x - a1x;
      a[aoffset + 0] = t1x + t2x;
      a[aoffset + 1] = t1y + t2y;
      a[aoffset + 4] = t1x - t2x;
      a[aoffset + 5] = t1y - t2y;
      a[aoffset + 2] = m2x + m3x;
      a[aoffset + 3] = m2y + m3y;
      a[aoffset + 6] = m2x - m3x;
      a[aoffset + 7] = m2y - m3y;

      return;
    }

    if (n == 5) {

      offs = plan.m_plan[entryoffset + 7];
      c1 = plan.m_precomputed[offs + 0];
      c2 = plan.m_precomputed[offs + 1];
      c3 = plan.m_precomputed[offs + 2];
      c4 = plan.m_precomputed[offs + 3];
      c5 = plan.m_precomputed[offs + 4];
      t1x = a[aoffset + 2] + a[aoffset + 8];
      t1y = a[aoffset + 3] + a[aoffset + 9];
      t2x = a[aoffset + 4] + a[aoffset + 6];
      t2y = a[aoffset + 5] + a[aoffset + 7];
      t3x = a[aoffset + 2] - a[aoffset + 8];
      t3y = a[aoffset + 3] - a[aoffset + 9];
      t4x = a[aoffset + 6] - a[aoffset + 4];
      t4y = a[aoffset + 7] - a[aoffset + 5];
      t5x = t1x + t2x;
      t5y = t1y + t2y;
      a[aoffset + 0] = a[aoffset + 0] + t5x;
      a[aoffset + 1] = a[aoffset + 1] + t5y;
      m1x = c1 * t5x;
      m1y = c1 * t5y;
      m2x = c2 * (t1x - t2x);
      m2y = c2 * (t1y - t2y);
      m3x = -(c3 * (t3y + t4y));
      m3y = c3 * (t3x + t4x);
      m4x = -(c4 * t4y);
      m4y = c4 * t4x;
      m5x = -(c5 * t3y);
      m5y = c5 * t3x;
      s3x = m3x - m4x;
      s3y = m3y - m4y;
      s5x = m3x + m5x;
      s5y = m3y + m5y;
      s1x = a[aoffset + 0] + m1x;
      s1y = a[aoffset + 1] + m1y;
      s2x = s1x + m2x;
      s2y = s1y + m2y;
      s4x = s1x - m2x;
      s4y = s1y - m2y;
      a[aoffset + 2] = s2x + s3x;
      a[aoffset + 3] = s2y + s3y;
      a[aoffset + 4] = s4x + s5x;
      a[aoffset + 5] = s4y + s5y;
      a[aoffset + 6] = s4x - s5x;
      a[aoffset + 7] = s4y - s5y;
      a[aoffset + 8] = s2x - s3x;
      a[aoffset + 9] = s2y - s3y;

      return;
    }
  }

  if (plan.m_plan[entryoffset + 3] == m_fhtcodeletplan) {

    n1 = plan.m_plan[entryoffset + 1];
    n2 = plan.m_plan[entryoffset + 2];
    n = n1 * n2;

    if (n == 2) {

      a0x = a[aoffset + 0];
      a1x = a[aoffset + 1];
      a[aoffset + 0] = a0x + a1x;
      a[aoffset + 1] = a0x - a1x;

      return;
    }

    if (n == 3) {

      offs = plan.m_plan[entryoffset + 7];
      c1 = plan.m_precomputed[offs + 0];
      c2 = plan.m_precomputed[offs + 1];
      a0x = a[aoffset + 0];
      a1x = a[aoffset + 1];
      a2x = a[aoffset + 2];
      t1x = a1x + a2x;
      a0x = a0x + t1x;
      m1x = c1 * t1x;
      m2y = c2 * (a2x - a1x);
      s1x = a0x + m1x;
      a[aoffset + 0] = a0x;
      a[aoffset + 1] = s1x - m2y;
      a[aoffset + 2] = s1x + m2y;

      return;
    }

    if (n == 4) {

      a0x = a[aoffset + 0];
      a1x = a[aoffset + 1];
      a2x = a[aoffset + 2];
      a3x = a[aoffset + 3];
      t1x = a0x + a2x;
      t2x = a1x + a3x;
      m2x = a0x - a2x;
      m3y = a3x - a1x;
      a[aoffset + 0] = t1x + t2x;
      a[aoffset + 1] = m2x - m3y;
      a[aoffset + 2] = t1x - t2x;
      a[aoffset + 3] = m2x + m3y;

      return;
    }

    if (n == 5) {

      offs = plan.m_plan[entryoffset + 7];
      c1 = plan.m_precomputed[offs + 0];
      c2 = plan.m_precomputed[offs + 1];
      c3 = plan.m_precomputed[offs + 2];
      c4 = plan.m_precomputed[offs + 3];
      c5 = plan.m_precomputed[offs + 4];
      t1x = a[aoffset + 1] + a[aoffset + 4];
      t2x = a[aoffset + 2] + a[aoffset + 3];
      t3x = a[aoffset + 1] - a[aoffset + 4];
      t4x = a[aoffset + 3] - a[aoffset + 2];
      t5x = t1x + t2x;
      v0 = a[aoffset + 0] + t5x;
      a[aoffset + 0] = v0;
      m2x = c2 * (t1x - t2x);
      m3y = c3 * (t3x + t4x);
      s3y = m3y - c4 * t4x;
      s5y = m3y + c5 * t3x;
      s1x = v0 + c1 * t5x;
      s2x = s1x + m2x;
      s4x = s1x - m2x;
      a[aoffset + 1] = s2x - s3y;
      a[aoffset + 2] = s4x - s5y;
      a[aoffset + 3] = s4x + s5y;
      a[aoffset + 4] = s2x + s3y;

      return;
    }
  }

  if (plan.m_plan[entryoffset + 3] == m_fftbluesteinplan) {

    n = plan.m_plan[entryoffset + 1];
    m = plan.m_plan[entryoffset + 4];
    offs = plan.m_plan[entryoffset + 7];
    for (i = stackptr + 2 * n; i <= stackptr + 2 * m - 1; i++)
      plan.m_stackbuf[i] = 0;

    offsp = offs + 2 * m;
    offsa = aoffset;
    offsb = stackptr;
    for (i = 0; i <= n - 1; i++) {

      bx = plan.m_precomputed[offsp + 0];
      by = plan.m_precomputed[offsp + 1];
      x = a[offsa + 0];
      y = a[offsa + 1];
      plan.m_stackbuf[offsb + 0] = x * bx - y * -by;
      plan.m_stackbuf[offsb + 1] = x * -by + y * bx;
      offsp = offsp + 2;
      offsa = offsa + 2;
      offsb = offsb + 2;
    }

    FtBaseExecutePlanRec(plan.m_stackbuf, stackptr, plan,
                         plan.m_plan[entryoffset + 5], stackptr + 2 * 2 * m);
    offsb = stackptr;
    offsp = offs;
    for (i = 0; i <= m - 1; i++) {

      x = plan.m_stackbuf[offsb + 0];
      y = plan.m_stackbuf[offsb + 1];
      bx = plan.m_precomputed[offsp + 0];
      by = plan.m_precomputed[offsp + 1];
      plan.m_stackbuf[offsb + 0] = x * bx - y * by;
      plan.m_stackbuf[offsb + 1] = -(x * by + y * bx);
      offsb = offsb + 2;
      offsp = offsp + 2;
    }

    FtBaseExecutePlanRec(plan.m_stackbuf, stackptr, plan,
                         plan.m_plan[entryoffset + 5], stackptr + 2 * 2 * m);
    offsb = stackptr;
    offsp = offs + 2 * m;
    offsa = aoffset;
    for (i = 0; i <= n - 1; i++) {

      x = plan.m_stackbuf[offsb + 0] / m;
      y = -(plan.m_stackbuf[offsb + 1] / m);
      bx = plan.m_precomputed[offsp + 0];
      by = plan.m_precomputed[offsp + 1];
      a[offsa + 0] = x * bx - y * -by;
      a[offsa + 1] = x * -by + y * bx;
      offsp = offsp + 2;
      offsa = offsa + 2;
      offsb = offsb + 2;
    }

    return;
  }
}

static void CFtBase::FtBaseFactorize(const int n, const int tasktype, int &n1,
                                     int &n2) {

  int j = 0;

  n1 = 0;
  n2 = 0;

  if (n1 * n2 != n) {
    for (j = m_ftbasecodeletrecommended; j >= 2; j--) {

      if (n % j == 0) {
        n1 = j;
        n2 = n / j;
        break;
      }
    }
  }

  if (n1 * n2 != n) {
    for (j = m_ftbasecodeletrecommended + 1; j <= n - 1; j++) {

      if (n % j == 0) {
        n1 = j;
        n2 = n / j;
        break;
      }
    }
  }

  if (n1 * n2 != n) {
    n1 = 1;
    n2 = n;
  }

  if (n2 == 1 && n1 != 1) {
    n2 = n1;
    n1 = 1;
  }
}

static bool CFtBase::FtBaseIsSmooth(int n) {

  int i = 0;

  for (i = 2; i <= m_ftbasemaxsmoothfactor; i++) {
    while (n % i == 0)
      n = n / i;
  }

  if (n == 1)
    return (true);

  return (false);
}

static int CFtBase::FtBaseFindSmooth(const int n) {

  int best = 0;

  best = 2;
  while (best < n)
    best = 2 * best;

  FtBaseFindSmoothRec(n, 1, 2, best);

  return (best);
}

static int CFtBase::FtBaseFindSmoothEven(const int n) {

  int best = 0;

  best = 2;
  while (best < n)
    best = 2 * best;

  FtBaseFindSmoothRec(n, 2, 2, best);

  return (best);
}

static double CFtBase::FtBaseGetFlopEstimate(const int n) {

  return (m_ftbaseinefficiencyfactor *
          (4 * n * MathLog(n) / MathLog(2) - 6 * n + 8));
}

static void CFtBase::FtBaseGeneratePlanRec(const int n, int tasktype,
                                           CFtPlan &plan, int &plansize,
                                           int &precomputedsize,
                                           int &planarraysize, int &tmpmemsize,
                                           int &stackmemsize, int stackptr) {

  int k = 0;
  int m = 0;
  int n1 = 0;
  int n2 = 0;
  int esize = 0;
  int entryoffset = 0;

  if (plansize + m_ftbaseplanentrysize > planarraysize)
    FFtArrayResize(plan.m_plan, planarraysize, 8 * planarraysize);
  entryoffset = plansize;
  esize = m_ftbaseplanentrysize;
  plansize = plansize + esize;

  if (n == 1) {

    plan.m_plan[entryoffset + 0] = esize;
    plan.m_plan[entryoffset + 1] = -1;
    plan.m_plan[entryoffset + 2] = -1;
    plan.m_plan[entryoffset + 3] = m_fftemptyplan;
    plan.m_plan[entryoffset + 4] = -1;
    plan.m_plan[entryoffset + 5] = -1;
    plan.m_plan[entryoffset + 6] = -1;
    plan.m_plan[entryoffset + 7] = -1;

    return;
  }

  FtBaseFactorize(n, tasktype, n1, n2);

  if (tasktype == m_ftbasecffttask || tasktype == m_ftbaserffttask) {

    if (n1 != 1) {

      tmpmemsize = MathMax(tmpmemsize, 2 * n1 * n2);
      plan.m_plan[entryoffset + 0] = esize;
      plan.m_plan[entryoffset + 1] = n1;
      plan.m_plan[entryoffset + 2] = n2;

      if (tasktype == m_ftbasecffttask)
        plan.m_plan[entryoffset + 3] = m_fftcooleytukeyplan;
      else
        plan.m_plan[entryoffset + 3] = m_fftrealcooleytukeyplan;
      plan.m_plan[entryoffset + 4] = 0;
      plan.m_plan[entryoffset + 5] = plansize;

      FtBaseGeneratePlanRec(n1, m_ftbasecffttask, plan, plansize,
                            precomputedsize, planarraysize, tmpmemsize,
                            stackmemsize, stackptr);
      plan.m_plan[entryoffset + 6] = plansize;

      FtBaseGeneratePlanRec(n2, m_ftbasecffttask, plan, plansize,
                            precomputedsize, planarraysize, tmpmemsize,
                            stackmemsize, stackptr);
      plan.m_plan[entryoffset + 7] = -1;

      return;
    } else {

      if (((n == 2 || n == 3) || n == 4) || n == 5) {

        plan.m_plan[entryoffset + 0] = esize;
        plan.m_plan[entryoffset + 1] = n1;
        plan.m_plan[entryoffset + 2] = n2;
        plan.m_plan[entryoffset + 3] = m_fftcodeletplan;
        plan.m_plan[entryoffset + 4] = 0;
        plan.m_plan[entryoffset + 5] = -1;
        plan.m_plan[entryoffset + 6] = -1;
        plan.m_plan[entryoffset + 7] = precomputedsize;

        if (n == 3)
          precomputedsize = precomputedsize + 2;

        if (n == 5)
          precomputedsize = precomputedsize + 5;

        return;
      } else {

        k = 2 * n2 - 1;
        m = FtBaseFindSmooth(k);
        tmpmemsize = MathMax(tmpmemsize, 2 * m);
        plan.m_plan[entryoffset + 0] = esize;
        plan.m_plan[entryoffset + 1] = n2;
        plan.m_plan[entryoffset + 2] = -1;
        plan.m_plan[entryoffset + 3] = m_fftbluesteinplan;
        plan.m_plan[entryoffset + 4] = m;
        plan.m_plan[entryoffset + 5] = plansize;
        stackptr = stackptr + 2 * 2 * m;
        stackmemsize = MathMax(stackmemsize, stackptr);

        FtBaseGeneratePlanRec(m, m_ftbasecffttask, plan, plansize,
                              precomputedsize, planarraysize, tmpmemsize,
                              stackmemsize, stackptr);
        stackptr = stackptr - 2 * 2 * m;
        plan.m_plan[entryoffset + 6] = -1;
        plan.m_plan[entryoffset + 7] = precomputedsize;
        precomputedsize = precomputedsize + 2 * m + 2 * n;

        return;
      }
    }
  }

  if (tasktype == m_ftbaserfhttask) {

    if (n1 != 1) {

      tmpmemsize = MathMax(tmpmemsize, 2 * n1 * n2);
      plan.m_plan[entryoffset + 0] = esize;
      plan.m_plan[entryoffset + 1] = n1;
      plan.m_plan[entryoffset + 2] = n2;
      plan.m_plan[entryoffset + 3] = m_fhtcooleytukeyplan;
      plan.m_plan[entryoffset + 4] = 0;
      plan.m_plan[entryoffset + 5] = plansize;

      FtBaseGeneratePlanRec(n1, tasktype, plan, plansize, precomputedsize,
                            planarraysize, tmpmemsize, stackmemsize, stackptr);
      plan.m_plan[entryoffset + 6] = plansize;

      FtBaseGeneratePlanRec(n2, tasktype, plan, plansize, precomputedsize,
                            planarraysize, tmpmemsize, stackmemsize, stackptr);
      plan.m_plan[entryoffset + 7] = -1;

      return;
    } else {

      plan.m_plan[entryoffset + 0] = esize;
      plan.m_plan[entryoffset + 1] = n1;
      plan.m_plan[entryoffset + 2] = n2;
      plan.m_plan[entryoffset + 3] = m_fhtn2plan;
      plan.m_plan[entryoffset + 4] = 0;
      plan.m_plan[entryoffset + 5] = -1;
      plan.m_plan[entryoffset + 6] = -1;
      plan.m_plan[entryoffset + 7] = -1;

      if (((n == 2 || n == 3) || n == 4) || n == 5) {

        plan.m_plan[entryoffset + 0] = esize;
        plan.m_plan[entryoffset + 1] = n1;
        plan.m_plan[entryoffset + 2] = n2;
        plan.m_plan[entryoffset + 3] = m_fhtcodeletplan;
        plan.m_plan[entryoffset + 4] = 0;
        plan.m_plan[entryoffset + 5] = -1;
        plan.m_plan[entryoffset + 6] = -1;
        plan.m_plan[entryoffset + 7] = precomputedsize;

        if (n == 3)
          precomputedsize = precomputedsize + 2;

        if (n == 5)
          precomputedsize = precomputedsize + 5;

        return;
      }

      return;
    }
  }
}

static void CFtBase::FtBasePrecomputePlanRec(CFtPlan &plan,
                                             const int entryoffset,
                                             const int stackptr) {

  int i = 0;
  int n1 = 0;
  int n2 = 0;
  int n = 0;
  int m = 0;
  int offs = 0;
  double v = 0;
  double emptyarray[];
  double bx = 0;
  double by = 0;

  if ((plan.m_plan[entryoffset + 3] == m_fftcooleytukeyplan ||
       plan.m_plan[entryoffset + 3] == m_fftrealcooleytukeyplan) ||
      plan.m_plan[entryoffset + 3] == m_fhtcooleytukeyplan) {

    FtBasePrecomputePlanRec(plan, plan.m_plan[entryoffset + 5], stackptr);

    FtBasePrecomputePlanRec(plan, plan.m_plan[entryoffset + 6], stackptr);

    return;
  }

  if (plan.m_plan[entryoffset + 3] == m_fftcodeletplan ||
      plan.m_plan[entryoffset + 3] == m_fhtcodeletplan) {
    n1 = plan.m_plan[entryoffset + 1];
    n2 = plan.m_plan[entryoffset + 2];
    n = n1 * n2;

    if (n == 3) {
      offs = plan.m_plan[entryoffset + 7];
      plan.m_precomputed[offs + 0] = MathCos(2 * M_PI / 3) - 1;
      plan.m_precomputed[offs + 1] = MathSin(2 * M_PI / 3);

      return;
    }

    if (n == 5) {
      offs = plan.m_plan[entryoffset + 7];
      v = 2 * M_PI / 5;
      plan.m_precomputed[offs + 0] = (MathCos(v) + MathCos(2 * v)) / 2 - 1;
      plan.m_precomputed[offs + 1] = (MathCos(v) - MathCos(2 * v)) / 2;
      plan.m_precomputed[offs + 2] = -MathSin(v);
      plan.m_precomputed[offs + 3] = -(MathSin(v) + MathSin(2 * v));
      plan.m_precomputed[offs + 4] = MathSin(v) - MathSin(2 * v);

      return;
    }
  }

  if (plan.m_plan[entryoffset + 3] == m_fftbluesteinplan) {

    FtBasePrecomputePlanRec(plan, plan.m_plan[entryoffset + 5], stackptr);
    n = plan.m_plan[entryoffset + 1];
    m = plan.m_plan[entryoffset + 4];
    offs = plan.m_plan[entryoffset + 7];
    for (i = 0; i <= 2 * m - 1; i++)
      plan.m_precomputed[offs + i] = 0;

    for (i = 0; i <= n - 1; i++) {
      bx = MathCos(M_PI * CMath::Sqr(i) / n);
      by = MathSin(M_PI * CMath::Sqr(i) / n);
      plan.m_precomputed[offs + 2 * i + 0] = bx;
      plan.m_precomputed[offs + 2 * i + 1] = by;
      plan.m_precomputed[offs + 2 * m + 2 * i + 0] = bx;
      plan.m_precomputed[offs + 2 * m + 2 * i + 1] = by;

      if (i > 0) {
        plan.m_precomputed[offs + 2 * (m - i) + 0] = bx;
        plan.m_precomputed[offs + 2 * (m - i) + 1] = by;
      }
    }

    FtBaseExecutePlanRec(plan.m_precomputed, offs, plan,
                         plan.m_plan[entryoffset + 5], stackptr);

    return;
  }
}

static void CFtBase::FFtTwCalc(double &a[], const int aoffset, const int n1,
                               const int n2) {

  int i = 0;
  int j = 0;
  int n = 0;
  int idx = 0;
  int offs = 0;
  double x = 0;
  double y = 0;
  double twxm1 = 0;
  double twy = 0;
  double twbasexm1 = 0;
  double twbasey = 0;
  double twrowxm1 = 0;
  double twrowy = 0;
  double tmpx = 0;
  double tmpy = 0;
  double v = 0;

  n = n1 * n2;
  v = -(2 * M_PI / n);
  twbasexm1 = -(2 * CMath::Sqr(MathSin(0.5 * v)));
  twbasey = MathSin(v);
  twrowxm1 = 0;
  twrowy = 0;

  for (i = 0; i <= n2 - 1; i++) {
    twxm1 = 0;
    twy = 0;
    for (j = 0; j <= n1 - 1; j++) {

      idx = i * n1 + j;
      offs = aoffset + 2 * idx;
      x = a[offs + 0];
      y = a[offs + 1];
      tmpx = x * twxm1 - y * twy;
      tmpy = x * twy + y * twxm1;
      a[offs + 0] = x + tmpx;
      a[offs + 1] = y + tmpy;

      if (j < n1 - 1) {

        if (j % m_ftbaseupdatetw == 0) {
          v = -(2 * M_PI * i * (j + 1) / n);
          twxm1 = -(2 * CMath::Sqr(MathSin(0.5 * v)));
          twy = MathSin(v);
        } else {
          tmpx = twrowxm1 + twxm1 * twrowxm1 - twy * twrowy;
          tmpy = twrowy + twxm1 * twrowy + twy * twrowxm1;
          twxm1 = twxm1 + tmpx;
          twy = twy + tmpy;
        }
      }
    }

    if (i < n2 - 1) {

      if (j % m_ftbaseupdatetw == 0) {
        v = -(2 * M_PI * (i + 1) / n);
        twrowxm1 = -(2 * CMath::Sqr(MathSin(0.5 * v)));
        twrowy = MathSin(v);
      } else {
        tmpx = twbasexm1 + twrowxm1 * twbasexm1 - twrowy * twbasey;
        tmpy = twbasey + twrowxm1 * twbasey + twrowy * twbasexm1;
        twrowxm1 = twrowxm1 + tmpx;
        twrowy = twrowy + tmpy;
      }
    }
  }
}

static void CFtBase::InternalComplexLinTranspose(double &a[], const int m,
                                                 const int n, const int astart,
                                                 double &buf[]) {

  int i_ = 0;
  int i1_ = 0;

  FFtICLTRec(a, astart, n, buf, 0, m, m, n);
  i1_ = -astart;

  for (i_ = astart; i_ <= astart + 2 * m * n - 1; i_++)
    a[i_] = buf[i_ + i1_];
}

static void CFtBase::InternalRealLinTranspose(double &a[], const int m,
                                              const int n, const int astart,
                                              double &buf[]) {

  int i_ = 0;
  int i1_ = 0;

  FFtIRLTRec(a, astart, n, buf, 0, m, m, n);
  i1_ = -astart;

  for (i_ = astart; i_ <= astart + m * n - 1; i_++)
    a[i_] = buf[i_ + i1_];
}

static void CFtBase::FFtICLTRec(double &a[], const int astart,
                                const int astride, double &b[],
                                const int bstart, const int bstride,
                                const int m, const int n) {

  int i = 0;
  int j = 0;
  int idx1 = 0;
  int idx2 = 0;
  int m2 = 0;
  int m1 = 0;
  int n1 = 0;

  if (m == 0 || n == 0)
    return;

  if (MathMax(m, n) <= 8) {
    m2 = 2 * bstride;
    for (i = 0; i <= m - 1; i++) {

      idx1 = bstart + 2 * i;
      idx2 = astart + 2 * i * astride;
      for (j = 0; j <= n - 1; j++) {
        b[idx1 + 0] = a[idx2 + 0];
        b[idx1 + 1] = a[idx2 + 1];
        idx1 = idx1 + m2;
        idx2 = idx2 + 2;
      }
    }

    return;
  }

  if (n > m) {

    n1 = n / 2;

    if (n - n1 >= 8 && n1 % 8 != 0)
      n1 = n1 + (8 - n1 % 8);

    if (!CAp::Assert(n - n1 > 0))
      return;

    FFtICLTRec(a, astart, astride, b, bstart, bstride, m, n1);

    FFtICLTRec(a, astart + 2 * n1, astride, b, bstart + 2 * n1 * bstride,
               bstride, m, n - n1);
  } else {

    m1 = m / 2;

    if (m - m1 >= 8 && m1 % 8 != 0)
      m1 = m1 + (8 - m1 % 8);

    if (!CAp::Assert(m - m1 > 0))
      return;

    FFtICLTRec(a, astart, astride, b, bstart, bstride, m1, n);

    FFtICLTRec(a, astart + 2 * m1 * astride, astride, b, bstart + 2 * m1,
               bstride, m - m1, n);
  }
}

static void CFtBase::FFtIRLTRec(double &a[], const int astart,
                                const int astride, double &b[],
                                const int bstart, const int bstride,
                                const int m, const int n) {

  int i = 0;
  int j = 0;
  int idx1 = 0;
  int idx2 = 0;
  int m1 = 0;
  int n1 = 0;

  if (m == 0 || n == 0)
    return;

  if (MathMax(m, n) <= 8) {
    for (i = 0; i <= m - 1; i++) {

      idx1 = bstart + i;
      idx2 = astart + i * astride;
      for (j = 0; j <= n - 1; j++) {
        b[idx1] = a[idx2];
        idx1 = idx1 + bstride;
        idx2 = idx2 + 1;
      }
    }

    return;
  }

  if (n > m) {

    n1 = n / 2;

    if (n - n1 >= 8 && n1 % 8 != 0)
      n1 = n1 + (8 - n1 % 8);

    if (!CAp::Assert(n - n1 > 0))
      return;

    FFtIRLTRec(a, astart, astride, b, bstart, bstride, m, n1);

    FFtIRLTRec(a, astart + n1, astride, b, bstart + n1 * bstride, bstride, m,
               n - n1);
  } else {

    m1 = m / 2;

    if (m - m1 >= 8 && m1 % 8 != 0)
      m1 = m1 + (8 - m1 % 8);

    if (!CAp::Assert(m - m1 > 0))
      return;

    FFtIRLTRec(a, astart, astride, b, bstart, bstride, m1, n);

    FFtIRLTRec(a, astart + m1 * astride, astride, b, bstart + m1, bstride,
               m - m1, n);
  }
}

static void CFtBase::FtBaseFindSmoothRec(const int n, const int seed,
                                         const int leastfactor, int &best) {

  if (!CAp::Assert(m_ftbasemaxsmoothfactor <= 5,
                   __FUNCTION__ + ": internal error!"))
    return;

  if (seed >= n) {
    best = MathMin(best, seed);
    return;
  }

  if (leastfactor <= 2) {

    FtBaseFindSmoothRec(n, seed * 2, 2, best);
  }

  if (leastfactor <= 3) {

    FtBaseFindSmoothRec(n, seed * 3, 3, best);
  }

  if (leastfactor <= 5) {

    FtBaseFindSmoothRec(n, seed * 5, 5, best);
  }
}

static void CFtBase::FFtArrayResize(int &a[], int &asize, const int newasize) {

  int tmp[];
  int i = 0;

  ArrayResizeAL(tmp, asize);
  for (i = 0; i <= asize - 1; i++)
    tmp[i] = a[i];

  ArrayResizeAL(a, newasize);
  for (i = 0; i <= asize - 1; i++)
    a[i] = tmp[i];

  asize = newasize;
}

static void CFtBase::ReFFHt(double &a[], const int n, const int offs) {

  double buf[];

  int i = 0;
  int j = 0;
  double v = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  ArrayResizeAL(buf, n);

  for (i = 0; i <= n - 1; i++) {
    v = 0;
    for (j = 0; j <= n - 1; j++)
      v = v + a[offs + j] * (MathCos(2 * M_PI * i * j / n) +
                             MathSin(2 * M_PI * i * j / n));
    buf[i] = v;
  }

  for (i = 0; i <= n - 1; i++)
    a[offs + i] = buf[i];
}

class CNearUnitYUnit {
public:
  CNearUnitYUnit(void);
  ~CNearUnitYUnit(void);

  static double NULog1p(const double x);
  static double NUExp1m(const double x);
  static double NUCos1m(const double x);
};

CNearUnitYUnit::CNearUnitYUnit(void) {}

CNearUnitYUnit::~CNearUnitYUnit(void) {}

static double CNearUnitYUnit::NULog1p(const double x) {

  double z = 1.0 + x;
  double lp = 0;
  double lq = 0;

  if (z < 0.70710678118654752440 || z > 1.41421356237309504880)
    return (MathLog(z));

  z = x * x;
  lp = 4.5270000862445199635215E-5;
  lp = lp * x + 4.9854102823193375972212E-1;
  lp = lp * x + 6.5787325942061044846969E0;
  lp = lp * x + 2.9911919328553073277375E1;
  lp = lp * x + 6.0949667980987787057556E1;
  lp = lp * x + 5.7112963590585538103336E1;
  lp = lp * x + 2.0039553499201281259648E1;
  lq = 1.0000000000000000000000E0;
  lq = lq * x + 1.5062909083469192043167E1;
  lq = lq * x + 8.3047565967967209469434E1;
  lq = lq * x + 2.2176239823732856465394E2;
  lq = lq * x + 3.0909872225312059774938E2;
  lq = lq * x + 2.1642788614495947685003E2;
  lq = lq * x + 6.0118660497603843919306E1;
  z = -(0.5 * z) + x * (z * lp / lq);

  return (x + z);
}

static double CNearUnitYUnit::NUExp1m(const double x) {

  double r;
  double xx;
  double ep;
  double eq;

  if (x < -0.5 || x > 0.5)
    return (MathExp(x) - 1.0);

  xx = x * x;
  ep = 1.2617719307481059087798E-4;
  ep = ep * xx + 3.0299440770744196129956E-2;
  ep = ep * xx + 9.9999999999999999991025E-1;
  eq = 3.0019850513866445504159E-6;
  eq = eq * xx + 2.5244834034968410419224E-3;
  eq = eq * xx + 2.2726554820815502876593E-1;
  eq = eq * xx + 2.0000000000000000000897E0;
  r = x * ep;
  r = r / (eq - r);

  return (r + r);
}

static double CNearUnitYUnit::NUCos1m(const double x) {

  double xx;
  double c;

  if (x < -0.25 * M_PI || x > 0.25 * M_PI)
    return (MathCos(x) - 1);

  xx = x * x;
  c = 4.7377507964246204691685E-14;
  c = c * xx - 1.1470284843425359765671E-11;
  c = c * xx + 2.0876754287081521758361E-9;
  c = c * xx - 2.7557319214999787979814E-7;
  c = c * xx + 2.4801587301570552304991E-5;
  c = c * xx - 1.3888888888888872993737E-3;
  c = c * xx + 4.1666666666666666609054E-2;

  return (-(0.5 * xx) + xx * xx * c);
}

#endif
