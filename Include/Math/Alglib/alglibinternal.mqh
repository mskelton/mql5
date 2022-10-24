#ifndef ALGLIBINTERNAL_H
#define ALGLIBINTERNAL_H

#include "ap.mqh"

class CSCodes {
public:
  CSCodes(void);
  ~CSCodes(void);

  static int GetRDFSerializationCode(void) ;
  static int GetKDTreeSerializationCode(void) ;
  static int GetMLPSerializationCode(void) ;
};



class CApBuff {
public:
  int m_ia0;
  int m_ia1;
  int m_ia2;
  int m_ia3;
  double m_ra0;
  double m_ra1;
  double m_ra2;
  double m_ra3;

  CApBuff(void);
  ~CApBuff(void);

  void Copy(CApBuff &obj);
};




class CApServ {
public:
  CApServ(void);
  ~CApServ(void);

  static void TaskGenInt1D(const double a, const double b, const int n,
                           double x[], double y[]);
  static void TaskGenInt1DEquidist(const double a, const double b, const int n,
                                   double x[], double y[]);
  static void TaskGenInt1DCheb1(const double a, const double b, const int n,
                                double x[], double y[]);
  static void TaskGenInt1DCheb2(const double a, const double b, const int n,
                                double x[], double y[]);

  static bool AreDistinct(double x[], const int n);

  static void BVectorSetLengthAtLeast(bool x[], const int n);
  static void IVectorSetLengthAtLeast(int x[], const int n);
  static void RVectorSetLengthAtLeast(double x[], const int n);
  static void RMatrixSetLengthAtLeast(CMatrixDouble &x, const int m,
                                      const int n);

  static void RMatrixResize(CMatrixDouble &x, const int m, const int n);

  static bool IsFiniteVector(const double x[], const int n);
  static bool IsFiniteComplexVector(al_complex z[], const int n);
  static bool IsFiniteMatrix(const CMatrixDouble &x, const int m, const int n);
  static bool IsFiniteComplexMatrix(CMatrixComplex &x, const int m,
                                    const int n);
  static bool IsFiniteRTrMatrix(CMatrixDouble &x, const int n,
                                const bool isupper);
  static bool IsFiniteCTrMatrix(CMatrixComplex &x, const int n,
                                const bool isupper);
  static bool IsFiniteOrNaNMatrix(CMatrixDouble &x, const int m, const int n);

  static double SafePythag2(const double x, const double y);
  static double SafePythag3(double x, double y, double z);
  static int SafeRDiv(double x, double y, double &r);
  static double SafeMinPosRV(const double x, const double y, const double v);
  static void ApPeriodicMap(double &x, const double a, const double b,
                            double &k);
  static double BoundVal(const double x, const double b1, const double b2);

  static void AllocComplex(CSerializer &s, al_complex &v);
  static void SerializeComplex(CSerializer &s, al_complex &v);
  static al_complex UnserializeComplex(CSerializer &s);
  static void AllocRealArray(CSerializer &s, double v[], int n);
  static void SerializeRealArray(CSerializer &s, double v[], int n);
  static void UnserializeRealArray(CSerializer &s, double v[]);
  static void AllocIntegerArray(CSerializer &s, int v[], int n);
  static void SerializeIntegerArray(CSerializer &s, int v[], int n);
  static void UnserializeIntegerArray(CSerializer &s, int v[]);
  static void AllocRealMatrix(CSerializer &s, CMatrixDouble &v, int n0, int n1);
  static void SerializeRealMatrix(CSerializer &s, CMatrixDouble &v, int n0,
                                  int n1);
  static void UnserializeRealMatrix(CSerializer &s, CMatrixDouble &v);

  static void CopyIntegerArray(int src[], int dst[]);
  static void CopyRealArray(double src[], double dst[]);
  static void CopyRealMatrix(CMatrixDouble &src, CMatrixDouble &dst);

  static int RecSearch(int a[], const int nrec, const int nheader, int i0,
                       int i1, int b[]);
};










































class CTSort {
private:
  static void TagSortFastIRec(double a[], int b[], double bufa[],
                              int bufb[], const int i1, const int i2);
  static void TagSortFastRRec(double a[], double b[], double bufa[],
                              double bufb[], const int i1, const int i2);
  static void TagSortFastRec(double a[], double bufa[], const int i1,
                             const int i2);

public:
  CTSort(void);
  ~CTSort(void);

