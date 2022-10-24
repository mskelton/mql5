#ifndef LINALG_H
#define LINALG_H

#include "alglibinternal.mqh"
#include "alglibmisc.mqh"

class CAblas {
private:
  static void AblasInternalSplitLength(const int n, const int nb, int &n1,
                                       int &n2);

  static void RMatrixSyrk2(const int n, const int k, const double alpha,
                           const CMatrixDouble &a, const int ia, const int ja,
                           const int optypea, const double beta,
                           CMatrixDouble &c, const int ic, const int jc,
                           const bool isUpper);
  static void RMatrixGemmK(const int m, const int n, const int k,
                           const double alpha, const CMatrixDouble &a,
                           const int ia, const int ja, const int optypea,
                           const CMatrixDouble &b, const int ib, const int jb,
                           const int optypeb, const double beta,
                           CMatrixDouble &c, const int ic, const int jc);
  static void RMatrixRightTrsM2(const int m, const int n, CMatrixDouble &a,
                                const int i1, const int j1, const bool isUpper,
                                const bool isUnit, const int optype,
                                CMatrixDouble &x, const int i2, const int j2);
  static void RMatrixLeftTrsM2(const int m, const int n, CMatrixDouble &a,
                               const int i1, const int j1, const bool isUpper,
                               const bool isUnit, const int optype,
                               CMatrixDouble &x, const int i2, const int j2);

  static void CMatrixSyrk2(const int n, const int k, const double alpha,
                           const CMatrixComplex &a, const int ia, const int ja,
                           const int optypea, const double beta,
                           CMatrixComplex &c, const int ic, const int jc,
                           const bool isUpper);
  static void CMatrixGemmk(const int m, const int n, const int k,
                           al_complex &alpha, const CMatrixComplex &a,
                           const int ia, const int ja, const int optypea,
                           const CMatrixComplex &b, const int ib, const int jb,
                           const int optypeb, al_complex &beta,
                           CMatrixComplex &c, const int ic, const int jc);
  static void CMatrixRightTrsM2(const int m, const int n, CMatrixComplex &a,
                                const int i1, const int j1, const bool isUpper,
                                const bool isUnit, const int optype,
                                CMatrixComplex &x, const int i2, const int j2);
  static void CMatrixLeftTrsM2(const int m, const int n, CMatrixComplex &a,
                               const int i1, const int j1, const bool isUpper,
                               const bool isUnit, const int optype,
                               CMatrixComplex &x, const int i2, const int j2);

public:
  CAblas(void);
  ~CAblas(void);

  static int AblasBlockSize(void) ;
  static int AblasMicroBlockSize(void) ;
  static int AblasComplexBlockSize(void) ;

  static void AblasSplitLength(const CMatrixDouble &a, const int n, int &n1,
                               int &n2);
  static void AblasComplexSplitLength(const CMatrixComplex &a, const int n,
                                      int &n1, int &n2);

  static void RMatrixSyrk(const int n, const int k, const double alpha,
                          const CMatrixDouble &a, const int ia, const int ja,
                          const int optypea, const double beta,
                          CMatrixDouble &c, const int ic, const int jc,
                          const bool isUpper);
  static void RMatrixGemm(const int m, const int n, const int k,
                          const double alpha, const CMatrixDouble &a,
                          const int ia, const int ja, const int optypea,
                          const CMatrixDouble &b, const int ib, const int jb,
                          const int optypeb, const double beta,
                          CMatrixDouble &c, const int ic, const int jc);
  static void RMatrixTranspose(const int m, const int n, const CMatrixDouble &a,
                               const int ia, const int ja, CMatrixDouble &b,
                               const int ib, const int jb);
  static void RMatrixCopy(const int m, const int n, const CMatrixDouble &a,
                          const int ia, const int ja, CMatrixDouble &b,
                          const int ib, const int jb);
  static void RMatrixRank1(const int m, const int n, CMatrixDouble &a,
                           const int ia, const int ja, const double u[],
                           const int iu, const double v[], const int iv);
  static void RMatrixMVect(const int m, const int n, const CMatrixDouble &a,
                           const int ia, const int ja, const int opa,
                           const double x[], const int ix, double y[],
                           const int iy);
  static void RMatrixRightTrsM(const int m, const int n, CMatrixDouble &a,
                               const int i1, const int j1, const bool isUpper,
                               const bool isUnit, const int optype,
                               CMatrixDouble &x, const int i2, const int j2);
  static void RMatrixLeftTrsM(const int m, const int n, CMatrixDouble &a,
                              const int i1, const int j1, const bool isUpper,
                              const bool isUnit, const int optype,
                              CMatrixDouble &x, const int i2, const int j2);

