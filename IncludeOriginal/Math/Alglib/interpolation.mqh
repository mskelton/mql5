#ifndef INTERPOLATION_H
#define INTERPOLATION_H

#include "alglibmisc.mqh"
#include "integration.mqh"
#include "optimization.mqh"
#include "solvers.mqh"

class CIDWInterpolant {
public:
  int m_n;
  int m_nx;
  int m_d;
  double m_r;
  int m_nw;
  CKDTree m_tree;
  int m_modeltype;
  int m_debugsolverfailures;
  double m_debugworstrcond;
  double m_debugbestrcond;

  double m_xbuf[];
  int m_tbuf[];
  double m_rbuf[];

  CMatrixDouble m_q;
  CMatrixDouble m_xybuf;

public:
  CIDWInterpolant(void);
  ~CIDWInterpolant(void);

  void Copy(CIDWInterpolant &obj);
};

CIDWInterpolant::CIDWInterpolant(void) {}

CIDWInterpolant::~CIDWInterpolant(void) {}

void CIDWInterpolant::Copy(CIDWInterpolant &obj) {

  m_n = obj.m_n;
  m_nx = obj.m_nx;
  m_d = obj.m_d;
  m_r = obj.m_r;
  m_nw = obj.m_nw;
  m_modeltype = obj.m_modeltype;
  m_debugsolverfailures = obj.m_debugsolverfailures;
  m_debugworstrcond = obj.m_debugworstrcond;
  m_debugbestrcond = obj.m_debugbestrcond;
  m_tree.Copy(obj.m_tree);

  ArrayCopy(m_xbuf, obj.m_xbuf);
  ArrayCopy(m_tbuf, obj.m_tbuf);
  ArrayCopy(m_rbuf, obj.m_rbuf);

  m_q = obj.m_q;
  m_xybuf = obj.m_xybuf;
}

class CIDWInterpolantShell {
private:
  CIDWInterpolant m_innerobj;

public:
  CIDWInterpolantShell(void);
  CIDWInterpolantShell(CIDWInterpolant &obj);
  ~CIDWInterpolantShell(void);

  CIDWInterpolant *GetInnerObj(void);
};

CIDWInterpolantShell::CIDWInterpolantShell(void) {}

CIDWInterpolantShell::CIDWInterpolantShell(CIDWInterpolant &obj) {

  m_innerobj.Copy(obj);
}

CIDWInterpolantShell::~CIDWInterpolantShell(void) {}

CIDWInterpolant *CIDWInterpolantShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CIDWInt {
private:
  static double IDWCalcQ(CIDWInterpolant &z, double &x[], const int k);
  static void IDWInit1(const int n, const int nx, const int d, int nq, int nw,
                       CIDWInterpolant &z);
  static void IDWInternalSolver(double &y[], double &w[],
                                CMatrixDouble &fmatrix, double &temp[],
                                const int n, const int m, int &info,
                                double &x[], double &taskrcond);

public:
  static const double m_idwqfactor;
  static const int m_idwkmin;

  CIDWInt(void);
  ~CIDWInt(void);

  static double IDWCalc(CIDWInterpolant &z, double &x[]);
  static void IDWBuildModifiedShepard(CMatrixDouble &xy, const int n,
                                      const int nx, const int d, int nq, int nw,
                                      CIDWInterpolant &z);
  static void IDWBuildModifiedShepardR(CMatrixDouble &xy, const int n,
                                       const int nx, const double r,
                                       CIDWInterpolant &z);
  static void IDWBuildNoisy(CMatrixDouble &xy, const int n, const int nx,
                            const int d, int nq, int nw, CIDWInterpolant &z);
};

const double CIDWInt::m_idwqfactor = 1.5;
const int CIDWInt::m_idwkmin = 5;

CIDWInt::CIDWInt(void) {}

CIDWInt::~CIDWInt(void) {}

static double CIDWInt::IDWCalc(CIDWInterpolant &z, double &x[]) {

  double result = 0;
  int nx = 0;
  int i = 0;
  int k = 0;
  double r = 0;
  double s = 0;
  double w = 0;
  double v1 = 0;
  double v2 = 0;
  double d0 = 0;
  double di = 0;

  k = 0;

  if (z.m_modeltype == 0) {

    nx = z.m_nx;
    k = CNearestNeighbor::KDTreeQueryKNN(z.m_tree, x, z.m_nw, true);

    CNearestNeighbor::KDTreeQueryResultsDistances(z.m_tree, z.m_rbuf);

    CNearestNeighbor::KDTreeQueryResultsTags(z.m_tree, z.m_tbuf);
  }
  if (z.m_modeltype == 1) {

    nx = z.m_nx;
    k = CNearestNeighbor::KDTreeQueryRNN(z.m_tree, x, z.m_r, true);

    CNearestNeighbor::KDTreeQueryResultsDistances(z.m_tree, z.m_rbuf);

    CNearestNeighbor::KDTreeQueryResultsTags(z.m_tree, z.m_tbuf);
    if (k < m_idwkmin) {

      k = CNearestNeighbor::KDTreeQueryKNN(z.m_tree, x, m_idwkmin, true);

      CNearestNeighbor::KDTreeQueryResultsDistances(z.m_tree, z.m_rbuf);

      CNearestNeighbor::KDTreeQueryResultsTags(z.m_tree, z.m_tbuf);
    }
  }

  r = z.m_rbuf[k - 1];
  d0 = z.m_rbuf[0];
  result = 0;
  s = 0;
  for (i = 0; i <= k - 1; i++) {
    di = z.m_rbuf[i];

    if (di == d0) {

      w = 1;
    } else {

      v1 = (r - di) / (r - d0);
      v2 = d0 / di;
      w = CMath::Sqr(v1 * v2);
    }

    result = result + w * IDWCalcQ(z, x, z.m_tbuf[i]);
    s = s + w;
  }

  return (result / s);
}

static void CIDWInt::IDWBuildModifiedShepard(CMatrixDouble &xy, const int n,
                                             const int nx, const int d, int nq,
                                             int nw, CIDWInterpolant &z) {

  int i = 0;
  int j = 0;
  int k = 0;
  int j2 = 0;
  int j3 = 0;
  double v = 0;
  double r = 0;
  double s = 0;
  double d0 = 0;
  double di = 0;
  double v1 = 0;
  double v2 = 0;
  int nc = 0;
  int offs = 0;
  int info = 0;
  double taskrcond = 0;
  int i_ = 0;

  double x[];
  double qrbuf[];
  double y[];
  double w[];
  double qsol[];
  double temp[];
  int tags[];

  CMatrixDouble qxybuf;
  CMatrixDouble fmatrix;

  nc = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(nx >= 1, __FUNCTION__ + ": NX<1!"))
    return;

  if (!CAp::Assert(d >= -1 && d <= 2,
                   __FUNCTION__ + ": D<>-1 and D<>0 and D<>1 and D<>2!"))
    return;

  if (d == 1) {
    nq = MathMax(nq, (int)MathCeil(m_idwqfactor * (1 + nx)) + 1);
    nq = MathMax(nq, (int)MathRound(MathPow(2, nx)) + 1);
  }

  if (d == 2) {
    nq = MathMax(nq, (int)MathCeil(m_idwqfactor * (nx + 2) * (nx + 1) / 2) + 1);
    nq = MathMax(nq, (int)MathRound(MathPow(2, nx)) + 1);
  }

  nw = MathMax(nw, (int)MathRound(MathPow(2, nx)) + 1);
  nq = MathMin(nq, n);
  nw = MathMin(nw, n);

  IDWInit1(n, nx, d, nq, nw, z);
  z.m_modeltype = 0;

  ArrayResizeAL(tags, n);
  for (i = 0; i <= n - 1; i++)
    tags[i] = i;

  CNearestNeighbor::KDTreeBuildTagged(xy, tags, n, nx, 1, 2, z.m_tree);

  ArrayResizeAL(temp, nq + 1);
  ArrayResizeAL(x, nx);
  ArrayResizeAL(qrbuf, nq);
  qxybuf.Resize(nq, nx + 1);

  if (d == -1)
    ArrayResizeAL(w, nq);

  if (d == 1) {

    ArrayResizeAL(y, nq);
    ArrayResizeAL(w, nq);
    ArrayResizeAL(qsol, nx);

    fmatrix.Resize(nq, nx + 1);
  }

  if (d == 2) {

    ArrayResizeAL(y, nq);
    ArrayResizeAL(w, nq);
    ArrayResizeAL(qsol, nx + (int)MathRound(nx * (nx + 1) * 0.5));

    fmatrix.Resize(nq, nx + (int)MathRound(nx * (nx + 1) * 0.5) + 1);
  }
  for (i = 0; i <= n - 1; i++) {

    for (i_ = 0; i_ <= nx; i_++)
      z.m_q[i].Set(i_, xy[i][i_]);

    if (d == 0)
      continue;

    for (i_ = 0; i_ <= nx - 1; i_++)
      x[i_] = xy[i][i_];
    k = CNearestNeighbor::KDTreeQueryKNN(z.m_tree, x, nq, false);

    CNearestNeighbor::KDTreeQueryResultsXY(z.m_tree, qxybuf);

    CNearestNeighbor::KDTreeQueryResultsDistances(z.m_tree, qrbuf);
    r = qrbuf[k - 1];
    d0 = qrbuf[0];

    for (j = 0; j <= k - 1; j++) {
      di = qrbuf[j];

      if (di == d0) {

        w[j] = 1;
      } else {

        v1 = (r - di) / (r - d0);
        v2 = d0 / di;
        w[j] = CMath::Sqr(v1 * v2);
      }
    }

    if (d == -1) {

      for (j = 0; j <= nx - 1; j++)
        x[j] = 0;
      s = 0;

      for (j = 0; j <= k - 1; j++) {

        v = 0;
        for (j2 = 0; j2 <= nx - 1; j2++)
          v = v + CMath::Sqr(qxybuf[j][j2] - xy[i][j2]);

        if (v != 0.0) {
          for (j2 = 0; j2 <= nx - 1; j2++)
            x[j2] = x[j2] + w[j] * (qxybuf[j][nx] - xy[i][nx]) *
                                (qxybuf[j][j2] - xy[i][j2]) / v;
        }
        s = s + w[j];
      }
      for (j = 0; j <= nx - 1; j++)
        z.m_q[i].Set(nx + 1 + j, x[j] / s);
    } else {

      if (d == 1) {

        for (j = 0; j <= k - 1; j++) {
          for (j2 = 0; j2 <= nx - 1; j2++)
            fmatrix[j].Set(j2, qxybuf[j][j2] - xy[i][j2]);
          y[j] = qxybuf[j][nx] - xy[i][nx];
        }
        nc = nx;
      }

      if (d == 2) {

        for (j = 0; j <= k - 1; j++) {
          offs = 0;
          for (j2 = 0; j2 <= nx - 1; j2++) {
            fmatrix[j].Set(offs, qxybuf[j][j2] - xy[i][j2]);
            offs = offs + 1;
          }

          for (j2 = 0; j2 <= nx - 1; j2++) {
            for (j3 = j2; j3 <= nx - 1; j3++) {
              fmatrix[j].Set(offs, (qxybuf[j][j2] - xy[i][j2]) *
                                       (qxybuf[j][j3] - xy[i][j3]));
              offs = offs + 1;
            }
          }
          y[j] = qxybuf[j][nx] - xy[i][nx];
        }
        nc = nx + (int)MathRound(nx * (nx + 1) * 0.5);
      }

      IDWInternalSolver(y, w, fmatrix, temp, k, nc, info, qsol, taskrcond);

      if (info > 0) {

        z.m_debugworstrcond = MathMin(z.m_debugworstrcond, taskrcond);
        z.m_debugbestrcond = MathMax(z.m_debugbestrcond, taskrcond);
        for (j = 0; j <= nc - 1; j++)
          z.m_q[i].Set(nx + 1 + j, qsol[j]);
      } else {

        z.m_debugsolverfailures = z.m_debugsolverfailures + 1;
        for (j = 0; j <= nc - 1; j++)
          z.m_q[i].Set(nx + 1 + j, 0);
      }
    }
  }
}

static void CIDWInt::IDWBuildModifiedShepardR(CMatrixDouble &xy, const int n,
                                              const int nx, const double r,
                                              CIDWInterpolant &z) {

  int i = 0;
  int i_ = 0;

  int tags[];

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(nx >= 1, __FUNCTION__ + ": NX<1!"))
    return;

  if (!CAp::Assert(r > 0.0, __FUNCTION__ + ": R<=0!"))
    return;

  IDWInit1(n, nx, 0, 0, n, z);
  z.m_modeltype = 1;
  z.m_r = r;

  ArrayResizeAL(tags, n);
  for (i = 0; i <= n - 1; i++)
    tags[i] = i;

  CNearestNeighbor::KDTreeBuildTagged(xy, tags, n, nx, 1, 2, z.m_tree);

  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= nx; i_++)
      z.m_q[i].Set(i_, xy[i][i_]);
  }
}

static void CIDWInt::IDWBuildNoisy(CMatrixDouble &xy, const int n, const int nx,
                                   const int d, int nq, int nw,
                                   CIDWInterpolant &z) {

  int i = 0;
  int j = 0;
  int k = 0;
  int j2 = 0;
  int j3 = 0;
  double v = 0;
  int nc = 0;
  int offs = 0;
  double taskrcond = 0;
  int info = 0;
  int i_ = 0;

  double x[];
  double qrbuf[];
  double y[];
  double w[];
  double qsol[];
  int tags[];
  double temp[];

  CMatrixDouble qxybuf;
  CMatrixDouble fmatrix;

  nc = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(nx >= 1, __FUNCTION__ + ": NX<1!"))
    return;

  if (!CAp::Assert(d >= 1 && d <= 2, __FUNCTION__ + ": D<>1 and D<>2!"))
    return;

  if (d == 1)
    nq = MathMax(nq, (int)MathCeil(m_idwqfactor * (1 + nx)) + 1);

  if (d == 2)
    nq = MathMax(nq, (int)MathCeil(m_idwqfactor * (nx + 2) * (nx + 1) / 2) + 1);

  nw = MathMax(nw, (int)MathRound(MathPow(2, nx)) + 1);
  nq = MathMin(nq, n);
  nw = MathMin(nw, n);

  IDWInit1(n, nx, d, nq, nw, z);
  z.m_modeltype = 0;

  ArrayResizeAL(tags, n);
  for (i = 0; i <= n - 1; i++)
    tags[i] = i;

  CNearestNeighbor::KDTreeBuildTagged(xy, tags, n, nx, 1, 2, z.m_tree);

  ArrayResizeAL(temp, nq + 1);
  ArrayResizeAL(x, nx);
  ArrayResizeAL(qrbuf, nq);
  qxybuf.Resize(nq, nx + 1);

  if (d == 1) {

    ArrayResizeAL(y, nq);
    ArrayResizeAL(w, nq);
    ArrayResizeAL(qsol, 1 + nx);

    fmatrix.Resize(nq, 1 + nx + 1);
  }

  if (d == 2) {

    ArrayResizeAL(y, nq);
    ArrayResizeAL(w, nq);
    ArrayResizeAL(qsol, 1 + nx + (int)MathRound(nx * (nx + 1) * 0.5));

    fmatrix.Resize(nq, 1 + nx + (int)MathRound(nx * (nx + 1) * 0.5) + 1);
  }

  for (i = 0; i <= n - 1; i++) {

    for (i_ = 0; i_ <= nx - 1; i_++)
      z.m_q[i].Set(i_, xy[i][i_]);

    for (i_ = 0; i_ <= nx - 1; i_++)
      x[i_] = xy[i][i_];
    k = CNearestNeighbor::KDTreeQueryKNN(z.m_tree, x, nq, true);

    CNearestNeighbor::KDTreeQueryResultsXY(z.m_tree, qxybuf);

    CNearestNeighbor::KDTreeQueryResultsDistances(z.m_tree, qrbuf);

    if (d == 1) {

      for (j = 0; j <= k - 1; j++) {
        fmatrix[j].Set(0, 1.0);
        for (j2 = 0; j2 <= nx - 1; j2++)
          fmatrix[j].Set(1 + j2, qxybuf[j][j2] - xy[i][j2]);

        y[j] = qxybuf[j][nx];
        w[j] = 1;
      }
      nc = 1 + nx;
    }

    if (d == 2) {

      for (j = 0; j <= k - 1; j++) {
        fmatrix[j].Set(0, 1);
        offs = 1;
        for (j2 = 0; j2 <= nx - 1; j2++) {
          fmatrix[j].Set(offs, qxybuf[j][j2] - xy[i][j2]);
          offs = offs + 1;
        }

        for (j2 = 0; j2 <= nx - 1; j2++) {
          for (j3 = j2; j3 <= nx - 1; j3++) {
            fmatrix[j].Set(offs, (qxybuf[j][j2] - xy[i][j2]) *
                                     (qxybuf[j][j3] - xy[i][j3]));
            offs = offs + 1;
          }
        }

        y[j] = qxybuf[j][nx];
        w[j] = 1;
      }
      nc = 1 + nx + (int)MathRound(nx * (nx + 1) * 0.5);
    }

    IDWInternalSolver(y, w, fmatrix, temp, k, nc, info, qsol, taskrcond);

    if (info > 0) {

      z.m_debugworstrcond = MathMin(z.m_debugworstrcond, taskrcond);
      z.m_debugbestrcond = MathMax(z.m_debugbestrcond, taskrcond);
      for (j = 0; j <= nc - 1; j++)
        z.m_q[i].Set(nx + j, qsol[j]);
    } else {

      z.m_debugsolverfailures = z.m_debugsolverfailures + 1;
      v = 0;
      for (j = 0; j <= k - 1; j++)
        v = v + qxybuf[j][nx];
      z.m_q[i].Set(nx, v / k);
      for (j = 0; j <= nc - 2; j++)
        z.m_q[i].Set(nx + 1 + j, 0);
    }
  }
}

static double CIDWInt::IDWCalcQ(CIDWInterpolant &z, double &x[], const int k) {

  double result = 0;
  int nx = 0;
  int i = 0;
  int j = 0;
  int offs = 0;

  nx = z.m_nx;

  result = z.m_q[k][nx];

  if (z.m_d >= 1) {
    for (i = 0; i <= nx - 1; i++)
      result = result + z.m_q[k][nx + 1 + i] * (x[i] - z.m_q[k][i]);
  }

  if (z.m_d >= 2) {
    offs = nx + 1 + nx;
    for (i = 0; i <= nx - 1; i++) {
      for (j = i; j <= nx - 1; j++) {
        result = result +
                 z.m_q[k][offs] * (x[i] - z.m_q[k][i]) * (x[j] - z.m_q[k][j]);
        offs = offs + 1;
      }
    }
  }

  return (result);
}

static void CIDWInt::IDWInit1(const int n, const int nx, const int d, int nq,
                              int nw, CIDWInterpolant &z) {

  z.m_debugsolverfailures = 0;
  z.m_debugworstrcond = 1.0;
  z.m_debugbestrcond = 0;
  z.m_n = n;
  z.m_nx = nx;
  z.m_d = 0;

  if (d == 1)
    z.m_d = 1;

  if (d == 2)
    z.m_d = 2;

  if (d == -1)
    z.m_d = 1;
  z.m_nw = nw;

  if (d == -1)
    z.m_q.Resize(n, 2 * nx + 1);

  if (d == 0)
    z.m_q.Resize(n, nx + 1);

  if (d == 1)
    z.m_q.Resize(n, 2 * nx + 1);

  if (d == 2)
    z.m_q.Resize(n, nx + 1 + nx + (int)MathRound(nx * (nx + 1) * 0.5));

  ArrayResizeAL(z.m_tbuf, nw);
  ArrayResizeAL(z.m_rbuf, nw);
  z.m_xybuf.Resize(nw, nx + 1);
  ArrayResizeAL(z.m_xbuf, nx);
}

static void CIDWInt::IDWInternalSolver(double &y[], double &w[],
                                       CMatrixDouble &fmatrix, double &temp[],
                                       const int n, const int m, int &info,
                                       double &x[], double &taskrcond) {

  int i = 0;
  int j = 0;
  double v = 0;
  double tau = 0;
  int i_ = 0;
  int i1_ = 0;

  double b[];

  CDenseSolverLSReport srep;

  info = 1;

  for (i = 0; i <= n - 1; i++) {
    fmatrix[i].Set(m, y[i]);
    v = w[i];
    for (i_ = 0; i_ <= m; i_++)
      fmatrix[i].Set(i_, v * fmatrix[i][i_]);
  }

  if (m <= n) {

    for (i = 0; i <= m - 1; i++) {

      if (i < n - 1) {
        i1_ = i - 1;
        for (i_ = 1; i_ <= n - i; i_++)
          temp[i_] = fmatrix[i_ + i1_][i];

        CReflections::GenerateReflection(temp, n - i, tau);

        fmatrix[i].Set(i, temp[1]);
        temp[1] = 1;

        for (j = i + 1; j <= m; j++) {
          i1_ = 1 - i;
          v = 0.0;
          for (i_ = i; i_ <= n - 1; i_++)
            v += fmatrix[i_][j] * temp[i_ + i1_];

          v = tau * v;
          i1_ = 1 - i;
          for (i_ = i; i_ <= n - 1; i_++)
            fmatrix[i_].Set(j, fmatrix[i_][j] - v * temp[i_ + i1_]);
        }
      }
    }

    taskrcond = CRCond::RMatrixTrRCondInf(fmatrix, m, true, false);

    if (taskrcond > 10000 * n * CMath::m_machineepsilon) {

      x[m - 1] = fmatrix[m - 1][m] / fmatrix[m - 1][m - 1];
      for (i = m - 2; i >= 0; i--) {
        v = 0.0;
        for (i_ = i + 1; i_ <= m - 1; i_++)
          v += fmatrix[i][i_] * x[i_];
        x[i] = (fmatrix[i][m] - v) / fmatrix[i][i];
      }
    } else {

      ArrayResizeAL(b, m);
      for (i = 0; i <= m - 1; i++) {
        for (j = 0; j <= i - 1; j++)
          fmatrix[i].Set(j, 0.0);
        b[i] = fmatrix[i][m];
      }

      CDenseSolver::RMatrixSolveLS(
          fmatrix, m, m, b, 10000 * CMath::m_machineepsilon, info, srep, x);
    }
  } else {

    ArrayResizeAL(b, n);
    for (i = 0; i <= n - 1; i++)
      b[i] = fmatrix[i][m];

    CDenseSolver::RMatrixSolveLS(
        fmatrix, n, m, b, 10000 * CMath::m_machineepsilon, info, srep, x);
    taskrcond = srep.m_r2;
  }
}

class CBarycentricInterpolant {
public:
  int m_n;
  double m_sy;

  double m_x[];
  double m_y[];
  double m_w[];

  CBarycentricInterpolant(void);
  ~CBarycentricInterpolant(void);

  void Copy(CBarycentricInterpolant &obj);
};

CBarycentricInterpolant::CBarycentricInterpolant(void) {}

CBarycentricInterpolant::~CBarycentricInterpolant(void) {}

void CBarycentricInterpolant::Copy(CBarycentricInterpolant &obj) {

  m_n = obj.m_n;
  m_sy = obj.m_sy;

  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_y, obj.m_y);
  ArrayCopy(m_w, obj.m_w);
}

class CBarycentricInterpolantShell {
private:
  CBarycentricInterpolant m_innerobj;

public:
  CBarycentricInterpolantShell(void);
  CBarycentricInterpolantShell(CBarycentricInterpolant &obj);
  ~CBarycentricInterpolantShell(void);

  CBarycentricInterpolant *GetInnerObj(void);
};

CBarycentricInterpolantShell::CBarycentricInterpolantShell(void) {}

CBarycentricInterpolantShell::CBarycentricInterpolantShell(
    CBarycentricInterpolant &obj) {

  m_innerobj.Copy(obj);
}

CBarycentricInterpolantShell::~CBarycentricInterpolantShell(void) {}

CBarycentricInterpolant *CBarycentricInterpolantShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CRatInt {
private:
  static void BarycentricNormalize(CBarycentricInterpolant &b);

public:
  CRatInt(void);
  ~CRatInt(void);

  static double BarycentricCalc(CBarycentricInterpolant &b, const double t);
  static void BarycentricDiff1(CBarycentricInterpolant &b, double t, double &f,
                               double &df);
  static void BarycentricDiff2(CBarycentricInterpolant &b, const double t,
                               double &f, double &df, double &d2f);
  static void BarycentricLinTransX(CBarycentricInterpolant &b, const double ca,
                                   const double cb);
  static void BarycentricLinTransY(CBarycentricInterpolant &b, const double ca,
                                   const double cb);
  static void BarycentricUnpack(CBarycentricInterpolant &b, int &n, double &x[],
                                double &y[], double &w[]);
  static void BarycentricBuildXYW(double &x[], double &y[], double &w[],
                                  const int n, CBarycentricInterpolant &b);
  static void BarycentricBuildFloaterHormann(double &x[], double &y[],
                                             const int n, int d,
                                             CBarycentricInterpolant &b);
  static void BarycentricCopy(CBarycentricInterpolant &b,
                              CBarycentricInterpolant &b2);
};

CRatInt::CRatInt(void) {}

CRatInt::~CRatInt(void) {}

static double CRatInt::BarycentricCalc(CBarycentricInterpolant &b,
                                       const double t) {

  double s1 = 0;
  double s2 = 0;
  double s = 0;
  double v = 0;
  int i = 0;

  if (!CAp::Assert(!CInfOrNaN::IsInfinity(t), __FUNCTION__ + ": infinite T!"))
    return (EMPTY_VALUE);

  if (CInfOrNaN::IsNaN(t))
    return (CInfOrNaN::NaN());

  if (b.m_n == 1)
    return (b.m_sy * b.m_y[0]);

  s = MathAbs(t - b.m_x[0]);
  for (i = 0; i <= b.m_n - 1; i++) {
    v = b.m_x[i];

    if (v == (double)(t))
      return (b.m_sy * b.m_y[i]);
    v = MathAbs(t - v);

    if (v < s)
      s = v;
  }

  s1 = 0;
  s2 = 0;

  for (i = 0; i <= b.m_n - 1; i++) {
    v = s / (t - b.m_x[i]);
    v = v * b.m_w[i];
    s1 = s1 + v * b.m_y[i];
    s2 = s2 + v;
  }

  return (b.m_sy * s1 / s2);
}

static void CRatInt::BarycentricDiff1(CBarycentricInterpolant &b, double t,
                                      double &f, double &df) {

  double v = 0;
  double vv = 0;
  int i = 0;
  int k = 0;
  double n0 = 0;
  double n1 = 0;
  double d0 = 0;
  double d1 = 0;
  double s0 = 0;
  double s1 = 0;
  double xk = 0;
  double xi = 0;
  double xmin = 0;
  double xmax = 0;
  double xscale1 = 0;
  double xoffs1 = 0;
  double xscale2 = 0;
  double xoffs2 = 0;
  double xprev = 0;

  f = 0;
  df = 0;

  if (!CAp::Assert(!CInfOrNaN::IsInfinity(t), __FUNCTION__ + ": infinite T!"))
    return;

  if (CInfOrNaN::IsNaN(t)) {

    f = CInfOrNaN::NaN();
    df = CInfOrNaN::NaN();

    return;
  }

  if (b.m_n == 1) {

    f = b.m_sy * b.m_y[0];
    df = 0;

    return;
  }

  if (b.m_sy == 0.0) {

    f = 0;
    df = 0;

    return;
  }

  if (!CAp::Assert(b.m_sy > 0.0, __FUNCTION__ + ": internal error"))
    return;

  v = MathAbs(b.m_x[0] - t);
  k = 0;
  xmin = b.m_x[0];
  xmax = b.m_x[0];

  for (i = 1; i <= b.m_n - 1; i++) {
    vv = b.m_x[i];

    if (MathAbs(vv - t) < v) {
      v = MathAbs(vv - t);
      k = i;
    }

    xmin = MathMin(xmin, vv);
    xmax = MathMax(xmax, vv);
  }

  xscale1 = 1 / (xmax - xmin);
  xoffs1 = -(xmin / (xmax - xmin)) + 1;
  xscale2 = 2;
  xoffs2 = -3;
  t = t * xscale1 + xoffs1;
  t = t * xscale2 + xoffs2;
  xk = b.m_x[k];
  xk = xk * xscale1 + xoffs1;
  xk = xk * xscale2 + xoffs2;
  v = t - xk;
  n0 = 0;
  n1 = 0;
  d0 = 0;
  d1 = 0;
  xprev = -2;

  for (i = 0; i <= b.m_n - 1; i++) {

    xi = b.m_x[i];
    xi = xi * xscale1 + xoffs1;
    xi = xi * xscale2 + xoffs2;

    if (!CAp::Assert(xi > xprev, __FUNCTION__ + ": points are too close!"))
      return;
    xprev = xi;

    if (i != k) {
      vv = CMath::Sqr(t - xi);
      s0 = (t - xk) / (t - xi);
      s1 = (xk - xi) / vv;
    } else {
      s0 = 1;
      s1 = 0;
    }

    vv = b.m_w[i] * b.m_y[i];
    n0 = n0 + s0 * vv;
    n1 = n1 + s1 * vv;
    vv = b.m_w[i];
    d0 = d0 + s0 * vv;
    d1 = d1 + s1 * vv;
  }

  f = b.m_sy * n0 / d0;
  df = (n1 * d0 - n0 * d1) / CMath::Sqr(d0);

  if (df != 0.0)
    df = MathSign(df) * MathExp(MathLog(MathAbs(df)) + MathLog(b.m_sy) +
                                MathLog(xscale1) + MathLog(xscale2));
}

static void CRatInt::BarycentricDiff2(CBarycentricInterpolant &b,
                                      const double t, double &f, double &df,
                                      double &d2f) {

  double v = 0;
  double vv = 0;
  int i = 0;
  int k = 0;
  double n0 = 0;
  double n1 = 0;
  double n2 = 0;
  double d0 = 0;
  double d1 = 0;
  double d2 = 0;
  double s0 = 0;
  double s1 = 0;
  double s2 = 0;
  double xk = 0;
  double xi = 0;

  f = 0;
  df = 0;
  d2f = 0;

  if (!CAp::Assert(!CInfOrNaN::IsInfinity(t), __FUNCTION__ + ": infinite T!"))
    return;

  if (CInfOrNaN::IsNaN(t)) {

    f = CInfOrNaN::NaN();
    df = CInfOrNaN::NaN();
    d2f = CInfOrNaN::NaN();

    return;
  }

  if (b.m_n == 1) {

    f = b.m_sy * b.m_y[0];
    df = 0;
    d2f = 0;

    return;
  }

  if (b.m_sy == 0.0) {

    f = 0;
    df = 0;
    d2f = 0;

    return;
  }

  if (!CAp::Assert(b.m_sy > 0.0, __FUNCTION__ + ": internal error"))
    return;

  f = 0;
  df = 0;
  d2f = 0;
  v = MathAbs(b.m_x[0] - t);
  k = 0;
  for (i = 1; i <= b.m_n - 1; i++) {
    vv = b.m_x[i];

    if (MathAbs(vv - t) < v) {
      v = MathAbs(vv - t);
      k = i;
    }
  }

  xk = b.m_x[k];
  v = t - xk;
  n0 = 0;
  n1 = 0;
  n2 = 0;
  d0 = 0;
  d1 = 0;
  d2 = 0;

  for (i = 0; i <= b.m_n - 1; i++) {

    if (i != k) {
      xi = b.m_x[i];
      vv = CMath::Sqr(t - xi);
      s0 = (t - xk) / (t - xi);
      s1 = (xk - xi) / vv;
      s2 = -(2 * (xk - xi) / (vv * (t - xi)));
    } else {
      s0 = 1;
      s1 = 0;
      s2 = 0;
    }

    vv = b.m_w[i] * b.m_y[i];
    n0 = n0 + s0 * vv;
    n1 = n1 + s1 * vv;
    n2 = n2 + s2 * vv;
    vv = b.m_w[i];
    d0 = d0 + s0 * vv;
    d1 = d1 + s1 * vv;
    d2 = d2 + s2 * vv;
  }

  f = b.m_sy * n0 / d0;
  df = b.m_sy * (n1 * d0 - n0 * d1) / CMath::Sqr(d0);
  d2f = b.m_sy *
        ((n2 * d0 - n0 * d2) * CMath::Sqr(d0) -
         (n1 * d0 - n0 * d1) * 2 * d0 * d1) /
        CMath::Sqr(CMath::Sqr(d0));
}

static void CRatInt::BarycentricLinTransX(CBarycentricInterpolant &b,
                                          const double ca, const double cb) {

  int i = 0;
  int j = 0;
  double v = 0;

  if (ca == 0.0) {
    b.m_sy = BarycentricCalc(b, cb);
    v = 1;
    for (i = 0; i <= b.m_n - 1; i++) {
      b.m_y[i] = 1;
      b.m_w[i] = v;
      v = -v;
    }

    return;
  }

  for (i = 0; i <= b.m_n - 1; i++)
    b.m_x[i] = (b.m_x[i] - cb) / ca;

  if (ca < 0.0) {
    for (i = 0; i <= b.m_n - 1; i++) {

      if (i < b.m_n - 1 - i) {

        j = b.m_n - 1 - i;
        v = b.m_x[i];
        b.m_x[i] = b.m_x[j];
        b.m_x[j] = v;
        v = b.m_y[i];
        b.m_y[i] = b.m_y[j];
        b.m_y[j] = v;
        v = b.m_w[i];
        b.m_w[i] = b.m_w[j];
        b.m_w[j] = v;
      } else
        break;
    }
  }
}

static void CRatInt::BarycentricLinTransY(CBarycentricInterpolant &b,
                                          const double ca, const double cb) {

  int i = 0;
  double v = 0;
  int i_ = 0;

  for (i = 0; i <= b.m_n - 1; i++)
    b.m_y[i] = ca * b.m_sy * b.m_y[i] + cb;

  b.m_sy = 0;
  for (i = 0; i <= b.m_n - 1; i++)
    b.m_sy = MathMax(b.m_sy, MathAbs(b.m_y[i]));

  if (b.m_sy > 0.0) {
    v = 1 / b.m_sy;

    for (i_ = 0; i_ <= b.m_n - 1; i_++)
      b.m_y[i_] = v * b.m_y[i_];
  }
}

