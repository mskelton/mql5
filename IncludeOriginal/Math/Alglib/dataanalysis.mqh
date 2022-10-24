#ifndef DATAANALYSIS_H
#define DATAANALYSIS_H

#include "ap.mqh"
#include "optimization.mqh"
#include "solvers.mqh"
#include "statistics.mqh"

class CCVReport {
public:
  double m_relclserror;
  double m_avgce;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;

  CCVReport(void);
  ~CCVReport(void);
};

CCVReport::CCVReport(void) {
}

CCVReport::~CCVReport(void) {
}

class CBdSS {
private:
  static double XLnY(const double x, const double y);
  static double GetCV(int &cnt[], const int nc);
  static void TieAddC(int &c[], int &ties[], const int ntie, const int nc,
                      int &cnt[]);
  static void TieSubC(int &c[], int &ties[], const int ntie, const int nc,
                      int &cnt[]);

public:
  CBdSS(void);
  ~CBdSS(void);

  static void DSErrAllocate(const int nclasses, double &buf[]);
  static void DSErrAccumulate(double &buf[], double &y[], double &desiredy[]);
  static void DSErrFinish(double &buf[]);
  static void DSNormalize(CMatrixDouble &xy, const int npoints, const int nvars,
                          int &info, double &means[], double &sigmas[]);
  static void DSNormalizeC(CMatrixDouble &xy, const int npoints,
                           const int nvars, int &info, double &means[],
                           double &sigmas[]);
  static double DSGetMeanMindIstance(CMatrixDouble &xy, const int npoints,
                                     const int nvars);
  static void DSTie(double &a[], const int n, int &ties[], int &tiecount,
                    int &p1[], int &p2[]);
  static void DSTieFastI(double &a[], int &b[], const int n, int &ties[],
                         int &tiecount, double &bufr[], int &bufi[]);
  static void DSOptimalSplit2(double &ca[], int &cc[], const int n, int &info,
                              double &threshold, double &pal, double &pbl,
                              double &par, double &pbr, double &cve);
  static void DSOptimalSplit2Fast(double &a[], int &c[], int &tiesbuf[],
                                  int &cntbuf[], double &bufr[], int &bufi[],
                                  const int n, const int nc, double alpha,
                                  int &info, double &threshold, double &rms,
                                  double &cvrms);
  static void DSSplitK(double &ca[], int &cc[], const int n, const int nc,
                       int kmax, int &info, double &thresholds[], int &ni,
                       double &cve);
  static void DSOptimalSplitK(double &ca[], int &cc[], const int n,
                              const int nc, int kmax, int &info,
                              double &thresholds[], int &ni, double &cve);
};

CBdSS::CBdSS(void) {
}

CBdSS::~CBdSS(void) {
}

static void CBdSS::DSErrAllocate(const int nclasses, double &buf[]) {

  ArrayResizeAL(buf, 8);

  buf[0] = 0;
  buf[1] = 0;
  buf[2] = 0;
  buf[3] = 0;
  buf[4] = 0;
  buf[5] = nclasses;
  buf[6] = 0;
  buf[7] = 0;
}

static void CBdSS::DSErrAccumulate(double &buf[], double &y[],
                                   double &desiredy[]) {

  int nclasses = 0;
  int nout = 0;
  int offs = 0;
  int mmax = 0;
  int rmax = 0;
  int j = 0;
  double v = 0;
  double ev = 0;

  offs = 5;
  nclasses = (int)MathRound(buf[offs]);

  if (nclasses > 0) {

    rmax = (int)MathRound(desiredy[0]);
    mmax = 0;

    for (j = 1; j <= nclasses - 1; j++) {

      if (y[j] > y[mmax])
        mmax = j;
    }

    if (mmax != rmax)
      buf[0] = buf[0] + 1;

    if (y[rmax] > 0.0)
      buf[1] = buf[1] - MathLog(y[rmax]);
    else
      buf[1] = buf[1] + MathLog(CMath::m_maxrealnumber);

    for (j = 0; j <= nclasses - 1; j++) {
      v = y[j];

      if (j == rmax)
        ev = 1;
      else
        ev = 0;

      buf[2] = buf[2] + CMath::Sqr(v - ev);
      buf[3] = buf[3] + MathAbs(v - ev);

      if (ev != 0.0) {
        buf[4] = buf[4] + MathAbs((v - ev) / ev);
        buf[offs + 2] = buf[offs + 2] + 1;
      }
    }

    buf[offs + 1] = buf[offs + 1] + 1;
  } else {

    nout = -nclasses;
    rmax = 0;

    for (j = 1; j <= nout - 1; j++) {

      if (desiredy[j] > desiredy[rmax])
        rmax = j;
    }

    mmax = 0;
    for (j = 1; j <= nout - 1; j++) {

      if (y[j] > y[mmax])
        mmax = j;
    }

    if (mmax != rmax)
      buf[0] = buf[0] + 1;

    for (j = 0; j <= nout - 1; j++) {

      v = y[j];
      ev = desiredy[j];
      buf[2] = buf[2] + CMath::Sqr(v - ev);
      buf[3] = buf[3] + MathAbs(v - ev);

      if (ev != 0.0) {
        buf[4] = buf[4] + MathAbs((v - ev) / ev);
        buf[offs + 2] = buf[offs + 2] + 1;
      }
    }

    buf[offs + 1] = buf[offs + 1] + 1;
  }
}

static void CBdSS::DSErrFinish(double &buf[]) {

  int nout = 0;
  int offs = 0;

  offs = 5;
  nout = (int)(MathAbs((int)MathRound(buf[offs])));

  if (buf[offs + 1] != 0.0) {

    buf[0] = buf[0] / buf[offs + 1];
    buf[1] = buf[1] / buf[offs + 1];
    buf[2] = MathSqrt(buf[2] / (nout * buf[offs + 1]));
    buf[3] = buf[3] / (nout * buf[offs + 1]);
  }

  if (buf[offs + 2] != 0.0)
    buf[4] = buf[4] / buf[offs + 2];
}

static void CBdSS::DSNormalize(CMatrixDouble &xy, const int npoints,
                               const int nvars, int &info, double &means[],
                               double &sigmas[]) {

  int i = 0;
  int j = 0;
  double mean = 0;
  double variance = 0;
  double skewness = 0;
  double kurtosis = 0;
  int i_ = 0;

  double tmp[];

  info = 0;

  if (npoints <= 0 || nvars < 1) {
    info = -1;
    return;
  }

  info = 1;

  ArrayResizeAL(means, nvars);
  ArrayResizeAL(sigmas, nvars);
  ArrayResizeAL(tmp, npoints);

  for (j = 0; j <= nvars - 1; j++) {

    for (i_ = 0; i_ <= npoints - 1; i_++)
      tmp[i_] = xy[i_][j];

    CBaseStat::SampleMoments(tmp, npoints, mean, variance, skewness, kurtosis);

    means[j] = mean;
    sigmas[j] = MathSqrt(variance);

    if (sigmas[j] == 0.0)
      sigmas[j] = 1;

    for (i = 0; i <= npoints - 1; i++)
      xy[i].Set(j, (xy[i][j] - means[j]) / sigmas[j]);
  }
}

static void CBdSS::DSNormalizeC(CMatrixDouble &xy, const int npoints,
                                const int nvars, int &info, double &means[],
                                double &sigmas[]) {

  int j = 0;
  double mean = 0;
  double variance = 0;
  double skewness = 0;
  double kurtosis = 0;
  int i_ = 0;

  double tmp[];

  info = 0;

  if (npoints <= 0 || nvars < 1) {
    info = -1;
    return;
  }

  info = 1;

  ArrayResizeAL(means, nvars);
  ArrayResizeAL(sigmas, nvars);
  ArrayResizeAL(tmp, npoints);
  for (j = 0; j <= nvars - 1; j++) {

    for (i_ = 0; i_ <= npoints - 1; i_++)
      tmp[i_] = xy[i_][j];

    CBaseStat::SampleMoments(tmp, npoints, mean, variance, skewness, kurtosis);

    means[j] = mean;
    sigmas[j] = MathSqrt(variance);

    if (sigmas[j] == 0.0)
      sigmas[j] = 1;
  }
}

static double CBdSS::DSGetMeanMindIstance(CMatrixDouble &xy, const int npoints,
                                          const int nvars) {

  double result = 0;
  int i = 0;
  int j = 0;
  double v = 0;
  int i_ = 0;

  double tmp[];
  double tmp2[];

  if (npoints <= 0 || nvars < 1)
    return (0);

  ArrayResizeAL(tmp, npoints);
  for (i = 0; i <= npoints - 1; i++)
    tmp[i] = CMath::m_maxrealnumber;

  ArrayResizeAL(tmp2, nvars);
  for (i = 0; i <= npoints - 1; i++) {
    for (j = i + 1; j <= npoints - 1; j++) {

      for (i_ = 0; i_ <= nvars - 1; i_++)
        tmp2[i_] = xy[i][i_];
      for (i_ = 0; i_ <= nvars - 1; i_++)
        tmp2[i_] = tmp2[i_] - xy[j][i_];
      v = 0.0;
      for (i_ = 0; i_ <= nvars - 1; i_++)
        v += tmp2[i_] * tmp2[i_];

      v = MathSqrt(v);
      tmp[i] = MathMin(tmp[i], v);
      tmp[j] = MathMin(tmp[j], v);
    }
  }

  result = 0;
  for (i = 0; i <= npoints - 1; i++)
    result = result + tmp[i] / npoints;

  return (result);
}

static void CBdSS::DSTie(double &a[], const int n, int &ties[], int &tiecount,
                         int &p1[], int &p2[]) {

  int i = 0;
  int k = 0;

  int tmp[];

  tiecount = 0;

  if (n <= 0) {
    tiecount = 0;
    return;
  }

  CTSort::TagSort(a, n, p1, p2);

  tiecount = 1;
  for (i = 1; i <= n - 1; i++) {

    if (a[i] != a[i - 1])
      tiecount = tiecount + 1;
  }

  ArrayResizeAL(ties, tiecount + 1);

  ties[0] = 0;
  k = 1;

  for (i = 1; i <= n - 1; i++) {

    if (a[i] != a[i - 1]) {
      ties[k] = i;
      k = k + 1;
    }
  }

  ties[tiecount] = n;
}

static void CBdSS::DSTieFastI(double &a[], int &b[], const int n, int &ties[],
                              int &tiecount, double &bufr[], int &bufi[]) {

  int i = 0;
  int k = 0;

  int tmp[];

  tiecount = 0;

  if (n <= 0) {
    tiecount = 0;
    return;
  }

  CTSort::TagSortFastI(a, b, bufr, bufi, n);

  ties[0] = 0;
  k = 1;

  for (i = 1; i <= n - 1; i++) {

    if (a[i] != a[i - 1]) {
      ties[k] = i;
      k = k + 1;
    }
  }

  ties[k] = n;
  tiecount = k;
}

static void CBdSS::DSOptimalSplit2(double &ca[], int &cc[], const int n,
                                   int &info, double &threshold, double &pal,
                                   double &pbl, double &par, double &pbr,
                                   double &cve) {

  int i = 0;
  int t = 0;
  double s = 0;
  int tiecount = 0;
  int k = 0;
  int koptimal = 0;
  double pak = 0;
  double pbk = 0;
  double cvoptimal = 0;
  double cv = 0;

  int ties[];
  int p1[];
  int p2[];
  double a[];
  int c[];

  ArrayCopy(a, ca);
  ArrayCopy(c, cc);

  info = 0;
  threshold = 0;
  pal = 0;
  pbl = 0;
  par = 0;
  pbr = 0;
  cve = 0;

  if (n <= 0) {
    info = -1;
    return;
  }
  for (i = 0; i <= n - 1; i++) {

    if (c[i] != 0 && c[i] != 1) {
      info = -2;
      return;
    }
  }

  info = 1;

  DSTie(a, n, ties, tiecount, p1, p2);

  for (i = 0; i <= n - 1; i++) {

    if (p2[i] != i) {
      t = c[i];
      c[i] = c[p2[i]];
      c[p2[i]] = t;
    }
  }

  if (tiecount == 1) {
    info = -3;
    return;
  }

  pal = 0;
  pbl = 0;
  par = 0;
  pbr = 0;
  for (i = 0; i <= n - 1; i++) {

    if (c[i] == 0)
      par = par + 1;

    if (c[i] == 1)
      pbr = pbr + 1;
  }

  koptimal = -1;
  cvoptimal = CMath::m_maxrealnumber;
  for (k = 0; k <= tiecount - 2; k++) {

    pak = 0;
    pbk = 0;
    for (i = ties[k]; i <= ties[k + 1] - 1; i++) {

      if (c[i] == 0)
        pak = pak + 1;

      if (c[i] == 1)
        pbk = pbk + 1;
    }

    cv = 0;
    cv = cv - XLnY(pal + pak, (pal + pak) / (pal + pak + pbl + pbk + 1));
    cv = cv - XLnY(pbl + pbk, (pbl + pbk) / (pal + pak + 1 + pbl + pbk));
    cv = cv - XLnY(par - pak, (par - pak) / (par - pak + pbr - pbk + 1));
    cv = cv - XLnY(pbr - pbk, (pbr - pbk) / (par - pak + 1 + pbr - pbk));

    if (cv < cvoptimal) {
      cvoptimal = cv;
      koptimal = k;
    }

    pal = pal + pak;
    pbl = pbl + pbk;
    par = par - pak;
    pbr = pbr - pbk;
  }

  cve = cvoptimal;
  threshold = 0.5 * (a[ties[koptimal]] + a[ties[koptimal + 1]]);
  pal = 0;
  pbl = 0;
  par = 0;
  pbr = 0;
  for (i = 0; i <= n - 1; i++) {

    if (a[i] < threshold) {

      if (c[i] == 0)
        pal = pal + 1;
      else
        pbl = pbl + 1;
    } else {

      if (c[i] == 0)
        par = par + 1;
      else
        pbr = pbr + 1;
    }
  }

  s = pal + pbl;
  pal = pal / s;
  pbl = pbl / s;
  s = par + pbr;
  par = par / s;
  pbr = pbr / s;
}

static void CBdSS::DSOptimalSplit2Fast(double &a[], int &c[], int &tiesbuf[],
                                       int &cntbuf[], double &bufr[],
                                       int &bufi[], const int n, const int nc,
                                       double alpha, int &info,
                                       double &threshold, double &rms,
                                       double &cvrms) {

  int i = 0;
  int k = 0;
  int cl = 0;
  int tiecount = 0;
  double cbest = 0;
  double cc = 0;
  int koptimal = 0;
  int sl = 0;
  int sr = 0;
  double v = 0;
  double w = 0;
  double x = 0;

  info = 0;
  threshold = 0;
  rms = 0;
  cvrms = 0;

  if (n <= 0 || nc < 2) {
    info = -1;
    return;
  }
  for (i = 0; i <= n - 1; i++) {

    if (c[i] < 0 || c[i] >= nc) {
      info = -2;
      return;
    }
  }

  info = 1;

  DSTieFastI(a, c, n, tiesbuf, tiecount, bufr, bufi);

  if (tiecount == 1) {
    info = -3;
    return;
  }

  for (i = 0; i <= 2 * nc - 1; i++)
    cntbuf[i] = 0;
  for (i = 0; i <= n - 1; i++)
    cntbuf[nc + c[i]] = cntbuf[nc + c[i]] + 1;

  koptimal = -1;
  threshold = a[n - 1];
  cbest = CMath::m_maxrealnumber;
  sl = 0;
  sr = n;

  for (k = 0; k <= tiecount - 2; k++) {

    for (i = tiesbuf[k]; i <= tiesbuf[k + 1] - 1; i++) {
      cl = c[i];
      cntbuf[cl] = cntbuf[cl] + 1;
      cntbuf[nc + cl] = cntbuf[nc + cl] - 1;
    }
    sl = sl + (tiesbuf[k + 1] - tiesbuf[k]);
    sr = sr - (tiesbuf[k + 1] - tiesbuf[k]);

    v = 0;
    for (i = 0; i <= nc - 1; i++) {
      w = cntbuf[i];
      v = v + w * CMath::Sqr(w / sl - 1);
      v = v + (sl - w) * CMath::Sqr(w / sl);
      w = cntbuf[nc + i];
      v = v + w * CMath::Sqr(w / sr - 1);
      v = v + (sr - w) * CMath::Sqr(w / sr);
    }

    v = MathSqrt(v / (nc * n));

    x = (double)(2 * sl) / (double)(sl + sr) - 1;
    cc = v * (1 - alpha + alpha * CMath::Sqr(x));

    if (cc < cbest) {

      rms = v;
      koptimal = k;
      cbest = cc;

      cvrms = 0;
      for (i = 0; i <= nc - 1; i++) {

        if (sl > 1) {
          w = cntbuf[i];
          cvrms = cvrms + w * CMath::Sqr((w - 1) / (sl - 1) - 1);
          cvrms = cvrms + (sl - w) * CMath::Sqr(w / (sl - 1));
        } else {
          w = cntbuf[i];
          cvrms = cvrms + w * CMath::Sqr(1.0 / (double)nc - 1);
          cvrms = cvrms + (sl - w) * CMath::Sqr(1.0 / (double)nc);
        }

        if (sr > 1) {
          w = cntbuf[nc + i];
          cvrms = cvrms + w * CMath::Sqr((w - 1) / (sr - 1) - 1);
          cvrms = cvrms + (sr - w) * CMath::Sqr(w / (sr - 1));
        } else {
          w = cntbuf[nc + i];
          cvrms = cvrms + w * CMath::Sqr(1.0 / (double)nc - 1);
          cvrms = cvrms + (sr - w) * CMath::Sqr(1.0 / (double)nc);
        }
      }

      cvrms = MathSqrt(cvrms / (nc * n));
    }
  }

  threshold = 0.5 * (a[tiesbuf[koptimal]] + a[tiesbuf[koptimal + 1]]);

  if (threshold <= a[tiesbuf[koptimal]])
    threshold = a[tiesbuf[koptimal + 1]];
}

static void CBdSS::DSSplitK(double &ca[], int &cc[], const int n, const int nc,
                            int kmax, int &info, double &thresholds[], int &ni,
                            double &cve) {

  int i = 0;
  int j = 0;
  int j1 = 0;
  int k = 0;
  int tiecount = 0;
  double v2 = 0;
  int bestk = 0;
  double bestcve = 0;
  double curcve = 0;

  int ties[];
  int p1[];
  int p2[];
  int cnt[];
  int bestsizes[];
  int cursizes[];
  double a[];
  int c[];

  ArrayCopy(a, ca);
  ArrayCopy(c, cc);

  info = 0;
  ni = 0;
  cve = 0;

  if ((n <= 0 || nc < 2) || kmax < 2) {
    info = -1;
    return;
  }
  for (i = 0; i <= n - 1; i++) {

    if (c[i] < 0 || c[i] >= nc) {
      info = -2;
      return;
    }
  }

  info = 1;

  DSTie(a, n, ties, tiecount, p1, p2);

  for (i = 0; i <= n - 1; i++) {

    if (p2[i] != i) {
      k = c[i];
      c[i] = c[p2[i]];
      c[p2[i]] = k;
    }
  }

  if (tiecount == 1) {
    info = -3;
    return;
  }

  kmax = MathMin(kmax, tiecount);

  ArrayResizeAL(bestsizes, kmax);
  ArrayResizeAL(cursizes, kmax);
  ArrayResizeAL(cnt, nc);

  v2 = CMath::m_maxrealnumber;
  j = -1;
  for (i = 1; i <= tiecount - 1; i++) {

    if (MathAbs(ties[i] - 0.5 * (n - 1)) < v2) {
      v2 = MathAbs(ties[i] - 0.5 * n);
      j = i;
    }
  }

  if (!CAp::Assert(j > 0, __FUNCTION__ + ": internal error #1!"))
    return;

  bestk = 2;
  bestsizes[0] = ties[j];
  bestsizes[1] = n - j;
  bestcve = 0;

  for (i = 0; i <= nc - 1; i++)
    cnt[i] = 0;
  for (i = 0; i <= j - 1; i++)
    TieAddC(c, ties, i, nc, cnt);
  bestcve = bestcve + GetCV(cnt, nc);

  for (i = 0; i <= nc - 1; i++)
    cnt[i] = 0;
  for (i = j; i <= tiecount - 1; i++)
    TieAddC(c, ties, i, nc, cnt);
  bestcve = bestcve + GetCV(cnt, nc);

  for (k = 2; k <= kmax; k++) {

    for (i = 0; i <= k - 1; i++)
      cursizes[i] = 0;

    i = 0;
    j = 0;

    while (j <= tiecount - 1 && i <= k - 1) {

      if (cursizes[i] == 0) {
        cursizes[i] = ties[j + 1] - ties[j];
        j = j + 1;
        continue;
      }

      if (tiecount - j == k - 1 - i) {
        i = i + 1;
        continue;
      }

      if (i == k - 1) {
        cursizes[i] = cursizes[i] + ties[j + 1] - ties[j];
        j = j + 1;
        continue;
      }

      if (MathAbs(cursizes[i] + ties[j + 1] - ties[j] - (double)n / (double)k) <
          MathAbs(cursizes[i] - (double)n / (double)k)) {
        cursizes[i] = cursizes[i] + ties[j + 1] - ties[j];
        j = j + 1;
      } else
        i = i + 1;
    }

    if (!CAp::Assert(cursizes[k - 1] != 0 && j == tiecount,
                     __FUNCTION__ + ": internal error #1"))
      return;

    curcve = 0;
    j = 0;
    for (i = 0; i <= k - 1; i++) {

      for (j1 = 0; j1 <= nc - 1; j1++)
        cnt[j1] = 0;
      for (j1 = j; j1 <= j + cursizes[i] - 1; j1++)
        cnt[c[j1]] = cnt[c[j1]] + 1;
      curcve = curcve + GetCV(cnt, nc);
      j = j + cursizes[i];
    }

    if (curcve < bestcve) {
      for (i = 0; i <= k - 1; i++)
        bestsizes[i] = cursizes[i];
      bestcve = curcve;
      bestk = k;
    }
  }

  cve = bestcve;
  ni = bestk;

  ArrayResizeAL(thresholds, ni - 1);
  j = bestsizes[0];

  for (i = 1; i <= bestk - 1; i++) {
    thresholds[i - 1] = 0.5 * (a[j - 1] + a[j]);
    j = j + bestsizes[i];
  }
}

static void CBdSS::DSOptimalSplitK(double &ca[], int &cc[], const int n,
                                   const int nc, int kmax, int &info,
                                   double &thresholds[], int &ni, double &cve) {

  int i = 0;
  int j = 0;
  int s = 0;
  int jl = 0;
  int jr = 0;
  double v2 = 0;
  int tiecount = 0;
  double cvtemp = 0;
  int k = 0;
  int koptimal = 0;
  double cvoptimal = 0;

  int ties[];
  int p1[];
  int p2[];
  int cnt[];
  int cnt2[];
  double a[];
  int c[];

  CMatrixDouble cv;
  CMatrixInt splits;

  ArrayCopy(a, ca);
  ArrayCopy(c, cc);

  info = 0;
  ni = 0;
  cve = 0;

  if ((n <= 0 || nc < 2) || kmax < 2) {
    info = -1;
    return;
  }
  for (i = 0; i <= n - 1; i++) {

    if (c[i] < 0 || c[i] >= nc) {
      info = -2;
      return;
    }
  }

  info = 1;

  DSTie(a, n, ties, tiecount, p1, p2);

  for (i = 0; i <= n - 1; i++) {

    if (p2[i] != i) {
      k = c[i];
      c[i] = c[p2[i]];
      c[p2[i]] = k;
    }
  }

  if (tiecount == 1) {
    info = -3;
    return;
  }

  kmax = MathMin(kmax, tiecount);

  cv.Resize(kmax, tiecount);
  splits.Resize(kmax, tiecount);
  ArrayResizeAL(cnt, nc);
  ArrayResizeAL(cnt2, nc);

  for (j = 0; j <= nc - 1; j++)
    cnt[j] = 0;
  for (j = 0; j <= tiecount - 1; j++) {
    TieAddC(c, ties, j, nc, cnt);
    splits[0].Set(j, 0);
    cv[0].Set(j, GetCV(cnt, nc));
  }
  for (k = 1; k <= kmax - 1; k++) {
    for (j = 0; j <= nc - 1; j++)
      cnt[j] = 0;

    for (j = k; j <= tiecount - 1; j++) {

      TieAddC(c, ties, j, nc, cnt);

      for (i = 0; i <= nc - 1; i++)
        cnt2[i] = cnt[i];
      cv[k].Set(j, cv[k - 1][j - 1] + GetCV(cnt2, nc));
      splits[k].Set(j, j);

      for (s = k + 1; s <= j; s++) {

        TieSubC(c, ties, s - 1, nc, cnt2);

        cvtemp = cv[k - 1][s - 1] + GetCV(cnt2, nc);

        if (cvtemp < cv[k][j]) {
          cv[k].Set(j, cvtemp);
          splits[k].Set(j, s);
        }
      }
    }
  }

  koptimal = -1;
  cvoptimal = CMath::m_maxrealnumber;
  for (k = 0; k <= kmax - 1; k++) {

    if (cv[k][tiecount - 1] < cvoptimal) {
      cvoptimal = cv[k][tiecount - 1];
      koptimal = k;
    }
  }

  if (!CAp::Assert(koptimal >= 0, __FUNCTION__ + ": internal error #1!"))
    return;

  if (koptimal == 0) {

    v2 = CMath::m_maxrealnumber;
    j = -1;
    for (i = 1; i <= tiecount - 1; i++) {

      if (MathAbs(ties[i] - 0.5 * (n - 1)) < v2) {
        v2 = MathAbs(ties[i] - 0.5 * (n - 1));
        j = i;
      }
    }

    if (!CAp::Assert(j > 0, __FUNCTION__ + ": internal error #2!"))
      return;

    ArrayResizeAL(thresholds, 1);

    thresholds[0] = 0.5 * (a[ties[j - 1]] + a[ties[j]]);
    ni = 2;
    cve = 0;

    for (i = 0; i <= nc - 1; i++)
      cnt[i] = 0;
    for (i = 0; i <= j - 1; i++)
      TieAddC(c, ties, i, nc, cnt);
    cve = cve + GetCV(cnt, nc);
    for (i = 0; i <= nc - 1; i++)
      cnt[i] = 0;
    for (i = j; i <= tiecount - 1; i++)
      TieAddC(c, ties, i, nc, cnt);
    cve = cve + GetCV(cnt, nc);
  } else {

    ArrayResizeAL(thresholds, koptimal);
    ni = koptimal + 1;
    cve = cv[koptimal][tiecount - 1];
    jl = splits[koptimal][tiecount - 1];
    jr = tiecount - 1;

    for (k = koptimal; k >= 1; k--) {
      thresholds[k - 1] = 0.5 * (a[ties[jl - 1]] + a[ties[jl]]);
      jr = jl - 1;
      jl = splits[k - 1][jl - 1];
    }
  }
}

static double CBdSS::XLnY(const double x, const double y) {

  if (x == 0.0)
    return (0);

  return (x * MathLog(y));
}

static double CBdSS::GetCV(int &cnt[], const int nc) {

  double result = 0;
  int i = 0;
  double s = 0;

  s = 0;
  for (i = 0; i <= nc - 1; i++)
    s = s + cnt[i];

  result = 0;
  for (i = 0; i <= nc - 1; i++)
    result = result - XLnY(cnt[i], cnt[i] / (s + nc - 1));

  return (result);
}

static void CBdSS::TieAddC(int &c[], int &ties[], const int ntie, const int nc,
                           int &cnt[]) {

  int i = 0;

  for (i = ties[ntie]; i <= ties[ntie + 1] - 1; i++)
    cnt[c[i]] = cnt[c[i]] + 1;
}

static void CBdSS::TieSubC(int &c[], int &ties[], const int ntie, const int nc,
                           int &cnt[]) {

  int i = 0;

  for (i = ties[ntie]; i <= ties[ntie + 1] - 1; i++)
    cnt[c[i]] = cnt[c[i]] - 1;
}

class CDecisionForest {
public:
  int m_nvars;
  int m_nclasses;
  int m_ntrees;
  int m_bufsize;
  double m_trees[];

  CDecisionForest(void);
  ~CDecisionForest(void);

  void Copy(CDecisionForest &obj);
};

CDecisionForest::CDecisionForest(void) {
}

CDecisionForest::~CDecisionForest(void) {
}

void CDecisionForest::Copy(CDecisionForest &obj) {

  m_nvars = obj.m_nvars;
  m_nclasses = obj.m_nclasses;
  m_ntrees = obj.m_ntrees;
  m_bufsize = obj.m_bufsize;

  ArrayCopy(m_trees, obj.m_trees);
}

class CDecisionForestShell {
private:
  CDecisionForest m_innerobj;

public:
  CDecisionForestShell(void);
  CDecisionForestShell(CDecisionForest &obj);
  ~CDecisionForestShell(void);

  CDecisionForest *GetInnerObj(void);
};

CDecisionForestShell::CDecisionForestShell(void) {
}

CDecisionForestShell::CDecisionForestShell(CDecisionForest &obj) {

  m_innerobj.Copy(obj);
}

CDecisionForestShell::~CDecisionForestShell(void) {
}

CDecisionForest *CDecisionForestShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CDFReport {
public:
  double m_relclserror;
  double m_avgce;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;
  double m_oobrelclserror;
  double m_oobavgce;
  double m_oobrmserror;
  double m_oobavgerror;
  double m_oobavgrelerror;

  CDFReport(void);
  ~CDFReport(void);

  void Copy(CDFReport &obj);
};

CDFReport::CDFReport(void) {
}

CDFReport::~CDFReport(void) {
}

void CDFReport::Copy(CDFReport &obj) {

  m_relclserror = obj.m_relclserror;
  m_avgce = obj.m_avgce;
  m_rmserror = obj.m_rmserror;
  m_avgerror = obj.m_avgerror;
  m_avgrelerror = obj.m_avgrelerror;
  m_oobrelclserror = obj.m_oobrelclserror;
  m_oobavgce = obj.m_oobavgce;
  m_oobrmserror = obj.m_oobrmserror;
  m_oobavgerror = obj.m_oobavgerror;
  m_oobavgrelerror = obj.m_oobavgrelerror;
}

class CDFReportShell {
private:
  CDFReport m_innerobj;

public:
  CDFReportShell(void);
  CDFReportShell(CDFReport &obj);
  ~CDFReportShell(void);

  double GetRelClsError(void);
  void SetRelClsError(const double d);
  double GetAvgCE(void);
  void SetAvgCE(const double d);
  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  double GetOOBRelClsError(void);
  void SetOOBRelClsError(const double d);
  double GetOOBAvgCE(void);
  void SetOOBAvgCE(const double d);
  double GetOOBRMSError(void);
  void SetOOBRMSError(const double d);
  double GetOOBAvgError(void);
  void SetOOBAvgError(const double d);
  double GetOOBAvgRelError(void);
  void SetOOBAvgRelError(const double d);
  CDFReport *GetInnerObj(void);
};

CDFReportShell::CDFReportShell(void) {
}

CDFReportShell::CDFReportShell(CDFReport &obj) {

  m_innerobj.Copy(obj);
}

CDFReportShell::~CDFReportShell(void) {
}

double CDFReportShell::GetRelClsError(void) {

  return (m_innerobj.m_relclserror);
}

void CDFReportShell::SetRelClsError(const double d) {

  m_innerobj.m_relclserror = d;
}

double CDFReportShell::GetAvgCE(void) {

  return (m_innerobj.m_avgce);
}

void CDFReportShell::SetAvgCE(const double d) {

  m_innerobj.m_avgce = d;
}

double CDFReportShell::GetRMSError(void) {

  return (m_innerobj.m_rmserror);
}

void CDFReportShell::SetRMSError(const double d) {

  m_innerobj.m_rmserror = d;
}

double CDFReportShell::GetAvgError(void) {

  return (m_innerobj.m_avgerror);
}

void CDFReportShell::SetAvgError(const double d) {

  m_innerobj.m_avgerror = d;
}

double CDFReportShell::GetAvgRelError(void) {

  return (m_innerobj.m_avgrelerror);
}

void CDFReportShell::SetAvgRelError(const double d) {

  m_innerobj.m_avgrelerror = d;
}

double CDFReportShell::GetOOBRelClsError(void) {

  return (m_innerobj.m_oobrelclserror);
}

void CDFReportShell::SetOOBRelClsError(const double d) {

  m_innerobj.m_oobrelclserror = d;
}

double CDFReportShell::GetOOBAvgCE(void) {

  return (m_innerobj.m_oobavgce);
}

void CDFReportShell::SetOOBAvgCE(const double d) {

  m_innerobj.m_oobavgce = d;
}

double CDFReportShell::GetOOBRMSError(void) {

  return (m_innerobj.m_oobrmserror);
}

void CDFReportShell::SetOOBRMSError(const double d) {

  m_innerobj.m_oobrmserror = d;
}

double CDFReportShell::GetOOBAvgError(void) {

  return (m_innerobj.m_oobavgerror);
}

void CDFReportShell::SetOOBAvgError(const double d) {

  m_innerobj.m_oobavgerror = d;
}

double CDFReportShell::GetOOBAvgRelError(void) {

  return (m_innerobj.m_oobavgrelerror);
}

void CDFReportShell::SetOOBAvgRelError(const double d) {

  m_innerobj.m_oobavgrelerror = d;
}

CDFReport *CDFReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CDFInternalBuffers {
public:
  double m_treebuf[];
  int m_idxbuf[];
  double m_tmpbufr[];
  double m_tmpbufr2[];
  int m_tmpbufi[];
  int m_classibuf[];
  double m_sortrbuf[];
  double m_sortrbuf2[];
  int m_sortibuf[];
  int m_varpool[];
  bool m_evsbin[];
  double m_evssplits[];

  CDFInternalBuffers(void);
  ~CDFInternalBuffers(void);
};

CDFInternalBuffers::CDFInternalBuffers(void) {
}

CDFInternalBuffers::~CDFInternalBuffers(void) {
}

class CDForest {
private:
  static int DFClsError(CDecisionForest &df, CMatrixDouble &xy,
                        const int npoints);
  static void DFProcessInternal(CDecisionForest &df, const int offs,
                                double &x[], double &y[]);
  static void DFBuildTree(CMatrixDouble &xy, const int npoints, const int nvars,
                          const int nclasses, const int nfeatures,
                          const int nvarsinpool, const int flags,
                          CDFInternalBuffers &bufs);
  static void DFBuildTreeRec(CMatrixDouble &xy, const int npoints,
                             const int nvars, const int nclasses,
                             const int nfeatures, int nvarsinpool,
                             const int flags, int &numprocessed, const int idx1,
                             const int idx2, CDFInternalBuffers &bufs);
  static void DFSplitC(double &x[], int &c[], int &cntbuf[], const int n,
                       const int nc, const int flags, int &info,
                       double &threshold, double &e, double &sortrbuf[],
                       int &sortibuf[]);
  static void DFSplitR(double &x[], double &y[], const int n, const int flags,
                       int &info, double &threshold, double &e,
                       double &sortrbuf[], double &sortrbuf2[]);

public:
  static const int m_innernodewidth;
  static const int m_leafnodewidth;
  static const int m_dfusestrongsplits;
  static const int m_dfuseevs;
  static const int m_dffirstversion;

  CDForest(void);
  ~CDForest(void);

  static void DFBuildRandomDecisionForest(CMatrixDouble &xy, const int npoints,
                                          const int nvars, const int nclasses,
                                          const int ntrees, const double r,
                                          int &info, CDecisionForest &df,
                                          CDFReport &rep);
  static void DFBuildRandomDecisionForestX1(
      CMatrixDouble &xy, const int npoints, const int nvars, const int nclasses,
      const int ntrees, const int nrndvars, const double r, int &info,
      CDecisionForest &df, CDFReport &rep);
  static void DFBuildInternal(CMatrixDouble &xy, const int npoints,
                              const int nvars, const int nclasses,
                              const int ntrees, const int samplesize,
                              const int nfeatures, const int flags, int &info,
                              CDecisionForest &df, CDFReport &rep);
  static void DFProcess(CDecisionForest &df, double &x[], double &y[]);
  static void DFProcessI(CDecisionForest &df, double &x[], double &y[]);
  static double DFRelClsError(CDecisionForest &df, CMatrixDouble &xy,
                              const int npoints);
  static double DFAvgCE(CDecisionForest &df, CMatrixDouble &xy,
                        const int npoints);
  static double DFRMSError(CDecisionForest &df, CMatrixDouble &xy,
                           const int npoints);
  static double DFAvgError(CDecisionForest &df, CMatrixDouble &xy,
                           const int npoints);
  static double DFAvgRelError(CDecisionForest &df, CMatrixDouble &xy,
                              const int npoints);
  static void DFCopy(CDecisionForest &df1, CDecisionForest &df2);
  static void DFAlloc(CSerializer &s, CDecisionForest &forest);
  static void DFSerialize(CSerializer &s, CDecisionForest &forest);
  static void DFUnserialize(CSerializer &s, CDecisionForest &forest);
};

const int CDForest::m_innernodewidth = 3;
const int CDForest::m_leafnodewidth = 2;
const int CDForest::m_dfusestrongsplits = 1;
const int CDForest::m_dfuseevs = 2;
const int CDForest::m_dffirstversion = 0;

CDForest::CDForest(void) {
}

CDForest::~CDForest(void) {
}

static void CDForest::DFBuildRandomDecisionForest(
    CMatrixDouble &xy, const int npoints, const int nvars, const int nclasses,
    const int ntrees, const double r, int &info, CDecisionForest &df,
    CDFReport &rep) {

  int samplesize = 0;

  info = 0;

  if (r <= 0.0 || r > 1.0) {
    info = -1;
    return;
  }

  samplesize = (int)(MathMax((int)MathRound(r * npoints), 1));

  DFBuildInternal(xy, npoints, nvars, nclasses, ntrees, samplesize,
                  (int)(MathMax(nvars / 2, 1)),
                  m_dfusestrongsplits + m_dfuseevs, info, df, rep);
}

static void CDForest::DFBuildRandomDecisionForestX1(
    CMatrixDouble &xy, const int npoints, const int nvars, const int nclasses,
    const int ntrees, const int nrndvars, const double r, int &info,
    CDecisionForest &df, CDFReport &rep) {

  int samplesize = 0;

  info = 0;

  if (r <= 0.0 || r > 1.0) {
    info = -1;
    return;
  }

  if (nrndvars <= 0 || nrndvars > nvars) {
    info = -1;
    return;
  }

  samplesize = (int)(MathMax((int)MathRound(r * npoints), 1));

  DFBuildInternal(xy, npoints, nvars, nclasses, ntrees, samplesize, nrndvars,
                  m_dfusestrongsplits + m_dfuseevs, info, df, rep);
}

static void CDForest::DFBuildInternal(CMatrixDouble &xy, const int npoints,
                                      const int nvars, const int nclasses,
                                      const int ntrees, const int samplesize,
                                      const int nfeatures, const int flags,
                                      int &info, CDecisionForest &df,
                                      CDFReport &rep) {

  int i = 0;
  int j = 0;
  int k = 0;
  int tmpi = 0;
  int lasttreeoffs = 0;
  int offs = 0;
  int ooboffs = 0;
  int treesize = 0;
  int nvarsinpool = 0;
  bool useevs;
  int oobcnt = 0;
  int oobrelcnt = 0;
  double v = 0;
  double vmin = 0;
  double vmax = 0;
  bool bflag;
  int i_ = 0;
  int i1_ = 0;

  int permbuf[];
  double oobbuf[];
  int oobcntbuf[];
  double x[];
  double y[];

  CMatrixDouble xys;

  CDFInternalBuffers bufs;

  info = 0;

  if (npoints < 1 || samplesize < 1 || samplesize > npoints || nvars < 1 ||
      nclasses < 1 || ntrees < 1 || nfeatures < 1) {
    info = -1;
    return;
  }

  if (nclasses > 1) {
    for (i = 0; i <= npoints - 1; i++) {

      if ((int)MathRound(xy[i][nvars]) < 0 ||
          (int)MathRound(xy[i][nvars]) >= nclasses) {
        info = -2;
        return;
      }
    }
  }

  info = 1;

  useevs = flags / m_dfuseevs % 2 != 0;

  treesize =
      1 + m_innernodewidth * (samplesize - 1) + m_leafnodewidth * samplesize;

  ArrayResizeAL(permbuf, npoints);
  ArrayResizeAL(bufs.m_treebuf, treesize);
  ArrayResizeAL(bufs.m_idxbuf, npoints);
  ArrayResizeAL(bufs.m_tmpbufr, npoints);
  ArrayResizeAL(bufs.m_tmpbufr2, npoints);
  ArrayResizeAL(bufs.m_tmpbufi, npoints);
  ArrayResizeAL(bufs.m_sortrbuf, npoints);
  ArrayResizeAL(bufs.m_sortrbuf2, npoints);
  ArrayResizeAL(bufs.m_sortibuf, npoints);
  ArrayResizeAL(bufs.m_varpool, nvars);
  ArrayResizeAL(bufs.m_evsbin, nvars);
  ArrayResizeAL(bufs.m_evssplits, nvars);
  ArrayResizeAL(bufs.m_classibuf, 2 * nclasses);
  ArrayResizeAL(oobbuf, nclasses * npoints);
  ArrayResizeAL(oobcntbuf, npoints);
  ArrayResizeAL(df.m_trees, ntrees * treesize);
  xys.Resize(samplesize, nvars + 1);
  ArrayResizeAL(x, nvars);
  ArrayResizeAL(y, nclasses);

  for (i = 0; i <= npoints - 1; i++)
    permbuf[i] = i;
  for (i = 0; i <= npoints * nclasses - 1; i++)
    oobbuf[i] = 0;
  for (i = 0; i <= npoints - 1; i++)
    oobcntbuf[i] = 0;

  for (i = 0; i <= nvars - 1; i++)
    bufs.m_varpool[i] = i;
  nvarsinpool = nvars;

  if (useevs) {
    for (j = 0; j <= nvars - 1; j++) {
      vmin = xy[0][j];
      vmax = vmin;

      for (i = 0; i <= npoints - 1; i++) {
        v = xy[i][j];
        vmin = MathMin(vmin, v);
        vmax = MathMax(vmax, v);
      }

      if (vmin == vmax) {

        bufs.m_varpool[j] = bufs.m_varpool[nvarsinpool - 1];
        bufs.m_varpool[nvarsinpool - 1] = -1;
        nvarsinpool = nvarsinpool - 1;
        continue;
      }

      bflag = false;
      for (i = 0; i <= npoints - 1; i++) {
        v = xy[i][j];

        if (v != vmin && v != vmax) {
          bflag = true;
          break;
        }
      }

      if (bflag) {

        bufs.m_evsbin[j] = false;
      } else {

        bufs.m_evsbin[j] = true;
        bufs.m_evssplits[j] = 0.5 * (vmin + vmax);

        if (bufs.m_evssplits[j] <= vmin)
          bufs.m_evssplits[j] = vmax;
      }
    }
  }

  df.m_nvars = nvars;
  df.m_nclasses = nclasses;
  df.m_ntrees = ntrees;

  offs = 0;
  for (i = 0; i <= ntrees - 1; i++) {

    for (k = 0; k <= samplesize - 1; k++) {

      j = k + CMath::RandomInteger(npoints - k);
      tmpi = permbuf[k];
      permbuf[k] = permbuf[j];
      permbuf[j] = tmpi;
      j = permbuf[k];
      for (i_ = 0; i_ <= nvars; i_++)
        xys[k].Set(i_, xy[j][i_]);
    }

    DFBuildTree(xys, samplesize, nvars, nclasses, nfeatures, nvarsinpool, flags,
                bufs);

    j = (int)MathRound(bufs.m_treebuf[0]);
    i1_ = -offs;
    for (i_ = offs; i_ <= offs + j - 1; i_++)
      df.m_trees[i_] = bufs.m_treebuf[i_ + i1_];
    lasttreeoffs = offs;
    offs = offs + j;

    for (k = samplesize; k <= npoints - 1; k++) {
      for (j = 0; j <= nclasses - 1; j++)
        y[j] = 0;
      j = permbuf[k];
      for (i_ = 0; i_ <= nvars - 1; i_++)
        x[i_] = xy[j][i_];

      DFProcessInternal(df, lasttreeoffs, x, y);

      i1_ = -j * nclasses;
      for (i_ = j * nclasses; i_ <= (j + 1) * nclasses - 1; i_++)
        oobbuf[i_] = oobbuf[i_] + y[i_ + i1_];
      oobcntbuf[j] = oobcntbuf[j] + 1;
    }
  }
  df.m_bufsize = offs;

  for (i = 0; i <= npoints - 1; i++) {

    if (oobcntbuf[i] != 0) {
      v = 1.0 / (double)oobcntbuf[i];
      for (i_ = i * nclasses; i_ <= i * nclasses + nclasses - 1; i_++)
        oobbuf[i_] = v * oobbuf[i_];
    }
  }

  rep.m_relclserror = DFRelClsError(df, xy, npoints);
  rep.m_avgce = DFAvgCE(df, xy, npoints);
  rep.m_rmserror = DFRMSError(df, xy, npoints);
  rep.m_avgerror = DFAvgError(df, xy, npoints);
  rep.m_avgrelerror = DFAvgRelError(df, xy, npoints);

  rep.m_oobrelclserror = 0;
  rep.m_oobavgce = 0;
  rep.m_oobrmserror = 0;
  rep.m_oobavgerror = 0;
  rep.m_oobavgrelerror = 0;
  oobcnt = 0;
  oobrelcnt = 0;
  for (i = 0; i <= npoints - 1; i++) {

    if (oobcntbuf[i] != 0) {
      ooboffs = i * nclasses;

      if (nclasses > 1) {

        k = (int)MathRound(xy[i][nvars]);
        tmpi = 0;
        for (j = 1; j <= nclasses - 1; j++) {

          if (oobbuf[ooboffs + j] > oobbuf[ooboffs + tmpi])
            tmpi = j;
        }

        if (tmpi != k)
          rep.m_oobrelclserror = rep.m_oobrelclserror + 1;

        if (oobbuf[ooboffs + k] != 0.0)
          rep.m_oobavgce = rep.m_oobavgce - MathLog(oobbuf[ooboffs + k]);
        else
          rep.m_oobavgce = rep.m_oobavgce - MathLog(CMath::m_minrealnumber);

        for (j = 0; j <= nclasses - 1; j++) {

          if (j == k) {
            rep.m_oobrmserror =
                rep.m_oobrmserror + CMath::Sqr(oobbuf[ooboffs + j] - 1);
            rep.m_oobavgerror =
                rep.m_oobavgerror + MathAbs(oobbuf[ooboffs + j] - 1);
            rep.m_oobavgrelerror =
                rep.m_oobavgrelerror + MathAbs(oobbuf[ooboffs + j] - 1);
            oobrelcnt = oobrelcnt + 1;
          } else {
            rep.m_oobrmserror =
                rep.m_oobrmserror + CMath::Sqr(oobbuf[ooboffs + j]);
            rep.m_oobavgerror =
                rep.m_oobavgerror + MathAbs(oobbuf[ooboffs + j]);
          }
        }
      } else {

        rep.m_oobrmserror =
            rep.m_oobrmserror + CMath::Sqr(oobbuf[ooboffs] - xy[i][nvars]);
        rep.m_oobavgerror =
            rep.m_oobavgerror + MathAbs(oobbuf[ooboffs] - xy[i][nvars]);

        if (xy[i][nvars] != 0.0) {
          rep.m_oobavgrelerror =
              rep.m_oobavgrelerror +
              MathAbs((oobbuf[ooboffs] - xy[i][nvars]) / xy[i][nvars]);
          oobrelcnt = oobrelcnt + 1;
        }
      }

      oobcnt = oobcnt + 1;
    }
  }

  if (oobcnt > 0) {

    rep.m_oobrelclserror = rep.m_oobrelclserror / oobcnt;
    rep.m_oobavgce = rep.m_oobavgce / oobcnt;
    rep.m_oobrmserror = MathSqrt(rep.m_oobrmserror / (oobcnt * nclasses));
    rep.m_oobavgerror = rep.m_oobavgerror / (oobcnt * nclasses);

    if (oobrelcnt > 0)
      rep.m_oobavgrelerror = rep.m_oobavgrelerror / oobrelcnt;
  }
}

static void CDForest::DFProcess(CDecisionForest &df, double &x[], double &y[]) {

  int offs = 0;
  int i = 0;
  double v = 0;
  int i_ = 0;

  if (CAp::Len(y) < df.m_nclasses)
    ArrayResizeAL(y, df.m_nclasses);

  offs = 0;
  for (i = 0; i <= df.m_nclasses - 1; i++)
    y[i] = 0;
  for (i = 0; i <= df.m_ntrees - 1; i++) {

    DFProcessInternal(df, offs, x, y);

    offs = offs + (int)MathRound(df.m_trees[offs]);
  }

  v = 1.0 / (double)df.m_ntrees;
  for (i_ = 0; i_ <= df.m_nclasses - 1; i_++)
    y[i_] = v * y[i_];
}

static void CDForest::DFProcessI(CDecisionForest &df, double &x[],
                                 double &y[]) {

  DFProcess(df, x, y);
}

static double CDForest::DFRelClsError(CDecisionForest &df, CMatrixDouble &xy,
                                      const int npoints) {

  return ((double)DFClsError(df, xy, npoints) / (double)npoints);
}

static double CDForest::DFAvgCE(CDecisionForest &df, CMatrixDouble &xy,
                                const int npoints) {

  double result = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int tmpi = 0;
  int i_ = 0;

  double x[];
  double y[];

  ArrayResizeAL(x, df.m_nvars);
  ArrayResizeAL(y, df.m_nclasses);

  result = 0;
  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= df.m_nvars - 1; i_++)
      x[i_] = xy[i][i_];

    DFProcess(df, x, y);

    if (df.m_nclasses > 1) {

      k = (int)MathRound(xy[i][df.m_nvars]);
      tmpi = 0;
      for (j = 1; j <= df.m_nclasses - 1; j++) {

        if (y[j] > (double)(y[tmpi]))
          tmpi = j;
      }

      if (y[k] != 0.0)
        result = result - MathLog(y[k]);
      else
        result = result - MathLog(CMath::m_minrealnumber);
    }
  }

  return (result / npoints);
}

static double CDForest::DFRMSError(CDecisionForest &df, CMatrixDouble &xy,
                                   const int npoints) {

  double result = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int tmpi = 0;
  int i_ = 0;

  double x[];
  double y[];

  ArrayResizeAL(x, df.m_nvars);
  ArrayResizeAL(y, df.m_nclasses);

  result = 0;
  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= df.m_nvars - 1; i_++)
      x[i_] = xy[i][i_];

    DFProcess(df, x, y);

    if (df.m_nclasses > 1) {

      k = (int)MathRound(xy[i][df.m_nvars]);
      tmpi = 0;
      for (j = 1; j <= df.m_nclasses - 1; j++) {

        if (y[j] > y[tmpi])
          tmpi = j;
      }
      for (j = 0; j <= df.m_nclasses - 1; j++) {

        if (j == k)
          result = result + CMath::Sqr(y[j] - 1);
        else
          result = result + CMath::Sqr(y[j]);
      }
    } else {

      result = result + CMath::Sqr(y[0] - xy[i][df.m_nvars]);
    }
  }

  return (MathSqrt(result / (npoints * df.m_nclasses)));
}

static double CDForest::DFAvgError(CDecisionForest &df, CMatrixDouble &xy,
                                   const int npoints) {

  double result = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int i_ = 0;

  double x[];
  double y[];

  ArrayResizeAL(x, df.m_nvars);
  ArrayResizeAL(y, df.m_nclasses);

  result = 0;
  for (i = 0; i <= npoints - 1; i++) {

    for (i_ = 0; i_ <= df.m_nvars - 1; i_++)
      x[i_] = xy[i][i_];

    DFProcess(df, x, y);

    if (df.m_nclasses > 1) {

      k = (int)MathRound(xy[i][df.m_nvars]);
      for (j = 0; j <= df.m_nclasses - 1; j++) {

        if (j == k)
          result = result + MathAbs(y[j] - 1);
        else
          result = result + MathAbs(y[j]);
      }
    } else {

      result = result + MathAbs(y[0] - xy[i][df.m_nvars]);
    }
  }

  return (result / (npoints * df.m_nclasses));
}

static double CDForest::DFAvgRelError(CDecisionForest &df, CMatrixDouble &xy,
                                      const int npoints) {

  double result = 0;
  int relcnt = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int i_ = 0;

  double x[];
  double y[];

  ArrayResizeAL(x, df.m_nvars);
  ArrayResizeAL(y, df.m_nclasses);

  result = 0;
  relcnt = 0;
  for (i = 0; i <= npoints - 1; i++) {

    for (i_ = 0; i_ <= df.m_nvars - 1; i_++)
      x[i_] = xy[i][i_];

    DFProcess(df, x, y);

    if (df.m_nclasses > 1) {

      k = (int)MathRound(xy[i][df.m_nvars]);
      for (j = 0; j <= df.m_nclasses - 1; j++) {

        if (j == k) {
          result = result + MathAbs(y[j] - 1);
          relcnt = relcnt + 1;
        }
      }
    } else {

      if (xy[i][df.m_nvars] != 0.0) {
        result =
            result + MathAbs((y[0] - xy[i][df.m_nvars]) / xy[i][df.m_nvars]);
        relcnt = relcnt + 1;
      }
    }
  }

  if (relcnt > 0)
    result = result / relcnt;

  return (result);
}

static void CDForest::DFCopy(CDecisionForest &df1, CDecisionForest &df2) {

  int i_ = 0;

  df2.m_nvars = df1.m_nvars;
  df2.m_nclasses = df1.m_nclasses;
  df2.m_ntrees = df1.m_ntrees;
  df2.m_bufsize = df1.m_bufsize;

  ArrayResizeAL(df2.m_trees, df1.m_bufsize);

  for (i_ = 0; i_ <= df1.m_bufsize - 1; i_++)
    df2.m_trees[i_] = df1.m_trees[i_];
}

static void CDForest::DFAlloc(CSerializer &s, CDecisionForest &forest) {

  s.Alloc_Entry();
  s.Alloc_Entry();
  s.Alloc_Entry();
  s.Alloc_Entry();
  s.Alloc_Entry();
  s.Alloc_Entry();

  CApServ::AllocRealArray(s, forest.m_trees, forest.m_bufsize);
}

static void CDForest::DFSerialize(CSerializer &s, CDecisionForest &forest) {

  s.Serialize_Int(CSCodes::GetRDFSerializationCode());
  s.Serialize_Int(m_dffirstversion);
  s.Serialize_Int(forest.m_nvars);
  s.Serialize_Int(forest.m_nclasses);
  s.Serialize_Int(forest.m_ntrees);
  s.Serialize_Int(forest.m_bufsize);

  CApServ::SerializeRealArray(s, forest.m_trees, forest.m_bufsize);
}

static void CDForest::DFUnserialize(CSerializer &s, CDecisionForest &forest) {

  int i0 = 0;
  int i1 = 0;

  i0 = s.Unserialize_Int();

  if (!CAp::Assert(i0 == CSCodes::GetRDFSerializationCode(),
                   __FUNCTION__ + ": stream header corrupted"))
    return;

  i1 = s.Unserialize_Int();

  if (!CAp::Assert(i1 == m_dffirstversion,
                   __FUNCTION__ + ": stream header corrupted"))
    return;

  forest.m_nvars = s.Unserialize_Int();
  forest.m_nclasses = s.Unserialize_Int();
  forest.m_ntrees = s.Unserialize_Int();
  forest.m_bufsize = s.Unserialize_Int();

  CApServ::UnserializeRealArray(s, forest.m_trees);
}

static int CDForest::DFClsError(CDecisionForest &df, CMatrixDouble &xy,
                                const int npoints) {

  int result = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int tmpi = 0;
  int i_ = 0;

  double x[];
  double y[];

  if (df.m_nclasses <= 1)
    return (0);

  ArrayResizeAL(x, df.m_nvars);
  ArrayResizeAL(y, df.m_nclasses);

  result = 0;
  for (i = 0; i <= npoints - 1; i++) {

    for (i_ = 0; i_ <= df.m_nvars - 1; i_++)
      x[i_] = xy[i][i_];

    DFProcess(df, x, y);

    k = (int)MathRound(xy[i][df.m_nvars]);
    tmpi = 0;
    for (j = 1; j <= df.m_nclasses - 1; j++) {

      if (y[j] > (double)(y[tmpi]))
        tmpi = j;
    }

    if (tmpi != k)
      result = result + 1;
  }

  return (result);
}

static void CDForest::DFProcessInternal(CDecisionForest &df, const int offs,
                                        double &x[], double &y[]) {

  int k = 0;
  int idx = 0;

  k = offs + 1;

  while (true) {

    if (df.m_trees[k] == -1.0) {

      if (df.m_nclasses == 1)
        y[0] = y[0] + df.m_trees[k + 1];
      else {
        idx = (int)MathRound(df.m_trees[k + 1]);
        y[idx] = y[idx] + 1;
      }

      break;
    }

    if (x[(int)MathRound(df.m_trees[k])] < df.m_trees[k + 1])
      k = k + m_innernodewidth;
    else
      k = offs + (int)MathRound(df.m_trees[k + 2]);
  }
}

static void CDForest::DFBuildTree(CMatrixDouble &xy, const int npoints,
                                  const int nvars, const int nclasses,
                                  const int nfeatures, const int nvarsinpool,
                                  const int flags, CDFInternalBuffers &bufs) {

  int numprocessed = 0;
  int i = 0;

  if (!CAp::Assert(npoints > 0))
    return;

  for (i = 0; i <= npoints - 1; i++)
    bufs.m_idxbuf[i] = i;

  numprocessed = 1;

  DFBuildTreeRec(xy, npoints, nvars, nclasses, nfeatures, nvarsinpool, flags,
                 numprocessed, 0, npoints - 1, bufs);

  bufs.m_treebuf[0] = numprocessed;
}

static void CDForest::DFBuildTreeRec(CMatrixDouble &xy, const int npoints,
                                     const int nvars, const int nclasses,
                                     const int nfeatures, int nvarsinpool,
                                     const int flags, int &numprocessed,
                                     const int idx1, const int idx2,
                                     CDFInternalBuffers &bufs) {

  int i = 0;
  int j = 0;
  int k = 0;
  bool bflag;
  int i1 = 0;
  int i2 = 0;
  int info = 0;
  double sl = 0;
  double sr = 0;
  double w = 0;
  int idxbest = 0;
  double ebest = 0;
  double tbest = 0;
  int varcur = 0;
  double s = 0;
  double v = 0;
  double v1 = 0;
  double v2 = 0;
  double threshold = 0;
  int oldnp = 0;
  double currms = 0;
  bool useevs;

  tbest = 0;

  if (!CAp::Assert(npoints > 0))
    return;

  if (!CAp::Assert(idx2 >= idx1))
    return;
  useevs = flags / m_dfuseevs % 2 != 0;

  if (idx2 == idx1) {
    bufs.m_treebuf[numprocessed] = -1;
    bufs.m_treebuf[numprocessed + 1] = xy[bufs.m_idxbuf[idx1]][nvars];
    numprocessed = numprocessed + m_leafnodewidth;

    return;
  }

  idxbest = -1;

  if (nclasses > 1) {

    for (i = 0; i <= nclasses - 1; i++)
      bufs.m_classibuf[i] = 0;
    s = idx2 - idx1 + 1;
    for (i = idx1; i <= idx2; i++) {
      j = (int)MathRound(xy[bufs.m_idxbuf[i]][nvars]);
      bufs.m_classibuf[j] = bufs.m_classibuf[j] + 1;
    }

    ebest = 0;
    for (i = 0; i <= nclasses - 1; i++)
      ebest = ebest +
              bufs.m_classibuf[i] * CMath::Sqr(1 - bufs.m_classibuf[i] / s) +
              (s - bufs.m_classibuf[i]) * CMath::Sqr(bufs.m_classibuf[i] / s);
    ebest = MathSqrt(ebest / (nclasses * (idx2 - idx1 + 1)));
  } else {

    v = 0;
    for (i = idx1; i <= idx2; i++)
      v = v + xy[bufs.m_idxbuf[i]][nvars];
    v = v / (idx2 - idx1 + 1);

    ebest = 0;
    for (i = idx1; i <= idx2; i++)
      ebest = ebest + CMath::Sqr(xy[bufs.m_idxbuf[i]][nvars] - v);
    ebest = MathSqrt(ebest / (idx2 - idx1 + 1));
  }

  i = 0;

  while (i <= MathMin(nfeatures, nvarsinpool) - 1) {

    j = i + CMath::RandomInteger(nvarsinpool - i);
    k = bufs.m_varpool[i];
    bufs.m_varpool[i] = bufs.m_varpool[j];
    bufs.m_varpool[j] = k;
    varcur = bufs.m_varpool[i];

    for (j = idx1; j <= idx2; j++)
      bufs.m_tmpbufr[j - idx1] = xy[bufs.m_idxbuf[j]][varcur];

    if (useevs) {
      bflag = false;
      v = bufs.m_tmpbufr[0];
      for (j = 0; j <= idx2 - idx1; j++) {

        if (bufs.m_tmpbufr[j] != v) {
          bflag = true;
          break;
        }
      }

      if (!bflag) {

        k = bufs.m_varpool[i];
        bufs.m_varpool[i] = bufs.m_varpool[nvarsinpool - 1];
        bufs.m_varpool[nvarsinpool - 1] = k;
        nvarsinpool = nvarsinpool - 1;
        continue;
      }
    }

    if (nclasses > 1) {
      for (j = idx1; j <= idx2; j++)
        bufs.m_tmpbufi[j - idx1] = (int)MathRound(xy[bufs.m_idxbuf[j]][nvars]);
    } else {
      for (j = idx1; j <= idx2; j++)
        bufs.m_tmpbufr2[j - idx1] = xy[bufs.m_idxbuf[j]][nvars];
    }

    if (useevs && bufs.m_evsbin[varcur]) {

      threshold = bufs.m_evssplits[varcur];

      if (nclasses > 1) {

        for (j = 0; j <= 2 * nclasses - 1; j++)
          bufs.m_classibuf[j] = 0;

        sl = 0;
        sr = 0;

        for (j = 0; j <= idx2 - idx1; j++) {
          k = bufs.m_tmpbufi[j];

          if (bufs.m_tmpbufr[j] < threshold) {
            bufs.m_classibuf[k] = bufs.m_classibuf[k] + 1;
            sl = sl + 1;
          } else {
            bufs.m_classibuf[k + nclasses] = bufs.m_classibuf[k + nclasses] + 1;
            sr = sr + 1;
          }
        }

        if (!CAp::Assert(sl != 0.0 && sr != 0.0,
                         __FUNCTION__ + ": something strange!"))
          return;

        currms = 0;

        for (j = 0; j <= nclasses - 1; j++) {
          w = bufs.m_classibuf[j];
          currms = currms + w * CMath::Sqr(w / sl - 1);
          currms = currms + (sl - w) * CMath::Sqr(w / sl);
          w = bufs.m_classibuf[nclasses + j];
          currms = currms + w * CMath::Sqr(w / sr - 1);
          currms = currms + (sr - w) * CMath::Sqr(w / sr);
        }
        currms = MathSqrt(currms / (nclasses * (idx2 - idx1 + 1)));
      } else {

        sl = 0;
        sr = 0;
        v1 = 0;
        v2 = 0;

        for (j = 0; j <= idx2 - idx1; j++) {

          if (bufs.m_tmpbufr[j] < threshold) {
            v1 = v1 + bufs.m_tmpbufr2[j];
            sl = sl + 1;
          } else {
            v2 = v2 + bufs.m_tmpbufr2[j];
            sr = sr + 1;
          }
        }

        if (!CAp::Assert(sl != 0.0 && sr != 0.0,
                         __FUNCTION__ + ": something strange!"))
          return;

        v1 = v1 / sl;
        v2 = v2 / sr;
        currms = 0;
        for (j = 0; j <= idx2 - idx1; j++) {

          if (bufs.m_tmpbufr[j] < threshold)
            currms = currms + CMath::Sqr(v1 - bufs.m_tmpbufr2[j]);
          else
            currms = currms + CMath::Sqr(v2 - bufs.m_tmpbufr2[j]);
        }
        currms = MathSqrt(currms / (idx2 - idx1 + 1));
      }

      info = 1;
    } else {

      if (nclasses > 1)
        DFSplitC(bufs.m_tmpbufr, bufs.m_tmpbufi, bufs.m_classibuf,
                 idx2 - idx1 + 1, nclasses, m_dfusestrongsplits, info,
                 threshold, currms, bufs.m_sortrbuf, bufs.m_sortibuf);
      else
        DFSplitR(bufs.m_tmpbufr, bufs.m_tmpbufr2, idx2 - idx1 + 1,
                 m_dfusestrongsplits, info, threshold, currms, bufs.m_sortrbuf,
                 bufs.m_sortrbuf2);
    }

    if (info > 0) {

      if (currms <= ebest) {
        ebest = currms;
        idxbest = varcur;
        tbest = threshold;
      }
    }

    i = i + 1;
  }

  if (idxbest < 0) {

    bufs.m_treebuf[numprocessed] = -1;

    if (nclasses > 1) {

      bufs.m_treebuf[numprocessed + 1] = (int)MathRound(
          xy[bufs.m_idxbuf[idx1 + CMath::RandomInteger(idx2 - idx1 + 1)]]
            [nvars]);
    } else {

      v = 0;
      for (i = idx1; i <= idx2; i++)
        v = v + xy[bufs.m_idxbuf[i]][nvars] / (idx2 - idx1 + 1);
      bufs.m_treebuf[numprocessed + 1] = v;
    }

    numprocessed = numprocessed + m_leafnodewidth;
  } else {

    bufs.m_treebuf[numprocessed] = idxbest;
    bufs.m_treebuf[numprocessed + 1] = tbest;
    i1 = idx1;
    i2 = idx2;

    while (i1 <= i2) {

      if (xy[bufs.m_idxbuf[i1]][idxbest] < tbest) {
        i1 = i1 + 1;
        continue;
      }

      if (xy[bufs.m_idxbuf[i2]][idxbest] >= tbest) {
        i2 = i2 - 1;
        continue;
      }

      j = bufs.m_idxbuf[i1];
      bufs.m_idxbuf[i1] = bufs.m_idxbuf[i2];
      bufs.m_idxbuf[i2] = j;
      i1 = i1 + 1;
      i2 = i2 - 1;
    }

    oldnp = numprocessed;
    numprocessed = numprocessed + m_innernodewidth;

    DFBuildTreeRec(xy, npoints, nvars, nclasses, nfeatures, nvarsinpool, flags,
                   numprocessed, idx1, i1 - 1, bufs);
    bufs.m_treebuf[oldnp + 2] = numprocessed;

    DFBuildTreeRec(xy, npoints, nvars, nclasses, nfeatures, nvarsinpool, flags,
                   numprocessed, i2 + 1, idx2, bufs);
  }
}

static void CDForest::DFSplitC(double &x[], int &c[], int &cntbuf[],
                               const int n, const int nc, const int flags,
                               int &info, double &threshold, double &e,
                               double &sortrbuf[], int &sortibuf[]) {

  int i = 0;
  int neq = 0;
  int nless = 0;
  int ngreater = 0;
  int q = 0;
  int qmin = 0;
  int qmax = 0;
  int qcnt = 0;
  double cursplit = 0;
  int nleft = 0;
  double v = 0;
  double cure = 0;
  double w = 0;
  double sl = 0;
  double sr = 0;

  info = 0;
  threshold = 0;
  e = 0;

  CTSort::TagSortFastI(x, c, sortrbuf, sortibuf, n);

  e = CMath::m_maxrealnumber;
  threshold = 0.5 * (x[0] + x[n - 1]);
  info = -3;

  if (flags / m_dfusestrongsplits % 2 == 0) {

    qcnt = 2;
    qmin = 1;
    qmax = 1;
  } else {

    qcnt = 4;
    qmin = 1;
    qmax = 3;
  }
  for (q = qmin; q <= qmax; q++) {

    cursplit = x[n * q / qcnt];
    neq = 0;
    nless = 0;
    ngreater = 0;

    for (i = 0; i <= n - 1; i++) {

      if (x[i] < cursplit)
        nless = nless + 1;

      if (x[i] == cursplit)
        neq = neq + 1;

      if (x[i] > cursplit)
        ngreater = ngreater + 1;
    }

    if (!CAp::Assert(neq != 0, __FUNCTION__ + ": NEq=0,something strange!!!"))
      return;

    if (nless != 0 || ngreater != 0) {

      if (nless < ngreater) {
        cursplit = 0.5 * (x[nless + neq - 1] + x[nless + neq]);
        nleft = nless + neq;

        if (cursplit <= (double)(x[nless + neq - 1]))
          cursplit = x[nless + neq];
      } else {
        cursplit = 0.5 * (x[nless - 1] + x[nless]);
        nleft = nless;

        if (cursplit <= (double)(x[nless - 1]))
          cursplit = x[nless];
      }

      info = 1;
      cure = 0;

      for (i = 0; i <= 2 * nc - 1; i++)
        cntbuf[i] = 0;
      for (i = 0; i <= nleft - 1; i++)
        cntbuf[c[i]] = cntbuf[c[i]] + 1;
      for (i = nleft; i <= n - 1; i++)
        cntbuf[nc + c[i]] = cntbuf[nc + c[i]] + 1;

      sl = nleft;
      sr = n - nleft;
      v = 0;

      for (i = 0; i <= nc - 1; i++) {
        w = cntbuf[i];
        v = v + w * CMath::Sqr(w / sl - 1);
        v = v + (sl - w) * CMath::Sqr(w / sl);
        w = cntbuf[nc + i];
        v = v + w * CMath::Sqr(w / sr - 1);
        v = v + (sr - w) * CMath::Sqr(w / sr);
      }
      cure = MathSqrt(v / (nc * n));

      if (cure < e) {
        threshold = cursplit;
        e = cure;
      }
    }
  }
}

static void CDForest::DFSplitR(double &x[], double &y[], const int n,
                               const int flags, int &info, double &threshold,
                               double &e, double &sortrbuf[],
                               double &sortrbuf2[]) {

  int i = 0;
  int neq = 0;
  int nless = 0;
  int ngreater = 0;
  int q = 0;
  int qmin = 0;
  int qmax = 0;
  int qcnt = 0;
  double cursplit = 0;
  int nleft = 0;
  double v = 0;
  double cure = 0;

  info = 0;
  threshold = 0;
  e = 0;

  CTSort::TagSortFastR(x, y, sortrbuf, sortrbuf2, n);

  e = CMath::m_maxrealnumber;
  threshold = 0.5 * (x[0] + x[n - 1]);
  info = -3;

  if (flags / m_dfusestrongsplits % 2 == 0) {

    qcnt = 2;
    qmin = 1;
    qmax = 1;
  } else {

    qcnt = 4;
    qmin = 1;
    qmax = 3;
  }

  for (q = qmin; q <= qmax; q++) {

    cursplit = x[n * q / qcnt];
    neq = 0;
    nless = 0;
    ngreater = 0;
    for (i = 0; i <= n - 1; i++) {

      if (x[i] < cursplit)
        nless = nless + 1;

      if (x[i] == cursplit)
        neq = neq + 1;

      if (x[i] > cursplit)
        ngreater = ngreater + 1;
    }

    if (!CAp::Assert(neq != 0, __FUNCTION__ + ": NEq=0,something strange!!!"))
      return;

    if (nless != 0 || ngreater != 0) {

      if (nless < ngreater) {
        cursplit = 0.5 * (x[nless + neq - 1] + x[nless + neq]);
        nleft = nless + neq;

        if (cursplit <= (double)(x[nless + neq - 1]))
          cursplit = x[nless + neq];
      } else {
        cursplit = 0.5 * (x[nless - 1] + x[nless]);
        nleft = nless;

        if (cursplit <= (double)(x[nless - 1]))
          cursplit = x[nless];
      }

      info = 1;
      cure = 0;
      v = 0;

      for (i = 0; i <= nleft - 1; i++)
        v = v + y[i];
      v = v / nleft;
      for (i = 0; i <= nleft - 1; i++)
        cure = cure + CMath::Sqr(y[i] - v);
      v = 0;
      for (i = nleft; i <= n - 1; i++)
        v = v + y[i];
      v = v / (n - nleft);
      for (i = nleft; i <= n - 1; i++)
        cure = cure + CMath::Sqr(y[i] - v);
      cure = MathSqrt(cure / n);

      if (cure < e) {
        threshold = cursplit;
        e = cure;
      }
    }
  }
}

class CKMeans {
private:
  static bool SelectCenterPP(CMatrixDouble &xy, const int npoints,
                             const int nvars, CMatrixDouble &centers,
                             bool &cbusycenters[], const int ccnt, double &d2[],
                             double &p[], double &tmp[]);

public:
  CKMeans(void);
  ~CKMeans(void);

  static void KMeansGenerate(CMatrixDouble &xy, const int npoints,
                             const int nvars, const int k, const int restarts,
                             int &info, CMatrixDouble &c, int &xyc[]);
};

CKMeans::CKMeans(void) {
}

CKMeans::~CKMeans(void) {
}

static void CKMeans::KMeansGenerate(CMatrixDouble &xy, const int npoints,
                                    const int nvars, const int k,
                                    const int restarts, int &info,
                                    CMatrixDouble &c, int &xyc[]) {

  int i = 0;
  int j = 0;
  double e = 0;
  double ebest = 0;
  double v = 0;
  int cclosest = 0;
  bool waschanges;
  bool zerosizeclusters;
  int pass = 0;
  int i_ = 0;
  double dclosest = 0;

  int xycbest[];
  double x[];
  double tmp[];
  double d2[];
  double p[];
  int csizes[];
  bool cbusy[];
  double work[];

  CMatrixDouble ct;
  CMatrixDouble ctbest;

  info = 0;

  if (npoints < k || nvars < 1 || k < 1 || restarts < 1) {
    info = -1;
    return;
  }

  info = 1;

  ct.Resize(k, nvars);
  ctbest.Resize(k, nvars);
  ArrayResizeAL(xyc, npoints);
  ArrayResizeAL(xycbest, npoints);
  ArrayResizeAL(d2, npoints);
  ArrayResizeAL(p, npoints);
  ArrayResizeAL(tmp, nvars);
  ArrayResizeAL(csizes, k);
  ArrayResizeAL(cbusy, k);

  ebest = CMath::m_maxrealnumber;

  for (pass = 1; pass <= restarts; pass++) {

    i = CMath::RandomInteger(npoints);
    for (i_ = 0; i_ <= nvars - 1; i_++)
      ct[0].Set(i_, xy[i][i_]);
    cbusy[0] = true;
    for (i = 1; i <= k - 1; i++)
      cbusy[i] = false;

    if (!SelectCenterPP(xy, npoints, nvars, ct, cbusy, k, d2, p, tmp)) {
      info = -3;
      return;
    }

    for (i = 0; i <= npoints - 1; i++)
      xyc[i] = -1;

    while (true) {

      waschanges = false;
      for (i = 0; i <= npoints - 1; i++) {

        cclosest = -1;
        dclosest = CMath::m_maxrealnumber;
        for (j = 0; j <= k - 1; j++) {

          for (i_ = 0; i_ <= nvars - 1; i_++)
            tmp[i_] = xy[i][i_];
          for (i_ = 0; i_ <= nvars - 1; i_++)
            tmp[i_] = tmp[i_] - ct[j][i_];
          v = 0.0;
          for (i_ = 0; i_ <= nvars - 1; i_++)
            v += tmp[i_] * tmp[i_];

          if (v < dclosest) {
            cclosest = j;
            dclosest = v;
          }
        }

        if (xyc[i] != cclosest)
          waschanges = true;

        xyc[i] = cclosest;
      }

      for (j = 0; j <= k - 1; j++)
        csizes[j] = 0;
      for (i = 0; i <= k - 1; i++) {
        for (j = 0; j <= nvars - 1; j++)
          ct[i].Set(j, 0);
      }

      for (i = 0; i <= npoints - 1; i++) {
        csizes[xyc[i]] = csizes[xyc[i]] + 1;
        for (i_ = 0; i_ <= nvars - 1; i_++)
          ct[xyc[i]].Set(i_, ct[xyc[i]][i_] + xy[i][i_]);
      }
      zerosizeclusters = false;
      for (i = 0; i <= k - 1; i++) {
        cbusy[i] = csizes[i] != 0;
        zerosizeclusters = zerosizeclusters || csizes[i] == 0;
      }

      if (zerosizeclusters) {

        if (!SelectCenterPP(xy, npoints, nvars, ct, cbusy, k, d2, p, tmp)) {
          info = -3;
          return;
        }
        continue;
      }

      for (j = 0; j <= k - 1; j++) {
        v = 1.0 / (double)csizes[j];
        for (i_ = 0; i_ <= nvars - 1; i_++)
          ct[j].Set(i_, v * ct[j][i_]);
      }

      if (!waschanges)
        break;
    }

    e = 0;
    for (i = 0; i <= npoints - 1; i++) {
      for (i_ = 0; i_ <= nvars - 1; i_++)
        tmp[i_] = xy[i][i_];
      for (i_ = 0; i_ <= nvars - 1; i_++)
        tmp[i_] = tmp[i_] - ct[xyc[i]][i_];

      v = 0.0;
      for (i_ = 0; i_ <= nvars - 1; i_++)
        v += tmp[i_] * tmp[i_];
      e = e + v;
    }

    if (e < ebest) {

      ebest = e;

      CBlas::CopyMatrix(ct, 0, k - 1, 0, nvars - 1, ctbest, 0, k - 1, 0,
                        nvars - 1);

      for (i = 0; i <= npoints - 1; i++)
        xycbest[i] = xyc[i];
    }
  }

  c.Resize(nvars, k);

  CBlas::CopyAndTranspose(ctbest, 0, k - 1, 0, nvars - 1, c, 0, nvars - 1, 0,
                          k - 1);

  for (i = 0; i <= npoints - 1; i++)
    xyc[i] = xycbest[i];
}

static bool CKMeans::SelectCenterPP(CMatrixDouble &xy, const int npoints,
                                    const int nvars, CMatrixDouble &centers,
                                    bool &cbusycenters[], const int ccnt,
                                    double &d2[], double &p[], double &tmp[]) {

  bool result;
  int i = 0;
  int j = 0;
  int cc = 0;
  double v = 0;
  double s = 0;
  int i_ = 0;

  double busycenters[];

  ArrayCopy(busycenters, cbusycenters);

  result = true;

  for (cc = 0; cc <= ccnt - 1; cc++) {

    if (!busycenters[cc]) {

      for (i = 0; i <= npoints - 1; i++) {
        d2[i] = CMath::m_maxrealnumber;
        for (j = 0; j <= ccnt - 1; j++) {

          if (busycenters[j]) {
            for (i_ = 0; i_ <= nvars - 1; i_++)
              tmp[i_] = xy[i][i_];
            for (i_ = 0; i_ <= nvars - 1; i_++)
              tmp[i_] = tmp[i_] - centers[j][i_];

            v = 0.0;
            for (i_ = 0; i_ <= nvars - 1; i_++)
              v += tmp[i_] * tmp[i_];

            if (v < d2[i])
              d2[i] = v;
          }
        }
      }

      s = 0;
      for (i = 0; i <= npoints - 1; i++)
        s = s + d2[i];

      if (s == 0.0)
        return (false);

      s = 1 / s;
      for (i_ = 0; i_ <= npoints - 1; i_++)
        p[i_] = s * d2[i_];

      s = 0;
      v = CMath::RandomReal();

      for (i = 0; i <= npoints - 1; i++) {
        s = s + p[i];

        if (v <= s || i == npoints - 1) {
          for (i_ = 0; i_ <= nvars - 1; i_++)
            centers[cc].Set(i_, xy[i][i_]);
          busycenters[cc] = true;

          break;
        }
      }
    }
  }

  return (result);
}

class CLDA {
public:
  CLDA(void);
  ~CLDA(void);

  static void FisherLDA(CMatrixDouble &xy, const int npoints, const int nvars,
                        const int nclasses, int &info, double &w[]);
  static void FisherLDAN(CMatrixDouble &xy, const int npoints, const int nvars,
                         const int nclasses, int &info, CMatrixDouble &w);
};

CLDA::CLDA(void) {
}

CLDA::~CLDA(void) {
}

static void CLDA::FisherLDA(CMatrixDouble &xy, const int npoints,
                            const int nvars, const int nclasses, int &info,
                            double &w[]) {

  int i_ = 0;

  CMatrixDouble w2;

  info = 0;

  FisherLDAN(xy, npoints, nvars, nclasses, info, w2);

  if (info > 0) {

    ArrayResizeAL(w, nvars);

    for (i_ = 0; i_ <= nvars - 1; i_++)
      w[i_] = w2[i_][0];
  }
}

static void CLDA::FisherLDAN(CMatrixDouble &xy, const int npoints,
                             const int nvars, const int nclasses, int &info,
                             CMatrixDouble &w) {

  int i = 0;
  int j = 0;
  int k = 0;
  int m = 0;
  double v = 0;
  int i_ = 0;

  int c[];
  double mu[];
  int nc[];
  double tf[];
  double d[];
  double d2[];
  double work[];

  CMatrixDouble muc;
  CMatrixDouble sw;
  CMatrixDouble st;
  CMatrixDouble z;
  CMatrixDouble z2;
  CMatrixDouble tm;
  CMatrixDouble sbroot;
  CMatrixDouble a;
  CMatrixDouble xyproj;
  CMatrixDouble wproj;

  info = 0;

  if ((npoints < 0 || nvars < 1) || nclasses < 2) {
    info = -1;
    return;
  }
  for (i = 0; i <= npoints - 1; i++) {

    if ((int)MathRound(xy[i][nvars]) < 0 ||
        (int)MathRound(xy[i][nvars]) >= nclasses) {
      info = -2;
      return;
    }
  }

  info = 1;

  if (npoints <= 1) {
    info = 2;

    w.Resize(nvars, nvars);

    for (i = 0; i <= nvars - 1; i++) {
      for (j = 0; j <= nvars - 1; j++) {

        if (i == j)
          w[i].Set(j, 1);
        else
          w[i].Set(j, 0);
      }
    }

    return;
  }

  ArrayResizeAL(tf, nvars);
  ArrayResizeAL(work, MathMax(nvars, npoints) + 1);

  ArrayResizeAL(c, npoints);
  for (i = 0; i <= npoints - 1; i++)
    c[i] = (int)MathRound(xy[i][nvars]);

  ArrayResizeAL(mu, nvars);
  muc.Resize(nclasses, nvars);
  ArrayResizeAL(nc, nclasses);
  for (j = 0; j <= nvars - 1; j++)
    mu[j] = 0;
  for (i = 0; i <= nclasses - 1; i++) {
    nc[i] = 0;
    for (j = 0; j <= nvars - 1; j++)
      muc[i].Set(j, 0);
  }

  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= nvars - 1; i_++)
      mu[i_] = mu[i_] + xy[i][i_];
    for (i_ = 0; i_ <= nvars - 1; i_++)
      muc[c[i]].Set(i_, muc[c[i]][i_] + xy[i][i_]);
    nc[c[i]] = nc[c[i]] + 1;
  }
  for (i = 0; i <= nclasses - 1; i++) {
    v = 1.0 / (double)nc[i];
    for (i_ = 0; i_ <= nvars - 1; i_++)
      muc[i].Set(i_, v * muc[i][i_]);
  }

  v = 1.0 / (double)npoints;
  for (i_ = 0; i_ <= nvars - 1; i_++)
    mu[i_] = v * mu[i_];

  st.Resize(nvars, nvars);
  for (i = 0; i <= nvars - 1; i++) {
    for (j = 0; j <= nvars - 1; j++)
      st[i].Set(j, 0);
  }

  for (k = 0; k <= npoints - 1; k++) {
    for (i_ = 0; i_ <= nvars - 1; i_++)
      tf[i_] = xy[k][i_];
    for (i_ = 0; i_ <= nvars - 1; i_++)
      tf[i_] = tf[i_] - mu[i_];
    for (i = 0; i <= nvars - 1; i++) {
      v = tf[i];
      for (i_ = 0; i_ <= nvars - 1; i_++)
        st[i].Set(i_, st[i][i_] + v * tf[i_]);
    }
  }

  sw.Resize(nvars, nvars);
  for (i = 0; i <= nvars - 1; i++) {
    for (j = 0; j <= nvars - 1; j++)
      sw[i].Set(j, 0);
  }

  for (k = 0; k <= npoints - 1; k++) {
    for (i_ = 0; i_ <= nvars - 1; i_++)
      tf[i_] = xy[k][i_];
    for (i_ = 0; i_ <= nvars - 1; i_++)
      tf[i_] = tf[i_] - muc[c[k]][i_];
    for (i = 0; i <= nvars - 1; i++) {
      v = tf[i];
      for (i_ = 0; i_ <= nvars - 1; i_++)
        sw[i].Set(i_, sw[i][i_] + v * tf[i_]);
    }
  }

  if (!CEigenVDetect::SMatrixEVD(st, nvars, 1, true, d, z)) {
    info = -4;
    return;
  }

  w.Resize(nvars, nvars);

  if (d[nvars - 1] <= 0.0 ||
      d[0] <= 1000 * CMath::m_machineepsilon * d[nvars - 1]) {

    if (d[nvars - 1] <= 0.0) {
      info = 2;
      for (i = 0; i <= nvars - 1; i++) {
        for (j = 0; j <= nvars - 1; j++) {

          if (i == j)
            w[i].Set(j, 1);
          else
            w[i].Set(j, 0);
        }
      }

      return;
    }

    m = 0;
    for (k = 0; k <= nvars - 1; k++) {

      if (d[k] <= 1000 * CMath::m_machineepsilon * d[nvars - 1])
        m = k + 1;
    }

    if (!CAp::Assert(m != 0, __FUNCTION__ + ": internal error #1"))
      return;

    xyproj.Resize(npoints, nvars - m + 1);

    CBlas::MatrixMatrixMultiply(xy, 0, npoints - 1, 0, nvars - 1, false, z, 0,
                                nvars - 1, m, nvars - 1, false, 1.0, xyproj, 0,
                                npoints - 1, 0, nvars - m - 1, 0.0, work);
    for (i = 0; i <= npoints - 1; i++)
      xyproj[i].Set(nvars - m, xy[i][nvars]);

    FisherLDAN(xyproj, npoints, nvars - m, nclasses, info, wproj);

    if (info < 0)
      return;

    CBlas::MatrixMatrixMultiply(z, 0, nvars - 1, m, nvars - 1, false, wproj, 0,
                                nvars - m - 1, 0, nvars - m - 1, false, 1.0, w,
                                0, nvars - 1, 0, nvars - m - 1, 0.0, work);

    for (k = nvars - m; k <= nvars - 1; k++) {
      for (i_ = 0; i_ <= nvars - 1; i_++)
        w[i_].Set(k, z[i_][k - nvars + m]);
    }
    info = 2;
  } else {

    tm.Resize(nvars, nvars);
    a.Resize(nvars, nvars);

    CBlas::MatrixMatrixMultiply(sw, 0, nvars - 1, 0, nvars - 1, false, z, 0,
                                nvars - 1, 0, nvars - 1, false, 1.0, tm, 0,
                                nvars - 1, 0, nvars - 1, 0.0, work);
    CBlas::MatrixMatrixMultiply(z, 0, nvars - 1, 0, nvars - 1, true, tm, 0,
                                nvars - 1, 0, nvars - 1, false, 1.0, a, 0,
                                nvars - 1, 0, nvars - 1, 0.0, work);

    for (i = 0; i <= nvars - 1; i++) {
      for (j = 0; j <= nvars - 1; j++)
        a[i].Set(j, a[i][j] / MathSqrt(d[i] * d[j]));
    }

    if (!CEigenVDetect::SMatrixEVD(a, nvars, 1, true, d2, z2)) {
      info = -4;
      return;
    }

    for (k = 0; k <= nvars - 1; k++) {
      for (i = 0; i <= nvars - 1; i++)
        tf[i] = z2[i][k] / MathSqrt(d[i]);
      for (i = 0; i <= nvars - 1; i++) {
        v = 0.0;
        for (i_ = 0; i_ <= nvars - 1; i_++)
          v += z[i][i_] * tf[i_];
        w[i].Set(k, v);
      }
    }
  }

  for (k = 0; k <= nvars - 1; k++) {

    v = 0.0;
    for (i_ = 0; i_ <= nvars - 1; i_++)
      v += w[i_][k] * w[i_][k];
    v = 1 / MathSqrt(v);
    for (i_ = 0; i_ <= nvars - 1; i_++)
      w[i_].Set(k, v * w[i_][k]);
    v = 0;
    for (i = 0; i <= nvars - 1; i++)
      v = v + w[i][k];

    if (v < 0.0) {
      for (i_ = 0; i_ <= nvars - 1; i_++)
        w[i_].Set(k, -1 * w[i_][k]);
    }
  }
}

class CLinearModel {
public:
  double m_w[];

  CLinearModel(void);
  ~CLinearModel(void);

  void Copy(CLinearModel &obj);
};

CLinearModel::CLinearModel(void) {
}

CLinearModel::~CLinearModel(void) {
}

void CLinearModel::Copy(CLinearModel &obj) {

  ArrayCopy(m_w, obj.m_w);
}

class CLinearModelShell {
private:
  CLinearModel m_innerobj;

public:
  CLinearModelShell(void);
  CLinearModelShell(CLinearModel &obj);
  ~CLinearModelShell(void);

  CLinearModel *GetInnerObj(void);
};

CLinearModelShell::CLinearModelShell(void) {
}

CLinearModelShell::CLinearModelShell(CLinearModel &obj) {

  m_innerobj.Copy(obj);
}

CLinearModelShell::~CLinearModelShell(void) {
}

CLinearModel *CLinearModelShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CLRReport {
public:
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;
  double m_cvrmserror;
  double m_cvavgerror;
  double m_cvavgrelerror;
  int m_ncvdefects;

  int m_cvdefects[];

  CMatrixDouble m_c;

  CLRReport(void);
  ~CLRReport(void);

  void Copy(CLRReport &obj);
};

CLRReport::CLRReport(void) {
}

CLRReport::~CLRReport(void) {
}

void CLRReport::Copy(CLRReport &obj) {

  m_rmserror = obj.m_rmserror;
  m_avgerror = obj.m_avgerror;
  m_avgrelerror = obj.m_avgrelerror;
  m_cvrmserror = obj.m_cvrmserror;
  m_cvavgerror = obj.m_cvavgerror;
  m_cvavgrelerror = obj.m_cvavgrelerror;
  m_ncvdefects = obj.m_ncvdefects;

  ArrayCopy(m_cvdefects, obj.m_cvdefects);

  m_c = obj.m_c;
}

class CLRReportShell {
private:
  CLRReport m_innerobj;

public:
  CLRReportShell(void);
  CLRReportShell(CLRReport &obj);
  ~CLRReportShell(void);

  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  double GetCVRMSError(void);
  void SetCVRMSError(const double d);
  double GetCVAvgError(void);
  void SetCVAvgError(const double d);
  double GetCVAvgRelError(void);
  void SetCVAvgRelError(const double d);
  int GetNCVDEfects(void);
  void SetNCVDEfects(const int i);
  CLRReport *GetInnerObj(void);
};

CLRReportShell::CLRReportShell(void) {
}

CLRReportShell::CLRReportShell(CLRReport &obj) {

  m_innerobj.Copy(obj);
}

CLRReportShell::~CLRReportShell(void) {
}

double CLRReportShell::GetRMSError(void) {

  return (m_innerobj.m_rmserror);
}

void CLRReportShell::SetRMSError(const double d) {

  m_innerobj.m_rmserror = d;
}

double CLRReportShell::GetAvgError(void) {

  return (m_innerobj.m_avgerror);
}

void CLRReportShell::SetAvgError(const double d) {

  m_innerobj.m_avgerror = d;
}

double CLRReportShell::GetAvgRelError(void) {

  return (m_innerobj.m_avgrelerror);
}

void CLRReportShell::SetAvgRelError(const double d) {

  m_innerobj.m_avgrelerror = d;
}

double CLRReportShell::GetCVRMSError(void) {

  return (m_innerobj.m_cvrmserror);
}

void CLRReportShell::SetCVRMSError(const double d) {

  m_innerobj.m_cvrmserror = d;
}

double CLRReportShell::GetCVAvgError(void) {

  return (m_innerobj.m_cvavgerror);
}

void CLRReportShell::SetCVAvgError(const double d) {

  m_innerobj.m_cvavgerror = d;
}

double CLRReportShell::GetCVAvgRelError(void) {

  return (m_innerobj.m_cvavgrelerror);
}

void CLRReportShell::SetCVAvgRelError(const double d) {

  m_innerobj.m_cvavgrelerror = d;
}

int CLRReportShell::GetNCVDEfects(void) {

  return (m_innerobj.m_ncvdefects);
}

void CLRReportShell::SetNCVDEfects(const int i) {

  m_innerobj.m_ncvdefects = i;
}

CLRReport *CLRReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CLinReg {
private:
  static void LRInternal(CMatrixDouble &xy, double &s[], const int npoints,
                         const int nvars, int &info, CLinearModel &lm,
                         CLRReport &ar);

public:
  static const int m_lrvnum;

  CLinReg(void);
  ~CLinReg(void);

  static void LRBuild(CMatrixDouble &xy, const int npoints, const int nvars,
                      int &info, CLinearModel &lm, CLRReport &ar);
  static void LRBuildS(CMatrixDouble &xy, double &s[], const int npoints,
                       const int nvars, int &info, CLinearModel &lm,
                       CLRReport &ar);
  static void LRBuildZS(CMatrixDouble &xy, double &s[], const int npoints,
                        const int nvars, int &info, CLinearModel &lm,
                        CLRReport &ar);
  static void LRBuildZ(CMatrixDouble &xy, const int npoints, const int nvars,
                       int &info, CLinearModel &lm, CLRReport &ar);
  static void LRUnpack(CLinearModel &lm, double &v[], int &nvars);
  static void LRPack(double &v[], const int nvars, CLinearModel &lm);
  static double LRProcess(CLinearModel &lm, double &x[]);
  static double LRRMSError(CLinearModel &lm, CMatrixDouble &xy,
                           const int npoints);
  static double LRAvgError(CLinearModel &lm, CMatrixDouble &xy,
                           const int npoints);
  static double LRAvgRelError(CLinearModel &lm, CMatrixDouble &xy,
                              const int npoints);
  static void LRCopy(CLinearModel &lm1, CLinearModel &lm2);
  static void LRLines(CMatrixDouble &xy, double &s[], const int n, int &info,
                      double &a, double &b, double &vara, double &varb,
                      double &covab, double &corrab, double &p);
  static void LRLine(CMatrixDouble &xy, const int n, int &info, double &a,
                     double &b);
};

const int CLinReg::m_lrvnum = 5;

CLinReg::CLinReg(void) {
}

CLinReg::~CLinReg(void) {
}

static void CLinReg::LRBuild(CMatrixDouble &xy, const int npoints,
                             const int nvars, int &info, CLinearModel &lm,
                             CLRReport &ar) {

  int i = 0;
  double sigma2 = 0;
  int i_ = 0;

  double s[];

  info = 0;

  if (npoints <= nvars + 1 || nvars < 1) {
    info = -1;
    return;
  }

  ArrayResizeAL(s, npoints);
  for (i = 0; i <= npoints - 1; i++)
    s[i] = 1;

  LRBuildS(xy, s, npoints, nvars, info, lm, ar);

  if (info < 0)
    return;

  sigma2 = CMath::Sqr(ar.m_rmserror) * npoints / (npoints - nvars - 1);
  for (i = 0; i <= nvars; i++) {
    for (i_ = 0; i_ <= nvars; i_++)
      ar.m_c[i].Set(i_, sigma2 * ar.m_c[i][i_]);
  }
}

static void CLinReg::LRBuildS(CMatrixDouble &xy, double &s[], const int npoints,
                              const int nvars, int &info, CLinearModel &lm,
                              CLRReport &ar) {

  int i = 0;
  int j = 0;
  double v = 0;
  int offs = 0;
  double mean = 0;
  double variance = 0;
  double skewness = 0;
  double kurtosis = 0;
  int i_ = 0;

  double x[];
  double means[];
  double sigmas[];

  CMatrixDouble xyi;

  info = 0;

  if (npoints <= nvars + 1 || nvars < 1) {
    info = -1;
    return;
  }

  xyi.Resize(npoints, nvars + 2);
  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= nvars - 1; i_++)
      xyi[i].Set(i_, xy[i][i_]);
    xyi[i].Set(nvars, 1);
    xyi[i].Set(nvars + 1, xy[i][nvars]);
  }

  ArrayResizeAL(x, npoints);
  ArrayResizeAL(means, nvars);
  ArrayResizeAL(sigmas, nvars);
  for (j = 0; j <= nvars - 1; j++) {

    for (i_ = 0; i_ <= npoints - 1; i_++)
      x[i_] = xy[i_][j];

    CBaseStat::SampleMoments(x, npoints, mean, variance, skewness, kurtosis);

    means[j] = mean;
    sigmas[j] = MathSqrt(variance);

    if (sigmas[j] == 0.0)
      sigmas[j] = 1;

    for (i = 0; i <= npoints - 1; i++)
      xyi[i].Set(j, (xyi[i][j] - means[j]) / sigmas[j]);
  }

  LRInternal(xyi, s, npoints, nvars + 1, info, lm, ar);

  if (info < 0)
    return;

  offs = (int)MathRound(lm.m_w[3]);
  for (j = 0; j <= nvars - 1; j++) {

    lm.m_w[offs + nvars] =
        lm.m_w[offs + nvars] - lm.m_w[offs + j] * means[j] / sigmas[j];
    v = means[j] / sigmas[j];
    for (i_ = 0; i_ <= nvars; i_++)
      ar.m_c[nvars].Set(i_, ar.m_c[nvars][i_] - v * ar.m_c[j][i_]);
    for (i_ = 0; i_ <= nvars; i_++)
      ar.m_c[i_].Set(nvars, ar.m_c[i_][nvars] - v * ar.m_c[i_][j]);

    lm.m_w[offs + j] = lm.m_w[offs + j] / sigmas[j];
    v = 1 / sigmas[j];
    for (i_ = 0; i_ <= nvars; i_++)
      ar.m_c[j].Set(i_, v * ar.m_c[j][i_]);
    for (i_ = 0; i_ <= nvars; i_++)
      ar.m_c[i_].Set(j, v * ar.m_c[i_][j]);
  }
}

static void CLinReg::LRBuildZS(CMatrixDouble &xy, double &s[],
                               const int npoints, const int nvars, int &info,
                               CLinearModel &lm, CLRReport &ar) {

  int i = 0;
  int j = 0;
  double v = 0;
  int offs = 0;
  double mean = 0;
  double variance = 0;
  double skewness = 0;
  double kurtosis = 0;
  int i_ = 0;

  double x[];
  double c[];

  CMatrixDouble xyi;

  info = 0;

  if (npoints <= nvars + 1 || nvars < 1) {
    info = -1;
    return;
  }

  xyi.Resize(npoints, nvars + 2);
  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= nvars - 1; i_++)
      xyi[i].Set(i_, xy[i][i_]);
    xyi[i].Set(nvars, 0);
    xyi[i].Set(nvars + 1, xy[i][nvars]);
  }

  ArrayResizeAL(x, npoints);
  ArrayResizeAL(c, nvars);
  for (j = 0; j <= nvars - 1; j++) {
    for (i_ = 0; i_ <= npoints - 1; i_++)
      x[i_] = xy[i_][j];

    CBaseStat::SampleMoments(x, npoints, mean, variance, skewness, kurtosis);

    if (MathAbs(mean) > MathSqrt(variance)) {

      c[j] = mean;
    } else {

      if (variance == 0.0)
        variance = 1;
      c[j] = MathSqrt(variance);
    }
    for (i = 0; i <= npoints - 1; i++)
      xyi[i].Set(j, xyi[i][j] / c[j]);
  }

  LRInternal(xyi, s, npoints, nvars + 1, info, lm, ar);

  if (info < 0)
    return;

  offs = (int)MathRound(lm.m_w[3]);
  for (j = 0; j <= nvars - 1; j++) {

    lm.m_w[offs + j] = lm.m_w[offs + j] / c[j];
    v = 1 / c[j];
    for (i_ = 0; i_ <= nvars; i_++)
      ar.m_c[j].Set(i_, v * ar.m_c[j][i_]);
    for (i_ = 0; i_ <= nvars; i_++)
      ar.m_c[i_].Set(j, v * ar.m_c[i_][j]);
  }
}

static void CLinReg::LRBuildZ(CMatrixDouble &xy, const int npoints,
                              const int nvars, int &info, CLinearModel &lm,
                              CLRReport &ar) {

  int i = 0;
  double sigma2 = 0;
  int i_ = 0;

  double s[];

  info = 0;

  if (npoints <= nvars + 1 || nvars < 1) {
    info = -1;
    return;
  }

  ArrayResizeAL(s, npoints);
  for (i = 0; i <= npoints - 1; i++)
    s[i] = 1;

  LRBuildZS(xy, s, npoints, nvars, info, lm, ar);

  if (info < 0)
    return;

  sigma2 = CMath::Sqr(ar.m_rmserror) * npoints / (npoints - nvars - 1);
  for (i = 0; i <= nvars; i++) {
    for (i_ = 0; i_ <= nvars; i_++)
      ar.m_c[i].Set(i_, sigma2 * ar.m_c[i][i_]);
  }
}

static void CLinReg::LRUnpack(CLinearModel &lm, double &v[], int &nvars) {

  int offs = 0;
  int i_ = 0;
  int i1_ = 0;

  nvars = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_lrvnum,
                   __FUNCTION__ + ": Incorrect LINREG version!"))
    return;

  nvars = (int)MathRound(lm.m_w[2]);
  offs = (int)MathRound(lm.m_w[3]);

  ArrayResizeAL(v, nvars + 1);

  i1_ = offs;
  for (i_ = 0; i_ <= nvars; i_++)
    v[i_] = lm.m_w[i_ + i1_];
}

static void CLinReg::LRPack(double &v[], const int nvars, CLinearModel &lm) {

  int offs = 0;
  int i_ = 0;
  int i1_ = 0;

  ArrayResizeAL(lm.m_w, 5 + nvars);

  offs = 4;
  lm.m_w[0] = 4 + nvars + 1;
  lm.m_w[1] = m_lrvnum;
  lm.m_w[2] = nvars;
  lm.m_w[3] = offs;

  i1_ = -offs;
  for (i_ = offs; i_ <= offs + nvars; i_++)
    lm.m_w[i_] = v[i_ + i1_];
}

static double CLinReg::LRProcess(CLinearModel &lm, double &x[]) {

  double v = 0;
  int offs = 0;
  int nvars = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_lrvnum,
                   __FUNCTION__ + ": Incorrect LINREG version!"))
    return (EMPTY_VALUE);

  nvars = (int)MathRound(lm.m_w[2]);
  offs = (int)MathRound(lm.m_w[3]);
  i1_ = offs;
  v = 0.0;

  for (i_ = 0; i_ <= nvars - 1; i_++)
    v += x[i_] * lm.m_w[i_ + i1_];

  return (v + lm.m_w[offs + nvars]);
}

static double CLinReg::LRRMSError(CLinearModel &lm, CMatrixDouble &xy,
                                  const int npoints) {

  double result = 0;
  int i = 0;
  double v = 0;
  int offs = 0;
  int nvars = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_lrvnum,
                   __FUNCTION__ + ": Incorrect LINREG version!"))
    return (EMPTY_VALUE);

  nvars = (int)MathRound(lm.m_w[2]);
  offs = (int)MathRound(lm.m_w[3]);
  result = 0;

  for (i = 0; i <= npoints - 1; i++) {
    i1_ = offs;
    v = 0.0;
    for (i_ = 0; i_ <= nvars - 1; i_++)
      v += xy[i][i_] * lm.m_w[i_ + i1_];
    v = v + lm.m_w[offs + nvars];
    result = result + CMath::Sqr(v - xy[i][nvars]);
  }

  return (MathSqrt(result / npoints));
}

static double CLinReg::LRAvgError(CLinearModel &lm, CMatrixDouble &xy,
                                  const int npoints) {

  double result = 0;
  int i = 0;
  double v = 0;
  int offs = 0;
  int nvars = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_lrvnum,
                   __FUNCTION__ + ": Incorrect LINREG version!"))
    return (EMPTY_VALUE);

  nvars = (int)MathRound(lm.m_w[2]);
  offs = (int)MathRound(lm.m_w[3]);
  result = 0;

  for (i = 0; i <= npoints - 1; i++) {
    i1_ = offs;
    v = 0.0;
    for (i_ = 0; i_ <= nvars - 1; i_++)
      v += xy[i][i_] * lm.m_w[i_ + i1_];
    v = v + lm.m_w[offs + nvars];
    result = result + MathAbs(v - xy[i][nvars]);
  }

  return (result / npoints);
}

static double CLinReg::LRAvgRelError(CLinearModel &lm, CMatrixDouble &xy,
                                     const int npoints) {

  double result = 0;
  int i = 0;
  int k = 0;
  double v = 0;
  int offs = 0;
  int nvars = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_lrvnum,
                   __FUNCTION__ + ": Incorrect LINREG version!"))
    return (EMPTY_VALUE);

  nvars = (int)MathRound(lm.m_w[2]);
  offs = (int)MathRound(lm.m_w[3]);
  result = 0;
  k = 0;

  for (i = 0; i <= npoints - 1; i++) {

    if (xy[i][nvars] != 0.0) {
      i1_ = offs;
      v = 0.0;
      for (i_ = 0; i_ <= nvars - 1; i_++)
        v += xy[i][i_] * lm.m_w[i_ + i1_];
      v = v + lm.m_w[offs + nvars];

      result = result + MathAbs((v - xy[i][nvars]) / xy[i][nvars]);
      k = k + 1;
    }
  }

  if (k != 0)
    result = result / k;

  return (result);
}

static void CLinReg::LRCopy(CLinearModel &lm1, CLinearModel &lm2) {

  int k = 0;
  int i_ = 0;

  k = (int)MathRound(lm1.m_w[0]);

  ArrayResizeAL(lm2.m_w, k);

  for (i_ = 0; i_ <= k - 1; i_++)
    lm2.m_w[i_] = lm1.m_w[i_];
}

static void CLinReg::LRLines(CMatrixDouble &xy, double &s[], const int n,
                             int &info, double &a, double &b, double &vara,
                             double &varb, double &covab, double &corrab,
                             double &p) {

  int i = 0;
  double ss = 0;
  double sx = 0;
  double sxx = 0;
  double sy = 0;
  double stt = 0;
  double e1 = 0;
  double e2 = 0;
  double t = 0;
  double chi2 = 0;

  info = 0;
  a = 0;
  b = 0;
  vara = 0;
  varb = 0;
  covab = 0;
  corrab = 0;
  p = 0;

  if (n < 2) {
    info = -1;
    return;
  }
  for (i = 0; i <= n - 1; i++) {

    if ((double)(s[i]) <= 0.0) {
      info = -2;
      return;
    }
  }

  info = 1;

  ss = 0;
  sx = 0;
  sy = 0;
  sxx = 0;

  for (i = 0; i <= n - 1; i++) {
    t = CMath::Sqr(s[i]);
    ss = ss + 1 / t;
    sx = sx + xy[i][0] / t;
    sy = sy + xy[i][1] / t;
    sxx = sxx + CMath::Sqr(xy[i][0]) / t;
  }

  t = MathSqrt(4 * CMath::Sqr(sx) + CMath::Sqr(ss - sxx));
  e1 = 0.5 * (ss + sxx + t);
  e2 = 0.5 * (ss + sxx - t);

  if (MathMin(e1, e2) <= 1000 * CMath::m_machineepsilon * MathMax(e1, e2)) {
    info = -3;
    return;
  }

  a = 0;
  b = 0;
  stt = 0;

  for (i = 0; i <= n - 1; i++) {
    t = (xy[i][0] - sx / ss) / s[i];
    b = b + t * xy[i][1] / s[i];
    stt = stt + CMath::Sqr(t);
  }
  b = b / stt;
  a = (sy - sx * b) / ss;

  if (n > 2) {
    chi2 = 0;
    for (i = 0; i <= n - 1; i++)
      chi2 = chi2 + CMath::Sqr((xy[i][1] - a - b * xy[i][0]) / s[i]);

    p = CIncGammaF::IncompleteGammaC((double)(n - 2) / (double)2, chi2 / 2);
  } else
    p = 1;

  vara = (1 + CMath::Sqr(sx) / (ss * stt)) / ss;
  varb = 1 / stt;
  covab = -(sx / (ss * stt));
  corrab = covab / MathSqrt(vara * varb);
}

static void CLinReg::LRLine(CMatrixDouble &xy, const int n, int &info,
                            double &a, double &b) {

  int i = 0;
  double vara = 0;
  double varb = 0;
  double covab = 0;
  double corrab = 0;
  double p = 0;

  double s[];

  info = 0;
  a = 0;
  b = 0;

  if (n < 2) {
    info = -1;
    return;
  }

  ArrayResizeAL(s, n);
  for (i = 0; i <= n - 1; i++)
    s[i] = 1;

  LRLines(xy, s, n, info, a, b, vara, varb, covab, corrab, p);
}

static void CLinReg::LRInternal(CMatrixDouble &xy, double &s[],
                                const int npoints, const int nvars, int &info,
                                CLinearModel &lm, CLRReport &ar) {

  int i = 0;
  int j = 0;
  int k = 0;
  int ncv = 0;
  int na = 0;
  int nacv = 0;
  double r = 0;
  double p = 0;
  double epstol = 0;
  int offs = 0;
  int i_ = 0;
  int i1_ = 0;

  double b[];
  double sv[];
  double t[];
  double svi[];
  double work[];

  CMatrixDouble a;
  CMatrixDouble u;
  CMatrixDouble vt;
  CMatrixDouble vm;
  CMatrixDouble xym;

  CLRReport ar2;
  CLinearModel tlm;

  info = 0;
  epstol = 1000;

  if (npoints < nvars || nvars < 1) {
    info = -1;
    return;
  }
  for (i = 0; i <= npoints - 1; i++) {

    if (s[i] <= 0.0) {
      info = -2;
      return;
    }
  }

  info = 1;

  a.Resize(npoints, nvars);
  ArrayResizeAL(b, npoints);

  for (i = 0; i <= npoints - 1; i++) {
    r = 1 / s[i];
    for (i_ = 0; i_ <= nvars - 1; i_++)
      a[i].Set(i_, r * xy[i][i_]);
    b[i] = xy[i][nvars] / s[i];
  }

  ArrayResizeAL(lm.m_w, 4 + nvars);
  offs = 4;
  lm.m_w[0] = 4 + nvars;
  lm.m_w[1] = m_lrvnum;
  lm.m_w[2] = nvars - 1;
  lm.m_w[3] = offs;

  ArrayResizeAL(t, nvars);
  ArrayResizeAL(svi, nvars);
  ar.m_c.Resize(nvars, nvars);
  vm.Resize(nvars, nvars);

  if (!CSingValueDecompose::RMatrixSVD(a, npoints, nvars, 1, 1, 2, sv, u, vt)) {
    info = -4;
    return;
  }

  if (sv[0] <= 0.0) {

    for (i = offs; i <= offs + nvars - 1; i++)
      lm.m_w[i] = 0;

    ar.m_rmserror = LRRMSError(lm, xy, npoints);
    ar.m_avgerror = LRAvgError(lm, xy, npoints);
    ar.m_avgrelerror = LRAvgRelError(lm, xy, npoints);
    ar.m_cvrmserror = ar.m_rmserror;
    ar.m_cvavgerror = ar.m_avgerror;
    ar.m_cvavgrelerror = ar.m_avgrelerror;
    ar.m_ncvdefects = 0;

    ArrayResizeAL(ar.m_cvdefects, nvars);
    ar.m_c.Resize(nvars, nvars);
    for (i = 0; i <= nvars - 1; i++) {
      for (j = 0; j <= nvars - 1; j++)
        ar.m_c[i].Set(j, 0);
    }

    return;
  }

  if (sv[nvars - 1] <= epstol * CMath::m_machineepsilon * sv[0]) {

    for (k = nvars; k >= 1; k--) {

      if (sv[k - 1] > epstol * CMath::m_machineepsilon * sv[0]) {

        xym.Resize(npoints, k + 1);
        for (i = 0; i <= npoints - 1; i++) {
          for (j = 0; j <= k - 1; j++) {

            r = 0.0;
            for (i_ = 0; i_ <= nvars - 1; i_++)
              r += xy[i][i_] * vt[j][i_];
            xym[i].Set(j, r);
          }
          xym[i].Set(k, xy[i][nvars]);
        }

        LRInternal(xym, s, npoints, k, info, tlm, ar2);

        if (info != 1)
          return;

        for (j = 0; j <= nvars - 1; j++)
          lm.m_w[offs + j] = 0;
        for (j = 0; j <= k - 1; j++) {
          r = tlm.m_w[offs + j];
          i1_ = -offs;
          for (i_ = offs; i_ <= offs + nvars - 1; i_++)
            lm.m_w[i_] = lm.m_w[i_] + r * vt[j][i_ + i1_];
        }

        ar.m_rmserror = ar2.m_rmserror;
        ar.m_avgerror = ar2.m_avgerror;
        ar.m_avgrelerror = ar2.m_avgrelerror;
        ar.m_cvrmserror = ar2.m_cvrmserror;
        ar.m_cvavgerror = ar2.m_cvavgerror;
        ar.m_cvavgrelerror = ar2.m_cvavgrelerror;
        ar.m_ncvdefects = ar2.m_ncvdefects;

        ArrayResizeAL(ar.m_cvdefects, nvars);
        for (j = 0; j <= ar.m_ncvdefects - 1; j++)
          ar.m_cvdefects[j] = ar2.m_cvdefects[j];

        ar.m_c.Resize(nvars, nvars);
        ArrayResizeAL(work, nvars + 1);

        CBlas::MatrixMatrixMultiply(ar2.m_c, 0, k - 1, 0, k - 1, false, vt, 0,
                                    k - 1, 0, nvars - 1, false, 1.0, vm, 0,
                                    k - 1, 0, nvars - 1, 0.0, work);
        CBlas::MatrixMatrixMultiply(vt, 0, k - 1, 0, nvars - 1, true, vm, 0,
                                    k - 1, 0, nvars - 1, false, 1.0, ar.m_c, 0,
                                    nvars - 1, 0, nvars - 1, 0.0, work);

        return;
      }
    }

    info = -255;

    return;
  }

  for (i = 0; i <= nvars - 1; i++) {

    if (sv[i] > epstol * CMath::m_machineepsilon * sv[0])
      svi[i] = 1 / sv[i];
    else
      svi[i] = 0;
  }

  for (i = 0; i <= nvars - 1; i++)
    t[i] = 0;

  for (i = 0; i <= npoints - 1; i++) {
    r = b[i];
    for (i_ = 0; i_ <= nvars - 1; i_++)
      t[i_] = t[i_] + r * u[i][i_];
  }
  for (i = 0; i <= nvars - 1; i++)
    lm.m_w[offs + i] = 0;

  for (i = 0; i <= nvars - 1; i++) {
    r = t[i] * svi[i];
    i1_ = -offs;
    for (i_ = offs; i_ <= offs + nvars - 1; i_++)
      lm.m_w[i_] = lm.m_w[i_] + r * vt[i][i_ + i1_];
  }

  for (j = 0; j <= nvars - 1; j++) {
    r = svi[j];
    for (i_ = 0; i_ <= nvars - 1; i_++)
      vm[i_].Set(j, r * vt[j][i_]);
  }

  for (i = 0; i <= nvars - 1; i++) {
    for (j = i; j <= nvars - 1; j++) {
      r = 0.0;
      for (i_ = 0; i_ <= nvars - 1; i_++)
        r += vm[i][i_] * vm[j][i_];
      ar.m_c[i].Set(j, r);
      ar.m_c[j].Set(i, r);
    }
  }

  ncv = 0;
  na = 0;
  nacv = 0;
  ar.m_rmserror = 0;
  ar.m_avgerror = 0;
  ar.m_avgrelerror = 0;
  ar.m_cvrmserror = 0;
  ar.m_cvavgerror = 0;
  ar.m_cvavgrelerror = 0;
  ar.m_ncvdefects = 0;

  ArrayResizeAL(ar.m_cvdefects, nvars);
  for (i = 0; i <= npoints - 1; i++) {

    i1_ = offs;
    r = 0.0;
    for (i_ = 0; i_ <= nvars - 1; i_++)
      r += xy[i][i_] * lm.m_w[i_ + i1_];

    ar.m_rmserror = ar.m_rmserror + CMath::Sqr(r - xy[i][nvars]);
    ar.m_avgerror = ar.m_avgerror + MathAbs(r - xy[i][nvars]);

    if (xy[i][nvars] != 0.0) {
      ar.m_avgrelerror =
          ar.m_avgrelerror + MathAbs((r - xy[i][nvars]) / xy[i][nvars]);
      na = na + 1;
    }

    p = 0.0;
    for (i_ = 0; i_ <= nvars - 1; i_++)
      p += u[i][i_] * u[i][i_];

    if (p > 1 - epstol * CMath::m_machineepsilon) {
      ar.m_cvdefects[ar.m_ncvdefects] = i;
      ar.m_ncvdefects = ar.m_ncvdefects + 1;
      continue;
    }

    r = s[i] * (r / s[i] - b[i] * p) / (1 - p);
    ar.m_cvrmserror = ar.m_cvrmserror + CMath::Sqr(r - xy[i][nvars]);
    ar.m_cvavgerror = ar.m_cvavgerror + MathAbs(r - xy[i][nvars]);

    if (xy[i][nvars] != 0.0) {
      ar.m_cvavgrelerror =
          ar.m_cvavgrelerror + MathAbs((r - xy[i][nvars]) / xy[i][nvars]);
      nacv = nacv + 1;
    }
    ncv = ncv + 1;
  }

  if (ncv == 0) {

    info = -255;

    return;
  }

  ar.m_rmserror = MathSqrt(ar.m_rmserror / npoints);
  ar.m_avgerror = ar.m_avgerror / npoints;

  if (na != 0)
    ar.m_avgrelerror = ar.m_avgrelerror / na;
  ar.m_cvrmserror = MathSqrt(ar.m_cvrmserror / ncv);
  ar.m_cvavgerror = ar.m_cvavgerror / ncv;

  if (nacv != 0)
    ar.m_cvavgrelerror = ar.m_cvavgrelerror / nacv;
}

class CMultilayerPerceptron {
public:
  int m_hlnetworktype;
  int m_hlnormtype;

  int m_hllayersizes[];
  int m_hlconnections[];
  int m_hlneurons[];
  int m_structinfo[];
  double m_weights[];
  double m_columnmeans[];
  double m_columnsigmas[];
  double m_neurons[];
  double m_dfdnet[];
  double m_derror[];
  double m_x[];
  double m_y[];
  double m_nwbuf[];
  int m_integerbuf[];

  CMatrixDouble m_chunks;

  CMultilayerPerceptron(void);
  ~CMultilayerPerceptron(void);

  void Copy(CMultilayerPerceptron &obj);
};

CMultilayerPerceptron::CMultilayerPerceptron(void) {
}

CMultilayerPerceptron::~CMultilayerPerceptron(void) {
}

void CMultilayerPerceptron::Copy(CMultilayerPerceptron &obj) {

  m_hlnetworktype = obj.m_hlnetworktype;
  m_hlnormtype = obj.m_hlnormtype;

  ArrayCopy(m_hllayersizes, obj.m_hllayersizes);
  ArrayCopy(m_hlconnections, obj.m_hlconnections);
  ArrayCopy(m_hlneurons, obj.m_hlneurons);
  ArrayCopy(m_structinfo, obj.m_structinfo);
  ArrayCopy(m_weights, obj.m_weights);
  ArrayCopy(m_columnmeans, obj.m_columnmeans);
  ArrayCopy(m_columnsigmas, obj.m_columnsigmas);
  ArrayCopy(m_neurons, obj.m_neurons);
  ArrayCopy(m_dfdnet, obj.m_dfdnet);
  ArrayCopy(m_derror, obj.m_derror);
  ArrayCopy(m_x, obj.m_x);
  ArrayCopy(m_y, obj.m_y);
  ArrayCopy(m_nwbuf, obj.m_nwbuf);
  ArrayCopy(m_integerbuf, obj.m_integerbuf);

  m_chunks = obj.m_chunks;
}

class CMultilayerPerceptronShell {
private:
  CMultilayerPerceptron m_innerobj;

public:
  CMultilayerPerceptronShell(void);
  CMultilayerPerceptronShell(CMultilayerPerceptron &obj);
  ~CMultilayerPerceptronShell(void);

  CMultilayerPerceptron *GetInnerObj(void);
};

CMultilayerPerceptronShell::CMultilayerPerceptronShell(void) {
}

CMultilayerPerceptronShell::CMultilayerPerceptronShell(
    CMultilayerPerceptron &obj) {

  m_innerobj.Copy(obj);
}

CMultilayerPerceptronShell::~CMultilayerPerceptronShell(void) {
}

CMultilayerPerceptron *CMultilayerPerceptronShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMLPBase {
private:
  static void AddInputLayer(const int ncount, int &lsizes[], int &ltypes[],
                            int &lconnfirst[], int &lconnlast[], int &lastproc);
  static void AddBiasedSummatorLayer(const int ncount, int &lsizes[],
                                     int &ltypes[], int &lconnfirst[],
                                     int &lconnlast[], int &lastproc);
  static void AddActivationLayer(const int functype, int &lsizes[],
                                 int &ltypes[], int &lconnfirst[],
                                 int &lconnlast[], int &lastproc);
  static void AddZeroLayer(int &lsizes[], int &ltypes[], int &lconnfirst[],
                           int &lconnlast[], int &lastproc);
  static void HLAddInputLayer(CMultilayerPerceptron &network, int &connidx,
                              int &neuroidx, int &structinfoidx, int nin);
  static void HLAddOutputLayer(CMultilayerPerceptron &network, int &connidx,
                               int &neuroidx, int &structinfoidx,
                               int &weightsidx, const int k, const int nprev,
                               const int nout, const bool iscls,
                               const bool islinearout);
  static void HLAddHiddenLayer(CMultilayerPerceptron &network, int &connidx,
                               int &neuroidx, int &structinfoidx,
                               int &weightsidx, const int k, const int nprev,
                               const int ncur);
  static void FillHighLevelInformation(CMultilayerPerceptron &network,
                                       const int nin, const int nhid1,
                                       const int nhid2, const int nout,
                                       const bool iscls,
                                       const bool islinearout);
  static void MLPCreate(const int nin, const int nout, int &lsizes[],
                        int &ltypes[], int &lconnfirst[], int &lconnlast[],
                        const int layerscount, const bool isclsnet,
                        CMultilayerPerceptron &network);
  static void MLPHessianBatchInternal(CMultilayerPerceptron &network,
                                      CMatrixDouble &xy, const int ssize,
                                      const bool naturalerr, double &e,
                                      double &grad[], CMatrixDouble &h);
  static void MLPInternalCalculateGradient(CMultilayerPerceptron &network,
                                           double &neurons[], double &weights[],
                                           double &derror[], double &grad[],
                                           const bool naturalerrorfunc);
  static void MLPChunkedGradient(CMultilayerPerceptron &network,
                                 CMatrixDouble &xy, const int cstart,
                                 const int csize, double &e, double &grad[],
                                 const bool naturalerrorfunc);
  static double SafeCrossEntropy(const double t, const double z);

public:
  static const int m_mlpvnum;
  static const int m_mlpfirstversion;
  static const int m_nfieldwidth;
  static const int m_hlconm_nfieldwidth;
  static const int m_hlm_nfieldwidth;
  static const int m_chunksize;

  CMLPBase(void);
  ~CMLPBase(void);

  static void MLPCreate0(const int nin, const int nout,
                         CMultilayerPerceptron &network);
  static void MLPCreate1(const int nin, const int nhid, const int nout,
                         CMultilayerPerceptron &network);
  static void MLPCreate2(const int nin, const int nhid1, const int nhid2,
                         const int nout, CMultilayerPerceptron &network);
  static void MLPCreateB0(const int nin, const int nout, const double b,
                          double d, CMultilayerPerceptron &network);
  static void MLPCreateB1(const int nin, const int nhid, const int nout,
                          const double b, double d,
                          CMultilayerPerceptron &network);
  static void MLPCreateB2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const double b, double d,
                          CMultilayerPerceptron &network);
  static void MLPCreateR0(const int nin, const int nout, const double a,
                          const double b, CMultilayerPerceptron &network);
  static void MLPCreateR1(const int nin, const int nhid, const int nout,
                          const double a, const double b,
                          CMultilayerPerceptron &network);
  static void MLPCreateR2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const double a, const double b,
                          CMultilayerPerceptron &network);
  static void MLPCreateC0(const int nin, const int nout,
                          CMultilayerPerceptron &network);
  static void MLPCreateC1(const int nin, const int nhid, const int nout,
                          CMultilayerPerceptron &network);
  static void MLPCreateC2(const int nin, const int nhid1, const int nhid2,
                          const int nout, CMultilayerPerceptron &network);
  static void MLPCopy(CMultilayerPerceptron &network1,
                      CMultilayerPerceptron &network2);
  static void MLPSerializeOld(CMultilayerPerceptron &network, double &ra[],
                              int &rlen);
  static void MLPUnserializeOld(double &ra[], CMultilayerPerceptron &network);
  static void MLPRandomize(CMultilayerPerceptron &network);
  static void MLPRandomizeFull(CMultilayerPerceptron &network);
  static void MLPInitPreprocessor(CMultilayerPerceptron &network,
                                  CMatrixDouble &xy, const int ssize);
  static void MLPProperties(CMultilayerPerceptron &network, int &nin, int &nout,
                            int &wcount);
  static bool MLPIsSoftMax(CMultilayerPerceptron &network);
  static int MLPGetLayersCount(CMultilayerPerceptron &network);
  static int MLPGetLayerSize(CMultilayerPerceptron &network, const int k);
  static void MLPGetInputScaling(CMultilayerPerceptron &network, const int i,
                                 double &mean, double &sigma);
  static void MLPGetOutputScaling(CMultilayerPerceptron &network, const int i,
                                  double &mean, double &sigma);
  static void MLPGetNeuronInfo(CMultilayerPerceptron &network, const int k,
                               const int i, int &fkind, double &threshold);
  static double MLPGetWeight(CMultilayerPerceptron &network, const int k0,
                             const int i0, const int k1, const int i1);
  static void MLPSetInputScaling(CMultilayerPerceptron &network, const int i,
                                 const double mean, double sigma);
  static void MLPSetOutputScaling(CMultilayerPerceptron &network, const int i,
                                  const double mean, double sigma);
  static void MLPSetNeuronInfo(CMultilayerPerceptron &network, const int k,
                               const int i, const int fkind,
                               const double threshold);
  static void MLPSetWeight(CMultilayerPerceptron &network, const int k0,
                           const int i0, const int k1, const int i1,
                           const double w);
  static void MLPActivationFunction(double net, const int k, double &f,
                                    double &df, double &d2f);
  static void MLPProcess(CMultilayerPerceptron &network, double &x[],
                         double &y[]);
  static void MLPProcessI(CMultilayerPerceptron &network, double &x[],
                          double &y[]);
  static double MLPError(CMultilayerPerceptron &network, CMatrixDouble &xy,
                         const int ssize);
  static double MLPErrorN(CMultilayerPerceptron &network, CMatrixDouble &xy,
                          const int ssize);
  static int MLPClsError(CMultilayerPerceptron &network, CMatrixDouble &xy,
                         const int ssize);
  static double MLPRelClsError(CMultilayerPerceptron &network,
                               CMatrixDouble &xy, const int npoints);
  static double MLPAvgCE(CMultilayerPerceptron &network, CMatrixDouble &xy,
                         const int npoints);
  static double MLPRMSError(CMultilayerPerceptron &network, CMatrixDouble &xy,
                            const int npoints);
  static double MLPAvgError(CMultilayerPerceptron &network, CMatrixDouble &xy,
                            const int npoints);
  static double MLPAvgRelError(CMultilayerPerceptron &network,
                               CMatrixDouble &xy, const int npoints);
  static void MLPGrad(CMultilayerPerceptron &network, double &x[],
                      double &desiredy[], double &e, double &grad[]);
  static void MLPGradN(CMultilayerPerceptron &network, double &x[],
                       double &desiredy[], double &e, double &grad[]);
  static void MLPGradBatch(CMultilayerPerceptron &network, CMatrixDouble &xy,
                           const int ssize, double &e, double &grad[]);
  static void MLPGradNBatch(CMultilayerPerceptron &network, CMatrixDouble &xy,
                            const int ssize, double &e, double &grad[]);
  static void MLPHessianNBatch(CMultilayerPerceptron &network,
                               CMatrixDouble &xy, const int ssize, double &e,
                               double &grad[], CMatrixDouble &h);
  static void MLPHessianBatch(CMultilayerPerceptron &network, CMatrixDouble &xy,
                              const int ssize, double &e, double &grad[],
                              CMatrixDouble &h);
  static void MLPInternalProcessVector(int &structinfo[], double &weights[],
                                       double &columnmeans[],
                                       double &columnsigmas[],
                                       double &neurons[], double &dfdnet[],
                                       double &x[], double &y[]);
  static void MLPAlloc(CSerializer &s, CMultilayerPerceptron &network);
  static void MLPSerialize(CSerializer &s, CMultilayerPerceptron &network);
  static void MLPUnserialize(CSerializer &s, CMultilayerPerceptron &network);
};

const int CMLPBase::m_mlpvnum = 7;
const int CMLPBase::m_mlpfirstversion = 0;
const int CMLPBase::m_nfieldwidth = 4;
const int CMLPBase::m_hlconm_nfieldwidth = 5;
const int CMLPBase::m_hlm_nfieldwidth = 4;
const int CMLPBase::m_chunksize = 32;

CMLPBase::CMLPBase(void) {
}

CMLPBase::~CMLPBase(void) {
}

static void CMLPBase::MLPCreate0(const int nin, const int nout,
                                 CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  layerscount = 4;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(-5, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, 0, 0, nout, false, true);
}

static void CMLPBase::MLPCreate1(const int nin, const int nhid, const int nout,
                                 CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  layerscount = 7;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(-5, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, nhid, 0, nout, false, true);
}

static void CMLPBase::MLPCreate2(const int nin, const int nhid1,
                                 const int nhid2, const int nout,
                                 CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  layerscount = 10;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid1, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid2, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(-5, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, nhid1, nhid2, nout, false, true);
}

static void CMLPBase::MLPCreateB0(const int nin, const int nout, const double b,
                                  double d, CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;
  int i = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  layerscount = 4;

  if (d >= 0.0)
    d = 1;
  else
    d = -1;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(3, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, 0, 0, nout, false, false);

  for (i = nin; i <= nin + nout - 1; i++) {
    network.m_columnmeans[i] = b;
    network.m_columnsigmas[i] = d;
  }
}

static void CMLPBase::MLPCreateB1(const int nin, const int nhid, const int nout,
                                  const double b, double d,
                                  CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;
  int i = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];
  layerscount = 7;

  if (d >= 0.0)
    d = 1;
  else
    d = -1;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(3, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, nhid, 0, nout, false, false);

  for (i = nin; i <= nin + nout - 1; i++) {
    network.m_columnmeans[i] = b;
    network.m_columnsigmas[i] = d;
  }
}

static void CMLPBase::MLPCreateB2(const int nin, const int nhid1,
                                  const int nhid2, const int nout,
                                  const double b, double d,
                                  CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;
  int i = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  layerscount = 10;

  if (d >= 0.0)
    d = 1;
  else
    d = -1;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid1, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid2, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(3, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, nhid1, nhid2, nout, false, false);

  for (i = nin; i <= nin + nout - 1; i++) {
    network.m_columnmeans[i] = b;
    network.m_columnsigmas[i] = d;
  }
}

static void CMLPBase::MLPCreateR0(const int nin, const int nout, const double a,
                                  const double b,
                                  CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;
  int i = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  layerscount = 1 + 3;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, 0, 0, nout, false, false);

  for (i = nin; i <= nin + nout - 1; i++) {
    network.m_columnmeans[i] = 0.5 * (a + b);
    network.m_columnsigmas[i] = 0.5 * (a - b);
  }
}

static void CMLPBase::MLPCreateR1(const int nin, const int nhid, const int nout,
                                  const double a, const double b,
                                  CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;
  int i = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  layerscount = 7;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, nhid, 0, nout, false, false);

  for (i = nin; i <= nin + nout - 1; i++) {
    network.m_columnmeans[i] = 0.5 * (a + b);
    network.m_columnsigmas[i] = 0.5 * (a - b);
  }
}

static void CMLPBase::MLPCreateR2(const int nin, const int nhid1,
                                  const int nhid2, const int nout,
                                  const double a, const double b,
                                  CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;
  int i = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  layerscount = 10;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid1, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid2, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount,
            false, network);

  FillHighLevelInformation(network, nin, nhid1, nhid2, nout, false, false);

  for (i = nin; i <= nin + nout - 1; i++) {
    network.m_columnmeans[i] = 0.5 * (a + b);
    network.m_columnsigmas[i] = 0.5 * (a - b);
  }
}

static void CMLPBase::MLPCreateC0(const int nin, const int nout,
                                  CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  if (!CAp::Assert(nout >= 2, __FUNCTION__ + ": NOut<2!"))
    return;

  layerscount = 4;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout - 1, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddZeroLayer(lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount, true,
            network);

  FillHighLevelInformation(network, nin, 0, 0, nout, true, true);
}

static void CMLPBase::MLPCreateC1(const int nin, const int nhid, const int nout,
                                  CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  if (!CAp::Assert(nout >= 2, __FUNCTION__ + ": NOut<2!"))
    return;

  layerscount = 7;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout - 1, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddZeroLayer(lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount, true,
            network);

  FillHighLevelInformation(network, nin, nhid, 0, nout, true, true);
}

static void CMLPBase::MLPCreateC2(const int nin, const int nhid1,
                                  const int nhid2, const int nout,
                                  CMultilayerPerceptron &network) {

  int layerscount = 0;
  int lastproc = 0;

  int lsizes[];
  int ltypes[];
  int lconnfirst[];
  int lconnlast[];

  if (!CAp::Assert(nout >= 2, __FUNCTION__ + ": NOut<2!"))
    return;

  layerscount = 10;

  ArrayResizeAL(lsizes, layerscount);
  ArrayResizeAL(ltypes, layerscount);
  ArrayResizeAL(lconnfirst, layerscount);
  ArrayResizeAL(lconnlast, layerscount);

  AddInputLayer(nin, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid1, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nhid2, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddActivationLayer(1, lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  AddBiasedSummatorLayer(nout - 1, lsizes, ltypes, lconnfirst, lconnlast,
                         lastproc);

  AddZeroLayer(lsizes, ltypes, lconnfirst, lconnlast, lastproc);

  MLPCreate(nin, nout, lsizes, ltypes, lconnfirst, lconnlast, layerscount, true,
            network);

  FillHighLevelInformation(network, nin, nhid1, nhid2, nout, true, true);
}

static void CMLPBase::MLPCopy(CMultilayerPerceptron &network1,
                              CMultilayerPerceptron &network2) {

  network2.m_hlnetworktype = network1.m_hlnetworktype;
  network2.m_hlnormtype = network1.m_hlnormtype;

  CApServ::CopyIntegerArray(network1.m_hllayersizes, network2.m_hllayersizes);
  CApServ::CopyIntegerArray(network1.m_hlconnections, network2.m_hlconnections);
  CApServ::CopyIntegerArray(network1.m_hlneurons, network2.m_hlneurons);
  CApServ::CopyIntegerArray(network1.m_structinfo, network2.m_structinfo);
  CApServ::CopyRealArray(network1.m_weights, network2.m_weights);
  CApServ::CopyRealArray(network1.m_columnmeans, network2.m_columnmeans);
  CApServ::CopyRealArray(network1.m_columnsigmas, network2.m_columnsigmas);
  CApServ::CopyRealArray(network1.m_neurons, network2.m_neurons);
  CApServ::CopyRealArray(network1.m_dfdnet, network2.m_dfdnet);
  CApServ::CopyRealArray(network1.m_derror, network2.m_derror);
  CApServ::CopyRealArray(network1.m_x, network2.m_x);
  CApServ::CopyRealArray(network1.m_y, network2.m_y);
  CApServ::CopyRealMatrix(network1.m_chunks, network2.m_chunks);
  CApServ::CopyRealArray(network1.m_nwbuf, network2.m_nwbuf);
  CApServ::CopyIntegerArray(network1.m_integerbuf, network2.m_integerbuf);
}

static void CMLPBase::MLPSerializeOld(CMultilayerPerceptron &network,
                                      double &ra[], int &rlen) {

  int i = 0;
  int ssize = 0;
  int ntotal = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  int sigmalen = 0;
  int offs = 0;
  int i_ = 0;
  int i1_ = 0;

  rlen = 0;

  ssize = network.m_structinfo[0];
  nin = network.m_structinfo[1];
  nout = network.m_structinfo[2];
  ntotal = network.m_structinfo[3];
  wcount = network.m_structinfo[4];

  if (MLPIsSoftMax(network))
    sigmalen = nin;
  else
    sigmalen = nin + nout;

  rlen = 3 + ssize + wcount + 2 * sigmalen;

  ArrayResizeAL(ra, rlen);

  ra[0] = rlen;
  ra[1] = m_mlpvnum;
  ra[2] = ssize;

  offs = 3;
  for (i = 0; i <= ssize - 1; i++)
    ra[offs + i] = network.m_structinfo[i];

  offs = offs + ssize;
  i1_ = -offs;
  for (i_ = offs; i_ <= offs + wcount - 1; i_++)
    ra[i_] = network.m_weights[i_ + i1_];

  offs = offs + wcount;
  i1_ = -offs;
  for (i_ = offs; i_ <= offs + sigmalen - 1; i_++)
    ra[i_] = network.m_columnmeans[i_ + i1_];

  offs = offs + sigmalen;
  i1_ = -offs;
  for (i_ = offs; i_ <= offs + sigmalen - 1; i_++)
    ra[i_] = network.m_columnsigmas[i_ + i1_];
  offs = offs + sigmalen;
}

static void CMLPBase::MLPUnserializeOld(double &ra[],
                                        CMultilayerPerceptron &network) {

  int i = 0;
  int ssize = 0;
  int ntotal = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  int sigmalen = 0;
  int offs = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert((int)MathRound(ra[1]) == m_mlpvnum,
                   __FUNCTION__ + ": incorrect array!"))
    return;

  offs = 3;
  ssize = (int)MathRound(ra[2]);

  ArrayResizeAL(network.m_structinfo, ssize);
  for (i = 0; i <= ssize - 1; i++)
    network.m_structinfo[i] = (int)MathRound(ra[offs + i]);
  offs = offs + ssize;

  ssize = network.m_structinfo[0];
  nin = network.m_structinfo[1];
  nout = network.m_structinfo[2];
  ntotal = network.m_structinfo[3];
  wcount = network.m_structinfo[4];

  if (network.m_structinfo[6] == 0)
    sigmalen = nin + nout;
  else
    sigmalen = nin;

  ArrayResizeAL(network.m_weights, wcount);
  ArrayResizeAL(network.m_columnmeans, sigmalen);
  ArrayResizeAL(network.m_columnsigmas, sigmalen);
  ArrayResizeAL(network.m_neurons, ntotal);
  network.m_chunks.Resize(3 * ntotal + 1, m_chunksize);
  ArrayResizeAL(network.m_nwbuf, MathMax(wcount, 2 * nout));
  ArrayResizeAL(network.m_dfdnet, ntotal);
  ArrayResizeAL(network.m_x, nin);
  ArrayResizeAL(network.m_y, nout);
  ArrayResizeAL(network.m_derror, ntotal);

  i1_ = offs;
  for (i_ = 0; i_ <= wcount - 1; i_++)
    network.m_weights[i_] = ra[i_ + i1_];

  offs = offs + wcount;
  i1_ = offs;
  for (i_ = 0; i_ <= sigmalen - 1; i_++)
    network.m_columnmeans[i_] = ra[i_ + i1_];

  offs = offs + sigmalen;
  i1_ = offs;
  for (i_ = 0; i_ <= sigmalen - 1; i_++)
    network.m_columnsigmas[i_] = ra[i_ + i1_];
  offs = offs + sigmalen;
}

static void CMLPBase::MLPRandomize(CMultilayerPerceptron &network) {

  int i = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;

  MLPProperties(network, nin, nout, wcount);

  for (i = 0; i <= wcount - 1; i++)
    network.m_weights[i] = CMath::RandomReal() - 0.5;
}

static void CMLPBase::MLPRandomizeFull(CMultilayerPerceptron &network) {

  int i = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  int ntotal = 0;
  int istart = 0;
  int offs = 0;
  int ntype = 0;

  MLPProperties(network, nin, nout, wcount);

  ntotal = network.m_structinfo[3];
  istart = network.m_structinfo[5];

  for (i = 0; i <= wcount - 1; i++)
    network.m_weights[i] = CMath::RandomReal() - 0.5;
  for (i = 0; i <= nin - 1; i++) {
    network.m_columnmeans[i] = 2 * CMath::RandomReal() - 1;
    network.m_columnsigmas[i] = 1.5 * CMath::RandomReal() + 0.5;
  }

  if (!MLPIsSoftMax(network)) {
    for (i = 0; i <= nout - 1; i++) {
      offs = istart + (ntotal - nout + i) * m_nfieldwidth;
      ntype = network.m_structinfo[offs + 0];

      if (ntype == 0) {

        network.m_columnmeans[nin + i] = 2 * CMath::RandomReal() - 1;
      }

      if (ntype == 0 || ntype == 3) {

        network.m_columnsigmas[nin + i] =
            MathSign(network.m_columnsigmas[nin + i]) *
            (1.5 * CMath::RandomReal() + 0.5);
      }
    }
  }
}

static void CMLPBase::MLPInitPreprocessor(CMultilayerPerceptron &network,
                                          CMatrixDouble &xy, const int ssize) {

  int i = 0;
  int j = 0;
  int jmax = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  int ntotal = 0;
  int istart = 0;
  int offs = 0;
  int ntype = 0;
  double s = 0;

  double means[];
  double sigmas[];

  MLPProperties(network, nin, nout, wcount);

  ntotal = network.m_structinfo[3];
  istart = network.m_structinfo[5];

  if (MLPIsSoftMax(network))
    jmax = nin - 1;
  else
    jmax = nin + nout - 1;

  ArrayResizeAL(means, jmax + 1);
  ArrayResizeAL(sigmas, jmax + 1);

  for (j = 0; j <= jmax; j++) {

    means[j] = 0;
    for (i = 0; i <= ssize - 1; i++)
      means[j] = means[j] + xy[i][j];
    means[j] = means[j] / ssize;

    sigmas[j] = 0;
    for (i = 0; i <= ssize - 1; i++)
      sigmas[j] = sigmas[j] + CMath::Sqr(xy[i][j] - means[j]);
    sigmas[j] = MathSqrt(sigmas[j] / ssize);
  }

  for (i = 0; i <= nin - 1; i++) {
    network.m_columnmeans[i] = means[i];
    network.m_columnsigmas[i] = sigmas[i];

    if (network.m_columnsigmas[i] == 0.0)
      network.m_columnsigmas[i] = 1;
  }

  if (!MLPIsSoftMax(network)) {
    for (i = 0; i <= nout - 1; i++) {
      offs = istart + (ntotal - nout + i) * m_nfieldwidth;
      ntype = network.m_structinfo[offs + 0];

      if (ntype == 0) {
        network.m_columnmeans[nin + i] = means[nin + i];
        network.m_columnsigmas[nin + i] = sigmas[nin + i];

        if (network.m_columnsigmas[nin + i] == 0.0)
          network.m_columnsigmas[nin + i] = 1;
      }

      if (ntype == 3) {
        s = means[nin + i] - network.m_columnmeans[nin + i];

        if (s == 0.0)
          s = MathSign(network.m_columnsigmas[nin + i]);

        if (s == 0.0)
          s = 1.0;

        network.m_columnsigmas[nin + i] =
            MathSign(network.m_columnsigmas[nin + i]) * MathAbs(s);

        if ((double)(network.m_columnsigmas[nin + i]) == 0.0)
          network.m_columnsigmas[nin + i] = 1;
      }
    }
  }
}

static void CMLPBase::MLPProperties(CMultilayerPerceptron &network, int &nin,
                                    int &nout, int &wcount) {

  nin = network.m_structinfo[1];
  nout = network.m_structinfo[2];
  wcount = network.m_structinfo[4];
}

static bool CMLPBase::MLPIsSoftMax(CMultilayerPerceptron &network) {

  if (network.m_structinfo[6] == 1)
    return (true);

  return (false);
}

static int CMLPBase::MLPGetLayersCount(CMultilayerPerceptron &network) {

  return (CAp::Len(network.m_hllayersizes));
}

static int CMLPBase::MLPGetLayerSize(CMultilayerPerceptron &network,
                                     const int k) {

  if (!CAp::Assert(k >= 0 && k < CAp::Len(network.m_hllayersizes),
                   __FUNCTION__ + ": incorrect layer index"))
    return (-1);

  return (network.m_hllayersizes[k]);
}

static void CMLPBase::MLPGetInputScaling(CMultilayerPerceptron &network,
                                         const int i, double &mean,
                                         double &sigma) {

  mean = 0;
  sigma = 0;

  if (!CAp::Assert(i >= 0 && i < network.m_hllayersizes[0],
                   __FUNCTION__ + ": incorrect (nonexistent) I"))
    return;

  mean = network.m_columnmeans[i];
  sigma = network.m_columnsigmas[i];

  if (sigma == 0.0)
    sigma = 1;
}

static void CMLPBase::MLPGetOutputScaling(CMultilayerPerceptron &network,
                                          const int i, double &mean,
                                          double &sigma) {

  mean = 0;
  sigma = 0;

  if (!CAp::Assert(
          i >= 0 &&
              i < network.m_hllayersizes[CAp::Len(network.m_hllayersizes) - 1],
          __FUNCTION__ + ": incorrect (nonexistent) I"))
    return;

  if (network.m_structinfo[6] == 1) {

    mean = 0;
    sigma = 1;
  } else {

    mean = network.m_columnmeans[network.m_hllayersizes[0] + i];
    sigma = network.m_columnsigmas[network.m_hllayersizes[0] + i];
  }
}

static void CMLPBase::MLPGetNeuronInfo(CMultilayerPerceptron &network,
                                       const int k, const int i, int &fkind,
                                       double &threshold) {

  int ncnt = 0;
  int istart = 0;
  int highlevelidx = 0;
  int activationoffset = 0;

  fkind = 0;
  threshold = 0;
  ncnt = CAp::Len(network.m_hlneurons) / m_hlm_nfieldwidth;
  istart = network.m_structinfo[5];

  network.m_integerbuf[0] = k;
  network.m_integerbuf[1] = i;

  highlevelidx = CApServ::RecSearch(network.m_hlneurons, m_hlm_nfieldwidth, 2,
                                    0, ncnt, network.m_integerbuf);

  if (!CAp::Assert(highlevelidx >= 0,
                   __FUNCTION__ +
                       ": incorrect (nonexistent) layer or neuron index"))
    return;

  if (network.m_hlneurons[highlevelidx * m_hlm_nfieldwidth + 2] >= 0) {
    activationoffset =
        istart + network.m_hlneurons[highlevelidx * m_hlm_nfieldwidth + 2] *
                     m_nfieldwidth;
    fkind = network.m_structinfo[activationoffset + 0];
  } else
    fkind = 0;

  if (network.m_hlneurons[highlevelidx * m_hlm_nfieldwidth + 3] >= 0)
    threshold =
        network.m_weights[network.m_hlneurons[highlevelidx * m_hlm_nfieldwidth +
                                              3]];
  else
    threshold = 0;
}

static double CMLPBase::MLPGetWeight(CMultilayerPerceptron &network,
                                     const int k0, const int i0, const int k1,
                                     const int i1) {

  double result = 0;
  int ccnt = 0;
  int highlevelidx = 0;

  ccnt = CAp::Len(network.m_hlconnections) / m_hlconm_nfieldwidth;

  if (!CAp::Assert(k0 >= 0 && k0 < CAp::Len(network.m_hllayersizes),
                   __FUNCTION__ + ": incorrect (nonexistent) K0"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(i0 >= 0 && i0 < network.m_hllayersizes[k0],
                   __FUNCTION__ + ": incorrect (nonexistent) I0"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(k1 >= 0 && k1 < CAp::Len(network.m_hllayersizes),
                   __FUNCTION__ + ": incorrect (nonexistent) K1"))
    return (EMPTY_VALUE);

  if (!CAp::Assert(i1 >= 0 && i1 < network.m_hllayersizes[k1],
                   __FUNCTION__ + ": incorrect (nonexistent) I1"))
    return (EMPTY_VALUE);

  network.m_integerbuf[0] = k0;
  network.m_integerbuf[1] = i0;
  network.m_integerbuf[2] = k1;
  network.m_integerbuf[3] = i1;

  highlevelidx =
      CApServ::RecSearch(network.m_hlconnections, m_hlconm_nfieldwidth, 4, 0,
                         ccnt, network.m_integerbuf);

  if (highlevelidx >= 0)
    result =
        network.m_weights
            [network.m_hlconnections[highlevelidx * m_hlconm_nfieldwidth + 4]];
  else
    result = 0;

  return (result);
}

static void CMLPBase::MLPSetInputScaling(CMultilayerPerceptron &network,
                                         const int i, const double mean,
                                         double sigma) {

  if (!CAp::Assert(i >= 0 && i < network.m_hllayersizes[0],
                   __FUNCTION__ + ": incorrect (nonexistent) I"))
    return;

  if (!CAp::Assert(CMath::IsFinite(mean),
                   __FUNCTION__ + ": infinite or NAN Mean"))
    return;

  if (!CAp::Assert(CMath::IsFinite(sigma),
                   __FUNCTION__ + ": infinite or NAN Sigma"))
    return;

  if (sigma == 0.0)
    sigma = 1;

  network.m_columnmeans[i] = mean;
  network.m_columnsigmas[i] = sigma;
}

static void CMLPBase::MLPSetOutputScaling(CMultilayerPerceptron &network,
                                          const int i, const double mean,
                                          double sigma) {

  if (!CAp::Assert(
          i >= 0 &&
              i < network.m_hllayersizes[CAp::Len(network.m_hllayersizes) - 1],
          __FUNCTION__ + ": incorrect (nonexistent) I"))
    return;

  if (!CAp::Assert(CMath::IsFinite(mean),
                   __FUNCTION__ + ": infinite or NAN Mean"))
    return;

  if (!CAp::Assert(CMath::IsFinite(sigma),
                   __FUNCTION__ + ": infinite or NAN Sigma"))
    return;

  if (network.m_structinfo[6] == 1) {

    if (!CAp::Assert(
            mean == 0.0,
            __FUNCTION__ +
                ": you can not set non-zero Mean term for classifier network"))
      return;

    if (!CAp::Assert(
            sigma == 1.0,
            __FUNCTION__ +
                ": you can not set non-unit Sigma term for classifier network"))
      return;
  } else {

    if (sigma == 0.0)
      sigma = 1;

    network.m_columnmeans[network.m_hllayersizes[0] + i] = mean;
    network.m_columnsigmas[network.m_hllayersizes[0] + i] = sigma;
  }
}

static void CMLPBase::MLPSetNeuronInfo(CMultilayerPerceptron &network,
                                       const int k, const int i,
                                       const int fkind,
                                       const double threshold) {

  int ncnt = 0;
  int istart = 0;
  int highlevelidx = 0;
  int activationoffset = 0;

  if (!CAp::Assert(CMath::IsFinite(threshold),
                   __FUNCTION__ + ": infinite or NAN Threshold"))
    return;

  ncnt = CAp::Len(network.m_hlneurons) / m_hlm_nfieldwidth;
  istart = network.m_structinfo[5];

  network.m_integerbuf[0] = k;
  network.m_integerbuf[1] = i;

  highlevelidx = CApServ::RecSearch(network.m_hlneurons, m_hlm_nfieldwidth, 2,
                                    0, ncnt, network.m_integerbuf);

  if (!CAp::Assert(highlevelidx >= 0,
                   __FUNCTION__ +
                       ": incorrect (nonexistent) layer or neuron index"))
    return;

  if (network.m_hlneurons[highlevelidx * m_hlm_nfieldwidth + 2] >= 0) {
    activationoffset =
        istart + network.m_hlneurons[highlevelidx * m_hlm_nfieldwidth + 2] *
                     m_nfieldwidth;
    network.m_structinfo[activationoffset + 0] = fkind;
  } else {

    if (!CAp::Assert(fkind == 0, __FUNCTION__ +
                                     ": you try to set activation function for "
                                     "neuron which can not have one"))
      return;
  }

  if (network.m_hlneurons[highlevelidx * m_hlm_nfieldwidth + 3] >= 0)
    network
        .m_weights[network.m_hlneurons[highlevelidx * m_hlm_nfieldwidth + 3]] =
        threshold;
  else {

    if (!CAp::Assert(threshold == 0.0,
                     __FUNCTION__ + ": you try to set non-zero threshold for "
                                    "neuron which can not have one"))
      return;
  }
}

static void CMLPBase::MLPSetWeight(CMultilayerPerceptron &network, const int k0,
                                   const int i0, const int k1, const int i1,
                                   const double w) {

  int ccnt = 0;
  int highlevelidx = 0;

  ccnt = CAp::Len(network.m_hlconnections) / m_hlconm_nfieldwidth;

  if (!CAp::Assert(k0 >= 0 && k0 < CAp::Len(network.m_hllayersizes),
                   __FUNCTION__ + ": incorrect (nonexistent) K0"))
    return;

  if (!CAp::Assert(i0 >= 0 && i0 < network.m_hllayersizes[k0],
                   __FUNCTION__ + ": incorrect (nonexistent) I0"))
    return;

  if (!CAp::Assert(k1 >= 0 && k1 < CAp::Len(network.m_hllayersizes),
                   __FUNCTION__ + ": incorrect (nonexistent) K1"))
    return;

  if (!CAp::Assert(i1 >= 0 && i1 < network.m_hllayersizes[k1],
                   __FUNCTION__ + ": incorrect (nonexistent) I1"))
    return;

  if (!CAp::Assert(CMath::IsFinite(w),
                   __FUNCTION__ + ": infinite or NAN weight"))
    return;

  network.m_integerbuf[0] = k0;
  network.m_integerbuf[1] = i0;
  network.m_integerbuf[2] = k1;
  network.m_integerbuf[3] = i1;

  highlevelidx =
      CApServ::RecSearch(network.m_hlconnections, m_hlconm_nfieldwidth, 4, 0,
                         ccnt, network.m_integerbuf);

  if (highlevelidx >= 0)
    network.m_weights
        [network.m_hlconnections[highlevelidx * m_hlconm_nfieldwidth + 4]] = w;
  else {

    if (!CAp::Assert(
            w == 0.0,
            __FUNCTION__ +
                ": you try to set non-zero weight for non-existent connection"))
      return;
  }
}

static void CMLPBase::MLPActivationFunction(double net, const int k, double &f,
                                            double &df, double &d2f) {

  double net2 = 0;
  double arg = 0;
  double root = 0;
  double r = 0;

  f = 0;
  df = 0;
  d2f = 0;

  if (k == 0 || k == -5) {
    f = net;
    df = 1;
    d2f = 0;

    return;
  }

  if (k == 1) {

    if (MathAbs(net) < 100.0)
      f = MathTanh(net);
    else
      f = MathSign(net);

    df = 1 - CMath::Sqr(f);
    d2f = -(2 * f * df);

    return;
  }

  if (k == 3) {

    if (net >= 0.0) {

      net2 = net * net;
      arg = net2 + 1;
      root = MathSqrt(arg);
      f = net + root;
      r = net / root;
      df = 1 + r;
      d2f = (root - net * r) / arg;
    } else {

      f = MathExp(net);
      df = f;
      d2f = f;
    }

    return;
  }

  if (k == 2) {

    f = MathExp(-CMath::Sqr(net));
    df = -(2 * net * f);
    d2f = -(2 * (f + df * net));

    return;
  }

  f = 0;
  df = 0;
  d2f = 0;
}

static void CMLPBase::MLPProcess(CMultilayerPerceptron &network, double &x[],
                                 double &y[]) {

  if (CAp::Len(y) < network.m_structinfo[2])
    ArrayResizeAL(y, network.m_structinfo[2]);

  MLPInternalProcessVector(network.m_structinfo, network.m_weights,
                           network.m_columnmeans, network.m_columnsigmas,
                           network.m_neurons, network.m_dfdnet, x, y);
}

static void CMLPBase::MLPProcessI(CMultilayerPerceptron &network, double &x[],
                                  double &y[]) {

  MLPProcess(network, x, y);
}

static double CMLPBase::MLPError(CMultilayerPerceptron &network,
                                 CMatrixDouble &xy, const int ssize) {

  double result = 0;
  int i = 0;
  int k = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  double e = 0;
  int i_ = 0;
  int i1_ = 0;

  MLPProperties(network, nin, nout, wcount);

  for (i = 0; i <= ssize - 1; i++) {
    for (i_ = 0; i_ <= nin - 1; i_++)
      network.m_x[i_] = xy[i][i_];

    MLPProcess(network, network.m_x, network.m_y);

    if (MLPIsSoftMax(network)) {

      k = (int)MathRound(xy[i][nin]);

      if (k >= 0 && k < nout)
        network.m_y[k] = network.m_y[k] - 1;
    } else {

      i1_ = nin;
      for (i_ = 0; i_ <= nout - 1; i_++)
        network.m_y[i_] = network.m_y[i_] - xy[i][i_ + i1_];
    }

    e = 0.0;
    for (i_ = 0; i_ <= nout - 1; i_++)
      e += network.m_y[i_] * network.m_y[i_];
    result = result + e / 2;
  }

  return (result);
}

static double CMLPBase::MLPErrorN(CMultilayerPerceptron &network,
                                  CMatrixDouble &xy, const int ssize) {

  double result = 0;
  int i = 0;
  int k = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  double e = 0;
  int i_ = 0;
  int i1_ = 0;

  MLPProperties(network, nin, nout, wcount);

  for (i = 0; i <= ssize - 1; i++) {

    for (i_ = 0; i_ <= nin - 1; i_++)
      network.m_x[i_] = xy[i][i_];

    MLPProcess(network, network.m_x, network.m_y);

    if (network.m_structinfo[6] == 0) {

      i1_ = nin;
      for (i_ = 0; i_ <= nout - 1; i_++)
        network.m_y[i_] = network.m_y[i_] - xy[i][i_ + i1_];

      e = 0.0;
      for (i_ = 0; i_ <= nout - 1; i_++)
        e += network.m_y[i_] * network.m_y[i_];
      result = result + e / 2;
    } else {

      k = (int)MathRound(xy[i][nin]);

      if (k >= 0 && k < nout)
        result = result + SafeCrossEntropy(1, network.m_y[k]);
    }
  }

  return (result);
}

static int CMLPBase::MLPClsError(CMultilayerPerceptron &network,
                                 CMatrixDouble &xy, const int ssize) {

  int result = 0;
  int i = 0;
  int j = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  int nn = 0;
  int ns = 0;
  int nmax = 0;
  int i_ = 0;

  double workx[];
  double worky[];

  MLPProperties(network, nin, nout, wcount);

  ArrayResizeAL(workx, nin);
  ArrayResizeAL(worky, nout);

  for (i = 0; i <= ssize - 1; i++) {

    for (i_ = 0; i_ <= nin - 1; i_++)
      workx[i_] = xy[i][i_];

    MLPProcess(network, workx, worky);

    nmax = 0;
    for (j = 0; j <= nout - 1; j++) {

      if (worky[j] > worky[nmax])
        nmax = j;
    }
    nn = nmax;

    if (MLPIsSoftMax(network))
      ns = (int)MathRound(xy[i][nin]);
    else {
      nmax = 0;
      for (j = 0; j <= nout - 1; j++) {

        if (xy[i][nin + j] > xy[i][nin + nmax])
          nmax = j;
      }
      ns = nmax;
    }

    if (nn != ns)
      result = result + 1;
  }

  return (result);
}

static double CMLPBase::MLPRelClsError(CMultilayerPerceptron &network,
                                       CMatrixDouble &xy, const int npoints) {

  return ((double)MLPClsError(network, xy, npoints) / (double)npoints);
}

static double CMLPBase::MLPAvgCE(CMultilayerPerceptron &network,
                                 CMatrixDouble &xy, const int npoints) {

  double result = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;

  if (MLPIsSoftMax(network)) {

    MLPProperties(network, nin, nout, wcount);

    result = MLPErrorN(network, xy, npoints) / (npoints * MathLog(2));
  } else
    result = 0;

  return (result);
}

static double CMLPBase::MLPRMSError(CMultilayerPerceptron &network,
                                    CMatrixDouble &xy, const int npoints) {

  int nin = 0;
  int nout = 0;
  int wcount = 0;

  MLPProperties(network, nin, nout, wcount);

  return (MathSqrt(2 * MLPError(network, xy, npoints) / (npoints * nout)));
}

static double CMLPBase::MLPAvgError(CMultilayerPerceptron &network,
                                    CMatrixDouble &xy, const int npoints) {

  double result = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  int i_ = 0;

  MLPProperties(network, nin, nout, wcount);

  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= nin - 1; i_++)
      network.m_x[i_] = xy[i][i_];

    MLPProcess(network, network.m_x, network.m_y);

    if (MLPIsSoftMax(network)) {

      k = (int)MathRound(xy[i][nin]);
      for (j = 0; j <= nout - 1; j++) {

        if (j == k)
          result = result + MathAbs(1 - network.m_y[j]);
        else
          result = result + MathAbs(network.m_y[j]);
      }
    } else {

      for (j = 0; j <= nout - 1; j++)
        result = result + MathAbs(xy[i][nin + j] - network.m_y[j]);
    }
  }

  return (result / (npoints * nout));
}

static double CMLPBase::MLPAvgRelError(CMultilayerPerceptron &network,
                                       CMatrixDouble &xy, const int npoints) {

  double result = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int lk = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  int i_ = 0;

  MLPProperties(network, nin, nout, wcount);

  result = 0;
  k = 0;

  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= nin - 1; i_++)
      network.m_x[i_] = xy[i][i_];

    MLPProcess(network, network.m_x, network.m_y);

    if (MLPIsSoftMax(network)) {

      lk = (int)MathRound(xy[i][nin]);
      for (j = 0; j <= nout - 1; j++) {

        if (j == lk) {
          result = result + MathAbs(1 - network.m_y[j]);
          k = k + 1;
        }
      }
    } else {

      for (j = 0; j <= nout - 1; j++) {

        if (xy[i][nin + j] != 0.0) {
          result = result + MathAbs(xy[i][nin + j] - network.m_y[j]) /
                                MathAbs(xy[i][nin + j]);
          k = k + 1;
        }
      }
    }
  }

  if (k != 0)
    result = result / k;

  return (result);
}

static void CMLPBase::MLPGrad(CMultilayerPerceptron &network, double &x[],
                              double &desiredy[], double &e, double &grad[]) {

  int i = 0;
  int nout = 0;
  int ntotal = 0;

  if (CAp::Len(grad) < network.m_structinfo[4])
    ArrayResizeAL(grad, network.m_structinfo[4]);

  MLPProcess(network, x, network.m_y);

  nout = network.m_structinfo[2];
  ntotal = network.m_structinfo[3];
  e = 0;

  for (i = 0; i <= ntotal - 1; i++)
    network.m_derror[i] = 0;
  for (i = 0; i <= nout - 1; i++) {
    network.m_derror[ntotal - nout + i] = network.m_y[i] - desiredy[i];
    e = e + CMath::Sqr(network.m_y[i] - desiredy[i]) / 2;
  }

  MLPInternalCalculateGradient(network, network.m_neurons, network.m_weights,
                               network.m_derror, grad, false);
}

static void CMLPBase::MLPGradN(CMultilayerPerceptron &network, double &x[],
                               double &desiredy[], double &e, double &grad[]) {

  double s = 0;
  int i = 0;
  int nout = 0;
  int ntotal = 0;

  e = 0;

  if (CAp::Len(grad) < network.m_structinfo[4])
    ArrayResizeAL(grad, network.m_structinfo[4]);

  MLPProcess(network, x, network.m_y);

  nout = network.m_structinfo[2];
  ntotal = network.m_structinfo[3];
  for (i = 0; i <= ntotal - 1; i++)
    network.m_derror[i] = 0;
  e = 0;

  if (network.m_structinfo[6] == 0) {

    for (i = 0; i <= nout - 1; i++) {
      network.m_derror[ntotal - nout + i] = network.m_y[i] - desiredy[i];
      e = e + CMath::Sqr(network.m_y[i] - desiredy[i]) / 2;
    }
  } else {

    s = 0;
    for (i = 0; i <= nout - 1; i++)
      s = s + desiredy[i];
    for (i = 0; i <= nout - 1; i++) {
      network.m_derror[ntotal - nout + i] = s * network.m_y[i] - desiredy[i];
      e = e + SafeCrossEntropy(desiredy[i], network.m_y[i]);
    }
  }

  MLPInternalCalculateGradient(network, network.m_neurons, network.m_weights,
                               network.m_derror, grad, true);
}

static void CMLPBase::MLPGradBatch(CMultilayerPerceptron &network,
                                   CMatrixDouble &xy, const int ssize,
                                   double &e, double &grad[]) {

  int i = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;

  MLPProperties(network, nin, nout, wcount);

  for (i = 0; i <= wcount - 1; i++)
    grad[i] = 0;
  e = 0;
  i = 0;

  while (i <= ssize - 1) {
    MLPChunkedGradient(network, xy, i, MathMin(ssize, i + m_chunksize) - i, e,
                       grad, false);
    i = i + m_chunksize;
  }
}

static void CMLPBase::MLPGradNBatch(CMultilayerPerceptron &network,
                                    CMatrixDouble &xy, const int ssize,
                                    double &e, double &grad[]) {

  int i = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;

  MLPProperties(network, nin, nout, wcount);

  for (i = 0; i <= wcount - 1; i++)
    grad[i] = 0;
  e = 0;
  i = 0;

  while (i <= ssize - 1) {
    MLPChunkedGradient(network, xy, i, MathMin(ssize, i + m_chunksize) - i, e,
                       grad, true);
    i = i + m_chunksize;
  }
}

static void CMLPBase::MLPHessianNBatch(CMultilayerPerceptron &network,
                                       CMatrixDouble &xy, const int ssize,
                                       double &e, double &grad[],
                                       CMatrixDouble &h) {

  e = 0;

  MLPHessianBatchInternal(network, xy, ssize, true, e, grad, h);
}

static void CMLPBase::MLPHessianBatch(CMultilayerPerceptron &network,
                                      CMatrixDouble &xy, const int ssize,
                                      double &e, double &grad[],
                                      CMatrixDouble &h) {

  e = 0;

  MLPHessianBatchInternal(network, xy, ssize, false, e, grad, h);
}

static void CMLPBase::MLPInternalProcessVector(
    int &structinfo[], double &weights[], double &columnmeans[],
    double &columnsigmas[], double &neurons[], double &dfdnet[], double &x[],
    double &y[]) {

  int i = 0;
  int n1 = 0;
  int n2 = 0;
  int w1 = 0;
  int w2 = 0;
  int ntotal = 0;
  int nin = 0;
  int nout = 0;
  int istart = 0;
  int offs = 0;
  double net = 0;
  double f = 0;
  double df = 0;
  double d2f = 0;
  double mx = 0;
  bool perr;
  int i_ = 0;
  int i1_ = 0;

  nin = structinfo[1];
  nout = structinfo[2];
  ntotal = structinfo[3];
  istart = structinfo[5];

  for (i = 0; i <= nin - 1; i++) {

    if (columnsigmas[i] != 0.0)
      neurons[i] = (x[i] - columnmeans[i]) / columnsigmas[i];
    else
      neurons[i] = x[i] - columnmeans[i];
  }

  for (i = 0; i <= ntotal - 1; i++) {
    offs = istart + i * m_nfieldwidth;

    if (structinfo[offs + 0] > 0 || structinfo[offs + 0] == -5) {

      MLPActivationFunction(neurons[structinfo[offs + 2]], structinfo[offs + 0],
                            f, df, d2f);

      neurons[i] = f;
      dfdnet[i] = df;
      continue;
    }

    if (structinfo[offs + 0] == 0) {

      n1 = structinfo[offs + 2];
      n2 = n1 + structinfo[offs + 1] - 1;
      w1 = structinfo[offs + 3];
      w2 = w1 + structinfo[offs + 1] - 1;
      i1_ = (n1) - (w1);
      net = 0.0;

      for (i_ = w1; i_ <= w2; i_++)
        net += weights[i_] * neurons[i_ + i1_];
      neurons[i] = net;
      dfdnet[i] = 1.0;
      continue;
    }

    if (structinfo[offs + 0] < 0) {
      perr = true;

      if (structinfo[offs + 0] == -2) {

        perr = false;
      }

      if (structinfo[offs + 0] == -3) {

        neurons[i] = -1;
        perr = false;
      }

      if (structinfo[offs + 0] == -4) {

        neurons[i] = 0;
        perr = false;
      }

      if (!CAp::Assert(!perr, __FUNCTION__ +
                                  ": internal error - unknown neuron type!"))
        return;
      continue;
    }
  }

  i1_ = ntotal - nout;
  for (i_ = 0; i_ <= nout - 1; i_++)
    y[i_] = neurons[i_ + i1_];

  if (!CAp::Assert(structinfo[6] == 0 || structinfo[6] == 1,
                   __FUNCTION__ + ": unknown normalization type!"))
    return;

  if (structinfo[6] == 1) {

    mx = y[0];
    for (i = 1; i <= nout - 1; i++)
      mx = MathMax(mx, y[i]);

    net = 0;
    for (i = 0; i <= nout - 1; i++) {
      y[i] = MathExp(y[i] - mx);
      net = net + y[i];
    }
    for (i = 0; i <= nout - 1; i++)
      y[i] = y[i] / net;
  } else {

    for (i = 0; i <= nout - 1; i++)
      y[i] = y[i] * columnsigmas[nin + i] + columnmeans[nin + i];
  }
}

static void CMLPBase::MLPAlloc(CSerializer &s, CMultilayerPerceptron &network) {

  int i = 0;
  int j = 0;
  int k = 0;
  int fkind = 0;
  double threshold = 0;
  double v0 = 0;
  double v1 = 0;
  int nin = 0;
  int nout = 0;

  nin = network.m_hllayersizes[0];
  nout = network.m_hllayersizes[CAp::Len(network.m_hllayersizes) - 1];

  s.Alloc_Entry();
  s.Alloc_Entry();
  s.Alloc_Entry();

  CApServ::AllocIntegerArray(s, network.m_hllayersizes, -1);
  for (i = 1; i <= CAp::Len(network.m_hllayersizes) - 1; i++) {
    for (j = 0; j <= network.m_hllayersizes[i] - 1; j++) {

      MLPGetNeuronInfo(network, i, j, fkind, threshold);

      s.Alloc_Entry();
      s.Alloc_Entry();
      for (k = 0; k <= network.m_hllayersizes[i - 1] - 1; k++)
        s.Alloc_Entry();
    }
  }
  for (j = 0; j <= nin - 1; j++) {

    MLPGetInputScaling(network, j, v0, v1);

    s.Alloc_Entry();
    s.Alloc_Entry();
  }
  for (j = 0; j <= nout - 1; j++) {

    MLPGetOutputScaling(network, j, v0, v1);

    s.Alloc_Entry();
    s.Alloc_Entry();
  }
}

static void CMLPBase::MLPSerialize(CSerializer &s,
                                   CMultilayerPerceptron &network) {

  int i = 0;
  int j = 0;
  int k = 0;
  int fkind = 0;
  double threshold = 0;
  double v0 = 0;
  double v1 = 0;
  int nin = 0;
  int nout = 0;

  nin = network.m_hllayersizes[0];
  nout = network.m_hllayersizes[CAp::Len(network.m_hllayersizes) - 1];

  s.Serialize_Int(CSCodes::GetMLPSerializationCode());
  s.Serialize_Int(m_mlpfirstversion);
  s.Serialize_Bool(MLPIsSoftMax(network));

  CApServ::SerializeIntegerArray(s, network.m_hllayersizes, -1);
  for (i = 1; i <= CAp::Len(network.m_hllayersizes) - 1; i++) {
    for (j = 0; j <= network.m_hllayersizes[i] - 1; j++) {

      MLPGetNeuronInfo(network, i, j, fkind, threshold);

      s.Serialize_Int(fkind);
      s.Serialize_Double(threshold);
      for (k = 0; k <= network.m_hllayersizes[i - 1] - 1; k++)
        s.Serialize_Double(MLPGetWeight(network, i - 1, k, i, j));
    }
  }
  for (j = 0; j <= nin - 1; j++) {

    MLPGetInputScaling(network, j, v0, v1);

    s.Serialize_Double(v0);
    s.Serialize_Double(v1);
  }
  for (j = 0; j <= nout - 1; j++) {

    MLPGetOutputScaling(network, j, v0, v1);

    s.Serialize_Double(v0);
    s.Serialize_Double(v1);
  }
}

static void CMLPBase::MLPUnserialize(CSerializer &s,
                                     CMultilayerPerceptron &network) {

  int i0 = 0;
  int i1 = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int fkind = 0;
  double threshold = 0;
  double v0 = 0;
  double v1 = 0;
  int nin = 0;
  int nout = 0;
  bool issoftmax;

  int layersizes[];

  i0 = s.Unserialize_Int();

  if (!CAp::Assert(i0 == CSCodes::GetMLPSerializationCode(),
                   __FUNCTION__ + ": stream header corrupted"))
    return;

  i1 = s.Unserialize_Int();

  if (!CAp::Assert(i1 == m_mlpfirstversion,
                   __FUNCTION__ + ": stream header corrupted"))
    return;

  issoftmax = s.Unserialize_Bool();

  CApServ::UnserializeIntegerArray(s, layersizes);

  if (!CAp::Assert((CAp::Len(layersizes) == 2 || CAp::Len(layersizes) == 3) ||
                       CAp::Len(layersizes) == 4,
                   __FUNCTION__ + ": too many hidden layers!"))
    return;

  nin = layersizes[0];
  nout = layersizes[CAp::Len(layersizes) - 1];

  if (CAp::Len(layersizes) == 2) {

    if (issoftmax)
      MLPCreateC0(layersizes[0], layersizes[1], network);
    else
      MLPCreate0(layersizes[0], layersizes[1], network);
  }

  if (CAp::Len(layersizes) == 3) {

    if (issoftmax)
      MLPCreateC1(layersizes[0], layersizes[1], layersizes[2], network);
    else
      MLPCreate1(layersizes[0], layersizes[1], layersizes[2], network);
  }

  if (CAp::Len(layersizes) == 4) {

    if (issoftmax)
      MLPCreateC2(layersizes[0], layersizes[1], layersizes[2], layersizes[3],
                  network);
    else
      MLPCreate2(layersizes[0], layersizes[1], layersizes[2], layersizes[3],
                 network);
  }

  for (i = 1; i <= CAp::Len(layersizes) - 1; i++) {
    for (j = 0; j <= layersizes[i] - 1; j++) {

      fkind = s.Unserialize_Int();
      threshold = s.Unserialize_Double();

      MLPSetNeuronInfo(network, i, j, fkind, threshold);

      for (k = 0; k <= layersizes[i - 1] - 1; k++) {
        v0 = s.Unserialize_Double();

        MLPSetWeight(network, i - 1, k, i, j, v0);
      }
    }
  }

  for (j = 0; j <= nin - 1; j++) {

    v0 = s.Unserialize_Double();
    v1 = s.Unserialize_Double();

    MLPSetInputScaling(network, j, v0, v1);
  }
  for (j = 0; j <= nout - 1; j++) {

    v0 = s.Unserialize_Double();
    v1 = s.Unserialize_Double();

    MLPSetOutputScaling(network, j, v0, v1);
  }
}

static void CMLPBase::AddInputLayer(const int ncount, int &lsizes[],
                                    int &ltypes[], int &lconnfirst[],
                                    int &lconnlast[], int &lastproc) {

  lsizes[0] = ncount;
  ltypes[0] = -2;
  lconnfirst[0] = 0;
  lconnlast[0] = 0;
  lastproc = 0;
}

static void CMLPBase::AddBiasedSummatorLayer(const int ncount, int &lsizes[],
                                             int &ltypes[], int &lconnfirst[],
                                             int &lconnlast[], int &lastproc) {

  lsizes[lastproc + 1] = 1;
  ltypes[lastproc + 1] = -3;
  lconnfirst[lastproc + 1] = 0;
  lconnlast[lastproc + 1] = 0;
  lsizes[lastproc + 2] = ncount;
  ltypes[lastproc + 2] = 0;
  lconnfirst[lastproc + 2] = lastproc;
  lconnlast[lastproc + 2] = lastproc + 1;
  lastproc = lastproc + 2;
}

static void CMLPBase::AddActivationLayer(const int functype, int &lsizes[],
                                         int &ltypes[], int &lconnfirst[],
                                         int &lconnlast[], int &lastproc) {

  if (!CAp::Assert(functype > 0 || functype == -5,
                   __FUNCTION__ + ": incorrect function type"))
    return;

  lsizes[lastproc + 1] = lsizes[lastproc];
  ltypes[lastproc + 1] = functype;
  lconnfirst[lastproc + 1] = lastproc;
  lconnlast[lastproc + 1] = lastproc;
  lastproc = lastproc + 1;
}

static void CMLPBase::AddZeroLayer(int &lsizes[], int &ltypes[],
                                   int &lconnfirst[], int &lconnlast[],
                                   int &lastproc) {

  lsizes[lastproc + 1] = 1;
  ltypes[lastproc + 1] = -4;
  lconnfirst[lastproc + 1] = 0;
  lconnlast[lastproc + 1] = 0;
  lastproc = lastproc + 1;
}

static void CMLPBase::HLAddInputLayer(CMultilayerPerceptron &network,
                                      int &connidx, int &neuroidx,
                                      int &structinfoidx, int nin) {

  int i = 0;
  int offs = 0;

  offs = m_hlm_nfieldwidth * neuroidx;

  for (i = 0; i <= nin - 1; i++) {
    network.m_hlneurons[offs + 0] = 0;
    network.m_hlneurons[offs + 1] = i;
    network.m_hlneurons[offs + 2] = -1;
    network.m_hlneurons[offs + 3] = -1;
    offs = offs + m_hlm_nfieldwidth;
  }

  neuroidx = neuroidx + nin;
  structinfoidx = structinfoidx + nin;
}

static void CMLPBase::HLAddOutputLayer(CMultilayerPerceptron &network,
                                       int &connidx, int &neuroidx,
                                       int &structinfoidx, int &weightsidx,
                                       const int k, const int nprev,
                                       const int nout, const bool iscls,
                                       const bool islinearout) {

  int i = 0;
  int j = 0;
  int neurooffs = 0;
  int connoffs = 0;

  if (!CAp::Assert((iscls && islinearout) || !iscls,
                   __FUNCTION__ + ": internal error"))
    return;

  neurooffs = m_hlm_nfieldwidth * neuroidx;
  connoffs = m_hlconm_nfieldwidth * connidx;

  if (!iscls) {

    for (i = 0; i <= nout - 1; i++) {

      network.m_hlneurons[neurooffs + 0] = k;
      network.m_hlneurons[neurooffs + 1] = i;
      network.m_hlneurons[neurooffs + 2] = structinfoidx + 1 + nout + i;
      network.m_hlneurons[neurooffs + 3] = weightsidx + nprev + (nprev + 1) * i;
      neurooffs = neurooffs + m_hlm_nfieldwidth;
    }
    for (i = 0; i <= nprev - 1; i++) {
      for (j = 0; j <= nout - 1; j++) {

        network.m_hlconnections[connoffs + 0] = k - 1;
        network.m_hlconnections[connoffs + 1] = i;
        network.m_hlconnections[connoffs + 2] = k;
        network.m_hlconnections[connoffs + 3] = j;
        network.m_hlconnections[connoffs + 4] =
            weightsidx + i + j * (nprev + 1);
        connoffs = connoffs + m_hlconm_nfieldwidth;
      }
    }

    connidx = connidx + nprev * nout;
    neuroidx = neuroidx + nout;
    structinfoidx = structinfoidx + 2 * nout + 1;
    weightsidx = weightsidx + nout * (nprev + 1);
  } else {

    for (i = 0; i <= nout - 2; i++) {

      network.m_hlneurons[neurooffs + 0] = k;
      network.m_hlneurons[neurooffs + 1] = i;
      network.m_hlneurons[neurooffs + 2] = -1;
      network.m_hlneurons[neurooffs + 3] = weightsidx + nprev + (nprev + 1) * i;
      neurooffs = neurooffs + m_hlm_nfieldwidth;
    }

    network.m_hlneurons[neurooffs + 0] = k;
    network.m_hlneurons[neurooffs + 1] = i;
    network.m_hlneurons[neurooffs + 2] = -1;
    network.m_hlneurons[neurooffs + 3] = -1;
    for (i = 0; i <= nprev - 1; i++) {
      for (j = 0; j <= nout - 2; j++) {

        network.m_hlconnections[connoffs + 0] = k - 1;
        network.m_hlconnections[connoffs + 1] = i;
        network.m_hlconnections[connoffs + 2] = k;
        network.m_hlconnections[connoffs + 3] = j;
        network.m_hlconnections[connoffs + 4] =
            weightsidx + i + j * (nprev + 1);
        connoffs = connoffs + m_hlconm_nfieldwidth;
      }
    }

    connidx = connidx + nprev * (nout - 1);
    neuroidx = neuroidx + nout;
    structinfoidx = structinfoidx + nout + 2;
    weightsidx = weightsidx + (nout - 1) * (nprev + 1);
  }
}

static void CMLPBase::HLAddHiddenLayer(CMultilayerPerceptron &network,
                                       int &connidx, int &neuroidx,
                                       int &structinfoidx, int &weightsidx,
                                       const int k, const int nprev,
                                       const int ncur) {

  int i = 0;
  int j = 0;
  int neurooffs = 0;
  int connoffs = 0;

  neurooffs = m_hlm_nfieldwidth * neuroidx;
  connoffs = m_hlconm_nfieldwidth * connidx;
  for (i = 0; i <= ncur - 1; i++) {

    network.m_hlneurons[neurooffs + 0] = k;
    network.m_hlneurons[neurooffs + 1] = i;
    network.m_hlneurons[neurooffs + 2] = structinfoidx + 1 + ncur + i;
    network.m_hlneurons[neurooffs + 3] = weightsidx + nprev + (nprev + 1) * i;
    neurooffs = neurooffs + m_hlm_nfieldwidth;
  }
  for (i = 0; i <= nprev - 1; i++) {
    for (j = 0; j <= ncur - 1; j++) {

      network.m_hlconnections[connoffs + 0] = k - 1;
      network.m_hlconnections[connoffs + 1] = i;
      network.m_hlconnections[connoffs + 2] = k;
      network.m_hlconnections[connoffs + 3] = j;
      network.m_hlconnections[connoffs + 4] = weightsidx + i + j * (nprev + 1);
      connoffs = connoffs + m_hlconm_nfieldwidth;
    }
  }

  connidx = connidx + nprev * ncur;
  neuroidx = neuroidx + ncur;
  structinfoidx = structinfoidx + 2 * ncur + 1;
  weightsidx = weightsidx + ncur * (nprev + 1);
}

static void CMLPBase::FillHighLevelInformation(CMultilayerPerceptron &network,
                                               const int nin, const int nhid1,
                                               const int nhid2, const int nout,
                                               const bool iscls,
                                               const bool islinearout) {

  int idxweights = 0;
  int idxstruct = 0;
  int idxneuro = 0;
  int idxconn = 0;

  if (!CAp::Assert((iscls && islinearout) || !iscls,
                   __FUNCTION__ + ": internal error"))
    return;

  idxweights = 0;
  idxneuro = 0;
  idxstruct = 0;
  idxconn = 0;
  network.m_hlnetworktype = 0;

  if (nhid1 == 0) {

    ArrayResizeAL(network.m_hllayersizes, 2);

    network.m_hllayersizes[0] = nin;
    network.m_hllayersizes[1] = nout;

    if (!iscls) {

      ArrayResizeAL(network.m_hlconnections, m_hlconm_nfieldwidth * nin * nout);
      ArrayResizeAL(network.m_hlneurons, m_hlm_nfieldwidth * (nin + nout));
      network.m_hlnormtype = 0;
    } else {

      ArrayResizeAL(network.m_hlconnections,
                    m_hlconm_nfieldwidth * nin * (nout - 1));
      ArrayResizeAL(network.m_hlneurons, m_hlm_nfieldwidth * (nin + nout));
      network.m_hlnormtype = 1;
    }

    HLAddInputLayer(network, idxconn, idxneuro, idxstruct, nin);

    HLAddOutputLayer(network, idxconn, idxneuro, idxstruct, idxweights, 1, nin,
                     nout, iscls, islinearout);

    return;
  }

  if (nhid2 == 0) {

    ArrayResizeAL(network.m_hllayersizes, 3);

    network.m_hllayersizes[0] = nin;
    network.m_hllayersizes[1] = nhid1;
    network.m_hllayersizes[2] = nout;

    if (!iscls) {

      ArrayResizeAL(network.m_hlconnections,
                    m_hlconm_nfieldwidth * (nin * nhid1 + nhid1 * nout));
      ArrayResizeAL(network.m_hlneurons,
                    m_hlm_nfieldwidth * (nin + nhid1 + nout));
      network.m_hlnormtype = 0;
    } else {

      ArrayResizeAL(network.m_hlconnections,
                    m_hlconm_nfieldwidth * (nin * nhid1 + nhid1 * (nout - 1)));
      ArrayResizeAL(network.m_hlneurons,
                    m_hlm_nfieldwidth * (nin + nhid1 + nout));
      network.m_hlnormtype = 1;
    }

    HLAddInputLayer(network, idxconn, idxneuro, idxstruct, nin);

    HLAddHiddenLayer(network, idxconn, idxneuro, idxstruct, idxweights, 1, nin,
                     nhid1);

    HLAddOutputLayer(network, idxconn, idxneuro, idxstruct, idxweights, 2,
                     nhid1, nout, iscls, islinearout);

    return;
  }

  ArrayResizeAL(network.m_hllayersizes, 4);

  network.m_hllayersizes[0] = nin;
  network.m_hllayersizes[1] = nhid1;
  network.m_hllayersizes[2] = nhid2;
  network.m_hllayersizes[3] = nout;

  if (!iscls) {

    ArrayResizeAL(network.m_hlconnections,
                  m_hlconm_nfieldwidth *
                      (nin * nhid1 + nhid1 * nhid2 + nhid2 * nout));
    ArrayResizeAL(network.m_hlneurons,
                  m_hlm_nfieldwidth * (nin + nhid1 + nhid2 + nout));
    network.m_hlnormtype = 0;
  } else {

    ArrayResizeAL(network.m_hlconnections,
                  m_hlconm_nfieldwidth *
                      (nin * nhid1 + nhid1 * nhid2 + nhid2 * (nout - 1)));
    ArrayResizeAL(network.m_hlneurons,
                  m_hlm_nfieldwidth * (nin + nhid1 + nhid2 + nout));
    network.m_hlnormtype = 1;
  }

  HLAddInputLayer(network, idxconn, idxneuro, idxstruct, nin);

  HLAddHiddenLayer(network, idxconn, idxneuro, idxstruct, idxweights, 1, nin,
                   nhid1);

  HLAddHiddenLayer(network, idxconn, idxneuro, idxstruct, idxweights, 2, nhid1,
                   nhid2);

  HLAddOutputLayer(network, idxconn, idxneuro, idxstruct, idxweights, 3, nhid2,
                   nout, iscls, islinearout);
}

static void CMLPBase::MLPCreate(const int nin, const int nout, int &lsizes[],
                                int &ltypes[], int &lconnfirst[],
                                int &lconnlast[], const int layerscount,
                                const bool isclsnet,
                                CMultilayerPerceptron &network) {

  int i = 0;
  int j = 0;
  int ssize = 0;
  int ntotal = 0;
  int wcount = 0;
  int offs = 0;
  int nprocessed = 0;
  int wallocated = 0;

  int localtemp[];
  int lnfirst[];
  int lnsyn[];

  if (!CAp::Assert(layerscount > 0, __FUNCTION__ + ": wrong parameters!"))
    return;

  if (!CAp::Assert(ltypes[0] == -2,
                   __FUNCTION__ + ": wrong LTypes[0] (must be -2)!"))
    return;
  for (i = 0; i <= layerscount - 1; i++) {

    if (!CAp::Assert(lsizes[i] > 0, __FUNCTION__ + ": wrong LSizes!"))
      return;

    if (!CAp::Assert(lconnfirst[i] >= 0 && (lconnfirst[i] < i || i == 0),
                     __FUNCTION__ + ": wrong LConnFirst!"))
      return;

    if (!CAp::Assert(lconnlast[i] >= lconnfirst[i] &&
                         (lconnlast[i] < i || i == 0),
                     __FUNCTION__ + ": wrong LConnLast!"))
      return;
  }

  ArrayResizeAL(lnfirst, layerscount);
  ArrayResizeAL(lnsyn, layerscount);

  ntotal = 0;
  wcount = 0;

  for (i = 0; i <= layerscount - 1; i++) {

    lnsyn[i] = -1;

    if (ltypes[i] >= 0 || ltypes[i] == -5) {
      lnsyn[i] = 0;
      for (j = lconnfirst[i]; j <= lconnlast[i]; j++)
        lnsyn[i] = lnsyn[i] + lsizes[j];
    } else {

      if ((ltypes[i] == -2 || ltypes[i] == -3) || ltypes[i] == -4)
        lnsyn[i] = 0;
    }

    if (!CAp::Assert(lnsyn[i] >= 0, __FUNCTION__ + ": internal error #0!"))
      return;

    lnfirst[i] = ntotal;
    ntotal = ntotal + lsizes[i];

    if (ltypes[i] == 0)
      wcount = wcount + lnsyn[i] * lsizes[i];
  }
  ssize = 7 + ntotal * m_nfieldwidth;

  ArrayResizeAL(network.m_structinfo, ssize);
  ArrayResizeAL(network.m_weights, wcount);

  if (isclsnet) {

    ArrayResizeAL(network.m_columnmeans, nin);
    ArrayResizeAL(network.m_columnsigmas, nin);
  } else {

    ArrayResizeAL(network.m_columnmeans, nin + nout);
    ArrayResizeAL(network.m_columnsigmas, nin + nout);
  }

  ArrayResizeAL(network.m_neurons, ntotal);
  network.m_chunks.Resize(3 * ntotal + 1, m_chunksize);
  ArrayResizeAL(network.m_nwbuf, MathMax(wcount, 2 * nout));
  ArrayResizeAL(network.m_integerbuf, 4);
  ArrayResizeAL(network.m_dfdnet, ntotal);
  ArrayResizeAL(network.m_x, nin);
  ArrayResizeAL(network.m_y, nout);
  ArrayResizeAL(network.m_derror, ntotal);

  network.m_structinfo[0] = ssize;
  network.m_structinfo[1] = nin;
  network.m_structinfo[2] = nout;
  network.m_structinfo[3] = ntotal;
  network.m_structinfo[4] = wcount;
  network.m_structinfo[5] = 7;

  if (isclsnet)
    network.m_structinfo[6] = 1;
  else
    network.m_structinfo[6] = 0;

  nprocessed = 0;
  wallocated = 0;

  for (i = 0; i <= layerscount - 1; i++) {
    for (j = 0; j <= lsizes[i] - 1; j++) {
      offs = network.m_structinfo[5] + nprocessed * m_nfieldwidth;
      network.m_structinfo[offs + 0] = ltypes[i];

      if (ltypes[i] == 0) {

        network.m_structinfo[offs + 1] = lnsyn[i];
        network.m_structinfo[offs + 2] = lnfirst[lconnfirst[i]];
        network.m_structinfo[offs + 3] = wallocated;
        wallocated = wallocated + lnsyn[i];
        nprocessed = nprocessed + 1;
      }

      if (ltypes[i] > 0 || ltypes[i] == -5) {

        network.m_structinfo[offs + 1] = 1;
        network.m_structinfo[offs + 2] = lnfirst[lconnfirst[i]] + j;
        network.m_structinfo[offs + 3] = -1;
        nprocessed = nprocessed + 1;
      }

      if ((ltypes[i] == -2 || ltypes[i] == -3) || ltypes[i] == -4)
        nprocessed = nprocessed + 1;
    }
  }

  if (!CAp::Assert(wallocated == wcount, __FUNCTION__ + ": internal error #1!"))
    return;

  if (!CAp::Assert(nprocessed == ntotal, __FUNCTION__ + ": internal error #2!"))
    return;

  for (i = 0; i <= wcount - 1; i++)
    network.m_weights[i] = CMath::RandomReal() - 0.5;
  for (i = 0; i <= nin - 1; i++) {
    network.m_columnmeans[i] = 0;
    network.m_columnsigmas[i] = 1;
  }

  if (!isclsnet) {
    for (i = 0; i <= nout - 1; i++) {
      network.m_columnmeans[nin + i] = 0;
      network.m_columnsigmas[nin + i] = 1;
    }
  }
}

static void CMLPBase::MLPHessianBatchInternal(
    CMultilayerPerceptron &network, CMatrixDouble &xy, const int ssize,
    const bool naturalerr, double &e, double &grad[], CMatrixDouble &h) {

  int nin = 0;
  int nout = 0;
  int wcount = 0;
  int ntotal = 0;
  int istart = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int kl = 0;
  int offs = 0;
  int n1 = 0;
  int n2 = 0;
  int w1 = 0;
  int w2 = 0;
  double s = 0;
  double t = 0;
  double v = 0;
  double et = 0;
  bool bflag;
  double f = 0;
  double df = 0;
  double d2f = 0;
  double deidyj = 0;
  double mx = 0;
  double q = 0;
  double z = 0;
  double s2 = 0;
  double expi = 0;
  double expj = 0;
  int i_ = 0;
  int i1_ = 0;

  double x[];
  double desiredy[];
  double gt[];
  double zeros[];

  CMatrixDouble rx;
  CMatrixDouble ry;
  CMatrixDouble rdx;
  CMatrixDouble rdy;

  e = 0;

  MLPProperties(network, nin, nout, wcount);

  ntotal = network.m_structinfo[3];
  istart = network.m_structinfo[5];

  ArrayResizeAL(x, nin);
  ArrayResizeAL(desiredy, nout);
  ArrayResizeAL(zeros, wcount);
  ArrayResizeAL(gt, wcount);
  rx.Resize(ntotal + nout, wcount);
  ry.Resize(ntotal + nout, wcount);
  rdx.Resize(ntotal + nout, wcount);
  rdy.Resize(ntotal + nout, wcount);

  e = 0;
  for (i = 0; i <= wcount - 1; i++)
    zeros[i] = 0;
  for (i_ = 0; i_ <= wcount - 1; i_++)
    grad[i_] = zeros[i_];
  for (i = 0; i <= wcount - 1; i++) {
    for (i_ = 0; i_ <= wcount - 1; i_++)
      h[i].Set(i_, zeros[i_]);
  }

  for (k = 0; k <= ssize - 1; k++) {

    for (i_ = 0; i_ <= nin - 1; i_++)
      x[i_] = xy[k][i_];

    if (MLPIsSoftMax(network)) {

      kl = (int)MathRound(xy[k][nin]);
      for (i = 0; i <= nout - 1; i++) {

        if (i == kl)
          desiredy[i] = 1;
        else
          desiredy[i] = 0;
      }
    } else {

      i1_ = nin;
      for (i_ = 0; i_ <= nout - 1; i_++)
        desiredy[i_] = xy[k][i_ + i1_];
    }

    if (naturalerr)
      MLPGradN(network, x, desiredy, et, gt);
    else
      MLPGrad(network, x, desiredy, et, gt);

    e = e + et;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      grad[i_] = grad[i_] + gt[i_];

    for (i = 0; i <= ntotal - 1; i++) {
      offs = istart + i * m_nfieldwidth;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        rx[i].Set(i_, zeros[i_]);
      for (i_ = 0; i_ <= wcount - 1; i_++)
        ry[i].Set(i_, zeros[i_]);

      if (network.m_structinfo[offs + 0] > 0 ||
          network.m_structinfo[offs + 0] == -5) {

        n1 = network.m_structinfo[offs + 2];
        for (i_ = 0; i_ <= wcount - 1; i_++)
          rx[i].Set(i_, ry[n1][i_]);

        v = network.m_dfdnet[i];
        for (i_ = 0; i_ <= wcount - 1; i_++)
          ry[i].Set(i_, v * rx[i][i_]);
        continue;
      }

      if (network.m_structinfo[offs + 0] == 0) {

        n1 = network.m_structinfo[offs + 2];
        n2 = n1 + network.m_structinfo[offs + 1] - 1;
        w1 = network.m_structinfo[offs + 3];
        w2 = w1 + network.m_structinfo[offs + 1] - 1;

        for (j = n1; j <= n2; j++) {
          v = network.m_weights[w1 + j - n1];
          for (i_ = 0; i_ <= wcount - 1; i_++)
            rx[i].Set(i_, rx[i][i_] + v * ry[j][i_]);
          rx[i].Set(w1 + j - n1, rx[i][w1 + j - n1] + network.m_neurons[j]);
        }
        for (i_ = 0; i_ <= wcount - 1; i_++)
          ry[i].Set(i_, rx[i][i_]);
        continue;
      }

      if (network.m_structinfo[offs + 0] < 0) {
        bflag = true;

        if (network.m_structinfo[offs + 0] == -2) {

          bflag = false;
        }

        if (network.m_structinfo[offs + 0] == -3) {

          bflag = false;
        }

        if (network.m_structinfo[offs + 0] == -4) {

          bflag = false;
        }

        if (!CAp::Assert(!bflag, __FUNCTION__ +
                                     ": internal error - unknown neuron type!"))
          return;
        continue;
      }
    }

    for (i = 0; i <= ntotal + nout - 1; i++) {
      for (i_ = 0; i_ <= wcount - 1; i_++)
        rdy[i].Set(i_, zeros[i_]);
    }

    if (network.m_structinfo[6] == 0) {

      for (i = 0; i <= nout - 1; i++) {
        n1 = ntotal - nout + i;
        n2 = ntotal + i;

        for (i_ = 0; i_ <= wcount - 1; i_++)
          rx[n2].Set(i_, ry[n1][i_]);
        v = network.m_columnsigmas[nin + i];
        for (i_ = 0; i_ <= wcount - 1; i_++)
          ry[n2].Set(i_, v * rx[n2][i_]);

        for (i_ = 0; i_ <= wcount - 1; i_++)
          rdy[n2].Set(i_, ry[n2][i_]);

        df = network.m_columnsigmas[nin + i];
        for (i_ = 0; i_ <= wcount - 1; i_++)
          rdx[n2].Set(i_, df * rdy[n2][i_]);
        for (i_ = 0; i_ <= wcount - 1; i_++)
          rdy[n1].Set(i_, rdy[n1][i_] + rdx[n2][i_]);
      }
    } else {

      if (naturalerr) {

        t = 0;
        for (i = 0; i <= nout - 1; i++)
          t = t + desiredy[i];
        mx = network.m_neurons[ntotal - nout];

        for (i = 0; i <= nout - 1; i++)
          mx = MathMax(mx, network.m_neurons[ntotal - nout + i]);
        s = 0;
        for (i = 0; i <= nout - 1; i++) {
          network.m_nwbuf[i] =
              MathExp(network.m_neurons[ntotal - nout + i] - mx);
          s = s + network.m_nwbuf[i];
        }

        for (i = 0; i <= nout - 1; i++) {
          for (j = 0; j <= nout - 1; j++) {

            if (j == i) {
              deidyj = t * network.m_nwbuf[i] * (s - network.m_nwbuf[i]) /
                       CMath::Sqr(s);
              for (i_ = 0; i_ <= wcount - 1; i_++)
                rdy[ntotal - nout + i].Set(
                    i_, rdy[ntotal - nout + i][i_] +
                            deidyj * ry[ntotal - nout + i][i_]);
            } else {
              deidyj = -(t * network.m_nwbuf[i] * network.m_nwbuf[j] /
                         CMath::Sqr(s));
              for (i_ = 0; i_ <= wcount - 1; i_++)
                rdy[ntotal - nout + i].Set(
                    i_, rdy[ntotal - nout + i][i_] +
                            deidyj * ry[ntotal - nout + j][i_]);
            }
          }
        }
      } else {

        mx = network.m_neurons[ntotal - nout];
        for (i = 0; i <= nout - 1; i++)
          mx = MathMax(mx, network.m_neurons[ntotal - nout + i]);

        s = 0;
        s2 = 0;
        for (i = 0; i <= nout - 1; i++) {
          network.m_nwbuf[i] =
              MathExp(network.m_neurons[ntotal - nout + i] - mx);
          s = s + network.m_nwbuf[i];
          s2 = s2 + CMath::Sqr(network.m_nwbuf[i]);
        }

        q = 0;
        for (i = 0; i <= nout - 1; i++)
          q = q + (network.m_y[i] - desiredy[i]) * network.m_nwbuf[i];
        for (i = 0; i <= nout - 1; i++) {

          z = -q + (network.m_y[i] - desiredy[i]) * s;
          expi = network.m_nwbuf[i];
          for (j = 0; j <= nout - 1; j++) {
            expj = network.m_nwbuf[j];

            if (j == i)
              deidyj =
                  expi / CMath::Sqr(s) *
                  ((z + expi) * (s - 2 * expi) / s + expi * s2 / CMath::Sqr(s));
            else
              deidyj = expi * expj / CMath::Sqr(s) *
                       (s2 / CMath::Sqr(s) - 2 * z / s - (expi + expj) / s +
                        (network.m_y[i] - desiredy[i]) -
                        (network.m_y[j] - desiredy[j]));
            for (i_ = 0; i_ <= wcount - 1; i_++)
              rdy[ntotal - nout + i].Set(i_, rdy[ntotal - nout + i][i_] +
                                                 deidyj *
                                                     ry[ntotal - nout + j][i_]);
          }
        }
      }
    }

    for (i = ntotal - 1; i >= 0; i--) {

      offs = istart + i * m_nfieldwidth;

      if (network.m_structinfo[offs + 0] > 0 ||
          network.m_structinfo[offs + 0] == -5) {
        n1 = network.m_structinfo[offs + 2];

        MLPActivationFunction(network.m_neurons[n1],
                              network.m_structinfo[offs + 0], f, df, d2f);
        v = d2f * network.m_derror[i];
        for (i_ = 0; i_ <= wcount - 1; i_++)
          rdx[i].Set(i_, df * rdy[i][i_]);
        for (i_ = 0; i_ <= wcount - 1; i_++)
          rdx[i].Set(i_, rdx[i][i_] + v * rx[i][i_]);

        for (i_ = 0; i_ <= wcount - 1; i_++)
          rdy[n1].Set(i_, rdy[n1][i_] + rdx[i][i_]);
        continue;
      }

      if (network.m_structinfo[offs + 0] == 0) {

        n1 = network.m_structinfo[offs + 2];
        n2 = n1 + network.m_structinfo[offs + 1] - 1;
        w1 = network.m_structinfo[offs + 3];
        w2 = w1 + network.m_structinfo[offs + 1] - 1;

        for (i_ = 0; i_ <= wcount - 1; i_++)
          rdx[i].Set(i_, rdy[i][i_]);

        for (j = w1; j <= w2; j++) {
          v = network.m_neurons[n1 + j - w1];
          for (i_ = 0; i_ <= wcount - 1; i_++)
            h[j].Set(i_, h[j][i_] + v * rdx[i][i_]);

          v = network.m_derror[i];
          for (i_ = 0; i_ <= wcount - 1; i_++)
            h[j].Set(i_, h[j][i_] + v * ry[n1 + j - w1][i_]);
        }

        for (j = w1; j <= w2; j++) {
          v = network.m_weights[j];
          for (i_ = 0; i_ <= wcount - 1; i_++)
            rdy[n1 + j - w1].Set(i_, rdy[n1 + j - w1][i_] + v * rdx[i][i_]);
          rdy[n1 + j - w1].Set(j, rdy[n1 + j - w1][j] + network.m_derror[i]);
        }
        continue;
      }

      if (network.m_structinfo[offs + 0] < 0) {
        bflag = false;

        if ((network.m_structinfo[offs + 0] == -2 ||
             network.m_structinfo[offs + 0] == -3) ||
            network.m_structinfo[offs + 0] == -4) {

          bflag = true;
        }

        if (!CAp::Assert(bflag, __FUNCTION__ + ": unknown neuron type!"))
          return;
        continue;
      }
    }
  }
}

static void CMLPBase::MLPInternalCalculateGradient(
    CMultilayerPerceptron &network, double &neurons[], double &weights[],
    double &derror[], double &grad[], const bool naturalerrorfunc) {

  int i = 0;
  int n1 = 0;
  int n2 = 0;
  int w1 = 0;
  int w2 = 0;
  int ntotal = 0;
  int istart = 0;
  int nin = 0;
  int nout = 0;
  int offs = 0;
  double dedf = 0;
  double dfdnet = 0;
  double v = 0;
  double fown = 0;
  double deown = 0;
  double net = 0;
  double mx = 0;
  bool bflag;
  int i_ = 0;
  int i1_ = 0;

  nin = network.m_structinfo[1];
  nout = network.m_structinfo[2];
  ntotal = network.m_structinfo[3];
  istart = network.m_structinfo[5];

  if (!CAp::Assert(network.m_structinfo[6] == 0 || network.m_structinfo[6] == 1,
                   __FUNCTION__ + ": unknown normalization type!"))
    return;

  if (network.m_structinfo[6] == 1) {

    if (!naturalerrorfunc) {
      mx = network.m_neurons[ntotal - nout];
      for (i = 0; i <= nout - 1; i++)
        mx = MathMax(mx, network.m_neurons[ntotal - nout + i]);
      net = 0;
      for (i = 0; i <= nout - 1; i++) {
        network.m_nwbuf[i] = MathExp(network.m_neurons[ntotal - nout + i] - mx);
        net = net + network.m_nwbuf[i];
      }

      i1_ = -(ntotal - nout);
      v = 0.0;
      for (i_ = ntotal - nout; i_ <= ntotal - 1; i_++)
        v += network.m_derror[i_] * network.m_nwbuf[i_ + i1_];
      for (i = 0; i <= nout - 1; i++) {
        fown = network.m_nwbuf[i];
        deown = network.m_derror[ntotal - nout + i];
        network.m_nwbuf[nout + i] =
            (-v + deown * fown + deown * (net - fown)) * fown / CMath::Sqr(net);
      }
      for (i = 0; i <= nout - 1; i++)
        network.m_derror[ntotal - nout + i] = network.m_nwbuf[nout + i];
    }
  } else {

    for (i = 0; i <= nout - 1; i++)
      network.m_derror[ntotal - nout + i] =
          network.m_derror[ntotal - nout + i] * network.m_columnsigmas[nin + i];
  }

  for (i = ntotal - 1; i >= 0; i--) {

    offs = istart + i * m_nfieldwidth;

    if (network.m_structinfo[offs + 0] > 0 ||
        network.m_structinfo[offs + 0] == -5) {

      dedf = network.m_derror[i];
      dfdnet = network.m_dfdnet[i];
      derror[network.m_structinfo[offs + 2]] =
          derror[network.m_structinfo[offs + 2]] + dedf * dfdnet;
      continue;
    }

    if (network.m_structinfo[offs + 0] == 0) {

      n1 = network.m_structinfo[offs + 2];
      n2 = n1 + network.m_structinfo[offs + 1] - 1;
      w1 = network.m_structinfo[offs + 3];
      w2 = w1 + network.m_structinfo[offs + 1] - 1;
      dedf = network.m_derror[i];
      dfdnet = 1.0;
      v = dedf * dfdnet;
      i1_ = n1 - w1;

      for (i_ = w1; i_ <= w2; i_++)
        grad[i_] = v * neurons[i_ + i1_];
      i1_ = w1 - n1;
      for (i_ = n1; i_ <= n2; i_++)
        derror[i_] = derror[i_] + v * weights[i_ + i1_];
      continue;
    }

    if (network.m_structinfo[offs + 0] < 0) {
      bflag = false;

      if ((network.m_structinfo[offs + 0] == -2 ||
           network.m_structinfo[offs + 0] == -3) ||
          network.m_structinfo[offs + 0] == -4) {

        bflag = true;
      }

      if (!CAp::Assert(bflag, __FUNCTION__ + ": unknown neuron type!"))
        return;
      continue;
    }
  }
}

static void CMLPBase::MLPChunkedGradient(CMultilayerPerceptron &network,
                                         CMatrixDouble &xy, const int cstart,
                                         const int csize, double &e,
                                         double &grad[],
                                         const bool naturalerrorfunc) {

  int i = 0;
  int j = 0;
  int k = 0;
  int kl = 0;
  int n1 = 0;
  int n2 = 0;
  int w1 = 0;
  int w2 = 0;
  int c1 = 0;
  int c2 = 0;
  int ntotal = 0;
  int nin = 0;
  int nout = 0;
  int offs = 0;
  double f = 0;
  double df = 0;
  double d2f = 0;
  double v = 0;
  double s = 0;
  double fown = 0;
  double deown = 0;
  double net = 0;
  double lnnet = 0;
  double mx = 0;
  bool bflag;
  int istart = 0;
  int ineurons = 0;
  int idfdnet = 0;
  int iderror = 0;
  int izeros = 0;
  int i_ = 0;
  int i1_ = 0;

  nin = network.m_structinfo[1];
  nout = network.m_structinfo[2];
  ntotal = network.m_structinfo[3];
  istart = network.m_structinfo[5];
  c1 = cstart;
  c2 = cstart + csize - 1;
  ineurons = 0;
  idfdnet = ntotal;
  iderror = 2 * ntotal;
  izeros = 3 * ntotal;
  for (j = 0; j <= csize - 1; j++)
    network.m_chunks[izeros].Set(j, 0);

  for (i = 0; i <= nin - 1; i++) {
    for (j = 0; j <= csize - 1; j++) {

      if (network.m_columnsigmas[i] != 0.0)
        network.m_chunks[i].Set(j, (xy[c1 + j][i] - network.m_columnmeans[i]) /
                                       network.m_columnsigmas[i]);
      else
        network.m_chunks[i].Set(j, xy[c1 + j][i] - network.m_columnmeans[i]);
    }
  }
  for (i = 0; i <= ntotal - 1; i++) {
    offs = istart + i * m_nfieldwidth;

    if (network.m_structinfo[offs + 0] > 0 ||
        network.m_structinfo[offs + 0] == -5) {

      n1 = network.m_structinfo[offs + 2];
      for (i_ = 0; i_ <= csize - 1; i_++)
        network.m_chunks[i].Set(i_, network.m_chunks[n1][i_]);
      for (j = 0; j <= csize - 1; j++) {

        MLPActivationFunction(network.m_chunks[i][j],
                              network.m_structinfo[offs + 0], f, df, d2f);

        network.m_chunks[i].Set(j, f);
        network.m_chunks[idfdnet + i].Set(j, df);
      }
      continue;
    }

    if (network.m_structinfo[offs + 0] == 0) {

      n1 = network.m_structinfo[offs + 2];
      n2 = n1 + network.m_structinfo[offs + 1] - 1;
      w1 = network.m_structinfo[offs + 3];
      w2 = w1 + network.m_structinfo[offs + 1] - 1;

      for (i_ = 0; i_ <= csize - 1; i_++)
        network.m_chunks[i].Set(i_, network.m_chunks[izeros][i_]);
      for (j = n1; j <= n2; j++) {
        v = network.m_weights[w1 + j - n1];
        for (i_ = 0; i_ <= csize - 1; i_++)
          network.m_chunks[i].Set(i_, network.m_chunks[i][i_] +
                                          v * network.m_chunks[j][i_]);
      }
      continue;
    }

    if (network.m_structinfo[offs + 0] < 0) {
      bflag = false;

      if (network.m_structinfo[offs + 0] == -2) {

        bflag = true;
      }

      if (network.m_structinfo[offs + 0] == -3) {

        for (k = 0; k <= csize - 1; k++)
          network.m_chunks[i].Set(k, -1);
        bflag = true;
      }

      if (network.m_structinfo[offs + 0] == -4) {

        for (k = 0; k <= csize - 1; k++)
          network.m_chunks[i].Set(k, 0);
        bflag = true;
      }

      if (!CAp::Assert(bflag, __FUNCTION__ +
                                  ": internal error - unknown neuron type!"))
        return;
      continue;
    }
  }

  for (i = 0; i <= ntotal - 1; i++) {
    for (i_ = 0; i_ <= csize - 1; i_++)
      network.m_chunks[iderror + i].Set(i_, network.m_chunks[izeros][i_]);
  }

  if (!CAp::Assert(network.m_structinfo[6] == 0 || network.m_structinfo[6] == 1,
                   __FUNCTION__ + ": unknown normalization type!"))
    return;

  if (network.m_structinfo[6] == 1) {

    for (k = 0; k <= csize - 1; k++) {

      mx = network.m_chunks[ntotal - nout][k];
      for (i = 1; i <= nout - 1; i++)
        mx = MathMax(mx, network.m_chunks[ntotal - nout + i][k]);
      net = 0;
      for (i = 0; i <= nout - 1; i++) {
        network.m_nwbuf[i] =
            MathExp(network.m_chunks[ntotal - nout + i][k] - mx);
        net = net + network.m_nwbuf[i];
      }

      if (naturalerrorfunc) {

        s = 1;
        lnnet = MathLog(net);
        kl = (int)MathRound(xy[cstart + k][nin]);

        for (i = 0; i <= nout - 1; i++) {

          if (i == kl)
            v = 1;
          else
            v = 0;
          network.m_chunks[iderror + ntotal - nout + i].Set(
              k, s * network.m_nwbuf[i] / net - v);
          e = e + SafeCrossEntropy(v, network.m_nwbuf[i] / net);
        }
      } else {

        kl = (int)MathRound(xy[cstart + k][nin]);
        for (i = 0; i <= nout - 1; i++) {

          if (i == kl)
            v = network.m_nwbuf[i] / net - 1;
          else
            v = network.m_nwbuf[i] / net;
          network.m_nwbuf[nout + i] = v;
          e = e + CMath::Sqr(v) / 2;
        }

        i1_ = -nout;
        v = 0.0;
        for (i_ = nout; i_ <= 2 * nout - 1; i_++)
          v += network.m_nwbuf[i_] * network.m_nwbuf[i_ + i1_];

        for (i = 0; i <= nout - 1; i++) {
          fown = network.m_nwbuf[i];
          deown = network.m_nwbuf[nout + i];
          network.m_chunks[iderror + ntotal - nout + i].Set(
              k, (-v + deown * fown + deown * (net - fown)) * fown /
                     CMath::Sqr(net));
        }
      }
    }
  } else {

    for (i = 0; i <= nout - 1; i++) {
      for (j = 0; j <= csize - 1; j++) {
        v = network.m_chunks[ntotal - nout + i][j] *
                network.m_columnsigmas[nin + i] +
            network.m_columnmeans[nin + i] - xy[cstart + j][nin + i];
        network.m_chunks[iderror + ntotal - nout + i].Set(
            j, v * network.m_columnsigmas[nin + i]);
        e = e + CMath::Sqr(v) / 2;
      }
    }
  }

  for (i = ntotal - 1; i >= 0; i--) {

    offs = istart + i * m_nfieldwidth;

    if (network.m_structinfo[offs + 0] > 0 ||
        network.m_structinfo[offs + 0] == -5) {

      n1 = network.m_structinfo[offs + 2];
      for (k = 0; k <= csize - 1; k++)
        network.m_chunks[iderror + i].Set(k,
                                          network.m_chunks[iderror + i][k] *
                                              network.m_chunks[idfdnet + i][k]);
      for (i_ = 0; i_ <= csize - 1; i_++)
        network.m_chunks[iderror + n1].Set(
            i_, network.m_chunks[iderror + n1][i_] +
                    network.m_chunks[iderror + i][i_]);
      continue;
    }

    if (network.m_structinfo[offs + 0] == 0) {

      n1 = network.m_structinfo[offs + 2];
      n2 = n1 + network.m_structinfo[offs + 1] - 1;
      w1 = network.m_structinfo[offs + 3];
      w2 = w1 + network.m_structinfo[offs + 1] - 1;

      for (j = w1; j <= w2; j++) {
        v = 0.0;
        for (i_ = 0; i_ <= csize - 1; i_++)
          v += network.m_chunks[n1 + j - w1][i_] *
               network.m_chunks[iderror + i][i_];
        grad[j] = grad[j] + v;
      }

      for (j = n1; j <= n2; j++) {
        v = network.m_weights[w1 + j - n1];
        for (i_ = 0; i_ <= csize - 1; i_++)
          network.m_chunks[iderror + j].Set(
              i_, network.m_chunks[iderror + j][i_] +
                      v * network.m_chunks[iderror + i][i_]);
      }
      continue;
    }

    if (network.m_structinfo[offs + 0] < 0) {
      bflag = false;

      if ((network.m_structinfo[offs + 0] == -2 ||
           network.m_structinfo[offs + 0] == -3) ||
          network.m_structinfo[offs + 0] == -4) {

        bflag = true;
      }

      if (!CAp::Assert(bflag, __FUNCTION__ + ": unknown neuron type!"))
        return;
      continue;
    }
  }
}

static double CMLPBase::SafeCrossEntropy(const double t, const double z) {

  double result = 0;
  double r = 0;

  if (t == 0.0)
    result = 0;
  else {

    if (MathAbs(z) > 1.0) {

      if (t / z == 0.0)
        r = CMath::m_minrealnumber;
      else
        r = t / z;
    } else {

      if (z == 0.0 || MathAbs(t) >= CMath::m_maxrealnumber * MathAbs(z))
        r = CMath::m_maxrealnumber;
      else
        r = t / z;
    }

    result = t * MathLog(r);
  }

  return (result);
}

class CLogitModel {
public:
  double m_w[];

  CLogitModel(void);
  ~CLogitModel(void);

  void Copy(CLogitModel &obj);
};

CLogitModel::CLogitModel(void) {
}

CLogitModel::~CLogitModel(void) {
}

void CLogitModel::Copy(CLogitModel &obj) {

  ArrayCopy(m_w, obj.m_w);
}

class CLogitModelShell {
private:
  CLogitModel m_innerobj;

public:
  CLogitModelShell(void);
  CLogitModelShell(CLogitModel &obj);
  ~CLogitModelShell(void);

  CLogitModel *GetInnerObj(void);
};

CLogitModelShell::CLogitModelShell(void) {
}

CLogitModelShell::CLogitModelShell(CLogitModel &obj) {

  m_innerobj.Copy(obj);
}

CLogitModelShell::~CLogitModelShell(void) {
}

CLogitModel *CLogitModelShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CLogitMCState {
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

  CLogitMCState(void);
  ~CLogitMCState(void);
};

CLogitMCState::CLogitMCState(void) {
}

CLogitMCState::~CLogitMCState(void) {
}

class CMNLReport {
public:
  int m_ngrad;
  int m_nhess;

  CMNLReport(void);
  ~CMNLReport(void);

  void Copy(CMNLReport &obj);
};

CMNLReport::CMNLReport(void) {
}

CMNLReport::~CMNLReport(void) {
}

void CMNLReport::Copy(CMNLReport &obj) {

  m_ngrad = obj.m_ngrad;
  m_nhess = obj.m_nhess;
}

class CMNLReportShell {
private:
  CMNLReport m_innerobj;

public:
  CMNLReportShell(void);
  CMNLReportShell(CMNLReport &obj);
  ~CMNLReportShell(void);

  int GetNGrad(void);
  void SetNGrad(const int i);
  int GetNHess(void);
  void SetNHess(const int i);
  CMNLReport *GetInnerObj(void);
};

CMNLReportShell::CMNLReportShell(void) {
}

CMNLReportShell::CMNLReportShell(CMNLReport &obj) {

  m_innerobj.Copy(obj);
}

CMNLReportShell::~CMNLReportShell(void) {
}

int CMNLReportShell::GetNGrad(void) {

  return (m_innerobj.m_ngrad);
}

void CMNLReportShell::SetNGrad(const int i) {

  m_innerobj.m_ngrad = i;
}

int CMNLReportShell::GetNHess(void) {

  return (m_innerobj.m_nhess);
}

void CMNLReportShell::SetNHess(const int i) {

  m_innerobj.m_nhess = i;
}

CMNLReport *CMNLReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CLogit {
private:
  static void MNLIExp(double &w[], double &x[]);
  static void MNLAllErrors(CLogitModel &lm, CMatrixDouble &xy,
                           const int npoints, double &relcls, double &avgce,
                           double &rms, double &avg, double &avgrel);
  static void MNLMCSrch(const int n, double &x[], double &f, double &g[],
                        double &s[], double &stp, int &info, int &nfev,
                        double &wa[], CLogitMCState &state, int &stage);
  static void MNLMCStep(double &stx, double &fx, double &dx, double &sty,
                        double &fy, double &dy, double &stp, const double fp,
                        const double dp, bool &brackt, const double stmin,
                        const double stmax, int &info);

public:
  static const double m_xtol;
  static const double m_ftol;
  static const double m_gtol;
  static const int m_maxfev;
  static const double m_stpmin;
  static const double m_stpmax;
  static const int m_logitvnum;

  CLogit(void);
  ~CLogit(void);

  static void MNLTrainH(CMatrixDouble &xy, const int npoints, const int nvars,
                        const int nclasses, int &info, CLogitModel &lm,
                        CMNLReport &rep);
  static void MNLProcess(CLogitModel &lm, double &x[], double &y[]);
  static void MNLProcessI(CLogitModel &lm, double &x[], double &y[]);
  static void MNLUnpack(CLogitModel &lm, CMatrixDouble &a, int &nvars,
                        int &nclasses);
  static void MNLPack(CMatrixDouble &a, const int nvars, const int nclasses,
                      CLogitModel &lm);
  static void MNLCopy(CLogitModel &lm1, CLogitModel &lm2);
  static double MNLAvgCE(CLogitModel &lm, CMatrixDouble &xy, const int npoints);
  static double MNLRelClsError(CLogitModel &lm, CMatrixDouble &xy,
                               const int npoints);
  static double MNLRMSError(CLogitModel &lm, CMatrixDouble &xy,
                            const int npoints);
  static double MNLAvgError(CLogitModel &lm, CMatrixDouble &xy,
                            const int npoints);
  static double MNLAvgRelError(CLogitModel &lm, CMatrixDouble &xy,
                               const int ssize);
  static int MNLClsError(CLogitModel &lm, CMatrixDouble &xy, const int npoints);
};

const double CLogit::m_xtol = 100 * CMath::m_machineepsilon;
const double CLogit::m_ftol = 0.0001;
const double CLogit::m_gtol = 0.3;
const int CLogit::m_maxfev = 20;
const double CLogit::m_stpmin = 1.0E-2;
const double CLogit::m_stpmax = 1.0E5;
const int CLogit::m_logitvnum = 6;

CLogit::CLogit(void) {
}

CLogit::~CLogit(void) {
}

static void CLogit::MNLTrainH(CMatrixDouble &xy, const int npoints,
                              const int nvars, const int nclasses, int &info,
                              CLogitModel &lm, CMNLReport &rep) {

  int i = 0;
  int j = 0;
  int k = 0;
  int ssize = 0;
  bool allsame;
  int offs = 0;
  double threshold = 0;
  double wminstep = 0;
  double decay = 0;
  int wdim = 0;
  int expoffs = 0;
  double v = 0;
  double s = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  double e = 0;
  bool spd;
  double wstep = 0;
  int mcstage = 0;
  int mcinfo = 0;
  int mcnfev = 0;
  int solverinfo = 0;
  int i_ = 0;
  int i1_ = 0;

  double g[];
  double x[];
  double y[];
  double wbase[];
  double wdir[];
  double work[];

  CMatrixDouble h;

  CLogitMCState mcstate;
  CDenseSolverReport solverrep;
  CMultilayerPerceptron network;

  info = 0;
  threshold = 1000 * CMath::m_machineepsilon;
  wminstep = 0.001;
  decay = 0.001;

  if ((npoints < nvars + 2 || nvars < 1) || nclasses < 2) {
    info = -1;
    return;
  }
  for (i = 0; i <= npoints - 1; i++) {

    if ((int)MathRound(xy[i][nvars]) < 0 ||
        (int)MathRound(xy[i][nvars]) >= nclasses) {
      info = -2;
      return;
    }
  }

  info = 1;

  rep.m_ngrad = 0;
  rep.m_nhess = 0;

  wdim = (nvars + 1) * (nclasses - 1);
  offs = 5;
  expoffs = offs + wdim;
  ssize = 5 + (nvars + 1) * (nclasses - 1) + nclasses;

  ArrayResizeAL(lm.m_w, ssize);

  lm.m_w[0] = ssize;
  lm.m_w[1] = m_logitvnum;
  lm.m_w[2] = nvars;
  lm.m_w[3] = nclasses;
  lm.m_w[4] = offs;

  allsame = true;
  for (i = 1; i <= npoints - 1; i++) {

    if ((int)MathRound(xy[i][nvars]) != (int)MathRound(xy[i - 1][nvars]))
      allsame = false;
  }

  if (allsame) {
    for (i = 0; i <= (nvars + 1) * (nclasses - 1) - 1; i++)
      lm.m_w[offs + i] = 0;

    v = -(2 * MathLog(CMath::m_minrealnumber));
    k = (int)MathRound(xy[0][nvars]);

    if (k == nclasses - 1) {
      for (i = 0; i <= nclasses - 2; i++)
        lm.m_w[offs + i * (nvars + 1) + nvars] = -v;
    } else {
      for (i = 0; i <= nclasses - 2; i++) {

        if (i == k)
          lm.m_w[offs + i * (nvars + 1) + nvars] = v;
        else
          lm.m_w[offs + i * (nvars + 1) + nvars] = 0;
      }
    }

    return;
  }

  CMLPBase::MLPCreateC0(nvars, nclasses, network);

  CMLPBase::MLPInitPreprocessor(network, xy, npoints);

  CMLPBase::MLPProperties(network, nin, nout, wcount);
  for (i = 0; i <= wcount - 1; i++)
    network.m_weights[i] = (2 * CMath::RandomReal() - 1) / nvars;

  ArrayResizeAL(g, wcount);
  h.Resize(wcount, wcount);
  ArrayResizeAL(wbase, wcount);
  ArrayResizeAL(wdir, wcount);
  ArrayResizeAL(work, wcount);

  for (k = 0; k <= wcount / 3 + 10; k++) {

    CMLPBase::MLPGradNBatch(network, xy, npoints, e, g);
    v = 0.0;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      v += network.m_weights[i_] * network.m_weights[i_];

    e = e + 0.5 * decay * v;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      g[i_] = g[i_] + decay * network.m_weights[i_];
    rep.m_ngrad = rep.m_ngrad + 1;

    for (i_ = 0; i_ <= wcount - 1; i_++)
      wdir[i_] = -g[i_];
    v = 0.0;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      v += wdir[i_] * wdir[i_];

    wstep = MathSqrt(v);
    v = 1 / MathSqrt(v);
    for (i_ = 0; i_ <= wcount - 1; i_++)
      wdir[i_] = v * wdir[i_];
    mcstage = 0;

    MNLMCSrch(wcount, network.m_weights, e, g, wdir, wstep, mcinfo, mcnfev,
              work, mcstate, mcstage);

    while (mcstage != 0) {

      CMLPBase::MLPGradNBatch(network, xy, npoints, e, g);
      v = 0.0;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        v += network.m_weights[i_] * network.m_weights[i_];

      e = e + 0.5 * decay * v;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        g[i_] = g[i_] + decay * network.m_weights[i_];
      rep.m_ngrad = rep.m_ngrad + 1;

      MNLMCSrch(wcount, network.m_weights, e, g, wdir, wstep, mcinfo, mcnfev,
                work, mcstate, mcstage);
    }
  }

  while (true) {

    CMLPBase::MLPHessianNBatch(network, xy, npoints, e, g, h);
    v = 0.0;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      v += network.m_weights[i_] * network.m_weights[i_];

    e = e + 0.5 * decay * v;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      g[i_] = g[i_] + decay * network.m_weights[i_];
    for (k = 0; k <= wcount - 1; k++)
      h[k].Set(k, h[k][k] + decay);
    rep.m_nhess = rep.m_nhess + 1;

    spd = CTrFac::SPDMatrixCholesky(h, wcount, false);

    CDenseSolver::SPDMatrixCholeskySolve(h, wcount, false, g, solverinfo,
                                         solverrep, wdir);
    spd = solverinfo > 0;

    if (spd) {

      for (i_ = 0; i_ <= wcount - 1; i_++)
        wdir[i_] = -1 * wdir[i_];
      spd = true;
    } else {

      for (i_ = 0; i_ <= wcount - 1; i_++)
        wdir[i_] = -g[i_];
      spd = false;
    }

    v = 0.0;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      v += wdir[i_] * wdir[i_];

    wstep = MathSqrt(v);
    v = 1 / MathSqrt(v);
    for (i_ = 0; i_ <= wcount - 1; i_++)
      wdir[i_] = v * wdir[i_];
    mcstage = 0;

    MNLMCSrch(wcount, network.m_weights, e, g, wdir, wstep, mcinfo, mcnfev,
              work, mcstate, mcstage);

    while (mcstage != 0) {

      CMLPBase::MLPGradNBatch(network, xy, npoints, e, g);
      v = 0.0;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        v += network.m_weights[i_] * network.m_weights[i_];

      e = e + 0.5 * decay * v;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        g[i_] = g[i_] + decay * network.m_weights[i_];
      rep.m_ngrad = rep.m_ngrad + 1;

      MNLMCSrch(wcount, network.m_weights, e, g, wdir, wstep, mcinfo, mcnfev,
                work, mcstate, mcstage);
    }

    if (spd && ((mcinfo == 2 || mcinfo == 4) || mcinfo == 6))
      break;
  }

  i1_ = -offs;
  for (i_ = offs; i_ <= offs + wcount - 1; i_++)
    lm.m_w[i_] = network.m_weights[i_ + i1_];
  for (k = 0; k <= nvars - 1; k++) {
    for (i = 0; i <= nclasses - 2; i++) {
      s = network.m_columnsigmas[k];

      if (s == 0.0)
        s = 1;

      j = offs + (nvars + 1) * i;
      v = lm.m_w[j + k];
      lm.m_w[j + k] = v / s;
      lm.m_w[j + nvars] = lm.m_w[j + nvars] + v * network.m_columnmeans[k] / s;
    }
  }

  for (k = 0; k <= nclasses - 2; k++)
    lm.m_w[offs + (nvars + 1) * k + nvars] =
        -lm.m_w[offs + (nvars + 1) * k + nvars];
}

static void CLogit::MNLProcess(CLogitModel &lm, double &x[], double &y[]) {

  int nvars = 0;
  int nclasses = 0;
  int offs = 0;
  int i = 0;
  int i1 = 0;
  double s = 0;

  if (!CAp::Assert(lm.m_w[1] == m_logitvnum,
                   __FUNCTION__ + ": unexpected model version"))
    return;

  nvars = (int)MathRound(lm.m_w[2]);
  nclasses = (int)MathRound(lm.m_w[3]);
  offs = (int)MathRound(lm.m_w[4]);

  MNLIExp(lm.m_w, x);
  s = 0;

  i1 = offs + (nvars + 1) * (nclasses - 1);
  for (i = i1; i <= i1 + nclasses - 1; i++)
    s = s + lm.m_w[i];

  if (CAp::Len(y) < nclasses)
    ArrayResizeAL(y, nclasses);

  for (i = 0; i <= nclasses - 1; i++)
    y[i] = lm.m_w[i1 + i] / s;
}

static void CLogit::MNLProcessI(CLogitModel &lm, double &x[], double &y[]) {

  MNLProcess(lm, x, y);
}

static void CLogit::MNLUnpack(CLogitModel &lm, CMatrixDouble &a, int &nvars,
                              int &nclasses) {

  int offs = 0;
  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  nvars = 0;
  nclasses = 0;

  if (!CAp::Assert(lm.m_w[1] == m_logitvnum,
                   __FUNCTION__ + ": unexpected model version"))
    return;

  nvars = (int)MathRound(lm.m_w[2]);
  nclasses = (int)MathRound(lm.m_w[3]);
  offs = (int)MathRound(lm.m_w[4]);

  a.Resize(nclasses - 1, nvars + 1);

  for (i = 0; i <= nclasses - 2; i++) {
    i1_ = offs + i * (nvars + 1);
    for (i_ = 0; i_ <= nvars; i_++)
      a[i].Set(i_, lm.m_w[i_ + i1_]);
  }
}

static void CLogit::MNLPack(CMatrixDouble &a, const int nvars,
                            const int nclasses, CLogitModel &lm) {

  int offs = 0;
  int i = 0;
  int wdim = 0;
  int ssize = 0;
  int i_ = 0;
  int i1_ = 0;

  wdim = (nvars + 1) * (nclasses - 1);
  offs = 5;
  ssize = 5 + (nvars + 1) * (nclasses - 1) + nclasses;

  ArrayResizeAL(lm.m_w, ssize);

  lm.m_w[0] = ssize;
  lm.m_w[1] = m_logitvnum;
  lm.m_w[2] = nvars;
  lm.m_w[3] = nclasses;
  lm.m_w[4] = offs;

  for (i = 0; i <= nclasses - 2; i++) {
    i1_ = -(offs + i * (nvars + 1));
    for (i_ = offs + i * (nvars + 1); i_ <= offs + i * (nvars + 1) + nvars;
         i_++)
      lm.m_w[i_] = a[i][i_ + i1_];
  }
}

static void CLogit::MNLCopy(CLogitModel &lm1, CLogitModel &lm2) {

  int k = 0;
  int i_ = 0;

  k = (int)MathRound(lm1.m_w[0]);

  ArrayResizeAL(lm2.m_w, k);

  for (i_ = 0; i_ <= k - 1; i_++)
    lm2.m_w[i_] = lm1.m_w[i_];
}

static double CLogit::MNLAvgCE(CLogitModel &lm, CMatrixDouble &xy,
                               const int npoints) {

  double result = 0;
  int nvars = 0;
  int nclasses = 0;
  int i = 0;
  int i_ = 0;

  double workx[];
  double worky[];

  if (!CAp::Assert(lm.m_w[1] == m_logitvnum,
                   __FUNCTION__ + ": unexpected model version"))
    return (EMPTY_VALUE);

  nvars = (int)MathRound(lm.m_w[2]);
  nclasses = (int)MathRound(lm.m_w[3]);

  ArrayResizeAL(workx, nvars);
  ArrayResizeAL(worky, nclasses);

  for (i = 0; i <= npoints - 1; i++) {

    if (!CAp::Assert((int)MathRound(xy[i][nvars]) >= 0 &&
                         (int)MathRound(xy[i][nvars]) < nclasses,
                     __FUNCTION__ + ": incorrect class number!"))
      return (EMPTY_VALUE);

    for (i_ = 0; i_ <= nvars - 1; i_++)
      workx[i_] = xy[i][i_];

    MNLProcess(lm, workx, worky);

    if (worky[(int)MathRound(xy[i][nvars])] > 0.0)
      result = result - MathLog(worky[(int)MathRound(xy[i][nvars])]);
    else
      result = result - MathLog(CMath::m_minrealnumber);
  }

  return (result / (npoints * MathLog(2)));
}

static double CLogit::MNLRelClsError(CLogitModel &lm, CMatrixDouble &xy,
                                     const int npoints) {

  return ((double)MNLClsError(lm, xy, npoints) / (double)npoints);
}

static double CLogit::MNLRMSError(CLogitModel &lm, CMatrixDouble &xy,
                                  const int npoints) {

  double relcls = 0;
  double avgce = 0;
  double rms = 0;
  double avg = 0;
  double avgrel = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_logitvnum,
                   __FUNCTION__ + ": Incorrect MNL version!"))
    return (EMPTY_VALUE);

  MNLAllErrors(lm, xy, npoints, relcls, avgce, rms, avg, avgrel);

  return (rms);
}

static double CLogit::MNLAvgError(CLogitModel &lm, CMatrixDouble &xy,
                                  const int npoints) {

  double relcls = 0;
  double avgce = 0;
  double rms = 0;
  double avg = 0;
  double avgrel = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_logitvnum,
                   __FUNCTION__ + ": Incorrect MNL version!"))
    return (EMPTY_VALUE);

  MNLAllErrors(lm, xy, npoints, relcls, avgce, rms, avg, avgrel);

  return (avg);
}

static double CLogit::MNLAvgRelError(CLogitModel &lm, CMatrixDouble &xy,
                                     const int ssize) {

  double relcls = 0;
  double avgce = 0;
  double rms = 0;
  double avg = 0;
  double avgrel = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_logitvnum,
                   __FUNCTION__ + ": Incorrect MNL version!"))
    return (EMPTY_VALUE);

  MNLAllErrors(lm, xy, ssize, relcls, avgce, rms, avg, avgrel);

  return (avgrel);
}

static int CLogit::MNLClsError(CLogitModel &lm, CMatrixDouble &xy,
                               const int npoints) {

  int result = 0;
  int nvars = 0;
  int nclasses = 0;
  int i = 0;
  int j = 0;
  int nmax = 0;
  int i_ = 0;

  double workx[];
  double worky[];

  if (!CAp::Assert(lm.m_w[1] == m_logitvnum,
                   __FUNCTION__ + ": unexpected model version"))
    return (-1);

  nvars = (int)MathRound(lm.m_w[2]);
  nclasses = (int)MathRound(lm.m_w[3]);

  ArrayResizeAL(workx, nvars);
  ArrayResizeAL(worky, nclasses);

  for (i = 0; i <= npoints - 1; i++) {

    for (i_ = 0; i_ <= nvars - 1; i_++)
      workx[i_] = xy[i][i_];

    MNLProcess(lm, workx, worky);

    nmax = 0;
    for (j = 0; j <= nclasses - 1; j++) {

      if (worky[j] > worky[nmax])
        nmax = j;
    }

    if (nmax != (int)MathRound(xy[i][nvars]))
      result = result + 1;
  }

  return (result);
}

static void CLogit::MNLIExp(double &w[], double &x[]) {

  int nvars = 0;
  int nclasses = 0;
  int offs = 0;
  int i = 0;
  int i1 = 0;
  double v = 0;
  double mx = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert(w[1] == m_logitvnum,
                   __FUNCTION__ + ": unexpected model version"))
    return;

  nvars = (int)MathRound(w[2]);
  nclasses = (int)MathRound(w[3]);
  offs = (int)MathRound(w[4]);

  i1 = offs + (nvars + 1) * (nclasses - 1);
  for (i = 0; i <= nclasses - 2; i++) {

    i1_ = -(offs + i * (nvars + 1));
    v = 0.0;
    for (i_ = offs + i * (nvars + 1); i_ <= offs + i * (nvars + 1) + nvars - 1;
         i_++)
      v += w[i_] * x[i_ + i1_];
    w[i1 + i] = v + w[offs + i * (nvars + 1) + nvars];
  }

  w[i1 + nclasses - 1] = 0;
  mx = 0;

  for (i = i1; i <= i1 + nclasses - 1; i++)
    mx = MathMax(mx, w[i]);
  for (i = i1; i <= i1 + nclasses - 1; i++)
    w[i] = MathExp(w[i] - mx);
}

static void CLogit::MNLAllErrors(CLogitModel &lm, CMatrixDouble &xy,
                                 const int npoints, double &relcls,
                                 double &avgce, double &rms, double &avg,
                                 double &avgrel) {

  int nvars = 0;
  int nclasses = 0;
  int i = 0;
  int i_ = 0;

  double buf[];
  double workx[];
  double y[];
  double dy[];

  relcls = 0;
  avgce = 0;
  rms = 0;
  avg = 0;
  avgrel = 0;

  if (!CAp::Assert((int)MathRound(lm.m_w[1]) == m_logitvnum,
                   __FUNCTION__ + ": Incorrect MNL version!"))
    return;

  nvars = (int)MathRound(lm.m_w[2]);
  nclasses = (int)MathRound(lm.m_w[3]);

  ArrayResizeAL(workx, nvars);
  ArrayResizeAL(y, nclasses);
  ArrayResizeAL(dy, 1);

  CBdSS::DSErrAllocate(nclasses, buf);
  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= nvars - 1; i_++)
      workx[i_] = xy[i][i_];

    MNLProcess(lm, workx, y);

    dy[0] = xy[i][nvars];

    CBdSS::DSErrAccumulate(buf, y, dy);
  }

  CBdSS::DSErrFinish(buf);

  relcls = buf[0];
  avgce = buf[1];
  rms = buf[2];
  avg = buf[3];
  avgrel = buf[4];
}

static void CLogit::MNLMCSrch(const int n, double &x[], double &f, double &g[],
                              double &s[], double &stp, int &info, int &nfev,
                              double &wa[], CLogitMCState &state, int &stage) {

  double v = 0;
  double p5 = 0;
  double p66 = 0;
  double zero = 0;
  int i_ = 0;

  p5 = 0.5;
  p66 = 0.66;
  state.m_xtrapf = 4.0;
  zero = 0;

  while (true) {

    if (stage == 0) {

      stage = 2;
      continue;
    }

    if (stage == 2) {
      state.m_infoc = 1;
      info = 0;

      if (n <= 0 || stp <= 0.0 || m_ftol < 0.0 || m_gtol < zero ||
          m_xtol < zero || m_stpmin < zero || m_stpmax < m_stpmin ||
          m_maxfev <= 0) {
        stage = 0;
        return;
      }

      v = 0.0;
      for (i_ = 0; i_ <= n - 1; i_++)
        v += g[i_] * s[i_];
      state.m_dginit = v;

      if (state.m_dginit >= 0.0) {
        stage = 0;
        return;
      }

      state.m_brackt = false;
      state.m_stage1 = true;
      nfev = 0;
      state.m_finit = f;
      state.m_dgtest = m_ftol * state.m_dginit;
      state.m_width = m_stpmax - m_stpmin;
      state.m_width1 = state.m_width / p5;
      for (i_ = 0; i_ <= n - 1; i_++)
        wa[i_] = x[i_];

      state.m_stx = 0;
      state.m_fx = state.m_finit;
      state.m_dgx = state.m_dginit;
      state.m_sty = 0;
      state.m_fy = state.m_finit;
      state.m_dgy = state.m_dginit;

      stage = 3;
      continue;
    }

    if (stage == 3) {

      if (state.m_brackt) {

        if (state.m_stx < state.m_sty) {
          state.m_stmin = state.m_stx;
          state.m_stmax = state.m_sty;
        } else {
          state.m_stmin = state.m_sty;
          state.m_stmax = state.m_stx;
        }
      } else {
        state.m_stmin = state.m_stx;
        state.m_stmax = stp + state.m_xtrapf * (stp - state.m_stx);
      }

      if (stp > m_stpmax)
        stp = m_stpmax;

      if (stp < m_stpmin)
        stp = m_stpmin;

      if ((((state.m_brackt &&
             (stp <= state.m_stmin || stp >= state.m_stmax)) ||
            nfev >= m_maxfev - 1) ||
           state.m_infoc == 0) ||
          (state.m_brackt &&
           state.m_stmax - state.m_stmin <= m_xtol * state.m_stmax))
        stp = state.m_stx;

      for (i_ = 0; i_ <= n - 1; i_++)
        x[i_] = wa[i_];
      for (i_ = 0; i_ <= n - 1; i_++)
        x[i_] = x[i_] + stp * s[i_];

      stage = 4;
      return;
    }

    if (stage == 4) {
      info = 0;
      nfev = nfev + 1;
      v = 0.0;

      for (i_ = 0; i_ <= n - 1; i_++)
        v += g[i_] * s[i_];
      state.m_dg = v;
      state.m_ftest1 = state.m_finit + stp * state.m_dgtest;

      if ((state.m_brackt && (stp <= state.m_stmin || stp >= state.m_stmax)) ||
          state.m_infoc == 0)
        info = 6;

      if ((stp == m_stpmax && f <= state.m_ftest1) &&
          state.m_dg <= state.m_dgtest)
        info = 5;

      if (stp == m_stpmin &&
          (f > state.m_ftest1 || state.m_dg >= state.m_dgtest))
        info = 4;

      if (nfev >= m_maxfev)
        info = 3;

      if (state.m_brackt &&
          state.m_stmax - state.m_stmin <= m_xtol * state.m_stmax)
        info = 2;

      if (f <= state.m_ftest1 &&
          MathAbs(state.m_dg) <= -(m_gtol * state.m_dginit))
        info = 1;

      if (info != 0) {
        stage = 0;
        return;
      }

      if ((state.m_stage1 && f <= state.m_ftest1) &&
          state.m_dg >= MathMin(m_ftol, m_gtol) * state.m_dginit)
        state.m_stage1 = false;

      if ((state.m_stage1 && f <= state.m_fx) && f > state.m_ftest1) {

        state.m_fm = f - stp * state.m_dgtest;
        state.m_fxm = state.m_fx - state.m_stx * state.m_dgtest;
        state.m_fym = state.m_fy - state.m_sty * state.m_dgtest;
        state.m_dgm = state.m_dg - state.m_dgtest;
        state.m_dgxm = state.m_dgx - state.m_dgtest;
        state.m_dgym = state.m_dgy - state.m_dgtest;

        MNLMCStep(state.m_stx, state.m_fxm, state.m_dgxm, state.m_sty,
                  state.m_fym, state.m_dgym, stp, state.m_fm, state.m_dgm,
                  state.m_brackt, state.m_stmin, state.m_stmax, state.m_infoc);

        state.m_fx = state.m_fxm + state.m_stx * state.m_dgtest;
        state.m_fy = state.m_fym + state.m_sty * state.m_dgtest;
        state.m_dgx = state.m_dgxm + state.m_dgtest;
        state.m_dgy = state.m_dgym + state.m_dgtest;
      } else {

        MNLMCStep(state.m_stx, state.m_fx, state.m_dgx, state.m_sty, state.m_fy,
                  state.m_dgy, stp, f, state.m_dg, state.m_brackt,
                  state.m_stmin, state.m_stmax, state.m_infoc);
      }

      if (state.m_brackt) {

        if (MathAbs(state.m_sty - state.m_stx) >= p66 * state.m_width1)
          stp = state.m_stx + p5 * (state.m_sty - state.m_stx);
        state.m_width1 = state.m_width;
        state.m_width = MathAbs(state.m_sty - state.m_stx);
      }

      stage = 3;
      continue;
    }
  }
}

static void CLogit::MNLMCStep(double &stx, double &fx, double &dx, double &sty,
                              double &fy, double &dy, double &stp,
                              const double fp, const double dp, bool &brackt,
                              const double stmin, const double stmax,
                              int &info) {

  bool bound;
  double gamma = 0;
  double p = 0;
  double q = 0;
  double r = 0;
  double s = 0;
  double sgnd = 0;
  double stpc = 0;
  double stpf = 0;
  double stpq = 0;
  double theta = 0;

  info = 0;

  if (((brackt && (stp <= MathMin(stx, sty) || stp >= MathMax(stx, sty))) ||
       dx * (stp - stx) >= 0.0) ||
      stmax < stmin)
    return;

  sgnd = dp * (dx / MathAbs(dx));

  if (fp > fx) {

    info = 1;
    bound = true;
    theta = 3 * (fx - fp) / (stp - stx) + dx + dp;
    s = MathMax(MathAbs(theta), MathMax(MathAbs(dx), MathAbs(dp)));
    gamma = s * MathSqrt(CMath::Sqr(theta / s) - dx / s * (dp / s));

    if (stp < stx)
      gamma = -gamma;

    p = gamma - dx + theta;
    q = gamma - dx + gamma + dp;
    r = p / q;
    stpc = stx + r * (stp - stx);
    stpq = stx + dx / ((fx - fp) / (stp - stx) + dx) / 2 * (stp - stx);

    if (MathAbs(stpc - stx) < MathAbs(stpq - stx))
      stpf = stpc;
    else
      stpf = stpc + (stpq - stpc) / 2;
    brackt = true;
  } else {

    if (sgnd < 0.0) {

      info = 2;
      bound = false;
      theta = 3 * (fx - fp) / (stp - stx) + dx + dp;
      s = MathMax(MathAbs(theta), MathMax(MathAbs(dx), MathAbs(dp)));
      gamma = s * MathSqrt(CMath::Sqr(theta / s) - dx / s * (dp / s));

      if (stp > stx)
        gamma = -gamma;

      p = gamma - dp + theta;
      q = gamma - dp + gamma + dx;
      r = p / q;
      stpc = stp + r * (stx - stp);
      stpq = stp + dp / (dp - dx) * (stx - stp);

      if (MathAbs(stpc - stp) > MathAbs(stpq - stp))
        stpf = stpc;
      else
        stpf = stpq;
      brackt = true;
    } else {

      if (MathAbs(dp) < MathAbs(dx)) {

        info = 3;
        bound = true;
        theta = 3 * (fx - fp) / (stp - stx) + dx + dp;
        s = MathMax(MathAbs(theta), MathMax(MathAbs(dx), MathAbs(dp)));

        gamma =
            s * MathSqrt(MathMax(0, CMath::Sqr(theta / s) - dx / s * (dp / s)));

        if (stp > stx)
          gamma = -gamma;
        p = gamma - dp + theta;
        q = gamma + (dx - dp) + gamma;
        r = p / q;

        if (r < 0.0 && gamma != 0.0)
          stpc = stp + r * (stx - stp);
        else {

          if (stp > stx)
            stpc = stmax;
          else
            stpc = stmin;
        }
        stpq = stp + dp / (dp - dx) * (stx - stp);

        if (brackt) {

          if (MathAbs(stp - stpc) < MathAbs(stp - stpq))
            stpf = stpc;
          else
            stpf = stpq;
        } else {

          if (MathAbs(stp - stpc) > MathAbs(stp - stpq))
            stpf = stpc;
          else
            stpf = stpq;
        }
      } else {

        info = 4;
        bound = false;

        if (brackt) {

          theta = 3 * (fp - fy) / (sty - stp) + dy + dp;
          s = MathMax(MathAbs(theta), MathMax(MathAbs(dy), MathAbs(dp)));
          gamma = s * MathSqrt(CMath::Sqr(theta / s) - dy / s * (dp / s));

          if (stp > sty)
            gamma = -gamma;

          p = gamma - dp + theta;
          q = gamma - dp + gamma + dy;
          r = p / q;
          stpc = stp + r * (sty - stp);
          stpf = stpc;
        } else {

          if (stp > stx)
            stpf = stmax;
          else
            stpf = stmin;
        }
      }
    }
  }

  if (fp > fx) {
    sty = stp;
    fy = fp;
    dy = dp;
  } else {

    if (sgnd < 0.0) {
      sty = stx;
      fy = fx;
      dy = dx;
    }

    stx = stp;
    fx = fp;
    dx = dp;
  }

  stpf = MathMin(stmax, stpf);
  stpf = MathMax(stmin, stpf);
  stp = stpf;

  if (brackt && bound) {

    if (sty > stx)
      stp = MathMin(stx + 0.66 * (sty - stx), stp);
    else
      stp = MathMax(stx + 0.66 * (sty - stx), stp);
  }
}

class CMCPDState {
public:
  int m_n;
  int m_npairs;
  int m_ccnt;
  double m_regterm;
  int m_repinneriterationscount;
  int m_repouteriterationscount;
  int m_repnfev;
  int m_repterminationtype;
  CMinBLEICState m_bs;
  CMinBLEICReport m_br;

  int m_states[];
  int m_ct[];
  double m_pw[];
  double m_tmpp[];
  double m_effectivew[];
  double m_effectivebndl[];
  double m_effectivebndu[];
  int m_effectivect[];
  double m_h[];

  CMatrixDouble m_data;
  CMatrixDouble m_ec;
  CMatrixDouble m_bndl;
  CMatrixDouble m_bndu;
  CMatrixDouble m_c;
  CMatrixDouble m_priorp;
  CMatrixDouble m_effectivec;
  CMatrixDouble m_p;

  CMCPDState(void);
  ~CMCPDState(void);

  void Copy(CMCPDState &obj);
};

CMCPDState::CMCPDState(void) {
}

CMCPDState::~CMCPDState(void) {
}

void CMCPDState::Copy(CMCPDState &obj) {

  m_n = obj.m_n;
  m_npairs = obj.m_npairs;
  m_ccnt = obj.m_ccnt;
  m_regterm = obj.m_regterm;
  m_repinneriterationscount = obj.m_repinneriterationscount;
  m_repouteriterationscount = obj.m_repouteriterationscount;
  m_repnfev = obj.m_repnfev;
  m_repterminationtype = obj.m_repterminationtype;
  m_bs.Copy(obj.m_bs);
  m_br.Copy(obj.m_br);

  ArrayCopy(m_states, obj.m_states);
  ArrayCopy(m_ct, obj.m_ct);
  ArrayCopy(m_pw, obj.m_pw);
  ArrayCopy(m_tmpp, obj.m_tmpp);
  ArrayCopy(m_effectivew, obj.m_effectivew);
  ArrayCopy(m_effectivebndl, obj.m_effectivebndl);
  ArrayCopy(m_effectivebndu, obj.m_effectivebndu);
  ArrayCopy(m_effectivect, obj.m_effectivect);
  ArrayCopy(m_h, obj.m_h);

  m_data = obj.m_data;
  m_ec = obj.m_ec;
  m_bndl = obj.m_bndl;
  m_bndu = obj.m_bndu;
  m_c = obj.m_c;
  m_priorp = obj.m_priorp;
  m_effectivec = obj.m_effectivec;
  m_p = obj.m_p;
}

class CMCPDStateShell {
private:
  CMCPDState m_innerobj;

public:
  CMCPDStateShell(void);
  CMCPDStateShell(CMCPDState &obj);
  ~CMCPDStateShell(void);

  CMCPDState *GetInnerObj(void);
};

CMCPDStateShell::CMCPDStateShell(void) {
}

CMCPDStateShell::CMCPDStateShell(CMCPDState &obj) {

  m_innerobj.Copy(obj);
}

CMCPDStateShell::~CMCPDStateShell(void) {
}

CMCPDState *CMCPDStateShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMCPDReport {
public:
  int m_inneriterationscount;
  int m_outeriterationscount;
  int m_nfev;
  int m_terminationtype;

  CMCPDReport(void);
  ~CMCPDReport(void);

  void Copy(CMCPDReport &obj);
};

CMCPDReport::CMCPDReport(void) {
}

CMCPDReport::~CMCPDReport(void) {
}

void CMCPDReport::Copy(CMCPDReport &obj) {

  m_inneriterationscount = obj.m_inneriterationscount;
  m_outeriterationscount = obj.m_outeriterationscount;
  m_nfev = obj.m_nfev;
  m_terminationtype = obj.m_terminationtype;
}

class CMCPDReportShell {
private:
  CMCPDReport m_innerobj;

public:
  CMCPDReportShell(void);
  CMCPDReportShell(CMCPDReport &obj);
  ~CMCPDReportShell(void);

  int GetInnerIterationsCount(void);
  void SetInnerIterationsCount(const int i);
  int GetOuterIterationsCount(void);
  void SetOuterIterationsCount(const int i);
  int GetNFev(void);
  void SetNFev(const int i);
  int GetTerminationType(void);
  void SetTerminationType(const int i);
  CMCPDReport *GetInnerObj(void);
};

CMCPDReportShell::CMCPDReportShell(void) {
}

CMCPDReportShell::CMCPDReportShell(CMCPDReport &obj) {

  m_innerobj.Copy(obj);
}

CMCPDReportShell::~CMCPDReportShell(void) {
}

int CMCPDReportShell::GetInnerIterationsCount(void) {

  return (m_innerobj.m_inneriterationscount);
}

void CMCPDReportShell::SetInnerIterationsCount(const int i) {

  m_innerobj.m_inneriterationscount = i;
}

int CMCPDReportShell::GetOuterIterationsCount(void) {

  return (m_innerobj.m_outeriterationscount);
}

void CMCPDReportShell::SetOuterIterationsCount(const int i) {

  m_innerobj.m_outeriterationscount = i;
}

int CMCPDReportShell::GetNFev(void) {

  return (m_innerobj.m_nfev);
}

void CMCPDReportShell::SetNFev(const int i) {

  m_innerobj.m_nfev = i;
}

int CMCPDReportShell::GetTerminationType(void) {

  return (m_innerobj.m_terminationtype);
}

void CMCPDReportShell::SetTerminationType(const int i) {

  m_innerobj.m_terminationtype = i;
}

CMCPDReport *CMCPDReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMarkovCPD {
private:
  static void MCPDInit(const int n, const int entrystate, const int exitstate,
                       CMCPDState &s);

public:
  static const double m_xtol;

  CMarkovCPD(void);
  ~CMarkovCPD(void);

  static void MCPDCreate(const int n, CMCPDState &s);
  static void MCPDCreateEntry(const int n, const int entrystate, CMCPDState &s);
  static void MCPDCreateExit(const int n, const int exitstate, CMCPDState &s);
  static void MCPDCreateEntryExit(const int n, const int entrystate,
                                  const int exitstate, CMCPDState &s);
  static void MCPDAddTrack(CMCPDState &s, CMatrixDouble &xy, const int k);
  static void MCPDSetEC(CMCPDState &s, CMatrixDouble &ec);
  static void MCPDAddEC(CMCPDState &s, const int i, const int j,
                        const double c);
  static void MCPDSetBC(CMCPDState &s, CMatrixDouble &bndl,
                        CMatrixDouble &bndu);
  static void MCPDAddBC(CMCPDState &s, const int i, const int j, double bndl,
                        double bndu);
  static void MCPDSetLC(CMCPDState &s, CMatrixDouble &c, int &ct[],
                        const int k);
  static void MCPDSetTikhonovRegularizer(CMCPDState &s, const double v);
  static void MCPDSetPrior(CMCPDState &s, CMatrixDouble &cpp);
  static void MCPDSetPredictionWeights(CMCPDState &s, double &pw[]);
  static void MCPDSolve(CMCPDState &s);
  static void MCPDResults(CMCPDState &s, CMatrixDouble &p, CMCPDReport &rep);
};

const double CMarkovCPD::m_xtol = 1.0E-8;

CMarkovCPD::CMarkovCPD(void) {
}

CMarkovCPD::~CMarkovCPD(void) {
}

static void CMarkovCPD::MCPDCreate(const int n, CMCPDState &s) {

  if (!CAp::Assert(n >= 1, "MCPDCreate: N<1"))
    return;

  MCPDInit(n, -1, -1, s);
}

static void CMarkovCPD::MCPDCreateEntry(const int n, const int entrystate,
                                        CMCPDState &s) {

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2"))
    return;

  if (!CAp::Assert(entrystate >= 0, __FUNCTION__ + ": EntryState<0"))
    return;

  if (!CAp::Assert(entrystate < n, __FUNCTION__ + ": EntryState>=N"))
    return;

  MCPDInit(n, entrystate, -1, s);
}

static void CMarkovCPD::MCPDCreateExit(const int n, const int exitstate,
                                       CMCPDState &s) {

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2"))
    return;

  if (!CAp::Assert(exitstate >= 0, __FUNCTION__ + ": ExitState<0"))
    return;

  if (!CAp::Assert(exitstate < n, __FUNCTION__ + ": ExitState>=N"))
    return;

  MCPDInit(n, -1, exitstate, s);
}

static void CMarkovCPD::MCPDCreateEntryExit(const int n, const int entrystate,
                                            const int exitstate,
                                            CMCPDState &s) {

  if (!CAp::Assert(n >= 2, __FUNCTION__ + ": N<2"))
    return;

  if (!CAp::Assert(entrystate >= 0, __FUNCTION__ + ": EntryState<0"))
    return;

  if (!CAp::Assert(entrystate < n, __FUNCTION__ + ": EntryState>=N"))
    return;

  if (!CAp::Assert(exitstate >= 0, __FUNCTION__ + ": ExitState<0"))
    return;

  if (!CAp::Assert(exitstate < n, __FUNCTION__ + ": ExitState>=N"))
    return;

  if (!CAp::Assert(entrystate != exitstate,
                   __FUNCTION__ + ": EntryState=ExitState"))
    return;

  MCPDInit(n, entrystate, exitstate, s);
}

static void CMarkovCPD::MCPDAddTrack(CMCPDState &s, CMatrixDouble &xy,
                                     const int k) {

  int i = 0;
  int j = 0;
  int n = 0;
  double s0 = 0;
  double s1 = 0;

  n = s.m_n;

  if (!CAp::Assert(k >= 0, __FUNCTION__ + ": K<0"))
    return;

  if (!CAp::Assert(CAp::Cols(xy) >= n, __FUNCTION__ + ": Cols(XY)<N"))
    return;

  if (!CAp::Assert(CAp::Rows(xy) >= k, __FUNCTION__ + ": Rows(XY)<K"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(xy, k, n),
                   __FUNCTION__ + ": XY contains infinite or NaN elements"))
    return;
  for (i = 0; i <= k - 1; i++) {
    for (j = 0; j <= n - 1; j++) {

      if (!CAp::Assert((double)(xy[i][j]) >= 0.0,
                       __FUNCTION__ + ": XY contains negative elements"))
        return;
    }
  }

  if (k < 2)
    return;

  if (CAp::Rows(s.m_data) < s.m_npairs + k - 1)
    CApServ::RMatrixResize(
        s.m_data, MathMax(2 * CAp::Rows(s.m_data), s.m_npairs + k - 1), 2 * n);

  for (i = 0; i <= k - 2; i++) {
    s0 = 0;
    s1 = 0;
    for (j = 0; j <= n - 1; j++) {

      if (s.m_states[j] >= 0)
        s0 = s0 + xy[i][j];

      if (s.m_states[j] <= 0)
        s1 = s1 + xy[i + 1][j];
    }

    if (s0 > 0.0 && s1 > 0.0) {
      for (j = 0; j <= n - 1; j++) {

        if (s.m_states[j] >= 0)
          s.m_data[s.m_npairs].Set(j, xy[i][j] / s0);
        else
          s.m_data[s.m_npairs].Set(j, 0.0);

        if (s.m_states[j] <= 0)
          s.m_data[s.m_npairs].Set(n + j, xy[i + 1][j] / s1);
        else
          s.m_data[s.m_npairs].Set(n + j, 0.0);
      }

      s.m_npairs = s.m_npairs + 1;
    }
  }
}

static void CMarkovCPD::MCPDSetEC(CMCPDState &s, CMatrixDouble &ec) {

  int i = 0;
  int j = 0;
  int n = 0;

  n = s.m_n;

  if (!CAp::Assert(CAp::Cols(ec) >= n, __FUNCTION__ + ": Cols(EC)<N"))
    return;

  if (!CAp::Assert(CAp::Rows(ec) >= n, __FUNCTION__ + ": Rows(EC)<N"))
    return;

  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++) {

      if (!CAp::Assert(CMath::IsFinite(ec[i][j]) || CInfOrNaN::IsNaN(ec[i][j]),
                       "MCPDSetEC: EC containts infinite elements"))
        return;
      s.m_ec[i].Set(j, ec[i][j]);
    }
  }
}

static void CMarkovCPD::MCPDAddEC(CMCPDState &s, const int i, const int j,
                                  const double c) {

  if (!CAp::Assert(i >= 0, __FUNCTION__ + ": I<0"))
    return;

  if (!CAp::Assert(i < s.m_n, __FUNCTION__ + ": I>=N"))
    return;

  if (!CAp::Assert(j >= 0, __FUNCTION__ + ": J<0"))
    return;

  if (!CAp::Assert(j < s.m_n, __FUNCTION__ + ": J>=N"))
    return;

  if (!CAp::Assert(CInfOrNaN::IsNaN(c) || CMath::IsFinite(c),
                   "MCPDAddEC: C is not finite number or NAN"))
    return;
  s.m_ec[i].Set(j, c);
}

static void CMarkovCPD::MCPDSetBC(CMCPDState &s, CMatrixDouble &bndl,
                                  CMatrixDouble &bndu) {

  int i = 0;
  int j = 0;
  int n = 0;

  n = s.m_n;

  if (!CAp::Assert(CAp::Cols(bndl) >= n, __FUNCTION__ + ": Cols(BndL)<N"))
    return;

  if (!CAp::Assert(CAp::Rows(bndl) >= n, __FUNCTION__ + ": Rows(BndL)<N"))
    return;

  if (!CAp::Assert(CAp::Cols(bndu) >= n, __FUNCTION__ + ": Cols(BndU)<N"))
    return;

  if (!CAp::Assert(CAp::Rows(bndu) >= n, __FUNCTION__ + ": Rows(BndU)<N"))
    return;

  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++) {

      if (!CAp::Assert(CMath::IsFinite(bndl[i][j]) ||
                           CInfOrNaN::IsNegativeInfinity(bndl[i][j]),
                       "MCPDSetBC: BndL containts NAN or +INF"))
        return;

      if (!CAp::Assert(CMath::IsFinite(bndu[i][j]) ||
                           CInfOrNaN::IsPositiveInfinity(bndu[i][j]),
                       "MCPDSetBC: BndU containts NAN or -INF"))
        return;

      s.m_bndl[i].Set(j, bndl[i][j]);
      s.m_bndu[i].Set(j, bndu[i][j]);
    }
  }
}

static void CMarkovCPD::MCPDAddBC(CMCPDState &s, const int i, const int j,
                                  double bndl, double bndu) {

  if (!CAp::Assert(i >= 0, __FUNCTION__ + ": I<0"))
    return;

  if (!CAp::Assert(i < s.m_n, __FUNCTION__ + ": I>=N"))
    return;

  if (!CAp::Assert(j >= 0, __FUNCTION__ + ": J<0"))
    return;

  if (!CAp::Assert(j < s.m_n, __FUNCTION__ + ": J>=N"))
    return;

  if (!CAp::Assert(CMath::IsFinite(bndl) || CInfOrNaN::IsNegativeInfinity(bndl),
                   "MCPDAddBC: BndL is NAN or +INF"))
    return;

  if (!CAp::Assert(CMath::IsFinite(bndu) || CInfOrNaN::IsPositiveInfinity(bndu),
                   "MCPDAddBC: BndU is NAN or -INF"))
    return;

  s.m_bndl[i].Set(j, bndl);
  s.m_bndu[i].Set(j, bndu);
}

static void CMarkovCPD::MCPDSetLC(CMCPDState &s, CMatrixDouble &c, int &ct[],
                                  const int k) {

  int i = 0;
  int j = 0;
  int n = 0;

  n = s.m_n;

  if (!CAp::Assert(CAp::Cols(c) >= n * n + 1, __FUNCTION__ + ": Cols(C)<N*N+1"))
    return;

  if (!CAp::Assert(CAp::Rows(c) >= k, __FUNCTION__ + ": Rows(C)<K"))
    return;

  if (!CAp::Assert(CAp::Len(ct) >= k, __FUNCTION__ + ": Len(CT)<K"))
    return;

  if (!CAp::Assert(CApServ::IsFiniteMatrix(c, k, n * n + 1),
                   __FUNCTION__ + ": C contains infinite or NaN values!"))
    return;

  CApServ::RMatrixSetLengthAtLeast(s.m_c, k, n * n + 1);

  CApServ::IVectorSetLengthAtLeast(s.m_ct, k);

  for (i = 0; i <= k - 1; i++) {
    for (j = 0; j <= n * n; j++)
      s.m_c[i].Set(j, c[i][j]);
    s.m_ct[i] = ct[i];
  }
  s.m_ccnt = k;
}

static void CMarkovCPD::MCPDSetTikhonovRegularizer(CMCPDState &s,
                                                   const double v) {

  if (!CAp::Assert(CMath::IsFinite(v), __FUNCTION__ + ": V is infinite or NAN"))
    return;

  if (!CAp::Assert(v >= 0.0, __FUNCTION__ + ": V is less than zero"))
    return;

  s.m_regterm = v;
}

static void CMarkovCPD::MCPDSetPrior(CMCPDState &s, CMatrixDouble &cpp) {

  int i = 0;
  int j = 0;
  int n = 0;

  CMatrixDouble pp;
  pp = cpp;

  n = s.m_n;

  if (!CAp::Assert(CAp::Cols(pp) >= n, __FUNCTION__ + ": Cols(PP)<N"))
    return;

  if (!CAp::Assert(CAp::Rows(pp) >= n, __FUNCTION__ + ": Rows(PP)<K"))
    return;

  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++) {

      if (!CAp::Assert(CMath::IsFinite(pp[i][j]),
                       __FUNCTION__ + ": PP containts infinite elements"))
        return;

      if (!CAp::Assert(pp[i][j] >= 0.0 && pp[i][j] <= 1.0,
                       __FUNCTION__ +
                           ": PP[i][j] is less than 0.0 or greater than 1.0"))
        return;

      s.m_priorp[i].Set(j, pp[i][j]);
    }
  }
}

static void CMarkovCPD::MCPDSetPredictionWeights(CMCPDState &s, double &pw[]) {

  int i = 0;
  int n = 0;

  n = s.m_n;

  if (!CAp::Assert(CAp::Len(pw) >= n, __FUNCTION__ + ": Length(PW)<N"))
    return;

  for (i = 0; i <= n - 1; i++) {

    if (!CAp::Assert(CMath::IsFinite(pw[i]),
                     __FUNCTION__ + ": PW containts infinite or NAN elements"))
      return;

    if (!CAp::Assert(pw[i] >= 0.0,
                     __FUNCTION__ + ": PW containts negative elements"))
      return;

    s.m_pw[i] = pw[i];
  }
}

static void CMarkovCPD::MCPDSolve(CMCPDState &s) {

  int n = 0;
  int npairs = 0;
  int ccnt = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int k2 = 0;
  double v = 0;
  double vv = 0;
  int i_ = 0;
  int i1_ = 0;

  n = s.m_n;
  npairs = s.m_npairs;

  s.m_repterminationtype = 0;
  s.m_repinneriterationscount = 0;
  s.m_repouteriterationscount = 0;
  s.m_repnfev = 0;
  for (k = 0; k <= n - 1; k++) {
    for (k2 = 0; k2 <= n - 1; k2++)
      s.m_p[k].Set(k2, CInfOrNaN::NaN());
  }

  for (i = 0; i <= n - 1; i++) {

    if (s.m_pw[i] == 0.0) {

      v = 0;
      k = 0;
      for (j = 0; j <= npairs - 1; j++) {

        if (s.m_data[j][n + i] != 0.0) {
          v = v + s.m_data[j][n + i];
          k = k + 1;
        }
      }

      if (k != 0)
        s.m_effectivew[i] = k / v;
      else
        s.m_effectivew[i] = 1.0;
    } else
      s.m_effectivew[i] = s.m_pw[i];
  }

  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      s.m_h[i * n + j] = 2 * s.m_regterm;
  }

  for (k = 0; k <= npairs - 1; k++) {
    for (i = 0; i <= n - 1; i++) {
      for (j = 0; j <= n - 1; j++)
        s.m_h[i * n + j] =
            s.m_h[i * n + j] +
            2 * CMath::Sqr(s.m_effectivew[i]) * CMath::Sqr(s.m_data[k][j]);
    }
  }

  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++) {

      if (s.m_h[i * n + j] == 0.0)
        s.m_h[i * n + j] = 1;
    }
  }

  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++) {

      s.m_effectivebndl[i * n + j] = 0.0;

      if (s.m_states[i] > 0 || s.m_states[j] < 0)
        s.m_effectivebndu[i * n + j] = 0.0;
      else
        s.m_effectivebndu[i * n + j] = 1.0;

      if (CMath::IsFinite(s.m_bndl[i][j]) &&
          s.m_bndl[i][j] > s.m_effectivebndl[i * n + j])
        s.m_effectivebndl[i * n + j] = s.m_bndl[i][j];

      if (CMath::IsFinite(s.m_bndu[i][j]) &&
          s.m_bndu[i][j] < s.m_effectivebndu[i * n + j])
        s.m_effectivebndu[i * n + j] = s.m_bndu[i][j];

      if (s.m_effectivebndl[i * n + j] > s.m_effectivebndu[i * n + j]) {
        s.m_repterminationtype = -3;
        return;
      }

      if (CMath::IsFinite(s.m_ec[i][j])) {

        if (s.m_ec[i][j] < s.m_effectivebndl[i * n + j] ||
            s.m_ec[i][j] > s.m_effectivebndu[i * n + j]) {
          s.m_repterminationtype = -3;
          return;
        }

        s.m_effectivebndl[i * n + j] = s.m_ec[i][j];
        s.m_effectivebndu[i * n + j] = s.m_ec[i][j];
      }
    }
  }

  CApServ::RMatrixSetLengthAtLeast(s.m_effectivec, s.m_ccnt + n, n * n + 1);

  CApServ::IVectorSetLengthAtLeast(s.m_effectivect, s.m_ccnt + n);
  ccnt = s.m_ccnt;
  for (i = 0; i <= s.m_ccnt - 1; i++) {
    for (j = 0; j <= n * n; j++)
      s.m_effectivec[i].Set(j, s.m_c[i][j]);
    s.m_effectivect[i] = s.m_ct[i];
  }

  for (i = 0; i <= n - 1; i++) {

    if (s.m_states[i] >= 0) {
      for (k = 0; k <= n * n - 1; k++)
        s.m_effectivec[ccnt].Set(k, 0);
      for (k = 0; k <= n - 1; k++)
        s.m_effectivec[ccnt].Set(k * n + i, 1);

      s.m_effectivec[ccnt].Set(n * n, 1.0);
      s.m_effectivect[ccnt] = 0;
      ccnt = ccnt + 1;
    }
  }

  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      s.m_tmpp[i * n + j] = 1.0 / (double)n;
  }

  CMinBLEIC::MinBLEICRestartFrom(s.m_bs, s.m_tmpp);
  CMinBLEIC::MinBLEICSetBC(s.m_bs, s.m_effectivebndl, s.m_effectivebndu);
  CMinBLEIC::MinBLEICSetLC(s.m_bs, s.m_effectivec, s.m_effectivect, ccnt);
  CMinBLEIC::MinBLEICSetInnerCond(s.m_bs, 0, 0, m_xtol);
  CMinBLEIC::MinBLEICSetOuterCond(s.m_bs, m_xtol, 1.0E-5);
  CMinBLEIC::MinBLEICSetPrecDiag(s.m_bs, s.m_h);

  while (CMinBLEIC::MinBLEICIteration(s.m_bs)) {

    if (!CAp::Assert(s.m_bs.m_needfg, __FUNCTION__ + ": internal error"))
      return;

    if (s.m_bs.m_needfg) {

      s.m_bs.m_f = 0.0;
      vv = s.m_regterm;
      for (i = 0; i <= n - 1; i++) {
        for (j = 0; j <= n - 1; j++) {
          s.m_bs.m_f = s.m_bs.m_f + vv * CMath::Sqr(s.m_bs.m_x[i * n + j] -
                                                    s.m_priorp[i][j]);
          s.m_bs.m_g[i * n + j] =
              2 * vv * (s.m_bs.m_x[i * n + j] - s.m_priorp[i][j]);
        }
      }

      for (k = 0; k <= npairs - 1; k++) {
        for (i = 0; i <= n - 1; i++) {
          i1_ = (0) - (i * n);
          v = 0.0;
          for (i_ = i * n; i_ <= i * n + n - 1; i_++)
            v += s.m_bs.m_x[i_] * s.m_data[k][i_ + i1_];
          vv = s.m_effectivew[i];
          s.m_bs.m_f = s.m_bs.m_f + CMath::Sqr(vv * (v - s.m_data[k][n + i]));
          for (j = 0; j <= n - 1; j++) {
            s.m_bs.m_g[i * n + j] =
                s.m_bs.m_g[i * n + j] +
                2 * vv * vv * (v - s.m_data[k][n + i]) * s.m_data[k][j];
          }
        }
      }

      continue;
    }
  }

  CMinBLEIC::MinBLEICResultsBuf(s.m_bs, s.m_tmpp, s.m_br);
  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++)
      s.m_p[i].Set(j, s.m_tmpp[i * n + j]);
  }

  s.m_repterminationtype = s.m_br.m_terminationtype;
  s.m_repinneriterationscount = s.m_br.m_inneriterationscount;
  s.m_repouteriterationscount = s.m_br.m_outeriterationscount;
  s.m_repnfev = s.m_br.m_nfev;
}

static void CMarkovCPD::MCPDResults(CMCPDState &s, CMatrixDouble &p,
                                    CMCPDReport &rep) {

  int i = 0;
  int j = 0;

  p.Resize(s.m_n, s.m_n);

  for (i = 0; i <= s.m_n - 1; i++) {
    for (j = 0; j <= s.m_n - 1; j++)
      p[i].Set(j, s.m_p[i][j]);
  }

  rep.m_terminationtype = s.m_repterminationtype;
  rep.m_inneriterationscount = s.m_repinneriterationscount;
  rep.m_outeriterationscount = s.m_repouteriterationscount;
  rep.m_nfev = s.m_repnfev;
}

static void CMarkovCPD::MCPDInit(const int n, const int entrystate,
                                 const int exitstate, CMCPDState &s) {

  int i = 0;
  int j = 0;

  if (!CAp::Assert(n >= 1, __FUNCTION__ + ": N<1"))
    return;

  s.m_n = n;

  ArrayResizeAL(s.m_states, n);
  for (i = 0; i <= n - 1; i++)
    s.m_states[i] = 0;

  if (entrystate >= 0)
    s.m_states[entrystate] = 1;

  if (exitstate >= 0)
    s.m_states[exitstate] = -1;

  s.m_npairs = 0;
  s.m_regterm = 1.0E-8;
  s.m_ccnt = 0;

  s.m_p.Resize(n, n);
  s.m_ec.Resize(n, n);
  s.m_bndl.Resize(n, n);
  s.m_bndu.Resize(n, n);
  ArrayResizeAL(s.m_pw, n);
  s.m_priorp.Resize(n, n);
  ArrayResizeAL(s.m_tmpp, n * n);
  ArrayResizeAL(s.m_effectivew, n);
  ArrayResizeAL(s.m_effectivebndl, n * n);
  ArrayResizeAL(s.m_effectivebndu, n * n);
  ArrayResizeAL(s.m_h, n * n);

  for (i = 0; i <= n - 1; i++) {
    for (j = 0; j <= n - 1; j++) {
      s.m_p[i].Set(j, 0.0);
      s.m_priorp[i].Set(j, 0.0);
      s.m_bndl[i].Set(j, CInfOrNaN::NegativeInfinity());
      s.m_bndu[i].Set(j, CInfOrNaN::PositiveInfinity());
      s.m_ec[i].Set(j, CInfOrNaN::NaN());
    }
    s.m_pw[i] = 0.0;
    s.m_priorp[i].Set(i, 1.0);
  }

  s.m_data.Resize(1, 2 * n);
  for (i = 0; i <= 2 * n - 1; i++)
    s.m_data[0].Set(i, 0.0);
  for (i = 0; i <= n * n - 1; i++)
    s.m_tmpp[i] = 0.0;

  CMinBLEIC::MinBLEICCreate(n * n, s.m_tmpp, s.m_bs);
}

class CMLPReport {
public:
  int m_ngrad;
  int m_nhess;
  int m_ncholesky;

  CMLPReport(void);
  ~CMLPReport(void);

  void Copy(CMLPReport &obj);
};

CMLPReport::CMLPReport(void) {
}

CMLPReport::~CMLPReport(void) {
}

void CMLPReport::Copy(CMLPReport &obj) {

  m_ngrad = obj.m_ngrad;
  m_nhess = obj.m_nhess;
  m_ncholesky = obj.m_ncholesky;
}

class CMLPReportShell {
private:
  CMLPReport m_innerobj;

public:
  CMLPReportShell(void);
  CMLPReportShell(CMLPReport &obj);
  ~CMLPReportShell(void);

  int GetNGrad(void);
  void SetNGrad(const int i);
  int GetNHess(void);
  void SetNHess(const int i);
  int GetNCholesky(void);
  void SetNCholesky(const int i);
  CMLPReport *GetInnerObj(void);
};

CMLPReportShell::CMLPReportShell(void) {
}

CMLPReportShell::CMLPReportShell(CMLPReport &obj) {

  m_innerobj.Copy(obj);
}

CMLPReportShell::~CMLPReportShell(void) {
}

int CMLPReportShell::GetNGrad(void) {

  return (m_innerobj.m_ngrad);
}

void CMLPReportShell::SetNGrad(const int i) {

  m_innerobj.m_ngrad = i;
}

int CMLPReportShell::GetNHess(void) {

  return (m_innerobj.m_nhess);
}

void CMLPReportShell::SetNHess(const int i) {

  m_innerobj.m_nhess = i;
}

int CMLPReportShell::GetNCholesky(void) {

  return (m_innerobj.m_ncholesky);
}

void CMLPReportShell::SetNCholesky(const int i) {

  m_innerobj.m_ncholesky = i;
}

CMLPReport *CMLPReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMLPCVReport {
public:
  double m_relclserror;
  double m_avgce;
  double m_rmserror;
  double m_avgerror;
  double m_avgrelerror;

  CMLPCVReport(void);
  ~CMLPCVReport(void);

  void Copy(CMLPCVReport &obj);
};

CMLPCVReport::CMLPCVReport(void) {
}

CMLPCVReport::~CMLPCVReport(void) {
}

void CMLPCVReport::Copy(CMLPCVReport &obj) {

  m_relclserror = obj.m_relclserror;
  m_avgce = obj.m_avgce;
  m_rmserror = obj.m_rmserror;
  m_avgerror = obj.m_avgerror;
  m_avgrelerror = obj.m_avgrelerror;
}

class CMLPCVReportShell {
private:
  CMLPCVReport m_innerobj;

public:
  CMLPCVReportShell(void);
  CMLPCVReportShell(CMLPCVReport &obj);
  ~CMLPCVReportShell(void);

  double GetRelClsError(void);
  void SetRelClsError(const double d);
  double GetAvgCE(void);
  void SetAvgCE(const double d);
  double GetRMSError(void);
  void SetRMSError(const double d);
  double GetAvgError(void);
  void SetAvgError(const double d);
  double GetAvgRelError(void);
  void SetAvgRelError(const double d);
  CMLPCVReport *GetInnerObj(void);
};

CMLPCVReportShell::CMLPCVReportShell(void) {
}

CMLPCVReportShell::CMLPCVReportShell(CMLPCVReport &obj) {

  m_innerobj.Copy(obj);
}

CMLPCVReportShell::~CMLPCVReportShell(void) {
}

double CMLPCVReportShell::GetRelClsError(void) {

  return (m_innerobj.m_relclserror);
}

void CMLPCVReportShell::SetRelClsError(const double d) {

  m_innerobj.m_relclserror = d;
}

double CMLPCVReportShell::GetAvgCE(void) {

  return (m_innerobj.m_avgce);
}

void CMLPCVReportShell::SetAvgCE(const double d) {

  m_innerobj.m_avgce = d;
}

double CMLPCVReportShell::GetRMSError(void) {

  return (m_innerobj.m_rmserror);
}

void CMLPCVReportShell::SetRMSError(const double d) {

  m_innerobj.m_rmserror = d;
}

double CMLPCVReportShell::GetAvgError(void) {

  return (m_innerobj.m_avgerror);
}

void CMLPCVReportShell::SetAvgError(const double d) {

  m_innerobj.m_avgerror = d;
}

double CMLPCVReportShell::GetAvgRelError(void) {

  return (m_innerobj.m_avgrelerror);
}

void CMLPCVReportShell::SetAvgRelError(const double d) {

  m_innerobj.m_avgrelerror = d;
}

CMLPCVReport *CMLPCVReportShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMLPTrain {
private:
  static void MLPKFoldCVGeneral(CMultilayerPerceptron &n, CMatrixDouble &xy,
                                const int npoints, const double decay,
                                const int restarts, const int foldscount,
                                const bool lmalgorithm, const double wstep,
                                const int maxits, int &info, CMLPReport &rep,
                                CMLPCVReport &cvrep);
  static void MLPKFoldSplit(CMatrixDouble &xy, const int npoints,
                            const int nclasses, const int foldscount,
                            const bool stratifiedsplits, int &folds[]);

public:
  static const double m_mindecay;

  CMLPTrain(void);
  ~CMLPTrain(void);

  static void MLPTrainLM(CMultilayerPerceptron &network, CMatrixDouble &xy,
                         const int npoints, double decay, const int restarts,
                         int &info, CMLPReport &rep);
  static void MLPTrainLBFGS(CMultilayerPerceptron &network, CMatrixDouble &xy,
                            const int npoints, double decay, const int restarts,
                            const double wstep, int maxits, int &info,
                            CMLPReport &rep);
  static void MLPTrainES(CMultilayerPerceptron &network, CMatrixDouble &trnxy,
                         const int trnsize, CMatrixDouble &valxy,
                         const int valsize, const double decay,
                         const int restarts, int &info, CMLPReport &rep);
  static void MLPKFoldCVLBFGS(CMultilayerPerceptron &network, CMatrixDouble &xy,
                              const int npoints, const double decay,
                              const int restarts, const double wstep,
                              const int maxits, const int foldscount, int &info,
                              CMLPReport &rep, CMLPCVReport &cvrep);
  static void MLPKFoldCVLM(CMultilayerPerceptron &network, CMatrixDouble &xy,
                           const int npoints, const double decay,
                           const int restarts, int foldscount, int &info,
                           CMLPReport &rep, CMLPCVReport &cvrep);
};

const double CMLPTrain::m_mindecay = 0.001;

CMLPTrain::CMLPTrain(void) {
}

CMLPTrain::~CMLPTrain(void) {
}

static void CMLPTrain::MLPTrainLM(CMultilayerPerceptron &network,
                                  CMatrixDouble &xy, const int npoints,
                                  double decay, const int restarts, int &info,
                                  CMLPReport &rep) {

  int nin = 0;
  int nout = 0;
  int wcount = 0;
  double lmm_ftol = 0;
  double lmsteptol = 0;
  int i = 0;
  int k = 0;
  double v = 0;
  double e = 0;
  double enew = 0;
  double xnorm2 = 0;
  double stepnorm = 0;
  bool spd;
  double nu = 0;
  double lambdav = 0;
  double lambdaup = 0;
  double lambdadown = 0;
  int pass = 0;
  double ebest = 0;
  int invinfo = 0;
  int solverinfo = 0;
  int i_ = 0;

  double g[];
  double d[];
  double x[];
  double y[];
  double wbase[];
  double wdir[];
  double wt[];
  double wx[];
  double wbest[];

  CMatrixDouble h;
  CMatrixDouble hmod;
  CMatrixDouble z;

  CMinLBFGSReport internalrep;
  CMinLBFGSState state;
  CMatInvReport invrep;
  CDenseSolverReport solverrep;

  info = 0;

  CMLPBase::MLPProperties(network, nin, nout, wcount);

  lambdaup = 10;
  lambdadown = 0.3;
  lmm_ftol = 0.001;
  lmsteptol = 0.001;

  if (npoints <= 0 || restarts < 1) {
    info = -1;
    return;
  }

  if (CMLPBase::MLPIsSoftMax(network)) {
    for (i = 0; i <= npoints - 1; i++) {

      if ((int)MathRound(xy[i][nin]) < 0 ||
          (int)MathRound(xy[i][nin]) >= nout) {
        info = -2;
        return;
      }
    }
  }

  decay = MathMax(decay, m_mindecay);
  info = 2;

  rep.m_ngrad = 0;
  rep.m_nhess = 0;
  rep.m_ncholesky = 0;

  CMLPBase::MLPInitPreprocessor(network, xy, npoints);

  ArrayResizeAL(g, wcount);
  h.Resize(wcount, wcount);
  hmod.Resize(wcount, wcount);
  ArrayResizeAL(wbase, wcount);
  ArrayResizeAL(wdir, wcount);
  ArrayResizeAL(wbest, wcount);
  ArrayResizeAL(wt, wcount);
  ArrayResizeAL(wx, wcount);

  ebest = CMath::m_maxrealnumber;

  for (pass = 1; pass <= restarts; pass++) {

    CMLPBase::MLPRandomize(network);

    for (i_ = 0; i_ <= wcount - 1; i_++)
      wbase[i_] = network.m_weights[i_];

    CMinLBFGS::MinLBFGSCreate(wcount, (int)(MathMin(wcount, 5)), wbase, state);
    CMinLBFGS::MinLBFGSSetCond(state, 0, 0, 0, (int)(MathMax(25, wcount)));
    while (CMinLBFGS::MinLBFGSIteration(state)) {

      for (i_ = 0; i_ <= wcount - 1; i_++)
        network.m_weights[i_] = state.m_x[i_];

      CMLPBase::MLPGradBatch(network, xy, npoints, state.m_f, state.m_g);

      v = 0.0;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        v += network.m_weights[i_] * network.m_weights[i_];
      state.m_f = state.m_f + 0.5 * decay * v;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        state.m_g[i_] = state.m_g[i_] + decay * network.m_weights[i_];

      rep.m_ngrad = rep.m_ngrad + 1;
    }

    CMinLBFGS::MinLBFGSResults(state, wbase, internalrep);
    for (i_ = 0; i_ <= wcount - 1; i_++)
      network.m_weights[i_] = wbase[i_];

    CMLPBase::MLPHessianBatch(network, xy, npoints, e, g, h);
    v = 0.0;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      v += network.m_weights[i_] * network.m_weights[i_];

    e = e + 0.5 * decay * v;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      g[i_] = g[i_] + decay * network.m_weights[i_];
    for (k = 0; k <= wcount - 1; k++)
      h[k].Set(k, h[k][k] + decay);

    rep.m_nhess = rep.m_nhess + 1;
    lambdav = 0.001;
    nu = 2;

    while (true) {

      for (i = 0; i <= wcount - 1; i++) {
        for (i_ = 0; i_ <= wcount - 1; i_++)
          hmod[i].Set(i_, h[i][i_]);
        hmod[i].Set(i, hmod[i][i] + lambdav);
      }

      spd = CTrFac::SPDMatrixCholesky(hmod, wcount, true);
      rep.m_ncholesky = rep.m_ncholesky + 1;

      if (!spd) {
        lambdav = lambdav * lambdaup * nu;
        nu = nu * 2;
        continue;
      }

      CDenseSolver::SPDMatrixCholeskySolve(hmod, wcount, true, g, solverinfo,
                                           solverrep, wdir);

      if (solverinfo < 0) {
        lambdav = lambdav * lambdaup * nu;
        nu = nu * 2;
        continue;
      }
      for (i_ = 0; i_ <= wcount - 1; i_++)
        wdir[i_] = -1 * wdir[i_];

      for (i_ = 0; i_ <= wcount - 1; i_++)
        network.m_weights[i_] = network.m_weights[i_] + wdir[i_];
      xnorm2 = 0.0;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        xnorm2 += network.m_weights[i_] * network.m_weights[i_];

      stepnorm = 0.0;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        stepnorm += wdir[i_] * wdir[i_];
      stepnorm = MathSqrt(stepnorm);

      enew = CMLPBase::MLPError(network, xy, npoints) + 0.5 * decay * xnorm2;

      if (stepnorm < lmsteptol * (1 + MathSqrt(xnorm2)))
        break;

      if (enew > e) {
        lambdav = lambdav * lambdaup * nu;
        nu = nu * 2;
        continue;
      }

      CMatInv::RMatrixTrInverse(hmod, wcount, true, false, invinfo, invrep);

      if (invinfo <= 0) {

        info = -9;
        return;
      }

      for (i_ = 0; i_ <= wcount - 1; i_++)
        wbase[i_] = network.m_weights[i_];
      for (i = 0; i <= wcount - 1; i++)
        wt[i] = 0;

      CMinLBFGS::MinLBFGSCreateX(wcount, wcount, wt, 1, 0.0, state);
      CMinLBFGS::MinLBFGSSetCond(state, 0, 0, 0, 5);
      while (CMinLBFGS::MinLBFGSIteration(state)) {

        for (i = 0; i <= wcount - 1; i++) {
          v = 0.0;
          for (i_ = i; i_ <= wcount - 1; i_++)
            v += state.m_x[i_] * hmod[i][i_];
          network.m_weights[i] = wbase[i] + v;
        }

        CMLPBase::MLPGradBatch(network, xy, npoints, state.m_f, g);
        for (i = 0; i <= wcount - 1; i++)
          state.m_g[i] = 0;
        for (i = 0; i <= wcount - 1; i++) {
          v = g[i];
          for (i_ = i; i_ <= wcount - 1; i_++)
            state.m_g[i_] = state.m_g[i_] + v * hmod[i][i_];
        }

        v = 0.0;
        for (i_ = 0; i_ <= wcount - 1; i_++)
          v += network.m_weights[i_] * network.m_weights[i_];
        state.m_f = state.m_f + 0.5 * decay * v;
        for (i = 0; i <= wcount - 1; i++) {
          v = decay * network.m_weights[i];
          for (i_ = i; i_ <= wcount - 1; i_++)
            state.m_g[i_] = state.m_g[i_] + v * hmod[i][i_];
        }

        rep.m_ngrad = rep.m_ngrad + 1;
      }

      CMinLBFGS::MinLBFGSResults(state, wt, internalrep);

      for (i = 0; i <= wcount - 1; i++) {
        v = 0.0;
        for (i_ = i; i_ <= wcount - 1; i_++)
          v += wt[i_] * hmod[i][i_];
        network.m_weights[i] = wbase[i] + v;
      }

      CMLPBase::MLPHessianBatch(network, xy, npoints, e, g, h);
      v = 0.0;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        v += network.m_weights[i_] * network.m_weights[i_];

      e = e + 0.5 * decay * v;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        g[i_] = g[i_] + decay * network.m_weights[i_];
      for (k = 0; k <= wcount - 1; k++)
        h[k].Set(k, h[k][k] + decay);
      rep.m_nhess = rep.m_nhess + 1;

      lambdav = lambdav * lambdadown;
      nu = 2;
    }

    v = 0.0;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      v += network.m_weights[i_] * network.m_weights[i_];

    e = 0.5 * decay * v + CMLPBase::MLPError(network, xy, npoints);

    if (e < ebest) {
      ebest = e;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        wbest[i_] = network.m_weights[i_];
    }
  }

  for (i_ = 0; i_ <= wcount - 1; i_++)
    network.m_weights[i_] = wbest[i_];
}

static void CMLPTrain::MLPTrainLBFGS(CMultilayerPerceptron &network,
                                     CMatrixDouble &xy, const int npoints,
                                     double decay, const int restarts,
                                     const double wstep, int maxits, int &info,
                                     CMLPReport &rep) {

  int i = 0;
  int pass = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  double e = 0;
  double v = 0;
  double ebest = 0;

  double w[];
  double wbest[];

  CMinLBFGSReport internalrep;
  CMinLBFGSState state;
  int i_ = 0;

  info = 0;

  if (wstep == 0.0 && maxits == 0) {
    info = -8;
    return;
  }

  if (((npoints <= 0 || restarts < 1) || wstep < 0.0) || maxits < 0) {
    info = -1;
    return;
  }

  CMLPBase::MLPProperties(network, nin, nout, wcount);

  if (CMLPBase::MLPIsSoftMax(network)) {
    for (i = 0; i <= npoints - 1; i++) {

      if ((int)MathRound(xy[i][nin]) < 0 ||
          (int)MathRound(xy[i][nin]) >= nout) {
        info = -2;
        return;
      }
    }
  }

  decay = MathMax(decay, m_mindecay);
  info = 2;

  CMLPBase::MLPInitPreprocessor(network, xy, npoints);

  ArrayResizeAL(w, wcount);
  ArrayResizeAL(wbest, wcount);

  ebest = CMath::m_maxrealnumber;

  rep.m_ncholesky = 0;
  rep.m_nhess = 0;
  rep.m_ngrad = 0;
  for (pass = 1; pass <= restarts; pass++) {

    CMLPBase::MLPRandomize(network);
    for (i_ = 0; i_ <= wcount - 1; i_++)
      w[i_] = network.m_weights[i_];

    CMinLBFGS::MinLBFGSCreate(wcount, (int)(MathMin(wcount, 10)), w, state);
    CMinLBFGS::MinLBFGSSetCond(state, 0.0, 0.0, wstep, maxits);
    while (CMinLBFGS::MinLBFGSIteration(state)) {
      for (i_ = 0; i_ <= wcount - 1; i_++)
        network.m_weights[i_] = state.m_x[i_];

      CMLPBase::MLPGradNBatch(network, xy, npoints, state.m_f, state.m_g);
      v = 0.0;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        v += network.m_weights[i_] * network.m_weights[i_];
      state.m_f = state.m_f + 0.5 * decay * v;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        state.m_g[i_] = state.m_g[i_] + decay * network.m_weights[i_];
      rep.m_ngrad = rep.m_ngrad + 1;
    }

    CMinLBFGS::MinLBFGSResults(state, w, internalrep);
    for (i_ = 0; i_ <= wcount - 1; i_++)
      network.m_weights[i_] = w[i_];

    v = 0.0;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      v += network.m_weights[i_] * network.m_weights[i_];

    e = CMLPBase::MLPErrorN(network, xy, npoints) + 0.5 * decay * v;

    if (e < ebest) {
      for (i_ = 0; i_ <= wcount - 1; i_++)
        wbest[i_] = network.m_weights[i_];
      ebest = e;
    }
  }

  for (i_ = 0; i_ <= wcount - 1; i_++)
    network.m_weights[i_] = wbest[i_];
}

static void CMLPTrain::MLPTrainES(CMultilayerPerceptron &network,
                                  CMatrixDouble &trnxy, const int trnsize,
                                  CMatrixDouble &valxy, const int valsize,
                                  const double decay, const int restarts,
                                  int &info, CMLPReport &rep) {

  int i = 0;
  int pass = 0;
  int nin = 0;
  int nout = 0;
  int wcount = 0;
  double e = 0;
  double v = 0;
  double ebest = 0;
  int itbest = 0;
  double wstep = 0;
  int i_ = 0;

  double w[];
  double wbest[];
  double wfinal[];
  double efinal = 0;

  CMinLBFGSReport internalrep;
  CMinLBFGSState state;

  info = 0;
  wstep = 0.001;

  if (((trnsize <= 0 || valsize <= 0) || restarts < 1) || decay < 0.0) {
    info = -1;
    return;
  }

  CMLPBase::MLPProperties(network, nin, nout, wcount);

  if (CMLPBase::MLPIsSoftMax(network)) {
    for (i = 0; i <= trnsize - 1; i++) {

      if ((int)MathRound(trnxy[i][nin]) < 0 ||
          (int)MathRound(trnxy[i][nin]) >= nout) {
        info = -2;
        return;
      }
    }
    for (i = 0; i <= valsize - 1; i++) {

      if ((int)MathRound(valxy[i][nin]) < 0 ||
          (int)MathRound(valxy[i][nin]) >= nout) {
        info = -2;
        return;
      }
    }
  }

  info = 2;

  CMLPBase::MLPInitPreprocessor(network, trnxy, trnsize);

  ArrayResizeAL(w, wcount);
  ArrayResizeAL(wbest, wcount);
  ArrayResizeAL(wfinal, wcount);

  efinal = CMath::m_maxrealnumber;
  for (i = 0; i <= wcount - 1; i++)
    wfinal[i] = 0;

  rep.m_ncholesky = 0;
  rep.m_nhess = 0;
  rep.m_ngrad = 0;

  for (pass = 1; pass <= restarts; pass++) {

    CMLPBase::MLPRandomize(network);

    ebest = CMLPBase::MLPError(network, valxy, valsize);
    for (i_ = 0; i_ <= wcount - 1; i_++)
      wbest[i_] = network.m_weights[i_];

    itbest = 0;
    for (i_ = 0; i_ <= wcount - 1; i_++)
      w[i_] = network.m_weights[i_];

    CMinLBFGS::MinLBFGSCreate(wcount, (int)(MathMin(wcount, 10)), w, state);
    CMinLBFGS::MinLBFGSSetCond(state, 0.0, 0.0, wstep, 0);
    CMinLBFGS::MinLBFGSSetXRep(state, true);
    while (CMinLBFGS::MinLBFGSIteration(state)) {

      for (i_ = 0; i_ <= wcount - 1; i_++)
        network.m_weights[i_] = state.m_x[i_];

      CMLPBase::MLPGradNBatch(network, trnxy, trnsize, state.m_f, state.m_g);
      v = 0.0;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        v += network.m_weights[i_] * network.m_weights[i_];
      state.m_f = state.m_f + 0.5 * decay * v;
      for (i_ = 0; i_ <= wcount - 1; i_++)
        state.m_g[i_] = state.m_g[i_] + decay * network.m_weights[i_];
      rep.m_ngrad = rep.m_ngrad + 1;

      if (state.m_xupdated) {
        for (i_ = 0; i_ <= wcount - 1; i_++)
          network.m_weights[i_] = w[i_];

        e = CMLPBase::MLPError(network, valxy, valsize);

        if (e < ebest) {
          ebest = e;
          for (i_ = 0; i_ <= wcount - 1; i_++)
            wbest[i_] = network.m_weights[i_];
          itbest = internalrep.m_iterationscount;
        }

        if (internalrep.m_iterationscount > 30 &&
            (double)(internalrep.m_iterationscount) > (double)(1.5 * itbest)) {
          info = 6;
          break;
        }
      }
    }

    CMinLBFGS::MinLBFGSResults(state, w, internalrep);

    if (ebest < efinal) {
      for (i_ = 0; i_ <= wcount - 1; i_++)
        wfinal[i_] = wbest[i_];
      efinal = ebest;
    }
  }

  for (i_ = 0; i_ <= wcount - 1; i_++)
    network.m_weights[i_] = wfinal[i_];
}

static void CMLPTrain::MLPKFoldCVLBFGS(CMultilayerPerceptron &network,
                                       CMatrixDouble &xy, const int npoints,
                                       const double decay, const int restarts,
                                       const double wstep, const int maxits,
                                       const int foldscount, int &info,
                                       CMLPReport &rep, CMLPCVReport &cvrep) {

  info = 0;

  MLPKFoldCVGeneral(network, xy, npoints, decay, restarts, foldscount, false,
                    wstep, maxits, info, rep, cvrep);
}

static void CMLPTrain::MLPKFoldCVLM(CMultilayerPerceptron &network,
                                    CMatrixDouble &xy, const int npoints,
                                    const double decay, const int restarts,
                                    int foldscount, int &info, CMLPReport &rep,
                                    CMLPCVReport &cvrep) {

  info = 0;

  MLPKFoldCVGeneral(network, xy, npoints, decay, restarts, foldscount, true,
                    0.0, 0, info, rep, cvrep);
}

static void CMLPTrain::MLPKFoldCVGeneral(
    CMultilayerPerceptron &n, CMatrixDouble &xy, const int npoints,
    const double decay, const int restarts, const int foldscount,
    const bool lmalgorithm, const double wstep, const int maxits, int &info,
    CMLPReport &rep, CMLPCVReport &cvrep) {

  int i = 0;
  int fold = 0;
  int j = 0;
  int k = 0;
  int nin = 0;
  int nout = 0;
  int rowlen = 0;
  int wcount = 0;
  int nclasses = 0;
  int tssize = 0;
  int cvssize = 0;
  int relcnt = 0;
  int i_ = 0;

  int folds[];
  double x[];
  double y[];

  CMatrixDouble cvset;
  CMatrixDouble testset;

  CMultilayerPerceptron network;
  CMLPReport internalrep;

  info = 0;

  CMLPBase::MLPProperties(n, nin, nout, wcount);

  if (CMLPBase::MLPIsSoftMax(n)) {
    nclasses = nout;
    rowlen = nin + 1;
  } else {
    nclasses = -nout;
    rowlen = nin + nout;
  }

  if ((npoints <= 0 || foldscount < 2) || foldscount > npoints) {
    info = -1;
    return;
  }

  CMLPBase::MLPCopy(n, network);

  testset.Resize(npoints, rowlen);
  cvset.Resize(npoints, rowlen);
  ArrayResizeAL(x, nin);
  ArrayResizeAL(y, nout);

  MLPKFoldSplit(xy, npoints, nclasses, foldscount, false, folds);

  cvrep.m_relclserror = 0;
  cvrep.m_avgce = 0;
  cvrep.m_rmserror = 0;
  cvrep.m_avgerror = 0;
  cvrep.m_avgrelerror = 0;
  rep.m_ngrad = 0;
  rep.m_nhess = 0;
  rep.m_ncholesky = 0;
  relcnt = 0;

  for (fold = 0; fold <= foldscount - 1; fold++) {

    tssize = 0;
    cvssize = 0;
    for (i = 0; i <= npoints - 1; i++) {

      if (folds[i] == fold) {
        for (i_ = 0; i_ <= rowlen - 1; i_++)
          testset[tssize].Set(i_, xy[i][i_]);
        tssize = tssize + 1;
      } else {
        for (i_ = 0; i_ <= rowlen - 1; i_++)
          cvset[cvssize].Set(i_, xy[i][i_]);
        cvssize = cvssize + 1;
      }
    }

    if (lmalgorithm)
      MLPTrainLM(network, cvset, cvssize, decay, restarts, info, internalrep);
    else
      MLPTrainLBFGS(network, cvset, cvssize, decay, restarts, wstep, maxits,
                    info, internalrep);

    if (info < 0) {

      cvrep.m_relclserror = 0;
      cvrep.m_avgce = 0;
      cvrep.m_rmserror = 0;
      cvrep.m_avgerror = 0;
      cvrep.m_avgrelerror = 0;

      return;
    }

    rep.m_ngrad = rep.m_ngrad + internalrep.m_ngrad;
    rep.m_nhess = rep.m_nhess + internalrep.m_nhess;
    rep.m_ncholesky = rep.m_ncholesky + internalrep.m_ncholesky;

    if (CMLPBase::MLPIsSoftMax(network)) {

      cvrep.m_relclserror =
          cvrep.m_relclserror + CMLPBase::MLPClsError(network, testset, tssize);
      cvrep.m_avgce =
          cvrep.m_avgce + CMLPBase::MLPErrorN(network, testset, tssize);
    }

    for (i = 0; i <= tssize - 1; i++) {
      for (i_ = 0; i_ <= nin - 1; i_++)
        x[i_] = testset[i][i_];

      CMLPBase::MLPProcess(network, x, y);

      if (CMLPBase::MLPIsSoftMax(network)) {

        k = (int)MathRound(testset[i][nin]);
        for (j = 0; j <= nout - 1; j++) {

          if (j == k) {

            cvrep.m_rmserror = cvrep.m_rmserror + CMath::Sqr(y[j] - 1);
            cvrep.m_avgerror = cvrep.m_avgerror + MathAbs(y[j] - 1);
            cvrep.m_avgrelerror = cvrep.m_avgrelerror + MathAbs(y[j] - 1);
            relcnt = relcnt + 1;
          } else {

            cvrep.m_rmserror = cvrep.m_rmserror + CMath::Sqr(y[j]);
            cvrep.m_avgerror = cvrep.m_avgerror + MathAbs(y[j]);
          }
        }
      } else {

        for (j = 0; j <= nout - 1; j++) {
          cvrep.m_rmserror =
              cvrep.m_rmserror + CMath::Sqr(y[j] - testset[i][nin + j]);
          cvrep.m_avgerror =
              cvrep.m_avgerror + MathAbs(y[j] - testset[i][nin + j]);

          if (testset[i][nin + j] != 0.0) {
            cvrep.m_avgrelerror =
                cvrep.m_avgrelerror +
                MathAbs((y[j] - testset[i][nin + j]) / testset[i][nin + j]);
            relcnt = relcnt + 1;
          }
        }
      }
    }
  }

  if (CMLPBase::MLPIsSoftMax(network)) {
    cvrep.m_relclserror = cvrep.m_relclserror / npoints;
    cvrep.m_avgce = cvrep.m_avgce / (MathLog(2) * npoints);
  }

  cvrep.m_rmserror = MathSqrt(cvrep.m_rmserror / (npoints * nout));
  cvrep.m_avgerror = cvrep.m_avgerror / (npoints * nout);
  cvrep.m_avgrelerror = cvrep.m_avgrelerror / relcnt;
  info = 1;
}

static void CMLPTrain::MLPKFoldSplit(CMatrixDouble &xy, const int npoints,
                                     const int nclasses, const int foldscount,
                                     const bool stratifiedsplits,
                                     int &folds[]) {

  int i = 0;
  int j = 0;
  int k = 0;

  if (!CAp::Assert(npoints > 0, __FUNCTION__ + ": wrong NPoints!"))
    return;

  if (!CAp::Assert(nclasses > 1 || nclasses < 0,
                   __FUNCTION__ + ": wrong NClasses!"))
    return;

  if (!CAp::Assert(foldscount >= 2 && foldscount <= npoints,
                   __FUNCTION__ + " wrong FoldsCount!"))
    return;

  if (!CAp::Assert(!stratifiedsplits,
                   __FUNCTION__ + ": stratified splits are not supported!"))
    return;

  ArrayResizeAL(folds, npoints);
  for (i = 0; i <= npoints - 1; i++)
    folds[i] = i * foldscount / npoints;

  for (i = 0; i <= npoints - 2; i++) {
    j = i + CMath::RandomInteger(npoints - i);

    if (j != i) {
      k = folds[i];
      folds[i] = folds[j];
      folds[j] = k;
    }
  }
}

class CMLPEnsemble {
public:
  int m_ensemblesize;
  int m_nin;
  int m_nout;
  int m_wcount;
  bool m_issoftmax;
  bool m_postprocessing;
  int m_serializedlen;

  int m_structinfo[];
  double m_weights[];
  double m_columnmeans[];
  double m_columnsigmas[];
  double m_serializedmlp[];
  double m_tmpweights[];
  double m_tmpmeans[];
  double m_tmpsigmas[];
  double m_neurons[];
  double m_dfdnet[];
  double m_y[];

  CMLPEnsemble(void);
  ~CMLPEnsemble(void);

  void Copy(CMLPEnsemble &obj);
};

CMLPEnsemble::CMLPEnsemble(void) {
}

CMLPEnsemble::~CMLPEnsemble(void) {
}

void CMLPEnsemble::Copy(CMLPEnsemble &obj) {

  m_ensemblesize = obj.m_ensemblesize;
  m_nin = obj.m_nin;
  m_nout = obj.m_nout;
  m_wcount = obj.m_wcount;
  m_issoftmax = obj.m_issoftmax;
  m_postprocessing = obj.m_postprocessing;
  m_serializedlen = obj.m_serializedlen;

  ArrayCopy(m_structinfo, obj.m_structinfo);
  ArrayCopy(m_weights, obj.m_weights);
  ArrayCopy(m_columnmeans, obj.m_columnmeans);
  ArrayCopy(m_columnsigmas, obj.m_columnsigmas);
  ArrayCopy(m_serializedmlp, obj.m_serializedmlp);
  ArrayCopy(m_tmpweights, obj.m_tmpweights);
  ArrayCopy(m_tmpmeans, obj.m_tmpmeans);
  ArrayCopy(m_tmpsigmas, obj.m_tmpsigmas);
  ArrayCopy(m_neurons, obj.m_neurons);
  ArrayCopy(m_dfdnet, obj.m_dfdnet);
  ArrayCopy(m_y, obj.m_y);
}

class CMLPEnsembleShell {
private:
  CMLPEnsemble m_innerobj;

public:
  CMLPEnsembleShell(void);
  CMLPEnsembleShell(CMLPEnsemble &obj);
  ~CMLPEnsembleShell(void);

  CMLPEnsemble *GetInnerObj(void);
};

CMLPEnsembleShell::CMLPEnsembleShell(void) {
}

CMLPEnsembleShell::CMLPEnsembleShell(CMLPEnsemble &obj) {

  m_innerobj.Copy(obj);
}

CMLPEnsembleShell::~CMLPEnsembleShell(void) {
}

CMLPEnsemble *CMLPEnsembleShell::GetInnerObj(void) {

  return (GetPointer(m_innerobj));
}

class CMLPE {
private:
  static void MLPEAllErrors(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                            const int npoints, double &relcls, double &avgce,
                            double &rms, double &avg, double &avgrel);
  static void MLPEBaggingInternal(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                  const int npoints, const double decay,
                                  const int restarts, const double wstep,
                                  const int maxits, const bool lmalgorithm,
                                  int &info, CMLPReport &rep,
                                  CMLPCVReport &ooberrors);

public:
  static const int m_mlpntotaloffset;
  static const int m_mlpevnum;

  CMLPE(void);
  ~CMLPE(void);

  static void MLPECreate0(const int nin, const int nout, const int ensemblesize,
                          CMLPEnsemble &ensemble);
  static void MLPECreate1(const int nin, const int nhid, const int nout,
                          const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreate2(const int nin, const int nhid1, const int nhid2,
                          const int nout, const int ensemblesize,
                          CMLPEnsemble &ensemble);
  static void MLPECreateB0(const int nin, const int nout, const double b,
                           const double d, const int ensemblesize,
                           CMLPEnsemble &ensemble);
  static void MLPECreateB1(const int nin, const int nhid, const int nout,
                           const double b, const double d,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateB2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const double b, const double d,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateR0(const int nin, const int nout, const double a,
                           const double b, const int ensemblesize,
                           CMLPEnsemble &ensemble);
  static void MLPECreateR1(const int nin, const int nhid, const int nout,
                           const double a, const double b,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateR2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const double a, const double b,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateC0(const int nin, const int nout,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateC1(const int nin, const int nhid, const int nout,
                           const int ensemblesize, CMLPEnsemble &ensemble);
  static void MLPECreateC2(const int nin, const int nhid1, const int nhid2,
                           const int nout, const int ensemblesize,
                           CMLPEnsemble &ensemble);
  static void MLPECreateFromNetwork(CMultilayerPerceptron &network,
                                    const int ensemblesize,
                                    CMLPEnsemble &ensemble);
  static void MLPECopy(CMLPEnsemble &ensemble1, CMLPEnsemble &ensemble2);
  static void MLPESerialize(CMLPEnsemble &ensemble, double &ra[], int &rlen);
  static void MLPEUnserialize(double &ra[], CMLPEnsemble &ensemble);
  static void MLPERandomize(CMLPEnsemble &ensemble);
  static void MLPEProperties(CMLPEnsemble &ensemble, int &nin, int &nout);
  static bool MLPEIsSoftMax(CMLPEnsemble &ensemble);
  static void MLPEProcess(CMLPEnsemble &ensemble, double &x[], double &y[]);
  static void MLPEProcessI(CMLPEnsemble &ensemble, double &x[], double &y[]);
  static double MLPERelClsError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                const int npoints);
  static double MLPEAvgCE(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                          const int npoints);
  static double MLPERMSError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                             const int npoints);
  static double MLPEAvgError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                             const int npoints);
  static double MLPEAvgRelError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                const int npoints);
  static void MLPEBaggingLM(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                            const int npoints, const double decay,
                            const int restarts, int &info, CMLPReport &rep,
                            CMLPCVReport &ooberrors);
  static void MLPEBaggingLBFGS(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                               const int npoints, const double decay,
                               const int restarts, const double wstep,
                               const int maxits, int &info, CMLPReport &rep,
                               CMLPCVReport &ooberrors);
  static void MLPETrainES(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                          const int npoints, const double decay,
                          const int restarts, int &info, CMLPReport &rep);
};

const int CMLPE::m_mlpntotaloffset = 3;
const int CMLPE::m_mlpevnum = 9;

CMLPE::CMLPE(void) {
}

CMLPE::~CMLPE(void) {
}

static void CMLPE::MLPECreate0(const int nin, const int nout,
                               const int ensemblesize, CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreate0(nin, nout, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreate1(const int nin, const int nhid, const int nout,
                               const int ensemblesize, CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreate1(nin, nhid, nout, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreate2(const int nin, const int nhid1, const int nhid2,
                               const int nout, const int ensemblesize,
                               CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreate2(nin, nhid1, nhid2, nout, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateB0(const int nin, const int nout, const double b,
                                const double d, const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateB0(nin, nout, b, d, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateB1(const int nin, const int nhid, const int nout,
                                const double b, const double d,
                                const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateB1(nin, nhid, nout, b, d, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateB2(const int nin, const int nhid1, const int nhid2,
                                const int nout, const double b, const double d,
                                const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateB2(nin, nhid1, nhid2, nout, b, d, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateR0(const int nin, const int nout, const double a,
                                const double b, const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateR0(nin, nout, a, b, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateR1(const int nin, const int nhid, const int nout,
                                const double a, const double b,
                                const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateR1(nin, nhid, nout, a, b, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateR2(const int nin, const int nhid1, const int nhid2,
                                const int nout, const double a, const double b,
                                const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateR2(nin, nhid1, nhid2, nout, a, b, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateC0(const int nin, const int nout,
                                const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateC0(nin, nout, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateC1(const int nin, const int nhid, const int nout,
                                const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateC1(nin, nhid, nout, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateC2(const int nin, const int nhid1, const int nhid2,
                                const int nout, const int ensemblesize,
                                CMLPEnsemble &ensemble) {

  CMultilayerPerceptron net;

  CMLPBase::MLPCreateC2(nin, nhid1, nhid2, nout, net);

  MLPECreateFromNetwork(net, ensemblesize, ensemble);
}

static void CMLPE::MLPECreateFromNetwork(CMultilayerPerceptron &network,
                                         const int ensemblesize,
                                         CMLPEnsemble &ensemble) {

  int i = 0;
  int ccount = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert(ensemblesize > 0,
                   __FUNCTION__ + ": incorrect ensemble size!"))
    return;

  CMLPBase::MLPProperties(network, ensemble.m_nin, ensemble.m_nout,
                          ensemble.m_wcount);

  if (CMLPBase::MLPIsSoftMax(network))
    ccount = ensemble.m_nin;
  else
    ccount = ensemble.m_nin + ensemble.m_nout;

  ensemble.m_postprocessing = false;
  ensemble.m_issoftmax = CMLPBase::MLPIsSoftMax(network);
  ensemble.m_ensemblesize = ensemblesize;

  ArrayResizeAL(ensemble.m_structinfo, network.m_structinfo[0]);

  for (i = 0; i <= network.m_structinfo[0] - 1; i++)
    ensemble.m_structinfo[i] = network.m_structinfo[i];

  ArrayResizeAL(ensemble.m_weights, ensemblesize * ensemble.m_wcount);
  ArrayResizeAL(ensemble.m_columnmeans, ensemblesize * ccount);
  ArrayResizeAL(ensemble.m_columnsigmas, ensemblesize * ccount);

  for (i = 0; i <= ensemblesize * ensemble.m_wcount - 1; i++)
    ensemble.m_weights[i] = CMath::RandomReal() - 0.5;

  for (i = 0; i <= ensemblesize - 1; i++) {
    i1_ = -(i * ccount);
    for (i_ = i * ccount; i_ <= (i + 1) * ccount - 1; i_++)
      ensemble.m_columnmeans[i_] = network.m_columnmeans[i_ + i1_];
    i1_ = -(i * ccount);
    for (i_ = i * ccount; i_ <= (i + 1) * ccount - 1; i_++)
      ensemble.m_columnsigmas[i_] = network.m_columnsigmas[i_ + i1_];
  }

  CMLPBase::MLPSerializeOld(network, ensemble.m_serializedmlp,
                            ensemble.m_serializedlen);

  ArrayResizeAL(ensemble.m_tmpweights, ensemble.m_wcount);
  ArrayResizeAL(ensemble.m_tmpmeans, ccount);
  ArrayResizeAL(ensemble.m_tmpsigmas, ccount);
  ArrayResizeAL(ensemble.m_neurons, ensemble.m_structinfo[m_mlpntotaloffset]);
  ArrayResizeAL(ensemble.m_dfdnet, ensemble.m_structinfo[m_mlpntotaloffset]);
  ArrayResizeAL(ensemble.m_y, ensemble.m_nout);
}

static void CMLPE::MLPECopy(CMLPEnsemble &ensemble1, CMLPEnsemble &ensemble2) {

  int i = 0;
  int ssize = 0;
  int ccount = 0;
  int ntotal = 0;
  int i_ = 0;

  ssize = ensemble1.m_structinfo[0];

  if (ensemble1.m_issoftmax)
    ccount = ensemble1.m_nin;
  else
    ccount = ensemble1.m_nin + ensemble1.m_nout;

  ntotal = ensemble1.m_structinfo[m_mlpntotaloffset];

  ArrayResizeAL(ensemble2.m_structinfo, ssize);
  ArrayResizeAL(ensemble2.m_weights,
                ensemble1.m_ensemblesize * ensemble1.m_wcount);
  ArrayResizeAL(ensemble2.m_columnmeans, ensemble1.m_ensemblesize * ccount);
  ArrayResizeAL(ensemble2.m_columnsigmas, ensemble1.m_ensemblesize * ccount);
  ArrayResizeAL(ensemble2.m_tmpweights, ensemble1.m_wcount);
  ArrayResizeAL(ensemble2.m_tmpmeans, ccount);
  ArrayResizeAL(ensemble2.m_tmpsigmas, ccount);
  ArrayResizeAL(ensemble2.m_serializedmlp, ensemble1.m_serializedlen);
  ArrayResizeAL(ensemble2.m_neurons, ntotal);
  ArrayResizeAL(ensemble2.m_dfdnet, ntotal);
  ArrayResizeAL(ensemble2.m_y, ensemble1.m_nout);

  ensemble2.m_nin = ensemble1.m_nin;
  ensemble2.m_nout = ensemble1.m_nout;
  ensemble2.m_wcount = ensemble1.m_wcount;
  ensemble2.m_ensemblesize = ensemble1.m_ensemblesize;
  ensemble2.m_issoftmax = ensemble1.m_issoftmax;
  ensemble2.m_postprocessing = ensemble1.m_postprocessing;
  ensemble2.m_serializedlen = ensemble1.m_serializedlen;

  for (i = 0; i <= ssize - 1; i++)
    ensemble2.m_structinfo[i] = ensemble1.m_structinfo[i];
  for (i_ = 0; i_ <= ensemble1.m_ensemblesize * ensemble1.m_wcount - 1; i_++)
    ensemble2.m_weights[i_] = ensemble1.m_weights[i_];
  for (i_ = 0; i_ <= ensemble1.m_ensemblesize * ccount - 1; i_++)
    ensemble2.m_columnmeans[i_] = ensemble1.m_columnmeans[i_];
  for (i_ = 0; i_ <= ensemble1.m_ensemblesize * ccount - 1; i_++)
    ensemble2.m_columnsigmas[i_] = ensemble1.m_columnsigmas[i_];
  for (i_ = 0; i_ <= ensemble1.m_serializedlen - 1; i_++)
    ensemble2.m_serializedmlp[i_] = ensemble1.m_serializedmlp[i_];
}

static void CMLPE::MLPESerialize(CMLPEnsemble &ensemble, double &ra[],
                                 int &rlen) {

  int i = 0;
  int ssize = 0;
  int ntotal = 0;
  int ccount = 0;
  int hsize = 0;
  int offs = 0;
  int i_ = 0;
  int i1_ = 0;

  rlen = 0;
  hsize = 13;
  ssize = ensemble.m_structinfo[0];

  if (ensemble.m_issoftmax)
    ccount = ensemble.m_nin;
  else
    ccount = ensemble.m_nin + ensemble.m_nout;

  ntotal = ensemble.m_structinfo[m_mlpntotaloffset];
  rlen = hsize + ssize + ensemble.m_ensemblesize * ensemble.m_wcount +
         2 * ccount * ensemble.m_ensemblesize + ensemble.m_serializedlen;

  ArrayResizeAL(ra, rlen);

  ra[0] = rlen;
  ra[1] = m_mlpevnum;
  ra[2] = ensemble.m_ensemblesize;
  ra[3] = ensemble.m_nin;
  ra[4] = ensemble.m_nout;
  ra[5] = ensemble.m_wcount;

  if (ensemble.m_issoftmax)
    ra[6] = 1;
  else
    ra[6] = 0;

  if (ensemble.m_postprocessing)
    ra[7] = 1;
  else
    ra[7] = 9;

  ra[8] = ssize;
  ra[9] = ntotal;
  ra[10] = ccount;
  ra[11] = hsize;
  ra[12] = ensemble.m_serializedlen;

  offs = hsize;
  for (i = offs; i <= offs + ssize - 1; i++)
    ra[i] = ensemble.m_structinfo[i - offs];

  offs = offs + ssize;
  i1_ = -offs;
  for (i_ = offs; i_ <= offs + ensemble.m_ensemblesize * ensemble.m_wcount - 1;
       i_++)
    ra[i_] = ensemble.m_weights[i_ + i1_];

  offs = offs + ensemble.m_ensemblesize * ensemble.m_wcount;
  i1_ = -offs;
  for (i_ = offs; i_ <= offs + ensemble.m_ensemblesize * ccount - 1; i_++)
    ra[i_] = ensemble.m_columnmeans[i_ + i1_];

  offs = offs + ensemble.m_ensemblesize * ccount;
  i1_ = -offs;
  for (i_ = offs; i_ <= offs + ensemble.m_ensemblesize * ccount - 1; i_++)
    ra[i_] = ensemble.m_columnsigmas[i_ + i1_];

  offs = offs + ensemble.m_ensemblesize * ccount;
  i1_ = -offs;
  for (i_ = offs; i_ <= offs + ensemble.m_serializedlen - 1; i_++)
    ra[i_] = ensemble.m_serializedmlp[i_ + i1_];
  offs = offs + ensemble.m_serializedlen;
}

static void CMLPE::MLPEUnserialize(double &ra[], CMLPEnsemble &ensemble) {

  int i = 0;
  int ssize = 0;
  int ntotal = 0;
  int ccount = 0;
  int hsize = 0;
  int offs = 0;
  int i_ = 0;
  int i1_ = 0;

  if (!CAp::Assert((int)MathRound(ra[1]) == m_mlpevnum,
                   __FUNCTION__ + ": incorrect array!"))
    return;

  hsize = 13;
  ensemble.m_ensemblesize = (int)MathRound(ra[2]);
  ensemble.m_nin = (int)MathRound(ra[3]);
  ensemble.m_nout = (int)MathRound(ra[4]);
  ensemble.m_wcount = (int)MathRound(ra[5]);
  ensemble.m_issoftmax = (int)MathRound(ra[6]) == 1;
  ensemble.m_postprocessing = (int)MathRound(ra[7]) == 1;
  ssize = (int)MathRound(ra[8]);
  ntotal = (int)MathRound(ra[9]);
  ccount = (int)MathRound(ra[10]);
  offs = (int)MathRound(ra[11]);
  ensemble.m_serializedlen = (int)MathRound(ra[12]);

  ArrayResizeAL(ensemble.m_structinfo, ssize);
  ArrayResizeAL(ensemble.m_weights,
                ensemble.m_ensemblesize * ensemble.m_wcount);
  ArrayResizeAL(ensemble.m_columnmeans, ensemble.m_ensemblesize * ccount);
  ArrayResizeAL(ensemble.m_columnsigmas, ensemble.m_ensemblesize * ccount);
  ArrayResizeAL(ensemble.m_tmpweights, ensemble.m_wcount);
  ArrayResizeAL(ensemble.m_tmpmeans, ccount);
  ArrayResizeAL(ensemble.m_tmpsigmas, ccount);
  ArrayResizeAL(ensemble.m_neurons, ntotal);
  ArrayResizeAL(ensemble.m_dfdnet, ntotal);
  ArrayResizeAL(ensemble.m_serializedmlp, ensemble.m_serializedlen);
  ArrayResizeAL(ensemble.m_y, ensemble.m_nout);

  for (i = offs; i <= offs + ssize - 1; i++)
    ensemble.m_structinfo[i - offs] = (int)MathRound(ra[i]);

  offs = offs + ssize;
  i1_ = offs;
  for (i_ = 0; i_ <= ensemble.m_ensemblesize * ensemble.m_wcount - 1; i_++)
    ensemble.m_weights[i_] = ra[i_ + i1_];

  offs = offs + ensemble.m_ensemblesize * ensemble.m_wcount;
  i1_ = offs;
  for (i_ = 0; i_ <= ensemble.m_ensemblesize * ccount - 1; i_++)
    ensemble.m_columnmeans[i_] = ra[i_ + i1_];

  offs = offs + ensemble.m_ensemblesize * ccount;
  i1_ = offs;
  for (i_ = 0; i_ <= ensemble.m_ensemblesize * ccount - 1; i_++)
    ensemble.m_columnsigmas[i_] = ra[i_ + i1_];

  offs = offs + ensemble.m_ensemblesize * ccount;
  i1_ = offs;
  for (i_ = 0; i_ <= ensemble.m_serializedlen - 1; i_++)
    ensemble.m_serializedmlp[i_] = ra[i_ + i1_];
  offs = offs + ensemble.m_serializedlen;
}

static void CMLPE::MLPERandomize(CMLPEnsemble &ensemble) {

  int i = 0;

  for (i = 0; i <= ensemble.m_ensemblesize * ensemble.m_wcount - 1; i++)
    ensemble.m_weights[i] = CMath::RandomReal() - 0.5;
}

static void CMLPE::MLPEProperties(CMLPEnsemble &ensemble, int &nin, int &nout) {

  nin = ensemble.m_nin;
  nout = ensemble.m_nout;
}

static bool CMLPE::MLPEIsSoftMax(CMLPEnsemble &ensemble) {

  return (ensemble.m_issoftmax);
}

static void CMLPE::MLPEProcess(CMLPEnsemble &ensemble, double &x[],
                               double &y[]) {

  int i = 0;
  int es = 0;
  int wc = 0;
  int cc = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  if (CAp::Len(y) < ensemble.m_nout)
    ArrayResizeAL(y, ensemble.m_nout);

  es = ensemble.m_ensemblesize;
  wc = ensemble.m_wcount;

  if (ensemble.m_issoftmax)
    cc = ensemble.m_nin;
  else
    cc = ensemble.m_nin + ensemble.m_nout;

  v = 1.0 / (double)es;
  for (i = 0; i <= ensemble.m_nout - 1; i++)
    y[i] = 0;

  for (i = 0; i <= es - 1; i++) {
    i1_ = i * wc;
    for (i_ = 0; i_ <= wc - 1; i_++)
      ensemble.m_tmpweights[i_] = ensemble.m_weights[i_ + i1_];
    i1_ = i * cc;
    for (i_ = 0; i_ <= cc - 1; i_++)
      ensemble.m_tmpmeans[i_] = ensemble.m_columnmeans[i_ + i1_];
    i1_ = i * cc;
    for (i_ = 0; i_ <= cc - 1; i_++)
      ensemble.m_tmpsigmas[i_] = ensemble.m_columnsigmas[i_ + i1_];

    CMLPBase::MLPInternalProcessVector(
        ensemble.m_structinfo, ensemble.m_tmpweights, ensemble.m_tmpmeans,
        ensemble.m_tmpsigmas, ensemble.m_neurons, ensemble.m_dfdnet, x,
        ensemble.m_y);

    for (i_ = 0; i_ <= ensemble.m_nout - 1; i_++)
      y[i_] = y[i_] + v * ensemble.m_y[i_];
  }
}

static void CMLPE::MLPEProcessI(CMLPEnsemble &ensemble, double &x[],
                                double &y[]) {

  MLPEProcess(ensemble, x, y);
}

static double CMLPE::MLPERelClsError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                     const int npoints) {

  double relcls = 0;
  double avgce = 0;
  double rms = 0;
  double avg = 0;
  double avgrel = 0;

  MLPEAllErrors(ensemble, xy, npoints, relcls, avgce, rms, avg, avgrel);

  return (relcls);
}

static double CMLPE::MLPEAvgCE(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                               const int npoints) {

  double relcls = 0;
  double avgce = 0;
  double rms = 0;
  double avg = 0;
  double avgrel = 0;

  MLPEAllErrors(ensemble, xy, npoints, relcls, avgce, rms, avg, avgrel);

  return (avgce);
}

static double CMLPE::MLPERMSError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                  const int npoints) {

  double relcls = 0;
  double avgce = 0;
  double rms = 0;
  double avg = 0;
  double avgrel = 0;

  MLPEAllErrors(ensemble, xy, npoints, relcls, avgce, rms, avg, avgrel);

  return (rms);
}

static double CMLPE::MLPEAvgError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                  const int npoints) {

  double result = 0;
  double relcls = 0;
  double avgce = 0;
  double rms = 0;
  double avg = 0;
  double avgrel = 0;

  MLPEAllErrors(ensemble, xy, npoints, relcls, avgce, rms, avg, avgrel);

  return (avg);
}

static double CMLPE::MLPEAvgRelError(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                     const int npoints) {

  double result = 0;
  double relcls = 0;
  double avgce = 0;
  double rms = 0;
  double avg = 0;
  double avgrel = 0;

  MLPEAllErrors(ensemble, xy, npoints, relcls, avgce, rms, avg, avgrel);

  return (avgrel);
}

static void CMLPE::MLPEBaggingLM(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                 const int npoints, const double decay,
                                 const int restarts, int &info, CMLPReport &rep,
                                 CMLPCVReport &ooberrors) {

  info = 0;

  MLPEBaggingInternal(ensemble, xy, npoints, decay, restarts, 0.0, 0, true,
                      info, rep, ooberrors);
}

static void CMLPE::MLPEBaggingLBFGS(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                    const int npoints, const double decay,
                                    const int restarts, const double wstep,
                                    const int maxits, int &info,
                                    CMLPReport &rep, CMLPCVReport &ooberrors) {

  info = 0;

  MLPEBaggingInternal(ensemble, xy, npoints, decay, restarts, wstep, maxits,
                      false, info, rep, ooberrors);
}

static void CMLPE::MLPETrainES(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                               const int npoints, const double decay,
                               const int restarts, int &info, CMLPReport &rep) {

  int i = 0;
  int k = 0;
  int ccount = 0;
  int pcount = 0;
  int trnsize = 0;
  int valsize = 0;
  int tmpinfo = 0;
  int i_ = 0;
  int i1_ = 0;

  CMatrixDouble trnxy;
  CMatrixDouble valxy;

  CMultilayerPerceptron network;
  CMLPReport tmprep;

  info = 0;

  if ((npoints < 2 || restarts < 1) || decay < 0.0) {
    info = -1;
    return;
  }

  if (ensemble.m_issoftmax) {
    for (i = 0; i <= npoints - 1; i++) {

      if ((int)MathRound(xy[i][ensemble.m_nin]) < 0 ||
          (int)MathRound(xy[i][ensemble.m_nin]) >= ensemble.m_nout) {
        info = -2;
        return;
      }
    }
  }

  info = 6;

  if (ensemble.m_issoftmax) {
    ccount = ensemble.m_nin + 1;
    pcount = ensemble.m_nin;
  } else {
    ccount = ensemble.m_nin + ensemble.m_nout;
    pcount = ensemble.m_nin + ensemble.m_nout;
  }

  trnxy.Resize(npoints, ccount);
  valxy.Resize(npoints, ccount);

  CMLPBase::MLPUnserializeOld(ensemble.m_serializedmlp, network);

  rep.m_ngrad = 0;
  rep.m_nhess = 0;
  rep.m_ncholesky = 0;

  for (k = 0; k <= ensemble.m_ensemblesize - 1; k++) {

    do {
      trnsize = 0;
      valsize = 0;
      for (i = 0; i <= npoints - 1; i++) {

        if (CMath::RandomReal() < 0.66) {

          for (i_ = 0; i_ <= ccount - 1; i_++)
            trnxy[trnsize].Set(i_, xy[i][i_]);
          trnsize = trnsize + 1;
        } else {

          for (i_ = 0; i_ <= ccount - 1; i_++)
            valxy[valsize].Set(i_, xy[i][i_]);
          valsize = valsize + 1;
        }
      }
    } while (!(trnsize != 0 && valsize != 0));

    CMLPTrain::MLPTrainES(network, trnxy, trnsize, valxy, valsize, decay,
                          restarts, tmpinfo, tmprep);

    if (tmpinfo < 0) {
      info = tmpinfo;
      return;
    }

    i1_ = -(k * ensemble.m_wcount);
    for (i_ = k * ensemble.m_wcount; i_ <= (k + 1) * ensemble.m_wcount - 1;
         i_++)
      ensemble.m_weights[i_] = network.m_weights[i_ + i1_];
    i1_ = -(k * pcount);
    for (i_ = k * pcount; i_ <= (k + 1) * pcount - 1; i_++)
      ensemble.m_columnmeans[i_] = network.m_columnmeans[i_ + i1_];
    i1_ = -(k * pcount);
    for (i_ = k * pcount; i_ <= (k + 1) * pcount - 1; i_++)
      ensemble.m_columnsigmas[i_] = network.m_columnsigmas[i_ + i1_];

    rep.m_ngrad = rep.m_ngrad + tmprep.m_ngrad;
    rep.m_nhess = rep.m_nhess + tmprep.m_nhess;
    rep.m_ncholesky = rep.m_ncholesky + tmprep.m_ncholesky;
  }
}

static void CMLPE::MLPEAllErrors(CMLPEnsemble &ensemble, CMatrixDouble &xy,
                                 const int npoints, double &relcls,
                                 double &avgce, double &rms, double &avg,
                                 double &avgrel) {

  int i = 0;
  int i_ = 0;
  int i1_ = 0;

  double buf[];
  double workx[];
  double y[];
  double dy[];

  relcls = 0;
  avgce = 0;
  rms = 0;
  avg = 0;
  avgrel = 0;

  ArrayResizeAL(workx, ensemble.m_nin);
  ArrayResizeAL(y, ensemble.m_nout);

  if (ensemble.m_issoftmax) {

    ArrayResizeAL(dy, 1);

    CBdSS::DSErrAllocate(ensemble.m_nout, buf);
  } else {

    ArrayResizeAL(dy, ensemble.m_nout);

    CBdSS::DSErrAllocate(-ensemble.m_nout, buf);
  }

  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= ensemble.m_nin - 1; i_++)
      workx[i_] = xy[i][i_];

    MLPEProcess(ensemble, workx, y);

    if (ensemble.m_issoftmax)
      dy[0] = xy[i][ensemble.m_nin];
    else {
      i1_ = ensemble.m_nin;
      for (i_ = 0; i_ <= ensemble.m_nout - 1; i_++)
        dy[i_] = xy[i][i_ + i1_];
    }

    CBdSS::DSErrAccumulate(buf, y, dy);
  }

  CBdSS::DSErrFinish(buf);

  relcls = buf[0];
  avgce = buf[1];
  rms = buf[2];
  avg = buf[3];
  avgrel = buf[4];
}

static void CMLPE::MLPEBaggingInternal(CMLPEnsemble &ensemble,
                                       CMatrixDouble &xy, const int npoints,
                                       const double decay, const int restarts,
                                       const double wstep, const int maxits,
                                       const bool lmalgorithm, int &info,
                                       CMLPReport &rep,
                                       CMLPCVReport &ooberrors) {

  int nin = 0;
  int nout = 0;
  int ccnt = 0;
  int pcnt = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  double v = 0;
  int i_ = 0;
  int i1_ = 0;

  bool s[];
  int oobcntbuf[];
  double x[];
  double y[];
  double dy[];
  double dsbuf[];

  CMatrixDouble xys;
  CMatrixDouble oobbuf;

  CMLPReport tmprep;
  CMultilayerPerceptron network;

  info = 0;

  if ((!lmalgorithm && wstep == 0.0) && maxits == 0) {
    info = -8;
    return;
  }

  if (((npoints <= 0 || restarts < 1) || wstep < 0.0) || maxits < 0) {
    info = -1;
    return;
  }

  if (ensemble.m_issoftmax) {
    for (i = 0; i <= npoints - 1; i++) {

      if ((int)MathRound(xy[i][ensemble.m_nin]) < 0 ||
          (int)MathRound(xy[i][ensemble.m_nin]) >= ensemble.m_nout) {
        info = -2;
        return;
      }
    }
  }

  info = 2;
  rep.m_ngrad = 0;
  rep.m_nhess = 0;
  rep.m_ncholesky = 0;
  ooberrors.m_relclserror = 0;
  ooberrors.m_avgce = 0;
  ooberrors.m_rmserror = 0;
  ooberrors.m_avgerror = 0;
  ooberrors.m_avgrelerror = 0;
  nin = ensemble.m_nin;
  nout = ensemble.m_nout;

  if (ensemble.m_issoftmax) {
    ccnt = nin + 1;
    pcnt = nin;
  } else {
    ccnt = nin + nout;
    pcnt = nin + nout;
  }

  xys.Resize(npoints, ccnt);
  ArrayResizeAL(s, npoints);
  oobbuf.Resize(npoints, nout);
  ArrayResizeAL(oobcntbuf, npoints);
  ArrayResizeAL(x, nin);
  ArrayResizeAL(y, nout);

  if (ensemble.m_issoftmax)
    ArrayResizeAL(dy, 1);
  else
    ArrayResizeAL(dy, nout);

  for (i = 0; i <= npoints - 1; i++) {
    for (j = 0; j <= nout - 1; j++)
      oobbuf[i].Set(j, 0);
  }
  for (i = 0; i <= npoints - 1; i++)
    oobcntbuf[i] = 0;

  CMLPBase::MLPUnserializeOld(ensemble.m_serializedmlp, network);

  for (k = 0; k <= ensemble.m_ensemblesize - 1; k++) {

    for (i = 0; i <= npoints - 1; i++)
      s[i] = false;
    for (i = 0; i <= npoints - 1; i++) {
      j = CMath::RandomInteger(npoints);
      s[j] = true;
      for (i_ = 0; i_ <= ccnt - 1; i_++)
        xys[i].Set(i_, xy[j][i_]);
    }

    if (lmalgorithm)
      CMLPTrain::MLPTrainLM(network, xys, npoints, decay, restarts, info,
                            tmprep);
    else
      CMLPTrain::MLPTrainLBFGS(network, xys, npoints, decay, restarts, wstep,
                               maxits, info, tmprep);

    if (info < 0)
      return;

    rep.m_ngrad = rep.m_ngrad + tmprep.m_ngrad;
    rep.m_nhess = rep.m_nhess + tmprep.m_nhess;
    rep.m_ncholesky = rep.m_ncholesky + tmprep.m_ncholesky;

    i1_ = -(k * ensemble.m_wcount);
    for (i_ = k * ensemble.m_wcount; i_ <= (k + 1) * ensemble.m_wcount - 1;
         i_++)
      ensemble.m_weights[i_] = network.m_weights[i_ + i1_];

    i1_ = -(k * pcnt);
    for (i_ = k * pcnt; i_ <= (k + 1) * pcnt - 1; i_++)
      ensemble.m_columnmeans[i_] = network.m_columnmeans[i_ + i1_];

    i1_ = -(k * pcnt);
    for (i_ = k * pcnt; i_ <= (k + 1) * pcnt - 1; i_++)
      ensemble.m_columnsigmas[i_] = network.m_columnsigmas[i_ + i1_];

    for (i = 0; i <= npoints - 1; i++) {

      if (!s[i]) {
        for (i_ = 0; i_ <= nin - 1; i_++)
          x[i_] = xy[i][i_];

        CMLPBase::MLPProcess(network, x, y);

        for (i_ = 0; i_ <= nout - 1; i_++)
          oobbuf[i].Set(i_, oobbuf[i][i_] + y[i_]);
        oobcntbuf[i] = oobcntbuf[i] + 1;
      }
    }
  }

  if (ensemble.m_issoftmax) {

    CBdSS::DSErrAllocate(nout, dsbuf);
  } else {

    CBdSS::DSErrAllocate(-nout, dsbuf);
  }
  for (i = 0; i <= npoints - 1; i++) {

    if (oobcntbuf[i] != 0) {
      v = 1.0 / (double)oobcntbuf[i];
      for (i_ = 0; i_ <= nout - 1; i_++)
        y[i_] = v * oobbuf[i][i_];

      if (ensemble.m_issoftmax)
        dy[0] = xy[i][nin];
      else {
        i1_ = nin;
        for (i_ = 0; i_ <= nout - 1; i_++)
          dy[i_] = v * xy[i][i_ + i1_];
      }

      CBdSS::DSErrAccumulate(dsbuf, y, dy);
    }
  }

  CBdSS::DSErrFinish(dsbuf);

  ooberrors.m_relclserror = dsbuf[0];
  ooberrors.m_avgce = dsbuf[1];
  ooberrors.m_rmserror = dsbuf[2];
  ooberrors.m_avgerror = dsbuf[3];
  ooberrors.m_avgrelerror = dsbuf[4];
}

class CPCAnalysis {
public:
  CPCAnalysis(void);
  ~CPCAnalysis(void);

  static void PCABuildBasis(CMatrixDouble &x, const int npoints,
                            const int nvars, int &info, double &s2[],
                            CMatrixDouble &v);
};

CPCAnalysis::CPCAnalysis(void) {
}

CPCAnalysis::~CPCAnalysis(void) {
}

static void CPCAnalysis::PCABuildBasis(CMatrixDouble &x, const int npoints,
                                       const int nvars, int &info, double &s2[],
                                       CMatrixDouble &v) {

  int i = 0;
  int j = 0;
  double mean = 0;
  double variance = 0;
  double skewness = 0;
  double kurtosis = 0;
  int i_ = 0;

  double m[];
  double t[];

  CMatrixDouble a;
  CMatrixDouble u;
  CMatrixDouble vt;

  info = 0;

  if (npoints < 0 || nvars < 1) {
    info = -1;
    return;
  }

  info = 1;

  if (npoints == 0) {

    ArrayResizeAL(s2, nvars);
    v.Resize(nvars, nvars);

    for (i = 0; i <= nvars - 1; i++)
      s2[i] = 0;
    for (i = 0; i <= nvars - 1; i++) {
      for (j = 0; j <= nvars - 1; j++) {

        if (i == j)
          v[i].Set(j, 1);
        else
          v[i].Set(j, 0);
      }
    }

    return;
  }

  ArrayResizeAL(m, nvars);
  ArrayResizeAL(t, npoints);
  for (j = 0; j <= nvars - 1; j++) {
    for (i_ = 0; i_ <= npoints - 1; i_++)
      t[i_] = x[i_][j];

    CBaseStat::SampleMoments(t, npoints, mean, variance, skewness, kurtosis);
    m[j] = mean;
  }

  a.Resize(MathMax(npoints, nvars), nvars);

  for (i = 0; i <= npoints - 1; i++) {
    for (i_ = 0; i_ <= nvars - 1; i_++)
      a[i].Set(i_, x[i][i_]);
    for (i_ = 0; i_ <= nvars - 1; i_++)
      a[i].Set(i_, a[i][i_] - m[i_]);
  }
  for (i = npoints; i <= nvars - 1; i++) {
    for (j = 0; j <= nvars - 1; j++)
      a[i].Set(j, 0);
  }

  if (!CSingValueDecompose::RMatrixSVD(a, MathMax(npoints, nvars), nvars, 0, 1,
                                       2, s2, u, vt)) {
    info = -4;
    return;
  }

  if (npoints != 1) {
    for (i = 0; i <= nvars - 1; i++)
      s2[i] = CMath::Sqr(s2[i]) / (npoints - 1);
  }

  v.Resize(nvars, nvars);

  CBlas::CopyAndTranspose(vt, 0, nvars - 1, 0, nvars - 1, v, 0, nvars - 1, 0,
                          nvars - 1);
}

#endif