  static void TagSort(double a[], const int n, int p1[], int p2[]);
  static void TagSortBuf(double a[], const int n, int p1[], int p2[],
                         CApBuff &buf);
  static void TagSortFastI(double a[], int b[], double bufa[], int bufb[],
                           const int n);
  static void TagSortFastR(double a[], double b[], double bufa[],
                           double bufb[], const int n);
  static void TagSortFast(double a[], double bufa[], const int n);
  static void TagHeapPushI(double a[], int b[], int &n, const double va,
                           const int vb);
  static void TagHeapReplaceTopI(double a[], int b[], const int n,
                                 const double va, const int vb);
  static void TagHeapPopI(double a[], int b[], int &n);
};














class CBasicStatOps {
public:
  CBasicStatOps(void);
  ~CBasicStatOps(void);

  static void RankX(double x[], const int n, CApBuff &buf);
};




class CAblasF {
public:
  CAblasF(void);
  ~CAblasF(void);

  static bool CMatrixRank1F(const int m, const int n, CMatrixComplex &a, int ia,
                            int ja, al_complex u[], int iu, al_complex v[],
                            int iv);
  static bool RMatrixRank1F(const int m, const int n, CMatrixDouble &a, int ia,
                            int ja, double u[], int iu, double v[], int iv);
  static bool CMatrixMVF(const int m, const int n, CMatrixComplex &a, int ia,
                         int ja, int opa, al_complex x[], int ix,
                         al_complex y[], int iy);
  static bool RMatrixMVF(const int m, const int n, CMatrixDouble &a, int ia,
                         int ja, int opa, double x[], int ix, double y[],
                         int iy);
  static bool CMatrixRightTrsMF(const int m, const int n, CMatrixComplex &a,
                                const int i1, int j1, const bool isupper,
                                bool isunit, int optype, CMatrixComplex &x,
                                int i2, int j2);
  static bool CMatrixLeftTrsMF(const int m, const int n, CMatrixComplex &a,
                               const int i1, int j1, const bool isupper,
                               bool isunit, int optype, CMatrixComplex &x,
                               int i2, int j2);
  static bool RMatrixRightTrsMF(const int m, const int n, CMatrixDouble &a,
                                const int i1, int j1, const bool isupper,
                                bool isunit, int optype, CMatrixDouble &x,
                                int i2, int j2);
  static bool RMatrixLeftTrsMF(const int m, const int n, CMatrixDouble &a,
                               const int i1, int j1, const bool isupper,
                               bool isunit, int optype, CMatrixDouble &x,
                               int i2, int j2);
  static bool CMatrixSyrkF(const int n, int k, double alpha, CMatrixComplex &a,
                           int ia, int ja, int optypea, double beta,
                           CMatrixComplex &c, int ic, int jc, bool isupper);
  static bool RMatrixSyrkF(const int n, int k, double alpha, CMatrixDouble &a,
                           int ia, int ja, int optypea, double beta,
                           CMatrixDouble &c, int ic, int jc, bool isupper);
  static bool RMatrixGemmF(const int m, const int n, int k, double alpha,
                           CMatrixDouble &a, int ia, int ja, int optypea,
                           CMatrixDouble &b, int ib, int jb, int optypeb,
                           double beta, CMatrixDouble &c, int ic, int jc);
  static bool CMatrixGemmF(const int m, const int n, int k, al_complex &alpha,
                           CMatrixComplex &a, int ia, int ja, int optypea,
                           CMatrixComplex &b, int ib, int jb, int optypeb,
                           al_complex &beta, CMatrixComplex &c, int ic, int jc);
};















class CBlas {
public:
  CBlas(void);
  ~CBlas(void);

