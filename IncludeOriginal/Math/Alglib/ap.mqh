#ifndef AP_H
#define AP_H

#include "bitconvert.mqh"
#include "complex.mqh"
#include "matrix.mqh"
#include <Object.mqh>

struct RCommState {
public:
  int stage;
  int ia[];
  bool ba[];
  double ra[];
  al_complex ca[];

  RCommState(void) {
    stage = -1;
  }
  ~RCommState(void){};
  void Copy(RCommState &obj);
};

void RCommState::Copy(RCommState &obj) {

  stage = obj.stage;

  ArrayCopy(ia, obj.ia);
  ArrayCopy(ba, obj.ba);
  ArrayCopy(ra, obj.ra);
  ArrayCopy(ca, obj.ca);
}

class CAp {
public:
  static bool exception_happened;

  CAp(void);
  ~CAp(void);

  static int Len(const int &a[]);
  static int Len(const bool &a[]);
  static int Len(const double &a[]);
  static int Len(const al_complex &a[]);

  static int Rows(const CMatrixInt &a);
  static int Rows(const CMatrixDouble &a);
  static int Rows(const CMatrixComplex &a);

  static int Cols(const CMatrixInt &a);
  static int Cols(const CMatrixDouble &a);
  static int Cols(const CMatrixComplex &a);

  static void Swap(int &a, int &b);
  static void Swap(double &a, double &b);
  static void Swap(al_complex &a, al_complex &b);
  static void Swap(bool &a[], bool &b[]);
  static void Swap(int &a[], int &b[]);
  static void Swap(double &a[], double &b[]);
  static void Swap(al_complex &a[], al_complex &b[]);
  static void Swap(CMatrixInt &a, CMatrixInt &b);
  static void Swap(CMatrixDouble &a, CMatrixDouble &b);
  static void Swap(CMatrixComplex &a, CMatrixComplex &b);

  static bool Assert(const bool cond);
  static bool Assert(const bool cond, const string s);

  static int ThresHoldToDPS(const double threshold);

  static string StringJoin(const string sep, const string &a[]);

  static string Format(const al_complex &a, const int dps);
  static string Format(const bool &a[]);
  static string Format(const int &a[]);
  static string Format(const double &a[], const int dps);
  static string Format(const al_complex &a[], const int dps);
  static string FormatB(const CMatrixInt &a);
  static string Format(const CMatrixInt &a);
  static string Format(const CMatrixDouble &a, const int dps);
  static string Format(const CMatrixComplex &a, const int dps);

  static bool IsSymmetric(const CMatrixDouble &a);
  static bool IsHermitian(const CMatrixComplex &a);
  static bool ForceSymmetric(CMatrixDouble &a);
  static bool ForceHermitian(CMatrixComplex &a);
};

bool CAp::exception_happened = false;

CAp::CAp(void) {
}

CAp::~CAp(void) {
}

static int CAp::Len(const int &a[]) {
  return (ArraySize(a));
}

static int CAp::Len(const bool &a[]) {
  return (ArraySize(a));
}

static int CAp::Len(const double &a[]) {
  return (ArraySize(a));
}

static int CAp::Len(const al_complex &a[]) {
  return (ArraySize(a));
}

static int CAp::Rows(const CMatrixInt &a) {
  return (a.Size());
}

static int CAp::Rows(const CMatrixDouble &a) {
  return (a.Size());
}

static int CAp::Rows(const CMatrixComplex &a) {
  return (a.Size());
}

static int CAp::Cols(const CMatrixInt &a) {

  if (a.Size() == 0)
    return (0);

  return (a[0].Size());
}

static int CAp::Cols(const CMatrixDouble &a) {

  if (a.Size() == 0)
    return (0);

  return (a[0].Size());
}

static int CAp::Cols(const CMatrixComplex &a) {

  if (a.Size() == 0)
    return (0);

  return (a[0].Size());
}

static void CAp::Swap(int &a, int &b) {
  int t = a;
  a = b;
  b = t;
}

static void CAp::Swap(double &a, double &b) {
  double t = a;
  a = b;
  b = t;
}

static void CAp::Swap(al_complex &a, al_complex &b) {
  al_complex t(a.re, a.im);
  a = b;
  b = t;
}

static void CAp::Swap(bool &a[], bool &b[]) {

  int na = ArraySize(a);
  int nb = ArraySize(b);

  bool t[];
  ArrayResizeAL(t, na);

  ArrayCopy(t, a);
  ArrayResizeAL(a, nb);
  ArrayCopy(a, b);
  ArrayResizeAL(b, na);
  ArrayCopy(b, t);
}

static void CAp::Swap(int &a[], int &b[]) {

  int na = ArraySize(a);
  int nb = ArraySize(b);

  int t[];
  ArrayResizeAL(t, na);

  ArrayCopy(t, a);
  ArrayResizeAL(a, nb);
  ArrayCopy(a, b);
  ArrayResizeAL(b, na);
  ArrayCopy(b, t);
}

static void CAp::Swap(double &a[], double &b[]) {

  int na = ArraySize(a);
  int nb = ArraySize(b);

  double t[];
  ArrayResizeAL(t, na);

  ArrayCopy(t, a);
  ArrayResizeAL(a, nb);
  ArrayCopy(a, b);
  ArrayResizeAL(b, na);
  ArrayCopy(b, t);
}

