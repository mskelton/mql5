#ifndef DIFFEQUATIONS_H
#define DIFFEQUATIONS_H

#include "alglibinternal.mqh"
#include "matrix.mqh"

class CODESolverState {
public:
  int m_n;
  int m_m;
  double m_xscale;
  double m_h;
  double m_eps;
  bool m_fraceps;
  int m_repterminationtype;
  int m_repnfev;
  int m_solvertype;
  bool m_needdy;
  double m_x;
  RCommState m_rstate;

  double m_yc[];
  double m_escale[];
  double m_xg[];
  double m_y[];
  double m_dy[];
  double m_yn[];
  double m_yns[];
  double m_rka[];
  double m_rkc[];
  double m_rkcs[];

  CMatrixDouble m_ytbl;
  CMatrixDouble m_rkb;
  CMatrixDouble m_rkk;

public:
  CODESolverState(void);
  ~CODESolverState(void);

  void Copy(CODESolverState &obj);
};

CODESolverState::CODESolverState(void) {
}

CODESolverState::~CODESolverState(void) {
}

void CODESolverState::Copy(CODESolverState &obj) {

  m_n = obj.m_n;
  m_m = obj.m_m;
  m_xscale = obj.m_xscale;
  m_h = obj.m_h;
  m_eps = obj.m_eps;
  m_fraceps = obj.m_fraceps;
  m_repterminationtype = obj.m_repterminationtype;
  m_repnfev = obj.m_repnfev;
  m_solvertype = obj.m_solvertype;
  m_needdy = obj.m_needdy;
  m_x = obj.m_x;
  m_rstate.Copy(obj.m_rstate);

  ArrayCopy(m_yc, obj.m_yc);
  ArrayCopy(m_escale, obj.m_escale);
  ArrayCopy(m_xg, obj.m_xg);
  ArrayCopy(m_y, obj.m_y);
  ArrayCopy(m_dy, obj.m_dy);
  ArrayCopy(m_yn, obj.m_yn);
  ArrayCopy(m_yns, obj.m_yns);
  ArrayCopy(m_rka, obj.m_rka);
  ArrayCopy(m_rkc, obj.m_rkc);
  ArrayCopy(m_rkcs, obj.m_rkcs);

  m_ytbl = obj.m_ytbl;
  m_rkb = obj.m_rkb;
  m_rkk = obj.m_rkk;
}

class CODESolverStateShell {
private:
  CODESolverState m_innerobj;

public:
  CODESolverStateShell(void);
  CODESolverStateShell(CODESolverState &obj);
  ~CODESolverStateShell(void);

  bool GetNeedDY(void);
  void SetNeedDY(const bool b);
  double GetX(void);
  void SetX(const double d);
  CODESolverState *GetInnerObj(void);
};

CODESolverStateShell::CODESolverStateShell(void) {
}

CODESolverStateShell::CODESolverStateShell(CODESolverState &obj) {

  m_innerobj.Copy(obj);
}

CODESolverStateShell::~CODESolverStateShell(void) {
}

bool CODESolverStateShell::GetNeedDY(void) {

  return (m_innerobj.m_needdy);
}

void CODESolverStateShell::SetNeedDY(const bool b) {

  m_innerobj.m_needdy = b;
}

double CODESolverStateShell::GetX(void) {

  return (m_innerobj.m_x);
}

void CODESolverStateShell::SetX(const double d) {

  m_innerobj.m_x = d;
}

CODESolverState *CODESolverStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CODESolverReport {
public:
  int m_nfev;
  int m_terminationtype;

  CODESolverReport(void);
  ~CODESolverReport(void);

  void Copy(CODESolverReport &obj);
};

CODESolverReport::CODESolverReport(void) {
}

CODESolverReport::~CODESolverReport(void) {
}

void CODESolverReport::Copy(CODESolverReport &obj) {

  m_nfev = obj.m_nfev;
  m_terminationtype = obj.m_terminationtype;
}

class CODESolverReportShell {
private:
  CODESolverReport m_innerobj;

public:
  CODESolverReportShell(void);
  CODESolverReportShell(CODESolverReport &obj);
  ~CODESolverReportShell(void);