static void CRatInt::BarycentricUnpack(CBarycentricInterpolant &b, int &n,
                                       double &x[], double &y[], double &w[]) {

  double v = 0;
  int i_ = 0;

  n = b.m_n;

  ArrayResizeAL(x, n);
  ArrayResizeAL(y, n);
  ArrayResizeAL(w, n);

  v = b.m_sy;

  for (i_ = 0; i_ <= n - 1; i_++)
    x[i_] = b.m_x[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    y[i_] = v * b.m_y[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    w[i_] = b.m_w[i_];
}

static void CRatInt::BarycentricBuildXYW(double &x[], double &y[], double &w[],
                                         const int n,
                                         CBarycentricInterpolant &b) {

  int i_ = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  ArrayResizeAL(b.m_x, n);
  ArrayResizeAL(b.m_y, n);
  ArrayResizeAL(b.m_w, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    b.m_x[i_] = x[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    b.m_y[i_] = y[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    b.m_w[i_] = w[i_];
  b.m_n = n;

  BarycentricNormalize(b);
}

static void CRatInt::BarycentricBuildFloaterHormann(
    double &x[], double &y[], const int n, int d, CBarycentricInterpolant &b) {

  double s0 = 0;
  double s = 0;
  double v = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int i_ = 0;

  int perm[];
  double wtemp[];
  double sortrbuf[];
  double sortrbuf2[];

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(d >= 0, __FUNCTION__ + ": incorrect D!"))
    return;

  if (d > n - 1)
    d = n - 1;
  b.m_n = n;

  if (n == 1) {

    ArrayResizeAL(b.m_x, n);
    ArrayResizeAL(b.m_y, n);
    ArrayResizeAL(b.m_w, n);

    b.m_x[0] = x[0];
    b.m_y[0] = y[0];
    b.m_w[0] = 1;

    BarycentricNormalize(b);

    return;
  }

  ArrayResizeAL(b.m_x, n);
  ArrayResizeAL(b.m_y, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    b.m_x[i_] = x[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    b.m_y[i_] = y[i_];

  CTSort::TagSortFastR(b.m_x, b.m_y, sortrbuf, sortrbuf2, n);

  ArrayResizeAL(b.m_w, n);
  s0 = 1;
  for (k = 1; k <= d; k++)
    s0 = -s0;

  for (k = 0; k <= n - 1; k++) {

    s = 0;
    for (i = (int)(MathMax(k - d, 0)); i <= MathMin(k, n - 1 - d); i++) {
      v = 1;
      for (j = i; j <= i + d; j++) {

        if (j != k)
          v = v / MathAbs(b.m_x[k] - b.m_x[j]);
      }
      s = s + v;
    }
    b.m_w[k] = s0 * s;

    s0 = -s0;
  }

  BarycentricNormalize(b);
}

static void CRatInt::BarycentricCopy(CBarycentricInterpolant &b,
                                     CBarycentricInterpolant &b2) {

  int i_ = 0;

  b2.m_n = b.m_n;
  b2.m_sy = b.m_sy;

  ArrayResizeAL(b2.m_x, b2.m_n);
  ArrayResizeAL(b2.m_y, b2.m_n);
  ArrayResizeAL(b2.m_w, b2.m_n);

  for (i_ = 0; i_ <= b2.m_n - 1; i_++)
    b2.m_x[i_] = b.m_x[i_];
  for (i_ = 0; i_ <= b2.m_n - 1; i_++)
    b2.m_y[i_] = b.m_y[i_];
  for (i_ = 0; i_ <= b2.m_n - 1; i_++)
    b2.m_w[i_] = b.m_w[i_];
}

static void CRatInt::BarycentricNormalize(CBarycentricInterpolant &b) {

  int i = 0;
  int j = 0;
  int j2 = 0;
  double v = 0;
  int i_ = 0;

  int p1[];
  int p2[];

  b.m_sy = 0;
  for (i = 0; i <= b.m_n - 1; i++)
    b.m_sy = MathMax(b.m_sy, MathAbs(b.m_y[i]));

  if (b.m_sy > 0.0 && MathAbs(b.m_sy - 1) > 10 * CMath::m_machineepsilon) {
    v = 1 / b.m_sy;
    for (i_ = 0; i_ <= b.m_n - 1; i_++)
      b.m_y[i_] = v * b.m_y[i_];
  }

  v = 0;
  for (i = 0; i <= b.m_n - 1; i++)
    v = MathMax(v, MathAbs(b.m_w[i]));

  if (v > 0.0 && MathAbs(v - 1) > 10 * CMath::m_machineepsilon) {
    v = 1 / v;
    for (i_ = 0; i_ <= b.m_n - 1; i_++)
      b.m_w[i_] = v * b.m_w[i_];
  }
  for (i = 0; i <= b.m_n - 2; i++) {

    if (b.m_x[i + 1] < b.m_x[i]) {

      CTSort::TagSort(b.m_x, b.m_n, p1, p2);

      for (j = 0; j <= b.m_n - 1; j++) {
        j2 = p2[j];
        v = b.m_y[j];
        b.m_y[j] = b.m_y[j2];
        b.m_y[j2] = v;
        v = b.m_w[j];
        b.m_w[j] = b.m_w[j2];
        b.m_w[j2] = v;
      }
      break;
    }
  }
}

class CPolInt {
public:
  CPolInt(void);
  ~CPolInt(void);

  static void PolynomialBar2Cheb(CBarycentricInterpolant &p, const double a,
                                 const double b, double &t[]);
  static void PolynomialCheb2Bar(double &t[], const int n, const double a,
                                 const double b, CBarycentricInterpolant &p);
  static void PolynomialBar2Pow(CBarycentricInterpolant &p, const double c,
                                const double s, double &a[]);
  static void PolynomialPow2Bar(double &a[], const int n, const double c,
                                const double s, CBarycentricInterpolant &p);
  static void PolynomialBuild(double &cx[], double &cy[], const int n,
                              CBarycentricInterpolant &p);
  static void PolynomialBuildEqDist(const double a, const double b, double &y[],
                                    const int n, CBarycentricInterpolant &p);
  static void PolynomialBuildCheb1(const double a, const double b, double &y[],
                                   const int n, CBarycentricInterpolant &p);
  static void PolynomialBuildCheb2(const double a, const double b, double &y[],
                                   const int n, CBarycentricInterpolant &p);
  static double PolynomialCalcEqDist(const double a, const double b,
                                     double &f[], const int n, const double t);
  static double PolynomialCalcCheb1(const double a, const double b, double &f[],
                                    const int n, double t);
  static double PolynomialCalcCheb2(const double a, const double b, double &f[],
                                    const int n, double t);
};

CPolInt::CPolInt(void) {}

CPolInt::~CPolInt(void) {}

static void CPolInt::PolynomialBar2Cheb(CBarycentricInterpolant &p,
                                        const double a, const double b,
                                        double &t[]) {

  int i = 0;
  int k = 0;
  double v = 0;
  int i_ = 0;

  double vp[];
  double vx[];
  double tk[];
  double tk1[];

  if (!CAp::Assert(CMath::IsFinite(a), __FUNCTION__ + ": A is not finite!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(b), __FUNCTION__ + ": B is not finite!"))
    return;

  if (!CAp::Assert(a != b, __FUNCTION__ + ": A=B!"))
    return;

  if (!CAp::Assert(
          p.m_n > 0,
          __FUNCTION__ +
              ": P is not correctly initialized barycentric interpolant!"))
    return;

  ArrayResizeAL(vp, p.m_n);
  ArrayResizeAL(vx, p.m_n);
  for (i = 0; i <= p.m_n - 1; i++) {
    vx[i] = MathCos(M_PI * (i + 0.5) / p.m_n);
    vp[i] = CRatInt::BarycentricCalc(p, 0.5 * (vx[i] + 1) * (b - a) + a);
  }

  ArrayResizeAL(t, p.m_n);
  v = 0;
  for (i = 0; i <= p.m_n - 1; i++)
    v = v + vp[i];
  t[0] = v / p.m_n;

  if (p.m_n > 1) {

    ArrayResizeAL(tk, p.m_n);
    ArrayResizeAL(tk1, p.m_n);
    for (i = 0; i <= p.m_n - 1; i++) {
      tk[i] = vx[i];
      tk1[i] = 1;
    }

    for (k = 1; k <= p.m_n - 1; k++) {

      v = 0.0;
      for (i_ = 0; i_ <= p.m_n - 1; i_++)
        v += tk[i_] * vp[i_];
      t[k] = v / (0.5 * p.m_n);

      for (i = 0; i <= p.m_n - 1; i++) {
        v = 2 * vx[i] * tk[i] - tk1[i];
        tk1[i] = tk[i];
        tk[i] = v;
      }
    }
  }
}

static void CPolInt::PolynomialCheb2Bar(double &t[], const int n,
                                        const double a, const double b,
                                        CBarycentricInterpolant &p) {

  int i = 0;
  int k = 0;
  double tk = 0;
  double tk1 = 0;
  double vx = 0;
  double vy = 0;
  double v = 0;

  double y[];

  if (!CAp::Assert(CMath::IsFinite(a), __FUNCTION__ + ": A is not finite!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(b), __FUNCTION__ + ": B is not finite!"))
    return;

  if (!CAp::Assert(a != b, __FUNCTION__ + ": A=B!"))
    return;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1"))
    return;

  if (!CAp::Assert(CAp::Len(t) >= n, __FUNCTION__ + ": Length(T)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(t, n),
                   __FUNCTION__ + ": T[] contains INF or NAN"))
    return;

  ArrayResizeAL(y, n);
  for (i = 0; i <= n - 1; i++) {

    vx = MathCos(M_PI * (i + 0.5) / n);
    vy = t[0];
    tk1 = 1;
    tk = vx;

    for (k = 1; k <= n - 1; k++) {
      vy = vy + t[k] * tk;
      v = 2 * vx * tk - tk1;
      tk1 = tk;
      tk = v;
    }
    y[i] = vy;
  }

  PolynomialBuildCheb1(a, b, y, n, p);
}

static void CPolInt::PolynomialBar2Pow(CBarycentricInterpolant &p,
                                       const double c, const double s,
                                       double &a[]) {

  int i = 0;
  int k = 0;
  double e = 0;
  double d = 0;
  double v = 0;
  int i_ = 0;

  double vp[];
  double vx[];
  double tk[];
  double tk1[];
  double t[];

  if (!CAp::Assert(CMath::IsFinite(c), __FUNCTION__ + ": C is not finite!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(s), __FUNCTION__ + ": S is not finite!"))
    return;

  if (!CAp::Assert(s != 0.0, __FUNCTION__ + ": S=0!"))
    return;

  if (!CAp::Assert(
          p.m_n > 0,
          __FUNCTION__ +
              ": P is not correctly initialized barycentric interpolant!"))
    return;

  ArrayResizeAL(vp, p.m_n);
  ArrayResizeAL(vx, p.m_n);
  for (i = 0; i <= p.m_n - 1; i++) {
    vx[i] = MathCos(M_PI * (i + 0.5) / p.m_n);
    vp[i] = CRatInt::BarycentricCalc(p, s * vx[i] + c);
  }

  ArrayResizeAL(t, p.m_n);
  v = 0;
  for (i = 0; i <= p.m_n - 1; i++)
    v = v + vp[i];
  t[0] = v / p.m_n;

  if (p.m_n > 1) {

    ArrayResizeAL(tk, p.m_n);
    ArrayResizeAL(tk1, p.m_n);
    for (i = 0; i <= p.m_n - 1; i++) {
      tk[i] = vx[i];
      tk1[i] = 1;
    }

    for (k = 1; k <= p.m_n - 1; k++) {

      v = 0.0;
      for (i_ = 0; i_ <= p.m_n - 1; i_++)
        v += tk[i_] * vp[i_];
      t[k] = v / (0.5 * p.m_n);

      for (i = 0; i <= p.m_n - 1; i++) {
        v = 2 * vx[i] * tk[i] - tk1[i];
        tk1[i] = tk[i];
        tk[i] = v;
      }
    }
  }

  ArrayResizeAL(a, p.m_n);
  for (i = 0; i <= p.m_n - 1; i++)
    a[i] = 0;
  d = 0;

  for (i = 0; i <= p.m_n - 1; i++) {
    for (k = i; k <= p.m_n - 1; k++) {
      e = a[k];
      a[k] = 0;

      if (i <= 1 && k == i)
        a[k] = 1;
      else {

        if (i != 0)
          a[k] = 2 * d;

        if (k > i + 1)
          a[k] = a[k] - a[k - 2];
      }
      d = e;
    }

    d = a[i];
    e = 0;
    k = i;

    while (k <= p.m_n - 1) {
      e = e + a[k] * t[k];
      k = k + 2;
    }
    a[i] = e;
  }
}

static void CPolInt::PolynomialPow2Bar(double &a[], const int n, const double c,
                                       const double s,
                                       CBarycentricInterpolant &p) {

  int i = 0;
  int k = 0;
  double vx = 0;
  double vy = 0;
  double px = 0;

  double y[];

  if (!CAp::Assert(CMath::IsFinite(c), __FUNCTION__ + ": C is not finite!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(s), __FUNCTION__ + ": S is not finite!"))
    return;

  if (!CAp::Assert(s != 0.0, __FUNCTION__ + ": S is zero!"))
    return;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1"))
    return;

  if (!CAp::Assert(CAp::Len(a) >= n, __FUNCTION__ + ": Length(A)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(a, n),
                   __FUNCTION__ + ": A[] contains INF or NAN"))
    return;

  ArrayResizeAL(y, n);
  for (i = 0; i <= n - 1; i++) {

    vx = MathCos(M_PI * (i + 0.5) / n);
    vy = a[0];
    px = vx;

    for (k = 1; k <= n - 1; k++) {
      vy = vy + px * a[k];
      px = px * vx;
    }
    y[i] = vy;
  }

  PolynomialBuildCheb1(c - s, c + s, y, n, p);
}

static void CPolInt::PolynomialBuild(double &cx[], double &cy[], const int n,
                                     CBarycentricInterpolant &p) {

  int j = 0;
  int k = 0;
  double b = 0;
  double a = 0;
  double v = 0;
  double mx = 0;
  int i_ = 0;

  double w[];
  double sortrbuf[];
  double sortrbuf2[];
  double x[];
  double y[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  CTSort::TagSortFastR(x, y, sortrbuf, sortrbuf2, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  ArrayResizeAL(w, n);
  a = x[0];
  b = x[0];
  for (j = 0; j <= n - 1; j++) {
    w[j] = 1;
    a = MathMin(a, x[j]);
    b = MathMax(b, x[j]);
  }

  for (k = 0; k <= n - 1; k++) {

    mx = MathAbs(w[k]);
    for (j = 0; j <= n - 1; j++) {

      if (j != k) {
        v = (b - a) / (x[j] - x[k]);
        w[j] = w[j] * v;
        mx = MathMax(mx, MathAbs(w[j]));
      }
    }

    if (k % 5 == 0) {

      v = 1 / mx;
      for (i_ = 0; i_ <= n - 1; i_++)
        w[i_] = v * w[i_];
    }
  }

  CRatInt::BarycentricBuildXYW(x, y, w, n, p);
}

static void CPolInt::PolynomialBuildEqDist(const double a, const double b,
                                           double &y[], const int n,
                                           CBarycentricInterpolant &p) {

  int i = 0;
  double v = 0;

  double w[];
  double x[];

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(a),
                   __FUNCTION__ + ": A is infinite or NaN!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(b),
                   __FUNCTION__ + ": B is infinite or NaN!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(b != a, __FUNCTION__ + ": B=A!"))
    return;

  if (!CAp::Assert((double)(a + (b - a) / n) != a,
                   __FUNCTION__ + ": B is too close to A!"))
    return;

  if (n == 1) {

    ArrayResizeAL(x, 1);
    ArrayResizeAL(w, 1);
    x[0] = 0.5 * (b + a);
    w[0] = 1;

    CRatInt::BarycentricBuildXYW(x, y, w, 1, p);

    return;
  }

  ArrayResizeAL(x, n);
  ArrayResizeAL(w, n);
  v = 1;

  for (i = 0; i <= n - 1; i++) {
    w[i] = v;
    x[i] = a + (b - a) * i / (n - 1);
    v = -(v * (n - 1 - i));
    v = v / (i + 1);
  }

  CRatInt::BarycentricBuildXYW(x, y, w, n, p);
}

static void CPolInt::PolynomialBuildCheb1(const double a, const double b,
                                          double &y[], const int n,
                                          CBarycentricInterpolant &p) {

  int i = 0;
  double v = 0;
  double t = 0;

  double w[];
  double x[];

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(a),
                   __FUNCTION__ + ": A is infinite or NaN!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(b),
                   __FUNCTION__ + ": B is infinite or NaN!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(b != a, __FUNCTION__ + ": B=A!"))
    return;

  if (n == 1) {

    ArrayResizeAL(x, 1);
    ArrayResizeAL(w, 1);
    x[0] = 0.5 * (b + a);
    w[0] = 1;

    CRatInt::BarycentricBuildXYW(x, y, w, 1, p);

    return;
  }

  ArrayResizeAL(x, n);
  ArrayResizeAL(w, n);
  v = 1;

  for (i = 0; i <= n - 1; i++) {
    t = MathTan(0.5 * M_PI * (2 * i + 1) / (2 * n));
    w[i] = 2 * v * t / (1 + CMath::Sqr(t));
    x[i] = 0.5 * (b + a) +
           0.5 * (b - a) * (1 - CMath::Sqr(t)) / (1 + CMath::Sqr(t));
    v = -v;
  }

  CRatInt::BarycentricBuildXYW(x, y, w, n, p);
}

static void CPolInt::PolynomialBuildCheb2(const double a, const double b,
                                          double &y[], const int n,
                                          CBarycentricInterpolant &p) {

  int i = 0;
  double v = 0;

  double w[];
  double x[];

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(a),
                   __FUNCTION__ + ": A is infinite or NaN!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(b),
                   __FUNCTION__ + ": B is infinite or NaN!"))
    return;

  if (!CAp::Assert(b != a, __FUNCTION__ + ": B=A!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (n == 1) {

    ArrayResizeAL(x, 1);
    ArrayResizeAL(w, 1);
    x[0] = 0.5 * (b + a);
    w[0] = 1;

    CRatInt::BarycentricBuildXYW(x, y, w, 1, p);

    return;
  }

  ArrayResizeAL(x, n);
  ArrayResizeAL(w, n);
  v = 1;

  for (i = 0; i <= n - 1; i++) {

    if (i == 0 || i == n - 1)
      w[i] = v * 0.5;
    else
      w[i] = v;
    x[i] = 0.5 * (b + a) + 0.5 * (b - a) * MathCos(M_PI * i / (n - 1));
    v = -v;
  }

  CRatInt::BarycentricBuildXYW(x, y, w, n, p);
}

static double CPolInt::PolynomialCalcEqDist(const double a, const double b,
                                            double &f[], const int n,
                                            const double t) {

  double s1 = 0;
  double s2 = 0;
  double v = 0;
  double threshold = 0;
  double s = 0;
  double h = 0;
  int i = 0;
  int j = 0;
  double w = 0;
  double x = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Len(f) >= n, __FUNCTION__ + ": Length(F)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CMath::IsFinite(a),
                   __FUNCTION__ + ": A is infinite or NaN!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CMath::IsFinite(b),
                   __FUNCTION__ + ": B is infinite or NaN!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CApServ::IsFiniteVector(f, n),
                   __FUNCTION__ + ": F contains infinite or NaN values!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(b != a, __FUNCTION__ + ": B=A!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(!CInfOrNaN::IsInfinity(t),
                   __FUNCTION__ + ": T is infinite!"))
    return (EMPTY_VALUE);

  if (CInfOrNaN::IsNaN(t))
    return (CInfOrNaN::NaN());

  if (n == 1)
    return (f[0]);

  threshold = MathSqrt(CMath::m_minrealnumber);
  j = 0;
  s = t - a;

  for (i = 1; i <= n - 1; i++) {
    x = a + (double)i / (double)(n - 1) * (b - a);

    if (MathAbs(t - x) < MathAbs(s)) {
      s = t - x;
      j = i;
    }
  }

  if (s == 0.0)
    return (f[j]);

  if (MathAbs(s) > threshold) {

    j = -1;
    s = 1.0;
  }

  s1 = 0;
  s2 = 0;
  w = 1.0;
  h = (b - a) / (n - 1);

  for (i = 0; i <= n - 1; i++) {

    if (i != j) {
      v = s * w / (t - (a + i * h));
      s1 = s1 + v * f[i];
      s2 = s2 + v;
    } else {
      v = w;
      s1 = s1 + v * f[i];
      s2 = s2 + v;
    }

    w = -(w * (n - 1 - i));
    w = w / (i + 1);
  }

  return (s1 / s2);
}

static double CPolInt::PolynomialCalcCheb1(const double a, const double b,
                                           double &f[], const int n, double t) {

  double s1 = 0;
  double s2 = 0;
  double v = 0;
  double threshold = 0;
  double s = 0;
  int i = 0;
  int j = 0;
  double a0 = 0;
  double delta = 0;
  double alpha = 0;
  double beta = 0;
  double ca = 0;
  double sa = 0;
  double tempc = 0;
  double temps = 0;
  double x = 0;
  double w = 0;
  double p1 = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Len(f) >= n, __FUNCTION__ + ": Length(F)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CMath::IsFinite(a),
                   __FUNCTION__ + ": A is infinite or NaN!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CMath::IsFinite(b),
                   __FUNCTION__ + ": B is infinite or NaN!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CApServ::IsFiniteVector(f, n),
                   __FUNCTION__ + ": F contains infinite or NaN values!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(b != a, __FUNCTION__ + ": B=A!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(!CInfOrNaN::IsInfinity(t),
                   __FUNCTION__ + ": T is infinite!"))
    return (EMPTY_VALUE);

  if (CInfOrNaN::IsNaN(t))
    return (CInfOrNaN::NaN());

  if (n == 1)
    return (f[0]);

  threshold = MathSqrt(CMath::m_minrealnumber);
  t = (t - 0.5 * (a + b)) / (0.5 * (b - a));
  a0 = M_PI / (2 * (n - 1) + 2);
  delta = 2 * M_PI / (2 * (n - 1) + 2);
  alpha = 2 * CMath::Sqr(MathSin(delta / 2));
  beta = MathSin(delta);

  ca = MathCos(a0);
  sa = MathSin(a0);
  j = 0;
  x = ca;
  s = t - x;

  for (i = 1; i <= n - 1; i++) {

    temps = sa - (alpha * sa - beta * ca);
    tempc = ca - (alpha * ca + beta * sa);
    sa = temps;
    ca = tempc;
    x = ca;

    if (MathAbs(t - x) < MathAbs(s)) {
      s = t - x;
      j = i;
    }
  }

  if (s == 0.0)
    return (f[j]);

  if (MathAbs(s) > threshold) {

    j = -1;
    s = 1.0;
  }

  s1 = 0;
  s2 = 0;
  ca = MathCos(a0);
  sa = MathSin(a0);
  p1 = 1.0;

  for (i = 0; i <= n - 1; i++) {

    x = ca;
    w = p1 * sa;

    if (i != j) {
      v = s * w / (t - x);
      s1 = s1 + v * f[i];
      s2 = s2 + v;
    } else {
      v = w;
      s1 = s1 + v * f[i];
      s2 = s2 + v;
    }

    temps = sa - (alpha * sa - beta * ca);
    tempc = ca - (alpha * ca + beta * sa);
    sa = temps;
    ca = tempc;
    p1 = -p1;
  }

  return (s1 / s2);
}

static double CPolInt::PolynomialCalcCheb2(const double a, const double b,
                                           double &f[], const int n, double t) {

  double s1 = 0;
  double s2 = 0;
  double v = 0;
  double threshold = 0;
  double s = 0;
  int i = 0;
  int j = 0;
  double a0 = 0;
  double delta = 0;
  double alpha = 0;
  double beta = 0;
  double ca = 0;
  double sa = 0;
  double tempc = 0;
  double temps = 0;
  double x = 0;
  double w = 0;
  double p1 = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Len(f) >= n, __FUNCTION__ + ": Length(F)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CMath::IsFinite(a),
                   __FUNCTION__ + ": A is infinite or NaN!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CMath::IsFinite(b),
                   __FUNCTION__ + ": B is infinite or NaN!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(b != a, __FUNCTION__ + ": B=A!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CApServ::IsFiniteVector(f, n),
                   __FUNCTION__ + ": F contains infinite or NaN values!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(!CInfOrNaN::IsInfinity(t),
                   __FUNCTION__ + ": T is infinite!"))
    return (EMPTY_VALUE);

  if (CInfOrNaN::IsNaN(t))
    return (CInfOrNaN::NaN());

  if (n == 1)
    return (f[0]);

  threshold = MathSqrt(CMath::m_minrealnumber);
  t = (t - 0.5 * (a + b)) / (0.5 * (b - a));
  a0 = 0.0;
  delta = M_PI / (n - 1);
  alpha = 2 * CMath::Sqr(MathSin(delta / 2));
  beta = MathSin(delta);

  ca = MathCos(a0);
  sa = MathSin(a0);
  j = 0;
  x = ca;
  s = t - x;

  for (i = 1; i <= n - 1; i++) {

    temps = sa - (alpha * sa - beta * ca);
    tempc = ca - (alpha * ca + beta * sa);
    sa = temps;
    ca = tempc;
    x = ca;

    if (MathAbs(t - x) < MathAbs(s)) {
      s = t - x;
      j = i;
    }
  }

  if (s == 0.0)
    return (f[j]);

  if (MathAbs(s) > threshold) {

    j = -1;
    s = 1.0;
  }

  s1 = 0;
  s2 = 0;
  ca = MathCos(a0);
  sa = MathSin(a0);
  p1 = 1.0;

  for (i = 0; i <= n - 1; i++) {

    x = ca;

    if (i == 0 || i == n - 1)
      w = 0.5 * p1;
    else
      w = 1.0 * p1;

    if (i != j) {
      v = s * w / (t - x);
      s1 = s1 + v * f[i];
      s2 = s2 + v;
    } else {
      v = w;
      s1 = s1 + v * f[i];
      s2 = s2 + v;
    }

    temps = sa - (alpha * sa - beta * ca);
    tempc = ca - (alpha * ca + beta * sa);
    sa = temps;
    ca = tempc;
    p1 = -p1;
  }

  return (s1 / s2);
}

class CSpline1DInterpolant {
public:
  bool m_periodic;
  int m_n;
  int m_k;

  double m_x[];
  double m_c[];

  CSpline1DInterpolant(void);
  ~CSpline1DInterpolant(void);

  void Copy(CSpline1DInterpolant &obj);
};

CSpline1DInterpolant::CSpline1DInterpolant(void) {}

CSpline1DInterpolant::~CSpline1DInterpolant(void) {}

void CSpline1DInterpolant::Copy(CSpline1DInterpolant &obj) {

  m_periodic = obj.m_periodic;
  m_n = obj.m_n;
  m_k = obj.m_k;

  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_c, obj.m_c);
}

class CSpline1DInterpolantShell {
private:
  CSpline1DInterpolant m_innerobj;

public:
  CSpline1DInterpolantShell(void);
  CSpline1DInterpolantShell(CSpline1DInterpolant &obj);
  ~CSpline1DInterpolantShell(void);

  CSpline1DInterpolant *GetInnerObj(void);
};

CSpline1DInterpolantShell::CSpline1DInterpolantShell(void) {}

CSpline1DInterpolantShell::CSpline1DInterpolantShell(
    CSpline1DInterpolant &obj) {

  m_innerobj.Copy(obj);
}

CSpline1DInterpolantShell::~CSpline1DInterpolantShell(void) {}

CSpline1DInterpolant *CSpline1DInterpolantShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CSpline1D {
private:
  static void Spline1DGridDiffCubicInternal(
      double &x[], double &y[], const int n, const int boundltype,
      const double boundl, const int boundrtype, const double boundr,
      double &d[], double &a1[], double &a2[], double &a3[], double &b[],
      double &dt[]);
  static void HeapSortPoints(double &x[], double &y[], const int n);
  static void HeapSortPPoints(double &x[], double &y[], int &p[], const int n);
  static void SolveTridiagonal(double &a[], double &cb[], double &c[],
                               double &cd[], const int n, double &x[]);
  static void SolveCyclicTridiagonal(double &a[], double &cb[], double &c[],
                                     double &d[], const int n, double &x[]);
  static double DiffThreePoint(double t, const double x0, const double f0,
                               double x1, const double f1, double x2,
                               const double f2);

public:
  CSpline1D(void);
  ~CSpline1D(void);

  static void Spline1DBuildLinear(double &cx[], double &cy[], const int n,
                                  CSpline1DInterpolant &c);
  static void Spline1DBuildCubic(double &cx[], double &cy[], const int n,
                                 const int boundltype, const double boundl,
                                 const int boundrtype, const double boundr,
                                 CSpline1DInterpolant &c);
  static void Spline1DGridDiffCubic(double &cx[], double &cy[], const int n,
                                    const int boundltype, const double boundl,
                                    const int boundrtype, const double boundr,
                                    double &d[]);
  static void Spline1DGridDiff2Cubic(double &cx[], double &cy[], const int n,
                                     const int boundltype, const double boundl,
                                     const int boundrtype, const double boundr,
                                     double &d1[], double &d2[]);
  static void Spline1DConvCubic(double &cx[], double &cy[], const int n,
                                const int boundltype, const double boundl,
                                const int boundrtype, const double boundr,
                                double &cx2[], const int n2, double &y2[]);
  static void Spline1DConvDiffCubic(double &cx[], double &cy[], const int n,
                                    const int boundltype, const double boundl,
                                    const int boundrtype, const double boundr,
                                    double &cx2[], const int n2, double &y2[],
                                    double &d2[]);
  static void Spline1DConvDiff2Cubic(double &cx[], double &cy[], const int n,
                                     const int boundltype, const double boundl,
                                     const int boundrtype, const double boundr,
                                     double &cx2[], const int n2, double &y2[],
                                     double &d2[], double &dd2[]);
  static void Spline1DBuildCatmullRom(double &cx[], double &cy[], const int n,
                                      const int boundtype, const double tension,
                                      CSpline1DInterpolant &c);
  static void Spline1DBuildHermite(double &cx[], double &cy[], double &cd[],
                                   const int n, CSpline1DInterpolant &c);
  static void Spline1DBuildAkima(double &cx[], double &cy[], const int n,
                                 CSpline1DInterpolant &c);
  static double Spline1DCalc(CSpline1DInterpolant &c, double x);
  static void Spline1DDiff(CSpline1DInterpolant &c, double x, double &s,
                           double &ds, double &d2s);
  static void Spline1DCopy(CSpline1DInterpolant &c, CSpline1DInterpolant &cc);
  static void Spline1DUnpack(CSpline1DInterpolant &c, int &n,
                             CMatrixDouble &tbl);
  static void Spline1DLinTransX(CSpline1DInterpolant &c, const double a,
                                const double b);
  static void Spline1DLinTransY(CSpline1DInterpolant &c, const double a,
                                const double b);
  static double Spline1DIntegrate(CSpline1DInterpolant &c, double x);
  static void Spline1DConvDiffInternal(double &xold[], double &yold[],
                                       double &dold[], const int n,
                                       double &x2[], const int n2, double &y[],
                                       const bool needy, double &d1[],
                                       const bool needd1, double &d2[],
                                       const bool needd2);
  static void HeapSortDPoints(double &x[], double &y[], double &d[],
                              const int n);
};

CSpline1D::CSpline1D(void) {}

CSpline1D::~CSpline1D(void) {}

static void CSpline1D::Spline1DBuildLinear(double &cx[], double &cy[],
                                           const int n,
                                           CSpline1DInterpolant &c) {

  int i = 0;

  double x[];
  double y[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  if (!CAp::Assert(n > 1, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  HeapSortPoints(x, y, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  c.m_periodic = false;
  c.m_n = n;
  c.m_k = 3;

  ArrayResizeAL(c.m_x, n);
  ArrayResizeAL(c.m_c, 4 * (n - 1));

  for (i = 0; i <= n - 1; i++)
    c.m_x[i] = x[i];

  for (i = 0; i <= n - 2; i++) {
    c.m_c[4 * i + 0] = y[i];
    c.m_c[4 * i + 1] = (y[i + 1] - y[i]) / (x[i + 1] - x[i]);
    c.m_c[4 * i + 2] = 0;
    c.m_c[4 * i + 3] = 0;
  }
}

static void CSpline1D::Spline1DBuildCubic(double &cx[], double &cy[],
                                          const int n, const int boundltype,
                                          const double boundl,
                                          const int boundrtype,
                                          const double boundr,
                                          CSpline1DInterpolant &c) {

  int ylen = 0;

  double a1[];
  double a2[];
  double a3[];
  double b[];
  double dt[];
  double d[];
  int p[];
  double x[];
  double y[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  if (!CAp::Assert(((boundltype == -1 || boundltype == 0) || boundltype == 1) ||
                       boundltype == 2,
                   __FUNCTION__ + ": incorrect BoundLType!"))
    return;

  if (!CAp::Assert(((boundrtype == -1 || boundrtype == 0) || boundrtype == 1) ||
                       boundrtype == 2,
                   __FUNCTION__ + ": incorrect BoundRType!"))
    return;

  if (!CAp::Assert((boundrtype == -1 && boundltype == -1) ||
                       (boundrtype != -1 && boundltype != -1),
                   __FUNCTION__ + ": incorrect BoundLType/BoundRType!"))
    return;

  if (boundltype == 1 || boundltype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundl),
                     __FUNCTION__ + ": BoundL is infinite or NAN!"))
      return;
  }

  if (boundrtype == 1 || boundrtype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundr),
                     __FUNCTION__ + ": BoundR is infinite or NAN!"))
      return;
  }

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  ylen = n;

  if (boundltype == -1)
    ylen = n - 1;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, ylen),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  HeapSortPPoints(x, y, p, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  Spline1DGridDiffCubicInternal(x, y, n, boundltype, boundl, boundrtype, boundr,
                                d, a1, a2, a3, b, dt);
  Spline1DBuildHermite(x, y, d, n, c);

  if (boundltype == -1 || boundrtype == -1)
    c.m_periodic = 1;
  else
    c.m_periodic = 0;
}

static void CSpline1D::Spline1DGridDiffCubic(double &cx[], double &cy[],
                                             const int n, const int boundltype,
                                             const double boundl,
                                             const int boundrtype,
                                             const double boundr, double &d[]) {

  int i = 0;
  int ylen = 0;
  int i_ = 0;

  double a1[];
  double a2[];
  double a3[];
  double b[];
  double dt[];
  int p[];
  double x[];
  double y[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  if (!CAp::Assert(((boundltype == -1 || boundltype == 0) || boundltype == 1) ||
                       boundltype == 2,
                   __FUNCTION__ + ": incorrect BoundLType!"))
    return;

  if (!CAp::Assert(((boundrtype == -1 || boundrtype == 0) || boundrtype == 1) ||
                       boundrtype == 2,
                   __FUNCTION__ + ": incorrect BoundRType!"))
    return;

  if (!CAp::Assert((boundrtype == -1 && boundltype == -1) ||
                       (boundrtype != -1 && boundltype != -1),
                   __FUNCTION__ + ": incorrect BoundLType/BoundRType!"))
    return;

  if (boundltype == 1 || boundltype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundl),
                     __FUNCTION__ + ": BoundL is infinite or NAN!"))
      return;
  }

  if (boundrtype == 1 || boundrtype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundr),
                     __FUNCTION__ + ": BoundR is infinite or NAN!"))
      return;
  }

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  ylen = n;

  if (boundltype == -1)
    ylen = n - 1;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, ylen),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  HeapSortPPoints(x, y, p, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  Spline1DGridDiffCubicInternal(x, y, n, boundltype, boundl, boundrtype, boundr,
                                d, a1, a2, a3, b, dt);

  if (CAp::Len(dt) < n)
    ArrayResizeAL(dt, n);

  for (i = 0; i <= n - 1; i++)
    dt[p[i]] = d[i];
  for (i_ = 0; i_ <= n - 1; i_++)
    d[i_] = dt[i_];
}

static void CSpline1D::Spline1DGridDiff2Cubic(double &cx[], double &cy[],
                                              const int n, const int boundltype,
                                              const double boundl,
                                              const int boundrtype,
                                              const double boundr, double &d1[],
                                              double &d2[]) {

  int i = 0;
  int ylen = 0;
  double delta = 0;
  double delta2 = 0;
  double delta3 = 0;
  double s0 = 0;
  double s1 = 0;
  double s2 = 0;
  double s3 = 0;
  int i_ = 0;

  double a1[];
  double a2[];
  double a3[];
  double b[];
  double dt[];
  int p[];
  double x[];
  double y[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  if (!CAp::Assert(((boundltype == -1 || boundltype == 0) || boundltype == 1) ||
                       boundltype == 2,
                   __FUNCTION__ + ": incorrect BoundLType!"))
    return;

  if (!CAp::Assert(((boundrtype == -1 || boundrtype == 0) || boundrtype == 1) ||
                       boundrtype == 2,
                   __FUNCTION__ + ": incorrect BoundRType!"))
    return;

  if (!CAp::Assert((boundrtype == -1 && boundltype == -1) ||
                       (boundrtype != -1 && boundltype != -1),
                   __FUNCTION__ + ": incorrect BoundLType/BoundRType!"))
    return;

  if (boundltype == 1 || boundltype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundl),
                     __FUNCTION__ + ": BoundL is infinite or NAN!"))
      return;
  }

  if (boundrtype == 1 || boundrtype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundr),
                     __FUNCTION__ + ": BoundR is infinite or NAN!"))
      return;
  }

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  ylen = n;

  if (boundltype == -1)
    ylen = n - 1;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, ylen),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  HeapSortPPoints(x, y, p, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  Spline1DGridDiffCubicInternal(x, y, n, boundltype, boundl, boundrtype, boundr,
                                d1, a1, a2, a3, b, dt);

  ArrayResizeAL(d2, n);
  delta = 0;
  s2 = 0;
  s3 = 0;

  for (i = 0; i <= n - 2; i++) {

    delta = x[i + 1] - x[i];
    delta2 = CMath::Sqr(delta);
    delta3 = delta * delta2;
    s0 = y[i];
    s1 = d1[i];
    s2 = (3 * (y[i + 1] - y[i]) - 2 * d1[i] * delta - d1[i + 1] * delta) /
         delta2;
    s3 = (2 * (y[i] - y[i + 1]) + d1[i] * delta + d1[i + 1] * delta) / delta3;
    d2[i] = 2 * s2;
  }
  d2[n - 1] = 2 * s2 + 6 * s3 * delta;

  if (CAp::Len(dt) < n)
    ArrayResizeAL(dt, n);

  for (i = 0; i <= n - 1; i++)
    dt[p[i]] = d1[i];
  for (i_ = 0; i_ <= n - 1; i_++)
    d1[i_] = dt[i_];
  for (i = 0; i <= n - 1; i++)
    dt[p[i]] = d2[i];
  for (i_ = 0; i_ <= n - 1; i_++)
    d2[i_] = dt[i_];
}