static void CAp::Swap(al_complex &a[], al_complex &b[]) {

  int na = ArraySize(a);
  int nb = ArraySize(b);

  al_complex t[];
  ArrayResizeAL(t, na);

  ArrayCopy(t, a);
  ArrayResizeAL(a, nb);
  ArrayCopy(a, b);
  ArrayResizeAL(b, na);
  ArrayCopy(b, t);
}

static void CAp::Swap(CMatrixInt &a, CMatrixInt &b) {

  CMatrixInt t;

  t = a;
  a = b;
  b = t;
}

static void CAp::Swap(CMatrixDouble &a, CMatrixDouble &b) {

  CMatrixDouble t;

  t = a;
  a = b;
  b = t;
}

static void CAp::Swap(CMatrixComplex &a, CMatrixComplex &b) {

  CMatrixComplex t;

  t = a;
  a = b;
  b = t;
}

static bool CAp::Assert(const bool cond) {
  return (Assert(cond, "ALGLIB: assertion failed"));
}

static bool CAp::Assert(const bool cond, const string s) {

  if (cond == 0) {
    Print(__FUNCTION__ + " " + s);
    exception_happened = true;
    return (false);
  }

  return (true);
}

static int CAp::ThresHoldToDPS(const double threshold) {

  int res = 0;
  double t = 1.0;
  for (res = 0; t / 10 > threshold * (1 + 1E-10); res++)
    t /= 10;

  return (res);
}

static string CAp::StringJoin(const string sep, const string &a[]) {
  int size = ArraySize(a);

  if (size == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }

  string res = "";
  for (int i = 0; i < size; i++) {
    StringAdd(res, a[i]);
    if (i != size - 1)
      StringAdd(res, sep);
  }

  return (res);
}

static string CAp::Format(const al_complex &a, const int dps) {

  string fmt;
  if (dps >= 0)
    fmt = "f";
  else
    fmt = "e";

  string sign;
  if (a.im >= 0)
    sign = "+";
  else
    sign = "-";

  int d = (int)MathAbs(dps);
  string fmtx = StringFormat(".%d" + fmt, d);
  string fmty = StringFormat(".%d" + fmt, d);

  string res = StringFormat("%" + fmtx, a.re) + sign +
               StringFormat("%" + fmty, MathAbs(a.im)) + "i";
  StringReplace(res, ",", ".");

  return (res);
}

static string CAp::Format(const bool &a[]) {
  int size = ArraySize(a);

  if (size == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }

  string result[];
  ArrayResizeAL(result, size);
  for (int i = 0; i < size; i++) {
    if (a[i] == 0)
      result[i] = "true";
    else
      result[i] = "false";
  }

  return ("{" + StringJoin(",", result) + "}");
}

static string CAp::Format(const int &a[]) {
  int size = ArraySize(a);

  if (size == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }

  string result[];
  ArrayResizeAL(result, size);
  for (int i = 0; i < size; i++)
    result[i] = IntegerToString(a[i]);

  return ("{" + StringJoin(",", result) + "}");
}

static string CAp::Format(const double &a[], const int dps) {
  int size = ArraySize(a);

  if (size == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }
  string result[];
  ArrayResizeAL(result, size);

  string sfmt;
  if (dps >= 0)
    sfmt = "f";
  else
    sfmt = "e";

  int d = (int)MathAbs(dps);
  string fmt = StringFormat(".%d" + sfmt, d);
  for (int i = 0; i < size; i++) {
    result[i] = StringFormat("%" + fmt, a[i]);
    StringReplace(result[i], ",", ".");
  }

  return ("{" + StringJoin(",", result) + "}");
}

static string CAp::Format(const al_complex &a[], const int dps) {
  int size = ArraySize(a);

  if (size == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }
  string result[];
  ArrayResizeAL(result, size);

  string fmt;
  if (dps >= 0)
    fmt = "f";
  else
    fmt = "e";

  int d = (int)MathAbs(dps);
  string fmtx = StringFormat(".%d" + fmt, d);
  string fmty = StringFormat(".%d" + fmt, d);
  string sign;
  for (int i = 0; i < size; i++) {

    if (a[i].im >= 0)
      sign = "+";
    else
      sign = "-";

    result[i] = StringFormat("%" + fmtx, a[i].re) + sign +
                StringFormat("%" + fmty, MathAbs(a[i].im)) + "i";
    StringReplace(result[i], ",", ".");
  }

  return ("{" + StringJoin(",", result) + "}");
}

static string CAp::FormatB(const CMatrixInt &a) {
  int m = a.Size();

  if (m == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }
  int n = a[0].Size();

  if (n == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }

  bool line[];
  string result[];
  ArrayResizeAL(line, n);
  ArrayResizeAL(result, m);

  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++)
      line[j] = (bool)(a[i][j]);
    result[i] = Format(line);
  }

  return ("{" + StringJoin(",", result) + "}");
}

static string CAp::Format(const CMatrixInt &a) {
  int m = a.Size();

  if (m == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }
  int n = a[0].Size();

  if (n == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }

  int line[];
  string result[];
  ArrayResizeAL(line, n);
  ArrayResizeAL(result, m);

  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++)
      line[j] = a[i][j];
    result[i] = Format(line);
  }

  return ("{" + StringJoin(",", result) + "}");
}

