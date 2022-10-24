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

  double m_xbuf;
  int m_tbuf;
  double m_rbuf;

  CMatrixDouble m_q;
  CMatrixDouble m_xybuf;

public:
  CIDWInterpolant(void);
  ~CIDWInterpolant(void);

  void Copy(CIDWInterpolant &obj);
};

class CIDWInterpolantShell {
private:
  CIDWInterpolant m_innerobj;

public:
  CIDWInterpolantShell(void);
  CIDWInterpolantShell(CIDWInterpolant &obj);
  ~CIDWInterpolantShell(void);

  CIDWInterpolant *GetInnerObj(void);
};

class CIDWInt {
private:
  static double IDWCalcQ(CIDWInterpolant &z, double x[], const int k);
  static void IDWInit1(const int n, const int nx, const int d, int nq, int nw,
                       CIDWInterpolant &z);
  static void IDWInternalSolver(double y[], double w[], CMatrixDouble &fmatrix,
                                double temp[], const int n, const int m,
                                int &info, double x[], double &taskrcond);

public:
  static const double m_idwqfactor;
  static const int m_idwkmin;

  CIDWInt(void);
  ~CIDWInt(void);

  static double IDWCalc(CIDWInterpolant &z, double x[]);
  static void IDWBuildModifiedShepard(CMatrixDouble &xy, const int n,
                                      const int nx, const int d, int nq, int nw,
                                      CIDWInterpolant &z);
  static void IDWBuildModifiedShepardR(CMatrixDouble &xy, const int n,
                                       const int nx, const double r,
                                       CIDWInterpolant &z);
  static void IDWBuildNoisy(CMatrixDouble &xy, const int n, const int nx,
                            const int d, int nq, int nw, CIDWInterpolant &z);
};

class CBarycentricInterpolant {
public:
  int m_n;
  double m_sy;

  double m_x;
  double m_y;
  double m_w;

  CBarycentricInterpolant(void);
  ~CBarycentricInterpolant(void);

  void Copy(CBarycentricInterpolant &obj);
};

class CBarycentricInterpolantShell {
private:
  CBarycentricInterpolant m_innerobj;

public:
  CBarycentricInterpolantShell(void);
  CBarycentricInterpolantShell(CBarycentricInterpolant &obj);
  ~CBarycentricInterpolantShell(void);

  CBarycentricInterpolant *GetInnerObj(void);
};

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
  static void BarycentricUnpack(CBarycentricInterpolant &b, int &n, double x[],
                                double y[], double w[]);
  static void BarycentricBuildXYW(double x[], double y[], double w[],
                                  const int n, CBarycentricInterpolant &b);
  static void BarycentricBuildFloaterHormann(double x[], double y[],
                                             const int n, int d,
                                             CBarycentricInterpolant &b);
  static void BarycentricCopy(CBarycentricInterpolant &b,
                              CBarycentricInterpolant &b2);
};

class CPolInt {
public:
  CPolInt(void);
  ~CPolInt(void);

  static void PolynomialBar2Cheb(CBarycentricInterpolant &p, const double a,
                                 const double b, double t[]);
  static void PolynomialCheb2Bar(double t[], const int n, const double a,
                                 const double b, CBarycentricInterpolant &p);
  static void PolynomialBar2Pow(CBarycentricInterpolant &p, const double c,
                                const double s, double a[]);
  static void PolynomialPow2Bar(double a[], const int n, const double c,
                                const double s, CBarycentricInterpolant &p);
  static void PolynomialBuild(double cx[], double cy[], const int n,
                              CBarycentricInterpolant &p);
  static void PolynomialBuildEqDist(const double a, const double b, double y[],
                                    const int n, CBarycentricInterpolant &p);
  static void PolynomialBuildCheb1(const double a, const double b, double y[],
                                   const int n, CBarycentricInterpolant &p);
  static void PolynomialBuildCheb2(const double a, const double b, double y[],
                                   const int n, CBarycentricInterpolant &p);
  static double PolynomialCalcEqDist(const double a, const double b, double f[],
                                     const int n, const double t);
  static double PolynomialCalcCheb1(const double a, const double b, double f[],
                                    const int n, double t);
  static double PolynomialCalcCheb2(const double a, const double b, double f[],
                                    const int n, double t);
};

