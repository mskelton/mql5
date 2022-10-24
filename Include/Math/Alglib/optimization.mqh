#ifndef OPTIMIZATION_H
#define OPTIMIZATION_H

#include "alglibinternal.mqh"
#include "ap.mqh"
#include "linalg.mqh"
#include "matrix.mqh"

class CMinCGState {
public:
  int m_n;
  double m_epsg;
  double m_epsf;
  double m_epsx;
  int m_maxits;
  double m_stpmax;
  double m_suggestedstep;
  bool m_xrep;
  bool m_drep;
  int m_cgtype;
  int m_prectype;
  int m_vcnt;
  double m_diffstep;
  int m_nfev;
  int m_mcstage;
  int m_k;
  double m_fold;
  double m_stp;
  double m_curstpmax;
  double m_laststep;
  double m_lastscaledstep;
  int m_mcinfo;
  bool m_innerresetneeded;
  bool m_terminationneeded;
  double m_trimthreshold;
  int m_rstimer;
  double m_f;
  bool m_needf;
  bool m_needfg;
  bool m_xupdated;
  bool m_algpowerup;
  bool m_lsstart;
  bool m_lsend;
  RCommState m_rstate;
  int m_repiterationscount;
  int m_repnfev;
  int m_repterminationtype;
  int m_debugrestartscount;
  CLinMinState m_lstate;
  double m_fbase;
  double m_fm2;
  double m_fm1;
  double m_fp1;
  double m_fp2;
  double m_betahs;
  double m_betady;

  double m_xk;
  double m_dk;
  double m_xn;
  double m_dn;
  double m_d;
  double m_x;
  double m_yk;
  double m_s;
  double m_g;
  double m_diagh;
  double m_diaghl2;
  double m_work0;
  double m_work1;

  CMatrixDouble m_vcorr;

  CMinCGState(void);
  ~CMinCGState(void);

  void Copy(CMinCGState &obj);
};

class CMinCGStateShell {
private:
  CMinCGState m_innerobj;

public:
  CMinCGStateShell(void);
  CMinCGStateShell(CMinCGState &obj);
  ~CMinCGStateShell(void);

  bool GetNeedF(void);
  void SetNeedF(const bool b);
  bool GetNeedFG(void);
  void SetNeedFG(const bool b);
  bool GetXUpdated(void);
  void SetXUpdated(const bool b);
  double GetF(void);
  void SetF(const double d);
  CMinCGState *GetInnerObj(void);
};

class CMinCGReport {
public:
  int m_iterationscount;
  int m_nfev;
  int m_terminationtype;

  CMinCGReport(void);
  ~CMinCGReport(void);

  void Copy(CMinCGReport &obj);
};

class CMinCGReportShell {
private:
  CMinCGReport m_innerobj;

public:
  CMinCGReportShell(void);
  CMinCGReportShell(CMinCGReport &obj);
  ~CMinCGReportShell(void);

  int GetIterationsCount(void);
  void SetIterationsCount(const int i);
  int GetNFev(void);
  void SetNFev(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  CMinCGReport *GetInnerObj(void);
};

class CMinCG {
private:
  static void ClearRequestFields(CMinCGState &state);
  static void PreconditionedMultiply(CMinCGState &state, double x[],
                                     double work0[], double work1[]);
  static double PreconditionedMultiply2(CMinCGState &state, double x[],
                                        double y[], double work0[],
                                        double work1[]);
  static void MinCGInitInternal(const int n, const double diffstep,
                                CMinCGState &state);