static string CAp::Format(const CMatrixDouble &a, const int dps) {
  int m = a.Size();

  if (m == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }
  int n = a[0].Size();

  if (n == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }

  double line[];
  string result[];
  ArrayResizeAL(line, n);
  ArrayResizeAL(result, m);

  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++)
      line[j] = a[i][j];
    result[i] = Format(line, dps);
  }

  return ("{" + StringJoin(",", result) + "}");
}

static string CAp::Format(const CMatrixComplex &a, const int dps) {
  int m = a.Size();

  if (m == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }
  int n = a[0].Size();

  if (n == 0) {
    Print(__FUNCTION__ + ": array size error");
    return (NULL);
  }

  al_complex line[];
  string result[];
  ArrayResizeAL(line, n);
  ArrayResizeAL(result, m);

  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++)
      line[j] = a[i][j];
    result[i] = Format(line, dps);
  }

  return ("{" + StringJoin(",", result) + "}");
}

static bool CAp::IsSymmetric(const CMatrixDouble &a) {
  int n = a.Size();

  if (n != a[0].Size())
    return (false);

  if (n == 0)
    return (true);

  double v1, v2;
  double mx = 0.0;
  double err = 0.0;

  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      v1 = a[i][j];
      v2 = a[j][i];

      if (!CMath::IsFinite(v1))
        return (false);
      if (!CMath::IsFinite(v2))
        return (false);

      err = MathMax(err, MathAbs(v1 - v2));
      mx = MathMax(mx, MathAbs(v1));
      mx = MathMax(mx, MathAbs(v2));
    }
    v1 = a[i][i];

    if (!CMath::IsFinite(v1))
      return (false);
    mx = MathMax(mx, MathAbs(v1));
  }

  if (mx == 0)
    return (true);

  if (err / mx <= 1.0E-14)
    return (true);

  return (false);
}

static bool CAp::IsHermitian(const CMatrixComplex &a) {
  int n = a.Size();

  if (n != a[0].Size())
    return (false);

  if (n == 0)
    return (true);

  double mx = 0;
  double err = 0;
  al_complex v1, v2, vt;

  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      v1 = a[i][j];
      v2 = a[j][i];

      if (!CMath::IsFinite(v1.re))
        return (false);
      if (!CMath::IsFinite(v1.im))
        return (false);
      if (!CMath::IsFinite(v2.re))
        return (false);
      if (!CMath::IsFinite(v2.im))
        return (false);

      vt.re = v1.re - v2.re;
      vt.im = v1.im + v2.im;
      err = MathMax(err, CMath::AbsComplex(vt));
      mx = MathMax(mx, CMath::AbsComplex(v1));
      mx = MathMax(mx, CMath::AbsComplex(v2));
    }
    v1 = a[i][i];

    if (!CMath::IsFinite(v1.re))
      return (false);
    if (!CMath::IsFinite(v1.im))
      return (false);

    err = MathMax(err, MathAbs(v1.im));
    mx = MathMax(mx, CMath::AbsComplex(v1));
  }

  if (mx == 0)
    return (true);

  if (err / mx <= 1.0E-14)
    return (true);

  return (false);
}

static bool CAp::ForceSymmetric(CMatrixDouble &a) {
  int n = a.Size();

  if (n != a[0].Size())
    return (false);

  if (n == 0)
    return (true);

  for (int i = 0; i < n; i++)
    for (int j = i + 1; j < n; j++)
      a[i].Set(j, a[j][i]);

  return (true);
}

static bool CAp::ForceHermitian(CMatrixComplex &a) {
  int n = a.Size();

  if (n != a[0].Size())
    return (false);

  if (n == 0)
    return (true);

  al_complex c;
  for (int i = 0; i < n; i++)
    for (int j = i + 1; j < n; j++) {
      c = a[j][i];
      c.im = -c.im;
      a[i].Set(j, c);
    }

  return (true);
}

class CHighQualityRandState {
public:
  int m_s1;
  int m_s2;
  double m_v;
  int m_magicv;

  CHighQualityRandState(void);
  ~CHighQualityRandState(void);
};

CHighQualityRandState::CHighQualityRandState(void) {
}

CHighQualityRandState::~CHighQualityRandState(void) {
}

class CHighQualityRandStateShell {
private:
  CHighQualityRandState m_innerobj;

public:
  CHighQualityRandStateShell(void);
  CHighQualityRandStateShell(CHighQualityRandState &obj);
  ~CHighQualityRandStateShell(void);

  CHighQualityRandState *GetInnerObj(void);
};

CHighQualityRandStateShell::CHighQualityRandStateShell(void) {
}

CHighQualityRandStateShell::CHighQualityRandStateShell(
    CHighQualityRandState &obj) {

  m_innerobj.m_s1 = obj.m_s1;
  m_innerobj.m_s2 = obj.m_s2;
  m_innerobj.m_v = obj.m_v;
  m_innerobj.m_magicv = obj.m_magicv;
}

CHighQualityRandStateShell::~CHighQualityRandStateShell(void) {
}