class CSpline1DInterpolant {
public:
  bool m_periodic;
  int m_n;
  int m_k;

  double m_x;
  double m_c;

  CSpline1DInterpolant(void);
  ~CSpline1DInterpolant(void);

  void Copy(CSpline1DInterpolant &obj);
};

class CSpline1DInterpolantShell {
private:
  CSpline1DInterpolant m_innerobj;

public:
  CSpline1DInterpolantShell(void);
  CSpline1DInterpolantShell(CSpline1DInterpolant &obj);
  ~CSpline1DInterpolantShell(void);

  CSpline1DInterpolant *GetInnerObj(void);
};

class CSpline1D {
private:
  static void
  Spline1DGridDiffCubicInternal(double x[], double y[], const int n,
                                const int boundltype, const double boundl,
                                const int boundrtype, const double boundr,
                                double d[], double a1[], double a2[],
                                double a3[], double b[], double dt[]);
  static void HeapSortPoints(double x[], double y[], const int n);
  static void HeapSortPPoints(double x[], double y[], int p[], const int n);
  static void SolveTridiagonal(double a[], double cb[], double c[], double cd[],
                               const int n, double x[]);
  static void SolveCyclicTridiagonal(double a[], double cb[], double c[],
                                     double d[], const int n, double x[]);
  static double DiffThreePoint(double t, const double x0, const double f0,
                               double x1, const double f1, double x2,
                               const double f2);

public:
  CSpline1D(void);
  ~CSpline1D(void);

  static void Spline1DBuildLinear(double cx[], double cy[], const int n,
                                  CSpline1DInterpolant &c);
  static void Spline1DBuildCubic(double cx[], double cy[], const int n,
                                 const int boundltype, const double boundl,
                                 const int boundrtype, const double boundr,
                                 CSpline1DInterpolant &c);
  static void Spline1DGridDiffCubic(double cx[], double cy[], const int n,
                                    const int boundltype, const double boundl,
                                    const int boundrtype, const double boundr,
                                    double d[]);
  static void Spline1DGridDiff2Cubic(double cx[], double cy[], const int n,
                                     const int boundltype, const double boundl,
                                     const int boundrtype, const double boundr,
                                     double d1[], double d2[]);
  static void Spline1DConvCubic(double cx[], double cy[], const int n,
                                const int boundltype, const double boundl,
                                const int boundrtype, const double boundr,
                                double cx2[], const int n2, double y2[]);
  static void Spline1DConvDiffCubic(double cx[], double cy[], const int n,
                                    const int boundltype, const double boundl,
                                    const int boundrtype, const double boundr,
                                    double cx2[], const int n2, double y2[],
                                    double d2[]);
  static void Spline1DConvDiff2Cubic(double cx[], double cy[], const int n,
                                     const int boundltype, const double boundl,
                                     const int boundrtype, const double boundr,
                                     double cx2[], const int n2, double y2[],
                                     double d2[], double dd2[]);
  static void Spline1DBuildCatmullRom(double cx[], double cy[], const int n,
                                      const int boundtype, const double tension,
                                      CSpline1DInterpolant &c);
  static void Spline1DBuildHermite(double cx[], double cy[], double cd[],
                                   const int n, CSpline1DInterpolant &c);
  static void Spline1DBuildAkima(double cx[], double cy[], const int n,
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
  static void Spline1DConvDiffInternal(double xold[], double yold[],
                                       double dold[], const int n, double x2[],
                                       const int n2, double y[],
                                       const bool needy, double d1[],
                                       const bool needd1, double d2[],
                                       const bool needd2);
  static void HeapSortDPoints(double x[], double y[], double d[], const int n);
};

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

  double m_s;
  double m_bndl;
  double m_bndu;
  double m_tasky;
  double m_w;
  double m_x;
  double m_c;
  double m_g;

  CMatrixDouble m_taskx;
  CMatrixDouble m_h;

  CLSFitState(void);
  ~CLSFitState(void);

  void Copy(CLSFitState &obj);
};

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

