#ifndef BINOMIAL_H
#define BINOMIAL_H

#include "Beta.mqh"
#include "Math.mqh"

double MathProbabilityDensityBinomial(const double x, const double n,
                                      const double p, const bool log_mode,
                                      int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(n) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (n < 0 || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (p < 0.0 || p > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (p == 0.0 || p == 1.0)
    return TailLog0(true, log_mode);

  if (x < 0 || x > n)
    return TailLog0(true, log_mode);

  double log_result = MathGammaLog(n + 1.0) - MathGammaLog(x + 1.0) -
                      MathGammaLog(n - x + 1.0) + x * MathLog(p) +
                      (n - x) * MathLog(1.0 - p);
  if (log_mode == true)
    return log_result;

  return MathExp(log_result);
}

double MathProbabilityDensityBinomial(const double x, const double n,
                                      const double p, int &error_code) {
  return MathProbabilityDensityBinomial(x, n, p, false, error_code);
}

bool MathProbabilityDensityBinomial(const double &x[], const double n,
                                    const double p, const bool log_mode,
                                    double &result[]) {

  if (!MathIsValidNumber(n) || !MathIsValidNumber(p))
    return false;

  if (n < 0 || n != MathRound(n))
    return false;

  if (p < 0.0 || p > 1.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);

  if (p == 0.0 || p == 1.0) {
    for (int i = 0; i < data_count; i++)
      result[i] = TailLog0(true, log_mode);
    return true;
  }
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];
    if (MathIsValidNumber(x_arg) && x_arg == MathRound(x_arg)) {

      if (x_arg < 0 || x_arg > n)
        result[i] = TailLog0(true, log_mode);
      else {
        double log_result = MathGammaLog(n + 1.0) - MathGammaLog(x_arg + 1.0) -
                            MathGammaLog(n - x_arg + 1.0) + x_arg * MathLog(p) +
                            (n - x_arg) * MathLog(1.0 - p);
        if (log_mode == true)
          result[i] = log_result;
        else
          result[i] = MathExp(log_result);
      }
    } else
      return false;
  }
  return true;
}

bool MathProbabilityDensityBinomial(const double &x[], const double n,
                                    const double p, double &result[]) {
  return MathProbabilityDensityBinomial(x, n, p, false, result);
}

double MathCumulativeDistributionBinomial(const double x, const double n,
                                          double p, const bool tail,
                                          const bool log_mode,
                                          int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(n) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (n < 0 || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (p < 0.0 || p > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (p == 0.0) {
    if (x >= 0)
      return TailLog1(tail, log_mode);
    else
      return TailLog0(tail, log_mode);
  }

  if (p == 1.0) {
    if (x > n)
      return TailLog1(tail, log_mode);
    else
      return TailLog0(tail, log_mode);
  }

  if (x < 0)
    return TailLog0(tail, log_mode);

  if (x > n)
    return TailLog1(tail, log_mode);
  int err_code = 0;

  double result = MathMin(
      1.0 - MathCumulativeDistributionBeta(p, x + 1.0, n - x, err_code), 1.0);

  return TailLogValue(result, tail, log_mode);
}

double MathCumulativeDistributionBinomial(const double x, const double n,
                                          double p, int &error_code) {
  return MathCumulativeDistributionBinomial(x, n, p, true, false, error_code);
}

bool MathCumulativeDistributionBinomial(const double &x[], const double n,
                                        double p, const bool tail,
                                        const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(n) || !MathIsValidNumber(p))
    return false;

  if (n < 0 || n != MathRound(n))
    return false;

  if (p < 0.0 || p > 1.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);

  if (p == 0.0 || p == 1.0) {
    if (p == 0.0) {
      for (int i = 0; i < data_count; i++) {
        if (x[i] >= 0)
          result[i] = TailLog1(tail, log_mode);
        else
          result[i] = TailLog0(tail, log_mode);
      }
    } else

    {
      for (int i = 0; i < data_count; i++) {
        if (x[i] > n)
          result[i] = TailLog1(tail, log_mode);
        else
          result[i] = TailLog0(tail, log_mode);
      }
    }
    return true;
  }

  int err_code = 0;
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];
    if (MathIsValidNumber(x_arg)) {
      if (x_arg < 0)
        result[i] = TailLog0(tail, log_mode);
      else if (x_arg > n)
        result[i] = TailLog1(tail, log_mode);
      else {
        double value = MathMin(1.0 - MathCumulativeDistributionBeta(
                                         p, x_arg + 1.0, n - x_arg, err_code),
                               1.0);

        result[i] = TailLogValue(value, tail, log_mode);
      }
    } else
      return false;
  }
  return true;
}