CHighQualityRandState *CHighQualityRandStateShell::GetInnerObj(void) {
  return (GetPointer(m_innerobj));
}

class CHighQualityRand {
private:
  static int HQRndIntegerBase(CHighQualityRandState &state);

public:
  static const int m_HQRndMax;
  static const int m_HQRndM1;
  static const int m_HQRndM2;
  static const int m_HQRndMagic;

  CHighQualityRand(void);
  ~CHighQualityRand(void);

  static void HQRndRandomize(CHighQualityRandState &state);
  static void HQRndSeed(const int s1, const int s2,
                        CHighQualityRandState &state);
  static double HQRndUniformR(CHighQualityRandState &state);
  static int HQRndUniformI(CHighQualityRandState &state, const int n);
  static double HQRndNormal(CHighQualityRandState &state);
  static void HQRndUnit2(CHighQualityRandState &state, double &x, double &y);
  static void HQRndNormal2(CHighQualityRandState &state, double &x1,
                           double &x2);
  static double HQRndExponential(CHighQualityRandState &state,
                                 const double lambdav);
};

const int CHighQualityRand::m_HQRndMax = 2147483563;
const int CHighQualityRand::m_HQRndM1 = 2147483563;
const int CHighQualityRand::m_HQRndM2 = 2147483399;
const int CHighQualityRand::m_HQRndMagic = 1634357784;

CHighQualityRand::CHighQualityRand(void) {
}

CHighQualityRand::~CHighQualityRand(void) {
}

static void CHighQualityRand::HQRndRandomize(CHighQualityRandState &state) {

  HQRndSeed(CMath::RandomInteger(m_HQRndM1), CMath::RandomInteger(m_HQRndM2),
            state);
}

static void CHighQualityRand::HQRndSeed(const int s1, const int s2,
                                        CHighQualityRandState &state) {

  state.m_s1 = s1 % (m_HQRndM1 - 1) + 1;
  state.m_s2 = s2 % (m_HQRndM2 - 1) + 1;
  state.m_v = 1.0 / (double)m_HQRndMax;
  state.m_magicv = m_HQRndMagic;
}

static double CHighQualityRand::HQRndUniformR(CHighQualityRandState &state) {

  return (state.m_v * (HQRndIntegerBase(state) - 1));
}

static int CHighQualityRand::HQRndUniformI(CHighQualityRandState &state,
                                           const int n) {

  int result = 0;
  int mx = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return (-1);

  if (!CAp::Assert(n < m_HQRndMax - 1, __FUNCTION__ + ": N>=RNDBaseMax-1!"))
    return (-1);

  mx = m_HQRndMax - 1 - (m_HQRndMax - 1) % n;
  do
    result = HQRndIntegerBase(state) - 1;
  while (result >= mx);

  result = result % n;

  return (result);
}

static double CHighQualityRand::HQRndNormal(CHighQualityRandState &state) {

  double v1 = 0;
  double v2 = 0;

  HQRndNormal2(state, v1, v2);

  return (v1);
}

static void CHighQualityRand::HQRndUnit2(CHighQualityRandState &state,
                                         double &x, double &y) {

  double v = 0;
  double mx = 0;
  double mn = 0;

  x = 0;
  y = 0;

  do
    HQRndNormal2(state, x, y);
  while (!(x != 0.0 || y != 0.0));

  mx = MathMax(MathAbs(x), MathAbs(y));
  mn = MathMin(MathAbs(x), MathAbs(y));
  v = mx * MathSqrt(1 + CMath::Sqr(mn / mx));

  x = x / v;
  y = y / v;
}

static void CHighQualityRand::HQRndNormal2(CHighQualityRandState &state,
                                           double &x1, double &x2) {

  double u = 0;
  double v = 0;
  double s = 0;

  x1 = 0;
  x2 = 0;

  while (true) {
    u = 2 * HQRndUniformR(state) - 1;
    v = 2 * HQRndUniformR(state) - 1;
    s = CMath::Sqr(u) + CMath::Sqr(v);

    if (s > 0.0 && s < 1.0) {

      s = MathSqrt(-(2 * MathLog(s))) / MathSqrt(s);
      x1 = u * s;
      x2 = v * s;

      return;
    }
  }
}

static double CHighQualityRand::HQRndExponential(CHighQualityRandState &state,
                                                 const double lambdav) {

  if (!CAp::Assert(lambdav > 0.0, __FUNCTION__ + ": LambdaV<=0!"))
    return (EMPTY_VALUE);

  return (-(MathLog(HQRndUniformR(state)) / lambdav));
}

static int CHighQualityRand::HQRndIntegerBase(CHighQualityRandState &state) {

  int result = 0;
  int k = 0;

  if (!CAp::Assert(state.m_magicv == m_HQRndMagic,
                   __FUNCTION__ + ": State is not correctly initialized!"))
    return (-1);

  k = state.m_s1 / 53668;
  state.m_s1 = 40014 * (state.m_s1 - k * 53668) - k * 12211;

  if (state.m_s1 < 0)
    state.m_s1 = state.m_s1 + 2147483563;

  k = state.m_s2 / 52774;
  state.m_s2 = 40692 * (state.m_s2 - k * 52774) - k * 3791;

  if (state.m_s2 < 0)
    state.m_s2 = state.m_s2 + 2147483399;

  result = state.m_s1 - state.m_s2;

  if (result < 1)
    result = result + 2147483562;

  return (result);
}

