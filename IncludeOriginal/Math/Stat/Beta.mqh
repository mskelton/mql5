#ifndef BETA_H
#define BETA_H

#include "Math.mqh"

double MathProbabilityDensityBeta(const double x, const double a,
                                  const double b, const bool log_mode,
                                  int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0.0 || b <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x <= 0.0 || x >= 1.0)
    return TailLog0(true, log_mode);

  double log_result =
      (a - 1.0) * MathLog(x) + (b - 1.0) * MathLog(1.0 - x) - MathBetaLog(a, b);

  if (log_mode == true)
    return log_result;

  return MathExp(log_result);
}

double MathProbabilityDensityBeta(const double x, const double a,
                                  const double b, int &error_code) {
  return MathProbabilityDensityBeta(x, a, b, false, error_code);
}

bool MathProbabilityDensityBeta(const double &x[], const double a,
                                const double b, const bool log_mode,
                                double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0.0 || b <= 0.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg <= 0.0 || x_arg >= 1.0)
      result[i] = TailLog0(true, log_mode);
    else {
      double log_result = (a - 1.0) * MathLog(x_arg) +
                          (b - 1.0) * MathLog(1.0 - x_arg) - MathBetaLog(a, b);
      if (log_mode == true)
        result[i] = log_result;
      else
        result[i] = MathExp(log_result);
    }
  }
  return true;
}

bool MathProbabilityDensityBeta(const double &x[], const double a,
                                const double b, double &result[]) {
  return MathProbabilityDensityBeta(x, a, b, false, result);
}

double MathCumulativeDistributionBeta(const double x, const double a,
                                      const double b, const bool tail,
                                      const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0.0 || b <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x <= 0.0)
    return TailLog0(tail, log_mode);
  if (x >= 1.0)
    return TailLog1(tail, log_mode);

  double cdf = MathMin(MathBetaIncomplete(x, a, b), 1.0);

  return TailLogValue(cdf, tail, log_mode);
}

double MathCumulativeDistributionBeta(const double x, const double a,
                                      const double b, int &error_code) {
  return MathCumulativeDistributionBeta(x, a, b, true, false, error_code);
}

bool MathCumulativeDistributionBeta(const double &x[], const double a,
                                    const double b, const bool tail,
                                    const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0.0 || b <= 0.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];
    if (MathIsValidNumber(x_arg)) {
      if (x_arg <= 0.0)
        result[i] = TailLog0(tail, log_mode);
      if (x_arg >= 1.0)
        result[i] = TailLog1(tail, log_mode);
      else {

        double cdf = MathMin(MathBetaIncomplete(x_arg, a, b), 1.0);

        result[i] = TailLogValue(cdf, tail, log_mode);
      }
    } else
      return false;
  }
  return (true);
}

bool MathCumulativeDistributionBeta(const double &x[], const double a,
                                    const double b, double &result[]) {
  return MathCumulativeDistributionBeta(x, a, b, true, false, result);
}

double MathQuantileBeta(const double probability, const double a,
                        const double b, const bool tail, const bool log_mode,
                        int &error_code) {

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(a) ||
      !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0.0 || b <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double prob = TailLogProbability(probability, tail, log_mode);

  if (prob < 0.0 || prob > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (prob == 0.0)
    return 0.0;
  if (prob == 1.0)
    return 1.0;

  const double eps = 10e-16;

  double h = 1.0;
  double h_min = MathSqrt(eps);

  double x = a / (a + b);
  if (x == 0.0)
    x = h_min;
  else if (x == 1.0)
    x = 1.0 - h_min;

  int err_code = 0;
  const int max_iterations = 100;
  int iterations = 0;

  while (iterations < max_iterations) {

    if (((MathAbs(h) > h_min * MathAbs(x)) && (MathAbs(h) > h_min)) == false)
      break;

    double pdf = MathProbabilityDensityBeta(x, a, b, false, err_code);
    double cdf = MathCumulativeDistributionBeta(x, a, b, true, false, err_code);

    h = (cdf - prob) / pdf;

    double x_new = x - h;

    if (x_new < 0.0)
      x_new = x * 0.1;
    else if (x_new > 1.0)
      x_new = 1.0 - (1.0 - x) * 0.1;
    x = x_new;

    iterations++;
  }

  if (iterations < max_iterations)
    return x;
  else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
}

double MathQuantileBeta(const double probability, const double a,
                        const double b, int &error_code) {
  return MathQuantileBeta(probability, a, b, true, false, error_code);
}

bool MathQuantileBeta(const double &probability[], const double a,
                      const double b, const bool tail, const bool log_mode,
                      double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0.0 || b <= 0.0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);

  const double eps = 10e-16;
  double h_min = MathSqrt(eps);

  int err_code = 0;
  const int max_iterations = 1000;
  for (int i = 0; i < data_count; i++) {

    double prob = TailLogProbability(probability[i], tail, log_mode);

    if (MathIsValidNumber(prob)) {

      if (prob < 0.0 || prob > 1.0)
        return false;

      if (prob == 0.0)
        result[i] = 0.0;
      else if (prob == 1.0)
        result[i] = 1.0;
      else {

        double x = a / (a + b);
        if (x == 0.0)
          x = h_min;
        else if (x == 1.0)
          x = 1.0 - h_min;

        double h = 1.0;
        int iterations = 0;

        while (iterations < max_iterations) {

          if (((MathAbs(h) > h_min * MathAbs(x)) && (MathAbs(h) > h_min)) ==
              false)
            break;

          double pdf = MathProbabilityDensityBeta(x, a, b, false, err_code);
          double cdf =
              MathCumulativeDistributionBeta(x, a, b, true, false, err_code);

          h = (cdf - prob) / pdf;

          double x_new = x - h;

          if (x_new < 0.0)
            x_new = x * 0.1;
          else if (x_new > 1.0)
            x_new = 1.0 - (1.0 - x) * 0.1;
          x = x_new;

          iterations++;
        }

        if (iterations < max_iterations)
          result[i] = x;
        else
          return false;
      }
    } else
      return false;
  }
  return true;
}