static void CSpline1D::Spline1DConvCubic(double &cx[], double &cy[],
                                         const int n, const int boundltype,
                                         const double boundl,
                                         const int boundrtype,
                                         const double boundr, double &cx2[],
                                         const int n2, double &y2[]) {

  int i = 0;
  int ylen = 0;
  double t = 0;
  double t2 = 0;
  int i_ = 0;

  double a1[];
  double a2[];
  double a3[];
  double b[];
  double d[];
  double dt[];
  double d1[];
  double d2[];
  int p[];
  int p2[];
  double x[];
  double y[];
  double x2[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);
  ArrayCopy(x2, cx2);

  if (!CAp::Assert(((boundltype == -1 || boundltype == 0) || boundltype == 1) ||
                       boundltype == 2,
                   __FUNCTION__ + ": incorrect BoundLType!"))
    return;

  if (!CAp::Assert(((boundrtype == -1 || boundrtype == 0) || boundrtype == 1) ||
                       boundrtype == 2,
                   __FUNCTION__ + ": incorrect BoundRType!"))
    return;

  if (!CAp::Assert((boundrtype == -1 && boundltype == -1) ||
                       (boundrtype != -1 && boundltype != -1),
                   __FUNCTION__ + ": incorrect BoundLType/BoundRType!"))
    return;

  if (boundltype == 1 || boundltype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundl),
                     __FUNCTION__ + ": BoundL is infinite or NAN!"))
      return;
  }

  if (boundrtype == 1 || boundrtype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundr),
                     __FUNCTION__ + ": BoundR is infinite or NAN!"))
      return;
  }

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(n2 >= 2, __FUNCTION__ + ": N2<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x2) >= n2, __FUNCTION__ + ": Length(X2)<N2!"))
    return;

  ylen = n;

  if (boundltype == -1)
    ylen = n - 1;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, ylen),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x2, n2),
                   __FUNCTION__ + ": X2 contains infinite or NAN values!"))
    return;

  HeapSortPPoints(x, y, p, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  ArrayResizeAL(dt, MathMax(n, n2));

  if (boundrtype == -1 && boundltype == -1) {
    for (i = 0; i <= n2 - 1; i++) {
      t = x2[i];
      CApServ::ApPeriodicMap(t, x[0], x[n - 1], t2);
      x2[i] = t;
    }
  }

  HeapSortPPoints(x2, dt, p2, n2);

  Spline1DGridDiffCubicInternal(x, y, n, boundltype, boundl, boundrtype, boundr,
                                d, a1, a2, a3, b, dt);
  Spline1DConvDiffInternal(x, y, d, n, x2, n2, y2, true, d1, false, d2, false);

  if (!CAp::Assert(CAp::Len(dt) >= n2, __FUNCTION__ + ": internal error!"))
    return;

  for (i = 0; i <= n2 - 1; i++)
    dt[p2[i]] = y2[i];
  for (i_ = 0; i_ <= n2 - 1; i_++)
    y2[i_] = dt[i_];
}

static void CSpline1D::Spline1DConvDiffCubic(
    double &cx[], double &cy[], const int n, const int boundltype,
    const double boundl, const int boundrtype, const double boundr,
    double &cx2[], const int n2, double &y2[], double &d2[]) {

  int i = 0;
  int ylen = 0;
  double t = 0;
  double t2 = 0;
  int i_ = 0;

  double a1[];
  double a2[];
  double a3[];
  double b[];
  double d[];
  double dt[];
  double rt1[];
  int p[];
  int p2[];
  double x[];
  double y[];
  double x2[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);
  ArrayCopy(x2, cx2);

  if (!CAp::Assert(((boundltype == -1 || boundltype == 0) || boundltype == 1) ||
                       boundltype == 2,
                   __FUNCTION__ + ": incorrect BoundLType!"))
    return;

  if (!CAp::Assert(((boundrtype == -1 || boundrtype == 0) || boundrtype == 1) ||
                       boundrtype == 2,
                   __FUNCTION__ + ": incorrect BoundRType!"))
    return;

  if (!CAp::Assert((boundrtype == -1 && boundltype == -1) ||
                       (boundrtype != -1 && boundltype != -1),
                   __FUNCTION__ + ": incorrect BoundLType/BoundRType!"))
    return;

  if (boundltype == 1 || boundltype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundl),
                     __FUNCTION__ + ": BoundL is infinite or NAN!"))
      return;
  }

  if (boundrtype == 1 || boundrtype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundr),
                     __FUNCTION__ + ": BoundR is infinite or NAN!"))
      return;
  }

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(n2 >= 2, __FUNCTION__ + "Spline1DConvDiffCubic: N2<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x2) >= n2, __FUNCTION__ + ": Length(X2)<N2!"))
    return;

  ylen = n;

  if (boundltype == -1)
    ylen = n - 1;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, ylen),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x2, n2),
                   __FUNCTION__ + ": X2 contains infinite or NAN values!"))
    return;

  HeapSortPPoints(x, y, p, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  ArrayResizeAL(dt, MathMax(n, n2));

  if (boundrtype == -1 && boundltype == -1) {
    for (i = 0; i <= n2 - 1; i++) {
      t = x2[i];
      CApServ::ApPeriodicMap(t, x[0], x[n - 1], t2);
      x2[i] = t;
    }
  }

  HeapSortPPoints(x2, dt, p2, n2);

  Spline1DGridDiffCubicInternal(x, y, n, boundltype, boundl, boundrtype, boundr,
                                d, a1, a2, a3, b, dt);
  Spline1DConvDiffInternal(x, y, d, n, x2, n2, y2, true, d2, true, rt1, false);

  if (!CAp::Assert(CAp::Len(dt) >= n2, __FUNCTION__ + ": internal error!"))
    return;

  for (i = 0; i <= n2 - 1; i++)
    dt[p2[i]] = y2[i];
  for (i_ = 0; i_ <= n2 - 1; i_++)
    y2[i_] = dt[i_];
  for (i = 0; i <= n2 - 1; i++)
    dt[p2[i]] = d2[i];
  for (i_ = 0; i_ <= n2 - 1; i_++)
    d2[i_] = dt[i_];
}

static void CSpline1D::Spline1DConvDiff2Cubic(
    double &cx[], double &cy[], const int n, const int boundltype,
    const double boundl, const int boundrtype, const double boundr,
    double &cx2[], const int n2, double &y2[], double &d2[], double &dd2[]) {

  int i = 0;
  int ylen = 0;
  double t = 0;
  double t2 = 0;
  int i_ = 0;

  double a1[];
  double a2[];
  double a3[];
  double b[];
  double d[];
  double dt[];
  int p[];
  int p2[];
  double x[];
  double y[];
  double x2[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);
  ArrayCopy(x2, cx2);

  if (!CAp::Assert(((boundltype == -1 || boundltype == 0) || boundltype == 1) ||
                       boundltype == 2,
                   __FUNCTION__ + ": incorrect BoundLType!"))
    return;

  if (!CAp::Assert(((boundrtype == -1 || boundrtype == 0) || boundrtype == 1) ||
                       boundrtype == 2,
                   __FUNCTION__ + ": incorrect BoundRType!"))
    return;

  if (!CAp::Assert((boundrtype == -1 && boundltype == -1) ||
                       (boundrtype != -1 && boundltype != -1),
                   __FUNCTION__ + ": incorrect BoundLType/BoundRType!"))
    return;

  if (boundltype == 1 || boundltype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundl),
                     __FUNCTION__ + ": BoundL is infinite or NAN!"))
      return;
  }

  if (boundrtype == 1 || boundrtype == 2) {

    if (!CAp::Assert(CMath::IsFinite(boundr),
                     __FUNCTION__ + ": BoundR is infinite or NAN!"))
      return;
  }

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(n2 >= 2, __FUNCTION__ + ": N2<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x2) >= n2, __FUNCTION__ + ": Length(X2)<N2!"))
    return;

  ylen = n;

  if (boundltype == -1)
    ylen = n - 1;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, ylen),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x2, n2),
                   __FUNCTION__ + ": X2 contains infinite or NAN values!"))
    return;

  HeapSortPPoints(x, y, p, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  ArrayResizeAL(dt, MathMax(n, n2));

  if (boundrtype == -1 && boundltype == -1) {
    for (i = 0; i <= n2 - 1; i++) {
      t = x2[i];
      CApServ::ApPeriodicMap(t, x[0], x[n - 1], t2);
      x2[i] = t;
    }
  }

  HeapSortPPoints(x2, dt, p2, n2);

  Spline1DGridDiffCubicInternal(x, y, n, boundltype, boundl, boundrtype, boundr,
                                d, a1, a2, a3, b, dt);
  Spline1DConvDiffInternal(x, y, d, n, x2, n2, y2, true, d2, true, dd2, true);

  if (!CAp::Assert(CAp::Len(dt) >= n2, __FUNCTION__ + ": internal error!"))
    return;

  for (i = 0; i <= n2 - 1; i++)
    dt[p2[i]] = y2[i];
  for (i_ = 0; i_ <= n2 - 1; i_++)
    y2[i_] = dt[i_];
  for (i = 0; i <= n2 - 1; i++)
    dt[p2[i]] = d2[i];
  for (i_ = 0; i_ <= n2 - 1; i_++)
    d2[i_] = dt[i_];
  for (i = 0; i <= n2 - 1; i++)
    dt[p2[i]] = dd2[i];
  for (i_ = 0; i_ <= n2 - 1; i_++)
    dd2[i_] = dt[i_];
}

static void CSpline1D::Spline1DBuildCatmullRom(double &cx[], double &cy[],
                                               const int n, const int boundtype,
                                               const double tension,
                                               CSpline1DInterpolant &c) {

  int i = 0;

  double d[];
  double x[];
  double y[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(boundtype == -1 || boundtype == 0,
                   __FUNCTION__ + ": incorrect BoundType!"))
    return;

  if (!CAp::Assert((double)(tension) >= 0.0, __FUNCTION__ + ": Tension<0!"))
    return;

  if (!CAp::Assert((double)(tension) <= (double)(1),
                   __FUNCTION__ + ": Tension>1!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  HeapSortPoints(x, y, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  if (n == 2 && boundtype == 0) {

    Spline1DBuildLinear(x, y, n, c);
    return;
  }
  if (n == 2 && boundtype == -1) {

    Spline1DBuildCubic(x, y, n, -1, 0.0, -1, 0.0, c);
    return;
  }

  if (boundtype == -1) {

    y[n - 1] = y[0];

    ArrayResizeAL(d, n);
    d[0] = (y[1] - y[n - 2]) / (2 * (x[1] - x[0] + x[n - 1] - x[n - 2]));
    for (i = 1; i <= n - 2; i++)
      d[i] = (1 - tension) * (y[i + 1] - y[i - 1]) / (x[i + 1] - x[i - 1]);
    d[n - 1] = d[0];

    Spline1DBuildHermite(x, y, d, n, c);
    c.m_periodic = true;
  } else {

    ArrayResizeAL(d, n);
    for (i = 1; i <= n - 2; i++)
      d[i] = (1 - tension) * (y[i + 1] - y[i - 1]) / (x[i + 1] - x[i - 1]);
    d[0] = 2 * (y[1] - y[0]) / (x[1] - x[0]) - d[1];
    d[n - 1] = 2 * (y[n - 1] - y[n - 2]) / (x[n - 1] - x[n - 2]) - d[n - 2];

    Spline1DBuildHermite(x, y, d, n, c);
  }
}

static void CSpline1D::Spline1DBuildHermite(double &cx[], double &cy[],
                                            double &cd[], const int n,
                                            CSpline1DInterpolant &c) {

  int i = 0;
  double delta = 0;
  double delta2 = 0;
  double delta3 = 0;

  double x[];
  double y[];
  double d[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);
  ArrayCopy(d, cd);

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(d) >= n, __FUNCTION__ + ": Length(D)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(d, n),
                   __FUNCTION__ + ": D contains infinite or NAN values!"))
    return;
  HeapSortDPoints(x, y, d, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  ArrayResizeAL(c.m_x, n);
  ArrayResizeAL(c.m_c, 4 * (n - 1));

  c.m_periodic = false;
  c.m_k = 3;
  c.m_n = n;

  for (i = 0; i <= n - 1; i++)
    c.m_x[i] = x[i];

  for (i = 0; i <= n - 2; i++) {
    delta = x[i + 1] - x[i];
    delta2 = CMath::Sqr(delta);
    delta3 = delta * delta2;
    c.m_c[4 * i + 0] = y[i];
    c.m_c[4 * i + 1] = d[i];
    c.m_c[4 * i + 2] =
        (3 * (y[i + 1] - y[i]) - 2 * d[i] * delta - d[i + 1] * delta) / delta2;
    c.m_c[4 * i + 3] =
        (2 * (y[i] - y[i + 1]) + d[i] * delta + d[i + 1] * delta) / delta3;
  }
}