bool MathCumulativeDistributionBinomial(const double &x[], const double n,
                                        double p, double &result[]) {
  return MathCumulativeDistributionBinomial(x, n, p, true, false, result);
}

double MathQuantileBinomial(const double probability, const double n,
                            const double p, const bool tail,
                            const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(n) ||
      !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (n < 0 || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (p < 0.0 || p > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double prob = TailLogProbability(probability, tail, log_mode);

  if (prob < 0.0 || prob > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  int iterations = 0;
  const int max_iterations = 1000;

  double sum = MathProbabilityDensityBinomial(0, n, p, false, error_code);
  while (sum < prob && iterations < max_iterations) {
    sum += MathProbabilityDensityBinomial(iterations, n, p, false, error_code);
    iterations++;
  }

  if (iterations < max_iterations) {
    if (iterations == 0)
      return 0.0;
    else
      return iterations - 1;
  } else {
    error_code = ERR_RESULT_INFINITE;
    return QPOSINF;
  }
}

double MathQuantileBinomial(const double probability, const double n,
                            const double p, int &error_code) {
  return MathQuantileBinomial(probability, n, p, true, false, error_code);
}

bool MathQuantileBinomial(const double &probability[], const double n,
                          const double p, const bool tail, const bool log_mode,
                          double &result[]) {

  if (!MathIsValidNumber(n) || !MathIsValidNumber(p))
    return false;

  if (n < 0 || n != MathRound(n))
    return false;

  if (p < 0.0 || p > 1.0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);

  const int max_iterations = 1000;
  for (int i = 0; i < data_count; i++) {

    double prob = TailLogProbability(probability[i], tail, log_mode);

    if (MathIsValidNumber(prob)) {

      if (prob < 0.0 || prob > 1.0)
        return false;

      int iterations = 0;

      double sum = MathProbabilityDensityBinomial(0, n, p, false, error_code);
      while (sum < prob && iterations < max_iterations) {
        sum +=
            MathProbabilityDensityBinomial(iterations, n, p, false, error_code);
        iterations++;
      }

      if (iterations < max_iterations) {
        if (iterations == 0)
          result[i] = 0;
        else
          result[i] = iterations - 1;
      } else
        return false;
    } else
      return false;
  }
  return true;
}

bool MathQuantileBinomial(const double &probability[], const double n,
                          const double p, double &result[]) {
  return MathQuantileBinomial(probability, n, p, true, false, result);
}

double MathRandomBinomial(const double n, const double p) {
  int ix, ix1, mp;
  double f, g, qn, r, t, u, v, w, w2, x, z;
  int value = 0;
  int n1 = (int)n;

  double pp = MathMin(p, 1.0 - p);
  double q = 1.0 - pp;
  double xnp = (double)(n1)*pp;

  if (xnp < 30.0) {
    qn = MathPow(q, n1);
    r = pp / q;
    g = r * (double)(n1 + 1);

    for (;;) {
      ix = 0;
      f = qn;
      u = MathRandomNonZero();

      for (;;) {
        if (u < f) {
          if (0.5 < p) {
            ix = n1 - ix;
          }
          value = ix;
          return value;
        }
        if (110 < ix)
          break;
        u = u - f;
        ix = ix + 1;
        f = f * (g / (double)(ix)-r);
      }
    }
  }
  double ffm = xnp + pp;
  int m = int(ffm);
  double fm = m;
  double xnpq = xnp * q;
  double p1 = (int)(2.195 * MathSqrt(xnpq) - 4.6 * q) + 0.5;
  double xm = fm + 0.5;
  double xl = xm - p1;
  double xr = xm + p1;
  double c = 0.134 + 20.5 / (15.3 + fm);
  double al = (ffm - xl) / (ffm - xl * pp);
  double xll = al * (1.0 + 0.5 * al);
  al = (xr - ffm) / (xr * q);
  double xlr = al * (1.0 + 0.5 * al);
  double p2 = p1 * (1.0 + c + c);
  double p3 = p2 + c / xll;
  double p4 = p3 + c / xlr;

  for (;;) {
    u = MathRandomNonZero() * p4;
    v = MathRandomNonZero();

    if (u < p1) {
      ix = int(xm - p1 * v + u);
      if (0.5 < p)
        ix = n1 - ix;

      value = ix;
      return value;
    }

    if (u <= p2) {
      x = xl + (u - p1) / c;
      v = v * c + 1.0 - MathAbs(xm - x) / p1;

      if (v <= 0.0 || 1.0 < v)
        continue;
      ix = int(x);
    } else if (u <= p3) {
      ix = int(xl + MathLog(v) / xll);
      if (ix < 0)
        continue;
      v = v * (u - p2) * xll;
    } else {
      ix = int(xr - MathLog(v) / xlr);
      if (n1 < ix)
        continue;
      v = v * (u - p3) * xlr;
    }
    int k = MathAbs(ix - m);

    if (k <= 20 || xnpq / 2.0 - 1.0 <= k) {
      f = 1.0;
      r = pp / q;
      g = (n1 + 1) * r;

      if (m < ix) {
        mp = m + 1;
        for (int i = mp; i <= ix; i++)
          f = f * (g / i - r);
      } else if (ix < m) {
        ix1 = ix + 1;
        for (int i = ix1; i <= m; i++)
          f = f / (g / i - r);
      }

      if (v <= f) {
        if (0.5 < p)
          ix = n1 - ix;

        value = ix;
        return value;
      }
    } else {
      double amaxp =
          (k / xnpq) * ((k * (k / 3.0 + 0.625) + 0.1666666666666) / xnpq + 0.5);
      double ynorm = -double((k * k) / (2.0 * xnpq));
      double alv = MathLog(v);

      if (alv < ynorm - amaxp) {
        if (0.5 < p)
          ix = n1 - ix;

        value = ix;
        return value;
      }

      if (ynorm + amaxp < alv)
        continue;

      double x1 = double(ix + 1);
      double f1 = fm + 1.0;
      z = (double)(n1 + 1) - fm;
      w = (double)(n1 - ix + 1);
      double z2 = z * z;
      double x2 = x1 * x1;
      double f2 = f1 * f1;
      w2 = w * w;

      t = xm * MathLog(f1 / x1) + (n1 - m + 0.5) * MathLog(z / w) +
          (double)(ix - m) * MathLog(w * pp / (x1 * q)) +
          (13860.0 - (462.0 - (132.0 - (99.0 - 140.0 / f2) / f2) / f2) / f2) /
              f1 / 166320.0 +
          (13860.0 - (462.0 - (132.0 - (99.0 - 140.0 / z2) / z2) / z2) / z2) /
              z / 166320.0 +
          (13860.0 - (462.0 - (132.0 - (99.0 - 140.0 / x2) / x2) / x2) / x2) /
              x1 / 166320.0 +
          (13860.0 - (462.0 - (132.0 - (99.0 - 140.0 / w2) / w2) / w2) / w2) /
              w / 166320.0;

      if (alv <= t) {
        if (0.5 < p)
          ix = n1 - ix;

        value = ix;
        return value;
      }
    }
  }
  return value;
}

double MathRandomBinomial(const double n, const double p, int &error_code) {

  if (!MathIsValidNumber(n) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (n <= 0 || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (p <= 0 || p >= 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  return MathRandomBinomial(n, p);
}

bool MathRandomBinomial(const double n, const double p, const int data_count,
                        double &result[]) {
  if (data_count <= 0)
    return false;

  if (!MathIsValidNumber(n) || !MathIsValidNumber(p))
    return false;

  if (n <= 0 || n != MathRound(n))
    return false;

  if (p <= 0 || p >= 1.0)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++)
    result[i] = MathRandomBinomial(n, p);
  return true;
}

bool MathMomentsBinomial(const double n, const double p, double &mean,
                         double &variance, double &skewness, double &kurtosis,
                         int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(n) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (n < 0 || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  if (p <= 0.0 || p >= 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  double np = n * p;
  double one_mp = (1.0 - p);

  mean = np;
  variance = np * one_mp;
  skewness = (1 - 2 * p) / MathSqrt(variance);
  kurtosis = (1 - 6 * p * one_mp) / variance;

  return true;
}

#endif