  static void CMatrixSyrk(const int n, const int k, const double alpha,
                          CMatrixComplex &a, const int ia, const int ja,
                          const int optypea, const double beta,
                          CMatrixComplex &c, const int ic, const int jc,
                          const bool isUpper);
  static void CMatrixGemm(const int m, const int n, const int k,
                          al_complex &alpha, CMatrixComplex &a, const int ia,
                          const int ja, const int optypea, CMatrixComplex &b,
                          const int ib, const int jb, const int optypeb,
                          al_complex &beta, CMatrixComplex &c, const int ic,
                          const int jc);
  static void CMatrixTranspose(const int m, const int n,
                               const CMatrixComplex &a, const int ia,
                               const int ja, CMatrixComplex &b, const int ib,
                               const int jb);
  static void CMatrixCopy(const int m, const int n, const CMatrixComplex &a,
                          const int ia, const int ja, CMatrixComplex &b,
                          const int ib, const int jb);
  static void CMatrixRank1(const int m, const int n, CMatrixComplex &a,
                           const int ia, const int ja, const al_complex u[],
                           const int iu, const al_complex v[], const int iv);
  static void CMatrixMVect(const int m, const int n, const CMatrixComplex &a,
                           const int ia, const int ja, const int opa,
                           const al_complex x[], const int ix, al_complex y[],
                           const int iy);
  static void CMatrixRightTrsM(const int m, const int n, CMatrixComplex &a,
                               const int i1, const int j1, const bool isUpper,
                               const bool isUnit, const int optype,
                               CMatrixComplex &x, const int i2, const int j2);
  static void CMatrixLeftTrsM(const int m, const int n, CMatrixComplex &a,
                              const int i1, const int j1, const bool isUpper,
                              const bool isUnit, const int optype,
                              CMatrixComplex &x, const int i2, const int j2);
};






























class COrtFac {
private:
  static void RMatrixQRBaseCase(CMatrixDouble &a, const int m, const int n,
                                double work[], double t[], double tau[]);
  static void RMatrixLQBaseCase(CMatrixDouble &a, const int m, const int n,
                                double work[], double t[], double tau[]);
  static void CMatrixQRBaseCase(CMatrixComplex &a, const int m, const int n,
                                al_complex work[], al_complex t[],
                                al_complex tau[]);
  static void CMatrixLQBaseCase(CMatrixComplex &a, const int m, const int n,
                                al_complex work[], al_complex t[],
                                al_complex tau[]);
  static void RMatrixBlockReflector(CMatrixDouble a, double &tau[],
                                    const bool columnwisea, const int lengtha,
                                    const int blocksize, CMatrixDouble &t,
                                    double work[]);
  static void CMatrixBlockReflector(CMatrixComplex a, al_complex &tau[],
                                    const bool columnwisea, const int lengtha,
                                    const int blocksize, CMatrixComplex &t,
                                    al_complex work[]);

public:
  COrtFac(void);
  ~COrtFac(void);