class CLSFit {
private:
  static void Spline1DFitInternal(const int st, double cx[], double cy[],
                                  double cw[], const int n, double cxc[],
                                  double cyc[], int dc[], const int k,
                                  const int m, int &info,
                                  CSpline1DInterpolant &s,
                                  CSpline1DFitReport &rep);
  static void LSFitLinearInternal(double y[], double w[],
                                  CMatrixDouble &fmatrix, const int n,
                                  const int m, int &info, double c[],
                                  CLSFitReport &rep);
  static void LSFitClearRequestFields(CLSFitState &state);
  static void BarycentricCalcBasis(CBarycentricInterpolant &b, const double t,
                                   double y[]);
  static void InternalChebyshevFit(double x[], double y[], double w[],
                                   const int n, double cxc[], double cyc[],
                                   int dc[], const int k, const int m,
                                   int &info, double c[], CLSFitReport &rep);
  static void BarycentricFitWCFixedD(double cx[], double cy[], double cw[],
                                     const int n, double cxc[], double cyc[],
                                     int dc[], const int k, const int m,
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

  static void PolynomialFit(double x[], double y[], const int n, const int m,
                            int &info, CBarycentricInterpolant &p,
                            CPolynomialFitReport &rep);
  static void PolynomialFitWC(double cx[], double cy[], double cw[],
                              const int n, double cxc[], double cyc[], int dc[],
                              const int k, const int m, int &info,
                              CBarycentricInterpolant &p,
                              CPolynomialFitReport &rep);
  static void BarycentricFitFloaterHormannWC(double x[], double y[], double w[],
                                             const int n, double xc[],
                                             double yc[], int dc[], const int k,
                                             const int m, int &info,
                                             CBarycentricInterpolant &b,
                                             CBarycentricFitReport &rep);
  static void BarycentricFitFloaterHormann(double x[], double y[], const int n,
                                           const int m, int &info,
                                           CBarycentricInterpolant &b,
                                           CBarycentricFitReport &rep);
  static void Spline1DFitPenalized(double cx[], double cy[], const int n,
                                   const int m, const double rho, int &info,
                                   CSpline1DInterpolant &s,
                                   CSpline1DFitReport &rep);
  static void Spline1DFitPenalizedW(double cx[], double cy[], double cw[],
                                    const int n, const int m, double rho,
                                    int &info, CSpline1DInterpolant &s,
                                    CSpline1DFitReport &rep);
  static void Spline1DFitCubicWC(double x[], double y[], double w[],
                                 const int n, double xc[], double yc[],
                                 int dc[], const int k, const int m, int &info,
                                 CSpline1DInterpolant &s,
                                 CSpline1DFitReport &rep);
  static void Spline1DFitHermiteWC(double x[], double y[], double w[],
                                   const int n, double xc[], double yc[],
                                   int dc[], const int k, const int m,
                                   int &info, CSpline1DInterpolant &s,
                                   CSpline1DFitReport &rep);
  static void Spline1DFitCubic(double x[], double y[], const int n, const int m,
                               int &info, CSpline1DInterpolant &s,
                               CSpline1DFitReport &rep);
  static void Spline1DFitHermite(double x[], double y[], const int n,
                                 const int m, int &info,
                                 CSpline1DInterpolant &s,
                                 CSpline1DFitReport &rep);
  static void LSFitLinearW(double y[], double w[], CMatrixDouble &fmatrix,
                           const int n, const int m, int &info, double c[],
                           CLSFitReport &rep);
  static void LSFitLinearWC(double cy[], double w[], CMatrixDouble &fmatrix,
                            CMatrixDouble &ccmatrix, const int n, const int m,
                            const int k, int &info, double c[],
                            CLSFitReport &rep);
  static void LSFitLinear(double y[], CMatrixDouble &fmatrix, const int n,
                          const int m, int &info, double c[],
                          CLSFitReport &rep);
  static void LSFitLinearC(double cy[], CMatrixDouble &fmatrix,
                           CMatrixDouble &cmatrix, const int n, const int m,
                           const int k, int &info, double c[],
                           CLSFitReport &rep);
  static void LSFitCreateWF(CMatrixDouble &x, double y[], double w[],
                            double c[], const int n, const int m, const int k,
                            const double diffstep, CLSFitState &state);
  static void LSFitCreateF(CMatrixDouble &x, double y[], double c[],
                           const int n, const int m, const int k,
                           const double diffstep, CLSFitState &state);
  static void LSFitCreateWFG(CMatrixDouble &x, double y[], double w[],
                             double c[], const int n, const int m, const int k,
                             bool cheapfg, CLSFitState &state);
  static void LSFitCreateFG(CMatrixDouble &x, double y[], double c[],
                            const int n, const int m, const int k,
                            const bool cheapfg, CLSFitState &state);
  static void LSFitCreateWFGH(CMatrixDouble &x, double y[], double w[],
                              double c[], const int n, const int m, const int k,
                              CLSFitState &state);
  static void LSFitCreateFGH(CMatrixDouble &x, double y[], double c[],
                             const int n, const int m, const int k,
                             CLSFitState &state);
  static void LSFitSetCond(CLSFitState &state, const double epsf,
                           const double epsx, const int maxits);
  static void LSFitSetStpMax(CLSFitState &state, const double stpmax);
  static void LSFitSetXRep(CLSFitState &state, const bool needxrep);
  static void LSFitSetScale(CLSFitState &state, double s[]);
  static void LSFitSetBC(CLSFitState &state, double bndl[], double bndu[]);
  static void LSFitResults(CLSFitState &state, int &info, double c[],
                           CLSFitReport &rep);
  static void LSFitScaleXY(double x[], double y[], double w[], const int n,
                           double xc[], double yc[], int dc[], const int k,
                           double &xa, double &xb, double &sa, double &sb,
                           double xoriginal[], double yoriginal[]);
  static bool LSFitIteration(CLSFitState &state);
};

class CPSpline2Interpolant {
public:
  int m_n;
  bool m_periodic;
  CSpline1DInterpolant m_x;
  CSpline1DInterpolant m_y;