class CMath {
public:
  static bool m_first_call;
  static double m_last;
  static CHighQualityRandState m_state;

  static const double m_machineepsilon;
  static const double m_maxrealnumber;
  static const double m_minrealnumber;

  CMath(void);
  ~CMath(void);

  static bool IsFinite(const double d);
  static double RandomReal(void);
  static int RandomInteger(const int n);
  static double Sqr(const double x) {
    return (x * x);
  }
  static double AbsComplex(const al_complex &z);
  static double AbsComplex(const double r);
  static al_complex Conj(const al_complex &z);
  static al_complex Csqr(const al_complex &z);
};

const double CMath::m_machineepsilon = 5E-16;
const double CMath::m_maxrealnumber = 1E300;
const double CMath::m_minrealnumber = 1E-300;
bool CMath::m_first_call = true;
double CMath::m_last = 0.0;
CHighQualityRandState CMath::m_state;

CMath::CMath(void) {
}

CMath::~CMath(void) {
}

static bool CMath::IsFinite(const double d) {

  return (MathIsValidNumber(d));
}

static double CMath::RandomReal(void) {

  double result;

  if (m_first_call) {
    CHighQualityRand::HQRndSeed(1 + MathRand(), 1 + MathRand(), m_state);
    m_first_call = false;
  }

  result = CHighQualityRand::HQRndUniformR(m_state);

  if (result == m_last) {
    m_first_call = true;
    return (RandomReal());
  }

  m_last = result;

  return (CHighQualityRand::HQRndUniformR(m_state));
}

static int CMath::RandomInteger(const int n) {

  if (m_first_call) {
    CHighQualityRand::HQRndSeed(1 + MathRand(), 1 + MathRand(), m_state);
    m_first_call = false;
  }

  if (n >= CHighQualityRand::m_HQRndM1 - 1)
    return (CHighQualityRand::HQRndUniformI(m_state,
                                            CHighQualityRand::m_HQRndM1 - 2));
  else
    return (CHighQualityRand::HQRndUniformI(m_state, n));
}

static double CMath::AbsComplex(const al_complex &z) {

  double w = 0.0;
  double v = 0.0;
  double xabs = MathAbs(z.re);
  double yabs = MathAbs(z.im);

  if (xabs > yabs)
    w = xabs;
  else
    w = yabs;

  if (xabs < yabs)
    v = xabs;
  else
    v = yabs;

  if (v == 0)
    return (w);

  double t = v / w;

  return (w * MathSqrt(1 + t * t));
}

static double CMath::AbsComplex(const double r) {

  al_complex z = r;
  double w = 0.0;
  double v = 0.0;
  double xabs = MathAbs(z.re);
  double yabs = MathAbs(z.im);

  if (xabs > yabs)
    w = xabs;
  else
    w = yabs;

  if (xabs < yabs)
    v = xabs;
  else
    v = yabs;

  if (v == 0)
    return (w);

  double t = v / w;

  return (w * MathSqrt(1 + t * t));
}

static al_complex CMath::Conj(const al_complex &z) {
  al_complex res;
  res.re = z.re;
  res.im = -z.im;

  return (res);
}

static al_complex CMath::Csqr(const al_complex &z) {
  al_complex res;
  res.re = z.re * z.re - z.im * z.im;
  res.im = 2 * z.re * z.im;

  return (res);
}

char _sixbits2char_tbl[] = {
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C',
    'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c',
    'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
    'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '-', '_'};

int _char2sixbits_tbl[128] = {
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, 0,  1,  2,  3,  4,  5,  6,  7,  8,
    9,  -1, -1, -1, -1, -1, -1, -1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
    21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, -1, -1, -1, -1,
    63, -1, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52,
    53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1};

class CSerializer {

  enum SMODE { DEFAULT, ALLOC, TO_STRING, FROM_STRING };

private:
  static const int m_ser_entries_per_row;
  static const int m_ser_entry_length;

  SMODE m_mode;
  int m_entries_needed;
  int m_entries_saved;
  int m_bytes_asked;
  int m_bytes_written;
  int m_bytes_read;
  char m_out_str[];
  char m_in_str[];

  int Get_Alloc_Size(void);
  static char SixBits2Char(const int v);
  static int Char2SixBits(const char c);
  static void ThreeBytes2FourSixBits(uchar &src[], const int src_offs,
                                     int &dst[], const int dst_offs);
  static void FourSixBits2ThreeBytes(int &src[], const int src_offs,
                                     uchar &dst[], const int dst_offs);
  static void Bool2Str(const bool v, char &buf[], int &offs);
  static bool Str2Bool(char &buf[], int &offs);
  static void Int2Str(const int v, char &buf[], int &offs);
  static int Str2Int(char &buf[], int &offs);
  static void Double2Str(const double v, char &buf[], int &offs);
  static double Str2Double(char &buf[], int &offs);

public:
  CSerializer(void);
  ~CSerializer(void);

  void Alloc_Start(void);
  void Alloc_Entry(void);
  void SStart_Str(void);
  void UStart_Str(const string s);
  void Reset(void);
  void Stop(void);

  void Serialize_Bool(const bool v);
  void Serialize_Int(const int v);
  void Serialize_Double(const double v);

  bool Unserialize_Bool(void);
  int Unserialize_Int(void);
  double Unserialize_Double(void);

  string Get_String(void);
};

const int CSerializer::m_ser_entries_per_row = 5;
const int CSerializer::m_ser_entry_length = 11;

CSerializer::CSerializer(void)
    : m_mode(DEFAULT), m_entries_needed(0), m_bytes_asked(0) {
}

CSerializer::~CSerializer(void) {
}

void CSerializer::Alloc_Start(void) {

  m_entries_needed = 0;
  m_bytes_asked = 0;
  m_mode = ALLOC;
}

void CSerializer::Alloc_Entry(void) {

  if (m_mode != ALLOC) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return;
  }
  m_entries_needed++;
}

