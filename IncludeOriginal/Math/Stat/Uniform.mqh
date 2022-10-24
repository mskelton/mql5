#ifndef UNIFORM_H
#define UNIFORM_H

#include "Math.mqh"

double MathProbabilityDensityUniform(const double x, const double a,
                                     const double b, const bool log_mode,
                                     int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (b <= a) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x >= a && x <= b)
    return TailLogValue(1.0 / (b - a), true, log_mode);

  return TailLog0(true, log_mode);
}

double MathProbabilityDensityUniform(const double x, const double a,
                                     const double b, int &error_code) {
  return MathProbabilityDensityUniform(x, a, b, false, error_code);
}

bool MathProbabilityDensityUniform(const double &x[], const double a,
                                   const double b, const bool log_mode,
                                   double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (b <= a)
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

    if (x_arg >= a && x_arg <= b)
      result[i] = TailLogValue(1.0 / (b - a), true, log_mode);
    else
      result[i] = TailLog0(true, log_mode);
  }
  return true;
}

bool MathProbabilityDensityUniform(const double &x[], const double a,
                                   const double b, double &result[]) {
  return MathProbabilityDensityUniform(x, a, b, false, result);
}

double MathCumulativeDistributionUniform(const double x, const double a,
                                         const double b, const bool tail,
                                         const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (b < a) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (x >= a && x <= b)
    return TailLogValue(MathMin((x - a) / (b - a), 1.0), tail, log_mode);

  if (x > b)
    return TailLog1(tail, log_mode);
  return TailLog0(tail, log_mode);
}

double MathCumulativeDistributionUniform(const double x, const double a,
                                         const double b, int &error_code) {
  return MathCumulativeDistributionUniform(x, a, b, true, false, error_code);
}

bool MathCumulativeDistributionUniform(const double &x[], const double a,
                                       const double b, const bool tail,
                                       const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (b < a)
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

    if (x_arg >= a && x_arg <= b)
      result[i] =
          TailLogValue(MathMin((x_arg - a) / (b - a), 1.0), tail, log_mode);
    else {
      if (x_arg > b)
        result[i] = TailLog1(tail, log_mode);
      else
        result[i] = TailLog0(tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionUniform(const double &x[], const double a,
                                       const double b, double &result[]) {
  return MathCumulativeDistributionUniform(x, a, b, true, false, result);
}

double MathQuantileUniform(const double probability, const double a,
                           const double b, const bool tail, const bool log_mode,
                           int &error_code) {
  if (log_mode == true) {
    if (probability == QNEGINF)
      return 0.0;
  }

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (b < a) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }
  if (b == a)
    return a;

  double prob = TailLogProbability(probability, tail, log_mode);

  if (prob < 0.0 || prob > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (prob == 0.0)
    return a;
  else if (prob == 1.0)
    return b;

  return a + prob * (b - a);
}

double MathQuantileUniform(const double probability, const double a,
                           const double b, int &error_code) {
  return MathQuantileUniform(probability, a, b, true, false, error_code);
}

bool MathQuantileUniform(const double &probability[], const double a,
                         const double b, const bool tail, const bool log_mode,
                         double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (b < a)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    if (log_mode == true && probability[i] == QNEGINF)
      result[i] = 0;
    else {

      double prob = TailLogProbability(probability[i], tail, log_mode);

      if (prob < 0.0 || prob > 1.0)
        return false;

      if (b == a)
        result[i] = a;
      else if (prob == 0.0)
        result[i] = a;
      else if (prob == 1.0)
        result[i] = b;
      else

        result[i] = (a + prob * (b - a));
    }
  }
  return true;
}

bool MathQuantileUniform(const double &probability[], const double a,
                         const double b, double &result[]) {
  return MathQuantileUniform(probability, a, b, true, false, result);
}

double MathRandomUniform(const double a, const double b, int &error_code) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (b < a) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (a == b)
    return a;

  return a + MathRandomNonZero() * (b - a);
}

bool MathRandomUniform(const double a, const double b, const int data_count,
                       double &result[]) {

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (b < a)
    return false;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double rnd = MathRandomNonZero();
    result[i] = a + rnd * (b - a);
  }
  return true;
}

bool MathMomentsUniform(const double a, const double b, double &mean,
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

  if (b <= a) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  mean = 0.5 * (a + b);
  variance = MathPow(b - a, 2) / 12;
  skewness = 0;
  kurtosis = -3 + 9.0 / 5.0;

  return true;
}

#endif
