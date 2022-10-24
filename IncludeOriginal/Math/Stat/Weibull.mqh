#ifndef WEIBULL_H
#define WEIBULL_H

#include "Math.mqh"

double MathProbabilityDensityWeibull(const double x, const double a,
                                     const double b, const bool log_mode,
                                     int &error_code) {

  if (x == QPOSINF || x == QNEGINF) {
    error_code = ERR_OK;
    return TailLog0(true, log_mode);
  }

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0 || b <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x <= 0)
    return TailLog0(true, log_mode);

  double pwr = MathPow(x / b, a - 1);
  double pdf = (a / b) * pwr * MathExp(-(x / b) * pwr);
  if (log_mode == true)
    return MathLog(pdf);

  return pdf;
}

double MathProbabilityDensityWeibull(const double x, const double a,
                                     const double b, int &error_code) {
  return MathProbabilityDensityWeibull(x, a, b, false, error_code);
}

bool MathProbabilityDensityWeibull(const double &x[], const double a,
                                   const double b, const bool log_mode,
                                   double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0 || b <= 0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg == QPOSINF || x_arg == QNEGINF)
      result[i] = TailLog0(true, log_mode);
    else if (x_arg <= 0)
      result[i] = TailLog0(true, log_mode);
    else {

      double pwr = MathPow(x_arg / b, a - 1);
      double pdf = (a / b) * pwr * MathExp(-(x_arg / b) * pwr);
      if (log_mode == true)
        result[i] = MathLog(pdf);
      else
        result[i] = pdf;
    }
  }
  return true;
}

bool MathProbabilityDensityWeibull(const double &x[], const double a,
                                   const double b, double &result[]) {
  return MathProbabilityDensityWeibull(x, a, b, false, result);
}

double MathCumulativeDistributionWeibull(const double x, const double a,
                                         const double b, const bool tail,
                                         const bool log_mode, int &error_code) {

  if (x == QNEGINF) {
    error_code = ERR_OK;
    return TailLog0(tail, log_mode);
  }

  if (x == QPOSINF) {
    error_code = ERR_OK;
    return TailLog1(tail, log_mode);
  }

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0 || b <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x <= 0)
    return TailLog0(tail, log_mode);

  double cdf = MathMin(1.0 - MathExp(-MathPow(x / b, a)), 1.0);
  return TailLogValue(cdf, tail, log_mode);
}

double MathCumulativeDistributionWeibull(const double x, const double a,
                                         const double b, int &error_code) {
  return MathCumulativeDistributionWeibull(x, a, b, true, false, error_code);
}

bool MathCumulativeDistributionWeibull(const double &x[], const double a,
                                       const double b, const bool tail,
                                       const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0 || b <= 0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg == QNEGINF)
      result[i] = TailLog0(tail, log_mode);
    else

        if (x_arg == QPOSINF)
      result[i] = TailLog1(tail, log_mode);
    else

        if (x_arg <= 0)
      result[i] = TailLog0(tail, log_mode);
    else {

      double cdf = MathMin(1.0 - MathExp(-MathPow(x_arg / b, a)), 1.0);
      result[i] = TailLogValue(cdf, tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionWeibull(const double &x[], const double a,
                                       const double b, double &result[]) {
  return MathCumulativeDistributionWeibull(x, a, b, true, false, result);
}

double MathQuantileWeibull(const double probability, const double a,
                           const double b, const bool tail, const bool log_mode,
                           int &error_code) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0 || b <= 0) {
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

  return b * MathPow(-MathLog(1.0 - prob), 1.0 / a);
}

double MathQuantileWeibull(const double probability, const double a,
                           const double b, int &error_code) {
  return MathQuantileWeibull(probability, a, b, true, false, error_code);
}

bool MathQuantileWeibull(const double &probability[], const double a,
                         const double b, const bool tail, const bool log_mode,
                         double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0 || b <= 0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double prob = TailLogProbability(probability[i], tail, log_mode);

    if (prob < 0.0 || prob > 1.0)
      return false;

    if (prob == 1.0)
      result[i] = QPOSINF;

    if (prob == 0.0)
      result[i] = 0.0;
    else

      result[i] = b * MathPow(-MathLog(1.0 - prob), 1.0 / a);
  }
  return true;
}

bool MathQuantileWeibull(const double &probability[], const double a,
                         const double b, double &result[]) {
  return MathQuantileWeibull(probability, a, b, true, false, result);
}

double MathRandomWeibull(const double a, const double b, int &error_code) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0 || b <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double rnd = MathRandomNonZero();
  return b * MathPow(-MathLog(rnd), 1.0 / a);
}

bool MathRandomWeibull(const double a, const double b, const int data_count,
                       double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0 || b <= 0)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double rnd = MathRandomNonZero();
    result[i] = b * MathPow(-MathLog(rnd), 1.0 / a);
  }
  return true;
}

bool MathMomentsWeibull(const double a, const double b, double &mean,
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

  if (a <= 0 || b <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  double g1 = MathGamma(1 + 1.0 / a);
  double g2 = MathGamma(1 + 2.0 / a);
  double g3 = MathGamma(1 + 3.0 / a);
  double g4 = MathGamma(1 + 4.0 / a);

  mean = b * g1;
  variance = b * b * g2 - MathPow(g1, 2);
  skewness =
      (2 * g1 * g1 * g1 - 3 * g1 * g2 + g3) * MathPow(g2 - g1 * g1, -1.5);
  kurtosis = (-6 * MathPow(g1, 4) + 12 * MathPow(g1, 2) * g2 -
              3 * MathPow(g2, 2) - 4 * g1 * g3 + g4) *
             MathPow(g2 - g1 * g1, -2);

  return true;
}

#endif