  static void RMatrixQR(CMatrixDouble &a, const int m, const int n,
                        double tau[]);
  static void RMatrixLQ(CMatrixDouble &a, const int m, const int n,
                        double tau[]);
  static void RMatrixQRUnpackQ(CMatrixDouble &a, const int m, const int n,
                               double tau[], const int qcolumns,
                               CMatrixDouble &q);
  static void RMatrixQRUnpackR(CMatrixDouble &a, const int m, const int n,
                               CMatrixDouble &r);
  static void RMatrixLQUnpackQ(CMatrixDouble &a, const int m, const int n,
                               double tau[], const int qrows,
                               CMatrixDouble &q);
  static void RMatrixLQUnpackL(CMatrixDouble &a, const int m, const int n,
                               CMatrixDouble &l);
  static void RMatrixBD(CMatrixDouble &a, const int m, const int n,
                        double tauq[], double taup[]);
  static void RMatrixBDUnpackQ(CMatrixDouble &qp, const int m, const int n,
                               double tauq[], const int qcolumns,
                               CMatrixDouble &q);
  static void RMatrixBDMultiplyByQ(CMatrixDouble &qp, const int m, const int n,
                                   double tauq[], CMatrixDouble &z,
                                   const int zrows, const int zcolumns,
                                   const bool fromtheright,
                                   const bool dotranspose);
  static void RMatrixBDUnpackPT(CMatrixDouble &qp, const int m, const int n,
                                double taup[], const int ptrows,
                                CMatrixDouble &pt);
  static void RMatrixBDMultiplyByP(CMatrixDouble &qp, const int m, const int n,
                                   double taup[], CMatrixDouble &z,
                                   const int zrows, const int zcolumns,
                                   const bool fromtheright,
                                   const bool dotranspose);
  static void RMatrixBDUnpackDiagonals(CMatrixDouble &b, const int m,
                                       const int n, bool isupper, double &d[],
                                       double e[]);
  static void RMatrixHessenberg(CMatrixDouble a, const int n, double &tau[]);
  static void RMatrixHessenbergUnpackQ(CMatrixDouble &a, const int n,
                                       double tau[], CMatrixDouble &q);
  static void RMatrixHessenbergUnpackH(CMatrixDouble &a, const int n,
                                       CMatrixDouble &h);
  static void SMatrixTD(CMatrixDouble &a, const int n, const bool isupper,
                        double tau[], double d[], double e[]);
  static void SMatrixTDUnpackQ(CMatrixDouble &a, const int n,
                               const bool isupper, double tau[],
                               CMatrixDouble &q);

  static void CMatrixQR(CMatrixComplex &a, const int m, const int n,
                        al_complex tau[]);
  static void CMatrixLQ(CMatrixComplex &a, const int m, const int n,
                        al_complex tau[]);
  static void CMatrixQRUnpackQ(CMatrixComplex &a, const int m, const int n,
                               al_complex tau[], const int qcolumns,
                               CMatrixComplex &q);
  static void CMatrixQRUnpackR(CMatrixComplex &a, const int m, const int n,
                               CMatrixComplex &r);
  static void CMatrixLQUnpackQ(CMatrixComplex &a, const int m, const int n,
                               al_complex tau[], const int qrows,
                               CMatrixComplex &q);
  static void CMatrixLQUnpackL(CMatrixComplex &a, const int m, const int n,
                               CMatrixComplex &l);
  static void HMatrixTD(CMatrixComplex &a, const int n, const bool isupper,
                        al_complex tau[], double d[], double e[]);
  static void HMatrixTDUnpackQ(CMatrixComplex &a, const int n,
                               const bool isupper, al_complex tau[],
                               CMatrixComplex &q);
};


