bool MathQuantileBeta(const double &probability[], const double a,
                      const double b, double &result[]) {
  return MathQuantileBeta(probability, a, b, true, false, result);
}

double MathRandomBeta(const double a, const double b) {
  const double log4 = MathLog(4);
  const double log5 = MathLog(5);
  double a1, b1, alpha, beta, gamma, delta, r, s, u1, u2, v, y, z;
  double w = 0.0;
  double value = 0;

  if (1.0 < a && 1.0 < b) {

    a1 = MathMin(a, b);
    b1 = MathMax(a, b);
    alpha = a1 + b1;
    beta = MathSqrt((alpha - 2.0) / (2.0 * a1 * b1 - alpha));
    gamma = a1 + 1.0 / beta;

    for (;;) {
      u1 = MathRandomNonZero();
      u2 = MathRandomNonZero();

      if (u1 != 1.0)
        v = beta * MathLog(u1 / (1.0 - u1));
      else
        v = 0.0;

      w = a1 * MathExp(v);

      z = u1 * u1 * u2;
      r = gamma * v - log4;
      s = a1 + r - w;

      if (5.0 * z <= s + 1.0 + log5)
        break;

      double t = MathLog(z);
      if (t <= s)
        break;

      if (t <= (r + alpha * MathLog(alpha / (b1 + w))))
        break;
    }
  } else {

    a1 = MathMax(a, b);
    b1 = MathMin(a, b);
    alpha = a1 + b1;
    beta = 1.0 / b1;
    delta = 1.0 + a1 - b1;
    double k1 = delta * (1.0 / 72.0 + b1 / 24.0) / (a1 / b1 - 7.0 / 9.0);
    double k2 = 0.25 + (0.5 + 0.25 / delta) * b1;

    for (;;) {
      u1 = MathRandomNonZero();
      u2 = MathRandomNonZero();

      if (u1 < 0.5) {
        y = u1 * u2;
        z = u1 * y;

        if (k1 <= 0.25 * u2 + z - y)
          continue;
      } else {
        z = u1 * u1 * u2;

        if (z <= 0.25) {
          if (u1 != 1.0)
            v = beta * MathLog(u1 / (1.0 - u1));
          else
            v = 0.0;

          w = a1 * MathExp(v);

          if (a == a1)
            value = w / (b1 + w);
          else
            value = b1 / (b1 + w);

          return value;
        }

        if (k2 < z)
          continue;
      }

      if (u1 != 1.0)
        v = beta * MathLog(u1 / (1.0 - u1));
      else
        v = 0.0;
      w = a1 * MathExp(v);

      if (MathLog(z) <= alpha * (MathLog(alpha / (b1 + w)) + v) - log4)
        break;
    }
  }

  if (a == a1)
    value = w / (b1 + w);
  else
    value = b1 / (b1 + w);

  return value;
}

double MathRandomBeta(const double a, const double b, int &error_code) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0.0 || b <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  return MathRandomBeta(a, b);
}

bool MathRandomBeta(const double a, const double b, const int data_count,
                    double &result[]) {
  if (data_count <= 0)
    return false;

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0.0 || b <= 0.0)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++)
    result[i] = MathRandomBeta(a, b);

  return true;
}

bool MathMomentsBeta(const double a, const double b, double &mean,
                     double &variance, double &skewness, double &kurtosis,
                     int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (a <= 0.0 || b <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  mean = a / (a + b);
  variance = (a * b) / ((a + b) * (a + b) * (a + b + 1));
  skewness =
      2 * (b - a) * MathSqrt(a + b + 1) / (MathSqrt(a * b) * (a + b + 2));
  kurtosis = 6 *
             (a * a * a + a * a * (1 - 2 * b) + b * b * (1 + b) -
              2 * a * b * (2 + b)) /
             (a * b * (a + b + 2) * (a + b + 3));

  return true;
}

#endif