void CSerializer::SStart_Str(void) {

  int allocsize = Get_Alloc_Size();

  if (m_mode != ALLOC) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return;
  }
  m_mode = TO_STRING;

  ArrayResizeAL(m_out_str, allocsize);
  m_entries_saved = 0;
  m_bytes_written = 0;
}

void CSerializer::UStart_Str(const string s) {

  if (m_mode != DEFAULT) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return;
  }
  m_mode = FROM_STRING;
  StringToCharArray(s, m_in_str);
  m_bytes_read = 0;
}

void CSerializer::Reset(void) {
  m_mode = DEFAULT;
  m_entries_needed = 0;
  m_bytes_asked = 0;
}

void CSerializer::Serialize_Bool(const bool v) {

  if (m_mode != TO_STRING) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return;
  }

  Bool2Str(v, m_out_str, m_bytes_written);
  m_entries_saved++;

  if (m_entries_saved % m_ser_entries_per_row != 0) {
    m_out_str[m_bytes_written] = ' ';
    m_bytes_written++;
  } else {
    m_out_str[m_bytes_written + 0] = ' ';
    m_out_str[m_bytes_written + 1] ='
'; m_bytes_written += 2;
  }
}

void CSerializer::Serialize_Int(const int v) {

  if (m_mode != TO_STRING) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return;
  }

  Int2Str(v, m_out_str, m_bytes_written);
  m_entries_saved++;

  if (m_entries_saved % m_ser_entries_per_row != 0) {
    m_out_str[m_bytes_written] = ' ';
    m_bytes_written++;
  } else {
    m_out_str[m_bytes_written + 0] = ' ';
    m_out_str[m_bytes_written + 1] ='
'; m_bytes_written += 2;
  }
}

void CSerializer::Serialize_Double(const double v) {

  if (m_mode != TO_STRING) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return;
  }

  Double2Str(v, m_out_str, m_bytes_written);
  m_entries_saved++;

  if (m_entries_saved % m_ser_entries_per_row != 0) {
    m_out_str[m_bytes_written] = ' ';
    m_bytes_written++;
  } else {
    m_out_str[m_bytes_written + 0] = ' ';
    m_out_str[m_bytes_written + 1] ='
'; m_bytes_written += 2;
  }
}

bool CSerializer::Unserialize_Bool(void) {

  if (m_mode != FROM_STRING) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return (false);
  }

  return (Str2Bool(m_in_str, m_bytes_read));
}

int CSerializer::Unserialize_Int(void) {

  if (m_mode != FROM_STRING) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return (-1);
  }

  return (Str2Int(m_in_str, m_bytes_read));
}

double CSerializer::Unserialize_Double(void) {

  if (m_mode != FROM_STRING) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return (EMPTY_VALUE);
  }

  return (Str2Double(m_in_str, m_bytes_read));
}

void CSerializer::Stop(void) {
}

string CSerializer::Get_String(void) {

  return (GetSelectionString(m_out_str, 0, m_bytes_written));
}

int CSerializer::Get_Alloc_Size(void) {

  int rows;
  int lastrowsize;
  int result;

  if (m_mode != ALLOC) {
    Print(__FUNCTION__ + ": internal error during (un)serialization");

    return (-1);
  }

  if (m_entries_needed == 0) {
    m_bytes_asked = 1;

    return (m_bytes_asked);
  }

  rows = m_entries_needed / m_ser_entries_per_row;
  lastrowsize = m_ser_entries_per_row;

  if (m_entries_needed % m_ser_entries_per_row != 0) {
    lastrowsize = m_entries_needed % m_ser_entries_per_row;
    rows++;
  }

  result =
      ((rows - 1) * m_ser_entries_per_row + lastrowsize) * m_ser_entry_length;
  result += (rows - 1) * (m_ser_entries_per_row - 1) + (lastrowsize - 1);
  result += rows * 2;

  m_bytes_asked = result;

  return (result);
}

static char CSerializer::SixBits2Char(const int v) {

  if (v < 0 || v > 63)
    return ('?');

  return (_sixbits2char_tbl[v]);
}

static int CSerializer::Char2SixBits(const char c) {

  if (c >= 0 && c < 127)
    return (_char2sixbits_tbl[c]);

  return (-1);
}