class CEigenVDetect {
private:
  static bool TtidiagonalEVD(double d[], double ce[], const int n,
                             const int zneeded, CMatrixDouble &z);
  static void TdEVDE2(const double a, const double b, const double c,
                      double &rt1, double &rt2);
  static void TdEVDEv2(const double a, const double b, const double c,
                       double &rt1, double &rt2, double &cs1, double &sn1);
  static double TdEVDPythag(const double a, const double b);
  static double TdEVDExtSign(const double a, const double b);
  static bool InternalBisectionEigenValues(
      double cd[], double ce[], const int n, int irange, const int iorder,
      const double vl, const double vu, const int il, const int iu,
      const double abstol, double w[], int m, int &nsplit, int &iblock[],
      int isplit[], int &errorcode);
  static void InternalDStein(const int n, double d[], double ce[],
                             const int m, double cw[], int iblock[],
                             int isplit[], CMatrixDouble z, int &ifail[],
                             int &info);
  static void TdIninternalDLAGTF(const int n, double a[], const double lambdav,
                                 double b[], double c[], double tol,
                                 double d[], int iin[], int &info);
  static void TdIninternalDLAGTS(const int n, double a[], double b[],
                                 double c[], double d[], int iin[],
                                 double y[], double &tol, int &info);
  static void InternalDLAEBZ(const int ijob, const int nitmax, const int n,
                             const int mmax, const int minp,
                             const double abstol, const double reltol,
                             const double pivmin, double d[], double e[],
                             double e2[], int nval[], CMatrixDouble &ab,
                             double c[], int &mout, CMatrixInt &nab,
                             double work[], int iwork[], int &info);
  static void InternalTREVC(CMatrixDouble &t, const int n, const int side,
                            const int howmny, bool cvselect[],
                            CMatrixDouble &vl, CMatrixDouble &vr, int &m,
                            int &info);
  static void InternalHsEVDLALN2(
      const bool ltrans, const int na, const int nw, const double smin,
      const double ca, CMatrixDouble &a, const double d1, const double d2,
      CMatrixDouble b, const double wr, const double wi, bool &rswap4[],
      bool zswap4[], CMatrixInt ipivot44, double &civ4[], double crv4[],
      CMatrixDouble &x, double &scl, double &xnorm, int &info);
  static void InternalHsEVDLADIV(const double a, const double b, const double c,
                                 const double d, double &p, double &q);
  static bool NonSymmetricEVD(CMatrixDouble &ca, const int n, const int vneeded,
                              double wr[], double wi[], CMatrixDouble &vl,
                              CMatrixDouble &vr);
  static void ToUpperHessenberg(CMatrixDouble a, const int n, double &tau[]);
  static void UnpackQFromUpperHessenberg(CMatrixDouble &a, const int n,
                                         double tau[], CMatrixDouble &q);

public:
  CEigenVDetect(void);
  ~CEigenVDetect(void);

  static bool SMatrixEVD(CMatrixDouble &ca, const int n, const int zneeded,
                         const bool isupper, double d[], CMatrixDouble &z);
  static bool SMatrixEVDR(CMatrixDouble &ca, const int n, const int zneeded,
                          const bool isupper, const double b1, const double b2,
                          int m, double &w[], CMatrixDouble &z);
  static bool SMatrixEVDI(CMatrixDouble &ca, const int n, const int zneeded,
                          const bool isupper, const int i1, const int i2,
                          double w[], CMatrixDouble &z);
  static bool HMatrixEVD(CMatrixComplex &ca, const int n, int zneeded,
                         const bool isupper, double d[], CMatrixComplex &z);
  static bool HMatrixEVDR(CMatrixComplex &ca, const int n, int zneeded,
                          bool isupper, const double b1, const double b2,
                          int m, double &w[], CMatrixComplex &z);
  static bool HMatrixEVDI(CMatrixComplex &ca, const int n, int zneeded,
                          const bool isupper, const int i1, const int i2,
                          double w[], CMatrixComplex &z);
  static bool SMatrixTdEVD(double d[], double ce[], const int n,
                           const int zneeded, CMatrixDouble &z);
  static bool SMatrixTdEVDR(double d[], double e[], const int n,
                            const int zneeded, const double a, const double b,
                            int &m, CMatrixDouble &z);
  static bool SMatrixTdEVDI(double d[], double e[], const int n,
                            const int zneeded, const int i1, const int i2,
                            CMatrixDouble &z);
  static bool RMatrixEVD(CMatrixDouble &ca, const int n, const int vneeded,
                         double wr[], double wi[], CMatrixDouble &vl,
                         CMatrixDouble &vr);
};





























class CMatGen {
public:
  CMatGen(void);
  ~CMatGen(void);

