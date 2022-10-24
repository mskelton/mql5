#ifndef HYPERGEOMETRIC_H
#define HYPERGEOMETRIC_H

#include "Math.mqh"

double MathProbabilityDensityHypergeometric(const double x, const double m,
                                            const double k, const double n,
                                            const bool log_mode,
                                            int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(m) || !MathIsValidNumber(k) ||
      !MathIsValidNumber(n)) {
    error_code = ERR_ARGUMENTS_NAN;
    return (QNaN);
  }

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return (QNaN);
  }

  if (m < 0 || k < 0 || n < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return (QNaN);
  }

  if (n > m || k > m) {
    error_code = ERR_ARGUMENTS_INVALID;
    return (QNaN);
  }

  error_code = ERR_OK;

  if (x > n)
    return TailLog0(true, log_mode);
  if (x > k || m - k - n + x + 1 <= 0)
    return TailLog0(true, log_mode);

  double log_pdf = MathBinomialCoefficientLog(k, x) +
                   MathBinomialCoefficientLog(m - k, n - x) -
                   MathBinomialCoefficientLog(m, n);
  if (log_mode == true)
    return log_pdf;

  return MathExp(log_pdf);
}

double MathProbabilityDensityHypergeometric(const double x, const double m,
                                            const double k, const double n,
                                            int &error_code) {
  return MathProbabilityDensityHypergeometric(x, m, k, n, false, error_code);
}

bool MathProbabilityDensityHypergeometric(const double &x[], const double m,
                                          const double k, const double n,
                                          const bool log_mode,
                                          double &result[]) {

  if (!MathIsValidNumber(m) || !MathIsValidNumber(k) || !MathIsValidNumber(n))
    return false;

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n))
    return false;

  if (m < 0 || k < 0 || n < 0)
    return false;

  if (n > m || k > m)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  double m_k = m - k;
  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg < 0 || x_arg != MathRound(x_arg))
      return false;

    if (x_arg > n)
      result[i] = TailLog0(true, log_mode);
    else

        if (x_arg > k || m_k - n + x_arg + 1 <= 0)
      result[i] = TailLog0(true, log_mode);
    else {

      double log_pdf = MathBinomialCoefficientLog(k, x_arg) +
                       MathBinomialCoefficientLog(m_k, n - x_arg) -
                       MathBinomialCoefficientLog(m, n);
      if (log_mode == true)
        result[i] = log_pdf;
      else
        result[i] = MathExp(log_pdf);
    }
  }
  return true;
}

bool MathProbabilityDensityHypergeometric(const double &x[], const double m,
                                          const double k, const double n,
                                          double &result[]) {
  return MathProbabilityDensityHypergeometric(x, m, k, n, false, result);
}

double MathCumulativeDistributionHypergeometric(const double x, const double m,
                                                const double k, const double n,
                                                const bool tail,
                                                const bool log_mode,
                                                int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(m) || !MathIsValidNumber(k) ||
      !MathIsValidNumber(n)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n) ||
      x != MathRound(x)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (m < 0 || k < 0 || n < 0 || x < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (n > m || k > m) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x >= n || x >= k)
    return TailLog1(tail, log_mode);

  double pdf = MathExp(MathBinomialCoefficientLog(m - k, n) -
                       MathBinomialCoefficientLog(m, n));
  double cdf = pdf;
  double coef = m - k - n + 1;
  for (int j = 0; j <= x - 1; j++) {
    pdf = pdf * (k - j) * (n - j) / ((j + 1) * (coef + j));
    cdf = cdf + pdf;
  }
  return TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
}

double MathCumulativeDistributionHypergeometric(const double x, const double m,
                                                const double k, const double n,
                                                int &error_code) {
  return MathCumulativeDistributionHypergeometric(x, m, k, n, true, false,
                                                  error_code);
}

