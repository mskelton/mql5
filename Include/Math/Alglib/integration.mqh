#ifndef INTEGRATION_H
#define INTEGRATION_H

#include "alglibinternal.mqh"
#include "ap.mqh"
#include "linalg.mqh"
#include "specialfunctions.mqh"

class CGaussQ {
public:
  CGaussQ(void);
  ~CGaussQ(void);

  static void GQGenerateRec(double alpha[], double beta[], const double mu0,
                            const int n, int info, double &x[], double w[]);
  static void GQGenerateGaussLobattoRec(double calpha[], double cbeta[],
                                        const double mu0, const double a,
                                        const double b, int n, int &info,
                                        double x[], double w[]);
  static void GQGenerateGaussRadauRec(double calpha[], double cbeta[],
                                      const double mu0, const double a, int n,
                                      int info, double &x[], double w[]);
  static void GQGenerateGaussLegendre(const int n, int info, double &x[],
                                      double w[]);
  static void GQGenerateGaussJacobi(const int n, const double alpha,
                                    const double beta, int info, double &x[],
                                    double w[]);
  static void GQGenerateGaussLaguerre(const int n, const double alpha, int info,
                                      double &x[], double w[]);
  static void GQGenerateGaussHermite(const int n, int info, double &x[],
                                     double w[]);
};

class CGaussKronrodQ {
public:
  CGaussKronrodQ(void);
  ~CGaussKronrodQ(void);

  static void GKQGenerateRec(double calpha[], double cbeta[], const double mu0,
                             int n, int info, double &x[], double wkronrod[],
                             double wgauss[]);
  static void GKQGenerateGaussLegendre(const int n, int info, double &x[],
                                       double wkronrod[], double wgauss[]);
  static void GKQGenerateGaussJacobi(const int n, const double alpha,
                                     const double beta, int info, double &x[],
                                     double wkronrod[], double wgauss[]);
  static void GKQLegendreCalc(const int n, int info, double &x[],
                              double wkronrod[], double wgauss[]);
  static void GKQLegendreTbl(const int n, double x[], double wkronrod[],
                             double wgauss[], double &eps);
};

class CAutoGKReport {
public:
  int m_terminationtype;
  int m_nfev;
  int m_nintervals;

  CAutoGKReport(void);
  ~CAutoGKReport(void);

  void Copy(CAutoGKReport &obj);
};

class CAutoGKReportShell {
private:
  CAutoGKReport m_innerobj;

public:
  CAutoGKReportShell(void);
  CAutoGKReportShell(CAutoGKReport &obj);
  ~CAutoGKReportShell(void);

  int GetTerminationType(void);
  void SetTerminationType(const int i);
  int GetNFev(void);
  void SetNFev(const int i);
  int GetNIntervals(void);
  void SetNIntervals(const int i);
  CAutoGKReport *GetInnerObj(void);
};

class CAutoGKInternalState {
public:
  double m_a;
  double m_b;
  double m_eps;
  double m_xwidth;
  double m_x;
  double m_f;
  int m_info;
  double m_r;
  int m_heapsize;
  int m_heapwidth;
  int m_heapused;
  double m_sumerr;
  double m_sumabs;
  int m_n;
  RCommState m_rstate;

  double m_qn;
  double m_wg;
  double m_wk;
  double m_wr;

  CMatrixDouble m_heap;

  CAutoGKInternalState(void);
  ~CAutoGKInternalState(void);

  void Copy(CAutoGKInternalState &obj);
};

class CAutoGKState {
public:
  double m_a;
  double m_b;
  double m_alpha;
  double m_beta;
  double m_xwidth;
  double m_x;
  double m_xminusa;
  double m_bminusx;
  bool m_needf;
  double m_f;
  int m_wrappermode;
  double m_v;
  int m_terminationtype;
  int m_nfev;
  int m_nintervals;
  CAutoGKInternalState m_internalstate;
  RCommState m_rstate;

  CAutoGKState(void);
  ~CAutoGKState(void);

  void Copy(CAutoGKState &obj);
};

class CAutoGKStateShell {
private:
  CAutoGKState m_innerobj;

public:
  CAutoGKStateShell(void);
  CAutoGKStateShell(CAutoGKState &obj);
  ~CAutoGKStateShell(void);

