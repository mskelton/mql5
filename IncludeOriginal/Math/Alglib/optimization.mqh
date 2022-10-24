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

  double m_xk[];
  double m_dk[];
  double m_xn[];
  double m_dn[];
  double m_d[];
  double m_x[];
  double m_yk[];
  double m_s[];
  double m_g[];
  double m_diagh[];
  double m_diaghl2[];
  double m_work0[];
  double m_work1[];

  CMatrixDouble m_vcorr;

  CMinCGState(void);
  ~CMinCGState(void);

  void Copy(CMinCGState &obj);
};

CMinCGState::CMinCGState(void) {
}

CMinCGState::~CMinCGState(void) {
}

void CMinCGState::Copy(CMinCGState &obj) {

  m_n = obj.m_n;
  m_epsg = obj.m_epsg;
  m_epsf = obj.m_epsf;
  m_epsx = obj.m_epsx;
  m_maxits = obj.m_maxits;
  m_stpmax = obj.m_stpmax;
  m_suggestedstep = obj.m_suggestedstep;
  m_xrep = obj.m_xrep;
  m_drep = obj.m_drep;
  m_cgtype = obj.m_cgtype;
  m_prectype = obj.m_prectype;
  m_vcnt = obj.m_vcnt;
  m_diffstep = obj.m_diffstep;
  m_nfev = obj.m_nfev;
  m_mcstage = obj.m_mcstage;
  m_k = obj.m_k;
  m_fold = obj.m_fold;
  m_stp = obj.m_stp;
  m_curstpmax = obj.m_curstpmax;
  m_laststep = obj.m_laststep;
  m_lastscaledstep = obj.m_lastscaledstep;
  m_mcinfo = obj.m_mcinfo;
  m_innerresetneeded = obj.m_innerresetneeded;
  m_terminationneeded = obj.m_terminationneeded;
  m_trimthreshold = obj.m_trimthreshold;
  m_rstimer = obj.m_rstimer;
  m_f = obj.m_f;
  m_needf = obj.m_needf;
  m_needfg = obj.m_needfg;
  m_xupdated = obj.m_xupdated;
  m_algpowerup = obj.m_algpowerup;
  m_lsstart = obj.m_lsstart;
  m_lsend = obj.m_lsend;
  m_repiterationscount = obj.m_repiterationscount;
  m_repnfev = obj.m_repnfev;
  m_repterminationtype = obj.m_repterminationtype;
  m_debugrestartscount = obj.m_debugrestartscount;
  m_fbase = obj.m_fbase;
  m_fm2 = obj.m_fm2;
  m_fm1 = obj.m_fm1;
  m_fp1 = obj.m_fp1;
  m_fp2 = obj.m_fp2;
  m_betahs = obj.m_betahs;
  m_betady = obj.m_betady;
  m_rstate.Copy(obj.m_rstate);
  m_lstate.Copy(obj.m_lstate);

  ArrayCopy(m_xk, obj.m_xk);
  ArrayCopy(m_dk, obj.m_dk);
  ArrayCopy(m_xn, obj.m_xn);
  ArrayCopy(m_dn, obj.m_dn);
  ArrayCopy(m_d, obj.m_d);
  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_yk, obj.m_yk);
  ArrayCopy(m_s, obj.m_s);
  ArrayCopy(m_g, obj.m_g);
  ArrayCopy(m_diagh, obj.m_diagh);
  ArrayCopy(m_diaghl2, obj.m_diaghl2);
  ArrayCopy(m_work0, obj.m_work0);
  ArrayCopy(m_work1, obj.m_work1);

  m_vcorr = obj.m_vcorr;
}

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

CMinCGStateShell::CMinCGStateShell(void) {
}

CMinCGStateShell::CMinCGStateShell(CMinCGState &obj) {

  m_innerobj.Copy(obj);
}

CMinCGStateShell::~CMinCGStateShell(void) {
}

bool CMinCGStateShell::GetNeedF(void) {

  return (m_innerobj.m_needf);
}

void CMinCGStateShell::SetNeedF(const bool b) {

  m_innerobj.m_needf = b;
}

bool CMinCGStateShell::GetNeedFG(void) {

  return (m_innerobj.m_needfg);
}

void CMinCGStateShell::SetNeedFG(const bool b) {

  m_innerobj.m_needfg = b;
}

bool CMinCGStateShell::GetXUpdated(void) {

  return (m_innerobj.m_xupdated);
}

void CMinCGStateShell::SetXUpdated(const bool b) {

  m_innerobj.m_xupdated = b;
}

double CMinCGStateShell::GetF(void) {

  return (m_innerobj.m_f);
}

void CMinCGStateShell::SetF(const double d) {

  m_innerobj.m_f = d;
}

CMinCGState *CMinCGStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMinCGReport {
public:
  int m_iterationscount;
  int m_nfev;
  int m_terminationtype;

  CMinCGReport(void);
  ~CMinCGReport(void);

  void Copy(CMinCGReport &obj);
};

CMinCGReport::CMinCGReport(void) {
}

CMinCGReport::~CMinCGReport(void) {
}

void CMinCGReport::Copy(CMinCGReport &obj) {

  m_iterationscount = obj.m_iterationscount;
  m_nfev = obj.m_nfev;
  m_terminationtype = obj.m_terminationtype;
}

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

CMinCGReportShell::CMinCGReportShell(void) {
}

CMinCGReportShell::CMinCGReportShell(CMinCGReport &obj) {

  m_innerobj.Copy(obj);
}

CMinCGReportShell::~CMinCGReportShell(void) {
}

int CMinCGReportShell::GetIterationsCount(void) {

  return (m_innerobj.m_iterationscount);
}

void CMinCGReportShell::SetIterationsCount(const int i) {

  m_innerobj.m_iterationscount = i;
}

int CMinCGReportShell::GetNFev(void) {

  return (m_innerobj.m_nfev);
}

void CMinCGReportShell::SetNFev(const int i) {

  m_innerobj.m_nfev = i;
}

int CMinCGReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CMinCGReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

CMinCGReport *CMinCGReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMinCG {
private:
  static void ClearRequestFields(CMinCGState &state);
  static void PreconditionedMultiply(CMinCGState &state, double &x[],
                                     double &work0[], double &work1[]);
  static double PreconditionedMultiply2(CMinCGState &state, double &x[],
                                        double &y[], double &work0[],
                                        double &work1[]);
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

  static void MinCGCreate(const int n, double &x[], CMinCGState &state);
  static void MinCGCreateF(const int n, double &x[], const double diffstep,
                           CMinCGState &state);
  static void MinCGSetCond(CMinCGState &state, const double epsg,
                           const double epsf, double epsx, const int maxits);
  static void MinCGSetScale(CMinCGState &state, double &s[]);
  static void MinCGSetXRep(CMinCGState &state, const bool needxrep);
  static void MinCGSetDRep(CMinCGState &state, const bool needdrep);
  static void MinCGSetCGType(CMinCGState &state, int cgtype);
  static void MinCGSetStpMax(CMinCGState &state, const double stpmax);
  static void MinCGSuggestStep(CMinCGState &state, const double stp);
  static void MinCGSetPrecDefault(CMinCGState &state);
  static void MinCGSetPrecDiag(CMinCGState &state, double &d[]);
  static void MinCGSetPrecScale(CMinCGState &state);
  static void MinCGResults(CMinCGState &state, double &x[], CMinCGReport &rep);
  static void MinCGResultsBuf(CMinCGState &state, double &x[],
                              CMinCGReport &rep);
  static void MinCGRestartFrom(CMinCGState &state, double &x[]);
  static void MinCGSetPrecDiagFast(CMinCGState &state, double &d[]);
  static void MinCGSetPrecLowRankFast(CMinCGState &state, double &d1[],
                                      double &c[], CMatrixDouble &v,
                                      const int vcnt);
  static void MinCGSetPrecVarPart(CMinCGState &state, double &d2[]);
  static bool MinCGIteration(CMinCGState &state);
};

const int CMinCG::m_rscountdownlen = 10;
const double CMinCG::m_gtol = 0.3;

CMinCG::CMinCG(void) {
}

CMinCG::~CMinCG(void) {
}

static void CMinCG::MinCGCreate(const int n, double &x[], CMinCGState &state) {

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N too small!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  MinCGInitInternal(n, 0.0, state);

  MinCGRestartFrom(state, x);
}

static void CMinCG::MinCGCreateF(const int n, double &x[],
                                 const double diffstep, CMinCGState &state) {

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N too small!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(diffstep),
                   __FUNCTION__ + ": DiffStep is infinite or NaN!"))
    return;

  if (!CAp::Assert(diffstep > 0.0,
                   __FUNCTION__ + ": DiffStep is non-positive!"))
    return;

  MinCGInitInternal(n, diffstep, state);

  MinCGRestartFrom(state, x);
}

static void CMinCG::MinCGSetCond(CMinCGState &state, const double epsg,
                                 const double epsf, double epsx,
                                 const int maxits) {

  if (!CAp::Assert(CMath::IsFinite(epsg),
                   __FUNCTION__ + ": EpsG is not finite number!"))
    return;

  if (!CAp::Assert(epsg >= 0.0, __FUNCTION__ + ": negative EpsG!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsf),
                   __FUNCTION__ + ": EpsF is not finite number!"))
    return;

  if (!CAp::Assert(epsf >= 0.0, __FUNCTION__ + ": negative EpsF!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsx),
                   __FUNCTION__ + ": EpsX is not finite number!"))
    return;

  if (!CAp::Assert(epsx >= 0.0, __FUNCTION__ + ": negative EpsX!"))
    return;

  if (!CAp::Assert(maxits >= 0, __FUNCTION__ + ": negative MaxIts!"))
    return;

  if (epsg == 0.0 && epsf == 0.0 && epsx == 0.0 && maxits == 0)
    epsx = 1.0E-6;

  state.m_epsg = epsg;
  state.m_epsf = epsf;
  state.m_epsx = epsx;
  state.m_maxits = maxits;
}

static void CMinCG::MinCGSetScale(CMinCGState &state, double &s[]) {

  int i = 0;

  if (!CAp::Assert(CAp::Len(s) >= state.m_n, __FUNCTION__ + ": Length(S)<N"))
    return;
  for (i = 0; i <= state.m_n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(s[i]),
                     __FUNCTION__ + ": S contains infinite or NAN elements"))
      return;

    if (!CAp::Assert(s[i] != 0.0, __FUNCTION__ + ": S contains zero elements"))
      return;
    state.m_s[i] = MathAbs(s[i]);
  }
}

static void CMinCG::MinCGSetXRep(CMinCGState &state, const bool needxrep) {

  state.m_xrep = needxrep;
}

static void CMinCG::MinCGSetDRep(CMinCGState &state, const bool needdrep) {

  state.m_drep = needdrep;
}

static void CMinCG::MinCGSetCGType(CMinCGState &state, int cgtype) {

  if (!CAp::Assert(cgtype >= -1 && cgtype <= 1,
                   __FUNCTION__ + ": incorrect CGType!"))
    return;

  if (cgtype == -1)
    cgtype = 1;

  state.m_cgtype = cgtype;
}

static void CMinCG::MinCGSetStpMax(CMinCGState &state, const double stpmax) {

  if (!CAp::Assert(CMath::IsFinite(stpmax),
                   __FUNCTION__ + ": StpMax is not finite!"))
    return;

  if (!CAp::Assert(stpmax >= 0.0, __FUNCTION__ + ": StpMax<0!"))
    return;

  state.m_stpmax = stpmax;
}

static void CMinCG::MinCGSuggestStep(CMinCGState &state, const double stp) {

  if (!CAp::Assert(CMath::IsFinite(stp),
                   __FUNCTION__ + ": Stp is infinite or NAN"))
    return;

  if (!CAp::Assert(stp >= 0.0, __FUNCTION__ + ": Stp<0"))
    return;

  state.m_suggestedstep = stp;
}

static void CMinCG::MinCGSetPrecDefault(CMinCGState &state) {

  state.m_prectype = 0;
  state.m_innerresetneeded = true;
}

static void CMinCG::MinCGSetPrecDiag(CMinCGState &state, double &d[]) {

  int i = 0;

  if (!CAp::Assert(CAp::Len(d) >= state.m_n, __FUNCTION__ + ": D is too short"))
    return;
  for (i = 0; i <= state.m_n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(d[i]),
                     __FUNCTION__ + ": D contains infinite or NAN elements"))
      return;

    if (!CAp::Assert((double)(d[i]) > 0.0,
                     __FUNCTION__ + ": D contains non-positive elements"))
      return;
  }

  MinCGSetPrecDiagFast(state, d);
}

static void CMinCG::MinCGSetPrecScale(CMinCGState &state) {

  state.m_prectype = 3;
  state.m_innerresetneeded = true;
}

static void CMinCG::MinCGResults(CMinCGState &state, double &x[],
                                 CMinCGReport &rep) {

  ArrayResizeAL(x, 0);

  MinCGResultsBuf(state, x, rep);
}

static void CMinCG::MinCGResultsBuf(CMinCGState &state, double &x[],
                                    CMinCGReport &rep) {

  int i_ = 0;

  if (CAp::Len(x) < state.m_n)
    ArrayResizeAL(x, state.m_n);

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    x[i_] = state.m_xn[i_];

  rep.m_iterationscount = state.m_repiterationscount;
  rep.m_nfev = state.m_repnfev;
  rep.m_terminationtype = state.m_repterminationtype;
}

