#ifndef NEGATIVE_BINOMIAL_H
#define NEGATIVE_BINOMIAL_H

#include "Gamma.mqh"
#include "Math.mqh"
#include "Poisson.mqh"

double MathProbabilityDensityNegativeBinomial(const double x, const double r,
                                              const double p,
                                              const bool log_mode,
                                              int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(r) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (r != MathRound(r) || r < 1.0 || p < 0.0 || p > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x < 0.0)
    return TailLog0(true, log_mode);

  double coef = MathRound(
      MathExp(MathGammaLog(r + x) - MathGammaLog(x + 1.0) - MathGammaLog(r)));

  return TailLogValue(coef * MathPow(p, r) * MathPow(1.0 - p, x), true,
                      log_mode);
}

double MathProbabilityDensityNegativeBinomial(const double x, const double r,
                                              const double p, int &error_code) {
  return MathProbabilityDensityNegativeBinomial(x, r, p, false, error_code);
}

bool MathProbabilityDensityNegativeBinomial(const double &x[], const double r,
                                            const double p, const bool log_mode,
                                            double &result[]) {

  if (!MathIsValidNumber(r) || !MathIsValidNumber(p))
    return false;

  if (r != MathRound(r) || r < 1.0 || p < 0.0 || p > 1.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  double power_p_r = MathPow(p, r);
  double log_gamma_r = MathGammaLog(r);
  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg < 0.0)
      result[i] = TailLog0(true, log_mode);
    else {

      double pdf = power_p_r * MathPow(1.0 - p, x_arg) *
                   MathRound(MathExp(MathGammaLog(r + x_arg) -
                                     MathGammaLog(x_arg + 1.0) - log_gamma_r));
      result[i] = TailLogValue(pdf, true, log_mode);
    }
  }
  return true;
}

bool MathProbabilityDensityNegativeBinomial(const double &x[], const double r,
                                            const double p, double &result[]) {
  return MathProbabilityDensityNegativeBinomial(x, r, p, false, result);
}

double MathCumulativeDistributionNegativeBinomial(const double x,
                                                  const double r, double p,
                                                  const bool tail,
                                                  const bool log_mode,
                                                  int error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(r) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (r != MathRound(r) || r < 1.0 || p < 0.0 || p > 1.0 || x < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x < 0.0)
    return TailLog0(tail, log_mode);
  int err_code = 0;

  int max_j = (int)MathFloor(x);
  double p1 = 1.0 - p;

  double factor1 = MathFactorial((int)r - 1);
  double factor2 = 1.0;
  double factor_p = 1.0;
  double factor_r = 1.0 / factor1;
  double power_p_r = MathPowInt(p, int(r)) * factor_r;
  double cdf = 0.0;
  for (int j = 0; j <= max_j; j++) {
    if (j > 0) {
      factor1 *= (j + 1);
      factor2 *= j;
      factor_p *= p1;
    }
    double pdf = power_p_r * factor1 * factor_p / factor2;
    cdf += pdf;
  }

  return TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
}

double MathCumulativeDistributionNegativeBinomial(const double x,
                                                  const double r, double p,
                                                  int error_code) {
  return MathCumulativeDistributionNegativeBinomial(x, r, p, true, false,
                                                    error_code);
}

