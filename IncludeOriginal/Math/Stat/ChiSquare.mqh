#ifndef CHI_SQUARE_H
#define CHI_SQUARE_H

#include "Gamma.mqh"
#include "Math.mqh"

double MathProbabilityDensityChiSquare(const double x, const double nu,
                                       const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu <= 0 || nu != MathRound(nu)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x <= 0.0)
    return TailLog0(true, log_mode);

  double pdf = MathProbabilityDensityGamma(x, nu * 0.5, 2.0, error_code);
  if (log_mode == true)
    return MathLog(pdf);
  return pdf;
}

double MathProbabilityDensityChiSquare(const double x, const double nu,
                                       int &error_code) {
  return MathProbabilityDensityChiSquare(x, nu, false, error_code);
}

bool MathProbabilityDensityChiSquare(const double &x[], const double nu,
                                     const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(nu))
    return false;

  if (nu <= 0 || nu != MathRound(nu))
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

    if (x_arg <= 0.0)
      result[i] = TailLog0(true, log_mode);
    else {

      double pdf =
          MathProbabilityDensityGamma(x_arg, nu * 0.5, 2.0, error_code);
      if (log_mode == true)
        result[i] = MathLog(pdf);
      else
        result[i] = pdf;
    }
  }
  return true;
}

bool MathProbabilityDensityChiSquare(const double &x[], const double nu,
                                     double &result[]) {
  return MathProbabilityDensityChiSquare(x, nu, false, result);
}

double MathCumulativeDistributionChiSquare(const double x, const double nu,
                                           const bool tail, const bool log_mode,
                                           int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu <= 0 || nu != MathRound(nu)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x <= 0.0)
    return TailLog0(true, log_mode);

  return MathCumulativeDistributionGamma(x, nu * 0.5, 2.0, tail, log_mode,
                                         error_code);
}

double MathCumulativeDistributionChiSquare(const double x, const double nu,
                                           int &error_code) {
  return MathCumulativeDistributionChiSquare(x, nu, true, false, error_code);
}

bool MathCumulativeDistributionChiSquare(const double &x[], const double nu,
                                         const bool tail, const bool log_mode,
                                         double &result[]) {

  if (!MathIsValidNumber(nu))
    return false;

  if (nu <= 0 || nu != MathRound(nu))
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

    if (x_arg <= 0.0)
      result[i] = TailLog0(true, log_mode);
    else {
      double cdf = MathCumulativeDistributionGamma(x_arg, nu * 0.5, 2.0, true,
                                                   false, error_code);
      result[i] = TailLogValue(cdf, tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionChiSquare(const double &x[], const double nu,
                                         double &result[]) {
  return MathCumulativeDistributionChiSquare(x, nu, true, false, result);
}

double MathQuantileChiSquare(const double probability, const double nu,
                             const bool tail, const bool log_mode,
                             int &error_code) {

  if (!MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (nu != MathRound(nu)) {
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
    return QPOSINF;

  return MathQuantileGamma(prob, nu * 0.5, 2.0, error_code);
}

double MathQuantileChiSquare(const double probability, const double nu,
                             int &error_code) {
  return MathQuantileChiSquare(probability, nu, true, false, error_code);
}

bool MathQuantileChiSquare(const double &probability[], const double nu,
                           const bool tail, const bool log_mode,
                           double &result[]) {

  if (!MathIsValidNumber(nu))
    return false;

  if (nu <= 0)
    return false;

  if (nu != MathRound(nu))
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

      result[i] = MathQuantileGamma(prob, nu * 0.5, 2.0, error_code);
    }
  }
  return true;
}

bool MathQuantileChiSquare(const double &probability[], const double nu,
                           double &result[]) {
  return MathQuantileChiSquare(probability, nu, true, false, result);
}

double MathRandomChiSquare(const double nu, int &error_code) {

  if (!MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (nu <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  return MathRandomGamma(nu * 0.5, 2.0, error_code);
}

bool MathRandomChiSquare(const double nu, const int data_count,
                         double &result[]) {

  if (!MathIsValidNumber(nu))
    return false;

  if (nu != MathRound(nu))
    return false;

  if (nu <= 0)
    return false;
  int error_code = 0;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    result[i] = MathRandomGamma(nu * 0.5, 2.0, error_code);
  }
  return true;
}

bool MathMomentsChiSquare(const double nu, double &mean, double &variance,
                          double &skewness, double &kurtosis, int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (nu <= 0 || nu != MathRound(nu)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  mean = nu;
  variance = 2 * nu;
  skewness = MathSqrt(8 / nu);
  kurtosis = 12 / nu;

  return true;
}

#endif
