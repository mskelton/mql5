#ifndef LOGISTIC_H
#define LOGISTIC_H

#include "Math.mqh"

double MathProbabilityDensityLogistic(const double x, const double mu,
                                      const double sigma, const bool log_mode,
                                      int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(mu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (sigma <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double y = (x - mu) / sigma;

  if (!MathIsValidNumber(y)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double e = MathExp(-y);
  double e1 = (1 + e);
  double pdf = e / (sigma * (e1 * e1));
  if (log_mode == true)
    return MathLog(pdf);

  return pdf;
}

double MathProbabilityDensityLogistic(const double x, const double mu,
                                      const double sigma, int &error_code) {
  return MathProbabilityDensityLogistic(x, mu, sigma, false, error_code);
}

bool MathProbabilityDensityLogistic(const double &x[], const double mu,
                                    const double sigma, const bool log_mode,
                                    double &result[]) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma))
    return false;

  if (sigma <= 0.0)
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

    double y = (x_arg - mu) / sigma;

    if (!MathIsValidNumber(y))
      return false;

    double e = MathExp(-y);
    double e1 = (1 + e);
    double pdf = e / (sigma * (e1 * e1));
    if (log_mode == true)
      result[i] = MathLog(pdf);
    else
      result[i] = pdf;
  }
  return true;
}

bool MathProbabilityDensityLogistic(const double &x[], const double mu,
                                    const double sigma, double &result[]) {
  return MathProbabilityDensityLogistic(x, mu, sigma, false, result);
}

double MathCumulativeDistributionLogistic(const double x, const double mu,
                                          double sigma, const bool tail,
                                          const bool log_mode,
                                          int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(mu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (sigma <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double y = (x - mu) / sigma;

  if (!MathIsValidNumber(y)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double result = 1.0 / (1.0 + MathExp(-y));
  return TailLogValue(MathMin(result, 1.0), tail, log_mode);
}

double MathCumulativeDistributionLogistic(const double x, const double mu,
                                          double sigma, int &error_code) {
  return MathCumulativeDistributionLogistic(x, mu, sigma, true, false,
                                            error_code);
}

bool MathCumulativeDistributionLogistic(const double &x[], const double mu,
                                        const double sigma, const bool tail,
                                        const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma))
    return false;

  if (sigma <= 0.0)
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

    double y = (x_arg - mu) / sigma;

    if (!MathIsValidNumber(y))
      return false;

    double cdf = MathMin(1.0 / (1.0 + MathExp(-y)), 1.0);
    result[i] = TailLogValue(cdf, tail, log_mode);
  }
  return true;
}

bool MathCumulativeDistributionLogistic(const double &x[], const double mu,
                                        const double sigma, double &result[]) {
  return MathCumulativeDistributionLogistic(x, mu, sigma, true, false, result);
}

double MathQuantileLogistic(const double probability, const double mu,
                            const double sigma, const bool tail,
                            const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(mu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (sigma < 0.0) {
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
      return mu;
    } else {
      error_code = ERR_RESULT_INFINITE;
      if (prob == 0.0)
        return QNEGINF;
      else
        return QPOSINF;
    }
  }

  error_code = ERR_OK;

  double q = MathLog(prob / (1.0 - prob));

  return mu + sigma * q;
}

double MathQuantileLogistic(const double probability, const double mu,
                            const double sigma, int &error_code) {
  return MathQuantileLogistic(probability, mu, sigma, true, false, error_code);
}

bool MathQuantileLogistic(const double &probability[], const double mu,
                          const double sigma, const bool tail,
                          const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma))
    return false;

  if (sigma < 0.0)
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
        result[i] = mu;
      else {
        if (prob == 0.0)
          result[i] = QNEGINF;
        else
          result[i] = QPOSINF;
      }
    } else {

      double q = MathLog(prob / (1.0 - prob));

      result[i] = mu + sigma * q;
    }
  }
  return true;
}

bool MathQuantileLogistic(const double &probability[], const double mu,
                          const double sigma, double &result[]) {
  return MathQuantileLogistic(probability, mu, sigma, true, false, result);
}

double MathRandomLogistic(const double mu, const double sigma,
                          int &error_code) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (sigma < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (sigma == 0.0)
    return mu;

  double rnd = MathRandomNonZero();

  return mu + sigma * MathLog(rnd / (1.0 - rnd));
}

bool MathRandomLogistic(const double mu, const double sigma,
                        const int data_count, double &result[]) {

  if (!MathIsValidNumber(mu) || !MathIsValidNumber(sigma))
    return false;

  if (sigma < 0.0)
    return false;

  ArrayResize(result, data_count);

  if (sigma == 0.0) {
    for (int i = 0; i < data_count; i++)
      result[i] = mu;
    return true;
  }

  for (int i = 0; i < data_count; i++) {

    double rnd = MathRandomNonZero();

    result[i] = mu + sigma * MathLog(rnd / (1.0 - rnd));
  }
  return true;
}

bool MathMomentsLogistic(const double mu, const double sigma, double &mean,
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

  if (sigma <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }
  error_code = ERR_OK;

  mean = mu;
  variance = MathPow(M_PI * sigma, 2) / 3.0;
  skewness = 0;
  kurtosis = (21.0 / 5.0) - 3;

  return true;
}

#endif