  double m_p;

  CPSpline2Interpolant(void);
  ~CPSpline2Interpolant(void);

  void Copy(CPSpline2Interpolant &obj);
};

class CPSpline2InterpolantShell {
private:
  CPSpline2Interpolant m_innerobj;

public:
  CPSpline2InterpolantShell(void);
  CPSpline2InterpolantShell(CPSpline2Interpolant &obj);
  ~CPSpline2InterpolantShell(void);

  CPSpline2Interpolant *GetInnerObj(void);
};

class CPSpline3Interpolant {
public:
  int m_n;
  bool m_periodic;
  CSpline1DInterpolant m_x;
  CSpline1DInterpolant m_y;
  CSpline1DInterpolant m_z;

  double m_p;

  CPSpline3Interpolant(void);
  ~CPSpline3Interpolant(void);

  void Copy(CPSpline3Interpolant &obj);
};

class CPSpline3InterpolantShell {
private:
  CPSpline3Interpolant m_innerobj;

public:
  CPSpline3InterpolantShell(void);
  CPSpline3InterpolantShell(CPSpline3Interpolant &obj);
  ~CPSpline3InterpolantShell(void);

  CPSpline3Interpolant *GetInnerObj(void);
};

class CPSpline {
private:
  static void PSpline2Par(CMatrixDouble &xy, const int n, const int pt,
                          double p[]);
  static void PSpline3Par(CMatrixDouble &xy, const int n, const int pt,
                          double p[]);

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
                                      double t[]);
  static void PSpline3ParameterValues(CPSpline3Interpolant &p, int &n,
                                      double t[]);
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

class CSpline2DInterpolant {
public:
  int m_k;

  double m_c;

  CSpline2DInterpolant(void);
  ~CSpline2DInterpolant(void);

  void Copy(CSpline2DInterpolant &obj);
};

class CSpline2DInterpolantShell {
private:
  CSpline2DInterpolant m_innerobj;

public:
  CSpline2DInterpolantShell(void);
  CSpline2DInterpolantShell(CSpline2DInterpolant &obj);
  ~CSpline2DInterpolantShell(void);

  CSpline2DInterpolant *GetInnerObj(void);
};

class CSpline2D {
private:
  static void BicubicCalcDerivatives(CMatrixDouble &a, double x[], double y[],
                                     const int m, const int n,
                                     CMatrixDouble &dx, CMatrixDouble &dy,
                                     CMatrixDouble &dxy);

public:
  CSpline2D(void);
  ~CSpline2D(void);

  static void Spline2DBuildBilinear(double cx[], double cy[], CMatrixDouble &cf,
                                    const int m, const int n,
                                    CSpline2DInterpolant &c);
  static void Spline2DBuildBicubic(double cx[], double cy[], CMatrixDouble &cf,
                                   const int m, const int n,
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

#endif
