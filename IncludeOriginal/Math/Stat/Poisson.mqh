#ifndef POISSON_H
#define POISSON_H

#include "Gamma.mqh"
#include "Math.mqh"

double MathProbabilityDensityPoisson(const double x, const double lambda,
                                     const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(lambda)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (lambda <= 0.0 || x != MathRound(x)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x < 0.0)
    return TailLog0(true, log_mode);

  double log_pdf = -lambda + x * MathLog(lambda) - MathGammaLog(x + 1.0);
  if (log_mode)
    return log_pdf;

  return MathExp(log_pdf);
}

double MathProbabilityDensityPoisson(const double x, const double lambda,
                                     int &error_code) {
  return MathProbabilityDensityPoisson(x, lambda, false, error_code);
}

bool MathProbabilityDensityPoisson(const double &x[], const double lambda,
                                   const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(lambda))
    return false;

  if (lambda <= 0.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg != MathRound(x_arg))
      return false;

    if (x_arg < 0.0)
      result[i] = TailLog0(true, log_mode);
    else {

      double log_pdf =
          -lambda + x_arg * MathLog(lambda) - MathGammaLog(x_arg + 1.0);
      if (log_mode)
        result[i] = log_pdf;
      else
        result[i] = MathExp(log_pdf);
    }
  }
  return true;
}

bool MathProbabilityDensityPoisson(const double &x[], const double lambda,
                                   double &result[]) {
  return MathProbabilityDensityPoisson(x, lambda, false, result);
}

double MathCumulativeDistributionPoisson(const double x, const double lambda,
                                         const bool tail, const bool log_mode,
                                         int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(lambda)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (lambda <= 0.0 || x != MathRound(x)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x < 0.0)
    return TailLog0(tail, log_mode);
  int err_code = 0;

  int t = (int)MathFloor(x + 10e-10);
  double cdf =
      MathCumulativeDistributionGamma(lambda, t + 1, 1, false, false, err_code);
  return TailLogValue(cdf, tail, log_mode);
}

double MathCumulativeDistributionPoisson(const double x, const double lambda,
                                         int &error_code) {
  return MathCumulativeDistributionPoisson(x, lambda, true, false, error_code);
}