  static void RMatrixRndOrthogonal(const int n, CMatrixDouble &a);
  static void RMatrixRndCond(const int n, const double c, CMatrixDouble &a);
  static void CMatrixRndOrthogonal(const int n, CMatrixComplex &a);
  static void CMatrixRndCond(const int n, const double c, CMatrixComplex &a);
  static void SMatrixRndCond(const int n, const double c, CMatrixDouble &a);
  static void SPDMatrixRndCond(const int n, const double c, CMatrixDouble &a);
  static void HMatrixRndCond(const int n, const double c, CMatrixComplex &a);
  static void HPDMatrixRndCond(const int n, const double c, CMatrixComplex &a);
  static void RMatrixRndOrthogonalFromTheRight(CMatrixDouble &a, const int m,
                                               const int n);
  static void RMatrixRndOrthogonalFromTheLeft(CMatrixDouble &a, const int m,
                                              const int n);
  static void CMatrixRndOrthogonalFromTheRight(CMatrixComplex &a, const int m,
                                               const int n);
  static void CMatrixRndOrthogonalFromTheLeft(CMatrixComplex &a, const int m,
                                              const int n);
  static void SMatrixRndMultiply(CMatrixDouble &a, const int n);
  static void HMatrixRndMultiply(CMatrixComplex &a, const int n);
};

















class CTrFac {
private:
  static void CMatrixLUPRec(CMatrixComplex &a, const int offs, const int m,
                            const int n, int pivots[], al_complex tmp[]);
  static void RMatrixLUPRec(CMatrixDouble &a, const int offs, const int m,
                            const int n, int pivots[], double tmp[]);
  static void CMatrixPLURec(CMatrixComplex &a, const int offs, const int m,
                            const int n, int pivots[], al_complex tmp[]);
  static void RMatrixPLURec(CMatrixDouble &a, const int offs, const int m,
                            const int n, int pivots[], double tmp[]);
  static void CMatrixLUP2(CMatrixComplex &a, const int offs, const int m,
                          const int n, int pivots[], al_complex tmp[]);
  static void RMatrixLUP2(CMatrixDouble &a, const int offs, const int m,
                          const int n, int pivots[], double tmp[]);
  static void CMatrixPLU2(CMatrixComplex &a, const int offs, const int m,
                          const int n, int pivots[], al_complex tmp[]);
  static void RMatrixPLU2(CMatrixDouble &a, const int offs, const int m,
                          const int n, int pivots[], double tmp[]);
  static bool HPDMatrixCholeskyRec(CMatrixComplex &a, const int offs,
                                   const int n, const bool isupper,
                                   al_complex tmp[]);
  static bool HPDMatrixCholesky2(CMatrixComplex &aaa, const int offs,
                                 const int n, const bool isupper,
                                 al_complex tmp[]);
  static bool SPDMatrixCholesky2(CMatrixDouble &aaa, const int offs,
                                 const int n, const bool isupper,
                                 double tmp[]);

public:
  CTrFac(void);
  ~CTrFac(void);

  static void RMatrixLU(CMatrixDouble &a, const int m, const int n,
                        int pivots[]);
  static void CMatrixLU(CMatrixComplex &a, const int m, const int n,
                        int pivots[]);
  static bool HPDMatrixCholesky(CMatrixComplex &a, const int n,
                                const bool isupper);
  static bool SPDMatrixCholesky(CMatrixDouble &a, const int n,
                                const bool isupper);
  static void RMatrixLUP(CMatrixDouble &a, const int m, const int n,
                         int pivots[]);
  static void CMatrixLUP(CMatrixComplex &a, const int m, const int n,
                         int pivots[]);
  static void RMatrixPLU(CMatrixDouble &a, const int m, const int n,
                         int pivots[]);
  static void CMatrixPLU(CMatrixComplex &a, const int m, const int n,
                         int pivots[]);
  static bool SPDMatrixCholeskyRec(CMatrixDouble &a, const int offs,
                                   const int n, const bool isupper,
                                   double tmp[]);
};























