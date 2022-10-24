#ifndef SOLVERS_H
#define SOLVERS_H

#include "alglibinternal.mqh"
#include "ap.mqh"
#include "linalg.mqh"
#include "matrix.mqh"

class CDenseSolverReport {
public:
  double m_r1;
  double m_rinf;

  CDenseSolverReport(void);
  ~CDenseSolverReport(void);

  void Copy(CDenseSolverReport &obj);
};

CDenseSolverReport::CDenseSolverReport(void) {}

CDenseSolverReport::~CDenseSolverReport(void) {}

void CDenseSolverReport::Copy(CDenseSolverReport &obj) {

  m_r1 = obj.m_r1;
  m_rinf = obj.m_rinf;
}

class CDenseSolverReportShell {
private:
  CDenseSolverReport m_innerobj;

public:
  CDenseSolverReportShell(void);
  CDenseSolverReportShell(CDenseSolverReport &obj);
  ~CDenseSolverReportShell(void);

  double GetR1(void);
  void SetR1(const double d);
  double GetRInf(void);
  void SetRInf(const double d);
  CDenseSolverReport *GetInnerObj(void);
};

CDenseSolverReportShell::CDenseSolverReportShell(void) {}

CDenseSolverReportShell::CDenseSolverReportShell(CDenseSolverReport &obj) {

  m_innerobj.Copy(obj);
}

CDenseSolverReportShell::~CDenseSolverReportShell(void) {}

double CDenseSolverReportShell::GetR1(void) {

  return (m_innerobj.m_r1);
}

void CDenseSolverReportShell::SetR1(const double d) {

  m_innerobj.m_r1 = d;
}

double CDenseSolverReportShell::GetRInf(void) {

  return (m_innerobj.m_rinf);
}

void CDenseSolverReportShell::SetRInf(const double d) {

  m_innerobj.m_rinf = d;
}

CDenseSolverReport *CDenseSolverReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CDenseSolverLSReport {
public:
  double m_r2;
  CMatrixDouble m_cx;
  int m_n;
  int m_k;

  CDenseSolverLSReport(void);
  ~CDenseSolverLSReport(void);

  void Copy(CDenseSolverLSReport &obj);
};

CDenseSolverLSReport::CDenseSolverLSReport(void) {}

CDenseSolverLSReport::~CDenseSolverLSReport(void) {}

void CDenseSolverLSReport::Copy(CDenseSolverLSReport &obj) {

  m_r2 = obj.m_r2;
  m_n = obj.m_n;
  m_k = obj.m_k;

  m_cx = obj.m_cx;
}

class CDenseSolverLSReportShell {
private:
  CDenseSolverLSReport m_innerobj;

public:
  CDenseSolverLSReportShell(void);
  CDenseSolverLSReportShell(CDenseSolverLSReport &obj);
  ~CDenseSolverLSReportShell(void);

  double GetR2(void);
  void SetR2(const double d);
  int GetN(void);
  void SetN(const int i);
  int GetK(void);
  void SetK(const int i);
  CDenseSolverLSReport *GetInnerObj(void);
};

CDenseSolverLSReportShell::CDenseSolverLSReportShell(void) {}

CDenseSolverLSReportShell::CDenseSolverLSReportShell(
    CDenseSolverLSReport &obj) {

  m_innerobj.Copy(obj);
}

CDenseSolverLSReportShell::~CDenseSolverLSReportShell(void) {}

double CDenseSolverLSReportShell::GetR2(void) {

  return (m_innerobj.m_r2);
}

void CDenseSolverLSReportShell::SetR2(const double d) {

  m_innerobj.m_r2 = d;
}

int CDenseSolverLSReportShell::GetN(void) {

  return (m_innerobj.m_n);
}

void CDenseSolverLSReportShell::SetN(const int i) {

  m_innerobj.m_n = i;
}

int CDenseSolverLSReportShell::GetK(void) {

  return (m_innerobj.m_k);
}

void CDenseSolverLSReportShell::SetK(const int i) {

  m_innerobj.m_k = i;
}

CDenseSolverLSReport *CDenseSolverLSReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CDenseSolver {
private:
  static void RMatrixLUSolveInternal(CMatrixDouble &lua, int &p[],
                                     const double scalea, const int n,
                                     CMatrixDouble &a, const bool havea,
                                     CMatrixDouble &b, const int m, int &info,
                                     CDenseSolverReport &rep, CMatrixDouble &x);
  static void SPDMatrixCholeskySolveInternal(
      CMatrixDouble &cha, const double sqrtscalea, const int n,
      const bool isupper, CMatrixDouble &a, const bool havea, CMatrixDouble &b,
      const int m, int &info, CDenseSolverReport &rep, CMatrixDouble &x);
  static void CMatrixLUSolveInternal(CMatrixComplex &lua, int &p[],
                                     const double scalea, const int n,
                                     CMatrixComplex &a, const bool havea,
                                     CMatrixComplex &b, const int m, int &info,
                                     CDenseSolverReport &rep,
                                     CMatrixComplex &x);
  static void HPDMatrixCholeskySolveInternal(
      CMatrixComplex &cha, const double sqrtscalea, const int n,
      const bool isupper, CMatrixComplex &a, const bool havea,
      CMatrixComplex &b, const int m, int &info, CDenseSolverReport &rep,
      CMatrixComplex &x);
  static int CDenseSolverRFSMax(const int n, const double r1,
                                const double rinf);
  static int CDenseSolverRFSMaxV2(const int n, const double r2);
  static void RBasicLUSolve(CMatrixDouble &lua, int &p[], const double scalea,
                            const int n, double &xb[], double &tmp[]);
  static void SPDBasicCholeskySolve(CMatrixDouble &cha, const double sqrtscalea,
                                    const int n, const bool isupper,
                                    double &xb[], double &tmp[]);
  static void CBasicLUSolve(CMatrixComplex &lua, int &p[], const double scalea,
                            const int n, al_complex &xb[], al_complex &tmp[]);
  static void HPDBasicCholeskySolve(CMatrixComplex &cha,
                                    const double sqrtscalea, const int n,
                                    const bool isupper, al_complex &xb[],
                                    al_complex &tmp[]);

public:
  CDenseSolver(void);
  ~CDenseSolver(void);

  static void RMatrixSolve(CMatrixDouble &a, const int n, double &b[],
                           int &info, CDenseSolverReport &rep, double &x[]);
  static void RMatrixSolveM(CMatrixDouble &a, const int n, CMatrixDouble &b,
                            const int m, const bool rfs, int &info,
                            CDenseSolverReport &rep, CMatrixDouble &x);
  static void RMatrixLUSolve(CMatrixDouble &lua, int &p[], const int n,
                             double &b[], int &info, CDenseSolverReport &rep,
                             double &x[]);
  static void RMatrixLUSolveM(CMatrixDouble &lua, int &p[], const int n,
                              CMatrixDouble &b, const int m, int &info,
                              CDenseSolverReport &rep, CMatrixDouble &x);
  static void RMatrixMixedSolve(CMatrixDouble &a, CMatrixDouble &lua, int &p[],
                                const int n, double &b[], int &info,
                                CDenseSolverReport &rep, double &x[]);
  static void RMatrixMixedSolveM(CMatrixDouble &a, CMatrixDouble &lua, int &p[],
                                 const int n, CMatrixDouble &b, const int m,
                                 int &info, CDenseSolverReport &rep,
                                 CMatrixDouble &x);
  static void CMatrixSolveM(CMatrixComplex &a, const int n, CMatrixComplex &b,
                            const int m, const bool rfs, int &info,
                            CDenseSolverReport &rep, CMatrixComplex &x);
  static void CMatrixSolve(CMatrixComplex &a, const int n, al_complex &b[],
                           int &info, CDenseSolverReport &rep, al_complex &x[]);
  static void CMatrixLUSolveM(CMatrixComplex &lua, int &p[], const int n,
                              CMatrixComplex &b, const int m, int &info,
                              CDenseSolverReport &rep, CMatrixComplex &x);
  static void CMatrixLUSolve(CMatrixComplex &lua, int &p[], const int n,
                             al_complex &b[], int &info,
                             CDenseSolverReport &rep, al_complex &x[]);
  static void CMatrixMixedSolveM(CMatrixComplex &a, CMatrixComplex &lua,
                                 int &p[], const int n, CMatrixComplex &b,
                                 const int m, int &info,
                                 CDenseSolverReport &rep, CMatrixComplex &x);
  static void CMatrixMixedSolve(CMatrixComplex &a, CMatrixComplex &lua,
                                int &p[], const int n, al_complex &b[],
                                int &info, CDenseSolverReport &rep,
                                al_complex &x[]);
  static void SPDMatrixSolveM(CMatrixDouble &a, const int n, const bool isupper,
                              CMatrixDouble &b, const int m, int &info,
                              CDenseSolverReport &rep, CMatrixDouble &x);
  static void SPDMatrixSolve(CMatrixDouble &a, const int n, const bool isupper,
                             double &b[], int &info, CDenseSolverReport &rep,
                             double &x[]);
  static void SPDMatrixCholeskySolveM(CMatrixDouble &cha, const int n,
                                      const bool isupper, CMatrixDouble &b,
                                      const int m, int &info,
                                      CDenseSolverReport &rep,
                                      CMatrixDouble &x);
  static void SPDMatrixCholeskySolve(CMatrixDouble &cha, const int n,
                                     const bool isupper, double &b[], int &info,
                                     CDenseSolverReport &rep, double &x[]);
  static void HPDMatrixSolveM(CMatrixComplex &a, const int n,
                              const bool isupper, CMatrixComplex &b,
                              const int m, int &info, CDenseSolverReport &rep,
                              CMatrixComplex &x);
  static void HPDMatrixSolve(CMatrixComplex &a, const int n, const bool isupper,
                             al_complex &b[], int &info,
                             CDenseSolverReport &rep, al_complex &x[]);
  static void HPDMatrixCholeskySolveM(CMatrixComplex &cha, const int n,
                                      const bool isupper, CMatrixComplex &b,
                                      const int m, int &info,
                                      CDenseSolverReport &rep,
                                      CMatrixComplex &x);
  static void HPDMatrixCholeskySolve(CMatrixComplex &cha, const int n,
                                     const bool isupper, al_complex &b[],
                                     int &info, CDenseSolverReport &rep,
                                     al_complex &x[]);
  static void RMatrixSolveLS(CMatrixDouble &a, const int nrows, const int ncols,
                             double &b[], double threshold, int &info,
                             CDenseSolverLSReport &rep, double &x[]);
};