bool MathCumulativeDistributionPoisson(const double &x[], const double lambda,
                                       const bool tail, const bool log_mode,
                                       double &result[]) {

  if (!MathIsValidNumber(lambda))
    return false;

  if (lambda <= 0.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  double coef_lambda = MathExp(-lambda);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg != MathRound(x_arg))
      return false;

    if (x_arg < 0.0)
      result[i] = TailLog0(tail, log_mode);
    else {
      int err_code = 0;
      int t = (int)MathFloor(x_arg + 10e-10);
      double cdf = MathCumulativeDistributionGamma(lambda, t + 1, 1, false,
                                                   false, err_code);
      result[i] = TailLogValue(cdf, tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionPoisson(const double &x[], const double lambda,
                                       double &result[]) {
  return MathCumulativeDistributionPoisson(x, lambda, true, false, result);
}

double MathQuantilePoisson(const double probability, const double lambda,
                           const bool tail, const bool log_mode,
                           int &error_code) {

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(lambda)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (lambda <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double prob = TailLogProbability(probability, tail, log_mode);

  if (prob < 0.0 || prob > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (prob == 1.0) {
    error_code = ERR_RESULT_INFINITE;
    return QPOSINF;
  }
  error_code = ERR_OK;
  if (prob == 0.0)
    return 0.0;

  prob *= 1 - 1000 * DBL_EPSILON;
  int err_code = 0;
  int j = 0;
  const int max_terms = 500;
  double coef_lambda = MathExp(-lambda);
  double pwr_lambda = 1.0;
  double inverse_fact = 1.0;
  double sum = 0;

  while (sum < prob && j < max_terms) {
    if (j > 0) {
      pwr_lambda *= lambda;
      inverse_fact /= j;
    }
    sum += coef_lambda * pwr_lambda * inverse_fact;
    j++;
  }

  if (j < max_terms) {
    if (j == 0)
      return 0;
    else
      return j - 1;
  } else {
    error_code = ERR_RESULT_INFINITE;
    return QPOSINF;
  }
}

double MathQuantilePoisson(const double probability, const double lambda,
                           int &error_code) {
  return MathQuantilePoisson(probability, lambda, true, false, error_code);
}

bool MathQuantilePoisson(const double &probability[], const double lambda,
                         const bool tail, const bool log_mode,
                         double &result[]) {

  if (!MathIsValidNumber(lambda))
    return false;

  if (lambda <= 0.0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  double coef_lambda = MathExp(-lambda);

  for (int i = 0; i < data_count; i++) {

    double prob = TailLogProbability(probability[i], tail, log_mode);

    if (prob < 0.0 || prob > 1.0)
      return false;
    else if (prob == 1.0)
      result[i] = QPOSINF;
    if (prob == 0.0)
      result[i] = 0;
    else {
      prob *= 1 - 1000 * DBL_EPSILON;
      int err_code = 0;
      int j = 0;
      double sum = 0.0;
      const int max_terms = 500;
      double pwr_lambda = 1.0;
      double inverse_fact = 1.0;

      while (sum < prob && j < max_terms) {
        if (j > 0) {
          pwr_lambda *= lambda;
          inverse_fact /= j;
        }
        sum += coef_lambda * pwr_lambda * inverse_fact;
        j++;
      }

      if (j < max_terms) {
        if (j == 0)
          result[i] = 0;
        else
          result[i] = j - 1;
      } else
        return false;
    }
  }
  return true;
}

bool MathQuantilePoisson(const double &probability[], const double lambda,
                         double &result[]) {
  return MathQuantilePoisson(probability, lambda, true, false, result);
}

double MathRandomPoisson(const double lambda) {
  const double a0 = -0.5;
  const double a1 = 0.3333333;
  const double a2 = -0.2500068;
  const double a3 = 0.2000118;
  const double a4 = -0.1661269;
  const double a5 = 0.1421878;
  const double a6 = -0.1384794;
  const double a7 = 0.1250060;
  int kflag;
  double fk = 0, difmuk = 0;
  double e = 0, fx, fy, g, p0, px, py, p, q, s, t, u = 0, v, x, xx;
  int value = 0;

  if (lambda < 10.0) {
    int m = MathMax(1, (int)(lambda));
    p = MathExp(-lambda);
    q = p;
    p0 = p;

    for (;;) {
      u = MathRandomNonZero();
      value = 0;

      if (u <= p0)
        return value;

      for (int k = 1; k <= 35; k++) {
        p = p * lambda / double(k);
        q = q + p;
        if (u <= q) {
          value = k;
          return value;
        }
      }
    }
  } else {
    s = MathSqrt(lambda);
    double d = 6.0 * lambda * lambda;
    int l = (int)(lambda - 1.1484);

    double f, x1, x2, r2;
    do {
      x1 = 2.0 * MathRandomNonZero() - 1.0;
      x2 = 2.0 * MathRandomNonZero() - 1.0;
      r2 = x1 * x1 + x2 * x2;
    } while (r2 >= 1.0 || r2 == 0.0);

    f = MathSqrt(-2.0 * MathLog(r2) / r2);
    double snorm = f * x2;

    g = lambda + s * snorm;

    if (0.0 <= g) {
      value = (int)(g);

      if (l <= value)
        return value;

      fk = (double)(value);
      difmuk = lambda - fk;
      u = MathRandomNonZero();

      if (difmuk * difmuk * difmuk <= d * u)
        return value;
    }

    double omega = 0.3989423 / s;
    double b1 = 0.04166667 / lambda;
    double b2 = 0.3 * b1 * b1;
    double c3 = 0.1428571 * b1 * b2;
    double c2 = b2 - 15.0 * c3;
    double c1 = b1 - 6.0 * b2 + 45.0 * c3;
    double c0 = 1.0 - b1 + 3.0 * b2 - 15.0 * c3;
    double c = 0.1069 / lambda;
    double del = 0;

    if (0.0 <= g) {
      kflag = 0;

      if (value < 10) {
        px = -lambda;
        py = MathPow(lambda, value) / MathFactorial(value);
      } else {
        del = 0.8333333E-01 / fk;
        del = del - 4.8 * del * del * del;
        v = difmuk / fk;

        if (0.25 < MathAbs(v)) {
          px = fk * MathLog(1.0 + v) - difmuk - del;
        } else {
          px = fk * v * v *
                   (((((((a7 * v + a6) * v + a5) * v + a4) * v + a3) * v + a2) *
                         v +
                     a1) *
                        v +
                    a0) -
               del;
        }
        py = 0.3989423 / MathSqrt(fk);
      }
      x = (0.5 - difmuk) / s;
      xx = x * x;
      fx = -0.5 * xx;
      fy = omega * (((c3 * xx + c2) * xx + c1) * xx + c0);

      if (kflag <= 0) {
        if (fy - u * fy <= py * MathExp(px - fx))
          return value;
      } else {
        if (c * MathAbs(u) <= py * MathExp(px + e) - fy * MathExp(fx + e))
          return value;
      }
    }

    for (;;) {
      double rnd = MathRandomNonZero();
      e = -MathLog(1.0 - rnd);

      u = 2.0 * MathRandomNonZero() - 1.0;
      if (u < 0.0)
        t = 1.8 - MathAbs(e);
      else
        t = 1.8 + MathAbs(e);

      if (t <= -0.6744)
        continue;

      value = (int)(lambda + s * t);
      fk = (double)(value);
      difmuk = lambda - fk;

      kflag = 1;

      if (value < 10) {
        px = -lambda;
        py = MathPow(lambda, value) / MathFactorial(value);
      } else {
        del = 0.8333333E-01 / fk;
        del = del - 4.8 * del * del * del;
        v = difmuk / fk;

        if (0.25 < MathAbs(v))
          px = fk * MathLog(1.0 + v) - difmuk - del;
        else
          px = fk * v * v *
                   (((((((a7 * v + a6) * v + a5) * v + a4) * v + a3) * v + a2) *
                         v +
                     a1) *
                        v +
                    a0) -
               del;

        py = 0.3989423 / MathSqrt(fk);
      }

      x = (0.5 - difmuk) / s;
      xx = x * x;
      fx = -0.5 * xx;
      fy = omega * (((c3 * xx + c2) * xx + c1) * xx + c0);

      if (kflag <= 0) {
        if (fy - u * fy <= py * MathExp(px - fx))
          return value;
      } else {
        if (c * MathAbs(u) <= py * MathExp(px + e) - fy * MathExp(fx + e))
          return value;
      }
    }
  }
  return value;
}

double MathRandomPoisson(const double lambda, int &error_code) {

  if (!MathIsValidNumber(lambda)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (lambda <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }
  error_code = ERR_OK;
  return MathRandomPoisson(lambda);
}

bool MathRandomPoisson(const double lambda, const int data_count,
                       double &result[]) {

  if (!MathIsValidNumber(lambda))
    return false;

  if (lambda <= 0.0)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    result[i] = MathRandomPoisson(lambda);
  }
  return true;
}

bool MathMomentsPoisson(const double lambda, double &mean, double &variance,
                        double &skewness, double &kurtosis, int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(lambda)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (lambda <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  mean = lambda;
  variance = lambda;
  skewness = MathPow(lambda, -0.5);
  kurtosis = 1.0 / lambda;

  return true;
}

#endif