static void CSpline1D::Spline1DBuildAkima(double &cx[], double &cy[],
                                          const int n,
                                          CSpline1DInterpolant &c) {

  int i = 0;

  double d[];
  double w[];
  double diff[];
  double x[];
  double y[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  if (!CAp::Assert(n >= 5, __FUNCTION__ + ": N<5!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  HeapSortPoints(x, y, n);

  if (!CAp::Assert(CApServ::AreDistinct(x, n),
                   __FUNCTION__ +
                       ": at least two consequent points are too close!"))
    return;

  ArrayResizeAL(w, n - 1);
  ArrayResizeAL(diff, n - 1);
  for (i = 0; i <= n - 2; i++)
    diff[i] = (y[i + 1] - y[i]) / (x[i + 1] - x[i]);
  for (i = 1; i <= n - 2; i++)
    w[i] = MathAbs(diff[i] - diff[i - 1]);

  ArrayResizeAL(d, n);
  for (i = 2; i <= n - 3; i++) {

    if (MathAbs(w[i - 1]) + MathAbs(w[i + 1]) != 0.0)
      d[i] =
          (w[i + 1] * diff[i - 1] + w[i - 1] * diff[i]) / (w[i + 1] + w[i - 1]);
    else
      d[i] = ((x[i + 1] - x[i]) * diff[i - 1] + (x[i] - x[i - 1]) * diff[i]) /
             (x[i + 1] - x[i - 1]);
  }

  d[0] = DiffThreePoint(x[0], x[0], y[0], x[1], y[1], x[2], y[2]);
  d[1] = DiffThreePoint(x[1], x[0], y[0], x[1], y[1], x[2], y[2]);
  d[n - 2] = DiffThreePoint(x[n - 2], x[n - 3], y[n - 3], x[n - 2], y[n - 2],
                            x[n - 1], y[n - 1]);
  d[n - 1] = DiffThreePoint(x[n - 1], x[n - 3], y[n - 3], x[n - 2], y[n - 2],
                            x[n - 1], y[n - 1]);

  Spline1DBuildHermite(x, y, d, n, c);
}

static double CSpline1D::Spline1DCalc(CSpline1DInterpolant &c, double x) {

  int l = 0;
  int r = 0;
  int m = 0;
  double t = 0;

  if (!CAp::Assert(c.m_k == 3, __FUNCTION__ + ": internal error"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(!CInfOrNaN::IsInfinity(x), __FUNCTION__ + ": infinite X!"))
    return (EMPTY_VALUE);

  if (CInfOrNaN::IsNaN(x))
    return (CInfOrNaN::NaN());

  if (c.m_periodic)
    CApServ::ApPeriodicMap(x, c.m_x[0], c.m_x[c.m_n - 1], t);

  l = 0;
  r = c.m_n - 2 + 1;
  while (l != r - 1) {
    m = (l + r) / 2;

    if (c.m_x[m] >= x)
      r = m;
    else
      l = m;
  }

  x = x - c.m_x[l];
  m = 4 * l;

  return (c.m_c[m] +
          x * (c.m_c[m + 1] + x * (c.m_c[m + 2] + x * c.m_c[m + 3])));
}

static void CSpline1D::Spline1DDiff(CSpline1DInterpolant &c, double x,
                                    double &s, double &ds, double &d2s) {

  int l = 0;
  int r = 0;
  int m = 0;
  double t = 0;

  s = 0;
  ds = 0;
  d2s = 0;

  if (!CAp::Assert(c.m_k == 3, __FUNCTION__ + ": internal error"))
    return;

  if (!CAp::Assert(!CInfOrNaN::IsInfinity(x), __FUNCTION__ + ": infinite X!"))
    return;

  if (CInfOrNaN::IsNaN(x)) {

    s = CInfOrNaN::NaN();
    ds = CInfOrNaN::NaN();
    d2s = CInfOrNaN::NaN();

    return;
  }

  if (c.m_periodic)
    CApServ::ApPeriodicMap(x, c.m_x[0], c.m_x[c.m_n - 1], t);

  l = 0;
  r = c.m_n - 2 + 1;
  while (l != r - 1) {
    m = (l + r) / 2;

    if (c.m_x[m] >= x)
      r = m;
    else
      l = m;
  }

  x = x - c.m_x[l];
  m = 4 * l;
  s = c.m_c[m] + x * (c.m_c[m + 1] + x * (c.m_c[m + 2] + x * c.m_c[m + 3]));
  ds = c.m_c[m + 1] + 2 * x * c.m_c[m + 2] + 3 * CMath::Sqr(x) * c.m_c[m + 3];
  d2s = 2 * c.m_c[m + 2] + 6 * x * c.m_c[m + 3];
}

static void CSpline1D::Spline1DCopy(CSpline1DInterpolant &c,
                                    CSpline1DInterpolant &cc) {

  int i_ = 0;

  cc.m_periodic = c.m_periodic;
  cc.m_n = c.m_n;
  cc.m_k = c.m_k;

  ArrayResizeAL(cc.m_x, cc.m_n);

  for (i_ = 0; i_ <= cc.m_n - 1; i_++)
    cc.m_x[i_] = c.m_x[i_];

  ArrayResizeAL(cc.m_c, (cc.m_k + 1) * (cc.m_n - 1));

  for (i_ = 0; i_ <= (cc.m_k + 1) * (cc.m_n - 1) - 1; i_++)
    cc.m_c[i_] = c.m_c[i_];
}

static void CSpline1D::Spline1DUnpack(CSpline1DInterpolant &c, int &n,
                                      CMatrixDouble &tbl) {

  int i = 0;
  int j = 0;

  tbl.Resize(c.m_n - 2 + 1, 2 + c.m_k + 1);

  n = c.m_n;

  for (i = 0; i <= n - 2; i++) {
    tbl[i].Set(0, c.m_x[i]);
    tbl[i].Set(1, c.m_x[i + 1]);
    for (j = 0; j <= c.m_k; j++)
      tbl[i].Set(2 + j, c.m_c[(c.m_k + 1) * i + j]);
  }
}

static void CSpline1D::Spline1DLinTransX(CSpline1DInterpolant &c,
                                         const double a, const double b) {

  int i = 0;
  int j = 0;
  int n = 0;
  double v = 0;
  double dv = 0;
  double d2v = 0;

  double x[];
  double y[];
  double d[];

  n = c.m_n;

  if (a == 0.0) {
    v = Spline1DCalc(c, b);
    for (i = 0; i <= n - 2; i++) {
      c.m_c[(c.m_k + 1) * i] = v;
      for (j = 1; j <= c.m_k; j++)
        c.m_c[(c.m_k + 1) * i + j] = 0;
    }

    return;
  }

  if (!CAp::Assert(c.m_k == 3, __FUNCTION__ + ": internal error"))
    return;

  ArrayResizeAL(x, n);
  ArrayResizeAL(y, n);
  ArrayResizeAL(d, n);

  for (i = 0; i <= n - 1; i++) {
    x[i] = c.m_x[i];
    Spline1DDiff(c, x[i], v, dv, d2v);
    x[i] = (x[i] - b) / a;
    y[i] = v;
    d[i] = a * dv;
  }

  Spline1DBuildHermite(x, y, d, n, c);
}

static void CSpline1D::Spline1DLinTransY(CSpline1DInterpolant &c,
                                         const double a, const double b) {

  int i = 0;
  int j = 0;
  int n = 0;

  n = c.m_n;

  for (i = 0; i <= n - 2; i++) {
    c.m_c[(c.m_k + 1) * i] = a * c.m_c[(c.m_k + 1) * i] + b;
    for (j = 1; j <= c.m_k; j++)
      c.m_c[(c.m_k + 1) * i + j] = a * c.m_c[(c.m_k + 1) * i + j];
  }
}

static double CSpline1D::Spline1DIntegrate(CSpline1DInterpolant &c, double x) {

  double result = 0;
  int n = 0;
  int i = 0;
  int j = 0;
  int l = 0;
  int r = 0;
  int m = 0;
  double w = 0;
  double v = 0;
  double t = 0;
  double intab = 0;
  double additionalterm = 0;

  n = c.m_n;

  if (c.m_periodic && (x < c.m_x[0] || x > c.m_x[c.m_n - 1])) {

    intab = 0;
    for (i = 0; i <= c.m_n - 2; i++) {
      w = c.m_x[i + 1] - c.m_x[i];
      m = (c.m_k + 1) * i;
      intab = intab + c.m_c[m] * w;
      v = w;
      for (j = 1; j <= c.m_k; j++) {
        v = v * w;
        intab = intab + c.m_c[m + j] * v / (j + 1);
      }
    }

    CApServ::ApPeriodicMap(x, c.m_x[0], c.m_x[c.m_n - 1], t);
    additionalterm = t * intab;
  } else
    additionalterm = 0;

  l = 0;
  r = n - 2 + 1;
  while (l != r - 1) {
    m = (l + r) / 2;

    if (c.m_x[m] >= x)
      r = m;
    else
      l = m;
  }

  result = 0;
  for (i = 0; i <= l - 1; i++) {
    w = c.m_x[i + 1] - c.m_x[i];
    m = (c.m_k + 1) * i;
    result = result + c.m_c[m] * w;
    v = w;

    for (j = 1; j <= c.m_k; j++) {
      v = v * w;
      result = result + c.m_c[m + j] * v / (j + 1);
    }
  }

  w = x - c.m_x[l];
  m = (c.m_k + 1) * l;
  v = w;
  result = result + c.m_c[m] * w;

  for (j = 1; j <= c.m_k; j++) {
    v = v * w;
    result = result + c.m_c[m + j] * v / (j + 1);
  }

  return (result + additionalterm);
}

static void CSpline1D::Spline1DConvDiffInternal(
    double &xold[], double &yold[], double &dold[], const int n, double &x2[],
    const int n2, double &y[], const bool needy, double &d1[],
    const bool needd1, double &d2[], const bool needd2) {

  int intervalindex = 0;
  int pointindex = 0;
  bool havetoadvance;
  double c0 = 0;
  double c1 = 0;
  double c2 = 0;
  double c3 = 0;
  double a = 0;
  double b = 0;
  double w = 0;
  double w2 = 0;
  double w3 = 0;
  double fa = 0;
  double fb = 0;
  double da = 0;
  double db = 0;
  double t = 0;

  if (needy && CAp::Len(y) < n2)
    ArrayResizeAL(y, n2);

  if (needd1 && CAp::Len(d1) < n2)
    ArrayResizeAL(d1, n2);

  if (needd2 && CAp::Len(d2) < n2)
    ArrayResizeAL(d2, n2);

  c0 = 0;
  c1 = 0;
  c2 = 0;
  c3 = 0;
  a = 0;
  b = 0;

  intervalindex = -1;
  pointindex = 0;

  while (true) {

    if (pointindex >= n2)
      break;
    t = x2[pointindex];

    havetoadvance = false;

    if (intervalindex == -1)
      havetoadvance = true;
    else {

      if (intervalindex < n - 2)
        havetoadvance = t >= b;
    }

    if (havetoadvance) {

      intervalindex = intervalindex + 1;
      a = xold[intervalindex];
      b = xold[intervalindex + 1];
      w = b - a;
      w2 = w * w;
      w3 = w * w2;
      fa = yold[intervalindex];
      fb = yold[intervalindex + 1];
      da = dold[intervalindex];
      db = dold[intervalindex + 1];
      c0 = fa;
      c1 = da;
      c2 = (3 * (fb - fa) - 2 * da * w - db * w) / w2;
      c3 = (2 * (fa - fb) + da * w + db * w) / w3;
      continue;
    }

    t = t - a;
    if (needy)
      y[pointindex] = c0 + t * (c1 + t * (c2 + t * c3));

    if (needd1)
      d1[pointindex] = c1 + 2 * t * c2 + 3 * t * t * c3;

    if (needd2)
      d2[pointindex] = 2 * c2 + 6 * t * c3;

    pointindex = pointindex + 1;
  }
}

static void CSpline1D::HeapSortDPoints(double &x[], double &y[], double &d[],
                                       const int n) {

  int i = 0;
  int i_ = 0;

  double rbuf[];
  int ibuf[];
  double rbuf2[];
  int ibuf2[];

  ArrayResizeAL(ibuf, n);
  ArrayResizeAL(rbuf, n);
  for (i = 0; i <= n - 1; i++)
    ibuf[i] = i;

  CTSort::TagSortFastI(x, ibuf, rbuf2, ibuf2, n);

  for (i = 0; i <= n - 1; i++)
    rbuf[i] = y[ibuf[i]];
  for (i_ = 0; i_ <= n - 1; i_++)
    y[i_] = rbuf[i_];
  for (i = 0; i <= n - 1; i++)
    rbuf[i] = d[ibuf[i]];
  for (i_ = 0; i_ <= n - 1; i_++)
    d[i_] = rbuf[i_];
}

static void CSpline1D::Spline1DGridDiffCubicInternal(
    double &x[], double &y[], const int n, const int boundltype,
    const double boundl, const int boundrtype, const double boundr, double &d[],
    double &a1[], double &a2[], double &a3[], double &b[], double &dt[]) {

  int i = 0;
  int i_ = 0;

  if (CAp::Len(d) < n)
    ArrayResizeAL(d, n);

  if (CAp::Len(a1) < n)
    ArrayResizeAL(a1, n);

  if (CAp::Len(a2) < n)
    ArrayResizeAL(a2, n);

  if (CAp::Len(a3) < n)
    ArrayResizeAL(a3, n);

  if (CAp::Len(b) < n)
    ArrayResizeAL(b, n);

  if (CAp::Len(dt) < n)
    ArrayResizeAL(dt, n);

  if ((n == 2 && boundltype == 0) && boundrtype == 0) {

    d[0] = (y[1] - y[0]) / (x[1] - x[0]);
    d[1] = d[0];

    return;
  }

  if ((n == 2 && boundltype == -1) && boundrtype == -1) {

    d[0] = 0;
    d[1] = 0;

    return;
  }

  if (boundrtype == -1 && boundltype == -1) {

    y[n - 1] = y[0];

    a1[0] = x[1] - x[0];
    a2[0] = 2 * (x[1] - x[0] + x[n - 1] - x[n - 2]);
    a3[0] = x[n - 1] - x[n - 2];
    b[0] = 3 * (y[n - 1] - y[n - 2]) / (x[n - 1] - x[n - 2]) * (x[1] - x[0]) +
           3 * (y[1] - y[0]) / (x[1] - x[0]) * (x[n - 1] - x[n - 2]);

    for (i = 1; i <= n - 2; i++) {

      a1[i] = x[i + 1] - x[i];
      a2[i] = 2 * (x[i + 1] - x[i - 1]);
      a3[i] = x[i] - x[i - 1];
      b[i] = 3 * (y[i] - y[i - 1]) / (x[i] - x[i - 1]) * (x[i + 1] - x[i]) +
             3 * (y[i + 1] - y[i]) / (x[i + 1] - x[i]) * (x[i] - x[i - 1]);
    }

    SolveCyclicTridiagonal(a1, a2, a3, b, n - 1, dt);
    for (i_ = 0; i_ <= n - 2; i_++)
      d[i_] = dt[i_];
    d[n - 1] = d[0];
  } else {

    if (boundltype == 0) {

      a1[0] = 0;
      a2[0] = 1;
      a3[0] = 1;
      b[0] = 2 * (y[1] - y[0]) / (x[1] - x[0]);
    }

    if (boundltype == 1) {

      a1[0] = 0;
      a2[0] = 1;
      a3[0] = 0;
      b[0] = boundl;
    }

    if (boundltype == 2) {

      a1[0] = 0;
      a2[0] = 2;
      a3[0] = 1;
      b[0] = 3 * (y[1] - y[0]) / (x[1] - x[0]) - 0.5 * boundl * (x[1] - x[0]);
    }

    for (i = 1; i <= n - 2; i++) {
      a1[i] = x[i + 1] - x[i];
      a2[i] = 2 * (x[i + 1] - x[i - 1]);
      a3[i] = x[i] - x[i - 1];
      b[i] = 3 * (y[i] - y[i - 1]) / (x[i] - x[i - 1]) * (x[i + 1] - x[i]) +
             3 * (y[i + 1] - y[i]) / (x[i + 1] - x[i]) * (x[i] - x[i - 1]);
    }

    if (boundrtype == 0) {

      a1[n - 1] = 1;
      a2[n - 1] = 1;
      a3[n - 1] = 0;
      b[n - 1] = 2 * (y[n - 1] - y[n - 2]) / (x[n - 1] - x[n - 2]);
    }

    if (boundrtype == 1) {

      a1[n - 1] = 0;
      a2[n - 1] = 1;
      a3[n - 1] = 0;
      b[n - 1] = boundr;
    }

    if (boundrtype == 2) {

      a1[n - 1] = 1;
      a2[n - 1] = 2;
      a3[n - 1] = 0;
      b[n - 1] = 3 * (y[n - 1] - y[n - 2]) / (x[n - 1] - x[n - 2]) +
                 0.5 * boundr * (x[n - 1] - x[n - 2]);
    }

    SolveTridiagonal(a1, a2, a3, b, n, d);
  }
}

static void CSpline1D::HeapSortPoints(double &x[], double &y[], const int n) {

  double bufx[];
  double bufy[];

  CTSort::TagSortFastR(x, y, bufx, bufy, n);
}

static void CSpline1D::HeapSortPPoints(double &x[], double &y[], int &p[],
                                       const int n) {

  int i = 0;
  int i_ = 0;

  double rbuf[];
  int ibuf[];

  if (CAp::Len(p) < n)
    ArrayResizeAL(p, n);

  ArrayResizeAL(rbuf, n);

  for (i = 0; i <= n - 1; i++)
    p[i] = i;

  CTSort::TagSortFastI(x, p, rbuf, ibuf, n);

  for (i = 0; i <= n - 1; i++)
    rbuf[i] = y[p[i]];
  for (i_ = 0; i_ <= n - 1; i_++)
    y[i_] = rbuf[i_];
}

static void CSpline1D::SolveTridiagonal(double &a[], double &cb[], double &c[],
                                        double &cd[], const int n,
                                        double &x[]) {

  int k = 0;
  double t = 0;

  double d[];
  double b[];

  ArrayCopy(d, cd);
  ArrayCopy(b, cb);

  if (CAp::Len(x) < n)
    ArrayResizeAL(x, n);

  for (k = 1; k <= n - 1; k++) {
    t = a[k] / b[k - 1];
    b[k] = b[k] - t * c[k - 1];
    d[k] = d[k] - t * d[k - 1];
  }
  x[n - 1] = d[n - 1] / b[n - 1];
  for (k = n - 2; k >= 0; k--)
    x[k] = (d[k] - c[k] * x[k + 1]) / b[k];
}

static void CSpline1D::SolveCyclicTridiagonal(double &a[], double &cb[],
                                              double &c[], double &d[],
                                              const int n, double &x[]) {

  int k = 0;
  double alpha = 0;
  double beta = 0;
  double gamma = 0;

  double y[];
  double z[];
  double u[];
  double b[];

  ArrayCopy(b, cb);

  if (CAp::Len(x) < n)
    ArrayResizeAL(x, n);

  beta = a[0];
  alpha = c[n - 1];
  gamma = -b[0];
  b[0] = 2 * b[0];
  b[n - 1] = b[n - 1] - alpha * beta / gamma;

  ArrayResizeAL(u, n);

  for (k = 0; k <= n - 1; k++)
    u[k] = 0;
  u[0] = gamma;
  u[n - 1] = alpha;

  SolveTridiagonal(a, b, c, d, n, y);

  SolveTridiagonal(a, b, c, u, n, z);

  for (k = 0; k <= n - 1; k++)
    x[k] = y[k] - (y[0] + beta / gamma * y[n - 1]) /
                      (1 + z[0] + beta / gamma * z[n - 1]) * z[k];
}

static double CSpline1D::DiffThreePoint(double t, const double x0,
                                        const double f0, double x1,
                                        const double f1, double x2,
                                        const double f2) {

  double a = 0;
  double b = 0;

  t = t - x0;
  x1 = x1 - x0;
  x2 = x2 - x0;
  a = (f2 - f0 - x2 / x1 * (f1 - f0)) / (CMath::Sqr(x2) - x1 * x2);
  b = (f1 - f0 - a * CMath::Sqr(x1)) / x1;

  return (2 * a * t + b);
}

class CPolynomialFitReport {
public:
  double m_taskrcond;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;
  double m_maxerror;

  CPolynomialFitReport(void);
  ~CPolynomialFitReport(void);

  void Copy(CPolynomialFitReport &obj);
};

CPolynomialFitReport::CPolynomialFitReport(void) {}

CPolynomialFitReport::~CPolynomialFitReport(void) {}

void CPolynomialFitReport::Copy(CPolynomialFitReport &obj) {

  m_taskrcond = obj.m_taskrcond;
  m_rmserror = obj.m_rmserror;
  m_avgerror = obj.m_avgerror;
  m_avgrelerror = obj.m_avgrelerror;
  m_maxerror = obj.m_maxerror;
}

class CPolynomialFitReportShell {
private:
  CPolynomialFitReport m_innerobj;

public:
  CPolynomialFitReportShell(void);
  CPolynomialFitReportShell(CPolynomialFitReport &obj);
  ~CPolynomialFitReportShell(void);

  double GetTaskRCond(void);
  void SetTaskRCond(const double d);
  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  double GetMaxError(void);
  void SetMaxError(const double d);
  CPolynomialFitReport *GetInnerObj(void);
};

CPolynomialFitReportShell::CPolynomialFitReportShell(void) {}

CPolynomialFitReportShell::CPolynomialFitReportShell(
    CPolynomialFitReport &obj) {

  m_innerobj.Copy(obj);
}

CPolynomialFitReportShell::~CPolynomialFitReportShell(void) {}

double CPolynomialFitReportShell::GetTaskRCond(void) {

  return (m_innerobj.m_taskrcond);
}

void CPolynomialFitReportShell::SetTaskRCond(const double d) {

  m_innerobj.m_taskrcond = d;
}

double CPolynomialFitReportShell::GetRMSError(void) {

  return (m_innerobj.m_rmserror);
}

void CPolynomialFitReportShell::SetRMSError(const double d) {

  m_innerobj.m_rmserror = d;
}

double CPolynomialFitReportShell::GetAvgError(void) {

  return (m_innerobj.m_avgerror);
}

void CPolynomialFitReportShell::SetAvgError(const double d) {

  m_innerobj.m_avgerror = d;
}

double CPolynomialFitReportShell::GetAvgRelError(void) {

  return (m_innerobj.m_avgrelerror);
}

void CPolynomialFitReportShell::SetAvgRelError(const double d) {

  m_innerobj.m_avgrelerror = d;
}

double CPolynomialFitReportShell::GetMaxError(void) {

  return (m_innerobj.m_maxerror);
}

void CPolynomialFitReportShell::SetMaxError(const double d) {

  m_innerobj.m_maxerror = d;
}

CPolynomialFitReport *CPolynomialFitReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CBarycentricFitReport {
public:
  double m_taskrcond;
  int m_dbest;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;
  double m_maxerror;

  CBarycentricFitReport(void);
  ~CBarycentricFitReport(void);

  void Copy(CBarycentricFitReport &obj);
};

CBarycentricFitReport::CBarycentricFitReport(void) {}

CBarycentricFitReport::~CBarycentricFitReport(void) {}

void CBarycentricFitReport::Copy(CBarycentricFitReport &obj) {

  m_taskrcond = obj.m_taskrcond;
  m_dbest = obj.m_dbest;
  m_rmserror = obj.m_rmserror;
  m_avgerror = obj.m_avgerror;
  m_avgrelerror = obj.m_avgrelerror;
  m_maxerror = obj.m_maxerror;
}

class CBarycentricFitReportShell {
private:
  CBarycentricFitReport m_innerobj;

public:
  CBarycentricFitReportShell(void);
  CBarycentricFitReportShell(CBarycentricFitReport &obj);
  ~CBarycentricFitReportShell(void);

  double GetTaskRCond(void);
  void SetTaskRCond(const double d);
  int GetDBest(void);
  void SetDBest(const int i);
  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  double GetMaxError(void);
  void SetMaxError(const double d);
  CBarycentricFitReport *GetInnerObj(void);
};

CBarycentricFitReportShell::CBarycentricFitReportShell(void) {}

CBarycentricFitReportShell::CBarycentricFitReportShell(
    CBarycentricFitReport &obj) {

  m_innerobj.Copy(obj);
}

CBarycentricFitReportShell::~CBarycentricFitReportShell(void) {}

double CBarycentricFitReportShell::GetTaskRCond(void) {

  return (m_innerobj.m_taskrcond);
}

void CBarycentricFitReportShell::SetTaskRCond(const double d) {

  m_innerobj.m_taskrcond = d;
}

int CBarycentricFitReportShell::GetDBest(void) {

  return (m_innerobj.m_dbest);
}

void CBarycentricFitReportShell::SetDBest(const int i) {

  m_innerobj.m_dbest = i;
}

double CBarycentricFitReportShell::GetRMSError(void) {

  return (m_innerobj.m_rmserror);
}

void CBarycentricFitReportShell::SetRMSError(const double d) {

  m_innerobj.m_rmserror = d;
}

double CBarycentricFitReportShell::GetAvgError(void) {

  return (m_innerobj.m_avgerror);
}

void CBarycentricFitReportShell::SetAvgError(const double d) {

  m_innerobj.m_avgerror = d;
}

double CBarycentricFitReportShell::GetAvgRelError(void) {

  return (m_innerobj.m_avgrelerror);
}

void CBarycentricFitReportShell::SetAvgRelError(const double d) {

  m_innerobj.m_avgrelerror = d;
}

double CBarycentricFitReportShell::GetMaxError(void) {

  return (m_innerobj.m_maxerror);
}

void CBarycentricFitReportShell::SetMaxError(const double d) {

  m_innerobj.m_maxerror = d;
}

CBarycentricFitReport *CBarycentricFitReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CSpline1DFitReport {
public:
  double m_taskrcond;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;
  double m_maxerror;

  CSpline1DFitReport(void);
  ~CSpline1DFitReport(void);

  void Copy(CSpline1DFitReport &obj);
};

CSpline1DFitReport::CSpline1DFitReport(void) {}

CSpline1DFitReport::~CSpline1DFitReport(void) {}

void CSpline1DFitReport::Copy(CSpline1DFitReport &obj) {

  m_taskrcond = obj.m_taskrcond;
  m_rmserror = obj.m_rmserror;
  m_avgerror = obj.m_avgerror;
  m_avgrelerror = obj.m_avgrelerror;
  m_maxerror = obj.m_maxerror;
}

class CSpline1DFitReportShell {
private:
  CSpline1DFitReport m_innerobj;

public:
  CSpline1DFitReportShell(void);
  CSpline1DFitReportShell(CSpline1DFitReport &obj);
  ~CSpline1DFitReportShell(void);

  double GetTaskRCond(void);
  void SetTaskRCond(const double d);
  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  double GetMaxError(void);
  void SetMaxError(const double d);
  CSpline1DFitReport *GetInnerObj(void);
};

CSpline1DFitReportShell::CSpline1DFitReportShell(void) {}

CSpline1DFitReportShell::CSpline1DFitReportShell(CSpline1DFitReport &obj) {

  m_innerobj.Copy(obj);
}

CSpline1DFitReportShell::~CSpline1DFitReportShell(void) {}

double CSpline1DFitReportShell::GetTaskRCond(void) {

  return (m_innerobj.m_taskrcond);
}

void CSpline1DFitReportShell::SetTaskRCond(const double d) {

  m_innerobj.m_taskrcond = d;
}

double CSpline1DFitReportShell::GetRMSError(void) {

  return (m_innerobj.m_rmserror);
}

void CSpline1DFitReportShell::SetRMSError(const double d) {

  m_innerobj.m_rmserror = d;
}

double CSpline1DFitReportShell::GetAvgError(void) {

  return (m_innerobj.m_avgerror);
}

void CSpline1DFitReportShell::SetAvgError(const double d) {

  m_innerobj.m_avgerror = d;
}

double CSpline1DFitReportShell::GetAvgRelError(void) {

  return (m_innerobj.m_avgrelerror);
}

void CSpline1DFitReportShell::SetAvgRelError(const double d) {

  m_innerobj.m_avgrelerror = d;
}

double CSpline1DFitReportShell::GetMaxError(void) {

  return (m_innerobj.m_maxerror);
}

void CSpline1DFitReportShell::SetMaxError(const double d) {

  m_innerobj.m_maxerror = d;
}

CSpline1DFitReport *CSpline1DFitReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CLSFitReport {
public:
  double m_taskrcond;
  int m_iterationscount;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;
  double m_maxerror;
  double m_wrmserror;

  CLSFitReport(void);
  ~CLSFitReport(void);

  void Copy(CLSFitReport &obj);
};

CLSFitReport::CLSFitReport(void) {}

CLSFitReport::~CLSFitReport(void) {}

void CLSFitReport::Copy(CLSFitReport &obj) {

  m_taskrcond = obj.m_taskrcond;
  m_iterationscount = obj.m_iterationscount;
  m_rmserror = obj.m_rmserror;
  m_avgerror = obj.m_avgerror;
  m_avgrelerror = obj.m_avgrelerror;
  m_maxerror = obj.m_maxerror;
  m_wrmserror = obj.m_wrmserror;
}

class CLSFitReportShell {
private:
  CLSFitReport m_innerobj;

public:
  CLSFitReportShell(void);
  CLSFitReportShell(CLSFitReport &obj);
  ~CLSFitReportShell(void);

  double GetTaskRCond(void);
  void SetTaskRCond(const double d);
  int GetIterationsCount(void);
  void SetIterationsCount(const int i);
  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  double GetMaxError(void);
  void SetMaxError(const double d);
  double GetWRMSError(void);
  void SetWRMSError(const double d);
  CLSFitReport *GetInnerObj(void);
};

CLSFitReportShell::CLSFitReportShell(void) {}

CLSFitReportShell::CLSFitReportShell(CLSFitReport &obj) {

  m_innerobj.Copy(obj);
}

CLSFitReportShell::~CLSFitReportShell(void) {}

double CLSFitReportShell::GetTaskRCond(void) {

  return (m_innerobj.m_taskrcond);
}

void CLSFitReportShell::SetTaskRCond(const double d) {

  m_innerobj.m_taskrcond = d;
}

int CLSFitReportShell::GetIterationsCount(void) {

  return (m_innerobj.m_iterationscount);
}

void CLSFitReportShell::SetIterationsCount(const int i) {

  m_innerobj.m_iterationscount = i;
}

double CLSFitReportShell::GetRMSError(void) {

  return (m_innerobj.m_rmserror);
}

void CLSFitReportShell::SetRMSError(const double d) {

  m_innerobj.m_rmserror = d;
}

double CLSFitReportShell::GetAvgError(void) {

  return (m_innerobj.m_avgerror);
}

void CLSFitReportShell::SetAvgError(const double d) {

  m_innerobj.m_avgerror = d;
}

double CLSFitReportShell::GetAvgRelError(void) {

  return (m_innerobj.m_avgrelerror);
}

void CLSFitReportShell::SetAvgRelError(const double d) {

  m_innerobj.m_avgrelerror = d;
}

double CLSFitReportShell::GetMaxError(void) {

  return (m_innerobj.m_maxerror);
}

void CLSFitReportShell::SetMaxError(const double d) {

  m_innerobj.m_maxerror = d;
}

double CLSFitReportShell::GetWRMSError(void) {

  return (m_innerobj.m_wrmserror);
}

void CLSFitReportShell::SetWRMSError(const double d) {

  m_innerobj.m_wrmserror = d;
}

CLSFitReport *CLSFitReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CLSFitState {
public:
  int m_optalgo;
  int m_m;
  int m_k;
  double m_f;
  double m_epsf;
  double m_epsx;
  int m_maxits;
  double m_stpmax;
  bool m_xrep;
  int m_npoints;
  int m_nweights;
  int m_wkind;
  int m_wits;
  bool m_xupdated;
  bool m_needf;
  bool m_needfg;
  bool m_needfgh;
  int m_pointindex;
  int m_repiterationscount;
  int m_repterminationtype;
  double m_reprmserror;
  double m_repavgerror;
  double m_repavgrelerror;
  double m_repmaxerror;
  double m_repwrmserror;
  CMinLMState m_optstate;
  CMinLMReport m_optrep;
  int m_prevnpt;
  int m_prevalgo;
  RCommState m_rstate;

  double m_s[];
  double m_bndl[];
  double m_bndu[];
  double m_tasky[];
  double m_w[];
  double m_x[];
  double m_c[];
  double m_g[];

  CMatrixDouble m_taskx;
  CMatrixDouble m_h;

  CLSFitState(void);
  ~CLSFitState(void);

  void Copy(CLSFitState &obj);
};

CLSFitState::CLSFitState(void) {}

CLSFitState::~CLSFitState(void) {}

void CLSFitState::Copy(CLSFitState &obj) {

  m_optalgo = obj.m_optalgo;
  m_m = obj.m_m;
  m_k = obj.m_k;
  m_f = obj.m_f;
  m_epsf = obj.m_epsf;
  m_epsx = obj.m_epsx;
  m_maxits = obj.m_maxits;
  m_stpmax = obj.m_stpmax;
  m_xrep = obj.m_xrep;
  m_npoints = obj.m_npoints;
  m_nweights = obj.m_nweights;
  m_wkind = obj.m_wkind;
  m_wits = obj.m_wits;
  m_xupdated = obj.m_xupdated;
  m_needf = obj.m_needf;
  m_needfg = obj.m_needfg;
  m_needfgh = obj.m_needfgh;
  m_pointindex = obj.m_pointindex;
  m_repiterationscount = obj.m_repiterationscount;
  m_repterminationtype = obj.m_repterminationtype;
  m_reprmserror = obj.m_reprmserror;
  m_repavgerror = obj.m_repavgerror;
  m_repavgrelerror = obj.m_repavgrelerror;
  m_repmaxerror = obj.m_repmaxerror;
  m_repwrmserror = obj.m_repwrmserror;
  m_prevnpt = obj.m_prevnpt;
  m_prevalgo = obj.m_prevalgo;
  m_optstate.Copy(obj.m_optstate);
  m_optrep.Copy(obj.m_optrep);
  m_rstate.Copy(obj.m_rstate);

  ArrayCopy(m_s, obj.m_s);
  ArrayCopy(m_bndl, obj.m_bndl);
  ArrayCopy(m_bndu, obj.m_bndu);
  ArrayCopy(m_tasky, obj.m_tasky);
  ArrayCopy(m_w, obj.m_w);
  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_c, obj.m_c);
  ArrayCopy(m_g, obj.m_g);

  m_taskx = obj.m_taskx;
  m_h = obj.m_h;
}

class CLSFitStateShell {
private:
  CLSFitState m_innerobj;

public:
  CLSFitStateShell(void);
  CLSFitStateShell(CLSFitState &obj);
  ~CLSFitStateShell(void);

  bool GetNeedF(void);
  void SetNeedF(const bool b);
  bool GetNeedFG(void);
  void SetNeedFG(const bool b);
  bool GetNeedFGH(void);
  void SetNeedFGH(const bool b);
  bool GetXUpdated(void);
  void SetXUpdated(const bool b);
  double GetF(void);
  void SetF(const double d);
  CLSFitState *GetInnerObj(void);
};

CLSFitStateShell::CLSFitStateShell(void) {}

CLSFitStateShell::CLSFitStateShell(CLSFitState &obj) {

  m_innerobj.Copy(obj);
}

CLSFitStateShell::~CLSFitStateShell(void) {}

bool CLSFitStateShell::GetNeedF(void) {

  return (m_innerobj.m_needf);
}

void CLSFitStateShell::SetNeedF(const bool b) {

  m_innerobj.m_needf = b;
}

bool CLSFitStateShell::GetNeedFG(void) {

  return (m_innerobj.m_needfg);
}

void CLSFitStateShell::SetNeedFG(const bool b) {

  m_innerobj.m_needfg = b;
}

bool CLSFitStateShell::GetNeedFGH(void) {

  return (m_innerobj.m_needfgh);
}

void CLSFitStateShell::SetNeedFGH(const bool b) {

  m_innerobj.m_needfgh = b;
}

bool CLSFitStateShell::GetXUpdated(void) {

  return (m_innerobj.m_xupdated);
}

void CLSFitStateShell::SetXUpdated(const bool b) {

  m_innerobj.m_xupdated = b;
}

double CLSFitStateShell::GetF(void) {

  return (m_innerobj.m_f);
}

void CLSFitStateShell::SetF(const double d) {

  m_innerobj.m_f = d;
}

CLSFitState *CLSFitStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CLSFit {
private:
  static void Spline1DFitInternal(const int st, double &cx[], double &cy[],
                                  double &cw[], const int n, double &cxc[],
                                  double &cyc[], int &dc[], const int k,
                                  const int m, int &info,
                                  CSpline1DInterpolant &s,
                                  CSpline1DFitReport &rep);
  static void LSFitLinearInternal(double &y[], double &w[],
                                  CMatrixDouble &fmatrix, const int n,
                                  const int m, int &info, double &c[],
                                  CLSFitReport &rep);
  static void LSFitClearRequestFields(CLSFitState &state);
  static void BarycentricCalcBasis(CBarycentricInterpolant &b, const double t,
                                   double &y[]);
  static void InternalChebyshevFit(double &x[], double &y[], double &w[],
                                   const int n, double &cxc[], double &cyc[],
                                   int &dc[], const int k, const int m,
                                   int &info, double &c[], CLSFitReport &rep);
  static void BarycentricFitWCFixedD(double &cx[], double &cy[], double &cw[],
                                     const int n, double &cxc[], double &cyc[],
                                     int &dc[], const int k, const int m,
                                     const int d, int &info,
                                     CBarycentricInterpolant &b,
                                     CBarycentricFitReport &rep);

  static void Func_lbl_rcomm(CLSFitState &state, int n, int m, int k, int i,
                             int j, double v, double vv, double relcnt);
  static bool Func_lbl_7(CLSFitState &state, int &n, int &m, int &k, int &i,
                         int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_11(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_14(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_16(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_21(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_24(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_26(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_29(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_31(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);
  static bool Func_lbl_38(CLSFitState &state, int &n, int &m, int &k, int &i,
                          int &j, double &v, double &vv, double &relcnt);

public:
  static const int m_rfsmax;

  CLSFit(void);
  ~CLSFit(void);

  static void PolynomialFit(double &x[], double &y[], const int n, const int m,
                            int &info, CBarycentricInterpolant &p,
                            CPolynomialFitReport &rep);
  static void PolynomialFitWC(double &cx[], double &cy[], double &cw[],
                              const int n, double &cxc[], double &cyc[],
                              int &dc[], const int k, const int m, int &info,
                              CBarycentricInterpolant &p,
                              CPolynomialFitReport &rep);
  static void BarycentricFitFloaterHormannWC(
      double &x[], double &y[], double &w[], const int n, double &xc[],
      double &yc[], int &dc[], const int k, const int m, int &info,
      CBarycentricInterpolant &b, CBarycentricFitReport &rep);
  static void BarycentricFitFloaterHormann(double &x[], double &y[],
                                           const int n, const int m, int &info,
                                           CBarycentricInterpolant &b,
                                           CBarycentricFitReport &rep);
  static void Spline1DFitPenalized(double &cx[], double &cy[], const int n,
                                   const int m, const double rho, int &info,
                                   CSpline1DInterpolant &s,
                                   CSpline1DFitReport &rep);
  static void Spline1DFitPenalizedW(double &cx[], double &cy[], double &cw[],
                                    const int n, const int m, double rho,
                                    int &info, CSpline1DInterpolant &s,
                                    CSpline1DFitReport &rep);
  static void Spline1DFitCubicWC(double &x[], double &y[], double &w[],
                                 const int n, double &xc[], double &yc[],
                                 int &dc[], const int k, const int m, int &info,
                                 CSpline1DInterpolant &s,
                                 CSpline1DFitReport &rep);
  static void Spline1DFitHermiteWC(double &x[], double &y[], double &w[],
                                   const int n, double &xc[], double &yc[],
                                   int &dc[], const int k, const int m,
                                   int &info, CSpline1DInterpolant &s,
                                   CSpline1DFitReport &rep);
  static void Spline1DFitCubic(double &x[], double &y[], const int n,
                               const int m, int &info, CSpline1DInterpolant &s,
                               CSpline1DFitReport &rep);
  static void Spline1DFitHermite(double &x[], double &y[], const int n,
                                 const int m, int &info,
                                 CSpline1DInterpolant &s,
                                 CSpline1DFitReport &rep);
  static void LSFitLinearW(double &y[], double &w[], CMatrixDouble &fmatrix,
                           const int n, const int m, int &info, double &c[],
                           CLSFitReport &rep);
  static void LSFitLinearWC(double &cy[], double &w[], CMatrixDouble &fmatrix,
                            CMatrixDouble &ccmatrix, const int n, const int m,
                            const int k, int &info, double &c[],
                            CLSFitReport &rep);
  static void LSFitLinear(double &y[], CMatrixDouble &fmatrix, const int n,
                          const int m, int &info, double &c[],
                          CLSFitReport &rep);
  static void LSFitLinearC(double &cy[], CMatrixDouble &fmatrix,
                           CMatrixDouble &cmatrix, const int n, const int m,
                           const int k, int &info, double &c[],
                           CLSFitReport &rep);
  static void LSFitCreateWF(CMatrixDouble &x, double &y[], double &w[],
                            double &c[], const int n, const int m, const int k,
                            const double diffstep, CLSFitState &state);
  static void LSFitCreateF(CMatrixDouble &x, double &y[], double &c[],
                           const int n, const int m, const int k,
                           const double diffstep, CLSFitState &state);
  static void LSFitCreateWFG(CMatrixDouble &x, double &y[], double &w[],
                             double &c[], const int n, const int m, const int k,
                             bool cheapfg, CLSFitState &state);
  static void LSFitCreateFG(CMatrixDouble &x, double &y[], double &c[],
                            const int n, const int m, const int k,
                            const bool cheapfg, CLSFitState &state);
  static void LSFitCreateWFGH(CMatrixDouble &x, double &y[], double &w[],
                              double &c[], const int n, const int m,
                              const int k, CLSFitState &state);
  static void LSFitCreateFGH(CMatrixDouble &x, double &y[], double &c[],
                             const int n, const int m, const int k,
                             CLSFitState &state);
  static void LSFitSetCond(CLSFitState &state, const double epsf,
                           const double epsx, const int maxits);
  static void LSFitSetStpMax(CLSFitState &state, const double stpmax);
  static void LSFitSetXRep(CLSFitState &state, const bool needxrep);
  static void LSFitSetScale(CLSFitState &state, double &s[]);
  static void LSFitSetBC(CLSFitState &state, double &bndl[], double &bndu[]);
  static void LSFitResults(CLSFitState &state, int &info, double &c[],
                           CLSFitReport &rep);
  static void LSFitScaleXY(double &x[], double &y[], double &w[], const int n,
                           double &xc[], double &yc[], int &dc[], const int k,
                           double &xa, double &xb, double &sa, double &sb,
                           double &xoriginal[], double &yoriginal[]);
  static bool LSFitIteration(CLSFitState &state);
};

const int CLSFit::m_rfsmax = 10;

CLSFit::CLSFit(void) {}

CLSFit::~CLSFit(void) {}

static void CLSFit::PolynomialFit(double &x[], double &y[], const int n,
                                  const int m, int &info,
                                  CBarycentricInterpolant &p,
                                  CPolynomialFitReport &rep) {

  int i = 0;

  double w[];
  double xc[];
  double yc[];
  int dc[];

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": M<=0!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  ArrayResizeAL(w, n);

  for (i = 0; i <= n - 1; i++)
    w[i] = 1;

  PolynomialFitWC(x, y, w, n, xc, yc, dc, 0, m, info, p, rep);
}

static void CLSFit::PolynomialFitWC(double &cx[], double &cy[], double &cw[],
                                    const int n, double &cxc[], double &cyc[],
                                    int &dc[], const int k, const int m,
                                    int &info, CBarycentricInterpolant &p,
                                    CPolynomialFitReport &rep) {

  double xa = 0;
  double xb = 0;
  double sa = 0;
  double sb = 0;
  int i = 0;
  int j = 0;
  double u = 0;
  double v = 0;
  double s = 0;
  int relcnt = 0;

  double xoriginal[];
  double yoriginal[];
  double y2[];
  double w2[];
  double tmp[];
  double tmp2[];
  double bx[];
  double by[];
  double bw[];
  double x[];
  double y[];
  double w[];
  double xc[];
  double yc[];

  CLSFitReport lrep;

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);
  ArrayCopy(w, cw);
  ArrayCopy(xc, cxc);
  ArrayCopy(yc, cyc);

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": M<=0!"))
    return;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": K<0!"))
    return;

  if (!CAp::Assert(k < m, __FUNCTION__ + ": K>=M!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": Length(W)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(xc) >= k, __FUNCTION__ + ": Length(XC)<K!"))
    return;

  if (!CAp::Assert(CAp::Len(yc) >= k, __FUNCTION__ + ": Length(YC)<K!"))
    return;

  if (!CAp::Assert(CAp::Len(dc) >= k, __FUNCTION__ + ": Length(DC)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(xc, k),
                   __FUNCTION__ + ": XC contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(yc, k),
                   __FUNCTION__ + ": YC contains infinite or NaN values!"))
    return;
  for (i = 0; i <= k - 1; i++) {

    if (!CAp::Assert(dc[i] == 0 || dc[i] == 1,
                     __FUNCTION__ + ": one of DC[] is not 0 or 1!"))
      return;
  }

  LSFitScaleXY(x, y, w, n, xc, yc, dc, k, xa, xb, sa, sb, xoriginal, yoriginal);
  InternalChebyshevFit(x, y, w, n, xc, yc, dc, k, m, info, tmp, lrep);

  if (info < 0)
    return;

  ArrayResizeAL(bx, m);
  ArrayResizeAL(by, m);
  ArrayResizeAL(bw, m);
  ArrayResizeAL(tmp2, m);
  s = 1;

  for (i = 0; i <= m - 1; i++) {

    if (m != 1)
      u = MathCos(M_PI * i / (m - 1));
    else
      u = 0;
    v = 0;
    for (j = 0; j <= m - 1; j++) {

      if (j == 0)
        tmp2[j] = 1;
      else {

        if (j == 1)
          tmp2[j] = u;
        else
          tmp2[j] = 2 * u * tmp2[j - 1] - tmp2[j - 2];
      }
      v = v + tmp[j] * tmp2[j];
    }

    bx[i] = u;
    by[i] = v;
    bw[i] = s;

    if (i == 0 || i == m - 1)
      bw[i] = 0.5 * bw[i];
    s = -s;
  }

  CRatInt::BarycentricBuildXYW(bx, by, bw, m, p);

  CRatInt::BarycentricLinTransX(p, 2 / (xb - xa), -((xa + xb) / (xb - xa)));

  CRatInt::BarycentricLinTransY(p, sb - sa, sa);

  rep.m_taskrcond = lrep.m_taskrcond;
  rep.m_rmserror = lrep.m_rmserror * (sb - sa);
  rep.m_avgerror = lrep.m_avgerror * (sb - sa);
  rep.m_maxerror = lrep.m_maxerror * (sb - sa);
  rep.m_avgrelerror = 0;
  relcnt = 0;

  for (i = 0; i <= n - 1; i++) {

    if (yoriginal[i] != 0.0) {
      rep.m_avgrelerror =
          rep.m_avgrelerror +
          MathAbs(CRatInt::BarycentricCalc(p, xoriginal[i]) - yoriginal[i]) /
              MathAbs(yoriginal[i]);
      relcnt = relcnt + 1;
    }
  }

  if (relcnt != 0)
    rep.m_avgrelerror = rep.m_avgrelerror / relcnt;
}

static void CLSFit::BarycentricFitFloaterHormannWC(
    double &x[], double &y[], double &w[], const int n, double &xc[],
    double &yc[], int &dc[], const int k, const int m, int &info,
    CBarycentricInterpolant &b, CBarycentricFitReport &rep) {

  int d = 0;
  int i = 0;
  double wrmscur = 0;
  double wrmsbest = 0;
  int locinfo = 0;

  CBarycentricInterpolant locb;
  CBarycentricFitReport locrep;

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": M<=0!"))
    return;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": K<0!"))
    return;

  if (!CAp::Assert(k < m, __FUNCTION__ + ": K>=M!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": Length(W)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(xc) >= k, __FUNCTION__ + ": Length(XC)<K!"))
    return;

  if (!CAp::Assert(CAp::Len(yc) >= k, __FUNCTION__ + ": Length(YC)<K!"))
    return;

  if (!CAp::Assert(CAp::Len(dc) >= k, __FUNCTION__ + ": Length(DC)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(xc, k),
                   __FUNCTION__ + ": XC contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(yc, k),
                   __FUNCTION__ + ": YC contains infinite or NaN values!"))
    return;
  for (i = 0; i <= k - 1; i++) {

    if (!CAp::Assert(dc[i] == 0 || dc[i] == 1,
                     __FUNCTION__ + ": one of DC[] is not 0 or 1!"))
      return;
  }

  wrmsbest = CMath::m_maxrealnumber;
  rep.m_dbest = -1;
  info = -3;

  for (d = 0; d <= MathMin(9, n - 1); d++) {

    BarycentricFitWCFixedD(x, y, w, n, xc, yc, dc, k, m, d, locinfo, locb,
                           locrep);

    if (!CAp::Assert((locinfo == -4 || locinfo == -3) || locinfo > 0,
                     __FUNCTION__ +
                         ": unexpected result from BarycentricFitWCFixedD!"))
      return;

    if (locinfo > 0) {

      wrmscur = 0;
      for (i = 0; i <= n - 1; i++)
        wrmscur =
            wrmscur +
            CMath::Sqr(w[i] * (y[i] - CRatInt::BarycentricCalc(locb, x[i])));
      wrmscur = MathSqrt(wrmscur / n);

      if (wrmscur < wrmsbest || rep.m_dbest < 0) {

        CRatInt::BarycentricCopy(locb, b);

        rep.m_dbest = d;
        info = 1;
        rep.m_rmserror = locrep.m_rmserror;
        rep.m_avgerror = locrep.m_avgerror;
        rep.m_avgrelerror = locrep.m_avgrelerror;
        rep.m_maxerror = locrep.m_maxerror;
        rep.m_taskrcond = locrep.m_taskrcond;
        wrmsbest = wrmscur;
      }
    } else {

      if (locinfo != -3 && info < 0)
        info = locinfo;
    }
  }
}

static void CLSFit::BarycentricFitFloaterHormann(double &x[], double &y[],
                                                 const int n, const int m,
                                                 int &info,
                                                 CBarycentricInterpolant &b,
                                                 CBarycentricFitReport &rep) {

  double w[];
  double xc[];
  double yc[];
  int dc[];

  int i = 0;

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": M<=0!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  ArrayResizeAL(w, n);

  for (i = 0; i <= n - 1; i++)
    w[i] = 1;

  BarycentricFitFloaterHormannWC(x, y, w, n, xc, yc, dc, 0, m, info, b, rep);
}

static void CLSFit::Spline1DFitPenalized(double &cx[], double &cy[],
                                         const int n, const int m,
                                         const double rho, int &info,
                                         CSpline1DInterpolant &s,
                                         CSpline1DFitReport &rep) {

  int i = 0;

  double w[];
  double x[];
  double y[];

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 4, __FUNCTION__ + ": M<4!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(rho), __FUNCTION__ + ": Rho is infinite!"))
    return;

  ArrayResizeAL(w, n);

  for (i = 0; i <= n - 1; i++)
    w[i] = 1;

  Spline1DFitPenalizedW(x, y, w, n, m, rho, info, s, rep);
}

static void CLSFit::Spline1DFitPenalizedW(double &cx[], double &cy[],
                                          double &cw[], const int n,
                                          const int m, double rho, int &info,
                                          CSpline1DInterpolant &s,
                                          CSpline1DFitReport &rep) {

  int i = 0;
  int j = 0;
  int b = 0;
  double v = 0;
  double relcnt = 0;
  double xa = 0;
  double xb = 0;
  double sa = 0;
  double sb = 0;
  double pdecay = 0;
  double tdecay = 0;
  double fdmax = 0;
  double admax = 0;
  double fa = 0;
  double ga = 0;
  double fb = 0;
  double gb = 0;
  double lambdav = 0;
  int i_ = 0;
  int i1_ = 0;

  double xoriginal[];
  double yoriginal[];
  double fcolumn[];
  double y2[];
  double w2[];
  double xc[];
  double yc[];
  int dc[];
  double bx[];
  double by[];
  double bd1[];
  double bd2[];
  double tx[];
  double ty[];
  double td[];
  double rightpart[];
  double c[];
  double tmp0[];
  double x[];
  double y[];
  double w[];

  CMatrixDouble fmatrix;
  CMatrixDouble amatrix;
  CMatrixDouble d2matrix;
  CMatrixDouble nmatrix;

  CSpline1DInterpolant bs;
  CFblsLinCgState cgstate;

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);
  ArrayCopy(w, cw);

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 4, __FUNCTION__ + ": M<4!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": Length(W)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(rho), __FUNCTION__ + ": Rho is infinite!"))
    return;

  v = -(MathLog(CMath::m_machineepsilon) / MathLog(10));

  if (rho < -v)
    rho = -v;

  if (rho > v)
    rho = v;
  lambdav = MathPow(10, rho);

  CSpline1D::HeapSortDPoints(x, y, w, n);

  LSFitScaleXY(x, y, w, n, xc, yc, dc, 0, xa, xb, sa, sb, xoriginal, yoriginal);

  fmatrix.Resize(n, m);
  amatrix.Resize(m, m);
  d2matrix.Resize(m, m);
  ArrayResizeAL(bx, m);
  ArrayResizeAL(by, m);
  ArrayResizeAL(fcolumn, n);
  nmatrix.Resize(m, m);
  ArrayResizeAL(rightpart, m);
  ArrayResizeAL(tmp0, MathMax(m, n));
  ArrayResizeAL(c, m);

  fdmax = 0;
  for (b = 0; b <= m - 1; b++) {

    for (j = 0; j <= m - 1; j++) {
      bx[j] = (double)(2 * j) / (double)(m - 1) - 1;
      by[j] = 0;
    }
    by[b] = 1;

    CSpline1D::Spline1DGridDiff2Cubic(bx, by, m, 2, 0.0, 2, 0.0, bd1, bd2);

    CSpline1D::Spline1DBuildCubic(bx, by, m, 2, 0.0, 2, 0.0, bs);

    CSpline1D::Spline1DConvCubic(bx, by, m, 2, 0.0, 2, 0.0, x, n, fcolumn);
    for (i_ = 0; i_ <= n - 1; i_++)
      fmatrix[i_].Set(b, fcolumn[i_]);
    v = 0;
    for (i = 0; i <= n - 1; i++)
      v = v + CMath::Sqr(w[i] * fcolumn[i]);
    fdmax = MathMax(fdmax, v);

    for (i_ = 0; i_ <= m - 1; i_++)
      d2matrix[b].Set(i_, bd2[i_]);
  }

  for (i = 0; i <= m - 1; i++) {
    for (j = i; j <= m - 1; j++) {

      v = 0;
      for (b = 0; b <= m - 2; b++) {

        fa = d2matrix[i][b];
        fb = d2matrix[i][b + 1];
        ga = d2matrix[j][b];
        gb = d2matrix[j][b + 1];
        v = v + (bx[b + 1] - bx[b]) *
                    (fa * ga + (fa * (gb - ga) + ga * (fb - fa)) / 2 +
                     (fb - fa) * (gb - ga) / 3);
      }
      amatrix[i].Set(j, v);
      amatrix[j].Set(i, v);
    }
  }

  admax = 0;
  for (i = 0; i <= m - 1; i++)
    admax = MathMax(admax, MathAbs(amatrix[i][i]));
  pdecay = lambdav * fdmax / admax;

  tdecay = fdmax * (1 + pdecay) * 10 * CMath::m_machineepsilon;

  for (i = 0; i <= n - 1; i++) {
    v = w[i];
    for (i_ = 0; i_ <= m - 1; i_++)
      fmatrix[i].Set(i_, v * fmatrix[i][i_]);
  }

  CAblas::RMatrixGemm(m, m, n, 1.0, fmatrix, 0, 0, 1, fmatrix, 0, 0, 0, 0.0,
                      nmatrix, 0, 0);
  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= m - 1; j++)
      nmatrix[i].Set(j, nmatrix[i][j] + pdecay * amatrix[i][j]);
  }

  for (i = 0; i <= m - 1; i++)
    nmatrix[i].Set(i, nmatrix[i][i] + tdecay);
  for (i = 0; i <= m - 1; i++)
    rightpart[i] = 0;

  for (i = 0; i <= n - 1; i++) {
    v = y[i] * w[i];
    for (i_ = 0; i_ <= m - 1; i_++)
      rightpart[i_] = rightpart[i_] + v * fmatrix[i][i_];
  }

  if (!CTrFac::SPDMatrixCholesky(nmatrix, m, true)) {
    info = -4;
    return;
  }

  CFbls::FblsCholeskySolve(nmatrix, 1.0, m, true, rightpart, tmp0);

  for (i_ = 0; i_ <= m - 1; i_++)
    c[i_] = rightpart[i_];

  CSpline1D::Spline1DGridDiffCubic(bx, c, m, 2, 0.0, 2, 0.0, bd1);

  ArrayResizeAL(tx, m + 2);
  ArrayResizeAL(ty, m + 2);
  ArrayResizeAL(td, m + 2);

  i1_ = -1;
  for (i_ = 1; i_ <= m; i_++)
    tx[i_] = bx[i_ + i1_];
  i1_ = -1;
  for (i_ = 1; i_ <= m; i_++)
    ty[i_] = rightpart[i_ + i1_];
  i1_ = -1;
  for (i_ = 1; i_ <= m; i_++)
    td[i_] = bd1[i_ + i1_];

  tx[0] = tx[1] - (tx[2] - tx[1]);
  ty[0] = ty[1] - td[1] * (tx[2] - tx[1]);
  td[0] = td[1];
  tx[m + 1] = tx[m] + (tx[m] - tx[m - 1]);
  ty[m + 1] = ty[m] + td[m] * (tx[m] - tx[m - 1]);
  td[m + 1] = td[m];

  CSpline1D::Spline1DBuildHermite(tx, ty, td, m + 2, s);

  CSpline1D::Spline1DLinTransX(s, 2 / (xb - xa), -((xa + xb) / (xb - xa)));

  CSpline1D::Spline1DLinTransY(s, sb - sa, sa);

  info = 1;

  rep.m_rmserror = 0;
  rep.m_avgerror = 0;
  rep.m_avgrelerror = 0;
  rep.m_maxerror = 0;
  relcnt = 0;

  CSpline1D::Spline1DConvCubic(bx, rightpart, m, 2, 0.0, 2, 0.0, x, n, fcolumn);

  for (i = 0; i <= n - 1; i++) {

    v = (sb - sa) * fcolumn[i] + sa;
    rep.m_rmserror = rep.m_rmserror + CMath::Sqr(v - yoriginal[i]);
    rep.m_avgerror = rep.m_avgerror + MathAbs(v - yoriginal[i]);

    if (yoriginal[i] != 0.0) {
      rep.m_avgrelerror =
          rep.m_avgrelerror + MathAbs(v - yoriginal[i]) / MathAbs(yoriginal[i]);
      relcnt = relcnt + 1;
    }
    rep.m_maxerror = MathMax(rep.m_maxerror, MathAbs(v - yoriginal[i]));
  }

  rep.m_rmserror = MathSqrt(rep.m_rmserror / n);
  rep.m_avgerror = rep.m_avgerror / n;

  if (relcnt != 0.0)
    rep.m_avgrelerror = rep.m_avgrelerror / relcnt;
}

