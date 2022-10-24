#ifndef LOGNORMAL_H
#define LOGNORMAL_H

#include "Math.mqh"
#include "Normal.mqh"

double MathProbabilityDensityLognormal(const double x, const double mu,
                                       const double sigma, const bool log_mode,
                                       int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(mu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (sigma < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x <= 0.0)
    return TailLog0(true, log_mode);

  if (sigma == 0) {
    if (MathLog(MathAbs(x)) == mu) {
      error_code = ERR_RESULT_INFINITE;
      return QPOSINF;
    } else
      return TailLog0(true, log_mode);
  }

  double y = (MathLog(x) - mu) / sigma;

  if (!MathIsValidNumber(y)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  y = MathAbs(y);
  if (y >= 2 * MathSqrt(DBL_MAX)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  return TailLogValue(M_1_SQRT_2PI * MathExp(-0.5 * y * y) / (x * sigma), true,
                      log_mode);
}

bool MathProbabilityDensityLognormal(const double &x[], const double mu,
                                     const double sigma, const bool log_mode,
                                     double &result[]) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma))
    return false;

  if (sigma < 0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);

  if (sigma == 0) {
    for (int i = 0; i < data_count; i++) {
      if (MathLog(MathAbs(x[i])) == mu)
        result[i] = QPOSINF;
      else
        result[i] = TailLog0(true, log_mode);
      return true;
    }
  }

  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg <= 0.0)
      result[i] = TailLog0(true, log_mode);
    else {

      double y = (MathLog(x_arg) - mu) / sigma;

      if (!MathIsValidNumber(y))
        return false;

      y = MathAbs(y);
      if (y >= 2 * MathSqrt(DBL_MAX))
        return false;

      result[i] =
          TailLogValue(M_1_SQRT_2PI * MathExp(-0.5 * y * y) / (x_arg * sigma),
                       true, log_mode);
    }
  }
  return true;
}

bool MathProbabilityDensityLognormal(const double &x[], const double mu,
                                     const double sigma, double &result[]) {
  return MathProbabilityDensityLognormal(x, mu, sigma, false, result);
}

double MathProbabilityDensityLognormal(const double x, const double mu,
                                       const double sigma, int &error_code) {
  return MathProbabilityDensityLognormal(x, mu, sigma, false, error_code);
}

double MathCumulativeDistributionLognormal(const double x, const double mu,
                                           const double sigma, const bool tail,
                                           const bool log_mode,
                                           int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(mu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (sigma < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x <= 0.0)
    return TailLog0(tail, log_mode);

  return MathCumulativeDistributionNormal(MathLog(x), mu, sigma, tail, log_mode,
                                          error_code);
}

double MathCumulativeDistributionLognormal(const double x, const double mu,
                                           const double sigma,
                                           int &error_code) {
  return MathCumulativeDistributionLognormal(x, mu, sigma, true, false,
                                             error_code);
}

bool MathCumulativeDistributionLognormal(const double &x[], const double mu,
                                         const double sigma, const bool tail,
                                         const bool log_mode,
                                         double &result[]) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma))
    return false;

  if (sigma < 0)
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
      result[i] = TailLog0(tail, log_mode);
    else

      result[i] = MathCumulativeDistributionNormal(MathLog(x_arg), mu, sigma,
                                                   tail, log_mode, error_code);
  }
  return true;
}

bool MathCumulativeDistributionLognormal(const double &x[], const double mu,
                                         const double sigma, double &result[]) {
  return MathCumulativeDistributionLognormal(x, mu, sigma, true, false, result);
}

double MathQuantileLognormal(const double probability, const double mu,
                             const double sigma, const bool tail,
                             const bool log_mode, int &error_code) {
  if (log_mode == true && probability == QNEGINF) {
    error_code = ERR_OK;
    return 0.0;
  }

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(mu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (sigma < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double prob = TailLogProbability(probability, tail, log_mode);

  if (prob < 0.0 || prob > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (prob == 0.0 || prob == 1.0) {
    if (sigma == 0.0) {
      error_code = ERR_OK;
      return MathExp(mu);
    } else if (prob == 0.0) {
      if (sigma > 0) {
        error_code = ERR_OK;
        return 0.0;
      } else if (sigma < 0) {
        error_code = ERR_RESULT_INFINITE;
        return QPOSINF;
      }
    } else {
      if (sigma < 0) {
        error_code = ERR_OK;
        return 0.0;
      } else if (sigma > 0) {
        error_code = ERR_RESULT_INFINITE;
        return QPOSINF;
      }
    }
  }

  return MathExp(MathQuantileNormal(prob, mu, sigma, error_code));
}

double MathQuantileLognormal(const double probability, const double mu,
                             const double sigma, int &error_code) {
  return MathQuantileLognormal(probability, mu, sigma, true, false, error_code);
}

bool MathQuantileLognormal(const double &probability[], const double mu,
                           const double sigma, const bool tail,
                           const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma))
    return false;

  if (sigma < 0)
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

    if (prob == 0.0 || prob == 1.0) {
      if (sigma == 0.0)
        result[i] = MathExp(mu);
      else if (prob == 0.0) {
        if (sigma > 0)
          result[i] = 0.0;
        else if (sigma < 0)
          result[i] = QPOSINF;
      } else {
        if (sigma < 0)
          result[i] = 0.0;
        else if (sigma > 0)
          result[i] = QPOSINF;
      }
    } else

      result[i] = MathExp(MathQuantileNormal(prob, mu, sigma, error_code));
  }
  return true;
}

bool MathQuantileLognormal(const double &probability[], const double mu,
                           const double sigma, double &result[]) {
  return MathQuantileLognormal(probability, mu, sigma, true, false, result);
}

double MathRandomLognormal(const double mu, const double sigma,
                           int &error_code) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (sigma < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }
  error_code = ERR_OK;

  double rnd = MathRandomNonZero();

  rnd = MathQuantileNormal(rnd, mu, sigma, true, false, error_code);
  return MathExp(rnd);
}

bool MathRandomLognormal(const double mu, const double sigma,
                         const int data_count, double &result[]) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma))
    return false;

  if (sigma < 0)
    return false;

  ArrayResize(result, data_count);
  int err_code = 0;
  for (int i = 0; i < data_count; i++)
    result[i] = MathRandomNonZero();

  MathQuantileNormal(result, mu, sigma, result);
  return MathExp(result);
}

bool MathMomentsLognormal(const double mu, const double sigma, double &mean,
                          double &variance, double &skewness, double &kurtosis,
                          int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (sigma < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  double sigma_sqr = sigma * sigma;
  double exp_sigma_sqr = MathExp(sigma_sqr);

  mean = MathExp(mu + sigma_sqr * 0.5);
  variance = (exp_sigma_sqr - 1.0) * MathExp(2 * mu + sigma_sqr);
  skewness = MathSqrt(exp_sigma_sqr - 1.0) * (exp_sigma_sqr + 2.0);
  kurtosis = 3 * MathPowInt(exp_sigma_sqr, 2) +
             2 * MathPowInt(exp_sigma_sqr, 3) + MathPowInt(exp_sigma_sqr, 4) -
             3 - 3;

  return true;
}

#endif