class CRCond {
private:
  static void RMatrixRCondTrInternal(CMatrixDouble &a, const int n,
                                     const bool isupper, const bool isunit,
                                     const bool onenorm, double anorm,
                                     double &rc);
  static void CMatrixRCondTrInternal(CMatrixComplex &a, const int n,
                                     const bool isupper, const bool isunit,
                                     const bool onenorm, double anorm,
                                     double &rc);
  static void SPDMatrixRCondCholeskyInternal(CMatrixDouble &cha, const int n,
                                             const bool isupper,
                                             const bool isnormprovided,
                                             double anorm, double &rc);
  static void HPDMatrixRCondCholeskyInternal(CMatrixComplex &cha, const int n,
                                             const bool isupper,
                                             const bool isnormprovided,
                                             double anorm, double &rc);
  static void RMatrixRCondLUInternal(CMatrixDouble &lua, const int n,
                                     const bool onenorm,
                                     const bool isanormprovided, double anorm,
                                     double &rc);
  static void CMatrixRCondLUInternal(CMatrixComplex &lua, const int n,
                                     const bool onenorm,
                                     const bool isanormprovided, double anorm,
                                     double &rc);
  static void RMatrixEstimateNorm(const int n, double v[], double x[],
                                  int isgn[], double &est, int &kase);
  static void CMatrixEstimateNorm(const int n, al_complex v[], al_complex x[],
                                  double est, int &kase, int &isave[],
                                  double rsave[]);
  static double InternalComplexRCondScSum1(al_complex x[], const int n);
  static int InternalComplexRCondIcMax1(al_complex x[], const int n);
  static void InternalComplexRCondSaveAll(int isave[], double rsave[], int &i,
                                          int &iter, int &j, int &jlast,
                                          int &jump, double &absxi,
                                          double &altsgn, double &estold,
                                          double &temp);
  static void InternalComplexRCondLoadAll(int isave[], double rsave[], int &i,
                                          int &iter, int &j, int &jlast,
                                          int &jump, double &absxi,
                                          double &altsgn, double &estold,
                                          double &temp);

public:
  static double RMatrixRCond1(CMatrixDouble &ca, const int n);
  static double RMatrixRCondInf(CMatrixDouble &ca, const int n);
  static double SPDMatrixRCond(CMatrixDouble &ca, const int n,
                               const bool isupper);
  static double RMatrixTrRCond1(CMatrixDouble &a, const int n,
                                const bool isupper, const bool isunit);
  static double RMatrixTrRCondInf(CMatrixDouble &a, const int n,
                                  const bool isupper, const bool isunit);
  static double RMatrixLURCond1(CMatrixDouble &lua, const int n);
  static double RMatrixLURCondInf(CMatrixDouble &lua, const int n);
  static double SPDMatrixCholeskyRCond(CMatrixDouble &a, const int n,
                                       const bool isupper);
  static double HPDMatrixRCond(CMatrixComplex &ca, const int n,
                               const bool isupper);
  static double CMatrixRCond1(CMatrixComplex &ca, const int n);
  static double CMatrixRCondInf(CMatrixComplex &ca, const int n);
  static double HPDMatrixCholeskyRCond(CMatrixComplex &a, const int n,
                                       const bool isupper);
  static double CMatrixLURCond1(CMatrixComplex &lua, const int n);
  static double CMatrixLURCondInf(CMatrixComplex &lua, const int n);
  static double CMatrixTrRCond1(CMatrixComplex &a, const int n,
                                const bool isupper, const bool isunit);
  static double CMatrixTrRCondInf(CMatrixComplex &a, const int n,
                                  const bool isupper, const bool isunit);
  static double RCondThreshold(void);
};






























class CMatInvReport {
public:
  double m_r1;
  double m_rinf;

  CMatInvReport(void);
  ~CMatInvReport(void);
};



class CMatInvReportShell {
private:
  CMatInvReport m_innerobj;

public:
  CMatInvReportShell(void);
  CMatInvReportShell(CMatInvReport &obj);
  ~CMatInvReportShell(void);

