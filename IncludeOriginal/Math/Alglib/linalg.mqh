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

  static int AblasBlockSize(void) {
    return (32);
  }
  static int AblasMicroBlockSize(void) {
    return (8);
  }
  static int AblasComplexBlockSize(void) {
    return (24);
  }

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
                           const int ia, const int ja, const double &u[],
                           const int iu, const double &v[], const int iv);
  static void RMatrixMVect(const int m, const int n, const CMatrixDouble &a,
                           const int ia, const int ja, const int opa,
                           const double &x[], const int ix, double &y[],
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
                           const int ia, const int ja, const al_complex &u[],
                           const int iu, const al_complex &v[], const int iv);
  static void CMatrixMVect(const int m, const int n, const CMatrixComplex &a,
                           const int ia, const int ja, const int opa,
                           const al_complex &x[], const int ix, al_complex &y[],
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

CAblas::CAblas(void) {}

CAblas::~CAblas(void) {}

static void CAblas::RMatrixSyrk(const int n, const int k, const double alpha,
                                const CMatrixDouble &a, const int ia,
                                const int ja, const int optypea,
                                const double beta, CMatrixDouble &c,
                                const int ic, const int jc,
                                const bool isUpper) {

  int s1 = 0;
  int s2 = 0;
  int bs = 0;

  bs = AblasBlockSize();

  if (n <= bs && k <= bs) {
    RMatrixSyrk2(n, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
    return;
  }

  if (k >= n) {

    AblasSplitLength(a, k, s1, s2);

    if (optypea == 0) {
      RMatrixSyrk(n, s1, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      RMatrixSyrk(n, s2, alpha, a, ia, ja + s1, optypea, 1.0, c, ic, jc,
                  isUpper);
    } else {
      RMatrixSyrk(n, s1, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      RMatrixSyrk(n, s2, alpha, a, ia + s1, ja, optypea, 1.0, c, ic, jc,
                  isUpper);
    }
  } else {

    AblasSplitLength(a, n, s1, s2);

    if (optypea == 0 && isUpper) {
      RMatrixSyrk(s1, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      RMatrixGemm(s1, s2, k, alpha, a, ia, ja, 0, a, ia + s1, ja, 1, beta, c,
                  ic, jc + s1);
      RMatrixSyrk(s2, k, alpha, a, ia + s1, ja, optypea, beta, c, ic + s1,
                  jc + s1, isUpper);

      return;
    }

    if (optypea == 0 && !isUpper) {
      RMatrixSyrk(s1, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      RMatrixGemm(s2, s1, k, alpha, a, ia + s1, ja, 0, a, ia, ja, 1, beta, c,
                  ic + s1, jc);
      RMatrixSyrk(s2, k, alpha, a, ia + s1, ja, optypea, beta, c, ic + s1,
                  jc + s1, isUpper);

      return;
    }

    if (optypea != 0 && isUpper) {
      RMatrixSyrk(s1, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      RMatrixGemm(s1, s2, k, alpha, a, ia, ja, 1, a, ia, ja + s1, 0, beta, c,
                  ic, jc + s1);
      RMatrixSyrk(s2, k, alpha, a, ia, ja + s1, optypea, beta, c, ic + s1,
                  jc + s1, isUpper);

      return;
    }

    if (optypea != 0 && !isUpper) {
      RMatrixSyrk(s1, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      RMatrixGemm(s2, s1, k, alpha, a, ia, ja + s1, 1, a, ia, ja, 0, beta, c,
                  ic + s1, jc);
      RMatrixSyrk(s2, k, alpha, a, ia, ja + s1, optypea, beta, c, ic + s1,
                  jc + s1, isUpper);

      return;
    }
  }

  return;
}

static void CAblas::AblasSplitLength(const CMatrixDouble &a, const int n,
                                     int &n1, int &n2) {

  n1 = 0;
  n2 = 0;

  if (n > AblasBlockSize())
    AblasInternalSplitLength(n, AblasBlockSize(), n1, n2);
  else
    AblasInternalSplitLength(n, AblasMicroBlockSize(), n1, n2);

  return;
}

static void CAblas::AblasComplexSplitLength(const CMatrixComplex &a,
                                            const int n, int &n1, int &n2) {

  if (n > AblasComplexBlockSize())
    AblasInternalSplitLength(n, AblasComplexBlockSize(), n1, n2);
  else
    AblasInternalSplitLength(n, AblasMicroBlockSize(), n1, n2);
}

static void CAblas::RMatrixGemm(const int m, const int n, const int k,
                                const double alpha, const CMatrixDouble &a,
                                const int ia, const int ja, const int optypea,
                                const CMatrixDouble &b, const int ib,
                                const int jb, const int optypeb,
                                const double beta, CMatrixDouble &c,
                                const int ic, const int jc) {

  int s1 = 0;
  int s2 = 0;
  int bs;

  bs = AblasBlockSize();

  if (m <= bs && n <= bs && k <= bs) {
    RMatrixGemmK(m, n, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                 c, ic, jc);
    return;
  }

  if (m >= n && m >= k) {

    AblasSplitLength(a, m, s1, s2);

    if (optypea == 0) {
      RMatrixGemm(s1, n, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      RMatrixGemm(s2, n, k, alpha, a, ia + s1, ja, optypea, b, ib, jb, optypeb,
                  beta, c, ic + s1, jc);
    } else {
      RMatrixGemm(s1, n, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      RMatrixGemm(s2, n, k, alpha, a, ia, ja + s1, optypea, b, ib, jb, optypeb,
                  beta, c, ic + s1, jc);
    }
    return;
  }

  if (n >= m && n >= k) {

    AblasSplitLength(a, n, s1, s2);

    if (optypeb == 0) {
      RMatrixGemm(m, s1, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      RMatrixGemm(m, s2, k, alpha, a, ia, ja, optypea, b, ib, jb + s1, optypeb,
                  beta, c, ic, jc + s1);
    } else {
      RMatrixGemm(m, s1, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      RMatrixGemm(m, s2, k, alpha, a, ia, ja, optypea, b, ib + s1, jb, optypeb,
                  beta, c, ic, jc + s1);
    }
    return;
  }

  if (k >= m && k >= n) {

    AblasSplitLength(a, k, s1, s2);

    if (optypea == 0 && optypeb == 0) {
      RMatrixGemm(m, n, s1, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      RMatrixGemm(m, n, s2, alpha, a, ia, ja + s1, optypea, b, ib + s1, jb,
                  optypeb, 1.0, c, ic, jc);
    }

    if (optypea == 0 && optypeb != 0) {
      RMatrixGemm(m, n, s1, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      RMatrixGemm(m, n, s2, alpha, a, ia, ja + s1, optypea, b, ib, jb + s1,
                  optypeb, 1.0, c, ic, jc);
    }

    if (optypea != 0 && optypeb == 0) {
      RMatrixGemm(m, n, s1, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      RMatrixGemm(m, n, s2, alpha, a, ia + s1, ja, optypea, b, ib + s1, jb,
                  optypeb, 1.0, c, ic, jc);
    }

    if (optypea != 0 && optypeb != 0) {
      RMatrixGemm(m, n, s1, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      RMatrixGemm(m, n, s2, alpha, a, ia + s1, ja, optypea, b, ib, jb + s1,
                  optypeb, 1.0, c, ic, jc);
    }
  }

  return;
}

static void CAblas::RMatrixSyrk2(const int n, const int k, const double alpha,
                                 const CMatrixDouble &a, const int ia,
                                 const int ja, const int optypea,
                                 const double beta, CMatrixDouble &c,
                                 const int ic, const int jc,
                                 const bool isUpper) {

  if ((alpha == 0.0 || k == 0.0) && beta == 1.0)
    return;

  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (optypea == 0) {

    for (i = 0; i < n; i++) {
      if (isUpper) {
        j1 = i;
        j2 = n - 1;
      } else {
        j1 = 0;
        j2 = i;
      }
      for (j = j1; j <= j2; j++) {

        if (alpha != 0 && k > 0) {
          v = 0.0;
          for (i_ = ja; i_ < ja + k; i_++)
            v += a[ia + i][i_] * a[ia + j][i_];
        } else
          v = 0;

        if (beta == 0)
          c[ic + i].Set(jc + j, alpha * v);
        else
          c[ic + i].Set(jc + j, beta * c[ic + i][jc + j] + alpha * v);
      }
    }
    return;
  } else {

    for (i = 0; i < n; i++) {

      if (isUpper) {
        j1 = i;
        j2 = n - 1;
      } else {
        j1 = 0;
        j2 = i;
      }

      if (beta == 0) {
        for (j = j1; j <= j2; j++)
          c[ic + i].Set(jc + j, 0);
      } else {
        for (i_ = jc + j1; i_ <= jc + j2; i_++)
          c[ic + i].Set(i_, beta * c[ic + i][i_]);
      }
    }
    for (i = 0; i < k; i++) {
      for (j = 0; j < n; j++) {

        if (isUpper) {
          j1 = j;
          j2 = n - 1;
        } else {
          j1 = 0;
          j2 = j;
        }

        v = alpha * a[ia + i][ja + j];
        i1_ = (ja + j1) - (jc + j1);
        for (i_ = jc + j1; i_ <= jc + j2; i_++)
          c[ic + j].Set(i_, c[ic + j][i_] + v * a[ia + i][i_ + i1_]);
      }
    }
  }

  return;
}

static void CAblas::AblasInternalSplitLength(const int n, const int nb, int &n1,
                                             int &n2) {

  int r = 0;
  n1 = 0;
  n2 = 0;

  if (n <= nb) {

    n1 = n;
    n2 = 0;
  } else {

    if (n % nb != 0) {

      n2 = n % nb;
      n1 = n - n2;
    } else {

      n2 = n / 2;
      n1 = n - n2;

      if (n1 % nb == 0)
        return;
      r = nb - n1 % nb;
      n1 += r;
      n2 -= r;
    }
  }
}

static void CAblas::RMatrixGemmK(const int m, const int n, const int k,
                                 const double alpha, const CMatrixDouble &a,
                                 const int ia, const int ja, const int optypea,
                                 const CMatrixDouble &b, const int ib,
                                 const int jb, const int optypeb,
                                 const double beta, CMatrixDouble &c,
                                 const int ic, const int jc) {

  if (m * n == 0)
    return;

  int i = 0;
  int j = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (k == 0) {

    if (beta != 1) {

      if (beta != 0) {
        for (i = 0; i < m; i++)
          for (j = 0; j < n; j++)
            c[ic + i].Set(jc + j, beta * c[ic + i][jc + j]);
      } else {
        for (i = 0; i < m; i++)
          for (j = 0; j < n; j++)
            c[ic + i].Set(jc + j, 0);
      }
    }
    return;
  }

  if (optypea == 0 && optypeb != 0) {

    for (i = 0; i < m; i++) {
      for (j = 0; j < n; j++) {

        if (k == 0 || alpha == 0)
          v = 0;
        else {
          i1_ = jb - ja;
          v = 0.0;
          for (i_ = ja; i_ < ja + k; i_++)
            v += a[ia + i][i_] * b[ib + j][i_ + i1_];
        }

        if (beta == 0)
          c[ic + i].Set(jc + j, alpha * v);
        else
          c[ic + i].Set(jc + j, beta * c[ic + i][jc + j] + alpha * v);
      }
    }
    return;
  }

  if (optypea == 0 && optypeb == 0) {

    for (i = 0; i < m; i++) {

      if (beta != 0) {
        for (i_ = jc; i_ < jc + n; i_++)
          c[ic + i].Set(i_, beta * c[ic + i][i_]);
      } else {
        for (j = 0; j < n; j++)
          c[ic + i].Set(jc + j, 0);
      }

      if (alpha != 0) {
        for (j = 0; j < k; j++) {
          v = alpha * a[ia + i][ja + j];
          i1_ = jb - jc;
          for (i_ = jc; i_ < jc + n; i_++)
            c[ic + i].Set(i_, c[ic + i][i_] + v * b[ib + j][i_ + i1_]);
        }
      }
    }
    return;
  }

  if (optypea != 0 && optypeb != 0) {

    for (i = 0; i < m; i++) {
      for (j = 0; j < n; j++) {

        if (alpha == 0)
          v = 0;
        else {
          i1_ = (jb) - (ia);
          v = 0.0;
          for (i_ = ia; i_ < ia + k; i_++)
            v += a[i_][ja + i] * b[ib + j][i_ + i1_];
        }

        if (beta == 0)
          c[ic + i].Set(jc + j, alpha * v);
        else
          c[ic + i].Set(jc + j, beta * c[ic + i][jc + j] + alpha * v);
      }
    }
    return;
  }

  if (optypea != 0 && optypeb == 0) {

    if (beta == 0) {
      for (i = 0; i < m; i++)
        for (j = 0; j < n; j++)
          c[ic + i].Set(jc + j, 0);
    } else {
      for (i = 0; i < m; i++)
        for (i_ = jc; i_ < jc + n; i_++)
          c[ic + i].Set(i_, beta * c[ic + i][i_]);
    }

    if (alpha != 0) {
      for (j = 0; j < k; j++)
        for (i = 0; i < m; i++) {
          v = alpha * a[ia + j][ja + i];
          i1_ = jb - jc;
          for (i_ = jc; i_ < jc + n; i_++)
            c[ic + i].Set(i_, c[ic + i][i_] + v * b[ib + j][i_ + i1_]);
        }
    }
  }

  return;
}

static void CAblas::CMatrixTranspose(const int m, const int n,
                                     const CMatrixComplex &a, const int ia,
                                     const int ja, CMatrixComplex &b,
                                     const int ib, const int jb) {

  int i = 0;
  int s1 = 0;
  int s2 = 0;
  int i_ = 0;
  int i1_ = 0;

  if (m <= 2 * AblasComplexBlockSize() && n <= 2 * AblasComplexBlockSize()) {

    for (i = 0; i < m; i++) {
      i1_ = ja - ib;
      for (i_ = ib; i_ < ib + n; i_++)
        b[i_].Set(jb + i, a[ia + i][i_ + i1_]);
    }
  } else {

    if (m > n) {

      AblasComplexSplitLength(a, m, s1, s2);

      CMatrixTranspose(s1, n, a, ia, ja, b, ib, jb);
      CMatrixTranspose(s2, n, a, ia + s1, ja, b, ib, jb + s1);
    } else {

      AblasComplexSplitLength(a, n, s1, s2);

      CMatrixTranspose(m, s1, a, ia, ja, b, ib, jb);
      CMatrixTranspose(m, s2, a, ia, ja + s1, b, ib + s1, jb);
    }
  }
}

static void CAblas::RMatrixTranspose(const int m, const int n,
                                     const CMatrixDouble &a, const int ia,
                                     const int ja, CMatrixDouble &b,
                                     const int ib, const int jb) {

  int i = 0;
  int s1 = 0;
  int s2 = 0;
  int i_ = 0;
  int i1_ = 0;

  if (m <= 2 * AblasBlockSize() && n <= 2 * AblasBlockSize()) {

    for (i = 0; i < m; i++) {
      i1_ = ja - ib;
      for (i_ = ib; i_ < ib + n; i_++)
        b[i_].Set(jb + i, a[ia + i][i_ + i1_]);
    }
  } else {

    if (m > n) {

      AblasSplitLength(a, m, s1, s2);

      RMatrixTranspose(s1, n, a, ia, ja, b, ib, jb);
      RMatrixTranspose(s2, n, a, ia + s1, ja, b, ib, jb + s1);
    } else {

      AblasSplitLength(a, n, s1, s2);

      RMatrixTranspose(m, s1, a, ia, ja, b, ib, jb);
      RMatrixTranspose(m, s2, a, ia, ja + s1, b, ib + s1, jb);
    }
  }
}

static void CAblas::CMatrixCopy(const int m, const int n,
                                const CMatrixComplex &a, const int ia,
                                const int ja, CMatrixComplex &b, const int ib,
                                const int jb) {

  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  for (i = 0; i < m; i++) {
    i1_ = ja - jb;
    for (i_ = jb; i_ < jb + n; i_++)
      b[ib + i].Set(i_, a[ia + i][i_ + i1_]);
  }
}

static void CAblas::RMatrixCopy(const int m, const int n,
                                const CMatrixDouble &a, const int ia,
                                const int ja, CMatrixDouble &b, const int ib,
                                const int jb) {

  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  for (i = 0; i < m; i++) {
    i1_ = ja - jb;
    for (i_ = jb; i_ < jb + n; i_++)
      b[ib + i].Set(i_, a[ia + i][i_ + i1_]);
  }
}

static void CAblas::CMatrixRank1(const int m, const int n, CMatrixComplex &a,
                                 const int ia, const int ja,
                                 const al_complex &u[], const int iu,
                                 const al_complex &v[], const int iv) {

  if (m == 0 || n == 0)
    return;

  int i = 0;
  al_complex s = 0;
  int i_ = 0;
  int i1_ = 0;

  for (i = 0; i < m; i++) {
    s = u[iu + i];
    i1_ = iv - ja;
    for (i_ = ja; i_ < ja + n; i_++)
      a[ia + i].Set(i_, a[ia + i][i_] + s * v[i_ + i1_]);
  }
}

static void CAblas::RMatrixRank1(const int m, const int n, CMatrixDouble &a,
                                 const int ia, const int ja, const double &u[],
                                 const int iu, const double &v[],
                                 const int iv) {

  if (m == 0 || n == 0)
    return;

  int i = 0;
  double s = 0;
  int i_ = 0;
  int i1_ = 0;

  for (i = 0; i < m; i++) {
    s = u[iu + i];
    i1_ = iv - ja;
    for (i_ = ja; i_ < ja + n; i_++)
      a[ia + i].Set(i_, a[ia + i][i_] + s * v[i_ + i1_]);
  }
}

static void CAblas::CMatrixMVect(const int m, const int n,
                                 const CMatrixComplex &a, const int ia,
                                 const int ja, const int opa,
                                 const al_complex &x[], const int ix,
                                 al_complex &y[], const int iy) {

  int i = 0;
  al_complex v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (m == 0)
    return;

  if (n == 0) {
    for (i = 0; i < m; i++)
      y[iy + i] = 0;

    return;
  }

  if (opa == 0) {

    for (i = 0; i < m; i++) {
      i1_ = ix - ja;
      v = 0.0;
      for (i_ = ja; i_ < ja + n; i_++)
        v += a[ia + i][i_] * x[i_ + i1_];

      y[iy + i] = v;
    }

    return;
  }

  if (opa == 1) {

    for (i = 0; i < m; i++)
      y[iy + i] = 0;
    for (i = 0; i < n; i++) {
      v = x[ix + i];
      i1_ = ja - iy;
      for (i_ = iy; i_ <= iy + m - 1; i_++)
        y[i_] += v * a[ia + i][i_ + i1_];
    }

    return;
  }

  if (opa == 2) {

    for (i = 0; i < m; i++)
      y[iy + i] = 0;
    for (i = 0; i < n; i++) {
      v = x[ix + i];
      i1_ = ja - iy;
      for (i_ = iy; i_ <= iy + m - 1; i_++)
        y[i_] += v * CMath::Conj(a[ia + i][i_ + i1_]);
    }
  }

  return;
}

static void CAblas::RMatrixMVect(const int m, const int n,
                                 const CMatrixDouble &a, const int ia,
                                 const int ja, const int opa, const double &x[],
                                 const int ix, double &y[], const int iy) {

  int i = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (m == 0)
    return;

  if (n == 0) {
    for (i = 0; i < m; i++)
      y[iy + i] = 0;

    return;
  }

  if (opa == 0) {

    for (i = 0; i < m; i++) {
      i1_ = ix - ja;
      v = 0.0;
      for (i_ = ja; i_ < ja + n; i_++)
        v += a[ia + i][i_] * x[i_ + i1_];
      y[iy + i] = v;
    }

    return;
  }

  if (opa == 1) {

    for (i = 0; i < m; i++)
      y[iy + i] = 0;
    for (i = 0; i < n; i++) {
      v = x[ix + i];
      i1_ = ja - iy;
      for (i_ = iy; i_ < iy + m; i_++)
        y[i_] += v * a[ia + i][i_ + i1_];
    }

    return;
  }
}

static void CAblas::CMatrixRightTrsM(const int m, const int n,
                                     CMatrixComplex &a, const int i1,
                                     const int j1, const bool isUpper,
                                     const bool isUnit, const int optype,
                                     CMatrixComplex &x, const int i2,
                                     const int j2) {

  al_complex Alpha(-1, 0);
  al_complex Beta(1, 0);
  int s1 = 0;
  int s2 = 0;
  int bs = AblasComplexBlockSize();

  if (m <= bs && n <= bs) {

    CMatrixRightTrsM2(m, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

    return;
  }

  if (m >= n) {

    AblasComplexSplitLength(a, m, s1, s2);
    CMatrixRightTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
    CMatrixRightTrsM(s2, n, a, i1, j1, isUpper, isUnit, optype, x, i2 + s1, j2);
  } else {

    AblasComplexSplitLength(a, n, s1, s2);

    if (isUpper && optype == 0) {

      CMatrixRightTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
      CMatrixGemm(m, s2, s1, Alpha, x, i2, j2, 0, a, i1, j1 + s1, 0, Beta, x,
                  i2, j2 + s1);
      CMatrixRightTrsM(m, s2, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                       i2, j2 + s1);

      return;
    }

    if (isUpper && optype != 0) {

      CMatrixRightTrsM(m, s2, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                       i2, j2 + s1);
      CMatrixGemm(m, s1, s2, Alpha, x, i2, j2 + s1, 0, a, i1, j1 + s1, optype,
                  Beta, x, i2, j2);
      CMatrixRightTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

      return;
    }

    if (!isUpper && optype == 0) {

      CMatrixRightTrsM(m, s2, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                       i2, j2 + s1);
      CMatrixGemm(m, s1, s2, Alpha, x, i2, j2 + s1, 0, a, i1 + s1, j1, 0, Beta,
                  x, i2, j2);
      CMatrixRightTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

      return;
    }

    if (!isUpper && optype != 0) {

      CMatrixRightTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
      CMatrixGemm(m, s2, s1, Alpha, x, i2, j2, 0, a, i1 + s1, j1, optype, Beta,
                  x, i2, j2 + s1);
      CMatrixRightTrsM(m, s2, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                       i2, j2 + s1);
    }
  }

  return;
}

static void CAblas::CMatrixLeftTrsM(const int m, const int n, CMatrixComplex &a,
                                    const int i1, const int j1,
                                    const bool isUpper, const bool isUnit,
                                    const int optype, CMatrixComplex &x,
                                    const int i2, const int j2) {

  al_complex Alpha(-1, 0);
  al_complex Beta(1, 0);
  int s1 = 0;
  int s2 = 0;
  int bs = AblasComplexBlockSize();

  if (m <= bs && n <= bs) {

    CMatrixLeftTrsM2(m, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

    return;
  }

  if (n >= m) {

    AblasComplexSplitLength(x, n, s1, s2);
    CMatrixLeftTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
    CMatrixLeftTrsM(m, s2, a, i1, j1, isUpper, isUnit, optype, x, i2, j2 + s1);
  } else {

    AblasComplexSplitLength(a, m, s1, s2);

    if (isUpper && optype == 0) {

      CMatrixLeftTrsM(s2, n, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                      i2 + s1, j2);
      CMatrixGemm(s1, n, s2, Alpha, a, i1, j1 + s1, 0, x, i2 + s1, j2, 0, Beta,
                  x, i2, j2);
      CMatrixLeftTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

      return;
    }

    if (isUpper && optype != 0) {

      CMatrixLeftTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
      CMatrixGemm(s2, n, s1, Alpha, a, i1, j1 + s1, optype, x, i2, j2, 0, Beta,
                  x, i2 + s1, j2);
      CMatrixLeftTrsM(s2, n, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                      i2 + s1, j2);

      return;
    }

    if (!isUpper && optype == 0) {

      CMatrixLeftTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
      CMatrixGemm(s2, n, s1, Alpha, a, i1 + s1, j1, 0, x, i2, j2, 0, Beta, x,
                  i2 + s1, j2);
      CMatrixLeftTrsM(s2, n, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                      i2 + s1, j2);

      return;
    }

    if (!isUpper && optype != 0) {

      CMatrixLeftTrsM(s2, n, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                      i2 + s1, j2);
      CMatrixGemm(s1, n, s2, Alpha, a, i1 + s1, j1, optype, x, i2 + s1, j2, 0,
                  Beta, x, i2, j2);
      CMatrixLeftTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
    }
  }

  return;
}

static void CAblas::RMatrixRightTrsM(const int m, const int n, CMatrixDouble &a,
                                     const int i1, const int j1,
                                     const bool isUpper, const bool isUnit,
                                     const int optype, CMatrixDouble &x,
                                     const int i2, const int j2) {

  int s1 = 0;
  int s2 = 0;
  int bs = AblasBlockSize();

  if (m <= bs && n <= bs) {

    RMatrixRightTrsM2(m, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

    return;
  }

  if (m >= n) {

    AblasSplitLength(a, m, s1, s2);
    RMatrixRightTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
    RMatrixRightTrsM(s2, n, a, i1, j1, isUpper, isUnit, optype, x, i2 + s1, j2);
  } else {

    AblasSplitLength(a, n, s1, s2);

    if (isUpper && optype == 0) {

      RMatrixRightTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
      RMatrixGemm(m, s2, s1, -1.0, x, i2, j2, 0, a, i1, j1 + s1, 0, 1.0, x, i2,
                  j2 + s1);
      RMatrixRightTrsM(m, s2, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                       i2, j2 + s1);

      return;
    }

    if (isUpper && optype != 0) {

      RMatrixRightTrsM(m, s2, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                       i2, j2 + s1);
      RMatrixGemm(m, s1, s2, -1.0, x, i2, j2 + s1, 0, a, i1, j1 + s1, optype,
                  1.0, x, i2, j2);
      RMatrixRightTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

      return;
    }

    if (!isUpper && optype == 0) {

      RMatrixRightTrsM(m, s2, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                       i2, j2 + s1);
      RMatrixGemm(m, s1, s2, -1.0, x, i2, j2 + s1, 0, a, i1 + s1, j1, 0, 1.0, x,
                  i2, j2);
      RMatrixRightTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

      return;
    }

    if (!isUpper && optype != 0) {

      RMatrixRightTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
      RMatrixGemm(m, s2, s1, -1.0, x, i2, j2, 0, a, i1 + s1, j1, optype, 1.0, x,
                  i2, j2 + s1);
      RMatrixRightTrsM(m, s2, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                       i2, j2 + s1);
    }
  }

  return;
}

static void CAblas::RMatrixLeftTrsM(const int m, const int n, CMatrixDouble &a,
                                    const int i1, const int j1,
                                    const bool isUpper, const bool isUnit,
                                    const int optype, CMatrixDouble &x,
                                    const int i2, const int j2) {

  int s1 = 0;
  int s2 = 0;
  int bs = AblasBlockSize();

  if (m <= bs && n <= bs) {

    RMatrixLeftTrsM2(m, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

    return;
  }

  if (n >= m) {

    AblasSplitLength(x, n, s1, s2);
    RMatrixLeftTrsM(m, s1, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
    RMatrixLeftTrsM(m, s2, a, i1, j1, isUpper, isUnit, optype, x, i2, j2 + s1);
  } else {

    AblasSplitLength(a, m, s1, s2);

    if (isUpper && optype == 0) {

      RMatrixLeftTrsM(s2, n, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                      i2 + s1, j2);
      RMatrixGemm(s1, n, s2, -1.0, a, i1, j1 + s1, 0, x, i2 + s1, j2, 0, 1.0, x,
                  i2, j2);
      RMatrixLeftTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);

      return;
    }

    if (isUpper && optype != 0) {

      RMatrixLeftTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
      RMatrixGemm(s2, n, s1, -1.0, a, i1, j1 + s1, optype, x, i2, j2, 0, 1.0, x,
                  i2 + s1, j2);
      RMatrixLeftTrsM(s2, n, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                      i2 + s1, j2);

      return;
    }

    if (!isUpper && optype == 0) {

      RMatrixLeftTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
      RMatrixGemm(s2, n, s1, -1.0, a, i1 + s1, j1, 0, x, i2, j2, 0, 1.0, x,
                  i2 + s1, j2);
      RMatrixLeftTrsM(s2, n, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                      i2 + s1, j2);

      return;
    }

    if (!isUpper && optype != 0) {

      RMatrixLeftTrsM(s2, n, a, i1 + s1, j1 + s1, isUpper, isUnit, optype, x,
                      i2 + s1, j2);
      RMatrixGemm(s1, n, s2, -1.0, a, i1 + s1, j1, optype, x, i2 + s1, j2, 0,
                  1.0, x, i2, j2);
      RMatrixLeftTrsM(s1, n, a, i1, j1, isUpper, isUnit, optype, x, i2, j2);
    }
  }

  return;
}

static void CAblas::CMatrixSyrk(const int n, const int k, const double alpha,
                                CMatrixComplex &a, const int ia, const int ja,
                                const int optypea, const double beta,
                                CMatrixComplex &c, const int ic, const int jc,
                                const bool isUpper) {

  al_complex Alpha(alpha, 0);
  al_complex Beta(beta, 0);
  int s1 = 0;
  int s2 = 0;
  int bs = AblasComplexBlockSize();

  if (n <= bs && k <= bs) {

    CMatrixSyrk2(n, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);

    return;
  }

  if (k >= n) {

    AblasComplexSplitLength(a, k, s1, s2);

    if (optypea == 0) {
      CMatrixSyrk(n, s1, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      CMatrixSyrk(n, s2, alpha, a, ia, ja + s1, optypea, 1.0, c, ic, jc,
                  isUpper);
    } else {
      CMatrixSyrk(n, s1, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      CMatrixSyrk(n, s2, alpha, a, ia + s1, ja, optypea, 1.0, c, ic, jc,
                  isUpper);
    }
  } else {

    AblasComplexSplitLength(a, n, s1, s2);

    if (optypea == 0 && isUpper) {
      CMatrixSyrk(s1, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      CMatrixGemm(s1, s2, k, Alpha, a, ia, ja, 0, a, ia + s1, ja, 2, Beta, c,
                  ic, jc + s1);
      CMatrixSyrk(s2, k, alpha, a, ia + s1, ja, optypea, beta, c, ic + s1,
                  jc + s1, isUpper);

      return;
    }

    if (optypea == 0 && !isUpper) {
      CMatrixSyrk(s1, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      CMatrixGemm(s2, s1, k, Alpha, a, ia + s1, ja, 0, a, ia, ja, 2, Beta, c,
                  ic + s1, jc);
      CMatrixSyrk(s2, k, alpha, a, ia + s1, ja, optypea, beta, c, ic + s1,
                  jc + s1, isUpper);

      return;
    }

    if (optypea != 0 && isUpper) {
      CMatrixSyrk(s1, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      CMatrixGemm(s1, s2, k, Alpha, a, ia, ja, 2, a, ia, ja + s1, 0, Beta, c,
                  ic, jc + s1);
      CMatrixSyrk(s2, k, alpha, a, ia, ja + s1, optypea, beta, c, ic + s1,
                  jc + s1, isUpper);

      return;
    }

    if (optypea != 0 && !isUpper) {
      CMatrixSyrk(s1, k, alpha, a, ia, ja, optypea, beta, c, ic, jc, isUpper);
      CMatrixGemm(s2, s1, k, Alpha, a, ia, ja + s1, 2, a, ia, ja, 0, Beta, c,
                  ic + s1, jc);
      CMatrixSyrk(s2, k, alpha, a, ia, ja + s1, optypea, beta, c, ic + s1,
                  jc + s1, isUpper);
    }
  }

  return;
}

static void CAblas::CMatrixGemm(const int m, const int n, const int k,
                                al_complex &alpha, CMatrixComplex &a,
                                const int ia, const int ja, const int optypea,
                                CMatrixComplex &b, const int ib, const int jb,
                                const int optypeb, al_complex &beta,
                                CMatrixComplex &c, const int ic, const int jc) {

  al_complex Beta(1, 0);
  int s1 = 0;
  int s2 = 0;
  int bs = AblasComplexBlockSize();

  if (m <= bs && n <= bs && k <= bs) {

    CMatrixGemmk(m, n, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                 c, ic, jc);

    return;
  }

  if (m >= n && m >= k) {

    AblasComplexSplitLength(a, m, s1, s2);
    CMatrixGemm(s1, n, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                c, ic, jc);

    if (optypea == 0)
      CMatrixGemm(s2, n, k, alpha, a, ia + s1, ja, optypea, b, ib, jb, optypeb,
                  beta, c, ic + s1, jc);
    else
      CMatrixGemm(s2, n, k, alpha, a, ia, ja + s1, optypea, b, ib, jb, optypeb,
                  beta, c, ic + s1, jc);

    return;
  }

  if (n >= m && n >= k) {

    AblasComplexSplitLength(a, n, s1, s2);

    if (optypeb == 0) {
      CMatrixGemm(m, s1, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      CMatrixGemm(m, s2, k, alpha, a, ia, ja, optypea, b, ib, jb + s1, optypeb,
                  beta, c, ic, jc + s1);
    } else {
      CMatrixGemm(m, s1, k, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      CMatrixGemm(m, s2, k, alpha, a, ia, ja, optypea, b, ib + s1, jb, optypeb,
                  beta, c, ic, jc + s1);
    }

    return;
  }

  if (k >= m && k >= n) {

    AblasComplexSplitLength(a, k, s1, s2);

    if (optypea == 0 && optypeb == 0) {
      CMatrixGemm(m, n, s1, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      CMatrixGemm(m, n, s2, alpha, a, ia, ja + s1, optypea, b, ib + s1, jb,
                  optypeb, Beta, c, ic, jc);
    }

    if (optypea == 0 && optypeb != 0) {
      CMatrixGemm(m, n, s1, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      CMatrixGemm(m, n, s2, alpha, a, ia, ja + s1, optypea, b, ib, jb + s1,
                  optypeb, Beta, c, ic, jc);
    }

    if (optypea != 0 && optypeb == 0) {
      CMatrixGemm(m, n, s1, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      CMatrixGemm(m, n, s2, alpha, a, ia + s1, ja, optypea, b, ib + s1, jb,
                  optypeb, Beta, c, ic, jc);
    }

    if (optypea != 0 && optypeb != 0) {
      CMatrixGemm(m, n, s1, alpha, a, ia, ja, optypea, b, ib, jb, optypeb, beta,
                  c, ic, jc);
      CMatrixGemm(m, n, s2, alpha, a, ia + s1, ja, optypea, b, ib, jb + s1,
                  optypeb, Beta, c, ic, jc);
    }
  }

  return;
}

static void CAblas::CMatrixRightTrsM2(const int m, const int n,
                                      CMatrixComplex &a, const int i1,
                                      const int j1, const bool isUpper,
                                      const bool isUnit, const int optype,
                                      CMatrixComplex &x, const int i2,
                                      const int j2) {

  if (n * m == 0)
    return;

  int i = 0;
  int j = 0;
  al_complex vc = 0;
  al_complex vd = 0;
  int i_ = 0;
  int i1_ = 0;

  if (isUpper) {

    if (optype == 0) {

      for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {

          if (isUnit)
            vd = 1;
          else
            vd = a[i1 + j][j1 + j];

          x[i2 + i].Set(j2 + j, x[i2 + i][j2 + j] / vd);

          if (j < n - 1) {
            vc = x[i2 + i][j2 + j];
            i1_ = j1 - j2;
            for (i_ = j2 + j + 1; i_ < j2 + n; i_++)
              x[i2 + i].Set(i_, x[i2 + i][i_] - vc * a[i1 + j][i_ + i1_]);
          }
        }
      }

      return;
    }

    if (optype == 1) {

      for (i = 0; i < m; i++) {
        for (j = n - 1; j >= 0; j--) {
          vc = 0;
          vd = 1;

          if (j < n - 1) {
            i1_ = j1 - j2;
            vc = 0.0;
            for (i_ = j2 + j + 1; i_ < j2 + n; i_++)
              vc += x[i2 + i][i_] * a[i1 + j][i_ + i1_];
          }

          if (!isUnit)
            vd = a[i1 + j][j1 + j];

          x[i2 + i].Set(j2 + j, (x[i2 + i][j2 + j] - vc) / vd);
        }
      }

      return;
    }

    if (optype == 2) {

      for (i = 0; i < m; i++) {
        for (j = n - 1; j >= 0; j--) {
          vc = 0;
          vd = 1;

          if (j < n - 1) {
            i1_ = j1 - j2;
            vc = 0.0;
            for (i_ = j2 + j + 1; i_ < j2 + n; i_++)
              vc += x[i2 + i][i_] * CMath::Conj(a[i1 + j][i_ + i1_]);
          }

          if (!isUnit)
            vd = CMath::Conj(a[i1 + j][j1 + j]);

          x[i2 + i].Set(j2 + j, (x[i2 + i][j2 + j] - vc) / vd);
        }
      }

      return;
    }
  } else {

    if (optype == 0) {

      for (i = 0; i < m; i++) {
        for (j = n - 1; j >= 0; j--) {

          if (isUnit)
            vd = 1;
          else
            vd = a[i1 + j][j1 + j];

          x[i2 + i].Set(j2 + j, x[i2 + i][j2 + j] / vd);

          if (j > 0) {
            vc = x[i2 + i][j2 + j];
            i1_ = j1 - j2;
            for (i_ = j2; i_ < j2 + j; i_++)
              x[i2 + i].Set(i_, x[i2 + i][i_] - vc * a[i1 + j][i_ + i1_]);
          }
        }
      }

      return;
    }
    if (optype == 1) {

      for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
          vc = 0;
          vd = 1;

          if (j > 0) {
            i1_ = j1 - j2;
            vc = 0.0;
            for (i_ = j2; i_ < j2 + j; i_++)
              vc += x[i2 + i][i_] * a[i1 + j][i_ + i1_];
          }

          if (!isUnit)
            vd = a[i1 + j][j1 + j];

          x[i2 + i].Set(j2 + j, (x[i2 + i][j2 + j] - vc) / vd);
        }
      }

      return;
    }
    if (optype == 2) {

      for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
          vc = 0;
          vd = 1;

          if (j > 0) {
            i1_ = j1 - j2;
            vc = 0.0;
            for (i_ = j2; i_ < j2 + j; i_++)
              vc += x[i2 + i][i_] * CMath::Conj(a[i1 + j][i_ + i1_]);
          }

          if (!isUnit)
            vd = CMath::Conj(a[i1 + j][j1 + j]);

          x[i2 + i].Set(j2 + j, (x[i2 + i][j2 + j] - vc) / vd);
        }
      }
    }
  }

  return;
}

static void CAblas::CMatrixLeftTrsM2(const int m, const int n,
                                     CMatrixComplex &a, const int i1,
                                     const int j1, const bool isUpper,
                                     const bool isUnit, const int optype,
                                     CMatrixComplex &x, const int i2,
                                     const int j2) {

  if (n * m == 0)
    return;

  al_complex Beta(1, 0);
  int i = 0;
  int j = 0;
  al_complex vc = 0;
  al_complex vd = 0;
  int i_ = 0;

  if (isUpper) {

    if (optype == 0) {

      for (i = m - 1; i >= 0; i--) {
        for (j = i + 1; j <= m - 1; j++) {
          vc = a[i1 + i][j1 + j];

          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + i].Set(i_, x[i2 + i][i_] - vc * x[i2 + j][i_]);
        }

        if (!isUnit) {
          vd = Beta / a[i1 + i][j1 + i];

          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
        }
      }

      return;
    }

    if (optype == 1) {

      for (i = 0; i < m; i++) {

        if (isUnit)
          vd = 1;
        else
          vd = Beta / a[i1 + i][j1 + i];

        for (i_ = j2; i_ < j2 + n; i_++)
          x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
        for (j = i + 1; j <= m - 1; j++) {
          vc = a[i1 + i][j1 + j];
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + j].Set(i_, x[i2 + j][i_] - vc * x[i2 + i][i_]);
        }
      }

      return;
    }

    if (optype == 2) {

      for (i = 0; i < m; i++) {

        if (isUnit)
          vd = 1;
        else
          vd = Beta / CMath::Conj(a[i1 + i][j1 + i]);

        for (i_ = j2; i_ < j2 + n; i_++)
          x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
        for (j = i + 1; j <= m - 1; j++) {
          vc = CMath::Conj(a[i1 + i][j1 + j]);
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + j].Set(i_, x[i2 + j][i_] - vc * x[i2 + i][i_]);
        }
      }

      return;
    }
  } else {

    if (optype == 0) {

      for (i = 0; i < m; i++) {

        for (j = 0; j < i; j++) {
          vc = a[i1 + i][j1 + j];
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + i].Set(i_, x[i2 + i][i_] - vc * x[i2 + j][i_]);
        }

        if (isUnit)
          vd = 1;
        else
          vd = Beta / a[i1 + j][j1 + j];

        for (i_ = j2; i_ < j2 + n; i_++)
          x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
      }

      return;
    }
    if (optype == 1) {

      for (i = m - 1; i >= 0; i--) {

        if (isUnit)
          vd = 1;
        else
          vd = Beta / a[i1 + i][j1 + i];

        for (i_ = j2; i_ < j2 + n; i_++)
          x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
        for (j = i - 1; j >= 0; j--) {
          vc = a[i1 + i][j1 + j];
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + j].Set(i_, x[i2 + j][i_] - vc * x[i2 + i][i_]);
        }
      }

      return;
    }
    if (optype == 2) {

      for (i = m - 1; i >= 0; i--) {

        if (isUnit)
          vd = 1;
        else
          vd = Beta / CMath::Conj(a[i1 + i][j1 + i]);

        for (i_ = j2; i_ < j2 + n; i_++)
          x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
        for (j = i - 1; j >= 0; j--) {
          vc = CMath::Conj(a[i1 + i][j1 + j]);
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + j].Set(i_, x[i2 + j][i_] - vc * x[i2 + i][i_]);
        }
      }
    }
  }

  return;
}

static void CAblas::RMatrixRightTrsM2(const int m, const int n,
                                      CMatrixDouble &a, const int i1,
                                      const int j1, const bool isUpper,
                                      const bool isUnit, const int optype,
                                      CMatrixDouble &x, const int i2,
                                      const int j2) {

  if (n * m == 0)
    return;

  int i = 0;
  int j = 0;
  double vr = 0;
  double vd = 0;
  int i_ = 0;
  int i1_ = 0;

  if (isUpper) {

    if (optype == 0) {

      for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {

          if (isUnit)
            vd = 1;
          else
            vd = a[i1 + j][j1 + j];

          x[i2 + i].Set(j2 + j, x[i2 + i][j2 + j] / vd);

          if (j < n - 1) {
            vr = x[i2 + i][j2 + j];
            i1_ = j1 - j2;

            for (i_ = j2 + j + 1; i_ < j2 + n; i_++)
              x[i2 + i].Set(i_, x[i2 + i][i_] - vr * a[i1 + j][i_ + i1_]);
          }
        }
      }

      return;
    }

    if (optype == 1) {

      for (i = 0; i < m; i++) {
        for (j = n - 1; j >= 0; j--) {
          vr = 0;
          vd = 1;

          if (j < n - 1) {
            i1_ = j1 - j2;
            vr = 0.0;
            for (i_ = j2 + j + 1; i_ < j2 + n; i_++)
              vr += x[i2 + i][i_] * a[i1 + j][i_ + i1_];
          }

          if (!isUnit)
            vd = a[i1 + j][j1 + j];

          x[i2 + i].Set(j2 + j, (x[i2 + i][j2 + j] - vr) / vd);
        }
      }

      return;
    }
  } else {

    if (optype == 0) {

      for (i = 0; i < m; i++) {
        for (j = n - 1; j >= 0; j--) {

          if (isUnit)
            vd = 1;
          else
            vd = a[i1 + j][j1 + j];

          x[i2 + i].Set(j2 + j, x[i2 + i][j2 + j] / vd);

          if (j > 0) {
            vr = x[i2 + i][j2 + j];
            i1_ = j1 - j2;

            for (i_ = j2; i_ < j2 + j; i_++)
              x[i2 + i].Set(i_, x[i2 + i][i_] - vr * a[i1 + j][i_ + i1_]);
          }
        }
      }

      return;
    }

    if (optype == 1) {

      for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
          vr = 0;
          vd = 1;

          if (j > 0) {
            i1_ = j1 - j2;
            vr = 0.0;
            for (i_ = j2; i_ < j2 + j; i_++)
              vr += x[i2 + i][i_] * a[i1 + j][i_ + i1_];
          }

          if (!isUnit)
            vd = a[i1 + j][j1 + j];

          x[i2 + i].Set(j2 + j, (x[i2 + i][j2 + j] - vr) / vd);
        }
      }
    }
  }

  return;
}

static void CAblas::RMatrixLeftTrsM2(const int m, const int n, CMatrixDouble &a,
                                     const int i1, const int j1,
                                     const bool isUpper, const bool isUnit,
                                     const int optype, CMatrixDouble &x,
                                     const int i2, const int j2) {

  if (n * m == 0)
    return;

  int i = 0;
  int j = 0;
  double vr = 0;
  double vd = 0;
  int i_ = 0;

  if (isUpper) {

    if (optype == 0) {

      for (i = m - 1; i >= 0; i--) {
        for (j = i + 1; j <= m - 1; j++) {
          vr = a[i1 + i][j1 + j];
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + i].Set(i_, x[i2 + i][i_] - vr * x[i2 + j][i_]);
        }

        if (!isUnit) {
          vd = 1 / a[i1 + i][j1 + i];
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
        }
      }

      return;
    }

    if (optype == 1) {

      for (i = 0; i < m; i++) {

        if (isUnit)
          vd = 1;
        else
          vd = 1 / a[i1 + i][j1 + i];

        for (i_ = j2; i_ < j2 + n; i_++)
          x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
        for (j = i + 1; j <= m - 1; j++) {
          vr = a[i1 + i][j1 + j];
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + j].Set(i_, x[i2 + j][i_] - vr * x[i2 + i][i_]);
        }
      }

      return;
    }
  } else {

    if (optype == 0) {

      for (i = 0; i < m; i++) {
        for (j = 0; j < i; j++) {
          vr = a[i1 + i][j1 + j];
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + i].Set(i_, x[i2 + i][i_] - vr * x[i2 + j][i_]);
        }

        if (isUnit)
          vd = 1;
        else
          vd = 1 / a[i1 + j][j1 + j];
        for (i_ = j2; i_ < j2 + n; i_++)
          x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
      }

      return;
    }

    if (optype == 1) {

      for (i = m - 1; i >= 0; i--) {

        if (isUnit)
          vd = 1;
        else
          vd = 1 / a[i1 + i][j1 + i];

        for (i_ = j2; i_ < j2 + n; i_++)
          x[i2 + i].Set(i_, vd * x[i2 + i][i_]);
        for (j = i - 1; j >= 0; j--) {
          vr = a[i1 + i][j1 + j];
          for (i_ = j2; i_ < j2 + n; i_++)
            x[i2 + j].Set(i_, x[i2 + j][i_] - vr * x[i2 + i][i_]);
        }
      }
    }
  }

  return;
}

static void CAblas::CMatrixSyrk2(const int n, const int k, const double alpha,
                                 const CMatrixComplex &a, const int ia,
                                 const int ja, const int optypea,
                                 const double beta, CMatrixComplex &c,
                                 const int ic, const int jc,
                                 const bool isUpper) {

  if ((alpha == 0 || k == 0) && beta == 1)
    return;

  al_complex Alpha(alpha, 0);
  al_complex Beta(beta, 0);
  al_complex Zero(0, 0);
  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;
  al_complex v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (optypea == 0) {

    for (i = 0; i < n; i++) {

      if (isUpper) {
        j1 = i;
        j2 = n - 1;
      } else {
        j1 = 0;
        j2 = i;
      }

      for (j = j1; j <= j2; j++) {

        if (alpha != 0 && k > 0) {
          v = 0.0;
          for (i_ = ja; i_ <= ja + k - 1; i_++)
            v += a[ia + i][i_] * CMath::Conj(a[ia + j][i_]);
        } else
          v = 0;

        if (beta == 0)
          c[ic + i].Set(jc + j, Alpha * v);
        else
          c[ic + i].Set(jc + j, Beta * c[ic + i][jc + j] + Alpha * v);
      }
    }

    return;
  } else {

    for (i = 0; i < n; i++) {

      if (isUpper) {
        j1 = i;
        j2 = n - 1;
      } else {
        j1 = 0;
        j2 = i;
      }

      if (beta == 0) {
        for (j = j1; j <= j2; j++)
          c[ic + i].Set(jc + j, Zero);
      } else {
        for (i_ = jc + j1; i_ <= jc + j2; i_++)
          c[ic + i].Set(i_, Beta * c[ic + i][i_]);
      }
    }

    for (i = 0; i < k; i++) {
      for (j = 0; j < n; j++) {

        if (isUpper) {
          j1 = j;
          j2 = n - 1;
        } else {
          j1 = 0;
          j2 = j;
        }
        v = Alpha * CMath::Conj(a[ia + i][ja + j]);
        i1_ = (ja + j1) - (jc + j1);
        for (i_ = jc + j1; i_ <= jc + j2; i_++)
          c[ic + j].Set(i_, c[ic + j][i_] + v * a[ia + i][i_ + i1_]);
      }
    }
  }

  return;
}

static void CAblas::CMatrixGemmk(const int m, const int n, const int k,
                                 al_complex &alpha, const CMatrixComplex &a,
                                 const int ia, const int ja, const int optypea,
                                 const CMatrixComplex &b, const int ib,
                                 const int jb, const int optypeb,
                                 al_complex &beta, CMatrixComplex &c,
                                 const int ic, const int jc) {

  if (m * n == 0)
    return;

  al_complex Zero(0, 0);
  int i = 0;
  int j = 0;
  al_complex v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (k == 0) {

    if (beta != Zero) {

      for (i = 0; i < m; i++)
        for (j = 0; j < n; j++)
          c[ic + i].Set(jc + j, beta * c[ic + i][jc + j]);
    } else {

      for (i = 0; i < m; i++)
        for (j = 0; j < n; j++)
          c[ic + i].Set(jc + j, Zero);
    }

    return;
  }

  if (optypea == 0 && optypeb != 0) {

    for (i = 0; i < m; i++) {
      for (j = 0; j < n; j++) {

        if (k == 0 || alpha == Zero)
          v = 0;
        else {

          if (optypeb == 1) {
            i1_ = (jb) - (ja);
            v = 0.0;
            for (i_ = ja; i_ <= ja + k - 1; i_++)
              v += a[ia + i][i_] * b[ib + j][i_ + i1_];
          } else {
            i1_ = (jb) - (ja);
            v = 0.0;
            for (i_ = ja; i_ <= ja + k - 1; i_++)
              v += a[ia + i][i_] * CMath::Conj(b[ib + j][i_ + i1_]);
          }
        }

        if (beta == Zero)
          c[ic + i].Set(jc + j, alpha * v);
        else
          c[ic + i].Set(jc + j, beta * c[ic + i][jc + j] + alpha * v);
      }
    }

    return;
  }
  if (optypea == 0 && optypeb == 0) {

    for (i = 0; i < m; i++) {

      if (beta != Zero) {
        for (i_ = jc; i_ <= jc + n - 1; i_++)
          c[ic + i].Set(i_, beta * c[ic + i][i_]);
      } else {
        for (j = 0; j < n; j++)
          c[ic + i].Set(jc + j, Zero);
      }

      if (alpha != Zero) {
        for (j = 0; j <= k - 1; j++) {
          v = alpha * a[ia + i][ja + j];
          i1_ = (jb) - (jc);
          for (i_ = jc; i_ <= jc + n - 1; i_++)
            c[ic + i].Set(i_, c[ic + i][i_] + v * b[ib + j][i_ + i1_]);
        }
      }
    }

    return;
  }

  if (optypea != 0 && optypeb != 0) {

    for (i = 0; i < m; i++) {
      for (j = 0; j < n; j++) {

        if (alpha == Zero)
          v = 0;
        else {

          if (optypea == 1) {

            if (optypeb == 1) {
              i1_ = (jb) - (ia);
              v = 0.0;
              for (i_ = ia; i_ <= ia + k - 1; i_++)
                v += a[i_][ja + i] * b[ib + j][i_ + i1_];
            } else {
              i1_ = (jb) - (ia);
              v = 0.0;
              for (i_ = ia; i_ <= ia + k - 1; i_++)
                v += a[i_][ja + i] * CMath::Conj(b[ib + j][i_ + i1_]);
            }
          } else {

            if (optypeb == 1) {
              i1_ = (jb) - (ia);
              v = 0.0;
              for (i_ = ia; i_ <= ia + k - 1; i_++)
                v += CMath::Conj(a[i_][ja + i]) * b[ib + j][i_ + i1_];
            } else {
              i1_ = (jb) - (ia);
              v = 0.0;
              for (i_ = ia; i_ <= ia + k - 1; i_++)
                v += CMath::Conj(a[i_][ja + i]) *
                     CMath::Conj(b[ib + j][i_ + i1_]);
            }
          }
        }

        if (beta == Zero)
          c[ic + i].Set(jc + j, alpha * v);
        else
          c[ic + i].Set(jc + j, beta * c[ic + i][jc + j] + alpha * v);
      }
    }

    return;
  }

  if (optypea != 0 && optypeb == 0) {

    if (beta == Zero) {
      for (i = 0; i < m; i++)
        for (j = 0; j < n; j++)
          c[ic + i].Set(jc + j, Zero);
    } else {
      for (i = 0; i < m; i++)
        for (i_ = jc; i_ <= jc + n - 1; i_++)
          c[ic + i].Set(i_, beta * c[ic + i][i_]);
    }

    if (alpha != Zero) {
      for (j = 0; j <= k - 1; j++)
        for (i = 0; i < m; i++) {

          if (optypea == 1)
            v = alpha * a[ia + j][ja + i];
          else
            v = alpha * CMath::Conj(a[ia + j][ja + i]);
          i1_ = (jb) - (jc);
          for (i_ = jc; i_ <= jc + n - 1; i_++)
            c[ic + i].Set(i_, c[ic + i][i_] + v * b[ib + j][i_ + i1_]);
        }
    }
  }

  return;
}

class COrtFac {
private:
  static void RMatrixQRBaseCase(CMatrixDouble &a, const int m, const int n,
                                double &work[], double &t[], double &tau[]);
  static void RMatrixLQBaseCase(CMatrixDouble &a, const int m, const int n,
                                double &work[], double &t[], double &tau[]);
  static void CMatrixQRBaseCase(CMatrixComplex &a, const int m, const int n,
                                al_complex &work[], al_complex &t[],
                                al_complex &tau[]);
  static void CMatrixLQBaseCase(CMatrixComplex &a, const int m, const int n,
                                al_complex &work[], al_complex &t[],
                                al_complex &tau[]);
  static void RMatrixBlockReflector(CMatrixDouble &a, double &tau[],
                                    const bool columnwisea, const int lengtha,
                                    const int blocksize, CMatrixDouble &t,
                                    double &work[]);
  static void CMatrixBlockReflector(CMatrixComplex &a, al_complex &tau[],
                                    const bool columnwisea, const int lengtha,
                                    const int blocksize, CMatrixComplex &t,
                                    al_complex &work[]);

public:
  COrtFac(void);
  ~COrtFac(void);

  static void RMatrixQR(CMatrixDouble &a, const int m, const int n,
                        double &tau[]);
  static void RMatrixLQ(CMatrixDouble &a, const int m, const int n,
                        double &tau[]);
  static void RMatrixQRUnpackQ(CMatrixDouble &a, const int m, const int n,
                               double &tau[], const int qcolumns,
                               CMatrixDouble &q);
  static void RMatrixQRUnpackR(CMatrixDouble &a, const int m, const int n,
                               CMatrixDouble &r);
  static void RMatrixLQUnpackQ(CMatrixDouble &a, const int m, const int n,
                               double &tau[], const int qrows,
                               CMatrixDouble &q);
  static void RMatrixLQUnpackL(CMatrixDouble &a, const int m, const int n,
                               CMatrixDouble &l);
  static void RMatrixBD(CMatrixDouble &a, const int m, const int n,
                        double &tauq[], double &taup[]);
  static void RMatrixBDUnpackQ(CMatrixDouble &qp, const int m, const int n,
                               double &tauq[], const int qcolumns,
                               CMatrixDouble &q);
  static void RMatrixBDMultiplyByQ(CMatrixDouble &qp, const int m, const int n,
                                   double &tauq[], CMatrixDouble &z,
                                   const int zrows, const int zcolumns,
                                   const bool fromtheright,
                                   const bool dotranspose);
  static void RMatrixBDUnpackPT(CMatrixDouble &qp, const int m, const int n,
                                double &taup[], const int ptrows,
                                CMatrixDouble &pt);
  static void RMatrixBDMultiplyByP(CMatrixDouble &qp, const int m, const int n,
                                   double &taup[], CMatrixDouble &z,
                                   const int zrows, const int zcolumns,
                                   const bool fromtheright,
                                   const bool dotranspose);
  static void RMatrixBDUnpackDiagonals(CMatrixDouble &b, const int m,
                                       const int n, bool &isupper, double &d[],
                                       double &e[]);
  static void RMatrixHessenberg(CMatrixDouble &a, const int n, double &tau[]);
  static void RMatrixHessenbergUnpackQ(CMatrixDouble &a, const int n,
                                       double &tau[], CMatrixDouble &q);
  static void RMatrixHessenbergUnpackH(CMatrixDouble &a, const int n,
                                       CMatrixDouble &h);
  static void SMatrixTD(CMatrixDouble &a, const int n, const bool isupper,
                        double &tau[], double &d[], double &e[]);
  static void SMatrixTDUnpackQ(CMatrixDouble &a, const int n,
                               const bool isupper, double &tau[],
                               CMatrixDouble &q);

  static void CMatrixQR(CMatrixComplex &a, const int m, const int n,
                        al_complex &tau[]);
  static void CMatrixLQ(CMatrixComplex &a, const int m, const int n,
                        al_complex &tau[]);
  static void CMatrixQRUnpackQ(CMatrixComplex &a, const int m, const int n,
                               al_complex &tau[], const int qcolumns,
                               CMatrixComplex &q);
  static void CMatrixQRUnpackR(CMatrixComplex &a, const int m, const int n,
                               CMatrixComplex &r);
  static void CMatrixLQUnpackQ(CMatrixComplex &a, const int m, const int n,
                               al_complex &tau[], const int qrows,
                               CMatrixComplex &q);
  static void CMatrixLQUnpackL(CMatrixComplex &a, const int m, const int n,
                               CMatrixComplex &l);
  static void HMatrixTD(CMatrixComplex &a, const int n, const bool isupper,
                        al_complex &tau[], double &d[], double &e[]);
  static void HMatrixTDUnpackQ(CMatrixComplex &a, const int n,
                               const bool isupper, al_complex &tau[],
                               CMatrixComplex &q);
};

COrtFac::COrtFac(void) {}

COrtFac::~COrtFac(void) {}

static void COrtFac::RMatrixQR(CMatrixDouble &a, const int m, const int n,
                               double &tau[]) {

  if (m <= 0 || n <= 0)
    return;

  int minmn = MathMin(m, n);
  int blockstart = 0;
  int blocksize = 0;
  int rowscount = 0;
  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  double work[];
  double t[];
  double taubuf[];

  CMatrixDouble tmpa;
  CMatrixDouble tmpt;
  CMatrixDouble tmpr;

  ArrayResizeAL(work, MathMax(m, n) + 1);
  ArrayResizeAL(t, MathMax(m, n) + 1);
  ArrayResizeAL(tau, minmn);
  ArrayResizeAL(taubuf, minmn);

  tmpa.Resize(m, CAblas::AblasBlockSize());
  tmpt.Resize(CAblas::AblasBlockSize(), 2 * CAblas::AblasBlockSize());
  tmpr.Resize(2 * CAblas::AblasBlockSize(), n);

  while (blockstart != minmn) {

    blocksize = minmn - blockstart;
    if (blocksize > CAblas::AblasBlockSize())
      blocksize = CAblas::AblasBlockSize();

    rowscount = m - blockstart;

    CAblas::RMatrixCopy(rowscount, blocksize, a, blockstart, blockstart, tmpa,
                        0, 0);
    RMatrixQRBaseCase(tmpa, rowscount, blocksize, work, t, taubuf);
    CAblas::RMatrixCopy(rowscount, blocksize, tmpa, 0, 0, a, blockstart,
                        blockstart);
    i1_ = -blockstart;
    for (i_ = blockstart; i_ <= blockstart + blocksize - 1; i_++)
      tau[i_] = taubuf[i_ + i1_];

    if (blockstart + blocksize <= n - 1) {

      if (n - blockstart - blocksize >= 2 * CAblas::AblasBlockSize() ||
          rowscount >= 4 * CAblas::AblasBlockSize()) {

        RMatrixBlockReflector(tmpa, taubuf, true, rowscount, blocksize, tmpt,
                              work);

        CAblas::RMatrixGemm(blocksize, n - blockstart - blocksize, rowscount,
                            1.0, tmpa, 0, 0, 1, a, blockstart,
                            blockstart + blocksize, 0, 0.0, tmpr, 0, 0);
        CAblas::RMatrixGemm(blocksize, n - blockstart - blocksize, blocksize,
                            1.0, tmpt, 0, 0, 1, tmpr, 0, 0, 0, 0.0, tmpr,
                            blocksize, 0);
        CAblas::RMatrixGemm(rowscount, n - blockstart - blocksize, blocksize,
                            1.0, tmpa, 0, 0, 0, tmpr, blocksize, 0, 0, 1.0, a,
                            blockstart, blockstart + blocksize);
      } else {

        for (i = 0; i < blocksize; i++) {
          i1_ = i - 1;
          for (i_ = 1; i_ <= rowscount - i; i_++)
            t[i_] = tmpa[i_ + i1_][i];
          t[1] = 1;

          CReflections::ApplyReflectionFromTheLeft(
              a, taubuf[i], t, blockstart + i, m - 1, blockstart + blocksize,
              n - 1, work);
        }
      }
    }

    blockstart = blockstart + blocksize;
  }
}

static void COrtFac::RMatrixLQ(CMatrixDouble &a, const int m, const int n,
                               double &tau[]) {

  if (m <= 0 || n <= 0)
    return;

  int minmn = MathMin(m, n);
  int blockstart = 0;
  int blocksize = 0;
  int columnscount = 0;
  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  double work[];
  double t[];
  double taubuf[];

  CMatrixDouble tmpa;
  CMatrixDouble tmpt;
  CMatrixDouble tmpr;

  ArrayResizeAL(work, MathMax(m, n) + 1);
  ArrayResizeAL(t, MathMax(m, n) + 1);
  ArrayResizeAL(tau, minmn);
  ArrayResizeAL(taubuf, minmn);

  tmpa.Resize(CAblas::AblasBlockSize(), n);
  tmpt.Resize(CAblas::AblasBlockSize(), 2 * CAblas::AblasBlockSize());
  tmpr.Resize(m, 2 * CAblas::AblasBlockSize());

  while (blockstart != minmn) {

    blocksize = minmn - blockstart;
    if (blocksize > CAblas::AblasBlockSize())
      blocksize = CAblas::AblasBlockSize();

    columnscount = n - blockstart;

    CAblas::RMatrixCopy(blocksize, columnscount, a, blockstart, blockstart,
                        tmpa, 0, 0);
    RMatrixLQBaseCase(tmpa, blocksize, columnscount, work, t, taubuf);
    CAblas::RMatrixCopy(blocksize, columnscount, tmpa, 0, 0, a, blockstart,
                        blockstart);
    i1_ = -blockstart;
    for (i_ = blockstart; i_ <= blockstart + blocksize - 1; i_++) {
      tau[i_] = taubuf[i_ + i1_];
    }

    if (blockstart + blocksize <= m - 1) {

      if (m - blockstart - blocksize >= 2 * CAblas::AblasBlockSize()) {

        RMatrixBlockReflector(tmpa, taubuf, false, columnscount, blocksize,
                              tmpt, work);

        CAblas::RMatrixGemm(m - blockstart - blocksize, blocksize, columnscount,
                            1.0, a, blockstart + blocksize, blockstart, 0, tmpa,
                            0, 0, 1, 0.0, tmpr, 0, 0);
        CAblas::RMatrixGemm(m - blockstart - blocksize, blocksize, blocksize,
                            1.0, tmpr, 0, 0, 0, tmpt, 0, 0, 0, 0.0, tmpr, 0,
                            blocksize);
        CAblas::RMatrixGemm(m - blockstart - blocksize, columnscount, blocksize,
                            1.0, tmpr, 0, blocksize, 0, tmpa, 0, 0, 0, 1.0, a,
                            blockstart + blocksize, blockstart);
      } else {

        for (i = 0; i < blocksize; i++) {
          i1_ = i - 1;
          for (i_ = 1; i_ <= columnscount - i; i_++)
            t[i_] = tmpa[i][i_ + i1_];
          t[1] = 1;

          CReflections::ApplyReflectionFromTheRight(
              a, taubuf[i], t, blockstart + blocksize, m - 1, blockstart + i,
              n - 1, work);
        }
      }
    }

    blockstart = blockstart + blocksize;
  }
}

static void COrtFac::CMatrixQR(CMatrixComplex &a, const int m, const int n,
                               al_complex &tau[]) {

  if (m <= 0 || n <= 0)
    return;

  al_complex work[];
  al_complex t[];
  al_complex taubuf[];

  CMatrixComplex tmpa;
  CMatrixComplex tmpt;
  CMatrixComplex tmpr;

  int minmn = MathMin(m, n);
  ;
  int blockstart = 0;
  int blocksize = 0;
  int rowscount = 0;
  int i = 0;
  int i_ = 0;
  int i1_ = 0;
  al_complex One(1, 0);
  al_complex Alpha(1, 0);
  al_complex Beta(0, 0);

  ArrayResizeAL(work, MathMax(m, n) + 1);
  ArrayResizeAL(t, MathMax(m, n) + 1);
  ArrayResizeAL(tau, minmn);
  ArrayResizeAL(taubuf, minmn);

  tmpa.Resize(m, CAblas::AblasComplexBlockSize());
  tmpt.Resize(CAblas::AblasComplexBlockSize(), CAblas::AblasComplexBlockSize());
  tmpr.Resize(2 * CAblas::AblasComplexBlockSize(), n);

  while (blockstart != minmn) {

    blocksize = minmn - blockstart;
    if (blocksize > CAblas::AblasComplexBlockSize())
      blocksize = CAblas::AblasComplexBlockSize();
    rowscount = m - blockstart;

    CAblas::CMatrixCopy(rowscount, blocksize, a, blockstart, blockstart, tmpa,
                        0, 0);
    CMatrixQRBaseCase(tmpa, rowscount, blocksize, work, t, taubuf);
    CAblas::CMatrixCopy(rowscount, blocksize, tmpa, 0, 0, a, blockstart,
                        blockstart);
    i1_ = -blockstart;
    for (i_ = blockstart; i_ <= blockstart + blocksize - 1; i_++)
      tau[i_] = taubuf[i_ + i1_];

    if (blockstart + blocksize <= n - 1) {

      if (n - blockstart - blocksize >= 2 * CAblas::AblasComplexBlockSize()) {

        CMatrixBlockReflector(tmpa, taubuf, true, rowscount, blocksize, tmpt,
                              work);

        CAblas::CMatrixGemm(blocksize, n - blockstart - blocksize, rowscount,
                            Alpha, tmpa, 0, 0, 2, a, blockstart,
                            blockstart + blocksize, 0, Beta, tmpr, 0, 0);
        CAblas::CMatrixGemm(blocksize, n - blockstart - blocksize, blocksize,
                            Alpha, tmpt, 0, 0, 2, tmpr, 0, 0, 0, Beta, tmpr,
                            blocksize, 0);
        CAblas::CMatrixGemm(rowscount, n - blockstart - blocksize, blocksize,
                            Alpha, tmpa, 0, 0, 0, tmpr, blocksize, 0, 0, Alpha,
                            a, blockstart, blockstart + blocksize);
      } else {

        for (i = 0; i < blocksize; i++) {
          i1_ = i - 1;
          for (i_ = 1; i_ <= rowscount - i; i_++)
            t[i_] = tmpa[i_ + i1_][i];
          t[1] = One;

          CComplexReflections::ComplexApplyReflectionFromTheLeft(
              a, CMath::Conj(taubuf[i]), t, blockstart + i, m - 1,
              blockstart + blocksize, n - 1, work);
        }
      }
    }

    blockstart = blockstart + blocksize;
  }
}

static void COrtFac::CMatrixLQ(CMatrixComplex &a, const int m, const int n,
                               al_complex &tau[]) {

  if (m <= 0 || n <= 0)
    return;

  al_complex work[];
  al_complex t[];
  al_complex taubuf[];

  CMatrixComplex tmpa;
  CMatrixComplex tmpt;
  CMatrixComplex tmpr;

  int minmn = MathMin(m, n);
  int blockstart = 0;
  int blocksize = 0;
  int columnscount = 0;
  int i = 0;
  int i_ = 0;
  int i1_ = 0;
  al_complex One(1, 0);
  al_complex Alpha(1, 0);
  al_complex Beta(0, 0);

  ArrayResizeAL(work, MathMax(m, n) + 1);
  ArrayResizeAL(t, MathMax(m, n) + 1);
  ArrayResizeAL(tau, minmn);
  ArrayResizeAL(taubuf, minmn);

  tmpa.Resize(CAblas::AblasComplexBlockSize(), n);
  tmpt.Resize(CAblas::AblasComplexBlockSize(), CAblas::AblasComplexBlockSize());
  tmpr.Resize(m, 2 * CAblas::AblasComplexBlockSize());

  while (blockstart != minmn) {

    blocksize = minmn - blockstart;
    if (blocksize > CAblas::AblasComplexBlockSize())
      blocksize = CAblas::AblasComplexBlockSize();
    columnscount = n - blockstart;

    CAblas::CMatrixCopy(blocksize, columnscount, a, blockstart, blockstart,
                        tmpa, 0, 0);
    CMatrixLQBaseCase(tmpa, blocksize, columnscount, work, t, taubuf);
    CAblas::CMatrixCopy(blocksize, columnscount, tmpa, 0, 0, a, blockstart,
                        blockstart);
    i1_ = -blockstart;
    for (i_ = blockstart; i_ <= blockstart + blocksize - 1; i_++)
      tau[i_] = taubuf[i_ + i1_];

    if (blockstart + blocksize <= m - 1) {

      if (m - blockstart - blocksize >= 2 * CAblas::AblasComplexBlockSize()) {

        CMatrixBlockReflector(tmpa, taubuf, false, columnscount, blocksize,
                              tmpt, work);

        CAblas::CMatrixGemm(m - blockstart - blocksize, blocksize, columnscount,
                            Alpha, a, blockstart + blocksize, blockstart, 0,
                            tmpa, 0, 0, 2, Beta, tmpr, 0, 0);
        CAblas::CMatrixGemm(m - blockstart - blocksize, blocksize, blocksize,
                            Alpha, tmpr, 0, 0, 0, tmpt, 0, 0, 0, Beta, tmpr, 0,
                            blocksize);
        CAblas::CMatrixGemm(m - blockstart - blocksize, columnscount, blocksize,
                            Alpha, tmpr, 0, blocksize, 0, tmpa, 0, 0, 0, Alpha,
                            a, blockstart + blocksize, blockstart);
      } else {

        for (i = 0; i < blocksize; i++) {
          i1_ = i - 1;
          for (i_ = 1; i_ <= columnscount - i; i_++)
            t[i_] = CMath::Conj(tmpa[i][i_ + i1_]);
          t[1] = One;

          CComplexReflections::ComplexApplyReflectionFromTheRight(
              a, taubuf[i], t, blockstart + blocksize, m - 1, blockstart + i,
              n - 1, work);
        }
      }
    }

    blockstart = blockstart + blocksize;
  }
}

static void COrtFac::RMatrixQRUnpackQ(CMatrixDouble &a, const int m,
                                      const int n, double &tau[],
                                      const int qcolumns, CMatrixDouble &q) {

  if (!CAp::Assert(qcolumns <= m, __FUNCTION__ + ": QColumns>M!"))
    return;

  if (m <= 0 || n <= 0 || qcolumns <= 0)
    return;

  double work[];
  double t[];
  double taubuf[];

  CMatrixDouble tmpa;
  CMatrixDouble tmpt;
  CMatrixDouble tmpr;

  int minmn = MathMin(m, n);
  int refcnt = MathMin(minmn, qcolumns);
  int blockstart =
      CAblas::AblasBlockSize() * (refcnt / CAblas::AblasBlockSize());
  int blocksize = refcnt - blockstart;
  int rowscount = 0;
  int i = 0;
  int j = 0;
  int i_ = 0;
  int i1_ = 0;

  q.Resize(m, qcolumns);

  for (i = 0; i < m; i++) {
    for (j = 0; j < qcolumns; j++) {
      if (i == j)
        q[i].Set(j, 1);
      else
        q[i].Set(j, 0);
    }
  }

  ArrayResizeAL(work, MathMax(m, qcolumns) + 1);
  ArrayResizeAL(t, MathMax(m, qcolumns) + 1);
  ArrayResizeAL(taubuf, minmn);

  tmpa.Resize(m, CAblas::AblasBlockSize());
  tmpt.Resize(CAblas::AblasBlockSize(), 2 * CAblas::AblasBlockSize());
  tmpr.Resize(2 * CAblas::AblasBlockSize(), qcolumns);

  while (blockstart >= 0) {
    rowscount = m - blockstart;

    CAblas::RMatrixCopy(rowscount, blocksize, a, blockstart, blockstart, tmpa,
                        0, 0);
    i1_ = blockstart;
    for (i_ = 0; i_ < blocksize; i_++)
      taubuf[i_] = tau[i_ + i1_];

    if (qcolumns >= 2 * CAblas::AblasBlockSize()) {

      RMatrixBlockReflector(tmpa, taubuf, true, rowscount, blocksize, tmpt,
                            work);

      CAblas::RMatrixGemm(blocksize, qcolumns, rowscount, 1.0, tmpa, 0, 0, 1, q,
                          blockstart, 0, 0, 0.0, tmpr, 0, 0);
      CAblas::RMatrixGemm(blocksize, qcolumns, blocksize, 1.0, tmpt, 0, 0, 0,
                          tmpr, 0, 0, 0, 0.0, tmpr, blocksize, 0);
      CAblas::RMatrixGemm(rowscount, qcolumns, blocksize, 1.0, tmpa, 0, 0, 0,
                          tmpr, blocksize, 0, 0, 1.0, q, blockstart, 0);
    } else {

      for (i = blocksize - 1; i >= 0; i--) {
        i1_ = i - 1;
        for (i_ = 1; i_ <= rowscount - i; i_++) {
          t[i_] = tmpa[i_ + i1_][i];
        }
        t[1] = 1;

        CReflections::ApplyReflectionFromTheLeft(
            q, taubuf[i], t, blockstart + i, m - 1, 0, qcolumns - 1, work);
      }
    }

    blockstart = blockstart - CAblas::AblasBlockSize();
    blocksize = CAblas::AblasBlockSize();
  }
}

static void COrtFac::RMatrixQRUnpackR(CMatrixDouble &a, const int m,
                                      const int n, CMatrixDouble &r) {

  if (m <= 0 || n <= 0)
    return;

  int i = 0;
  int k = MathMin(m, n);
  int i_ = 0;

  r.Resize(m, n);

  for (i = 0; i < n; i++)
    r[0].Set(i, 0);
  for (i = 1; i < m; i++) {
    for (i_ = 0; i_ < n; i_++)
      r[i].Set(i_, r[0][i_]);
  }

  for (i = 0; i < k; i++) {
    for (i_ = i; i_ < n; i_++)
      r[i].Set(i_, a[i][i_]);
  }
}

static void COrtFac::RMatrixLQUnpackQ(CMatrixDouble &a, const int m,
                                      const int n, double &tau[],
                                      const int qrows, CMatrixDouble &q) {

  if (!CAp::Assert(qrows <= n, __FUNCTION__ + ": QRows>N!"))
    return;

  if (m <= 0 || n <= 0 || qrows <= 0)
    return;

  double work[];
  double t[];
  double taubuf[];

  CMatrixDouble tmpa;
  CMatrixDouble tmpt;
  CMatrixDouble tmpr;

  int minmn = MathMin(m, n);
  int refcnt = MathMin(minmn, qrows);
  int blockstart =
      CAblas::AblasBlockSize() * (refcnt / CAblas::AblasBlockSize());
  int blocksize = refcnt - blockstart;
  int columnscount = 0;
  int i = 0;
  int j = 0;
  int i_ = 0;
  int i1_ = 0;

  ArrayResizeAL(work, MathMax(m, n) + 1);
  ArrayResizeAL(t, MathMax(m, n) + 1);
  ArrayResizeAL(taubuf, minmn);

  tmpa.Resize(CAblas::AblasBlockSize(), n);
  tmpt.Resize(CAblas::AblasBlockSize(), 2 * CAblas::AblasBlockSize());
  tmpr.Resize(qrows, 2 * CAblas::AblasBlockSize());
  q.Resize(qrows, n);

  for (i = 0; i <= qrows - 1; i++) {
    for (j = 0; j < n; j++) {
      if (i == j)
        q[i].Set(j, 1);
      else
        q[i].Set(j, 0);
    }
  }

  while (blockstart >= 0) {
    columnscount = n - blockstart;

    CAblas::RMatrixCopy(blocksize, columnscount, a, blockstart, blockstart,
                        tmpa, 0, 0);
    i1_ = blockstart;
    for (i_ = 0; i_ < blocksize; i_++)
      taubuf[i_] = tau[i_ + i1_];

    if (qrows >= 2 * CAblas::AblasBlockSize()) {

      RMatrixBlockReflector(tmpa, taubuf, false, columnscount, blocksize, tmpt,
                            work);

      CAblas::RMatrixGemm(qrows, blocksize, columnscount, 1.0, q, 0, blockstart,
                          0, tmpa, 0, 0, 1, 0.0, tmpr, 0, 0);
      CAblas::RMatrixGemm(qrows, blocksize, blocksize, 1.0, tmpr, 0, 0, 0, tmpt,
                          0, 0, 1, 0.0, tmpr, 0, blocksize);
      CAblas::RMatrixGemm(qrows, columnscount, blocksize, 1.0, tmpr, 0,
                          blocksize, 0, tmpa, 0, 0, 0, 1.0, q, 0, blockstart);
    } else {

      for (i = blocksize - 1; i >= 0; i--) {
        i1_ = i - 1;
        for (i_ = 1; i_ <= columnscount - i; i_++)
          t[i_] = tmpa[i][i_ + i1_];
        t[1] = 1;

        CReflections::ApplyReflectionFromTheRight(q, taubuf[i], t, 0, qrows - 1,
                                                  blockstart + i, n - 1, work);
      }
    }

    blockstart = blockstart - CAblas::AblasBlockSize();
    blocksize = CAblas::AblasBlockSize();
  }
}

static void COrtFac::RMatrixLQUnpackL(CMatrixDouble &a, const int m,
                                      const int n, CMatrixDouble &l) {

  if (m <= 0 || n <= 0)
    return;

  int i = 0;
  int k = 0;
  int i_ = 0;

  l.Resize(m, n);

  for (i = 0; i < n; i++)
    l[0].Set(i, 0);
  for (i = 1; i < m; i++) {
    for (i_ = 0; i_ < n; i_++)
      l[i].Set(i_, l[0][i_]);
  }

  for (i = 0; i < m; i++) {
    k = MathMin(i, n - 1);
    for (i_ = 0; i_ <= k; i_++)
      l[i].Set(i_, a[i][i_]);
  }
}

static void COrtFac::CMatrixQRUnpackQ(CMatrixComplex &a, const int m,
                                      const int n, al_complex &tau[],
                                      const int qcolumns, CMatrixComplex &q) {

  if (!CAp::Assert(qcolumns <= m, __FUNCTION__ + ": QColumns>M!"))
    return;

  if (m <= 0 || n <= 0)
    return;

  al_complex work[];
  al_complex t[];
  al_complex taubuf[];

  CMatrixComplex tmpa;
  CMatrixComplex tmpt;
  CMatrixComplex tmpr;

  int minmn = MathMin(m, n);
  int refcnt = MathMin(minmn, qcolumns);
  int blockstart = CAblas::AblasComplexBlockSize() *
                   (refcnt / CAblas::AblasComplexBlockSize());
  int blocksize = refcnt - blockstart;
  int rowscount = 0;
  int i = 0;
  int j = 0;
  int i_ = 0;
  int i1_ = 0;
  al_complex One(1, 0);
  al_complex Zero(0, 0);

  ArrayResizeAL(work, MathMax(m, n) + 1);
  ArrayResizeAL(t, MathMax(m, n) + 1);
  ArrayResizeAL(taubuf, minmn);

  tmpa.Resize(m, CAblas::AblasComplexBlockSize());
  tmpt.Resize(CAblas::AblasComplexBlockSize(), CAblas::AblasComplexBlockSize());
  tmpr.Resize(2 * CAblas::AblasComplexBlockSize(), qcolumns);
  q.Resize(m, qcolumns);
  for (i = 0; i < m; i++) {
    for (j = 0; j < qcolumns; j++) {
      if (i == j)
        q[i].Set(j, One);
      else
        q[i].Set(j, Zero);
    }
  }

  while (blockstart >= 0) {
    rowscount = m - blockstart;

    CAblas::CMatrixCopy(rowscount, blocksize, a, blockstart, blockstart, tmpa,
                        0, 0);
    i1_ = blockstart;
    for (i_ = 0; i_ < blocksize; i_++)
      taubuf[i_] = tau[i_ + i1_];

    if (qcolumns >= 2 * CAblas::AblasComplexBlockSize()) {

      CMatrixBlockReflector(tmpa, taubuf, true, rowscount, blocksize, tmpt,
                            work);

      CAblas::CMatrixGemm(blocksize, qcolumns, rowscount, One, tmpa, 0, 0, 2, q,
                          blockstart, 0, 0, Zero, tmpr, 0, 0);
      CAblas::CMatrixGemm(blocksize, qcolumns, blocksize, One, tmpt, 0, 0, 0,
                          tmpr, 0, 0, 0, Zero, tmpr, blocksize, 0);
      CAblas::CMatrixGemm(rowscount, qcolumns, blocksize, One, tmpa, 0, 0, 0,
                          tmpr, blocksize, 0, 0, One, q, blockstart, 0);
    } else {

      for (i = blocksize - 1; i >= 0; i--) {
        i1_ = i - 1;
        for (i_ = 1; i_ <= rowscount - i; i_++)
          t[i_] = tmpa[i_ + i1_][i];
        t[1] = 1;

        CComplexReflections::ComplexApplyReflectionFromTheLeft(
            q, taubuf[i], t, blockstart + i, m - 1, 0, qcolumns - 1, work);
      }
    }

    blockstart = blockstart - CAblas::AblasComplexBlockSize();
    blocksize = CAblas::AblasComplexBlockSize();
  }
}

static void COrtFac::CMatrixQRUnpackR(CMatrixComplex &a, const int m,
                                      const int n, CMatrixComplex &r) {

  if (m <= 0 || n <= 0)
    return;

  al_complex Zero(0, 0);
  int i = 0;
  int k = MathMin(m, n);
  int i_ = 0;

  r.Resize(m, n);

  for (i = 0; i < n; i++)
    r[0].Set(i, Zero);
  for (i = 1; i < m; i++) {
    for (i_ = 0; i_ < n; i_++)
      r[i].Set(i_, r[0][i_]);
  }

  for (i = 0; i < k; i++) {
    for (i_ = i; i_ < n; i_++)
      r[i].Set(i_, a[i][i_]);
  }
}

static void COrtFac::CMatrixLQUnpackQ(CMatrixComplex &a, const int m,
                                      const int n, al_complex &tau[],
                                      const int qrows, CMatrixComplex &q) {

  if (m <= 0 || n <= 0)
    return;

  al_complex work[];
  al_complex t[];
  al_complex taubuf[];

  CMatrixComplex tmpa;
  CMatrixComplex tmpt;
  CMatrixComplex tmpr;

  int minmn = MathMin(m, n);
  int refcnt = MathMin(minmn, qrows);
  int blockstart = CAblas::AblasComplexBlockSize() *
                   (refcnt / CAblas::AblasComplexBlockSize());
  int blocksize = refcnt - blockstart;
  int columnscount = 0;
  int i = 0;
  int j = 0;
  int i_ = 0;
  int i1_ = 0;
  al_complex One(1, 0);
  al_complex Zero(0, 0);

  ArrayResizeAL(work, MathMax(m, n) + 1);
  ArrayResizeAL(t, MathMax(m, n) + 1);
  ArrayResizeAL(taubuf, minmn);

  tmpa.Resize(CAblas::AblasComplexBlockSize(), n);
  tmpt.Resize(CAblas::AblasComplexBlockSize(), CAblas::AblasComplexBlockSize());
  tmpr.Resize(qrows, 2 * CAblas::AblasComplexBlockSize());
  q.Resize(qrows, n);
  for (i = 0; i <= qrows - 1; i++) {
    for (j = 0; j < n; j++) {
      if (i == j)
        q[i].Set(j, One);
      else
        q[i].Set(j, Zero);
    }
  }

  while (blockstart >= 0) {
    columnscount = n - blockstart;

    CAblas::CMatrixCopy(blocksize, columnscount, a, blockstart, blockstart,
                        tmpa, 0, 0);
    i1_ = blockstart;
    for (i_ = 0; i_ < blocksize; i_++)
      taubuf[i_] = tau[i_ + i1_];

    if (qrows >= 2 * CAblas::AblasComplexBlockSize()) {

      CMatrixBlockReflector(tmpa, taubuf, false, columnscount, blocksize, tmpt,
                            work);

      CAblas::CMatrixGemm(qrows, blocksize, columnscount, One, q, 0, blockstart,
                          0, tmpa, 0, 0, 2, Zero, tmpr, 0, 0);
      CAblas::CMatrixGemm(qrows, blocksize, blocksize, One, tmpr, 0, 0, 0, tmpt,
                          0, 0, 2, Zero, tmpr, 0, blocksize);
      CAblas::CMatrixGemm(qrows, columnscount, blocksize, One, tmpr, 0,
                          blocksize, 0, tmpa, 0, 0, 0, One, q, 0, blockstart);
    } else {

      for (i = blocksize - 1; i >= 0; i--) {
        i1_ = i - 1;
        for (i_ = 1; i_ <= columnscount - i; i_++)
          t[i_] = CMath::Conj(tmpa[i][i_ + i1_]);
        t[1] = 1;

        CComplexReflections::ComplexApplyReflectionFromTheRight(
            q, CMath::Conj(taubuf[i]), t, 0, qrows - 1, blockstart + i, n - 1,
            work);
      }
    }

    blockstart = blockstart - CAblas::AblasComplexBlockSize();
    blocksize = CAblas::AblasComplexBlockSize();
  }
}

static void COrtFac::CMatrixLQUnpackL(CMatrixComplex &a, const int m,
                                      const int n, CMatrixComplex &l) {

  if (m <= 0 || n <= 0)
    return;

  al_complex Zero(0, 0);
  int i = 0;
  int k = 0;
  int i_ = 0;

  l.Resize(m, n);

  for (i = 0; i < n; i++)
    l[0].Set(i, Zero);
  for (i = 1; i < m; i++) {
    for (i_ = 0; i_ < n; i_++)
      l[i].Set(i_, l[0][i_]);
  }

  for (i = 0; i < m; i++) {
    k = MathMin(i, n - 1);
    for (i_ = 0; i_ <= k; i_++)
      l[i].Set(i_, a[i][i_]);
  }
}

static void COrtFac::RMatrixBD(CMatrixDouble &a, const int m, const int n,
                               double &tauq[], double &taup[]) {

  if (n <= 0 || m <= 0)
    return;

  double work[];
  double t[];

  int minmn = 0;
  int maxmn = MathMax(m, n);
  int i = 0;
  double ltau = 0;
  int i_ = 0;
  int i1_ = 0;

  ArrayResizeAL(work, maxmn + 1);
  ArrayResizeAL(t, maxmn + 1);

  if (m >= n) {
    ArrayResizeAL(tauq, n);
    ArrayResizeAL(taup, n);
  } else {
    ArrayResizeAL(tauq, m);
    ArrayResizeAL(taup, m);
  }

  if (m >= n) {

    for (i = 0; i < n; i++) {

      i1_ = i - 1;
      for (i_ = 1; i_ <= m - i; i_++)
        t[i_] = a[i_ + i1_][i];
      CReflections::GenerateReflection(t, m - i, ltau);
      tauq[i] = ltau;
      i1_ = 1 - i;
      for (i_ = i; i_ < m; i_++)
        a[i_].Set(i, t[i_ + i1_]);
      t[1] = 1;

      CReflections::ApplyReflectionFromTheLeft(a, ltau, t, i, m - 1, i + 1,
                                               n - 1, work);

      if (i < n - 1) {

        i1_ = i;
        for (i_ = 1; i_ < n - i; i_++)
          t[i_] = a[i][i_ + i1_];
        CReflections::GenerateReflection(t, n - 1 - i, ltau);
        taup[i] = ltau;
        i1_ = -i;
        for (i_ = i + 1; i_ < n; i_++)
          a[i].Set(i_, t[i_ + i1_]);
        t[1] = 1;

        CReflections::ApplyReflectionFromTheRight(a, ltau, t, i + 1, m - 1,
                                                  i + 1, n - 1, work);
      } else
        taup[i] = 0;
    }
  } else {

    for (i = 0; i < m; i++) {

      i1_ = i - 1;
      for (i_ = 1; i_ <= n - i; i_++)
        t[i_] = a[i][i_ + i1_];
      CReflections::GenerateReflection(t, n - i, ltau);
      taup[i] = ltau;
      i1_ = 1 - i;
      for (i_ = i; i_ < n; i_++)
        a[i].Set(i_, t[i_ + i1_]);
      t[1] = 1;

      CReflections::ApplyReflectionFromTheRight(a, ltau, t, i + 1, m - 1, i,
                                                n - 1, work);

      if (i < m - 1) {

        i1_ = i;
        for (i_ = 1; i_ < m - i; i_++)
          t[i_] = a[i_ + i1_][i];
        CReflections::GenerateReflection(t, m - 1 - i, ltau);
        tauq[i] = ltau;
        i1_ = -i;
        for (i_ = i + 1; i_ < m; i_++)
          a[i_].Set(i, t[i_ + i1_]);
        t[1] = 1;

        CReflections::ApplyReflectionFromTheLeft(a, ltau, t, i + 1, m - 1,
                                                 i + 1, n - 1, work);
      } else
        tauq[i] = 0;
    }
  }
}

static void COrtFac::RMatrixBDUnpackQ(CMatrixDouble &qp, const int m,
                                      const int n, double &tauq[],
                                      const int qcolumns, CMatrixDouble &q) {

  if (!CAp::Assert(qcolumns <= m, __FUNCTION__ + ": QColumns>M!"))
    return;

  if (!CAp::Assert(qcolumns >= 0, __FUNCTION__ + ": QColumns<0!"))
    return;

  if (m == 0 || n == 0 || qcolumns == 0)
    return;

  int i = 0;
  int j = 0;

  q.Resize(m, qcolumns);

  for (i = 0; i < m; i++) {
    for (j = 0; j < qcolumns; j++) {
      if (i == j)
        q[i].Set(j, 1);
      else
        q[i].Set(j, 0);
    }
  }

  RMatrixBDMultiplyByQ(qp, m, n, tauq, q, m, qcolumns, false, false);
}

static void COrtFac::RMatrixBDMultiplyByQ(CMatrixDouble &qp, const int m,
                                          const int n, double &tauq[],
                                          CMatrixDouble &z, const int zrows,
                                          const int zcolumns,
                                          const bool fromtheright,
                                          const bool dotranspose) {

  if (m <= 0 || n <= 0 || zrows <= 0 || zcolumns <= 0)
    return;

  if (!CAp::Assert((fromtheright && zcolumns == m) ||
                       (!fromtheright && zrows == m),
                   __FUNCTION__ + ": incorrect Z size!"))
    return;

  int mx = 0;
  int i_ = 0;
  int i1_ = 0;
  int i = 0;
  int i1 = 0;
  int i2 = 0;
  int istep = 0;

  double v[];
  double work[];

  mx = MathMax(m, n);
  mx = MathMax(mx, zrows);
  mx = MathMax(mx, zcolumns);

  ArrayResizeAL(v, mx + 1);
  ArrayResizeAL(work, mx + 1);

  if (m >= n) {

    if (fromtheright) {
      i1 = 0;
      i2 = n - 1;
      istep = 1;
    } else {
      i1 = n - 1;
      i2 = 0;
      istep = -1;
    }

    if (dotranspose) {
      i = i1;
      i1 = i2;
      i2 = i;
      istep = -istep;
    }

    i = i1;
    do {
      i1_ = i - 1;
      for (i_ = 1; i_ <= m - i; i_++)
        v[i_] = qp[i_ + i1_][i];
      v[1] = 1;

      if (fromtheright)
        CReflections::ApplyReflectionFromTheRight(z, tauq[i], v, 0, zrows - 1,
                                                  i, m - 1, work);
      else
        CReflections::ApplyReflectionFromTheLeft(z, tauq[i], v, i, m - 1, 0,
                                                 zcolumns - 1, work);
      i = i + istep;
    } while (i != i2 + istep);
  } else {

    if (fromtheright) {
      i1 = 0;
      i2 = m - 2;
      istep = 1;
    } else {
      i1 = m - 2;
      i2 = 0;
      istep = -1;
    }

    if (dotranspose) {
      i = i1;
      i1 = i2;
      i2 = i;
      istep = -istep;
    }

    if (m - 1 > 0) {
      i = i1;
      do {
        i1_ = i;
        for (i_ = 1; i_ <= m - i - 1; i_++)
          v[i_] = qp[i_ + i1_][i];
        v[1] = 1;

        if (fromtheright)
          CReflections::ApplyReflectionFromTheRight(z, tauq[i], v, 0, zrows - 1,
                                                    i + 1, m - 1, work);
        else
          CReflections::ApplyReflectionFromTheLeft(z, tauq[i], v, i + 1, m - 1,
                                                   0, zcolumns - 1, work);
        i = i + istep;
      } while (i != i2 + istep);
    }
  }
}

static void COrtFac::RMatrixBDUnpackPT(CMatrixDouble &qp, const int m,
                                       const int n, double &taup[],
                                       const int ptrows, CMatrixDouble &pt) {

  if (!CAp::Assert(ptrows <= n, __FUNCTION__ + ": PTRows>N!"))
    return;

  if (!CAp::Assert(ptrows >= 0, __FUNCTION__ + ": PTRows<0!"))
    return;

  if (m == 0 || n == 0 || ptrows == 0)
    return;

  int i = 0;
  int j = 0;

  pt.Resize(ptrows, n);

  for (i = 0; i <= ptrows - 1; i++) {
    for (j = 0; j < n; j++) {
      if (i == j)
        pt[i].Set(j, 1);
      else
        pt[i].Set(j, 0);
    }
  }

  RMatrixBDMultiplyByP(qp, m, n, taup, pt, ptrows, n, true, true);
}

static void COrtFac::RMatrixBDMultiplyByP(CMatrixDouble &qp, const int m,
                                          const int n, double &taup[],
                                          CMatrixDouble &z, const int zrows,
                                          const int zcolumns,
                                          const bool fromtheright,
                                          const bool dotranspose) {

  if (m <= 0 || n <= 0 || zrows <= 0 || zcolumns <= 0)
    return;

  if (!CAp::Assert((fromtheright && zcolumns == n) ||
                       (!fromtheright && zrows == n),
                   __FUNCTION__ + ": incorrect Z size!"))
    return;

  double v[];
  double work[];

  int i = 0;
  int mx = 0;
  int i1 = 0;
  int i2 = 0;
  int istep = 0;
  int i_ = 0;
  int i1_ = 0;

  mx = MathMax(m, n);
  mx = MathMax(mx, zrows);
  mx = MathMax(mx, zcolumns);

  ArrayResizeAL(v, mx + 1);
  ArrayResizeAL(work, mx + 1);

  if (m >= n) {

    if (fromtheright) {
      i1 = n - 2;
      i2 = 0;
      istep = -1;
    } else {
      i1 = 0;
      i2 = n - 2;
      istep = 1;
    }

    if (!dotranspose) {
      i = i1;
      i1 = i2;
      i2 = i;
      istep = -istep;
    }

    if (n - 1 > 0) {
      i = i1;
      do {
        i1_ = i;
        for (i_ = 1; i_ < n - i; i_++)
          v[i_] = qp[i][i_ + i1_];
        v[1] = 1;

        if (fromtheright)
          CReflections::ApplyReflectionFromTheRight(z, taup[i], v, 0, zrows - 1,
                                                    i + 1, n - 1, work);
        else
          CReflections::ApplyReflectionFromTheLeft(z, taup[i], v, i + 1, n - 1,
                                                   0, zcolumns - 1, work);
        i = i + istep;
      } while (i != i2 + istep);
    }
  } else {

    if (fromtheright) {
      i1 = m - 1;
      i2 = 0;
      istep = -1;
    } else {
      i1 = 0;
      i2 = m - 1;
      istep = 1;
    }

    if (!dotranspose) {
      i = i1;
      i1 = i2;
      i2 = i;
      istep = -istep;
    }

    i = i1;
    do {
      i1_ = i - 1;
      for (i_ = 1; i_ <= n - i; i_++)
        v[i_] = qp[i][i_ + i1_];
      v[1] = 1;

      if (fromtheright)
        CReflections::ApplyReflectionFromTheRight(z, taup[i], v, 0, zrows - 1,
                                                  i, n - 1, work);
      else
        CReflections::ApplyReflectionFromTheLeft(z, taup[i], v, i, n - 1, 0,
                                                 zcolumns - 1, work);
      i = i + istep;
    } while (i != i2 + istep);
  }
}

static void COrtFac::RMatrixBDUnpackDiagonals(CMatrixDouble &b, const int m,
                                              const int n, bool &isupper,
                                              double &d[], double &e[]) {

  if (m <= 0 || n <= 0)
    return;

  int i = 0;

  if (m >= n)
    isupper = true;
  else
    isupper = false;

  if (isupper) {

    ArrayResizeAL(d, n);
    ArrayResizeAL(e, n);

    for (i = 0; i < n - 1; i++) {
      d[i] = b[i][i];
      e[i] = b[i][i + 1];
    }
    d[n - 1] = b[n - 1][n - 1];
  } else {

    ArrayResizeAL(d, m);
    ArrayResizeAL(e, m);

    for (i = 0; i < m - 1; i++) {
      d[i] = b[i][i];
      e[i] = b[i + 1][i];
    }
    d[m - 1] = b[m - 1][m - 1];
  }
}

static void COrtFac::RMatrixHessenberg(CMatrixDouble &a, const int n,
                                       double &tau[]) {

  if (n <= 1)
    return;

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": incorrect N!"))
    return;

  double t[];
  double work[];

  int i = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  ArrayResizeAL(tau, n - 1);
  ArrayResizeAL(t, n + 1);
  ArrayResizeAL(work, n);
  for (i = 0; i < n - 1; i++) {

    i1_ = i;
    for (i_ = 1; i_ < n - i; i_++)
      t[i_] = a[i_ + i1_][i];
    CReflections::GenerateReflection(t, n - i - 1, v);
    i1_ = -i;
    for (i_ = i + 1; i_ < n; i_++)
      a[i_].Set(i, t[i_ + i1_]);
    tau[i] = v;
    t[1] = 1;

    CReflections::ApplyReflectionFromTheRight(a, v, t, 0, n - 1, i + 1, n - 1,
                                              work);

    CReflections::ApplyReflectionFromTheLeft(a, v, t, i + 1, n - 1, i + 1,
                                             n - 1, work);
  }
}

static void COrtFac::RMatrixHessenbergUnpackQ(CMatrixDouble &a, const int n,
                                              double &tau[], CMatrixDouble &q) {

  if (n == 0)
    return;

  double v[];
  double work[];

  int i = 0;
  int j = 0;
  int i_ = 0;
  int i1_ = 0;

  q.Resize(n, n);

  ArrayResizeAL(v, n);
  ArrayResizeAL(work, n);

  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
      if (i == j)
        q[i].Set(j, 1);
      else
        q[i].Set(j, 0);
    }
  }

  for (i = 0; i < n - 1; i++) {

    i1_ = i;
    for (i_ = 1; i_ < n - i; i_++)
      v[i_] = a[i_ + i1_][i];
    v[1] = 1;
    CReflections::ApplyReflectionFromTheRight(q, tau[i], v, 0, n - 1, i + 1,
                                              n - 1, work);
  }
}

static void COrtFac::RMatrixHessenbergUnpackH(CMatrixDouble &a, const int n,
                                              CMatrixDouble &h) {

  if (n == 0)
    return;

  double v[];
  double work[];

  int i = 0;
  int j = 0;
  int i_ = 0;

  h.Resize(n, n);

  for (i = 0; i < n; i++) {
    for (j = 0; j <= i - 2; j++)
      h[i].Set(j, 0);
    j = (int)MathMax(0, i - 1);
    for (i_ = j; i_ < n; i_++)
      h[i].Set(i_, a[i][i_]);
  }
}

static void COrtFac::SMatrixTD(CMatrixDouble &a, const int n,
                               const bool isupper, double &tau[], double &d[],
                               double &e[]) {

  if (n <= 0)
    return;

  double t[];
  double t2[];
  double t3[];

  int i = 0;
  double alpha = 0;
  double taui = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  ArrayResizeAL(t, n + 1);
  ArrayResizeAL(t2, n + 1);
  ArrayResizeAL(t3, n + 1);

  if (n > 1)
    ArrayResizeAL(tau, n - 1);
  ArrayResizeAL(d, n);

  if (n > 1)
    ArrayResizeAL(e, n - 1);

  if (isupper) {

    for (i = n - 2; i >= 0; i--) {

      if (i >= 1) {
        i1_ = -2;
        for (i_ = 2; i_ <= i + 1; i_++)
          t[i_] = a[i_ + i1_][i + 1];
      }
      t[1] = a[i][i + 1];
      CReflections::GenerateReflection(t, i + 1, taui);

      if (i >= 1) {
        i1_ = 2;
        for (i_ = 0; i_ < i; i_++)
          a[i_].Set(i + 1, t[i_ + i1_]);
      }
      a[i].Set(i + 1, t[1]);
      e[i] = a[i][i + 1];

      if (taui != 0) {

        a[i].Set(i + 1, 1);

        i1_ = -1;
        for (i_ = 1; i_ <= i + 1; i_++)
          t[i_] = a[i_ + i1_][i + 1];
        CSblas::SymmetricMatrixVectorMultiply(a, isupper, 0, i, t, taui, t3);
        i1_ = 1;
        for (i_ = 0; i_ <= i; i_++)
          tau[i_] = t3[i_ + i1_];

        v = 0.0;
        for (i_ = 0; i_ <= i; i_++)
          v += tau[i_] * a[i_][i + 1];
        alpha = -(0.5 * taui * v);
        for (i_ = 0; i_ <= i; i_++)
          tau[i_] = tau[i_] + alpha * a[i_][i + 1];

        i1_ = -1;
        for (i_ = 1; i_ <= i + 1; i_++)
          t[i_] = a[i_ + i1_][i + 1];
        i1_ = -1;
        for (i_ = 1; i_ <= i + 1; i_++)
          t3[i_] = tau[i_ + i1_];
        CSblas::SymmetricRank2Update(a, isupper, 0, i, t, t3, t2, -1);
        a[i].Set(i + 1, e[i]);
      }
      d[i + 1] = a[i + 1][i + 1];
      tau[i] = taui;
    }
    d[0] = a[0][0];
  } else {

    for (i = 0; i < n - 1; i++) {

      i1_ = i;
      for (i_ = 1; i_ < n - i; i_++)
        t[i_] = a[i_ + i1_][i];
      CReflections::GenerateReflection(t, n - i - 1, taui);
      i1_ = -i;
      for (i_ = i + 1; i_ < n; i_++)
        a[i_].Set(i, t[i_ + i1_]);
      e[i] = a[i + 1][i];
      if (taui != 0) {

        a[i + 1].Set(i, 1);

        i1_ = i;
        for (i_ = 1; i_ < n - i; i_++)
          t[i_] = a[i_ + i1_][i];
        CSblas::SymmetricMatrixVectorMultiply(a, isupper, i + 1, n - 1, t, taui,
                                              t2);
        i1_ = 1 - i;
        for (i_ = i; i_ < n - 1; i_++)
          tau[i_] = t2[i_ + i1_];

        i1_ = 1;
        v = 0.0;
        for (i_ = i; i_ <= n - 2; i_++)
          v += tau[i_] * a[i_ + i1_][i];
        alpha = -(0.5 * taui * v);
        i1_ = 1;
        for (i_ = i; i_ < n - 1; i_++)
          tau[i_] = tau[i_] + alpha * a[i_ + i1_][i];

        i1_ = i;
        for (i_ = 1; i_ < n - i; i_++)
          t[i_] = a[i_ + i1_][i];
        i1_ = i - 1;
        for (i_ = 1; i_ < n - i; i_++)
          t2[i_] = tau[i_ + i1_];
        CSblas::SymmetricRank2Update(a, isupper, i + 1, n - 1, t, t2, t3, -1);
        a[i + 1].Set(i, e[i]);
      }
      d[i] = a[i][i];
      tau[i] = taui;
    }
    d[n - 1] = a[n - 1][n - 1];
  }
}

static void COrtFac::SMatrixTDUnpackQ(CMatrixDouble &a, const int n,
                                      const bool isupper, double &tau[],
                                      CMatrixDouble &q) {

  if (n == 0)
    return;

  double v[];
  double work[];

  int i = 0;
  int j = 0;
  int i_ = 0;
  int i1_ = 0;

  q.Resize(n, n);

  ArrayResizeAL(v, n + 1);
  ArrayResizeAL(work, n);

  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
      if (i == j)
        q[i].Set(j, 1);
      else
        q[i].Set(j, 0);
    }
  }

  if (isupper) {
    for (i = 0; i < n - 1; i++) {

      i1_ = -1;
      for (i_ = 1; i_ <= i + 1; i_++)
        v[i_] = a[i_ + i1_][i + 1];
      v[i + 1] = 1;

      CReflections::ApplyReflectionFromTheLeft(q, tau[i], v, 0, i, 0, n - 1,
                                               work);
    }
  } else {
    for (i = n - 2; i >= 0; i--) {

      i1_ = i;
      for (i_ = 1; i_ < n - i; i_++)
        v[i_] = a[i_ + i1_][i];
      v[1] = 1;

      CReflections::ApplyReflectionFromTheLeft(q, tau[i], v, i + 1, n - 1, 0,
                                               n - 1, work);
    }
  }
}

static void COrtFac::HMatrixTD(CMatrixComplex &a, const int n,
                               const bool isupper, al_complex &tau[],
                               double &d[], double &e[]) {

  if (n <= 0)
    return;

  al_complex t[];
  al_complex t2[];
  al_complex t3[];

  al_complex Half(0.5, 0);
  al_complex Zero(0, 0);
  al_complex _One(-1, 0);
  al_complex alpha = 0;
  al_complex taui = 0;
  al_complex v = 0;
  int i = 0;
  int i_ = 0;
  int i1_ = 0;
  for (i = 0; i < n; i++) {

    if (!CAp::Assert(a[i][i].im == 0))
      return;
  }

  if (n > 1) {
    ArrayResizeAL(tau, n - 1);
    ArrayResizeAL(e, n - 1);
  }
  ArrayResizeAL(d, n);
  ArrayResizeAL(t, n);
  ArrayResizeAL(t2, n);
  ArrayResizeAL(t3, n);

  if (isupper) {

    a[n - 1].Set(n - 1, a[n - 1][n - 1].re);
    for (i = n - 2; i >= 0; i--) {

      alpha = a[i][i + 1];
      t[1] = alpha;

      if (i >= 1) {
        i1_ = -2;
        for (i_ = 2; i_ <= i + 1; i_++)
          t[i_] = a[i_ + i1_][i + 1];
      }

      CComplexReflections::ComplexGenerateReflection(t, i + 1, taui);

      if (i >= 1) {
        i1_ = 2;
        for (i_ = 0; i_ < i; i_++)
          a[i_].Set(i + 1, t[i_ + i1_]);
      }

      alpha = t[1];
      e[i] = alpha.re;

      if (taui != Zero) {

        a[i].Set(i + 1, 1);

        i1_ = -1;
        for (i_ = 1; i_ <= i + 1; i_++)
          t[i_] = a[i_ + i1_][i + 1];
        CHblas::HermitianMatrixVectorMultiply(a, isupper, 0, i, t, taui, t2);
        i1_ = 1;
        for (i_ = 0; i_ <= i; i_++)
          tau[i_] = t2[i_ + i1_];

        v = 0.0;
        for (i_ = 0; i_ <= i; i_++)
          v += CMath::Conj(tau[i_]) * a[i_][i + 1];

        alpha = Half * taui * v;
        alpha.re = -alpha.re;
        alpha.im = -alpha.im;
        for (i_ = 0; i_ <= i; i_++)
          tau[i_] = tau[i_] + alpha * a[i_][i + 1];

        i1_ = -1;
        for (i_ = 1; i_ <= i + 1; i_++)
          t[i_] = a[i_ + i1_][i + 1];
        i1_ = -1;
        for (i_ = 1; i_ <= i + 1; i_++)
          t3[i_] = tau[i_ + i1_];
        CHblas::HermitianRank2Update(a, isupper, 0, i, t, t3, t2, _One);
      } else
        a[i].Set(i, a[i][i].re);

      a[i].Set(i + 1, e[i]);
      d[i + 1] = a[i + 1][i + 1].re;
      tau[i] = taui;
    }
    d[0] = a[0][0].re;
  } else {

    a[0].Set(0, a[0][0].re);
    for (i = 0; i < n - 1; i++) {

      i1_ = i;
      for (i_ = 1; i_ < n - i; i_++)
        t[i_] = a[i_ + i1_][i];

      CComplexReflections::ComplexGenerateReflection(t, n - i - 1, taui);
      i1_ = -i;
      for (i_ = i + 1; i_ < n; i_++)
        a[i_].Set(i, t[i_ + i1_]);
      e[i] = a[i + 1][i].re;

      if (taui != Zero) {

        a[i + 1].Set(i, 1);

        i1_ = i;
        for (i_ = 1; i_ < n - i; i_++)
          t[i_] = a[i_ + i1_][i];
        CHblas::HermitianMatrixVectorMultiply(a, isupper, i + 1, n - 1, t, taui,
                                              t2);
        i1_ = 1 - i;
        for (i_ = i; i_ < n - 1; i_++)
          tau[i_] = t2[i_ + i1_];

        i1_ = 1;
        v = 0.0;
        for (i_ = i; i_ < n - 1; i_++)
          v += CMath::Conj(tau[i_]) * a[i_ + i1_][i];

        alpha = Half * taui * v;
        alpha.re = -alpha.re;
        alpha.im = -alpha.im;
        i1_ = 1;
        for (i_ = i; i_ < n - 1; i_++)
          tau[i_] = tau[i_] + alpha * a[i_ + i1_][i];

        i1_ = i;
        for (i_ = 1; i_ < n - i; i_++)
          t[i_] = a[i_ + i1_][i];
        i1_ = i - 1;
        for (i_ = 1; i_ < n - i; i_++)
          t2[i_] = tau[i_ + i1_];
        CHblas::HermitianRank2Update(a, isupper, i + 1, n - 1, t, t2, t3, _One);
      } else
        a[i + 1].Set(i + 1, a[i + 1][i + 1].re);

      a[i + 1].Set(i, e[i]);
      d[i] = a[i][i].re;
      tau[i] = taui;
    }
    d[n - 1] = a[n - 1][n - 1].re;
  }
}

static void COrtFac::HMatrixTDUnpackQ(CMatrixComplex &a, const int n,
                                      const bool isupper, al_complex &tau[],
                                      CMatrixComplex &q) {

  if (n == 0)
    return;

  al_complex v[];
  al_complex work[];

  int i = 0;
  int j = 0;
  int i_ = 0;
  int i1_ = 0;

  q.Resize(n, n);

  ArrayResizeAL(v, n + 1);
  ArrayResizeAL(work, n + 1);

  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
      if (i == j)
        q[i].Set(j, 1);
      else
        q[i].Set(j, 0);
    }
  }

  if (isupper) {
    for (i = 0; i < n - 1; i++) {

      i1_ = -1;
      for (i_ = 1; i_ <= i + 1; i_++)
        v[i_] = a[i_ + i1_][i + 1];
      v[i + 1] = 1;

      CComplexReflections::ComplexApplyReflectionFromTheLeft(q, tau[i], v, 0, i,
                                                             0, n - 1, work);
    }
  } else {
    for (i = n - 2; i >= 0; i--) {

      i1_ = i;
      for (i_ = 1; i_ < n - i; i_++)
        v[i_] = a[i_ + i1_][i];
      v[1] = 1;

      CComplexReflections::ComplexApplyReflectionFromTheLeft(
          q, tau[i], v, i + 1, n - 1, 0, n - 1, work);
    }
  }
}

static void COrtFac::RMatrixQRBaseCase(CMatrixDouble &a, const int m,
                                       const int n, double &work[], double &t[],
                                       double &tau[]) {

  int i = 0;
  int k = MathMin(m, n);
  int minmn = MathMin(m, n);
  double tmp = 0;
  int i_ = 0;
  int i1_ = 0;

  for (i = 0; i < k; i++) {

    i1_ = i - 1;
    for (i_ = 1; i_ <= m - i; i_++)
      t[i_] = a[i_ + i1_][i];
    CReflections::GenerateReflection(t, m - i, tmp);
    tau[i] = tmp;
    i1_ = 1 - i;
    for (i_ = i; i_ < m; i_++)
      a[i_].Set(i, t[i_ + i1_]);
    t[1] = 1;

    if (i < n) {

      CReflections::ApplyReflectionFromTheLeft(a, tau[i], t, i, m - 1, i + 1,
                                               n - 1, work);
    }
  }
}

static void COrtFac::RMatrixLQBaseCase(CMatrixDouble &a, const int m,
                                       const int n, double &work[], double &t[],
                                       double &tau[]) {

  int i = 0;
  int k = MathMin(m, n);
  int minmn = MathMin(m, n);
  double tmp = 0;
  int i_ = 0;
  int i1_ = 0;

  for (i = 0; i < k; i++) {

    i1_ = i - 1;
    for (i_ = 1; i_ <= n - i; i_++)
      t[i_] = a[i][i_ + i1_];
    CReflections::GenerateReflection(t, n - i, tmp);
    tau[i] = tmp;
    i1_ = 1 - i;
    for (i_ = i; i_ < n; i_++)
      a[i].Set(i_, t[i_ + i1_]);
    t[1] = 1;

    if (i < n) {

      CReflections::ApplyReflectionFromTheRight(a, tau[i], t, i + 1, m - 1, i,
                                                n - 1, work);
    }
  }
}

static void COrtFac::CMatrixQRBaseCase(CMatrixComplex &a, const int m,
                                       const int n, al_complex &work[],
                                       al_complex &t[], al_complex &tau[]) {

  int i = 0;
  int k = MathMin(m, n);
  int mmi = 0;
  int minmn = MathMin(m, n);
  al_complex tmp = 0;
  int i_ = 0;
  int i1_ = 0;

  if (minmn <= 0)
    return;

  for (i = 0; i < k; i++) {

    mmi = m - i;
    i1_ = i - 1;
    for (i_ = 1; i_ <= mmi; i_++)
      t[i_] = a[i_ + i1_][i];

    CComplexReflections::ComplexGenerateReflection(t, mmi, tmp);
    tau[i] = tmp;
    i1_ = 1 - i;
    for (i_ = i; i_ < m; i_++)
      a[i_].Set(i, t[i_ + i1_]);
    t[1] = 1;

    if (i < n - 1) {

      CComplexReflections::ComplexApplyReflectionFromTheLeft(
          a, CMath::Conj(tau[i]), t, i, m - 1, i + 1, n - 1, work);
    }
  }
}

static void COrtFac::CMatrixLQBaseCase(CMatrixComplex &a, const int m,
                                       const int n, al_complex &work[],
                                       al_complex &t[], al_complex &tau[]) {

  int i = 0;
  int minmn = MathMin(m, n);
  al_complex tmp = 0;
  int i_ = 0;
  int i1_ = 0;

  if (minmn <= 0)
    return;

  for (i = 0; i <= minmn - 1; i++) {

    i1_ = i - 1;
    for (i_ = 1; i_ <= n - i; i_++)
      t[i_] = CMath::Conj(a[i][i_ + i1_]);
    CComplexReflections::ComplexGenerateReflection(t, n - i, tmp);
    tau[i] = tmp;
    i1_ = 1 - i;
    for (i_ = i; i_ < n; i_++)
      a[i].Set(i_, CMath::Conj(t[i_ + i1_]));
    t[1] = 1;

    if (i < m - 1) {

      CComplexReflections::ComplexApplyReflectionFromTheRight(
          a, tau[i], t, i + 1, m - 1, i, n - 1, work);
    }
  }
}

static void COrtFac::RMatrixBlockReflector(CMatrixDouble &a, double &tau[],
                                           const bool columnwisea,
                                           const int lengtha,
                                           const int blocksize,
                                           CMatrixDouble &t, double &work[]) {

  int i = 0;
  int j = 0;
  int k = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  for (k = 0; k < blocksize; k++) {

    if (columnwisea) {
      for (i = 0; i < k; i++)
        a[i].Set(k, 0);
    } else {
      for (i = 0; i < k; i++)
        a[k].Set(i, 0);
    }
    a[k].Set(k, 1);
  }

  for (i = 0; i < blocksize; i++) {
    for (j = 0; j < blocksize; j++)
      t[i].Set(blocksize + j, 0);
  }
  for (k = 0; k <= lengtha - 1; k++) {
    for (j = 1; j < blocksize; j++) {

      if (columnwisea) {
        v = a[k][j];

        if (v != 0) {
          i1_ = -blocksize;
          for (i_ = blocksize; i_ <= blocksize + j - 1; i_++)
            t[j].Set(i_, t[j][i_] + v * a[k][i_ + i1_]);
        }
      } else {
        v = a[j][k];

        if (v != 0) {
          i1_ = -blocksize;
          for (i_ = blocksize; i_ <= blocksize + j - 1; i_++)
            t[j].Set(i_, t[j][i_] + v * a[i_ + i1_][k]);
        }
      }
    }
  }

  for (k = 0; k < blocksize; k++) {

    i1_ = blocksize;
    for (i_ = 0; i_ < k; i_++)
      work[i_] = t[k][i_ + i1_];
    for (i = 0; i < k; i++) {
      v = 0.0;
      for (i_ = i; i_ < k; i_++)
        v += t[i][i_] * work[i_];
      t[i].Set(k, -(tau[k] * v));
    }
    t[k].Set(k, -tau[k]);

    for (i = k + 1; i < blocksize; i++)
      t[i].Set(k, 0);
  }
}

static void COrtFac::CMatrixBlockReflector(CMatrixComplex &a, al_complex &tau[],
                                           const bool columnwisea,
                                           const int lengtha,
                                           const int blocksize,
                                           CMatrixComplex &t,
                                           al_complex &work[]) {

  int i = 0;
  int k = 0;
  al_complex v = 0;
  al_complex tauv = 0;
  int i_ = 0;

  for (k = 0; k < blocksize; k++) {

    if (columnwisea) {
      for (i = 0; i < k; i++)
        a[i].Set(k, 0);
    } else {
      for (i = 0; i < k; i++)
        a[k].Set(i, 0);
    }
    a[k].Set(k, 1);

    for (i = 0; i < k; i++) {

      if (columnwisea) {
        v = 0.0;
        for (i_ = k; i_ <= lengtha - 1; i_++)
          v += CMath::Conj(a[i_][i]) * a[i_][k];
      } else {
        v = 0.0;
        for (i_ = k; i_ <= lengtha - 1; i_++)
          v += a[i][i_] * CMath::Conj(a[k][i_]);
      }
      work[i] = v;
    }
    for (i = 0; i < k; i++) {
      v = 0.0;
      for (i_ = i; i_ < k; i_++)
        v += t[i][i_] * work[i_];

      tauv = tau[k] * v;
      tauv.re = -tauv.re;
      tauv.im = -tauv.im;
      t[i].Set(k, tauv);
    }

    tauv = tau[k];
    tauv.re = -tauv.re;
    tauv.im = -tauv.im;
    t[k].Set(k, tauv);

    for (i = k + 1; i < blocksize; i++)
      t[i].Set(k, 0);
  }
}

class CEigenVDetect {
private:
  static bool TtidiagonalEVD(double &d[], double &ce[], const int n,
                             const int zneeded, CMatrixDouble &z);
  static void TdEVDE2(const double a, const double b, const double c,
                      double &rt1, double &rt2);
  static void TdEVDEv2(const double a, const double b, const double c,
                       double &rt1, double &rt2, double &cs1, double &sn1);
  static double TdEVDPythag(const double a, const double b);
  static double TdEVDExtSign(const double a, const double b);
  static bool InternalBisectionEigenValues(
      double &cd[], double &ce[], const int n, int irange, const int iorder,
      const double vl, const double vu, const int il, const int iu,
      const double abstol, double &w[], int &m, int &nsplit, int &iblock[],
      int &isplit[], int &errorcode);
  static void InternalDStein(const int n, double &d[], double &ce[],
                             const int m, double &cw[], int &iblock[],
                             int &isplit[], CMatrixDouble &z, int &ifail[],
                             int &info);
  static void TdIninternalDLAGTF(const int n, double &a[], const double lambdav,
                                 double &b[], double &c[], double tol,
                                 double &d[], int &iin[], int &info);
  static void TdIninternalDLAGTS(const int n, double &a[], double &b[],
                                 double &c[], double &d[], int &iin[],
                                 double &y[], double &tol, int &info);
  static void InternalDLAEBZ(const int ijob, const int nitmax, const int n,
                             const int mmax, const int minp,
                             const double abstol, const double reltol,
                             const double pivmin, double &d[], double &e[],
                             double &e2[], int &nval[], CMatrixDouble &ab,
                             double &c[], int &mout, CMatrixInt &nab,
                             double &work[], int &iwork[], int &info);
  static void InternalTREVC(CMatrixDouble &t, const int n, const int side,
                            const int howmny, bool &cvselect[],
                            CMatrixDouble &vl, CMatrixDouble &vr, int &m,
                            int &info);
  static void InternalHsEVDLALN2(
      const bool ltrans, const int na, const int nw, const double smin,
      const double ca, CMatrixDouble &a, const double d1, const double d2,
      CMatrixDouble &b, const double wr, const double wi, bool &rswap4[],
      bool &zswap4[], CMatrixInt &ipivot44, double &civ4[], double &crv4[],
      CMatrixDouble &x, double &scl, double &xnorm, int &info);
  static void InternalHsEVDLADIV(const double a, const double b, const double c,
                                 const double d, double &p, double &q);
  static bool NonSymmetricEVD(CMatrixDouble &ca, const int n, const int vneeded,
                              double &wr[], double &wi[], CMatrixDouble &vl,
                              CMatrixDouble &vr);
  static void ToUpperHessenberg(CMatrixDouble &a, const int n, double &tau[]);
  static void UnpackQFromUpperHessenberg(CMatrixDouble &a, const int n,
                                         double &tau[], CMatrixDouble &q);

public:
  CEigenVDetect(void);
  ~CEigenVDetect(void);

  static bool SMatrixEVD(CMatrixDouble &ca, const int n, const int zneeded,
                         const bool isupper, double &d[], CMatrixDouble &z);
  static bool SMatrixEVDR(CMatrixDouble &ca, const int n, const int zneeded,
                          const bool isupper, const double b1, const double b2,
                          int &m, double &w[], CMatrixDouble &z);
  static bool SMatrixEVDI(CMatrixDouble &ca, const int n, const int zneeded,
                          const bool isupper, const int i1, const int i2,
                          double &w[], CMatrixDouble &z);
  static bool HMatrixEVD(CMatrixComplex &ca, const int n, int zneeded,
                         const bool isupper, double &d[], CMatrixComplex &z);
  static bool HMatrixEVDR(CMatrixComplex &ca, const int n, int zneeded,
                          bool isupper, const double b1, const double b2,
                          int &m, double &w[], CMatrixComplex &z);
  static bool HMatrixEVDI(CMatrixComplex &ca, const int n, int zneeded,
                          const bool isupper, const int i1, const int i2,
                          double &w[], CMatrixComplex &z);
  static bool SMatrixTdEVD(double &d[], double &ce[], const int n,
                           const int zneeded, CMatrixDouble &z);
  static bool SMatrixTdEVDR(double &d[], double &e[], const int n,
                            const int zneeded, const double a, const double b,
                            int &m, CMatrixDouble &z);
  static bool SMatrixTdEVDI(double &d[], double &e[], const int n,
                            const int zneeded, const int i1, const int i2,
                            CMatrixDouble &z);
  static bool RMatrixEVD(CMatrixDouble &ca, const int n, const int vneeded,
                         double &wr[], double &wi[], CMatrixDouble &vl,
                         CMatrixDouble &vr);
};

CEigenVDetect::CEigenVDetect(void) {}

CEigenVDetect::~CEigenVDetect(void) {}

static bool CEigenVDetect::SMatrixEVD(CMatrixDouble &ca, const int n,
                                      const int zneeded, const bool isupper,
                                      double &d[], CMatrixDouble &z) {

  double tau[];
  double e[];

  CMatrixDouble a;
  a = ca;

  if (!CAp::Assert(zneeded == 0 || zneeded == 1,
                   __FUNCTION__ + ": incorrect ZNeeded"))
    return (false);

  COrtFac::SMatrixTD(a, n, isupper, tau, d, e);

  if (zneeded == 1) {

    COrtFac::SMatrixTDUnpackQ(a, n, isupper, tau, z);
  }

  return (SMatrixTdEVD(d, e, n, zneeded, z));
}

static bool CEigenVDetect::SMatrixEVDR(CMatrixDouble &ca, const int n,
                                       const int zneeded, const bool isupper,
                                       const double b1, const double b2, int &m,
                                       double &w[], CMatrixDouble &z) {

  double tau[];
  double e[];

  CMatrixDouble a;
  a = ca;

  m = 0;

  if (!CAp::Assert(zneeded == 0 || zneeded == 1,
                   __FUNCTION__ + ": incorrect ZNeeded"))
    return (false);

  COrtFac::SMatrixTD(a, n, isupper, tau, w, e);

  if (zneeded == 1) {

    COrtFac::SMatrixTDUnpackQ(a, n, isupper, tau, z);
  }

  return (SMatrixTdEVDR(w, e, n, zneeded, b1, b2, m, z));
}

static bool CEigenVDetect::SMatrixEVDI(CMatrixDouble &ca, const int n,
                                       const int zneeded, const bool isupper,
                                       const int i1, const int i2, double &w[],
                                       CMatrixDouble &z) {

  double tau[];
  double e[];

  CMatrixDouble a;
  a = ca;

  if (!CAp::Assert(zneeded == 0 || zneeded == 1,
                   __FUNCTION__ + ": incorrect ZNeeded"))
    return (false);

  COrtFac::SMatrixTD(a, n, isupper, tau, w, e);

  if (zneeded == 1) {

    COrtFac::SMatrixTDUnpackQ(a, n, isupper, tau, z);
  }

  return (SMatrixTdEVDI(w, e, n, zneeded, i1, i2, z));
}

static bool CEigenVDetect::HMatrixEVD(CMatrixComplex &ca, const int n,
                                      int zneeded, const bool isupper,
                                      double &d[], CMatrixComplex &z) {

  int i = 0;
  int k = 0;
  double v = 0;
  int i_ = 0;
  bool result;

  al_complex tau[];
  double e[];
  double work[];

  CMatrixDouble t;
  CMatrixComplex q;

  CMatrixComplex a;
  a = ca;

  if (!CAp::Assert(zneeded == 0 || zneeded == 1,
                   __FUNCTION__ + ": incorrect ZNeeded"))
    return (false);

  COrtFac::HMatrixTD(a, n, isupper, tau, d, e);

  if (zneeded == 1) {

    COrtFac::HMatrixTDUnpackQ(a, n, isupper, tau, q);
    zneeded = 2;
  }

  result = SMatrixTdEVD(d, e, n, zneeded, t);

  if (result && zneeded != 0) {
    ArrayResizeAL(work, n);
    z.Resize(n, n);
    for (i = 0; i < n; i++) {

      for (k = 0; k < n; k++)
        work[k] = 0;
      for (k = 0; k < n; k++) {
        v = q[i][k].re;
        for (i_ = 0; i_ < n; i_++)
          work[i_] = work[i_] + v * t[k][i_];
      }

      for (k = 0; k < n; k++)
        z[i].SetRe(k, work[k]);

      for (k = 0; k < n; k++)
        work[k] = 0;
      for (k = 0; k < n; k++) {
        v = q[i][k].im;
        for (i_ = 0; i_ < n; i_++)
          work[i_] = work[i_] + v * t[k][i_];
      }

      for (k = 0; k < n; k++)
        z[i].SetIm(k, work[k]);
    }
  }

  return (result);
}

static bool CEigenVDetect::HMatrixEVDR(CMatrixComplex &ca, const int n,
                                       int zneeded, bool isupper,
                                       const double b1, const double b2, int &m,
                                       double &w[], CMatrixComplex &z) {

  int i = 0;
  int k = 0;
  double v = 0;
  int i_ = 0;
  bool result;

  al_complex tau[];
  double e[];
  double work[];

  CMatrixComplex q;
  CMatrixDouble t;

  CMatrixComplex a;
  a = ca;

  m = 0;

  if (!CAp::Assert(zneeded == 0 || zneeded == 1,
                   __FUNCTION__ + ": incorrect ZNeeded"))
    return (false);

  COrtFac::HMatrixTD(a, n, isupper, tau, w, e);

  if (zneeded == 1) {

    COrtFac::HMatrixTDUnpackQ(a, n, isupper, tau, q);
    zneeded = 2;
  }

  result = SMatrixTdEVDR(w, e, n, zneeded, b1, b2, m, t);

  if ((result && zneeded != 0) && m != 0) {
    ArrayResizeAL(work, m);
    z.Resize(n, m);
    for (i = 0; i < n; i++) {

      for (k = 0; k <= m - 1; k++)
        work[k] = 0;
      for (k = 0; k < n; k++) {
        v = q[i][k].re;
        for (i_ = 0; i_ < m; i_++)
          work[i_] = work[i_] + v * t[k][i_];
      }

      for (k = 0; k <= m - 1; k++)
        z[i].SetRe(k, work[k]);

      for (k = 0; k <= m - 1; k++)
        work[k] = 0;
      for (k = 0; k < n; k++) {
        v = q[i][k].im;
        for (i_ = 0; i_ < m; i_++)
          work[i_] = work[i_] + v * t[k][i_];
      }

      for (k = 0; k <= m - 1; k++)
        z[i].SetIm(k, work[k]);
    }
  }

  return (result);
}

static bool CEigenVDetect::HMatrixEVDI(CMatrixComplex &ca, const int n,
                                       int zneeded, const bool isupper,
                                       const int i1, const int i2, double &w[],
                                       CMatrixComplex &z) {

  int i = 0;
  int k = 0;
  double v = 0;
  int m = 0;
  int i_ = 0;
  bool result;

  al_complex tau[];
  double e[];
  double work[];

  CMatrixComplex q;
  CMatrixDouble t;

  CMatrixComplex a;
  a = ca;

  if (!CAp::Assert(zneeded == 0 || zneeded == 1,
                   __FUNCTION__ + ": incorrect ZNeeded"))
    return (false);

  COrtFac::HMatrixTD(a, n, isupper, tau, w, e);

  if (zneeded == 1) {

    COrtFac::HMatrixTDUnpackQ(a, n, isupper, tau, q);
    zneeded = 2;
  }

  result = SMatrixTdEVDI(w, e, n, zneeded, i1, i2, t);

  m = i2 - i1 + 1;

  if (result && zneeded != 0) {
    ArrayResizeAL(work, m);
    z.Resize(n, m);
    for (i = 0; i < n; i++) {

      for (k = 0; k <= m - 1; k++)
        work[k] = 0;
      for (k = 0; k < n; k++) {
        v = q[i][k].re;
        for (i_ = 0; i_ < m; i_++)
          work[i_] = work[i_] + v * t[k][i_];
      }

      for (k = 0; k <= m - 1; k++)
        z[i].SetRe(k, work[k]);

      for (k = 0; k <= m - 1; k++)
        work[k] = 0;
      for (k = 0; k < n; k++) {
        v = q[i][k].im;
        for (i_ = 0; i_ < m; i_++)
          work[i_] = work[i_] + v * t[k][i_];
      }

      for (k = 0; k <= m - 1; k++)
        z[i].SetIm(k, work[k]);
    }
  }

  return (result);
}

static bool CEigenVDetect::SMatrixTdEVD(double &d[], double &ce[], const int n,
                                        const int zneeded, CMatrixDouble &z) {

  int i = 0;
  int i_ = 0;
  int i1_ = 0;
  bool result;

  double d1[];
  double e1[];

  CMatrixDouble z1;

  double e[];
  ArrayResizeAL(e, ArraySize(ce));
  ArrayCopy(e, ce);

  ArrayResizeAL(d1, n + 1);
  ArrayResizeAL(e1, n + 1);
  i1_ = -1;
  for (i_ = 1; i_ <= n; i_++)
    d1[i_] = d[i_ + i1_];

  if (n > 1) {
    i1_ = -1;
    for (i_ = 1; i_ < n; i_++)
      e1[i_] = e[i_ + i1_];
  }

  if (zneeded == 1) {
    z1.Resize(n + 1, n + 1);
    for (i = 1; i <= n; i++) {
      i1_ = -1;
      for (i_ = 1; i_ <= n; i_++)
        z1[i].Set(i_, z[i - 1][i_ + i1_]);
    }
  }

  result = TtidiagonalEVD(d1, e1, n, zneeded, z1);

  if (!result)
    return (result);

  i1_ = 1;
  for (i_ = 0; i_ < n; i_++)
    d[i_] = d1[i_ + i1_];

  if (zneeded != 0) {

    if (zneeded == 1) {
      for (i = 1; i <= n; i++) {
        i1_ = 1;
        for (i_ = 0; i_ < n; i_++)
          z[i - 1].Set(i_, z1[i][i_ + i1_]);
      }

      return (result);
    }

    if (zneeded == 2) {
      z.Resize(n, n);
      for (i = 1; i <= n; i++) {
        i1_ = 1;
        for (i_ = 0; i_ < n; i_++)
          z[i - 1].Set(i_, z1[i][i_ + i1_]);
      }

      return (result);
    }

    if (zneeded == 3) {
      z.Resize(1, n);
      i1_ = 1;
      for (i_ = 0; i_ < n; i_++)
        z[0].Set(i_, z1[1][i_ + i1_]);

      return (result);
    }

    if (!CAp::Assert(false, __FUNCTION__ + ": Incorrect ZNeeded!"))
      return (false);
  }

  return (result);
}

static bool CEigenVDetect::SMatrixTdEVDR(double &d[], double &e[], const int n,
                                         const int zneeded, const double a,
                                         const double b, int &m,
                                         CMatrixDouble &z) {

  bool result;
  int errorcode = 0;
  int nsplit = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int cr = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  int iblock[];
  int isplit[];
  int ifail[];
  double d1[];
  double e1[];
  double w[];

  CMatrixDouble z2;
  CMatrixDouble z3;

  m = 0;

  if (!CAp::Assert(zneeded >= 0 && zneeded <= 2,
                   __FUNCTION__ + ": incorrect ZNeeded!"))
    return (false);

  if (b <= a) {
    m = 0;

    return (true);
  }

  if (n <= 0) {
    m = 0;

    return (true);
  }

  ArrayResizeAL(d1, n + 1);
  i1_ = -1;
  for (i_ = 1; i_ <= n; i_++)
    d1[i_] = d[i_ + i1_];

  if (n > 1) {
    ArrayResizeAL(e1, n);
    i1_ = -1;
    for (i_ = 1; i_ < n; i_++)
      e1[i_] = e[i_ + i1_];
  }

  if (zneeded == 0) {

    result = InternalBisectionEigenValues(d1, e1, n, 2, 1, a, b, 0, 0, -1, w, m,
                                          nsplit, iblock, isplit, errorcode);

    if (!result || m == 0) {
      m = 0;
      return (result);
    }
    ArrayResizeAL(d, m);
    i1_ = 1;
    for (i_ = 0; i_ < m; i_++) {
      d[i_] = w[i_ + i1_];
    }

    return (result);
  }

  if (zneeded == 1) {

    result = InternalBisectionEigenValues(d1, e1, n, 2, 2, a, b, 0, 0, -1, w, m,
                                          nsplit, iblock, isplit, errorcode);

    if (!result || m == 0) {
      m = 0;
      return (result);
    }

    InternalDStein(n, d1, e1, m, w, iblock, isplit, z2, ifail, cr);

    if (cr != 0) {
      m = 0;

      result = false;
      return (result);
    }

    for (i = 1; i <= m; i++) {
      k = i;
      for (j = i; j <= m; j++) {

        if (w[j] < w[k])
          k = j;
      }

      v = w[i];
      w[i] = w[k];
      w[k] = v;
      for (j = 1; j <= n; j++) {

        v = z2[j][i];
        z2[j].Set(i, z2[j][k]);
        z2[j].Set(k, v);
      }
    }

    z3.Resize(m + 1, n + 1);
    for (i = 1; i <= m; i++)
      for (i_ = 1; i_ <= n; i_++)
        z3[i].Set(i_, z2[i_][i]);
    for (i = 1; i <= n; i++) {
      for (j = 1; j <= m; j++) {
        i1_ = 1;
        v = 0.0;
        for (i_ = 0; i_ < n; i_++)
          v += z[i - 1][i_] * z3[j][i_ + i1_];
        z2[i].Set(j, v);
      }
    }

    z.Resize(n, m);
    for (i = 1; i <= m; i++) {
      i1_ = 1;
      for (i_ = 0; i_ < n; i_++)
        z[i_].Set(i - 1, z2[i_ + i1_][i]);
    }

    ArrayResizeAL(d, m);
    for (i = 1; i <= m; i++)
      d[i - 1] = w[i];

    return (result);
  }

  if (zneeded == 2) {

    result = InternalBisectionEigenValues(d1, e1, n, 2, 2, a, b, 0, 0, -1, w, m,
                                          nsplit, iblock, isplit, errorcode);

    if (!result || m == 0) {
      m = 0;
      return (result);
    }

    InternalDStein(n, d1, e1, m, w, iblock, isplit, z2, ifail, cr);

    if (cr != 0) {
      m = 0;
      result = false;
      return (result);
    }

    for (i = 1; i <= m; i++) {
      k = i;
      for (j = i; j <= m; j++) {

        if (w[j] < w[k])
          k = j;
      }

      v = w[i];
      w[i] = w[k];
      w[k] = v;
      for (j = 1; j <= n; j++) {

        v = z2[j][i];
        z2[j].Set(i, z2[j][k]);
        z2[j].Set(k, v);
      }
    }

    ArrayResizeAL(d, m);
    for (i = 1; i <= m; i++)
      d[i - 1] = w[i];
    z.Resize(n, m);
    for (i = 1; i <= m; i++) {
      i1_ = 1;
      for (i_ = 0; i_ < n; i_++)
        z[i_].Set(i - 1, z2[i_ + i1_][i]);
    }

    return (result);
  }

  return (false);
}

static bool CEigenVDetect::SMatrixTdEVDI(double &d[], double &e[], const int n,
                                         const int zneeded, const int i1,
                                         const int i2, CMatrixDouble &z) {

  bool result;
  int errorcode = 0;
  int nsplit = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int m = 0;
  int cr = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  int iblock[];
  int isplit[];
  int ifail[];
  double w[];
  double d1[];
  double e1[];

  CMatrixDouble z2;
  CMatrixDouble z3;

  if (!CAp::Assert((0 <= i1 && i1 <= i2) && i2 < n,
                   __FUNCTION__ + ": incorrect I1/I2!"))
    return (false);

  ArrayResizeAL(d1, n + 1);
  i1_ = -1;
  for (i_ = 1; i_ <= n; i_++)
    d1[i_] = d[i_ + i1_];

  if (n > 1) {
    ArrayResizeAL(e1, n);
    i1_ = -1;
    for (i_ = 1; i_ < n; i_++)
      e1[i_] = e[i_ + i1_];
  }

  if (zneeded == 0) {
    result =
        InternalBisectionEigenValues(d1, e1, n, 3, 1, 0, 0, i1 + 1, i2 + 1, -1,
                                     w, m, nsplit, iblock, isplit, errorcode);

    if (!result)
      return (result);

    if (m != i2 - i1 + 1) {
      result = false;
      return (result);
    }
    ArrayResizeAL(d, m);
    for (i = 1; i <= m; i++)
      d[i - 1] = w[i];

    return (result);
  }

  if (zneeded == 1) {

    result =
        InternalBisectionEigenValues(d1, e1, n, 3, 2, 0, 0, i1 + 1, i2 + 1, -1,
                                     w, m, nsplit, iblock, isplit, errorcode);

    if (!result)
      return (result);

    if (m != i2 - i1 + 1) {
      result = false;
      return (result);
    }

    InternalDStein(n, d1, e1, m, w, iblock, isplit, z2, ifail, cr);

    if (cr != 0) {
      result = false;
      return (result);
    }

    for (i = 1; i <= m; i++) {
      k = i;
      for (j = i; j <= m; j++) {

        if (w[j] < w[k])
          k = j;
      }

      v = w[i];
      w[i] = w[k];
      w[k] = v;
      for (j = 1; j <= n; j++) {

        v = z2[j][i];
        z2[j].Set(i, z2[j][k]);
        z2[j].Set(k, v);
      }
    }

    z3.Resize(m + 1, n + 1);
    for (i = 1; i <= m; i++)
      for (i_ = 1; i_ <= n; i_++)
        z3[i].Set(i_, z2[i_][i]);
    for (i = 1; i <= n; i++) {
      for (j = 1; j <= m; j++) {
        i1_ = 1;
        v = 0.0;
        for (i_ = 0; i_ < n; i_++)
          v += z[i - 1][i_] * z3[j][i_ + i1_];
        z2[i].Set(j, v);
      }
    }

    z.Resize(n, m);
    for (i = 1; i <= m; i++) {
      i1_ = 1;
      for (i_ = 0; i_ < n; i_++)
        z[i_].Set(i - 1, z2[i_ + i1_][i]);
    }

    ArrayResizeAL(d, m);
    for (i = 1; i <= m; i++)
      d[i - 1] = w[i];

    return (result);
  }

  if (zneeded == 2) {

    result =
        InternalBisectionEigenValues(d1, e1, n, 3, 2, 0, 0, i1 + 1, i2 + 1, -1,
                                     w, m, nsplit, iblock, isplit, errorcode);

    if (!result)
      return (result);

    if (m != i2 - i1 + 1) {
      result = false;
      return (result);
    }

    InternalDStein(n, d1, e1, m, w, iblock, isplit, z2, ifail, cr);

    if (cr != 0) {
      result = false;
      return (result);
    }

    for (i = 1; i <= m; i++) {
      k = i;
      for (j = i; j <= m; j++) {

        if (w[j] < w[k])
          k = j;
      }

      v = w[i];
      w[i] = w[k];
      w[k] = v;
      for (j = 1; j <= n; j++) {

        v = z2[j][i];
        z2[j].Set(i, z2[j][k]);
        z2[j].Set(k, v);
      }
    }

    z.Resize(n, m);
    for (i = 1; i <= m; i++) {
      i1_ = 1;
      for (i_ = 0; i_ < n; i_++)
        z[i_].Set(i - 1, z2[i_ + i1_][i]);
    }

    ArrayResizeAL(d, m);
    for (i = 1; i <= m; i++)
      d[i - 1] = w[i];

    return (result);
  }

  return (false);
}

static bool CEigenVDetect::RMatrixEVD(CMatrixDouble &ca, const int n,
                                      const int vneeded, double &wr[],
                                      double &wi[], CMatrixDouble &vl,
                                      CMatrixDouble &vr) {

  int i = 0;
  int i_ = 0;
  int i1_ = 0;
  bool result;

  double wr1[];
  double wi1[];

  CMatrixDouble a1;
  CMatrixDouble vl1;
  CMatrixDouble vr1;

  CMatrixDouble a;
  a = ca;

  if (!CAp::Assert(vneeded >= 0 && vneeded <= 3,
                   __FUNCTION__ + ": incorrect VNeeded!"))
    return (false);
  a1.Resize(n + 1, n + 1);
  for (i = 1; i <= n; i++) {
    i1_ = -1;
    for (i_ = 1; i_ <= n; i_++)
      a1[i].Set(i_, a[i - 1][i_ + i1_]);
  }

  result = NonSymmetricEVD(a1, n, vneeded, wr1, wi1, vl1, vr1);

  if (result) {

    ArrayResizeAL(wr, n);
    ArrayResizeAL(wi, n);
    i1_ = 1;
    for (i_ = 0; i_ < n; i_++)
      wr[i_] = wr1[i_ + i1_];
    i1_ = 1;
    for (i_ = 0; i_ < n; i_++)
      wi[i_] = wi1[i_ + i1_];

    if (vneeded == 2 || vneeded == 3) {
      vl.Resize(n, n);
      for (i = 0; i < n; i++) {
        i1_ = 1;
        for (i_ = 0; i_ < n; i_++)
          vl[i].Set(i_, vl1[i + 1][i_ + i1_]);
      }
    }

    if (vneeded == 1 || vneeded == 3) {
      vr.Resize(n, n);
      for (i = 0; i < n; i++) {
        i1_ = 1;
        for (i_ = 0; i_ < n; i_++)
          vr[i].Set(i_, vr1[i + 1][i_ + i1_]);
      }
    }
  }

  return (result);
}

static bool CEigenVDetect::TtidiagonalEVD(double &d[], double &ce[],
                                          const int n, const int zneeded,
                                          CMatrixDouble &z) {

  bool result;
  int maxit = 0;
  int i = 0;
  int ii = 0;
  int iscale = 0;
  int j = 0;
  int jtot = 0;
  int k = 0;
  int t = 0;
  int l = 0;
  int l1 = 0;
  int lend = 0;
  int lendm1 = 0;
  int lendp1 = 0;
  int lendsv = 0;
  int lm1 = 0;
  int lsv = 0;
  int m = 0;
  int mm = 0;
  int mm1 = 0;
  int nm1 = 0;
  int nmaxit = 0;
  int tmpint = 0;
  double anorm = 0;
  double b = 0;
  double c = 0;
  double eps = 0;
  double eps2 = 0;
  double f = 0;
  double g = 0;
  double p = 0;
  double r = 0;
  double rt1 = 0;
  double rt2 = 0;
  double s = 0;
  double safmax = 0;
  double safmin = 0;
  double ssfmax = 0;
  double ssfmin = 0;
  double tst = 0;
  double tmp = 0;
  bool gotoflag;
  int zrows = 0;
  bool wastranspose;
  int i_ = 0;

  double work1[];
  double work2[];
  double workc[];
  double works[];
  double wtemp[];

  double e[];
  ArrayResizeAL(e, ArraySize(ce));
  ArrayCopy(e, ce);

  if (!CAp::Assert(zneeded >= 0 && zneeded <= 3,
                   __FUNCTION__ + ": Incorrent ZNeeded"))
    return (false);

  if (zneeded < 0 || zneeded > 3)
    return (false);

  result = true;

  if (n == 0)
    return (result);

  if (n == 1) {

    if (zneeded == 2 || zneeded == 3) {
      z.Resize(2, 2);
      z[1].Set(1, 1);
    }

    return (result);
  }

  maxit = 30;

  ArrayResizeAL(wtemp, n + 1);
  ArrayResizeAL(work1, n);
  ArrayResizeAL(work2, n);
  ArrayResizeAL(workc, n + 1);
  ArrayResizeAL(works, n + 1);

  eps = CMath::m_machineepsilon;
  eps2 = CMath::Sqr(eps);
  safmin = CMath::m_minrealnumber;
  safmax = CMath::m_maxrealnumber;
  ssfmax = MathSqrt(safmax) / 3;
  ssfmin = MathSqrt(safmin) / eps2;

  wastranspose = false;
  zrows = 0;

  if (zneeded == 1)
    zrows = n;

  if (zneeded == 2)
    zrows = n;

  if (zneeded == 3)
    zrows = 1;

  if (zneeded == 1) {
    wastranspose = true;

    CBlas::InplaceTranspose(z, 1, n, 1, n, wtemp);
  }

  if (zneeded == 2) {
    wastranspose = true;
    z.Resize(n + 1, n + 1);
    for (i = 1; i <= n; i++) {
      for (j = 1; j <= n; j++) {

        if (i == j)
          z[i].Set(j, 1);
        else
          z[i].Set(j, 0);
      }
    }
  }

  if (zneeded == 3) {
    wastranspose = false;
    z.Resize(2, n + 1);
    for (j = 1; j <= n; j++) {

      if (j == 1)
        z[1].Set(j, 1);
      else
        z[1].Set(j, 0);
    }
  }

  nmaxit = n * maxit;
  jtot = 0;

  l1 = 1;
  nm1 = n - 1;
  while (true) {

    if (l1 > n)
      break;

    if (l1 > 1)
      e[l1 - 1] = 0;
    gotoflag = false;
    m = l1;

    if (l1 <= nm1) {
      for (m = l1; m <= nm1; m++) {
        tst = MathAbs(e[m]);

        if (tst == 0.0) {
          gotoflag = true;

          break;
        }

        if (tst <=
            MathSqrt(MathAbs(d[m])) * MathSqrt(MathAbs(d[m + 1])) * eps) {
          e[m] = 0;
          gotoflag = true;

          break;
        }
      }
    }

    if (!gotoflag)
      m = n;

    l = l1;
    lsv = l;
    lend = m;
    lendsv = lend;
    l1 = m + 1;

    if (lend == l)
      continue;

    if (l == lend)
      anorm = MathAbs(d[l]);
    else {
      anorm = MathMax(MathAbs(d[l]) + MathAbs(e[l]),
                      MathAbs(e[lend - 1]) + MathAbs(d[lend]));
      for (i = l + 1; i <= lend - 1; i++)
        anorm =
            MathMax(anorm, MathAbs(d[i]) + MathAbs(e[i]) + MathAbs(e[i - 1]));
    }
    iscale = 0;

    if (anorm == 0.0)
      continue;

    if (anorm > (double)(ssfmax)) {
      iscale = 1;
      tmp = ssfmax / anorm;
      tmpint = lend - 1;
      for (i_ = l; i_ <= lend; i_++)
        d[i_] = tmp * d[i_];
      for (i_ = l; i_ <= tmpint; i_++)
        e[i_] = tmp * e[i_];
    }

    if (anorm < ssfmin) {
      iscale = 2;
      tmp = ssfmin / anorm;
      tmpint = lend - 1;
      for (i_ = l; i_ <= lend; i_++)
        d[i_] = tmp * d[i_];
      for (i_ = l; i_ <= tmpint; i_++)
        e[i_] = tmp * e[i_];
    }

    if (MathAbs(d[lend]) < MathAbs(d[l])) {
      lend = lsv;
      l = lendsv;
    }

    if (lend > l) {

      while (true) {
        gotoflag = false;

        if (l != lend) {
          lendm1 = lend - 1;
          for (m = l; m <= lendm1; m++) {
            tst = CMath::Sqr(MathAbs(e[m]));

            if (tst <= eps2 * MathAbs(d[m]) * MathAbs(d[m + 1]) + safmin) {
              gotoflag = true;

              break;
            }
          }
        }

        if (!gotoflag)
          m = lend;

        if (m < lend)
          e[m] = 0;
        p = d[l];

        if (m != l) {

          if (m == l + 1) {

            if (zneeded > 0) {

              TdEVDEv2(d[l], e[l], d[l + 1], rt1, rt2, c, s);

              work1[l] = c;
              work2[l] = s;
              workc[1] = work1[l];
              works[1] = work2[l];

              if (!wastranspose)
                CRotations::ApplyRotationsFromTheRight(
                    false, 1, zrows, l, l + 1, workc, works, z, wtemp);
              else
                CRotations::ApplyRotationsFromTheLeft(false, l, l + 1, 1, zrows,
                                                      workc, works, z, wtemp);
            } else

              TdEVDE2(d[l], e[l], d[l + 1], rt1, rt2);

            d[l] = rt1;
            d[l + 1] = rt2;
            e[l] = 0;
            l = l + 2;

            if (l <= lend)
              continue;

            break;
          }

          if (jtot == nmaxit)
            break;
          jtot = jtot + 1;

          g = (d[l + 1] - p) / (2 * e[l]);

          r = TdEVDPythag(g, 1);
          g = d[m] - p + e[l] / (g + TdEVDExtSign(r, g));
          s = 1;
          c = 1;
          p = 0;

          mm1 = m - 1;
          for (i = mm1; i >= l; i--) {
            f = s * e[i];
            b = c * e[i];

            CRotations::GenerateRotation(g, f, c, s, r);

            if (i != m - 1)
              e[i + 1] = r;
            g = d[i + 1] - p;
            r = (d[i] - g) * s + 2 * c * b;
            p = s * r;
            d[i + 1] = g + p;
            g = c * r - b;

            if (zneeded > 0) {
              work1[i] = c;
              work2[i] = -s;
            }
          }

          if (zneeded > 0) {
            for (i = l; i < m; i++) {
              workc[i - l + 1] = work1[i];
              works[i - l + 1] = work2[i];
            }

            if (!wastranspose) {

              CRotations::ApplyRotationsFromTheRight(false, 1, zrows, l, m,
                                                     workc, works, z, wtemp);
            } else {

              CRotations::ApplyRotationsFromTheLeft(false, l, m, 1, zrows,
                                                    workc, works, z, wtemp);
            }
          }
          d[l] = d[l] - p;
          e[l] = g;
          continue;
        }

        d[l] = p;
        l = l + 1;

        if (l <= lend)
          continue;

        break;
      }
    } else {

      while (true) {
        gotoflag = false;

        if (l != lend) {
          lendp1 = lend + 1;
          for (m = l; m >= lendp1; m--) {
            tst = CMath::Sqr(MathAbs(e[m - 1]));

            if (tst <=
                (double)(eps2 * MathAbs(d[m]) * MathAbs(d[m - 1]) + safmin)) {
              gotoflag = true;

              break;
            }
          }
        }

        if (!gotoflag)
          m = lend;

        if (m > lend)
          e[m - 1] = 0;
        p = d[l];

        if (m != l) {

          if (m == l - 1) {

            if (zneeded > 0) {

              TdEVDEv2(d[l - 1], e[l - 1], d[l], rt1, rt2, c, s);
              work1[m] = c;
              work2[m] = s;
              workc[1] = c;
              works[1] = s;

              if (!wastranspose) {

                CRotations::ApplyRotationsFromTheRight(true, 1, zrows, l - 1, l,
                                                       workc, works, z, wtemp);
              } else {

                CRotations::ApplyRotationsFromTheLeft(true, l - 1, l, 1, zrows,
                                                      workc, works, z, wtemp);
              }
            } else {

              TdEVDE2(d[l - 1], e[l - 1], d[l], rt1, rt2);
            }
            d[l - 1] = rt1;
            d[l] = rt2;
            e[l - 1] = 0;
            l = l - 2;

            if (l >= lend)
              continue;

            break;
          }

          if (jtot == nmaxit)
            break;
          jtot = jtot + 1;

          g = (d[l - 1] - p) / (2 * e[l - 1]);

          r = TdEVDPythag(g, 1);
          g = d[m] - p + e[l - 1] / (g + TdEVDExtSign(r, g));
          s = 1;
          c = 1;
          p = 0;

          lm1 = l - 1;
          for (i = m; i <= lm1; i++) {
            f = s * e[i];
            b = c * e[i];

            CRotations::GenerateRotation(g, f, c, s, r);

            if (i != m)
              e[i - 1] = r;

            g = d[i] - p;
            r = (d[i + 1] - g) * s + 2 * c * b;
            p = s * r;
            d[i] = g + p;
            g = c * r - b;

            if (zneeded > 0) {
              work1[i] = c;
              work2[i] = s;
            }
          }

          if (zneeded > 0) {
            mm = l - m + 1;
            for (i = m; i <= l - 1; i++) {
              workc[i - m + 1] = work1[i];
              works[i - m + 1] = work2[i];
            }

            if (!wastranspose) {

              CRotations::ApplyRotationsFromTheRight(true, 1, zrows, m, l,
                                                     workc, works, z, wtemp);
            } else {

              CRotations::ApplyRotationsFromTheLeft(true, m, l, 1, zrows, workc,
                                                    works, z, wtemp);
            }
          }
          d[l] = d[l] - p;
          e[lm1] = g;
          continue;
        }

        d[l] = p;
        l = l - 1;

        if (l >= lend)
          continue;

        break;
      }
    }

    if (iscale == 1) {
      tmp = anorm / ssfmax;
      tmpint = lendsv - 1;
      for (i_ = lsv; i_ <= lendsv; i_++)
        d[i_] = tmp * d[i_];
      for (i_ = lsv; i_ <= tmpint; i_++)
        e[i_] = tmp * e[i_];
    }

    if (iscale == 2) {
      tmp = anorm / ssfmin;
      tmpint = lendsv - 1;
      for (i_ = lsv; i_ <= lendsv; i_++)
        d[i_] = tmp * d[i_];
      for (i_ = lsv; i_ <= tmpint; i_++)
        e[i_] = tmp * e[i_];
    }

    if (jtot >= nmaxit) {
      result = false;

      if (wastranspose) {

        CBlas::InplaceTranspose(z, 1, n, 1, n, wtemp);
      }

      return (result);
    }
  }

  if (zneeded == 0) {

    if (n == 1)
      return (result);

    if (n == 2) {

      if (d[1] > d[2]) {
        tmp = d[1];
        d[1] = d[2];
        d[2] = tmp;
      }

      return (result);
    }
    i = 2;
    do {
      t = i;
      while (t != 1) {
        k = t / 2;

        if (d[k] >= d[t])
          t = 1;
        else {

          tmp = d[k];
          d[k] = d[t];
          d[t] = tmp;
          t = k;
        }
      }
      i = i + 1;
    }

    while (i <= n);
    i = n - 1;
    do {
      tmp = d[i + 1];
      d[i + 1] = d[1];
      d[1] = tmp;
      t = 1;
      while (t != 0) {
        k = 2 * t;

        if (k > i)
          t = 0;
        else {

          if (k < i) {

            if (d[k + 1] > d[k])
              k = k + 1;
          }

          if (d[t] >= d[k])
            t = 0;
          else {

            tmp = d[k];
            d[k] = d[t];
            d[t] = tmp;
            t = k;
          }
        }
      }
      i = i - 1;
    } while (i >= 1);
  } else {

    for (ii = 2; ii <= n; ii++) {
      i = ii - 1;
      k = i;
      p = d[i];
      for (j = ii; j <= n; j++) {

        if (d[j] < p) {
          k = j;
          p = d[j];
        }
      }

      if (k != i) {
        d[k] = d[i];
        d[i] = p;

        if (wastranspose) {
          for (i_ = 1; i_ <= n; i_++)
            wtemp[i_] = z[i][i_];
          for (i_ = 1; i_ <= n; i_++)
            z[i].Set(i_, z[k][i_]);
          for (i_ = 1; i_ <= n; i_++)
            z[k].Set(i_, wtemp[i_]);
        } else {
          for (i_ = 1; i_ <= zrows; i_++)
            wtemp[i_] = z[i_][i];
          for (i_ = 1; i_ <= zrows; i_++)
            z[i_].Set(i, z[i_][k]);
          for (i_ = 1; i_ <= zrows; i_++)
            z[i_].Set(k, wtemp[i_]);
        }
      }
    }

    if (wastranspose) {

      CBlas::InplaceTranspose(z, 1, n, 1, n, wtemp);
    }
  }

  return (result);
}

static void CEigenVDetect::TdEVDE2(const double a, const double b,
                                   const double c, double &rt1, double &rt2) {

  double ab = 0;
  double acmn = 0;
  double acmx = 0;
  double adf = 0;
  double df = 0;
  double rt = 0;
  double sm = 0;
  double tb = 0;

  rt1 = 0;
  rt2 = 0;
  sm = a + c;
  df = a - c;
  adf = MathAbs(df);
  tb = b + b;
  ab = MathAbs(tb);

  if (MathAbs(a) > MathAbs(c)) {
    acmx = a;
    acmn = c;
  } else {
    acmx = c;
    acmn = a;
  }

  if (adf > ab) {
    rt = adf * MathSqrt(1 + CMath::Sqr(ab / adf));
  } else {

    if (adf < ab)
      rt = ab * MathSqrt(1 + CMath::Sqr(adf / ab));
    else {

      rt = ab * MathSqrt(2);
    }
  }

  if (sm < 0.0) {
    rt1 = 0.5 * (sm - rt);

    rt2 = acmx / rt1 * acmn - b / rt1 * b;
  } else {

    if (sm > 0.0) {
      rt1 = 0.5 * (sm + rt);

      rt2 = acmx / rt1 * acmn - b / rt1 * b;
    } else {

      rt1 = 0.5 * rt;
      rt2 = -(0.5 * rt);
    }
  }
}

static void CEigenVDetect::TdEVDEv2(const double a, const double b,
                                    const double c, double &rt1, double &rt2,
                                    double &cs1, double &sn1) {

  int sgn1 = 0;
  int sgn2 = 0;
  double ab = 0;
  double acmn = 0;
  double acmx = 0;
  double acs = 0;
  double adf = 0;
  double cs = 0;
  double ct = 0;
  double df = 0;
  double rt = 0;
  double sm = 0;
  double tb = 0;
  double tn = 0;

  rt1 = 0;
  rt2 = 0;
  cs1 = 0;
  sn1 = 0;

  sm = a + c;
  df = a - c;
  adf = MathAbs(df);
  tb = b + b;
  ab = MathAbs(tb);

  if (MathAbs(a) > MathAbs(c)) {
    acmx = a;
    acmn = c;
  } else {
    acmx = c;
    acmn = a;
  }

  if (adf > ab)
    rt = adf * MathSqrt(1 + CMath::Sqr(ab / adf));
  else {

    if (adf < ab)
      rt = ab * MathSqrt(1 + CMath::Sqr(adf / ab));
    else {

      rt = ab * MathSqrt(2);
    }
  }

  if (sm < 0.0) {
    rt1 = 0.5 * (sm - rt);
    sgn1 = -1;

    rt2 = acmx / rt1 * acmn - b / rt1 * b;
  } else {

    if (sm > 0.0) {
      rt1 = 0.5 * (sm + rt);
      sgn1 = 1;

      rt2 = acmx / rt1 * acmn - b / rt1 * b;
    } else {

      rt1 = 0.5 * rt;
      rt2 = -(0.5 * rt);
      sgn1 = 1;
    }
  }

  if (df >= 0.0) {
    cs = df + rt;
    sgn2 = 1;
  } else {
    cs = df - rt;
    sgn2 = -1;
  }
  acs = MathAbs(cs);

  if (acs > ab) {
    ct = -(tb / cs);
    sn1 = 1 / MathSqrt(1 + ct * ct);
    cs1 = ct * sn1;
  } else {

    if (ab == 0.0) {
      cs1 = 1;
      sn1 = 0;
    } else {
      tn = -(cs / tb);
      cs1 = 1 / MathSqrt(1 + tn * tn);
      sn1 = tn * cs1;
    }
  }

  if (sgn1 == sgn2) {
    tn = cs1;
    cs1 = -sn1;
    sn1 = tn;
  }
}

static double CEigenVDetect::TdEVDPythag(const double a, const double b) {

  double result = 0;

  if (MathAbs(a) < MathAbs(b))
    result = MathAbs(b) * MathSqrt(1 + CMath::Sqr(a / b));
  else
    result = MathAbs(a) * MathSqrt(1 + CMath::Sqr(b / a));

  return (result);
}

static double CEigenVDetect::TdEVDExtSign(const double a, const double b) {

  double result = 0;

  if (b >= 0.0)
    result = MathAbs(a);
  else
    result = -MathAbs(a);

  return (result);
}

static bool CEigenVDetect::InternalBisectionEigenValues(
    double &cd[], double &ce[], const int n, int irange, const int iorder,
    const double vl, const double vu, const int il, const int iu,
    const double abstol, double &w[], int &m, int &nsplit, int &iblock[],
    int &isplit[], int &errorcode) {

  bool result;
  double fudge = 0;
  double relfac = 0;
  bool ncnvrg;
  bool toofew;
  int ib = 0;
  int ibegin = 0;
  int idiscl = 0;
  int idiscu = 0;
  int ie = 0;
  int iend = 0;
  int iinfo = 0;
  int im = 0;
  int iin = 0;
  int ioff = 0;
  int iout = 0;
  int itmax = 0;
  int iw = 0;
  int iwoff = 0;
  int j = 0;
  int itmp1 = 0;
  int jb = 0;
  int jdisc = 0;
  int je = 0;
  int nwl = 0;
  int nwu = 0;
  int tmpi = 0;
  double atoli = 0;
  double bnorm = 0;
  double gl = 0;
  double gu = 0;
  double pivmin = 0;
  double rtoli = 0;
  double safemn = 0;
  double tmp1 = 0;
  double tmp2 = 0;
  double tnorm = 0;
  double ulp = 0;
  double wkill = 0;
  double wl = 0;
  double wlu = 0;
  double wu = 0;
  double wul = 0;
  double scalefactor = 0;
  double t = 0;

  int idumma[];
  double work[];
  int iwork[];
  int ia1s2[];
  double ra1s2[];
  double ra1siin[];
  double ra2siin[];
  double ra3siin[];
  double ra4siin[];
  int iworkspace[];
  double rworkspace[];

  CMatrixDouble ra1s2x2;
  CMatrixInt ia1s2x2;
  CMatrixDouble ra1siinx2;
  CMatrixInt ia1siinx2;

  double d[];
  ArrayResizeAL(d, ArraySize(cd));
  ArrayCopy(d, cd);

  double e[];
  ArrayResizeAL(e, ArraySize(ce));
  ArrayCopy(e, ce);

  m = 0;
  nsplit = 0;
  errorcode = 0;

  if (n == 0)
    return (true);

  fudge = 2;
  relfac = 2;
  safemn = CMath::m_minrealnumber;
  ulp = 2 * CMath::m_machineepsilon;
  rtoli = ulp * relfac;

  ArrayResizeAL(idumma, 2);
  ArrayResizeAL(work, 4 * n + 1);
  ArrayResizeAL(iwork, 3 * n + 1);
  ArrayResizeAL(w, n + 1);
  ArrayResizeAL(iblock, n + 1);
  ArrayResizeAL(isplit, n + 1);
  ArrayResizeAL(ia1s2, 3);
  ArrayResizeAL(ra1s2, 3);
  ArrayResizeAL(ra1siin, n + 1);
  ArrayResizeAL(ra2siin, n + 1);
  ArrayResizeAL(ra3siin, n + 1);
  ArrayResizeAL(ra4siin, n + 1);
  ArrayResizeAL(iworkspace, n + 1);
  ArrayResizeAL(rworkspace, n + 1);
  ra1siinx2.Resize(n + 1, 3);
  ia1siinx2.Resize(n + 1, 3);
  ra1s2x2.Resize(3, 3);
  ia1s2x2.Resize(3, 3);

  wlu = 0;
  wul = 0;

  result = false;
  errorcode = 0;

  if (irange <= 0 || irange >= 4)
    errorcode = -4;

  if (iorder <= 0 || iorder >= 3)
    errorcode = -5;

  if (n < 0)
    errorcode = -3;

  if (irange == 2 && vl >= vu)
    errorcode = -6;

  if (irange == 3 && (il < 1 || il > MathMax(1, n)))
    errorcode = -8;

  if (irange == 3 && (iu < MathMin(n, il) || iu > n))
    errorcode = -9;

  if (errorcode != 0)
    return (result);

  ncnvrg = false;
  toofew = false;

  if (irange == 3 && il == 1 && iu == n)
    irange = 1;

  if (n == 1) {
    nsplit = 1;
    isplit[1] = 1;

    if ((irange == 2 && vl >= d[1]) || vu < d[1])
      m = 0;
    else {
      w[1] = d[1];
      iblock[1] = 1;
      m = 1;
    }

    return (true);
  }

  t = MathAbs(d[n]);
  for (j = 1; j < n; j++) {
    t = MathMax(t, MathAbs(d[j]));
    t = MathMax(t, MathAbs(e[j]));
  }
  scalefactor = 1;

  if (t != 0.0) {

    if (t > MathSqrt(MathSqrt(CMath::m_minrealnumber)) *
                MathSqrt(CMath::m_maxrealnumber))
      scalefactor = t;

    if (t < MathSqrt(MathSqrt(CMath::m_maxrealnumber)) *
                MathSqrt(CMath::m_minrealnumber))
      scalefactor = t;
    for (j = 1; j < n; j++) {
      d[j] = d[j] / scalefactor;
      e[j] = e[j] / scalefactor;
    }
    d[n] = d[n] / scalefactor;
  }

  nsplit = 1;
  work[n] = 0;
  pivmin = 1;
  for (j = 2; j <= n; j++) {
    tmp1 = CMath::Sqr(e[j - 1]);

    if (MathAbs(d[j] * d[j - 1]) * CMath::Sqr(ulp) + safemn > tmp1) {
      isplit[nsplit] = j - 1;
      nsplit = nsplit + 1;
      work[j - 1] = 0;
    } else {
      work[j - 1] = tmp1;
      pivmin = MathMax(pivmin, tmp1);
    }
  }
  isplit[nsplit] = n;
  pivmin = pivmin * safemn;

  if (irange == 3) {

    gu = d[1];
    gl = d[1];
    tmp1 = 0;
    for (j = 1; j < n; j++) {

      tmp2 = MathSqrt(work[j]);
      gu = MathMax(gu, d[j] + tmp1 + tmp2);
      gl = MathMin(gl, d[j] - tmp1 - tmp2);
      tmp1 = tmp2;
    }

    gu = MathMax(gu, d[n] + tmp1);
    gl = MathMin(gl, d[n] - tmp1);
    tnorm = MathMax(MathAbs(gl), MathAbs(gu));
    gl = gl - fudge * tnorm * ulp * n - fudge * 2 * pivmin;
    gu = gu + fudge * tnorm * ulp * n + fudge * pivmin;

    itmax = (int)MathCeil((MathLog(tnorm + pivmin) - MathLog(pivmin)) /
                          MathLog(2)) +
            2;

    if (abstol <= 0.0)
      atoli = ulp * tnorm;
    else
      atoli = abstol;

    work[n + 1] = gl;
    work[n + 2] = gl;
    work[n + 3] = gu;
    work[n + 4] = gu;
    work[n + 5] = gl;
    work[n + 6] = gu;
    iwork[1] = -1;
    iwork[2] = -1;
    iwork[3] = n + 1;
    iwork[4] = n + 1;
    iwork[5] = il - 1;
    iwork[6] = iu;

    ia1s2[1] = iwork[5];
    ia1s2[2] = iwork[6];
    ra1s2[1] = work[n + 5];
    ra1s2[2] = work[n + 6];
    ra1s2x2[1].Set(1, work[n + 1]);
    ra1s2x2[2].Set(1, work[n + 2]);
    ra1s2x2[1].Set(2, work[n + 3]);
    ra1s2x2[2].Set(2, work[n + 4]);
    ia1s2x2[1].Set(1, iwork[1]);
    ia1s2x2[2].Set(1, iwork[2]);
    ia1s2x2[1].Set(2, iwork[3]);
    ia1s2x2[2].Set(2, iwork[4]);

    InternalDLAEBZ(3, itmax, n, 2, 2, atoli, rtoli, pivmin, d, e, work, ia1s2,
                   ra1s2x2, ra1s2, iout, ia1s2x2, w, iblock, iinfo);
    iwork[5] = ia1s2[1];
    iwork[6] = ia1s2[2];
    work[n + 5] = ra1s2[1];
    work[n + 6] = ra1s2[2];
    work[n + 1] = ra1s2x2[1][1];
    work[n + 2] = ra1s2x2[2][1];
    work[n + 3] = ra1s2x2[1][2];
    work[n + 4] = ra1s2x2[2][2];
    iwork[1] = ia1s2x2[1][1];
    iwork[2] = ia1s2x2[2][1];
    iwork[3] = ia1s2x2[1][2];
    iwork[4] = ia1s2x2[2][2];

    if (iwork[6] == iu) {

      wl = work[n + 1];
      wlu = work[n + 3];
      nwl = iwork[1];
      wu = work[n + 4];
      wul = work[n + 2];
      nwu = iwork[4];
    } else {

      wl = work[n + 2];
      wlu = work[n + 4];
      nwl = iwork[2];
      wu = work[n + 3];
      wul = work[n + 1];
      nwu = iwork[3];
    }

    if (nwl < 0 || nwl >= n || nwu < 1 || nwu > n) {
      errorcode = 4;
      return (false);
    }
  } else {

    tnorm = MathMax(MathAbs(d[1]) + MathAbs(e[1]),
                    MathAbs(d[n]) + MathAbs(e[n - 1]));
    for (j = 2; j < n; j++)
      tnorm = MathMax(tnorm, MathAbs(d[j]) + MathAbs(e[j - 1]) + MathAbs(e[j]));

    if (abstol <= 0.0)
      atoli = ulp * tnorm;
    else
      atoli = abstol;

    if (irange == 2) {
      wl = vl;
      wu = vu;
    } else {
      wl = 0;
      wu = 0;
    }
  }

  m = 0;
  iend = 0;
  errorcode = 0;
  nwl = 0;
  nwu = 0;
  for (jb = 1; jb <= nsplit; jb++) {
    ioff = iend;
    ibegin = ioff + 1;
    iend = isplit[jb];
    iin = iend - ioff;

    if (iin == 1) {

      if (irange == 1 || wl >= d[ibegin] - pivmin)
        nwl = nwl + 1;

      if (irange == 1 || wu >= d[ibegin] - pivmin)
        nwu = nwu + 1;

      if ((irange == 1 || wl < d[ibegin] - pivmin) &&
          wu >= d[ibegin] - pivmin) {
        m = m + 1;
        w[m] = d[ibegin];
        iblock[m] = jb;
      }
    } else {

      gu = d[ibegin];
      gl = d[ibegin];
      tmp1 = 0;
      for (j = ibegin; j <= iend - 1; j++) {

        tmp2 = MathAbs(e[j]);
        gu = MathMax(gu, d[j] + tmp1 + tmp2);
        gl = MathMin(gl, d[j] - tmp1 - tmp2);
        tmp1 = tmp2;
      }

      gu = MathMax(gu, d[iend] + tmp1);
      gl = MathMin(gl, d[iend] - tmp1);
      bnorm = MathMax(MathAbs(gl), MathAbs(gu));
      gl = gl - fudge * bnorm * ulp * iin - fudge * pivmin;
      gu = gu + fudge * bnorm * ulp * iin + fudge * pivmin;

      if (abstol <= 0.0)
        atoli = ulp * MathMax(MathAbs(gl), MathAbs(gu));
      else
        atoli = abstol;

      if (irange > 1) {

        if (gu < wl) {
          nwl = nwl + iin;
          nwu = nwu + iin;
          continue;
        }
        gl = MathMax(gl, wl);
        gu = MathMin(gu, wu);

        if (gl >= gu)
          continue;
      }

      work[n + 1] = gl;
      work[n + iin + 1] = gu;

      for (tmpi = 1; tmpi <= iin; tmpi++) {
        ra1siin[tmpi] = d[ibegin - 1 + tmpi];

        if (ibegin - 1 + tmpi < n)
          ra2siin[tmpi] = e[ibegin - 1 + tmpi];

        ra3siin[tmpi] = work[ibegin - 1 + tmpi];
        ra1siinx2[tmpi].Set(1, work[n + tmpi]);
        ra1siinx2[tmpi].Set(2, work[n + tmpi + iin]);
        ra4siin[tmpi] = work[n + 2 * iin + tmpi];
        rworkspace[tmpi] = w[m + tmpi];
        iworkspace[tmpi] = iblock[m + tmpi];
        ia1siinx2[tmpi].Set(1, iwork[tmpi]);
        ia1siinx2[tmpi].Set(2, iwork[tmpi + iin]);
      }

      InternalDLAEBZ(1, 0, iin, iin, 1, atoli, rtoli, pivmin, ra1siin, ra2siin,
                     ra3siin, idumma, ra1siinx2, ra4siin, im, ia1siinx2,
                     rworkspace, iworkspace, iinfo);
      for (tmpi = 1; tmpi <= iin; tmpi++) {

        work[n + tmpi] = ra1siinx2[tmpi][1];
        work[n + tmpi + iin] = ra1siinx2[tmpi][2];
        work[n + 2 * iin + tmpi] = ra4siin[tmpi];
        w[m + tmpi] = rworkspace[tmpi];
        iblock[m + tmpi] = iworkspace[tmpi];
        iwork[tmpi] = ia1siinx2[tmpi][1];
        iwork[tmpi + iin] = ia1siinx2[tmpi][2];
      }
      nwl = nwl + iwork[1];
      nwu = nwu + iwork[iin + 1];
      iwoff = m - iwork[1];

      itmax = (int)MathCeil((MathLog(gu - gl + pivmin) - MathLog(pivmin)) /
                            MathLog(2)) +
              2;

      for (tmpi = 1; tmpi <= iin; tmpi++) {
        ra1siin[tmpi] = d[ibegin - 1 + tmpi];

        if (ibegin - 1 + tmpi < n)
          ra2siin[tmpi] = e[ibegin - 1 + tmpi];

        ra3siin[tmpi] = work[ibegin - 1 + tmpi];
        ra1siinx2[tmpi].Set(1, work[n + tmpi]);
        ra1siinx2[tmpi].Set(2, work[n + tmpi + iin]);
        ra4siin[tmpi] = work[n + 2 * iin + tmpi];
        rworkspace[tmpi] = w[m + tmpi];
        iworkspace[tmpi] = iblock[m + tmpi];
        ia1siinx2[tmpi].Set(1, iwork[tmpi]);
        ia1siinx2[tmpi].Set(2, iwork[tmpi + iin]);
      }

      InternalDLAEBZ(2, itmax, iin, iin, 1, atoli, rtoli, pivmin, ra1siin,
                     ra2siin, ra3siin, idumma, ra1siinx2, ra4siin, iout,
                     ia1siinx2, rworkspace, iworkspace, iinfo);
      for (tmpi = 1; tmpi <= iin; tmpi++) {

        work[n + tmpi] = ra1siinx2[tmpi][1];
        work[n + tmpi + iin] = ra1siinx2[tmpi][2];
        work[n + 2 * iin + tmpi] = ra4siin[tmpi];
        w[m + tmpi] = rworkspace[tmpi];
        iblock[m + tmpi] = iworkspace[tmpi];
        iwork[tmpi] = ia1siinx2[tmpi][1];
        iwork[tmpi + iin] = ia1siinx2[tmpi][2];
      }

      for (j = 1; j <= iout; j++) {
        tmp1 = 0.5 * (work[j + n] + work[j + iin + n]);

        if (j > iout - iinfo) {
          ncnvrg = true;
          ib = -jb;
        } else
          ib = jb;
        for (je = iwork[j] + 1 + iwoff; je <= iwork[j + iin] + iwoff; je++) {
          w[je] = tmp1;
          iblock[je] = ib;
        }
      }
      m = m + im;
    }
  }

  if (irange == 3) {
    im = 0;
    idiscl = il - 1 - nwl;
    idiscu = nwu - iu;

    if (idiscl > 0 || idiscu > 0) {
      for (je = 1; je <= m; je++) {

        if (w[je] <= wlu && idiscl > 0) {
          idiscl = idiscl - 1;
        } else {

          if (w[je] >= wul && idiscu > 0)
            idiscu = idiscu - 1;
          else {
            im = im + 1;
            w[im] = w[je];
            iblock[im] = iblock[je];
          }
        }
      }
      m = im;
    }

    if (idiscl > 0 || idiscu > 0) {

      if (idiscl > 0) {
        wkill = wu;
        for (jdisc = 1; jdisc <= idiscl; jdisc++) {
          iw = 0;
          for (je = 1; je <= m; je++) {

            if (iblock[je] != 0 && (w[je] < (double)(wkill) || iw == 0)) {
              iw = je;
              wkill = w[je];
            }
          }
          iblock[iw] = 0;
        }
      }

      if (idiscu > 0) {
        wkill = wl;
        for (jdisc = 1; jdisc <= idiscu; jdisc++) {
          iw = 0;
          for (je = 1; je <= m; je++) {

            if (iblock[je] != 0 && (w[je] > (double)(wkill) || iw == 0)) {
              iw = je;
              wkill = w[je];
            }
          }
          iblock[iw] = 0;
        }
      }
      im = 0;
      for (je = 1; je <= m; je++) {

        if (iblock[je] != 0) {
          im = im + 1;
          w[im] = w[je];
          iblock[im] = iblock[je];
        }
      }
      m = im;
    }

    if (idiscl < 0 || idiscu < 0)
      toofew = true;
  }

  if (iorder == 1 && nsplit > 1) {
    for (je = 1; je <= m - 1; je++) {
      ie = 0;
      tmp1 = w[je];
      for (j = je + 1; j <= m; j++) {

        if (w[j] < tmp1) {
          ie = j;
          tmp1 = w[j];
        }
      }

      if (ie != 0) {

        itmp1 = iblock[ie];
        w[ie] = w[je];
        iblock[ie] = iblock[je];
        w[je] = tmp1;
        iblock[je] = itmp1;
      }
    }
  }
  for (j = 1; j <= m; j++)
    w[j] = w[j] * scalefactor;
  errorcode = 0;

  if (ncnvrg)
    errorcode = errorcode + 1;

  if (toofew)
    errorcode = errorcode + 2;
  result = errorcode == 0;

  return (result);
}

static void CEigenVDetect::InternalDStein(const int n, double &d[],
                                          double &ce[], const int m,
                                          double &cw[], int &iblock[],
                                          int &isplit[], CMatrixDouble &z,
                                          int &ifail[], int &info) {

  int maxits = 0;
  int extra = 0;
  int b1 = 0;
  int blksiz = 0;
  int bn = 0;
  int gpind = 0;
  int i = 0;
  int iinfo = 0;
  int its = 0;
  int j = 0;
  int j1 = 0;
  int jblk = 0;
  int jmax = 0;
  int nblk = 0;
  int nrmchk = 0;
  double dtpcrt = 0;
  double eps = 0;
  double eps1 = 0;
  double nrm = 0;
  double onenrm = 0;
  double ortol = 0;
  double pertol = 0;
  double scl = 0;
  double sep = 0;
  double tol = 0;
  double xj = 0;
  double xjm = 0;
  double ztr = 0;
  bool tmpcriterion;
  int ti = 0;
  int i1 = 0;
  int i2 = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  double work1[];
  double work2[];
  double work3[];
  double work4[];
  double work5[];
  int iwork[];

  double e[];
  ArrayResizeAL(e, ArraySize(ce));
  ArrayCopy(e, ce);

  double w[];
  ArrayResizeAL(w, ArraySize(cw));
  ArrayCopy(w, cw);

  info = 0;
  maxits = 5;
  extra = 2;

  ArrayResizeAL(work1, (int)MathMax(n, 1) + 1);
  ArrayResizeAL(work2, (int)MathMax(n - 1, 1) + 1);
  ArrayResizeAL(work3, (int)MathMax(n, 1) + 1);
  ArrayResizeAL(work4, (int)MathMax(n, 1) + 1);
  ArrayResizeAL(work5, (int)MathMax(n, 1) + 1);
  ArrayResizeAL(iwork, (int)MathMax(n, 1) + 1);
  ArrayResizeAL(ifail, (int)MathMax(m, 1) + 1);
  z.Resize((int)MathMax(n, 1) + 1, (int)MathMax(m, 1) + 1);

  gpind = 0;
  onenrm = 0;
  ortol = 0;
  dtpcrt = 0;
  xjm = 0;

  info = 0;
  for (i = 1; i <= m; i++)
    ifail[i] = 0;

  if (n < 0) {
    info = -1;
    return;
  }

  if (m < 0 || m > n) {
    info = -4;
    return;
  }
  for (j = 2; j <= m; j++) {

    if (iblock[j] < iblock[j - 1]) {
      info = -6;

      break;
    }

    if (iblock[j] == iblock[j - 1] && w[j] < w[j - 1]) {
      info = -5;

      break;
    }
  }

  if (info != 0)
    return;

  if (n == 0 || m == 0)
    return;

  if (n == 1) {
    z[1].Set(1, 1);
    return;
  }

  ti = n - 1;
  for (i_ = 1; i_ <= ti; i_++)
    work1[i_] = e[i_];
  ArrayResizeAL(e, n + 1);
  for (i_ = 1; i_ <= ti; i_++)
    e[i_] = work1[i_];
  for (i_ = 1; i_ <= m; i_++)
    work1[i_] = w[i_];
  ArrayResizeAL(w, n + 1);
  for (i_ = 1; i_ <= m; i_++)
    w[i_] = work1[i_];

  eps = CMath::m_machineepsilon;

  j1 = 1;
  for (nblk = 1; nblk <= iblock[m]; nblk++) {

    if (nblk == 1)
      b1 = 1;
    else
      b1 = isplit[nblk - 1] + 1;
    bn = isplit[nblk];
    blksiz = bn - b1 + 1;

    if (blksiz != 1) {

      gpind = b1;
      onenrm = MathAbs(d[b1]) + MathAbs(e[b1]);
      onenrm = MathMax(onenrm, MathAbs(d[bn]) + MathAbs(e[bn - 1]));
      for (i = b1 + 1; i <= bn - 1; i++)
        onenrm =
            MathMax(onenrm, MathAbs(d[i]) + MathAbs(e[i - 1]) + MathAbs(e[i]));
      ortol = 0.001 * onenrm;
      dtpcrt = MathSqrt(0.1 / blksiz);
    }

    jblk = 0;
    for (j = j1; j <= m; j++) {

      if (iblock[j] != nblk) {
        j1 = j;

        break;
      }
      jblk = jblk + 1;
      xj = w[j];

      if (blksiz == 1) {

        work1[1] = 1;
      } else {

        if (jblk > 1) {
          eps1 = MathAbs(eps * xj);
          pertol = 10 * eps1;
          sep = xj - xjm;

          if (sep < pertol)
            xj = xjm + pertol;
        }
        its = 0;
        nrmchk = 0;

        for (ti = 1; ti <= blksiz; ti++)
          work1[ti] = 2 * CMath::RandomReal() - 1;

        for (ti = 1; ti <= blksiz - 1; ti++) {
          work2[ti] = e[b1 + ti - 1];
          work3[ti] = e[b1 + ti - 1];
          work4[ti] = d[b1 + ti - 1];
        }
        work4[blksiz] = d[b1 + blksiz - 1];

        tol = 0;
        TdIninternalDLAGTF(blksiz, work4, xj, work2, work3, tol, work5, iwork,
                           iinfo);

        do {
          its = its + 1;

          if (its > maxits) {

            info = info + 1;
            ifail[info] = j;
            break;
          }

          v = 0;
          for (ti = 1; ti <= blksiz; ti++)
            v = v + MathAbs(work1[ti]);
          scl = blksiz * onenrm * MathMax(eps, MathAbs(work4[blksiz])) / v;
          for (i_ = 1; i_ <= blksiz; i_++)
            work1[i_] = scl * work1[i_];

          TdIninternalDLAGTS(blksiz, work4, work2, work3, work5, iwork, work1,
                             tol, iinfo);

          if (jblk != 1) {

            if (MathAbs(xj - xjm) > ortol)
              gpind = j;

            if (gpind != j) {
              for (i = gpind; i < j; i++) {
                i1 = b1;
                i2 = b1 + blksiz - 1;
                i1_ = i1 - 1;
                ztr = 0.0;
                for (i_ = 1; i_ <= blksiz; i_++)
                  ztr += work1[i_] * z[i_ + i1_][i];
                i1_ = i1 - 1;
                for (i_ = 1; i_ <= blksiz; i_++)
                  work1[i_] = work1[i_] - ztr * z[i_ + i1_][i];
              }
            }
          }

          jmax = CBlas::VectorIdxAbsMax(work1, 1, blksiz);
          nrm = MathAbs(work1[jmax]);

          tmpcriterion = false;

          if (nrm < dtpcrt)
            tmpcriterion = true;
          else {
            nrmchk = nrmchk + 1;

            if (nrmchk < extra + 1)
              tmpcriterion = true;
          }
        } while (tmpcriterion);

        scl = 1 / CBlas::VectorNorm2(work1, 1, blksiz);
        jmax = CBlas::VectorIdxAbsMax(work1, 1, blksiz);

        if (work1[jmax] < 0.0)
          scl = -scl;
        for (i_ = 1; i_ <= blksiz; i_++)
          work1[i_] = scl * work1[i_];
      }
      for (i = 1; i <= n; i++)
        z[i].Set(j, 0);
      for (i = 1; i <= blksiz; i++)
        z[b1 + i - 1].Set(j, work1[i]);

      xjm = xj;
    }
  }
}

static void CEigenVDetect::TdIninternalDLAGTF(const int n, double &a[],
                                              const double lambdav, double &b[],
                                              double &c[], double tol,
                                              double &d[], int &iin[],
                                              int &info) {

  int k = 0;
  double eps = 0;
  double mult = 0;
  double piv1 = 0;
  double piv2 = 0;
  double scale1 = 0;
  double scale2 = 0;
  double temp = 0;
  double tl = 0;

  info = 0;

  if (n < 0) {
    info = -1;
    return;
  }

  if (n == 0)
    return;
  a[1] = a[1] - lambdav;
  iin[n] = 0;

  if (n == 1) {

    if (a[1] == 0.0)
      iin[1] = 1;

    return;
  }

  eps = CMath::m_machineepsilon;
  tl = MathMax(tol, eps);
  scale1 = MathAbs(a[1]) + MathAbs(b[1]);
  for (k = 1; k < n; k++) {
    a[k + 1] = a[k + 1] - lambdav;
    scale2 = MathAbs(c[k]) + MathAbs(a[k + 1]);

    if (k < n - 1)
      scale2 = scale2 + MathAbs(b[k + 1]);

    if (a[k] == 0.0)
      piv1 = 0;
    else
      piv1 = MathAbs(a[k]) / scale1;

    if (c[k] == 0.0) {
      iin[k] = 0;
      piv2 = 0;
      scale1 = scale2;

      if (k < n - 1)
        d[k] = 0;
    } else {
      piv2 = MathAbs(c[k]) / scale2;

      if (piv2 <= piv1) {

        iin[k] = 0;
        scale1 = scale2;
        c[k] = c[k] / a[k];
        a[k + 1] = a[k + 1] - c[k] * b[k];

        if (k < n - 1)
          d[k] = 0;
      } else {

        iin[k] = 1;
        mult = a[k] / c[k];
        a[k] = c[k];
        temp = a[k + 1];
        a[k + 1] = b[k] - mult * temp;
        if (k < n - 1) {
          d[k] = b[k + 1];
          b[k + 1] = -(mult * d[k]);
        }
        b[k] = temp;
        c[k] = mult;
      }
    }

    if (MathMax(piv1, piv2) <= tl && iin[n] == 0)
      iin[n] = k;
  }

  if (MathAbs(a[n]) <= scale1 * tl && iin[n] == 0)
    iin[n] = n;
}

static void CEigenVDetect::TdIninternalDLAGTS(const int n, double &a[],
                                              double &b[], double &c[],
                                              double &d[], int &iin[],
                                              double &y[], double &tol,
                                              int &info) {

  int k = 0;
  double absak = 0;
  double ak = 0;
  double bignum = 0;
  double eps = 0;
  double pert = 0;
  double sfmin = 0;
  double temp = 0;

  info = 0;

  if (n < 0) {
    info = -1;
    return;
  }

  if (n == 0)
    return;

  eps = CMath::m_machineepsilon;
  sfmin = CMath::m_minrealnumber;
  bignum = 1 / sfmin;

  if (tol <= 0.0) {
    tol = MathAbs(a[1]);

    if (n > 1)
      tol = MathMax(tol, MathMax(MathAbs(a[2]), MathAbs(b[1])));
    for (k = 3; k <= n; k++)
      tol = MathMax(tol, MathMax(MathAbs(a[k]), MathMax(MathAbs(b[k - 1]),
                                                        MathAbs(d[k - 2]))));
    tol = tol * eps;

    if (tol == 0.0)
      tol = eps;
  }
  for (k = 2; k <= n; k++) {

    if (iin[k - 1] == 0)
      y[k] = y[k] - c[k - 1] * y[k - 1];
    else {
      temp = y[k - 1];
      y[k - 1] = y[k];
      y[k] = temp - c[k - 1] * y[k];
    }
  }
  for (k = n; k >= 1; k--) {

    if (k <= n - 2)
      temp = y[k] - b[k] * y[k + 1] - d[k] * y[k + 2];
    else {

      if (k == n - 1)
        temp = y[k] - b[k] * y[k + 1];
      else
        temp = y[k];
    }
    ak = a[k];
    pert = MathAbs(tol);

    if (ak < 0.0)
      pert = -pert;
    while (true) {
      absak = MathAbs(ak);

      if (absak < 1.0) {

        if (absak < sfmin) {

          if (absak == 0.0 || MathAbs(temp) * sfmin > absak) {
            ak = ak + pert;
            pert = 2 * pert;
            continue;
          } else {
            temp = temp * bignum;
            ak = ak * bignum;
          }
        } else {

          if (MathAbs(temp) > absak * bignum) {
            ak = ak + pert;
            pert = 2 * pert;
            continue;
          }
        }
      }

      break;
    }
    y[k] = temp / ak;
  }
}

static void CEigenVDetect::InternalDLAEBZ(
    const int ijob, const int nitmax, const int n, const int mmax,
    const int minp, const double abstol, const double reltol,
    const double pivmin, double &d[], double &e[], double &e2[], int &nval[],
    CMatrixDouble &ab, double &c[], int &mout, CMatrixInt &nab, double &work[],
    int &iwork[], int &info) {

  int itmp1 = 0;
  int itmp2 = 0;
  int j = 0;
  int ji = 0;
  int jit = 0;
  int jp = 0;
  int kf = 0;
  int kfnew = 0;
  int kl = 0;
  int klnew = 0;
  double tmp1 = 0;
  double tmp2 = 0;

  mout = 0;
  info = 0;

  if (ijob < 1 || ijob > 3) {
    info = -1;

    return;
  }

  if (ijob == 1) {

    mout = 0;

    for (ji = 1; ji <= minp; ji++) {
      for (jp = 1; jp <= 2; jp++) {
        tmp1 = d[1] - ab[ji][jp];

        if (MathAbs(tmp1) < pivmin)
          tmp1 = -pivmin;
        nab[ji].Set(jp, 0);

        if (tmp1 <= 0.0)
          nab[ji].Set(jp, 1);
        for (j = 2; j <= n; j++) {
          tmp1 = d[j] - e2[j - 1] / tmp1 - ab[ji][jp];

          if (MathAbs(tmp1) < pivmin)
            tmp1 = -pivmin;

          if (tmp1 <= 0.0)
            nab[ji].Set(jp, nab[ji][jp] + 1);
        }
      }
      mout = mout + nab[ji][2] - nab[ji][1];
    }

    return;
  }

  kf = 1;
  kl = minp;

  if (ijob == 2) {
    for (ji = 1; ji <= minp; ji++)
      c[ji] = 0.5 * (ab[ji][1] + ab[ji][2]);
  }

  for (jit = 1; jit <= nitmax; jit++) {

    klnew = kl;
    for (ji = kf; ji <= kl; ji++) {

      tmp1 = c[ji];
      tmp2 = d[1] - tmp1;
      itmp1 = 0;

      if (tmp2 <= pivmin) {
        itmp1 = 1;
        tmp2 = MathMin(tmp2, -pivmin);
      }

      for (j = 2; j <= n; j++) {
        tmp2 = d[j] - e2[j - 1] / tmp2 - tmp1;

        if (tmp2 <= pivmin) {
          itmp1 = itmp1 + 1;
          tmp2 = MathMin(tmp2, -pivmin);
        }
      }

      if (ijob <= 2) {

        itmp1 = MathMin(nab[ji][2], MathMax(nab[ji][1], itmp1));

        if (itmp1 == nab[ji][2]) {

          ab[ji].Set(2, tmp1);
        } else {

          if (itmp1 == nab[ji][1]) {

            ab[ji].Set(1, tmp1);
          } else {

            if (klnew < mmax) {

              klnew = klnew + 1;
              ab[klnew].Set(2, ab[ji][2]);
              nab[klnew].Set(2, nab[ji][2]);
              ab[klnew].Set(1, tmp1);
              nab[klnew].Set(1, itmp1);
              ab[ji].Set(2, tmp1);
              nab[ji].Set(2, itmp1);
            } else {
              info = mmax + 1;

              return;
            }
          }
        }
      } else {

        if (itmp1 <= nval[ji]) {
          ab[ji].Set(1, tmp1);
          nab[ji].Set(1, itmp1);
        }

        if (itmp1 >= nval[ji]) {
          ab[ji].Set(2, tmp1);
          nab[ji].Set(2, itmp1);
        }
      }
    }
    kl = klnew;

    kfnew = kf;
    for (ji = kf; ji <= kl; ji++) {
      tmp1 = MathAbs(ab[ji][2] - ab[ji][1]);
      tmp2 = MathMax(MathAbs(ab[ji][2]), MathAbs(ab[ji][1]));

      if (tmp1 < (double)(MathMax(abstol, MathMax(pivmin, reltol * tmp2))) ||
          nab[ji][1] >= nab[ji][2]) {

        if (ji > kfnew) {
          tmp1 = ab[ji][1];
          tmp2 = ab[ji][2];
          itmp1 = nab[ji][1];
          itmp2 = nab[ji][2];

          ab[ji].Set(1, ab[kfnew][1]);
          ab[ji].Set(2, ab[kfnew][2]);
          nab[ji].Set(1, nab[kfnew][1]);
          nab[ji].Set(2, nab[kfnew][2]);
          ab[kfnew].Set(1, tmp1);
          ab[kfnew].Set(2, tmp2);
          nab[kfnew].Set(1, itmp1);
          nab[kfnew].Set(2, itmp2);

          if (ijob == 3) {
            itmp1 = nval[ji];
            nval[ji] = nval[kfnew];
            nval[kfnew] = itmp1;
          }
        }
        kfnew = kfnew + 1;
      }
    }
    kf = kfnew;

    for (ji = kf; ji <= kl; ji++)
      c[ji] = 0.5 * (ab[ji][1] + ab[ji][2]);

    if (kf > kl)
      break;
  }

  info = (int)MathMax(kl + 1 - kf, 0);
  mout = kl;
}

static void CEigenVDetect::InternalTREVC(CMatrixDouble &t, const int n,
                                         const int side, const int howmny,
                                         bool &cvselect[], CMatrixDouble &vl,
                                         CMatrixDouble &vr, int &m, int &info) {

  bool allv;
  bool bothv;
  bool leftv;
  bool over;
  bool pair;
  bool rightv;
  bool somev;
  int i = 0;
  int ierr = 0;
  int ii = 0;
  int ip = 0;
  int iis = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;
  int jnxt = 0;
  int k = 0;
  int ki = 0;
  int n2 = 0;
  double beta = 0;
  double bignum = 0;
  double emax = 0;
  double ovfl = 0;
  double rec = 0;
  double remax = 0;
  double scl = 0;
  double smin = 0;
  double smlnum = 0;
  double ulp = 0;
  double unfl = 0;
  double vcrit = 0;
  double vmax = 0;
  double wi = 0;
  double wr = 0;
  double xnorm = 0;
  bool skipflag;
  int k1 = 0;
  int k2 = 0;
  int k3 = 0;
  int k4 = 0;
  double vt = 0;
  int i_ = 0;
  int i1_ = 0;

  double work[];
  double temp[];
  bool rswap4[];
  bool zswap4[];
  double civ4[];
  double crv4[];

  CMatrixDouble x;
  CMatrixDouble temp11;
  CMatrixDouble temp22;
  CMatrixDouble temp11b;
  CMatrixDouble temp21b;
  CMatrixDouble temp12b;
  CMatrixDouble temp22b;
  CMatrixInt ipivot44;

  bool vselect[];
  ArrayResizeAL(vselect, ArraySize(cvselect));
  ArrayCopy(vselect, cvselect);

  m = 0;
  info = 0;

  x.Resize(3, 3);
  temp11.Resize(2, 2);
  temp11b.Resize(2, 2);
  temp21b.Resize(3, 2);
  temp12b.Resize(2, 3);
  temp22b.Resize(3, 3);
  temp22.Resize(3, 3);
  ArrayResizeAL(work, 3 * n + 1);
  ArrayResizeAL(temp, n + 1);
  ArrayResizeAL(rswap4, 5);
  ArrayResizeAL(zswap4, 5);
  ArrayResizeAL(civ4, 5);
  ArrayResizeAL(crv4, 5);
  ipivot44.Resize(5, 5);

  if (howmny != 1) {

    if (side == 1 || side == 3)
      vr.Resize(n + 1, n + 1);

    if (side == 2 || side == 3)
      vl.Resize(n + 1, n + 1);
  }

  bothv = side == 3;
  rightv = side == 1 || bothv;
  leftv = side == 2 || bothv;
  allv = howmny == 2;
  over = howmny == 1;
  somev = howmny == 3;
  info = 0;

  if (n < 0) {
    info = -2;
    return;
  }

  if (!rightv && !leftv) {
    info = -3;
    return;
  }

  if ((!allv && !over) && !somev) {
    info = -4;
    return;
  }

  if (somev) {
    m = 0;
    pair = false;
    for (j = 1; j <= n; j++) {

      if (pair) {
        pair = false;
        vselect[j] = false;
      } else {

        if (j < n) {

          if (t[j + 1][j] == 0.0) {

            if (vselect[j])
              m = m + 1;
          } else {
            pair = true;

            if (vselect[j] || vselect[j + 1]) {
              vselect[j] = true;
              m = m + 2;
            }
          }
        } else {

          if (vselect[n])
            m = m + 1;
        }
      }
    }
  } else
    m = n;

  if (n == 0)
    return;

  unfl = CMath::m_minrealnumber;
  ovfl = 1 / unfl;
  ulp = CMath::m_machineepsilon;
  smlnum = unfl * (n / ulp);
  bignum = (1 - ulp) / smlnum;

  work[1] = 0;
  for (j = 2; j <= n; j++) {
    work[j] = 0;
    for (i = 1; i < j; i++)
      work[j] = work[j] + MathAbs(t[i][j]);
  }

  n2 = 2 * n;

  if (rightv) {

    ip = 0;
    iis = m;
    for (ki = n; ki >= 1; ki--) {
      skipflag = false;

      if (ip == 1)
        skipflag = true;
      else {

        if (ki != 1) {

          if (t[ki][ki - 1] != 0.0)
            ip = -1;
        }

        if (somev) {

          if (ip == 0) {

            if (!vselect[ki])
              skipflag = true;
          } else {

            if (!vselect[ki - 1])
              skipflag = true;
          }
        }
      }

      if (!skipflag) {

        wr = t[ki][ki];
        wi = 0;

        if (ip != 0)
          wi = MathSqrt(MathAbs(t[ki][ki - 1])) *
               MathSqrt(MathAbs(t[ki - 1][ki]));
        smin = MathMax(ulp * (MathAbs(wr) + MathAbs(wi)), smlnum);

        if (ip == 0) {

          work[ki + n] = 1;

          for (k = 1; k <= ki - 1; k++)
            work[k + n] = -t[k][ki];

          jnxt = ki - 1;
          for (j = ki - 1; j >= 1; j--) {

            if (j > jnxt)
              continue;
            j1 = j;
            j2 = j;
            jnxt = j - 1;

            if (j > 1) {

              if (t[j][j - 1] != 0.0) {
                j1 = j - 1;
                jnxt = j - 2;
              }
            }

            if (j1 == j2) {

              temp11[1].Set(1, t[j][j]);
              temp11b[1].Set(1, work[j + n]);

              InternalHsEVDLALN2(false, 1, 1, smin, 1, temp11, 1.0, 1.0,
                                 temp11b, wr, 0.0, rswap4, zswap4, ipivot44,
                                 civ4, crv4, x, scl, xnorm, ierr);

              if (xnorm > 1.0) {

                if (work[j] > bignum / xnorm) {
                  x[1].Set(1, x[1][1] / xnorm);
                  scl = scl / xnorm;
                }
              }

              if (scl != 1.0) {
                k1 = n + 1;
                k2 = n + ki;
                for (i_ = k1; i_ <= k2; i_++)
                  work[i_] = scl * work[i_];
              }
              work[j + n] = x[1][1];

              k1 = 1 + n;
              k2 = j - 1 + n;
              k3 = j - 1;
              vt = -x[1][1];
              i1_ = 1 - k1;
              for (i_ = k1; i_ <= k2; i_++) {
                work[i_] = work[i_] + vt * t[i_ + i1_][j];
              }
            } else {

              temp22[1].Set(1, t[j - 1][j - 1]);
              temp22[1].Set(2, t[j - 1][j]);
              temp22[2].Set(1, t[j][j - 1]);
              temp22[2].Set(2, t[j][j]);
              temp21b[1].Set(1, work[j - 1 + n]);
              temp21b[2].Set(1, work[j + n]);

              InternalHsEVDLALN2(false, 2, 1, smin, 1.0, temp22, 1.0, 1.0,
                                 temp21b, wr, 0, rswap4, zswap4, ipivot44, civ4,
                                 crv4, x, scl, xnorm, ierr);

              if (xnorm > 1.0) {
                beta = MathMax(work[j - 1], work[j]);

                if (beta > bignum / xnorm) {
                  x[1].Set(1, x[1][1] / xnorm);
                  x[2].Set(1, x[2][1] / xnorm);
                  scl = scl / xnorm;
                }
              }

              if (scl != 1.0) {
                k1 = 1 + n;
                k2 = ki + n;
                for (i_ = k1; i_ <= k2; i_++)
                  work[i_] = scl * work[i_];
              }
              work[j - 1 + n] = x[1][1];
              work[j + n] = x[2][1];

              k1 = 1 + n;
              k2 = j - 2 + n;
              k3 = j - 2;
              k4 = j - 1;
              vt = -x[1][1];
              i1_ = 1 - k1;
              for (i_ = k1; i_ <= k2; i_++)
                work[i_] = work[i_] + vt * t[i_ + i1_][k4];
              vt = -x[2][1];
              i1_ = 1 - k1;
              for (i_ = k1; i_ <= k2; i_++)
                work[i_] = work[i_] + vt * t[i_ + i1_][j];
            }
          }

          if (!over) {
            k1 = 1 + n;
            k2 = ki + n;
            i1_ = k1 - 1;
            for (i_ = 1; i_ <= ki; i_++)
              vr[i_].Set(iis, work[i_ + i1_]);

            ii = CBlas::ColumnIdxAbsMax(vr, 1, ki, iis);
            remax = 1 / MathAbs(vr[ii][iis]);
            for (i_ = 1; i_ <= ki; i_++)
              vr[i_].Set(iis, remax * vr[i_][iis]);
            for (k = ki + 1; k <= n; k++)
              vr[k].Set(iis, 0);
          } else {

            if (ki > 1) {
              for (i_ = 1; i_ <= n; i_++)
                temp[i_] = vr[i_][ki];

              CBlas::MatrixVectorMultiply(vr, 1, n, 1, ki - 1, false, work,
                                          1 + n, ki - 1 + n, 1.0, temp, 1, n,
                                          work[ki + n]);
              for (i_ = 1; i_ <= n; i_++)
                vr[i_].Set(ki, temp[i_]);
            }

            ii = CBlas::ColumnIdxAbsMax(vr, 1, n, ki);
            remax = 1 / MathAbs(vr[ii][ki]);
            for (i_ = 1; i_ <= n; i_++)
              vr[i_].Set(ki, remax * vr[i_][ki]);
          }
        } else {

          if (MathAbs(t[ki - 1][ki]) >= MathAbs(t[ki][ki - 1])) {
            work[ki - 1 + n] = 1;
            work[ki + n2] = wi / t[ki - 1][ki];
          } else {
            work[ki - 1 + n] = -(wi / t[ki][ki - 1]);
            work[ki + n2] = 1;
          }
          work[ki + n] = 0;
          work[ki - 1 + n2] = 0;

          for (k = 1; k <= ki - 2; k++) {
            work[k + n] = -(work[ki - 1 + n] * t[k][ki - 1]);
            work[k + n2] = -(work[ki + n2] * t[k][ki]);
          }

          jnxt = ki - 2;
          for (j = ki - 2; j >= 1; j--) {

            if (j > jnxt)
              continue;
            j1 = j;
            j2 = j;
            jnxt = j - 1;

            if (j > 1) {

              if (t[j][j - 1] != 0.0) {
                j1 = j - 1;
                jnxt = j - 2;
              }
            }

            if (j1 == j2) {

              temp11[1].Set(1, t[j][j]);
              temp12b[1].Set(1, work[j + n]);
              temp12b[1].Set(2, work[j + n + n]);

              InternalHsEVDLALN2(false, 1, 2, smin, 1.0, temp11, 1.0, 1.0,
                                 temp12b, wr, wi, rswap4, zswap4, ipivot44,
                                 civ4, crv4, x, scl, xnorm, ierr);

              if (xnorm > 1.0) {

                if (work[j] > bignum / xnorm) {
                  x[1].Set(1, x[1][1] / xnorm);
                  x[1].Set(2, x[1][2] / xnorm);
                  scl = scl / xnorm;
                }
              }

              if (scl != 1.0) {
                k1 = 1 + n;
                k2 = ki + n;
                for (i_ = k1; i_ <= k2; i_++)
                  work[i_] = scl * work[i_];
                k1 = 1 + n2;
                k2 = ki + n2;
                for (i_ = k1; i_ <= k2; i_++)
                  work[i_] = scl * work[i_];
              }
              work[j + n] = x[1][1];
              work[j + n2] = x[1][2];

              k1 = 1 + n;
              k2 = j - 1 + n;
              k3 = 1;
              k4 = j - 1;
              vt = -x[1][1];
              i1_ = k3 - k1;
              for (i_ = k1; i_ <= k2; i_++)
                work[i_] = work[i_] + vt * t[i_ + i1_][j];

              k1 = 1 + n2;
              k2 = j - 1 + n2;
              k3 = 1;
              k4 = j - 1;
              vt = -x[1][2];
              i1_ = k3 - k1;
              for (i_ = k1; i_ <= k2; i_++)
                work[i_] = work[i_] + vt * t[i_ + i1_][j];
            } else {

              temp22[1].Set(1, t[j - 1][j - 1]);
              temp22[1].Set(2, t[j - 1][j]);
              temp22[2].Set(1, t[j][j - 1]);
              temp22[2].Set(2, t[j][j]);
              temp22b[1].Set(1, work[j - 1 + n]);
              temp22b[1].Set(2, work[j - 1 + n + n]);
              temp22b[2].Set(1, work[j + n]);
              temp22b[2].Set(2, work[j + n + n]);

              InternalHsEVDLALN2(false, 2, 2, smin, 1.0, temp22, 1.0, 1.0,
                                 temp22b, wr, wi, rswap4, zswap4, ipivot44,
                                 civ4, crv4, x, scl, xnorm, ierr);

              if (xnorm > 1.0) {
                beta = MathMax(work[j - 1], work[j]);

                if (beta > bignum / xnorm) {
                  rec = 1 / xnorm;
                  x[1].Set(1, x[1][1] * rec);
                  x[1].Set(2, x[1][2] * rec);
                  x[2].Set(1, x[2][1] * rec);
                  x[2].Set(2, x[2][2] * rec);
                  scl = scl * rec;
                }
              }

              if (scl != 1.0) {
                for (i_ = 1 + n; i_ <= ki + n; i_++)
                  work[i_] = scl * work[i_];
                for (i_ = 1 + n2; i_ <= ki + n2; i_++)
                  work[i_] = scl * work[i_];
              }

              work[j - 1 + n] = x[1][1];
              work[j + n] = x[2][1];
              work[j - 1 + n2] = x[1][2];
              work[j + n2] = x[2][2];

              vt = -x[1][1];
              i1_ = -n;
              for (i_ = n + 1; i_ <= n + j - 2; i_++)
                work[i_] = work[i_] + vt * t[i_ + i1_][j - 1];
              vt = -x[2][1];
              i1_ = -n;
              for (i_ = n + 1; i_ <= n + j - 2; i_++)
                work[i_] = work[i_] + vt * t[i_ + i1_][j];
              vt = -x[1][2];
              i1_ = -n2;
              for (i_ = n2 + 1; i_ <= n2 + j - 2; i_++)
                work[i_] = work[i_] + vt * t[i_ + i1_][j - 1];
              vt = -x[2][2];
              i1_ = -n2;
              for (i_ = n2 + 1; i_ <= n2 + j - 2; i_++)
                work[i_] = work[i_] + vt * t[i_ + i1_][j];
            }
          }

          if (!over) {
            i1_ = n;
            for (i_ = 1; i_ <= ki; i_++)
              vr[i_].Set(iis - 1, work[i_ + i1_]);
            i1_ = n2;
            for (i_ = 1; i_ <= ki; i_++)
              vr[i_].Set(iis, work[i_ + i1_]);
            emax = 0;
            for (k = 1; k <= ki; k++)
              emax =
                  MathMax(emax, MathAbs(vr[k][iis - 1]) + MathAbs(vr[k][iis]));
            remax = 1 / emax;

            for (i_ = 1; i_ <= ki; i_++)
              vr[i_].Set(iis - 1, remax * vr[i_][iis - 1]);
            for (i_ = 1; i_ <= ki; i_++)
              vr[i_].Set(iis, remax * vr[i_][iis]);
            for (k = ki + 1; k <= n; k++)
              vr[k].Set(iis - 1, 0);
            vr[k].Set(iis, 0);
          } else {

            if (ki > 2) {
              for (i_ = 1; i_ <= n; i_++)
                temp[i_] = vr[i_][ki - 1];

              CBlas::MatrixVectorMultiply(vr, 1, n, 1, ki - 2, false, work,
                                          1 + n, ki - 2 + n, 1.0, temp, 1, n,
                                          work[ki - 1 + n]);
              for (i_ = 1; i_ <= n; i_++)
                vr[i_].Set(ki - 1, temp[i_]);
              for (i_ = 1; i_ <= n; i_++)
                temp[i_] = vr[i_][ki];

              CBlas::MatrixVectorMultiply(vr, 1, n, 1, ki - 2, false, work,
                                          1 + n2, ki - 2 + n2, 1.0, temp, 1, n,
                                          work[ki + n2]);
              for (i_ = 1; i_ <= n; i_++)
                vr[i_].Set(ki, temp[i_]);
            } else {
              vt = work[ki - 1 + n];

              for (i_ = 1; i_ <= n; i_++)
                vr[i_].Set(ki - 1, vt * vr[i_][ki - 1]);
              vt = work[ki + n2];
              for (i_ = 1; i_ <= n; i_++)
                vr[i_].Set(ki, vt * vr[i_][ki]);
            }
            emax = 0;
            for (k = 1; k <= n; k++)
              emax = MathMax(emax, MathAbs(vr[k][ki - 1]) + MathAbs(vr[k][ki]));
            remax = 1 / emax;

            for (i_ = 1; i_ <= n; i_++)
              vr[i_].Set(ki - 1, remax * vr[i_][ki - 1]);
            for (i_ = 1; i_ <= n; i_++)
              vr[i_].Set(ki, remax * vr[i_][ki]);
          }
        }
        iis = iis - 1;

        if (ip != 0)
          iis = iis - 1;
      }

      if (ip == 1)
        ip = 0;

      if (ip == -1)
        ip = 1;
    }
  }

  if (leftv) {

    ip = 0;
    iis = 1;
    for (ki = 1; ki <= n; ki++) {
      skipflag = false;

      if (ip == -1)
        skipflag = true;
      else {

        if (ki != n) {

          if (t[ki + 1][ki] != 0.0)
            ip = 1;
        }

        if (somev) {

          if (!vselect[ki])
            skipflag = true;
        }
      }

      if (!skipflag) {

        wr = t[ki][ki];
        wi = 0;

        if (ip != 0)
          wi = MathSqrt(MathAbs(t[ki][ki + 1])) *
               MathSqrt(MathAbs(t[ki + 1][ki]));
        smin = MathMax(ulp * (MathAbs(wr) + MathAbs(wi)), smlnum);

        if (ip == 0) {

          work[ki + n] = 1;

          for (k = ki + 1; k <= n; k++)
            work[k + n] = -t[ki][k];

          vmax = 1;
          vcrit = bignum;
          jnxt = ki + 1;
          for (j = ki + 1; j <= n; j++) {

            if (j < jnxt)
              continue;
            j1 = j;
            j2 = j;
            jnxt = j + 1;

            if (j < n) {

              if (t[j + 1][j] != 0.0) {
                j2 = j + 1;
                jnxt = j + 2;
              }
            }

            if (j1 == j2) {

              if (work[j] > vcrit) {
                rec = 1 / vmax;
                for (i_ = ki + n; i_ <= n + n; i_++) {
                  work[i_] = rec * work[i_];
                }
                vmax = 1;
                vcrit = bignum;
              }
              i1_ = n;
              vt = 0.0;
              for (i_ = ki + 1; i_ < j; i_++)
                vt += t[i_][j] * work[i_ + i1_];
              work[j + n] = work[j + n] - vt;

              temp11[1].Set(1, t[j][j]);
              temp11b[1].Set(1, work[j + n]);
              InternalHsEVDLALN2(false, 1, 1, smin, 1.0, temp11, 1.0, 1.0,
                                 temp11b, wr, 0, rswap4, zswap4, ipivot44, civ4,
                                 crv4, x, scl, xnorm, ierr);

              if (scl != 1.0) {
                for (i_ = ki + n; i_ <= n + n; i_++)
                  work[i_] = scl * work[i_];
              }
              work[j + n] = x[1][1];
              vmax = MathMax(MathAbs(work[j + n]), vmax);
              vcrit = bignum / vmax;
            } else {

              beta = MathMax(work[j], work[j + 1]);

              if (beta > vcrit) {
                rec = 1 / vmax;
                for (i_ = ki + n; i_ <= n + n; i_++)
                  work[i_] = rec * work[i_];
                vmax = 1;
                vcrit = bignum;
              }
              i1_ = n;
              vt = 0.0;
              for (i_ = ki + 1; i_ < j; i_++)
                vt += t[i_][j] * work[i_ + i1_];

              work[j + n] = work[j + n] - vt;
              i1_ = n;
              vt = 0.0;
              for (i_ = ki + 1; i_ < j; i_++)
                vt += t[i_][j + 1] * work[i_ + i1_];
              work[j + 1 + n] = work[j + 1 + n] - vt;

              temp22[1].Set(1, t[j][j]);
              temp22[1].Set(2, t[j][j + 1]);
              temp22[2].Set(1, t[j + 1][j]);
              temp22[2].Set(2, t[j + 1][j + 1]);
              temp21b[1].Set(1, work[j + n]);
              temp21b[2].Set(1, work[j + 1 + n]);

              InternalHsEVDLALN2(true, 2, 1, smin, 1.0, temp22, 1.0, 1.0,
                                 temp21b, wr, 0, rswap4, zswap4, ipivot44, civ4,
                                 crv4, x, scl, xnorm, ierr);

              if (scl != 1.0) {
                for (i_ = ki + n; i_ <= n + n; i_++)
                  work[i_] = scl * work[i_];
              }

              work[j + n] = x[1][1];
              work[j + 1 + n] = x[2][1];
              vmax = MathMax(MathAbs(work[j + n]),
                             MathMax(MathAbs(work[j + 1 + n]), vmax));
              vcrit = bignum / vmax;
            }
          }

          if (!over) {
            i1_ = n;
            ;
            for (i_ = ki; i_ <= n; i_++)
              vl[i_].Set(iis, work[i_ + i1_]);

            ii = CBlas::ColumnIdxAbsMax(vl, ki, n, iis);
            remax = 1 / MathAbs(vl[ii][iis]);
            for (i_ = ki; i_ <= n; i_++)
              vl[i_].Set(iis, remax * vl[i_][iis]);
            for (k = 1; k <= ki - 1; k++)
              vl[k].Set(iis, 0);
          } else {

            if (ki < n) {
              for (i_ = 1; i_ <= n; i_++)
                temp[i_] = vl[i_][ki];

              CBlas::MatrixVectorMultiply(vl, 1, n, ki + 1, n, false, work,
                                          ki + 1 + n, n + n, 1.0, temp, 1, n,
                                          work[ki + n]);
              for (i_ = 1; i_ <= n; i_++)
                vl[i_].Set(ki, temp[i_]);
            }

            ii = CBlas::ColumnIdxAbsMax(vl, 1, n, ki);
            remax = 1 / MathAbs(vl[ii][ki]);
            for (i_ = 1; i_ <= n; i_++)
              vl[i_].Set(ki, remax * vl[i_][ki]);
          }
        } else {

          if (MathAbs(t[ki][ki + 1]) >= MathAbs(t[ki + 1][ki])) {
            work[ki + n] = wi / t[ki][ki + 1];
            work[ki + 1 + n2] = 1;
          } else {
            work[ki + n] = 1;
            work[ki + 1 + n2] = -(wi / t[ki + 1][ki]);
          }
          work[ki + 1 + n] = 0;
          work[ki + n2] = 0;

          for (k = ki + 2; k <= n; k++) {
            work[k + n] = -(work[ki + n] * t[ki][k]);
            work[k + n2] = -(work[ki + 1 + n2] * t[ki + 1][k]);
          }

          vmax = 1;
          vcrit = bignum;
          jnxt = ki + 2;
          for (j = ki + 2; j <= n; j++) {

            if (j < jnxt)
              continue;
            j1 = j;
            j2 = j;
            jnxt = j + 1;

            if (j < n) {

              if (t[j + 1][j] != 0.0) {
                j2 = j + 1;
                jnxt = j + 2;
              }
            }

            if (j1 == j2) {

              if (work[j] > vcrit) {
                rec = 1 / vmax;
                for (i_ = ki + n; i_ <= n + n; i_++)
                  work[i_] = rec * work[i_];
                for (i_ = ki + n2; i_ <= n + n2; i_++)
                  work[i_] = rec * work[i_];
                vmax = 1;
                vcrit = bignum;
              }
              i1_ = n;
              vt = 0.0;
              for (i_ = ki + 2; i_ < j; i_++)
                vt += t[i_][j] * work[i_ + i1_];

              work[j + n] = work[j + n] - vt;
              i1_ = n2;
              vt = 0.0;
              for (i_ = ki + 2; i_ < j; i_++)
                vt += t[i_][j] * work[i_ + i1_];
              work[j + n2] = work[j + n2] - vt;

              temp11[1].Set(1, t[j][j]);
              temp12b[1].Set(1, work[j + n]);
              temp12b[1].Set(2, work[j + n + n]);

              InternalHsEVDLALN2(false, 1, 2, smin, 1.0, temp11, 1.0, 1.0,
                                 temp12b, wr, -wi, rswap4, zswap4, ipivot44,
                                 civ4, crv4, x, scl, xnorm, ierr);

              if (scl != 1.0) {
                for (i_ = ki + n; i_ <= n + n; i_++)
                  work[i_] = scl * work[i_];
                for (i_ = ki + n2; i_ <= n + n2; i_++)
                  work[i_] = scl * work[i_];
              }

              work[j + n] = x[1][1];
              work[j + n2] = x[1][2];
              vmax = MathMax(MathAbs(work[j + n]),
                             MathMax(MathAbs(work[j + n2]), vmax));
              vcrit = bignum / vmax;
            } else {

              beta = MathMax(work[j], work[j + 1]);

              if (beta > vcrit) {
                rec = 1 / vmax;
                for (i_ = ki + n; i_ <= n + n; i_++)
                  work[i_] = rec * work[i_];
                for (i_ = ki + n2; i_ <= n + n2; i_++)
                  work[i_] = rec * work[i_];
                vmax = 1;
                vcrit = bignum;
              }
              i1_ = n;
              vt = 0.0;
              for (i_ = ki + 2; i_ < j; i_++)
                vt += t[i_][j] * work[i_ + i1_];

              work[j + n] = work[j + n] - vt;
              i1_ = n2;
              vt = 0.0;
              for (i_ = ki + 2; i_ < j; i_++)
                vt += t[i_][j] * work[i_ + i1_];

              work[j + n2] = work[j + n2] - vt;
              i1_ = n;
              vt = 0.0;
              for (i_ = ki + 2; i_ < j; i_++)
                vt += t[i_][j + 1] * work[i_ + i1_];

              work[j + 1 + n] = work[j + 1 + n] - vt;
              i1_ = n2;
              vt = 0.0;
              for (i_ = ki + 2; i_ < j; i_++)
                vt += t[i_][j + 1] * work[i_ + i1_];
              work[j + 1 + n2] = work[j + 1 + n2] - vt;

              temp22[1].Set(1, t[j][j]);
              temp22[1].Set(2, t[j][j + 1]);
              temp22[2].Set(1, t[j + 1][j]);
              temp22[2].Set(2, t[j + 1][j + 1]);
              temp22b[1].Set(1, work[j + n]);
              temp22b[1].Set(2, work[j + n + n]);
              temp22b[2].Set(1, work[j + 1 + n]);
              temp22b[2].Set(2, work[j + 1 + n + n]);

              InternalHsEVDLALN2(true, 2, 2, smin, 1.0, temp22, 1.0, 1.0,
                                 temp22b, wr, -wi, rswap4, zswap4, ipivot44,
                                 civ4, crv4, x, scl, xnorm, ierr);

              if (scl != 1.0) {
                for (i_ = ki + n; i_ <= n + n; i_++)
                  work[i_] = scl * work[i_];
                for (i_ = ki + n2; i_ <= n + n2; i_++)
                  work[i_] = scl * work[i_];
              }

              work[j + n] = x[1][1];
              work[j + n2] = x[1][2];
              work[j + 1 + n] = x[2][1];
              work[j + 1 + n2] = x[2][2];
              vmax = MathMax(MathAbs(x[1][1]), vmax);
              vmax = MathMax(MathAbs(x[1][2]), vmax);
              vmax = MathMax(MathAbs(x[2][1]), vmax);
              vmax = MathMax(MathAbs(x[2][2]), vmax);
              vcrit = bignum / vmax;
            }
          }

          if (!over) {
            i1_ = n;
            for (i_ = ki; i_ <= n; i_++)
              vl[i_].Set(iis, work[i_ + i1_]);
            i1_ = n2;
            for (i_ = ki; i_ <= n; i_++)
              vl[i_].Set(iis + 1, work[i_ + i1_]);
            emax = 0;
            for (k = ki; k <= n; k++)
              emax =
                  MathMax(emax, MathAbs(vl[k][iis]) + MathAbs(vl[k][iis + 1]));
            remax = 1 / emax;

            for (i_ = ki; i_ <= n; i_++)
              vl[i_].Set(iis, remax * vl[i_][iis]);
            for (i_ = ki; i_ <= n; i_++)
              vl[i_].Set(iis + 1, remax * vl[i_][iis + 1]);
            for (k = 1; k <= ki - 1; k++) {
              vl[k].Set(iis, 0);
              vl[k].Set(iis + 1, 0);
            }
          } else {

            if (ki < n - 1) {
              for (i_ = 1; i_ <= n; i_++)
                temp[i_] = vl[i_][ki];

              CBlas::MatrixVectorMultiply(vl, 1, n, ki + 2, n, false, work,
                                          ki + 2 + n, n + n, 1.0, temp, 1, n,
                                          work[ki + n]);
              for (i_ = 1; i_ <= n; i_++)
                vl[i_].Set(ki, temp[i_]);
              for (i_ = 1; i_ <= n; i_++)
                temp[i_] = vl[i_][ki + 1];

              CBlas::MatrixVectorMultiply(vl, 1, n, ki + 2, n, false, work,
                                          ki + 2 + n2, n + n2, 1.0, temp, 1, n,
                                          work[ki + 1 + n2]);
              for (i_ = 1; i_ <= n; i_++)
                vl[i_].Set(ki + 1, temp[i_]);
            } else {

              vt = work[ki + n];
              for (i_ = 1; i_ <= n; i_++)
                vl[i_].Set(ki, vt * vl[i_][ki]);
              vt = work[ki + 1 + n2];
              for (i_ = 1; i_ <= n; i_++)
                vl[i_].Set(ki + 1, vt * vl[i_][ki + 1]);
            }
            emax = 0;
            for (k = 1; k <= n; k++)
              emax = MathMax(emax, MathAbs(vl[k][ki]) + MathAbs(vl[k][ki + 1]));
            remax = 1 / emax;

            for (i_ = 1; i_ <= n; i_++)
              vl[i_].Set(ki, remax * vl[i_][ki]);
            for (i_ = 1; i_ <= n; i_++)
              vl[i_].Set(ki + 1, remax * vl[i_][ki + 1]);
          }
        }
        iis = iis + 1;

        if (ip != 0)
          iis = iis + 1;
      }

      if (ip == -1)
        ip = 0;

      if (ip == 1)
        ip = -1;
    }
  }
}

static void CEigenVDetect::InternalHsEVDLALN2(
    const bool ltrans, const int na, const int nw, const double smin,
    const double ca, CMatrixDouble &a, const double d1, const double d2,
    CMatrixDouble &b, const double wr, const double wi, bool &rswap4[],
    bool &zswap4[], CMatrixInt &ipivot44, double &civ4[], double &crv4[],
    CMatrixDouble &x, double &scl, double &xnorm, int &info) {

  int icmax = 0;
  int j = 0;
  double bbnd = 0;
  double bi1 = 0;
  double bi2 = 0;
  double bignum = 0;
  double bnorm = 0;
  double br1 = 0;
  double br2 = 0;
  double ci21 = 0;
  double ci22 = 0;
  double cmax = 0;
  double cnorm = 0;
  double cr21 = 0;
  double cr22 = 0;
  double csi = 0;
  double csr = 0;
  double li21 = 0;
  double lr21 = 0;
  double smini = 0;
  double smlnum = 0;
  double temp = 0;
  double u22abs = 0;
  double ui11 = 0;
  double ui11r = 0;
  double ui12 = 0;
  double ui12s = 0;
  double ui22 = 0;
  double ur11 = 0;
  double ur11r = 0;
  double ur12 = 0;
  double ur12s = 0;
  double ur22 = 0;
  double xi1 = 0;
  double xi2 = 0;
  double xr1 = 0;
  double xr2 = 0;
  double tmp1 = 0;
  double tmp2 = 0;

  scl = 0;
  xnorm = 0;
  info = 0;
  zswap4[1] = false;
  zswap4[2] = false;
  zswap4[3] = true;
  zswap4[4] = true;
  rswap4[1] = false;
  rswap4[2] = true;
  rswap4[3] = false;
  rswap4[4] = true;
  ipivot44[1].Set(1, 1);
  ipivot44[2].Set(1, 2);
  ipivot44[3].Set(1, 3);
  ipivot44[4].Set(1, 4);
  ipivot44[1].Set(2, 2);
  ipivot44[2].Set(2, 1);
  ipivot44[3].Set(2, 4);
  ipivot44[4].Set(2, 3);
  ipivot44[1].Set(3, 3);
  ipivot44[2].Set(3, 4);
  ipivot44[3].Set(3, 1);
  ipivot44[4].Set(3, 2);
  ipivot44[1].Set(4, 4);
  ipivot44[2].Set(4, 3);
  ipivot44[3].Set(4, 2);
  ipivot44[4].Set(4, 1);
  smlnum = 2 * CMath::m_minrealnumber;
  bignum = 1 / smlnum;
  smini = MathMax(smin, smlnum);

  info = 0;
  scl = 1;

  if (na == 1) {

    if (nw == 1) {

      csr = ca * a[1][1] - wr * d1;
      cnorm = MathAbs(csr);

      if (cnorm < smini) {
        csr = smini;
        cnorm = smini;
        info = 1;
      }

      bnorm = MathAbs(b[1][1]);

      if (cnorm < 1.0 && bnorm > 1.0) {

        if (bnorm > bignum * cnorm)
          scl = 1 / bnorm;
      }

      x[1].Set(1, b[1][1] * scl / csr);
      xnorm = MathAbs(x[1][1]);
    } else {

      csr = ca * a[1][1] - wr * d1;
      csi = -(wi * d1);
      cnorm = MathAbs(csr) + MathAbs(csi);

      if (cnorm < smini) {
        csr = smini;
        csi = 0;
        cnorm = smini;
        info = 1;
      }

      bnorm = MathAbs(b[1][1]) + MathAbs(b[1][2]);

      if (cnorm < 1.0 && bnorm > 1.0) {

        if (bnorm > bignum * cnorm)
          scl = 1 / bnorm;
      }

      InternalHsEVDLADIV(scl * b[1][1], scl * b[1][2], csr, csi, tmp1, tmp2);
      x[1].Set(1, tmp1);
      x[1].Set(2, tmp2);
      xnorm = MathAbs(x[1][1]) + MathAbs(x[1][2]);
    }
  } else {

    crv4[1 + 0] = ca * a[1][1] - wr * d1;
    crv4[2 + 2] = ca * a[2][2] - wr * d2;

    if (ltrans) {
      crv4[1 + 2] = ca * a[2][1];
      crv4[2 + 0] = ca * a[1][2];
    } else {
      crv4[2 + 0] = ca * a[2][1];
      crv4[1 + 2] = ca * a[1][2];
    }

    if (nw == 1) {

      cmax = 0;
      icmax = 0;
      for (j = 1; j <= 4; j++) {

        if (MathAbs(crv4[j]) > cmax) {
          cmax = MathAbs(crv4[j]);
          icmax = j;
        }
      }

      if (cmax < smini) {
        bnorm = MathMax(MathAbs(b[1][1]), MathAbs(b[2][1]));

        if (smini < 1.0 && bnorm > 1.0) {

          if (bnorm > bignum * smini)
            scl = 1 / bnorm;
        }

        temp = scl / smini;
        x[1].Set(1, temp * b[1][1]);
        x[2].Set(1, temp * b[2][1]);
        xnorm = temp * bnorm;
        info = 1;

        return;
      }

      ur11 = crv4[icmax];
      cr21 = crv4[ipivot44[2][icmax]];
      ur12 = crv4[ipivot44[3][icmax]];
      cr22 = crv4[ipivot44[4][icmax]];
      ur11r = 1 / ur11;
      lr21 = ur11r * cr21;
      ur22 = cr22 - ur12 * lr21;

      if (MathAbs(ur22) < smini) {
        ur22 = smini;
        info = 1;
      }

      if (rswap4[icmax]) {
        br1 = b[2][1];
        br2 = b[1][1];
      } else {
        br1 = b[1][1];
        br2 = b[2][1];
      }
      br2 = br2 - lr21 * br1;
      bbnd = MathMax(MathAbs(br1 * (ur22 * ur11r)), MathAbs(br2));

      if (bbnd > 1.0 && MathAbs(ur22) < 1.0) {

        if (bbnd >= bignum * MathAbs(ur22))
          scl = 1 / bbnd;
      }
      xr2 = br2 * scl / ur22;
      xr1 = scl * br1 * ur11r - xr2 * (ur11r * ur12);

      if (zswap4[icmax]) {
        x[1].Set(1, xr2);
        x[2].Set(1, xr1);
      } else {
        x[1].Set(1, xr1);
        x[2].Set(1, xr2);
      }
      xnorm = MathMax(MathAbs(xr1), MathAbs(xr2));

      if (xnorm > 1.0 && cmax > 1.0) {

        if (xnorm > bignum / cmax) {
          temp = cmax / bignum;
          x[1].Set(1, temp * x[1][1]);
          x[2].Set(1, temp * x[2][1]);
          xnorm = temp * xnorm;
          scl = temp * scl;
        }
      }
    } else {

      civ4[1 + 0] = -(wi * d1);
      civ4[2 + 0] = 0;
      civ4[1 + 2] = 0;
      civ4[2 + 2] = -(wi * d2);
      cmax = 0;
      icmax = 0;
      for (j = 1; j <= 4; j++) {

        if (MathAbs(crv4[j]) + MathAbs(civ4[j]) > cmax) {
          cmax = MathAbs(crv4[j]) + MathAbs(civ4[j]);
          icmax = j;
        }
      }

      if (cmax < smini) {
        bnorm = MathMax(MathAbs(b[1][1]) + MathAbs(b[1][2]),
                        MathAbs(b[2][1]) + MathAbs(b[2][2]));

        if (smini < 1.0 && bnorm > 1.0) {

          if (bnorm > bignum * smini)
            scl = 1 / bnorm;
        }

        temp = scl / smini;
        x[1].Set(1, temp * b[1][1]);
        x[2].Set(1, temp * b[2][1]);
        x[1].Set(2, temp * b[1][2]);
        x[2].Set(2, temp * b[2][2]);
        xnorm = temp * bnorm;
        info = 1;

        return;
      }

      ur11 = crv4[icmax];
      ui11 = civ4[icmax];
      cr21 = crv4[ipivot44[2][icmax]];
      ci21 = civ4[ipivot44[2][icmax]];
      ur12 = crv4[ipivot44[3][icmax]];
      ui12 = civ4[ipivot44[3][icmax]];
      cr22 = crv4[ipivot44[4][icmax]];
      ci22 = civ4[ipivot44[4][icmax]];

      if (icmax == 1 || icmax == 4) {

        if (MathAbs(ur11) > MathAbs(ui11)) {
          temp = ui11 / ur11;
          ur11r = 1 / (ur11 * (1 + CMath::Sqr(temp)));
          ui11r = -(temp * ur11r);
        } else {
          temp = ur11 / ui11;
          ui11r = -(1 / (ui11 * (1 + CMath::Sqr(temp))));
          ur11r = -(temp * ui11r);
        }

        lr21 = cr21 * ur11r;
        li21 = cr21 * ui11r;
        ur12s = ur12 * ur11r;
        ui12s = ur12 * ui11r;
        ur22 = cr22 - ur12 * lr21;
        ui22 = ci22 - ur12 * li21;
      } else {

        ur11r = 1 / ur11;
        ui11r = 0;
        lr21 = cr21 * ur11r;
        li21 = ci21 * ur11r;
        ur12s = ur12 * ur11r;
        ui12s = ui12 * ur11r;
        ur22 = cr22 - ur12 * lr21 + ui12 * li21;
        ui22 = -(ur12 * li21) - ui12 * lr21;
      }
      u22abs = MathAbs(ur22) + MathAbs(ui22);

      if (u22abs < smini) {
        ur22 = smini;
        ui22 = 0;
        info = 1;
      }

      if (rswap4[icmax]) {
        br2 = b[1][1];
        br1 = b[2][1];
        bi2 = b[1][2];
        bi1 = b[2][2];
      } else {
        br1 = b[1][1];
        br2 = b[2][1];
        bi1 = b[1][2];
        bi2 = b[2][2];
      }
      br2 = br2 - lr21 * br1 + li21 * bi1;
      bi2 = bi2 - li21 * br1 - lr21 * bi1;
      bbnd = MathMax((MathAbs(br1) + MathAbs(bi1)) *
                         (u22abs * (MathAbs(ur11r) + MathAbs(ui11r))),
                     MathAbs(br2) + MathAbs(bi2));

      if (bbnd > 1.0 && u22abs < 1.0) {

        if (bbnd >= bignum * u22abs) {

          scl = 1 / bbnd;
          br1 = scl * br1;
          bi1 = scl * bi1;
          br2 = scl * br2;
          bi2 = scl * bi2;
        }
      }

      InternalHsEVDLADIV(br2, bi2, ur22, ui22, xr2, xi2);
      xr1 = ur11r * br1 - ui11r * bi1 - ur12s * xr2 + ui12s * xi2;
      xi1 = ui11r * br1 + ur11r * bi1 - ui12s * xr2 - ur12s * xi2;

      if (zswap4[icmax]) {
        x[1].Set(1, xr2);
        x[2].Set(1, xr1);
        x[1].Set(2, xi2);
        x[2].Set(2, xi1);
      } else {
        x[1].Set(1, xr1);
        x[2].Set(1, xr2);
        x[1].Set(2, xi1);
        x[2].Set(2, xi2);
      }
      xnorm = MathMax(MathAbs(xr1) + MathAbs(xi1), MathAbs(xr2) + MathAbs(xi2));

      if (xnorm > 1.0 && cmax > 1.0) {

        if (xnorm > bignum / cmax) {

          temp = cmax / bignum;
          x[1].Set(1, temp * x[1][1]);
          x[2].Set(1, temp * x[2][1]);
          x[1].Set(2, temp * x[1][2]);
          x[2].Set(2, temp * x[2][2]);
          xnorm = temp * xnorm;
          scl = temp * scl;
        }
      }
    }
  }
}

static void CEigenVDetect::InternalHsEVDLADIV(const double a, const double b,
                                              const double c, const double d,
                                              double &p, double &q) {

  double e = 0;
  double f = 0;

  p = 0;
  q = 0;

  if (MathAbs(d) < MathAbs(c)) {

    e = d / c;
    f = c + d * e;
    p = (a + b * e) / f;
    q = (b - a * e) / f;
  } else {

    e = c / d;
    f = d + c * e;
    p = (b + a * e) / f;
    q = (-a + b * e) / f;
  }
}

static bool CEigenVDetect::NonSymmetricEVD(CMatrixDouble &ca, const int n,
                                           const int vneeded, double &wr[],
                                           double &wi[], CMatrixDouble &vl,
                                           CMatrixDouble &vr) {

  bool result;
  int i = 0;
  int info = 0;
  int m = 0;
  int i_ = 0;

  double tau[];
  bool sel[];

  CMatrixDouble s;

  CMatrixDouble a;
  a = ca;

  if (!CAp::Assert(vneeded >= 0 && vneeded <= 3,
                   __FUNCTION__ + ": incorrect VNeeded!"))
    return (false);

  if (vneeded == 0) {

    ToUpperHessenberg(a, n, tau);

    CHsSchur::InternalSchurDecomposition(a, n, 0, 0, wr, wi, s, info);

    result = info == 0;

    return (result);
  }

  ToUpperHessenberg(a, n, tau);

  UnpackQFromUpperHessenberg(a, n, tau, s);

  CHsSchur::InternalSchurDecomposition(a, n, 1, 1, wr, wi, s, info);

  result = info == 0;

  if (!result)
    return (result);

  if (vneeded == 1 || vneeded == 3) {
    vr.Resize(n + 1, n + 1);
    for (i = 1; i <= n; i++) {
      for (i_ = 1; i_ <= n; i_++)
        vr[i].Set(i_, s[i][i_]);
    }
  }

  if (vneeded == 2 || vneeded == 3) {
    vl.Resize(n + 1, n + 1);
    for (i = 1; i <= n; i++) {
      for (i_ = 1; i_ <= n; i_++)
        vl[i].Set(i_, s[i][i_]);
    }
  }

  InternalTREVC(a, n, vneeded, 1, sel, vl, vr, m, info);

  result = info == 0;

  return (result);
}

static void CEigenVDetect::ToUpperHessenberg(CMatrixDouble &a, const int n,
                                             double &tau[]) {

  int i = 0;
  int ip1 = 0;
  int nmi = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  double t[];
  double work[];

  if (!CAp::Assert(n >= 0, __FUNCTION__ + ": incorrect N!"))
    return;

  if (n <= 1)
    return;

  ArrayResizeAL(tau, n);
  ArrayResizeAL(t, n + 1);
  ArrayResizeAL(work, n + 1);

  for (i = 1; i < n; i++) {

    ip1 = i + 1;
    nmi = n - i;
    i1_ = ip1 - 1;
    for (i_ = 1; i_ <= nmi; i_++)
      t[i_] = a[i_ + i1_][i];

    CReflections::GenerateReflection(t, nmi, v);
    i1_ = 1 - ip1;
    for (i_ = ip1; i_ <= n; i_++)
      a[i_].Set(i, t[i_ + i1_]);
    tau[i] = v;
    t[1] = 1;

    CReflections::ApplyReflectionFromTheRight(a, v, t, 1, n, i + 1, n, work);

    CReflections::ApplyReflectionFromTheLeft(a, v, t, i + 1, n, i + 1, n, work);
  }
}

static void CEigenVDetect::UnpackQFromUpperHessenberg(CMatrixDouble &a,
                                                      const int n,
                                                      double &tau[],
                                                      CMatrixDouble &q) {

  int i = 0;
  int j = 0;
  int ip1 = 0;
  int nmi = 0;
  int i_ = 0;
  int i1_ = 0;

  double v[];
  double work[];

  if (n == 0)
    return;

  q.Resize(n + 1, n + 1);
  ArrayResizeAL(v, n + 1);
  ArrayResizeAL(work, n + 1);

  for (i = 1; i <= n; i++) {
    for (j = 1; j <= n; j++) {

      if (i == j)
        q[i].Set(j, 1);
      else
        q[i].Set(j, 0);
    }
  }

  for (i = 1; i < n; i++) {

    ip1 = i + 1;
    nmi = n - i;
    i1_ = ip1 - 1;
    for (i_ = 1; i_ <= nmi; i_++)
      v[i_] = a[i_ + i1_][i];
    v[1] = 1;

    CReflections::ApplyReflectionFromTheRight(q, tau[i], v, 1, n, i + 1, n,
                                              work);
  }
}

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

CMatGen::CMatGen(void) {}

CMatGen::~CMatGen(void) {}

static void CMatGen::RMatrixRndOrthogonal(const int n, CMatrixDouble &a) {

  int i = 0;
  int j = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  a.Resize(n, n);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {

      if (i == j)
        a[i].Set(j, 1);
      else
        a[i].Set(j, 0);
    }
  }

  RMatrixRndOrthogonalFromTheRight(a, n, n);
}

static void CMatGen::RMatrixRndCond(const int n, const double c,
                                    CMatrixDouble &a) {

  int i = 0;
  int j = 0;
  double l1 = 0;
  double l2 = 0;

  if (!CAp::Assert(n >= 1 && c >= 1.0, __FUNCTION__ + ": N<1 or C<1!"))
    return;

  a.Resize(n, n);

  if (n == 1) {
    a[0].Set(0, 2 * CMath::RandomInteger(2) - 1);

    return;
  }

  l1 = 0;
  l2 = MathLog(1 / c);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      a[i].Set(j, 0);
  }

  a[0].Set(0, MathExp(l1));
  for (i = 1; i <= n - 2; i++)
    a[i].Set(i, MathExp(CMath::RandomReal() * (l2 - l1) + l1));
  a[n - 1].Set(n - 1, MathExp(l2));

  RMatrixRndOrthogonalFromTheLeft(a, n, n);

  RMatrixRndOrthogonalFromTheRight(a, n, n);
}

static void CMatGen::CMatrixRndOrthogonal(const int n, CMatrixComplex &a) {

  int i = 0;
  int j = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return;

  a.Resize(n, n);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {

      if (i == j)
        a[i].Set(j, 1);
      else
        a[i].Set(j, 0);
    }
  }

  CMatrixRndOrthogonalFromTheRight(a, n, n);
}

static void CMatGen::CMatrixRndCond(const int n, const double c,
                                    CMatrixComplex &a) {

  int i = 0;
  int j = 0;
  double l1 = 0;
  double l2 = 0;
  al_complex v = 0;

  CHighQualityRandState state;

  if (!CAp::Assert(n >= 1 && c >= 1.0, __FUNCTION__ + ": N<1 or C<1!"))
    return;

  a.Resize(n, n);

  if (n == 1) {

    CHighQualityRand::HQRndRandomize(state);

    CHighQualityRand::HQRndUnit2(state, v.re, v.im);
    a[0].Set(0, v);
    return;
  }

  l1 = 0;
  l2 = MathLog(1 / c);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      a[i].Set(j, 0);
  }

  a[0].Set(0, MathExp(l1));
  for (i = 1; i <= n - 2; i++)
    a[i].Set(i, MathExp(CMath::RandomReal() * (l2 - l1) + l1));
  a[n - 1].Set(n - 1, MathExp(l2));

  CMatrixRndOrthogonalFromTheLeft(a, n, n);

  CMatrixRndOrthogonalFromTheRight(a, n, n);
}

static void CMatGen::SMatrixRndCond(const int n, const double c,
                                    CMatrixDouble &a) {

  int i = 0;
  int j = 0;
  double l1 = 0;
  double l2 = 0;

  if (!CAp::Assert(n >= 1 && c >= 1.0, __FUNCTION__ + ": N<1 or C<1!"))
    return;

  a.Resize(n, n);

  if (n == 1) {
    a[0].Set(0, 2 * CMath::RandomInteger(2) - 1);
    return;
  }

  l1 = 0;
  l2 = MathLog(1 / c);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      a[i].Set(j, 0);
  }

  a[0].Set(0, MathExp(l1));
  for (i = 1; i <= n - 2; i++)
    a[i].Set(i, (2 * CMath::RandomInteger(2) - 1) *
                    MathExp(CMath::RandomReal() * (l2 - l1) + l1));
  a[n - 1].Set(n - 1, MathExp(l2));

  SMatrixRndMultiply(a, n);
}

static void CMatGen::SPDMatrixRndCond(const int n, const double c,
                                      CMatrixDouble &a) {

  int i = 0;
  int j = 0;
  double l1 = 0;
  double l2 = 0;

  if (n <= 0 || c < 1.0)
    return;

  a.Resize(n, n);

  if (n == 1) {
    a[0].Set(0, 1);
    return;
  }

  l1 = 0;
  l2 = MathLog(1 / c);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      a[i].Set(j, 0);
  }

  a[0].Set(0, MathExp(l1));
  for (i = 1; i <= n - 2; i++)
    a[i].Set(i, MathExp(CMath::RandomReal() * (l2 - l1) + l1));
  a[n - 1].Set(n - 1, MathExp(l2));

  SMatrixRndMultiply(a, n);
}

static void CMatGen::HMatrixRndCond(const int n, const double c,
                                    CMatrixComplex &a) {

  int i = 0;
  int j = 0;
  double l1 = 0;
  double l2 = 0;

  if (!CAp::Assert(n >= 1 && c >= 1.0, __FUNCTION__ + ": N<1 or C<1!"))
    return;

  a.Resize(n, n);

  if (n == 1) {
    a[0].Set(0, 2 * CMath::RandomInteger(2) - 1);
    return;
  }

  l1 = 0;
  l2 = MathLog(1 / c);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      a[i].Set(j, 0);
  }

  a[0].Set(0, MathExp(l1));
  for (i = 1; i <= n - 2; i++)
    a[i].Set(i, (2 * CMath::RandomInteger(2) - 1) *
                    MathExp(CMath::RandomReal() * (l2 - l1) + l1));
  a[n - 1].Set(n - 1, MathExp(l2));

  HMatrixRndMultiply(a, n);

  for (i = 0; i < n; i++)
    a[i].SetIm(i, 0);
}

static void CMatGen::HPDMatrixRndCond(const int n, const double c,
                                      CMatrixComplex &a) {

  int i = 0;
  int j = 0;
  double l1 = 0;
  double l2 = 0;

  if (n <= 0 || c < 1.0)
    return;

  a.Resize(n, n);

  if (n == 1) {
    a[0].Set(0, 1);
    return;
  }

  l1 = 0;
  l2 = MathLog(1 / c);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      a[i].Set(j, 0);
  }

  a[0].Set(0, MathExp(l1));
  for (i = 1; i <= n - 2; i++)
    a[i].Set(i, MathExp(CMath::RandomReal() * (l2 - l1) + l1));
  a[n - 1].Set(n - 1, MathExp(l2));

  HMatrixRndMultiply(a, n);

  for (i = 0; i < n; i++)
    a[i].SetIm(i, 0);
}

static void CMatGen::RMatrixRndOrthogonalFromTheRight(CMatrixDouble &a,
                                                      const int m,
                                                      const int n) {

  double tau = 0;
  double lambdav = 0;
  int s = 0;
  int i = 0;
  double u1 = 0;
  double u2 = 0;
  int i_ = 0;

  double w[];
  double v[];

  CHighQualityRandState state;

  if (!CAp::Assert(n >= 1 && m >= 1, __FUNCTION__ + ": N<1 or M<1!"))
    return;

  if (n == 1) {
    tau = 2 * CMath::RandomInteger(2) - 1;
    for (i = 0; i < m; i++)
      a[i].Set(0, a[i][0] * tau);

    return;
  }

  ArrayResizeAL(w, m);
  ArrayResizeAL(v, n + 1);

  CHighQualityRand::HQRndRandomize(state);
  for (s = 2; s <= n; s++) {

    do {
      i = 1;
      while (i <= s) {

        CHighQualityRand::HQRndNormal2(state, u1, u2);
        v[i] = u1;

        if (i + 1 <= s)
          v[i + 1] = u2;
        i = i + 2;
      }

      lambdav = 0.0;
      for (i_ = 1; i_ <= s; i_++)
        lambdav += v[i_] * v[i_];
    } while (lambdav == 0.0);

    CReflections::GenerateReflection(v, s, tau);
    v[1] = 1;

    CReflections::ApplyReflectionFromTheRight(a, tau, v, 0, m - 1, n - s, n - 1,
                                              w);
  }

  for (i = 0; i < n; i++) {
    tau = 2 * CMath::RandomInteger(2) - 1;
    for (i_ = 0; i_ < m; i_++)
      a[i_].Set(i, tau * a[i_][i]);
  }
}

static void CMatGen::RMatrixRndOrthogonalFromTheLeft(CMatrixDouble &a,
                                                     const int m, const int n) {

  double tau = 0;
  double lambdav = 0;
  int s = 0;
  int i = 0;
  int j = 0;
  double u1 = 0;
  double u2 = 0;

  double w[];
  double v[];

  CHighQualityRandState state;
  int i_ = 0;

  if (!CAp::Assert(n >= 1 && m >= 1, __FUNCTION__ + ": N<1 or M<1!"))
    return;

  if (m == 1) {
    tau = 2 * CMath::RandomInteger(2) - 1;
    for (j = 0; j < n; j++)
      a[0].Set(j, a[0][j] * tau);

    return;
  }

  ArrayResizeAL(w, n);
  ArrayResizeAL(v, m + 1);

  CHighQualityRand::HQRndRandomize(state);
  for (s = 2; s <= m; s++) {

    do {
      i = 1;
      while (i <= s) {

        CHighQualityRand::HQRndNormal2(state, u1, u2);
        v[i] = u1;

        if (i + 1 <= s)
          v[i + 1] = u2;
        i = i + 2;
      }

      lambdav = 0.0;
      for (i_ = 1; i_ <= s; i_++)
        lambdav += v[i_] * v[i_];
    } while (lambdav == 0.0);

    CReflections::GenerateReflection(v, s, tau);
    v[1] = 1;

    CReflections::ApplyReflectionFromTheLeft(a, tau, v, m - s, m - 1, 0, n - 1,
                                             w);
  }

  for (i = 0; i < m; i++) {
    tau = 2 * CMath::RandomInteger(2) - 1;
    for (i_ = 0; i_ < n; i_++)
      a[i].Set(i_, tau * a[i][i_]);
  }
}

static void CMatGen::CMatrixRndOrthogonalFromTheRight(CMatrixComplex &a,
                                                      const int m,
                                                      const int n) {

  al_complex zero = 0;
  al_complex lambdav = 0;
  al_complex tau = 0;
  int s = 0;
  int i = 0;
  int i_ = 0;

  al_complex w[];
  al_complex v[];

  CHighQualityRandState state;

  if (!CAp::Assert(n >= 1 && m >= 1, __FUNCTION__ + ": N<1 or M<1!"))
    return;

  if (n == 1) {

    CHighQualityRand::HQRndRandomize(state);

    CHighQualityRand::HQRndUnit2(state, tau.re, tau.im);
    for (i = 0; i < m; i++)
      a[i].Set(0, a[i][0] * tau);

    return;
  }

  ArrayResizeAL(w, m);
  ArrayResizeAL(v, n + 1);

  CHighQualityRand::HQRndRandomize(state);
  for (s = 2; s <= n; s++) {

    do {
      for (i = 1; i <= s; i++) {

        CHighQualityRand::HQRndNormal2(state, tau.re, tau.im);
        v[i] = tau;
      }

      lambdav = 0.0;
      for (i_ = 1; i_ <= s; i_++)
        lambdav += v[i_] * CMath::Conj(v[i_]);
    } while (lambdav == zero);

    CComplexReflections::ComplexGenerateReflection(v, s, tau);
    v[1] = 1;

    CComplexReflections::ComplexApplyReflectionFromTheRight(a, tau, v, 0, m - 1,
                                                            n - s, n - 1, w);
  }

  for (i = 0; i < n; i++) {

    CHighQualityRand::HQRndUnit2(state, tau.re, tau.im);
    for (i_ = 0; i_ < m; i_++)
      a[i_].Set(i, tau * a[i_][i]);
  }
}

static void CMatGen::CMatrixRndOrthogonalFromTheLeft(CMatrixComplex &a,
                                                     const int m, const int n) {

  al_complex zero = 0;
  al_complex tau = 0;
  al_complex lambdav = 0;
  int s = 0;
  int i = 0;
  int j = 0;
  int i_ = 0;

  al_complex w[];
  al_complex v[];

  CHighQualityRandState state;

  if (!CAp::Assert(n >= 1 && m >= 1, __FUNCTION__ + ": N<1 or M<1!"))
    return;

  if (m == 1) {

    CHighQualityRand::HQRndRandomize(state);

    CHighQualityRand::HQRndUnit2(state, tau.re, tau.im);
    for (j = 0; j < n; j++)
      a[0].Set(j, a[0][j] * tau);

    return;
  }

  ArrayResizeAL(w, n);
  ArrayResizeAL(v, m + 1);

  CHighQualityRand::HQRndRandomize(state);
  for (s = 2; s <= m; s++) {

    do {
      for (i = 1; i <= s; i++) {

        CHighQualityRand::HQRndNormal2(state, tau.re, tau.im);
        v[i] = tau;
      }

      lambdav = 0.0;
      for (i_ = 1; i_ <= s; i_++)
        lambdav += v[i_] * CMath::Conj(v[i_]);
    } while (lambdav == zero);

    CComplexReflections::ComplexGenerateReflection(v, s, tau);
    v[1] = 1;

    CComplexReflections::ComplexApplyReflectionFromTheLeft(a, tau, v, m - s,
                                                           m - 1, 0, n - 1, w);
  }

  for (i = 0; i < m; i++) {

    CHighQualityRand::HQRndUnit2(state, tau.re, tau.im);
    for (i_ = 0; i_ < n; i_++)
      a[i].Set(i_, tau * a[i][i_]);
  }
}

static void CMatGen::SMatrixRndMultiply(CMatrixDouble &a, const int n) {

  double tau = 0;
  double lambdav = 0;
  int s = 0;
  int i = 0;
  double u1 = 0;
  double u2 = 0;
  int i_ = 0;

  double w[];
  double v[];

  CHighQualityRandState state;

  ArrayResizeAL(w, n);
  ArrayResizeAL(v, n + 1);

  CHighQualityRand::HQRndRandomize(state);
  for (s = 2; s <= n; s++) {

    do {
      i = 1;
      while (i <= s) {

        CHighQualityRand::HQRndNormal2(state, u1, u2);
        v[i] = u1;

        if (i + 1 <= s)
          v[i + 1] = u2;
        i = i + 2;
      }

      lambdav = 0.0;
      for (i_ = 1; i_ <= s; i_++)
        lambdav += v[i_] * v[i_];
    } while (lambdav == 0.0);

    CReflections::GenerateReflection(v, s, tau);
    v[1] = 1;

    CReflections::ApplyReflectionFromTheRight(a, tau, v, 0, n - 1, n - s, n - 1,
                                              w);

    CReflections::ApplyReflectionFromTheLeft(a, tau, v, n - s, n - 1, 0, n - 1,
                                             w);
  }

  for (i = 0; i < n; i++) {
    tau = 2 * CMath::RandomInteger(2) - 1;
    for (i_ = 0; i_ < n; i_++)
      a[i_].Set(i, tau * a[i_][i]);
    for (i_ = 0; i_ < n; i_++)
      a[i].Set(i_, tau * a[i][i_]);
  }
}

static void CMatGen::HMatrixRndMultiply(CMatrixComplex &a, const int n) {

  al_complex zero = 0;
  al_complex tau = 0;
  al_complex lambdav = 0;
  int s = 0;
  int i = 0;
  int i_ = 0;

  al_complex w[];
  al_complex v[];

  CHighQualityRandState state;

  ArrayResizeAL(w, n);
  ArrayResizeAL(v, n + 1);

  CHighQualityRand::HQRndRandomize(state);
  for (s = 2; s <= n; s++) {

    do {
      for (i = 1; i <= s; i++) {

        CHighQualityRand::HQRndNormal2(state, tau.re, tau.im);
        v[i] = tau;
      }

      lambdav = 0.0;
      for (i_ = 1; i_ <= s; i_++)
        lambdav += v[i_] * CMath::Conj(v[i_]);
    } while (lambdav == zero);

    CComplexReflections::ComplexGenerateReflection(v, s, tau);
    v[1] = 1;

    CComplexReflections::ComplexApplyReflectionFromTheRight(a, tau, v, 0, n - 1,
                                                            n - s, n - 1, w);

    CComplexReflections::ComplexApplyReflectionFromTheLeft(
        a, CMath::Conj(tau), v, n - s, n - 1, 0, n - 1, w);
  }

  for (i = 0; i < n; i++) {

    CHighQualityRand::HQRndUnit2(state, tau.re, tau.im);
    for (i_ = 0; i_ < n; i_++)
      a[i_].Set(i, tau * a[i_][i]);
    tau = CMath::Conj(tau);
    for (i_ = 0; i_ < n; i_++)
      a[i].Set(i_, tau * a[i][i_]);
  }
}

class CTrFac {
private:
  static void CMatrixLUPRec(CMatrixComplex &a, const int offs, const int m,
                            const int n, int &pivots[], al_complex &tmp[]);
  static void RMatrixLUPRec(CMatrixDouble &a, const int offs, const int m,
                            const int n, int &pivots[], double &tmp[]);
  static void CMatrixPLURec(CMatrixComplex &a, const int offs, const int m,
                            const int n, int &pivots[], al_complex &tmp[]);
  static void RMatrixPLURec(CMatrixDouble &a, const int offs, const int m,
                            const int n, int &pivots[], double &tmp[]);
  static void CMatrixLUP2(CMatrixComplex &a, const int offs, const int m,
                          const int n, int &pivots[], al_complex &tmp[]);
  static void RMatrixLUP2(CMatrixDouble &a, const int offs, const int m,
                          const int n, int &pivots[], double &tmp[]);
  static void CMatrixPLU2(CMatrixComplex &a, const int offs, const int m,
                          const int n, int &pivots[], al_complex &tmp[]);
  static void RMatrixPLU2(CMatrixDouble &a, const int offs, const int m,
                          const int n, int &pivots[], double &tmp[]);
  static bool HPDMatrixCholeskyRec(CMatrixComplex &a, const int offs,
                                   const int n, const bool isupper,
                                   al_complex &tmp[]);
  static bool HPDMatrixCholesky2(CMatrixComplex &aaa, const int offs,
                                 const int n, const bool isupper,
                                 al_complex &tmp[]);
  static bool SPDMatrixCholesky2(CMatrixDouble &aaa, const int offs,
                                 const int n, const bool isupper,
                                 double &tmp[]);

public:
  CTrFac(void);
  ~CTrFac(void);

  static void RMatrixLU(CMatrixDouble &a, const int m, const int n,
                        int &pivots[]);
  static void CMatrixLU(CMatrixComplex &a, const int m, const int n,
                        int &pivots[]);
  static bool HPDMatrixCholesky(CMatrixComplex &a, const int n,
                                const bool isupper);
  static bool SPDMatrixCholesky(CMatrixDouble &a, const int n,
                                const bool isupper);
  static void RMatrixLUP(CMatrixDouble &a, const int m, const int n,
                         int &pivots[]);
  static void CMatrixLUP(CMatrixComplex &a, const int m, const int n,
                         int &pivots[]);
  static void RMatrixPLU(CMatrixDouble &a, const int m, const int n,
                         int &pivots[]);
  static void CMatrixPLU(CMatrixComplex &a, const int m, const int n,
                         int &pivots[]);
  static bool SPDMatrixCholeskyRec(CMatrixDouble &a, const int offs,
                                   const int n, const bool isupper,
                                   double &tmp[]);
};

CTrFac::CTrFac(void) {}

CTrFac::~CTrFac(void) {}

static void CTrFac::RMatrixLU(CMatrixDouble &a, const int m, const int n,
                              int &pivots[]) {

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": incorrect M!"))
    return;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  RMatrixPLU(a, m, n, pivots);
}

static void CTrFac::CMatrixLU(CMatrixComplex &a, const int m, const int n,
                              int &pivots[]) {

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": incorrect M!"))
    return;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  CMatrixPLU(a, m, n, pivots);
}

static bool CTrFac::HPDMatrixCholesky(CMatrixComplex &a, const int n,
                                      const bool isupper) {

  al_complex tmp[];

  if (n < 1)
    return (false);

  return (HPDMatrixCholeskyRec(a, 0, n, isupper, tmp));
}

static bool CTrFac::SPDMatrixCholesky(CMatrixDouble &a, const int n,
                                      const bool isupper) {

  double tmp[];

  if (n < 1)
    return (false);

  return (SPDMatrixCholeskyRec(a, 0, n, isupper, tmp));
}

static void CTrFac::RMatrixLUP(CMatrixDouble &a, const int m, const int n,
                               int &pivots[]) {

  int i = 0;
  int j = 0;
  double mx = 0;
  double v = 0;
  int i_ = 0;

  double tmp[];

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": incorrect M!"))
    return;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  mx = 0;
  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++)
      mx = MathMax(mx, MathAbs(a[i][j]));
  }

  if (mx != 0.0) {
    v = 1 / mx;

    for (i = 0; i < m; i++) {
      for (i_ = 0; i_ < n; i_++)
        a[i].Set(i_, v * a[i][i_]);
    }
  }

  ArrayResizeAL(pivots, MathMin(m, n));
  ArrayResizeAL(tmp, 2 * MathMax(m, n));

  RMatrixLUPRec(a, 0, m, n, pivots, tmp);

  if (mx != 0.0) {
    v = mx;

    for (i = 0; i < m; i++)
      for (i_ = 0; i_ <= MathMin(i, n - 1); i_++)
        a[i].Set(i_, v * a[i][i_]);
  }
}

static void CTrFac::CMatrixLUP(CMatrixComplex &a, const int m, const int n,
                               int &pivots[]) {

  int i = 0;
  int j = 0;
  double mx = 0;
  double v = 0;
  al_complex cV;
  int i_ = 0;

  al_complex tmp[];

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": incorrect M!"))
    return;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  mx = 0;
  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++)
      mx = MathMax(mx, CMath::AbsComplex(a[i][j]));
  }

  if (mx != 0.0) {
    v = 1 / mx;
    cV = v;

    for (i = 0; i < m; i++) {
      for (i_ = 0; i_ < n; i_++)
        a[i].Set(i_, cV * a[i][i_]);
    }
  }

  ArrayResizeAL(pivots, MathMin(m, n));
  ArrayResizeAL(tmp, 2 * MathMax(m, n));

  CMatrixLUPRec(a, 0, m, n, pivots, tmp);

  if (mx != 0.0) {
    v = mx;
    cV = v;

    for (i = 0; i < m; i++) {
      for (i_ = 0; i_ <= MathMin(i, n - 1); i_++)
        a[i].Set(i_, cV * a[i][i_]);
    }
  }
}

static void CTrFac::RMatrixPLU(CMatrixDouble &a, const int m, const int n,
                               int &pivots[]) {

  int i = 0;
  int j = 0;
  double mx = 0;
  double v = 0;
  int i_ = 0;

  double tmp[];

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": incorrect M!"))
    return;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  ArrayResizeAL(tmp, 2 * MathMax(m, n));
  ArrayResizeAL(pivots, MathMin(m, n));

  mx = 0;
  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++)
      mx = MathMax(mx, MathAbs(a[i][j]));
  }

  if (mx != 0.0) {
    v = 1 / mx;

    for (i = 0; i < m; i++) {
      for (i_ = 0; i_ < n; i_++)
        a[i].Set(i_, v * a[i][i_]);
    }
  }

  RMatrixPLURec(a, 0, m, n, pivots, tmp);

  if (mx != 0.0) {
    v = mx;

    for (i = 0; i <= MathMin(m, n) - 1; i++) {
      for (i_ = i; i_ < n; i_++)
        a[i].Set(i_, v * a[i][i_]);
    }
  }
}

static void CTrFac::CMatrixPLU(CMatrixComplex &a, const int m, const int n,
                               int &pivots[]) {

  int i = 0;
  int j = 0;
  double mx = 0;
  al_complex v = 0;
  int i_ = 0;

  al_complex tmp[];

  if (!CAp::Assert(m > 0, __FUNCTION__ + ": incorrect M!"))
    return;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": incorrect N!"))
    return;

  ArrayResizeAL(tmp, 2 * MathMax(m, n));
  ArrayResizeAL(pivots, MathMin(m, n));

  mx = 0;
  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++)
      mx = MathMax(mx, CMath::AbsComplex(a[i][j]));
  }

  if (mx != 0.0) {
    v = 1 / mx;

    for (i = 0; i < m; i++) {
      for (i_ = 0; i_ < n; i_++)
        a[i].Set(i_, v * a[i][i_]);
    }
  }

  CMatrixPLURec(a, 0, m, n, pivots, tmp);

  if (mx != 0.0) {
    v = mx;

    for (i = 0; i <= MathMin(m, n) - 1; i++) {
      for (i_ = i; i_ < n; i_++)
        a[i].Set(i_, v * a[i][i_]);
    }
  }
}

static bool CTrFac::SPDMatrixCholeskyRec(CMatrixDouble &a, const int offs,
                                         const int n, const bool isupper,
                                         double &tmp[]) {

  bool result;
  int n1 = 0;
  int n2 = 0;

  if (n < 1)
    return (false);

  if (CAp::Len(tmp) < 2 * n)
    ArrayResizeAL(tmp, 2 * n);

  if (n == 1) {

    if (a[offs][offs] > 0.0) {
      a[offs].Set(offs, MathSqrt(a[offs][offs]));

      return (true);
    } else {

      return (false);
    }
  }

  if (n <= CAblas::AblasBlockSize()) {

    return (SPDMatrixCholesky2(a, offs, n, isupper, tmp));
  }

  result = true;
  CAblas::AblasSplitLength(a, n, n1, n2);
  result = SPDMatrixCholeskyRec(a, offs, n1, isupper, tmp);

  if (!result) {

    return (result);
  }

  if (n2 > 0) {
    if (isupper) {

      CAblas::RMatrixLeftTrsM(n1, n2, a, offs, offs, isupper, false, 1, a, offs,
                              offs + n1);

      CAblas::RMatrixSyrk(n2, n1, -1.0, a, offs, offs + n1, 1, 1.0, a,
                          offs + n1, offs + n1, isupper);
    } else {

      CAblas::RMatrixRightTrsM(n2, n1, a, offs, offs, isupper, false, 1, a,
                               offs + n1, offs);

      CAblas::RMatrixSyrk(n2, n1, -1.0, a, offs + n1, offs, 0, 1.0, a,
                          offs + n1, offs + n1, isupper);
    }
    result = SPDMatrixCholeskyRec(a, offs + n1, n2, isupper, tmp);

    if (!result) {

      return (result);
    }
  }

  return (result);
}

static void CTrFac::CMatrixLUPRec(CMatrixComplex &a, const int offs,
                                  const int m, const int n, int &pivots[],
                                  al_complex &tmp[]) {

  int i = 0;
  int m1 = 0;
  int m2 = 0;
  int i_ = 0;
  int i1_ = 0;
  al_complex One(1.0, 0.0);
  al_complex _One(-1.0, 0.0);

  if (MathMin(m, n) <= CAblas::AblasComplexBlockSize()) {
    CMatrixLUP2(a, offs, m, n, pivots, tmp);

    return;
  }

  if (m > n) {

    CMatrixLUPRec(a, offs, n, n, pivots, tmp);
    for (i = 0; i < n; i++) {
      i1_ = offs + n;
      for (i_ = 0; i_ < m - n; i_++)
        tmp[i_] = a[i_ + i1_][offs + i];

      for (i_ = offs + n; i_ < offs + m; i_++)
        a[i_].Set(offs + i, a[i_][pivots[offs + i]]);
      i1_ = -(offs + n);
      for (i_ = offs + n; i_ < offs + m; i_++)
        a[i_].Set(pivots[offs + i], tmp[i_ + i1_]);
    }

    CAblas::CMatrixRightTrsM(m - n, n, a, offs, offs, true, true, 0, a,
                             offs + n, offs);

    return;
  }

  CAblas::AblasComplexSplitLength(a, m, m1, m2);

  CMatrixLUPRec(a, offs, m1, n, pivots, tmp);

  if (m2 > 0) {
    for (i = 0; i < m1; i++) {

      if (offs + i != pivots[offs + i]) {
        i1_ = offs + m1;
        for (i_ = 0; i_ < m2; i_++)
          tmp[i_] = a[i_ + i1_][offs + i];

        for (i_ = offs + m1; i_ < offs + m; i_++)
          a[i_].Set(offs + i, a[i_][pivots[offs + i]]);
        i1_ = -(offs + m1);
        for (i_ = offs + m1; i_ < offs + m; i_++)
          a[i_].Set(pivots[offs + i], tmp[i_ + i1_]);
      }
    }

    CAblas::CMatrixRightTrsM(m2, m1, a, offs, offs, true, true, 0, a, offs + m1,
                             offs);

    CAblas::CMatrixGemm(m - m1, n - m1, m1, _One, a, offs + m1, offs, 0, a,
                        offs, offs + m1, 0, One, a, offs + m1, offs + m1);

    CMatrixLUPRec(a, offs + m1, m - m1, n - m1, pivots, tmp);
    for (i = 0; i < m2; i++) {

      if (offs + m1 + i != pivots[offs + m1 + i]) {
        i1_ = offs;
        for (i_ = 0; i_ < m1; i_++)
          tmp[i_] = a[i_ + i1_][offs + m1 + i];

        for (i_ = offs; i_ < offs + m1; i_++)
          a[i_].Set(offs + m1 + i, a[i_][pivots[offs + m1 + i]]);
        i1_ = -offs;
        for (i_ = offs; i_ < offs + m1; i_++)
          a[i_].Set(pivots[offs + m1 + i], tmp[i_ + i1_]);
      }
    }
  }
}

static void CTrFac::RMatrixLUPRec(CMatrixDouble &a, const int offs, const int m,
                                  const int n, int &pivots[], double &tmp[]) {

  int i = 0;
  int m1 = 0;
  int m2 = 0;
  int i_ = 0;
  int i1_ = 0;

  if (MathMin(m, n) <= CAblas::AblasBlockSize()) {
    RMatrixLUP2(a, offs, m, n, pivots, tmp);

    return;
  }

  if (m > n) {

    RMatrixLUPRec(a, offs, n, n, pivots, tmp);
    for (i = 0; i < n; i++) {

      if (offs + i != pivots[offs + i]) {
        i1_ = offs + n;
        for (i_ = 0; i_ < m - n; i_++)
          tmp[i_] = a[i_ + i1_][offs + i];

        for (i_ = offs + n; i_ < offs + m; i_++)
          a[i_].Set(offs + i, a[i_][pivots[offs + i]]);
        i1_ = -(offs + n);
        for (i_ = offs + n; i_ < offs + m; i_++)
          a[i_].Set(pivots[offs + i], tmp[i_ + i1_]);
      }
    }

    CAblas::RMatrixRightTrsM(m - n, n, a, offs, offs, true, true, 0, a,
                             offs + n, offs);

    return;
  }

  CAblas::AblasSplitLength(a, m, m1, m2);

  RMatrixLUPRec(a, offs, m1, n, pivots, tmp);

  if (m2 > 0) {
    for (i = 0; i < m1; i++) {

      if (offs + i != pivots[offs + i]) {
        i1_ = offs + m1;
        for (i_ = 0; i_ < m2; i_++)
          tmp[i_] = a[i_ + i1_][offs + i];

        for (i_ = offs + m1; i_ < offs + m; i_++)
          a[i_].Set(offs + i, a[i_][pivots[offs + i]]);
        i1_ = -(offs + m1);
        for (i_ = offs + m1; i_ < offs + m; i_++)
          a[i_].Set(pivots[offs + i], tmp[i_ + i1_]);
      }
    }

    CAblas::RMatrixRightTrsM(m2, m1, a, offs, offs, true, true, 0, a, offs + m1,
                             offs);

    CAblas::RMatrixGemm(m - m1, n - m1, m1, -1.0, a, offs + m1, offs, 0, a,
                        offs, offs + m1, 0, 1.0, a, offs + m1, offs + m1);

    RMatrixLUPRec(a, offs + m1, m - m1, n - m1, pivots, tmp);
    for (i = 0; i < m2; i++) {

      if (offs + m1 + i != pivots[offs + m1 + i]) {
        i1_ = offs;
        for (i_ = 0; i_ < m1; i_++)
          tmp[i_] = a[i_ + i1_][offs + m1 + i];

        for (i_ = offs; i_ < offs + m1; i_++)
          a[i_].Set(offs + m1 + i, a[i_][pivots[offs + m1 + i]]);
        i1_ = -offs;
        for (i_ = offs; i_ < offs + m1; i_++)
          a[i_].Set(pivots[offs + m1 + i], tmp[i_ + i1_]);
      }
    }
  }
}

static void CTrFac::CMatrixPLURec(CMatrixComplex &a, const int offs,
                                  const int m, const int n, int &pivots[],
                                  al_complex &tmp[]) {

  int i = 0;
  int n1 = 0;
  int n2 = 0;
  int i_ = 0;
  int i1_ = 0;
  al_complex One(1.0, 0.0);
  al_complex _One(-1.0, 0.0);

  if (MathMin(m, n) <= CAblas::AblasComplexBlockSize()) {

    CMatrixPLU2(a, offs, m, n, pivots, tmp);

    return;
  }

  if (n > m) {

    CMatrixPLURec(a, offs, m, m, pivots, tmp);
    for (i = 0; i < m; i++) {
      i1_ = offs + m;
      for (i_ = 0; i_ < n - m; i_++)
        tmp[i_] = a[offs + i][i_ + i1_];

      for (i_ = offs + m; i_ < offs + n; i_++)
        a[offs + i].Set(i_, a[pivots[offs + i]][i_]);
      i1_ = -(offs + m);
      for (i_ = offs + m; i_ < offs + n; i_++)
        a[pivots[offs + i]].Set(i_, tmp[i_ + i1_]);
    }

    CAblas::CMatrixLeftTrsM(m, n - m, a, offs, offs, false, true, 0, a, offs,
                            offs + m);

    return;
  }

  CAblas::AblasComplexSplitLength(a, n, n1, n2);

  CMatrixPLURec(a, offs, m, n1, pivots, tmp);

  if (n2 > 0) {
    for (i = 0; i < n1; i++) {

      if (offs + i != pivots[offs + i]) {
        i1_ = offs + n1;
        for (i_ = 0; i_ < n2; i_++)
          tmp[i_] = a[offs + i][i_ + i1_];

        for (i_ = offs + n1; i_ < offs + n; i_++)
          a[offs + i].Set(i_, a[pivots[offs + i]][i_]);
        i1_ = -(offs + n1);
        for (i_ = offs + n1; i_ < offs + n; i_++)
          a[pivots[offs + i]].Set(i_, tmp[i_ + i1_]);
      }
    }

    CAblas::CMatrixLeftTrsM(n1, n2, a, offs, offs, false, true, 0, a, offs,
                            offs + n1);

    CAblas::CMatrixGemm(m - n1, n - n1, n1, _One, a, offs + n1, offs, 0, a,
                        offs, offs + n1, 0, One, a, offs + n1, offs + n1);

    CMatrixPLURec(a, offs + n1, m - n1, n - n1, pivots, tmp);
    for (i = 0; i < n2; i++) {

      if (offs + n1 + i != pivots[offs + n1 + i]) {
        i1_ = offs;
        for (i_ = 0; i_ < n1; i_++)
          tmp[i_] = a[offs + n1 + i][i_ + i1_];

        for (i_ = offs; i_ < offs + n1; i_++)
          a[offs + n1 + i].Set(i_, a[pivots[offs + n1 + i]][i_]);
        i1_ = -offs;
        for (i_ = offs; i_ < offs + n1; i_++)

          a[pivots[offs + n1 + i]].Set(i_, tmp[i_ + i1_]);
      }
    }
  }
}

static void CTrFac::RMatrixPLURec(CMatrixDouble &a, const int offs, const int m,
                                  const int n, int &pivots[], double &tmp[]) {

  int i = 0;
  int n1 = 0;
  int n2 = 0;
  int i_ = 0;
  int i1_ = 0;

  if (MathMin(m, n) <= CAblas::AblasBlockSize()) {

    RMatrixPLU2(a, offs, m, n, pivots, tmp);

    return;
  }

  if (n > m) {

    RMatrixPLURec(a, offs, m, m, pivots, tmp);
    for (i = 0; i < m; i++) {
      i1_ = offs + m;
      for (i_ = 0; i_ < n - m; i_++)
        tmp[i_] = a[offs + i][i_ + i1_];

      for (i_ = offs + m; i_ < offs + n; i_++)
        a[offs + i].Set(i_, a[pivots[offs + i]][i_]);
      i1_ = -(offs + m);
      for (i_ = offs + m; i_ < offs + n; i_++)
        a[pivots[offs + i]].Set(i_, tmp[i_ + i1_]);
    }

    CAblas::RMatrixLeftTrsM(m, n - m, a, offs, offs, false, true, 0, a, offs,
                            offs + m);

    return;
  }

  CAblas::AblasSplitLength(a, n, n1, n2);

  RMatrixPLURec(a, offs, m, n1, pivots, tmp);

  if (n2 > 0) {
    for (i = 0; i < n1; i++) {

      if (offs + i != pivots[offs + i]) {
        i1_ = offs + n1;
        for (i_ = 0; i_ < n2; i_++)
          tmp[i_] = a[offs + i][i_ + i1_];

        for (i_ = offs + n1; i_ < offs + n; i_++)
          a[offs + i].Set(i_, a[pivots[offs + i]][i_]);
        i1_ = -(offs + n1);
        for (i_ = offs + n1; i_ < offs + n; i_++)
          a[pivots[offs + i]].Set(i_, tmp[i_ + i1_]);
      }
    }

    CAblas::RMatrixLeftTrsM(n1, n2, a, offs, offs, false, true, 0, a, offs,
                            offs + n1);

    CAblas::RMatrixGemm(m - n1, n - n1, n1, -1.0, a, offs + n1, offs, 0, a,
                        offs, offs + n1, 0, 1.0, a, offs + n1, offs + n1);

    RMatrixPLURec(a, offs + n1, m - n1, n - n1, pivots, tmp);
    for (i = 0; i < n2; i++) {

      if (offs + n1 + i != pivots[offs + n1 + i]) {
        i1_ = offs;
        for (i_ = 0; i_ < n1; i_++)
          tmp[i_] = a[offs + n1 + i][i_ + i1_];

        for (i_ = offs; i_ < offs + n1; i_++)
          a[offs + n1 + i].Set(i_, a[pivots[offs + n1 + i]][i_]);
        i1_ = -offs;
        for (i_ = offs; i_ < offs + n1; i_++)
          a[pivots[offs + n1 + i]].Set(i_, tmp[i_ + i1_]);
      }
    }
  }
}

static void CTrFac::CMatrixLUP2(CMatrixComplex &a, const int offs, const int m,
                                const int n, int &pivots[], al_complex &tmp[]) {

  int i = 0;
  int j = 0;
  int jp = 0;
  al_complex s = 0;
  int i_ = 0;
  int i1_ = 0;
  al_complex zero = 0;
  al_complex One(1.0, 0.0);

  if (m == 0 || n == 0)
    return;

  for (j = 0; j <= MathMin(m - 1, n - 1); j++) {

    jp = j;
    for (i = j + 1; i < n; i++) {

      if (CMath::AbsComplex(a[offs + j][offs + i]) >
          CMath::AbsComplex(a[offs + j][offs + jp]))
        jp = i;
    }
    pivots[offs + j] = offs + jp;

    if (jp != j) {
      i1_ = offs;
      for (i_ = 0; i_ < m; i_++)
        tmp[i_] = a[i_ + i1_][offs + j];

      for (i_ = offs; i_ < offs + m; i_++)
        a[i_].Set(offs + j, a[i_][offs + jp]);
      i1_ = -offs;
      for (i_ = offs; i_ < offs + m; i_++)
        a[i_].Set(offs + jp, tmp[i_ + i1_]);
    }

    if (a[offs + j][offs + j] != zero && j + 1 <= n - 1) {
      s = One / a[offs + j][offs + j];
      for (i_ = offs + j + 1; i_ < offs + n; i_++)
        a[offs + j].Set(i_, s * a[offs + j][i_]);
    }

    if (j < MathMin(m - 1, n - 1)) {
      i1_ = offs + j + 1;
      for (i_ = 0; i_ < m - j - 1; i_++)
        tmp[i_] = a[i_ + i1_][offs + j];
      i1_ = (offs + j + 1) - (m);
      for (i_ = m; i_ < m + n - j - 1; i_++) {
        tmp[i_] = a[offs + j][i_ + i1_];
        tmp[i_].re = -tmp[i_].re;
        tmp[i_].im = -tmp[i_].im;
      }

      CAblas::CMatrixRank1(m - j - 1, n - j - 1, a, offs + j + 1, offs + j + 1,
                           tmp, 0, tmp, m);
    }
  }
}

static void CTrFac::RMatrixLUP2(CMatrixDouble &a, const int offs, const int m,
                                const int n, int &pivots[], double &tmp[]) {

  int i = 0;
  int j = 0;
  int jp = 0;
  double s = 0;
  int i_ = 0;
  int i1_ = 0;

  if (m == 0 || n == 0)
    return;

  for (j = 0; j <= MathMin(m - 1, n - 1); j++) {

    jp = j;
    for (i = j + 1; i < n; i++) {
      if (MathAbs(a[offs + j][offs + i]) > MathAbs(a[offs + j][offs + jp]))
        jp = i;
    }
    pivots[offs + j] = offs + jp;

    if (jp != j) {
      i1_ = offs;
      for (i_ = 0; i_ < m; i_++)
        tmp[i_] = a[i_ + i1_][offs + j];

      for (i_ = offs; i_ < offs + m; i_++)
        a[i_].Set(offs + j, a[i_][offs + jp]);
      i1_ = -offs;
      for (i_ = offs; i_ < offs + m; i_++)
        a[i_].Set(offs + jp, tmp[i_ + i1_]);
    }

    if (a[offs + j][offs + j] != 0.0 && j + 1 <= n - 1) {
      s = 1 / a[offs + j][offs + j];
      for (i_ = offs + j + 1; i_ < offs + n; i_++)
        a[offs + j].Set(i_, s * a[offs + j][i_]);
    }

    if (j < MathMin(m - 1, n - 1)) {
      i1_ = offs + j + 1;
      for (i_ = 0; i_ < m - j - 1; i_++)
        tmp[i_] = a[i_ + i1_][offs + j];
      i1_ = (offs + j + 1) - (m);
      for (i_ = m; i_ < m + n - j - 1; i_++)
        tmp[i_] = -a[offs + j][i_ + i1_];

      CAblas::RMatrixRank1(m - j - 1, n - j - 1, a, offs + j + 1, offs + j + 1,
                           tmp, 0, tmp, m);
    }
  }
}

static void CTrFac::CMatrixPLU2(CMatrixComplex &a, const int offs, const int m,
                                const int n, int &pivots[], al_complex &tmp[]) {

  int i = 0;
  int j = 0;
  int jp = 0;
  al_complex s = 0;
  al_complex zero = 0;
  al_complex One(1.0, 0.0);
  int i_ = 0;
  int i1_ = 0;

  if (m == 0 || n == 0)
    return;
  for (j = 0; j <= MathMin(m - 1, n - 1); j++) {

    jp = j;
    for (i = j + 1; i < m; i++) {

      if (CMath::AbsComplex(a[offs + i][offs + j]) >
          CMath::AbsComplex(a[offs + jp][offs + j]))
        jp = i;
    }
    pivots[offs + j] = offs + jp;
    if (a[offs + jp][offs + j] != zero) {

      if (jp != j) {
        for (i = 0; i < n; i++) {
          s = a[offs + j][offs + i];
          a[offs + j].Set(offs + i, a[offs + jp][offs + i]);
          a[offs + jp].Set(offs + i, s);
        }
      }

      if (j + 1 <= m - 1) {
        s = One / a[offs + j][offs + j];
        for (i_ = offs + j + 1; i_ < offs + m; i_++)
          a[i_].Set(offs + j, s * a[i_][offs + j]);
      }
    }

    if (j < MathMin(m, n) - 1) {

      i1_ = offs + j + 1;
      for (i_ = 0; i_ < m - j - 1; i_++)
        tmp[i_] = a[i_ + i1_][offs + j];
      i1_ = (offs + j + 1) - (m);
      for (i_ = m; i_ < m + n - j - 1; i_++) {
        tmp[i_] = a[offs + j][i_ + i1_];
        tmp[i_].re = -tmp[i_].re;
        tmp[i_].im = -tmp[i_].im;
      }

      CAblas::CMatrixRank1(m - j - 1, n - j - 1, a, offs + j + 1, offs + j + 1,
                           tmp, 0, tmp, m);
    }
  }
}

static void CTrFac::RMatrixPLU2(CMatrixDouble &a, const int offs, const int m,
                                const int n, int &pivots[], double &tmp[]) {

  int i = 0;
  int j = 0;
  int jp = 0;
  double s = 0;
  int i_ = 0;
  int i1_ = 0;

  if (m == 0 || n == 0)
    return;
  for (j = 0; j <= MathMin(m - 1, n - 1); j++) {

    jp = j;
    for (i = j + 1; i < m; i++) {

      if (MathAbs(a[offs + i][offs + j]) > MathAbs(a[offs + jp][offs + j]))
        jp = i;
    }
    pivots[offs + j] = offs + jp;

    if (a[offs + jp][offs + j] != 0.0) {

      if (jp != j) {
        for (i = 0; i < n; i++) {
          s = a[offs + j][offs + i];
          a[offs + j].Set(offs + i, a[offs + jp][offs + i]);
          a[offs + jp].Set(offs + i, s);
        }
      }

      if (j + 1 <= m - 1) {
        s = 1 / a[offs + j][offs + j];
        for (i_ = offs + j + 1; i_ < offs + m; i_++)
          a[i_].Set(offs + j, s * a[i_][offs + j]);
      }
    }

    if (j < MathMin(m, n) - 1) {

      i1_ = offs + j + 1;
      for (i_ = 0; i_ < m - j - 1; i_++)
        tmp[i_] = a[i_ + i1_][offs + j];
      i1_ = (offs + j + 1) - (m);
      for (i_ = m; i_ < m + n - j - 1; i_++)
        tmp[i_] = -a[offs + j][i_ + i1_];

      CAblas::RMatrixRank1(m - j - 1, n - j - 1, a, offs + j + 1, offs + j + 1,
                           tmp, 0, tmp, m);
    }
  }
}

static bool CTrFac::HPDMatrixCholeskyRec(CMatrixComplex &a, const int offs,
                                         const int n, const bool isupper,
                                         al_complex &tmp[]) {

  bool result;
  int n1 = 0;
  int n2 = 0;

  if (n < 1)
    return (false);

  if (CAp::Len(tmp) < 2 * n)
    ArrayResizeAL(tmp, 2 * n);

  if (n == 1) {

    if (a[offs][offs].re > 0.0) {
      a[offs].Set(offs, MathSqrt(a[offs][offs].re));
      result = true;
    } else {
      result = false;
    }

    return (result);
  }

  if (n <= CAblas::AblasComplexBlockSize()) {
    result = HPDMatrixCholesky2(a, offs, n, isupper, tmp);

    return (result);
  }

  result = true;

  CAblas::AblasComplexSplitLength(a, n, n1, n2);
  result = HPDMatrixCholeskyRec(a, offs, n1, isupper, tmp);

  if (!result)
    return (result);

  if (n2 > 0) {

    if (isupper) {

      CAblas::CMatrixLeftTrsM(n1, n2, a, offs, offs, isupper, false, 2, a, offs,
                              offs + n1);

      CAblas::CMatrixSyrk(n2, n1, -1.0, a, offs, offs + n1, 2, 1.0, a,
                          offs + n1, offs + n1, isupper);
    } else {

      CAblas::CMatrixRightTrsM(n2, n1, a, offs, offs, isupper, false, 2, a,
                               offs + n1, offs);

      CAblas::CMatrixSyrk(n2, n1, -1.0, a, offs + n1, offs, 0, 1.0, a,
                          offs + n1, offs + n1, isupper);
    }
    result = HPDMatrixCholeskyRec(a, offs + n1, n2, isupper, tmp);

    if (!result)
      return (result);
  }

  return (result);
}

static bool CTrFac::HPDMatrixCholesky2(CMatrixComplex &aaa, const int offs,
                                       const int n, const bool isupper,
                                       al_complex &tmp[]) {

  bool result;
  int i = 0;
  int j = 0;
  double ajj = 0;
  al_complex v = 0;
  al_complex cR;
  double r = 0;
  int i_ = 0;
  int i1_ = 0;

  result = true;

  if (n < 0)
    return (false);

  if (n == 0)
    return (result);

  if (isupper) {

    for (j = 0; j < n; j++) {

      v = 0.0;
      for (i_ = offs; i_ < offs + j; i_++)
        v += CMath::Conj(aaa[i_][offs + j]) * aaa[i_][offs + j];
      ajj = (aaa[offs + j][offs + j] - v).re;

      if (ajj <= 0.0) {
        aaa[offs + j].Set(offs + j, ajj);

        return (false);
      }
      ajj = MathSqrt(ajj);
      aaa[offs + j].Set(offs + j, ajj);

      if (j < n - 1) {

        if (j > 0) {
          i1_ = offs;
          for (i_ = 0; i_ < j; i_++) {
            tmp[i_] = CMath::Conj(aaa[i_ + i1_][offs + j]);
            tmp[i_].re = -tmp[i_].re;
            tmp[i_].im = -tmp[i_].im;
          }

          CAblas::CMatrixMVect(n - j - 1, j, aaa, offs, offs + j + 1, 1, tmp, 0,
                               tmp, n);
          i1_ = (n) - (offs + j + 1);
          for (i_ = offs + j + 1; i_ < offs + n; i_++)
            aaa[offs + j].Set(i_, aaa[offs + j][i_] + tmp[i_ + i1_]);
        }
        r = 1 / ajj;
        cR = r;

        for (i_ = offs + j + 1; i_ < offs + n; i_++)
          aaa[offs + j].Set(i_, cR * aaa[offs + j][i_]);
      }
    }
  } else {

    for (j = 0; j < n; j++) {

      v = 0.0;
      for (i_ = offs; i_ < offs + j; i_++)
        v += CMath::Conj(aaa[offs + j][i_]) * aaa[offs + j][i_];
      ajj = (aaa[offs + j][offs + j] - v).re;

      if (ajj <= 0.0) {
        aaa[offs + j].Set(offs + j, ajj);

        return (false);
      }
      ajj = MathSqrt(ajj);
      aaa[offs + j].Set(offs + j, ajj);

      if (j < n - 1) {

        if (j > 0) {
          i1_ = offs;
          for (i_ = 0; i_ < j; i_++)
            tmp[i_] = CMath::Conj(aaa[offs + j][i_ + i1_]);

          CAblas::CMatrixMVect(n - j - 1, j, aaa, offs + j + 1, offs, 0, tmp, 0,
                               tmp, n);
          for (i = 0; i < n - j - 1; i++)
            aaa[offs + j + 1 + i].Set(
                offs + j, (aaa[offs + j + 1 + i][offs + j] - tmp[n + i]) / ajj);
        } else {
          for (i = 0; i < n - j - 1; i++)
            aaa[offs + j + 1 + i].Set(offs + j,
                                      aaa[offs + j + 1 + i][offs + j] / ajj);
        }
      }
    }
  }

  return (result);
}

static bool CTrFac::SPDMatrixCholesky2(CMatrixDouble &aaa, const int offs,
                                       const int n, const bool isupper,
                                       double &tmp[]) {

  bool result;
  int i = 0;
  int j = 0;
  double ajj = 0;
  double v = 0;
  double r = 0;
  int i_ = 0;
  int i1_ = 0;

  result = true;

  if (n < 0)
    return (false);

  if (n == 0)
    return (result);

  if (isupper) {

    for (j = 0; j < n; j++) {

      v = 0.0;
      for (i_ = offs; i_ < offs + j; i_++)
        v += aaa[i_][offs + j] * aaa[i_][offs + j];
      ajj = aaa[offs + j][offs + j] - v;

      if (ajj <= 0.0) {
        aaa[offs + j].Set(offs + j, ajj);
        result = false;

        return (result);
      }
      ajj = MathSqrt(ajj);
      aaa[offs + j].Set(offs + j, ajj);

      if (j < n - 1) {

        if (j > 0) {
          i1_ = offs;
          for (i_ = 0; i_ < j; i_++)
            tmp[i_] = -aaa[i_ + i1_][offs + j];

          CAblas::RMatrixMVect(n - j - 1, j, aaa, offs, offs + j + 1, 1, tmp, 0,
                               tmp, n);
          i1_ = (n) - (offs + j + 1);
          for (i_ = offs + j + 1; i_ < offs + n; i_++)
            aaa[offs + j].Set(i_, aaa[offs + j][i_] + tmp[i_ + i1_]);
        }
        r = 1 / ajj;

        for (i_ = offs + j + 1; i_ < offs + n; i_++)
          aaa[offs + j].Set(i_, r * aaa[offs + j][i_]);
      }
    }
  } else {

    for (j = 0; j < n; j++) {

      v = 0.0;
      for (i_ = offs; i_ < offs + j; i_++)
        v += aaa[offs + j][i_] * aaa[offs + j][i_];
      ajj = aaa[offs + j][offs + j] - v;

      if (ajj <= 0.0) {
        aaa[offs + j].Set(offs + j, ajj);

        return (false);
      }
      ajj = MathSqrt(ajj);
      aaa[offs + j].Set(offs + j, ajj);

      if (j < n - 1) {

        if (j > 0) {
          i1_ = offs;
          for (i_ = 0; i_ < j; i_++)
            tmp[i_] = aaa[offs + j][i_ + i1_];

          CAblas::RMatrixMVect(n - j - 1, j, aaa, offs + j + 1, offs, 0, tmp, 0,
                               tmp, n);
          for (i = 0; i < n - j - 1; i++)
            aaa[offs + j + 1 + i].Set(
                offs + j, (aaa[offs + j + 1 + i][offs + j] - tmp[n + i]) / ajj);
        } else {
          for (i = 0; i < n - j - 1; i++)
            aaa[offs + j + 1 + i].Set(offs + j,
                                      aaa[offs + j + 1 + i][offs + j] / ajj);
        }
      }
    }
  }

  return (result);
}

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
  static void RMatrixEstimateNorm(const int n, double &v[], double &x[],
                                  int &isgn[], double &est, int &kase);
  static void CMatrixEstimateNorm(const int n, al_complex &v[], al_complex &x[],
                                  double &est, int &kase, int &isave[],
                                  double &rsave[]);
  static double InternalComplexRCondScSum1(al_complex &x[], const int n);
  static int InternalComplexRCondIcMax1(al_complex &x[], const int n);
  static void InternalComplexRCondSaveAll(int &isave[], double &rsave[], int &i,
                                          int &iter, int &j, int &jlast,
                                          int &jump, double &absxi,
                                          double &altsgn, double &estold,
                                          double &temp);
  static void InternalComplexRCondLoadAll(int &isave[], double &rsave[], int &i,
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

static double CRCond::RMatrixRCond1(CMatrixDouble &ca, const int n) {

  int i = 0;
  int j = 0;
  double v = 0;
  double nrm = 0;

  int pivots[];
  double t[];

  CMatrixDouble a;
  a = ca;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  ArrayResizeAL(t, n);

  for (i = 0; i < n; i++)
    t[i] = 0;
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      t[j] = t[j] + MathAbs(a[i][j]);
  }

  nrm = 0;
  for (i = 0; i < n; i++)
    nrm = MathMax(nrm, t[i]);

  CTrFac::RMatrixLU(a, n, n, pivots);

  RMatrixRCondLUInternal(a, n, true, true, nrm, v);

  return (v);
}

static double CRCond::RMatrixRCondInf(CMatrixDouble &ca, const int n) {

  int i = 0;
  int j = 0;
  double v = 0;
  double nrm = 0;

  int pivots[];

  CMatrixDouble a;
  a = ca;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  nrm = 0;
  for (i = 0; i < n; i++) {
    v = 0;
    for (j = 0; j < n; j++)
      v = v + MathAbs(a[i][j]);
    nrm = MathMax(nrm, v);
  }

  CTrFac::RMatrixLU(a, n, n, pivots);

  RMatrixRCondLUInternal(a, n, false, true, nrm, v);

  return (v);
}

static double CRCond::SPDMatrixRCond(CMatrixDouble &ca, const int n,
                                     const bool isupper) {

  double result = 0;
  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;
  double v = 0;
  double nrm = 0;

  double t[];

  CMatrixDouble a;
  a = ca;

  ArrayResizeAL(t, n);

  for (i = 0; i < n; i++)
    t[i] = 0;
  for (i = 0; i < n; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }

    for (j = j1; j <= j2; j++) {

      if (i == j)
        t[i] = t[i] + MathAbs(a[i][i]);
      else {
        t[i] = t[i] + MathAbs(a[i][j]);
        t[j] = t[j] + MathAbs(a[i][j]);
      }
    }
  }

  nrm = 0;
  for (i = 0; i < n; i++)
    nrm = MathMax(nrm, t[i]);

  if (CTrFac::SPDMatrixCholesky(a, n, isupper)) {

    SPDMatrixRCondCholeskyInternal(a, n, isupper, true, nrm, v);

    result = v;
  } else
    result = -1;

  return (result);
}

static double CRCond::RMatrixTrRCond1(CMatrixDouble &a, const int n,
                                      const bool isupper, const bool isunit) {

  int i = 0;
  int j = 0;
  double v = 0;
  double nrm = 0;
  int j1 = 0;
  int j2 = 0;

  int pivots[];
  double t[];

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  ArrayResizeAL(t, n);

  for (i = 0; i < n; i++)
    t[i] = 0;
  for (i = 0; i < n; i++) {

    if (isupper) {
      j1 = i + 1;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i - 1;
    }

    for (j = j1; j <= j2; j++)
      t[j] = t[j] + MathAbs(a[i][j]);

    if (isunit)
      t[i] = t[i] + 1;
    else
      t[i] = t[i] + MathAbs(a[i][i]);
  }

  nrm = 0;
  for (i = 0; i < n; i++)
    nrm = MathMax(nrm, t[i]);

  RMatrixRCondTrInternal(a, n, isupper, isunit, true, nrm, v);

  return (v);
}

static double CRCond::RMatrixTrRCondInf(CMatrixDouble &a, const int n,
                                        const bool isupper, const bool isunit) {

  int i = 0;
  int j = 0;
  double v = 0;
  double nrm = 0;
  int j1 = 0;
  int j2 = 0;

  int pivots[];

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  nrm = 0;
  for (i = 0; i < n; i++) {

    if (isupper) {
      j1 = i + 1;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i - 1;
    }

    v = 0;
    for (j = j1; j <= j2; j++)
      v = v + MathAbs(a[i][j]);

    if (isunit)
      v = v + 1;
    else
      v = v + MathAbs(a[i][i]);
    nrm = MathMax(nrm, v);
  }

  RMatrixRCondTrInternal(a, n, isupper, isunit, false, nrm, v);

  return (v);
}

static double CRCond::HPDMatrixRCond(CMatrixComplex &ca, const int n,
                                     const bool isupper) {

  double result = 0;
  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;
  double v = 0;
  double nrm = 0;

  double t[];

  CMatrixComplex a;
  a = ca;

  ArrayResizeAL(t, n);

  for (i = 0; i < n; i++)
    t[i] = 0;
  for (i = 0; i < n; i++) {

    if (isupper) {
      j1 = i;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i;
    }

    for (j = j1; j <= j2; j++) {

      if (i == j)
        t[i] = t[i] + CMath::AbsComplex(a[i][i]);
      else {
        t[i] = t[i] + CMath::AbsComplex(a[i][j]);
        t[j] = t[j] + CMath::AbsComplex(a[i][j]);
      }
    }
  }

  nrm = 0;
  for (i = 0; i < n; i++)
    nrm = MathMax(nrm, t[i]);

  if (CTrFac::HPDMatrixCholesky(a, n, isupper)) {

    HPDMatrixRCondCholeskyInternal(a, n, isupper, true, nrm, v);

    result = v;
  } else
    result = -1;

  return (result);
}

static double CRCond::CMatrixRCond1(CMatrixComplex &ca, const int n) {

  int i = 0;
  int j = 0;
  double v = 0;
  double nrm = 0;

  double t[];
  int pivots[];

  CMatrixComplex a;
  a = ca;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  ArrayResizeAL(t, n);

  for (i = 0; i < n; i++)
    t[i] = 0;
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++)
      t[j] = t[j] + CMath::AbsComplex(a[i][j]);
  }

  nrm = 0;
  for (i = 0; i < n; i++)
    nrm = MathMax(nrm, t[i]);

  CTrFac::CMatrixLU(a, n, n, pivots);

  CMatrixRCondLUInternal(a, n, true, true, nrm, v);

  return (v);
}

static double CRCond::CMatrixRCondInf(CMatrixComplex &ca, const int n) {

  int i = 0;
  int j = 0;
  double v = 0;
  double nrm = 0;

  int pivots[];

  CMatrixComplex a;
  a = ca;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  nrm = 0;
  for (i = 0; i < n; i++) {
    v = 0;
    for (j = 0; j < n; j++)
      v = v + CMath::AbsComplex(a[i][j]);
    nrm = MathMax(nrm, v);
  }

  CTrFac::CMatrixLU(a, n, n, pivots);

  CMatrixRCondLUInternal(a, n, false, true, nrm, v);

  return (v);
}

static double CRCond::RMatrixLURCond1(CMatrixDouble &lua, const int n) {

  double v = 0;

  RMatrixRCondLUInternal(lua, n, true, false, 0, v);

  return (v);
}

static double CRCond::RMatrixLURCondInf(CMatrixDouble &lua, const int n) {

  double v = 0;

  RMatrixRCondLUInternal(lua, n, false, false, 0, v);

  return (v);
}

static double CRCond::SPDMatrixCholeskyRCond(CMatrixDouble &a, const int n,
                                             const bool isupper) {

  double v = 0;

  SPDMatrixRCondCholeskyInternal(a, n, isupper, false, 0, v);

  return (v);
}

static double CRCond::HPDMatrixCholeskyRCond(CMatrixComplex &a, const int n,
                                             const bool isupper) {

  double v = 0;

  HPDMatrixRCondCholeskyInternal(a, n, isupper, false, 0, v);

  return (v);
}

static double CRCond::CMatrixLURCond1(CMatrixComplex &lua, const int n) {

  double v = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  CMatrixRCondLUInternal(lua, n, true, false, 0.0, v);

  return (v);
}

static double CRCond::CMatrixLURCondInf(CMatrixComplex &lua, const int n) {

  double v = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  CMatrixRCondLUInternal(lua, n, false, false, 0.0, v);

  return (v);
}

static double CRCond::CMatrixTrRCond1(CMatrixComplex &a, const int n,
                                      const bool isupper, const bool isunit) {

  int i = 0;
  int j = 0;
  double v = 0;
  double nrm = 0;
  int j1 = 0;
  int j2 = 0;

  int pivots[];
  double t[];

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  ArrayResizeAL(t, n);

  for (i = 0; i < n; i++)
    t[i] = 0;
  for (i = 0; i < n; i++) {

    if (isupper) {
      j1 = i + 1;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i - 1;
    }

    for (j = j1; j <= j2; j++)
      t[j] = t[j] + CMath::AbsComplex(a[i][j]);

    if (isunit)
      t[i] = t[i] + 1;
    else
      t[i] = t[i] + CMath::AbsComplex(a[i][i]);
  }

  nrm = 0;
  for (i = 0; i < n; i++)
    nrm = MathMax(nrm, t[i]);

  CMatrixRCondTrInternal(a, n, isupper, isunit, true, nrm, v);

  return (v);
}

static double CRCond::CMatrixTrRCondInf(CMatrixComplex &a, const int n,
                                        const bool isupper, const bool isunit) {

  int i = 0;
  int j = 0;
  double v = 0;
  double nrm = 0;
  int j1 = 0;
  int j2 = 0;

  int pivots[];

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  nrm = 0;
  for (i = 0; i < n; i++) {

    if (isupper) {
      j1 = i + 1;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i - 1;
    }

    v = 0;
    for (j = j1; j <= j2; j++)
      v = v + CMath::AbsComplex(a[i][j]);

    if (isunit)
      v = v + 1;
    else
      v = v + CMath::AbsComplex(a[i][i]);
    nrm = MathMax(nrm, v);
  }

  CMatrixRCondTrInternal(a, n, isupper, isunit, false, nrm, v);

  return (v);
}

static double CRCond::RCondThreshold(void) {

  return (MathSqrt(MathSqrt(CMath::m_minrealnumber)));
}

static void CRCond::RMatrixRCondTrInternal(CMatrixDouble &a, const int n,
                                           const bool isupper,
                                           const bool isunit,
                                           const bool onenorm, double anorm,
                                           double &rc) {

  int i = 0;
  int j = 0;
  int kase = 0;
  int kase1 = 0;
  int j1 = 0;
  int j2 = 0;
  double ainvnm = 0;
  double maxgrowth = 0;
  double s = 0;
  bool mupper;
  bool mtrans;
  bool munit;

  double ex[];
  double ev[];
  int iwork[];
  double tmp[];

  if (onenorm)
    kase1 = 1;
  else
    kase1 = 2;

  rc = 0;
  mupper = true;
  mtrans = true;
  munit = true;

  ArrayResizeAL(iwork, n + 1);
  ArrayResizeAL(tmp, n);

  maxgrowth = 1 / RCondThreshold();
  s = 0;
  for (i = 0; i < n; i++) {

    if (isupper) {
      j1 = i + 1;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i - 1;
    }

    for (j = j1; j <= j2; j++)
      s = MathMax(s, MathAbs(a[i][j]));

    if (isunit)
      s = MathMax(s, 1);
    else
      s = MathMax(s, MathAbs(a[i][i]));
  }

  if (s == 0.0)
    s = 1;
  s = 1 / s;

  anorm = anorm * s;

  if (anorm == 0.0)
    return;

  if (n == 1) {
    rc = 1;
    return;
  }

  ainvnm = 0;
  kase = 0;
  while (true) {

    RMatrixEstimateNorm(n, ev, ex, iwork, ainvnm, kase);

    if (kase == 0)
      break;

    for (i = 0; i < n; i++)
      ex[i] = ex[i + 1];

    if (kase == kase1) {

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(a, s, n, ex, isupper, 0, isunit,
                                                maxgrowth))
        return;
    } else {

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(a, s, n, ex, isupper, 1, isunit,
                                                maxgrowth))
        return;
    }

    for (i = n - 1; i >= 0; i--)
      ex[i + 1] = ex[i];
  }

  if (ainvnm != 0.0) {
    rc = 1 / ainvnm;
    rc = rc / anorm;

    if (rc < RCondThreshold())
      rc = 0;
  }
}

static void CRCond::CMatrixRCondTrInternal(CMatrixComplex &a, const int n,
                                           const bool isupper,
                                           const bool isunit,
                                           const bool onenorm, double anorm,
                                           double &rc) {

  int kase = 0;
  int kase1 = 0;
  double ainvnm = 0;
  int i = 0;
  int j = 0;
  int j1 = 0;
  int j2 = 0;
  double s = 0;
  double maxgrowth = 0;

  al_complex ex[];
  al_complex cwork2[];
  al_complex cwork3[];
  al_complex cwork4[];
  int isave[];
  double rsave[];

  rc = 0;

  if (n <= 0)
    return;

  if (n == 0) {
    rc = 1;
    return;
  }

  ArrayResizeAL(cwork2, n + 1);

  maxgrowth = 1 / RCondThreshold();
  s = 0;
  for (i = 0; i < n; i++) {

    if (isupper) {
      j1 = i + 1;
      j2 = n - 1;
    } else {
      j1 = 0;
      j2 = i - 1;
    }

    for (j = j1; j <= j2; j++)
      s = MathMax(s, CMath::AbsComplex(a[i][j]));

    if (isunit)
      s = MathMax(s, 1);
    else
      s = MathMax(s, CMath::AbsComplex(a[i][i]));
  }

  if (s == 0.0)
    s = 1;
  s = 1 / s;

  anorm = anorm * s;
  if (anorm == 0.0)
    return;

  ainvnm = 0;

  if (onenorm)
    kase1 = 1;
  else
    kase1 = 2;
  kase = 0;
  while (true) {

    CMatrixEstimateNorm(n, cwork4, ex, ainvnm, kase, isave, rsave);

    if (kase == 0)
      break;

    for (i = 0; i < n; i++)
      ex[i] = ex[i + 1];

    if (kase == kase1) {

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(a, s, n, ex, isupper, 0, isunit,
                                                maxgrowth))
        return;
    } else {

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(a, s, n, ex, isupper, 2, isunit,
                                                maxgrowth))
        return;
    }

    for (i = n - 1; i >= 0; i--)
      ex[i + 1] = ex[i];
  }

  if (ainvnm != 0.0) {
    rc = 1 / ainvnm;
    rc = rc / anorm;

    if (rc < RCondThreshold())
      rc = 0;
  }
}

static void CRCond::SPDMatrixRCondCholeskyInternal(CMatrixDouble &cha,
                                                   const int n,
                                                   const bool isupper,
                                                   const bool isnormprovided,
                                                   double anorm, double &rc) {

  int i = 0;
  int j = 0;
  int kase = 0;
  double ainvnm = 0;
  double sa = 0;
  double v = 0;
  double maxgrowth = 0;
  int i_ = 0;
  int i1_ = 0;

  double ex[];
  double ev[];
  double tmp[];
  int iwork[];

  if (!CAp::Assert(n >= 1))
    return;

  ArrayResizeAL(tmp, n);

  rc = 0;

  maxgrowth = 1 / RCondThreshold();
  sa = 0;

  if (isupper) {
    for (i = 0; i < n; i++)
      for (j = i; j < n; j++)
        sa = MathMax(sa, CMath::AbsComplex(cha[i][j]));
  } else {
    for (i = 0; i < n; i++)
      for (j = 0; j <= i; j++)
        sa = MathMax(sa, CMath::AbsComplex(cha[i][j]));
  }

  if (sa == 0.0)
    sa = 1;
  sa = 1 / sa;

  if (!isnormprovided) {
    kase = 0;
    anorm = 0;
    while (true) {

      RMatrixEstimateNorm(n, ev, ex, iwork, anorm, kase);

      if (kase == 0)
        break;

      if (isupper) {

        for (i = 1; i <= n; i++) {
          i1_ = 1;
          v = 0.0;
          for (i_ = i - 1; i_ < n; i_++)
            v += cha[i - 1][i_] * ex[i_ + i1_];
          ex[i] = v;
        }
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = sa * ex[i_];

        for (i = 0; i < n; i++)
          tmp[i] = 0;
        for (i = 0; i < n; i++) {
          v = ex[i + 1];
          for (i_ = i; i_ < n; i_++)
            tmp[i_] = tmp[i_] + v * cha[i][i_];
        }

        i1_ = -1;
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = tmp[i_ + i1_];
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = sa * ex[i_];
      } else {

        for (i = 0; i < n; i++)
          tmp[i] = 0;
        for (i = 0; i < n; i++) {
          v = ex[i + 1];
          for (i_ = 0; i_ <= i; i_++)
            tmp[i_] = tmp[i_] + v * cha[i][i_];
        }

        i1_ = -1;
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = tmp[i_ + i1_];
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = sa * ex[i_];

        for (i = n; i >= 1; i--) {
          i1_ = 1;
          v = 0.0;
          for (i_ = 0; i_ < i; i_++)
            v += cha[i - 1][i_] * ex[i_ + i1_];
          ex[i] = v;
        }
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = sa * ex[i_];
      }
    }
  }

  if (anorm == 0.0)
    return;

  if (n == 1) {
    rc = 1;
    return;
  }

  kase = 0;
  while (true) {

    RMatrixEstimateNorm(n, ev, ex, iwork, ainvnm, kase);

    if (kase == 0)
      break;
    for (i = 0; i < n; i++)
      ex[i] = ex[i + 1];

    if (isupper) {

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(cha, sa, n, ex, isupper, 1,
                                                false, maxgrowth))
        return;

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(cha, sa, n, ex, isupper, 0,
                                                false, maxgrowth))
        return;
    } else {

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(cha, sa, n, ex, isupper, 0,
                                                false, maxgrowth))
        return;

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(cha, sa, n, ex, isupper, 1,
                                                false, maxgrowth))
        return;
    }
    for (i = n - 1; i >= 0; i--)
      ex[i + 1] = ex[i];
  }

  if (ainvnm != 0.0) {
    v = 1 / ainvnm;
    rc = v / anorm;

    if (rc < RCondThreshold())
      rc = 0;
  }
}

static void CRCond::HPDMatrixRCondCholeskyInternal(CMatrixComplex &cha,
                                                   const int n,
                                                   const bool isupper,
                                                   const bool isnormprovided,
                                                   double anorm, double &rc) {

  al_complex Csa;
  int kase = 0;
  double ainvnm = 0;
  al_complex v = 0;
  int i = 0;
  int j = 0;
  double sa = 0;
  double maxgrowth = 0;
  int i_ = 0;
  int i1_ = 0;

  int isave[];
  double rsave[];
  al_complex ex[];
  al_complex ev[];
  al_complex tmp[];

  if (!CAp::Assert(n >= 1))
    return;

  ArrayResizeAL(tmp, n);

  rc = 0;

  maxgrowth = 1 / RCondThreshold();
  sa = 0;

  if (isupper) {
    for (i = 0; i < n; i++)
      for (j = i; j < n; j++)
        sa = MathMax(sa, CMath::AbsComplex(cha[i][j]));
  } else {
    for (i = 0; i < n; i++)
      for (j = 0; j <= i; j++)
        sa = MathMax(sa, CMath::AbsComplex(cha[i][j]));
  }

  if (sa == 0.0)
    sa = 1;
  sa = 1 / sa;

  if (!isnormprovided) {
    anorm = 0;
    kase = 0;
    while (true) {

      CMatrixEstimateNorm(n, ev, ex, anorm, kase, isave, rsave);

      if (kase == 0)
        break;

      if (isupper) {

        for (i = 1; i <= n; i++) {
          i1_ = 1;
          v = 0.0;
          for (i_ = i - 1; i_ < n; i_++)
            v += cha[i - 1][i_] * ex[i_ + i1_];
          ex[i] = v;
        }
        for (i_ = 1; i_ <= n; i_++) {
          Csa = sa;
          ex[i_] = Csa * ex[i_];
        }

        for (i = 0; i < n; i++)
          tmp[i] = 0;
        for (i = 0; i < n; i++) {
          v = ex[i + 1];
          for (i_ = i; i_ < n; i_++)
            tmp[i_] = tmp[i_] + v * CMath::Conj(cha[i][i_]);
        }

        i1_ = -1;
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = tmp[i_ + i1_];
        for (i_ = 1; i_ <= n; i_++) {
          Csa = sa;
          ex[i_] = Csa * ex[i_];
        }
      } else {

        for (i = 0; i < n; i++)
          tmp[i] = 0;
        for (i = 0; i < n; i++) {
          v = ex[i + 1];
          for (i_ = 0; i_ <= i; i_++)
            tmp[i_] = tmp[i_] + v * CMath::Conj(cha[i][i_]);
        }

        i1_ = -1;
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = tmp[i_ + i1_];
        for (i_ = 1; i_ <= n; i_++) {
          Csa = sa;
          ex[i_] = Csa * ex[i_];
        }

        for (i = n; i >= 1; i--) {
          i1_ = 1;
          v = 0.0;
          for (i_ = 0; i_ < i; i_++)
            v += cha[i - 1][i_] * ex[i_ + i1_];
          ex[i] = v;
        }
        for (i_ = 1; i_ <= n; i_++) {
          Csa = sa;
          ex[i_] = Csa * ex[i_];
        }
      }
    }
  }

  if (anorm == 0.0)
    return;

  if (n == 1) {
    rc = 1;
    return;
  }

  ainvnm = 0;
  kase = 0;
  while (true) {

    CMatrixEstimateNorm(n, ev, ex, ainvnm, kase, isave, rsave);

    if (kase == 0)
      break;
    for (i = 0; i < n; i++)
      ex[i] = ex[i + 1];

    if (isupper) {

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(cha, sa, n, ex, isupper, 2,
                                                false, maxgrowth))
        return;

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(cha, sa, n, ex, isupper, 0,
                                                false, maxgrowth))
        return;
    } else {

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(cha, sa, n, ex, isupper, 0,
                                                false, maxgrowth))
        return;

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(cha, sa, n, ex, isupper, 2,
                                                false, maxgrowth))
        return;
    }
    for (i = n - 1; i >= 0; i--)
      ex[i + 1] = ex[i];
  }

  if (ainvnm != 0.0) {
    rc = 1 / ainvnm;
    rc = rc / anorm;

    if (rc < RCondThreshold())
      rc = 0;
  }
}

static void CRCond::RMatrixRCondLUInternal(CMatrixDouble &lua, const int n,
                                           const bool onenorm,
                                           const bool isanormprovided,
                                           double anorm, double &rc) {

  double v = 0;
  int i = 0;
  int j = 0;
  int kase = 0;
  int kase1 = 0;
  double ainvnm = 0;
  double maxgrowth = 0;
  double su = 0;
  double sl = 0;
  bool mupper;
  bool mtrans;
  bool munit;
  int i_ = 0;
  int i1_ = 0;

  double ex[];
  double ev[];
  int iwork[];
  double tmp[];

  if (onenorm)
    kase1 = 1;
  else
    kase1 = 2;

  rc = 0;
  mupper = true;
  mtrans = true;
  munit = true;

  ArrayResizeAL(iwork, n + 1);
  ArrayResizeAL(tmp, n);

  maxgrowth = 1 / RCondThreshold();
  su = 0;
  sl = 1;
  for (i = 0; i < n; i++) {
    for (j = 0; j < i; j++)
      sl = MathMax(sl, MathAbs(lua[i][j]));
    for (j = i; j < n; j++)
      su = MathMax(su, MathAbs(lua[i][j]));
  }

  if (su == 0.0)
    su = 1;
  su = 1 / su;
  sl = 1 / sl;

  if (!isanormprovided) {
    kase = 0;
    anorm = 0;
    while (true) {

      RMatrixEstimateNorm(n, ev, ex, iwork, anorm, kase);

      if (kase == 0)
        break;

      if (kase == kase1) {

        for (i = 1; i <= n; i++) {
          i1_ = 1;
          v = 0.0;
          for (i_ = i - 1; i_ < n; i_++)
            v += lua[i - 1][i_] * ex[i_ + i1_];
          ex[i] = v;
        }

        for (i = n; i >= 1; i--) {

          if (i > 1) {
            i1_ = 1;
            v = 0.0;
            for (i_ = 0; i_ <= i - 2; i_++)
              v += lua[i - 1][i_] * ex[i_ + i1_];
          } else
            v = 0;
          ex[i] = ex[i] + v;
        }
      } else {

        for (i = 0; i < n; i++)
          tmp[i] = 0;
        for (i = 0; i < n; i++) {
          v = ex[i + 1];

          if (i >= 1) {
            for (i_ = 0; i_ < i; i_++)
              tmp[i_] = tmp[i_] + v * lua[i][i_];
          }
          tmp[i] = tmp[i] + v;
        }

        i1_ = -1;
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = tmp[i_ + i1_];

        for (i = 0; i < n; i++)
          tmp[i] = 0;
        for (i = 0; i < n; i++) {
          v = ex[i + 1];
          for (i_ = i; i_ < n; i_++)
            tmp[i_] = tmp[i_] + v * lua[i][i_];
        }

        i1_ = -1;
        for (i_ = 1; i_ <= n; i_++)
          ex[i_] = tmp[i_ + i1_];
      }
    }
  }

  anorm = anorm * su * sl;

  if (anorm == 0.0)
    return;

  if (n == 1) {
    rc = 1;
    return;
  }

  ainvnm = 0;
  kase = 0;
  while (true) {

    RMatrixEstimateNorm(n, ev, ex, iwork, ainvnm, kase);

    if (kase == 0)
      break;

    for (i = 0; i < n; i++)
      ex[i] = ex[i + 1];

    if (kase == kase1) {

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(lua, sl, n, ex, !mupper, 0,
                                                munit, maxgrowth))
        return;

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(lua, su, n, ex, mupper, 0,
                                                !munit, maxgrowth))
        return;
    } else {

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(lua, su, n, ex, mupper, 1,
                                                !munit, maxgrowth))
        return;

      if (!CSafeSolve::RMatrixScaledTrSafeSolve(lua, sl, n, ex, !mupper, 1,
                                                munit, maxgrowth))
        return;
    }

    for (i = n - 1; i >= 0; i--)
      ex[i + 1] = ex[i];
  }

  if (ainvnm != 0.0) {
    rc = 1 / ainvnm;
    rc = rc / anorm;

    if (rc < RCondThreshold())
      rc = 0;
  }
}

static void CRCond::CMatrixRCondLUInternal(CMatrixComplex &lua, const int n,
                                           const bool onenorm,
                                           const bool isanormprovided,
                                           double anorm, double &rc) {

  int kase = 0;
  int kase1 = 0;
  double ainvnm = 0;
  al_complex v = 0;
  int i = 0;
  int j = 0;
  double su = 0;
  double sl = 0;
  double maxgrowth = 0;
  int i_ = 0;
  int i1_ = 0;

  al_complex ex[];
  al_complex cwork2[];
  al_complex cwork3[];
  al_complex cwork4[];
  int isave[];
  double rsave[];

  if (n <= 0)
    return;

  ArrayResizeAL(cwork2, n + 1);

  rc = 0;

  if (n == 0) {
    rc = 1;
    return;
  }

  maxgrowth = 1 / RCondThreshold();
  su = 0;
  sl = 1;
  for (i = 0; i < n; i++) {
    for (j = 0; j < i; j++)
      sl = MathMax(sl, CMath::AbsComplex(lua[i][j]));
    for (j = i; j < n; j++)
      su = MathMax(su, CMath::AbsComplex(lua[i][j]));
  }

  if (su == 0.0)
    su = 1;
  su = 1 / su;
  sl = 1 / sl;

  if (!isanormprovided) {
    anorm = 0;

    if (onenorm)
      kase1 = 1;
    else
      kase1 = 2;
    kase = 0;
    do {

      CMatrixEstimateNorm(n, cwork4, ex, anorm, kase, isave, rsave);

      if (kase != 0) {

        if (kase == kase1) {

          for (i = 1; i <= n; i++) {
            i1_ = 1;
            v = 0.0;
            for (i_ = i - 1; i_ < n; i_++)
              v += lua[i - 1][i_] * ex[i_ + i1_];
            ex[i] = v;
          }

          for (i = n; i >= 1; i--) {
            v = 0;

            if (i > 1) {
              i1_ = 1;
              v = 0.0;
              for (i_ = 0; i_ <= i - 2; i_++)
                v += lua[i - 1][i_] * ex[i_ + i1_];
            }
            ex[i] = v + ex[i];
          }
        } else {

          for (i = 1; i <= n; i++)
            cwork2[i] = 0;
          for (i = 1; i <= n; i++) {
            v = ex[i];

            if (i > 1) {
              i1_ = -1;
              for (i_ = 1; i_ < i; i_++)
                cwork2[i_] = cwork2[i_] + v * CMath::Conj(lua[i - 1][i_ + i1_]);
            }
            cwork2[i] = cwork2[i] + v;
          }

          for (i = 1; i <= n; i++)
            ex[i] = 0;
          for (i = 1; i <= n; i++) {
            v = cwork2[i];
            i1_ = -1;
            for (i_ = i; i_ <= n; i_++)
              ex[i_] = ex[i_] + v * CMath::Conj(lua[i - 1][i_ + i1_]);
          }
        }
      }
    } while (kase != 0);
  }

  anorm = anorm * su * sl;

  if (anorm == 0.0)
    return;

  ainvnm = 0;

  if (onenorm)
    kase1 = 1;
  else
    kase1 = 2;
  kase = 0;
  while (true) {

    CMatrixEstimateNorm(n, cwork4, ex, ainvnm, kase, isave, rsave);

    if (kase == 0)
      break;

    for (i = 0; i < n; i++)
      ex[i] = ex[i + 1];

    if (kase == kase1) {

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(lua, sl, n, ex, false, 0, true,
                                                maxgrowth)) {
        rc = 0;

        return;
      }

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(lua, su, n, ex, true, 0, false,
                                                maxgrowth)) {
        rc = 0;

        return;
      }
    } else {

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(lua, su, n, ex, true, 2, false,
                                                maxgrowth)) {
        rc = 0;

        return;
      }

      if (!CSafeSolve::CMatrixScaledTrSafeSolve(lua, sl, n, ex, false, 2, true,
                                                maxgrowth)) {
        rc = 0;

        return;
      }
    }

    for (i = n - 1; i >= 0; i--)
      ex[i + 1] = ex[i];
  }

  if (ainvnm != 0.0) {
    rc = 1 / ainvnm;
    rc = rc / anorm;

    if (rc < RCondThreshold())
      rc = 0;
  }
}

static void CRCond::RMatrixEstimateNorm(const int n, double &v[], double &x[],
                                        int &isgn[], double &est, int &kase) {

  int itmax = 0;
  int i = 0;
  double t = 0;
  bool flg;
  int positer = 0;
  int posj = 0;
  int posjlast = 0;
  int posjump = 0;
  int posaltsgn = 0;
  int posestold = 0;
  int postemp = 0;
  int i_ = 0;

  itmax = 5;
  posaltsgn = n + 1;
  posestold = n + 2;
  postemp = n + 3;
  positer = n + 1;
  posj = n + 2;
  posjlast = n + 3;
  posjump = n + 4;

  if (kase == 0) {

    ArrayResizeAL(v, n + 4);
    ArrayResizeAL(x, n + 1);
    ArrayResizeAL(isgn, n + 5);

    t = 1.0 / (double)n;
    for (i = 1; i <= n; i++)
      x[i] = t;
    kase = 1;
    isgn[posjump] = 1;

    return;
  }

  if (isgn[posjump] == 1) {

    if (n == 1) {
      v[1] = x[1];
      est = MathAbs(v[1]);
      kase = 0;

      return;
    }

    est = 0;
    for (i = 1; i <= n; i++)
      est = est + MathAbs(x[i]);
    for (i = 1; i <= n; i++) {

      if (x[i] >= 0.0)
        x[i] = 1;
      else
        x[i] = -1;

      if (x[i] > 0)
        isgn[i] = 1;

      if (x[i] < 0)
        isgn[i] = -1;

      if (x[i] == 0)
        isgn[i] = 0;
    }
    kase = 2;
    isgn[posjump] = 2;

    return;
  }

  if (isgn[posjump] == 2) {
    isgn[posj] = 1;
    for (i = 2; i <= n; i++) {

      if (MathAbs(x[i]) > MathAbs(x[isgn[posj]]))
        isgn[posj] = i;
    }
    isgn[positer] = 2;

    for (i = 1; i <= n; i++)
      x[i] = 0;
    x[isgn[posj]] = 1;
    kase = 1;
    isgn[posjump] = 3;

    return;
  }

  if (isgn[posjump] == 3) {
    for (i_ = 1; i_ <= n; i_++)
      v[i_] = x[i_];
    v[posestold] = est;

    est = 0;
    for (i = 1; i <= n; i++)
      est = est + MathAbs(v[i]);
    flg = false;
    for (i = 1; i <= n; i++) {
      if (((x[i] >= 0.0) && (isgn[i] < 0)) || ((x[i] < 0.0) && (isgn[i] >= 0)))
        flg = true;
    }

    if (!flg || est <= v[posestold]) {
      v[posaltsgn] = 1;
      for (i = 1; i <= n; i++) {
        x[i] = v[posaltsgn] * (1 + (double)(i - 1) / (double)(n - 1));
        v[posaltsgn] = -v[posaltsgn];
      }
      kase = 1;
      isgn[posjump] = 5;

      return;
    }
    for (i = 1; i <= n; i++) {

      if (x[i] >= 0.0) {
        x[i] = 1;
        isgn[i] = 1;
      } else {
        x[i] = -1;
        isgn[i] = -1;
      }
    }
    kase = 2;
    isgn[posjump] = 4;

    return;
  }

  if (isgn[posjump] == 4) {
    isgn[posjlast] = isgn[posj];
    isgn[posj] = 1;
    for (i = 2; i <= n; i++) {

      if (MathAbs(x[i]) > MathAbs(x[isgn[posj]]))
        isgn[posj] = i;
    }

    if (x[isgn[posjlast]] != MathAbs(x[isgn[posj]]) && isgn[positer] < itmax) {
      isgn[positer] = isgn[positer] + 1;
      for (i = 1; i <= n; i++)
        x[i] = 0;
      x[isgn[posj]] = 1;
      kase = 1;
      isgn[posjump] = 3;

      return;
    }

    v[posaltsgn] = 1;
    for (i = 1; i <= n; i++) {
      x[i] = v[posaltsgn] * (1 + (double)(i - 1) / (double)(n - 1));
      v[posaltsgn] = -v[posaltsgn];
    }
    kase = 1;
    isgn[posjump] = 5;

    return;
  }

  if (isgn[posjump] == 5) {
    v[postemp] = 0;
    for (i = 1; i <= n; i++)
      v[postemp] = v[postemp] + MathAbs(x[i]);
    v[postemp] = 2 * v[postemp] / (3 * n);

    if (v[postemp] > est) {
      for (i_ = 1; i_ <= n; i_++)
        v[i_] = x[i_];
      est = v[postemp];
    }
    kase = 0;

    return;
  }
}

static void CRCond::CMatrixEstimateNorm(const int n, al_complex &v[],
                                        al_complex &x[], double &est, int &kase,
                                        int &isave[], double &rsave[]) {

  int itmax = 0;
  int i = 0;
  int iter = 0;
  int j = 0;
  int jlast = 0;
  int jump = 0;
  double absxi = 0;
  double altsgn = 0;
  double estold = 0;
  double safmin = 0;
  double temp = 0;
  int i_ = 0;

  itmax = 5;
  safmin = CMath::m_minrealnumber;

  if (kase == 0) {

    ArrayResizeAL(v, n + 1);
    ArrayResizeAL(x, n + 1);
    ArrayResizeAL(isave, 5);
    ArrayResizeAL(rsave, 4);
    for (i = 1; i <= n; i++)
      x[i] = 1.0 / (double)n;
    kase = 1;
    jump = 1;

    InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                altsgn, estold, temp);

    return;
  }

  InternalComplexRCondLoadAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                              altsgn, estold, temp);

  if (jump == 1) {

    if (n == 1) {
      v[1] = x[1];

      est = CMath::AbsComplex(v[1]);
      kase = 0;

      InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                  altsgn, estold, temp);

      return;
    }

    est = InternalComplexRCondScSum1(x, n);
    for (i = 1; i <= n; i++) {

      absxi = CMath::AbsComplex(x[i]);

      if (absxi > safmin)
        x[i] = x[i] / absxi;
      else
        x[i] = 1;
    }
    kase = 2;
    jump = 2;

    InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                altsgn, estold, temp);

    return;
  }

  if (jump == 2) {
    j = InternalComplexRCondIcMax1(x, n);
    iter = 2;

    for (i = 1; i <= n; i++)
      x[i] = 0;
    x[j] = 1;
    kase = 1;
    jump = 3;

    InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                altsgn, estold, temp);

    return;
  }

  if (jump == 3) {
    for (i_ = 1; i_ <= n; i_++)
      v[i_] = x[i_];
    estold = est;

    est = InternalComplexRCondScSum1(v, n);

    if (est <= estold) {

      altsgn = 1;
      for (i = 1; i <= n; i++) {
        x[i] = altsgn * (1 + (double)(i - 1) / (double)(n - 1));
        altsgn = -altsgn;
      }
      kase = 1;
      jump = 5;

      InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                  altsgn, estold, temp);

      return;
    }
    for (i = 1; i <= n; i++) {
      absxi = CMath::AbsComplex(x[i]);

      if (absxi > safmin)
        x[i] = x[i] / absxi;
      else
        x[i] = 1;
    }
    kase = 2;
    jump = 4;

    InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                altsgn, estold, temp);

    return;
  }

  if (jump == 4) {
    jlast = j;
    j = InternalComplexRCondIcMax1(x, n);

    if (CMath::AbsComplex(x[jlast]) != CMath::AbsComplex(x[j]) &&
        iter < itmax) {
      iter = iter + 1;

      for (i = 1; i <= n; i++)
        x[i] = 0;
      x[j] = 1;
      kase = 1;
      jump = 3;

      InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                  altsgn, estold, temp);

      return;
    }

    altsgn = 1;
    for (i = 1; i <= n; i++) {
      x[i] = altsgn * (1 + (double)(i - 1) / (double)(n - 1));
      altsgn = -altsgn;
    }
    kase = 1;
    jump = 5;

    InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                altsgn, estold, temp);

    return;
  }

  if (jump == 5) {
    temp = 2 * (InternalComplexRCondScSum1(x, n) / (3 * n));

    if (temp > est) {
      for (i_ = 1; i_ <= n; i_++)
        v[i_] = x[i_];
      est = temp;
    }
    kase = 0;

    InternalComplexRCondSaveAll(isave, rsave, i, iter, j, jlast, jump, absxi,
                                altsgn, estold, temp);

    return;
  }
}

static double CRCond::InternalComplexRCondScSum1(al_complex &x[], const int n) {

  double result = 0;
  int i = 0;

  for (i = 1; i <= n; i++)
    result = result + CMath::AbsComplex(x[i]);

  return (result);
}

static int CRCond::InternalComplexRCondIcMax1(al_complex &x[], const int n) {

  int result = 0;
  int i = 0;
  double m = 0;

  result = 1;
  m = CMath::AbsComplex(x[1]);
  for (i = 2; i <= n; i++) {

    if (CMath::AbsComplex(x[i]) > m) {
      result = i;
      m = CMath::AbsComplex(x[i]);
    }
  }

  return (result);
}

static void CRCond::InternalComplexRCondSaveAll(int &isave[], double &rsave[],
                                                int &i, int &iter, int &j,
                                                int &jlast, int &jump,
                                                double &absxi, double &altsgn,
                                                double &estold, double &temp) {

  isave[0] = i;
  isave[1] = iter;
  isave[2] = j;
  isave[3] = jlast;
  isave[4] = jump;

  rsave[0] = absxi;
  rsave[1] = altsgn;
  rsave[2] = estold;
  rsave[3] = temp;
}

static void CRCond::InternalComplexRCondLoadAll(int &isave[], double &rsave[],
                                                int &i, int &iter, int &j,
                                                int &jlast, int &jump,
                                                double &absxi, double &altsgn,
                                                double &estold, double &temp) {

  i = isave[0];
  iter = isave[1];
  j = isave[2];
  jlast = isave[3];
  jump = isave[4];

  absxi = rsave[0];
  altsgn = rsave[1];
  estold = rsave[2];
  temp = rsave[3];
}

class CMatInvReport {
public:
  double m_r1;
  double m_rinf;

  CMatInvReport(void);
  ~CMatInvReport(void);
};

CMatInvReport::CMatInvReport(void) {}

CMatInvReport::~CMatInvReport(void) {}

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

CMatInvReportShell::CMatInvReportShell(void) {}

CMatInvReportShell::CMatInvReportShell(CMatInvReport &obj) {
  m_innerobj.m_r1 = obj.m_r1;
  m_innerobj.m_rinf = obj.m_rinf;
}

CMatInvReportShell::~CMatInvReportShell(void) {}

double CMatInvReportShell::GetR1(void) {
  return (m_innerobj.m_r1);
}

void CMatInvReportShell::SetR1(double r) {
  m_innerobj.m_r1 = r;
}

double CMatInvReportShell::GetRInf(void) {
  return (m_innerobj.m_rinf);
}

void CMatInvReportShell::SetRInf(double r) {
  m_innerobj.m_rinf = r;
}

CMatInvReport *CMatInvReportShell::GetInnerObj(void) {
  return (GetPointer(m_innerobj));
}

class CMatInv {
private:
  static void RMatrixTrInverseRec(CMatrixDouble &a, const int offs, const int n,
                                  const bool isupper, const bool isunit,
                                  double &tmp[], int &info, CMatInvReport &rep);
  static void CMatrixTrInverseRec(CMatrixComplex &a, const int offs,
                                  const int n, const bool isupper,
                                  const bool isunit, al_complex &tmp[],
                                  int &info, CMatInvReport &rep);
  static void RMatrixLUInverseRec(CMatrixDouble &a, const int offs, const int n,
                                  double &work[], int &info,
                                  CMatInvReport &rep);
  static void CMatrixLUInverseRec(CMatrixComplex &a, const int offs,
                                  const int n, al_complex &work[], int &info,
                                  CMatInvReport &rep);
  static void SPDMatrixCholeskyInverseRec(CMatrixDouble &a, const int offs,
                                          const int n, const bool isupper,
                                          double &tmp[]);
  static void HPDMatrixCholeskyInverseRec(CMatrixComplex &a, const int offs,
                                          const int n, const bool isupper,
                                          al_complex &tmp[]);

public:
  CMatInv(void);
  ~CMatInv(void);

  static void RMatrixLUInverse(CMatrixDouble &a, int &pivots[], const int n,
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
  static void CMatrixLUInverse(CMatrixComplex &a, int &pivots[], const int n,
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

CMatInv::CMatInv(void) {}

CMatInv::~CMatInv(void) {}

static void CMatInv::RMatrixLUInverse(CMatrixDouble &a, int &pivots[],
                                      const int n, int &info,
                                      CMatInvReport &rep) {

  int i = 0;
  int j = 0;
  int k = 0;
  double v = 0;

  double work[];

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(pivots) >= n, __FUNCTION__ + ": len(Pivots)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(a, n, n),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  info = 1;
  for (i = 0; i < n; i++) {

    if (pivots[i] > n - 1 || pivots[i] < i)
      info = -1;
  }

  if (!CAp::Assert(info > 0, __FUNCTION__ + ": incorrect Pivots array!"))
    return;

  rep.m_r1 = CRCond::RMatrixLURCond1(a, n);
  rep.m_rinf = CRCond::RMatrixLURCondInf(a, n);

  if (rep.m_r1 < CRCond::RCondThreshold() ||
      rep.m_rinf < CRCond::RCondThreshold()) {
    for (i = 0; i < n; i++) {
      for (j = 0; j < n; j++)
        a[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }

  ArrayResizeAL(work, n);
  RMatrixLUInverseRec(a, 0, n, work, info, rep);

  for (i = 0; i < n; i++) {
    for (j = n - 2; j >= 0; j--) {
      k = pivots[j];
      v = a[i][j];
      a[i].Set(j, a[i][k]);
      a[i].Set(k, v);
    }
  }
}

static void CMatInv::RMatrixInverse(CMatrixDouble &a, const int n, int &info,
                                    CMatInvReport &rep) {

  int pivots[];

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(a, n, n),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  CTrFac::RMatrixLU(a, n, n, pivots);

  RMatrixLUInverse(a, pivots, n, info, rep);
}

static void CMatInv::CMatrixLUInverse(CMatrixComplex &a, int &pivots[],
                                      const int n, int &info,
                                      CMatInvReport &rep) {

  int i = 0;
  int j = 0;
  int k = 0;
  al_complex v = 0;

  al_complex work[];

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Len(pivots) >= n, __FUNCTION__ + ": len(Pivots)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteComplexMatrix(a, n, n),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  info = 1;
  for (i = 0; i < n; i++) {

    if (pivots[i] > n - 1 || pivots[i] < i)
      info = -1;
  }

  if (!CAp::Assert(info > 0, __FUNCTION__ + ": incorrect Pivots array!"))
    return;

  rep.m_r1 = CRCond::CMatrixLURCond1(a, n);
  rep.m_rinf = CRCond::CMatrixLURCondInf(a, n);

  if (rep.m_r1 < CRCond::RCondThreshold() ||
      rep.m_rinf < CRCond::RCondThreshold()) {
    for (i = 0; i < n; i++) {
      for (j = 0; j < n; j++)
        a[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }

  ArrayResizeAL(work, n);
  CMatrixLUInverseRec(a, 0, n, work, info, rep);

  for (i = 0; i < n; i++) {
    for (j = n - 2; j >= 0; j--) {
      k = pivots[j];
      v = a[i][j];
      a[i].Set(j, a[i][k]);
      a[i].Set(k, v);
    }
  }
}

static void CMatInv::CMatrixInverse(CMatrixComplex &a, const int n, int &info,
                                    CMatInvReport &rep) {

  int pivots[];

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteComplexMatrix(a, n, n),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  CTrFac::CMatrixLU(a, n, n, pivots);

  CMatrixLUInverse(a, pivots, n, info, rep);
}

static void CMatInv::SPDMatrixCholeskyInverse(CMatrixDouble &a, const int n,
                                              const bool isupper, int &info,
                                              CMatInvReport &rep) {

  int i = 0;
  int j = 0;
  bool f;

  double tmp[];

  CMatInvReport rep2;

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  info = 1;
  f = true;
  for (i = 0; i < n; i++)
    f = f && CMath::IsFinite(a[i][i]);

  if (!CAp::Assert(f, __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  rep.m_r1 = CRCond::SPDMatrixCholeskyRCond(a, n, isupper);
  rep.m_rinf = rep.m_r1;

  if (rep.m_r1 < CRCond::RCondThreshold() ||
      rep.m_rinf < CRCond::RCondThreshold()) {
    if (isupper) {
      for (i = 0; i < n; i++)
        for (j = i; j < n; j++)
          a[i].Set(j, 0);
    } else {
      for (i = 0; i < n; i++)
        for (j = 0; j <= i; j++)
          a[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }

  ArrayResizeAL(tmp, n);
  SPDMatrixCholeskyInverseRec(a, 0, n, isupper, tmp);
}

static void CMatInv::SPDMatrixInverse(CMatrixDouble &a, const int n,
                                      const bool isupper, int &info,
                                      CMatInvReport &rep) {

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteRTrMatrix(a, n, isupper),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  info = 1;

  if (CTrFac::SPDMatrixCholesky(a, n, isupper))
    SPDMatrixCholeskyInverse(a, n, isupper, info, rep);
  else
    info = -3;
}

static void CMatInv::HPDMatrixCholeskyInverse(CMatrixComplex &a, const int n,
                                              const bool isupper, int &info,
                                              CMatInvReport &rep) {

  int i = 0;
  int j = 0;
  bool f;

  al_complex tmp[];

  CMatInvReport rep2;

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  f = true;
  for (i = 0; i < n; i++)
    f = (f && CMath::IsFinite(a[i][i].re)) && CMath::IsFinite(a[i][i].im);

  if (!CAp::Assert(f, __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;
  info = 1;

  rep.m_r1 = CRCond::HPDMatrixCholeskyRCond(a, n, isupper);
  rep.m_rinf = rep.m_r1;

  if (rep.m_r1 < CRCond::RCondThreshold() ||
      rep.m_rinf < CRCond::RCondThreshold()) {

    if (isupper) {
      for (i = 0; i < n; i++)
        for (j = i; j < n; j++)
          a[i].Set(j, 0);
    } else {
      for (i = 0; i < n; i++)
        for (j = 0; j <= i; j++)
          a[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }

  ArrayResizeAL(tmp, n);
  HPDMatrixCholeskyInverseRec(a, 0, n, isupper, tmp);
}

static void CMatInv::HPDMatrixInverse(CMatrixComplex &a, const int n,
                                      const bool isupper, int &info,
                                      CMatInvReport &rep) {

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteCTrMatrix(a, n, isupper),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  info = 1;

  if (CTrFac::HPDMatrixCholesky(a, n, isupper))
    HPDMatrixCholeskyInverse(a, n, isupper, info, rep);
  else
    info = -3;
}

static void CMatInv::RMatrixTrInverse(CMatrixDouble &a, const int n,
                                      const bool isupper, const bool isunit,
                                      int &info, CMatInvReport &rep) {

  int i = 0;
  int j = 0;

  double tmp[];

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteRTrMatrix(a, n, isupper),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  info = 1;

  rep.m_r1 = CRCond::RMatrixTrRCond1(a, n, isupper, isunit);
  rep.m_rinf = CRCond::RMatrixTrRCondInf(a, n, isupper, isunit);

  if (rep.m_r1 < CRCond::RCondThreshold() ||
      rep.m_rinf < CRCond::RCondThreshold()) {
    for (i = 0; i < n; i++)
      for (j = 0; j < n; j++)
        a[i].Set(j, 0);

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }

  ArrayResizeAL(tmp, n);
  RMatrixTrInverseRec(a, 0, n, isupper, isunit, tmp, info, rep);
}

static void CMatInv::CMatrixTrInverse(CMatrixComplex &a, const int n,
                                      const bool isupper, const bool isunit,
                                      int &info, CMatInvReport &rep) {

  int i = 0;
  int j = 0;

  al_complex tmp[];

  info = 0;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return;

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return;

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteCTrMatrix(a, n, isupper),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return;

  info = 1;

  rep.m_r1 = CRCond::CMatrixTrRCond1(a, n, isupper, isunit);
  rep.m_rinf = CRCond::CMatrixTrRCondInf(a, n, isupper, isunit);

  if (rep.m_r1 < CRCond::RCondThreshold() ||
      rep.m_rinf < CRCond::RCondThreshold()) {
    for (i = 0; i < n; i++) {
      for (j = 0; j < n; j++)
        a[i].Set(j, 0);
    }

    rep.m_r1 = 0;
    rep.m_rinf = 0;
    info = -3;

    return;
  }

  ArrayResizeAL(tmp, n);
  CMatrixTrInverseRec(a, 0, n, isupper, isunit, tmp, info, rep);
}

static void CMatInv::RMatrixTrInverseRec(CMatrixDouble &a, const int offs,
                                         const int n, const bool isupper,
                                         const bool isunit, double &tmp[],
                                         int &info, CMatInvReport &rep) {

  int n1 = 0;
  int n2 = 0;
  int i = 0;
  int j = 0;
  double v = 0;
  double ajj = 0;
  int i_ = 0;
  int i1_ = 0;

  if (n < 1) {
    info = -1;

    return;
  }

  if (n <= CAblas::AblasBlockSize()) {

    if (isupper) {

      for (j = 0; j < n; j++) {

        if (!isunit) {

          if (a[offs + j][offs + j] == 0.0) {
            info = -3;

            return;
          }
          a[offs + j].Set(offs + j, 1 / a[offs + j][offs + j]);
          ajj = -a[offs + j][offs + j];
        } else
          ajj = -1;

        if (j > 0) {
          i1_ = offs;
          for (i_ = 0; i_ < j; i_++)
            tmp[i_] = a[i_ + i1_][offs + j];
          for (i = 0; i < j; i++) {

            if (i < j - 1) {
              i1_ = (i + 1) - (offs + i + 1);
              v = 0.0;
              for (i_ = offs + i + 1; i_ <= offs + j - 1; i_++)
                v += a[offs + i][i_] * tmp[i_ + i1_];
            } else
              v = 0;

            if (!isunit)
              a[offs + i].Set(offs + j, v + a[offs + i][offs + i] * tmp[i]);
            else
              a[offs + i].Set(offs + j, v + tmp[i]);
          }
          for (i_ = offs + 0; i_ <= offs + j - 1; i_++)
            a[i_].Set(offs + j, ajj * a[i_][offs + j]);
        }
      }
    } else {

      for (j = n - 1; j >= 0; j--) {

        if (!isunit) {

          if (a[offs + j][offs + j] == 0.0) {
            info = -3;

            return;
          }
          a[offs + j].Set(offs + j, 1 / a[offs + j][offs + j]);
          ajj = -a[offs + j][offs + j];
        } else
          ajj = -1;

        if (j < n - 1) {

          i1_ = offs;
          for (i_ = j + 1; i_ < n; i_++)
            tmp[i_] = a[i_ + i1_][offs + j];
          for (i = j + 1; i < n; i++) {

            if (i > j + 1) {
              i1_ = -offs;
              v = 0.0;
              for (i_ = offs + j + 1; i_ < offs + i; i_++)
                v += a[offs + i][i_] * tmp[i_ + i1_];
            } else
              v = 0;

            if (!isunit)
              a[offs + i].Set(offs + j, v + a[offs + i][offs + i] * tmp[i]);
            else
              a[offs + i].Set(offs + j, v + tmp[i]);
          }
          for (i_ = offs + j + 1; i_ <= offs + n - 1; i_++)
            a[i_].Set(offs + j, ajj * a[i_][offs + j]);
        }
      }
    }

    return;
  }

  CAblas::AblasSplitLength(a, n, n1, n2);

  if (n2 > 0) {

    if (isupper) {
      for (i = 0; i < n1; i++)
        for (i_ = offs + n1; i_ <= offs + n - 1; i_++)
          a[offs + i].Set(i_, -1 * a[offs + i][i_]);

      CAblas::RMatrixLeftTrsM(n1, n2, a, offs, offs, isupper, isunit, 0, a,
                              offs, offs + n1);

      CAblas::RMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, isupper, isunit,
                               0, a, offs, offs + n1);
    } else {
      for (i = 0; i < n2; i++)
        for (i_ = offs; i_ <= offs + n1 - 1; i_++)
          a[offs + n1 + i].Set(i_, -1 * a[offs + n1 + i][i_]);

      CAblas::RMatrixRightTrsM(n2, n1, a, offs, offs, isupper, isunit, 0, a,
                               offs + n1, offs);

      CAblas::RMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, isupper, isunit,
                              0, a, offs + n1, offs);
    }

    RMatrixTrInverseRec(a, offs + n1, n2, isupper, isunit, tmp, info, rep);
  }

  RMatrixTrInverseRec(a, offs, n1, isupper, isunit, tmp, info, rep);
}

static void CMatInv::CMatrixTrInverseRec(CMatrixComplex &a, const int offs,
                                         const int n, const bool isupper,
                                         const bool isunit, al_complex &tmp[],
                                         int &info, CMatInvReport &rep) {

  al_complex One = 1.0;
  al_complex _One = -1.0;
  int n1 = 0;
  int n2 = 0;
  int i = 0;
  int j = 0;
  al_complex v = 0;
  al_complex ajj = 0;
  int i_ = 0;
  int i1_ = 0;

  if (n < 1) {
    info = -1;

    return;
  }

  if (n <= CAblas::AblasComplexBlockSize()) {

    if (isupper) {

      for (j = 0; j < n; j++) {

        if (!isunit) {

          if (a[offs + j][offs + j] == 0) {
            info = -3;

            return;
          }
          a[offs + j].Set(offs + j, One / a[offs + j][offs + j]);
          ajj = -a[offs + j][offs + j];
        } else
          ajj = -1;

        if (j > 0) {
          i1_ = offs;
          for (i_ = 0; i_ < j; i_++)
            tmp[i_] = a[i_ + i1_][offs + j];
          for (i = 0; i < j; i++) {

            if (i < j - 1) {
              i1_ = (i + 1) - (offs + i + 1);
              v = 0.0;
              for (i_ = offs + i + 1; i_ <= offs + j - 1; i_++)
                v += a[offs + i][i_] * tmp[i_ + i1_];
            } else
              v = 0;

            if (!isunit)
              a[offs + i].Set(offs + j, v + a[offs + i][offs + i] * tmp[i]);
            else
              a[offs + i].Set(offs + j, v + tmp[i]);
          }
          for (i_ = offs + 0; i_ <= offs + j - 1; i_++)
            a[i_].Set(offs + j, ajj * a[i_][offs + j]);
        }
      }
    } else {

      for (j = n - 1; j >= 0; j--) {

        if (!isunit) {

          if (a[offs + j][offs + j] == 0) {
            info = -3;

            return;
          }
          a[offs + j].Set(offs + j, One / a[offs + j][offs + j]);
          ajj = -a[offs + j][offs + j];
        } else
          ajj = -1;

        if (j < n - 1) {

          i1_ = offs;
          for (i_ = j + 1; i_ < n; i_++)
            tmp[i_] = a[i_ + i1_][offs + j];
          for (i = j + 1; i < n; i++) {

            if (i > j + 1) {
              i1_ = -offs;
              v = 0.0;
              for (i_ = offs + j + 1; i_ < offs + i; i_++)
                v += a[offs + i][i_] * tmp[i_ + i1_];
            } else
              v = 0;

            if (!isunit)
              a[offs + i].Set(offs + j, v + a[offs + i][offs + i] * tmp[i]);
            else
              a[offs + i].Set(offs + j, v + tmp[i]);
          }
          for (i_ = offs + j + 1; i_ <= offs + n - 1; i_++)
            a[i_].Set(offs + j, ajj * a[i_][offs + j]);
        }
      }
    }

    return;
  }

  CAblas::AblasComplexSplitLength(a, n, n1, n2);

  if (n2 > 0) {

    if (isupper) {
      for (i = 0; i < n1; i++) {
        for (i_ = offs + n1; i_ <= offs + n - 1; i_++)
          a[offs + i].Set(i_, _One * a[offs + i][i_]);
      }

      CAblas::CMatrixLeftTrsM(n1, n2, a, offs, offs, isupper, isunit, 0, a,
                              offs, offs + n1);

      CAblas::CMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, isupper, isunit,
                               0, a, offs, offs + n1);
    } else {
      for (i = 0; i < n2; i++) {
        for (i_ = offs; i_ <= offs + n1 - 1; i_++)
          a[offs + n1 + i].Set(i_, _One * a[offs + n1 + i][i_]);
      }

      CAblas::CMatrixRightTrsM(n2, n1, a, offs, offs, isupper, isunit, 0, a,
                               offs + n1, offs);

      CAblas::CMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, isupper, isunit,
                              0, a, offs + n1, offs);
    }

    CMatrixTrInverseRec(a, offs + n1, n2, isupper, isunit, tmp, info, rep);
  }

  CMatrixTrInverseRec(a, offs, n1, isupper, isunit, tmp, info, rep);
}

static void CMatInv::RMatrixLUInverseRec(CMatrixDouble &a, const int offs,
                                         const int n, double &work[], int &info,
                                         CMatInvReport &rep) {

  int i = 0;
  int j = 0;
  double v = 0;
  int n1 = 0;
  int n2 = 0;
  int i_ = 0;
  int i1_ = 0;

  if (n < 1) {
    info = -1;

    return;
  }

  if (n <= CAblas::AblasBlockSize()) {

    RMatrixTrInverseRec(a, offs, n, true, false, work, info, rep);

    if (info <= 0)
      return;

    for (j = n - 1; j >= 0; j--) {

      for (i = j + 1; i < n; i++) {
        work[i] = a[offs + i][offs + j];
        a[offs + i].Set(offs + j, 0);
      }

      if (j < n - 1) {
        for (i = 0; i < n; i++) {
          i1_ = -offs;
          v = 0.0;
          for (i_ = offs + j + 1; i_ <= offs + n - 1; i_++)
            v += a[offs + i][i_] * work[i_ + i1_];
          a[offs + i].Set(offs + j, a[offs + i][offs + j] - v);
        }
      }
    }

    return;
  }

  CAblas::AblasSplitLength(a, n, n1, n2);

  if (!CAp::Assert(n2 > 0, __FUNCTION__ + ": internal error!"))
    return;

  CAblas::RMatrixLeftTrsM(n1, n2, a, offs, offs, true, false, 0, a, offs,
                          offs + n1);
  CAblas::RMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, true, false, 0, a,
                           offs, offs + n1);

  CAblas::RMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, false, true, 0, a,
                          offs + n1, offs);
  CAblas::RMatrixRightTrsM(n2, n1, a, offs, offs, false, true, 0, a, offs + n1,
                           offs);

  RMatrixLUInverseRec(a, offs, n1, work, info, rep);

  if (info <= 0)
    return;

  CAblas::RMatrixGemm(n1, n1, n2, 1.0, a, offs, offs + n1, 0, a, offs + n1,
                      offs, 0, 1.0, a, offs, offs);

  CAblas::RMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, false, true, 0, a,
                           offs, offs + n1);
  for (i = 0; i < n1; i++) {
    for (i_ = offs + n1; i_ <= offs + n - 1; i_++)
      a[offs + i].Set(i_, -1 * a[offs + i][i_]);
  }
  CAblas::RMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, true, false, 0, a,
                          offs + n1, offs);
  for (i = 0; i < n2; i++) {
    for (i_ = offs; i_ <= offs + n1 - 1; i_++)
      a[offs + n1 + i].Set(i_, -1 * a[offs + n1 + i][i_]);
  }

  RMatrixLUInverseRec(a, offs + n1, n2, work, info, rep);
}

static void CMatInv::CMatrixLUInverseRec(CMatrixComplex &a, const int offs,
                                         const int n, al_complex &work[],
                                         int &info, CMatInvReport &rep) {

  al_complex One = 1.0;
  al_complex _One = -1.0;
  int i = 0;
  int j = 0;
  al_complex v = 0;
  int n1 = 0;
  int n2 = 0;
  int i_ = 0;
  int i1_ = 0;

  if (n < 1) {
    info = -1;

    return;
  }

  if (n <= CAblas::AblasComplexBlockSize()) {

    CMatrixTrInverseRec(a, offs, n, true, false, work, info, rep);

    if (info <= 0)
      return;

    for (j = n - 1; j >= 0; j--) {

      for (i = j + 1; i < n; i++) {
        work[i] = a[offs + i][offs + j];
        a[offs + i].Set(offs + j, 0);
      }

      if (j < n - 1) {
        for (i = 0; i < n; i++) {
          i1_ = -offs;
          v = 0.0;
          for (i_ = offs + j + 1; i_ <= offs + n - 1; i_++)
            v += a[offs + i][i_] * work[i_ + i1_];
          a[offs + i].Set(offs + j, a[offs + i][offs + j] - v);
        }
      }
    }

    return;
  }

  CAblas::AblasComplexSplitLength(a, n, n1, n2);

  if (!CAp::Assert(n2 > 0, __FUNCTION__ + ": internal error!"))
    return;

  CAblas::CMatrixLeftTrsM(n1, n2, a, offs, offs, true, false, 0, a, offs,
                          offs + n1);
  CAblas::CMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, true, false, 0, a,
                           offs, offs + n1);

  CAblas::CMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, false, true, 0, a,
                          offs + n1, offs);
  CAblas::CMatrixRightTrsM(n2, n1, a, offs, offs, false, true, 0, a, offs + n1,
                           offs);

  CMatrixLUInverseRec(a, offs, n1, work, info, rep);

  if (info <= 0)
    return;
  CAblas::CMatrixGemm(n1, n1, n2, One, a, offs, offs + n1, 0, a, offs + n1,
                      offs, 0, One, a, offs, offs);

  CAblas::CMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, false, true, 0, a,
                           offs, offs + n1);
  for (i = 0; i < n1; i++) {
    for (i_ = offs + n1; i_ <= offs + n - 1; i_++)
      a[offs + i].Set(i_, _One * a[offs + i][i_]);
  }
  CAblas::CMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, true, false, 0, a,
                          offs + n1, offs);
  for (i = 0; i < n2; i++) {
    for (i_ = offs; i_ <= offs + n1 - 1; i_++)
      a[offs + n1 + i].Set(i_, _One * a[offs + n1 + i][i_]);
  }

  CMatrixLUInverseRec(a, offs + n1, n2, work, info, rep);
}

static void CMatInv::SPDMatrixCholeskyInverseRec(CMatrixDouble &a,
                                                 const int offs, const int n,
                                                 const bool isupper,
                                                 double &tmp[]) {

  int i = 0;
  int j = 0;
  double v = 0;
  int n1 = 0;
  int n2 = 0;
  int info2 = 0;
  int i_ = 0;
  int i1_ = 0;

  CMatInvReport rep2;

  if (n < 1)
    return;

  if (n <= CAblas::AblasBlockSize()) {
    RMatrixTrInverseRec(a, offs, n, isupper, false, tmp, info2, rep2);

    if (isupper) {

      for (i = 0; i < n; i++) {

        if (i == 0) {

          a[offs + i].Set(offs + i, CMath::Sqr(a[offs + i][offs + i]));
        } else {

          i1_ = offs;
          for (i_ = 0; i_ <= i - 1; i_++)
            tmp[i_] = a[i_ + i1_][offs + i];
          for (j = 0; j < i; j++) {
            v = a[offs + j][offs + i];
            i1_ = -offs;
            for (i_ = offs + j; i_ < offs + i; i_++)
              a[offs + j].Set(i_, a[offs + j][i_] + v * tmp[i_ + i1_]);
          }

          v = a[offs + i][offs + i];
          for (i_ = offs; i_ < offs + i; i_++)
            a[i_].Set(offs + i, v * a[i_][offs + i]);
          a[offs + i].Set(offs + i, CMath::Sqr(a[offs + i][offs + i]));
        }
      }
    } else {

      for (i = 0; i < n; i++) {

        if (i == 0) {

          a[offs + i].Set(offs + i, CMath::Sqr(a[offs + i][offs + i]));
        } else {

          i1_ = offs;
          for (i_ = 0; i_ <= i - 1; i_++)
            tmp[i_] = a[offs + i][i_ + i1_];
          for (j = 0; j < i; j++) {
            v = a[offs + i][offs + j];
            i1_ = -offs;
            for (i_ = offs; i_ <= offs + j; i_++)
              a[offs + j].Set(i_, a[offs + j][i_] + v * tmp[i_ + i1_]);
          }

          v = a[offs + i][offs + i];
          for (i_ = offs; i_ < offs + i; i_++)
            a[offs + i].Set(i_, v * a[offs + i][i_]);
          a[offs + i].Set(offs + i, CMath::Sqr(a[offs + i][offs + i]));
        }
      }
    }

    return;
  }

  CAblas::AblasSplitLength(a, n, n1, n2);

  if (isupper) {
    for (i = 0; i < n1; i++) {
      for (i_ = offs + n1; i_ <= offs + n - 1; i_++)
        a[offs + i].Set(i_, -1 * a[offs + i][i_]);
    }

    CAblas::RMatrixLeftTrsM(n1, n2, a, offs, offs, isupper, false, 0, a, offs,
                            offs + n1);

    CAblas::RMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, isupper, false, 0,
                             a, offs, offs + n1);
  } else {
    for (i = 0; i < n2; i++) {
      for (i_ = offs; i_ <= offs + n1 - 1; i_++)
        a[offs + n1 + i].Set(i_, -1 * a[offs + n1 + i][i_]);
    }

    CAblas::RMatrixRightTrsM(n2, n1, a, offs, offs, isupper, false, 0, a,
                             offs + n1, offs);

    CAblas::RMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, isupper, false, 0,
                            a, offs + n1, offs);
  }

  SPDMatrixCholeskyInverseRec(a, offs, n1, isupper, tmp);

  if (isupper) {

    CAblas::RMatrixSyrk(n1, n2, 1.0, a, offs, offs + n1, 0, 1.0, a, offs, offs,
                        isupper);

    CAblas::RMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, isupper, false, 1,
                             a, offs, offs + n1);
  } else {

    CAblas::RMatrixSyrk(n1, n2, 1.0, a, offs + n1, offs, 1, 1.0, a, offs, offs,
                        isupper);

    CAblas::RMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, isupper, false, 1,
                            a, offs + n1, offs);
  }

  SPDMatrixCholeskyInverseRec(a, offs + n1, n2, isupper, tmp);
}

static void CMatInv::HPDMatrixCholeskyInverseRec(CMatrixComplex &a,
                                                 const int offs, const int n,
                                                 const bool isupper,
                                                 al_complex &tmp[]) {

  al_complex _One = -1.0;
  int i = 0;
  int j = 0;
  al_complex v = 0;
  int n1 = 0;
  int n2 = 0;
  int info2 = 0;
  int i_ = 0;
  int i1_ = 0;

  CMatInvReport rep2;

  if (n < 1)
    return;

  if (n <= CAblas::AblasComplexBlockSize()) {
    CMatrixTrInverseRec(a, offs, n, isupper, false, tmp, info2, rep2);

    if (isupper) {

      for (i = 0; i < n; i++) {

        if (i == 0) {

          a[offs + i].Set(offs + i, CMath::Sqr(a[offs + i][offs + i].re) +
                                        CMath::Sqr(a[offs + i][offs + i].im));
        } else {

          i1_ = offs;
          for (i_ = 0; i_ <= i - 1; i_++)
            tmp[i_] = CMath::Conj(a[i_ + i1_][offs + i]);
          for (j = 0; j < i; j++) {
            v = a[offs + j][offs + i];
            i1_ = -offs;
            for (i_ = offs + j; i_ < offs + i; i_++)
              a[offs + j].Set(i_, a[offs + j][i_] + v * tmp[i_ + i1_]);
          }

          v = CMath::Conj(a[offs + i][offs + i]);
          for (i_ = offs; i_ < offs + i; i_++)
            a[i_].Set(offs + i, v * a[i_][offs + i]);
          a[offs + i].Set(offs + i, CMath::Sqr(a[offs + i][offs + i].re) +
                                        CMath::Sqr(a[offs + i][offs + i].im));
        }
      }
    } else {

      for (i = 0; i < n; i++) {

        if (i == 0) {

          a[offs + i].Set(offs + i, CMath::Sqr(a[offs + i][offs + i].re) +
                                        CMath::Sqr(a[offs + i][offs + i].im));
        } else {

          i1_ = offs;
          for (i_ = 0; i_ <= i - 1; i_++)
            tmp[i_] = a[offs + i][i_ + i1_];
          for (j = 0; j < i; j++) {
            v = CMath::Conj(a[offs + i][offs + j]);
            i1_ = -offs;
            for (i_ = offs; i_ <= offs + j; i_++)
              a[offs + j].Set(i_, a[offs + j][i_] + v * tmp[i_ + i1_]);
          }
          v = CMath::Conj(a[offs + i][offs + i]);
          for (i_ = offs; i_ < offs + i; i_++)
            a[offs + i].Set(i_, v * a[offs + i][i_]);
          a[offs + i].Set(offs + i, CMath::Sqr(a[offs + i][offs + i].re) +
                                        CMath::Sqr(a[offs + i][offs + i].im));
        }
      }
    }

    return;
  }

  CAblas::AblasComplexSplitLength(a, n, n1, n2);

  if (isupper) {
    for (i = 0; i < n1; i++) {
      for (i_ = offs + n1; i_ <= offs + n - 1; i_++)
        a[offs + i].Set(i_, _One * a[offs + i][i_]);
    }

    CAblas::CMatrixLeftTrsM(n1, n2, a, offs, offs, isupper, false, 0, a, offs,
                            offs + n1);

    CAblas::CMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, isupper, false, 0,
                             a, offs, offs + n1);
  } else {
    for (i = 0; i < n2; i++) {
      for (i_ = offs; i_ <= offs + n1 - 1; i_++)
        a[offs + n1 + i].Set(i_, _One * a[offs + n1 + i][i_]);
    }

    CAblas::CMatrixRightTrsM(n2, n1, a, offs, offs, isupper, false, 0, a,
                             offs + n1, offs);

    CAblas::CMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, isupper, false, 0,
                            a, offs + n1, offs);
  }

  HPDMatrixCholeskyInverseRec(a, offs, n1, isupper, tmp);

  if (isupper) {

    CAblas::CMatrixSyrk(n1, n2, 1.0, a, offs, offs + n1, 0, 1.0, a, offs, offs,
                        isupper);

    CAblas::CMatrixRightTrsM(n1, n2, a, offs + n1, offs + n1, isupper, false, 2,
                             a, offs, offs + n1);
  } else {

    CAblas::CMatrixSyrk(n1, n2, 1.0, a, offs + n1, offs, 2, 1.0, a, offs, offs,
                        isupper);

    CAblas::CMatrixLeftTrsM(n2, n1, a, offs + n1, offs + n1, isupper, false, 2,
                            a, offs + n1, offs);
  }

  HPDMatrixCholeskyInverseRec(a, offs + n1, n2, isupper, tmp);
}

class CBdSingValueDecompose {
private:
  static bool BidiagonalSVDDecompositionInternal(
      double &d[], double &ce[], const int n, const bool isupper,
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

  static bool RMatrixBdSVD(double &d[], double &ce[], const int n,
                           const bool isupper,
                           const bool isfractionalaccuracyrequired,
                           CMatrixDouble &u, const int nru, CMatrixDouble &c,
                           const int ncc, CMatrixDouble &vt, const int ncvt);
  static bool BidiagonalSVDDecomposition(
      double &d[], double &ce[], const int n, const bool isupper,
      const bool isfractionalaccuracyrequired, CMatrixDouble &u, const int nru,
      CMatrixDouble &c, const int ncc, CMatrixDouble &vt, const int ncvt);
};

CBdSingValueDecompose::CBdSingValueDecompose(void) {}

CBdSingValueDecompose::~CBdSingValueDecompose(void) {}

static bool CBdSingValueDecompose::RMatrixBdSVD(
    double &d[], double &ce[], const int n, const bool isupper,
    const bool isfractionalaccuracyrequired, CMatrixDouble &u, const int nru,
    CMatrixDouble &c, const int ncc, CMatrixDouble &vt, const int ncvt) {

  bool result;

  double d1[];
  double e1[];
  int i_ = 0;
  int i1_ = 0;

  double e[];
  ArrayCopy(e, ce);

  ArrayResizeAL(d1, n + 1);

  i1_ = -1;
  for (i_ = 1; i_ <= n; i_++)
    d1[i_] = d[i_ + i1_];

  if (n > 1) {

    ArrayResizeAL(e1, n);

    i1_ = -1;
    for (i_ = 1; i_ < n; i_++)
      e1[i_] = e[i_ + i1_];
  }

  result = BidiagonalSVDDecompositionInternal(d1, e1, n, isupper,
                                              isfractionalaccuracyrequired, u,
                                              0, nru, c, 0, ncc, vt, 0, ncvt);

  i1_ = 1;
  for (i_ = 0; i_ < n; i_++)
    d[i_] = d1[i_ + i1_];

  return (result);
}

static bool CBdSingValueDecompose::BidiagonalSVDDecomposition(
    double &d[], double &ce[], const int n, const bool isupper,
    const bool isfractionalaccuracyrequired, CMatrixDouble &u, const int nru,
    CMatrixDouble &c, const int ncc, CMatrixDouble &vt, const int ncvt) {

  double e[];
  ArrayCopy(e, ce);

  return (BidiagonalSVDDecompositionInternal(d, e, n, isupper,
                                             isfractionalaccuracyrequired, u, 1,
                                             nru, c, 1, ncc, vt, 1, ncvt));
}

static bool CBdSingValueDecompose::BidiagonalSVDDecompositionInternal(
    double &d[], double &ce[], const int n, const bool isupper,
    const bool isfractionalaccuracyrequired, CMatrixDouble &u, const int ustart,
    const int nru, CMatrixDouble &c, const int cstart, const int ncc,
    CMatrixDouble &vt, const int vstart, const int ncvt) {

  bool result;
  int i = 0;
  int idir = 0;
  int isub = 0;
  int iter = 0;
  int j = 0;
  int ll = 0;
  int lll = 0;
  int m = 0;
  int maxit = 0;
  int oldll = 0;
  int oldm = 0;
  double abse = 0;
  double abss = 0;
  double cosl = 0;
  double cosr = 0;
  double cs = 0;
  double eps = 0;
  double f = 0;
  double g = 0;
  double h = 0;
  double mu = 0;
  double oldcs = 0;
  double oldsn = 0;
  double r = 0;
  double shift = 0;
  double sigmn = 0;
  double sigmx = 0;
  double sinl = 0;
  double sinr = 0;
  double sll = 0;
  double smax = 0;
  double smin = 0;
  double sminl = 0;
  double sminlo = 0;
  double sminoa = 0;
  double sn = 0;
  double thresh = 0;
  double tol = 0;
  double tolmul = 0;
  double unfl = 0;
  int maxitr = 0;
  bool matrixsplitflag;
  bool iterflag;
  bool rightside;
  bool fwddir;
  double tmp = 0;
  int mm1 = 0;
  int mm0 = 0;
  bool bchangedir;
  int uend = 0;
  int cend = 0;
  int vend = 0;
  int i_ = 0;

  double work0[];
  double work1[];
  double work2[];
  double work3[];
  double utemp[];
  double vttemp[];
  double ctemp[];
  double etemp[];

  double e[];
  ArrayCopy(e, ce);

  result = true;

  if (n == 0)
    return (true);

  if (n == 1) {

    if (d[1] < 0.0) {
      d[1] = -d[1];

      if (ncvt > 0)
        for (i_ = vstart; i_ <= vstart + ncvt - 1; i_++)
          vt[vstart].Set(i_, -1 * vt[vstart][i_]);
    }

    return (result);
  }

  ll = 0;
  oldsn = 0;

  ArrayResizeAL(work0, n);
  ArrayResizeAL(work1, n);
  ArrayResizeAL(work2, n);
  ArrayResizeAL(work3, n);
  uend = ustart + (int)MathMax(nru - 1, 0);
  vend = vstart + (int)MathMax(ncvt - 1, 0);
  cend = cstart + (int)MathMax(ncc - 1, 0);
  ArrayResizeAL(utemp, uend + 1);
  ArrayResizeAL(vttemp, vend + 1);
  ArrayResizeAL(ctemp, cend + 1);

  maxitr = 12;
  rightside = true;
  fwddir = true;

  ArrayResizeAL(etemp, n + 1);
  for (i = 1; i < n; i++)
    etemp[i] = e[i];
  ArrayResizeAL(e, n + 1);
  for (i = 1; i < n; i++)
    e[i] = etemp[i];
  e[n] = 0;
  idir = 0;

  eps = CMath::m_machineepsilon;
  unfl = CMath::m_minrealnumber;

  if (!isupper) {
    for (i = 1; i < n; i++) {

      CRotations::GenerateRotation(d[i], e[i], cs, sn, r);
      d[i] = r;
      e[i] = sn * d[i + 1];
      d[i + 1] = cs * d[i + 1];
      work0[i] = cs;
      work1[i] = sn;
    }

    if (nru > 0) {

      CRotations::ApplyRotationsFromTheRight(fwddir, ustart, uend,
                                             1 + ustart - 1, n + ustart - 1,
                                             work0, work1, u, utemp);
    }

    if (ncc > 0) {

      CRotations::ApplyRotationsFromTheLeft(fwddir, 1 + cstart - 1,
                                            n + cstart - 1, cstart, cend, work0,
                                            work1, c, ctemp);
    }
  }

  tolmul = MathMax(10, MathMin(100, MathPow(eps, -0.125)));
  tol = tolmul * eps;

  if (!isfractionalaccuracyrequired)
    tol = -tol;

  smax = 0;
  for (i = 1; i <= n; i++)
    smax = MathMax(smax, MathAbs(d[i]));
  for (i = 1; i < n; i++)
    smax = MathMax(smax, MathAbs(e[i]));
  sminl = 0;

  if (tol >= 0.0) {

    sminoa = MathAbs(d[1]);

    if (sminoa != 0.0) {
      mu = sminoa;
      for (i = 2; i <= n; i++) {
        mu = MathAbs(d[i]) * (mu / (mu + MathAbs(e[i - 1])));
        sminoa = MathMin(sminoa, mu);

        if (sminoa == 0.0)
          break;
      }
    }

    sminoa = sminoa / MathSqrt(n);
    thresh = MathMax(tol * sminoa, maxitr * n * n * unfl);
  } else {

    thresh = MathMax(MathAbs(tol) * smax, maxitr * n * n * unfl);
  }

  maxit = maxitr * n * n;
  iter = 0;
  oldll = -1;
  oldm = -1;

  m = n;

  while (true) {

    if (m <= 1)
      break;

    if (iter > maxit)
      return (false);

    if (tol < 0.0 && MathAbs(d[m]) <= thresh)
      d[m] = 0;

    smax = MathAbs(d[m]);
    smin = smax;
    matrixsplitflag = false;
    for (lll = 1; lll <= m - 1; lll++) {
      ll = m - lll;
      abss = MathAbs(d[ll]);
      abse = MathAbs(e[ll]);

      if (tol < 0.0 && abss <= thresh)
        d[ll] = 0;

      if (abse <= thresh) {
        matrixsplitflag = true;
        break;
      }

      smin = MathMin(smin, abss);
      smax = MathMax(smax, MathMax(abss, abse));
    }

    if (!matrixsplitflag)
      ll = 0;
    else {

      e[ll] = 0;

      if (ll == m - 1) {

        m = m - 1;
        continue;
      }
    }
    ll = ll + 1;

    if (ll == m - 1) {

      SVDV2x2(d[m - 1], e[m - 1], d[m], sigmn, sigmx, sinr, cosr, sinl, cosl);
      d[m - 1] = sigmx;
      e[m - 1] = 0;
      d[m] = sigmn;

      if (ncvt > 0) {
        mm0 = m + (vstart - 1);
        mm1 = m - 1 + (vstart - 1);

        for (i_ = vstart; i_ <= vend; i_++)
          vttemp[i_] = cosr * vt[mm1][i_];
        for (i_ = vstart; i_ <= vend; i_++)
          vttemp[i_] = vttemp[i_] + sinr * vt[mm0][i_];
        for (i_ = vstart; i_ <= vend; i_++)
          vt[mm0].Set(i_, cosr * vt[mm0][i_]);
        for (i_ = vstart; i_ <= vend; i_++)
          vt[mm0].Set(i_, vt[mm0][i_] - sinr * vt[mm1][i_]);
        for (i_ = vstart; i_ <= vend; i_++)
          vt[mm1].Set(i_, vttemp[i_]);
      }

      if (nru > 0) {
        mm0 = m + ustart - 1;
        mm1 = m - 1 + ustart - 1;

        for (i_ = ustart; i_ <= uend; i_++)
          utemp[i_] = cosl * u[i_][mm1];
        for (i_ = ustart; i_ <= uend; i_++)
          utemp[i_] = utemp[i_] + sinl * u[i_][mm0];
        for (i_ = ustart; i_ <= uend; i_++)
          u[i_].Set(mm0, cosl * u[i_][mm0]);
        for (i_ = ustart; i_ <= uend; i_++)
          u[i_].Set(mm0, u[i_][mm0] - sinl * u[i_][mm1]);
        for (i_ = ustart; i_ <= uend; i_++)
          u[i_].Set(mm1, utemp[i_]);
      }

      if (ncc > 0) {
        mm0 = m + cstart - 1;
        mm1 = m - 1 + cstart - 1;

        for (i_ = cstart; i_ <= cend; i_++)
          ctemp[i_] = cosl * c[mm1][i_];
        for (i_ = cstart; i_ <= cend; i_++)
          ctemp[i_] = ctemp[i_] + sinl * c[mm0][i_];
        for (i_ = cstart; i_ <= cend; i_++)
          c[mm0].Set(i_, cosl * c[mm0][i_]);
        for (i_ = cstart; i_ <= cend; i_++)
          c[mm0].Set(i_, c[mm0][i_] - sinl * c[mm1][i_]);
        for (i_ = cstart; i_ <= cend; i_++)
          c[mm1].Set(i_, ctemp[i_]);
      }
      m = m - 2;
      continue;
    }

    bchangedir = false;

    if (idir == 1 && MathAbs(d[ll]) < 1.0E-3 * MathAbs(d[m]))
      bchangedir = true;

    if (idir == 2 && MathAbs(d[m]) < 1.0E-3 * MathAbs(d[ll]))
      bchangedir = true;

    if (ll != oldll || m != oldm || bchangedir) {

      if (MathAbs(d[ll]) >= MathAbs(d[m])) {

        idir = 1;
      } else {

        idir = 2;
      }
    }

    if (idir == 1) {

      if (MathAbs(e[m - 1]) <= MathAbs(tol) * MathAbs(d[m]) ||
          (tol < 0.0 && MathAbs(e[m - 1]) <= thresh)) {
        e[m - 1] = 0;
        continue;
      }

      if (tol >= 0.0) {

        mu = MathAbs(d[ll]);
        sminl = mu;
        iterflag = false;
        for (lll = ll; lll <= m - 1; lll++) {

          if (MathAbs(e[lll]) <= tol * mu) {
            e[lll] = 0;
            iterflag = true;

            break;
          }

          sminlo = sminl;
          mu = MathAbs(d[lll + 1]) * (mu / (mu + MathAbs(e[lll])));
          sminl = MathMin(sminl, mu);
        }

        if (iterflag)
          continue;
      }
    } else {

      if (MathAbs(e[ll]) <= MathAbs(tol) * MathAbs(d[ll]) ||
          (tol < 0.0 && MathAbs(e[ll]) <= thresh)) {
        e[ll] = 0;
        continue;
      }

      if (tol >= 0.0) {

        mu = MathAbs(d[m]);
        sminl = mu;
        iterflag = false;
        for (lll = m - 1; lll >= ll; lll--) {

          if (MathAbs(e[lll]) <= (double)(tol * mu)) {
            e[lll] = 0;
            iterflag = true;

            break;
          }
          sminlo = sminl;
          mu = MathAbs(d[lll]) * (mu / (mu + MathAbs(e[lll])));
          sminl = MathMin(sminl, mu);
        }

        if (iterflag)
          continue;
      }
    }

    oldll = ll;
    oldm = m;

    if (tol >= 0.0 && n * tol * (sminl / smax) <= MathMax(eps, 0.01 * tol)) {

      shift = 0;
    } else {

      if (idir == 1) {
        sll = MathAbs(d[ll]);
        SVD2x2(d[m - 1], e[m - 1], d[m], shift, r);
      } else {
        sll = MathAbs(d[m]);
        SVD2x2(d[ll], e[ll], d[ll + 1], shift, r);
      }

      if (sll > 0.0) {

        if (CMath::Sqr(shift / sll) < eps)
          shift = 0;
      }
    }

    iter = iter + m - ll;

    if (shift == 0.0) {

      if (idir == 1) {

        cs = 1;
        oldcs = 1;
        for (i = ll; i < m; i++) {

          CRotations::GenerateRotation(d[i] * cs, e[i], cs, sn, r);

          if (i > ll)
            e[i - 1] = oldsn * r;

          CRotations::GenerateRotation(oldcs * r, d[i + 1] * sn, oldcs, oldsn,
                                       tmp);

          d[i] = tmp;
          work0[i - ll + 1] = cs;
          work1[i - ll + 1] = sn;
          work2[i - ll + 1] = oldcs;
          work3[i - ll + 1] = oldsn;
        }

        h = d[m] * cs;
        d[m] = h * oldcs;
        e[m - 1] = h * oldsn;

        if (ncvt > 0) {

          CRotations::ApplyRotationsFromTheLeft(fwddir, ll + vstart - 1,
                                                m + vstart - 1, vstart, vend,
                                                work0, work1, vt, vttemp);
        }

        if (nru > 0) {

          CRotations::ApplyRotationsFromTheRight(
              fwddir, ustart, uend, ll + ustart - 1, m + ustart - 1, work2,
              work3, u, utemp);
        }

        if (ncc > 0) {

          CRotations::ApplyRotationsFromTheLeft(fwddir, ll + cstart - 1,
                                                m + cstart - 1, cstart, cend,
                                                work2, work3, c, ctemp);
        }

        if (MathAbs(e[m - 1]) <= thresh)
          e[m - 1] = 0;
      } else {

        cs = 1;
        oldcs = 1;
        for (i = m; i >= ll + 1; i--) {

          CRotations::GenerateRotation(d[i] * cs, e[i - 1], cs, sn, r);

          if (i < m)
            e[i] = oldsn * r;

          CRotations::GenerateRotation(oldcs * r, d[i - 1] * sn, oldcs, oldsn,
                                       tmp);

          d[i] = tmp;
          work0[i - ll] = cs;
          work1[i - ll] = -sn;
          work2[i - ll] = oldcs;
          work3[i - ll] = -oldsn;
        }

        h = d[ll] * cs;
        d[ll] = h * oldcs;
        e[ll] = h * oldsn;

        if (ncvt > 0) {

          CRotations::ApplyRotationsFromTheLeft(!fwddir, ll + vstart - 1,
                                                m + vstart - 1, vstart, vend,
                                                work2, work3, vt, vttemp);
        }

        if (nru > 0) {

          CRotations::ApplyRotationsFromTheRight(
              !fwddir, ustart, uend, ll + ustart - 1, m + ustart - 1, work0,
              work1, u, utemp);
        }

        if (ncc > 0) {

          CRotations::ApplyRotationsFromTheLeft(!fwddir, ll + cstart - 1,
                                                m + cstart - 1, cstart, cend,
                                                work0, work1, c, ctemp);
        }

        if (MathAbs(e[ll]) <= thresh)
          e[ll] = 0;
      }
    } else {

      if (idir == 1) {

        f = (MathAbs(d[ll]) - shift) * (ExtSignBdSQR(1, d[ll]) + shift / d[ll]);
        g = e[ll];
        for (i = ll; i < m; i++) {

          CRotations::GenerateRotation(f, g, cosr, sinr, r);

          if (i > ll)
            e[i - 1] = r;

          f = cosr * d[i] + sinr * e[i];
          e[i] = cosr * e[i] - sinr * d[i];
          g = sinr * d[i + 1];
          d[i + 1] = cosr * d[i + 1];

          CRotations::GenerateRotation(f, g, cosl, sinl, r);

          d[i] = r;
          f = cosl * e[i] + sinl * d[i + 1];
          d[i + 1] = cosl * d[i + 1] - sinl * e[i];

          if (i < m - 1) {
            g = sinl * e[i + 1];
            e[i + 1] = cosl * e[i + 1];
          }

          work0[i - ll + 1] = cosr;
          work1[i - ll + 1] = sinr;
          work2[i - ll + 1] = cosl;
          work3[i - ll + 1] = sinl;
        }
        e[m - 1] = f;

        if (ncvt > 0) {

          CRotations::ApplyRotationsFromTheLeft(fwddir, ll + vstart - 1,
                                                m + vstart - 1, vstart, vend,
                                                work0, work1, vt, vttemp);
        }

        if (nru > 0) {

          CRotations::ApplyRotationsFromTheRight(
              fwddir, ustart, uend, ll + ustart - 1, m + ustart - 1, work2,
              work3, u, utemp);
        }

        if (ncc > 0) {

          CRotations::ApplyRotationsFromTheLeft(fwddir, ll + cstart - 1,
                                                m + cstart - 1, cstart, cend,
                                                work2, work3, c, ctemp);
        }

        if (MathAbs(e[m - 1]) <= thresh)
          e[m - 1] = 0;
      } else {

        f = (MathAbs(d[m]) - shift) * (ExtSignBdSQR(1, d[m]) + shift / d[m]);
        g = e[m - 1];
        for (i = m; i >= ll + 1; i--) {

          CRotations::GenerateRotation(f, g, cosr, sinr, r);

          if (i < m)
            e[i] = r;

          f = cosr * d[i] + sinr * e[i - 1];
          e[i - 1] = cosr * e[i - 1] - sinr * d[i];
          g = sinr * d[i - 1];
          d[i - 1] = cosr * d[i - 1];

          CRotations::GenerateRotation(f, g, cosl, sinl, r);

          d[i] = r;
          f = cosl * e[i - 1] + sinl * d[i - 1];
          d[i - 1] = cosl * d[i - 1] - sinl * e[i - 1];

          if (i > ll + 1) {
            g = sinl * e[i - 2];
            e[i - 2] = cosl * e[i - 2];
          }

          work0[i - ll] = cosr;
          work1[i - ll] = -sinr;
          work2[i - ll] = cosl;
          work3[i - ll] = -sinl;
        }
        e[ll] = f;

        if (MathAbs(e[ll]) <= thresh)
          e[ll] = 0;

        if (ncvt > 0) {

          CRotations::ApplyRotationsFromTheLeft(!fwddir, ll + vstart - 1,
                                                m + vstart - 1, vstart, vend,
                                                work2, work3, vt, vttemp);
        }

        if (nru > 0) {

          CRotations::ApplyRotationsFromTheRight(
              !fwddir, ustart, uend, ll + ustart - 1, m + ustart - 1, work0,
              work1, u, utemp);
        }

        if (ncc > 0) {

          CRotations::ApplyRotationsFromTheLeft(!fwddir, ll + cstart - 1,
                                                m + cstart - 1, cstart, cend,
                                                work0, work1, c, ctemp);
        }
      }
    }

    continue;
  }

  for (i = 1; i <= n; i++) {

    if (d[i] < 0.0) {
      d[i] = -d[i];

      if (ncvt > 0) {
        for (i_ = vstart; i_ <= vend; i_++)
          vt[i + vstart - 1].Set(i_, -1 * vt[i + vstart - 1][i_]);
      }
    }
  }

  for (i = 1; i < n; i++) {

    isub = 1;
    smin = d[1];
    for (j = 2; j <= n + 1 - i; j++) {

      if (d[j] <= smin) {
        isub = j;
        smin = d[j];
      }
    }

    if (isub != n + 1 - i) {

      d[isub] = d[n + 1 - i];
      d[n + 1 - i] = smin;

      if (ncvt > 0) {
        j = n + 1 - i;

        for (i_ = vstart; i_ <= vend; i_++)
          vttemp[i_] = vt[isub + vstart - 1][i_];
        for (i_ = vstart; i_ <= vend; i_++)
          vt[isub + vstart - 1].Set(i_, vt[j + vstart - 1][i_]);
        for (i_ = vstart; i_ <= vend; i_++)
          vt[j + vstart - 1].Set(i_, vttemp[i_]);
      }
      if (nru > 0) {
        j = n + 1 - i;

        for (i_ = ustart; i_ <= uend; i_++)
          utemp[i_] = u[i_][isub + ustart - 1];
        for (i_ = ustart; i_ <= uend; i_++)
          u[i_].Set(isub + ustart - 1, u[i_][j + ustart - 1]);
        for (i_ = ustart; i_ <= uend; i_++)
          u[i_].Set(j + ustart - 1, utemp[i_]);
      }

      if (ncc > 0) {
        j = n + 1 - i;

        for (i_ = cstart; i_ <= cend; i_++)
          ctemp[i_] = c[isub + cstart - 1][i_];
        for (i_ = cstart; i_ <= cend; i_++)
          c[isub + cstart - 1].Set(i_, c[j + cstart - 1][i_]);
        for (i_ = cstart; i_ <= cend; i_++)
          c[j + cstart - 1].Set(i_, ctemp[i_]);
      }
    }
  }

  return (result);
}

static double CBdSingValueDecompose::ExtSignBdSQR(const double a,
                                                  const double b) {

  double result = 0;

  if (b >= 0.0)
    result = MathAbs(a);
  else
    result = -MathAbs(a);

  return (result);
}

static void CBdSingValueDecompose::SVD2x2(const double f, const double g,
                                          const double h, double &ssmin,
                                          double &ssmax) {

  double aas = 0;
  double at = 0;
  double au = 0;
  double c = 0;
  double fa = 0;
  double fhmn = 0;
  double fhmx = 0;
  double ga = 0;
  double ha = 0;

  ssmin = 0;
  ssmax = 0;
  fa = MathAbs(f);
  ga = MathAbs(g);
  ha = MathAbs(h);
  fhmn = MathMin(fa, ha);
  fhmx = MathMax(fa, ha);

  if (fhmn == 0.0) {
    ssmin = 0;

    if (fhmx == 0.0)
      ssmax = ga;
    else
      ssmax = MathMax(fhmx, ga) *
              MathSqrt(1 + CMath::Sqr(MathMin(fhmx, ga) / MathMax(fhmx, ga)));
  } else {

    if (ga < fhmx) {

      aas = 1 + fhmn / fhmx;
      at = (fhmx - fhmn) / fhmx;
      au = CMath::Sqr(ga / fhmx);
      c = 2 / (MathSqrt(aas * aas + au) + MathSqrt(at * at + au));
      ssmin = fhmn * c;
      ssmax = fhmx / c;
    } else {
      au = fhmx / ga;

      if (au == 0.0) {

        ssmin = fhmn * fhmx / ga;
        ssmax = ga;
      } else {

        aas = 1 + fhmn / fhmx;
        at = (fhmx - fhmn) / fhmx;
        c = 1 / (MathSqrt(1 + CMath::Sqr(aas * au)) +
                 MathSqrt(1 + CMath::Sqr(at * au)));
        ssmin = fhmn * c * au;
        ssmin = ssmin + ssmin;
        ssmax = ga / (c + c);
      }
    }
  }
}

static void CBdSingValueDecompose::SVDV2x2(const double f, const double g,
                                           const double h, double &ssmin,
                                           double &ssmax, double &snr,
                                           double &csr, double &snl,
                                           double &csl) {

  bool gasmal;
  bool swp;
  int pmax = 0;
  double a = 0;
  double clt = 0;
  double crt = 0;
  double d = 0;
  double fa = 0;
  double ft = 0;
  double ga = 0;
  double gt = 0;
  double ha = 0;
  double ht = 0;
  double l = 0;
  double m = 0;
  double mm = 0;
  double r = 0;
  double s = 0;
  double slt = 0;
  double srt = 0;
  double t = 0;
  double temp = 0;
  double tsign = 0;
  double tt = 0;
  double v = 0;

  ssmin = 0;
  ssmax = 0;
  snr = 0;
  csr = 0;
  snl = 0;
  csl = 0;
  ft = f;
  fa = MathAbs(ft);
  ht = h;
  ha = MathAbs(h);
  clt = 0;
  crt = 0;
  slt = 0;
  srt = 0;
  tsign = 0;

  pmax = 1;
  swp = ha > fa;

  if (swp) {

    pmax = 3;
    temp = ft;
    ft = ht;
    ht = temp;
    temp = fa;
    fa = ha;
    ha = temp;
  }
  gt = g;
  ga = MathAbs(gt);

  if (ga == 0.0) {

    ssmin = ha;
    ssmax = fa;
    clt = 1;
    crt = 1;
    slt = 0;
    srt = 0;
  } else {
    gasmal = true;

    if (ga > fa) {
      pmax = 2;

      if (fa / ga < CMath::m_machineepsilon) {

        gasmal = false;
        ssmax = ga;

        if (ha > 1.0) {
          v = ga / ha;
          ssmin = fa / v;
        } else {
          v = fa / ga;
          ssmin = v * ha;
        }

        clt = 1;
        slt = ht / gt;
        srt = 1;
        crt = ft / gt;
      }
    }

    if (gasmal) {

      d = fa - ha;

      if (d == fa)
        l = 1;
      else
        l = d / fa;

      m = gt / ft;
      t = 2 - l;
      mm = m * m;
      tt = t * t;
      s = MathSqrt(tt + mm);

      if (l == 0.0)
        r = MathAbs(m);
      else
        r = MathSqrt(l * l + mm);

      a = 0.5 * (s + r);
      ssmin = ha / a;
      ssmax = fa * a;

      if (mm == 0.0) {

        if (l == 0.0)
          t = ExtSignBdSQR(2, ft) * ExtSignBdSQR(1, gt);
        else
          t = gt / ExtSignBdSQR(d, ft) + m / t;
      } else
        t = (m / (s + t) + m / (r + l)) * (1 + a);

      l = MathSqrt(t * t + 4);
      crt = 2 / l;
      srt = t / l;
      clt = (crt + srt * m) / a;
      v = ht / ft;
      slt = v * srt / a;
    }
  }

  if (swp) {
    csl = srt;
    snl = crt;
    csr = slt;
    snr = clt;
  } else {
    csl = clt;
    snl = slt;
    csr = crt;
    snr = srt;
  }

  if (pmax == 1)
    tsign = ExtSignBdSQR(1, csr) * ExtSignBdSQR(1, csl) * ExtSignBdSQR(1, f);

  if (pmax == 2)
    tsign = ExtSignBdSQR(1, snr) * ExtSignBdSQR(1, csl) * ExtSignBdSQR(1, g);

  if (pmax == 3)
    tsign = ExtSignBdSQR(1, snr) * ExtSignBdSQR(1, snl) * ExtSignBdSQR(1, h);

  ssmax = ExtSignBdSQR(ssmax, tsign);
  ssmin = ExtSignBdSQR(ssmin, tsign * ExtSignBdSQR(1, f) * ExtSignBdSQR(1, h));
}

class CSingValueDecompose {
public:
  CSingValueDecompose(void);
  ~CSingValueDecompose(void);

  static bool RMatrixSVD(CMatrixDouble &ca, const int m, const int n,
                         const int uneeded, const int vtneeded,
                         const int additionalmemory, double &w[],
                         CMatrixDouble &u, CMatrixDouble &vt);
};

CSingValueDecompose::CSingValueDecompose(void) {}

CSingValueDecompose::~CSingValueDecompose(void) {}

static bool CSingValueDecompose::RMatrixSVD(CMatrixDouble &ca, const int m,
                                            const int n, const int uneeded,
                                            const int vtneeded,
                                            const int additionalmemory,
                                            double &w[], CMatrixDouble &u,
                                            CMatrixDouble &vt) {

  bool result;
  bool isupper;
  int minmn = 0;
  int ncu = 0;
  int nrvt = 0;
  int nru = 0;
  int ncvt = 0;
  int i = 0;
  int j = 0;

  double tauq[];
  double taup[];
  double tau[];
  double e[];
  double work[];

  CMatrixDouble t2;

  CMatrixDouble a;
  a = ca;

  result = true;

  if (m == 0 || n == 0)
    return (true);

  if (!CAp::Assert(uneeded >= 0 && uneeded <= 2,
                   __FUNCTION__ + ": wrong parameters!"))
    return (false);

  if (!CAp::Assert(vtneeded >= 0 && vtneeded <= 2,
                   __FUNCTION__ + ": wrong parameters!"))
    return (false);

  if (!CAp::Assert(additionalmemory >= 0 && additionalmemory <= 2,
                   __FUNCTION__ + ": wrong parameters!"))
    return (false);

  minmn = MathMin(m, n);
  ArrayResizeAL(w, minmn + 1);
  ncu = 0;
  nru = 0;

  if (uneeded == 1) {
    nru = m;
    ncu = minmn;
    u.Resize(nru, ncu);
  }

  if (uneeded == 2) {
    nru = m;
    ncu = m;
    u.Resize(nru, ncu);
  }
  nrvt = 0;
  ncvt = 0;

  if (vtneeded == 1) {
    nrvt = minmn;
    ncvt = n;
    vt.Resize(nrvt, ncvt);
  }

  if (vtneeded == 2) {
    nrvt = n;
    ncvt = n;
    vt.Resize(nrvt, ncvt);
  }

  if ((double)(m) > (double)(1.6 * n)) {

    if (uneeded == 0) {

      COrtFac::RMatrixQR(a, m, n, tau);
      for (i = 0; i < n; i++) {
        for (j = 0; j < i; j++)
          a[i].Set(j, 0);
      }

      COrtFac::RMatrixBD(a, n, n, tauq, taup);

      COrtFac::RMatrixBDUnpackPT(a, n, n, taup, nrvt, vt);

      COrtFac::RMatrixBDUnpackDiagonals(a, n, n, isupper, w, e);

      return (CBdSingValueDecompose::RMatrixBdSVD(w, e, n, isupper, false, u, 0,
                                                  a, 0, vt, ncvt));
    } else {

      COrtFac::RMatrixQR(a, m, n, tau);

      COrtFac::RMatrixQRUnpackQ(a, m, n, tau, ncu, u);
      for (i = 0; i < n; i++) {
        for (j = 0; j < i; j++)
          a[i].Set(j, 0);
      }

      COrtFac::RMatrixBD(a, n, n, tauq, taup);

      COrtFac::RMatrixBDUnpackPT(a, n, n, taup, nrvt, vt);

      COrtFac::RMatrixBDUnpackDiagonals(a, n, n, isupper, w, e);

      if (additionalmemory < 1) {

        COrtFac::RMatrixBDMultiplyByQ(a, n, n, tauq, u, m, n, true, false);

        result = CBdSingValueDecompose::RMatrixBdSVD(w, e, n, isupper, false, u,
                                                     m, a, 0, vt, ncvt);
      } else {

        ArrayResizeAL(work, MathMax(m, n) + 1);

        COrtFac::RMatrixBDUnpackQ(a, n, n, tauq, n, t2);

        CBlas::CopyMatrix(u, 0, m - 1, 0, n - 1, a, 0, m - 1, 0, n - 1);

        CBlas::InplaceTranspose(t2, 0, n - 1, 0, n - 1, work);

        result = CBdSingValueDecompose::RMatrixBdSVD(w, e, n, isupper, false, u,
                                                     0, t2, n, vt, ncvt);

        CBlas::MatrixMatrixMultiply(a, 0, m - 1, 0, n - 1, false, t2, 0, n - 1,
                                    0, n - 1, true, 1.0, u, 0, m - 1, 0, n - 1,
                                    0.0, work);
      }

      return (result);
    }
  }

  if ((double)(n) > (double)(1.6 * m)) {

    if (vtneeded == 0) {

      COrtFac::RMatrixLQ(a, m, n, tau);
      for (i = 0; i <= m - 1; i++) {
        for (j = i + 1; j <= m - 1; j++)
          a[i].Set(j, 0);
      }

      COrtFac::RMatrixBD(a, m, m, tauq, taup);

      COrtFac::RMatrixBDUnpackQ(a, m, m, tauq, ncu, u);

      COrtFac::RMatrixBDUnpackDiagonals(a, m, m, isupper, w, e);
      ArrayResizeAL(work, m + 1);

      CBlas::InplaceTranspose(u, 0, nru - 1, 0, ncu - 1, work);

      result = CBdSingValueDecompose::RMatrixBdSVD(w, e, m, isupper, false, a,
                                                   0, u, nru, vt, 0);

      CBlas::InplaceTranspose(u, 0, nru - 1, 0, ncu - 1, work);

      return (result);
    } else {

      COrtFac::RMatrixLQ(a, m, n, tau);

      COrtFac::RMatrixLQUnpackQ(a, m, n, tau, nrvt, vt);
      for (i = 0; i <= m - 1; i++) {
        for (j = i + 1; j <= m - 1; j++)
          a[i].Set(j, 0);
      }

      COrtFac::RMatrixBD(a, m, m, tauq, taup);

      COrtFac::RMatrixBDUnpackQ(a, m, m, tauq, ncu, u);

      COrtFac::RMatrixBDUnpackDiagonals(a, m, m, isupper, w, e);
      ArrayResizeAL(work, MathMax(m, n) + 1);

      CBlas::InplaceTranspose(u, 0, nru - 1, 0, ncu - 1, work);

      if (additionalmemory < 1) {

        COrtFac::RMatrixBDMultiplyByP(a, m, m, taup, vt, m, n, false, true);

        result = CBdSingValueDecompose::RMatrixBdSVD(w, e, m, isupper, false, a,
                                                     0, u, nru, vt, n);
      } else {

        COrtFac::RMatrixBDUnpackPT(a, m, m, taup, m, t2);

        result = CBdSingValueDecompose::RMatrixBdSVD(w, e, m, isupper, false, a,
                                                     0, u, nru, t2, m);

        CBlas::CopyMatrix(vt, 0, m - 1, 0, n - 1, a, 0, m - 1, 0, n - 1);

        CBlas::MatrixMatrixMultiply(t2, 0, m - 1, 0, m - 1, false, a, 0, m - 1,
                                    0, n - 1, false, 1.0, vt, 0, m - 1, 0,
                                    n - 1, 0.0, work);
      }

      CBlas::InplaceTranspose(u, 0, nru - 1, 0, ncu - 1, work);

      return (result);
    }
  }

  if (m <= n) {

    COrtFac::RMatrixBD(a, m, n, tauq, taup);

    COrtFac::RMatrixBDUnpackQ(a, m, n, tauq, ncu, u);

    COrtFac::RMatrixBDUnpackPT(a, m, n, taup, nrvt, vt);

    COrtFac::RMatrixBDUnpackDiagonals(a, m, n, isupper, w, e);
    ArrayResizeAL(work, m + 1);

    CBlas::InplaceTranspose(u, 0, nru - 1, 0, ncu - 1, work);

    result = CBdSingValueDecompose::RMatrixBdSVD(w, e, minmn, isupper, false, a,
                                                 0, u, nru, vt, ncvt);

    CBlas::InplaceTranspose(u, 0, nru - 1, 0, ncu - 1, work);

    return (result);
  }

  COrtFac::RMatrixBD(a, m, n, tauq, taup);

  COrtFac::RMatrixBDUnpackQ(a, m, n, tauq, ncu, u);

  COrtFac::RMatrixBDUnpackPT(a, m, n, taup, nrvt, vt);

  COrtFac::RMatrixBDUnpackDiagonals(a, m, n, isupper, w, e);

  if (additionalmemory < 2 || uneeded == 0) {

    result = CBdSingValueDecompose::RMatrixBdSVD(w, e, minmn, isupper, false, u,
                                                 nru, a, 0, vt, ncvt);
  } else {

    t2.Resize(minmn, m);

    CBlas::CopyAndTranspose(u, 0, m - 1, 0, minmn - 1, t2, 0, minmn - 1, 0,
                            m - 1);

    result = CBdSingValueDecompose::RMatrixBdSVD(w, e, minmn, isupper, false, u,
                                                 0, t2, m, vt, ncvt);

    CBlas::CopyAndTranspose(t2, 0, minmn - 1, 0, m - 1, u, 0, m - 1, 0,
                            minmn - 1);
  }

  return (result);
}

class CFblsLinCgState {
public:
  double m_e1;
  double m_e2;
  double m_x[];
  double m_ax[];
  double m_xax;
  double m_xk[];
  int m_n;
  double m_rk[];
  double m_rk1[];
  double m_xk1[];
  double m_pk[];
  double m_pk1[];
  double m_b[];
  RCommState m_rstate;
  double m_tmp2[];

  CFblsLinCgState(void);
  ~CFblsLinCgState(void);
};

CFblsLinCgState::CFblsLinCgState(void) {}

CFblsLinCgState::~CFblsLinCgState(void) {}

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
                                const int n, const bool isupper, double &xb[],
                                double &tmp[]);
  static void FblsSolveCGx(CMatrixDouble &a, const int m, const int n,
                           const double alpha, const double &b[], double &x[],
                           double &buf[]);
  static void FblsCGCreate(double &x[], double &b[], const int n,
                           CFblsLinCgState &state);
  static bool FblsCGIteration(CFblsLinCgState &state);
};

CFbls::CFbls(void) {}

CFbls::~CFbls(void) {}

static void CFbls::FblsCholeskySolve(CMatrixDouble &cha,
                                     const double sqrtscalea, const int n,
                                     const bool isupper, double &xb[],
                                     double &tmp[]) {

  int i = 0;
  double v = 0;
  int i_ = 0;

  if (CAp::Len(tmp) < n)
    ArrayResizeAL(tmp, n);

  if (isupper) {

    for (i = 0; i < n; i++) {
      xb[i] = xb[i] / (sqrtscalea * cha[i][i]);

      if (i < n - 1) {
        v = xb[i];
        for (i_ = i + 1; i_ < n; i_++)
          tmp[i_] = sqrtscalea * cha[i][i_];
        for (i_ = i + 1; i_ < n; i_++)
          xb[i_] = xb[i_] - v * tmp[i_];
      }
    }

    for (i = n - 1; i >= 0; i--) {

      if (i < n - 1) {
        for (i_ = i + 1; i_ < n; i_++)
          tmp[i_] = sqrtscalea * cha[i][i_];
        v = 0.0;
        for (i_ = i + 1; i_ < n; i_++)
          v += tmp[i_] * xb[i_];
        xb[i] = xb[i] - v;
      }
      xb[i] = xb[i] / (sqrtscalea * cha[i][i]);
    }
  } else {

    for (i = 0; i < n; i++) {

      if (i > 0) {
        for (i_ = 0; i_ < i; i_++)
          tmp[i_] = sqrtscalea * cha[i][i_];
        v = 0.0;
        for (i_ = 0; i_ < i; i_++)
          v += tmp[i_] * xb[i_];
        xb[i] = xb[i] - v;
      }
      xb[i] = xb[i] / (sqrtscalea * cha[i][i]);
    }

    for (i = n - 1; i >= 0; i--) {
      xb[i] = xb[i] / (sqrtscalea * cha[i][i]);

      if (i > 0) {
        v = xb[i];
        for (i_ = 0; i_ < i; i_++)
          tmp[i_] = sqrtscalea * cha[i][i_];
        for (i_ = 0; i_ < i; i_++)
          xb[i_] = xb[i_] - v * tmp[i_];
      }
    }
  }
}

static void CFbls::FblsSolveCGx(CMatrixDouble &a, const int m, const int n,
                                const double alpha, const double &b[],
                                double &x[], double &buf[]) {

  int k = 0;
  int offsrk = 0;
  int offsrk1 = 0;
  int offsxk = 0;
  int offsxk1 = 0;
  int offspk = 0;
  int offspk1 = 0;
  int offstmp1 = 0;
  int offstmp2 = 0;
  int bs = 0;
  double e1 = 0;
  double e2 = 0;
  double rk2 = 0;
  double rk12 = 0;
  double pap = 0;
  double s = 0;
  double betak = 0;
  double v1 = 0;
  double v2 = 0;
  int i_ = 0;
  int i1_ = 0;

  v1 = 0.0;
  for (i_ = 0; i_ < n; i_++)
    v1 += b[i_] * b[i_];

  if (v1 == 0.0) {
    for (k = 0; k < n; k++)
      x[k] = 0;

    return;
  }

  offsrk = 0;
  offsrk1 = offsrk + n;
  offsxk = offsrk1 + n;
  offsxk1 = offsxk + n;
  offspk = offsxk1 + n;
  offspk1 = offspk + n;
  offstmp1 = offspk1 + n;
  offstmp2 = offstmp1 + m;
  bs = offstmp2 + n;

  if (CAp::Len(buf) < bs)
    ArrayResizeAL(buf, bs);

  i1_ = -offsxk;
  for (i_ = offsxk; i_ <= offsxk + n - 1; i_++)
    buf[i_] = x[i_ + i1_];

  CAblas::RMatrixMVect(m, n, a, 0, 0, 0, buf, offsxk, buf, offstmp1);

  CAblas::RMatrixMVect(n, m, a, 0, 0, 1, buf, offstmp1, buf, offstmp2);

  i1_ = offsxk - offstmp2;
  for (i_ = offstmp2; i_ < offstmp2 + n; i_++)
    buf[i_] = buf[i_] + alpha * buf[i_ + i1_];

  i1_ = -offsrk;
  for (i_ = offsrk; i_ < offsrk + n; i_++)
    buf[i_] = b[i_ + i1_];

  i1_ = offstmp2 - offsrk;
  for (i_ = offsrk; i_ < offsrk + n; i_++)
    buf[i_] = buf[i_] - buf[i_ + i1_];
  rk2 = 0.0;
  for (i_ = offsrk; i_ < offsrk + n; i_++)
    rk2 += buf[i_] * buf[i_];

  i1_ = offsrk - offspk;
  for (i_ = offspk; i_ <= offspk + n - 1; i_++)
    buf[i_] = buf[i_ + i1_];
  e1 = MathSqrt(rk2);

  for (k = 0; k < n; k++) {

    CAblas::RMatrixMVect(m, n, a, 0, 0, 0, buf, offspk, buf, offstmp1);
    v1 = 0.0;
    for (i_ = offstmp1; i_ <= offstmp1 + m - 1; i_++)
      v1 += buf[i_] * buf[i_];
    v2 = 0.0;
    for (i_ = offspk; i_ <= offspk + n - 1; i_++)
      v2 += buf[i_] * buf[i_];
    pap = v1 + alpha * v2;

    CAblas::RMatrixMVect(n, m, a, 0, 0, 1, buf, offstmp1, buf, offstmp2);
    i1_ = offspk - offstmp2;
    for (i_ = offstmp2; i_ < offstmp2 + n; i_++)
      buf[i_] = buf[i_] + alpha * buf[i_ + i1_];

    if (pap == 0.0)
      break;

    s = rk2 / pap;

    i1_ = offsxk - offsxk1;
    for (i_ = offsxk1; i_ <= offsxk1 + n - 1; i_++)
      buf[i_] = buf[i_ + i1_];
    i1_ = offspk - offsxk1;
    for (i_ = offsxk1; i_ <= offsxk1 + n - 1; i_++)
      buf[i_] = buf[i_] + s * buf[i_ + i1_];

    i1_ = offsrk - offsrk1;
    for (i_ = offsrk1; i_ <= offsrk1 + n - 1; i_++)
      buf[i_] = buf[i_ + i1_];
    i1_ = offstmp2 - offsrk1;
    for (i_ = offsrk1; i_ <= offsrk1 + n - 1; i_++)
      buf[i_] = buf[i_] - s * buf[i_ + i1_];
    rk12 = 0.0;
    for (i_ = offsrk1; i_ <= offsrk1 + n - 1; i_++)
      rk12 += buf[i_] * buf[i_];

    if (MathSqrt(rk12) <= 100 * CMath::m_machineepsilon * MathSqrt(rk2)) {

      i1_ = offsxk1 - offsxk;
      for (i_ = offsxk; i_ <= offsxk + n - 1; i_++)
        buf[i_] = buf[i_ + i1_];
      break;
    }

    betak = rk12 / rk2;
    i1_ = offsrk1 - offspk1;
    for (i_ = offspk1; i_ <= offspk1 + n - 1; i_++)
      buf[i_] = buf[i_ + i1_];
    i1_ = offspk - offspk1;
    for (i_ = offspk1; i_ <= offspk1 + n - 1; i_++)
      buf[i_] = buf[i_] + betak * buf[i_ + i1_];

    i1_ = offsrk1 - offsrk;
    for (i_ = offsrk; i_ < offsrk + n; i_++)
      buf[i_] = buf[i_ + i1_];
    i1_ = offsxk1 - offsxk;
    for (i_ = offsxk; i_ <= offsxk + n - 1; i_++)
      buf[i_] = buf[i_ + i1_];
    i1_ = offspk1 - offspk;
    for (i_ = offspk; i_ <= offspk + n - 1; i_++)
      buf[i_] = buf[i_ + i1_];
    rk2 = rk12;
  }

  CAblas::RMatrixMVect(m, n, a, 0, 0, 0, buf, offsxk, buf, offstmp1);

  CAblas::RMatrixMVect(n, m, a, 0, 0, 1, buf, offstmp1, buf, offstmp2);
  i1_ = offsxk - offstmp2;
  for (i_ = offstmp2; i_ < offstmp2 + n; i_++)
    buf[i_] = buf[i_] + alpha * buf[i_ + i1_];
  i1_ = -offsrk;
  for (i_ = offsrk; i_ < offsrk + n; i_++)
    buf[i_] = b[i_ + i1_];
  i1_ = offstmp2 - offsrk;
  for (i_ = offsrk; i_ < offsrk + n; i_++)
    buf[i_] = buf[i_] - buf[i_ + i1_];
  v1 = 0.0;
  for (i_ = offsrk; i_ < offsrk + n; i_++)
    v1 += buf[i_] * buf[i_];
  e2 = MathSqrt(v1);

  if (e2 < e1) {
    i1_ = offsxk;
    for (i_ = 0; i_ < n; i_++)
      x[i_] = buf[i_ + i1_];
  }
}

static void CFbls::FblsCGCreate(double &x[], double &b[], const int n,
                                CFblsLinCgState &state) {

  int i_ = 0;

  if (CAp::Len(state.m_b) < n)
    ArrayResizeAL(state.m_b, n);

  if (CAp::Len(state.m_rk) < n)
    ArrayResizeAL(state.m_rk, n);

  if (CAp::Len(state.m_rk1) < n)
    ArrayResizeAL(state.m_rk1, n);

  if (CAp::Len(state.m_xk) < n)
    ArrayResizeAL(state.m_xk, n);

  if (CAp::Len(state.m_xk1) < n)
    ArrayResizeAL(state.m_xk1, n);

  if (CAp::Len(state.m_pk) < n)
    ArrayResizeAL(state.m_pk, n);

  if (CAp::Len(state.m_pk1) < n)
    ArrayResizeAL(state.m_pk1, n);

  if (CAp::Len(state.m_tmp2) < n)
    ArrayResizeAL(state.m_tmp2, n);

  if (CAp::Len(state.m_x) < n)
    ArrayResizeAL(state.m_x, n);

  if (CAp::Len(state.m_ax) < n)
    ArrayResizeAL(state.m_ax, n);

  state.m_n = n;
  for (i_ = 0; i_ < n; i_++)
    state.m_xk[i_] = x[i_];
  for (i_ = 0; i_ < n; i_++)
    state.m_b[i_] = b[i_];

  ArrayResizeAL(state.m_rstate.ia, 2);
  ArrayResizeAL(state.m_rstate.ra, 7);
  state.m_rstate.stage = -1;
}

static bool CFbls::FblsCGIteration(CFblsLinCgState &state) {

  int n = 0;
  int k = 0;
  double rk2 = 0;
  double rk12 = 0;
  double pap = 0;
  double s = 0;
  double betak = 0;
  double v1 = 0;
  double v2 = 0;
  int i_ = 0;

  if (state.m_rstate.stage >= 0) {

    n = state.m_rstate.ia[0];
    k = state.m_rstate.ia[1];
    rk2 = state.m_rstate.ra[0];
    rk12 = state.m_rstate.ra[1];
    pap = state.m_rstate.ra[2];
    s = state.m_rstate.ra[3];
    betak = state.m_rstate.ra[4];
    v1 = state.m_rstate.ra[5];
    v2 = state.m_rstate.ra[6];
  } else {

    n = -983;
    k = -989;
    rk2 = -834;
    rk12 = 900;
    pap = -287;
    s = 364;
    betak = 214;
    v1 = -338;
    v2 = -686;
  }

  if (state.m_rstate.stage == 0) {

    for (i_ = 0; i_ < n; i_++)
      state.m_rk[i_] = state.m_b[i_];

    for (i_ = 0; i_ < n; i_++)
      state.m_rk[i_] = state.m_rk[i_] - state.m_ax[i_];

    rk2 = 0.0;
    for (i_ = 0; i_ < n; i_++)
      rk2 += state.m_rk[i_] * state.m_rk[i_];

    for (i_ = 0; i_ < n; i_++)
      state.m_pk[i_] = state.m_rk[i_];
    state.m_e1 = MathSqrt(rk2);

    k = 0;

    return (Func_lbl_3(state, n, k, rk2, rk12, pap, s, betak, v1, v2));
  }

  if (state.m_rstate.stage == 1) {

    for (i_ = 0; i_ < n; i_++)
      state.m_tmp2[i_] = state.m_ax[i_];
    pap = state.m_xax;

    if (!CMath::IsFinite(pap))
      return (Func_lbl_5(state, n, k, rk2, rk12, pap, s, betak, v1, v2));

    if (pap <= 0.0)
      return (Func_lbl_5(state, n, k, rk2, rk12, pap, s, betak, v1, v2));

    s = rk2 / pap;

    for (i_ = 0; i_ < n; i_++)
      state.m_xk1[i_] = state.m_xk[i_];
    for (i_ = 0; i_ < n; i_++)
      state.m_xk1[i_] = state.m_xk1[i_] + s * state.m_pk[i_];

    for (i_ = 0; i_ < n; i_++)
      state.m_rk1[i_] = state.m_rk[i_];
    for (i_ = 0; i_ < n; i_++)
      state.m_rk1[i_] = state.m_rk1[i_] - s * state.m_tmp2[i_];
    rk12 = 0.0;
    for (i_ = 0; i_ < n; i_++)
      rk12 += state.m_rk1[i_] * state.m_rk1[i_];

    if (MathSqrt(rk12) <= 100 * CMath::m_machineepsilon * state.m_e1) {

      for (i_ = 0; i_ < n; i_++)
        state.m_xk[i_] = state.m_xk1[i_];

      return (Func_lbl_5(state, n, k, rk2, rk12, pap, s, betak, v1, v2));
    }

    betak = rk12 / rk2;
    for (i_ = 0; i_ < n; i_++)
      state.m_pk1[i_] = state.m_rk1[i_];
    for (i_ = 0; i_ < n; i_++)
      state.m_pk1[i_] = state.m_pk1[i_] + betak * state.m_pk[i_];

    for (i_ = 0; i_ < n; i_++)
      state.m_rk[i_] = state.m_rk1[i_];
    for (i_ = 0; i_ < n; i_++)
      state.m_xk[i_] = state.m_xk1[i_];
    for (i_ = 0; i_ < n; i_++)
      state.m_pk[i_] = state.m_pk1[i_];
    rk2 = rk12;
    k = k + 1;

    return (Func_lbl_3(state, n, k, rk2, rk12, pap, s, betak, v1, v2));
  }

  if (state.m_rstate.stage == 2) {

    for (i_ = 0; i_ < n; i_++)
      state.m_rk[i_] = state.m_b[i_];

    for (i_ = 0; i_ < n; i_++)
      state.m_rk[i_] = state.m_rk[i_] - state.m_ax[i_];

    v1 = 0.0;
    for (i_ = 0; i_ < n; i_++)
      v1 += state.m_rk[i_] * state.m_rk[i_];
    state.m_e2 = MathSqrt(v1);

    return (false);
  }

  n = state.m_n;

  v1 = 0.0;
  for (i_ = 0; i_ < n; i_++)
    v1 += state.m_b[i_] * state.m_b[i_];

  if (v1 == 0.0) {
    for (k = 0; k < n; k++)
      state.m_xk[k] = 0;

    return (false);
  }

  for (i_ = 0; i_ < n; i_++)
    state.m_x[i_] = state.m_xk[i_];
  state.m_rstate.stage = 0;

  Func_lbl_rcomm(state, n, k, rk2, rk12, pap, s, betak, v1, v2);

  return (true);
}

static void CFbls::Func_lbl_rcomm(CFblsLinCgState &state, int n, int k,
                                  double rk2, double rk12, double pap, double s,
                                  double betak, double v1, double v2) {

  state.m_rstate.ia[0] = n;
  state.m_rstate.ia[1] = k;
  state.m_rstate.ra[0] = rk2;
  state.m_rstate.ra[1] = rk12;
  state.m_rstate.ra[2] = pap;
  state.m_rstate.ra[3] = s;
  state.m_rstate.ra[4] = betak;
  state.m_rstate.ra[5] = v1;
  state.m_rstate.ra[6] = v2;
}

static bool CFbls::Func_lbl_3(CFblsLinCgState &state, int &n, int &k,
                              double &rk2, double &rk12, double &pap, double &s,
                              double &betak, double &v1, double &v2) {

  if (k > n - 1)
    return (Func_lbl_5(state, n, k, rk2, rk12, pap, s, betak, v1, v2));

  for (int i_ = 0; i_ < n; i_++)
    state.m_x[i_] = state.m_pk[i_];
  state.m_rstate.stage = 1;

  Func_lbl_rcomm(state, n, k, rk2, rk12, pap, s, betak, v1, v2);

  return (true);
}

static bool CFbls::Func_lbl_5(CFblsLinCgState &state, int &n, int &k,
                              double &rk2, double &rk12, double &pap, double &s,
                              double &betak, double &v1, double &v2) {

  for (int i_ = 0; i_ < n; i_++)
    state.m_x[i_] = state.m_xk[i_];
  state.m_rstate.stage = 2;

  Func_lbl_rcomm(state, n, k, rk2, rk12, pap, s, betak, v1, v2);

  return (true);
}

class CMatDet {
public:
  CMatDet(void);
  ~CMatDet(void);

  static double RMatrixLUDet(CMatrixDouble &a, int &pivots[], const int n);
  static double RMatrixDet(CMatrixDouble &ca, const int n);
  static double SPDMatrixCholeskyDet(CMatrixDouble &a, const int n);
  static double SPDMatrixDet(CMatrixDouble &ca, const int n,
                             const bool isupper);
  static al_complex CMatrixLUDet(CMatrixComplex &a, int &pivots[], const int n);
  static al_complex CMatrixDet(CMatrixComplex &ca, const int n);
};

CMatDet::CMatDet(void) {}

CMatDet::~CMatDet(void) {}

static double CMatDet::RMatrixLUDet(CMatrixDouble &a, int &pivots[],
                                    const int n) {

  double result = 0;
  int i = 0;
  int s = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Len(pivots) >= n,
                   __FUNCTION__ + ": Pivots array is too short!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CApServ::IsFiniteMatrix(a, n, n),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return (EMPTY_VALUE);

  result = 1;
  s = 1;
  for (i = 0; i < n; i++) {
    result = result * a[i][i];

    if (pivots[i] != i)
      s = -s;
  }

  return (result * s);
}

static double CMatDet::RMatrixDet(CMatrixDouble &ca, const int n) {

  double result = 0;
  int pivots[];

  CMatrixDouble a;
  a = ca;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CApServ::IsFiniteMatrix(a, n, n),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return (EMPTY_VALUE);

  CTrFac::RMatrixLU(a, n, n, pivots);

  return (RMatrixLUDet(a, pivots, n));
}

static al_complex CMatDet::CMatrixLUDet(CMatrixComplex &a, int &pivots[],
                                        const int n) {

  al_complex result = 0;
  int i = 0;
  int s = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Len(pivots) >= n,
                   __FUNCTION__ + ": Pivots array is too short!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CApServ::IsFiniteComplexMatrix(a, n, n),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return (EMPTY_VALUE);

  result = 1;
  s = 1;
  for (i = 0; i < n; i++) {
    result = result * a[i][i];

    if (pivots[i] != i)
      s = -s;
  }

  return (result * s);
}

static al_complex CMatDet::CMatrixDet(CMatrixComplex &ca, const int n) {

  al_complex result = 0;
  int pivots[];

  CMatrixComplex a;
  a = ca;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CApServ::IsFiniteComplexMatrix(a, n, n),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return (EMPTY_VALUE);

  CTrFac::CMatrixLU(a, n, n, pivots);

  return (CMatrixLUDet(a, pivots, n));
}

static double CMatDet::SPDMatrixCholeskyDet(CMatrixDouble &a, const int n) {

  double result = 0;
  int i = 0;
  bool f;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return (EMPTY_VALUE);

  f = true;
  for (i = 0; i < n; i++)
    f = f && CMath::IsFinite(a[i][i]);

  if (!CAp::Assert(f, __FUNCTION__ + ": A contains infinite or NaN values!"))
    return (EMPTY_VALUE);
  result = 1;
  for (i = 0; i < n; i++)
    result = result * CMath::Sqr(a[i][i]);

  return (result);
}

static double CMatDet::SPDMatrixDet(CMatrixDouble &ca, const int n,
                                    const bool isupper) {

  double result = 0;
  bool b;

  CMatrixDouble a;
  a = ca;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Rows(a) >= n, __FUNCTION__ + ": rows(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CAp::Cols(a) >= n, __FUNCTION__ + ": cols(A)<N!"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(CApServ::IsFiniteRTrMatrix(a, n, isupper),
                   __FUNCTION__ + ": A contains infinite or NaN values!"))
    return (EMPTY_VALUE);

  b = CTrFac::SPDMatrixCholesky(a, n, isupper);

  if (!CAp::Assert(b, __FUNCTION__ + ": A is not SPD!"))
    return (EMPTY_VALUE);

  return (SPDMatrixCholeskyDet(a, n));
}

class CSpdGEVD {
public:
  CSpdGEVD(void);
  ~CSpdGEVD(void);

  static bool SMatrixGEVD(CMatrixDouble &ca, const int n, const bool isuppera,
                          CMatrixDouble &b, const bool isupperb,
                          const int zneeded, const int problemtype, double &d[],
                          CMatrixDouble &z);
  static bool SMatrixGEVDReduce(CMatrixDouble &a, const int n,
                                const bool isuppera, CMatrixDouble &b,
                                const bool isupperb, const int problemtype,
                                CMatrixDouble &r, bool &isupperr);
};

CSpdGEVD::CSpdGEVD(void) {}

CSpdGEVD::~CSpdGEVD(void) {}

static bool CSpdGEVD::SMatrixGEVD(CMatrixDouble &ca, const int n,
                                  const bool isuppera, CMatrixDouble &b,
                                  const bool isupperb, const int zneeded,
                                  const int problemtype, double &d[],
                                  CMatrixDouble &z) {

  bool result;
  bool isupperr;
  int j1 = 0;
  int j2 = 0;
  int j1inc = 0;
  int j2inc = 0;
  int i = 0;
  int j = 0;
  double v = 0;
  int i_ = 0;

  CMatrixDouble r;
  CMatrixDouble t;

  CMatrixDouble a;
  a = ca;

  result =
      SMatrixGEVDReduce(a, n, isuppera, b, isupperb, problemtype, r, isupperr);

  if (!result)
    return (result);

  result = CEigenVDetect::SMatrixEVD(a, n, zneeded, isuppera, d, t);

  if (!result)
    return (result);

  if (zneeded != 0) {

    z.Resize(n, n);
    for (j = 0; j < n; j++)
      z[0].Set(j, 0.0);
    for (i = 1; i < n; i++) {
      for (i_ = 0; i_ < n; i_++)
        z[i].Set(i_, z[0][i_]);
    }

    if (isupperr) {
      j1 = 0;
      j2 = n - 1;
      j1inc = 1;
      j2inc = 0;
    } else {
      j1 = 0;
      j2 = 0;
      j1inc = 0;
      j2inc = 1;
    }

    for (i = 0; i < n; i++) {
      for (j = j1; j <= j2; j++) {
        v = r[i][j];
        for (i_ = 0; i_ < n; i_++)
          z[i].Set(i_, z[i][i_] + v * t[j][i_]);
      }
      j1 = j1 + j1inc;
      j2 = j2 + j2inc;
    }
  }

  return (result);
}

static bool CSpdGEVD::SMatrixGEVDReduce(CMatrixDouble &a, const int n,
                                        const bool isuppera, CMatrixDouble &b,
                                        const bool isupperb,
                                        const int problemtype, CMatrixDouble &r,
                                        bool &isupperr) {

  bool result;
  int i = 0;
  int j = 0;
  double v = 0;
  int info = 0;
  int i_ = 0;
  int i1_ = 0;

  CMatrixDouble t;

  double w1[];
  double w2[];
  double w3[];

  CMatInvReport rep;

  if (!CAp::Assert(n > 0, __FUNCTION__ + ": N<=0!"))
    return (false);

  if (!CAp::Assert(problemtype == 1 || problemtype == 2 || problemtype == 3,
                   __FUNCTION__ + ": incorrect ProblemType!"))
    return (false);

  result = true;

  if (problemtype == 1) {

    t.Resize(n, n);

    if (isupperb) {
      for (i = 0; i < n; i++)
        for (i_ = i; i_ < n; i_++)
          t[i_].Set(i, b[i][i_]);
    } else {
      for (i = 0; i < n; i++)
        for (i_ = 0; i_ <= i; i_++)
          t[i].Set(i_, b[i][i_]);
    }

    if (!CTrFac::SPDMatrixCholesky(t, n, false))
      return (false);

    CMatInv::RMatrixTrInverse(t, n, false, false, info, rep);

    if (info <= 0)
      return (false);

    ArrayResizeAL(w1, n + 1);
    ArrayResizeAL(w2, n + 1);
    r.Resize(n, n);
    for (j = 1; j <= n; j++) {

      i1_ = -1;
      for (i_ = 1; i_ <= j; i_++)
        w1[i_] = t[j - 1][i_ + i1_];

      CSblas::SymmetricMatrixVectorMultiply(a, isuppera, 0, j - 1, w1, 1.0, w2);

      if (isuppera)
        CBlas::MatrixVectorMultiply(a, 0, j - 1, j, n - 1, true, w1, 1, j, 1.0,
                                    w2, j + 1, n, 0.0);
      else
        CBlas::MatrixVectorMultiply(a, j, n - 1, 0, j - 1, false, w1, 1, j, 1.0,
                                    w2, j + 1, n, 0.0);

      for (i = 1; i <= n; i++) {
        i1_ = 1;
        v = 0.0;
        for (i_ = 0; i_ < i; i_++)
          v += t[i - 1][i_] * w2[i_ + i1_];
        r[i - 1].Set(j - 1, v);
      }
    }

    for (i = 0; i < n; i++) {
      for (i_ = 0; i_ < n; i_++)
        a[i].Set(i_, r[i][i_]);
    }

    isupperr = true;
    for (i = 0; i < n; i++) {
      for (j = 0; j < i; j++)
        r[i].Set(j, 0);
    }
    for (i = 0; i < n; i++) {
      for (i_ = i; i_ < n; i_++)
        r[i].Set(i_, t[i_][i]);
    }

    return (result);
  }

  if (problemtype == 2 || problemtype == 3) {

    t.Resize(n, n);

    if (isupperb) {
      for (i = 0; i < n; i++)
        for (i_ = i; i_ < n; i_++)
          t[i].Set(i_, b[i][i_]);
    } else {
      for (i = 0; i < n; i++)
        for (i_ = i; i_ < n; i_++)
          t[i].Set(i_, b[i_][i]);
    }

    if (!CTrFac::SPDMatrixCholesky(t, n, true))
      return (false);

    ArrayResizeAL(w1, n + 1);
    ArrayResizeAL(w2, n + 1);
    ArrayResizeAL(w3, n + 1);
    r.Resize(n, n);
    for (j = 1; j <= n; j++) {

      i1_ = (j - 1) - (1);
      for (i_ = 1; i_ <= n - j + 1; i_++)
        w1[i_] = t[j - 1][i_ + i1_];

      CSblas::SymmetricMatrixVectorMultiply(a, isuppera, j - 1, n - 1, w1, 1.0,
                                            w3);
      i1_ = (1) - (j);
      for (i_ = j; i_ <= n; i_++)
        w2[i_] = w3[i_ + i1_];
      i1_ = (j - 1) - (j);
      for (i_ = j; i_ <= n; i_++)
        w1[i_] = t[j - 1][i_ + i1_];

      if (isuppera)
        CBlas::MatrixVectorMultiply(a, 0, j - 2, j - 1, n - 1, false, w1, j, n,
                                    1.0, w2, 1, j - 1, 0.0);
      else
        CBlas::MatrixVectorMultiply(a, j - 1, n - 1, 0, j - 2, true, w1, j, n,
                                    1.0, w2, 1, j - 1, 0.0);

      for (i = 1; i <= n; i++) {
        i1_ = (i) - (i - 1);
        v = 0.0;
        for (i_ = i - 1; i_ < n; i_++)
          v += t[i - 1][i_] * w2[i_ + i1_];
        r[i - 1].Set(j - 1, v);
      }
    }

    for (i = 0; i < n; i++) {
      for (i_ = 0; i_ < n; i_++)
        a[i].Set(i_, r[i][i_]);
    }

    if (problemtype == 2) {

      CMatInv::RMatrixTrInverse(t, n, true, false, info, rep);

      if (info <= 0)
        return (false);

      isupperr = true;
      for (i = 0; i < n; i++) {
        for (j = 0; j < i; j++)
          r[i].Set(j, 0);
      }
      for (i = 0; i < n; i++) {
        for (i_ = i; i_ < n; i_++)
          r[i].Set(i_, t[i][i_]);
      }
    } else {

      isupperr = false;
      for (i = 0; i < n; i++) {
        for (j = i + 1; j < n; j++)
          r[i].Set(j, 0);
      }
      for (i = 0; i < n; i++) {
        for (i_ = i; i_ < n; i_++)
          r[i_].Set(i, t[i][i_]);
      }
    }
  }

  return (result);
}

class CInverseUpdate {
public:
  CInverseUpdate(void);
  ~CInverseUpdate(void);

  static void RMatrixInvUpdateSimple(CMatrixDouble &inva, const int n,
                                     const int updrow, const int updcolumn,
                                     const double updval);
  static void RMatrixInvUpdateRow(CMatrixDouble &inva, const int n,
                                  const int updrow, double &v[]);
  static void RMatrixInvUpdateColumn(CMatrixDouble &inva, const int n,
                                     const int updcolumn, double &u[]);
  static void RMatrixInvUpdateUV(CMatrixDouble &inva, const int n, double &u[],
                                 double &v[]);
};

CInverseUpdate::CInverseUpdate(void) {}

CInverseUpdate::~CInverseUpdate(void) {}

static void CInverseUpdate::RMatrixInvUpdateSimple(CMatrixDouble &inva,
                                                   const int n,
                                                   const int updrow,
                                                   const int updcolumn,
                                                   const double updval) {

  double t1[];
  double t2[];

  int i = 0;
  double lambdav = 0;
  double vt = 0;
  int i_ = 0;

  if (!CAp::Assert(updrow >= 0 && updrow < n,
                   "RMatrixInvUpdateSimple: incorrect UpdRow!"))
    return;

  if (!CAp::Assert(updcolumn >= 0 && updcolumn < n,
                   "RMatrixInvUpdateSimple: incorrect UpdColumn!"))
    return;

  ArrayResizeAL(t1, n);
  ArrayResizeAL(t2, n);

  for (i_ = 0; i_ < n; i_++)
    t1[i_] = inva[i_][updrow];

  for (i_ = 0; i_ < n; i_++)
    t2[i_] = inva[updcolumn][i_];

  lambdav = updval * inva[updcolumn][updrow];

  for (i = 0; i < n; i++) {
    vt = updval * t1[i];
    vt = vt / (1 + lambdav);
    for (i_ = 0; i_ < n; i_++)
      inva[i].Set(i_, inva[i][i_] - vt * t2[i_]);
  }
}

static void CInverseUpdate::RMatrixInvUpdateRow(CMatrixDouble &inva,
                                                const int n, const int updrow,
                                                double &v[]) {

  double t1[];
  double t2[];

  int i = 0;
  int j = 0;
  double lambdav = 0;
  double vt = 0;
  int i_ = 0;

  ArrayResizeAL(t1, n);
  ArrayResizeAL(t2, n);

  for (i_ = 0; i_ < n; i_++)
    t1[i_] = inva[i_][updrow];

  for (j = 0; j <= n - 1; j++) {
    vt = 0.0;
    for (i_ = 0; i_ < n; i_++)
      vt += v[i_] * inva[i_][j];
    t2[j] = vt;
  }
  lambdav = t2[updrow];

  for (i = 0; i < n; i++) {
    vt = t1[i] / (1 + lambdav);
    for (i_ = 0; i_ < n; i_++)
      inva[i].Set(i_, inva[i][i_] - vt * t2[i_]);
  }
}

static void CInverseUpdate::RMatrixInvUpdateColumn(CMatrixDouble &inva,
                                                   const int n,
                                                   const int updcolumn,
                                                   double &u[]) {

  double t1[];
  double t2[];

  int i = 0;
  double lambdav = 0;
  double vt = 0;
  int i_ = 0;

  ArrayResizeAL(t1, n);
  ArrayResizeAL(t2, n);

  for (i = 0; i < n; i++) {
    vt = 0.0;
    for (i_ = 0; i_ < n; i_++)
      vt += inva[i][i_] * u[i_];
    t1[i] = vt;
  }
  lambdav = t1[updcolumn];

  for (i_ = 0; i_ < n; i_++)
    t2[i_] = inva[updcolumn][i_];

  for (i = 0; i < n; i++) {
    vt = t1[i] / (1 + lambdav);
    for (i_ = 0; i_ < n; i_++)
      inva[i].Set(i_, inva[i][i_] - vt * t2[i_]);
  }
}

static void CInverseUpdate::RMatrixInvUpdateUV(CMatrixDouble &inva, const int n,
                                               double &u[], double &v[]) {

  double t1[];
  double t2[];

  int i = 0;
  int j = 0;
  double lambdav = 0;
  double vt = 0;
  int i_ = 0;

  ArrayResizeAL(t1, n);
  ArrayResizeAL(t2, n);

  for (i = 0; i < n; i++) {
    vt = 0.0;
    for (i_ = 0; i_ < n; i_++)
      vt += inva[i][i_] * u[i_];
    t1[i] = vt;
  }
  lambdav = 0.0;
  for (i_ = 0; i_ < n; i_++)
    lambdav += v[i_] * t1[i_];

  for (j = 0; j <= n - 1; j++) {
    vt = 0.0;
    for (i_ = 0; i_ < n; i_++)
      vt += v[i_] * inva[i_][j];
    t2[j] = vt;
  }

  for (i = 0; i < n; i++) {
    vt = t1[i] / (1 + lambdav);
    for (i_ = 0; i_ < n; i_++)
      inva[i].Set(i_, inva[i][i_] - vt * t2[i_]);
  }
}

class CSchur {
public:
  CSchur(void);
  ~CSchur(void);

  static bool RMatrixSchur(CMatrixDouble &a, const int n, CMatrixDouble &s);
};

CSchur::CSchur(void) {}

CSchur::~CSchur(void) {}

static bool CSchur::RMatrixSchur(CMatrixDouble &a, const int n,
                                 CMatrixDouble &s) {

  bool result;
  int info = 0;
  int i = 0;
  int j = 0;

  double tau[];
  double wi[];
  double wr[];

  CMatrixDouble a1;
  CMatrixDouble s1;

  COrtFac::RMatrixHessenberg(a, n, tau);
  COrtFac::RMatrixHessenbergUnpackQ(a, n, tau, s);

  a1.Resize(n + 1, n + 1);
  s1.Resize(n + 1, n + 1);
  for (i = 1; i <= n; i++) {
    for (j = 1; j <= n; j++) {
      a1[i].Set(j, a[i - 1][j - 1]);
      s1[i].Set(j, s[i - 1][j - 1]);
    }
  }

  CHsSchur::InternalSchurDecomposition(a1, n, 1, 1, wr, wi, s1, info);
  result = info == 0;

  for (i = 1; i <= n; i++) {
    for (j = 1; j <= n; j++) {
      a[i - 1].Set(j - 1, a1[i][j]);
      s[i - 1].Set(j - 1, s1[i][j]);
    }
  }

  return (result);
}

#endif
