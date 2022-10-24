#ifndef CAUCHY_H
#define CAUCHY_H

#include "Math.mqh"

double MathProbabilityDensityCauchy(const double x, const double a,
                                    const double b, const bool log_mode,
                                    int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (b <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double y = (x - a) / b;

  if (!MathIsValidNumber(y)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (log_mode == true)
    return -MathLog(M_PI * b * (1.0 + y * y));

  return 1.0 / (M_PI * b * (1.0 + y * y));
}

double MathProbabilityDensityCauchy(const double x, const double a,
                                    const double b, int &error_code) {
  return MathProbabilityDensityCauchy(x, a, b, false, error_code);
}

bool MathProbabilityDensityCauchy(const double &x[], const double a,
                                  const double b, const bool log_mode,
                                  double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (b <= 0.0)
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

    double y = (x_arg - a) / b;
    if (log_mode == true)
      result[i] = -MathLog(M_PI * b * (1.0 + y * y));
    else
      result[i] = (1.0 / (M_PI * b * (1.0 + y * y)));
  }
  return true;
}

bool MathProbabilityDensityCauchy(const double &x[], const double a,
                                  const double b, double &result[]) {
  return MathProbabilityDensityCauchy(x, a, b, false, result);
}

double MathCumulativeDistributionCauchy(const double x, const double a,
                                        const double b, const bool tail,
                                        const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (b <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double y = (x - a) / b;

  if (!MathIsValidNumber(y)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }
  error_code = ERR_OK;

  double cdf = 0;
  if (y > -1.0)
    cdf = MathMin(0.5 + M_1_PI * MathArctan(y), 1.0);
  else
    cdf = MathMin(M_1_PI * MathArctan(-1 / y), 1.0);

  return TailLogValue(cdf, tail, log_mode);
}

double MathCumulativeDistributionCauchy(const double x, const double a,
                                        const double b, int &error_code) {
  return MathCumulativeDistributionCauchy(x, a, b, true, false, error_code);
}

bool MathCumulativeDistributionCauchy(const double &x[], const double a,
                                      const double b, const bool tail,
                                      const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (b <= 0.0)
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

    double y = (x_arg - a) / b;

    if (!MathIsValidNumber(y))
      return false;

    double cdf = 0;
    if (y > -1.0)
      cdf = MathMin(0.5 + M_1_PI * MathArctan(y), 1.0);
    else
      cdf = MathMin(M_1_PI * MathArctan(-1 / y), 1.0);

    result[i] = TailLogValue(cdf, tail, log_mode);
  }

  return true;
}

bool MathCumulativeDistributionCauchy(const double &x[], const double a,
                                      const double b, double &result[]) {
  return MathCumulativeDistributionCauchy(x, a, b, true, false, result);
}

double MathQuantileCauchy(const double probability, const double a,
                          const double b, const bool tail, const bool log_mode,
                          int &error_code) {

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(a) ||
      !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (b <= 0.0) {
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

  if (prob == 0.0) {
    error_code = ERR_RESULT_INFINITE;
    return QNEGINF;
  }
  error_code = ERR_OK;

  return a + b * MathTan(M_PI * (prob - 0.5));
}

double MathQuantileCauchy(const double probability, const double a,
                          const double b, int &error_code) {
  return MathQuantileCauchy(probability, a, b, true, false, error_code);
}

bool MathQuantileCauchy(const double &probability[], const double a,
                        const double b, const bool tail, const bool log_mode,
                        double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (b <= 0.0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    if (!MathIsValidNumber(probability[i]))
      return false;

    double prob = TailLogProbability(probability[i], tail, log_mode);

    if (prob < 0.0 || prob > 1.0)
      return false;

    if (prob == 1.0)
      result[i] = QPOSINF;
    else

        if (prob == 0.0)
      result[i] = QNEGINF;
    else
      result[i] = a + b * MathTan(M_PI * (prob - 0.5));
  }
  return true;
}

bool MathQuantileCauchy(const double &probability[], const double a,
                        const double b, double &result[]) {
  return MathQuantileCauchy(probability, a, b, true, false, result);
}

double MathRandomCauchy(const double a, const double b, int &error_code) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (b < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (b == 0.0)
    return a;

  double rnd = MathRandomNonZero();

  return a + b * MathTan(M_PI * (rnd - 0.5));
}

bool MathRandomCauchy(const double a, const double b, const int data_count,
                      double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (b < 0)
    return false;

  ArrayResize(result, data_count);

  if (b == 0.0) {
    for (int i = 0; i < data_count; i++)
      result[i] = a;
  } else

    for (int i = 0; i < data_count; i++) {

      double rnd = MathRandomNonZero();
      result[i] = a + b * MathTan(M_PI * (rnd - 0.5));
    }
  return true;
}

bool MathMomentsCauchy(const double a, const double b, double &mean,
                       double &variance, double &skewness, double &kurtosis,
                       int &error_code) {
  error_code = ERR_OK;

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  return true;
}

#endif