  double GetR1(void);
  void SetR1(double r);
  double GetRInf(void);
  void SetRInf(double r);
  CMatInvReport *GetInnerObj(void);
};









class CMatInv {
private:
  static void RMatrixTrInverseRec(CMatrixDouble &a, const int offs, const int n,
                                  const bool isupper, const bool isunit,
                                  double tmp[], int &info, CMatInvReport &rep);
  static void CMatrixTrInverseRec(CMatrixComplex &a, const int offs,
                                  const int n, const bool isupper,
                                  const bool isunit, al_complex tmp[],
                                  int &info, CMatInvReport &rep);
  static void RMatrixLUInverseRec(CMatrixDouble &a, const int offs, const int n,
                                  double work[], int &info,
                                  CMatInvReport &rep);
  static void CMatrixLUInverseRec(CMatrixComplex &a, const int offs,
                                  const int n, al_complex work[], int &info,
                                  CMatInvReport &rep);
  static void SPDMatrixCholeskyInverseRec(CMatrixDouble &a, const int offs,
                                          const int n, const bool isupper,
                                          double tmp[]);
  static void HPDMatrixCholeskyInverseRec(CMatrixComplex &a, const int offs,
                                          const int n, const bool isupper,
                                          al_complex tmp[]);

public:
  CMatInv(void);
  ~CMatInv(void);

  static void RMatrixLUInverse(CMatrixDouble a, int &pivots[], const int n,
                               int &info, CMatInvReport &rep);
  static void RMatrixInverse(CMatrixDouble &a, const int n, int &info,
                             CMatInvReport &rep);
  static void SPDMatrixCholeskyInverse(CMatrixDouble &a, const int n,
                                       const bool isupper, int &info,
                                       CMatInvReport &rep);
  static void SPDMatrixInverse(CMatrixDouble &a, const int n,
                               const bool isupper, int &info,
                               CMatInvReport &rep);
  static void RMatrixTrInverse(CMatrixDouble &a, const int n,
                               const bool isupper, const bool isunit, int &info,
                               CMatInvReport &rep);
  static void CMatrixLUInverse(CMatrixComplex a, int &pivots[], const int n,
                               int &info, CMatInvReport &rep);
  static void CMatrixInverse(CMatrixComplex &a, const int n, int &info,
                             CMatInvReport &rep);
  static void HPDMatrixCholeskyInverse(CMatrixComplex &a, const int n,
                                       const bool isupper, int &info,
                                       CMatInvReport &rep);
  static void HPDMatrixInverse(CMatrixComplex &a, const int n,
                               const bool isupper, int &info,
                               CMatInvReport &rep);
  static void CMatrixTrInverse(CMatrixComplex &a, const int n,
                               const bool isupper, const bool isunit, int &info,
                               CMatInvReport &rep);
};



















class CBdSingValueDecompose {
private:
  static bool BidiagonalSVDDecompositionInternal(
      double d[], double ce[], const int n, const bool isupper,
      const bool isfractionalaccuracyrequired, CMatrixDouble &u,
      const int ustart, const int nru, CMatrixDouble &c, const int cstart,
      const int ncc, CMatrixDouble &vt, const int vstart, const int ncvt);
  static double ExtSignBdSQR(const double a, const double b);
  static void SVD2x2(const double f, const double g, const double h,
                     double &ssmin, double &ssmax);
  static void SVDV2x2(const double f, const double g, const double h,
                      double &ssmin, double &ssmax, double &snr, double &csr,
                      double &snl, double &csl);

public:
  CBdSingValueDecompose(void);
  ~CBdSingValueDecompose(void);

  static bool RMatrixBdSVD(double d[], double ce[], const int n,
                           const bool isupper,
                           const bool isfractionalaccuracyrequired,
                           CMatrixDouble &u, const int nru, CMatrixDouble &c,
                           const int ncc, CMatrixDouble &vt, const int ncvt);
  static bool BidiagonalSVDDecomposition(
      double d[], double ce[], const int n, const bool isupper,
      const bool isfractionalaccuracyrequired, CMatrixDouble &u, const int nru,
      CMatrixDouble &c, const int ncc, CMatrixDouble &vt, const int ncvt);
};









