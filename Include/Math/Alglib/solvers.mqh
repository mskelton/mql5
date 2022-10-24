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











class CDenseSolver {
private:
  static void RMatrixLUSolveInternal(CMatrixDouble lua, int &p[],
                                     const double scalea, const int n,
                                     CMatrixDouble &a, const bool havea,
                                     CMatrixDouble &b, const int m, int &info,
                                     CDenseSolverReport &rep, CMatrixDouble &x);
  static void SPDMatrixCholeskySolveInternal(
      CMatrixDouble &cha, const double sqrtscalea, const int n,
      const bool isupper, CMatrixDouble &a, const bool havea, CMatrixDouble &b,
      const int m, int &info, CDenseSolverReport &rep, CMatrixDouble &x);
  static void CMatrixLUSolveInternal(CMatrixComplex lua, int &p[],
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
  static void RBasicLUSolve(CMatrixDouble lua, int &p[], const double scalea,
                            const int n, double xb[], double tmp[]);
  static void SPDBasicCholeskySolve(CMatrixDouble &cha, const double sqrtscalea,
                                    const int n, const bool isupper,
                                    double xb[], double tmp[]);
  static void CBasicLUSolve(CMatrixComplex lua, int &p[], const double scalea,
                            const int n, al_complex xb[], al_complex tmp[]);
  static void HPDBasicCholeskySolve(CMatrixComplex &cha,
                                    const double sqrtscalea, const int n,
                                    const bool isupper, al_complex xb[],
                                    al_complex tmp[]);

public:
  CDenseSolver(void);
  ~CDenseSolver(void);

  static void RMatrixSolve(CMatrixDouble a, const int n, double &b[],
                           int info, CDenseSolverReport &rep, double &x[]);
  static void RMatrixSolveM(CMatrixDouble &a, const int n, CMatrixDouble &b,
                            const int m, const bool rfs, int &info,
                            CDenseSolverReport &rep, CMatrixDouble &x);
  static void RMatrixLUSolve(CMatrixDouble lua, int &p[], const int n,
                             double b[], int &info, CDenseSolverReport &rep,
                             double x[]);
  static void RMatrixLUSolveM(CMatrixDouble lua, int &p[], const int n,
                              CMatrixDouble &b, const int m, int &info,
                              CDenseSolverReport &rep, CMatrixDouble &x);
  static void RMatrixMixedSolve(CMatrixDouble a, CMatrixDouble &lua, int &p[],
                                const int n, double b[], int &info,
                                CDenseSolverReport rep, double &x[]);
  static void RMatrixMixedSolveM(CMatrixDouble a, CMatrixDouble &lua, int &p[],
                                 const int n, CMatrixDouble &b, const int m,
                                 int &info, CDenseSolverReport &rep,
                                 CMatrixDouble &x);
  static void CMatrixSolveM(CMatrixComplex &a, const int n, CMatrixComplex &b,
                            const int m, const bool rfs, int &info,
                            CDenseSolverReport &rep, CMatrixComplex &x);
  static void CMatrixSolve(CMatrixComplex a, const int n, al_complex &b[],
                           int info, CDenseSolverReport &rep, al_complex &x[]);
  static void CMatrixLUSolveM(CMatrixComplex lua, int &p[], const int n,
                              CMatrixComplex &b, const int m, int &info,
                              CDenseSolverReport &rep, CMatrixComplex &x);
  static void CMatrixLUSolve(CMatrixComplex lua, int &p[], const int n,
                             al_complex b[], int &info,
                             CDenseSolverReport rep, al_complex &x[]);
  static void CMatrixMixedSolveM(CMatrixComplex &a, CMatrixComplex &lua,
                                 int p[], const int n, CMatrixComplex &b,
                                 const int m, int &info,
                                 CDenseSolverReport &rep, CMatrixComplex &x);
  static void CMatrixMixedSolve(CMatrixComplex &a, CMatrixComplex &lua,
                                int p[], const int n, al_complex b[],
                                int &info, CDenseSolverReport &rep,
                                al_complex x[]);
  static void SPDMatrixSolveM(CMatrixDouble &a, const int n, const bool isupper,
                              CMatrixDouble &b, const int m, int &info,
                              CDenseSolverReport &rep, CMatrixDouble &x);
  static void SPDMatrixSolve(CMatrixDouble &a, const int n, const bool isupper,
                             double b[], int &info, CDenseSolverReport &rep,
                             double x[]);
  static void SPDMatrixCholeskySolveM(CMatrixDouble &cha, const int n,
                                      const bool isupper, CMatrixDouble &b,
                                      const int m, int &info,
                                      CDenseSolverReport &rep,
                                      CMatrixDouble &x);
  static void SPDMatrixCholeskySolve(CMatrixDouble &cha, const int n,
                                     const bool isupper, double b[], int &info,
                                     CDenseSolverReport rep, double &x[]);
  static void HPDMatrixSolveM(CMatrixComplex &a, const int n,
                              const bool isupper, CMatrixComplex &b,
                              const int m, int &info, CDenseSolverReport &rep,
                              CMatrixComplex &x);
  static void HPDMatrixSolve(CMatrixComplex &a, const int n, const bool isupper,
                             al_complex b[], int &info,
                             CDenseSolverReport rep, al_complex &x[]);
  static void HPDMatrixCholeskySolveM(CMatrixComplex &cha, const int n,
                                      const bool isupper, CMatrixComplex &b,
                                      const int m, int &info,
                                      CDenseSolverReport &rep,
                                      CMatrixComplex &x);
  static void HPDMatrixCholeskySolve(CMatrixComplex &cha, const int n,
                                     const bool isupper, al_complex b[],
                                     int &info, CDenseSolverReport &rep,
                                     al_complex x[]);
  static void RMatrixSolveLS(CMatrixDouble &a, const int nrows, const int ncols,
                             double b[], double threshold, int &info,
                             CDenseSolverLSReport rep, double &x[]);
};


































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

  double m_x;
  double m_fi;
  double m_xbase;
  double m_candstep;
  double m_rightpart;
  double m_cgbuf;

  CMatrixDouble m_j;

  CNlEqState(void);
  ~CNlEqState(void);

  void Copy(CNlEqState &obj);
};




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

  static void NlEqCreateLM(const int n, const int m, double x[],
                           CNlEqState &state);
  static void NlEqSetCond(CNlEqState &state, double epsf, const int maxits);
  static void NlEqSetXRep(CNlEqState &state, const bool needxrep);
  static void NlEqSetStpMax(CNlEqState &state, const double stpmax);
  static void NlEqResults(CNlEqState state, double &x[], CNlEqReport &rep);
  static void NlEqResultsBuf(CNlEqState state, double &x[], CNlEqReport &rep);
  static void NlEqRestartFrom(CNlEqState state, double &x[]);
  static bool NlEqIteration(CNlEqState &state);
};




















#endif