  static double VectorNorm2(double x[], const int i1, const int i2);
  static int VectorIdxAbsMax(double x[], const int i1, const int i2);
  static int ColumnIdxAbsMax(CMatrixDouble &x, const int i1, const int i2,
                             const int j);
  static int RowIdxAbsMax(CMatrixDouble &x, const int j1, const int j2,
                          const int i);
  static double UpperHessenberg1Norm(CMatrixDouble &a, const int i1,
                                     const int i2, const int j1, const int j2,
                                     double work[]);
  static void CopyMatrix(CMatrixDouble &a, const int is1, const int is2,
                         const int js1, const int js2, CMatrixDouble &b,
                         const int id1, const int id2, const int jd1,
                         const int jd2);
  static void InplaceTranspose(CMatrixDouble &a, const int i1, const int i2,
                               const int j1, const int j2, double work[]);
  static void CopyAndTranspose(CMatrixDouble &a, const int is1, const int is2,
                               const int js1, const int js2, CMatrixDouble &b,
                               const int id1, const int id2, const int jd1,
                               const int jd2);
  static void MatrixVectorMultiply(CMatrixDouble &a, const int i1, const int i2,
                                   const int j1, const int j2, const bool trans,
                                   double x[], const int ix1, const int ix2,
                                   const double alpha, double y[],
                                   const int iy1, const int iy2,
                                   const double beta);
  static double PyThag2(double x, double y);
  static void MatrixMatrixMultiply(
      CMatrixDouble &a, const int ai1, const int ai2, const int aj1,
      const int aj2, const bool transa, CMatrixDouble &b, const int bi1,
      const int bi2, const int bj1, const int bj2, const bool transb,
      const double alpha, CMatrixDouble &c, const int ci1, const int ci2,
      const int cj1, const int cj2, const double beta, double work[]);
};














class CHblas {
public:
  CHblas(void);
  ~CHblas(void);

  static void HermitianMatrixVectorMultiply(CMatrixComplex &a,
                                            const bool isupper, const int i1,
                                            const int i2, al_complex x[],
                                            al_complex &alpha, al_complex y[]);
  static void HermitianRank2Update(CMatrixComplex &a, const bool isupper,
                                   const int i1, const int i2, al_complex x[],
                                   al_complex y[], al_complex t[],
                                   al_complex &alpha);
};





class CReflections {
public:
  CReflections(void);
  ~CReflections(void);

  static void GenerateReflection(double x[], const int n, double &tau);
  static void ApplyReflectionFromTheLeft(CMatrixDouble &c, const double tau,
                                         const double v[], const int m1,
                                         const int m2, const int n1,
                                         const int n2, double work[]);
  static void ApplyReflectionFromTheRight(CMatrixDouble &c, const double tau,
                                          const double v[], const int m1,
                                          const int m2, const int n1,
                                          const int n2, double work[]);
};






class CComplexReflections {
public:
  void CComplexReflections(void);
  void ~CComplexReflections(void);

  static void ComplexGenerateReflection(al_complex x[], const int n,
                                        al_complex &tau);
  static void ComplexApplyReflectionFromTheLeft(
      CMatrixComplex &c, al_complex &tau, al_complex v[], const int m1,
      const int m2, const int n1, const int n2, al_complex work[]);
  static void ComplexApplyReflectionFromTheRight(
      CMatrixComplex &c, al_complex &tau, al_complex v[], const int m1,
      const int m2, const int n1, const int n2, al_complex work[]);
};






class CSblas {
public:
  CSblas(void);
  ~CSblas(void);

  static void SymmetricMatrixVectorMultiply(const CMatrixDouble &a,
                                            const bool isupper, const int i1,
                                            const int i2, const double x[],
                                            const double alpha, double y[]);
  static void SymmetricRank2Update(CMatrixDouble &a, const bool isupper,
                                   const int i1, const int i2,
                                   const double x[], const double y[],
                                   double t[], const double alpha);
};





class CRotations {
public:
  CRotations(void);
  ~CRotations(void);

  static void ApplyRotationsFromTheLeft(const bool isforward, const int m1,
                                        const int m2, const int n1,
                                        const int n2, double c[], double s[],
                                        CMatrixDouble &a, double work[]);
  static void ApplyRotationsFromTheRight(const bool isforward, const int m1,
                                         const int m2, const int n1,
                                         const int n2, double c[], double s[],
                                         CMatrixDouble &a, double work[]);
  static void GenerateRotation(const double f, const double g, double &cs,
                               double &sn, double &r);
};






