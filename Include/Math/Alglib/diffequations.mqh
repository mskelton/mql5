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

  double m_yc;
  double m_escale;
  double m_xg;
  double m_y;
  double m_dy;
  double m_yn;
  double m_yns;
  double m_rka;
  double m_rkc;
  double m_rkcs;

  CMatrixDouble m_ytbl;
  CMatrixDouble m_rkb;
  CMatrixDouble m_rkk;

public:
  CODESolverState(void);
  ~CODESolverState(void);

  void Copy(CODESolverState &obj);
};

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

class CODESolverReport {
public:
  int m_nfev;
  int m_terminationtype;

  CODESolverReport(void);
  ~CODESolverReport(void);

  void Copy(CODESolverReport &obj);
};

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

class CODESolver {
private:
  static void ODESolverInit(int solvertype, double y[], const int n, double x[],
                            const int m, const double eps, double h,
                            CODESolverState &state);

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

  static void ODESolverRKCK(double y[], const int n, double x[], const int m,
                            const double eps, const double h,
                            CODESolverState &state);
  static void ODESolverResults(CODESolverState &state, int &m, double xtbl[],
                               CMatrixDouble &ytbl, CODESolverReport &rep);
  static bool ODESolverIteration(CODESolverState &state);
};

#endif
