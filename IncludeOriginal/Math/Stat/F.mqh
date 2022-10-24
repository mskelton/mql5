#ifndef F_H
#define F_H

#include "Beta.mqh"
#include "ChiSquare.mqh"
#include "Math.mqh"

double MathProbabilityDensityF(const double x, const double nu1,
                               const double nu2, const bool log_mode,
                               int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu1) ||
      !MathIsValidNumber(nu2)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu1 != MathRound(nu1) || nu1 != MathRound(nu1) || nu1 < 1 || nu2 < 1) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x <= 0)
    return TailLog0(true, log_mode);

  double value = MathPow((nu1 / nu2), nu1 * 0.5) * MathPow(x, (nu1 - 2) * 0.5) /
                 MathBeta(nu1 * 0.5, nu2 * 0.5);
  value = value * MathPow(1.0 + (nu1 / nu2) * x, -(nu1 + nu2) * 0.5);
  if (log_mode == true)
    return MathLog(value);

  return value;
}

double MathProbabilityDensityF(const double x, const double nu1,
                               const double nu2, int &error_code) {
  return MathProbabilityDensityF(x, nu1, nu2, false, error_code);
}

bool MathProbabilityDensityF(const double &x[], const double nu1,
                             const double nu2, const bool log_mode,
                             double &result[]) {

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2))
    return false;

  if (nu1 != MathRound(nu1) || nu1 != MathRound(nu1) || nu1 < 1 || nu2 < 1)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg <= 0)
      result[i] = TailLog0(true, log_mode);
    else {

      double value = MathPow((nu1 / nu2), nu1 * 0.5) *
                     MathPow(x_arg, (nu1 - 2) * 0.5) /
                     MathBeta(nu1 * 0.5, nu2 * 0.5);
      value = value * MathPow(1.0 + (nu1 / nu2) * x_arg, -(nu1 + nu2) * 0.5);
      if (log_mode == true)
        result[i] = MathLog(value);
      else
        result[i] = value;
    }
  }
  return true;
}

bool MathProbabilityDensityF(const double &x[], const double nu1,
                             const double nu2, double &result[]) {
  return MathProbabilityDensityF(x, nu1, nu2, false, result);
}

double MathCumulativeDistributionF(const double x, const double nu1,
                                   const double nu2, const bool tail,
                                   const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu1) ||
      !MathIsValidNumber(nu2)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x <= 0)
    return TailLog0(tail, log_mode);

  double cdf = MathMin(
      1.0 - MathBetaIncomplete(nu2 / (nu2 + nu1 * x), nu2 * 0.5, nu1 * 0.5),
      1.0);
  return TailLogValue(cdf, tail, log_mode);
}

double MathCumulativeDistributionF(const double x, const double nu1,
                                   const double nu2, int &error_code) {
  return MathCumulativeDistributionF(x, nu1, nu2, true, false, error_code);
}

bool MathCumulativeDistributionF(const double &x[], const double nu1,
                                 const double nu2, const bool tail,
                                 const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2))
    return false;

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg <= 0)
      result[i] = TailLog0(tail, log_mode);
    else {

      double cdf = MathMin(1.0 - MathBetaIncomplete(nu2 / (nu2 + nu1 * x_arg),
                                                    nu2 * 0.5, nu1 * 0.5),
                           1.0);
      result[i] = TailLogValue(cdf, tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionF(const double &x[], const double nu1,
                                 const double nu2, double &result[]) {
  return MathCumulativeDistributionF(x, nu1, nu2, true, false, result);
}

double MathQuantileF(const double probability, const double nu1,
                     const double nu2, const bool tail, const bool log_mode,
                     int &error_code) {

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0) {
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

  double qBeta = MathQuantileBeta(1.0 - prob, nu2 * 0.5, nu1 * 0.5, error_code);

  return (nu2 / qBeta - nu2) / nu1;
}

double MathQuantileF(const double probability, const double nu1,
                     const double nu2, int &error_code) {
  return MathQuantileF(probability, nu1, nu2, true, false, error_code);
}

bool MathQuantileF(const double &probability[], const double nu1,
                   const double nu2, const bool tail, const bool log_mode,
                   double &result[]) {

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2))
    return false;

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0)
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

    if (prob == 0.0)
      result[i] = 0.0;
    else if (prob == 1.0)
      result[i] = QPOSINF;
    else {

      double qBeta =
          MathQuantileBeta(1.0 - prob, nu2 * 0.5, nu1 * 0.5, error_code);
      result[i] = (nu2 / qBeta - nu2) / nu1;
    }
  }
  return true;
}

bool MathQuantileF(const double &probability[], const double nu1,
                   const double nu2, double &result[]) {
  return MathQuantileF(probability, nu1, nu2, true, false, result);
}

double MathRandomF(const double nu1, const double nu2, int &error_code) {

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double xnum = MathRandomGamma(nu1 * 0.5, 1.0, error_code) * nu2;
  double xden = MathRandomGamma(nu2 * 0.5, 1.0, error_code) * nu1;

  double value = 0.0;
  if (xden != 0)
    value = xnum / xden;
  else {
    error_code = ERR_NON_CONVERGENCE;
    value = QNaN;
  }

  return value;
}

bool MathRandomF(const double nu1, const double nu2, const int data_count,
                 double &result[]) {

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2))
    return false;

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    int error_code = 0;

    double xnum = MathRandomGamma(nu1 * 0.5, 1.0, error_code) * nu2;
    double xden = MathRandomGamma(nu2 * 0.5, 1.0, error_code) * nu1;

    double value = 0.0;
    if (xden != 0)
      value = xnum / xden;
    else {
      error_code = ERR_NON_CONVERGENCE;
      value = QNaN;
    }

    result[i] = value;
  }
  return true;
}

bool MathMomentsF(const double nu1, const double nu2, double &mean,
                  double &variance, double &skewness, double &kurtosis,
                  int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (nu1 != MathRound(nu1) || nu1 != MathRound(nu1) || nu1 < 1 || nu2 < 1) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  if (nu2 > 2)
    mean = nu2 / (nu2 - 2);
  if (nu2 > 4)
    variance = 2 * nu2 * nu2 * (nu1 + nu2 - 2) /
               (nu1 * (nu2 - 2) * (nu2 - 2) * (nu2 - 4));
  if (nu2 > 6)
    skewness = 2 * MathSqrt(2) * MathSqrt(nu2 - 4) * (2 * nu1 + nu2 - 2) /
               (MathSqrt(nu1 * (nu1 + nu2 - 2)) * (nu2 - 6));
  if (nu2 > 8)
    kurtosis = 12 *
               (nu1 * (5 * nu2 - 22) * (nu1 + nu2 - 2) +
                (nu2 - 4) * (nu2 - 2) * (nu2 - 2)) /
               (nu1 * (nu2 - 8) * (nu2 - 6) * (nu1 + nu2 - 2));

  return true;
}

#endif