class CHsSchur {
private:
  static void InternalAuxSchur(const bool wantt, const bool wantz, const int n,
                               const int ilo, const int ihi, CMatrixDouble &h,
                               double wr[], double wi[], const int iloz,
                               const int ihiz, CMatrixDouble &z, double work[],
                               double workv3[], double workc1[],
                               double works1[], int &info);
  static void Aux2x2Schur(double &a, double &b, double &c, double &d,
                          double &rt1r, double &rt1i, double &rt2r,
                          double &rt2i, double &cs, double &sn);
  static double ExtSchurSign(const double a, const double b);
  static int ExtSchurSignToone(const double b);

public:
  CHsSchur(void);
  ~CHsSchur(void);

  static bool UpperHessenbergSchurDecomposition(CMatrixDouble &h, const int n,
                                                CMatrixDouble &s);
  static void InternalSchurDecomposition(CMatrixDouble &h, const int n,
                                         const int tneeded, const int zneeded,
                                         double wr[], double wi[],
                                         CMatrixDouble &z, int &info);
};









class CTrLinSolve {
public:
  CTrLinSolve(void);
  ~CTrLinSolve(void);

  static void RMatrixTrSafeSolve(CMatrixDouble &a, const int n, double x[],
                                 double &s, const bool isupper,
                                 const bool istrans, const bool isunit);
  static void SafeSolveTriangular(CMatrixDouble &a, const int n, double x[],
                                  double &s, const bool isupper,
                                  const bool istrans, const bool isunit,
                                  const bool normin, double cnorm[]);
};





class CSafeSolve {
private:
  static bool CBasicSolveAndUpdate(al_complex &alpha, al_complex &beta,
                                   const double lnmax, const double bnorm,
                                   const double maxgrowth, double &xnorm,
                                   al_complex &x);

public:
  CSafeSolve(void);
  ~CSafeSolve(void);

  static bool RMatrixScaledTrSafeSolve(CMatrixDouble &a, const double sa,
                                       const int n, double x[],
                                       const bool isupper, const int trans,
                                       const bool isunit,
                                       const double maxgrowth);
  static bool CMatrixScaledTrSafeSolve(CMatrixComplex &a, const double sa,
                                       const int n, al_complex x[],
                                       const bool isupper, const int trans,
                                       const bool isunit,
                                       const double maxgrowth);
};






class CXblas {
private:
  static void XSum(double w[], const double mx, const int n, double &r,
                   double &rerr);
  static double XFastPow(const double r, const int n);

public:
  CXblas(void);
  ~CXblas(void);

  static void XDot(double a[], double b[], const int n, double temp[],
                   double &r, double &rerr);
  static void XCDot(al_complex a[], al_complex b[], const int n,
                    double temp[], al_complex &r, double &rerr);
};







class CLinMinState {
public:
  bool m_brackt;
  bool m_stage1;
  int m_infoc;
  double m_dg;
  double m_dgm;
  double m_dginit;
  double m_dgtest;
  double m_dgx;
  double m_dgxm;
  double m_dgy;
  double m_dgym;
  double m_finit;
  double m_ftest1;
  double m_fm;
  double m_fx;
  double m_fxm;
  double m_fy;
  double m_fym;
  double m_stx;
  double m_sty;
  double m_stmin;
  double m_stmax;
  double m_width;
  double m_width1;
  double m_xtrapf;

  CLinMinState(void);
  ~CLinMinState(void);

  void Copy(CLinMinState &obj);
};




class CArmijoState {
public:
  bool m_needf;
  double m_x;
  double m_f;
  int m_n;
  double m_xbase;
  double m_s;
  double m_stplen;
  double m_fcur;
  double m_stpmax;
  int m_fmax;
  int m_nfev;
  int m_info;
  RCommState m_rstate;

  CArmijoState(void);
  ~CArmijoState(void);
};



class CLinMin {
private:
  static void MCStep(double &stx, double &fx, double &dx, double &sty,
                     double &fy, double &dy, double &stp, double fp, double dp,
                     bool &m_brackt, double stmin, double stmax, int &info);

  static void Func_lbl_rcomm(CArmijoState &state, int n, double v);
  static bool Func_lbl_6(CArmijoState &state, int &n, double &v);
  static bool Func_lbl_10(CArmijoState &state, int &n, double &v);

public:
  static const double m_ftol;
  static const double m_xtol;
  static const int m_maxfev;
  static const double m_stpmin;
  static const double m_defstpmax;
  static const double m_armijofactor;