static void CLSFit::Spline1DFitCubicWC(double &x[], double &y[], double &w[],
                                       const int n, double &xc[], double &yc[],
                                       int &dc[], const int k, const int m,
                                       int &info, CSpline1DInterpolant &s,
                                       CSpline1DFitReport &rep) {

  int i = 0;

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 4, __FUNCTION__ + ": M<4!"))
    return;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": K<0!"))
    return;

  if (!CAp::Assert(k < m, __FUNCTION__ + ": K>=M!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": Length(W)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(xc) >= k, __FUNCTION__ + ": Length(XC)<K!"))
    return;

  if (!CAp::Assert(CAp::Len(yc) >= k, __FUNCTION__ + ": Length(YC)<K!"))
    return;

  if (!CAp::Assert(CAp::Len(dc) >= k, __FUNCTION__ + ": Length(DC)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(xc, k),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(yc, k),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;
  for (i = 0; i <= k - 1; i++) {

    if (!CAp::Assert(dc[i] == 0 || dc[i] == 1,
                     __FUNCTION__ + ": DC[i] is neither 0 or 1!"))
      return;
  }

  Spline1DFitInternal(0, x, y, w, n, xc, yc, dc, k, m, info, s, rep);
}

static void CLSFit::Spline1DFitHermiteWC(double &x[], double &y[], double &w[],
                                         const int n, double &xc[],
                                         double &yc[], int &dc[], const int k,
                                         const int m, int &info,
                                         CSpline1DInterpolant &s,
                                         CSpline1DFitReport &rep) {

  int i = 0;

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 4, __FUNCTION__ + ": M<4!"))
    return;

  if (!CAp::Assert(m % 2 == 0, __FUNCTION__ + ": M is odd!"))
    return;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": K<0!"))
    return;

  if (!CAp::Assert(k < m, __FUNCTION__ + ": K>=M!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": Length(W)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(xc) >= k, __FUNCTION__ + ": Length(XC)<K!"))
    return;

  if (!CAp::Assert(CAp::Len(yc) >= k, __FUNCTION__ + ": Length(YC)<K!"))
    return;

  if (!CAp::Assert(CAp::Len(dc) >= k, __FUNCTION__ + ": Length(DC)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(xc, k),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(yc, k),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;
  for (i = 0; i <= k - 1; i++) {

    if (!CAp::Assert(dc[i] == 0 || dc[i] == 1,
                     __FUNCTION__ + ": DC[i] is neither 0 or 1!"))
      return;
  }

  Spline1DFitInternal(1, x, y, w, n, xc, yc, dc, k, m, info, s, rep);
}

static void CLSFit::Spline1DFitCubic(double &x[], double &y[], const int n,
                                     const int m, int &info,
                                     CSpline1DInterpolant &s,
                                     CSpline1DFitReport &rep) {

  int i = 0;

  double w[];
  double xc[];
  double yc[];
  int dc[];

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 4, __FUNCTION__ + ": M<4!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  ArrayResizeAL(w, n);

  for (i = 0; i <= n - 1; i++)
    w[i] = 1;

  Spline1DFitCubicWC(x, y, w, n, xc, yc, dc, 0, m, info, s, rep);
}

static void CLSFit::Spline1DFitHermite(double &x[], double &y[], const int n,
                                       const int m, int &info,
                                       CSpline1DInterpolant &s,
                                       CSpline1DFitReport &rep) {

  int i = 0;

  double w[];
  double xc[];
  double yc[];
  int dc[];

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 4, __FUNCTION__ + ": M<4!"))
    return;

  if (!CAp::Assert(m % 2 == 0, __FUNCTION__ + ": M is odd!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": Length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NAN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NAN values!"))
    return;

  ArrayResizeAL(w, n);

  for (i = 0; i <= n - 1; i++)
    w[i] = 1;

  Spline1DFitHermiteWC(x, y, w, n, xc, yc, dc, 0, m, info, s, rep);
}

static void CLSFit::LSFitLinearW(double &y[], double &w[],
                                 CMatrixDouble &fmatrix, const int n,
                                 const int m, int &info, double &c[],
                                 CLSFitReport &rep) {

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": length(W)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": W contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(fmatrix) >= n,
                   __FUNCTION__ + ": rows(FMatrix)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(fmatrix) >= m,
                   __FUNCTION__ + ": cols(FMatrix)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(fmatrix, n, m),
                   __FUNCTION__ + ": FMatrix contains infinite or NaN values!"))
    return;

  LSFitLinearInternal(y, w, fmatrix, n, m, info, c, rep);
}

static void CLSFit::LSFitLinearWC(double &cy[], double &w[],
                                  CMatrixDouble &fmatrix,
                                  CMatrixDouble &ccmatrix, const int n,
                                  const int m, const int k, int &info,
                                  double &c[], CLSFitReport &rep) {

  int i = 0;
  int j = 0;
  double v = 0;
  int i_ = 0;

  double tau[];
  double tmp[];
  double c0[];
  double y[];

  CMatrixDouble q;
  CMatrixDouble f2;
  CMatrixDouble cmatrix;

  ArrayCopy(y, cy);

  cmatrix = ccmatrix;

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": K<0!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": length(W)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": W contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(fmatrix) >= n,
                   __FUNCTION__ + ": rows(FMatrix)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(fmatrix) >= m,
                   __FUNCTION__ + ": cols(FMatrix)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(fmatrix, n, m),
                   __FUNCTION__ + ": FMatrix contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(cmatrix) >= k,
                   __FUNCTION__ + ": rows(CMatrix)<K!"))
    return;

  if (!CAp::Assert(CAp::Cols(cmatrix) >= m + 1 || k == 0,
                   __FUNCTION__ + ": cols(CMatrix)<M+1!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(cmatrix, k, m + 1),
                   __FUNCTION__ + ": CMatrix contains infinite or NaN values!"))
    return;

  if (k >= m) {
    info = -3;
    return;
  }

  if (k == 0) {

    LSFitLinearInternal(y, w, fmatrix, n, m, info, c, rep);
  } else {

    COrtFac::RMatrixLQ(cmatrix, k, m, tau);
    COrtFac::RMatrixLQUnpackQ(cmatrix, k, m, tau, m, q);
    for (i = 0; i <= k - 1; i++) {
      for (j = i + 1; j <= m - 1; j++)
        cmatrix[i].Set(j, 0.0);
    }

    if (CRCond::RMatrixLURCondInf(cmatrix, k) <
        1000 * CMath::m_machineepsilon) {
      info = -3;
      return;
    }

    ArrayResizeAL(tmp, k);

    for (i = 0; i <= k - 1; i++) {

      if (i > 0) {
        v = 0.0;
        for (i_ = 0; i_ <= i - 1; i_++)
          v += cmatrix[i][i_] * tmp[i_];
      } else
        v = 0;

      tmp[i] = (cmatrix[i][m] - v) / cmatrix[i][i];
    }

    ArrayResizeAL(c0, m);

    for (i = 0; i <= m - 1; i++)
      c0[i] = 0;
    for (i = 0; i <= k - 1; i++) {
      v = tmp[i];
      for (i_ = 0; i_ <= m - 1; i_++)
        c0[i_] = c0[i_] + v * q[i][i_];
    }

    ArrayResizeAL(tmp, MathMax(n, m) + 1);
    f2.Resize(n, m - k);

    CBlas::MatrixVectorMultiply(fmatrix, 0, n - 1, 0, m - 1, false, c0, 0,
                                m - 1, -1.0, y, 0, n - 1, 1.0);

    CBlas::MatrixMatrixMultiply(fmatrix, 0, n - 1, 0, m - 1, false, q, k, m - 1,
                                0, m - 1, true, 1.0, f2, 0, n - 1, 0, m - k - 1,
                                0.0, tmp);

    LSFitLinearInternal(y, w, f2, n, m - k, info, tmp, rep);
    rep.m_taskrcond = -1;

    if (info <= 0)
      return;

    ArrayResizeAL(c, m);
    for (i_ = 0; i_ <= m - 1; i_++)
      c[i_] = c0[i_];

    CBlas::MatrixVectorMultiply(q, k, m - 1, 0, m - 1, true, tmp, 0, m - k - 1,
                                1.0, c, 0, m - 1, 1.0);
  }
}

static void CLSFit::LSFitLinear(double &y[], CMatrixDouble &fmatrix,
                                const int n, const int m, int &info,
                                double &c[], CLSFitReport &rep) {

  int i = 0;

  double w[];

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(fmatrix) >= n,
                   __FUNCTION__ + ": rows(FMatrix)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(fmatrix) >= m,
                   __FUNCTION__ + ": cols(FMatrix)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(fmatrix, n, m),
                   __FUNCTION__ + ": FMatrix contains infinite or NaN values!"))
    return;

  ArrayResizeAL(w, n);

  for (i = 0; i <= n - 1; i++)
    w[i] = 1;

  LSFitLinearInternal(y, w, fmatrix, n, m, info, c, rep);
}

static void CLSFit::LSFitLinearC(double &cy[], CMatrixDouble &fmatrix,
                                 CMatrixDouble &cmatrix, const int n,
                                 const int m, const int k, int &info,
                                 double &c[], CLSFitReport &rep) {

  int i = 0;

  double w[];
  double y[];

  ArrayCopy(y, cy);

  info = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": K<0!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(fmatrix) >= n,
                   __FUNCTION__ + ": rows(FMatrix)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(fmatrix) >= m,
                   __FUNCTION__ + ": cols(FMatrix)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(fmatrix, n, m),
                   __FUNCTION__ + ": FMatrix contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(cmatrix) >= k,
                   __FUNCTION__ + ": rows(CMatrix)<K!"))
    return;

  if (!CAp::Assert(CAp::Cols(cmatrix) >= m + 1 || k == 0,
                   __FUNCTION__ + ": cols(CMatrix)<M+1!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(cmatrix, k, m + 1),
                   __FUNCTION__ + ": CMatrix contains infinite or NaN values!"))
    return;

  ArrayResizeAL(w, n);

  for (i = 0; i <= n - 1; i++)
    w[i] = 1;

  LSFitLinearWC(y, w, fmatrix, cmatrix, n, m, k, info, c, rep);
}

