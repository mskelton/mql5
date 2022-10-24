#ifndef GEOMETRIC_H
#define GEOMETRIC_H

#include "Math.mqh"

double MathProbabilityDensityGeometric(const double x, const double p,
                                       const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (p <= 0.0 || p > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (x != MathRound(x)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x < 0)
    return TailLog0(true, log_mode);

  if (p == 1.0) {
    if (x == 0.0)
      return TailLog1(true, log_mode);
    else
      return TailLog0(true, log_mode);
  }

  return TailLogValue(p * MathPow(1.0 - p, x), true, log_mode);
}

double MathProbabilityDensityGeometric(const double x, const double p,
                                       int &error_code) {
  return MathProbabilityDensityGeometric(x, p, false, error_code);
}

bool MathProbabilityDensityGeometric(const double &x[], const double p,
                                     const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(p))
    return false;

  if (p <= 0.0 || p > 1.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);

  if (p == 1.0) {
    for (int i = 0; i < data_count; i++) {
      if (x[i] == 0.0)
        result[i] = TailLog1(true, log_mode);
      else
        result[i] = TailLog0(true, log_mode);
    }
    return true;
  }

  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg != MathRound(x_arg))
      return false;

    if (x_arg < 0)
      result[i] = TailLog0(true, log_mode);
    else {
      double pdf = p * MathPow(1.0 - p, x_arg);
      result[i] = TailLogValue(pdf, true, log_mode);
    }
  }
  return true;
}

bool MathProbabilityDensityGeometric(const double &x[], const double p,
                                     double &result[]) {
  return MathProbabilityDensityGeometric(x, p, false, result);
}

double MathCumulativeDistributionGeometric(const double x, const double p,
                                           const bool tail, const bool log_mode,
                                           int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (p <= 0.0 || p > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }
  error_code = ERR_OK;

  if (x < 0)
    return TailLog0(true, log_mode);

  if (p == 1.0) {
    if (x == 0.0)
      return TailLog1(true, log_mode);
    else
      return TailLog0(true, log_mode);
  }

  double cdf = 1.0 - MathPow(1.0 - p, x + 1.0);
  return TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
}

double MathCumulativeDistributionGeometric(const double x, const double p,
                                           int &error_code) {
  return MathCumulativeDistributionGeometric(x, p, true, false, error_code);
}

bool MathCumulativeDistributionGeometric(const double &x[], const double p,
                                         const bool tail, const bool log_mode,
                                         double &result[]) {

  if (!MathIsValidNumber(p))
    return false;

  if (p <= 0.0 || p > 1.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);

  if (p == 1.0) {
    for (int i = 0; i < data_count; i++) {
      if (x[i] == 0.0)
        result[i] = TailLog1(true, log_mode);
      else
        result[i] = TailLog0(true, log_mode);
    }
    return true;
  }

  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg < 0)
      result[i] = TailLog0(true, log_mode);
    else
      result[i] = TailLogValue(
          MathMin(1.0 - MathPow(1.0 - p, x_arg + 1.0), 1.0), tail, log_mode);
  }
  return true;
}

bool MathCumulativeDistributionGeometric(const double &x[], const double p,
                                         double &result[]) {
  return MathCumulativeDistributionGeometric(x, p, true, false, result);
}

double MathQuantileGeometric(const double probability, const double p,
                             const bool tail, const bool log_mode,
                             int &error_code) {

  if (!MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (p <= 0.0 || p >= 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double prob = TailLogProbability(probability, tail, log_mode);

  if (prob < 0.0 || prob > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (prob == 1.0)
    return QPOSINF;
  if (prob == 0.0)
    return 0.0;

  double res = MathCeil(-1.0 + MathLog(1.0 - prob) / MathLog(1.0 - p) - 1e-12);
  if (res < 0)
    res = 0;

  return res;
}

double MathQuantileGeometric(const double probability, const double p,
                             int &error_code) {
  return MathQuantileGeometric(probability, p, true, false, error_code);
}

bool MathQuantileGeometric(const double &probability[], const double p,
                           const bool tail, const bool log_mode,
                           double &result[]) {

  if (!MathIsValidNumber(p))
    return false;

  if (p <= 0.0 || p >= 1.0)
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
    else {
      double res =
          MathCeil(-1.0 + MathLog(1.0 - prob) / MathLog(1.0 - p) - 1e-12);
      if (res < 0)
        res = 0;
      result[i] = res;
    }
  }
  return true;
}

bool MathQuantileGeometric(const double &probability[], const double p,
                           double &result[]) {
  return MathQuantileGeometric(probability, p, true, false, result);
}

double MathRandomGeometric(const double p, int &error_code) {

  if (!MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (p < 0.0 || p > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double rnd = MathRandomNonZero();
  double res = MathCeil(-1.0 + MathLog(rnd) / MathLog(1.0 - p) - 1e-12);
  if (res < 0)
    res = 0;
  return res;
}

bool MathRandomGeometric(const double p, const int data_count,
                         double &result[]) {

  if (!MathIsValidNumber(p))
    return false;

  if (p < 0.0 || p > 1.0)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double rnd = MathRandomNonZero();
    double res = MathCeil(-1.0 + MathLog(rnd) / MathLog(1.0 - p) - 1e-12);
    if (res < 0)
      res = 0;
    result[i] = res;
  }
  return true;
}

bool MathMomentsGeometric(const double p, double &mean, double &variance,
                          double &skewness, double &kurtosis, int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (p <= 0.0 || p >= 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return (false);
  }

  error_code = ERR_OK;

  mean = (1.0 / p) - 1;
  variance = (1.0 - p) / (p * p);
  skewness = (2.0 - p) / MathSqrt(1.0 - p);
  kurtosis = (p * p - 6 * p + 6) / (1 - p);

  return true;
}

#endif