static void CSerializer::ThreeBytes2FourSixBits(uchar &src[],
                                                const int src_offs, int &dst[],
                                                const int dst_offs) {

  dst[dst_offs + 0] = src[src_offs + 0] & 0x3F;
  dst[dst_offs + 1] =
      (src[src_offs + 0] >> 6) | ((src[src_offs + 1] & 0x0F) << 2);
  dst[dst_offs + 2] =
      (src[src_offs + 1] >> 4) | ((src[src_offs + 2] & 0x03) << 4);
  dst[dst_offs + 3] = src[src_offs + 2] >> 2;
}

static void CSerializer::FourSixBits2ThreeBytes(int &src[], const int src_offs,
                                                uchar &dst[],
                                                const int dst_offs) {

  dst[dst_offs + 0] =
      (uchar)(src[src_offs + 0] | ((src[src_offs + 1] & 0x03) << 6));
  dst[dst_offs + 1] =
      (uchar)((src[src_offs + 1] >> 2) | ((src[src_offs + 2] & 0x0F) << 4));
  dst[dst_offs + 2] =
      (uchar)((src[src_offs + 2] >> 4) | (src[src_offs + 3] << 2));
}

static void CSerializer::Bool2Str(const bool v, char &buf[], int &offs) {

  char c;
  int i;

  if (v)
    c = '1';
  else
    c = '0';

  for (i = 0; i < m_ser_entry_length; i++)
    buf[offs + i] = c;

  offs += m_ser_entry_length;
}