bool MathCumulativeDistributionHypergeometric(const double &x[], const double m,
                                              const double k, const double n,
                                              const bool tail,
                                              const bool log_mode,
                                              double &result[]) {

  if (!MathIsValidNumber(m) || !MathIsValidNumber(k) || !MathIsValidNumber(n))
    return false;

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n))
    return false;

  if (m < 0 || k < 0 || n < 0)
    return false;

  if (n > m || k > m)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  double coef = m - k - n + 1;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg < 0 || x_arg != MathRound(x_arg))
      return false;

    if (x_arg >= n || x_arg >= k)
      result[i] = TailLog1(tail, log_mode);
    else {

      double pdf = MathExp(MathBinomialCoefficientLog(m - k, n) -
                           MathBinomialCoefficientLog(m, n));
      double cdf = pdf;
      for (int j = 0; j <= x_arg - 1; j++) {
        pdf = pdf * (k - j) * (n - j) / ((j + 1) * (coef + j));
        cdf = cdf + pdf;
      }
      result[i] = TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionHypergeometric(const double &x[], const double m,
                                              const double k, const double n,
                                              double &result[]) {
  return MathCumulativeDistributionHypergeometric(x, m, k, n, true, false,
                                                  result);
}

double MathQuantileHypergeometric(const double probability, const double m,
                                  const double k, const double n,
                                  const bool tail, const bool log_mode,
                                  int &error_code) {

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(m) ||
      !MathIsValidNumber(k) || !MathIsValidNumber(n)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (m < 0 || k < 0 || n < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (n > m || k > m) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double prob = TailLogProbability(probability, tail, log_mode);

  if (prob < 0.0 || prob > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (prob == 0)
    return 0.0;
  if (prob == 1.0)
    return QPOSINF;

  int max_terms = 1000;
  prob *= 1 - 1000 * DBL_EPSILON;
  double m_k = m - k;
  double pdf = MathExp(MathBinomialCoefficientLog(m_k, n) -
                       MathBinomialCoefficientLog(m, n));
  double cdf = pdf;
  double coef = m_k - n + 1;
  int j = 0;
  while (cdf < prob && j < max_terms) {
    pdf = pdf * (k - j) * (n - j) / ((j + 1) * (coef + j));
    cdf = cdf + pdf;
    j++;
  }
  return j;
}

double MathQuantileHypergeometric(const double probability, const double m,
                                  const double k, const double n,
                                  int &error_code) {
  return MathQuantileHypergeometric(probability, m, k, n, true, false,
                                    error_code);
}

bool MathQuantileHypergeometric(const double &probability[], const double m,
                                const double k, const double n, const bool tail,
                                const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(m) || !MathIsValidNumber(k) || !MathIsValidNumber(n))
    return false;

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n))
    return false;

  if (m < 0 || k < 0 || n < 0)
    return false;

  if (n > m || k > m)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  int max_terms = 1000;
  double m_k = m - k;
  double pdf0 = MathExp(MathBinomialCoefficientLog(m_k, n) -
                        MathBinomialCoefficientLog(m, n));
  double coef = m_k - n + 1;

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
      prob *= 1 - 1000 * DBL_EPSILON;
      double pdf = pdf0;
      double cdf = pdf;
      int j = 0;
      while (cdf < prob && j < max_terms) {
        pdf = pdf * (k - j) * (n - j) / ((j + 1) * (coef + j));
        cdf = cdf + pdf;
        j++;
      }
      result[i] = j;
    }
  }
  return true;
}

bool MathQuantileHypergeometric(const double &probability[], const double m,
                                const double k, const double n,
                                double &result[]) {
  return MathQuantileHypergeometric(probability, m, k, n, true, false, result);
}

double MathRandomHypergeometric(const double m, const double k, const double n,
                                int &error_code) {

  if (!MathIsValidNumber(m) || !MathIsValidNumber(k) || !MathIsValidNumber(n)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (m < 0 || k < 0 || n < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (n > m || k > m) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double prob = MathRandomNonZero();
  prob *= 1 - 1000 * DBL_EPSILON;
  int max_terms = 1000;
  double m_k = m - k;
  double coef = m_k - n + 1;
  double pdf = MathExp(MathBinomialCoefficientLog(m_k, n) -
                       MathBinomialCoefficientLog(m, n));
  double cdf = pdf;
  int j = 0;
  while (cdf < prob && j < max_terms) {
    pdf = pdf * (k - j) * (n - j) / ((j + 1) * (coef + j));
    cdf = cdf + pdf;
    j++;
  }
  return j;
}

bool MathRandomHypergeometric(const double m, const double k, const double n,
                              const int data_count, double &result[]) {

  if (!MathIsValidNumber(m) || !MathIsValidNumber(k) || !MathIsValidNumber(n))
    return false;

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n))
    return false;

  if (m < 0 || k < 0 || n < 0)
    return false;

  if (n > m || k > m)
    return false;

  int max_terms = 1000;
  double m_k = m - k;
  double coef = m_k - n + 1;
  double pdf0 = MathExp(MathBinomialCoefficientLog(m_k, n) -
                        MathBinomialCoefficientLog(m, n));

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double prob = MathRandomNonZero();
    prob *= 1 - 1000 * DBL_EPSILON;

    double pdf = pdf0;
    double cdf = pdf;
    int j = 0;
    while (cdf < prob && j < max_terms) {
      pdf = pdf * (k - j) * (n - j) / ((j + 1) * (coef + j));
      cdf = cdf + pdf;
      j++;
    }
    result[i] = j;
  }
  return true;
}

bool MathMomentsHypergeometric(const double m, const double k, const double n,
                               double &mean, double &variance, double &skewness,
                               double &kurtosis, int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(m) || !MathIsValidNumber(k) || !MathIsValidNumber(n)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (m != MathRound(m) || k != MathRound(k) || n != MathRound(n)) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  if (m < 0 || k < 0 || n < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  if (n > m || k > m) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  mean = n * k / m;
  variance = k * n * (1 - k / m) * (m - n) / (m * (m - 1));
  skewness = MathSqrt(m - 1) * (m - 2 * k) * (m - 2 * n) /
             ((m - 2) * MathSqrt(k * n * (m - k) * (m - n)));
  kurtosis = (m - 1) * m * m / (k * n * (m - 3) * (m - 2) * (m - k) * (m - n));
  kurtosis *= 3 * k * (m - k) *
                  (m * m * (n - 2) - m * n * n + 6 * n * (m - n)) / (m * m) -
              6 * n * (m - n) + m * (m + 1);
  kurtosis -= 3;

  return true;
}

#endif