static void CLSFit::LSFitCreateWF(CMatrixDouble &x, double &y[], double &w[],
                                  double &c[], const int n, const int m,
                                  const int k, const double diffstep,
                                  CLSFitState &state) {

  int i = 0;
  int i_ = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(k >= 1, __FUNCTION__ + ": K<1!"))
    return;

  if (!CAp::Assert(CAp::Len(c) >= k, __FUNCTION__ + ": length(C)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(c, k),
                   __FUNCTION__ + ": C contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": length(W)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": W contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(x) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(x) >= m, __FUNCTION__ + ": cols(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(x, n, m),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(diffstep),
                   __FUNCTION__ + ": DiffStep is not finite!"))
    return;

  if (!CAp::Assert((double)(diffstep) > 0.0, __FUNCTION__ + ": DiffStep<=0!"))
    return;

  state.m_npoints = n;
  state.m_nweights = n;
  state.m_wkind = 1;
  state.m_m = m;
  state.m_k = k;

  LSFitSetCond(state, 0.0, 0.0, 0);

  LSFitSetStpMax(state, 0.0);

  LSFitSetXRep(state, false);

  state.m_taskx.Resize(n, m);
  ArrayResizeAL(state.m_tasky, n);
  ArrayResizeAL(state.m_w, n);
  ArrayResizeAL(state.m_c, k);
  ArrayResizeAL(state.m_x, m);

  for (i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = c[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_w[i_] = w[i_];
  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_taskx[i].Set(i_, x[i][i_]);
    state.m_tasky[i] = y[i];
  }

  ArrayResizeAL(state.m_s, k);
  ArrayResizeAL(state.m_bndl, k);
  ArrayResizeAL(state.m_bndu, k);

  for (i = 0; i <= k - 1; i++) {
    state.m_s[i] = 1.0;
    state.m_bndl[i] = CInfOrNaN::NegativeInfinity();
    state.m_bndu[i] = CInfOrNaN::PositiveInfinity();
  }

  state.m_optalgo = 0;
  state.m_prevnpt = -1;
  state.m_prevalgo = -1;

  CMinLM::MinLMCreateV(k, n, state.m_c, diffstep, state.m_optstate);

  LSFitClearRequestFields(state);

  ArrayResizeAL(state.m_rstate.ia, 5);
  ArrayResizeAL(state.m_rstate.ra, 3);
  state.m_rstate.stage = -1;
}

static void CLSFit::LSFitCreateF(CMatrixDouble &x, double &y[], double &c[],
                                 const int n, const int m, const int k,
                                 const double diffstep, CLSFitState &state) {

  int i = 0;
  int i_ = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(k >= 1, __FUNCTION__ + ": K<1!"))
    return;

  if (!CAp::Assert(CAp::Len(c) >= k, __FUNCTION__ + ": length(C)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(c, k),
                   __FUNCTION__ + ": C contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(x) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(x) >= m, __FUNCTION__ + ": cols(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(x, n, m),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(x) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(x) >= m, __FUNCTION__ + ": cols(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(x, n, m),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(diffstep),
                   __FUNCTION__ + ": DiffStep is not finite!"))
    return;

  if (!CAp::Assert((double)(diffstep) > 0.0, __FUNCTION__ + ": DiffStep<=0!"))
    return;

  state.m_npoints = n;
  state.m_wkind = 0;
  state.m_m = m;
  state.m_k = k;

  LSFitSetCond(state, 0.0, 0.0, 0);

  LSFitSetStpMax(state, 0.0);

  LSFitSetXRep(state, false);

  state.m_taskx.Resize(n, m);
  ArrayResizeAL(state.m_tasky, n);
  ArrayResizeAL(state.m_c, k);
  ArrayResizeAL(state.m_x, m);

  for (i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = c[i_];
  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_taskx[i].Set(i_, x[i][i_]);
    state.m_tasky[i] = y[i];
  }

  ArrayResizeAL(state.m_s, k);
  ArrayResizeAL(state.m_bndl, k);
  ArrayResizeAL(state.m_bndu, k);

  for (i = 0; i <= k - 1; i++) {
    state.m_s[i] = 1.0;
    state.m_bndl[i] = CInfOrNaN::NegativeInfinity();
    state.m_bndu[i] = CInfOrNaN::PositiveInfinity();
  }

  state.m_optalgo = 0;
  state.m_prevnpt = -1;
  state.m_prevalgo = -1;

  CMinLM::MinLMCreateV(k, n, state.m_c, diffstep, state.m_optstate);

  LSFitClearRequestFields(state);

  ArrayResizeAL(state.m_rstate.ia, 5);
  ArrayResizeAL(state.m_rstate.ra, 3);
  state.m_rstate.stage = -1;
}

static void CLSFit::LSFitCreateWFG(CMatrixDouble &x, double &y[], double &w[],
                                   double &c[], const int n, const int m,
                                   const int k, bool cheapfg,
                                   CLSFitState &state) {

  int i = 0;
  int i_ = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(k >= 1, __FUNCTION__ + ": K<1!"))
    return;

  if (!CAp::Assert(CAp::Len(c) >= k, __FUNCTION__ + ": length(C)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(c, k),
                   __FUNCTION__ + ": C contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": length(W)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": W contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(x) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(x) >= m, __FUNCTION__ + ": cols(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(x, n, m),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  state.m_npoints = n;
  state.m_nweights = n;
  state.m_wkind = 1;
  state.m_m = m;
  state.m_k = k;

  LSFitSetCond(state, 0.0, 0.0, 0);

  LSFitSetStpMax(state, 0.0);

  LSFitSetXRep(state, false);

  state.m_taskx.Resize(n, m);
  ArrayResizeAL(state.m_tasky, n);
  ArrayResizeAL(state.m_w, n);
  ArrayResizeAL(state.m_c, k);
  ArrayResizeAL(state.m_x, m);
  ArrayResizeAL(state.m_g, k);

  for (i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = c[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_w[i_] = w[i_];
  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_taskx[i].Set(i_, x[i][i_]);
    state.m_tasky[i] = y[i];
  }

  ArrayResizeAL(state.m_s, k);
  ArrayResizeAL(state.m_bndl, k);
  ArrayResizeAL(state.m_bndu, k);

  for (i = 0; i <= k - 1; i++) {
    state.m_s[i] = 1.0;
    state.m_bndl[i] = CInfOrNaN::NegativeInfinity();
    state.m_bndu[i] = CInfOrNaN::PositiveInfinity();
  }

  state.m_optalgo = 1;
  state.m_prevnpt = -1;
  state.m_prevalgo = -1;

  if (cheapfg)
    CMinLM::MinLMCreateVGJ(k, n, state.m_c, state.m_optstate);
  else
    CMinLM::MinLMCreateVJ(k, n, state.m_c, state.m_optstate);

  LSFitClearRequestFields(state);

  ArrayResizeAL(state.m_rstate.ia, 5);
  ArrayResizeAL(state.m_rstate.ra, 3);
  state.m_rstate.stage = -1;
}

static void CLSFit::LSFitCreateFG(CMatrixDouble &x, double &y[], double &c[],
                                  const int n, const int m, const int k,
                                  const bool cheapfg, CLSFitState &state) {

  int i = 0;
  int i_ = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(k >= 1, __FUNCTION__ + ": K<1!"))
    return;

  if (!CAp::Assert(CAp::Len(c) >= k, __FUNCTION__ + ": length(C)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(c, k),
                   __FUNCTION__ + ": C contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(x) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(x) >= m, __FUNCTION__ + ": cols(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(x, n, m),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(x) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(x) >= m, __FUNCTION__ + ": cols(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(x, n, m),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  state.m_npoints = n;
  state.m_wkind = 0;
  state.m_m = m;
  state.m_k = k;
  LSFitSetCond(state, 0.0, 0.0, 0);
  LSFitSetStpMax(state, 0.0);
  LSFitSetXRep(state, false);

  state.m_taskx.Resize(n, m);
  ArrayResizeAL(state.m_tasky, n);
  ArrayResizeAL(state.m_c, k);
  ArrayResizeAL(state.m_x, m);
  ArrayResizeAL(state.m_g, k);

  for (i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = c[i_];
  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_taskx[i].Set(i_, x[i][i_]);
    state.m_tasky[i] = y[i];
  }

  ArrayResizeAL(state.m_s, k);
  ArrayResizeAL(state.m_bndl, k);
  ArrayResizeAL(state.m_bndu, k);

  for (i = 0; i <= k - 1; i++) {
    state.m_s[i] = 1.0;
    state.m_bndl[i] = CInfOrNaN::NegativeInfinity();
    state.m_bndu[i] = CInfOrNaN::PositiveInfinity();
  }

  state.m_optalgo = 1;
  state.m_prevnpt = -1;
  state.m_prevalgo = -1;

  if (cheapfg)
    CMinLM::MinLMCreateVGJ(k, n, state.m_c, state.m_optstate);
  else
    CMinLM::MinLMCreateVJ(k, n, state.m_c, state.m_optstate);

  LSFitClearRequestFields(state);

  ArrayResizeAL(state.m_rstate.ia, 5);
  ArrayResizeAL(state.m_rstate.ra, 3);
  state.m_rstate.stage = -1;
}

static void CLSFit::LSFitCreateWFGH(CMatrixDouble &x, double &y[], double &w[],
                                    double &c[], const int n, const int m,
                                    const int k, CLSFitState &state) {

  int i = 0;
  int i_ = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(k >= 1, __FUNCTION__ + ": K<1!"))
    return;

  if (!CAp::Assert(CAp::Len(c) >= k, __FUNCTION__ + ": length(C)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(c, k),
                   __FUNCTION__ + ": C contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(w) >= n, __FUNCTION__ + ": length(W)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(w, n),
                   __FUNCTION__ + ": W contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(x) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(x) >= m, __FUNCTION__ + ": cols(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(x, n, m),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  state.m_npoints = n;
  state.m_nweights = n;
  state.m_wkind = 1;
  state.m_m = m;
  state.m_k = k;

  LSFitSetCond(state, 0.0, 0.0, 0);

  LSFitSetStpMax(state, 0.0);

  LSFitSetXRep(state, false);

  state.m_taskx.Resize(n, m);
  ArrayResizeAL(state.m_tasky, n);
  ArrayResizeAL(state.m_w, n);
  ArrayResizeAL(state.m_c, k);
  state.m_h.Resize(k, k);
  ArrayResizeAL(state.m_x, m);
  ArrayResizeAL(state.m_g, k);

  for (i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = c[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_w[i_] = w[i_];
  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_taskx[i].Set(i_, x[i][i_]);
    state.m_tasky[i] = y[i];
  }

  ArrayResizeAL(state.m_s, k);
  ArrayResizeAL(state.m_bndl, k);
  ArrayResizeAL(state.m_bndu, k);

  for (i = 0; i <= k - 1; i++) {
    state.m_s[i] = 1.0;
    state.m_bndl[i] = CInfOrNaN::NegativeInfinity();
    state.m_bndu[i] = CInfOrNaN::PositiveInfinity();
  }

  state.m_optalgo = 2;
  state.m_prevnpt = -1;
  state.m_prevalgo = -1;

  CMinLM::MinLMCreateFGH(k, state.m_c, state.m_optstate);

  LSFitClearRequestFields(state);

  ArrayResizeAL(state.m_rstate.ia, 5);
  ArrayResizeAL(state.m_rstate.ra, 3);
  state.m_rstate.stage = -1;
}

static void CLSFit::LSFitCreateFGH(CMatrixDouble &x, double &y[], double &c[],
                                   const int n, const int m, const int k,
                                   CLSFitState &state) {

  int i = 0;
  int i_ = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1!"))
    return;

  if (!CAp::Assert(k >= 1, __FUNCTION__ + ": K<1!"))
    return;

  if (!CAp::Assert(CAp::Len(c) >= k, __FUNCTION__ + ": length(C)<K!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(c, k),
                   __FUNCTION__ + ": C contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, __FUNCTION__ + ": length(Y)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   __FUNCTION__ + ": Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Rows(x) >= n, __FUNCTION__ + ": rows(X)<N!"))
    return;

  if (!CAp::Assert(CAp::Cols(x) >= m, __FUNCTION__ + ": cols(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(x, n, m),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  state.m_npoints = n;
  state.m_wkind = 0;
  state.m_m = m;
  state.m_k = k;

  LSFitSetCond(state, 0.0, 0.0, 0);

  LSFitSetStpMax(state, 0.0);

  LSFitSetXRep(state, false);

  state.m_taskx.Resize(n, m);
  ArrayResizeAL(state.m_tasky, n);
  ArrayResizeAL(state.m_c, k);
  state.m_h.Resize(k, k);
  ArrayResizeAL(state.m_x, m);
  ArrayResizeAL(state.m_g, k);

  for (i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = c[i_];
  for (i = 0; i <= n - 1; i++) {
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_taskx[i].Set(i_, x[i][i_]);
    state.m_tasky[i] = y[i];
  }

  ArrayResizeAL(state.m_s, k);
  ArrayResizeAL(state.m_bndl, k);
  ArrayResizeAL(state.m_bndu, k);

  for (i = 0; i <= k - 1; i++) {
    state.m_s[i] = 1.0;
    state.m_bndl[i] = CInfOrNaN::NegativeInfinity();
    state.m_bndu[i] = CInfOrNaN::PositiveInfinity();
  }

  state.m_optalgo = 2;
  state.m_prevnpt = -1;
  state.m_prevalgo = -1;

  CMinLM::MinLMCreateFGH(k, state.m_c, state.m_optstate);

  LSFitClearRequestFields(state);

  ArrayResizeAL(state.m_rstate.ia, 5);
  ArrayResizeAL(state.m_rstate.ra, 3);
  state.m_rstate.stage = -1;
}

static void CLSFit::LSFitSetCond(CLSFitState &state, const double epsf,
                                 const double epsx, const int maxits) {

  if (!CAp::Assert(CMath::IsFinite(epsf),
                   __FUNCTION__ + ": EpsF is not finite!"))
    return;

  if (!CAp::Assert((double)(epsf) >= 0.0, __FUNCTION__ + ": negative EpsF!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsx),
                   __FUNCTION__ + ": EpsX is not finite!"))
    return;

  if (!CAp::Assert((double)(epsx) >= 0.0, __FUNCTION__ + ": negative EpsX!"))
    return;

  if (!CAp::Assert(maxits >= 0, __FUNCTION__ + ": negative MaxIts!"))
    return;

  state.m_epsf = epsf;
  state.m_epsx = epsx;
  state.m_maxits = maxits;
}

static void CLSFit::LSFitSetStpMax(CLSFitState &state, const double stpmax) {

  if (!CAp::Assert(stpmax >= 0.0, __FUNCTION__ + ": StpMax<0!"))
    return;

  state.m_stpmax = stpmax;
}

static void CLSFit::LSFitSetXRep(CLSFitState &state, const bool needxrep) {

  state.m_xrep = needxrep;
}

static void CLSFit::LSFitSetScale(CLSFitState &state, double &s[]) {

  int i = 0;

  if (!CAp::Assert(CAp::Len(s) >= state.m_k, __FUNCTION__ + ": Length(S)<K"))
    return;
  for (i = 0; i <= state.m_k - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(s[i]),
                     __FUNCTION__ + ": S contains infinite or NAN elements"))
      return;

    if (!CAp::Assert((double)(s[i]) != 0.0,
                     __FUNCTION__ + ": S contains infinite or NAN elements"))
      return;

    state.m_s[i] = s[i];
  }
}

static void CLSFit::LSFitSetBC(CLSFitState &state, double &bndl[],
                               double &bndu[]) {

  int i = 0;
  int k = 0;

  k = state.m_k;

  if (!CAp::Assert(CAp::Len(bndl) >= k, __FUNCTION__ + ": Length(BndL)<K"))
    return;

  if (!CAp::Assert(CAp::Len(bndu) >= k, __FUNCTION__ + ": Length(BndU)<K"))
    return;
  for (i = 0; i <= k - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(bndl[i]) ||
                         CInfOrNaN::IsNegativeInfinity(bndl[i]),
                     __FUNCTION__ + ": BndL contains NAN or +INF"))
      return;

    if (!CAp::Assert(CMath::IsFinite(bndu[i]) ||
                         CInfOrNaN::IsPositiveInfinity(bndu[i]),
                     __FUNCTION__ + ": BndU contains NAN or -INF"))
      return;

    if (CMath::IsFinite(bndl[i]) && CMath::IsFinite(bndu[i])) {

      if (!CAp::Assert(bndl[i] <= bndu[i], __FUNCTION__ + ": BndL[i]>BndU[i]"))
        return;
    }

    state.m_bndl[i] = bndl[i];
    state.m_bndu[i] = bndu[i];
  }
}

static void CLSFit::LSFitResults(CLSFitState &state, int &info, double &c[],
                                 CLSFitReport &rep) {

  int i_ = 0;

  info = state.m_repterminationtype;

  if (info > 0) {

    ArrayResizeAL(c, state.m_k);
    for (i_ = 0; i_ <= state.m_k - 1; i_++)
      c[i_] = state.m_c[i_];

    rep.m_rmserror = state.m_reprmserror;
    rep.m_wrmserror = state.m_repwrmserror;
    rep.m_avgerror = state.m_repavgerror;
    rep.m_avgrelerror = state.m_repavgrelerror;
    rep.m_maxerror = state.m_repmaxerror;
    rep.m_iterationscount = state.m_repiterationscount;
  }
}

static void CLSFit::LSFitScaleXY(double &x[], double &y[], double &w[],
                                 const int n, double &xc[], double &yc[],
                                 int &dc[], const int k, double &xa, double &xb,
                                 double &sa, double &sb, double &xoriginal[],
                                 double &yoriginal[]) {

  double xmin = 0;
  double xmax = 0;
  int i = 0;
  double mx = 0;
  int i_ = 0;

  xa = 0;
  xb = 0;
  sa = 0;
  sb = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": incorrect N"))
    return;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": incorrect K"))
    return;

  xmin = x[0];
  xmax = x[0];
  for (i = 1; i <= n - 1; i++) {
    xmin = MathMin(xmin, x[i]);
    xmax = MathMax(xmax, x[i]);
  }
  for (i = 0; i <= k - 1; i++) {
    xmin = MathMin(xmin, xc[i]);
    xmax = MathMax(xmax, xc[i]);
  }

  if (xmin == xmax) {

    if (xmin == 0.0) {
      xmin = -1;
      xmax = 1;
    } else {

      if (xmin > 0.0)
        xmin = 0.5 * xmin;
      else
        xmax = 0.5 * xmax;
    }
  }

  ArrayResizeAL(xoriginal, n);
  for (i_ = 0; i_ <= n - 1; i_++)
    xoriginal[i_] = x[i_];

  xa = xmin;
  xb = xmax;
  for (i = 0; i <= n - 1; i++)
    x[i] = 2 * (x[i] - 0.5 * (xa + xb)) / (xb - xa);

  for (i = 0; i <= k - 1; i++) {

    if (!CAp::Assert(dc[i] >= 0, __FUNCTION__ + ": internal error!"))
      return;
    xc[i] = 2 * (xc[i] - 0.5 * (xa + xb)) / (xb - xa);
    yc[i] = yc[i] * MathPow(0.5 * (xb - xa), dc[i]);
  }

  ArrayResizeAL(yoriginal, n);
  for (i_ = 0; i_ <= n - 1; i_++)
    yoriginal[i_] = y[i_];
  sa = 0;
  for (i = 0; i <= n - 1; i++)
    sa = sa + y[i];
  sa = sa / n;

  sb = 0;
  for (i = 0; i <= n - 1; i++)
    sb = sb + CMath::Sqr(y[i] - sa);
  sb = MathSqrt(sb / n) + sa;

  if (sb == sa)
    sb = 2 * sa;

  if (sb == sa)
    sb = sa + 1;
  for (i = 0; i <= n - 1; i++)
    y[i] = (y[i] - sa) / (sb - sa);
  for (i = 0; i <= k - 1; i++) {

    if (dc[i] == 0)
      yc[i] = (yc[i] - sa) / (sb - sa);
    else
      yc[i] = yc[i] / (sb - sa);
  }

  mx = 0;
  for (i = 0; i <= n - 1; i++)
    mx = MathMax(mx, MathAbs(w[i]));

  if (mx != 0.0) {
    for (i = 0; i <= n - 1; i++)
      w[i] = w[i] / mx;
  }
}

static void CLSFit::Spline1DFitInternal(const int st, double &cx[],
                                        double &cy[], double &cw[], const int n,
                                        double &cxc[], double &cyc[], int &dc[],
                                        const int k, const int m, int &info,
                                        CSpline1DInterpolant &s,
                                        CSpline1DFitReport &rep) {

  double v0 = 0;
  double v1 = 0;
  double v2 = 0;
  double mx = 0;
  int i = 0;
  int j = 0;
  int relcnt = 0;
  double xa = 0;
  double xb = 0;
  double sa = 0;
  double sb = 0;
  double bl = 0;
  double br = 0;
  double decay = 0;
  int i_ = 0;

  double y2[];
  double w2[];
  double sx[];
  double sy[];
  double sd[];
  double tmp[];
  double xoriginal[];
  double yoriginal[];
  double x[];
  double y[];
  double w[];
  double xc[];
  double yc[];

  CMatrixDouble fmatrix;
  CMatrixDouble cmatrix;

  CLSFitReport lrep;
  CSpline1DInterpolant s2;

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);
  ArrayCopy(w, cw);
  ArrayCopy(xc, cxc);
  ArrayCopy(yc, cyc);

  info = 0;

  if (!CAp::Assert(st == 0 || st == 1, __FUNCTION__ + ": internal error!"))
    return;

  if (st == 0 && m < 4) {
    info = -1;
    return;
  }

  if (st == 1 && m < 4) {
    info = -1;
    return;
  }

  if ((n < 1 || k < 0) || k >= m) {
    info = -1;
    return;
  }
  for (i = 0; i <= k - 1; i++) {
    info = 0;

    if (dc[i] < 0)
      info = -1;

    if (dc[i] > 1)
      info = -1;

    if (info < 0)
      return;
  }

  if (st == 1 && m % 2 != 0) {

    info = -2;
    return;
  }

  decay = 10000 * CMath::m_machineepsilon;

  LSFitScaleXY(x, y, w, n, xc, yc, dc, k, xa, xb, sa, sb, xoriginal, yoriginal);

  ArrayResizeAL(y2, n + m);
  ArrayResizeAL(w2, n + m);
  fmatrix.Resize(n + m, m);

  if (k > 0)
    cmatrix.Resize(k, m + 1);

  if (st == 0) {

    ArrayResizeAL(sx, m - 2);
    ArrayResizeAL(sy, m - 2);
    for (j = 0; j <= m - 2 - 1; j++)
      sx[j] = (double)(2 * j) / (double)(m - 2 - 1) - 1;
  }

  if (st == 1) {

    ArrayResizeAL(sx, m / 2);
    ArrayResizeAL(sy, m / 2);
    ArrayResizeAL(sd, m / 2);
    for (j = 0; j <= m / 2 - 1; j++)
      sx[j] = (double)(2 * j) / (double)(m / 2 - 1) - 1;
  }

  for (j = 0; j <= m - 1; j++) {

    if (st == 0) {

      for (i = 0; i <= m - 2 - 1; i++)
        sy[i] = 0;
      bl = 0;
      br = 0;

      if (j < m - 2)
        sy[j] = 1;

      if (j == m - 2)
        bl = 1;

      if (j == m - 1)
        br = 1;

      CSpline1D::Spline1DBuildCubic(sx, sy, m - 2, 1, bl, 1, br, s2);
    }

    if (st == 1) {

      for (i = 0; i <= m / 2 - 1; i++) {
        sy[i] = 0;
        sd[i] = 0;
      }

      if (j % 2 == 0)
        sy[j / 2] = 1;
      else
        sd[j / 2] = 1;

      CSpline1D::Spline1DBuildHermite(sx, sy, sd, m / 2, s2);
    }

    for (i = 0; i <= n - 1; i++)
      fmatrix[i].Set(j, CSpline1D::Spline1DCalc(s2, x[i]));
    for (i = 0; i <= k - 1; i++) {

      if (!CAp::Assert(dc[i] >= 0 && dc[i] <= 2,
                       __FUNCTION__ + ": internal error!"))
        return;

      CSpline1D::Spline1DDiff(s2, xc[i], v0, v1, v2);

      if (dc[i] == 0)
        cmatrix[i].Set(j, v0);

      if (dc[i] == 1)
        cmatrix[i].Set(j, v1);

      if (dc[i] == 2)
        cmatrix[i].Set(j, v2);
    }
  }

  for (i = 0; i <= k - 1; i++)
    cmatrix[i].Set(m, yc[i]);
  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= m - 1; j++) {

      if (i == j)
        fmatrix[n + i].Set(j, decay);
      else
        fmatrix[n + i].Set(j, 0);
    }
  }

  ArrayResizeAL(y2, n + m);
  ArrayResizeAL(w2, n + m);

  for (i_ = 0; i_ <= n - 1; i_++)
    y2[i_] = y[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    w2[i_] = w[i_];

  mx = 0;
  for (i = 0; i <= n - 1; i++)
    mx = mx + MathAbs(w[i]);
  mx = mx / n;
  for (i = 0; i <= m - 1; i++) {
    y2[n + i] = 0;
    w2[n + i] = mx;
  }

  if (k > 0) {

    LSFitLinearWC(y2, w2, fmatrix, cmatrix, n + m, m, k, info, tmp, lrep);
  } else {

    LSFitLinearWC(y, w, fmatrix, cmatrix, n, m, k, info, tmp, lrep);
  }

  if (info < 0)
    return;

  if (st == 0) {

    for (i_ = 0; i_ <= m - 2 - 1; i_++)
      sy[i_] = tmp[i_];

    CSpline1D::Spline1DBuildCubic(sx, sy, m - 2, 1, tmp[m - 2], 1, tmp[m - 1],
                                  s);
  }

  if (st == 1) {

    for (i = 0; i <= m / 2 - 1; i++) {
      sy[i] = tmp[2 * i];
      sd[i] = tmp[2 * i + 1];
    }

    CSpline1D::Spline1DBuildHermite(sx, sy, sd, m / 2, s);
  }

  CSpline1D::Spline1DLinTransX(s, 2 / (xb - xa), -((xa + xb) / (xb - xa)));

  CSpline1D::Spline1DLinTransY(s, sb - sa, sa);

  rep.m_taskrcond = lrep.m_taskrcond;
  rep.m_rmserror = lrep.m_rmserror * (sb - sa);
  rep.m_avgerror = lrep.m_avgerror * (sb - sa);
  rep.m_maxerror = lrep.m_maxerror * (sb - sa);
  rep.m_avgrelerror = 0;
  relcnt = 0;
  for (i = 0; i <= n - 1; i++) {

    if (yoriginal[i] != 0.0) {
      rep.m_avgrelerror =
          rep.m_avgrelerror +
          MathAbs(CSpline1D::Spline1DCalc(s, xoriginal[i]) - yoriginal[i]) /
              MathAbs(yoriginal[i]);
      relcnt = relcnt + 1;
    }
  }

  if (relcnt != 0)
    rep.m_avgrelerror = rep.m_avgrelerror / relcnt;
}

static void CLSFit::LSFitLinearInternal(double &y[], double &w[],
                                        CMatrixDouble &fmatrix, const int n,
                                        const int m, int &info, double &c[],
                                        CLSFitReport &rep) {

  double threshold = 0;
  int i = 0;
  int j = 0;
  double v = 0;
  int relcnt = 0;
  int i_ = 0;

  double b[];
  double wmod[];
  double tau[];
  double sv[];
  double tmp[];
  double utb[];
  double sutb[];

  CMatrixDouble ft;
  CMatrixDouble q;
  CMatrixDouble l;
  CMatrixDouble r;
  CMatrixDouble u;
  CMatrixDouble vt;

  info = 0;

  if (n < 1 || m < 1) {
    info = -1;
    return;
  }

  info = 1;
  threshold = MathSqrt(CMath::m_machineepsilon);

  if (n < m) {

    ft.Resize(n, m);
    ArrayResizeAL(b, n);
    ArrayResizeAL(wmod, n);
    for (j = 0; j <= n - 1; j++) {
      v = w[j];
      for (i_ = 0; i_ <= m - 1; i_++)
        ft[j].Set(i_, v * fmatrix[j][i_]);

      b[j] = w[j] * y[j];
      wmod[j] = 1;
    }

    ArrayResizeAL(c, m);
    for (i = 0; i <= m - 1; i++)
      c[i] = 0;
    rep.m_taskrcond = 0;

    COrtFac::RMatrixLQ(ft, n, m, tau);

    COrtFac::RMatrixLQUnpackQ(ft, n, m, tau, n, q);

    COrtFac::RMatrixLQUnpackL(ft, n, m, l);

    LSFitLinearInternal(b, wmod, l, n, n, info, tmp, rep);

    if (info <= 0)
      return;

    for (i = 0; i <= n - 1; i++) {
      v = tmp[i];
      for (i_ = 0; i_ <= m - 1; i_++)
        c[i_] = c[i_] + v * q[i][i_];
    }

    return;
  }

  ft.Resize(n, m);
  ArrayResizeAL(b, n);
  for (j = 0; j <= n - 1; j++) {
    v = w[j];
    for (i_ = 0; i_ <= m - 1; i_++)
      ft[j].Set(i_, v * fmatrix[j][i_]);
    b[j] = w[j] * y[j];
  }

  COrtFac::RMatrixQR(ft, n, m, tau);

  COrtFac::RMatrixQRUnpackQ(ft, n, m, tau, m, q);

  COrtFac::RMatrixQRUnpackR(ft, n, m, r);

  ArrayResizeAL(tmp, m);
  for (i = 0; i <= m - 1; i++)
    tmp[i] = 0;

  for (i = 0; i <= n - 1; i++) {
    v = b[i];
    for (i_ = 0; i_ <= m - 1; i_++)
      tmp[i_] = tmp[i_] + v * q[i][i_];
  }

  ArrayResizeAL(b, m);

  for (i_ = 0; i_ <= m - 1; i_++)
    b[i_] = tmp[i_];

  rep.m_taskrcond = CRCond::RMatrixLURCondInf(r, m);

  if (rep.m_taskrcond > threshold) {

    ArrayResizeAL(c, m);
    c[m - 1] = b[m - 1] / r[m - 1][m - 1];

    for (i = m - 2; i >= 0; i--) {
      v = 0.0;
      for (i_ = i + 1; i_ <= m - 1; i_++)
        v += r[i][i_] * c[i_];
      c[i] = (b[i] - v) / r[i][i];
    }
  } else {

    if (!CSingValueDecompose::RMatrixSVD(r, m, m, 1, 1, 2, sv, u, vt)) {
      info = -4;
      return;
    }

    ArrayResizeAL(utb, m);
    ArrayResizeAL(sutb, m);
    for (i = 0; i <= m - 1; i++)
      utb[i] = 0;

    for (i = 0; i <= m - 1; i++) {
      v = b[i];
      for (i_ = 0; i_ <= m - 1; i_++)
        utb[i_] = utb[i_] + v * u[i][i_];
    }

    if (sv[0] > 0.0) {
      rep.m_taskrcond = sv[m - 1] / sv[0];
      for (i = 0; i <= m - 1; i++) {

        if (sv[i] > threshold * sv[0])
          sutb[i] = utb[i] / sv[i];
        else
          sutb[i] = 0;
      }
    } else {

      rep.m_taskrcond = 0;
      for (i = 0; i <= m - 1; i++)
        sutb[i] = 0;
    }

    ArrayResizeAL(c, m);
    for (i = 0; i <= m - 1; i++)
      c[i] = 0;

    for (i = 0; i <= m - 1; i++) {
      v = sutb[i];
      for (i_ = 0; i_ <= m - 1; i_++)
        c[i_] = c[i_] + v * vt[i][i_];
    }
  }

  rep.m_rmserror = 0;
  rep.m_avgerror = 0;
  rep.m_avgrelerror = 0;
  rep.m_maxerror = 0;
  relcnt = 0;

  for (i = 0; i <= n - 1; i++) {
    v = 0.0;
    for (i_ = 0; i_ <= m - 1; i_++)
      v += fmatrix[i][i_] * c[i_];

    rep.m_rmserror = rep.m_rmserror + CMath::Sqr(v - y[i]);
    rep.m_avgerror = rep.m_avgerror + MathAbs(v - y[i]);

    if (y[i] != 0.0) {
      rep.m_avgrelerror = rep.m_avgrelerror + MathAbs(v - y[i]) / MathAbs(y[i]);
      relcnt = relcnt + 1;
    }
    rep.m_maxerror = MathMax(rep.m_maxerror, MathAbs(v - y[i]));
  }

  rep.m_rmserror = MathSqrt(rep.m_rmserror / n);
  rep.m_avgerror = rep.m_avgerror / n;

  if (relcnt != 0)
    rep.m_avgrelerror = rep.m_avgrelerror / relcnt;
}

static void CLSFit::LSFitClearRequestFields(CLSFitState &state) {

  state.m_needf = false;
  state.m_needfg = false;
  state.m_needfgh = false;
  state.m_xupdated = false;
}

static void CLSFit::BarycentricCalcBasis(CBarycentricInterpolant &b,
                                         const double t, double &y[]) {

  double s2 = 0;
  double s = 0;
  double v = 0;
  int i = 0;
  int j = 0;
  int i_ = 0;

  if (b.m_n == 1) {
    y[0] = 1;
    return;
  }

  s = MathAbs(t - b.m_x[0]);
  for (i = 0; i <= b.m_n - 1; i++) {
    v = b.m_x[i];

    if (v == t) {
      for (j = 0; j <= b.m_n - 1; j++)
        y[j] = 0;
      y[i] = 1;

      return;
    }

    v = MathAbs(t - v);

    if (v < s)
      s = v;
  }
  s2 = 0;

  for (i = 0; i <= b.m_n - 1; i++) {
    v = s / (t - b.m_x[i]);
    v = v * b.m_w[i];
    y[i] = v;
    s2 = s2 + v;
  }

  v = 1 / s2;
  for (i_ = 0; i_ <= b.m_n - 1; i_++)
    y[i_] = v * y[i_];
}

static void CLSFit::InternalChebyshevFit(double &x[], double &y[], double &w[],
                                         const int n, double &cxc[],
                                         double &cyc[], int &dc[], const int k,
                                         const int m, int &info, double &c[],
                                         CLSFitReport &rep) {

  int i = 0;
  int j = 0;
  double mx = 0;
  double decay = 0;
  int i_ = 0;

  double y2[];
  double w2[];
  double tmp[];
  double tmp2[];
  double tmpdiff[];
  double bx[];
  double by[];
  double bw[];
  double xc[];
  double yc[];

  CMatrixDouble fmatrix;
  CMatrixDouble cmatrix;

  ArrayCopy(xc, cxc);
  ArrayCopy(yc, cyc);

  info = 0;

  decay = 10000 * CMath::m_machineepsilon;

  ArrayResizeAL(y2, n + m);
  ArrayResizeAL(w2, n + m);
  ArrayResizeAL(tmp, m);
  ArrayResizeAL(tmpdiff, m);
  fmatrix.Resize(n + m, m);

  if (k > 0)
    cmatrix.Resize(k, m + 1);

  for (i = 0; i <= n - 1; i++) {

    for (j = 0; j <= m - 1; j++) {

      if (j == 0)
        tmp[j] = 1;
      else {

        if (j == 1)
          tmp[j] = x[i];
        else
          tmp[j] = 2 * x[i] * tmp[j - 1] - tmp[j - 2];
      }
    }

    for (i_ = 0; i_ <= m - 1; i_++)
      fmatrix[i].Set(i_, tmp[i_]);
  }

  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= m - 1; j++) {

      if (i == j)
        fmatrix[n + i].Set(j, decay);
      else
        fmatrix[n + i].Set(j, 0);
    }
  }

  for (i_ = 0; i_ <= n - 1; i_++)
    y2[i_] = y[i_];
  for (i_ = 0; i_ <= n - 1; i_++)
    w2[i_] = w[i_];

  mx = 0;
  for (i = 0; i <= n - 1; i++)
    mx = mx + MathAbs(w[i]);
  mx = mx / n;

  for (i = 0; i <= m - 1; i++) {
    y2[n + i] = 0;
    w2[n + i] = mx;
  }

  for (i = 0; i <= k - 1; i++) {

    for (j = 0; j <= m - 1; j++) {

      if (j == 0) {
        tmp[j] = 1;
        tmpdiff[j] = 0;
      } else {

        if (j == 1) {
          tmp[j] = xc[i];
          tmpdiff[j] = 1;
        } else {
          tmp[j] = 2 * xc[i] * tmp[j - 1] - tmp[j - 2];
          tmpdiff[j] =
              2 * (tmp[j - 1] + xc[i] * tmpdiff[j - 1]) - tmpdiff[j - 2];
        }
      }
    }

    if (dc[i] == 0) {
      for (i_ = 0; i_ <= m - 1; i_++)
        cmatrix[i].Set(i_, tmp[i_]);
    }

    if (dc[i] == 1) {
      for (i_ = 0; i_ <= m - 1; i_++)
        cmatrix[i].Set(i_, tmpdiff[i_]);
    }
    cmatrix[i].Set(m, yc[i]);
  }

  if (k > 0) {

    LSFitLinearWC(y2, w2, fmatrix, cmatrix, n + m, m, k, info, c, rep);
  } else {

    LSFitLinearWC(y, w, fmatrix, cmatrix, n, m, 0, info, c, rep);
  }

  if (info < 0)
    return;
}

static void CLSFit::BarycentricFitWCFixedD(
    double &cx[], double &cy[], double &cw[], const int n, double &cxc[],
    double &cyc[], int &dc[], const int k, const int m, const int d, int &info,
    CBarycentricInterpolant &b, CBarycentricFitReport &rep) {

  double v0 = 0;
  double v1 = 0;
  double mx = 0;
  int i = 0;
  int j = 0;
  int relcnt = 0;
  double xa = 0;
  double xb = 0;
  double sa = 0;
  double sb = 0;
  double decay = 0;
  int i_ = 0;

  double y2[];
  double w2[];
  double sx[];
  double sy[];
  double sbf[];
  double xoriginal[];
  double yoriginal[];
  double tmp[];
  double x[];
  double y[];
  double w[];
  double xc[];
  double yc[];

  CMatrixDouble fmatrix;
  CMatrixDouble cmatrix;

  CLSFitReport lrep;
  CBarycentricInterpolant b2;

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);
  ArrayCopy(w, cw);
  ArrayCopy(xc, cxc);
  ArrayCopy(yc, cyc);

  info = 0;

  if (((n < 1 || m < 2) || k < 0) || k >= m) {
    info = -1;
    return;
  }
  for (i = 0; i <= k - 1; i++) {
    info = 0;

    if (dc[i] < 0)
      info = -1;

    if (dc[i] > 1)
      info = -1;

    if (info < 0)
      return;
  }

  decay = 10000 * CMath::m_machineepsilon;

  LSFitScaleXY(x, y, w, n, xc, yc, dc, k, xa, xb, sa, sb, xoriginal, yoriginal);

  ArrayResizeAL(y2, n + m);
  ArrayResizeAL(w2, n + m);
  fmatrix.Resize(n + m, m);

  if (k > 0)
    cmatrix.Resize(k, m + 1);

  ArrayResizeAL(y2, n + m);
  ArrayResizeAL(w2, n + m);

  ArrayResizeAL(sx, m);
  ArrayResizeAL(sy, m);
  ArrayResizeAL(sbf, m);
  for (j = 0; j <= m - 1; j++)
    sx[j] = (double)(2 * j) / (double)(m - 1) - 1;
  for (i = 0; i <= m - 1; i++)
    sy[i] = 1;

  CRatInt::BarycentricBuildFloaterHormann(sx, sy, m, d, b2);

  mx = 0;

  for (i = 0; i <= n - 1; i++) {

    BarycentricCalcBasis(b2, x[i], sbf);
    for (i_ = 0; i_ <= m - 1; i_++)
      fmatrix[i].Set(i_, sbf[i_]);

    y2[i] = y[i];
    w2[i] = w[i];
    mx = mx + MathAbs(w[i]) / n;
  }

  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= m - 1; j++) {

      if (i == j)
        fmatrix[n + i].Set(j, decay);
      else
        fmatrix[n + i].Set(j, 0);
    }

    y2[n + i] = 0;
    w2[n + i] = mx;
  }

  if (k > 0) {
    for (j = 0; j <= m - 1; j++) {
      for (i = 0; i <= m - 1; i++)
        sy[i] = 0;
      sy[j] = 1;

      CRatInt::BarycentricBuildFloaterHormann(sx, sy, m, d, b2);

      for (i = 0; i <= k - 1; i++) {

        if (!CAp::Assert(dc[i] >= 0 && dc[i] <= 1,
                         __FUNCTION__ + ": internal error!"))
          return;

        CRatInt::BarycentricDiff1(b2, xc[i], v0, v1);

        if (dc[i] == 0)
          cmatrix[i].Set(j, v0);

        if (dc[i] == 1)
          cmatrix[i].Set(j, v1);
      }
    }
    for (i = 0; i <= k - 1; i++)
      cmatrix[i].Set(m, yc[i]);
  }

  if (k > 0) {

    LSFitLinearWC(y2, w2, fmatrix, cmatrix, n + m, m, k, info, tmp, lrep);
  } else {

    LSFitLinearWC(y, w, fmatrix, cmatrix, n, m, k, info, tmp, lrep);
  }

  if (info < 0)
    return;

  for (i_ = 0; i_ <= m - 1; i_++)
    sy[i_] = tmp[i_];

  CRatInt::BarycentricBuildFloaterHormann(sx, sy, m, d, b);

  CRatInt::BarycentricLinTransX(b, 2 / (xb - xa), -((xa + xb) / (xb - xa)));

  CRatInt::BarycentricLinTransY(b, sb - sa, sa);

  rep.m_taskrcond = lrep.m_taskrcond;
  rep.m_rmserror = lrep.m_rmserror * (sb - sa);
  rep.m_avgerror = lrep.m_avgerror * (sb - sa);
  rep.m_maxerror = lrep.m_maxerror * (sb - sa);
  rep.m_avgrelerror = 0;
  relcnt = 0;
  for (i = 0; i <= n - 1; i++) {

    if (yoriginal[i] != 0.0) {
      rep.m_avgrelerror =
          rep.m_avgrelerror +
          MathAbs(CRatInt::BarycentricCalc(b, xoriginal[i]) - yoriginal[i]) /
              MathAbs(yoriginal[i]);
      relcnt = relcnt + 1;
    }
  }

  if (relcnt != 0)
    rep.m_avgrelerror = rep.m_avgrelerror / relcnt;
}

static bool CLSFit::LSFitIteration(CLSFitState &state) {

  int n = 0;
  int m = 0;
  int k = 0;
  int i = 0;
  int j = 0;
  double v = 0;
  double vv = 0;
  double relcnt = 0;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    m = state.m_rstate.ia[1];
    k = state.m_rstate.ia[2];
    i = state.m_rstate.ia[3];
    j = state.m_rstate.ia[4];
    v = state.m_rstate.ra[0];
    vv = state.m_rstate.ra[1];
    relcnt = state.m_rstate.ra[2];
  } else {

    n = -983;
    m = -989;
    k = -834;
    i = 900;
    j = -287;
    v = 364;
    vv = 214;
    relcnt = -338;
  }

  if (state.m_rstate.stage == 0) {

    state.m_needf = false;

    if (state.m_wkind == 1)
      vv = state.m_w[i];
    else
      vv = 1.0;

    state.m_optstate.m_fi[i] = vv * (state.m_f - state.m_tasky[i]);
    i = i + 1;

    return (Func_lbl_11(state, n, m, k, i, j, v, vv, relcnt));
  }

  if (state.m_rstate.stage == 1) {

    state.m_needf = false;

    if (state.m_wkind == 1)
      vv = state.m_w[i];
    else
      vv = 1.0;

    state.m_optstate.m_f =
        state.m_optstate.m_f + CMath::Sqr(vv * (state.m_f - state.m_tasky[i]));
    i = i + 1;

    return (Func_lbl_16(state, n, m, k, i, j, v, vv, relcnt));
  }

  if (state.m_rstate.stage == 2) {

    state.m_needfg = false;

    if (state.m_wkind == 1)
      vv = state.m_w[i];
    else
      vv = 1.0;

    state.m_optstate.m_f =
        state.m_optstate.m_f + CMath::Sqr(vv * (state.m_f - state.m_tasky[i]));
    v = CMath::Sqr(vv) * 2 * (state.m_f - state.m_tasky[i]);
    for (i_ = 0; i_ <= k - 1; i_++)
      state.m_optstate.m_g[i_] = state.m_optstate.m_g[i_] + v * state.m_g[i_];
    i = i + 1;

    return (Func_lbl_21(state, n, m, k, i, j, v, vv, relcnt));
  }

  if (state.m_rstate.stage == 3) {

    state.m_needfg = false;

    if (state.m_wkind == 1)
      vv = state.m_w[i];
    else
      vv = 1.0;

    state.m_optstate.m_fi[i] = vv * (state.m_f - state.m_tasky[i]);
    for (i_ = 0; i_ <= k - 1; i_++)
      state.m_optstate.m_j[i].Set(i_, vv * state.m_g[i_]);
    i = i + 1;

    return (Func_lbl_26(state, n, m, k, i, j, v, vv, relcnt));
  }

  if (state.m_rstate.stage == 4) {

    state.m_needfgh = false;

    if (state.m_wkind == 1)
      vv = state.m_w[i];
    else
      vv = 1.0;

    state.m_optstate.m_f =
        state.m_optstate.m_f + CMath::Sqr(vv * (state.m_f - state.m_tasky[i]));
    v = CMath::Sqr(vv) * 2 * (state.m_f - state.m_tasky[i]);
    for (i_ = 0; i_ <= k - 1; i_++)
      state.m_optstate.m_g[i_] = state.m_optstate.m_g[i_] + v * state.m_g[i_];

    for (j = 0; j <= k - 1; j++) {
      v = 2 * CMath::Sqr(vv) * state.m_g[j];
      for (i_ = 0; i_ <= k - 1; i_++)
        state.m_optstate.m_h[j].Set(i_, state.m_optstate.m_h[j][i_] +
                                            v * state.m_g[i_]);
      v = 2 * CMath::Sqr(vv) * (state.m_f - state.m_tasky[i]);
      for (i_ = 0; i_ <= k - 1; i_++)
        state.m_optstate.m_h[j].Set(i_, state.m_optstate.m_h[j][i_] +
                                            v * state.m_h[j][i_]);
    }
    i = i + 1;

    return (Func_lbl_31(state, n, m, k, i, j, v, vv, relcnt));
  }

  if (state.m_rstate.stage == 5) {

    state.m_xupdated = false;

    return (Func_lbl_7(state, n, m, k, i, j, v, vv, relcnt));
  }

  if (state.m_rstate.stage == 6) {

    state.m_needf = false;
    v = state.m_f;

    if (state.m_wkind == 1)
      vv = state.m_w[i];
    else
      vv = 1.0;

    state.m_reprmserror =
        state.m_reprmserror + CMath::Sqr(v - state.m_tasky[i]);
    state.m_repwrmserror =
        state.m_repwrmserror + CMath::Sqr(vv * (v - state.m_tasky[i]));
    state.m_repavgerror = state.m_repavgerror + MathAbs(v - state.m_tasky[i]);

    if (state.m_tasky[i] != 0.0) {
      state.m_repavgrelerror =
          state.m_repavgrelerror +
          MathAbs(v - state.m_tasky[i]) / MathAbs(state.m_tasky[i]);
      relcnt = relcnt + 1;
    }

    state.m_repmaxerror =
        MathMax(state.m_repmaxerror, MathAbs(v - state.m_tasky[i]));
    i = i + 1;

    return (Func_lbl_38(state, n, m, k, i, j, v, vv, relcnt));
  }

  if (state.m_wkind == 1) {

    if (!CAp::Assert(
            state.m_npoints == state.m_nweights,
            __FUNCTION__ +
                ": number of points is not equal to the number of weights"))
      return (false);
  }

  n = state.m_npoints;
  m = state.m_m;
  k = state.m_k;

  CMinLM::MinLMSetCond(state.m_optstate, 0.0, state.m_epsf, state.m_epsx,
                       state.m_maxits);

  CMinLM::MinLMSetStpMax(state.m_optstate, state.m_stpmax);

  CMinLM::MinLMSetXRep(state.m_optstate, state.m_xrep);

  CMinLM::MinLMSetScale(state.m_optstate, state.m_s);

  CMinLM::MinLMSetBC(state.m_optstate, state.m_bndl, state.m_bndu);

  return (Func_lbl_7(state, n, m, k, i, j, v, vv, relcnt));
}