static bool CSerializer::Str2Bool(char &buf[], int &offs) {

  bool was0;
  bool was1;
  string emsg = ": unable to read boolean value from stream";

  was0 = false;
  was1 = false;

   while(buf[offs]==' ' || buf[offs]=='	' || buf[offs]=='
' || buf[offs]=='')
      offs++;

   while(buf[offs]!=' ' && buf[offs]!='	' && buf[offs]!='
' && buf[offs]!='' && buf[offs]!=0)
     {
    if (buf[offs] == '0') {
      was0 = true;
      offs++;
      continue;
    }

    if (buf[offs] == '1') {
      was1 = true;
      offs++;
      continue;
    }
    Print(__FUNCTION__ + " " + emsg);

    return (false);
     }

   if((!was0) && (!was1))
     {
    Print(__FUNCTION__ + " " + emsg);

    return (false);
     }

   if(was0 && was1)
     {
    Print(__FUNCTION__ + " " + emsg);

    return (false);
     }

   if(was1)
      return(true);

   return(false);
}

static void CSerializer::Int2Str(const int v, char &buf[], int &offs) {

  int i;
  uchar c;
  uchar _bytes[];

  BitConverter::GetBytes(v, _bytes);

  uchar bytes[];
  int sixbits[];

  ArrayResizeAL(bytes, 9);
  ArrayResizeAL(sixbits, 12);

  if (!BitConverter::IsLittleEndian())
    ArrayReverse(_bytes);

  if (v < 0)
    c = (uchar)0xFF;
  else
    c = (uchar)0x00;

  for (i = 0; i < sizeof(int); i++)
    bytes[i] = _bytes[i];

  for (i = sizeof(int); i < 8; i++)
    bytes[i] = c;
  bytes[8] = 0;

  ThreeBytes2FourSixBits(bytes, 0, sixbits, 0);
  ThreeBytes2FourSixBits(bytes, 3, sixbits, 4);
  ThreeBytes2FourSixBits(bytes, 6, sixbits, 8);

  for (i = 0; i < m_ser_entry_length; i++)
    buf[offs + i] = SixBits2Char(sixbits[i]);

  offs += m_ser_entry_length;
}

static int CSerializer::Str2Int(char &buf[], int &offs) {

  string emsg = ": unable to read integer value from stream";
  string emsg3264 = ": unable to read integer value from stream (value does "
                    "not fit into 32 bits)";
  int sixbitsread;
  int i;
  uchar c;

  int sixbits[];
  uchar bytes[];
  uchar _bytes[];

  ArrayResizeAL(sixbits, 12);
  ArrayResizeAL(bytes, 9);
  ArrayResizeAL(_bytes, sizeof(int));

  sixbitsread = 0;
   while(buf[offs]==' ' || buf[offs]=='	' || buf[offs]=='
' || buf[offs]=='')
      offs++;
   while(buf[offs]!=' ' && buf[offs]!='	' && buf[offs]!='
' && buf[offs]!='' && buf[offs]!=0)
     {
    int d;

    d = Char2SixBits(buf[offs]);

    if (d < 0 || sixbitsread >= m_ser_entry_length) {
      Print(__FUNCTION__ + " " + emsg);

      return (-1);
    }
    sixbits[sixbitsread] = d;
    sixbitsread++;
    offs++;
     }

   if(sixbitsread==0)
     {
    Print(__FUNCTION__ + " " + emsg);

    return (-1);
     }
   for(i=sixbitsread;i<12;i++)
      sixbits[i]=0;

   FourSixBits2ThreeBytes(sixbits,0,bytes,0);

   FourSixBits2ThreeBytes(sixbits,4,bytes,3);

   FourSixBits2ThreeBytes(sixbits,8,bytes,6);

   if((bytes[sizeof(int)-1]&0x80)!=0)
      c=(uchar)0xFF;
   else
      c=(uchar)0x00;
   for(i=sizeof(int);i<8;i++)
      
      if(bytes[i]!=c)
        {
    Print(__FUNCTION__ + " " + emsg3264);

    return (-1);
        }

   for(i=0;i<sizeof(int);i++)
      _bytes[i]=bytes[i];

   if(!BitConverter::IsLittleEndian())
      ArrayReverse(_bytes);

   return(BitConverter::ToInt32(_bytes));
}

static void CSerializer::Double2Str(const double v, char &buf[], int &offs) {

  int i;

  uchar bytes[];
  int sixbits[];

  ArrayResizeAL(sixbits, 12);
  ArrayResizeAL(bytes, 9);

  if (CInfOrNaN::IsNaN(v)) {
    buf[offs + 0] = '.';
    buf[offs + 1] = 'n';
    buf[offs + 2] = 'a';
    buf[offs + 3] = 'n';
    buf[offs + 4] = '_';
    buf[offs + 5] = '_';
    buf[offs + 6] = '_';
    buf[offs + 7] = '_';
    buf[offs + 8] = '_';
    buf[offs + 9] = '_';
    buf[offs + 10] = '_';
    offs += m_ser_entry_length;

    return;
  }

  if (CInfOrNaN::IsPositiveInfinity(v)) {
    buf[offs + 0] = '.';
    buf[offs + 1] = 'p';
    buf[offs + 2] = 'o';
    buf[offs + 3] = 's';
    buf[offs + 4] = 'i';
    buf[offs + 5] = 'n';
    buf[offs + 6] = 'f';
    buf[offs + 7] = '_';
    buf[offs + 8] = '_';
    buf[offs + 9] = '_';
    buf[offs + 10] = '_';
    offs += m_ser_entry_length;

    return;
  }

  if (CInfOrNaN::IsNegativeInfinity(v)) {
    buf[offs + 0] = '.';
    buf[offs + 1] = 'n';
    buf[offs + 2] = 'e';
    buf[offs + 3] = 'g';
    buf[offs + 4] = 'i';
    buf[offs + 5] = 'n';
    buf[offs + 6] = 'f';
    buf[offs + 7] = '_';
    buf[offs + 8] = '_';
    buf[offs + 9] = '_';
    buf[offs + 10] = '_';
    offs += m_ser_entry_length;

    return;
  }

  uchar _bytes[];
  BitConverter::GetBytes(v, _bytes);

  if (!BitConverter::IsLittleEndian())
    ArrayReverse(_bytes);

  for (i = 0; i < sizeof(double); i++)
    bytes[i] = _bytes[i];

  for (i = sizeof(double); i < 9; i++)
    bytes[i] = 0;

  ThreeBytes2FourSixBits(bytes, 0, sixbits, 0);

  ThreeBytes2FourSixBits(bytes, 3, sixbits, 4);

  ThreeBytes2FourSixBits(bytes, 6, sixbits, 8);

  for (i = 0; i < m_ser_entry_length; i++)
    buf[offs + i] = SixBits2Char(sixbits[i]);

  offs += m_ser_entry_length;
}

static double CSerializer::Str2Double(char &buf[], int &offs) {

  string emsg = "ALGLIB: unable to read double value from stream";
  int sixbitsread;
  int i;

  uchar bytes[];
  uchar _bytes[];
  int sixbits[];

  ArrayResizeAL(bytes, 9);
  ArrayResizeAL(sixbits, 12);
  ArrayResizeAL(_bytes, sizeof(double));

   while(buf[offs]==' ' || buf[offs]=='	' || buf[offs]=='
' || buf[offs]=='')
      offs++;

   if(buf[offs]=='.')
     {
    string s = GetSelectionString(buf, offs, m_ser_entry_length);

    if (s == ".nan_______") {
      offs += m_ser_entry_length;

      return (CInfOrNaN::NaN());
    }

    if (s == ".posinf____") {
      offs += m_ser_entry_length;

      return (CInfOrNaN::PositiveInfinity());
    }

    if (s == ".neginf____") {
      offs += m_ser_entry_length;

      return (CInfOrNaN::NegativeInfinity());
    }
    Print(__FUNCTION__ + "emsg");

    return (EMPTY_VALUE);
     }






   sixbitsread=0;
   while(buf[offs]!=' ' && buf[offs]!='	' && buf[offs]!='
' && buf[offs]!='' && buf[offs]!=0)
     {
    int d;

    d = Char2SixBits(buf[offs]);

    if (d < 0 || sixbitsread >= m_ser_entry_length) {
      Print(__FUNCTION__ + "emsg");

      return (EMPTY_VALUE);
    }
    sixbits[sixbitsread] = d;
    sixbitsread++;
    offs++;
     }

   if(sixbitsread!=m_ser_entry_length)
     {
    Print(__FUNCTION__ + "emsg");

    return (EMPTY_VALUE);
     }
   sixbits[m_ser_entry_length]=0;

   FourSixBits2ThreeBytes(sixbits,0,bytes,0);

   FourSixBits2ThreeBytes(sixbits,4,bytes,3);

   FourSixBits2ThreeBytes(sixbits,8,bytes,6);

   for(i=0;i<sizeof(double);i++)
      _bytes[i]=bytes[i];

   if(!BitConverter::IsLittleEndian())
      ArrayReverse(_bytes);

   return(BitConverter::ToDouble(_bytes));
}

#endif