CDenseSolver::CDenseSolver(void) {}

CDenseSolver::~CDenseSolver(void) {}

static void CDenseSolver::RMatrixSolve(CMatrixDouble &a, const int n,
                                       double &b[], int &info,
                                       CDenseSolverReport &rep, double &x[]) {

  int i_ = 0;

  CMatrixDouble bm;
  CMatrixDouble xm;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  RMatrixSolveM(a, n, bm, 1, true, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::RMatrixSolveM(CMatrixDouble &a, const int n,
                                        CMatrixDouble &b, const int m,
                                        const bool rfs, int &info,
                                        CDenseSolverReport &rep,
                                        CMatrixDouble &x) {

  double scalea = 0;
  int i = 0;
  int j = 0;
  int i_ = 0;

  CMatrixDouble da;
  CMatrixDouble emptya;

  int p[];

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  da.Resize(n, n);

  scalea = 0;
  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      scalea = MathMax(scalea, MathAbs(a[i][j]));
  }

  if (scalea == 0.0)
    scalea = 1;

  scalea = 1 / scalea;
  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= n - 1; i_++)
      da[i].Set(i_, a[i][i_]);
  }

  CTrFac::RMatrixLU(da, n, n, p);

  if (rfs)
    RMatrixLUSolveInternal(da, p, scalea, n, a, true, b, m, info, rep, x);
  else
    RMatrixLUSolveInternal(da, p, scalea, n, emptya, false, b, m, info, rep, x);
}

static void CDenseSolver::RMatrixLUSolve(CMatrixDouble &lua, int &p[],
                                         const int n, double &b[], int &info,
                                         CDenseSolverReport &rep, double &x[]) {

  CMatrixDouble bm;
  CMatrixDouble xm;

  int i_ = 0;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  RMatrixLUSolveM(lua, p, n, bm, 1, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::RMatrixLUSolveM(CMatrixDouble &lua, int &p[],
                                          const int n, CMatrixDouble &b,
                                          const int m, int &info,
                                          CDenseSolverReport &rep,
                                          CMatrixDouble &x) {

  CMatrixDouble emptya;

  int i = 0;
  int j = 0;
  double scalea = 0;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  scalea = 0;
  for (i = 0; i <= n - 1; i++) {
    for (j = i; j <= n - 1; j++)
      scalea = MathMax(scalea, MathAbs(lua[i][j]));
  }

  if (scalea == 0.0)
    scalea = 1;

  scalea = 1 / scalea;

  RMatrixLUSolveInternal(lua, p, scalea, n, emptya, false, b, m, info, rep, x);
}

static void CDenseSolver::RMatrixMixedSolve(CMatrixDouble &a,
                                            CMatrixDouble &lua, int &p[],
                                            const int n, double &b[], int &info,
                                            CDenseSolverReport &rep,
                                            double &x[]) {

  int i_ = 0;

  CMatrixDouble bm;
  CMatrixDouble xm;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  RMatrixMixedSolveM(a, lua, p, n, bm, 1, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::RMatrixMixedSolveM(CMatrixDouble &a,
                                             CMatrixDouble &lua, int &p[],
                                             const int n, CMatrixDouble &b,
                                             const int m, int &info,
                                             CDenseSolverReport &rep,
                                             CMatrixDouble &x) {

  double scalea = 0;
  int i = 0;
  int j = 0;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  scalea = 0;
  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      scalea = MathMax(scalea, MathAbs(a[i][j]));
  }

  if (scalea == 0.0)
    scalea = 1;

  scalea = 1 / scalea;

  RMatrixLUSolveInternal(lua, p, scalea, n, a, true, b, m, info, rep, x);
}

static void CDenseSolver::CMatrixSolveM(CMatrixComplex &a, const int n,
                                        CMatrixComplex &b, const int m,
                                        const bool rfs, int &info,
                                        CDenseSolverReport &rep,
                                        CMatrixComplex &x) {

  double scalea = 0;
  int i = 0;
  int j = 0;
  int i_ = 0;

  int p[];

  CMatrixComplex da;
  CMatrixComplex emptya;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  da.Resize(n, n);

  scalea = 0;
  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      scalea = MathMax(scalea, CMath::AbsComplex(a[i][j]));
  }

  if (scalea == 0.0)
    scalea = 1;

  scalea = 1 / scalea;
  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= n - 1; i_++)
      da[i].Set(i_, a[i][i_]);
  }

  CTrFac::CMatrixLU(da, n, n, p);

  if (rfs)
    CMatrixLUSolveInternal(da, p, scalea, n, a, true, b, m, info, rep, x);
  else
    CMatrixLUSolveInternal(da, p, scalea, n, emptya, false, b, m, info, rep, x);
}