static void CLSFit::Func_lbl_rcomm(CLSFitState &state, int n, int m, int k,
                                   int i, int j, double v, double vv,
                                   double relcnt) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ia[1] = m;
  state.m_rstate.ia[2] = k;
  state.m_rstate.ia[3] = i;
  state.m_rstate.ia[4] = j;
  state.m_rstate.ra[0] = v;
  state.m_rstate.ra[1] = vv;
  state.m_rstate.ra[2] = relcnt;
}

static bool CLSFit::Func_lbl_7(CLSFitState &state, int &n, int &m, int &k,
                               int &i, int &j, double &v, double &vv,
                               double &relcnt) {

  if (!CMinLM::MinLMIteration(state.m_optstate)) {

    CMinLM::MinLMResults(state.m_optstate, state.m_c, state.m_optrep);

    state.m_repterminationtype = state.m_optrep.m_terminationtype;
    state.m_repiterationscount = state.m_optrep.m_iterationscount;

    if (state.m_repterminationtype <= 0)
      return (false);

    state.m_reprmserror = 0;
    state.m_repwrmserror = 0;
    state.m_repavgerror = 0;
    state.m_repavgrelerror = 0;
    state.m_repmaxerror = 0;
    relcnt = 0;
    i = 0;

    return (Func_lbl_38(state, n, m, k, i, j, v, vv, relcnt));
  }

  if (!state.m_optstate.m_needfi) {

    if (!state.m_optstate.m_needf)
      return (Func_lbl_14(state, n, m, k, i, j, v, vv, relcnt));

    state.m_optstate.m_f = 0;
    i = 0;

    return (Func_lbl_16(state, n, m, k, i, j, v, vv, relcnt));
  }

  i = 0;

  return (Func_lbl_11(state, n, m, k, i, j, v, vv, relcnt));
}

static bool CLSFit::Func_lbl_11(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (i > n - 1)
    return (Func_lbl_7(state, n, m, k, i, j, v, vv, relcnt));

  for (int i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = state.m_optstate.m_x[i_];
  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_x[i_] = state.m_taskx[i][i_];
  state.m_pointindex = i;

  LSFitClearRequestFields(state);

  state.m_needf = true;
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, m, k, i, j, v, vv, relcnt);

  return (true);
}

static bool CLSFit::Func_lbl_14(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (!state.m_optstate.m_needfg) {

    if (!state.m_optstate.m_needfij)
      return (Func_lbl_24(state, n, m, k, i, j, v, vv, relcnt));

    i = 0;

    return (Func_lbl_26(state, n, m, k, i, j, v, vv, relcnt));
  }

  state.m_optstate.m_f = 0;
  for (i = 0; i <= k - 1; i++)
    state.m_optstate.m_g[i] = 0;
  i = 0;

  return (Func_lbl_21(state, n, m, k, i, j, v, vv, relcnt));
}

static bool CLSFit::Func_lbl_16(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (i > n - 1)
    return (Func_lbl_7(state, n, m, k, i, j, v, vv, relcnt));

  for (int i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = state.m_optstate.m_x[i_];
  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_x[i_] = state.m_taskx[i][i_];
  state.m_pointindex = i;

  LSFitClearRequestFields(state);

  state.m_needf = true;
  state.m_rstate.stage = 1;

  Func_lbl_rcomm(state, n, m, k, i, j, v, vv, relcnt);

  return (true);
}

static bool CLSFit::Func_lbl_21(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (i > n - 1)
    return (Func_lbl_7(state, n, m, k, i, j, v, vv, relcnt));

  for (int i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = state.m_optstate.m_x[i_];
  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_x[i_] = state.m_taskx[i][i_];
  state.m_pointindex = i;

  LSFitClearRequestFields(state);

  state.m_needfg = true;
  state.m_rstate.stage = 2;

  Func_lbl_rcomm(state, n, m, k, i, j, v, vv, relcnt);

  return (true);
}

static bool CLSFit::Func_lbl_24(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (!state.m_optstate.m_needfgh)
    return (Func_lbl_29(state, n, m, k, i, j, v, vv, relcnt));

  state.m_optstate.m_f = 0;
  for (i = 0; i <= k - 1; i++)
    state.m_optstate.m_g[i] = 0;
  for (i = 0; i <= k - 1; i++) {
    for (j = 0; j <= k - 1; j++)
      state.m_optstate.m_h[i].Set(j, 0);
  }

  i = 0;

  return (Func_lbl_31(state, n, m, k, i, j, v, vv, relcnt));
}

static bool CLSFit::Func_lbl_26(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (i > n - 1)
    return (Func_lbl_7(state, n, m, k, i, j, v, vv, relcnt));

  for (int i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = state.m_optstate.m_x[i_];
  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_x[i_] = state.m_taskx[i][i_];
  state.m_pointindex = i;

  LSFitClearRequestFields(state);

  state.m_needfg = true;
  state.m_rstate.stage = 3;

  Func_lbl_rcomm(state, n, m, k, i, j, v, vv, relcnt);

  return (true);
}

static bool CLSFit::Func_lbl_29(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (!state.m_optstate.m_xupdated)
    return (Func_lbl_7(state, n, m, k, i, j, v, vv, relcnt));

  for (int i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = state.m_optstate.m_x[i_];
  state.m_f = state.m_optstate.m_f;

  LSFitClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 5;

  Func_lbl_rcomm(state, n, m, k, i, j, v, vv, relcnt);

  return (true);
}

static bool CLSFit::Func_lbl_31(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (i > n - 1)
    return (Func_lbl_7(state, n, m, k, i, j, v, vv, relcnt));

  for (int i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = state.m_optstate.m_x[i_];
  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_x[i_] = state.m_taskx[i][i_];
  state.m_pointindex = i;

  LSFitClearRequestFields(state);

  state.m_needfgh = true;
  state.m_rstate.stage = 4;

  Func_lbl_rcomm(state, n, m, k, i, j, v, vv, relcnt);

  return (true);
}

static bool CLSFit::Func_lbl_38(CLSFitState &state, int &n, int &m, int &k,
                                int &i, int &j, double &v, double &vv,
                                double &relcnt) {

  if (i > n - 1) {

    state.m_reprmserror = MathSqrt(state.m_reprmserror / n);
    state.m_repwrmserror = MathSqrt(state.m_repwrmserror / n);
    state.m_repavgerror = state.m_repavgerror / n;

    if (relcnt != 0.0)
      state.m_repavgrelerror = state.m_repavgrelerror / relcnt;

    return (false);
  }

  for (int i_ = 0; i_ <= k - 1; i_++)
    state.m_c[i_] = state.m_c[i_];
  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_x[i_] = state.m_taskx[i][i_];
  state.m_pointindex = i;

  LSFitClearRequestFields(state);

  state.m_needf = true;
  state.m_rstate.stage = 6;

  Func_lbl_rcomm(state, n, m, k, i, j, v, vv, relcnt);

  return (true);
}

class CPSpline2Interpolant {
public:
  int m_n;
  bool m_periodic;
  CSpline1DInterpolant m_x;
  CSpline1DInterpolant m_y;

  double m_p[];

  CPSpline2Interpolant(void);
  ~CPSpline2Interpolant(void);

  void Copy(CPSpline2Interpolant &obj);
};

CPSpline2Interpolant::CPSpline2Interpolant(void) {}

CPSpline2Interpolant::~CPSpline2Interpolant(void) {}

void CPSpline2Interpolant::Copy(CPSpline2Interpolant &obj) {

  m_n = obj.m_n;
  m_periodic = obj.m_periodic;
  m_x.Copy(obj.m_x);
  m_y.Copy(obj.m_y);

  ArrayCopy(m_p, obj.m_p);
}

class CPSpline2InterpolantShell {
private:
  CPSpline2Interpolant m_innerobj;

public:
  CPSpline2InterpolantShell(void);
  CPSpline2InterpolantShell(CPSpline2Interpolant &obj);
  ~CPSpline2InterpolantShell(void);

  CPSpline2Interpolant *GetInnerObj(void);
};

CPSpline2InterpolantShell::CPSpline2InterpolantShell(void) {}

CPSpline2InterpolantShell::CPSpline2InterpolantShell(
    CPSpline2Interpolant &obj) {

  m_innerobj.Copy(obj);
}

CPSpline2InterpolantShell::~CPSpline2InterpolantShell(void) {}

CPSpline2Interpolant *CPSpline2InterpolantShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CPSpline3Interpolant {
public:
  int m_n;
  bool m_periodic;
  CSpline1DInterpolant m_x;
  CSpline1DInterpolant m_y;
  CSpline1DInterpolant m_z;

  double m_p[];

  CPSpline3Interpolant(void);
  ~CPSpline3Interpolant(void);

  void Copy(CPSpline3Interpolant &obj);
};

CPSpline3Interpolant::CPSpline3Interpolant(void) {}

CPSpline3Interpolant::~CPSpline3Interpolant(void) {}

void CPSpline3Interpolant::Copy(CPSpline3Interpolant &obj) {

  m_n = obj.m_n;
  m_periodic = obj.m_periodic;
  m_x.Copy(obj.m_x);
  m_y.Copy(obj.m_y);
  m_z.Copy(obj.m_z);

  ArrayCopy(m_p, obj.m_p);
}

class CPSpline3InterpolantShell {
private:
  CPSpline3Interpolant m_innerobj;

public:
  CPSpline3InterpolantShell(void);
  CPSpline3InterpolantShell(CPSpline3Interpolant &obj);
  ~CPSpline3InterpolantShell(void);

  CPSpline3Interpolant *GetInnerObj(void);
};

CPSpline3InterpolantShell::CPSpline3InterpolantShell(void) {}

CPSpline3InterpolantShell::CPSpline3InterpolantShell(
    CPSpline3Interpolant &obj) {

  m_innerobj.Copy(obj);
}

CPSpline3InterpolantShell::~CPSpline3InterpolantShell(void) {}

CPSpline3Interpolant *CPSpline3InterpolantShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CPSpline {
private:
  static void PSpline2Par(CMatrixDouble &xy, const int n, const int pt,
                          double &p[]);
  static void PSpline3Par(CMatrixDouble &xy, const int n, const int pt,
                          double &p[]);

public:
  CPSpline(void);
  ~CPSpline(void);

  static void PSpline2Build(CMatrixDouble &cxy, const int n, const int st,
                            const int pt, CPSpline2Interpolant &p);
  static void PSpline3Build(CMatrixDouble &cxy, const int n, const int st,
                            const int pt, CPSpline3Interpolant &p);
  static void PSpline2BuildPeriodic(CMatrixDouble &cxy, const int n,
                                    const int st, const int pt,
                                    CPSpline2Interpolant &p);
  static void PSpline3BuildPeriodic(CMatrixDouble &cxy, const int n,
                                    const int st, const int pt,
                                    CPSpline3Interpolant &p);
  static void PSpline2ParameterValues(CPSpline2Interpolant &p, int &n,
                                      double &t[]);
  static void PSpline3ParameterValues(CPSpline3Interpolant &p, int &n,
                                      double &t[]);
  static void PSpline2Calc(CPSpline2Interpolant &p, double t, double &x,
                           double &y);
  static void PSpline3Calc(CPSpline3Interpolant &p, double t, double &x,
                           double &y, double &z);
  static void PSpline2Tangent(CPSpline2Interpolant &p, double t, double &x,
                              double &y);
  static void PSpline3Tangent(CPSpline3Interpolant &p, double t, double &x,
                              double &y, double &z);
  static void PSpline2Diff(CPSpline2Interpolant &p, double t, double &x,
                           double &dx, double &y, double &dy);
  static void PSpline3Diff(CPSpline3Interpolant &p, double t, double &x,
                           double &dx, double &y, double &dy, double &z,
                           double &dz);
  static void PSpline2Diff2(CPSpline2Interpolant &p, double t, double &x,
                            double &dx, double &d2x, double &y, double &dy,
                            double &d2y);
  static void PSpline3Diff2(CPSpline3Interpolant &p, double t, double &x,
                            double &dx, double &d2x, double &y, double &dy,
                            double &d2y, double &z, double &dz, double &d2z);
  static double PSpline2ArcLength(CPSpline2Interpolant &p, const double a,
                                  const double b);
  static double PSpline3ArcLength(CPSpline3Interpolant &p, const double a,
                                  const double b);
};

CPSpline::CPSpline(void) {}

CPSpline::~CPSpline(void) {}

static void CPSpline::PSpline2Build(CMatrixDouble &cxy, const int n,
                                    const int st, const int pt,
                                    CPSpline2Interpolant &p) {

  int i_ = 0;

  double tmp[];

  CMatrixDouble xy;
  xy = cxy;

  if (!CAp::Assert(st >= 0 && st <= 2,
                   __FUNCTION__ + ": incorrect spline type!"))
    return;

  if (!CAp::Assert(pt >= 0 && pt <= 2,
                   __FUNCTION__ + ": incorrect parameterization type!"))
    return;

  if (st == 0) {

    if (!CAp::Assert(n >= 5,
                     __FUNCTION__ + ": N<5 (minimum value for Akima splines)!"))
      return;
  } else {

    if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2!"))
      return;
  }

  p.m_n = n;
  p.m_periodic = false;

  ArrayResizeAL(tmp, n);

  PSpline2Par(xy, n, pt, p.m_p);

  if (!CAp::Assert(CApServ::AreDistinct(p.m_p, n),
                   __FUNCTION__ + ": consequent points are too close!"))
    return;

  if (st == 0) {

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][0];

    CSpline1D::Spline1DBuildAkima(p.m_p, tmp, n, p.m_x);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][1];

    CSpline1D::Spline1DBuildAkima(p.m_p, tmp, n, p.m_y);
  }

  if (st == 1) {

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][0];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n, 0, 0.0, p.m_x);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][1];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n, 0, 0.0, p.m_y);
  }

  if (st == 2) {

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][0];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n, 0, 0.0, 0, 0.0, p.m_x);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][1];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n, 0, 0.0, 0, 0.0, p.m_y);
  }
}

static void CPSpline::PSpline3Build(CMatrixDouble &cxy, const int n,
                                    const int st, const int pt,
                                    CPSpline3Interpolant &p) {

  int i_ = 0;

  double tmp[];

  CMatrixDouble xy;
  xy = cxy;

  if (!CAp::Assert(st >= 0 && st <= 2,
                   __FUNCTION__ + ": incorrect spline type!"))
    return;

  if (!CAp::Assert(pt >= 0 && pt <= 2,
                   __FUNCTION__ + ": incorrect parameterization type!"))
    return;

  if (st == 0) {

    if (!CAp::Assert(n >= 5,
                     __FUNCTION__ + ": N<5 (minimum value for Akima splines)!"))
      return;
  } else {

    if (!CAp::Assert(n >= 2, __FUNCTION__ + "PSpline3Build: N<2!"))
      return;
  }

  p.m_n = n;
  p.m_periodic = false;

  ArrayResizeAL(tmp, n);

  PSpline3Par(xy, n, pt, p.m_p);

  if (!CAp::Assert(CApServ::AreDistinct(p.m_p, n),
                   __FUNCTION__ + ": consequent points are too close!"))
    return;

  if (st == 0) {

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][0];

    CSpline1D::Spline1DBuildAkima(p.m_p, tmp, n, p.m_x);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][1];

    CSpline1D::Spline1DBuildAkima(p.m_p, tmp, n, p.m_y);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][2];

    CSpline1D::Spline1DBuildAkima(p.m_p, tmp, n, p.m_z);
  }

  if (st == 1) {

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][0];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n, 0, 0.0, p.m_x);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][1];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n, 0, 0.0, p.m_y);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][2];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n, 0, 0.0, p.m_z);
  }

  if (st == 2) {

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][0];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n, 0, 0.0, 0, 0.0, p.m_x);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][1];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n, 0, 0.0, 0, 0.0, p.m_y);

    for (i_ = 0; i_ <= n - 1; i_++)
      tmp[i_] = xy[i_][2];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n, 0, 0.0, 0, 0.0, p.m_z);
  }
}

static void CPSpline::PSpline2BuildPeriodic(CMatrixDouble &cxy, const int n,
                                            const int st, const int pt,
                                            CPSpline2Interpolant &p) {

  int i_ = 0;

  double tmp[];

  CMatrixDouble xyp;
  CMatrixDouble xy;

  xy = cxy;

  if (!CAp::Assert(st >= 1 && st <= 2,
                   __FUNCTION__ + ": incorrect spline type!"))
    return;

  if (!CAp::Assert(pt >= 0 && pt <= 2,
                   __FUNCTION__ + ": incorrect parameterization type!"))
    return;

  if (!CAp::Assert(n >= 3, __FUNCTION__ + ": N<3!"))
    return;

  p.m_n = n;
  p.m_periodic = true;

  ArrayResizeAL(tmp, n + 1);
  xyp.Resize(n + 1, 2);

  for (i_ = 0; i_ <= n - 1; i_++)
    xyp[i_].Set(0, xy[i_][0]);
  for (i_ = 0; i_ <= n - 1; i_++)
    xyp[i_].Set(1, xy[i_][1]);
  for (i_ = 0; i_ <= 1; i_++)
    xyp[n].Set(i_, xy[0][i_]);

  PSpline2Par(xyp, n + 1, pt, p.m_p);

  if (!CAp::Assert(
          CApServ::AreDistinct(p.m_p, n + 1),
          __FUNCTION__ +
              ": consequent (or first and last) points are too close!"))
    return;

  if (st == 1) {

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][0];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n + 1, -1, 0.0, p.m_x);

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][1];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n + 1, -1, 0.0, p.m_y);
  }

  if (st == 2) {

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][0];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n + 1, -1, 0.0, -1, 0.0, p.m_x);

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][1];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n + 1, -1, 0.0, -1, 0.0, p.m_y);
  }
}

static void CPSpline::PSpline3BuildPeriodic(CMatrixDouble &cxy, const int n,
                                            const int st, const int pt,
                                            CPSpline3Interpolant &p) {

  int i_ = 0;

  double tmp[];

  CMatrixDouble xyp;
  CMatrixDouble xy;

  xy = cxy;

  if (!CAp::Assert(st >= 1 && st <= 2,
                   __FUNCTION__ + ": incorrect spline type!"))
    return;

  if (!CAp::Assert(pt >= 0 && pt <= 2,
                   __FUNCTION__ + ": incorrect parameterization type!"))
    return;

  if (!CAp::Assert(n >= 3, __FUNCTION__ + ": N<3!"))
    return;

  p.m_n = n;
  p.m_periodic = true;

  ArrayResizeAL(tmp, n + 1);
  xyp.Resize(n + 1, 3);

  for (i_ = 0; i_ <= n - 1; i_++)
    xyp[i_].Set(0, xy[i_][0]);
  for (i_ = 0; i_ <= n - 1; i_++)
    xyp[i_].Set(1, xy[i_][1]);
  for (i_ = 0; i_ <= n - 1; i_++)
    xyp[i_].Set(2, xy[i_][2]);
  for (i_ = 0; i_ <= 2; i_++)
    xyp[n].Set(i_, xy[0][i_]);

  PSpline3Par(xyp, n + 1, pt, p.m_p);

  if (!CAp::Assert(
          CApServ::AreDistinct(p.m_p, n + 1),
          __FUNCTION__ +
              ": consequent (or first and last) points are too close!"))
    return;

  if (st == 1) {

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][0];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n + 1, -1, 0.0, p.m_x);

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][1];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n + 1, -1, 0.0, p.m_y);

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][2];

    CSpline1D::Spline1DBuildCatmullRom(p.m_p, tmp, n + 1, -1, 0.0, p.m_z);
  }

  if (st == 2) {

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][0];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n + 1, -1, 0.0, -1, 0.0, p.m_x);

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][1];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n + 1, -1, 0.0, -1, 0.0, p.m_y);

    for (i_ = 0; i_ <= n; i_++)
      tmp[i_] = xyp[i_][2];

    CSpline1D::Spline1DBuildCubic(p.m_p, tmp, n + 1, -1, 0.0, -1, 0.0, p.m_z);
  }
}

static void CPSpline::PSpline2ParameterValues(CPSpline2Interpolant &p, int &n,
                                              double &t[]) {

  int i_ = 0;

  n = 0;

  if (!CAp::Assert(p.m_n >= 2, __FUNCTION__ + ": internal error!"))
    return;

  n = p.m_n;

  ArrayResizeAL(t, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    t[i_] = p.m_p[i_];
  t[0] = 0;

  if (!p.m_periodic)
    t[n - 1] = 1;
}

static void CPSpline::PSpline3ParameterValues(CPSpline3Interpolant &p, int &n,
                                              double &t[]) {

  int i_ = 0;

  n = 0;

  if (!CAp::Assert(p.m_n >= 2, __FUNCTION__ + ": internal error!"))
    return;

  n = p.m_n;

  ArrayResizeAL(t, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    t[i_] = p.m_p[i_];
  t[0] = 0;

  if (!p.m_periodic)
    t[n - 1] = 1;
}

static void CPSpline::PSpline2Calc(CPSpline2Interpolant &p, double t, double &x,
                                   double &y) {

  x = 0;
  y = 0;

  if (p.m_periodic)
    t = t - (int)MathFloor(t);

  x = CSpline1D::Spline1DCalc(p.m_x, t);

  y = CSpline1D::Spline1DCalc(p.m_y, t);
}

static void CPSpline::PSpline3Calc(CPSpline3Interpolant &p, double t, double &x,
                                   double &y, double &z) {

  x = 0;
  y = 0;
  z = 0;

  if (p.m_periodic)
    t = t - (int)MathFloor(t);

  x = CSpline1D::Spline1DCalc(p.m_x, t);

  y = CSpline1D::Spline1DCalc(p.m_y, t);

  z = CSpline1D::Spline1DCalc(p.m_z, t);
}

static void CPSpline::PSpline2Tangent(CPSpline2Interpolant &p, double t,
                                      double &x, double &y) {

  double v = 0;
  double v0 = 0;
  double v1 = 0;

  x = 0;
  y = 0;

  if (p.m_periodic)
    t = t - (int)MathFloor(t);

  PSpline2Diff(p, t, v0, x, v1, y);

  if (x != 0.0 || y != 0.0) {

    v = CApServ::SafePythag2(x, y);
    x = x / v;
    y = y / v;
  }
}

static void CPSpline::PSpline3Tangent(CPSpline3Interpolant &p, double t,
                                      double &x, double &y, double &z) {

  double v = 0;
  double v0 = 0;
  double v1 = 0;
  double v2 = 0;

  x = 0;
  y = 0;
  z = 0;

  if (p.m_periodic)
    t = t - (int)MathFloor(t);

  PSpline3Diff(p, t, v0, x, v1, y, v2, z);

  if ((x != 0.0 || y != 0.0) || z != 0.0) {

    v = CApServ::SafePythag3(x, y, z);

    x = x / v;
    y = y / v;
    z = z / v;
  }
}

static void CPSpline::PSpline2Diff(CPSpline2Interpolant &p, double t, double &x,
                                   double &dx, double &y, double &dy) {

  double d2s = 0;

  x = 0;
  dx = 0;
  y = 0;
  dy = 0;

  if (p.m_periodic)
    t = t - (int)MathFloor(t);

  CSpline1D::Spline1DDiff(p.m_x, t, x, dx, d2s);

  CSpline1D::Spline1DDiff(p.m_y, t, y, dy, d2s);
}

static void CPSpline::PSpline3Diff(CPSpline3Interpolant &p, double t, double &x,
                                   double &dx, double &y, double &dy, double &z,
                                   double &dz) {

  double d2s = 0;

  x = 0;
  dx = 0;
  y = 0;
  dy = 0;
  z = 0;
  dz = 0;

  if (p.m_periodic)
    t = t - (int)MathFloor(t);

  CSpline1D::Spline1DDiff(p.m_x, t, x, dx, d2s);

  CSpline1D::Spline1DDiff(p.m_y, t, y, dy, d2s);

  CSpline1D::Spline1DDiff(p.m_z, t, z, dz, d2s);
}

static void CPSpline::PSpline2Diff2(CPSpline2Interpolant &p, double t,
                                    double &x, double &dx, double &d2x,
                                    double &y, double &dy, double &d2y) {

  x = 0;
  dx = 0;
  d2x = 0;
  y = 0;
  dy = 0;
  d2y = 0;

  if (p.m_periodic)
    t = t - (int)MathFloor(t);

  CSpline1D::Spline1DDiff(p.m_x, t, x, dx, d2x);

  CSpline1D::Spline1DDiff(p.m_y, t, y, dy, d2y);
}

static void CPSpline::PSpline3Diff2(CPSpline3Interpolant &p, double t,
                                    double &x, double &dx, double &d2x,
                                    double &y, double &dy, double &d2y,
                                    double &z, double &dz, double &d2z) {

  x = 0;
  dx = 0;
  d2x = 0;
  y = 0;
  dy = 0;
  d2y = 0;
  z = 0;
  dz = 0;
  d2z = 0;

  if (p.m_periodic)
    t = t - (int)MathFloor(t);

  CSpline1D::Spline1DDiff(p.m_x, t, x, dx, d2x);

  CSpline1D::Spline1DDiff(p.m_y, t, y, dy, d2y);

  CSpline1D::Spline1DDiff(p.m_z, t, z, dz, d2z);
}

static double CPSpline::PSpline2ArcLength(CPSpline2Interpolant &p,
                                          const double a, const double b) {

  double result = 0;
  double sx = 0;
  double dsx = 0;
  double d2sx = 0;
  double sy = 0;
  double dsy = 0;
  double d2sy = 0;

  CAutoGKState state;
  CAutoGKReport rep;

  CAutoGK::AutoGKSmooth(a, b, state);

  while (CAutoGK::AutoGKIteration(state)) {
    CSpline1D::Spline1DDiff(p.m_x, state.m_x, sx, dsx, d2sx);
    CSpline1D::Spline1DDiff(p.m_y, state.m_x, sy, dsy, d2sy);
    state.m_f = CApServ::SafePythag2(dsx, dsy);
  }

  CAutoGK::AutoGKResults(state, result, rep);

  if (!CAp::Assert(rep.m_terminationtype > 0,
                   __FUNCTION__ + ": internal error!"))
    return (EMPTY_VALUE);

  return (result);
}

static double CPSpline::PSpline3ArcLength(CPSpline3Interpolant &p,
                                          const double a, const double b) {

  double result = 0;
  double sx = 0;
  double dsx = 0;
  double d2sx = 0;
  double sy = 0;
  double dsy = 0;
  double d2sy = 0;
  double sz = 0;
  double dsz = 0;
  double d2sz = 0;

  CAutoGKState state;
  CAutoGKReport rep;

  CAutoGK::AutoGKSmooth(a, b, state);

  while (CAutoGK::AutoGKIteration(state)) {
    CSpline1D::Spline1DDiff(p.m_x, state.m_x, sx, dsx, d2sx);
    CSpline1D::Spline1DDiff(p.m_y, state.m_x, sy, dsy, d2sy);
    CSpline1D::Spline1DDiff(p.m_z, state.m_x, sz, dsz, d2sz);
    state.m_f = CApServ::SafePythag3(dsx, dsy, dsz);
  }

  CAutoGK::AutoGKResults(state, result, rep);

  if (!CAp::Assert(rep.m_terminationtype > 0,
                   __FUNCTION__ + ": internal error!"))
    return (EMPTY_VALUE);

  return (result);
}

static void CPSpline::PSpline2Par(CMatrixDouble &xy, const int n, const int pt,
                                  double &p[]) {

  double v = 0;
  int i = 0;
  int i_ = 0;

  if (!CAp::Assert(pt >= 0 && pt <= 2, __FUNCTION__ + ": internal error!"))
    return;

  ArrayResizeAL(p, n);

  if (pt == 0) {
    for (i = 0; i <= n - 1; i++)
      p[i] = i;
  }

  if (pt == 1) {
    p[0] = 0;

    for (i = 1; i <= n - 1; i++)
      p[i] = p[i - 1] + CApServ::SafePythag2(xy[i][0] - xy[i - 1][0],
                                             xy[i][1] - xy[i - 1][1]);
  }

  if (pt == 2) {
    p[0] = 0;

    for (i = 1; i <= n - 1; i++)
      p[i] = p[i - 1] + MathSqrt(CApServ::SafePythag2(xy[i][0] - xy[i - 1][0],
                                                      xy[i][1] - xy[i - 1][1]));
  }

  v = 1 / p[n - 1];

  for (i_ = 0; i_ <= n - 1; i_++)
    p[i_] = v * p[i_];
}

static void CPSpline::PSpline3Par(CMatrixDouble &xy, const int n, const int pt,
                                  double &p[]) {

  double v = 0;
  int i = 0;
  int i_ = 0;

  if (!CAp::Assert(pt >= 0 && pt <= 2, __FUNCTION__ + ": internal error!"))
    return;

  ArrayResizeAL(p, n);

  if (pt == 0) {
    for (i = 0; i <= n - 1; i++)
      p[i] = i;
  }

  if (pt == 1) {
    p[0] = 0;

    for (i = 1; i <= n - 1; i++)
      p[i] = p[i - 1] + CApServ::SafePythag3(xy[i][0] - xy[i - 1][0],
                                             xy[i][1] - xy[i - 1][1],
                                             xy[i][2] - xy[i - 1][2]);
  }

  if (pt == 2) {
    p[0] = 0;

    for (i = 1; i <= n - 1; i++)
      p[i] = p[i - 1] + MathSqrt(CApServ::SafePythag3(xy[i][0] - xy[i - 1][0],
                                                      xy[i][1] - xy[i - 1][1],
                                                      xy[i][2] - xy[i - 1][2]));
  }

  v = 1 / p[n - 1];

  for (i_ = 0; i_ <= n - 1; i_++)
    p[i_] = v * p[i_];
}

class CSpline2DInterpolant {
public:
  int m_k;

  double m_c[];

  CSpline2DInterpolant(void);
  ~CSpline2DInterpolant(void);

  void Copy(CSpline2DInterpolant &obj);
};

CSpline2DInterpolant::CSpline2DInterpolant(void) {}

CSpline2DInterpolant::~CSpline2DInterpolant(void) {}

void CSpline2DInterpolant::Copy(CSpline2DInterpolant &obj) {

  m_k = obj.m_k;

  ArrayCopy(m_c, obj.m_c);
}

class CSpline2DInterpolantShell {
private:
  CSpline2DInterpolant m_innerobj;

public:
  CSpline2DInterpolantShell(void);
  CSpline2DInterpolantShell(CSpline2DInterpolant &obj);
  ~CSpline2DInterpolantShell(void);

  CSpline2DInterpolant *GetInnerObj(void);
};

CSpline2DInterpolantShell::CSpline2DInterpolantShell(void) {}

CSpline2DInterpolantShell::CSpline2DInterpolantShell(
    CSpline2DInterpolant &obj) {

  m_innerobj.Copy(obj);
}

CSpline2DInterpolantShell::~CSpline2DInterpolantShell(void) {}

CSpline2DInterpolant *CSpline2DInterpolantShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CSpline2D {
private:
  static void BicubicCalcDerivatives(CMatrixDouble &a, double &x[], double &y[],
                                     const int m, const int n,
                                     CMatrixDouble &dx, CMatrixDouble &dy,
                                     CMatrixDouble &dxy);

public:
  CSpline2D(void);
  ~CSpline2D(void);

  static void Spline2DBuildBilinear(double &cx[], double &cy[],
                                    CMatrixDouble &cf, const int m, const int n,
                                    CSpline2DInterpolant &c);
  static void Spline2DBuildBicubic(double &cx[], double &cy[],
                                   CMatrixDouble &cf, const int m, const int n,
                                   CSpline2DInterpolant &c);
  static double Spline2DCalc(CSpline2DInterpolant &c, const double x,
                             const double y);
  static void Spline2DDiff(CSpline2DInterpolant &c, const double x,
                           const double y, double &f, double &fx, double &fy,
                           double &fxy);
  static void Spline2DUnpack(CSpline2DInterpolant &c, int &m, int &n,
                             CMatrixDouble &tbl);
  static void Spline2DLinTransXY(CSpline2DInterpolant &c, double ax, double bx,
                                 double ay, double by);
  static void Spline2DLinTransF(CSpline2DInterpolant &c, const double a,
                                const double b);
  static void Spline2DCopy(CSpline2DInterpolant &c, CSpline2DInterpolant &cc);
  static void Spline2DResampleBicubic(CMatrixDouble &a, const int oldheight,
                                      const int oldwidth, CMatrixDouble &b,
                                      const int newheight, const int newwidth);
  static void Spline2DResampleBilinear(CMatrixDouble &a, const int oldheight,
                                       const int oldwidth, CMatrixDouble &b,
                                       const int newheight, const int newwidth);
};

CSpline2D::CSpline2D(void) {}

CSpline2D::~CSpline2D(void) {}

static void CSpline2D::Spline2DBuildBilinear(double &cx[], double &cy[],
                                             CMatrixDouble &cf, const int m,
                                             const int n,
                                             CSpline2DInterpolant &c) {

  int i = 0;
  int j = 0;
  int k = 0;
  int tblsize = 0;
  int shift = 0;
  double t = 0;

  double x[];
  double y[];

  CMatrixDouble dx;
  CMatrixDouble dy;
  CMatrixDouble dxy;
  CMatrixDouble f;

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  f = cf;

  if (!CAp::Assert(n >= 2 && m >= 2, __FUNCTION__ + ": N<2 or M<2!"))
    return;

  for (j = 0; j <= n - 1; j++) {
    k = j;
    for (i = j + 1; i <= n - 1; i++) {

      if (x[i] < x[k])
        k = i;
    }

    if (k != j) {
      for (i = 0; i <= m - 1; i++) {

        t = f[i][j];
        f[i].Set(j, f[i][k]);
        f[i].Set(k, t);
      }

      t = x[j];
      x[j] = x[k];
      x[k] = t;
    }
  }

  for (i = 0; i <= m - 1; i++) {
    k = i;
    for (j = i + 1; j <= m - 1; j++) {

      if (y[j] < y[k])
        k = j;
    }

    if (k != i) {
      for (j = 0; j <= n - 1; j++) {

        t = f[i][j];
        f[i].Set(j, f[k][j]);
        f[k].Set(j, t);
      }

      t = y[i];
      y[i] = y[k];
      y[k] = t;
    }
  }

  c.m_k = 1;
  tblsize = 4 + n + m + n * m;

  ArrayResizeAL(c.m_c, tblsize);

  c.m_c[0] = tblsize;
  c.m_c[1] = -1;
  c.m_c[2] = n;
  c.m_c[3] = m;

  for (i = 0; i <= n - 1; i++)
    c.m_c[4 + i] = x[i];
  for (i = 0; i <= m - 1; i++)
    c.m_c[4 + n + i] = y[i];

  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= n - 1; j++) {
      shift = i * n + j;
      c.m_c[4 + n + m + shift] = f[i][j];
    }
  }
}