  int GetNFev(void);
  void SetNFev(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  CODESolverReport *GetInnerObj(void);
};

CODESolverReportShell::CODESolverReportShell(void) {
}

CODESolverReportShell::CODESolverReportShell(CODESolverReport &obj) {

  m_innerobj.Copy(obj);
}

CODESolverReportShell::~CODESolverReportShell(void) {
}

int CODESolverReportShell::GetNFev(void) {

  return (m_innerobj.m_nfev);
}

void CODESolverReportShell::SetNFev(const int i) {

  m_innerobj.m_nfev = i;
}

int CODESolverReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CODESolverReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

CODESolverReport *CODESolverReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CODESolver {
private:
  static void ODESolverInit(int solvertype, double &y[], const int n,
                            double &x[], const int m, const double eps,
                            double h, CODESolverState &state);

  static void Func_lbl_rcomm(CODESolverState &state, int n, int m, int i, int j,
                             int k, int klimit, bool gridpoint, double xc,
                             double v, double h, double h2, double err,
                             double maxgrowpow);
  static bool Func_lbl_6(CODESolverState &state, int &n, int &m, int &i, int &j,
                         int &k, int &klimit, bool &gridpoint, double &xc,
                         double &v, double &h, double &h2, double &err,
                         double &maxgrowpow);
  static bool Func_lbl_8(CODESolverState &state, int &n, int &m, int &i, int &j,
                         int &k, int &klimit, bool &gridpoint, double &xc,
                         double &v, double &h, double &h2, double &err,
                         double &maxgrowpow);
  static bool Func_lbl_10(CODESolverState &state, int &n, int &m, int &i,
                          int &j, int &k, int &klimit, bool &gridpoint,
                          double &xc, double &v, double &h, double &h2,
                          double &err, double &maxgrowpow);

public:
  static const double m_odesolvermaxgrow;
  static const double m_odesolvermaxshrink;

  CODESolver(void);
  ~CODESolver(void);

  static void ODESolverRKCK(double &y[], const int n, double &x[], const int m,
                            const double eps, const double h,
                            CODESolverState &state);
  static void ODESolverResults(CODESolverState &state, int &m, double &xtbl[],
                               CMatrixDouble &ytbl, CODESolverReport &rep);
  static bool ODESolverIteration(CODESolverState &state);
};

const double CODESolver::m_odesolvermaxgrow = 3.0;
const double CODESolver::m_odesolvermaxshrink = 10.0;

CODESolver::CODESolver(void) {
}

CODESolver::~CODESolver(void) {
}

static void CODESolver::ODESolverRKCK(double &y[], const int n, double &x[],
                                      const int m, const double eps,
                                      const double h, CODESolverState &state) {

  if (!CAp::Assert(n >= 1, "ODESolverRKCK: N<1!"))
    return;

  if (!CAp::Assert(m >= 1, "ODESolverRKCK: M<1!"))
    return;

  if (!CAp::Assert(CAp::Len(y) >= n, "ODESolverRKCK: Length(Y)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= m, "ODESolverRKCK: Length(X)<M!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(y, n),
                   "ODESolverRKCK: Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, m),
                   "ODESolverRKCK: Y contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(eps), "ODESolverRKCK: Eps is not finite!"))
    return;

  if (!CAp::Assert(eps != 0.0, "ODESolverRKCK: Eps is zero!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(h), "ODESolverRKCK: H is not finite!"))
    return;

  ODESolverInit(0, y, n, x, m, eps, h, state);
}

static void CODESolver::ODESolverResults(CODESolverState &state, int &m,
                                         double &xtbl[], CMatrixDouble &ytbl,
                                         CODESolverReport &rep) {

  double v = 0;
  int i = 0;
  int i_ = 0;

  m = 0;
  rep.m_terminationtype = state.m_repterminationtype;

  if (rep.m_terminationtype > 0) {

    m = state.m_m;
    rep.m_nfev = state.m_repnfev;

    ArrayResizeAL(xtbl, state.m_m);
    v = state.m_xscale;

    for (i_ = 0; i_ <= state.m_m - 1; i_++)
      xtbl[i_] = v * state.m_xg[i_];

    ytbl.Resize(state.m_m, state.m_n);
    for (i = 0; i <= state.m_m - 1; i++) {
      for (i_ = 0; i_ <= state.m_n - 1; i_++)
        ytbl[i].Set(i_, state.m_ytbl[i][i_]);
    }
  } else
    rep.m_nfev = 0;
}

static void CODESolver::ODESolverInit(int solvertype, double &y[], const int n,
                                      double &x[], const int m,
                                      const double eps, double h,
                                      CODESolverState &state) {

  int i = 0;
  double v = 0;
  int i_ = 0;

  ArrayResizeAL(state.m_rstate.ia, 6);
  ArrayResizeAL(state.m_rstate.ba, 1);
  ArrayResizeAL(state.m_rstate.ra, 6);
  state.m_rstate.stage = -1;
  state.m_needdy = false;

  if ((n <= 0 || m < 1) || eps == 0.0) {
    state.m_repterminationtype = -1;
    return;
  }

  if (h < 0.0)
    h = -h;

  if (m == 1) {

    state.m_repnfev = 0;
    state.m_repterminationtype = 1;
    state.m_ytbl.Resize(1, n);
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_ytbl[0].Set(i_, y[i_]);

    ArrayResizeAL(state.m_xg, m);
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_xg[i_] = x[i_];

    return;
  }

  if (x[1] == x[0]) {
    state.m_repterminationtype = -2;
    return;
  }
  for (i = 1; i <= m - 1; i++) {

    if ((x[1] > x[0] && x[i] <= x[i - 1]) ||
        (x[1] < x[0] && x[i] >= x[i - 1])) {
      state.m_repterminationtype = -2;
      return;
    }
  }

  if (h == 0.0) {
    v = MathAbs(x[1] - x[0]);
    for (i = 2; i <= m - 1; i++)
      v = MathMin(v, MathAbs(x[i] - x[i - 1]));
    h = 0.001 * v;
  }

  state.m_n = n;
  state.m_m = m;
  state.m_h = h;
  state.m_eps = MathAbs(eps);
  state.m_fraceps = eps < 0.0;

  ArrayResizeAL(state.m_xg, m);
  for (i_ = 0; i_ <= m - 1; i_++)
    state.m_xg[i_] = x[i_];

  if (x[1] > x[0])
    state.m_xscale = 1;
  else {
    state.m_xscale = -1;
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_xg[i_] = -1 * state.m_xg[i_];
  }

  ArrayResizeAL(state.m_yc, n);
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_yc[i_] = y[i_];

  state.m_solvertype = solvertype;
  state.m_repterminationtype = 0;

  ArrayResizeAL(state.m_y, n);
  ArrayResizeAL(state.m_dy, n);
}

static bool CODESolver::ODESolverIteration(CODESolverState &state) {

  int n = 0;
  int m = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  double xc = 0;
  double v = 0;
  double h = 0;
  double h2 = 0;
  bool gridpoint;
  double err = 0;
  double maxgrowpow = 0;
  int klimit = 0;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    m = state.m_rstate.ia[1];
    i = state.m_rstate.ia[2];
    j = state.m_rstate.ia[3];
    k = state.m_rstate.ia[4];
    klimit = state.m_rstate.ia[5];
    gridpoint = state.m_rstate.ba[0];
    xc = state.m_rstate.ra[0];
    v = state.m_rstate.ra[1];
    h = state.m_rstate.ra[2];
    h2 = state.m_rstate.ra[3];
    err = state.m_rstate.ra[4];
    maxgrowpow = state.m_rstate.ra[5];
  } else {

    n = -983;
    m = -989;
    i = -834;
    j = 900;
    k = -287;
    klimit = 364;
    gridpoint = false;
    xc = -338;
    v = -686;
    h = 912;
    h2 = 585;
    err = 497;
    maxgrowpow = -271;
  }

  if (state.m_rstate.stage == 0) {

    state.m_needdy = false;
    state.m_repnfev = state.m_repnfev + 1;
    v = h * state.m_xscale;
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_rkk[k].Set(i_, v * state.m_dy[i_]);

    v = state.m_rkc[k];
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_yn[i_] = state.m_yn[i_] + v * state.m_rkk[k][i_];
    v = state.m_rkcs[k];
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_yns[i_] = state.m_yns[i_] + v * state.m_rkk[k][i_];
    k = k + 1;
    return (Func_lbl_8(state, n, m, i, j, k, klimit, gridpoint, xc, v, h, h2,
                       err, maxgrowpow));
  }

  if (state.m_repterminationtype != 0)
    return (false);

  n = state.m_n;
  m = state.m_m;
  h = state.m_h;
  maxgrowpow = MathPow(m_odesolvermaxgrow, 5);
  state.m_repnfev = 0;

  if (!CAp::Assert(state.m_h > 0.0, "ODESolver: internal error"))
    return (false);

  if (!CAp::Assert(m > 1, "ODESolverIteration: internal error"))
    return (false);

  if (state.m_solvertype != 0)
    return (false);

  ArrayResizeAL(state.m_rka, 6);

  state.m_rka[0] = 0;
  state.m_rka[1] = 1.0 / 5.0;
  state.m_rka[2] = 3.0 / 10.0;
  state.m_rka[3] = 3.0 / 5.0;
  state.m_rka[4] = 1;
  state.m_rka[5] = 7.0 / 8.0;
  state.m_rkb.Resize(6, 5);
  state.m_rkb[1].Set(0, 1.0 / 5.0);
  state.m_rkb[2].Set(0, 3.0 / 40.0);
  state.m_rkb[2].Set(1, 9.0 / 40.0);
  state.m_rkb[3].Set(0, 3.0 / 10.0);
  state.m_rkb[3].Set(1, -(9.0 / 10.0));
  state.m_rkb[3].Set(2, 6.0 / 5.0);
  state.m_rkb[4].Set(0, -(11.0 / 54.0));
  state.m_rkb[4].Set(1, 5.0 / 2.0);
  state.m_rkb[4].Set(2, -(70.0 / 27.0));
  state.m_rkb[4].Set(3, 35.0 / 27.0);
  state.m_rkb[5].Set(0, 1631.0 / 55296.0);
  state.m_rkb[5].Set(1, 175.0 / 512.0);
  state.m_rkb[5].Set(2, 575.0 / 13824.0);
  state.m_rkb[5].Set(3, 44275.0 / 110592.0);
  state.m_rkb[5].Set(4, 253.0 / 4096.0);

  ArrayResizeAL(state.m_rkc, 6);

  state.m_rkc[0] = 37.0 / 378.0;
  state.m_rkc[1] = 0;
  state.m_rkc[2] = 250.0 / 621.0;
  state.m_rkc[3] = 125.0 / 594.0;
  state.m_rkc[4] = 0;
  state.m_rkc[5] = 512.0 / 1771.0;

  ArrayResizeAL(state.m_rkcs, 6);

  state.m_rkcs[0] = 2825.0 / 27648.0;
  state.m_rkcs[1] = 0;
  state.m_rkcs[2] = 18575.0 / 48384.0;
  state.m_rkcs[3] = 13525.0 / 55296.0;
  state.m_rkcs[4] = 277.0 / 14336.0;
  state.m_rkcs[5] = 1.0 / 4.0;
  state.m_rkk.Resize(6, n);

  state.m_ytbl.Resize(m, n);
  ArrayResizeAL(state.m_escale, n);
  ArrayResizeAL(state.m_yn, n);
  ArrayResizeAL(state.m_yns, n);

  xc = state.m_xg[0];
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_ytbl[0].Set(i_, state.m_yc[i_]);
  for (j = 0; j <= n - 1; j++)
    state.m_escale[j] = 0;
  i = 1;

  if (i > m - 1) {
    state.m_repterminationtype = 1;

    return (false);
  }

  return (Func_lbl_6(state, n, m, i, j, k, klimit, gridpoint, xc, v, h, h2, err,
                     maxgrowpow));
}

static void CODESolver::Func_lbl_rcomm(CODESolverState &state, int n, int m,
                                       int i, int j, int k, int klimit,
                                       bool gridpoint, double xc, double v,
                                       double h, double h2, double err,
                                       double maxgrowpow) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ia[1] = m;
  state.m_rstate.ia[2] = i;
  state.m_rstate.ia[3] = j;
  state.m_rstate.ia[4] = k;
  state.m_rstate.ia[5] = klimit;
  state.m_rstate.ba[0] = gridpoint;
  state.m_rstate.ra[0] = xc;
  state.m_rstate.ra[1] = v;
  state.m_rstate.ra[2] = h;
  state.m_rstate.ra[3] = h2;
  state.m_rstate.ra[4] = err;
  state.m_rstate.ra[5] = maxgrowpow;
}

static bool CODESolver::Func_lbl_6(CODESolverState &state, int &n, int &m,
                                   int &i, int &j, int &k, int &klimit,
                                   bool &gridpoint, double &xc, double &v,
                                   double &h, double &h2, double &err,
                                   double &maxgrowpow) {

  if (xc + h >= state.m_xg[i]) {
    h = state.m_xg[i] - xc;
    gridpoint = true;
  } else
    gridpoint = false;

  for (j = 0; j <= n - 1; j++)
    state.m_escale[j] = MathMax(state.m_escale[j], MathAbs(state.m_yc[j]));

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_yn[i_] = state.m_yc[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_yns[i_] = state.m_yc[i_];
  k = 0;

  return (Func_lbl_8(state, n, m, i, j, k, klimit, gridpoint, xc, v, h, h2, err,
                     maxgrowpow));
}

static bool CODESolver::Func_lbl_8(CODESolverState &state, int &n, int &m,
                                   int &i, int &j, int &k, int &klimit,
                                   bool &gridpoint, double &xc, double &v,
                                   double &h, double &h2, double &err,
                                   double &maxgrowpow) {

  if (k > 5)
    return (Func_lbl_10(state, n, m, i, j, k, klimit, gridpoint, xc, v, h, h2,
                        err, maxgrowpow));

  state.m_x = state.m_xscale * (xc + state.m_rka[k] * h);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_y[i_] = state.m_yc[i_];

  for (j = 0; j <= k - 1; j++) {
    v = state.m_rkb[k][j];
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_y[i_] = state.m_y[i_] + v * state.m_rkk[j][i_];
  }
  state.m_needdy = true;
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, m, i, j, k, klimit, gridpoint, xc, v, h, h2, err,
                 maxgrowpow);

  return (true);
}

static bool CODESolver::Func_lbl_10(CODESolverState &state, int &n, int &m,
                                    int &i, int &j, int &k, int &klimit,
                                    bool &gridpoint, double &xc, double &v,
                                    double &h, double &h2, double &err,
                                    double &maxgrowpow) {

  err = 0;
  for (j = 0; j <= n - 1; j++) {

    if (!state.m_fraceps) {

      err = MathMax(err, MathAbs(state.m_yn[j] - state.m_yns[j]));
    } else {

      v = state.m_escale[j];

      if (v == 0.0)
        v = 1;
      err = MathMax(err, MathAbs(state.m_yn[j] - state.m_yns[j]) / v);
    }
  }

  if (maxgrowpow * err <= state.m_eps)
    h2 = m_odesolvermaxgrow * h;
  else
    h2 = h * MathPow(state.m_eps / err, 0.2);

  if (h2 < h / m_odesolvermaxshrink)
    h2 = h / m_odesolvermaxshrink;

  if (err > state.m_eps) {
    h = h2;

    return (Func_lbl_6(state, n, m, i, j, k, klimit, gridpoint, xc, v, h, h2,
                       err, maxgrowpow));
  }

  xc = xc + h;
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_yc[i_] = state.m_yn[i_];

  h = h2;

  if (gridpoint) {

    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_ytbl[i].Set(i_, state.m_yc[i_]);
    i = i + 1;

    if (i > m - 1) {
      state.m_repterminationtype = 1;
      return (false);
    }

    return (Func_lbl_6(state, n, m, i, j, k, klimit, gridpoint, xc, v, h, h2,
                       err, maxgrowpow));
  }

  return (Func_lbl_6(state, n, m, i, j, k, klimit, gridpoint, xc, v, h, h2, err,
                     maxgrowpow));
}

#endif