bool MathCumulativeDistributionNegativeBinomial(const double &x[],
                                                const double r, double p,
                                                const bool tail,
                                                const bool log_mode,
                                                double &result[]) {

  if (!MathIsValidNumber(r) || !MathIsValidNumber(p))
    return false;

  if (r != MathRound(r) || r < 1.0 || p < 0.0 || p > 1.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  double fact1 = MathFactorial((int)r - 1);
  double factor_r = 1.0 / fact1;
  double power_p_r = MathPowInt(p, int(r)) * factor_r;
  double p1 = 1.0 - p;
  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    if (x_arg < 0.0)
      result[i] = TailLog0(tail, log_mode);
    else {
      int err_code = 0;

      int max_j = (int)MathFloor(x_arg);

      double factor1 = fact1;
      double factor2 = 1.0;
      double factor_p = 1.0;
      double cdf = 0.0;
      for (int j = 0; j <= max_j; j++) {
        if (j > 0) {
          factor1 *= (j + 1);
          factor2 *= j;
          factor_p *= p1;
        }
        double pdf = power_p_r * factor1 * factor_p / factor2;
        cdf += pdf;
      }

      result[i] = TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionNegativeBinomial(const double &x[],
                                                const double r, double p,
                                                double &result[]) {
  return MathCumulativeDistributionNegativeBinomial(x, r, p, true, false,
                                                    result);
}

double MathQuantileNegativeBinomial(const double probability, const double r,
                                    const double p, const bool tail,
                                    const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(r) ||
      !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (r != MathRound(r) || r < 1.0 || p < 0.0 || p > 1.0) {
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

  int max_terms = 1000;
  int err_code = 0;

  double fact1 = MathFactorial((int)r - 1);
  double factor_r = 1.0 / fact1;
  double power_p_r = MathPowInt(p, int(r)) * factor_r;
  double p1 = 1.0 - p;

  double factor1 = fact1;
  double factor2 = 1.0;
  double factor_p = 1.0;
  double cdf = 0.0;
  int j = 0;
  while (cdf < prob && j < max_terms) {
    if (j > 0) {
      factor1 *= (j + 1);
      factor2 *= j;
      factor_p *= p1;
    }
    double pdf = power_p_r * factor1 * factor_p / factor2;
    cdf += pdf;
    j++;
  }

  if (j < max_terms) {
    if (j == 0)
      return 0;
    else
      return j - 1;
  } else {
    error_code = ERR_NON_CONVERGENCE;
    return 0;
  }
}

double MathQuantileNegativeBinomial(const double probability, const double r,
                                    const double p, int &error_code) {
  return MathQuantileNegativeBinomial(probability, r, p, true, false,
                                      error_code);
}

bool MathQuantileNegativeBinomial(const double &probability[], const double r,
                                  const double p, const bool tail,
                                  const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(r) || !MathIsValidNumber(p))
    return false;

  if (r != MathRound(r) || r < 1.0 || p < 0.0 || p > 1.0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  double fact1 = MathFactorial((int)r - 1);
  double factor_r = 1.0 / fact1;
  double power_p_r = MathPowInt(p, int(r)) * factor_r;
  double p1 = 1.0 - p;
  int max_terms = 500;
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
      double factor1 = fact1;
      double factor2 = 1.0;
      double factor_p = 1.0;
      double cdf = 0.0;
      int j = 0;
      while (cdf < prob && j < max_terms) {
        if (j > 0) {
          factor1 *= (j + 1);
          factor2 *= j;
          factor_p *= p1;
        }
        double pdf = power_p_r * factor1 * factor_p / factor2;
        cdf += pdf;
        j++;
      }
      if (j < max_terms) {
        if (j == 0)
          result[i] = 0;
        else
          result[i] = j - 1;
      } else
        return false;
    }
  }
  return true;
}

bool MathQuantileNegativeBinomial(const double &probability[], const double r,
                                  const double p, double &result[]) {
  return MathQuantileNegativeBinomial(probability, r, p, true, false, result);
}

double MathRandomNegativeBinomial(const double r, const double p,
                                  int error_code) {

  if (!MathIsValidNumber(r) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (r <= 0.0 || p <= 0.0 || p >= 1.0) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }
  double r_gamma = MathRandomGamma(r, (1 - p) / p);
  return MathRandomPoisson(r_gamma, error_code);
}

bool MathRandomNegativeBinomial(const double r, const double p,
                                const int data_count, double &result[]) {

  if (!MathIsValidNumber(r) || !MathIsValidNumber(p))
    return false;

  if (r <= 0.0 || p <= 0.0 || p >= 1.0)
    return false;

  double p_coef = (1 - p) / p;
  int error_code = 0;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double r_gamma = MathRandomGamma(r, p_coef);
    result[i] = MathRandomPoisson(r_gamma, error_code);
  }
  return true;
}

bool MathMomentsNegativeBinomial(const double r, double p, double &mean,
                                 double &variance, double &skewness,
                                 double &kurtosis, int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(r) || !MathIsValidNumber(p)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (r != MathRound(r) || r < 1.0 || p <= 0.0 || p >= 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  mean = r * (1.0 - p) / p;
  variance = mean / p;
  skewness = (2.0 - p) / MathSqrt((r * (1.0 - p)));
  kurtosis = (p * p - 6 * p + 6) / (r * (1.0 - p));

  return true;
}

#endif