  CLinMin(void);
  ~CLinMin(void);

  static void LinMinNormalized(double d[], double &stp, const int n);
  static void MCSrch(const int n, double x[], double &f, double g[],
                     double s[], double &stp, double stpmax, double gtol,
                     int &info, int &nfev, double wa[], CLinMinState &state,
                     int &stage);
  static void ArmijoCreate(const int n, double x[], const double f,
                           double s[], const double stp, const double stpmax,
                           const int ffmax, CArmijoState &state);
  static void ArmijoResults(CArmijoState &state, int &info, double &stp,
                            double &f);
  static bool ArmijoIteration(CArmijoState &state);
};













class COptServ {
public:
  COptServ(void);
  ~COptServ(void);

  static void TrimPrepare(const double f, double &threshold);
  static void TrimFunction(double &f, double g[], const int n,
                           const double threshold);
};





class CFtPlan {
public:
  int m_plan;
  double m_precomputed;
  double m_tmpbuf;
  double m_stackbuf;

  CFtPlan(void);
  ~CFtPlan(void);
};



class CFtBase {
private:
  static void FtBaseGeneratePlanRec(const int n, int tasktype, CFtPlan &plan,
                                    int &plansize, int &precomputedsize,
                                    int &planarraysize, int &tmpmemsize,
                                    int &stackmemsize, int stackptr);
  static void FtBasePrecomputePlanRec(CFtPlan &plan, const int entryoffset,
                                      const int stackptr);
  static void FFtTwCalc(double a[], const int aoffset, const int n1,
                        const int n2);
  static void InternalComplexLinTranspose(double a[], const int m, const int n,
                                          const int astart, double buf[]);
  static void InternalRealLinTranspose(double a[], const int m, const int n,
                                       const int astart, double buf[]);
  static void FFtICLTRec(double a[], const int astart, const int astride,
                         double b[], const int bstart, const int bstride,
                         const int m, const int n);
  static void FFtIRLTRec(double a[], const int astart, const int astride,
                         double b[], const int bstart, const int bstride,
                         const int m, const int n);
  static void FtBaseFindSmoothRec(const int n, const int seed,
                                  const int leastfactor, int &best);
  static void FFtArrayResize(int a[], int &asize, const int newasize);
  static void ReFFHt(double a[], const int n, const int offs);

public:
  static const int m_ftbaseplanentrysize;
  static const int m_ftbasecffttask;
  static const int m_ftbaserfhttask;
  static const int m_ftbaserffttask;
  static const int m_fftcooleytukeyplan;
  static const int m_fftbluesteinplan;
  static const int m_fftcodeletplan;
  static const int m_fhtcooleytukeyplan;
  static const int m_fhtcodeletplan;
  static const int m_fftrealcooleytukeyplan;
  static const int m_fftemptyplan;
  static const int m_fhtn2plan;
  static const int m_ftbaseupdatetw;
  static const int m_ftbasecodeletrecommended;
  static const double m_ftbaseinefficiencyfactor;
  static const int m_ftbasemaxsmoothfactor;

  CFtBase(void);
  ~CFtBase(void);

  static void FtBaseGenerateComplexFFtPlan(const int n, CFtPlan &plan);
  static void FtBaseGenerateRealFFtPlan(const int n, CFtPlan &plan);
  static void FtBaseGenerateRealFHtPlan(const int n, CFtPlan &plan);
  static void FtBaseExecutePlan(double a[], const int aoffset, const int n,
                                CFtPlan &plan);
  static void FtBaseExecutePlanRec(double a[], const int aoffset,
                                   CFtPlan &plan, const int entryoffset,
                                   const int stackptr);
  static void FtBaseFactorize(const int n, const int tasktype, int &n1,
                              int &n2);
  static bool FtBaseIsSmooth(int n);
  static int FtBaseFindSmooth(const int n);
  static int FtBaseFindSmoothEven(const int n);
  static double FtBaseGetFlopEstimate(const int n);
};
























class CNearUnitYUnit {
public:
  CNearUnitYUnit(void);
  ~CNearUnitYUnit(void);

  static double NULog1p(const double x);
  static double NUExp1m(const double x);
  static double NUCos1m(const double x);
};






#endif