static void CSpline2D::Spline2DBuildBicubic(double &cx[], double &cy[],
                                            CMatrixDouble &cf, const int m,
                                            const int n,
                                            CSpline2DInterpolant &c) {

  int i = 0;
  int j = 0;
  int k = 0;
  int tblsize = 0;
  int shift = 0;
  double t = 0;

  double x[];
  double y[];

  CMatrixDouble dx;
  CMatrixDouble dy;
  CMatrixDouble dxy;
  CMatrixDouble f;

  ArrayCopy(x, cx);
  ArrayCopy(y, cy);

  f = cf;

  if (!CAp::Assert(n >= 2 && m >= 2, __FUNCTION__ + ": N<2 or M<2!"))
    return;

  for (j = 0; j <= n - 1; j++) {
    k = j;
    for (i = j + 1; i <= n - 1; i++) {

      if (x[i] < x[k])
        k = i;
    }

    if (k != j) {
      for (i = 0; i <= m - 1; i++) {

        t = f[i][j];
        f[i].Set(j, f[i][k]);
        f[i].Set(k, t);
      }

      t = x[j];
      x[j] = x[k];
      x[k] = t;
    }
  }

  for (i = 0; i <= m - 1; i++) {
    k = i;
    for (j = i + 1; j <= m - 1; j++) {

      if (y[j] < y[k])
        k = j;
    }

    if (k != i) {
      for (j = 0; j <= n - 1; j++) {

        t = f[i][j];
        f[i].Set(j, f[k][j]);
        f[k].Set(j, t);
      }

      t = y[i];
      y[i] = y[k];
      y[k] = t;
    }
  }

  c.m_k = 3;
  tblsize = 4 + n + m + 4 * n * m;

  ArrayResizeAL(c.m_c, tblsize);

  c.m_c[0] = tblsize;
  c.m_c[1] = -3;
  c.m_c[2] = n;
  c.m_c[3] = m;

  for (i = 0; i <= n - 1; i++)
    c.m_c[4 + i] = x[i];
  for (i = 0; i <= m - 1; i++)
    c.m_c[4 + n + i] = y[i];

  BicubicCalcDerivatives(f, x, y, m, n, dx, dy, dxy);

  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= n - 1; j++) {
      shift = i * n + j;
      c.m_c[4 + n + m + shift] = f[i][j];
      c.m_c[4 + n + m + n * m + shift] = dx[i][j];
      c.m_c[4 + n + m + 2 * n * m + shift] = dy[i][j];
      c.m_c[4 + n + m + 3 * n * m + shift] = dxy[i][j];
    }
  }
}

static double CSpline2D::Spline2DCalc(CSpline2DInterpolant &c, const double x,
                                      const double y) {

  double v = 0;
  double vx = 0;
  double vy = 0;
  double vxy = 0;

  Spline2DDiff(c, x, y, v, vx, vy, vxy);

  return (v);
}

static void CSpline2D::Spline2DDiff(CSpline2DInterpolant &c, const double x,
                                    const double y, double &f, double &fx,
                                    double &fy, double &fxy) {

  int n = 0;
  int m = 0;
  double t = 0;
  double dt = 0;
  double u = 0;
  double du = 0;
  int ix = 0;
  int iy = 0;
  int l = 0;
  int r = 0;
  int h = 0;
  int shift1 = 0;
  int s1 = 0;
  int s2 = 0;
  int s3 = 0;
  int s4 = 0;
  int sf = 0;
  int sfx = 0;
  int sfy = 0;
  int sfxy = 0;
  double y1 = 0;
  double y2 = 0;
  double y3 = 0;
  double y4 = 0;
  double v = 0;
  double t0 = 0;
  double t1 = 0;
  double t2 = 0;
  double t3 = 0;
  double u0 = 0;
  double u1 = 0;
  double u2 = 0;
  double u3 = 0;

  f = 0;
  fx = 0;
  fy = 0;
  fxy = 0;

  if (!CAp::Assert((int)MathRound(c.m_c[1]) == -1 ||
                       (int)MathRound(c.m_c[1]) == -3,
                   __FUNCTION__ + ": incorrect C!"))
    return;

  n = (int)MathRound(c.m_c[2]);
  m = (int)MathRound(c.m_c[3]);

  l = 4;
  r = 4 + n - 2 + 1;
  while (l != r - 1) {
    h = (l + r) / 2;

    if (c.m_c[h] >= x)
      r = h;
    else
      l = h;
  }

  t = (x - c.m_c[l]) / (c.m_c[l + 1] - c.m_c[l]);
  dt = 1.0 / (c.m_c[l + 1] - c.m_c[l]);
  ix = l - 4;

  l = 4 + n;
  r = 4 + n + (m - 2) + 1;
  while (l != r - 1) {
    h = (l + r) / 2;

    if (c.m_c[h] >= y)
      r = h;
    else
      l = h;
  }

  u = (y - c.m_c[l]) / (c.m_c[l + 1] - c.m_c[l]);
  du = 1.0 / (c.m_c[l + 1] - c.m_c[l]);
  iy = l - (4 + n);

  f = 0;
  fx = 0;
  fy = 0;
  fxy = 0;

  if ((int)MathRound(c.m_c[1]) == -1) {

    shift1 = 4 + n + m;
    y1 = c.m_c[shift1 + n * iy + ix];
    y2 = c.m_c[shift1 + n * iy + (ix + 1)];
    y3 = c.m_c[shift1 + n * (iy + 1) + (ix + 1)];
    y4 = c.m_c[shift1 + n * (iy + 1) + ix];
    f = (1 - t) * (1 - u) * y1 + t * (1 - u) * y2 + t * u * y3 +
        (1 - t) * u * y4;
    fx = (-((1 - u) * y1) + (1 - u) * y2 + u * y3 - u * y4) * dt;
    fy = (-((1 - t) * y1) - t * y2 + t * y3 + (1 - t) * y4) * du;
    fxy = (y1 - y2 + y3 - y4) * du * dt;

    return;
  }

  if ((int)MathRound(c.m_c[1]) == -3) {

    t0 = 1;
    t1 = t;
    t2 = CMath::Sqr(t);
    t3 = t * t2;
    u0 = 1;
    u1 = u;
    u2 = CMath::Sqr(u);
    u3 = u * u2;
    sf = 4 + n + m;
    sfx = 4 + n + m + n * m;
    sfy = 4 + n + m + 2 * n * m;
    sfxy = 4 + n + m + 3 * n * m;
    s1 = n * iy + ix;
    s2 = n * iy + (ix + 1);
    s3 = n * (iy + 1) + (ix + 1);
    s4 = n * (iy + 1) + ix;

    v = 1 * c.m_c[sf + s1];
    f = f + v * t0 * u0;
    v = 1 * c.m_c[sfy + s1] / du;
    f = f + v * t0 * u1;
    fy = fy + 1 * v * t0 * u0 * du;
    v = -(3 * c.m_c[sf + s1]) + 3 * c.m_c[sf + s4] - 2 * c.m_c[sfy + s1] / du -
        1 * c.m_c[sfy + s4] / du;
    f = f + v * t0 * u2;
    fy = fy + 2 * v * t0 * u1 * du;
    v = 2 * c.m_c[sf + s1] - 2 * c.m_c[sf + s4] + 1 * c.m_c[sfy + s1] / du +
        1 * c.m_c[sfy + s4] / du;
    f = f + v * t0 * u3;
    fy = fy + 3 * v * t0 * u2 * du;
    v = 1 * c.m_c[sfx + s1] / dt;
    f = f + v * t1 * u0;
    fx = fx + 1 * v * t0 * u0 * dt;
    v = 1 * c.m_c[sfxy + s1] / (dt * du);
    f = f + v * t1 * u1;
    fx = fx + 1 * v * t0 * u1 * dt;
    fy = fy + 1 * v * t1 * u0 * du;
    fxy = fxy + 1 * v * t0 * u0 * dt * du;
    v = -(3 * c.m_c[sfx + s1] / dt) + 3 * c.m_c[sfx + s4] / dt -
        2 * c.m_c[sfxy + s1] / (dt * du) - 1 * c.m_c[sfxy + s4] / (dt * du);
    f = f + v * t1 * u2;
    fx = fx + 1 * v * t0 * u2 * dt;
    fy = fy + 2 * v * t1 * u1 * du;
    fxy = fxy + 2 * v * t0 * u1 * dt * du;
    v = 2 * c.m_c[sfx + s1] / dt - 2 * c.m_c[sfx + s4] / dt +
        1 * c.m_c[sfxy + s1] / (dt * du) + 1 * c.m_c[sfxy + s4] / (dt * du);
    f = f + v * t1 * u3;
    fx = fx + 1 * v * t0 * u3 * dt;
    fy = fy + 3 * v * t1 * u2 * du;
    fxy = fxy + 3 * v * t0 * u2 * dt * du;
    v = -(3 * c.m_c[sf + s1]) + 3 * c.m_c[sf + s2] - 2 * c.m_c[sfx + s1] / dt -
        1 * c.m_c[sfx + s2] / dt;
    f = f + v * t2 * u0;
    fx = fx + 2 * v * t1 * u0 * dt;
    v = -(3 * c.m_c[sfy + s1] / du) + 3 * c.m_c[sfy + s2] / du -
        2 * c.m_c[sfxy + s1] / (dt * du) - 1 * c.m_c[sfxy + s2] / (dt * du);
    f = f + v * t2 * u1;
    fx = fx + 2 * v * t1 * u1 * dt;
    fy = fy + 1 * v * t2 * u0 * du;
    fxy = fxy + 2 * v * t1 * u0 * dt * du;
    v = 9 * c.m_c[sf + s1] - 9 * c.m_c[sf + s2] + 9 * c.m_c[sf + s3] -
        9 * c.m_c[sf + s4] + 6 * c.m_c[sfx + s1] / dt +
        3 * c.m_c[sfx + s2] / dt - 3 * c.m_c[sfx + s3] / dt -
        6 * c.m_c[sfx + s4] / dt + 6 * c.m_c[sfy + s1] / du -
        6 * c.m_c[sfy + s2] / du - 3 * c.m_c[sfy + s3] / du +
        3 * c.m_c[sfy + s4] / du + 4 * c.m_c[sfxy + s1] / (dt * du) +
        2 * c.m_c[sfxy + s2] / (dt * du) + 1 * c.m_c[sfxy + s3] / (dt * du) +
        2 * c.m_c[sfxy + s4] / (dt * du);
    f = f + v * t2 * u2;
    fx = fx + 2 * v * t1 * u2 * dt;
    fy = fy + 2 * v * t2 * u1 * du;
    fxy = fxy + 4 * v * t1 * u1 * dt * du;
    v = -(6 * c.m_c[sf + s1]) + 6 * c.m_c[sf + s2] - 6 * c.m_c[sf + s3] +
        6 * c.m_c[sf + s4] - 4 * c.m_c[sfx + s1] / dt -
        2 * c.m_c[sfx + s2] / dt + 2 * c.m_c[sfx + s3] / dt +
        4 * c.m_c[sfx + s4] / dt - 3 * c.m_c[sfy + s1] / du +
        3 * c.m_c[sfy + s2] / du + 3 * c.m_c[sfy + s3] / du -
        3 * c.m_c[sfy + s4] / du - 2 * c.m_c[sfxy + s1] / (dt * du) -
        1 * c.m_c[sfxy + s2] / (dt * du) - 1 * c.m_c[sfxy + s3] / (dt * du) -
        2 * c.m_c[sfxy + s4] / (dt * du);
    f = f + v * t2 * u3;
    fx = fx + 2 * v * t1 * u3 * dt;
    fy = fy + 3 * v * t2 * u2 * du;
    fxy = fxy + 6 * v * t1 * u2 * dt * du;
    v = 2 * c.m_c[sf + s1] - 2 * c.m_c[sf + s2] + 1 * c.m_c[sfx + s1] / dt +
        1 * c.m_c[sfx + s2] / dt;
    f = f + v * t3 * u0;
    fx = fx + 3 * v * t2 * u0 * dt;
    v = 2 * c.m_c[sfy + s1] / du - 2 * c.m_c[sfy + s2] / du +
        1 * c.m_c[sfxy + s1] / (dt * du) + 1 * c.m_c[sfxy + s2] / (dt * du);
    f = f + v * t3 * u1;
    fx = fx + 3 * v * t2 * u1 * dt;
    fy = fy + 1 * v * t3 * u0 * du;
    fxy = fxy + 3 * v * t2 * u0 * dt * du;
    v = -(6 * c.m_c[sf + s1]) + 6 * c.m_c[sf + s2] - 6 * c.m_c[sf + s3] +
        6 * c.m_c[sf + s4] - 3 * c.m_c[sfx + s1] / dt -
        3 * c.m_c[sfx + s2] / dt + 3 * c.m_c[sfx + s3] / dt +
        3 * c.m_c[sfx + s4] / dt - 4 * c.m_c[sfy + s1] / du +
        4 * c.m_c[sfy + s2] / du + 2 * c.m_c[sfy + s3] / du -
        2 * c.m_c[sfy + s4] / du - 2 * c.m_c[sfxy + s1] / (dt * du) -
        2 * c.m_c[sfxy + s2] / (dt * du) - 1 * c.m_c[sfxy + s3] / (dt * du) -
        1 * c.m_c[sfxy + s4] / (dt * du);
    f = f + v * t3 * u2;
    fx = fx + 3 * v * t2 * u2 * dt;
    fy = fy + 2 * v * t3 * u1 * du;
    fxy = fxy + 6 * v * t2 * u1 * dt * du;
    v = 4 * c.m_c[sf + s1] - 4 * c.m_c[sf + s2] + 4 * c.m_c[sf + s3] -
        4 * c.m_c[sf + s4] + 2 * c.m_c[sfx + s1] / dt +
        2 * c.m_c[sfx + s2] / dt - 2 * c.m_c[sfx + s3] / dt -
        2 * c.m_c[sfx + s4] / dt + 2 * c.m_c[sfy + s1] / du -
        2 * c.m_c[sfy + s2] / du - 2 * c.m_c[sfy + s3] / du +
        2 * c.m_c[sfy + s4] / du + 1 * c.m_c[sfxy + s1] / (dt * du) +
        1 * c.m_c[sfxy + s2] / (dt * du) + 1 * c.m_c[sfxy + s3] / (dt * du) +
        1 * c.m_c[sfxy + s4] / (dt * du);
    f = f + v * t3 * u3;
    fx = fx + 3 * v * t2 * u3 * dt;
    fy = fy + 3 * v * t3 * u2 * du;
    fxy = fxy + 9 * v * t2 * u2 * dt * du;

    return;
  }
}

static void CSpline2D::Spline2DUnpack(CSpline2DInterpolant &c, int &m, int &n,
                                      CMatrixDouble &tbl) {

  int i = 0;
  int j = 0;
  int ci = 0;
  int cj = 0;
  int k = 0;
  int p = 0;
  int shift = 0;
  int s1 = 0;
  int s2 = 0;
  int s3 = 0;
  int s4 = 0;
  int sf = 0;
  int sfx = 0;
  int sfy = 0;
  int sfxy = 0;
  double y1 = 0;
  double y2 = 0;
  double y3 = 0;
  double y4 = 0;
  double dt = 0;
  double du = 0;

  m = 0;
  n = 0;

  if (!CAp::Assert((int)MathRound(c.m_c[1]) == -3 ||
                       (int)MathRound(c.m_c[1]) == -1,
                   __FUNCTION__ + ": incorrect C!"))
    return;

  n = (int)MathRound(c.m_c[2]);
  m = (int)MathRound(c.m_c[3]);

  tbl.Resize((n - 1) * (m - 1), 20);

  for (i = 0; i <= m - 2; i++) {
    for (j = 0; j <= n - 2; j++) {

      p = i * (n - 1) + j;
      tbl[p].Set(0, c.m_c[4 + j]);
      tbl[p].Set(1, c.m_c[4 + j + 1]);
      tbl[p].Set(2, c.m_c[4 + n + i]);
      tbl[p].Set(3, c.m_c[4 + n + i + 1]);
      dt = 1 / (tbl[p][1] - tbl[p][0]);
      du = 1 / (tbl[p][3] - tbl[p][2]);

      if ((int)MathRound(c.m_c[1]) == -1) {
        for (k = 4; k <= 19; k++)
          tbl[p].Set(k, 0);

        shift = 4 + n + m;
        y1 = c.m_c[shift + n * i + j];
        y2 = c.m_c[shift + n * i + (j + 1)];
        y3 = c.m_c[shift + n * (i + 1) + (j + 1)];
        y4 = c.m_c[shift + n * (i + 1) + j];
        tbl[p].Set(4, y1);
        tbl[p].Set(4 + 1 * 4 + 0, y2 - y1);
        tbl[p].Set(4 + 0 * 4 + 1, y4 - y1);
        tbl[p].Set(4 + 1 * 4 + 1, y3 - y2 - y4 + y1);
      }

      if ((int)MathRound(c.m_c[1]) == -3) {

        sf = 4 + n + m;
        sfx = 4 + n + m + n * m;
        sfy = 4 + n + m + 2 * n * m;
        sfxy = 4 + n + m + 3 * n * m;
        s1 = n * i + j;
        s2 = n * i + (j + 1);
        s3 = n * (i + 1) + (j + 1);
        s4 = n * (i + 1) + j;

        tbl[p].Set(4 + 0 * 4 + 0, 1 * c.m_c[sf + s1]);
        tbl[p].Set(4 + 0 * 4 + 1, 1 * c.m_c[sfy + s1] / du);
        tbl[p].Set(4 + 0 * 4 + 2, -(3 * c.m_c[sf + s1]) + 3 * c.m_c[sf + s4] -
                                      2 * c.m_c[sfy + s1] / du -
                                      1 * c.m_c[sfy + s4] / du);
        tbl[p].Set(4 + 0 * 4 + 3, 2 * c.m_c[sf + s1] - 2 * c.m_c[sf + s4] +
                                      1 * c.m_c[sfy + s1] / du +
                                      1 * c.m_c[sfy + s4] / du);
        tbl[p].Set(4 + 1 * 4 + 0, 1 * c.m_c[sfx + s1] / dt);
        tbl[p].Set(4 + 1 * 4 + 1, 1 * c.m_c[sfxy + s1] / (dt * du));
        tbl[p].Set(4 + 1 * 4 + 2, -(3 * c.m_c[sfx + s1] / dt) +
                                      3 * c.m_c[sfx + s4] / dt -
                                      2 * c.m_c[sfxy + s1] / (dt * du) -
                                      1 * c.m_c[sfxy + s4] / (dt * du));
        tbl[p].Set(4 + 1 * 4 + 3, 2 * c.m_c[sfx + s1] / dt -
                                      2 * c.m_c[sfx + s4] / dt +
                                      1 * c.m_c[sfxy + s1] / (dt * du) +
                                      1 * c.m_c[sfxy + s4] / (dt * du));
        tbl[p].Set(4 + 2 * 4 + 0, -(3 * c.m_c[sf + s1]) + 3 * c.m_c[sf + s2] -
                                      2 * c.m_c[sfx + s1] / dt -
                                      1 * c.m_c[sfx + s2] / dt);
        tbl[p].Set(4 + 2 * 4 + 1, -(3 * c.m_c[sfy + s1] / du) +
                                      3 * c.m_c[sfy + s2] / du -
                                      2 * c.m_c[sfxy + s1] / (dt * du) -
                                      1 * c.m_c[sfxy + s2] / (dt * du));
        tbl[p].Set(4 + 2 * 4 + 2,
                   9 * c.m_c[sf + s1] - 9 * c.m_c[sf + s2] +
                       9 * c.m_c[sf + s3] - 9 * c.m_c[sf + s4] +
                       6 * c.m_c[sfx + s1] / dt + 3 * c.m_c[sfx + s2] / dt -
                       3 * c.m_c[sfx + s3] / dt - 6 * c.m_c[sfx + s4] / dt +
                       6 * c.m_c[sfy + s1] / du - 6 * c.m_c[sfy + s2] / du -
                       3 * c.m_c[sfy + s3] / du + 3 * c.m_c[sfy + s4] / du +
                       4 * c.m_c[sfxy + s1] / (dt * du) +
                       2 * c.m_c[sfxy + s2] / (dt * du) +
                       1 * c.m_c[sfxy + s3] / (dt * du) +
                       2 * c.m_c[sfxy + s4] / (dt * du));
        tbl[p].Set(4 + 2 * 4 + 3,
                   -(6 * c.m_c[sf + s1]) + 6 * c.m_c[sf + s2] -
                       6 * c.m_c[sf + s3] + 6 * c.m_c[sf + s4] -
                       4 * c.m_c[sfx + s1] / dt - 2 * c.m_c[sfx + s2] / dt +
                       2 * c.m_c[sfx + s3] / dt + 4 * c.m_c[sfx + s4] / dt -
                       3 * c.m_c[sfy + s1] / du + 3 * c.m_c[sfy + s2] / du +
                       3 * c.m_c[sfy + s3] / du - 3 * c.m_c[sfy + s4] / du -
                       2 * c.m_c[sfxy + s1] / (dt * du) -
                       1 * c.m_c[sfxy + s2] / (dt * du) -
                       1 * c.m_c[sfxy + s3] / (dt * du) -
                       2 * c.m_c[sfxy + s4] / (dt * du));
        tbl[p].Set(4 + 3 * 4 + 0, 2 * c.m_c[sf + s1] - 2 * c.m_c[sf + s2] +
                                      1 * c.m_c[sfx + s1] / dt +
                                      1 * c.m_c[sfx + s2] / dt);
        tbl[p].Set(4 + 3 * 4 + 1, 2 * c.m_c[sfy + s1] / du -
                                      2 * c.m_c[sfy + s2] / du +
                                      1 * c.m_c[sfxy + s1] / (dt * du) +
                                      1 * c.m_c[sfxy + s2] / (dt * du));
        tbl[p].Set(4 + 3 * 4 + 2,
                   -(6 * c.m_c[sf + s1]) + 6 * c.m_c[sf + s2] -
                       6 * c.m_c[sf + s3] + 6 * c.m_c[sf + s4] -
                       3 * c.m_c[sfx + s1] / dt - 3 * c.m_c[sfx + s2] / dt +
                       3 * c.m_c[sfx + s3] / dt + 3 * c.m_c[sfx + s4] / dt -
                       4 * c.m_c[sfy + s1] / du + 4 * c.m_c[sfy + s2] / du +
                       2 * c.m_c[sfy + s3] / du - 2 * c.m_c[sfy + s4] / du -
                       2 * c.m_c[sfxy + s1] / (dt * du) -
                       2 * c.m_c[sfxy + s2] / (dt * du) -
                       1 * c.m_c[sfxy + s3] / (dt * du) -
                       1 * c.m_c[sfxy + s4] / (dt * du));
        tbl[p].Set(4 + 3 * 4 + 3,
                   4 * c.m_c[sf + s1] - 4 * c.m_c[sf + s2] +
                       4 * c.m_c[sf + s3] - 4 * c.m_c[sf + s4] +
                       2 * c.m_c[sfx + s1] / dt + 2 * c.m_c[sfx + s2] / dt -
                       2 * c.m_c[sfx + s3] / dt - 2 * c.m_c[sfx + s4] / dt +
                       2 * c.m_c[sfy + s1] / du - 2 * c.m_c[sfy + s2] / du -
                       2 * c.m_c[sfy + s3] / du + 2 * c.m_c[sfy + s4] / du +
                       1 * c.m_c[sfxy + s1] / (dt * du) +
                       1 * c.m_c[sfxy + s2] / (dt * du) +
                       1 * c.m_c[sfxy + s3] / (dt * du) +
                       1 * c.m_c[sfxy + s4] / (dt * du));
      }

      for (ci = 0; ci <= 3; ci++) {
        for (cj = 0; cj <= 3; cj++)
          tbl[p].Set(4 + ci * 4 + cj, tbl[p][4 + ci * 4 + cj] *
                                          MathPow(dt, ci) * MathPow(du, cj));
      }
    }
  }
}

static void CSpline2D::Spline2DLinTransXY(CSpline2DInterpolant &c, double ax,
                                          double bx, double ay, double by) {

  int i = 0;
  int j = 0;
  int n = 0;
  int m = 0;
  double v = 0;
  int typec = 0;

  double x[];
  double y[];

  CMatrixDouble f;

  typec = (int)MathRound(c.m_c[1]);

  if (!CAp::Assert(typec == -3 || typec == -1, __FUNCTION__ + ": incorrect C!"))
    return;

  n = (int)MathRound(c.m_c[2]);
  m = (int)MathRound(c.m_c[3]);

  ArrayResizeAL(x, n);
  ArrayResizeAL(y, m);
  f.Resize(m, n);

  for (j = 0; j <= n - 1; j++)
    x[j] = c.m_c[4 + j];
  for (i = 0; i <= m - 1; i++)
    y[i] = c.m_c[4 + n + i];
  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      f[i].Set(j, c.m_c[4 + n + m + i * n + j]);
  }

  if (ax == 0.0) {

    for (i = 0; i <= m - 1; i++) {
      v = Spline2DCalc(c, bx, y[i]);
      for (j = 0; j <= n - 1; j++)
        f[i].Set(j, v);
    }

    if (typec == -3)
      Spline2DBuildBicubic(x, y, f, m, n, c);

    if (typec == -1)
      Spline2DBuildBilinear(x, y, f, m, n, c);

    ax = 1;
    bx = 0;
  }

  if (ay == 0.0) {

    for (j = 0; j <= n - 1; j++) {
      v = Spline2DCalc(c, x[j], by);
      for (i = 0; i <= m - 1; i++)
        f[i].Set(j, v);
    }

    if (typec == -3)
      Spline2DBuildBicubic(x, y, f, m, n, c);

    if (typec == -1)
      Spline2DBuildBilinear(x, y, f, m, n, c);

    ay = 1;
    by = 0;
  }

  for (j = 0; j <= n - 1; j++)
    x[j] = (x[j] - bx) / ax;
  for (i = 0; i <= m - 1; i++)
    y[i] = (y[i] - by) / ay;

  if (typec == -3)
    Spline2DBuildBicubic(x, y, f, m, n, c);

  if (typec == -1)
    Spline2DBuildBilinear(x, y, f, m, n, c);
}

static void CSpline2D::Spline2DLinTransF(CSpline2DInterpolant &c,
                                         const double a, const double b) {

  int i = 0;
  int j = 0;
  int n = 0;
  int m = 0;
  int typec = 0;

  double x[];
  double y[];

  CMatrixDouble f;

  typec = (int)MathRound(c.m_c[1]);

  if (!CAp::Assert(typec == -3 || typec == -1, __FUNCTION__ + ": incorrect C!"))
    return;

  n = (int)MathRound(c.m_c[2]);
  m = (int)MathRound(c.m_c[3]);

  ArrayResizeAL(x, n);
  ArrayResizeAL(y, m);
  f.Resize(m, n);

  for (j = 0; j <= n - 1; j++)
    x[j] = c.m_c[4 + j];
  for (i = 0; i <= m - 1; i++)
    y[i] = c.m_c[4 + n + i];
  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      f[i].Set(j, a * c.m_c[4 + n + m + i * n + j] + b);
  }

  if (typec == -3)
    Spline2DBuildBicubic(x, y, f, m, n, c);

  if (typec == -1)
    Spline2DBuildBilinear(x, y, f, m, n, c);
}

static void CSpline2D::Spline2DCopy(CSpline2DInterpolant &c,
                                    CSpline2DInterpolant &cc) {

  int n = 0;
  int i_ = 0;

  if (!CAp::Assert(c.m_k == 1 || c.m_k == 3, __FUNCTION__ + ": incorrect C!"))
    return;

  cc.m_k = c.m_k;
  n = (int)MathRound(c.m_c[0]);

  ArrayResizeAL(cc.m_c, n);

  for (i_ = 0; i_ <= n - 1; i_++)
    cc.m_c[i_] = c.m_c[i_];
}

static void CSpline2D::Spline2DResampleBicubic(
    CMatrixDouble &a, const int oldheight, const int oldwidth, CMatrixDouble &b,
    const int newheight, const int newwidth) {

  int i = 0;
  int j = 0;
  int mw = 0;
  int mh = 0;

  double x[];
  double y[];

  CMatrixDouble buf;

  CSpline1DInterpolant c;

  if (!CAp::Assert(oldwidth > 1 && oldheight > 1,
                   __FUNCTION__ + ": width/height less than 1"))
    return;

  if (!CAp::Assert(newwidth > 1 && newheight > 1,
                   __FUNCTION__ + ": width/height less than 1"))
    return;

  mw = MathMax(oldwidth, newwidth);
  mh = MathMax(oldheight, newheight);

  b.Resize(newheight, newwidth);
  buf.Resize(oldheight, newwidth);
  ArrayResizeAL(x, MathMax(mw, mh));
  ArrayResizeAL(y, MathMax(mw, mh));

  for (i = 0; i <= oldheight - 1; i++) {

    for (j = 0; j <= oldwidth - 1; j++) {
      x[j] = (double)j / (double)(oldwidth - 1);
      y[j] = a[i][j];
    }

    CSpline1D::Spline1DBuildCubic(x, y, oldwidth, 0, 0.0, 0, 0.0, c);
    for (j = 0; j <= newwidth - 1; j++)
      buf[i].Set(
          j, CSpline1D::Spline1DCalc(c, (double)j / (double)(newwidth - 1)));
  }

  for (j = 0; j <= newwidth - 1; j++) {

    for (i = 0; i <= oldheight - 1; i++) {
      x[i] = (double)i / (double)(oldheight - 1);
      y[i] = buf[i][j];
    }

    CSpline1D::Spline1DBuildCubic(x, y, oldheight, 0, 0.0, 0, 0.0, c);
    for (i = 0; i <= newheight - 1; i++)
      b[i].Set(j,
               CSpline1D::Spline1DCalc(c, (double)i / (double)(newheight - 1)));
  }
}

static void CSpline2D::Spline2DResampleBilinear(
    CMatrixDouble &a, const int oldheight, const int oldwidth, CMatrixDouble &b,
    const int newheight, const int newwidth) {

  int i = 0;
  int j = 0;
  int l = 0;
  int c = 0;
  double t = 0;
  double u = 0;

  b.Resize(newheight, newwidth);
  for (i = 0; i <= newheight - 1; i++) {
    for (j = 0; j <= newwidth - 1; j++) {

      l = i * (oldheight - 1) / (newheight - 1);

      if (l == oldheight - 1)
        l = oldheight - 2;

      u = (double)i / (double)(newheight - 1) * (oldheight - 1) - l;
      c = j * (oldwidth - 1) / (newwidth - 1);

      if (c == oldwidth - 1)
        c = oldwidth - 2;

      t = (double)(j * (oldwidth - 1)) / (double)(newwidth - 1) - c;
      b[i].Set(j, (1 - t) * (1 - u) * a[l][c] + t * (1 - u) * a[l][c + 1] +
                      t * u * a[l + 1][c + 1] + (1 - t) * u * a[l + 1][c]);
    }
  }
}

static void CSpline2D::BicubicCalcDerivatives(CMatrixDouble &a, double &x[],
                                              double &y[], const int m,
                                              const int n, CMatrixDouble &dx,
                                              CMatrixDouble &dy,
                                              CMatrixDouble &dxy) {

  int i = 0;
  int j = 0;
  double s = 0;
  double ds = 0;
  double d2s = 0;

  double xt[];
  double ft[];

  CSpline1DInterpolant c;

  dx.Resize(m, n);
  dy.Resize(m, n);
  dxy.Resize(m, n);

  ArrayResizeAL(xt, n);
  ArrayResizeAL(ft, n);
  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= n - 1; j++) {
      xt[j] = x[j];
      ft[j] = a[i][j];
    }

    CSpline1D::Spline1DBuildCubic(xt, ft, n, 0, 0.0, 0, 0.0, c);
    for (j = 0; j <= n - 1; j++) {

      CSpline1D::Spline1DDiff(c, x[j], s, ds, d2s);
      dx[i].Set(j, ds);
    }
  }

  ArrayResizeAL(xt, m);
  ArrayResizeAL(ft, m);
  for (j = 0; j <= n - 1; j++) {
    for (i = 0; i <= m - 1; i++) {
      xt[i] = y[i];
      ft[i] = a[i][j];
    }

    CSpline1D::Spline1DBuildCubic(xt, ft, m, 0, 0.0, 0, 0.0, c);
    for (i = 0; i <= m - 1; i++) {

      CSpline1D::Spline1DDiff(c, y[i], s, ds, d2s);
      dy[i].Set(j, ds);
    }
  }

  ArrayResizeAL(xt, n);
  ArrayResizeAL(ft, n);
  for (i = 0; i <= m - 1; i++) {
    for (j = 0; j <= n - 1; j++) {
      xt[j] = x[j];
      ft[j] = dy[i][j];
    }

    CSpline1D::Spline1DBuildCubic(xt, ft, n, 0, 0.0, 0, 0.0, c);
    for (j = 0; j <= n - 1; j++) {

      CSpline1D::Spline1DDiff(c, x[j], s, ds, d2s);
      dxy[i].Set(j, ds);
    }
  }
}

#endif