class CSingValueDecompose {
public:
  CSingValueDecompose(void);
  ~CSingValueDecompose(void);

  static bool RMatrixSVD(CMatrixDouble &ca, const int m, const int n,
                         const int uneeded, const int vtneeded,
                         const int additionalmemory, double w[],
                         CMatrixDouble &u, CMatrixDouble &vt);
};




class CFblsLinCgState {
public:
  double m_e1;
  double m_e2;
  double m_x;
  double m_ax;
  double m_xax;
  double m_xk;
  int m_n;
  double m_rk;
  double m_rk1;
  double m_xk1;
  double m_pk;
  double m_pk1;
  double m_b;
  RCommState m_rstate;
  double m_tmp2;

  CFblsLinCgState(void);
  ~CFblsLinCgState(void);
};



class CFbls {
private:
  static void Func_lbl_rcomm(CFblsLinCgState &state, int n, int k, double rk2,
                             double rk12, double pap, double s, double betak,
                             double v1, double v2);
  static bool Func_lbl_3(CFblsLinCgState &state, int &n, int &k, double &rk2,
                         double &rk12, double &pap, double &s, double &betak,
                         double &v1, double &v2);
  static bool Func_lbl_5(CFblsLinCgState &state, int &n, int &k, double &rk2,
                         double &rk12, double &pap, double &s, double &betak,
                         double &v1, double &v2);

public:
  CFbls(void);
  ~CFbls(void);

  static void FblsCholeskySolve(CMatrixDouble &cha, const double sqrtscalea,
                                const int n, const bool isupper, double xb[],
                                double tmp[]);
  static void FblsSolveCGx(CMatrixDouble &a, const int m, const int n,
                           const double alpha, const double b[], double x[],
                           double buf[]);
  static void FblsCGCreate(double x[], double b[], const int n,
                           CFblsLinCgState &state);
  static bool FblsCGIteration(CFblsLinCgState &state);
};










class CMatDet {
public:
  CMatDet(void);
  ~CMatDet(void);

  static double RMatrixLUDet(CMatrixDouble a, int &pivots[], const int n);
  static double RMatrixDet(CMatrixDouble &ca, const int n);
  static double SPDMatrixCholeskyDet(CMatrixDouble &a, const int n);
  static double SPDMatrixDet(CMatrixDouble &ca, const int n,
                             const bool isupper);
  static al_complex CMatrixLUDet(CMatrixComplex a, int &pivots[], const int n);
  static al_complex CMatrixDet(CMatrixComplex &ca, const int n);
};









class CSpdGEVD {
public:
  CSpdGEVD(void);
  ~CSpdGEVD(void);

  static bool SMatrixGEVD(CMatrixDouble &ca, const int n, const bool isuppera,
                          CMatrixDouble &b, const bool isupperb,
                          const int zneeded, const int problemtype, double d[],
                          CMatrixDouble &z);
  static bool SMatrixGEVDReduce(CMatrixDouble &a, const int n,
                                const bool isuppera, CMatrixDouble &b,
                                const bool isupperb, const int problemtype,
                                CMatrixDouble &r, bool &isupperr);
};





class CInverseUpdate {
public:
  CInverseUpdate(void);
  ~CInverseUpdate(void);

  static void RMatrixInvUpdateSimple(CMatrixDouble &inva, const int n,
                                     const int updrow, const int updcolumn,
                                     const double updval);
  static void RMatrixInvUpdateRow(CMatrixDouble &inva, const int n,
                                  const int updrow, double v[]);
  static void RMatrixInvUpdateColumn(CMatrixDouble &inva, const int n,
                                     const int updcolumn, double u[]);
  static void RMatrixInvUpdateUV(CMatrixDouble inva, const int n, double &u[],
                                 double v[]);
};







class CSchur {
public:
  CSchur(void);
  ~CSchur(void);

  static bool RMatrixSchur(CMatrixDouble &a, const int n, CMatrixDouble &s);
};




#endif
