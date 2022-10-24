#ifndef EXPONENTIAL_H
#define EXPONENTIAL_H

#include "Math.mqh"

double MathProbabilityDensityExponential(const double x, const double mu,
                                         const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(mu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (mu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x < 0.0)
    return TailLog0(true, log_mode);

  double lambda = 1.0 / mu;
  if (log_mode == true)
    return MathLog(lambda * MathExp(-x * lambda));

  return lambda * MathExp(-x * lambda);
}

double MathProbabilityDensityExponential(const double x, const double mu,
                                         int &error_code) {
  return MathProbabilityDensityExponential(x, mu, false, error_code);
}

bool MathProbabilityDensityExponential(const double &x[], const double mu,
                                       const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(mu))
    return false;

  if (mu <= 0.0)
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

    if (x_arg < 0.0)
      result[i] = TailLog0(true, log_mode);
    else {

      double lambda = 1.0 / mu;
      if (log_mode == true)
        result[i] = MathLog(lambda * MathExp(-x_arg * lambda));
      else
        result[i] = lambda * MathExp(-x_arg * lambda);
    }
  }
  return true;
}

bool MathProbabilityDensityExponential(const double &x[], const double mu,
                                       double &result[]) {
  return MathProbabilityDensityExponential(x, mu, false, result);
}

double MathCumulativeDistributionExponential(const double x, const double mu,
                                             const bool tail,
                                             const bool log_mode,
                                             int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(mu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (mu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x < 0.0)
    return TailLog0(tail, log_mode);

  double result = MathMin(1.0 - MathExp(-x / mu), 1.0);
  return TailLogValue(result, tail, log_mode);
}

double MathCumulativeDistributionExponential(const double x, const double mu,
                                             int &error_code) {
  return MathCumulativeDistributionExponential(x, mu, true, false, error_code);
}

bool MathCumulativeDistributionExponential(const double &x[], const double mu,
                                           const bool tail, const bool log_mode,
                                           double &result[]) {

  if (!MathIsValidNumber(mu))
    return false;

  if (mu <= 0.0)
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

    if (x_arg < 0.0)
      result[i] = TailLog0(tail, log_mode);
    else {

      double cdf = MathMin(1.0 - MathExp(-x_arg / mu), 1.0);
      result[i] = TailLogValue(cdf, tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionExponential(const double &x[], const double mu,
                                           double &result[]) {
  return MathCumulativeDistributionExponential(x, mu, true, false, result);
}

double MathQuantileExponential(const double probability, const double mu,
                               const bool tail, const bool log_mode,
                               int &error_code) {

  if (!MathIsValidNumber(mu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (mu <= 0.0) {
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
  else if (prob == 1.0)
    return QPOSINF;

  return -mu * MathLog(1.0 - prob);
}

double MathQuantileExponential(const double probability, const double mu,
                               int &error_code) {
  return MathQuantileExponential(probability, mu, true, false, error_code);
}

bool MathQuantileExponential(const double &probability[], const double mu,
                             const bool tail, const bool log_mode,
                             double &result[]) {

  if (!MathIsValidNumber(mu))
    return false;

  if (mu <= 0.0)
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
    else
      result[i] = -mu * MathLog(1.0 - prob);
  }
  return true;
}

bool MathQuantileExponential(const double &probability[], const double mu,
                             double &result[]) {
  return MathQuantileExponential(probability, mu, true, false, result);
}

double MathRandomExponential(const double mu, int &error_code) {

  if (!MathIsValidNumber(mu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (mu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double rnd = MathRandomNonZero();

  return -mu * MathLog(1.0 - rnd);
}

bool MathRandomExponential(const double mu, const int data_count,
                           double &result[]) {

  if (!MathIsValidNumber(mu))
    return false;

  if (mu <= 0.0)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double rnd = MathRandomNonZero();
    result[i] = -mu * MathLog(1.0 - rnd);
  }
  return true;
}

bool MathMomentsExponential(const double mu, double &mean, double &variance,
                            double &skewness, double &kurtosis,
                            int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(mu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (mu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  mean = mu;
  variance = mu * mu;
  skewness = 2;
  kurtosis = 6;

  return true;
}

#endif