static void CMinCG::MinCGRestartFrom(CMinCGState &state, double &x[]) {

  int i_ = 0;

  if (!CAp::Assert(CAp::Len(x) >= state.m_n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, state.m_n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    state.m_x[i_] = x[i_];

  MinCGSuggestStep(state, 0.0);

  ArrayResizeAL(state.m_rstate.ia, 2);
  ArrayResizeAL(state.m_rstate.ra, 3);

  state.m_rstate.stage = -1;

  ClearRequestFields(state);
}

static void CMinCG::MinCGSetPrecDiagFast(CMinCGState &state, double &d[]) {

  int i = 0;

  CApServ::RVectorSetLengthAtLeast(state.m_diagh, state.m_n);

  CApServ::RVectorSetLengthAtLeast(state.m_diaghl2, state.m_n);

  state.m_prectype = 2;
  state.m_vcnt = 0;
  state.m_innerresetneeded = true;

  for (i = 0; i <= state.m_n - 1; i++) {
    state.m_diagh[i] = d[i];
    state.m_diaghl2[i] = 0.0;
  }
}

static void CMinCG::MinCGSetPrecLowRankFast(CMinCGState &state, double &d1[],
                                            double &c[], CMatrixDouble &v,
                                            const int vcnt) {

  int i = 0;
  int i_ = 0;
  int j = 0;
  int k = 0;
  int n = 0;
  double t = 0;

  CMatrixDouble b;

  if (vcnt == 0) {

    MinCGSetPrecDiagFast(state, d1);
    return;
  }

  n = state.m_n;
  b.Resize(vcnt, vcnt);

  CApServ::RVectorSetLengthAtLeast(state.m_diagh, n);

  CApServ::RVectorSetLengthAtLeast(state.m_diaghl2, n);

  CApServ::RMatrixSetLengthAtLeast(state.m_vcorr, vcnt, n);
  state.m_prectype = 2;
  state.m_vcnt = vcnt;
  state.m_innerresetneeded = true;

  for (i = 0; i <= n - 1; i++) {
    state.m_diagh[i] = d1[i];
    state.m_diaghl2[i] = 0.0;
  }

  for (i = 0; i <= vcnt - 1; i++) {
    for (j = i; j <= vcnt - 1; j++) {
      t = 0;
      for (k = 0; k <= n - 1; k++)
        t = t + v[i][k] * v[j][k] / d1[k];
      b[i].Set(j, t);
    }
    b[i].Set(i, b[i][i] + 1.0 / c[i]);
  }

  if (!CTrFac::SPDMatrixCholeskyRec(b, 0, vcnt, true, state.m_work0)) {
    state.m_vcnt = 0;
    return;
  }

  for (i = 0; i <= vcnt - 1; i++) {
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_vcorr[i].Set(i_, v[i][i_]);

    for (j = 0; j <= i - 1; j++) {
      t = b[j][i];
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_vcorr[i].Set(i_,
                             state.m_vcorr[i][i_] - t * state.m_vcorr[j][i_]);
    }
    t = 1 / b[i][i];

    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_vcorr[i].Set(i_, t * state.m_vcorr[i][i_]);
  }
}

static void CMinCG::MinCGSetPrecVarPart(CMinCGState &state, double &d2[]) {

  int i = 0;
  int n = 0;

  n = state.m_n;

  for (i = 0; i <= n - 1; i++)
    state.m_diaghl2[i] = d2[i];
}

static void CMinCG::ClearRequestFields(CMinCGState &state) {

  state.m_needf = false;
  state.m_needfg = false;
  state.m_xupdated = false;
  state.m_lsstart = false;
  state.m_lsend = false;
  state.m_algpowerup = false;
}

static void CMinCG::PreconditionedMultiply(CMinCGState &state, double &x[],
                                           double &work0[], double &work1[]) {

  int i = 0;
  int n = 0;
  int vcnt = 0;
  double v = 0;
  int i_ = 0;

  n = state.m_n;
  vcnt = state.m_vcnt;

  if (state.m_prectype == 0)
    return;

  if (state.m_prectype == 3) {
    for (i = 0; i <= n - 1; i++)
      x[i] = x[i] * state.m_s[i] * state.m_s[i];

    return;
  }

  if (!CAp::Assert(state.m_prectype == 2,
                   __FUNCTION__ + ": internal error (unexpected PrecType)"))
    return;

  for (i = 0; i <= n - 1; i++)
    x[i] = x[i] / (state.m_diagh[i] + state.m_diaghl2[i]);

  if (vcnt > 0) {

    for (i = 0; i <= vcnt - 1; i++) {
      v = 0.0;
      for (i_ = 0; i_ <= n - 1; i_++)
        v += state.m_vcorr[i][i_] * x[i_];
      work0[i] = v;
    }

    for (i = 0; i <= n - 1; i++)
      work1[i] = 0;
    for (i = 0; i <= vcnt - 1; i++) {
      v = work0[i];
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_work1[i_] = state.m_work1[i_] + v * state.m_vcorr[i][i_];
    }

    for (i = 0; i <= n - 1; i++)
      x[i] = x[i] - state.m_work1[i] / (state.m_diagh[i] + state.m_diaghl2[i]);
  }
}

static double CMinCG::PreconditionedMultiply2(CMinCGState &state, double &x[],
                                              double &y[], double &work0[],
                                              double &work1[]) {

  double result = 0;
  int i = 0;
  int n = 0;
  int vcnt = 0;
  double v0 = 0;
  double v1 = 0;
  int i_ = 0;

  n = state.m_n;
  vcnt = state.m_vcnt;

  if (state.m_prectype == 0) {
    v0 = 0.0;
    for (i_ = 0; i_ <= n - 1; i_++)
      v0 += x[i_] * y[i_];

    return (v0);
  }

  if (state.m_prectype == 3) {
    result = 0;
    for (i = 0; i <= n - 1; i++)
      result = result + x[i] * state.m_s[i] * state.m_s[i] * y[i];

    return (result);
  }

  if (!CAp::Assert(state.m_prectype == 2,
                   __FUNCTION__ + ": internal error (unexpected PrecType)"))
    return (EMPTY_VALUE);

  result = 0.0;
  for (i = 0; i <= n - 1; i++)
    result = result + x[i] * y[i] / (state.m_diagh[i] + state.m_diaghl2[i]);

  if (vcnt > 0) {

    for (i = 0; i <= n - 1; i++) {
      work0[i] = x[i] / (state.m_diagh[i] + state.m_diaghl2[i]);
      work1[i] = y[i] / (state.m_diagh[i] + state.m_diaghl2[i]);
    }
    for (i = 0; i <= vcnt - 1; i++) {

      v0 = 0.0;
      for (i_ = 0; i_ <= n - 1; i_++)
        v0 += work0[i_] * state.m_vcorr[i][i_];
      v1 = 0.0;
      for (i_ = 0; i_ <= n - 1; i_++)
        v1 += work1[i_] * state.m_vcorr[i][i_];

      result = result - v0 * v1;
    }
  }

  return (result);
}

static void CMinCG::MinCGInitInternal(const int n, const double diffstep,
                                      CMinCGState &state) {

  int i = 0;

  state.m_n = n;
  state.m_diffstep = diffstep;

  MinCGSetCond(state, 0, 0, 0, 0);

  MinCGSetXRep(state, false);

  MinCGSetDRep(state, false);

  MinCGSetStpMax(state, 0);

  MinCGSetCGType(state, -1);

  MinCGSetPrecDefault(state);

  ArrayResizeAL(state.m_xk, n);
  ArrayResizeAL(state.m_dk, n);
  ArrayResizeAL(state.m_xn, n);
  ArrayResizeAL(state.m_dn, n);
  ArrayResizeAL(state.m_x, n);
  ArrayResizeAL(state.m_d, n);
  ArrayResizeAL(state.m_g, n);
  ArrayResizeAL(state.m_work0, n);
  ArrayResizeAL(state.m_work1, n);
  ArrayResizeAL(state.m_yk, n);
  ArrayResizeAL(state.m_s, n);

  for (i = 0; i <= n - 1; i++)
    state.m_s[i] = 1.0;
}

static bool CMinCG::MinCGIteration(CMinCGState &state) {

  int n = 0;
  int i = 0;
  double betak = 0;
  double v = 0;
  double vv = 0;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    i = state.m_rstate.ia[1];
    betak = state.m_rstate.ra[0];
    v = state.m_rstate.ra[1];
    vv = state.m_rstate.ra[2];
  } else {

    n = -983;
    i = -989;
    betak = -834;
    v = 900;
    vv = -287;
  }

  if (state.m_rstate.stage == 0) {

    state.m_needfg = false;

    return (Func_lbl_18(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 1) {

    state.m_fbase = state.m_f;
    i = 0;

    return (Func_lbl_19(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 2) {

    state.m_fm2 = state.m_f;
    state.m_x[i] = v - 0.5 * state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 3;

    Func_lbl_rcomm(state, n, i, betak, v, vv);
    return (true);
  }

  if (state.m_rstate.stage == 3) {

    state.m_fm1 = state.m_f;
    state.m_x[i] = v + 0.5 * state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 4;

    Func_lbl_rcomm(state, n, i, betak, v, vv);
    return (true);
  }

  if (state.m_rstate.stage == 4) {

    state.m_fp1 = state.m_f;
    state.m_x[i] = v + state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 5;

    Func_lbl_rcomm(state, n, i, betak, v, vv);
    return (true);
  }

  if (state.m_rstate.stage == 5) {

    state.m_fp2 = state.m_f;
    state.m_x[i] = v;
    state.m_g[i] =
        (8 * (state.m_fp1 - state.m_fm1) - (state.m_fp2 - state.m_fm2)) /
        (6 * state.m_diffstep * state.m_s[i]);
    i = i + 1;

    return (Func_lbl_19(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 6) {

    state.m_algpowerup = false;

    return (Func_lbl_22(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 7) {

    state.m_xupdated = false;

    return (Func_lbl_24(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 8) {

    state.m_lsstart = false;

    return (Func_lbl_28(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 9) {

    state.m_needfg = false;

    return (Func_lbl_33(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 10) {

    state.m_fbase = state.m_f;
    i = 0;

    return (Func_lbl_34(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 11) {

    state.m_fm2 = state.m_f;
    state.m_x[i] = v - 0.5 * state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 12;

    Func_lbl_rcomm(state, n, i, betak, v, vv);
    return (true);
  }

  if (state.m_rstate.stage == 12) {

    state.m_fm1 = state.m_f;
    state.m_x[i] = v + 0.5 * state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 13;

    Func_lbl_rcomm(state, n, i, betak, v, vv);
    return (true);
  }

  if (state.m_rstate.stage == 13) {

    state.m_fp1 = state.m_f;
    state.m_x[i] = v + state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 14;

    Func_lbl_rcomm(state, n, i, betak, v, vv);
    return (true);
  }

  if (state.m_rstate.stage == 14) {

    state.m_fp2 = state.m_f;
    state.m_x[i] = v;
    state.m_g[i] =
        (8 * (state.m_fp1 - state.m_fm1) - (state.m_fp2 - state.m_fm2)) /
        (6 * state.m_diffstep * state.m_s[i]);
    i = i + 1;

    return (Func_lbl_34(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 15) {

    state.m_lsend = false;

    return (Func_lbl_37(state, n, i, betak, v, vv));
  }

  if (state.m_rstate.stage == 16) {

    state.m_xupdated = false;

    return (Func_lbl_39(state, n, i, betak, v, vv));
  }

  n = state.m_n;
  state.m_repterminationtype = 0;
  state.m_repiterationscount = 0;
  state.m_repnfev = 0;
  state.m_debugrestartscount = 0;

  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_xk[i_] = state.m_x[i_];

  state.m_terminationneeded = false;

  ClearRequestFields(state);

  if (state.m_diffstep != 0.0) {
    state.m_needf = true;
    state.m_rstate.stage = 1;

    Func_lbl_rcomm(state, n, i, betak, v, vv);

    return (true);
  }

  state.m_needfg = true;
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static void CMinCG::Func_lbl_rcomm(CMinCGState &state, int n, int i,
                                   double betak, double v, double vv) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ia[1] = i;
  state.m_rstate.ra[0] = betak;
  state.m_rstate.ra[1] = v;
  state.m_rstate.ra[2] = vv;
}

static bool CMinCG::Func_lbl_18(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  if (!state.m_drep)
    return (Func_lbl_22(state, n, i, betak, v, vv));

  ClearRequestFields(state);

  state.m_algpowerup = true;
  state.m_rstate.stage = 6;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static bool CMinCG::Func_lbl_19(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  if (i > n - 1) {
    state.m_f = state.m_fbase;
    state.m_needf = false;

    return (Func_lbl_18(state, n, i, betak, v, vv));
  }

  v = state.m_x[i];
  state.m_x[i] = v - state.m_diffstep * state.m_s[i];
  state.m_rstate.stage = 2;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static bool CMinCG::Func_lbl_22(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  COptServ::TrimPrepare(state.m_f, state.m_trimthreshold);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_dk[i_] = -state.m_g[i_];

  PreconditionedMultiply(state, state.m_dk, state.m_work0, state.m_work1);

  if (!state.m_xrep)
    return (Func_lbl_24(state, n, i, betak, v, vv));

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 7;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static bool CMinCG::Func_lbl_24(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  if (state.m_terminationneeded) {
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_xn[i_] = state.m_xk[i_];
    state.m_repterminationtype = 8;

    return (false);
  }

  v = 0;
  for (i = 0; i <= n - 1; i++)
    v = v + CMath::Sqr(state.m_g[i] * state.m_s[i]);

  if (MathSqrt(v) <= state.m_epsg) {
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_xn[i_] = state.m_xk[i_];
    state.m_repterminationtype = 4;

    return (false);
  }

  state.m_repnfev = 1;
  state.m_k = 0;
  state.m_fold = state.m_f;

  if (state.m_prectype == 2 || state.m_prectype == 3) {

    v = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      v += state.m_dk[i_] * state.m_dk[i_];
    state.m_laststep = MathSqrt(v);
  } else {

    if (state.m_suggestedstep > 0.0)
      state.m_laststep = state.m_suggestedstep;
    else {

      v = 0.0;
      for (int i_ = 0; i_ <= n - 1; i_++)
        v += state.m_g[i_] * state.m_g[i_];
      v = MathSqrt(v);

      if (state.m_stpmax == 0.0)
        state.m_laststep = MathMin(1.0 / v, 1);
      else
        state.m_laststep = MathMin(1.0 / v, state.m_stpmax);
    }
  }

  state.m_rstimer = m_rscountdownlen;

  return (Func_lbl_26(state, n, i, betak, v, vv));
}

static bool CMinCG::Func_lbl_26(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  state.m_innerresetneeded = false;
  state.m_terminationneeded = false;
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_yk[i_] = -state.m_g[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_d[i_] = state.m_dk[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xk[i_];

  state.m_mcstage = 0;
  state.m_stp = 1.0;

  CLinMin::LinMinNormalized(state.m_d, state.m_stp, n);

  if (state.m_laststep != 0.0)
    state.m_stp = state.m_laststep;
  state.m_curstpmax = state.m_stpmax;

  if (!state.m_drep)
    return (Func_lbl_28(state, n, i, betak, v, vv));

  ClearRequestFields(state);

  state.m_lsstart = true;
  state.m_rstate.stage = 8;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static bool CMinCG::Func_lbl_28(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  if (state.m_terminationneeded) {
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_xn[i_] = state.m_x[i_];
    state.m_repterminationtype = 8;

    return (false);
  }

  CLinMin::MCSrch(n, state.m_x, state.m_f, state.m_g, state.m_d, state.m_stp,
                  state.m_curstpmax, m_gtol, state.m_mcinfo, state.m_nfev,
                  state.m_work0, state.m_lstate, state.m_mcstage);

  return (Func_lbl_30(state, n, i, betak, v, vv));
}

static bool CMinCG::Func_lbl_30(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  if (state.m_mcstage == 0)
    return (Func_lbl_31(state, n, i, betak, v, vv));

  ClearRequestFields(state);

  if ((double)(state.m_diffstep) != 0.0) {
    state.m_needf = true;
    state.m_rstate.stage = 10;

    Func_lbl_rcomm(state, n, i, betak, v, vv);

    return (true);
  }

  state.m_needfg = true;
  state.m_rstate.stage = 9;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static bool CMinCG::Func_lbl_31(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  if (!state.m_drep)
    return (Func_lbl_37(state, n, i, betak, v, vv));

  ClearRequestFields(state);

  state.m_lsend = true;
  state.m_rstate.stage = 15;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static bool CMinCG::Func_lbl_33(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  COptServ::TrimFunction(state.m_f, state.m_g, n, state.m_trimthreshold);

  CLinMin::MCSrch(n, state.m_x, state.m_f, state.m_g, state.m_d, state.m_stp,
                  state.m_curstpmax, m_gtol, state.m_mcinfo, state.m_nfev,
                  state.m_work0, state.m_lstate, state.m_mcstage);

  return (Func_lbl_30(state, n, i, betak, v, vv));
}

static bool CMinCG::Func_lbl_34(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  if (i > n - 1) {
    state.m_f = state.m_fbase;
    state.m_needf = false;

    return (Func_lbl_33(state, n, i, betak, v, vv));
  }

  v = state.m_x[i];
  state.m_x[i] = v - state.m_diffstep * state.m_s[i];
  state.m_rstate.stage = 11;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static bool CMinCG::Func_lbl_37(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xn[i_] = state.m_x[i_];

  if (!state.m_xrep)
    return (Func_lbl_39(state, n, i, betak, v, vv));

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 16;

  Func_lbl_rcomm(state, n, i, betak, v, vv);

  return (true);
}

static bool CMinCG::Func_lbl_39(CMinCGState &state, int &n, int &i,
                                double &betak, double &v, double &vv) {

  if (state.m_terminationneeded) {
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_xn[i_] = state.m_x[i_];
    state.m_repterminationtype = 8;

    return (false);
  }

  if (state.m_mcinfo == 1 && !state.m_innerresetneeded) {

    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_yk[i_] = state.m_yk[i_] + state.m_g[i_];

    vv = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      vv += state.m_yk[i_] * state.m_dk[i_];

    v = PreconditionedMultiply2(state, state.m_g, state.m_g, state.m_work0,
                                state.m_work1);
    state.m_betady = v / vv;

    v = PreconditionedMultiply2(state, state.m_g, state.m_yk, state.m_work0,
                                state.m_work1);
    state.m_betahs = v / vv;

    if (state.m_cgtype == 0)
      betak = state.m_betady;

    if (state.m_cgtype == 1)
      betak = MathMax(0, MathMin(state.m_betady, state.m_betahs));
  } else {

    betak = 0;
    state.m_debugrestartscount = state.m_debugrestartscount + 1;
  }

  if (state.m_repiterationscount > 0 &&
      state.m_repiterationscount % (3 + n) == 0) {

    betak = 0;
  }

  if (state.m_mcinfo == 1 || state.m_mcinfo == 5)
    state.m_rstimer = m_rscountdownlen;
  else
    state.m_rstimer = state.m_rstimer - 1;
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_dn[i_] = -state.m_g[i_];

  PreconditionedMultiply(state, state.m_dn, state.m_work0, state.m_work1);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_dn[i_] = state.m_dn[i_] + betak * state.m_dk[i_];

  state.m_laststep = 0;
  state.m_lastscaledstep = 0.0;
  for (i = 0; i <= n - 1; i++) {
    state.m_laststep = state.m_laststep + CMath::Sqr(state.m_d[i]);
    state.m_lastscaledstep =
        state.m_lastscaledstep + CMath::Sqr(state.m_d[i] / state.m_s[i]);
  }

  state.m_laststep = state.m_stp * MathSqrt(state.m_laststep);
  state.m_lastscaledstep = state.m_stp * MathSqrt(state.m_lastscaledstep);

  state.m_repnfev = state.m_repnfev + state.m_nfev;
  state.m_repiterationscount = state.m_repiterationscount + 1;

  if (state.m_repiterationscount >= state.m_maxits && state.m_maxits > 0) {

    state.m_repterminationtype = 5;

    return (false);
  }

  v = 0;
  for (i = 0; i <= n - 1; i++)
    v = v + CMath::Sqr(state.m_g[i] * state.m_s[i]);

  if (MathSqrt(v) <= state.m_epsg) {

    state.m_repterminationtype = 4;

    return (false);
  }

  if (!state.m_innerresetneeded) {

    if (state.m_fold - state.m_f <=
        state.m_epsf *
            MathMax(MathAbs(state.m_fold), MathMax(MathAbs(state.m_f), 1.0))) {

      state.m_repterminationtype = 1;

      return (false);
    }

    if (state.m_lastscaledstep <= state.m_epsx) {

      state.m_repterminationtype = 2;

      return (false);
    }
  }

  if (state.m_rstimer <= 0) {

    state.m_repterminationtype = 7;

    return (false);
  }

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xk[i_] = state.m_xn[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_dk[i_] = state.m_dn[i_];

  state.m_fold = state.m_f;
  state.m_k = state.m_k + 1;

  return (Func_lbl_26(state, n, i, betak, v, vv));
}

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

  double m_diaghoriginal[];
  double m_diagh[];
  double m_x[];
  double m_g[];
  double m_xcur[];
  double m_xprev[];
  double m_xstart[];
  double m_xend[];
  double m_lastg[];
  int m_ct[];
  double m_xe[];
  bool m_hasbndl[];
  bool m_hasbndu[];
  double m_bndloriginal[];
  double m_bnduoriginal[];
  double m_bndleffective[];
  double m_bndueffective[];
  bool m_activeconstraints[];
  double m_constrainedvalues[];
  double m_transforms[];
  double m_seffective[];
  double m_soriginal[];
  double m_w[];
  double m_tmp0[];
  double m_tmp1[];
  double m_tmp2[];
  double m_r[];

  CMatrixDouble m_ceoriginal;
  CMatrixDouble m_ceeffective;
  CMatrixDouble m_cecurrent;
  CMatrixDouble m_lmmatrix;

  CMinBLEICState(void);
  ~CMinBLEICState(void);

  void Copy(CMinBLEICState &obj);
};

CMinBLEICState::CMinBLEICState(void) {
}

CMinBLEICState::~CMinBLEICState(void) {
}

void CMinBLEICState::Copy(CMinBLEICState &obj) {

  m_nmain = obj.m_nmain;
  m_nslack = obj.m_nslack;
  m_innerepsg = obj.m_innerepsg;
  m_innerepsf = obj.m_innerepsf;
  m_innerepsx = obj.m_innerepsx;
  m_outerepsx = obj.m_outerepsx;
  m_outerepsi = obj.m_outerepsi;
  m_maxits = obj.m_maxits;
  m_xrep = obj.m_xrep;
  m_stpmax = obj.m_stpmax;
  m_diffstep = obj.m_diffstep;
  m_prectype = obj.m_prectype;
  m_f = obj.m_f;
  m_needf = obj.m_needf;
  m_needfg = obj.m_needfg;
  m_xupdated = obj.m_xupdated;
  m_repinneriterationscount = obj.m_repinneriterationscount;
  m_repouteriterationscount = obj.m_repouteriterationscount;
  m_repnfev = obj.m_repnfev;
  m_repterminationtype = obj.m_repterminationtype;
  m_repdebugeqerr = obj.m_repdebugeqerr;
  m_repdebugfs = obj.m_repdebugfs;
  m_repdebugff = obj.m_repdebugff;
  m_repdebugdx = obj.m_repdebugdx;
  m_itsleft = obj.m_itsleft;
  m_trimthreshold = obj.m_trimthreshold;
  m_cecnt = obj.m_cecnt;
  m_cedim = obj.m_cedim;
  m_v0 = obj.m_v0;
  m_v1 = obj.m_v1;
  m_v2 = obj.m_v2;
  m_t = obj.m_t;
  m_errfeas = obj.m_errfeas;
  m_gnorm = obj.m_gnorm;
  m_mpgnorm = obj.m_mpgnorm;
  m_mba = obj.m_mba;
  m_variabletofreeze = obj.m_variabletofreeze;
  m_valuetofreeze = obj.m_valuetofreeze;
  m_fbase = obj.m_fbase;
  m_fm2 = obj.m_fm2;
  m_fm1 = obj.m_fm1;
  m_fp1 = obj.m_fp1;
  m_fp2 = obj.m_fp2;
  m_xm1 = obj.m_xm1;
  m_xp1 = obj.m_xp1;
  m_optdim = obj.m_optdim;
  m_rstate.Copy(obj.m_rstate);
  m_cgstate.Copy(obj.m_cgstate);
  m_cgrep.Copy(obj.m_cgrep);

  ArrayCopy(m_diaghoriginal, obj.m_diaghoriginal);
  ArrayCopy(m_diagh, obj.m_diagh);
  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_g, obj.m_g);
  ArrayCopy(m_xcur, obj.m_xcur);
  ArrayCopy(m_xprev, obj.m_xprev);
  ArrayCopy(m_xstart, obj.m_xstart);
  ArrayCopy(m_xend, obj.m_xend);
  ArrayCopy(m_lastg, obj.m_lastg);
  ArrayCopy(m_ct, obj.m_ct);
  ArrayCopy(m_xe, obj.m_xe);
  ArrayCopy(m_hasbndl, obj.m_hasbndl);
  ArrayCopy(m_hasbndu, obj.m_hasbndu);
  ArrayCopy(m_bndloriginal, obj.m_bndloriginal);
  ArrayCopy(m_bnduoriginal, obj.m_bnduoriginal);
  ArrayCopy(m_bndleffective, obj.m_bndleffective);
  ArrayCopy(m_bndueffective, obj.m_bndueffective);
  ArrayCopy(m_activeconstraints, obj.m_activeconstraints);
  ArrayCopy(m_constrainedvalues, obj.m_constrainedvalues);
  ArrayCopy(m_transforms, obj.m_transforms);
  ArrayCopy(m_seffective, obj.m_seffective);
  ArrayCopy(m_soriginal, obj.m_soriginal);
  ArrayCopy(m_w, obj.m_w);
  ArrayCopy(m_tmp0, obj.m_tmp0);
  ArrayCopy(m_tmp1, obj.m_tmp1);
  ArrayCopy(m_tmp2, obj.m_tmp2);
  ArrayCopy(m_r, obj.m_r);

  m_ceoriginal = obj.m_ceoriginal;
  m_ceeffective = obj.m_ceeffective;
  m_cecurrent = obj.m_cecurrent;
  m_lmmatrix = obj.m_lmmatrix;
}

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

CMinBLEICStateShell::CMinBLEICStateShell(void) {
}

CMinBLEICStateShell::CMinBLEICStateShell(CMinBLEICState &obj) {

  m_innerobj.Copy(obj);
}

CMinBLEICStateShell::~CMinBLEICStateShell(void) {
}

bool CMinBLEICStateShell::GetNeedF(void) {

  return (m_innerobj.m_needf);
}

void CMinBLEICStateShell::SetNeedF(const bool b) {

  m_innerobj.m_needf = b;
}

bool CMinBLEICStateShell::GetNeedFG(void) {

  return (m_innerobj.m_needfg);
}

void CMinBLEICStateShell::SetNeedFG(const bool b) {

  m_innerobj.m_needfg = b;
}

bool CMinBLEICStateShell::GetXUpdated(void) {

  return (m_innerobj.m_xupdated);
}

void CMinBLEICStateShell::SetXUpdated(const bool b) {

  m_innerobj.m_xupdated = b;
}

double CMinBLEICStateShell::GetF(void) {

  return (m_innerobj.m_f);
}

void CMinBLEICStateShell::SetF(const double d) {

  m_innerobj.m_f = d;
}

CMinBLEICState *CMinBLEICStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

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

CMinBLEICReport::CMinBLEICReport(void) {
}

CMinBLEICReport::~CMinBLEICReport(void) {
}

void CMinBLEICReport::Copy(CMinBLEICReport &obj) {

  m_inneriterationscount = obj.m_inneriterationscount;
  m_outeriterationscount = obj.m_outeriterationscount;
  m_nfev = obj.m_nfev;
  m_terminationtype = obj.m_terminationtype;
  m_debugeqerr = obj.m_debugeqerr;
  m_debugfs = obj.m_debugfs;
  m_debugff = obj.m_debugff;
  m_debugdx = obj.m_debugdx;
}

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

CMinBLEICReportShell::CMinBLEICReportShell(void) {
}

CMinBLEICReportShell::CMinBLEICReportShell(CMinBLEICReport &obj) {

  m_innerobj.Copy(obj);
}

CMinBLEICReportShell::~CMinBLEICReportShell(void) {
}

int CMinBLEICReportShell::GetInnerIterationsCount(void) {

  return (m_innerobj.m_inneriterationscount);
}

void CMinBLEICReportShell::SetInnerIterationsCount(const int i) {

  m_innerobj.m_inneriterationscount = i;
}

int CMinBLEICReportShell::GetOuterIterationsCount(void) {

  return (m_innerobj.m_outeriterationscount);
}

void CMinBLEICReportShell::SetOuterIterationsCount(const int i) {

  m_innerobj.m_outeriterationscount = i;
}

int CMinBLEICReportShell::GetNFev(void) {

  return (m_innerobj.m_nfev);
}

void CMinBLEICReportShell::SetNFev(const int i) {

  m_innerobj.m_nfev = i;
}

int CMinBLEICReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CMinBLEICReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

double CMinBLEICReportShell::GetDebugEqErr(void) {

  return (m_innerobj.m_debugeqerr);
}

void CMinBLEICReportShell::SetDebugEqErr(const double d) {

  m_innerobj.m_debugeqerr = d;
}

double CMinBLEICReportShell::GetDebugFS(void) {

  return (m_innerobj.m_debugfs);
}

void CMinBLEICReportShell::SetDebugFS(const double d) {

  m_innerobj.m_debugfs = d;
}

double CMinBLEICReportShell::GetDebugFF(void) {

  return (m_innerobj.m_debugff);
}

void CMinBLEICReportShell::SetDebugFF(const double d) {

  m_innerobj.m_debugff = d;
}

double CMinBLEICReportShell::GetDebugDX(void) {

  return (m_innerobj.m_debugdx);
}

void CMinBLEICReportShell::SetDebugDX(const double d) {

  m_innerobj.m_debugdx = d;
}

CMinBLEICReport *CMinBLEICReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMinBLEIC {
private:
  static void ClearRequestFields(CMinBLEICState &state);
  static void UnscalePoint(CMinBLEICState &state, double &xscaled[],
                           double &xunscaled[]);
  static void ProjectPointAndUnscale(CMinBLEICState &state, double &xscaled[],
                                     double &xunscaled[], double &rscaled[],
                                     double &rnorm2);
  static void ScaleGradientAndExpand(CMinBLEICState &state, double &gunscaled[],
                                     double &gscaled[]);
  static void ModifyTargetFunction(CMinBLEICState &state, double &x[],
                                   double &r[], const double rnorm2, double &f,
                                   double &g[], double &gnorm, double &mpgnorm);
  static bool AdditionalCheckForConstraints(CMinBLEICState &state, double &x[]);
  static void RebuildCEXE(CMinBLEICState &state);
  static void MakeGradientProjection(CMinBLEICState &state, double &pg[]);
  static bool PrepareConstraintMatrix(CMinBLEICState &state, double &x[],
                                      double &g[], double &px[], double &pg[]);
  static void MinBLEICInitInternal(const int n, double &x[],
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

  static void MinBLEICCreate(const int n, double &x[], CMinBLEICState &state);
  static void MinBLEICCreateF(const int n, double &x[], const double diffstep,
                              CMinBLEICState &state);
  static void MinBLEICSetBC(CMinBLEICState &state, double &bndl[],
                            double &bndu[]);
  static void MinBLEICSetLC(CMinBLEICState &state, CMatrixDouble &c, int &ct[],
                            const int k);
  static void MinBLEICSetInnerCond(CMinBLEICState &state, const double epsg,
                                   const double epsf, const double epsx);
  static void MinBLEICSetOuterCond(CMinBLEICState &state, const double epsx,
                                   const double epsi);
  static void MinBLEICSetScale(CMinBLEICState &state, double &s[]);
  static void MinBLEICSetPrecDefault(CMinBLEICState &state);
  static void MinBLEICSetPrecDiag(CMinBLEICState &state, double &d[]);
  static void MinBLEICSetPrecScale(CMinBLEICState &state);
  static void MinBLEICSetMaxIts(CMinBLEICState &state, const int maxits);
  static void MinBLEICSetXRep(CMinBLEICState &state, const bool needxrep);
  static void MinBLEICSetStpMax(CMinBLEICState &state, const double stpmax);
  static void MinBLEICResults(CMinBLEICState &state, double &x[],
                              CMinBLEICReport &rep);
  static void MinBLEICResultsBuf(CMinBLEICState &state, double &x[],
                                 CMinBLEICReport &rep);
  static void MinBLEICRestartFrom(CMinBLEICState &state, double &x[]);
  static bool MinBLEICIteration(CMinBLEICState &state);
};

const double CMinBLEIC::m_svdtol = 100;
const double CMinBLEIC::m_maxouterits = 20;

CMinBLEIC::CMinBLEIC(void) {
}

CMinBLEIC::~CMinBLEIC(void) {
}

static void CMinBLEIC::MinBLEICCreate(const int n, double &x[],
                                      CMinBLEICState &state) {

  CMatrixDouble c;

  int ct[];

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  MinBLEICInitInternal(n, x, 0.0, state);
}

static void CMinBLEIC::MinBLEICCreateF(const int n, double &x[],
                                       const double diffstep,
                                       CMinBLEICState &state) {

  CMatrixDouble c;

  int ct[];

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(diffstep),
                   __FUNCTION__ + ": DiffStep is infinite or NaN!"))
    return;

  if (!CAp::Assert(diffstep > 0.0,
                   __FUNCTION__ + ": DiffStep is non-positive!"))
    return;

  MinBLEICInitInternal(n, x, diffstep, state);
}

static void CMinBLEIC::MinBLEICSetBC(CMinBLEICState &state, double &bndl[],
                                     double &bndu[]) {

  int i = 0;
  int n = 0;

  n = state.m_nmain;

  if (!CAp::Assert(CAp::Len(bndl) >= n, __FUNCTION__ + ": Length(BndL)<N"))
    return;

  if (!CAp::Assert(CAp::Len(bndu) >= n, __FUNCTION__ + ": Length(BndU)<N"))
    return;
  for (i = 0; i <= n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(bndl[i]) ||
                         CInfOrNaN::IsNegativeInfinity(bndl[i]),
                     __FUNCTION__ + ": BndL contains NAN or +INF"))
      return;

    if (!CAp::Assert(CMath::IsFinite(bndu[i]) ||
                         CInfOrNaN::IsPositiveInfinity(bndu[i]),
                     __FUNCTION__ + ": BndU contains NAN or -INF"))
      return;

    state.m_bndloriginal[i] = bndl[i];
    state.m_hasbndl[i] = CMath::IsFinite(bndl[i]);
    state.m_bnduoriginal[i] = bndu[i];
    state.m_hasbndu[i] = CMath::IsFinite(bndu[i]);
  }
}

static void CMinBLEIC::MinBLEICSetLC(CMinBLEICState &state, CMatrixDouble &c,
                                     int &ct[], const int k) {

  int nmain = 0;
  int i = 0;
  int i_ = 0;

  nmain = state.m_nmain;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": K<0"))
    return;

  if (!CAp::Assert(CAp::Cols(c) >= nmain + 1 || k == 0,
                   __FUNCTION__ + ": Cols(C)<N+1"))
    return;

  if (!CAp::Assert(CAp::Rows(c) >= k, __FUNCTION__ + ": Rows(C)<K"))
    return;

  if (!CAp::Assert(CAp::Len(ct) >= k, __FUNCTION__ + ": Length(CT)<K"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(c, k, nmain + 1),
                   __FUNCTION__ + ": C contains infinite or NaN values!"))
    return;

  state.m_cecnt = k;

  CApServ::RMatrixSetLengthAtLeast(state.m_ceoriginal, state.m_cecnt,
                                   nmain + 1);

  CApServ::IVectorSetLengthAtLeast(state.m_ct, state.m_cecnt);

  for (i = 0; i <= k - 1; i++) {
    state.m_ct[i] = ct[i];
    for (i_ = 0; i_ <= nmain; i_++)
      state.m_ceoriginal[i].Set(i_, c[i][i_]);
  }
}

static void CMinBLEIC::MinBLEICSetInnerCond(CMinBLEICState &state,
                                            const double epsg,
                                            const double epsf,
                                            const double epsx) {

  if (!CAp::Assert(CMath::IsFinite(epsg),
                   __FUNCTION__ + ": EpsG is not finite number"))
    return;

  if (!CAp::Assert(epsg >= 0.0, __FUNCTION__ + ": negative EpsG"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsf),
                   __FUNCTION__ + ": EpsF is not finite number"))
    return;

  if (!CAp::Assert(epsf >= 0.0, __FUNCTION__ + ": negative EpsF"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsx),
                   __FUNCTION__ + ": EpsX is not finite number"))
    return;

  if (!CAp::Assert(epsx >= 0.0, __FUNCTION__ + ": negative EpsX"))
    return;

  state.m_innerepsg = epsg;
  state.m_innerepsf = epsf;
  state.m_innerepsx = epsx;
}

static void CMinBLEIC::MinBLEICSetOuterCond(CMinBLEICState &state,
                                            const double epsx,
                                            const double epsi) {

  if (!CAp::Assert(CMath::IsFinite(epsx),
                   __FUNCTION__ + ": EpsX is not finite number"))
    return;

  if (!CAp::Assert(epsx > 0.0, __FUNCTION__ + ": non-positive EpsX"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsi),
                   __FUNCTION__ + ": EpsI is not finite number"))
    return;

  if (!CAp::Assert((double)(epsi) > 0.0, __FUNCTION__ + ": non-positive EpsI"))
    return;

  state.m_outerepsx = epsx;
  state.m_outerepsi = epsi;
}

static void CMinBLEIC::MinBLEICSetScale(CMinBLEICState &state, double &s[]) {

  int i = 0;

  if (!CAp::Assert(CAp::Len(s) >= state.m_nmain,
                   __FUNCTION__ + ": Length(S)<N"))
    return;
  for (i = 0; i <= state.m_nmain - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(s[i]),
                     __FUNCTION__ + ": S contains infinite or NAN elements"))
      return;

    if (!CAp::Assert(s[i] != 0.0, __FUNCTION__ + ": S contains zero elements"))
      return;

    state.m_soriginal[i] = MathAbs(s[i]);
  }
}

static void CMinBLEIC::MinBLEICSetPrecDefault(CMinBLEICState &state) {

  state.m_prectype = 0;
}

static void CMinBLEIC::MinBLEICSetPrecDiag(CMinBLEICState &state, double &d[]) {

  int i = 0;

  if (!CAp::Assert(CAp::Len(d) >= state.m_nmain,
                   __FUNCTION__ + ": D is too short"))
    return;
  for (i = 0; i <= state.m_nmain - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(d[i]),
                     __FUNCTION__ + ": D contains infinite or NAN elements"))
      return;

    if (!CAp::Assert((double)(d[i]) > 0.0,
                     __FUNCTION__ + ": D contains non-positive elements"))
      return;
  }

  CApServ::RVectorSetLengthAtLeast(state.m_diaghoriginal, state.m_nmain);
  state.m_prectype = 2;

  for (i = 0; i <= state.m_nmain - 1; i++)
    state.m_diaghoriginal[i] = d[i];
}

static void CMinBLEIC::MinBLEICSetPrecScale(CMinBLEICState &state) {

  state.m_prectype = 3;
}

static void CMinBLEIC::MinBLEICSetMaxIts(CMinBLEICState &state,
                                         const int maxits) {

  if (!CAp::Assert(maxits >= 0, __FUNCTION__ + ": negative MaxIts!"))
    return;

  state.m_maxits = maxits;
}

static void CMinBLEIC::MinBLEICSetXRep(CMinBLEICState &state,
                                       const bool needxrep) {

  state.m_xrep = needxrep;
}

static void CMinBLEIC::MinBLEICSetStpMax(CMinBLEICState &state,
                                         const double stpmax) {

  if (!CAp::Assert(CMath::IsFinite(stpmax),
                   __FUNCTION__ + ": StpMax is not finite!"))
    return;

  if (!CAp::Assert(stpmax >= 0.0, __FUNCTION__ + ": StpMax<0!"))
    return;

  state.m_stpmax = stpmax;
}

static void CMinBLEIC::MinBLEICResults(CMinBLEICState &state, double &x[],
                                       CMinBLEICReport &rep) {

  ArrayResizeAL(x, 0);

  MinBLEICResultsBuf(state, x, rep);
}

static void CMinBLEIC::MinBLEICResultsBuf(CMinBLEICState &state, double &x[],
                                          CMinBLEICReport &rep) {

  int i = 0;
  int i_ = 0;

  if (CAp::Len(x) < state.m_nmain)
    ArrayResizeAL(x, state.m_nmain);

  rep.m_inneriterationscount = state.m_repinneriterationscount;
  rep.m_outeriterationscount = state.m_repouteriterationscount;
  rep.m_nfev = state.m_repnfev;
  rep.m_terminationtype = state.m_repterminationtype;

  if (state.m_repterminationtype > 0) {
    for (i_ = 0; i_ <= state.m_nmain - 1; i_++)
      x[i_] = state.m_xend[i_];
  } else {
    for (i = 0; i <= state.m_nmain - 1; i++)
      x[i] = CInfOrNaN::NaN();
  }

  rep.m_debugeqerr = state.m_repdebugeqerr;
  rep.m_debugfs = state.m_repdebugfs;
  rep.m_debugff = state.m_repdebugff;
  rep.m_debugdx = state.m_repdebugdx;
}

static void CMinBLEIC::MinBLEICRestartFrom(CMinBLEICState &state, double &x[]) {

  int n = 0;
  int i_ = 0;

  n = state.m_nmain;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_xstart[i_] = x[i_];

  ArrayResizeAL(state.m_rstate.ia, 5);
  ArrayResizeAL(state.m_rstate.ba, 1);
  ArrayResizeAL(state.m_rstate.ra, 2);
  state.m_rstate.stage = -1;

  ClearRequestFields(state);
}

static void CMinBLEIC::ClearRequestFields(CMinBLEICState &state) {

  state.m_needf = false;
  state.m_needfg = false;
  state.m_xupdated = false;
}

static void CMinBLEIC::UnscalePoint(CMinBLEICState &state, double &xscaled[],
                                    double &xunscaled[]) {

  int i = 0;
  double v = 0;

  for (i = 0; i <= state.m_nmain - 1; i++) {
    v = xscaled[i] * state.m_transforms[i];

    if (state.m_hasbndl[i]) {

      if (v < state.m_bndloriginal[i])
        v = state.m_bndloriginal[i];
    }

    if (state.m_hasbndu[i]) {

      if (v > state.m_bnduoriginal[i])
        v = state.m_bnduoriginal[i];
    }
    xunscaled[i] = v;
  }
}

static void CMinBLEIC::ProjectPointAndUnscale(CMinBLEICState &state,
                                              double &xscaled[],
                                              double &xunscaled[],
                                              double &rscaled[],
                                              double &rnorm2) {

  double v = 0;
  int i = 0;
  int nmain = 0;
  int nslack = 0;
  int i_ = 0;

  rnorm2 = 0;
  nmain = state.m_nmain;
  nslack = state.m_nslack;

  for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
    xscaled[i_] = xscaled[i_] - state.m_xe[i_];
  rnorm2 = 0;
  for (i = 0; i <= nmain + nslack - 1; i++)
    rscaled[i] = 0;

  for (i = 0; i <= nmain + nslack - 1; i++) {

    if (state.m_activeconstraints[i]) {
      v = xscaled[i];
      xscaled[i] = 0;
      rscaled[i] = rscaled[i] + v;
      rnorm2 = rnorm2 + CMath::Sqr(v);
    }
  }

  for (i = 0; i <= state.m_cecnt - 1; i++) {
    v = 0.0;
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      v += xscaled[i_] * state.m_cecurrent[i][i_];
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      xscaled[i_] = xscaled[i_] - v * state.m_cecurrent[i][i_];
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      rscaled[i_] = rscaled[i_] + v * state.m_cecurrent[i][i_];
    rnorm2 = rnorm2 + CMath::Sqr(v);
  }
  for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
    xscaled[i_] = xscaled[i_] + state.m_xe[i_];

  UnscalePoint(state, xscaled, xunscaled);
}

static void CMinBLEIC::ScaleGradientAndExpand(CMinBLEICState &state,
                                              double &gunscaled[],
                                              double &gscaled[]) {

  int i = 0;

  for (i = 0; i <= state.m_nmain - 1; i++)
    gscaled[i] = gunscaled[i] * state.m_transforms[i];
  for (i = 0; i <= state.m_nslack - 1; i++)
    gscaled[state.m_nmain + i] = 0;
}

static void CMinBLEIC::ModifyTargetFunction(CMinBLEICState &state, double &x[],
                                            double &r[], const double rnorm2,
                                            double &f, double &g[],
                                            double &gnorm, double &mpgnorm) {

  double v = 0;
  int i = 0;
  int nmain = 0;
  int nslack = 0;
  bool hasconstraints;
  int i_ = 0;

  gnorm = 0;
  mpgnorm = 0;
  nmain = state.m_nmain;
  nslack = state.m_nslack;
  hasconstraints = false;

  v = 0.0;
  for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
    v += g[i_] * g[i_];
  gnorm = MathSqrt(v);

  f = f + rnorm2;
  for (i = 0; i <= nmain + nslack - 1; i++) {

    if (state.m_activeconstraints[i])
      g[i] = 0;
  }
  for (i = 0; i <= state.m_cecnt - 1; i++) {
    v = 0.0;

    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      v += g[i_] * state.m_cecurrent[i][i_];
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      g[i_] = g[i_] - v * state.m_cecurrent[i][i_];
  }
  for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
    g[i_] = g[i_] + 2 * r[i_];

  v = 0.0;
  for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
    v += g[i_] * g[i_];
  mpgnorm = MathSqrt(v);
}

static bool CMinBLEIC::AdditionalCheckForConstraints(CMinBLEICState &state,
                                                     double &x[]) {

  bool result;
  int i = 0;
  int nmain = 0;
  int nslack = 0;

  result = false;
  nmain = state.m_nmain;
  nslack = state.m_nslack;

  for (i = 0; i <= nmain - 1; i++) {

    if (!state.m_activeconstraints[i]) {

      if (state.m_hasbndl[i]) {

        if (x[i] <= state.m_bndleffective[i]) {
          state.m_activeconstraints[i] = true;
          state.m_constrainedvalues[i] = state.m_bndleffective[i];
          result = true;
        }
      }

      if (state.m_hasbndu[i]) {

        if (x[i] >= state.m_bndueffective[i]) {
          state.m_activeconstraints[i] = true;
          state.m_constrainedvalues[i] = state.m_bndueffective[i];
          result = true;
        }
      }
    }
  }
  for (i = 0; i <= nslack - 1; i++) {

    if (!state.m_activeconstraints[nmain + i]) {

      if (x[nmain + i] <= 0.0) {
        state.m_activeconstraints[nmain + i] = true;
        state.m_constrainedvalues[nmain + i] = 0;
        result = true;
      }
    }
  }

  return (result);
}

static void CMinBLEIC::RebuildCEXE(CMinBLEICState &state) {

  int i = 0;
  int j = 0;
  int k = 0;
  int nmain = 0;
  int nslack = 0;
  double v = 0;
  int i_ = 0;

  nmain = state.m_nmain;
  nslack = state.m_nslack;

  CAblas::RMatrixCopy(state.m_cecnt, nmain + nslack + 1, state.m_ceeffective, 0,
                      0, state.m_cecurrent, 0, 0);

  for (i = 0; i <= state.m_cecnt - 1; i++) {

    for (j = 0; j <= nmain + nslack - 1; j++) {

      if (state.m_activeconstraints[j]) {
        state.m_cecurrent[i].Set(nmain + nslack,
                                 state.m_cecurrent[i][nmain + nslack] -
                                     state.m_cecurrent[i][j] *
                                         state.m_constrainedvalues[j]);
        state.m_cecurrent[i].Set(j, 0.0);
      }
    }

    for (k = 0; k <= i - 1; k++) {
      v = 0.0;
      for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
        v += state.m_cecurrent[k][i_] * state.m_cecurrent[i][i_];
      for (i_ = 0; i_ <= nmain + nslack; i_++)
        state.m_cecurrent[i].Set(i_, state.m_cecurrent[i][i_] -
                                         v * state.m_cecurrent[k][i_]);
    }

    v = 0.0;
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      v += state.m_cecurrent[i][i_] * state.m_cecurrent[i][i_];
    v = MathSqrt(v);

    if (v > 10000 * CMath::m_machineepsilon) {
      v = 1 / v;
      for (i_ = 0; i_ <= nmain + nslack; i_++)
        state.m_cecurrent[i].Set(i_, v * state.m_cecurrent[i][i_]);
    } else {
      for (j = 0; j <= nmain + nslack; j++)
        state.m_cecurrent[i].Set(j, 0);
    }
  }

  for (j = 0; j <= nmain + nslack - 1; j++)
    state.m_xe[j] = 0;
  for (i = 0; i <= nmain + nslack - 1; i++) {

    if (state.m_activeconstraints[i])
      state.m_xe[i] = state.m_xe[i] + state.m_constrainedvalues[i];
  }

  for (i = 0; i <= state.m_cecnt - 1; i++) {
    v = state.m_cecurrent[i][nmain + nslack];
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      state.m_xe[i_] = state.m_xe[i_] + v * state.m_cecurrent[i][i_];
  }
}

static void CMinBLEIC::MakeGradientProjection(CMinBLEICState &state,
                                              double &pg[]) {

  int i = 0;
  int nmain = 0;
  int nslack = 0;
  double v = 0;
  int i_ = 0;

  nmain = state.m_nmain;
  nslack = state.m_nslack;
  for (i = 0; i <= nmain + nslack - 1; i++) {

    if (state.m_activeconstraints[i])
      pg[i] = 0;
  }

  for (i = 0; i <= state.m_cecnt - 1; i++) {
    v = 0.0;
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      v += pg[i_] * state.m_cecurrent[i][i_];
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      pg[i_] = pg[i_] - v * state.m_cecurrent[i][i_];
  }
}

static bool CMinBLEIC::PrepareConstraintMatrix(CMinBLEICState &state,
                                               double &x[], double &g[],
                                               double &px[], double &pg[]) {

  int i = 0;
  int nmain = 0;
  int nslack = 0;
  double v = 0;
  double ferr = 0;
  int i_ = 0;

  nmain = state.m_nmain;
  nslack = state.m_nslack;

  AdditionalCheckForConstraints(state, x);

  do {

    RebuildCEXE(state);

    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      px[i_] = x[i_];
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      px[i_] = px[i_] - state.m_xe[i_];
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      pg[i_] = g[i_];
    for (i = 0; i <= nmain + nslack - 1; i++) {

      if (state.m_activeconstraints[i]) {
        px[i] = 0;
        pg[i] = 0;
      }
    }

    for (i = 0; i <= state.m_cecnt - 1; i++) {

      v = 0.0;
      for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
        v += px[i_] * state.m_cecurrent[i][i_];
      for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
        px[i_] = px[i_] - v * state.m_cecurrent[i][i_];

      v = 0.0;
      for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
        v += pg[i_] * state.m_cecurrent[i][i_];
      for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
        pg[i_] = pg[i_] - v * state.m_cecurrent[i][i_];
    }
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      px[i_] = px[i_] + state.m_xe[i_];

  } while (AdditionalCheckForConstraints(state, px));

  ferr = 0;
  for (i = 0; i <= state.m_cecnt - 1; i++) {
    v = 0.0;
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      v += px[i_] * state.m_ceeffective[i][i_];

    v = v - state.m_ceeffective[i][nmain + nslack];
    ferr = MathMax(ferr, MathAbs(v));
  }

  if (ferr <= state.m_outerepsi)
    return (true);

  return (false);
}

static void CMinBLEIC::MinBLEICInitInternal(const int n, double &x[],
                                            const double diffstep,
                                            CMinBLEICState &state) {

  int i = 0;

  CMatrixDouble c;

  int ct[];

  state.m_nmain = n;
  state.m_optdim = 0;
  state.m_diffstep = diffstep;

  ArrayResizeAL(state.m_bndloriginal, n);
  ArrayResizeAL(state.m_bndleffective, n);
  ArrayResizeAL(state.m_hasbndl, n);
  ArrayResizeAL(state.m_bnduoriginal, n);
  ArrayResizeAL(state.m_bndueffective, n);
  ArrayResizeAL(state.m_hasbndu, n);
  ArrayResizeAL(state.m_xstart, n);
  ArrayResizeAL(state.m_soriginal, n);
  ArrayResizeAL(state.m_x, n);
  ArrayResizeAL(state.m_g, n);
  for (i = 0; i <= n - 1; i++) {
    state.m_bndloriginal[i] = CInfOrNaN::NegativeInfinity();
    state.m_hasbndl[i] = false;
    state.m_bnduoriginal[i] = CInfOrNaN::PositiveInfinity();
    state.m_hasbndu[i] = false;
    state.m_soriginal[i] = 1.0;
  }

  MinBLEICSetLC(state, c, ct, 0);

  MinBLEICSetInnerCond(state, 0.0, 0.0, 0.0);

  MinBLEICSetOuterCond(state, 1.0E-6, 1.0E-6);

  MinBLEICSetMaxIts(state, 0);

  MinBLEICSetXRep(state, false);

  MinBLEICSetStpMax(state, 0.0);

  MinBLEICSetPrecDefault(state);

  MinBLEICRestartFrom(state, x);
}

static bool CMinBLEIC::MinBLEICIteration(CMinBLEICState &state) {

  int nmain = 0;
  int nslack = 0;
  int m = 0;
  int i = 0;
  int j = 0;
  double v = 0;
  double vv = 0;
  bool b;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    nmain = state.m_rstate.ia[0];
    nslack = state.m_rstate.ia[1];
    m = state.m_rstate.ia[2];
    i = state.m_rstate.ia[3];
    j = state.m_rstate.ia[4];
    b = state.m_rstate.ba[0];
    v = state.m_rstate.ra[0];
    vv = state.m_rstate.ra[1];
  } else {

    nmain = -983;
    nslack = -989;
    m = -834;
    i = 900;
    j = -287;
    b = false;
    v = 214;
    vv = -338;
  }

  if (state.m_rstate.stage == 0) {

    state.m_needfg = false;

    return (Func_lbl_14(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_rstate.stage == 1) {

    state.m_needf = false;

    return (Func_lbl_14(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_rstate.stage == 2) {

    state.m_needfg = false;

    return (Func_lbl_22(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_rstate.stage == 3) {

    state.m_fbase = state.m_f;
    i = 0;

    return (Func_lbl_23(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_rstate.stage == 4) {

    state.m_fm2 = state.m_f;
    state.m_x[i] = v - 0.5 * state.m_diffstep * state.m_soriginal[i];
    state.m_rstate.stage = 5;

    Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 5) {

    state.m_fm1 = state.m_f;
    state.m_x[i] = v + 0.5 * state.m_diffstep * state.m_soriginal[i];
    state.m_rstate.stage = 6;

    Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 6) {

    state.m_fp1 = state.m_f;
    state.m_x[i] = v + state.m_diffstep * state.m_soriginal[i];
    state.m_rstate.stage = 7;

    Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 7) {

    state.m_fp2 = state.m_f;
    state.m_g[i] =
        (8 * (state.m_fp1 - state.m_fm1) - (state.m_fp2 - state.m_fm2)) /
        (6 * state.m_diffstep * state.m_soriginal[i]);
    state.m_x[i] = v;
    i = i + 1;

    return (Func_lbl_23(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_rstate.stage == 8) {

    state.m_fm1 = state.m_f;
    state.m_xp1 = MathMin(v + state.m_diffstep * state.m_soriginal[i],
                          state.m_bnduoriginal[i]);
    state.m_x[i] = state.m_xp1;
    state.m_rstate.stage = 9;

    Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 9) {

    state.m_fp1 = state.m_f;
    state.m_g[i] = (state.m_fp1 - state.m_fm1) / (state.m_xp1 - state.m_xm1);
    state.m_x[i] = v;
    i = i + 1;

    return (Func_lbl_23(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_rstate.stage == 10) {

    state.m_xupdated = false;

    return (Func_lbl_17(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_rstate.stage == 11) {

    state.m_needfg = false;

    return (Func_lbl_31(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_rstate.stage == 12) {

    state.m_needf = false;

    return (Func_lbl_31(state, nmain, nslack, m, i, j, b, v, vv));
  }

  nmain = state.m_nmain;
  nslack = 0;
  for (i = 0; i <= state.m_cecnt - 1; i++) {

    if (state.m_ct[i] != 0)
      nslack = nslack + 1;
  }

  state.m_nslack = nslack;
  state.m_repterminationtype = 0;
  state.m_repinneriterationscount = 0;
  state.m_repouteriterationscount = 0;
  state.m_repnfev = 0;
  state.m_repdebugeqerr = 0.0;
  state.m_repdebugfs = CInfOrNaN::NaN();
  state.m_repdebugff = CInfOrNaN::NaN();
  state.m_repdebugdx = CInfOrNaN::NaN();

  if (state.m_stpmax != 0.0 && state.m_prectype != 0) {
    state.m_repterminationtype = -10;

    return (false);
  }

  CApServ::RVectorSetLengthAtLeast(state.m_r, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_diagh, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_tmp0, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_tmp1, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_tmp2, nmain + nslack);
  CApServ::RMatrixSetLengthAtLeast(state.m_cecurrent, state.m_cecnt,
                                   nmain + nslack + 1);
  CApServ::BVectorSetLengthAtLeast(state.m_activeconstraints, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_constrainedvalues, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_lastg, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_xe, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_xcur, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_xprev, nmain + nslack);
  CApServ::RVectorSetLengthAtLeast(state.m_xend, nmain);

  if (state.m_optdim != nmain + nslack) {
    for (i = 0; i <= nmain + nslack - 1; i++)
      state.m_tmp1[i] = 0.0;

    CMinCG::MinCGCreate(nmain + nslack, state.m_tmp1, state.m_cgstate);
    state.m_optdim = nmain + nslack;
  }

  CApServ::RVectorSetLengthAtLeast(state.m_transforms, nmain);
  for (i = 0; i <= nmain - 1; i++) {

    if (state.m_prectype == 2) {
      state.m_transforms[i] = 1 / MathSqrt(state.m_diaghoriginal[i]);
      continue;
    }

    if (state.m_prectype == 3) {
      state.m_transforms[i] = state.m_soriginal[i];
      continue;
    }
    state.m_transforms[i] = 1;
  }

  CApServ::RVectorSetLengthAtLeast(state.m_seffective, nmain + nslack);
  for (i = 0; i <= nmain - 1; i++)
    state.m_seffective[i] = state.m_soriginal[i] / state.m_transforms[i];
  for (i = 0; i <= nslack - 1; i++)
    state.m_seffective[nmain + i] = 1;

  CMinCG::MinCGSetScale(state.m_cgstate, state.m_seffective);

  for (i = 0; i <= nmain - 1; i++) {

    if (state.m_hasbndl[i])
      state.m_bndleffective[i] =
          state.m_bndloriginal[i] / state.m_transforms[i];

    if (state.m_hasbndu[i])
      state.m_bndueffective[i] =
          state.m_bnduoriginal[i] / state.m_transforms[i];
  }
  for (i = 0; i <= nmain - 1; i++) {

    if (state.m_hasbndl[i] && state.m_hasbndu[i]) {

      if (state.m_bndleffective[i] > state.m_bndueffective[i]) {
        state.m_repterminationtype = -3;

        return (false);
      }
    }
  }

  CApServ::RMatrixSetLengthAtLeast(state.m_ceeffective, state.m_cecnt,
                                   nmain + nslack + 1);

  m = 0;

  for (i = 0; i <= state.m_cecnt - 1; i++) {

    v = 0;
    for (j = 0; j <= nmain - 1; j++) {
      state.m_ceeffective[i].Set(j, state.m_ceoriginal[i][j] *
                                        state.m_transforms[j]);
      v = MathMax(v, MathAbs(state.m_ceeffective[i][j]));
    }

    if (v == 0.0)
      v = 1;
    for (j = 0; j <= nslack - 1; j++)
      state.m_ceeffective[i].Set(nmain + j, 0.0);
    state.m_ceeffective[i].Set(nmain + nslack, state.m_ceoriginal[i][nmain]);

    if (state.m_ct[i] < 0) {
      state.m_ceeffective[i].Set(nmain + m, v);
      m = m + 1;
    }

    if (state.m_ct[i] > 0) {
      state.m_ceeffective[i].Set(nmain + m, -v);
      m = m + 1;
    }
  }

  for (i = 0; i <= nmain - 1; i++)
    state.m_tmp0[i] = state.m_xstart[i] / state.m_transforms[i];

  m = 0;

  for (i = 0; i <= state.m_cecnt - 1; i++) {
    v = 0.0;
    for (i_ = 0; i_ <= nmain - 1; i_++)
      v += state.m_ceeffective[i][i_] * state.m_tmp0[i_];

    if (state.m_ct[i] < 0) {
      state.m_tmp0[nmain + m] = state.m_ceeffective[i][nmain + nslack] - v;
      m = m + 1;
    }

    if (state.m_ct[i] > 0) {
      state.m_tmp0[nmain + m] = v - state.m_ceeffective[i][nmain + nslack];
      m = m + 1;
    }
  }

  for (i = 0; i <= nmain + nslack - 1; i++)
    state.m_tmp1[i] = 0;
  for (i = 0; i <= nmain + nslack - 1; i++)
    state.m_activeconstraints[i] = false;

  b = PrepareConstraintMatrix(state, state.m_tmp0, state.m_tmp1, state.m_xcur,
                              state.m_tmp2);
  state.m_repdebugeqerr = 0.0;

  for (i = 0; i <= state.m_cecnt - 1; i++) {
    v = 0.0;
    for (i_ = 0; i_ <= nmain + nslack - 1; i_++)
      v += state.m_ceeffective[i][i_] * state.m_xcur[i_];
    state.m_repdebugeqerr =
        state.m_repdebugeqerr +
        CMath::Sqr(v - state.m_ceeffective[i][nmain + nslack]);
  }
  state.m_repdebugeqerr = MathSqrt(state.m_repdebugeqerr);

  if (!b) {
    state.m_repterminationtype = -3;

    return (false);
  }

  UnscalePoint(state, state.m_xcur, state.m_x);
  ClearRequestFields(state);

  if (state.m_diffstep != 0.0) {
    state.m_needf = true;
    state.m_rstate.stage = 1;

    Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

    return (true);
  }

  state.m_needfg = true;
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

  return (true);
}

static void CMinBLEIC::Func_lbl_rcomm(CMinBLEICState &state, int nmain,
                                      int nslack, int m, int i, int j, bool b,
                                      double v, double vv) {

  state.m_rstate.ia[0] = nmain;
  state.m_rstate.ia[1] = nslack;
  state.m_rstate.ia[2] = m;
  state.m_rstate.ia[3] = i;
  state.m_rstate.ia[4] = j;
  state.m_rstate.ba[0] = b;
  state.m_rstate.ra[0] = v;
  state.m_rstate.ra[1] = vv;
}

static bool CMinBLEIC::Func_lbl_14(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  COptServ::TrimPrepare(state.m_f, state.m_trimthreshold);
  state.m_repnfev = state.m_repnfev + 1;
  state.m_repdebugfs = state.m_f;

  state.m_itsleft = state.m_maxits;

  for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
    state.m_xprev[i_] = state.m_xcur[i_];

  return (Func_lbl_15(state, nmain, nslack, m, i, j, b, v, vv));
}

static bool CMinBLEIC::Func_lbl_15(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  if (!CAp::Assert(state.m_prectype == 0 || state.m_stpmax == 0.0,
                   "MinBLEIC: internal error (-10)"))
    return (false);

  for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
    state.m_tmp0[i_] = state.m_xcur[i_];
  for (i = 0; i <= nmain + nslack - 1; i++) {
    state.m_tmp1[i] = 0;
    state.m_activeconstraints[i] = false;
  }

  if (!PrepareConstraintMatrix(state, state.m_tmp0, state.m_tmp1, state.m_xcur,
                               state.m_tmp2)) {
    state.m_repterminationtype = -3;

    return (false);
  }
  for (i = 0; i <= nmain + nslack - 1; i++)
    state.m_activeconstraints[i] = false;
  RebuildCEXE(state);

  CMinCG::MinCGRestartFrom(state.m_cgstate, state.m_xcur);

  CMinCG::MinCGSetCond(state.m_cgstate, state.m_innerepsg, state.m_innerepsf,
                       state.m_innerepsx, state.m_itsleft);

  CMinCG::MinCGSetXRep(state.m_cgstate, state.m_xrep);

  CMinCG::MinCGSetDRep(state.m_cgstate, true);

  CMinCG::MinCGSetStpMax(state.m_cgstate, state.m_stpmax);

  return (Func_lbl_17(state, nmain, nslack, m, i, j, b, v, vv));
}

static bool CMinBLEIC::Func_lbl_16(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  state.m_repdebugeqerr = 0.0;
  for (i = 0; i <= state.m_cecnt - 1; i++) {

    v = 0.0;
    for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
      v += state.m_ceeffective[i][i_] * state.m_xcur[i_];
    state.m_repdebugeqerr =
        state.m_repdebugeqerr +
        CMath::Sqr(v - state.m_ceeffective[i][nmain + nslack]);
  }

  state.m_repdebugeqerr = MathSqrt(state.m_repdebugeqerr);
  state.m_repdebugdx = 0;
  for (i = 0; i <= nmain - 1; i++)
    state.m_repdebugdx =
        state.m_repdebugdx + CMath::Sqr(state.m_xcur[i] - state.m_xstart[i]);
  state.m_repdebugdx = MathSqrt(state.m_repdebugdx);

  return (false);
}

static bool CMinBLEIC::Func_lbl_17(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  if (!CMinCG::MinCGIteration(state.m_cgstate))
    return (Func_lbl_18(state, nmain, nslack, m, i, j, b, v, vv));

  if (state.m_cgstate.m_algpowerup) {
    for (i = 0; i <= nmain + nslack - 1; i++)
      state.m_activeconstraints[i] = false;

    do {

      RebuildCEXE(state);
      for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
        state.m_tmp1[i_] = state.m_cgstate.m_g[i_];

      MakeGradientProjection(state, state.m_tmp1);
      b = false;
      for (i = 0; i <= nmain - 1; i++) {

        if (!state.m_activeconstraints[i]) {

          if (state.m_hasbndl[i]) {

            if (state.m_cgstate.m_x[i] == state.m_bndleffective[i] &&
                state.m_tmp1[i] >= 0.0) {

              state.m_activeconstraints[i] = true;
              state.m_constrainedvalues[i] = state.m_bndleffective[i];
              b = true;
            }
          }

          if (state.m_hasbndu[i]) {

            if (state.m_cgstate.m_x[i] == state.m_bndueffective[i] &&
                state.m_tmp1[i] <= 0.0) {

              state.m_activeconstraints[i] = true;
              state.m_constrainedvalues[i] = state.m_bndueffective[i];
              b = true;
            }
          }
        }
      }
      for (i = 0; i <= nslack - 1; i++) {

        if (!state.m_activeconstraints[nmain + i]) {

          if (state.m_cgstate.m_x[nmain + i] == 0.0 &&
              state.m_tmp1[nmain + i] >= 0.0) {

            state.m_activeconstraints[nmain + i] = true;
            state.m_constrainedvalues[nmain + i] = 0;
            b = true;
          }
        }
      }
    } while (b);

    for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
      state.m_cgstate.m_g[i_] = state.m_tmp1[i_];

    return (Func_lbl_17(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_cgstate.m_lsstart) {

    state.m_variabletofreeze = -1;

    if ((double)(state.m_cgstate.m_curstpmax) == 0.0)
      state.m_cgstate.m_curstpmax = 1.0E50;
    for (i = 0; i <= nmain - 1; i++) {

      if (state.m_hasbndl[i] && state.m_cgstate.m_d[i] < 0.0) {

        v = state.m_cgstate.m_curstpmax;
        vv = state.m_cgstate.m_x[i] - state.m_bndleffective[i];

        if (vv < 0.0)
          vv = 0;
        state.m_cgstate.m_curstpmax = CApServ::SafeMinPosRV(
            vv, -state.m_cgstate.m_d[i], state.m_cgstate.m_curstpmax);

        if (state.m_cgstate.m_curstpmax < v) {
          state.m_variabletofreeze = i;
          state.m_valuetofreeze = state.m_bndleffective[i];
        }
      }

      if (state.m_hasbndu[i] && state.m_cgstate.m_d[i] > 0.0) {

        v = state.m_cgstate.m_curstpmax;
        vv = state.m_bndueffective[i] - state.m_cgstate.m_x[i];

        if (vv < 0.0)
          vv = 0;
        state.m_cgstate.m_curstpmax = CApServ::SafeMinPosRV(
            vv, state.m_cgstate.m_d[i], state.m_cgstate.m_curstpmax);

        if (state.m_cgstate.m_curstpmax < v) {
          state.m_variabletofreeze = i;
          state.m_valuetofreeze = state.m_bndueffective[i];
        }
      }
    }
    for (i = 0; i <= nslack - 1; i++) {

      if (state.m_cgstate.m_d[nmain + i] < 0.0) {

        v = state.m_cgstate.m_curstpmax;
        vv = state.m_cgstate.m_x[nmain + i];

        if (vv < 0.0)
          vv = 0;
        state.m_cgstate.m_curstpmax = CApServ::SafeMinPosRV(
            vv, -state.m_cgstate.m_d[nmain + i], state.m_cgstate.m_curstpmax);

        if (state.m_cgstate.m_curstpmax < v) {
          state.m_variabletofreeze = nmain + i;
          state.m_valuetofreeze = 0;
        }
      }
    }

    if (state.m_cgstate.m_curstpmax == 0.0) {

      state.m_activeconstraints[state.m_variabletofreeze] = true;
      state.m_constrainedvalues[state.m_variabletofreeze] =
          state.m_valuetofreeze;
      state.m_cgstate.m_x[state.m_variabletofreeze] = state.m_valuetofreeze;
      state.m_cgstate.m_terminationneeded = true;
    }

    return (Func_lbl_17(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_cgstate.m_lsend) {

    b = state.m_cgstate.m_stp >= state.m_cgstate.m_curstpmax &&
        state.m_variabletofreeze >= 0;

    if (b) {
      state.m_activeconstraints[state.m_variabletofreeze] = true;
      state.m_constrainedvalues[state.m_variabletofreeze] =
          state.m_valuetofreeze;
    }

    b = b || AdditionalCheckForConstraints(state, state.m_cgstate.m_x);

    if (b) {

      for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
        state.m_tmp0[i_] = state.m_cgstate.m_x[i_];
      for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
        state.m_tmp1[i_] = state.m_lastg[i_];

      if (!PrepareConstraintMatrix(state, state.m_tmp0, state.m_tmp1,
                                   state.m_cgstate.m_x, state.m_cgstate.m_g)) {
        state.m_repterminationtype = -3;

        return (false);
      }
      state.m_cgstate.m_innerresetneeded = true;
    }

    return (Func_lbl_17(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (!state.m_cgstate.m_needfg)
    return (Func_lbl_19(state, nmain, nslack, m, i, j, b, v, vv));

  for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
    state.m_tmp1[i_] = state.m_cgstate.m_x[i_];

  ProjectPointAndUnscale(state, state.m_tmp1, state.m_x, state.m_r, vv);

  ClearRequestFields(state);

  if (state.m_diffstep != 0.0) {

    state.m_needf = true;
    state.m_rstate.stage = 3;

    Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

    return (true);
  }

  state.m_needfg = true;
  state.m_rstate.stage = 2;

  Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

  return (true);
}

static bool CMinBLEIC::Func_lbl_18(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  CMinCG::MinCGResults(state.m_cgstate, state.m_xcur, state.m_cgrep);

  UnscalePoint(state, state.m_xcur, state.m_xend);

  state.m_repinneriterationscount =
      state.m_repinneriterationscount + state.m_cgrep.m_iterationscount;
  state.m_repouteriterationscount = state.m_repouteriterationscount + 1;
  state.m_repnfev = state.m_repnfev + state.m_cgrep.m_nfev;

  UnscalePoint(state, state.m_xcur, state.m_x);
  ClearRequestFields(state);

  if (state.m_diffstep != 0.0) {

    state.m_needf = true;
    state.m_rstate.stage = 12;

    Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

    return (true);
  }

  state.m_needfg = true;
  state.m_rstate.stage = 11;

  Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

  return (true);
}

static bool CMinBLEIC::Func_lbl_19(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  if (!state.m_cgstate.m_xupdated)
    return (Func_lbl_17(state, nmain, nslack, m, i, j, b, v, vv));

  UnscalePoint(state, state.m_cgstate.m_x, state.m_x);
  state.m_f = state.m_cgstate.m_f;

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 10;

  Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

  return (true);
}

static bool CMinBLEIC::Func_lbl_22(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  if (state.m_f < state.m_trimthreshold) {

    state.m_cgstate.m_f = state.m_f;

    ScaleGradientAndExpand(state, state.m_g, state.m_cgstate.m_g);

    for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
      state.m_lastg[i_] = state.m_cgstate.m_g[i_];

    ModifyTargetFunction(state, state.m_tmp1, state.m_r, vv,
                         state.m_cgstate.m_f, state.m_cgstate.m_g,
                         state.m_gnorm, state.m_mpgnorm);
  } else {

    state.m_cgstate.m_f = state.m_trimthreshold;
    for (i = 0; i <= nmain + nslack - 1; i++)
      state.m_cgstate.m_g[i] = 0.0;
  }

  return (Func_lbl_17(state, nmain, nslack, m, i, j, b, v, vv));
}

static bool CMinBLEIC::Func_lbl_23(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  if (i > nmain - 1) {

    state.m_f = state.m_fbase;
    state.m_needf = false;

    return (Func_lbl_22(state, nmain, nslack, m, i, j, b, v, vv));
  }

  v = state.m_x[i];
  b = false;

  if (state.m_hasbndl[i])
    b = b ||
        v - state.m_diffstep * state.m_soriginal[i] < state.m_bndloriginal[i];

  if (state.m_hasbndu[i])
    b = b ||
        v + state.m_diffstep * state.m_soriginal[i] > state.m_bnduoriginal[i];

  if (b) {

    state.m_xm1 = MathMax(v - state.m_diffstep * state.m_soriginal[i],
                          state.m_bndloriginal[i]);
    state.m_x[i] = state.m_xm1;
    state.m_rstate.stage = 8;

    Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

    return (true);
  }

  state.m_x[i] = v - state.m_diffstep * state.m_soriginal[i];
  state.m_rstate.stage = 4;

  Func_lbl_rcomm(state, nmain, nslack, m, i, j, b, v, vv);

  return (true);
}

static bool CMinBLEIC::Func_lbl_31(CMinBLEICState &state, int &nmain,
                                   int &nslack, int &m, int &i, int &j, bool &b,
                                   double &v, double &vv) {

  state.m_repnfev = state.m_repnfev + 1;
  state.m_repdebugff = state.m_f;

  v = 0;
  for (i = 0; i <= nmain - 1; i++)
    v = v + CMath::Sqr((state.m_xcur[i] - state.m_xprev[i]) /
                       state.m_seffective[i]);
  v = MathSqrt(v);

  if (v <= (double)(state.m_outerepsx)) {
    state.m_repterminationtype = 4;

    return (Func_lbl_16(state, nmain, nslack, m, i, j, b, v, vv));
  }

  if (state.m_maxits > 0) {
    state.m_itsleft = state.m_itsleft - state.m_cgrep.m_iterationscount;

    if (state.m_itsleft <= 0) {
      state.m_repterminationtype = 5;

      return (Func_lbl_16(state, nmain, nslack, m, i, j, b, v, vv));
    }
  }

  if (state.m_repouteriterationscount >= m_maxouterits) {
    state.m_repterminationtype = 5;

    return (Func_lbl_16(state, nmain, nslack, m, i, j, b, v, vv));
  }

  for (int i_ = 0; i_ <= nmain + nslack - 1; i_++)
    state.m_xprev[i_] = state.m_xcur[i_];

  return (Func_lbl_15(state, nmain, nslack, m, i, j, b, v, vv));
}

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

  double m_s[];
  double m_rho[];
  double m_theta[];
  double m_d[];
  double m_work[];
  double m_diagh[];
  double m_autobuf[];
  double m_x[];
  double m_g[];

  CMatrixDouble m_yk;
  CMatrixDouble m_sk;
  CMatrixDouble m_denseh;

  CMinLBFGSState(void);
  ~CMinLBFGSState(void);

  void Copy(CMinLBFGSState &obj);
};

CMinLBFGSState::CMinLBFGSState(void) {
}

CMinLBFGSState::~CMinLBFGSState(void) {
}

void CMinLBFGSState::Copy(CMinLBFGSState &obj) {

  m_n = obj.m_n;
  m_m = obj.m_m;
  m_epsg = obj.m_epsg;
  m_epsf = obj.m_epsf;
  m_epsx = obj.m_epsx;
  m_maxits = obj.m_maxits;
  m_xrep = obj.m_xrep;
  m_stpmax = obj.m_stpmax;
  m_diffstep = obj.m_diffstep;
  m_nfev = obj.m_nfev;
  m_mcstage = obj.m_mcstage;
  m_k = obj.m_k;
  m_q = obj.m_q;
  m_p = obj.m_p;
  m_stp = obj.m_stp;
  m_fold = obj.m_fold;
  m_trimthreshold = obj.m_trimthreshold;
  m_prectype = obj.m_prectype;
  m_gammak = obj.m_gammak;
  m_fbase = obj.m_fbase;
  m_fm2 = obj.m_fm2;
  m_fm1 = obj.m_fm1;
  m_fp1 = obj.m_fp1;
  m_fp2 = obj.m_fp2;
  m_f = obj.m_f;
  m_needf = obj.m_needf;
  m_needfg = obj.m_needfg;
  m_xupdated = obj.m_xupdated;
  m_repiterationscount = obj.m_repiterationscount;
  m_repnfev = obj.m_repnfev;
  m_repterminationtype = obj.m_repterminationtype;
  m_rstate.Copy(obj.m_rstate);
  m_lstate.Copy(obj.m_lstate);

  ArrayCopy(m_s, obj.m_s);
  ArrayCopy(m_rho, obj.m_rho);
  ArrayCopy(m_theta, obj.m_theta);
  ArrayCopy(m_d, obj.m_d);
  ArrayCopy(m_work, obj.m_work);
  ArrayCopy(m_diagh, obj.m_diagh);
  ArrayCopy(m_autobuf, obj.m_autobuf);
  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_g, obj.m_g);

  m_yk = obj.m_yk;
  m_sk = obj.m_sk;
  m_denseh = obj.m_denseh;
}

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

CMinLBFGSStateShell::CMinLBFGSStateShell(void) {
}

CMinLBFGSStateShell::CMinLBFGSStateShell(CMinLBFGSState &obj) {

  m_innerobj.Copy(obj);
}

CMinLBFGSStateShell::~CMinLBFGSStateShell(void) {
}

bool CMinLBFGSStateShell::GetNeedF(void) {

  return (m_innerobj.m_needf);
}

void CMinLBFGSStateShell::SetNeedF(const bool b) {

  m_innerobj.m_needf = b;
}

bool CMinLBFGSStateShell::GetNeedFG(void) {

  return (m_innerobj.m_needfg);
}

void CMinLBFGSStateShell::SetNeedFG(const bool b) {

  m_innerobj.m_needfg = b;
}

bool CMinLBFGSStateShell::GetXUpdated(void) {

  return (m_innerobj.m_xupdated);
}

void CMinLBFGSStateShell::SetXUpdated(const bool b) {

  m_innerobj.m_xupdated = b;
}

double CMinLBFGSStateShell::GetF(void) {

  return (m_innerobj.m_f);
}

void CMinLBFGSStateShell::SetF(const double d) {

  m_innerobj.m_f = d;
}

CMinLBFGSState *CMinLBFGSStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMinLBFGSReport {
public:
  int m_iterationscount;
  int m_nfev;
  int m_terminationtype;

  CMinLBFGSReport(void);
  ~CMinLBFGSReport(void);

  void Copy(CMinLBFGSReport &obj);
};

CMinLBFGSReport::CMinLBFGSReport(void) {
}

CMinLBFGSReport::~CMinLBFGSReport(void) {
}

void CMinLBFGSReport::Copy(CMinLBFGSReport &obj) {

  m_iterationscount = obj.m_iterationscount;
  m_nfev = obj.m_nfev;
  m_terminationtype = obj.m_terminationtype;
}

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

CMinLBFGSReportShell::CMinLBFGSReportShell(void) {
}

CMinLBFGSReportShell::CMinLBFGSReportShell(CMinLBFGSReport &obj) {

  m_innerobj.Copy(obj);
}

CMinLBFGSReportShell::~CMinLBFGSReportShell(void) {
}

int CMinLBFGSReportShell::GetIterationsCount(void) {

  return (m_innerobj.m_iterationscount);
}

void CMinLBFGSReportShell::SetIterationsCount(const int i) {

  m_innerobj.m_iterationscount = i;
}

int CMinLBFGSReportShell::GetNFev(void) {

  return (m_innerobj.m_nfev);
}

void CMinLBFGSReportShell::SetNFev(const int i) {

  m_innerobj.m_nfev = i;
}

int CMinLBFGSReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CMinLBFGSReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

CMinLBFGSReport *CMinLBFGSReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

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

  static void MinLBFGSCreate(const int n, const int m, double &x[],
                             CMinLBFGSState &state);
  static void MinLBFGSCreateF(const int n, const int m, double &x[],
                              const double diffstep, CMinLBFGSState &state);
  static void MinLBFGSSetCond(CMinLBFGSState &state, const double epsg,
                              const double epsf, double epsx, const int maxits);
  static void MinLBFGSSetXRep(CMinLBFGSState &state, const bool needxrep);
  static void MinLBFGSSetStpMax(CMinLBFGSState &state, const double stpmax);
  static void MinLBFGSSetScale(CMinLBFGSState &state, double &s[]);
  static void MinLBFGSCreateX(const int n, const int m, double &x[], int flags,
                              const double diffstep, CMinLBFGSState &state);
  static void MinLBFGSSetPrecDefault(CMinLBFGSState &state);
  static void MinLBFGSSetPrecCholesky(CMinLBFGSState &state, CMatrixDouble &p,
                                      const bool isupper);
  static void MinLBFGSSetPrecDiag(CMinLBFGSState &state, double &d[]);
  static void MinLBFGSSetPrecScale(CMinLBFGSState &state);
  static void MinLBFGSResults(CMinLBFGSState &state, double &x[],
                              CMinLBFGSReport &rep);
  static void MinLBFGSresultsbuf(CMinLBFGSState &state, double &x[],
                                 CMinLBFGSReport &rep);
  static void MinLBFGSRestartFrom(CMinLBFGSState &state, double &x[]);
  static bool MinLBFGSIteration(CMinLBFGSState &state);
};

const double CMinLBFGS::m_gtol = 0.4;

CMinLBFGS::CMinLBFGS(void) {
}

CMinLBFGS::~CMinLBFGS(void) {
}

static void CMinLBFGS::MinLBFGSCreate(const int n, const int m, double &x[],
                                      CMinLBFGSState &state) {

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1"))
    return;

  if (!CAp::Assert(m <= n, __FUNCTION__ + ": M>N"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  MinLBFGSCreateX(n, m, x, 0, 0.0, state);
}

static void CMinLBFGS::MinLBFGSCreateF(const int n, const int m, double &x[],
                                       const double diffstep,
                                       CMinLBFGSState &state) {

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N too small!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M<1"))
    return;

  if (!CAp::Assert(m <= n, __FUNCTION__ + ": M>N"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(diffstep),
                   __FUNCTION__ + ": DiffStep is infinite or NaN!"))
    return;

  if (!CAp::Assert(diffstep > 0.0,
                   __FUNCTION__ + ": DiffStep is non-positive!"))
    return;

  MinLBFGSCreateX(n, m, x, 0, diffstep, state);
}

static void CMinLBFGS::MinLBFGSSetCond(CMinLBFGSState &state, const double epsg,
                                       const double epsf, double epsx,
                                       const int maxits) {

  if (!CAp::Assert(CMath::IsFinite(epsg),
                   __FUNCTION__ + ": EpsG is not finite number!"))
    return;

  if (!CAp::Assert(epsg >= 0.0, __FUNCTION__ + ": negative EpsG!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsf),
                   __FUNCTION__ + ": EpsF is not finite number!"))
    return;

  if (!CAp::Assert(epsf >= 0.0, __FUNCTION__ + ": negative EpsF!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsx),
                   __FUNCTION__ + ": EpsX is not finite number!"))
    return;

  if (!CAp::Assert(epsx >= 0.0, __FUNCTION__ + ": negative EpsX!"))
    return;

  if (!CAp::Assert(maxits >= 0, __FUNCTION__ + ": negative MaxIts!"))
    return;

  if (((epsg == 0.0 && epsf == 0.0) && epsx == 0.0) && maxits == 0)
    epsx = 1.0E-6;

  state.m_epsg = epsg;
  state.m_epsf = epsf;
  state.m_epsx = epsx;
  state.m_maxits = maxits;
}

static void CMinLBFGS::MinLBFGSSetXRep(CMinLBFGSState &state,
                                       const bool needxrep) {

  state.m_xrep = needxrep;
}

static void CMinLBFGS::MinLBFGSSetStpMax(CMinLBFGSState &state,
                                         const double stpmax) {

  if (!CAp::Assert(CMath::IsFinite(stpmax),
                   __FUNCTION__ + ": StpMax is not finite!"))
    return;

  if (!CAp::Assert(stpmax >= 0.0, __FUNCTION__ + ": StpMax<0!"))
    return;

  state.m_stpmax = stpmax;
}

static void CMinLBFGS::MinLBFGSSetScale(CMinLBFGSState &state, double &s[]) {

  int i = 0;

  if (!CAp::Assert(CAp::Len(s) >= state.m_n, __FUNCTION__ + ": Length(S)<N"))
    return;
  for (i = 0; i <= state.m_n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(s[i]),
                     __FUNCTION__ + ": S contains infinite or NAN elements"))
      return;

    if (!CAp::Assert(s[i] != 0.0, __FUNCTION__ + ": S contains zero elements"))
      return;
    state.m_s[i] = MathAbs(s[i]);
  }
}

static void CMinLBFGS::MinLBFGSCreateX(const int n, const int m, double &x[],
                                       int flags, const double diffstep,
                                       CMinLBFGSState &state) {

  bool allocatemem;
  int i = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N too small!"))
    return;

  if (!CAp::Assert(m >= 1, __FUNCTION__ + ": M too small!"))
    return;

  if (!CAp::Assert(m <= n, __FUNCTION__ + ": M too large!"))
    return;

  state.m_diffstep = diffstep;
  state.m_n = n;
  state.m_m = m;
  allocatemem = flags % 2 == 0;
  flags = flags / 2;

  if (allocatemem) {

    ArrayResizeAL(state.m_rho, m);
    ArrayResizeAL(state.m_theta, m);
    state.m_yk.Resize(m, n);
    state.m_sk.Resize(m, n);
    ArrayResizeAL(state.m_d, n);
    ArrayResizeAL(state.m_x, n);
    ArrayResizeAL(state.m_s, n);
    ArrayResizeAL(state.m_g, n);
    ArrayResizeAL(state.m_work, n);
  }

  MinLBFGSSetCond(state, 0, 0, 0, 0);

  MinLBFGSSetXRep(state, false);

  MinLBFGSSetStpMax(state, 0);

  MinLBFGSRestartFrom(state, x);

  for (i = 0; i <= n - 1; i++)
    state.m_s[i] = 1.0;
  state.m_prectype = 0;
}

static void CMinLBFGS::MinLBFGSSetPrecDefault(CMinLBFGSState &state) {

  state.m_prectype = 0;
}

static void CMinLBFGS::MinLBFGSSetPrecCholesky(CMinLBFGSState &state,
                                               CMatrixDouble &p,
                                               const bool isupper) {

  int i = 0;
  double mx = 0;

  if (!CAp::Assert(CApServ::IsFiniteRTrMatrix(p, state.m_n, isupper),
                   __FUNCTION__ + ": P contains infinite or NAN values!"))
    return;

  mx = 0;
  for (i = 0; i <= state.m_n - 1; i++)
    mx = MathMax(mx, MathAbs(p[i][i]));

  if (!CAp::Assert((double)(mx) > 0.0,
                   __FUNCTION__ + ": P is strictly singular!"))
    return;

  if (CAp::Rows(state.m_denseh) < state.m_n ||
      CAp::Cols(state.m_denseh) < state.m_n)
    state.m_denseh.Resize(state.m_n, state.m_n);

  state.m_prectype = 1;

  if (isupper)
    CAblas::RMatrixCopy(state.m_n, state.m_n, p, 0, 0, state.m_denseh, 0, 0);
  else
    CAblas::RMatrixTranspose(state.m_n, state.m_n, p, 0, 0, state.m_denseh, 0,
                             0);
}

static void CMinLBFGS::MinLBFGSSetPrecDiag(CMinLBFGSState &state, double &d[]) {

  int i = 0;

  if (!CAp::Assert(CAp::Len(d) >= state.m_n, __FUNCTION__ + ": D is too short"))
    return;
  for (i = 0; i <= state.m_n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(d[i]),
                     __FUNCTION__ + ": D contains infinite or NAN elements"))
      return;

    if (!CAp::Assert((double)(d[i]) > 0.0,
                     __FUNCTION__ + ": D contains non-positive elements"))
      return;
  }

  CApServ::RVectorSetLengthAtLeast(state.m_diagh, state.m_n);

  state.m_prectype = 2;
  for (i = 0; i <= state.m_n - 1; i++)
    state.m_diagh[i] = d[i];
}

static void CMinLBFGS::MinLBFGSSetPrecScale(CMinLBFGSState &state) {

  state.m_prectype = 3;
}

static void CMinLBFGS::MinLBFGSResults(CMinLBFGSState &state, double &x[],
                                       CMinLBFGSReport &rep) {

  ArrayResizeAL(x, 0);

  MinLBFGSresultsbuf(state, x, rep);
}

static void CMinLBFGS::MinLBFGSresultsbuf(CMinLBFGSState &state, double &x[],
                                          CMinLBFGSReport &rep) {

  int i_ = 0;

  if (CAp::Len(x) < state.m_n)
    ArrayResizeAL(x, state.m_n);

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    x[i_] = state.m_x[i_];

  rep.m_iterationscount = state.m_repiterationscount;
  rep.m_nfev = state.m_repnfev;
  rep.m_terminationtype = state.m_repterminationtype;
}

static void CMinLBFGS::MinLBFGSRestartFrom(CMinLBFGSState &state, double &x[]) {

  int i_ = 0;

  if (!CAp::Assert(CAp::Len(x) >= state.m_n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, state.m_n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    state.m_x[i_] = x[i_];

  ArrayResizeAL(state.m_rstate.ia, 6);
  ArrayResizeAL(state.m_rstate.ra, 2);
  state.m_rstate.stage = -1;

  ClearRequestFields(state);
}

static void CMinLBFGS::ClearRequestFields(CMinLBFGSState &state) {

  state.m_needf = false;
  state.m_needfg = false;
  state.m_xupdated = false;
}

static bool CMinLBFGS::MinLBFGSIteration(CMinLBFGSState &state) {

  int n = 0;
  int m = 0;
  int i = 0;
  int j = 0;
  int ic = 0;
  int mcinfo = 0;
  double v = 0;
  double vv = 0;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    m = state.m_rstate.ia[1];
    i = state.m_rstate.ia[2];
    j = state.m_rstate.ia[3];
    ic = state.m_rstate.ia[4];
    mcinfo = state.m_rstate.ia[5];
    v = state.m_rstate.ra[0];
    vv = state.m_rstate.ra[1];
  } else {

    n = -983;
    m = -989;
    i = -834;
    j = 900;
    ic = -287;
    mcinfo = 364;
    v = 214;
    vv = -338;
  }

  if (state.m_rstate.stage == 0) {

    state.m_needfg = false;

    COptServ::TrimPrepare(state.m_f, state.m_trimthreshold);

    if (!state.m_xrep)
      return (Func_lbl_19(state, n, m, i, j, ic, mcinfo, v, vv));

    ClearRequestFields(state);

    state.m_xupdated = true;
    state.m_rstate.stage = 6;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 1) {

    state.m_fbase = state.m_f;
    i = 0;

    return (Func_lbl_16(state, n, m, i, j, ic, mcinfo, v, vv));
  }

  if (state.m_rstate.stage == 2) {

    state.m_fm2 = state.m_f;
    state.m_x[i] = v - 0.5 * state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 3;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 3) {

    state.m_fm1 = state.m_f;
    state.m_x[i] = v + 0.5 * state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 4;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 4) {

    state.m_fp1 = state.m_f;
    state.m_x[i] = v + state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 5;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 5) {

    state.m_fp2 = state.m_f;
    state.m_x[i] = v;
    state.m_g[i] =
        (8 * (state.m_fp1 - state.m_fm1) - (state.m_fp2 - state.m_fm2)) /
        (6 * state.m_diffstep * state.m_s[i]);
    i = i + 1;

    return (Func_lbl_16(state, n, m, i, j, ic, mcinfo, v, vv));
  }

  if (state.m_rstate.stage == 6) {

    state.m_xupdated = false;

    return (Func_lbl_19(state, n, m, i, j, ic, mcinfo, v, vv));
  }

  if (state.m_rstate.stage == 7) {

    state.m_needfg = false;

    COptServ::TrimFunction(state.m_f, state.m_g, n, state.m_trimthreshold);

    CLinMin::MCSrch(n, state.m_x, state.m_f, state.m_g, state.m_d, state.m_stp,
                    state.m_stpmax, m_gtol, mcinfo, state.m_nfev, state.m_work,
                    state.m_lstate, state.m_mcstage);

    return (Func_lbl_23(state, n, m, i, j, ic, mcinfo, v, vv));
  }

  if (state.m_rstate.stage == 8) {

    state.m_fbase = state.m_f;
    i = 0;

    return (Func_lbl_27(state, n, m, i, j, ic, mcinfo, v, vv));
  }

  if (state.m_rstate.stage == 9) {

    state.m_fm2 = state.m_f;
    state.m_x[i] = v - 0.5 * state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 10;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 10) {

    state.m_fm1 = state.m_f;
    state.m_x[i] = v + 0.5 * state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 11;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 11) {

    state.m_fp1 = state.m_f;
    state.m_x[i] = v + state.m_diffstep * state.m_s[i];
    state.m_rstate.stage = 12;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 12) {

    state.m_fp2 = state.m_f;
    state.m_x[i] = v;
    state.m_g[i] =
        (8 * (state.m_fp1 - state.m_fm1) - (state.m_fp2 - state.m_fm2)) /
        (6 * state.m_diffstep * state.m_s[i]);
    i = i + 1;

    return (Func_lbl_27(state, n, m, i, j, ic, mcinfo, v, vv));
  }

  if (state.m_rstate.stage == 13) {

    state.m_xupdated = false;

    return (Func_lbl_30(state, n, m, i, j, ic, mcinfo, v, vv));
  }

  n = state.m_n;
  m = state.m_m;
  state.m_repterminationtype = 0;
  state.m_repiterationscount = 0;
  state.m_repnfev = 0;

  ClearRequestFields(state);

  if (state.m_diffstep != 0.0) {

    state.m_needf = true;
    state.m_rstate.stage = 1;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  state.m_needfg = true;
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

  return (true);
}

static void CMinLBFGS::Func_lbl_rcomm(CMinLBFGSState &state, int n, int m,
                                      int i, int j, int ic, int mcinfo,
                                      double v, double vv) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ia[1] = m;
  state.m_rstate.ia[2] = i;
  state.m_rstate.ia[3] = j;
  state.m_rstate.ia[4] = ic;
  state.m_rstate.ia[5] = mcinfo;
  state.m_rstate.ra[0] = v;
  state.m_rstate.ra[1] = vv;
}

static bool CMinLBFGS::Func_lbl_16(CMinLBFGSState &state, int &n, int &m,
                                   int &i, int &j, int &ic, int &mcinfo,
                                   double &v, double &vv) {

  if (i > n - 1) {

    state.m_f = state.m_fbase;
    state.m_needf = false;

    COptServ::TrimPrepare(state.m_f, state.m_trimthreshold);

    if (!state.m_xrep)
      return (Func_lbl_19(state, n, m, i, j, ic, mcinfo, v, vv));

    ClearRequestFields(state);

    state.m_xupdated = true;
    state.m_rstate.stage = 6;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  v = state.m_x[i];
  state.m_x[i] = v - state.m_diffstep * state.m_s[i];
  state.m_rstate.stage = 2;

  Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

  return (true);
}

static bool CMinLBFGS::Func_lbl_19(CMinLBFGSState &state, int &n, int &m,
                                   int &i, int &j, int &ic, int &mcinfo,
                                   double &v, double &vv) {

  state.m_repnfev = 1;
  state.m_fold = state.m_f;

  v = 0;
  for (i = 0; i <= n - 1; i++)
    v = v + CMath::Sqr(state.m_g[i] * state.m_s[i]);

  if (MathSqrt(v) <= state.m_epsg) {
    state.m_repterminationtype = 4;

    return (false);
  }

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_d[i_] = -state.m_g[i_];

  if (state.m_prectype == 0) {

    v = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      v += state.m_g[i_] * state.m_g[i_];
    v = MathSqrt(v);

    if (state.m_stpmax == 0.0)
      state.m_stp = MathMin(1.0 / v, 1);
    else
      state.m_stp = MathMin(1.0 / v, state.m_stpmax);
  }

  if (state.m_prectype == 1) {

    CFbls::FblsCholeskySolve(state.m_denseh, 1.0, n, true, state.m_d,
                             state.m_autobuf);
    state.m_stp = 1;
  }

  if (state.m_prectype == 2) {

    for (i = 0; i <= n - 1; i++)
      state.m_d[i] = state.m_d[i] / state.m_diagh[i];
    state.m_stp = 1;
  }

  if (state.m_prectype == 3) {

    for (i = 0; i <= n - 1; i++)
      state.m_d[i] = state.m_d[i] * state.m_s[i] * state.m_s[i];
    state.m_stp = 1;
  }

  state.m_k = 0;

  return (Func_lbl_21(state, n, m, i, j, ic, mcinfo, v, vv));
}

static bool CMinLBFGS::Func_lbl_21(CMinLBFGSState &state, int &n, int &m,
                                   int &i, int &j, int &ic, int &mcinfo,
                                   double &v, double &vv) {

  state.m_p = state.m_k % m;
  state.m_q = MathMin(state.m_k, m - 1);

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_sk[state.m_p].Set(i_, -state.m_x[i_]);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_yk[state.m_p].Set(i_, -state.m_g[i_]);

  state.m_mcstage = 0;

  if (state.m_k != 0)
    state.m_stp = 1.0;

  CLinMin::LinMinNormalized(state.m_d, state.m_stp, n);

  CLinMin::MCSrch(n, state.m_x, state.m_f, state.m_g, state.m_d, state.m_stp,
                  state.m_stpmax, m_gtol, mcinfo, state.m_nfev, state.m_work,
                  state.m_lstate, state.m_mcstage);

  return (Func_lbl_23(state, n, m, i, j, ic, mcinfo, v, vv));
}

static bool CMinLBFGS::Func_lbl_23(CMinLBFGSState &state, int &n, int &m,
                                   int &i, int &j, int &ic, int &mcinfo,
                                   double &v, double &vv) {

  if (state.m_mcstage == 0) {

    if (!state.m_xrep)
      return (Func_lbl_30(state, n, m, i, j, ic, mcinfo, v, vv));

    ClearRequestFields(state);

    state.m_xupdated = true;
    state.m_rstate.stage = 13;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  ClearRequestFields(state);

  if ((double)(state.m_diffstep) != 0.0) {

    state.m_needf = true;
    state.m_rstate.stage = 8;

    Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

    return (true);
  }

  state.m_needfg = true;
  state.m_rstate.stage = 7;

  Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

  return (true);
}

static bool CMinLBFGS::Func_lbl_27(CMinLBFGSState &state, int &n, int &m,
                                   int &i, int &j, int &ic, int &mcinfo,
                                   double &v, double &vv) {

  if (i > n - 1) {

    state.m_f = state.m_fbase;
    state.m_needf = false;

    COptServ::TrimFunction(state.m_f, state.m_g, n, state.m_trimthreshold);

    CLinMin::MCSrch(n, state.m_x, state.m_f, state.m_g, state.m_d, state.m_stp,
                    state.m_stpmax, m_gtol, mcinfo, state.m_nfev, state.m_work,
                    state.m_lstate, state.m_mcstage);

    return (Func_lbl_23(state, n, m, i, j, ic, mcinfo, v, vv));
  }

  v = state.m_x[i];
  state.m_x[i] = v - state.m_diffstep * state.m_s[i];
  state.m_rstate.stage = 9;

  Func_lbl_rcomm(state, n, m, i, j, ic, mcinfo, v, vv);

  return (true);
}

static bool CMinLBFGS::Func_lbl_30(CMinLBFGSState &state, int &n, int &m,
                                   int &i, int &j, int &ic, int &mcinfo,
                                   double &v, double &vv) {

  state.m_repnfev = state.m_repnfev + state.m_nfev;
  state.m_repiterationscount = state.m_repiterationscount + 1;

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_sk[state.m_p].Set(i_, state.m_sk[state.m_p][i_] + state.m_x[i_]);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_yk[state.m_p].Set(i_, state.m_yk[state.m_p][i_] + state.m_g[i_]);

  if (state.m_repiterationscount >= state.m_maxits && state.m_maxits > 0) {

    state.m_repterminationtype = 5;

    return (false);
  }

  v = 0;
  for (i = 0; i <= n - 1; i++)
    v = v + CMath::Sqr(state.m_g[i] * state.m_s[i]);

  if (MathSqrt(v) <= state.m_epsg) {

    state.m_repterminationtype = 4;

    return (false);
  }

  if (state.m_fold - state.m_f <=
      state.m_epsf *
          MathMax(MathAbs(state.m_fold), MathMax(MathAbs(state.m_f), 1.0))) {

    state.m_repterminationtype = 1;

    return (false);
  }

  v = 0;
  for (i = 0; i <= n - 1; i++)
    v = v + CMath::Sqr(state.m_sk[state.m_p][i] / state.m_s[i]);

  if ((double)(MathSqrt(v)) <= (double)(state.m_epsx)) {

    state.m_repterminationtype = 2;

    return (false);
  }

  if (mcinfo != 1) {

    state.m_fold = state.m_f;
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_d[i_] = -state.m_g[i_];
  } else {

    v = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      v += state.m_yk[state.m_p][i_] * state.m_sk[state.m_p][i_];

    vv = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      vv += state.m_yk[state.m_p][i_] * state.m_yk[state.m_p][i_];

    if (v == 0.0 || vv == 0.0) {

      state.m_repterminationtype = -2;

      return (false);
    }

    state.m_rho[state.m_p] = 1 / v;
    state.m_gammak = v / vv;

    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_work[i_] = state.m_g[i_];
    for (i = state.m_k; i >= state.m_k - state.m_q; i--) {
      ic = i % m;
      v = 0.0;
      for (int i_ = 0; i_ <= n - 1; i_++)
        v += state.m_sk[ic][i_] * state.m_work[i_];

      state.m_theta[ic] = v;
      vv = v * state.m_rho[ic];
      for (int i_ = 0; i_ <= n - 1; i_++)
        state.m_work[i_] = state.m_work[i_] - vv * state.m_yk[ic][i_];
    }

    if (state.m_prectype == 0) {

      v = state.m_gammak;
      for (int i_ = 0; i_ <= n - 1; i_++)
        state.m_work[i_] = v * state.m_work[i_];
    }

    if (state.m_prectype == 1) {

      CFbls::FblsCholeskySolve(state.m_denseh, 1, n, true, state.m_work,
                               state.m_autobuf);
    }

    if (state.m_prectype == 2) {

      for (i = 0; i <= n - 1; i++) {
        state.m_work[i] = state.m_work[i] / state.m_diagh[i];
      }
    }

    if (state.m_prectype == 3) {

      for (i = 0; i <= n - 1; i++)
        state.m_work[i] = state.m_work[i] * state.m_s[i] * state.m_s[i];
    }

    for (i = state.m_k - state.m_q; i <= state.m_k; i++) {
      ic = i % m;
      v = 0.0;
      for (int i_ = 0; i_ <= n - 1; i_++)
        v += state.m_yk[ic][i_] * state.m_work[i_];

      vv = state.m_rho[ic] * (-v + state.m_theta[ic]);
      for (int i_ = 0; i_ <= n - 1; i_++) {
        state.m_work[i_] = state.m_work[i_] + vv * state.m_sk[ic][i_];
      }
    }
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_d[i_] = -state.m_work[i_];

    state.m_fold = state.m_f;
    state.m_k = state.m_k + 1;
  }

  return (Func_lbl_21(state, n, m, i, j, ic, mcinfo, v, vv));
}

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

  double m_diaga[];
  double m_b[];
  double m_bndl[];
  double m_bndu[];
  bool m_havebndl[];
  bool m_havebndu[];
  double m_xorigin[];
  double m_startx[];
  double m_xc[];
  double m_gc[];
  int m_activeconstraints[];
  int m_prevactiveconstraints[];
  double m_workbndl[];
  double m_workbndu[];
  double m_tmp0[];
  double m_tmp1[];
  int m_itmp0[];
  int m_p2[];
  double m_bufb[];
  double m_bufx[];

  CMatrixDouble m_densea;
  CMatrixDouble m_bufa;

  CMinQPState(void);
  ~CMinQPState(void);

  void Copy(CMinQPState &obj);
};

CMinQPState::CMinQPState(void) {
}

CMinQPState::~CMinQPState(void) {
}

void CMinQPState::Copy(CMinQPState &obj) {

  m_n = obj.m_n;
  m_algokind = obj.m_algokind;
  m_akind = obj.m_akind;
  m_havex = obj.m_havex;
  m_constterm = obj.m_constterm;
  m_repinneriterationscount = obj.m_repinneriterationscount;
  m_repouteriterationscount = obj.m_repouteriterationscount;
  m_repncholesky = obj.m_repncholesky;
  m_repnmv = obj.m_repnmv;
  m_repterminationtype = obj.m_repterminationtype;
  m_buf.Copy(obj.m_buf);

  ArrayCopy(m_diaga, obj.m_diaga);
  ArrayCopy(m_b, obj.m_b);
  ArrayCopy(m_bndl, obj.m_bndl);
  ArrayCopy(m_bndu, obj.m_bndu);
  ArrayCopy(m_havebndl, obj.m_havebndl);
  ArrayCopy(m_havebndu, obj.m_havebndu);
  ArrayCopy(m_xorigin, obj.m_xorigin);
  ArrayCopy(m_startx, obj.m_startx);
  ArrayCopy(m_xc, obj.m_xc);
  ArrayCopy(m_gc, obj.m_gc);
  ArrayCopy(m_activeconstraints, obj.m_activeconstraints);
  ArrayCopy(m_prevactiveconstraints, obj.m_prevactiveconstraints);
  ArrayCopy(m_workbndl, obj.m_workbndl);
  ArrayCopy(m_workbndu, obj.m_workbndu);
  ArrayCopy(m_tmp0, obj.m_tmp0);
  ArrayCopy(m_tmp1, obj.m_tmp1);
  ArrayCopy(m_itmp0, obj.m_itmp0);
  ArrayCopy(m_p2, obj.m_p2);
  ArrayCopy(m_bufb, obj.m_bufb);
  ArrayCopy(m_bufx, obj.m_bufx);

  m_densea = obj.m_densea;
  m_bufa = obj.m_bufa;
}

class CMinQPStateShell {
private:
  CMinQPState m_innerobj;

public:
  CMinQPStateShell(void);
  CMinQPStateShell(CMinQPState &obj);
  ~CMinQPStateShell(void);

  CMinQPState *GetInnerObj(void);
};

CMinQPStateShell::CMinQPStateShell(void) {
}

CMinQPStateShell::CMinQPStateShell(CMinQPState &obj) {

  m_innerobj.Copy(obj);
}

CMinQPStateShell::~CMinQPStateShell(void) {
}

CMinQPState *CMinQPStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

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

CMinQPReport::CMinQPReport(void) {
}

CMinQPReport::~CMinQPReport(void) {
}

void CMinQPReport::Copy(CMinQPReport &obj) {

  m_inneriterationscount = obj.m_inneriterationscount;
  m_outeriterationscount = obj.m_outeriterationscount;
  m_nmv = obj.m_nmv;
  m_ncholesky = obj.m_ncholesky;
  m_terminationtype = obj.m_terminationtype;
}

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

CMinQPReportShell::CMinQPReportShell(void) {
}

CMinQPReportShell::CMinQPReportShell(CMinQPReport &obj) {

  m_innerobj.Copy(obj);
}

CMinQPReportShell::~CMinQPReportShell(void) {
}

int CMinQPReportShell::GetInnerIterationsCount(void) {

  return (m_innerobj.m_inneriterationscount);
}

void CMinQPReportShell::SetInnerIterationsCount(const int i) {

  m_innerobj.m_inneriterationscount = i;
}

int CMinQPReportShell::GetOuterIterationsCount(void) {

  return (m_innerobj.m_outeriterationscount);
}

void CMinQPReportShell::SetOuterIterationsCount(const int i) {

  m_innerobj.m_outeriterationscount = i;
}

int CMinQPReportShell::GetNMV(void) {

  return (m_innerobj.m_nmv);
}

void CMinQPReportShell::SetNMV(const int i) {

  m_innerobj.m_nmv = i;
}

int CMinQPReportShell::GetNCholesky(void) {

  return (m_innerobj.m_ncholesky);
}

void CMinQPReportShell::SetNCholesky(const int i) {

  m_innerobj.m_ncholesky = i;
}

int CMinQPReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CMinQPReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

CMinQPReport *CMinQPReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMinQP {
private:
  static void MinQPGrad(CMinQPState &state);
  static double MinQPXTAX(CMinQPState &state, double &x[]);

public:
  CMinQP(void);
  ~CMinQP(void);

  static void MinQPCreate(const int n, CMinQPState &state);
  static void MinQPSetLinearTerm(CMinQPState &state, double &b[]);
  static void MinQPSetQuadraticTerm(CMinQPState &state, CMatrixDouble &a,
                                    const bool isupper);
  static void MinQPSetStartingPoint(CMinQPState &state, double &x[]);
  static void MinQPSetOrigin(CMinQPState &state, double &xorigin[]);
  static void MinQPSetAlgoCholesky(CMinQPState &state);
  static void MinQPSetBC(CMinQPState &state, double &bndl[], double &bndu[]);
  static void MinQPOptimize(CMinQPState &state);
  static void MinQPResults(CMinQPState &state, double &x[], CMinQPReport &rep);
  static void MinQPResultsBuf(CMinQPState &state, double &x[],
                              CMinQPReport &rep);
  static void MinQPSetLinearTermFast(CMinQPState &state, double &b[]);
  static void MinQPSetQuadraticTermFast(CMinQPState &state, CMatrixDouble &a,
                                        const bool isupper, const double s);
  static void MinQPRewriteDiagonal(CMinQPState &state, double &s[]);
  static void MinQPSetStartingPointFast(CMinQPState &state, double &x[]);
  static void MinQPSetOriginFast(CMinQPState &state, double &xorigin[]);
};

CMinQP::CMinQP(void) {
}

CMinQP::~CMinQP(void) {
}

static void CMinQP::MinQPCreate(const int n, CMinQPState &state) {

  int i = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1"))
    return;

  state.m_n = n;
  state.m_akind = -1;
  state.m_repterminationtype = 0;

  ArrayResizeAL(state.m_b, n);
  ArrayResizeAL(state.m_bndl, n);
  ArrayResizeAL(state.m_bndu, n);
  ArrayResizeAL(state.m_workbndl, n);
  ArrayResizeAL(state.m_workbndu, n);
  ArrayResizeAL(state.m_havebndl, n);
  ArrayResizeAL(state.m_havebndu, n);
  ArrayResizeAL(state.m_startx, n);
  ArrayResizeAL(state.m_xorigin, n);
  ArrayResizeAL(state.m_xc, n);
  ArrayResizeAL(state.m_gc, n);

  for (i = 0; i <= n - 1; i++) {
    state.m_b[i] = 0.0;
    state.m_workbndl[i] = CInfOrNaN::NegativeInfinity();
    state.m_workbndu[i] = CInfOrNaN::PositiveInfinity();
    state.m_havebndl[i] = false;
    state.m_havebndu[i] = false;
    state.m_startx[i] = 0.0;
    state.m_xorigin[i] = 0.0;
  }
  state.m_havex = false;

  MinQPSetAlgoCholesky(state);
}

static void CMinQP::MinQPSetLinearTerm(CMinQPState &state, double &b[]) {

  int n = 0;

  n = state.m_n;

  if (!CAp::Assert(CAp::Len(b) >= n, __FUNCTION__ + ": Length(B)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(b, n),
                   __FUNCTION__ + ": B contains infinite or NaN elements"))
    return;

  MinQPSetLinearTermFast(state, b);
}

static void CMinQP::MinQPSetQuadraticTerm(CMinQPState &state, CMatrixDouble &a,
                                          const bool isupper) {

  int n = 0;

  n = state.m_n;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": Rows(A)<N"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": Cols(A)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteRTrMatrix(a, n, isupper),
                   __FUNCTION__ + ": A contains infinite or NaN elements"))
    return;

  MinQPSetQuadraticTermFast(state, a, isupper, 0.0);
}

static void CMinQP::MinQPSetStartingPoint(CMinQPState &state, double &x[]) {

  int n = 0;

  n = state.m_n;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(B)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN elements"))
    return;

  MinQPSetStartingPointFast(state, x);
}

static void CMinQP::MinQPSetOrigin(CMinQPState &state, double &xorigin[]) {

  int n = 0;

  n = state.m_n;

  if (!CAp::Assert(CAp::Len(xorigin) >= n, __FUNCTION__ + ": Length(B)<N"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(xorigin, n),
                   __FUNCTION__ + ": B contains infinite or NaN elements"))
    return;

  MinQPSetOriginFast(state, xorigin);
}

static void CMinQP::MinQPSetAlgoCholesky(CMinQPState &state) {

  state.m_algokind = 1;
}

static void CMinQP::MinQPSetBC(CMinQPState &state, double &bndl[],
                               double &bndu[]) {

  int i = 0;
  int n = 0;

  n = state.m_n;

  if (!CAp::Assert(CAp::Len(bndl) >= n, __FUNCTION__ + ": Length(BndL)<N"))
    return;

  if (!CAp::Assert(CAp::Len(bndu) >= n, __FUNCTION__ + ": Length(BndU)<N"))
    return;

  for (i = 0; i <= n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(bndl[i]) ||
                         CInfOrNaN::IsNegativeInfinity(bndl[i]),
                     __FUNCTION__ + ": BndL contains NAN or +INF"))
      return;

    if (!CAp::Assert(CMath::IsFinite(bndu[i]) ||
                         CInfOrNaN::IsPositiveInfinity(bndu[i]),
                     __FUNCTION__ + ": BndU contains NAN or -INF"))
      return;

    state.m_bndl[i] = bndl[i];
    state.m_havebndl[i] = CMath::IsFinite(bndl[i]);
    state.m_bndu[i] = bndu[i];
    state.m_havebndu[i] = CMath::IsFinite(bndu[i]);
  }
}

static void CMinQP::MinQPOptimize(CMinQPState &state) {

  int n = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int nbc = 0;
  int nlc = 0;
  int nactive = 0;
  int nfree = 0;
  double f = 0;
  double fprev = 0;
  double v = 0;
  bool b;
  int i_ = 0;

  n = state.m_n;
  state.m_repterminationtype = -5;
  state.m_repinneriterationscount = 0;
  state.m_repouteriterationscount = 0;
  state.m_repncholesky = 0;
  state.m_repnmv = 0;

  for (i = 0; i <= n - 1; i++) {

    if (state.m_havebndl[i] && state.m_havebndu[i]) {

      if (state.m_bndl[i] > state.m_bndu[i]) {
        state.m_repterminationtype = -3;
        return;
      }
    }
  }

  nbc = 0;
  nlc = 0;
  for (i = 0; i <= n - 1; i++) {

    if (state.m_havebndl[i])
      nbc = nbc + 1;

    if (state.m_havebndu[i])
      nbc = nbc + 1;
  }

  for (i = 0; i <= n - 1; i++) {
    state.m_xc[i] = state.m_startx[i] - state.m_xorigin[i];

    if (state.m_havebndl[i])
      state.m_workbndl[i] = state.m_bndl[i] - state.m_xorigin[i];

    if (state.m_havebndu[i])
      state.m_workbndu[i] = state.m_bndu[i] - state.m_xorigin[i];
  }

  if (state.m_havex) {

    for (i = 0; i <= n - 1; i++) {

      if (state.m_havebndl[i]) {

        if (state.m_xc[i] < state.m_workbndl[i])
          state.m_xc[i] = state.m_workbndl[i];
      }

      if (state.m_havebndu[i]) {

        if (state.m_xc[i] > state.m_workbndu[i])
          state.m_xc[i] = state.m_workbndu[i];
      }
    }
  } else {

    for (i = 0; i <= n - 1; i++) {

      if (state.m_havebndl[i] && state.m_havebndu[i]) {
        state.m_xc[i] = 0.5 * (state.m_workbndl[i] + state.m_workbndu[i]);

        if (state.m_xc[i] < state.m_workbndl[i])
          state.m_xc[i] = state.m_workbndl[i];

        if (state.m_xc[i] > state.m_workbndu[i])
          state.m_xc[i] = state.m_workbndu[i];

        continue;
      }

      if (state.m_havebndl[i]) {
        state.m_xc[i] = state.m_workbndl[i];
        continue;
      }

      if (state.m_havebndu[i]) {
        state.m_xc[i] = state.m_workbndu[i];
        continue;
      }
      state.m_xc[i] = 0;
    }
  }

  if (state.m_algokind == 1 && state.m_akind == 0) {

    if (nbc == 0 && nlc == 0) {

      CApServ::RVectorSetLengthAtLeast(state.m_tmp0, n);

      CApServ::RVectorSetLengthAtLeast(state.m_bufb, n);

      state.m_densea[0].Set(0, state.m_diaga[0]);
      for (k = 1; k <= n - 1; k++) {
        for (i_ = 0; i_ <= k - 1; i_++)
          state.m_densea[i_].Set(k, state.m_densea[k][i_]);
        state.m_densea[k].Set(k, state.m_diaga[k]);
      }

      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_bufb[i_] = state.m_b[i_];
      state.m_repncholesky = 1;

      if (!CTrFac::SPDMatrixCholeskyRec(state.m_densea, 0, n, true,
                                        state.m_tmp0)) {
        state.m_repterminationtype = -5;
        return;
      }

      CFbls::FblsCholeskySolve(state.m_densea, 1.0, n, true, state.m_bufb,
                               state.m_tmp0);
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_xc[i_] = -state.m_bufb[i_];
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_xc[i_] = state.m_xc[i_] + state.m_xorigin[i_];

      state.m_repouteriterationscount = 1;
      state.m_repterminationtype = 4;

      return;
    }

    CApServ::RMatrixSetLengthAtLeast(state.m_bufa, n, n);

    CApServ::RVectorSetLengthAtLeast(state.m_bufb, n);

    CApServ::RVectorSetLengthAtLeast(state.m_bufx, n);

    CApServ::IVectorSetLengthAtLeast(state.m_activeconstraints, n);

    CApServ::IVectorSetLengthAtLeast(state.m_prevactiveconstraints, n);

    CApServ::RVectorSetLengthAtLeast(state.m_tmp0, n);

    for (i = 0; i <= n - 1; i++)
      state.m_prevactiveconstraints[i] = -1;

    fprev = CMath::m_maxrealnumber;
    while (true) {

      MinQPGrad(state);
      nactive = 0;
      for (i = 0; i <= n - 1; i++) {
        state.m_activeconstraints[i] = 0;

        if (state.m_havebndl[i]) {

          if (state.m_xc[i] <= state.m_workbndl[i] && state.m_gc[i] >= 0.0)
            state.m_activeconstraints[i] = 1;
        }

        if (state.m_havebndu[i]) {

          if (state.m_xc[i] >= state.m_workbndu[i] && state.m_gc[i] <= 0.0)
            state.m_activeconstraints[i] = 1;
        }

        if (state.m_havebndl[i] && state.m_havebndu[i]) {

          if (state.m_workbndl[i] == state.m_workbndu[i])
            state.m_activeconstraints[i] = 1;
        }

        if (state.m_activeconstraints[i] > 0)
          nactive = nactive + 1;
      }
      nfree = n - nactive;

      if (nfree == 0)
        break;
      b = false;
      for (i = 0; i <= n - 1; i++) {

        if (state.m_activeconstraints[i] != state.m_prevactiveconstraints[i])
          b = true;
      }

      if (!b)
        break;

      state.m_bufa[0].Set(0, state.m_diaga[0]);
      for (k = 1; k <= n - 1; k++) {
        for (i_ = 0; i_ <= k - 1; i_++)
          state.m_bufa[k].Set(i_, state.m_densea[k][i_]);
        for (i_ = 0; i_ <= k - 1; i_++)
          state.m_bufa[i_].Set(k, state.m_densea[k][i_]);
        state.m_bufa[k].Set(k, state.m_diaga[k]);
      }

      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_bufb[i_] = state.m_b[i_];
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_bufx[i_] = state.m_xc[i_];
      for (i = 0; i <= n - 1; i++)
        state.m_tmp0[i] = state.m_activeconstraints[i];

      CTSort::TagSortBuf(state.m_tmp0, n, state.m_itmp0, state.m_p2,
                         state.m_buf);
      for (k = 0; k <= n - 1; k++) {

        if (state.m_p2[k] != k) {

          v = state.m_bufb[k];
          state.m_bufb[k] = state.m_bufb[state.m_p2[k]];
          state.m_bufb[state.m_p2[k]] = v;
          v = state.m_bufx[k];
          state.m_bufx[k] = state.m_bufx[state.m_p2[k]];
          state.m_bufx[state.m_p2[k]] = v;
        }
      }
      for (i = 0; i <= n - 1; i++) {
        for (i_ = 0; i_ <= n - 1; i_++)
          state.m_tmp0[i_] = state.m_bufa[i][i_];
        for (k = 0; k <= n - 1; k++) {

          if (state.m_p2[k] != k) {

            v = state.m_tmp0[k];
            state.m_tmp0[k] = state.m_tmp0[state.m_p2[k]];
            state.m_tmp0[state.m_p2[k]] = v;
          }
        }
        for (i_ = 0; i_ <= n - 1; i_++)
          state.m_bufa[i].Set(i_, state.m_tmp0[i_]);
      }
      for (i = 0; i <= n - 1; i++) {

        if (state.m_p2[i] != i) {
          for (i_ = 0; i_ <= n - 1; i_++)
            state.m_tmp0[i_] = state.m_bufa[i][i_];
          for (i_ = 0; i_ <= n - 1; i_++)
            state.m_bufa[i].Set(i_, state.m_bufa[state.m_p2[i]][i_]);
          for (i_ = 0; i_ <= n - 1; i_++)
            state.m_bufa[state.m_p2[i]].Set(i_, state.m_tmp0[i_]);
        }
      }

      CAblas::RMatrixMVect(nfree, nactive, state.m_bufa, 0, nfree, 0,
                           state.m_bufx, nfree, state.m_tmp0, 0);
      for (i_ = 0; i_ <= nfree - 1; i_++)
        state.m_bufb[i_] = state.m_bufb[i_] + state.m_tmp0[i_];
      state.m_constterm = 0.0;
      for (i = nfree; i <= n - 1; i++) {
        state.m_constterm = state.m_constterm + 0.5 * state.m_bufx[i] *
                                                    state.m_bufa[i][i] *
                                                    state.m_bufx[i];
        for (j = i + 1; j <= n - 1; j++)
          state.m_constterm = state.m_constterm + state.m_bufx[i] *
                                                      state.m_bufa[i][j] *
                                                      state.m_bufx[j];
      }

      state.m_repncholesky = state.m_repncholesky + 1;

      if (!CTrFac::SPDMatrixCholeskyRec(state.m_bufa, 0, nfree, true,
                                        state.m_tmp0)) {
        state.m_repterminationtype = -5;
        return;
      }

      CFbls::FblsCholeskySolve(state.m_bufa, 1.0, nfree, true, state.m_bufb,
                               state.m_tmp0);
      for (i_ = 0; i_ <= nfree - 1; i_++)
        state.m_bufx[i_] = -state.m_bufb[i_];

      for (k = n - 1; k >= 0; k--) {

        if (state.m_p2[k] != k) {
          v = state.m_bufx[k];
          state.m_bufx[k] = state.m_bufx[state.m_p2[k]];
          state.m_bufx[state.m_p2[k]] = v;
        }
      }
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_xc[i_] = state.m_bufx[i_];
      for (i = 0; i <= n - 1; i++) {

        if (state.m_havebndl[i]) {

          if (state.m_xc[i] < state.m_workbndl[i])
            state.m_xc[i] = state.m_workbndl[i];
        }

        if (state.m_havebndu[i]) {

          if (state.m_xc[i] > state.m_workbndu[i])
            state.m_xc[i] = state.m_workbndu[i];
        }
      }

      f = 0.0;
      for (i_ = 0; i_ <= n - 1; i_++)
        f += state.m_b[i_] * state.m_xc[i_];
      f = f + MinQPXTAX(state, state.m_xc);

      if (f >= fprev)
        break;
      fprev = f;

      for (i = 0; i <= n - 1; i++)
        state.m_prevactiveconstraints[i] = state.m_activeconstraints[i];

      state.m_repouteriterationscount = state.m_repouteriterationscount + 1;
    }

    state.m_repterminationtype = 4;
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_xc[i_] = state.m_xc[i_] + state.m_xorigin[i_];

    return;
  }
}

static void CMinQP::MinQPResults(CMinQPState &state, double &x[],
                                 CMinQPReport &rep) {

  ArrayResizeAL(x, 0);

  MinQPResultsBuf(state, x, rep);
}

static void CMinQP::MinQPResultsBuf(CMinQPState &state, double &x[],
                                    CMinQPReport &rep) {

  int i_ = 0;

  if (CAp::Len(x) < state.m_n)
    ArrayResizeAL(x, state.m_n);

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    x[i_] = state.m_xc[i_];

  rep.m_inneriterationscount = state.m_repinneriterationscount;
  rep.m_outeriterationscount = state.m_repouteriterationscount;
  rep.m_nmv = state.m_repnmv;
  rep.m_terminationtype = state.m_repterminationtype;
}

static void CMinQP::MinQPSetLinearTermFast(CMinQPState &state, double &b[]) {

  int n = 0;
  int i_ = 0;

  n = state.m_n;
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_b[i_] = b[i_];
}

static void CMinQP::MinQPSetQuadraticTermFast(CMinQPState &state,
                                              CMatrixDouble &a,
                                              const bool isupper,
                                              const double s) {

  int k = 0;
  int n = 0;
  int i_ = 0;

  n = state.m_n;
  state.m_akind = 0;

  CApServ::RMatrixSetLengthAtLeast(state.m_densea, n, n);

  CApServ::RVectorSetLengthAtLeast(state.m_diaga, n);

  if (isupper) {
    for (k = 0; k <= n - 2; k++) {

      state.m_diaga[k] = a[k][k] + s;
      for (i_ = k + 1; i_ <= n - 1; i_++)
        state.m_densea[i_].Set(k, a[k][i_]);
    }
    state.m_diaga[n - 1] = a[n - 1][n - 1] + s;
  } else {
    state.m_diaga[0] = a[0][0] + s;
    for (k = 1; k <= n - 1; k++) {

      for (i_ = 0; i_ <= k - 1; i_++)
        state.m_densea[k].Set(i_, a[k][i_]);
      state.m_diaga[k] = a[k][k] + s;
    }
  }
}

static void CMinQP::MinQPRewriteDiagonal(CMinQPState &state, double &s[]) {

  int k = 0;
  int n = 0;

  if (!CAp::Assert(state.m_akind == 0,
                   __FUNCTION__ + ": internal error (AKind<>0)"))
    return;

  n = state.m_n;
  for (k = 0; k <= n - 1; k++)
    state.m_diaga[k] = s[k];
}

static void CMinQP::MinQPSetStartingPointFast(CMinQPState &state, double &x[]) {

  int n = 0;
  int i_ = 0;

  n = state.m_n;
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_startx[i_] = x[i_];
  state.m_havex = true;
}

static void CMinQP::MinQPSetOriginFast(CMinQPState &state, double &xorigin[]) {

  int n = 0;
  int i_ = 0;

  n = state.m_n;
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_xorigin[i_] = xorigin[i_];
}

static void CMinQP::MinQPGrad(CMinQPState &state) {

  int n = 0;
  int i = 0;
  double v = 0;
  int i_ = 0;

  n = state.m_n;

  if (!CAp::Assert(state.m_akind == -1 || state.m_akind == 0,
                   __FUNCTION__ + ": internal error"))
    return;

  if (state.m_akind == -1) {
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_gc[i_] = state.m_b[i_];

    return;
  }

  if (state.m_akind == 0) {
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_gc[i_] = state.m_b[i_];
    state.m_gc[0] = state.m_gc[0] + state.m_diaga[0] * state.m_xc[0];

    for (i = 1; i <= n - 1; i++) {
      v = 0.0;
      for (i_ = 0; i_ <= i - 1; i_++)
        v += state.m_densea[i][i_] * state.m_xc[i_];
      state.m_gc[i] = state.m_gc[i] + v + state.m_diaga[i] * state.m_xc[i];
      v = state.m_xc[i];

      for (i_ = 0; i_ <= i - 1; i_++)
        state.m_gc[i_] = state.m_gc[i_] + v * state.m_densea[i][i_];
    }

    return;
  }
}

static double CMinQP::MinQPXTAX(CMinQPState &state, double &x[]) {

  double result = 0;
  int n = 0;
  int i = 0;
  int j = 0;

  n = state.m_n;

  if (!CAp::Assert(state.m_akind == -1 || state.m_akind == 0,
                   __FUNCTION__ + ": internal error"))
    return (EMPTY_VALUE);
  result = 0;

  if (state.m_akind == -1)
    return (0.0);

  if (state.m_akind == 0) {
    result = 0;
    for (i = 0; i <= n - 1; i++) {
      for (j = 0; j <= i - 1; j++)
        result = result + state.m_densea[i][j] * x[i] * x[j];

      result = result + 0.5 * state.m_diaga[i] * CMath::Sqr(x[i]);
    }

    return (result);
  }

  return (result);
}

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

  double m_x[];
  double m_fi[];
  double m_g[];
  double m_xbase[];
  double m_fibase[];
  double m_gbase[];
  double m_bndl[];
  double m_bndu[];
  bool m_havebndl[];
  bool m_havebndu[];
  double m_s[];
  double m_xdir[];
  double m_deltax[];
  double m_deltaf[];
  double m_choleskybuf[];
  double m_tmp0[];
  double m_fm1[];
  double m_fp1[];

  CMatrixDouble m_j;
  CMatrixDouble m_h;
  CMatrixDouble m_quadraticmodel;

  CMinLMState(void);
  ~CMinLMState(void);

  void Copy(CMinLMState &obj);
};

CMinLMState::CMinLMState(void) {
}

CMinLMState::~CMinLMState(void) {
}

void CMinLMState::Copy(CMinLMState &obj) {

  m_n = obj.m_n;
  m_m = obj.m_m;
  m_diffstep = obj.m_diffstep;
  m_epsg = obj.m_epsg;
  m_epsf = obj.m_epsf;
  m_epsx = obj.m_epsx;
  m_maxits = obj.m_maxits;
  m_xrep = obj.m_xrep;
  m_stpmax = obj.m_stpmax;
  m_maxmodelage = obj.m_maxmodelage;
  m_makeadditers = obj.m_makeadditers;
  m_f = obj.m_f;
  m_needf = obj.m_needf;
  m_needfg = obj.m_needfg;
  m_needfgh = obj.m_needfgh;
  m_needfij = obj.m_needfij;
  m_needfi = obj.m_needfi;
  m_xupdated = obj.m_xupdated;
  m_algomode = obj.m_algomode;
  m_hasf = obj.m_hasf;
  m_hasfi = obj.m_hasfi;
  m_hasg = obj.m_hasg;
  m_fbase = obj.m_fbase;
  m_lambdav = obj.m_lambdav;
  m_nu = obj.m_nu;
  m_modelage = obj.m_modelage;
  m_deltaxready = obj.m_deltaxready;
  m_deltafready = obj.m_deltafready;
  m_repiterationscount = obj.m_repiterationscount;
  m_repterminationtype = obj.m_repterminationtype;
  m_repnfunc = obj.m_repnfunc;
  m_repnjac = obj.m_repnjac;
  m_repngrad = obj.m_repngrad;
  m_repnhess = obj.m_repnhess;
  m_repncholesky = obj.m_repncholesky;
  m_actualdecrease = obj.m_actualdecrease;
  m_predicteddecrease = obj.m_predicteddecrease;
  m_xm1 = obj.m_xm1;
  m_xp1 = obj.m_xp1;
  m_rstate.Copy(obj.m_rstate);
  m_internalstate.Copy(obj.m_internalstate);
  m_internalrep.Copy(obj.m_internalrep);
  m_qpstate.Copy(obj.m_qpstate);
  m_qprep.Copy(obj.m_qprep);

  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_fi, obj.m_fi);
  ArrayCopy(m_g, obj.m_g);
  ArrayCopy(m_xbase, obj.m_xbase);
  ArrayCopy(m_fibase, obj.m_fibase);
  ArrayCopy(m_gbase, obj.m_gbase);
  ArrayCopy(m_bndl, obj.m_bndl);
  ArrayCopy(m_bndu, obj.m_bndu);
  ArrayCopy(m_havebndl, obj.m_havebndl);
  ArrayCopy(m_havebndu, obj.m_havebndu);
  ArrayCopy(m_s, obj.m_s);
  ArrayCopy(m_xdir, obj.m_xdir);
  ArrayCopy(m_deltax, obj.m_deltax);
  ArrayCopy(m_deltaf, obj.m_deltaf);
  ArrayCopy(m_choleskybuf, obj.m_choleskybuf);
  ArrayCopy(m_tmp0, obj.m_tmp0);
  ArrayCopy(m_fm1, obj.m_fm1);
  ArrayCopy(m_fp1, obj.m_fp1);

  m_j = obj.m_j;
  m_h = obj.m_h;
  m_quadraticmodel = obj.m_quadraticmodel;
}

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

CMinLMStateShell::CMinLMStateShell(void) {
}

CMinLMStateShell::CMinLMStateShell(CMinLMState &obj) {

  m_innerobj.Copy(obj);
}

CMinLMStateShell::~CMinLMStateShell(void) {
}

bool CMinLMStateShell::GetNeedF(void) {

  return (m_innerobj.m_needf);
}

void CMinLMStateShell::SetNeedF(const bool b) {

  m_innerobj.m_needf = b;
}

bool CMinLMStateShell::GetNeedFG(void) {

  return (m_innerobj.m_needfg);
}

void CMinLMStateShell::SetNeedFG(const bool b) {

  m_innerobj.m_needfg = b;
}

bool CMinLMStateShell::GetNeedFGH(void) {

  return (m_innerobj.m_needfgh);
}

void CMinLMStateShell::SetNeedFGH(const bool b) {

  m_innerobj.m_needfgh = b;
}

bool CMinLMStateShell::GetNeedFI(void) {

  return (m_innerobj.m_needfi);
}

void CMinLMStateShell::SetNeedFI(const bool b) {

  m_innerobj.m_needfi = b;
}

bool CMinLMStateShell::GetNeedFIJ(void) {

  return (m_innerobj.m_needfij);
}

void CMinLMStateShell::SetNeedFIJ(const bool b) {

  m_innerobj.m_needfij = b;
}

bool CMinLMStateShell::GetXUpdated(void) {

  return (m_innerobj.m_xupdated);
}

void CMinLMStateShell::SetXUpdated(const bool b) {

  m_innerobj.m_xupdated = b;
}

double CMinLMStateShell::GetF(void) {

  return (m_innerobj.m_f);
}

void CMinLMStateShell::SetF(const double d) {

  m_innerobj.m_f = d;
}

CMinLMState *CMinLMStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

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

CMinLMReport::CMinLMReport(void) {
}

CMinLMReport::~CMinLMReport(void) {
}

void CMinLMReport::Copy(CMinLMReport &obj) {

  m_iterationscount = obj.m_iterationscount;
  m_terminationtype = obj.m_terminationtype;
  m_nfunc = obj.m_nfunc;
  m_njac = obj.m_njac;
  m_ngrad = obj.m_ngrad;
  m_nhess = obj.m_nhess;
  m_ncholesky = obj.m_ncholesky;
}

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

CMinLMReportShell::CMinLMReportShell(void) {
}

CMinLMReportShell::CMinLMReportShell(CMinLMReport &obj) {

  m_innerobj.Copy(obj);
}

CMinLMReportShell::~CMinLMReportShell(void) {
}

int CMinLMReportShell::GetIterationsCount(void) {

  return (m_innerobj.m_iterationscount);
}

void CMinLMReportShell::SetIterationsCount(const int i) {

  m_innerobj.m_iterationscount = i;
}

int CMinLMReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CMinLMReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

int CMinLMReportShell::GetNFunc(void) {

  return (m_innerobj.m_nfunc);
}

void CMinLMReportShell::SetNFunc(const int i) {

  m_innerobj.m_nfunc = i;
}

int CMinLMReportShell::GetNJAC(void) {

  return (m_innerobj.m_njac);
}

void CMinLMReportShell::SetNJAC(const int i) {

  m_innerobj.m_njac = i;
}

int CMinLMReportShell::GetNGrad(void) {

  return (m_innerobj.m_ngrad);
}

void CMinLMReportShell::SetNGrad(const int i) {

  m_innerobj.m_ngrad = i;
}

int CMinLMReportShell::GetNHess(void) {

  return (m_innerobj.m_nhess);
}

void CMinLMReportShell::SetNHess(const int i) {

  m_innerobj.m_nhess = i;
}

int CMinLMReportShell::GetNCholesky(void) {

  return (m_innerobj.m_ncholesky);
}

void CMinLMReportShell::SetNCholesky(const int i) {

  m_innerobj.m_ncholesky = i;
}

CMinLMReport *CMinLMReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMinLM {
private:
  static void LMPRepare(const int n, const int m, bool havegrad,
                        CMinLMState &state);
  static void ClearRequestFields(CMinLMState &state);
  static bool IncreaseLambda(double &lambdav, double &nu);
  static void DecreaseLambda(double &lambdav, double &nu);
  static double BoundedScaledAntigradNorm(CMinLMState &state, double &x[],
                                          double &g[]);

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

  static void MinLMCreateVJ(const int n, const int m, double &x[],
                            CMinLMState &state);
  static void MinLMCreateV(const int n, const int m, double &x[],
                           const double diffstep, CMinLMState &state);
  static void MinLMCreateFGH(const int n, double &x[], CMinLMState &state);
  static void MinLMSetCond(CMinLMState &state, const double epsg,
                           const double epsf, double epsx, const int maxits);
  static void MinLMSetXRep(CMinLMState &state, const bool needxrep);
  static void MinLMSetStpMax(CMinLMState &state, const double stpmax);
  static void MinLMSetScale(CMinLMState &state, double &s[]);
  static void MinLMSetBC(CMinLMState &state, double &bndl[], double &bndu[]);
  static void MinLMSetAccType(CMinLMState &state, int acctype);
  static void MinLMResults(CMinLMState &state, double &x[], CMinLMReport &rep);
  static void MinLMResultsBuf(CMinLMState &state, double &x[],
                              CMinLMReport &rep);
  static void MinLMRestartFrom(CMinLMState &state, double &x[]);
  static void MinLMCreateVGJ(const int n, const int m, double &x[],
                             CMinLMState &state);
  static void MinLMCreateFGJ(const int n, const int m, double &x[],
                             CMinLMState &state);
  static void MinLMCreateFJ(const int n, const int m, double &x[],
                            CMinLMState &state);
  static bool MinLMIteration(CMinLMState &state);
};

const int CMinLM::m_lmmodefj = 0;
const int CMinLM::m_lmmodefgj = 1;
const int CMinLM::m_lmmodefgh = 2;
const int CMinLM::m_lmflagnopreLBFGS = 1;
const int CMinLM::m_lmflagnointLBFGS = 2;
const int CMinLM::m_lmpreLBFGSm = 5;
const int CMinLM::m_lmintLBFGSits = 5;
const int CMinLM::m_lbfgsnorealloc = 1;
const double CMinLM::m_lambdaup = 2.0;
const double CMinLM::m_lambdadown = 0.33;
const double CMinLM::m_suspiciousnu = 16;
const int CMinLM::m_smallmodelage = 3;
const int CMinLM::m_additers = 5;

CMinLM::CMinLM(void) {
}

CMinLM::~CMinLM(void) {
}

static void CMinLM::MinLMCreateVJ(const int n, const int m, double &x[],
                                  CMinLMState &state) {

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
  state.m_algomode = 1;
  state.m_hasf = false;
  state.m_hasfi = true;
  state.m_hasg = false;

  LMPRepare(n, m, false, state);
  MinLMSetAccType(state, 0);
  MinLMSetCond(state, 0, 0, 0, 0);
  MinLMSetXRep(state, false);
  MinLMSetStpMax(state, 0);
  MinLMRestartFrom(state, x);
}

static void CMinLM::MinLMCreateV(const int n, const int m, double &x[],
                                 const double diffstep, CMinLMState &state) {

  if (!CAp::Assert(CMath::IsFinite(diffstep),
                   __FUNCTION__ + ": DiffStep is not finite!"))
    return;

  if (!CAp::Assert(diffstep > 0.0, __FUNCTION__ + ": DiffStep<=0!"))
    return;

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
  state.m_algomode = 0;
  state.m_hasf = false;
  state.m_hasfi = true;
  state.m_hasg = false;
  state.m_diffstep = diffstep;

  LMPRepare(n, m, false, state);
  MinLMSetAccType(state, 1);
  MinLMSetCond(state, 0, 0, 0, 0);
  MinLMSetXRep(state, false);
  MinLMSetStpMax(state, 0);
  MinLMRestartFrom(state, x);
}

static void CMinLM::MinLMCreateFGH(const int n, double &x[],
                                   CMinLMState &state) {

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  state.m_n = n;
  state.m_m = 0;
  state.m_algomode = 2;
  state.m_hasf = true;
  state.m_hasfi = false;
  state.m_hasg = true;

  LMPRepare(n, 0, true, state);
  MinLMSetAccType(state, 2);
  MinLMSetCond(state, 0, 0, 0, 0);
  MinLMSetXRep(state, false);
  MinLMSetStpMax(state, 0);
  MinLMRestartFrom(state, x);
}

static void CMinLM::MinLMSetCond(CMinLMState &state, const double epsg,
                                 const double epsf, double epsx,
                                 const int maxits) {

  if (!CAp::Assert(CMath::IsFinite(epsg),
                   __FUNCTION__ + ": EpsG is not finite number!"))
    return;

  if (!CAp::Assert(epsg >= 0.0, __FUNCTION__ + ": negative EpsG!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsf),
                   __FUNCTION__ + ": EpsF is not finite number!"))
    return;

  if (!CAp::Assert(epsf >= 0.0, __FUNCTION__ + ": negative EpsF!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsx),
                   __FUNCTION__ + ": EpsX is not finite number!"))
    return;

  if (!CAp::Assert(epsx >= 0.0, __FUNCTION__ + ": negative EpsX!"))
    return;

  if (!CAp::Assert(maxits >= 0, __FUNCTION__ + ": negative MaxIts!"))
    return;

  if (((epsg == 0.0 && epsf == 0.0) && epsx == 0.0) && maxits == 0)
    epsx = 1.0E-6;

  state.m_epsg = epsg;
  state.m_epsf = epsf;
  state.m_epsx = epsx;
  state.m_maxits = maxits;
}

static void CMinLM::MinLMSetXRep(CMinLMState &state, const bool needxrep) {

  state.m_xrep = needxrep;
}

static void CMinLM::MinLMSetStpMax(CMinLMState &state, const double stpmax) {

  if (!CAp::Assert(CMath::IsFinite(stpmax),
                   __FUNCTION__ + ": StpMax is not finite!"))
    return;

  if (!CAp::Assert(stpmax >= 0.0, __FUNCTION__ + ": StpMax<0!"))
    return;

  state.m_stpmax = stpmax;
}

static void CMinLM::MinLMSetScale(CMinLMState &state, double &s[]) {

  int i = 0;

  if (!CAp::Assert(CAp::Len(s) >= state.m_n, __FUNCTION__ + ": Length(S)<N"))
    return;
  for (i = 0; i <= state.m_n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(s[i]),
                     __FUNCTION__ + ": S contains infinite or NAN elements"))
      return;

    if (!CAp::Assert(s[i] != 0.0, __FUNCTION__ + ": S contains zero elements"))
      return;

    state.m_s[i] = MathAbs(s[i]);
  }
}

static void CMinLM::MinLMSetBC(CMinLMState &state, double &bndl[],
                               double &bndu[]) {

  int i = 0;
  int n = 0;

  n = state.m_n;

  if (!CAp::Assert(CAp::Len(bndl) >= n, __FUNCTION__ + ": Length(BndL)<N"))
    return;

  if (!CAp::Assert(CAp::Len(bndu) >= n, __FUNCTION__ + ": Length(BndU)<N"))
    return;
  for (i = 0; i <= n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(bndl[i]) ||
                         CInfOrNaN::IsNegativeInfinity(bndl[i]),
                     "MinLMSetBC: BndL contains NAN or +INF"))
      return;

    if (!CAp::Assert(CMath::IsFinite(bndu[i]) ||
                         CInfOrNaN::IsPositiveInfinity(bndu[i]),
                     "MinLMSetBC: BndU contains NAN or -INF"))
      return;

    state.m_bndl[i] = bndl[i];
    state.m_havebndl[i] = CMath::IsFinite(bndl[i]);
    state.m_bndu[i] = bndu[i];
    state.m_havebndu[i] = CMath::IsFinite(bndu[i]);
  }
}

static void CMinLM::MinLMSetAccType(CMinLMState &state, int acctype) {

  if (!CAp::Assert((acctype == 0 || acctype == 1) || acctype == 2,
                   __FUNCTION__ + ": incorrect AccType!"))
    return;

  if (acctype == 2)
    acctype = 0;

  if (acctype == 0) {
    state.m_maxmodelage = 0;
    state.m_makeadditers = false;

    return;
  }

  if (acctype == 1) {

    if (!CAp::Assert(state.m_hasfi,
                     __FUNCTION__ +
                         ": AccType=1 is incompatible with current protocol!"))
      return;

    if (state.m_algomode == 0)
      state.m_maxmodelage = 2 * state.m_n;
    else
      state.m_maxmodelage = m_smallmodelage;
    state.m_makeadditers = false;

    return;
  }
}

static void CMinLM::MinLMResults(CMinLMState &state, double &x[],
                                 CMinLMReport &rep) {

  ArrayResizeAL(x, 0);

  MinLMResultsBuf(state, x, rep);
}

static void CMinLM::MinLMResultsBuf(CMinLMState &state, double &x[],
                                    CMinLMReport &rep) {

  int i_ = 0;

  if (CAp::Len(x) < state.m_n)
    ArrayResizeAL(x, state.m_n);

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    x[i_] = state.m_x[i_];

  rep.m_iterationscount = state.m_repiterationscount;
  rep.m_terminationtype = state.m_repterminationtype;
  rep.m_nfunc = state.m_repnfunc;
  rep.m_njac = state.m_repnjac;
  rep.m_ngrad = state.m_repngrad;
  rep.m_nhess = state.m_repnhess;
  rep.m_ncholesky = state.m_repncholesky;
}

static void CMinLM::MinLMRestartFrom(CMinLMState &state, double &x[]) {

  int i_ = 0;

  if (!CAp::Assert(CAp::Len(x) >= state.m_n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, state.m_n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    state.m_xbase[i_] = x[i_];

  ArrayResizeAL(state.m_rstate.ia, 5);
  ArrayResizeAL(state.m_rstate.ba, 1);
  ArrayResizeAL(state.m_rstate.ra, 3);
  state.m_rstate.stage = -1;

  ClearRequestFields(state);
}

static void CMinLM::MinLMCreateVGJ(const int n, const int m, double &x[],
                                   CMinLMState &state) {

  MinLMCreateVJ(n, m, x, state);
}

static void CMinLM::MinLMCreateFGJ(const int n, const int m, double &x[],
                                   CMinLMState &state) {

  MinLMCreateFJ(n, m, x, state);
}

static void CMinLM::MinLMCreateFJ(const int n, const int m, double &x[],
                                  CMinLMState &state) {

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
  state.m_algomode = 1;
  state.m_hasf = true;
  state.m_hasfi = false;
  state.m_hasg = false;

  LMPRepare(n, m, true, state);

  MinLMSetAccType(state, 0);

  MinLMSetCond(state, 0, 0, 0, 0);

  MinLMSetXRep(state, false);

  MinLMSetStpMax(state, 0);

  MinLMRestartFrom(state, x);
}

static void CMinLM::LMPRepare(const int n, const int m, bool havegrad,
                              CMinLMState &state) {

  int i = 0;

  if (n <= 0 || m < 0)
    return;

  if (havegrad)
    ArrayResizeAL(state.m_g, n);

  if (m != 0) {

    state.m_j.Resize(m, n);
    ArrayResizeAL(state.m_fi, m);
    ArrayResizeAL(state.m_fibase, m);
    ArrayResizeAL(state.m_deltaf, m);
    ArrayResizeAL(state.m_fm1, m);
    ArrayResizeAL(state.m_fp1, m);
  } else
    state.m_h.Resize(n, n);

  ArrayResizeAL(state.m_x, n);
  ArrayResizeAL(state.m_deltax, n);
  state.m_quadraticmodel.Resize(n, n);
  ArrayResizeAL(state.m_xbase, n);
  ArrayResizeAL(state.m_gbase, n);
  ArrayResizeAL(state.m_xdir, n);
  ArrayResizeAL(state.m_tmp0, n);

  for (i = 0; i <= n - 1; i++)
    state.m_x[i] = 0;

  CMinLBFGS::MinLBFGSCreate(n, MathMin(m_additers, n), state.m_x,
                            state.m_internalstate);

  CMinLBFGS::MinLBFGSSetCond(state.m_internalstate, 0.0, 0.0, 0.0,
                             MathMin(m_additers, n));

  CMinQP::MinQPCreate(n, state.m_qpstate);

  CMinQP::MinQPSetAlgoCholesky(state.m_qpstate);

  ArrayResizeAL(state.m_bndl, n);
  ArrayResizeAL(state.m_bndu, n);
  ArrayResizeAL(state.m_havebndl, n);
  ArrayResizeAL(state.m_havebndu, n);
  for (i = 0; i <= n - 1; i++) {

    state.m_bndl[i] = CInfOrNaN::NegativeInfinity();
    state.m_havebndl[i] = false;
    state.m_bndu[i] = CInfOrNaN::PositiveInfinity();
    state.m_havebndu[i] = false;
  }

  ArrayResizeAL(state.m_s, n);
  for (i = 0; i <= n - 1; i++)
    state.m_s[i] = 1.0;
}

static void CMinLM::ClearRequestFields(CMinLMState &state) {

  state.m_needf = false;
  state.m_needfg = false;
  state.m_needfgh = false;
  state.m_needfij = false;
  state.m_needfi = false;
  state.m_xupdated = false;
}

static bool CMinLM::IncreaseLambda(double &lambdav, double &nu) {

  bool result;
  double lnlambda = 0;
  double lnnu = 0;
  double lnlambdaup = 0;
  double lnmax = 0;

  result = false;
  lnlambda = MathLog(lambdav);
  lnlambdaup = MathLog(m_lambdaup);
  lnnu = MathLog(nu);
  lnmax = MathLog(CMath::m_maxrealnumber);

  if (lnlambda + lnlambdaup + lnnu > 0.25 * lnmax) {

    return (result);
  }

  if (lnnu + MathLog(2) > lnmax)
    return (result);

  lambdav = lambdav * m_lambdaup * nu;
  nu = nu * 2;
  result = true;

  return (result);
}

static void CMinLM::DecreaseLambda(double &lambdav, double &nu) {

  nu = 1;

  if (MathLog(lambdav) + MathLog(m_lambdadown) <
      MathLog(CMath::m_minrealnumber))
    lambdav = CMath::m_minrealnumber;
  else
    lambdav = lambdav * m_lambdadown;
}

static double CMinLM::BoundedScaledAntigradNorm(CMinLMState &state, double &x[],
                                                double &g[]) {

  double result = 0;
  int n = 0;
  int i = 0;
  double v = 0;

  result = 0;
  n = state.m_n;
  for (i = 0; i <= n - 1; i++) {
    v = -(g[i] * state.m_s[i]);

    if (state.m_havebndl[i]) {

      if (x[i] <= state.m_bndl[i] && (double)(-g[i]) < 0.0)
        v = 0;
    }

    if (state.m_havebndu[i]) {

      if (x[i] >= state.m_bndu[i] && (double)(-g[i]) > 0.0)
        v = 0;
    }
    result = result + CMath::Sqr(v);
  }

  return (MathSqrt(result));
}

static bool CMinLM::MinLMIteration(CMinLMState &state) {

  int n = 0;
  int m = 0;
  bool bflag;
  int iflag = 0;
  double v = 0;
  double s = 0;
  double t = 0;
  int i = 0;
  int k = 0;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    m = state.m_rstate.ia[1];
    iflag = state.m_rstate.ia[2];
    i = state.m_rstate.ia[3];
    k = state.m_rstate.ia[4];
    bflag = state.m_rstate.ba[0];
    v = state.m_rstate.ra[0];
    s = state.m_rstate.ra[1];
    t = state.m_rstate.ra[2];
  } else {

    n = -983;
    m = -989;
    iflag = -834;
    i = 900;
    k = -287;
    bflag = false;
    v = 214;
    s = -338;
    t = -686;
  }

  if (state.m_rstate.stage == 0) {

    state.m_needf = false;

    return (Func_lbl_19(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 1) {

    state.m_needfi = false;
    v = 0.0;
    for (i_ = 0; i_ <= m - 1; i_++)
      v += state.m_fi[i_] * state.m_fi[i_];
    state.m_f = v;

    return (Func_lbl_19(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 2) {

    state.m_xupdated = false;

    return (Func_lbl_16(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 3) {

    state.m_repnfunc = state.m_repnfunc + 1;

    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_fm1[i_] = state.m_fi[i_];
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_x[i_] = state.m_xbase[i_];
    state.m_x[k] = state.m_x[k] + state.m_s[k] * state.m_diffstep;

    if (state.m_havebndl[k])
      state.m_x[k] = MathMax(state.m_x[k], state.m_bndl[k]);

    if (state.m_havebndu[k])
      state.m_x[k] = MathMin(state.m_x[k], state.m_bndu[k]);
    state.m_xp1 = state.m_x[k];

    ClearRequestFields(state);
    state.m_needfi = true;
    state.m_rstate.stage = 4;

    Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

    return (true);
  }

  if (state.m_rstate.stage == 4) {

    state.m_repnfunc = state.m_repnfunc + 1;

    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_fp1[i_] = state.m_fi[i_];
    v = state.m_xp1 - state.m_xm1;

    if (v != 0.0) {
      v = 1 / v;
      for (i_ = 0; i_ <= m - 1; i_++)
        state.m_j[i_].Set(k, v * state.m_fp1[i_]);
      for (i_ = 0; i_ <= m - 1; i_++)
        state.m_j[i_].Set(k, state.m_j[i_][k] - v * state.m_fm1[i_]);
    } else {
      for (i = 0; i <= m - 1; i++)
        state.m_j[i].Set(k, 0);
    }
    k = k + 1;

    return (Func_lbl_28(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 5) {

    state.m_needfi = false;
    state.m_repnfunc = state.m_repnfunc + 1;
    state.m_repnjac = state.m_repnjac + 1;

    state.m_modelage = 0;

    return (Func_lbl_25(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 6) {

    state.m_needfij = false;
    state.m_repnfunc = state.m_repnfunc + 1;
    state.m_repnjac = state.m_repnjac + 1;

    state.m_modelage = 0;

    return (Func_lbl_25(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 7) {

    state.m_needfgh = false;
    state.m_repnfunc = state.m_repnfunc + 1;
    state.m_repngrad = state.m_repngrad + 1;
    state.m_repnhess = state.m_repnhess + 1;

    CAblas::RMatrixCopy(n, n, state.m_h, 0, 0, state.m_quadraticmodel, 0, 0);
    for (i_ = 0; i_ <= n - 1; i_++)
      state.m_gbase[i_] = state.m_g[i_];
    state.m_fbase = state.m_f;

    bflag = true;
    state.m_modelage = 0;

    return (Func_lbl_31(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 8) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 9) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 10) {

    state.m_needfi = false;
    v = 0.0;
    for (i_ = 0; i_ <= m - 1; i_++)
      v += state.m_fi[i_] * state.m_fi[i_];
    state.m_f = v;

    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_deltaf[i_] = state.m_fi[i_];
    for (i_ = 0; i_ <= m - 1; i_++)
      state.m_deltaf[i_] = state.m_deltaf[i_] - state.m_fibase[i_];
    state.m_deltafready = true;

    return (Func_lbl_48(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 11) {

    state.m_needf = false;

    return (Func_lbl_48(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 12) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 13) {

    state.m_xupdated = false;

    return (Func_lbl_55(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_rstate.stage == 14) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 15) {

    state.m_xupdated = false;

    return (false);
  }

  n = state.m_n;
  m = state.m_m;
  state.m_repiterationscount = 0;
  state.m_repterminationtype = 0;
  state.m_repnfunc = 0;
  state.m_repnjac = 0;
  state.m_repngrad = 0;
  state.m_repnhess = 0;
  state.m_repncholesky = 0;

  for (i = 0; i <= n - 1; i++) {

    if (state.m_havebndl[i] && state.m_havebndu[i]) {

      if (state.m_bndl[i] > state.m_bndu[i]) {
        state.m_repterminationtype = -3;

        return (false);
      }
    }
  }

  CMinQP::MinQPSetBC(state.m_qpstate, state.m_bndl, state.m_bndu);

  if (!state.m_xrep)
    return (Func_lbl_16(state, n, m, iflag, i, k, bflag, v, s, t));
  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];

  ClearRequestFields(state);

  if (!state.m_hasf) {

    if (!CAp::Assert(state.m_hasfi, "MinLM: internal error 2!"))
      return (false);

    state.m_needfi = true;
    state.m_rstate.stage = 1;

    Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

    return (true);
  }

  state.m_needf = true;
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static void CMinLM::Func_lbl_rcomm(CMinLMState &state, int n, int m, int iflag,
                                   int i, int k, bool bflag, double v, double s,
                                   double t) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ia[1] = m;
  state.m_rstate.ia[2] = iflag;
  state.m_rstate.ia[3] = i;
  state.m_rstate.ia[4] = k;
  state.m_rstate.ba[0] = bflag;
  state.m_rstate.ra[0] = v;
  state.m_rstate.ra[1] = s;
  state.m_rstate.ra[2] = t;
}

static bool CMinLM::Func_lbl_16(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  state.m_nu = 1;
  state.m_lambdav = -CMath::m_maxrealnumber;
  state.m_modelage = state.m_maxmodelage + 1;
  state.m_deltaxready = false;
  state.m_deltafready = false;

  return (Func_lbl_20(state, n, m, iflag, i, k, bflag, v, s, t));
}

static bool CMinLM::Func_lbl_19(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  state.m_repnfunc = state.m_repnfunc + 1;

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 2;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_20(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  bflag = false;
  if (!(state.m_algomode == 0 || state.m_algomode == 1))
    return (Func_lbl_22(state, n, m, iflag, i, k, bflag, v, s, t));

  if (!(state.m_modelage > state.m_maxmodelage ||
        !(state.m_deltaxready & state.m_deltafready)))
    return (Func_lbl_24(state, n, m, iflag, i, k, bflag, v, s, t));

  if (state.m_algomode != 0) {

    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_x[i_] = state.m_xbase[i_];

    ClearRequestFields(state);

    state.m_needfij = true;
    state.m_rstate.stage = 6;

    Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

    return (true);
  }

  if (!CAp::Assert(
          state.m_hasfi,
          "MinLMIteration: internal error when estimating Jacobian (no f[])"))
    return (false);
  k = 0;

  return (Func_lbl_28(state, n, m, iflag, i, k, bflag, v, s, t));
}

static bool CMinLM::Func_lbl_21(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  state.m_repterminationtype = 7;
  if (!state.m_xrep)
    return (false);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  state.m_f = state.m_fbase;

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 15;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_22(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  if (state.m_algomode != 2)
    return (Func_lbl_31(state, n, m, iflag, i, k, bflag, v, s, t));

  if (!CAp::Assert(!state.m_hasfi, "MinLMIteration: internal error (HasFI is "
                                   "True in Hessian-based mode)"))
    return (false);

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];

  ClearRequestFields(state);

  state.m_needfgh = true;
  state.m_rstate.stage = 7;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_24(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  if (!CAp::Assert(state.m_deltaxready && state.m_deltafready,
                   "MinLMIteration: uninitialized DeltaX/DeltaF"))
    return (false);
  t = 0.0;
  for (int i_ = 0; i_ <= n - 1; i_++)
    t += state.m_deltax[i_] * state.m_deltax[i_];

  if (!CAp::Assert(t != 0.0, "MinLM: internal error (T=0)"))
    return (false);
  for (i = 0; i <= m - 1; i++) {

    v = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      v += state.m_j[i][i_] * state.m_deltax[i_];
    v = (state.m_deltaf[i] - v) / t;
    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_j[i].Set(i_, state.m_j[i][i_] + v * state.m_deltax[i_]);
  }
  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_fi[i_] = state.m_fibase[i_];
  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_fi[i_] = state.m_fi[i_] + state.m_deltaf[i_];

  state.m_modelage = state.m_modelage + 1;

  return (Func_lbl_25(state, n, m, iflag, i, k, bflag, v, s, t));
}

static bool CMinLM::Func_lbl_25(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  CAblas::RMatrixGemm(n, n, m, 2.0, state.m_j, 0, 0, 1, state.m_j, 0, 0, 0, 0.0,
                      state.m_quadraticmodel, 0, 0);
  CAblas::RMatrixMVect(n, m, state.m_j, 0, 0, 1, state.m_fi, 0, state.m_gbase,
                       0);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_gbase[i_] = 2 * state.m_gbase[i_];

  v = 0.0;
  for (int i_ = 0; i_ <= m - 1; i_++)
    v += state.m_fi[i_] * state.m_fi[i_];
  state.m_fbase = v;

  for (int i_ = 0; i_ <= m - 1; i_++)
    state.m_fibase[i_] = state.m_fi[i_];

  bflag = true;

  return (Func_lbl_22(state, n, m, iflag, i, k, bflag, v, s, t));
}

static bool CMinLM::Func_lbl_28(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  if (k > n - 1) {

    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_x[i_] = state.m_xbase[i_];

    ClearRequestFields(state);

    state.m_needfi = true;
    state.m_rstate.stage = 5;

    Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

    return (true);
  }

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  state.m_x[k] = state.m_x[k] - state.m_s[k] * state.m_diffstep;

  if (state.m_havebndl[k])
    state.m_x[k] = MathMax(state.m_x[k], state.m_bndl[k]);

  if (state.m_havebndu[k])
    state.m_x[k] = MathMin(state.m_x[k], state.m_bndu[k]);
  state.m_xm1 = state.m_x[k];

  ClearRequestFields(state);

  state.m_needfi = true;
  state.m_rstate.stage = 3;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_31(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  if (!CAp::Assert(bflag, "MinLM: internal integrity check failed!"))
    return (false);

  state.m_deltaxready = false;
  state.m_deltafready = false;

  if (state.m_lambdav < 0.0) {
    state.m_lambdav = 0;
    for (i = 0; i <= n - 1; i++)
      state.m_lambdav =
          MathMax(state.m_lambdav, MathAbs(state.m_quadraticmodel[i][i]) *
                                       CMath::Sqr(state.m_s[i]));
    state.m_lambdav = 0.001 * state.m_lambdav;

    if (state.m_lambdav == 0.0)
      state.m_lambdav = 1;
  }

  if (BoundedScaledAntigradNorm(state, state.m_xbase, state.m_gbase) >
      state.m_epsg) {

    iflag = -99;

    return (Func_lbl_39(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (state.m_modelage != 0) {

    state.m_modelage = state.m_maxmodelage + 1;

    return (Func_lbl_20(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  state.m_repterminationtype = 4;

  if (!state.m_xrep)
    return (false);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  state.m_f = state.m_fbase;

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 8;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_39(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  if (state.m_modelage > 0 && state.m_nu >= m_suspiciousnu) {
    iflag = -2;

    return (Func_lbl_40(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  bflag = true;

  CMinQP::MinQPSetStartingPointFast(state.m_qpstate, state.m_xbase);

  CMinQP::MinQPSetOriginFast(state.m_qpstate, state.m_xbase);

  CMinQP::MinQPSetLinearTermFast(state.m_qpstate, state.m_gbase);

  CMinQP::MinQPSetQuadraticTermFast(state.m_qpstate, state.m_quadraticmodel,
                                    true, 0.0);
  for (i = 0; i <= n - 1; i++)
    state.m_tmp0[i] = state.m_quadraticmodel[i][i] +
                      state.m_lambdav / CMath::Sqr(state.m_s[i]);

  CMinQP::MinQPRewriteDiagonal(state.m_qpstate, state.m_tmp0);

  CMinQP::MinQPOptimize(state.m_qpstate);

  CMinQP::MinQPResultsBuf(state.m_qpstate, state.m_xdir, state.m_qprep);

  if (state.m_qprep.m_terminationtype > 0) {

    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_xdir[i_] = state.m_xdir[i_] - state.m_xbase[i_];
    v = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      v += state.m_xdir[i_] * state.m_xdir[i_];

    if (CMath::IsFinite(v)) {
      v = MathSqrt(v);

      if ((state.m_stpmax > 0.0) && (v > state.m_stpmax))
        bflag = false;
    } else
      bflag = false;
  } else {

    if (!CAp::Assert(state.m_qprep.m_terminationtype == -3 ||
                         state.m_qprep.m_terminationtype == -5,
                     "MinLM: unexpected completion code from QP solver"))
      return (false);

    if (state.m_qprep.m_terminationtype == -3) {
      iflag = -3;

      return (Func_lbl_40(state, n, m, iflag, i, k, bflag, v, s, t));
    }
    bflag = false;
  }

  if (!bflag) {

    if (!IncreaseLambda(state.m_lambdav, state.m_nu)) {
      iflag = -1;

      return (Func_lbl_40(state, n, m, iflag, i, k, bflag, v, s, t));
    }

    return (Func_lbl_39(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_deltax[i_] = state.m_xbase[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_deltax[i_] = state.m_deltax[i_] + state.m_xdir[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_deltax[i_] = state.m_deltax[i_] - state.m_xbase[i_];
  state.m_deltaxready = true;

  v = 0.0;
  for (i = 0; i <= n - 1; i++)
    v = v + CMath::Sqr(state.m_deltax[i] / state.m_s[i]);
  v = MathSqrt(v);

  if (v > state.m_epsx)
    return (Func_lbl_41(state, n, m, iflag, i, k, bflag, v, s, t));

  if (state.m_modelage != 0) {

    iflag = -2;

    return (Func_lbl_40(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  state.m_repterminationtype = 2;
  if (!state.m_xrep)
    return (false);

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  state.m_f = state.m_fbase;

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 9;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_40(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {
  state.m_nu = 1;

  if (!CAp::Assert(iflag >= -3 && iflag <= 0,
                   "MinLM: internal integrity check failed!"))
    return (false);

  if (iflag == -3) {
    state.m_repterminationtype = -3;

    return (false);
  }

  if (iflag == -2) {
    state.m_modelage = state.m_maxmodelage + 1;

    return (Func_lbl_20(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (iflag == -1)
    return (Func_lbl_21(state, n, m, iflag, i, k, bflag, v, s, t));

  if (!CAp::Assert(state.m_deltaxready, "MinLM: deltaX is not ready"))
    return (false);
  t = 0;
  for (i = 0; i <= n - 1; i++) {

    v = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      v += state.m_quadraticmodel[i][i_] * state.m_deltax[i_];
    t = t + state.m_deltax[i] * state.m_gbase[i] + 0.5 * state.m_deltax[i] * v;
  }

  state.m_predicteddecrease = -t;
  state.m_actualdecrease = -(state.m_f - state.m_fbase);

  if (state.m_predicteddecrease <= 0.0)
    return (Func_lbl_21(state, n, m, iflag, i, k, bflag, v, s, t));
  v = state.m_actualdecrease / state.m_predicteddecrease;

  if (v >= 0.1)
    return (Func_lbl_49(state, n, m, iflag, i, k, bflag, v, s, t));

  if (IncreaseLambda(state.m_lambdav, state.m_nu))
    return (Func_lbl_49(state, n, m, iflag, i, k, bflag, v, s, t));

  state.m_repterminationtype = 7;

  if (!state.m_xrep)
    return (false);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  state.m_f = state.m_fbase;

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 12;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_41(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  if (!CAp::Assert(state.m_hasfi | state.m_hasf, "MinLM: internal error 2!"))
    return (false);
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_x[i_] + state.m_xdir[i_];

  ClearRequestFields(state);

  if (!state.m_hasfi) {

    state.m_needf = true;
    state.m_rstate.stage = 11;

    Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

    return (true);
  }

  state.m_needfi = true;
  state.m_rstate.stage = 10;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_48(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {
  state.m_repnfunc = state.m_repnfunc + 1;

  if (state.m_f >= state.m_fbase) {

    if (!IncreaseLambda(state.m_lambdav, state.m_nu)) {
      iflag = -1;

      return (Func_lbl_40(state, n, m, iflag, i, k, bflag, v, s, t));
    }

    return (Func_lbl_39(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  iflag = 0;

  return (Func_lbl_40(state, n, m, iflag, i, k, bflag, v, s, t));
}

static bool CMinLM::Func_lbl_49(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {

  if (v > 0.5)
    DecreaseLambda(state.m_lambdav, state.m_nu);

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xbase[i_] = state.m_xbase[i_] + state.m_deltax[i_];

  if (!state.m_xrep)
    return (Func_lbl_55(state, n, m, iflag, i, k, bflag, v, s, t));
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 13;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

static bool CMinLM::Func_lbl_55(CMinLMState &state, int &n, int &m, int &iflag,
                                int &i, int &k, bool &bflag, double &v,
                                double &s, double &t) {
  state.m_repiterationscount = state.m_repiterationscount + 1;

  if (state.m_repiterationscount >= state.m_maxits && state.m_maxits > 0)
    state.m_repterminationtype = 5;

  if (state.m_modelage == 0) {

    if (MathAbs(state.m_f - state.m_fbase) <=
        state.m_epsf *
            MathMax(1, MathMax(MathAbs(state.m_f), MathAbs(state.m_fbase))))
      state.m_repterminationtype = 1;
  }

  if (state.m_repterminationtype <= 0) {
    state.m_modelage = state.m_modelage + 1;

    return (Func_lbl_20(state, n, m, iflag, i, k, bflag, v, s, t));
  }

  if (!state.m_xrep)
    return (false);

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xbase[i_];

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 14;

  Func_lbl_rcomm(state, n, m, iflag, i, k, bflag, v, s, t);

  return (true);
}

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

  double m_bndl[];
  double m_bndu[];
  double m_ak[];
  double m_xk[];
  double m_dk[];
  double m_an[];
  double m_xn[];
  double m_dn[];
  double m_d[];
  double m_work[];
  double m_yk[];
  double m_gc[];
  double m_x[];
  double m_g[];

  CMinASAState(void);
  ~CMinASAState(void);

  void Copy(CMinASAState &obj);
};

CMinASAState::CMinASAState(void) {
}

CMinASAState::~CMinASAState(void) {
}

void CMinASAState::Copy(CMinASAState &obj) {

  m_n = obj.m_n;
  m_epsg = obj.m_epsg;
  m_epsf = obj.m_epsf;
  m_epsx = obj.m_epsx;
  m_maxits = obj.m_maxits;
  m_xrep = obj.m_xrep;
  m_stpmax = obj.m_stpmax;
  m_cgtype = obj.m_cgtype;
  m_k = obj.m_k;
  m_nfev = obj.m_nfev;
  m_mcstage = obj.m_mcstage;
  m_curalgo = obj.m_curalgo;
  m_acount = obj.m_acount;
  m_mu = obj.m_mu;
  m_finit = obj.m_finit;
  m_dginit = obj.m_dginit;
  m_fold = obj.m_fold;
  m_stp = obj.m_stp;
  m_laststep = obj.m_laststep;
  m_f = obj.m_f;
  m_needfg = obj.m_needfg;
  m_xupdated = obj.m_xupdated;
  m_repiterationscount = obj.m_repiterationscount;
  m_repnfev = obj.m_repnfev;
  m_repterminationtype = obj.m_repterminationtype;
  m_debugrestartscount = obj.m_debugrestartscount;
  m_betahs = obj.m_betahs;
  m_betady = obj.m_betady;
  m_rstate.Copy(obj.m_rstate);
  m_lstate.Copy(obj.m_lstate);

  ArrayCopy(m_bndl, obj.m_bndl);
  ArrayCopy(m_bndu, obj.m_bndu);
  ArrayCopy(m_ak, obj.m_ak);
  ArrayCopy(m_xk, obj.m_xk);
  ArrayCopy(m_dk, obj.m_dk);
  ArrayCopy(m_an, obj.m_an);
  ArrayCopy(m_xn, obj.m_xn);
  ArrayCopy(m_dn, obj.m_dn);
  ArrayCopy(m_d, obj.m_d);
  ArrayCopy(m_work, obj.m_work);
  ArrayCopy(m_yk, obj.m_yk);
  ArrayCopy(m_gc, obj.m_gc);
  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_g, obj.m_g);
}

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

CMinASAStateShell::CMinASAStateShell(void) {
}

CMinASAStateShell::CMinASAStateShell(CMinASAState &obj) {

  m_innerobj.Copy(obj);
}

CMinASAStateShell::~CMinASAStateShell(void) {
}

bool CMinASAStateShell::GetNeedFG(void) {

  return (m_innerobj.m_needfg);
}

void CMinASAStateShell::SetNeedFG(const bool b) {

  m_innerobj.m_needfg = b;
}

bool CMinASAStateShell::GetXUpdated(void) {

  return (m_innerobj.m_xupdated);
}

void CMinASAStateShell::SetXUpdated(const bool b) {

  m_innerobj.m_xupdated = b;
}

double CMinASAStateShell::GetF(void) {

  return (m_innerobj.m_f);
}

void CMinASAStateShell::SetF(const double d) {

  m_innerobj.m_f = d;
}

CMinASAState *CMinASAStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

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

CMinASAReport::CMinASAReport(void) {
}

CMinASAReport::~CMinASAReport(void) {
}

void CMinASAReport::Copy(CMinASAReport &obj) {

  m_iterationscount = obj.m_iterationscount;
  m_nfev = obj.m_nfev;
  m_terminationtype = obj.m_terminationtype;
  m_activeconstraints = obj.m_activeconstraints;
}

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

CMinASAReportShell::CMinASAReportShell(void) {
}

CMinASAReportShell::CMinASAReportShell(CMinASAReport &obj) {

  m_innerobj.Copy(obj);
}

CMinASAReportShell::~CMinASAReportShell(void) {
}

int CMinASAReportShell::GetIterationsCount(void) {

  return (m_innerobj.m_iterationscount);
}

void CMinASAReportShell::SetIterationsCount(const int i) {

  m_innerobj.m_iterationscount = i;
}

int CMinASAReportShell::GetNFev(void) {

  return (m_innerobj.m_nfev);
}

void CMinASAReportShell::SetNFev(const int i) {

  m_innerobj.m_nfev = i;
}

int CMinASAReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CMinASAReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

int CMinASAReportShell::GetActiveConstraints(void) {

  return (m_innerobj.m_activeconstraints);
}

void CMinASAReportShell::SetActiveConstraints(const int i) {

  m_innerobj.m_activeconstraints = i;
}

CMinASAReport *CMinASAReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

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
  static void MinASACreate(const int n, double &x[], double &bndl[],
                           double &bndu[], CMinASAState &state);
  static void MinASASetCond(CMinASAState &state, const double epsg,
                            const double epsf, double epsx, const int maxits);
  static void MinASASetXRep(CMinASAState &state, const bool needxrep);
  static void MinASASetAlgorithm(CMinASAState &state, int algotype);
  static void MinASASetStpMax(CMinASAState &state, const double stpmax);
  static void MinASAResults(CMinASAState &state, double &x[],
                            CMinASAReport &rep);
  static void MinASAResultsBuf(CMinASAState &state, double &x[],
                               CMinASAReport &rep);
  static void MinASARestartFrom(CMinASAState &state, double &x[],
                                double &bndl[], double &bndu[]);
  static bool MinASAIteration(CMinASAState &state);
};

const int CMinComp::m_n1 = 2;
const int CMinComp::m_n2 = 2;
const double CMinComp::m_stpmin = 1.0E-300;
const double CMinComp::m_gtol = 0.3;
const double CMinComp::m_gpaftol = 0.0001;
const double CMinComp::m_gpadecay = 0.5;
const double CMinComp::m_asarho = 0.5;

CMinComp::CMinComp(void) {
}

CMinComp::~CMinComp(void) {
}

static void CMinComp::MinLBFGSSetDefaultPreconditioner(CMinLBFGSState &state) {

  CMinLBFGS::MinLBFGSSetPrecDefault(state);
}

static void CMinComp::MinLBFGSSetCholeskyPreconditioner(CMinLBFGSState &state,
                                                        CMatrixDouble &p,
                                                        const bool isupper) {

  CMinLBFGS::MinLBFGSSetPrecCholesky(state, p, isupper);
}

static void CMinComp::MinBLEICSetBarrierWidth(CMinBLEICState &state,
                                              const double mu) {
}

static void CMinComp::MinBLEICSetBarrierDecay(CMinBLEICState &state,
                                              const double mudecay) {
}

static void CMinComp::MinASACreate(const int n, double &x[], double &bndl[],
                                   double &bndu[], CMinASAState &state) {

  int i = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N too small!"))
    return;

  if (!CAp::Assert(CAp::Len(x) >= n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(bndl) >= n, __FUNCTION__ + ": Length(BndL)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(bndl, n),
                   __FUNCTION__ + ": BndL contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(bndu) >= n, __FUNCTION__ + ": Length(BndU)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(bndu, n),
                   __FUNCTION__ + ": BndU contains infinite or NaN values!"))
    return;
  for (i = 0; i <= n - 1; i++) {

    if (!CAp::Assert((double)(bndl[i]) <= (double)(bndu[i]),
                     __FUNCTION__ + ": inconsistent bounds!"))
      return;

    if (!CAp::Assert((double)(bndl[i]) <= x[i],
                     __FUNCTION__ + ": infeasible X!"))
      return;

    if (!CAp::Assert(x[i] <= (double)(bndu[i]),
                     __FUNCTION__ + ": infeasible X!"))
      return;
  }

  state.m_n = n;
  MinASASetCond(state, 0, 0, 0, 0);
  MinASASetXRep(state, false);
  MinASASetStpMax(state, 0);
  MinASASetAlgorithm(state, -1);

  ArrayResizeAL(state.m_bndl, n);
  ArrayResizeAL(state.m_bndu, n);
  ArrayResizeAL(state.m_ak, n);
  ArrayResizeAL(state.m_xk, n);
  ArrayResizeAL(state.m_dk, n);
  ArrayResizeAL(state.m_an, n);
  ArrayResizeAL(state.m_xn, n);
  ArrayResizeAL(state.m_dn, n);
  ArrayResizeAL(state.m_x, n);
  ArrayResizeAL(state.m_d, n);
  ArrayResizeAL(state.m_g, n);
  ArrayResizeAL(state.m_gc, n);
  ArrayResizeAL(state.m_work, n);
  ArrayResizeAL(state.m_yk, n);

  MinASARestartFrom(state, x, bndl, bndu);
}

static void CMinComp::MinASASetCond(CMinASAState &state, const double epsg,
                                    const double epsf, double epsx,
                                    const int maxits) {

  if (!CAp::Assert(CMath::IsFinite(epsg),
                   __FUNCTION__ + ": EpsG is not finite number!"))
    return;

  if (!CAp::Assert(epsg >= 0.0, __FUNCTION__ + ": negative EpsG!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsf),
                   __FUNCTION__ + ": EpsF is not finite number!"))
    return;

  if (!CAp::Assert(epsf >= 0.0, __FUNCTION__ + ": negative EpsF!"))
    return;

  if (!CAp::Assert(CMath::IsFinite(epsx),
                   __FUNCTION__ + ": EpsX is not finite number!"))
    return;

  if (!CAp::Assert(epsx >= 0.0, __FUNCTION__ + ": negative EpsX!"))
    return;

  if (!CAp::Assert(maxits >= 0, __FUNCTION__ + ": negative MaxIts!"))
    return;

  if (((epsg == 0.0 && epsf == 0.0) && epsx == 0.0) && maxits == 0)
    epsx = 1.0E-6;

  state.m_epsg = epsg;
  state.m_epsf = epsf;
  state.m_epsx = epsx;
  state.m_maxits = maxits;
}

static void CMinComp::MinASASetXRep(CMinASAState &state, const bool needxrep) {

  state.m_xrep = needxrep;
}

static void CMinComp::MinASASetAlgorithm(CMinASAState &state, int algotype) {

  if (!CAp::Assert(algotype >= -1 && algotype <= 1,
                   __FUNCTION__ + ": incorrect AlgoType!"))
    return;

  if (algotype == -1)
    algotype = 1;

  state.m_cgtype = algotype;
}

static void CMinComp::MinASASetStpMax(CMinASAState &state,
                                      const double stpmax) {

  if (!CAp::Assert(CMath::IsFinite(stpmax),
                   __FUNCTION__ + ": StpMax is not finite!"))
    return;

  if (!CAp::Assert(stpmax >= 0.0, __FUNCTION__ + ": StpMax<0!"))
    return;

  state.m_stpmax = stpmax;
}

static void CMinComp::MinASAResults(CMinASAState &state, double &x[],
                                    CMinASAReport &rep) {

  ArrayResizeAL(x, 0);

  MinASAResultsBuf(state, x, rep);
}

static void CMinComp::MinASAResultsBuf(CMinASAState &state, double &x[],
                                       CMinASAReport &rep) {

  int i = 0;
  int i_ = 0;

  if (CAp::Len(x) < state.m_n)
    ArrayResizeAL(x, state.m_n);

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    x[i_] = state.m_x[i_];

  rep.m_iterationscount = state.m_repiterationscount;
  rep.m_nfev = state.m_repnfev;
  rep.m_terminationtype = state.m_repterminationtype;
  rep.m_activeconstraints = 0;
  for (i = 0; i <= state.m_n - 1; i++) {

    if (state.m_ak[i] == 0.0)
      rep.m_activeconstraints = rep.m_activeconstraints + 1;
  }
}

static void CMinComp::MinASARestartFrom(CMinASAState &state, double &x[],
                                        double &bndl[], double &bndu[]) {

  int i_ = 0;

  if (!CAp::Assert(CAp::Len(x) >= state.m_n, __FUNCTION__ + ": Length(X)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(x, state.m_n),
                   __FUNCTION__ + ": X contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(bndl) >= state.m_n,
                   __FUNCTION__ + ": Length(BndL)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(bndl, state.m_n),
                   __FUNCTION__ + ": BndL contains infinite or NaN values!"))
    return;

  if (!CAp::Assert(CAp::Len(bndu) >= state.m_n,
                   __FUNCTION__ + ": Length(BndU)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteVector(bndu, state.m_n),
                   __FUNCTION__ + ": BndU contains infinite or NaN values!"))
    return;

  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    state.m_x[i_] = x[i_];
  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    state.m_bndl[i_] = bndl[i_];
  for (i_ = 0; i_ <= state.m_n - 1; i_++)
    state.m_bndu[i_] = bndu[i_];
  state.m_laststep = 0;

  ArrayResizeAL(state.m_rstate.ia, 4);
  ArrayResizeAL(state.m_rstate.ba, 2);
  ArrayResizeAL(state.m_rstate.ra, 3);
  state.m_rstate.stage = -1;

  ClearRequestFields(state);
}

static double CMinComp::ASABoundedAntigradNorm(CMinASAState &state) {

  double result = 0;
  int i = 0;
  double v = 0;

  result = 0;
  for (i = 0; i <= state.m_n - 1; i++) {
    v = -state.m_g[i];

    if (state.m_x[i] == state.m_bndl[i] && -state.m_g[i] < 0.0)
      v = 0;

    if (state.m_x[i] == state.m_bndu[i] && -state.m_g[i] > 0.0)
      v = 0;
    result = result + CMath::Sqr(v);
  }

  return (MathSqrt(result));
}

static double CMinComp::ASAGINorm(CMinASAState &state) {

  double result = 0;
  int i = 0;

  result = 0;
  for (i = 0; i <= state.m_n - 1; i++) {

    if (state.m_x[i] != state.m_bndl[i] && state.m_x[i] != state.m_bndu[i])
      result = result + CMath::Sqr(state.m_g[i]);
  }

  return (MathSqrt(result));
}

static double CMinComp::ASAD1Norm(CMinASAState &state) {

  double result = 0;
  int i = 0;

  result = 0;
  for (i = 0; i <= state.m_n - 1; i++)
    result = result +
             CMath::Sqr(CApServ::BoundVal(state.m_x[i] - state.m_g[i],
                                          state.m_bndl[i], state.m_bndu[i]) -
                        state.m_x[i]);

  return (MathSqrt(result));
}

static bool CMinComp::ASAUIsEmpty(CMinASAState &state) {

  int i = 0;
  double d = 0;
  double d2 = 0;
  double d32 = 0;

  d = ASAD1Norm(state);
  d2 = MathSqrt(d);
  d32 = d * d2;
  for (i = 0; i <= state.m_n - 1; i++) {

    if (MathAbs(state.m_g[i]) >= d2 &&
        MathMin(state.m_x[i] - state.m_bndl[i],
                state.m_bndu[i] - state.m_x[i]) >= d32)
      return (false);
  }

  return (true);
}

static void CMinComp::ClearRequestFields(CMinASAState &state) {

  state.m_needfg = false;
  state.m_xupdated = false;
}

static bool CMinComp::MinASAIteration(CMinASAState &state) {

  int n = 0;
  int i = 0;
  double betak = 0;
  double v = 0;
  double vv = 0;
  int mcinfo = 0;
  bool b;
  bool stepfound;
  int diffcnt = 0;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    i = state.m_rstate.ia[1];
    mcinfo = state.m_rstate.ia[2];
    diffcnt = state.m_rstate.ia[3];
    b = state.m_rstate.ba[0];
    stepfound = state.m_rstate.ba[1];
    betak = state.m_rstate.ra[0];
    v = state.m_rstate.ra[1];
    vv = state.m_rstate.ra[2];
  } else {

    n = -983;
    i = -989;
    mcinfo = -834;
    diffcnt = 900;
    b = true;
    stepfound = false;
    betak = 214;
    v = -338;
    vv = -686;
  }

  if (state.m_rstate.stage == 0) {

    state.m_needfg = false;

    if (!state.m_xrep)
      return (Func_lbl_15(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v,
                          vv));

    ClearRequestFields(state);
    state.m_xupdated = true;
    state.m_rstate.stage = 1;

    Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

    return (true);
  }

  if (state.m_rstate.stage == 1) {

    state.m_xupdated = false;

    return (
        Func_lbl_15(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  if (state.m_rstate.stage == 2) {

    state.m_needfg = false;
    state.m_repnfev = state.m_repnfev + 1;
    stepfound = state.m_f <= state.m_finit + m_gpaftol * state.m_dginit;

    return (
        Func_lbl_24(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  if (state.m_rstate.stage == 3) {

    state.m_needfg = false;
    state.m_repnfev = state.m_repnfev + 1;

    if (state.m_stp <= m_stpmin) {
      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_xn[i_] = state.m_x[i_];

      return (Func_lbl_26(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v,
                          vv));
    }

    if (state.m_f <= state.m_finit + state.m_stp * m_gpaftol * state.m_dginit) {

      for (i_ = 0; i_ <= n - 1; i_++)
        state.m_xn[i_] = state.m_x[i_];

      return (Func_lbl_26(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v,
                          vv));
    }

    state.m_stp = state.m_stp * m_gpadecay;

    return (
        Func_lbl_27(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  if (state.m_rstate.stage == 4) {

    state.m_xupdated = false;

    return (
        Func_lbl_29(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  if (state.m_rstate.stage == 5) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 6) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 7) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 8) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 9) {

    state.m_needfg = false;

    for (i = 0; i <= n - 1; i++) {

      if (state.m_x[i] == state.m_bndl[i] || state.m_x[i] == state.m_bndu[i])
        state.m_gc[i] = 0;
      else
        state.m_gc[i] = state.m_g[i];
    }
    CLinMin::MCSrch(n, state.m_xn, state.m_f, state.m_gc, state.m_d,
                    state.m_stp, state.m_stpmax, m_gtol, mcinfo, state.m_nfev,
                    state.m_work, state.m_lstate, state.m_mcstage);

    return (
        Func_lbl_51(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  if (state.m_rstate.stage == 10) {

    state.m_xupdated = false;

    return (
        Func_lbl_53(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  if (state.m_rstate.stage == 11) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 12) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 13) {

    state.m_xupdated = false;

    return (false);
  }

  if (state.m_rstate.stage == 14) {

    state.m_xupdated = false;

    return (false);
  }

  n = state.m_n;
  state.m_repterminationtype = 0;
  state.m_repiterationscount = 0;
  state.m_repnfev = 0;
  state.m_debugrestartscount = 0;
  state.m_cgtype = 1;

  for (i_ = 0; i_ <= n - 1; i_++)
    state.m_xk[i_] = state.m_x[i_];
  for (i = 0; i <= n - 1; i++) {

    if (state.m_xk[i] == state.m_bndl[i] || state.m_xk[i] == state.m_bndu[i])
      state.m_ak[i] = 0;
    else
      state.m_ak[i] = 1;
  }

  state.m_mu = 0.1;
  state.m_curalgo = 0;

  ClearRequestFields(state);

  state.m_needfg = true;
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static void CMinComp::Func_lbl_rcomm(CMinASAState &state, int n, int i,
                                     int mcinfo, int diffcnt, bool b,
                                     bool stepfound, double betak, double v,
                                     double vv) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ia[1] = i;
  state.m_rstate.ia[2] = mcinfo;
  state.m_rstate.ia[3] = diffcnt;
  state.m_rstate.ba[0] = b;
  state.m_rstate.ba[1] = stepfound;
  state.m_rstate.ra[0] = betak;
  state.m_rstate.ra[1] = v;
  state.m_rstate.ra[2] = vv;
}

static bool CMinComp::Func_lbl_15(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (ASABoundedAntigradNorm(state) <= state.m_epsg) {
    state.m_repterminationtype = 4;

    return (false);
  }
  state.m_repnfev = state.m_repnfev + 1;

  return (
      Func_lbl_17(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
}

static bool CMinComp::Func_lbl_17(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (state.m_curalgo != 0)
    return (
        Func_lbl_19(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_k = 0;
  state.m_acount = 0;

  return (
      Func_lbl_21(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
}

static bool CMinComp::Func_lbl_19(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (state.m_curalgo != 1)
    return (
        Func_lbl_17(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  b = true;
  for (i = 0; i <= n - 1; i++) {

    if (state.m_ak[i] != 0.0) {
      b = false;
      break;
    }
  }

  if (b) {
    state.m_curalgo = 0;

    return (
        Func_lbl_17(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  state.m_fold = state.m_f;
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xk[i_] = state.m_x[i_];
  for (i = 0; i <= n - 1; i++) {

    state.m_dk[i] = -(state.m_g[i] * state.m_ak[i]);
    state.m_gc[i] = state.m_g[i] * state.m_ak[i];
  }

  return (
      Func_lbl_49(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
}

static bool CMinComp::Func_lbl_21(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  for (i = 0; i <= n - 1; i++)
    state.m_d[i] = CApServ::BoundVal(state.m_xk[i] - state.m_g[i],
                                     state.m_bndl[i], state.m_bndu[i]) -
                   state.m_xk[i];

  v = 0.0;
  for (int i_ = 0; i_ <= n - 1; i_++)
    v += state.m_d[i_] * state.m_g[i_];

  state.m_dginit = v;
  state.m_finit = state.m_f;

  if (!(ASAD1Norm(state) <= state.m_stpmax || state.m_stpmax == 0.0)) {
    stepfound = false;

    return (
        Func_lbl_24(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  for (i = 0; i <= n - 1; i++)
    state.m_x[i] = CApServ::BoundVal(state.m_xk[i] - state.m_g[i],
                                     state.m_bndl[i], state.m_bndu[i]);

  ClearRequestFields(state);

  state.m_needfg = true;
  state.m_rstate.stage = 2;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_24(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (!stepfound) {

    state.m_stp = 1;

    CLinMin::LinMinNormalized(state.m_d, state.m_stp, n);

    state.m_dginit = state.m_dginit / state.m_stp;
    state.m_stp = m_gpadecay * state.m_stp;

    if (state.m_stpmax > 0.0)
      state.m_stp = MathMin(state.m_stp, state.m_stpmax);

    return (
        Func_lbl_27(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xn[i_] = state.m_x[i_];
  state.m_stp = 1;

  return (
      Func_lbl_26(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
}

static bool CMinComp::Func_lbl_26(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {
  state.m_repiterationscount = state.m_repiterationscount + 1;

  if (!state.m_xrep)
    return (
        Func_lbl_29(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 4;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_27(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {
  v = state.m_stp;

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_xk[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_x[i_] = state.m_x[i_] + v * state.m_d[i_];
  ClearRequestFields(state);

  state.m_needfg = true;
  state.m_rstate.stage = 3;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_29(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  for (i = 0; i <= n - 1; i++) {

    if (state.m_xn[i] == state.m_bndl[i] || state.m_xn[i] == state.m_bndu[i])
      state.m_an[i] = 0;
    else
      state.m_an[i] = 1;
  }
  for (i = 0; i <= n - 1; i++) {

    if (state.m_ak[i] != state.m_an[i]) {
      state.m_acount = -1;
      break;
    }
  }
  state.m_acount = state.m_acount + 1;

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xk[i_] = state.m_xn[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_ak[i_] = state.m_an[i_];

  if (!(state.m_repiterationscount >= state.m_maxits && state.m_maxits > 0))
    return (
        Func_lbl_31(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_repterminationtype = 5;

  if (!state.m_xrep)
    return (false);

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 5;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_31(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (ASABoundedAntigradNorm(state) > state.m_epsg)
    return (
        Func_lbl_35(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_repterminationtype = 4;

  if (!state.m_xrep)
    return (false);

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 6;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_35(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  v = 0.0;
  for (int i_ = 0; i_ <= n - 1; i_++)
    v += state.m_d[i_] * state.m_d[i_];

  if (MathSqrt(v) * state.m_stp > state.m_epsx)
    return (
        Func_lbl_39(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_repterminationtype = 2;

  if (!state.m_xrep)
    return (false);

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 7;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_39(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (state.m_finit - state.m_f >
      state.m_epsf *
          MathMax(MathAbs(state.m_finit), MathMax(MathAbs(state.m_f), 1.0)))
    return (
        Func_lbl_43(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_repterminationtype = 1;

  if (!state.m_xrep)
    return (false);
  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 8;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_43(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (ASAUIsEmpty(state)) {

    if (ASAGINorm(state) >= state.m_mu * ASAD1Norm(state)) {
      state.m_curalgo = 1;

      return (Func_lbl_19(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v,
                          vv));
    } else
      state.m_mu = state.m_mu * m_asarho;
  } else {

    if (state.m_acount == m_n1) {

      if (ASAGINorm(state) >= state.m_mu * ASAD1Norm(state)) {
        state.m_curalgo = 1;

        return (Func_lbl_19(state, n, i, mcinfo, diffcnt, b, stepfound, betak,
                            v, vv));
      }
    }
  }

  state.m_k = state.m_k + 1;

  return (
      Func_lbl_21(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
}

static bool CMinComp::Func_lbl_49(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  for (i = 0; i <= n - 1; i++)
    state.m_yk[i] = -state.m_gc[i];

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_d[i_] = state.m_dk[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xn[i_] = state.m_xk[i_];

  state.m_mcstage = 0;
  state.m_stp = 1;

  CLinMin::LinMinNormalized(state.m_d, state.m_stp, n);

  if (state.m_laststep != 0.0)
    state.m_stp = state.m_laststep;

  CLinMin::MCSrch(n, state.m_xn, state.m_f, state.m_gc, state.m_d, state.m_stp,
                  state.m_stpmax, m_gtol, mcinfo, state.m_nfev, state.m_work,
                  state.m_lstate, state.m_mcstage);

  return (
      Func_lbl_51(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
}

static bool CMinComp::Func_lbl_51(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (state.m_mcstage == 0)
    return (
        Func_lbl_52(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  for (i = 0; i <= n - 1; i++)
    state.m_x[i] =
        CApServ::BoundVal(state.m_xn[i], state.m_bndl[i], state.m_bndu[i]);

  ClearRequestFields(state);

  state.m_needfg = true;
  state.m_rstate.stage = 9;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_52(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {
  diffcnt = 0;
  for (i = 0; i <= n - 1; i++) {

    state.m_xn[i] =
        CApServ::BoundVal(state.m_xn[i], state.m_bndl[i], state.m_bndu[i]);

    if (state.m_xn[i] == state.m_bndl[i] || state.m_xn[i] == state.m_bndu[i])
      state.m_an[i] = 0;
    else
      state.m_an[i] = 1;

    if (state.m_an[i] != state.m_ak[i])
      diffcnt = diffcnt + 1;
    state.m_ak[i] = state.m_an[i];
  }
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_xk[i_] = state.m_xn[i_];

  state.m_repnfev = state.m_repnfev + state.m_nfev;
  state.m_repiterationscount = state.m_repiterationscount + 1;

  if (!state.m_xrep)
    return (
        Func_lbl_53(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 10;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_53(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  v = 0.0;
  for (int i_ = 0; i_ <= n - 1; i_++)
    v += state.m_d[i_] * state.m_d[i_];
  state.m_laststep = MathSqrt(v) * state.m_stp;

  if (ASABoundedAntigradNorm(state) > state.m_epsg)
    return (
        Func_lbl_55(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_repterminationtype = 4;

  if (!state.m_xrep)
    return (false);
  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 11;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_55(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (!(state.m_repiterationscount >= state.m_maxits && state.m_maxits > 0))
    return (
        Func_lbl_59(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_repterminationtype = 5;

  if (!state.m_xrep)
    return (false);
  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 12;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_59(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (!(ASAGINorm(state) >= state.m_mu * ASAD1Norm(state) && diffcnt == 0))
    return (
        Func_lbl_63(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  if (state.m_fold - state.m_f >
      state.m_epsf *
          MathMax(MathAbs(state.m_fold), MathMax(MathAbs(state.m_f), 1.0)))
    return (
        Func_lbl_65(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_repterminationtype = 1;
  if (!state.m_xrep)
    return (false);

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 13;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

static bool CMinComp::Func_lbl_63(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (ASAGINorm(state) < state.m_mu * ASAD1Norm(state)) {
    state.m_curalgo = 0;

    return (
        Func_lbl_17(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  if (diffcnt > 0) {

    if (ASAUIsEmpty(state) || diffcnt >= m_n2)
      state.m_curalgo = 1;
    else
      state.m_curalgo = 0;

    return (
        Func_lbl_17(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
  }

  if (mcinfo == 1) {

    for (int i_ = 0; i_ <= n - 1; i_++)
      state.m_yk[i_] = state.m_yk[i_] + state.m_gc[i_];

    vv = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      vv += state.m_yk[i_] * state.m_dk[i_];

    v = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      v += state.m_gc[i_] * state.m_gc[i_];
    state.m_betady = v / vv;

    v = 0.0;
    for (int i_ = 0; i_ <= n - 1; i_++)
      v += state.m_gc[i_] * state.m_yk[i_];
    state.m_betahs = v / vv;

    if (state.m_cgtype == 0)
      betak = state.m_betady;

    if (state.m_cgtype == 1)
      betak = MathMax(0, MathMin(state.m_betady, state.m_betahs));
  } else {

    betak = 0;
    state.m_debugrestartscount = state.m_debugrestartscount + 1;
  }

  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_dn[i_] = -state.m_gc[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_dn[i_] = state.m_dn[i_] + betak * state.m_dk[i_];
  for (int i_ = 0; i_ <= n - 1; i_++)
    state.m_dk[i_] = state.m_dn[i_];

  state.m_fold = state.m_f;
  state.m_k = state.m_k + 1;

  return (
      Func_lbl_49(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));
}

static bool CMinComp::Func_lbl_65(CMinASAState &state, int &n, int &i,
                                  int &mcinfo, int &diffcnt, bool &b,
                                  bool &stepfound, double &betak, double &v,
                                  double &vv) {

  if (state.m_laststep > state.m_epsx)
    return (
        Func_lbl_63(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv));

  state.m_repterminationtype = 2;

  if (!state.m_xrep)
    return (false);

  ClearRequestFields(state);

  state.m_xupdated = true;
  state.m_rstate.stage = 14;

  Func_lbl_rcomm(state, n, i, mcinfo, diffcnt, b, stepfound, betak, v, vv);

  return (true);
}

#endif