  bool GetNeedF(void);
  void SetNeedF(const bool b);
  double GetX(void);
  void SetX(const double d);
  double GetXMinusA(void);
  void SetXMinusA(const double d);
  double GetBMinusX(void);
  void SetBMinusX(const double d);
  double GetF(void);
  void SetF(const double d);
  CAutoGKState *GetInnerObj(void);
};

class CAutoGK {
private:
  static void AutoGKInternalPrepare(const double a, const double b,
                                    const double eps, const double xwidth,
                                    CAutoGKInternalState &state);
  static void MHeapPop(CMatrixDouble &heap, const int heapsize,
                       const int heapwidth);
  static void MHeapPush(CMatrixDouble &heap, const int heapsize,
                        const int heapwidth);
  static void MHeapResize(CMatrixDouble &heap, int &heapsize,
                          const int newheapsize, const int heapwidth);
  static bool AutoGKInternalIteration(CAutoGKInternalState &state);

  static void Func_Internal_lbl_rcomm(CAutoGKInternalState &state, int i, int j,
                                      int ns, int info, double c1, double c2,
                                      double intg, double intk, double inta,
                                      double v, double ta, double tb,
                                      double qeps);
  static bool Func_Internal_lbl_5(CAutoGKInternalState &state, int &i, int &j,
                                  int &ns, int &info, double &c1, double &c2,
                                  double &intg, double &intk, double &inta,
                                  double &v, double &ta, double &tb,
                                  double &qeps);
  static bool Func_Internal_lbl_7(CAutoGKInternalState &state, int &i, int &j,
                                  int &ns, int &info, double &c1, double &c2,
                                  double &intg, double &intk, double &inta,
                                  double &v, double &ta, double &tb,
                                  double &qeps);
  static bool Func_Internal_lbl_8(CAutoGKInternalState &state, int &i, int &j,
                                  int &ns, int &info, double &c1, double &c2,
                                  double &intg, double &intk, double &inta,
                                  double &v, double &ta, double &tb,
                                  double &qeps);
  static bool Func_Internal_lbl_11(CAutoGKInternalState &state, int &i, int &j,
                                   int &ns, int &info, double &c1, double &c2,
                                   double &intg, double &intk, double &inta,
                                   double &v, double &ta, double &tb,
                                   double &qeps);
  static bool Func_Internal_lbl_14(CAutoGKInternalState &state, int &i, int &j,
                                   int &ns, int &info, double &c1, double &c2,
                                   double &intg, double &intk, double &inta,
                                   double &v, double &ta, double &tb,
                                   double &qeps);
  static bool Func_Internal_lbl_16(CAutoGKInternalState &state, int &i, int &j,
                                   int &ns, int &info, double &c1, double &c2,
                                   double &intg, double &intk, double &inta,
                                   double &v, double &ta, double &tb,
                                   double &qeps);
  static bool Func_Internal_lbl_19(CAutoGKInternalState &state, int &i, int &j,
                                   int &ns, int &info, double &c1, double &c2,
                                   double &intg, double &intk, double &inta,
                                   double &v, double &ta, double &tb,
                                   double &qeps);

  static void Func_lbl_rcomm(CAutoGKState &state, double s, double tmp,
                             double eps, double a, double b, double x, double t,
                             double alpha, double beta, double v1, double v2);
  static bool Func_lbl_5(CAutoGKState &state, double &s, double &tmp,
                         double &eps, double &a, double &b, double &x,
                         double &t, double &alpha, double &beta, double &v1,
                         double &v2);
  static bool Func_lbl_9(CAutoGKState &state, double &s, double &tmp,
                         double &eps, double &a, double &b, double &x,
                         double &t, double &alpha, double &beta, double &v1,
                         double &v2);
  static bool Func_lbl_11(CAutoGKState &state, double &s, double &tmp,
                          double &eps, double &a, double &b, double &x,
                          double &t, double &alpha, double &beta, double &v1,
                          double &v2);

public:
  static const int m_maxsubintervals;

  CAutoGK(void);
  ~CAutoGK(void);

  static void AutoGKSmooth(const double a, const double b, CAutoGKState &state);
  static void AutoGKSmoothW(const double a, const double b, const double xwidth,
                            CAutoGKState &state);
  static void AutoGKSingular(const double a, const double b, const double alpha,
                             const double beta, CAutoGKState &state);
  static void AutoGKResults(CAutoGKState &state, double &v, CAutoGKReport &rep);
  static bool AutoGKIteration(CAutoGKState &state);
};

#endif