static void CDenseSolver::CMatrixSolve(CMatrixComplex &a, const int n,
                                       al_complex &b[], int &info,
                                       CDenseSolverReport &rep,
                                       al_complex &x[]) {

  int i_ = 0;

  CMatrixComplex bm;
  CMatrixComplex xm;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  CMatrixSolveM(a, n, bm, 1, true, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::CMatrixLUSolveM(CMatrixComplex &lua, int &p[],
                                          const int n, CMatrixComplex &b,
                                          const int m, int &info,
                                          CDenseSolverReport &rep,
                                          CMatrixComplex &x) {

  int i = 0;
  int j = 0;
  double scalea = 0;

  CMatrixComplex emptya;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  scalea = 0;
  for (i = 0; i <= n - 1; i++) {
    for (j = i; j <= n - 1; j++)
      scalea = MathMax(scalea, CMath::AbsComplex(lua[i][j]));
  }

  if (scalea == 0.0)
    scalea = 1;

  scalea = 1 / scalea;

  CMatrixLUSolveInternal(lua, p, scalea, n, emptya, false, b, m, info, rep, x);
}

static void CDenseSolver::CMatrixLUSolve(CMatrixComplex &lua, int &p[],
                                         const int n, al_complex &b[],
                                         int &info, CDenseSolverReport &rep,
                                         al_complex &x[]) {

  CMatrixComplex bm;
  CMatrixComplex xm;

  int i_ = 0;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  CMatrixLUSolveM(lua, p, n, bm, 1, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::CMatrixMixedSolveM(CMatrixComplex &a,
                                             CMatrixComplex &lua, int &p[],
                                             const int n, CMatrixComplex &b,
                                             const int m, int &info,
                                             CDenseSolverReport &rep,
                                             CMatrixComplex &x) {

  double scalea = 0;
  int i = 0;
  int j = 0;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  scalea = 0;
  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      scalea = MathMax(scalea, CMath::AbsComplex(a[i][j]));
  }

  if (scalea == 0.0)
    scalea = 1;

  scalea = 1 / scalea;

  CMatrixLUSolveInternal(lua, p, scalea, n, a, true, b, m, info, rep, x);
}

static void CDenseSolver::CMatrixMixedSolve(CMatrixComplex &a,
                                            CMatrixComplex &lua, int &p[],
                                            const int n, al_complex &b[],
                                            int &info, CDenseSolverReport &rep,
                                            al_complex &x[]) {

  CMatrixComplex bm;
  CMatrixComplex xm;

  int i_ = 0;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  CMatrixMixedSolveM(a, lua, p, n, bm, 1, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::SPDMatrixSolveM(CMatrixDouble &a, const int n,
                                          const bool isupper, CMatrixDouble &b,
                                          const int m, int &info,
                                          CDenseSolverReport &rep,
                                          CMatrixDouble &x) {

  double sqrtscalea = 0;
  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;
  int i_ = 0;

  CMatrixDouble da;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  da.Resize(n, n);

  sqrtscalea = 0;
  for (i = 0; i <= n - 1; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }

    for (j = j1; j <= j2; j++)
      sqrtscalea = MathMax(sqrtscalea, MathAbs(a[i][j]));
  }

  if (sqrtscalea == 0.0)
    sqrtscalea = 1;

  sqrtscalea = 1 / sqrtscalea;
  sqrtscalea = MathSqrt(sqrtscalea);
  for (i = 0; i <= n - 1; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }

    for (i_ = j1; i_ <= j2; i_++)
      da[i].Set(i_, a[i][i_]);
  }

  if (!CTrFac::SPDMatrixCholesky(da, n, isupper)) {

    x.Resize(n, m);
    for (i = 0; i <= n - 1; i++) {
      for (j = 0; j <= m - 1; j++)
        x[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }
  info = 1;

  SPDMatrixCholeskySolveInternal(da, sqrtscalea, n, isupper, a, true, b, m,
                                 info, rep, x);
}

static void CDenseSolver::SPDMatrixSolve(CMatrixDouble &a, const int n,
                                         const bool isupper, double &b[],
                                         int &info, CDenseSolverReport &rep,
                                         double &x[]) {

  int i_ = 0;

  CMatrixDouble bm;
  CMatrixDouble xm;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  SPDMatrixSolveM(a, n, isupper, bm, 1, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::SPDMatrixCholeskySolveM(
    CMatrixDouble &cha, const int n, const bool isupper, CMatrixDouble &b,
    const int m, int &info, CDenseSolverReport &rep, CMatrixDouble &x) {

  double sqrtscalea = 0;
  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;

  CMatrixDouble emptya;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  sqrtscalea = 0;
  for (i = 0; i <= n - 1; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }

    for (j = j1; j <= j2; j++)
      sqrtscalea = MathMax(sqrtscalea, MathAbs(cha[i][j]));
  }

  if (sqrtscalea == 0.0)
    sqrtscalea = 1;

  sqrtscalea = 1 / sqrtscalea;

  SPDMatrixCholeskySolveInternal(cha, sqrtscalea, n, isupper, emptya, false, b,
                                 m, info, rep, x);
}

static void CDenseSolver::SPDMatrixCholeskySolve(
    CMatrixDouble &cha, const int n, const bool isupper, double &b[], int &info,
    CDenseSolverReport &rep, double &x[]) {

  int i_ = 0;

  CMatrixDouble bm;
  CMatrixDouble xm;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  SPDMatrixCholeskySolveM(cha, n, isupper, bm, 1, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::HPDMatrixSolveM(CMatrixComplex &a, const int n,
                                          const bool isupper, CMatrixComplex &b,
                                          const int m, int &info,
                                          CDenseSolverReport &rep,
                                          CMatrixComplex &x) {

  double sqrtscalea = 0;
  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;
  int i_ = 0;

  CMatrixComplex da;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  da.Resize(n, n);

  sqrtscalea = 0;
  for (i = 0; i <= n - 1; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }

    for (j = j1; j <= j2; j++)
      sqrtscalea = MathMax(sqrtscalea, CMath::AbsComplex(a[i][j]));
  }

  if (sqrtscalea == 0.0)
    sqrtscalea = 1;

  sqrtscalea = 1 / sqrtscalea;
  sqrtscalea = MathSqrt(sqrtscalea);
  for (i = 0; i <= n - 1; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }

    for (i_ = j1; i_ <= j2; i_++)
      da[i].Set(i_, a[i][i_]);
  }

  if (!CTrFac::HPDMatrixCholesky(da, n, isupper)) {

    x.Resize(n, m);
    for (i = 0; i <= n - 1; i++) {
      for (j = 0; j <= m - 1; j++)
        x[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }
  info = 1;

  HPDMatrixCholeskySolveInternal(da, sqrtscalea, n, isupper, a, true, b, m,
                                 info, rep, x);
}

static void CDenseSolver::HPDMatrixSolve(CMatrixComplex &a, const int n,
                                         const bool isupper, al_complex &b[],
                                         int &info, CDenseSolverReport &rep,
                                         al_complex &x[]) {

  int i_ = 0;

  CMatrixComplex bm;
  CMatrixComplex xm;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  HPDMatrixSolveM(a, n, isupper, bm, 1, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::HPDMatrixCholeskySolveM(
    CMatrixComplex &cha, const int n, const bool isupper, CMatrixComplex &b,
    const int m, int &info, CDenseSolverReport &rep, CMatrixComplex &x) {

  double sqrtscalea = 0;
  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;

  CMatrixComplex emptya;

  info = 0;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  sqrtscalea = 0;
  for (i = 0; i <= n - 1; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }

    for (j = j1; j <= j2; j++) {
      sqrtscalea = MathMax(sqrtscalea, CMath::AbsComplex(cha[i][j]));
    }
  }

  if (sqrtscalea == 0.0) {
    sqrtscalea = 1;
  }

  sqrtscalea = 1 / sqrtscalea;

  HPDMatrixCholeskySolveInternal(cha, sqrtscalea, n, isupper, emptya, false, b,
                                 m, info, rep, x);
}

static void CDenseSolver::HPDMatrixCholeskySolve(
    CMatrixComplex &cha, const int n, const bool isupper, al_complex &b[],
    int &info, CDenseSolverReport &rep, al_complex &x[]) {

  int i_ = 0;

  CMatrixComplex bm;
  CMatrixComplex xm;

  info = 0;

  if (n <= 0) {
    info = -1;
    return;
  }

  bm.Resize(n, 1);

  for (i_ = 0; i_ <= n - 1; i_++)
    bm[i_].Set(0, b[i_]);

  HPDMatrixCholeskySolveM(cha, n, isupper, bm, 1, info, rep, xm);

  ArrayResizeAL(x, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = xm[i_][0];
}

static void CDenseSolver::RMatrixSolveLS(CMatrixDouble &a, const int nrows,
                                         const int ncols, double &b[],
                                         double threshold, int &info,
                                         CDenseSolverLSReport &rep,
                                         double &x[]) {

  CMatrixDouble u;
  CMatrixDouble vt;

  double sv[];
  double rp[];
  double utb[];
  double sutb[];
  double tmp[];
  double ta[];
  double tx[];
  double buf[];
  double w[];

  int i = 0;
  int j = 0;
  int nsv = 0;
  int kernelidx = 0;
  double v = 0;
  double verr = 0;
  bool svdfailed;
  bool zeroa;
  int rfs = 0;
  int nrfs = 0;
  bool terminatenexttime;
  bool smallerr;
  int i_ = 0;

  info = 0;

  if ((nrows <= 0 || ncols <= 0) || threshold < 0.0) {
    info = -1;
    return;
  }

  if (threshold == 0.0)
    threshold = 1000 * CMath::m_machineepsilon;

  svdfailed =
      !CSingValueDecompose::RMatrixSVD(a, nrows, ncols, 1, 2, 2, sv, u, vt);

  if (sv[0] == 0.0)
    zeroa = true;
  else
    zeroa = false;

  if (svdfailed || zeroa) {

    if (svdfailed)
      info = -4;
    else
      info = 1;

    ArrayResizeAL(x, ncols);
    for (i = 0; i <= ncols - 1; i++)
      x[i] = 0;

    rep.m_n = ncols;
    rep.m_k = ncols;
    rep.m_cx.Resize(ncols, ncols);
    for (i = 0; i <= ncols - 1; i++) {
      for (j = 0; j <= ncols - 1; j++) {

        if (i == j)
          rep.m_cx[i].Set(j, 1);
        else
          rep.m_cx[i].Set(j, 0);
      }
    }
    rep.m_r2 = 0;

    return;
  }
  nsv = MathMin(ncols, nrows);

  if (nsv == ncols)
    rep.m_r2 = sv[nsv - 1] / sv[0];
  else
    rep.m_r2 = 0;

  rep.m_n = ncols;
  info = 1;

  ArrayResizeAL(utb, nsv);
  ArrayResizeAL(sutb, nsv);
  ArrayResizeAL(x, ncols);
  ArrayResizeAL(tmp, ncols);
  ArrayResizeAL(ta, ncols + 1);
  ArrayResizeAL(tx, ncols + 1);
  ArrayResizeAL(buf, ncols + 1);

  for (i = 0; i <= ncols - 1; i++)
    x[i] = 0;
  kernelidx = nsv;
  for (i = 0; i <= nsv - 1; i++) {

    if (sv[i] <= threshold * sv[0]) {
      kernelidx = i;
      break;
    }
  }

  rep.m_k = ncols - kernelidx;
  nrfs = CDenseSolverRFSMaxV2(ncols, rep.m_r2);
  terminatenexttime = false;

  ArrayResizeAL(rp, nrows);
  for (rfs = 0; rfs <= nrfs; rfs++) {

    if (terminatenexttime)
      break;

    if (rfs == 0) {
      for (i_ = 0; i_ <= nrows - 1; i_++)
        rp[i_] = b[i_];
    } else {
      smallerr = true;
      for (i = 0; i <= nrows - 1; i++) {

        for (i_ = 0; i_ <= ncols - 1; i_++)
          ta[i_] = a[i][i_];
        ta[ncols] = -1;

        for (i_ = 0; i_ <= ncols - 1; i_++)
          tx[i_] = x[i_];
        tx[ncols] = b[i];

        CXblas::XDot(ta, tx, ncols + 1, buf, v, verr);
        rp[i] = -v;
        smallerr = smallerr && MathAbs(v) < 4 * verr;
      }

      if (smallerr)
        terminatenexttime = true;
    }

    for (i = 0; i <= ncols - 1; i++)
      tmp[i] = 0;
    for (i = 0; i <= nsv - 1; i++)
      utb[i] = 0;

    for (i = 0; i <= nrows - 1; i++) {
      v = rp[i];
      for (i_ = 0; i_ <= nsv - 1; i_++)
        utb[i_] = utb[i_] + v * u[i][i_];
    }
    for (i = 0; i <= nsv - 1; i++) {

      if (i < kernelidx)
        sutb[i] = utb[i] / sv[i];
      else
        sutb[i] = 0;
    }

    for (i = 0; i <= nsv - 1; i++) {
      v = sutb[i];
      for (i_ = 0; i_ <= ncols - 1; i_++)
        tmp[i_] = tmp[i_] + v * vt[i][i_];
    }

    for (i_ = 0; i_ <= ncols - 1; i_++)
      x[i_] = x[i_] + tmp[i_];
  }

  if (rep.m_k > 0) {

    rep.m_cx.Resize(ncols, rep.m_k);
    for (i = 0; i <= rep.m_k - 1; i++) {
      for (i_ = 0; i_ <= ncols - 1; i_++)
        rep.m_cx[i_].Set(i, vt[kernelidx + i][i_]);
    }
  }
}

static void CDenseSolver::RMatrixLUSolveInternal(
    CMatrixDouble &lua, int &p[], const double scalea, const int n,
    CMatrixDouble &a, const bool havea, CMatrixDouble &b, const int m,
    int &info, CDenseSolverReport &rep, CMatrixDouble &x) {

  int i = 0;
  int j = 0;
  int k = 0;
  int rfs = 0;
  int nrfs = 0;
  double v = 0;
  double verr = 0;
  double mxb = 0;
  double scaleright = 0;
  bool smallerr;
  bool terminatenexttime;
  int i_ = 0;

  double xc[];
  double y[];
  double bc[];
  double xa[];
  double xb[];
  double tx[];

  info = 0;

  if (!CAp::Assert(scalea > 0.0))
    return;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }
  for (i = 0; i <= n - 1; i++) {

    if (p[i] > n - 1 || p[i] < i) {
      info = -1;
      return;
    }
  }

  x.Resize(n, m);
  ArrayResizeAL(y, n);
  ArrayResizeAL(xc, n);
  ArrayResizeAL(bc, n);
  ArrayResizeAL(tx, n + 1);
  ArrayResizeAL(xa, n + 1);
  ArrayResizeAL(xb, n + 1);

  rep.m_r1 = CRCond::RMatrixLURCond1(lua, n);
  rep.m_rinf = CRCond::RMatrixLURCondInf(lua, n);

  if (rep.m_r1 < CRCond::RCondThreshold() ||
      rep.m_rinf < CRCond::RCondThreshold()) {
    for (i = 0; i <= n - 1; i++) {
      for (j = 0; j <= m - 1; j++)
        x[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }
  info = 1;

  for (k = 0; k <= m - 1; k++) {

    for (i_ = 0; i_ <= n - 1; i_++)
      bc[i_] = b[i_][k];

    mxb = 0;
    for (i = 0; i <= n - 1; i++)
      mxb = MathMax(mxb, MathAbs(bc[i]));

    if (mxb == 0.0)
      mxb = 1;

    scaleright = 1 / mxb;

    for (i_ = 0; i_ <= n - 1; i_++)
      xc[i_] = bc[i_] * scaleright;

    RBasicLUSolve(lua, p, scalea, n, xc, tx);

    if (havea) {

      nrfs = CDenseSolverRFSMax(n, rep.m_r1, rep.m_rinf);
      terminatenexttime = false;
      for (rfs = 0; rfs <= nrfs - 1; rfs++) {

        if (terminatenexttime)
          break;

        smallerr = true;
        for (i_ = 0; i_ <= n - 1; i_++)
          xb[i_] = xc[i_];
        for (i = 0; i <= n - 1; i++) {

          for (i_ = 0; i_ <= n - 1; i_++)
            xa[i_] = a[i][i_] * scalea;
          xa[n] = -1;
          xb[n] = bc[i] * scaleright;

          CXblas::XDot(xa, xb, n + 1, tx, v, verr);
          y[i] = -v;
          smallerr = smallerr && MathAbs(v) < 4 * verr;
        }

        if (smallerr)
          terminatenexttime = true;

        RBasicLUSolve(lua, p, scalea, n, y, tx);
        for (i_ = 0; i_ <= n - 1; i_++)
          xc[i_] = xc[i_] + y[i_];
      }
    }

    v = scalea * mxb;
    for (i_ = 0; i_ <= n - 1; i_++)
      x[i_].Set(k, xc[i_] * v);
  }
}

static void CDenseSolver::SPDMatrixCholeskySolveInternal(
    CMatrixDouble &cha, const double sqrtscalea, const int n,
    const bool isupper, CMatrixDouble &a, const bool havea, CMatrixDouble &b,
    const int m, int &info, CDenseSolverReport &rep, CMatrixDouble &x) {

  int i = 0;
  int j = 0;
  int k = 0;
  double v = 0;
  double mxb = 0;
  double scaleright = 0;
  int i_ = 0;

  double xc[];
  double y[];
  double bc[];
  double xa[];
  double xb[];
  double tx[];

  info = 0;

  if (!CAp::Assert(sqrtscalea > 0.0))
    return;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  x.Resize(n, m);
  ArrayResizeAL(y, n);
  ArrayResizeAL(xc, n);
  ArrayResizeAL(bc, n);
  ArrayResizeAL(tx, n + 1);
  ArrayResizeAL(xa, n + 1);
  ArrayResizeAL(xb, n + 1);

  rep.m_r1 = CRCond::SPDMatrixCholeskyRCond(cha, n, isupper);
  rep.m_rinf = rep.m_r1;

  if (rep.m_r1 < CRCond::RCondThreshold()) {
    for (i = 0; i <= n - 1; i++) {
      for (j = 0; j <= m - 1; j++)
        x[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }
  info = 1;

  for (k = 0; k <= m - 1; k++) {

    for (i_ = 0; i_ <= n - 1; i_++)
      bc[i_] = b[i_][k];

    mxb = 0;
    for (i = 0; i <= n - 1; i++)
      mxb = MathMax(mxb, MathAbs(bc[i]));

    if (mxb == 0.0)
      mxb = 1;
    scaleright = 1 / mxb;

    for (i_ = 0; i_ <= n - 1; i_++)
      xc[i_] = bc[i_] * scaleright;

    SPDBasicCholeskySolve(cha, sqrtscalea, n, isupper, xc, tx);

    v = CMath::Sqr(sqrtscalea) * mxb;
    for (i_ = 0; i_ <= n - 1; i_++)
      x[i_].Set(k, xc[i_] * v);
  }
}

static void CDenseSolver::CMatrixLUSolveInternal(
    CMatrixComplex &lua, int &p[], const double scalea, const int n,
    CMatrixComplex &a, const bool havea, CMatrixComplex &b, const int m,
    int &info, CDenseSolverReport &rep, CMatrixComplex &x) {

  int i = 0;
  int j = 0;
  int k = 0;
  int rfs = 0;
  int nrfs = 0;
  al_complex v = 0;
  double verr = 0;
  double mxb = 0;
  double scaleright = 0;
  bool smallerr;
  bool terminatenexttime;
  int i_ = 0;

  al_complex xc[];
  al_complex y[];
  al_complex bc[];
  al_complex xa[];
  al_complex xb[];
  al_complex tx[];
  double tmpbuf[];

  info = 0;

  if (!CAp::Assert(scalea > 0.0))
    return;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }
  for (i = 0; i <= n - 1; i++) {

    if (p[i] > n - 1 || p[i] < i) {
      info = -1;
      return;
    }
  }

  x.Resize(n, m);
  ArrayResizeAL(y, n);
  ArrayResizeAL(xc, n);
  ArrayResizeAL(bc, n);
  ArrayResizeAL(tx, n);
  ArrayResizeAL(xa, n + 1);
  ArrayResizeAL(xb, n + 1);
  ArrayResizeAL(tmpbuf, 2 * n + 2);

  rep.m_r1 = CRCond::CMatrixLURCond1(lua, n);
  rep.m_rinf = CRCond::CMatrixLURCondInf(lua, n);

  if (rep.m_r1 < CRCond::RCondThreshold() ||
      rep.m_rinf < CRCond::RCondThreshold()) {
    for (i = 0; i <= n - 1; i++) {
      for (j = 0; j <= m - 1; j++)
        x[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }
  info = 1;

  for (k = 0; k <= m - 1; k++) {

    for (i_ = 0; i_ <= n - 1; i_++)
      bc[i_] = b[i_][k];

    mxb = 0;
    for (i = 0; i <= n - 1; i++)
      mxb = MathMax(mxb, CMath::AbsComplex(bc[i]));

    if (mxb == 0.0)
      mxb = 1;
    scaleright = 1 / mxb;

    for (i_ = 0; i_ <= n - 1; i_++)
      xc[i_] = bc[i_] * scaleright;

    CBasicLUSolve(lua, p, scalea, n, xc, tx);

    if (havea) {

      nrfs = CDenseSolverRFSMax(n, rep.m_r1, rep.m_rinf);
      terminatenexttime = false;
      for (rfs = 0; rfs <= nrfs - 1; rfs++) {

        if (terminatenexttime)
          break;

        smallerr = true;

        for (i_ = 0; i_ <= n - 1; i_++)
          xb[i_] = xc[i_];
        for (i = 0; i <= n - 1; i++) {

          for (i_ = 0; i_ <= n - 1; i_++)
            xa[i_] = a[i][i_] * scalea;
          xa[n] = -1;
          xb[n] = bc[i] * scaleright;

          CXblas::XCDot(xa, xb, n + 1, tmpbuf, v, verr);
          y[i] = -v;
          smallerr = smallerr && CMath::AbsComplex(v) < 4 * verr;
        }

        if (smallerr)
          terminatenexttime = true;

        CBasicLUSolve(lua, p, scalea, n, y, tx);
        for (i_ = 0; i_ <= n - 1; i_++)
          xc[i_] = xc[i_] + y[i_];
      }
    }

    v = scalea * mxb;
    for (i_ = 0; i_ <= n - 1; i_++)
      x[i_].Set(k, xc[i_] * v);
  }
}

static void CDenseSolver::HPDMatrixCholeskySolveInternal(
    CMatrixComplex &cha, const double sqrtscalea, const int n,
    const bool isupper, CMatrixComplex &a, const bool havea, CMatrixComplex &b,
    const int m, int &info, CDenseSolverReport &rep, CMatrixComplex &x) {

  int i = 0;
  int j = 0;
  int k = 0;
  double v = 0;
  double mxb = 0;
  double scaleright = 0;
  int i_ = 0;

  al_complex xc[];
  al_complex y[];
  al_complex bc[];
  al_complex xa[];
  al_complex xb[];
  al_complex tx[];

  info = 0;

  if (!CAp::Assert(sqrtscalea > 0.0))
    return;

  if (n <= 0 || m <= 0) {
    info = -1;
    return;
  }

  x.Resize(n, m);
  ArrayResizeAL(y, n);
  ArrayResizeAL(xc, n);
  ArrayResizeAL(bc, n);
  ArrayResizeAL(tx, n + 1);
  ArrayResizeAL(xa, n + 1);
  ArrayResizeAL(xb, n + 1);

  rep.m_r1 = CRCond::HPDMatrixCholeskyRCond(cha, n, isupper);
  rep.m_rinf = rep.m_r1;

  if (rep.m_r1 < CRCond::RCondThreshold()) {
    for (i = 0; i <= n - 1; i++) {
      for (j = 0; j <= m - 1; j++)
        x[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }
  info = 1;

  for (k = 0; k <= m - 1; k++) {

    for (i_ = 0; i_ <= n - 1; i_++)
      bc[i_] = b[i_][k];

    mxb = 0;
    for (i = 0; i <= n - 1; i++)
      mxb = MathMax(mxb, CMath::AbsComplex(bc[i]));

    if (mxb == 0.0)
      mxb = 1;
    scaleright = 1 / mxb;

    for (i_ = 0; i_ <= n - 1; i_++)
      xc[i_] = bc[i_] * scaleright;

    HPDBasicCholeskySolve(cha, sqrtscalea, n, isupper, xc, tx);

    v = CMath::Sqr(sqrtscalea) * mxb;
    for (i_ = 0; i_ <= n - 1; i_++)
      x[i_].Set(k, xc[i_] * v);
  }
}

static int CDenseSolver::CDenseSolverRFSMax(const int n, const double r1,
                                            const double rinf) {

  return (5);
}

static int CDenseSolver::CDenseSolverRFSMaxV2(const int n, const double r2) {

  return (CDenseSolverRFSMax(n, 0, 0));
}

static void CDenseSolver::RBasicLUSolve(CMatrixDouble &lua, int &p[],
                                        const double scalea, const int n,
                                        double &xb[], double &tmp[]) {

  int i = 0;
  double v = 0;
  int i_ = 0;

  for (i = 0; i <= n - 1; i++) {

    if (p[i] != i) {
      v = xb[i];
      xb[i] = xb[p[i]];
      xb[p[i]] = v;
    }
  }

  for (i = 1; i <= n - 1; i++) {
    v = 0.0;

    for (i_ = 0; i_ <= i - 1; i_++)
      v += lua[i][i_] * xb[i_];

    xb[i] = xb[i] - v;
  }

  xb[n - 1] = xb[n - 1] / (lua[n - 1][n - 1] * scalea);
  for (i = n - 2; i >= 0; i--) {

    for (i_ = i + 1; i_ <= n - 1; i_++)
      tmp[i_] = lua[i][i_] * scalea;
    v = 0.0;

    for (i_ = i + 1; i_ <= n - 1; i_++)
      v += tmp[i_] * xb[i_];

    xb[i] = (xb[i] - v) / (lua[i][i] * scalea);
  }
}

static void CDenseSolver::SPDBasicCholeskySolve(CMatrixDouble &cha,
                                                const double sqrtscalea,
                                                const int n, const bool isupper,
                                                double &xb[], double &tmp[]) {

  int i = 0;
  double v = 0;
  int i_ = 0;

  if (isupper) {

    for (i = 0; i <= n - 1; i++) {
      xb[i] = xb[i] / (sqrtscalea * cha[i][i]);

      if (i < n - 1) {
        v = xb[i];

        for (i_ = i + 1; i_ <= n - 1; i_++)
          tmp[i_] = sqrtscalea * cha[i][i_];
        for (i_ = i + 1; i_ <= n - 1; i_++)
          xb[i_] = xb[i_] - v * tmp[i_];
      }
    }

    for (i = n - 1; i >= 0; i--) {

      if (i < n - 1) {
        for (i_ = i + 1; i_ <= n - 1; i_++)
          tmp[i_] = sqrtscalea * cha[i][i_];
        v = 0.0;

        for (i_ = i + 1; i_ <= n - 1; i_++)
          v += tmp[i_] * xb[i_];

        xb[i] = xb[i] - v;
      }
      xb[i] = xb[i] / (sqrtscalea * cha[i][i]);
    }
  } else {

    for (i = 0; i <= n - 1; i++) {

      if (i > 0) {
        for (i_ = 0; i_ <= i - 1; i_++)
          tmp[i_] = sqrtscalea * cha[i][i_];

        v = 0.0;
        for (i_ = 0; i_ <= i - 1; i_++)
          v += tmp[i_] * xb[i_];

        xb[i] = xb[i] - v;
      }
      xb[i] = xb[i] / (sqrtscalea * cha[i][i]);
    }

    for (i = n - 1; i >= 0; i--) {
      xb[i] = xb[i] / (sqrtscalea * cha[i][i]);

      if (i > 0) {
        v = xb[i];

        for (i_ = 0; i_ <= i - 1; i_++)
          tmp[i_] = sqrtscalea * cha[i][i_];
        for (i_ = 0; i_ <= i - 1; i_++)
          xb[i_] = xb[i_] - v * tmp[i_];
      }
    }
  }
}

static void CDenseSolver::CBasicLUSolve(CMatrixComplex &lua, int &p[],
                                        const double scalea, const int n,
                                        al_complex &xb[], al_complex &tmp[]) {

  int i = 0;
  al_complex v = 0;
  int i_ = 0;

  for (i = 0; i <= n - 1; i++) {

    if (p[i] != i) {
      v = xb[i];
      xb[i] = xb[p[i]];
      xb[p[i]] = v;
    }
  }
  for (i = 1; i <= n - 1; i++) {
    v = 0.0;

    for (i_ = 0; i_ <= i - 1; i_++)
      v += lua[i][i_] * xb[i_];

    xb[i] = xb[i] - v;
  }

  xb[n - 1] = xb[n - 1] / (lua[n - 1][n - 1] * scalea);
  for (i = n - 2; i >= 0; i--) {
    for (i_ = i + 1; i_ <= n - 1; i_++)
      tmp[i_] = lua[i][i_] * scalea;

    v = 0.0;
    for (i_ = i + 1; i_ <= n - 1; i_++)
      v += tmp[i_] * xb[i_];

    xb[i] = (xb[i] - v) / (lua[i][i] * scalea);
  }
}

static void CDenseSolver::HPDBasicCholeskySolve(CMatrixComplex &cha,
                                                const double sqrtscalea,
                                                const int n, const bool isupper,
                                                al_complex &xb[],
                                                al_complex &tmp[]) {

  int i = 0;
  al_complex v = 0;
  int i_ = 0;

  if (isupper) {

    for (i = 0; i <= n - 1; i++) {
      xb[i] = xb[i] / (CMath::Conj(cha[i][i]) * sqrtscalea);

      if (i < n - 1) {
        v = xb[i];

        for (i_ = i + 1; i_ <= n - 1; i_++)
          tmp[i_] = CMath::Conj(cha[i][i_]) * sqrtscalea;
        for (i_ = i + 1; i_ <= n - 1; i_++)
          xb[i_] = xb[i_] - v * tmp[i_];
      }
    }

    for (i = n - 1; i >= 0; i--) {

      if (i < n - 1) {
        for (i_ = i + 1; i_ <= n - 1; i_++)
          tmp[i_] = cha[i][i_] * sqrtscalea;

        v = 0.0;
        for (i_ = i + 1; i_ <= n - 1; i_++)
          v += tmp[i_] * xb[i_];

        xb[i] = xb[i] - v;
      }
      xb[i] = xb[i] / (cha[i][i] * sqrtscalea);
    }
  } else {

    for (i = 0; i <= n - 1; i++) {

      if (i > 0) {
        for (i_ = 0; i_ <= i - 1; i_++)
          tmp[i_] = cha[i][i_] * sqrtscalea;

        v = 0.0;
        for (i_ = 0; i_ <= i - 1; i_++)
          v += tmp[i_] * xb[i_];

        xb[i] = xb[i] - v;
      }
      xb[i] = xb[i] / (cha[i][i] * sqrtscalea);
    }

    for (i = n - 1; i >= 0; i--) {
      xb[i] = xb[i] / (CMath::Conj(cha[i][i]) * sqrtscalea);

      if (i > 0) {
        v = xb[i];

        for (i_ = 0; i_ <= i - 1; i_++)
          tmp[i_] = CMath::Conj(cha[i][i_]) * sqrtscalea;
        for (i_ = 0; i_ <= i - 1; i_++)
          xb[i_] = xb[i_] - v * tmp[i_];
      }
    }
  }
}

class CNlEqState {
public:
  int m_n;
  int m_m;
  double m_epsf;
  int m_maxits;
  bool m_xrep;
  double m_stpmax;
  double m_f;
  bool m_needf;
  bool m_needfij;
  bool m_xupdated;
  RCommState m_rstate;
  int m_repiterationscount;
  int m_repnfunc;
  int m_repnjac;
  int m_repterminationtype;
  double m_fbase;
  double m_fprev;

  double m_x[];
  double m_fi[];
  double m_xbase[];
  double m_candstep[];
  double m_rightpart[];
  double m_cgbuf[];

  CMatrixDouble m_j;

  CNlEqState(void);
  ~CNlEqState(void);

  void Copy(CNlEqState &obj);
};

CNlEqState::CNlEqState(void) {}

CNlEqState::~CNlEqState(void) {}

void CNlEqState::Copy(CNlEqState &obj) {

  m_n = obj.m_n;
  m_m = obj.m_m;
  m_epsf = obj.m_epsf;
  m_maxits = obj.m_maxits;
  m_xrep = obj.m_xrep;
  m_stpmax = obj.m_stpmax;
  m_f = obj.m_f;
  m_needf = obj.m_needf;
  m_needfij = obj.m_needfij;
  m_xupdated = obj.m_xupdated;
  m_repiterationscount = obj.m_repiterationscount;
  m_repnfunc = obj.m_repnfunc;
  m_repnjac = obj.m_repnjac;
  m_repterminationtype = obj.m_repterminationtype;
  m_fbase = obj.m_fbase;
  m_fprev = obj.m_fprev;
  m_rstate.Copy(obj.m_rstate);

  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_fi, obj.m_fi);
  ArrayCopy(m_xbase, obj.m_xbase);
  ArrayCopy(m_candstep, obj.m_candstep);
  ArrayCopy(m_rightpart, obj.m_rightpart);
  ArrayCopy(m_cgbuf, obj.m_cgbuf);

  m_j = obj.m_j;
}

class CNlEqStateShell {
private:
  CNlEqState m_innerobj;

public:
  CNlEqStateShell(void);
  CNlEqStateShell(CNlEqState &obj);
  ~CNlEqStateShell(void);

  bool GetNeedF(void);
  void SetNeedF(const bool b);
  bool GetNeedFIJ(void);
  void SetNeedFIJ(const bool b);
  bool GetXUpdated(void);
  void SetXUpdated(const bool b);
  double GetF(void);
  void SetF(const double d);
  CNlEqState *GetInnerObj(void);
};

CNlEqStateShell::CNlEqStateShell(void) {}

CNlEqStateShell::CNlEqStateShell(CNlEqState &obj) {

  m_innerobj.Copy(obj);
}

CNlEqStateShell::~CNlEqStateShell(void) {}

bool CNlEqStateShell::GetNeedF(void) {

  return (m_innerobj.m_needf);
}

void CNlEqStateShell::SetNeedF(const bool b) {

  m_innerobj.m_needf = b;
}

bool CNlEqStateShell::GetNeedFIJ(void) {

  return (m_innerobj.m_needfij);
}

void CNlEqStateShell::SetNeedFIJ(const bool b) {

  m_innerobj.m_needfij = b;
}

bool CNlEqStateShell::GetXUpdated(void) {

  return (m_innerobj.m_xupdated);
}

void CNlEqStateShell::SetXUpdated(const bool b) {

  m_innerobj.m_xupdated = b;
}

double CNlEqStateShell::GetF(void) {

  return (m_innerobj.m_f);
}

void CNlEqStateShell::SetF(const double d) {

  m_innerobj.m_f = d;
}

CNlEqState *CNlEqStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CNlEqReport {
public:
  int m_iterationscount;
  int m_nfunc;
  int m_njac;
  int m_terminationtype;

  CNlEqReport(void);
  ~CNlEqReport(void);

  void Copy(CNlEqReport &obj);
};

CNlEqReport::CNlEqReport(void) {}

CNlEqReport::~CNlEqReport(void) {}

void CNlEqReport::Copy(CNlEqReport &obj) {

  m_iterationscount = obj.m_iterationscount;
  m_nfunc = obj.m_nfunc;
  m_njac = obj.m_njac;
  m_terminationtype = obj.m_terminationtype;
}

class CNlEqReportShell {
private:
  CNlEqReport m_innerobj;

public:
  CNlEqReportShell(void);
  CNlEqReportShell(CNlEqReport &obj);
  ~CNlEqReportShell(void);

  int GetIterationsCount(void);
  void SetIterationsCount(const int i);
  int GetNFunc(void);
  void SetNFunc(const int i);
  int GetNJac(void);
  void SetNJac(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  CNlEqReport *GetInnerObj(void);
};

CNlEqReportShell::CNlEqReportShell(void) {}

CNlEqReportShell::CNlEqReportShell(CNlEqReport &obj) {

  m_innerobj.Copy(obj);
}

CNlEqReportShell::~CNlEqReportShell(void) {}

int CNlEqReportShell::GetIterationsCount(void) {

  return (m_innerobj.m_iterationscount);
}

void CNlEqReportShell::SetIterationsCount(const int i) {

  m_innerobj.m_iterationscount = i;
}

int CNlEqReportShell::GetNFunc(void) {

  return (m_innerobj.m_nfunc);
}

void CNlEqReportShell::SetNFunc(const int i) {

  m_innerobj.m_nfunc = i;
}

int CNlEqReportShell::GetNJac(void) {

  return (m_innerobj.m_njac);
}

void CNlEqReportShell::SetNJac(const int i) {

  m_innerobj.m_njac = i;
}

int CNlEqReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CNlEqReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

CNlEqReport *CNlEqReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CNlEq {
private:
  static void ClearRequestFields(CNlEqState &state);
  static bool IncreaseLambda(double &lambdav, double &nu,
                             const double lambdaup);
  static void DecreaseLambda(double &lambdav, double &nu,
                             const double lambdadown);

  static void Func_lbl_rcomm(CNlEqState &state, const int n, const int m,
                             const int i, const bool b, const double lambdaup,
                             const double lambdadown, const double lambdav,
                             const double rho, const double mu,
                             const double stepnorm);
  static void Func_lbl_7(CNlEqState &state, const int n);
  static bool Func_lbl_5(CNlEqState &state, double &lambdaup,
                         double &lambdadown, double &lambdav, double &rho);
  static bool Func_lbl_11(CNlEqState &state, const double stepnorm);
  static int Func_lbl_10(CNlEqState &state, const int n, const int m,
                         const int i, const bool b, const double lambdaup,
                         const double lambdadown, const double lambdav,
                         const double rho, const double mu,
                         const double stepnorm);
  static int Func_lbl_9(CNlEqState &state, int &n, int &m, int &i, bool &b,
                        const double lambdaup, const double lambdadown,
                        double &lambdav, const double rho, const double mu,
                        double &stepnorm);

public:
  static const int m_armijomaxfev;

  CNlEq(void);
  ~CNlEq(void);

  static void NlEqCreateLM(const int n, const int m, double &x[],
                           CNlEqState &state);
  static void NlEqSetCond(CNlEqState &state, double epsf, const int maxits);
  static void NlEqSetXRep(CNlEqState &state, const bool needxrep);
  static void NlEqSetStpMax(CNlEqState &state, const double stpmax);
  static void NlEqResults(CNlEqState &state, double &x[], CNlEqReport &rep);
  static void NlEqResultsBuf(CNlEqState &state, double &x[], CNlEqReport &rep);
  static void NlEqRestartFrom(CNlEqState &state, double &x[]);
  static bool NlEqIteration(CNlEqState &state);
};

const int CNlEq::m_armijomaxfev = 20;

CNlEq::CNlEq(void) {}

CNlEq::~CNlEq(void) {}

static void CNlEq::NlEqCreateLM(const int n, const int m, double &x[],
                                CNlEqState &state) {

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  state.m_n = n;
  state.m_m = m;
  NlEqSetCond(state, 0, 0);
  NlEqSetXRep(state, false);
  NlEqSetStpMax(state, 0);

  ArrayResizeAL(state.m_x, n);
  ArrayResizeAL(state.m_xbase, n);
  state.m_j.Resize(m, n);
  ArrayResizeAL(state.m_fi, m);
  ArrayResizeAL(state.m_rightpart, n);
  ArrayResizeAL(state.m_candstep, n);

  NlEqRestartFrom(state, x);
}

static void CNlEq::NlEqSetCond(CNlEqState &state, double epsf,
                               const int maxits) {

  if (!CAp::Assert(CMath::IsFinite(epsf),
                   __FUNCTION__ + ": EpsF is not finite number!"))
    return;

  if (!CAp::Assert(epsf >= 0.0, __FUNCTION__ + ": negative EpsF!"))
    return;

  if (!CAp::Assert(maxits >= 0, __FUNCTION__ + ": negative MaxIts!"))
    return;

  if (epsf == 0.0 && maxits == 0)
    epsf = 1.0E-6;

  state.m_epsf = epsf;
  state.m_maxits = maxits;
}

static void CNlEq::NlEqSetXRep(CNlEqState &state, const bool needxrep) {

  state.m_xrep = needxrep;
}

static void CNlEq::NlEqSetStpMax(CNlEqState &state, const double stpmax) {

  if (!CAp::Assert(CMath::IsFinite(stpmax),
                   __FUNCTION__ + ": StpMax is not finite!"))
    return;

  if (!CAp::Assert(stpmax >= 0.0, __FUNCTION__ + ": StpMax<0!"))
    return;

  state.m_stpmax = stpmax;
}

static void CNlEq::NlEqResults(CNlEqState &state, double &x[],
                               CNlEqReport &rep) {
  ArrayResizeAL(x, 0);

  NlEqResultsBuf(state, x, rep);
}

static void CNlEq::NlEqResultsBuf(CNlEqState &state, double &x[],
                                  CNlEqReport &rep) {

  int i_ = 0;

  if (CAp::Len(x) < state.m_n)
    ArrayResizeAL(x, state.m_n);

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    x[i_] = state.m_xbase[i_];

  rep.m_iterationscount = state.m_repiterationscount;
  rep.m_nfunc = state.m_repnfunc;
  rep.m_njac = state.m_repnjac;
  rep.m_terminationtype = state.m_repterminationtype;
}

static void CNlEq::NlEqRestartFrom(CNlEqState &state, double &x[]) {

  int i_ = 0;

  if (!CAp::Assert(CAp::Len(x) >= state.m_n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, state.m_n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    state.m_x[i_] = x[i_];

  ArrayResizeAL(state.m_rstate.ia, 3);
  ArrayResizeAL(state.m_rstate.ba, 1);
  ArrayResizeAL(state.m_rstate.ra, 6);
  state.m_rstate.stage = -1;

  ClearRequestFields(state);
}

static void CNlEq::ClearRequestFields(CNlEqState &state) {

  state.m_needf = false;
  state.m_needfij = false;
  state.m_xupdated = false;
}

static bool CNlEq::IncreaseLambda(double &lambdav, double &nu,
                                  const double lambdaup) {

  double lnlambda = 0;
  double lnnu = 0;
  double lnlambdaup = 0;
  double lnmax = 0;

  lnlambda = MathLog(lambdav);
  lnlambdaup = MathLog(lambdaup);
  lnnu = MathLog(nu);
  lnmax = 0.5 * MathLog(CMath::m_maxrealnumber);

  if (lnlambda + lnlambdaup + lnnu > lnmax)
    return (false);

  if (lnnu + MathLog(2) > lnmax)
    return (false);

  lambdav = lambdav * lambdaup * nu;
  nu = nu * 2;

  return (true);
}

static void CNlEq::DecreaseLambda(double &lambdav, double &nu,
                                  const double lambdadown) {

  nu = 1;

  if (MathLog(lambdav) + MathLog(lambdadown) < MathLog(CMath::m_minrealnumber))
    lambdav = CMath::m_minrealnumber;
  else
    lambdav = lambdav * lambdadown;
}

static bool CNlEq::NlEqIteration(CNlEqState &state) {

  int n = 0;
  int m = 0;
  int i = 0;
  double lambdaup = 0;
  double lambdadown = 0;
  double lambdav = 0;
  double rho = 0;
  double mu = 0;
  double stepnorm = 0;
  bool b;
  int i_ = 0;
  int temp;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    m = state.m_rstate.ia[1];
    i = state.m_rstate.ia[2];
    b = state.m_rstate.ba[0];
    lambdaup = state.m_rstate.ra[0];
    lambdadown = state.m_rstate.ra[1];
    lambdav = state.m_rstate.ra[2];
    rho = state.m_rstate.ra[3];
    mu = state.m_rstate.ra[4];
    stepnorm = state.m_rstate.ra[5];
  } else {

    n = -983;
    m = -989;
    i = -834;
    b = false;
    lambdaup = -287;
    lambdadown = 364;
    lambdav = 214;
    rho = -338;
    mu = -686;
    stepnorm = 912;
  }

  if (state.m_rstate.stage == 0) {

    state.m_needf = false;
    state.m_repnfunc = state.m_repnfunc + 1;

    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_xbase[i_] = state.m_x[i_];

    state.m_fbase = state.m_f;
    state.m_fprev = CMath::m_maxrealnumber;

    if (!state.m_xrep) {

      if (!Func_lbl_5(state, lambdaup, lambdadown, lambdav, rho))
        return (false);

      Func_lbl_7(state, n);

      Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                     stepnorm);

      return (true);
    }

    ClearRequestFields(state);
    state.m_xupdated = true;
    state.m_rstate.stage = 1;

    Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                   stepnorm);

    return (true);
  }

  if (state.m_rstate.stage == 1) {

    state.m_xupdated = false;

    if (!Func_lbl_5(state, lambdaup, lambdadown, lambdav, rho))
      return (false);

    Func_lbl_7(state, n);

    Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                   stepnorm);

    return (true);
  }

  if (state.m_rstate.stage == 2) {

    state.m_needfij = false;
    state.m_repnfunc = state.m_repnfunc + 1;
    state.m_repnjac = state.m_repnjac + 1;

    CAblas::RMatrixMVect(n, m, state.m_j, 0, 0, 1, state.m_fi, 0,
                         state.m_rightpart, 0);
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_rightpart[i_] = -1 * state.m_rightpart[i_];

    temp = Func_lbl_9(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                      stepnorm);

    if (temp == -1)
      return (false);

    if (temp == 1)
      return (true);

    Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                   stepnorm);

    return (true);
  }

  if (state.m_rstate.stage == 3) {

    state.m_needf = false;
    state.m_repnfunc = state.m_repnfunc + 1;

    if (state.m_f < state.m_fbase) {

      DecreaseLambda(lambdav, rho, lambdadown);
      temp = Func_lbl_10(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho,
                         mu, stepnorm);

      if (temp == -1)
        return (false);

      if (temp == 1)
        return (true);

      Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                     stepnorm);

      return (true);
    }

    if (!IncreaseLambda(lambdav, rho, lambdaup)) {

      stepnorm = 0;
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_x[i_] = state.m_xbase[i_];
      state.m_f = state.m_fbase;
      temp = Func_lbl_10(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho,
                         mu, stepnorm);

      if (temp == -1)
        return (false);

      if (temp == 1)
        return (true);

      Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                     stepnorm);

      return (true);
    }
    temp = Func_lbl_9(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                      stepnorm);

    if (temp == -1)
      return (false);

    if (temp == 1)
      return (true);

    Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                   stepnorm);

    return (true);
  }

  if (state.m_rstate.stage == 4) {

    state.m_xupdated = false;

    if (!Func_lbl_11(state, stepnorm))
      return (false);

    Func_lbl_7(state, n);

    Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                   stepnorm);

    return (true);
  }

  n = state.m_n;
  m = state.m_m;
  state.m_repterminationtype = 0;
  state.m_repiterationscount = 0;
  state.m_repnfunc = 0;
  state.m_repnjac = 0;

  ClearRequestFields(state);
  state.m_needf = true;
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                 stepnorm);

  return (true);
}

static void CNlEq::Func_lbl_rcomm(CNlEqState &state, const int n, const int m,
                                  const int i, const bool b,
                                  const double lambdaup,
                                  const double lambdadown, const double lambdav,
                                  const double rho, const double mu,
                                  const double stepnorm) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ia[1] = m;
  state.m_rstate.ia[2] = i;
  state.m_rstate.ba[0] = b;
  state.m_rstate.ra[0] = lambdaup;
  state.m_rstate.ra[1] = lambdadown;
  state.m_rstate.ra[2] = lambdav;
  state.m_rstate.ra[3] = rho;
  state.m_rstate.ra[4] = mu;
  state.m_rstate.ra[5] = stepnorm;
}

static void CNlEq::Func_lbl_7(CNlEqState &state, const int n) {

  ClearRequestFields(state);
  state.m_needfij = true;

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  state.m_rstate.stage = 2;
}

static bool CNlEq::Func_lbl_5(CNlEqState &state, double &lambdaup,
                              double &lambdadown, double &lambdav,
                              double &rho) {

  if (state.m_f <= CMath::Sqr(state.m_epsf)) {
    state.m_repterminationtype = 1;
    return (false);
  }

  lambdaup = 10;
  lambdadown = 0.3;
  lambdav = 0.001;
  rho = 1;

  return (true);
}

static bool CNlEq::Func_lbl_11(CNlEqState &state, const double stepnorm) {

  if (MathSqrt(state.m_f) <= state.m_epsf)
    state.m_repterminationtype = 1;

  if (stepnorm == 0.0 && state.m_repterminationtype == 0)
    state.m_repterminationtype = -4;

  if (state.m_repiterationscount >= state.m_maxits && state.m_maxits > 0)
    state.m_repterminationtype = 5;

  if (state.m_repterminationtype != 0)
    return (false);

  return (true);
}

static int CNlEq::Func_lbl_10(CNlEqState &state, const int n, const int m,
                              const int i, const bool b, const double lambdaup,
                              const double lambdadown, const double lambdav,
                              const double rho, const double mu,
                              const double stepnorm) {

  state.m_fbase = state.m_f;
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xbase[i_] = state.m_xbase[i_] + stepnorm * state.m_candstep[i_];
  state.m_repiterationscount = state.m_repiterationscount + 1;

  if (!state.m_xrep) {

    if (!Func_lbl_11(state, stepnorm))
      return (-1);

    Func_lbl_7(state, n);

    Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                   stepnorm);

    return (1);
  }

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_f = state.m_fbase;

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  state.m_rstate.stage = 4;

  return (0);
}

static int CNlEq::Func_lbl_9(CNlEqState &state, int &n, int &m, int &i, bool &b,
                             const double lambdaup, const double lambdadown,
                             double &lambdav, const double rho, const double mu,
                             double &stepnorm) {

  for (i = 0; i <= n - 1; i++)
    state.m_candstep[i] = 0;

  CFbls::FblsSolveCGx(state.m_j, m, n, lambdav, state.m_rightpart,
                      state.m_candstep, state.m_cgbuf);

  stepnorm = 0;
  for (i = 0; i <= n - 1; i++) {

    if (state.m_candstep[i] != 0.0) {
      stepnorm = 1;
      break;
    }
  }
  CLinMin::LinMinNormalized(state.m_candstep, stepnorm, n);

  if (state.m_stpmax != 0.0)
    stepnorm = MathMin(stepnorm, state.m_stpmax);

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_x[i_] + stepnorm * state.m_candstep[i_];
  b = true;
  for (i = 0; i <= n - 1; i++) {

    if (state.m_x[i] != state.m_xbase[i]) {
      b = false;
      break;
    }
  }

  if (b) {

    stepnorm = 0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_x[i_] = state.m_xbase[i_];
    state.m_f = state.m_fbase;

    int temp = Func_lbl_10(state, n, m, i, b, lambdaup, lambdadown, lambdav,
                           rho, mu, stepnorm);

    if (temp != 0)
      return (temp);

    Func_lbl_rcomm(state, n, m, i, b, lambdaup, lambdadown, lambdav, rho, mu,
                   stepnorm);

    return (1);
  }

  ClearRequestFields(state);

  state.m_needf = true;
  state.m_rstate.stage = 3;

  return (0);
}

#endif