  static void Func_lbl_rcomm(CMinCGState &state, int n, int i, double betak,
                             double v, double vv);
  static bool Func_lbl_18(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_19(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_22(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_24(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_26(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_28(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_30(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_31(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_33(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_34(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_37(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_39(CMinCGState &state, int &n, int &i, double &betak,
                          double &v, double &vv);

public:
  static const int m_rscountdownlen;
  static const double m_gtol;

  CMinCG(void);
  ~CMinCG(void);

  static void MinCGCreate(const int n, double x[], CMinCGState &state);
  static void MinCGCreateF(const int n, double x[], const double diffstep,
                           CMinCGState &state);
  static void MinCGSetCond(CMinCGState &state, const double epsg,
                           const double epsf, double epsx, const int maxits);
  static void MinCGSetScale(CMinCGState &state, double s[]);
  static void MinCGSetXRep(CMinCGState &state, const bool needxrep);
  static void MinCGSetDRep(CMinCGState &state, const bool needdrep);
  static void MinCGSetCGType(CMinCGState &state, int cgtype);
  static void MinCGSetStpMax(CMinCGState &state, const double stpmax);
  static void MinCGSuggestStep(CMinCGState &state, const double stp);
  static void MinCGSetPrecDefault(CMinCGState &state);
  static void MinCGSetPrecDiag(CMinCGState &state, double d[]);
  static void MinCGSetPrecScale(CMinCGState &state);
  static void MinCGResults(CMinCGState &state, double x[], CMinCGReport &rep);
  static void MinCGResultsBuf(CMinCGState &state, double x[],
                              CMinCGReport &rep);
  static void MinCGRestartFrom(CMinCGState &state, double x[]);
  static void MinCGSetPrecDiagFast(CMinCGState &state, double d[]);
  static void MinCGSetPrecLowRankFast(CMinCGState &state, double d1[],
                                      double c[], CMatrixDouble &v,
                                      const int vcnt);
  static void MinCGSetPrecVarPart(CMinCGState &state, double d2[]);
  static bool MinCGIteration(CMinCGState &state);
};

class CMinBLEICState {
public:
  int m_nmain;
  int m_nslack;
  double m_innerepsg;
  double m_innerepsf;
  double m_innerepsx;
  double m_outerepsx;
  double m_outerepsi;
  int m_maxits;
  bool m_xrep;
  double m_stpmax;
  double m_diffstep;
  int m_prectype;
  double m_f;
  bool m_needf;
  bool m_needfg;
  bool m_xupdated;
  RCommState m_rstate;
  int m_repinneriterationscount;
  int m_repouteriterationscount;
  int m_repnfev;
  int m_repterminationtype;
  double m_repdebugeqerr;
  double m_repdebugfs;
  double m_repdebugff;
  double m_repdebugdx;
  int m_itsleft;
  double m_trimthreshold;
  int m_cecnt;
  int m_cedim;
  double m_v0;
  double m_v1;
  double m_v2;
  double m_t;
  double m_errfeas;
  double m_gnorm;
  double m_mpgnorm;
  double m_mba;
  int m_variabletofreeze;
  double m_valuetofreeze;
  double m_fbase;
  double m_fm2;
  double m_fm1;
  double m_fp1;
  double m_fp2;
  double m_xm1;
  double m_xp1;
  CMinCGState m_cgstate;
  CMinCGReport m_cgrep;
  int m_optdim;

  double m_diaghoriginal;
  double m_diagh;
  double m_x;
  double m_g;
  double m_xcur;
  double m_xprev;
  double m_xstart;
  double m_xend;
  double m_lastg;
  int m_ct;
  double m_xe;
  bool m_hasbndl;
  bool m_hasbndu;
  double m_bndloriginal;
  double m_bnduoriginal;
  double m_bndleffective;
  double m_bndueffective;
  bool m_activeconstraints;
  double m_constrainedvalues;
  double m_transforms;
  double m_seffective;
  double m_soriginal;
  double m_w;
  double m_tmp0;
  double m_tmp1;
  double m_tmp2;
  double m_r;

  CMatrixDouble m_ceoriginal;
  CMatrixDouble m_ceeffective;
  CMatrixDouble m_cecurrent;
  CMatrixDouble m_lmmatrix;

  CMinBLEICState(void);
  ~CMinBLEICState(void);

  void Copy(CMinBLEICState &obj);
};

class CMinBLEICStateShell {
private:
  CMinBLEICState m_innerobj;

public:
  CMinBLEICStateShell(void);
  CMinBLEICStateShell(CMinBLEICState &obj);
  ~CMinBLEICStateShell(void);

  bool GetNeedF(void);
  void SetNeedF(const bool b);
  bool GetNeedFG(void);
  void SetNeedFG(const bool b);
  bool GetXUpdated(void);
  void SetXUpdated(const bool b);
  double GetF(void);
  void SetF(const double d);
  CMinBLEICState *GetInnerObj(void);
};

class CMinBLEICReport {
public:
  int m_inneriterationscount;
  int m_outeriterationscount;
  int m_nfev;
  int m_terminationtype;
  double m_debugeqerr;
  double m_debugfs;
  double m_debugff;
  double m_debugdx;

  CMinBLEICReport(void);
  ~CMinBLEICReport(void);

  void Copy(CMinBLEICReport &obj);
};

class CMinBLEICReportShell {
private:
  CMinBLEICReport m_innerobj;

public:
  CMinBLEICReportShell(void);
  CMinBLEICReportShell(CMinBLEICReport &obj);
  ~CMinBLEICReportShell(void);

  int GetInnerIterationsCount(void);
  void SetInnerIterationsCount(const int i);
  int GetOuterIterationsCount(void);
  void SetOuterIterationsCount(const int i);
  int GetNFev(void);
  void SetNFev(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  double GetDebugEqErr(void);
  void SetDebugEqErr(const double d);
  double GetDebugFS(void);
  void SetDebugFS(const double d);
  double GetDebugFF(void);
  void SetDebugFF(const double d);
  double GetDebugDX(void);
  void SetDebugDX(const double d);
  CMinBLEICReport *GetInnerObj(void);
};

class CMinBLEIC {
private:
  static void ClearRequestFields(CMinBLEICState &state);
  static void UnscalePoint(CMinBLEICState &state, double xscaled[],
                           double xunscaled[]);
  static void ProjectPointAndUnscale(CMinBLEICState &state, double xscaled[],
                                     double xunscaled[], double rscaled[],
                                     double &rnorm2);
  static void ScaleGradientAndExpand(CMinBLEICState &state, double gunscaled[],
                                     double gscaled[]);
  static void ModifyTargetFunction(CMinBLEICState &state, double x[],
                                   double r[], const double rnorm2, double &f,
                                   double g[], double &gnorm, double &mpgnorm);
  static bool AdditionalCheckForConstraints(CMinBLEICState &state, double x[]);
  static void RebuildCEXE(CMinBLEICState &state);
  static void MakeGradientProjection(CMinBLEICState &state, double pg[]);
  static bool PrepareConstraintMatrix(CMinBLEICState &state, double x[],
                                      double g[], double px[], double pg[]);
  static void MinBLEICInitInternal(const int n, double x[],
                                   const double diffstep,
                                   CMinBLEICState &state);

  static void Func_lbl_rcomm(CMinBLEICState &state, int nmain, int nslack,
                             int m, int i, int j, bool b, double v, double vv);
  static bool Func_lbl_14(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);
  static bool Func_lbl_15(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);
  static bool Func_lbl_16(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);
  static bool Func_lbl_17(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);
  static bool Func_lbl_18(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);
  static bool Func_lbl_19(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);
  static bool Func_lbl_22(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);
  static bool Func_lbl_23(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);
  static bool Func_lbl_31(CMinBLEICState &state, int &nmain, int &nslack,
                          int &m, int &i, int &j, bool &b, double &v,
                          double &vv);

public:
  static const double m_svdtol;
  static const double m_maxouterits;

  CMinBLEIC(void);
  ~CMinBLEIC(void);

  static void MinBLEICCreate(const int n, double x[], CMinBLEICState &state);
  static void MinBLEICCreateF(const int n, double x[], const double diffstep,
                              CMinBLEICState &state);
  static void MinBLEICSetBC(CMinBLEICState &state, double bndl[],
                            double bndu[]);
  static void MinBLEICSetLC(CMinBLEICState &state, CMatrixDouble &c, int ct[],
                            const int k);
  static void MinBLEICSetInnerCond(CMinBLEICState &state, const double epsg,
                                   const double epsf, const double epsx);
  static void MinBLEICSetOuterCond(CMinBLEICState &state, const double epsx,
                                   const double epsi);
  static void MinBLEICSetScale(CMinBLEICState &state, double s[]);
  static void MinBLEICSetPrecDefault(CMinBLEICState &state);
  static void MinBLEICSetPrecDiag(CMinBLEICState &state, double d[]);
  static void MinBLEICSetPrecScale(CMinBLEICState &state);
  static void MinBLEICSetMaxIts(CMinBLEICState &state, const int maxits);
  static void MinBLEICSetXRep(CMinBLEICState &state, const bool needxrep);
  static void MinBLEICSetStpMax(CMinBLEICState &state, const double stpmax);
  static void MinBLEICResults(CMinBLEICState &state, double x[],
                              CMinBLEICReport &rep);
  static void MinBLEICResultsBuf(CMinBLEICState &state, double x[],
                                 CMinBLEICReport &rep);
  static void MinBLEICRestartFrom(CMinBLEICState &state, double x[]);
  static bool MinBLEICIteration(CMinBLEICState &state);
};

class CMinLBFGSState {
public:
  int m_n;
  int m_m;
  double m_epsg;
  double m_epsf;
  double m_epsx;
  int m_maxits;
  bool m_xrep;
  double m_stpmax;
  double m_diffstep;
  int m_nfev;
  int m_mcstage;
  int m_k;
  int m_q;
  int m_p;
  double m_stp;
  double m_fold;
  double m_trimthreshold;
  int m_prectype;
  double m_gammak;
  double m_fbase;
  double m_fm2;
  double m_fm1;
  double m_fp1;
  double m_fp2;
  double m_f;
  bool m_needf;
  bool m_needfg;
  bool m_xupdated;
  RCommState m_rstate;
  int m_repiterationscount;
  int m_repnfev;
  int m_repterminationtype;
  CLinMinState m_lstate;

  double m_s;
  double m_rho;
  double m_theta;
  double m_d;
  double m_work;
  double m_diagh;
  double m_autobuf;
  double m_x;
  double m_g;

  CMatrixDouble m_yk;
  CMatrixDouble m_sk;
  CMatrixDouble m_denseh;

  CMinLBFGSState(void);
  ~CMinLBFGSState(void);

  void Copy(CMinLBFGSState &obj);
};

class CMinLBFGSStateShell {
private:
  CMinLBFGSState m_innerobj;

public:
  CMinLBFGSStateShell(void);
  CMinLBFGSStateShell(CMinLBFGSState &obj);
  ~CMinLBFGSStateShell(void);

  bool GetNeedF(void);
  void SetNeedF(const bool b);
  bool GetNeedFG(void);
  void SetNeedFG(const bool b);
  bool GetXUpdated(void);
  void SetXUpdated(const bool b);
  double GetF(void);
  void SetF(const double d);
  CMinLBFGSState *GetInnerObj(void);
};

class CMinLBFGSReport {
public:
  int m_iterationscount;
  int m_nfev;
  int m_terminationtype;

  CMinLBFGSReport(void);
  ~CMinLBFGSReport(void);

  void Copy(CMinLBFGSReport &obj);
};

class CMinLBFGSReportShell {
private:
  CMinLBFGSReport m_innerobj;

public:
  CMinLBFGSReportShell(void);
  CMinLBFGSReportShell(CMinLBFGSReport &obj);
  ~CMinLBFGSReportShell(void);

  int GetIterationsCount(void);
  void SetIterationsCount(const int i);
  int GetNFev(void);
  void SetNFev(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  CMinLBFGSReport *GetInnerObj(void);
};

class CMinLBFGS {
private:
  static void ClearRequestFields(CMinLBFGSState &state);

  static void Func_lbl_rcomm(CMinLBFGSState &state, int n, int m, int i, int j,
                             int ic, int mcinfo, double v, double vv);
  static bool Func_lbl_16(CMinLBFGSState &state, int &n, int &m, int &i, int &j,
                          int &ic, int &mcinfo, double &v, double &vv);
  static bool Func_lbl_19(CMinLBFGSState &state, int &n, int &m, int &i, int &j,
                          int &ic, int &mcinfo, double &v, double &vv);
  static bool Func_lbl_21(CMinLBFGSState &state, int &n, int &m, int &i, int &j,
                          int &ic, int &mcinfo, double &v, double &vv);
  static bool Func_lbl_23(CMinLBFGSState &state, int &n, int &m, int &i, int &j,
                          int &ic, int &mcinfo, double &v, double &vv);
  static bool Func_lbl_27(CMinLBFGSState &state, int &n, int &m, int &i, int &j,
                          int &ic, int &mcinfo, double &v, double &vv);
  static bool Func_lbl_30(CMinLBFGSState &state, int &n, int &m, int &i, int &j,
                          int &ic, int &mcinfo, double &v, double &vv);

public:
  static const double m_gtol;

  CMinLBFGS(void);
  ~CMinLBFGS(void);

  static void MinLBFGSCreate(const int n, const int m, double x[],
                             CMinLBFGSState &state);
  static void MinLBFGSCreateF(const int n, const int m, double x[],
                              const double diffstep, CMinLBFGSState &state);
  static void MinLBFGSSetCond(CMinLBFGSState &state, const double epsg,
                              const double epsf, double epsx, const int maxits);
  static void MinLBFGSSetXRep(CMinLBFGSState &state, const bool needxrep);
  static void MinLBFGSSetStpMax(CMinLBFGSState &state, const double stpmax);
  static void MinLBFGSSetScale(CMinLBFGSState &state, double s[]);
  static void MinLBFGSCreateX(const int n, const int m, double x[], int flags,
                              const double diffstep, CMinLBFGSState &state);
  static void MinLBFGSSetPrecDefault(CMinLBFGSState &state);
  static void MinLBFGSSetPrecCholesky(CMinLBFGSState &state, CMatrixDouble &p,
                                      const bool isupper);
  static void MinLBFGSSetPrecDiag(CMinLBFGSState &state, double d[]);
  static void MinLBFGSSetPrecScale(CMinLBFGSState &state);
  static void MinLBFGSResults(CMinLBFGSState &state, double x[],
                              CMinLBFGSReport &rep);
  static void MinLBFGSresultsbuf(CMinLBFGSState &state, double x[],
                                 CMinLBFGSReport &rep);
  static void MinLBFGSRestartFrom(CMinLBFGSState &state, double x[]);
  static bool MinLBFGSIteration(CMinLBFGSState &state);
};

class CMinQPState {
public:
  int m_n;
  int m_algokind;
  int m_akind;
  bool m_havex;
  double m_constterm;
  int m_repinneriterationscount;
  int m_repouteriterationscount;
  int m_repncholesky;
  int m_repnmv;
  int m_repterminationtype;
  CApBuff m_buf;

  double m_diaga;
  double m_b;
  double m_bndl;
  double m_bndu;
  bool m_havebndl;
  bool m_havebndu;
  double m_xorigin;
  double m_startx;
  double m_xc;
  double m_gc;
  int m_activeconstraints;
  int m_prevactiveconstraints;
  double m_workbndl;
  double m_workbndu;
  double m_tmp0;
  double m_tmp1;
  int m_itmp0;
  int m_p2;
  double m_bufb;
  double m_bufx;

  CMatrixDouble m_densea;
  CMatrixDouble m_bufa;

  CMinQPState(void);
  ~CMinQPState(void);

  void Copy(CMinQPState &obj);
};

class CMinQPStateShell {
private:
  CMinQPState m_innerobj;

public:
  CMinQPStateShell(void);
  CMinQPStateShell(CMinQPState &obj);
  ~CMinQPStateShell(void);

  CMinQPState *GetInnerObj(void);
};

class CMinQPReport {
public:
  int m_inneriterationscount;
  int m_outeriterationscount;
  int m_nmv;
  int m_ncholesky;
  int m_terminationtype;

  CMinQPReport(void);
  ~CMinQPReport(void);

  void Copy(CMinQPReport &obj);
};

class CMinQPReportShell {
private:
  CMinQPReport m_innerobj;

public:
  CMinQPReportShell(void);
  CMinQPReportShell(CMinQPReport &obj);
  ~CMinQPReportShell(void);

  int GetInnerIterationsCount(void);
  void SetInnerIterationsCount(const int i);
  int GetOuterIterationsCount(void);
  void SetOuterIterationsCount(const int i);
  int GetNMV(void);
  void SetNMV(const int i);
  int GetNCholesky(void);
  void SetNCholesky(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  CMinQPReport *GetInnerObj(void);
};

class CMinQP {
private:
  static void MinQPGrad(CMinQPState &state);
  static double MinQPXTAX(CMinQPState &state, double x[]);

public:
  CMinQP(void);
  ~CMinQP(void);

  static void MinQPCreate(const int n, CMinQPState &state);
  static void MinQPSetLinearTerm(CMinQPState &state, double b[]);
  static void MinQPSetQuadraticTerm(CMinQPState &state, CMatrixDouble &a,
                                    const bool isupper);
  static void MinQPSetStartingPoint(CMinQPState &state, double x[]);
  static void MinQPSetOrigin(CMinQPState &state, double xorigin[]);
  static void MinQPSetAlgoCholesky(CMinQPState &state);
  static void MinQPSetBC(CMinQPState &state, double bndl[], double bndu[]);
  static void MinQPOptimize(CMinQPState &state);
  static void MinQPResults(CMinQPState &state, double x[], CMinQPReport &rep);
  static void MinQPResultsBuf(CMinQPState &state, double x[],
                              CMinQPReport &rep);
  static void MinQPSetLinearTermFast(CMinQPState &state, double b[]);
  static void MinQPSetQuadraticTermFast(CMinQPState &state, CMatrixDouble &a,
                                        const bool isupper, const double s);
  static void MinQPRewriteDiagonal(CMinQPState &state, double s[]);
  static void MinQPSetStartingPointFast(CMinQPState &state, double x[]);
  static void MinQPSetOriginFast(CMinQPState &state, double xorigin[]);
};

class CMinLMState {
public:
  int m_n;
  int m_m;
  double m_diffstep;
  double m_epsg;
  double m_epsf;
  double m_epsx;
  int m_maxits;
  bool m_xrep;
  double m_stpmax;
  int m_maxmodelage;
  bool m_makeadditers;
  double m_f;
  bool m_needf;
  bool m_needfg;
  bool m_needfgh;
  bool m_needfij;
  bool m_needfi;
  bool m_xupdated;
  int m_algomode;
  bool m_hasf;
  bool m_hasfi;
  bool m_hasg;
  double m_fbase;
  double m_lambdav;
  double m_nu;
  int m_modelage;
  bool m_deltaxready;
  bool m_deltafready;
  int m_repiterationscount;
  int m_repterminationtype;
  int m_repnfunc;
  int m_repnjac;
  int m_repngrad;
  int m_repnhess;
  int m_repncholesky;
  RCommState m_rstate;
  double m_actualdecrease;
  double m_predicteddecrease;
  double m_xm1;
  double m_xp1;
  CMinLBFGSState m_internalstate;
  CMinLBFGSReport m_internalrep;
  CMinQPState m_qpstate;
  CMinQPReport m_qprep;

  double m_x;
  double m_fi;
  double m_g;
  double m_xbase;
  double m_fibase;
  double m_gbase;
  double m_bndl;
  double m_bndu;
  bool m_havebndl;
  bool m_havebndu;
  double m_s;
  double m_xdir;
  double m_deltax;
  double m_deltaf;
  double m_choleskybuf;
  double m_tmp0;
  double m_fm1;
  double m_fp1;

  CMatrixDouble m_j;
  CMatrixDouble m_h;
  CMatrixDouble m_quadraticmodel;

  CMinLMState(void);
  ~CMinLMState(void);

  void Copy(CMinLMState &obj);
};

class CMinLMStateShell {
private:
  CMinLMState m_innerobj;

public:
  CMinLMStateShell(void);
  CMinLMStateShell(CMinLMState &obj);
  ~CMinLMStateShell(void);

  bool GetNeedF(void);
  void SetNeedF(const bool b);
  bool GetNeedFG(void);
  void SetNeedFG(const bool b);
  bool GetNeedFGH(void);
  void SetNeedFGH(const bool b);
  bool GetNeedFI(void);
  void SetNeedFI(const bool b);
  bool GetNeedFIJ(void);
  void SetNeedFIJ(const bool b);
  bool GetXUpdated(void);
  void SetXUpdated(const bool b);
  double GetF(void);
  void SetF(const double d);
  CMinLMState *GetInnerObj(void);
};

class CMinLMReport {
public:
  int m_iterationscount;
  int m_terminationtype;
  int m_nfunc;
  int m_njac;
  int m_ngrad;
  int m_nhess;
  int m_ncholesky;

  CMinLMReport(void);
  ~CMinLMReport(void);

  void Copy(CMinLMReport &obj);
};

class CMinLMReportShell {
private:
  CMinLMReport m_innerobj;

public:
  CMinLMReportShell(void);
  CMinLMReportShell(CMinLMReport &obj);
  ~CMinLMReportShell(void);

  int GetIterationsCount(void);
  void SetIterationsCount(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  int GetNFunc(void);
  void SetNFunc(const int i);
  int GetNJAC(void);
  void SetNJAC(const int i);
  int GetNGrad(void);
  void SetNGrad(const int i);
  int GetNHess(void);
  void SetNHess(const int i);
  int GetNCholesky(void);
  void SetNCholesky(const int i);
  CMinLMReport *GetInnerObj(void);
};

class CMinLM {
private:
  static void LMPRepare(const int n, const int m, bool havegrad,
                        CMinLMState &state);
  static void ClearRequestFields(CMinLMState &state);
  static bool IncreaseLambda(double &lambdav, double &nu);
  static void DecreaseLambda(double &lambdav, double &nu);
  static double BoundedScaledAntigradNorm(CMinLMState &state, double x[],
                                          double g[]);

  static void Func_lbl_rcomm(CMinLMState &state, int n, int m, int iflag, int i,
                             int k, bool bflag, double v, double s, double t);
  static bool Func_lbl_16(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_19(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_20(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_21(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_22(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_24(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_25(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_28(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_31(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_39(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_40(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_41(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_48(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_49(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);
  static bool Func_lbl_55(CMinLMState &state, int &n, int &m, int &iflag,
                          int &i, int &k, bool &bflag, double &v, double &s,
                          double &t);

public:
  static const int m_lmmodefj;
  static const int m_lmmodefgj;
  static const int m_lmmodefgh;
  static const int m_lmflagnopreLBFGS;
  static const int m_lmflagnointLBFGS;
  static const int m_lmpreLBFGSm;
  static const int m_lmintLBFGSits;
  static const int m_lbfgsnorealloc;
  static const double m_lambdaup;
  static const double m_lambdadown;
  static const double m_suspiciousnu;
  static const int m_smallmodelage;
  static const int m_additers;

  CMinLM(void);
  ~CMinLM(void);

  static void MinLMCreateVJ(const int n, const int m, double x[],
                            CMinLMState &state);
  static void MinLMCreateV(const int n, const int m, double x[],
                           const double diffstep, CMinLMState &state);
  static void MinLMCreateFGH(const int n, double x[], CMinLMState &state);
  static void MinLMSetCond(CMinLMState &state, const double epsg,
                           const double epsf, double epsx, const int maxits);
  static void MinLMSetXRep(CMinLMState &state, const bool needxrep);
  static void MinLMSetStpMax(CMinLMState &state, const double stpmax);
  static void MinLMSetScale(CMinLMState &state, double s[]);
  static void MinLMSetBC(CMinLMState &state, double bndl[], double bndu[]);
  static void MinLMSetAccType(CMinLMState &state, int acctype);
  static void MinLMResults(CMinLMState &state, double x[], CMinLMReport &rep);
  static void MinLMResultsBuf(CMinLMState &state, double x[],
                              CMinLMReport &rep);
  static void MinLMRestartFrom(CMinLMState &state, double x[]);
  static void MinLMCreateVGJ(const int n, const int m, double x[],
                             CMinLMState &state);
  static void MinLMCreateFGJ(const int n, const int m, double x[],
                             CMinLMState &state);
  static void MinLMCreateFJ(const int n, const int m, double x[],
                            CMinLMState &state);
  static bool MinLMIteration(CMinLMState &state);
};

class CMinASAState {
public:
  int m_n;
  double m_epsg;
  double m_epsf;
  double m_epsx;
  int m_maxits;
  bool m_xrep;
  double m_stpmax;
  int m_cgtype;
  int m_k;
  int m_nfev;
  int m_mcstage;
  int m_curalgo;
  int m_acount;
  double m_mu;
  double m_finit;
  double m_dginit;
  double m_fold;
  double m_stp;
  double m_laststep;
  double m_f;
  bool m_needfg;
  bool m_xupdated;
  RCommState m_rstate;
  int m_repiterationscount;
  int m_repnfev;
  int m_repterminationtype;
  int m_debugrestartscount;
  CLinMinState m_lstate;
  double m_betahs;
  double m_betady;

  double m_bndl;
  double m_bndu;
  double m_ak;
  double m_xk;
  double m_dk;
  double m_an;
  double m_xn;
  double m_dn;
  double m_d;
  double m_work;
  double m_yk;
  double m_gc;
  double m_x;
  double m_g;

  CMinASAState(void);
  ~CMinASAState(void);

  void Copy(CMinASAState &obj);
};

class CMinASAStateShell {
private:
  CMinASAState m_innerobj;

public:
  CMinASAStateShell(void);
  CMinASAStateShell(CMinASAState &obj);
  ~CMinASAStateShell(void);

  bool GetNeedFG(void);
  void SetNeedFG(const bool b);
  bool GetXUpdated(void);
  void SetXUpdated(const bool b);
  double GetF(void);
  void SetF(const double d);
  CMinASAState *GetInnerObj(void);
};

class CMinASAReport {
public:
  int m_iterationscount;
  int m_nfev;
  int m_terminationtype;
  int m_activeconstraints;

  CMinASAReport(void);
  ~CMinASAReport(void);

  void Copy(CMinASAReport &obj);
};

class CMinASAReportShell {
private:
  CMinASAReport m_innerobj;

public:
  CMinASAReportShell(void);
  CMinASAReportShell(CMinASAReport &obj);
  ~CMinASAReportShell(void);

  int GetIterationsCount(void);
  void SetIterationsCount(const int i);
  int GetNFev(void);
  void SetNFev(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  int GetActiveConstraints(void);
  void SetActiveConstraints(const int i);
  CMinASAReport *GetInnerObj(void);
};

class CMinComp {
private:
  static double ASABoundedAntigradNorm(CMinASAState &state);
  static double ASAGINorm(CMinASAState &state);
  static double ASAD1Norm(CMinASAState &state);
  static bool ASAUIsEmpty(CMinASAState &state);
  static void ClearRequestFields(CMinASAState &state);

  static void Func_lbl_rcomm(CMinASAState &state, int n, int i, int mcinfo,
                             int diffcnt, bool b, bool stepfound, double betak,
                             double v, double vv);
  static bool Func_lbl_15(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_17(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_19(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_21(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_24(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_26(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_27(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_29(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_31(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_35(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_39(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_43(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_49(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_51(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_52(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_53(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_55(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_59(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_63(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);
  static bool Func_lbl_65(CMinASAState &state, int &n, int &i, int &mcinfo,
                          int &diffcnt, bool &b, bool &stepfound, double &betak,
                          double &v, double &vv);

public:
  static const int m_n1;
  static const int m_n2;
  static const double m_stpmin;
  static const double m_gtol;
  static const double m_gpaftol;
  static const double m_gpadecay;
  static const double m_asarho;

  CMinComp(void);
  ~CMinComp(void);

  static void MinLBFGSSetDefaultPreconditioner(CMinLBFGSState &state);
  static void MinLBFGSSetCholeskyPreconditioner(CMinLBFGSState &state,
                                                CMatrixDouble &p,
                                                const bool isupper);
  static void MinBLEICSetBarrierWidth(CMinBLEICState &state, const double mu);
  static void MinBLEICSetBarrierDecay(CMinBLEICState &state,
                                      const double mudecay);
  static void MinASACreate(const int n, double x[], double bndl[],
                           double bndu[], CMinASAState &state);
  static void MinASASetCond(CMinASAState &state, const double epsg,
                            const double epsf, double epsx, const int maxits);
  static void MinASASetXRep(CMinASAState &state, const bool needxrep);
  static void MinASASetAlgorithm(CMinASAState &state, int algotype);
  static void MinASASetStpMax(CMinASAState &state, const double stpmax);
  static void MinASAResults(CMinASAState &state, double x[],
                            CMinASAReport &rep);
  static void MinASAResultsBuf(CMinASAState &state, double x[],
                               CMinASAReport &rep);
  static void MinASARestartFrom(CMinASAState &state, double x[], double bndl[],
                                double bndu[]);
  static bool MinASAIteration(CMinASAState &state);
};

#endif
