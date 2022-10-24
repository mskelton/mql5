#ifndef NONCENTRAL_F_H
#define NONCENTRAL_F_H

#include "F.mqh"
#include "Gamma.mqh"
#include "Math.mqh"
#include "NoncentralBeta.mqh"

double MathProbabilityDensityNoncentralF(const double x, const double nu1,
                                         const double nu2, const double sigma,
                                         const bool log_mode, int &error_code) {

  if (sigma == 0.0)
    return MathProbabilityDensityF(x, nu1, nu2, error_code);

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu1) ||
      !MathIsValidNumber(nu2) || !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x <= 0.0)
    return TailLog0(true, log_mode);

  double nu1_half = nu1 * 0.5;
  double nu2_half = nu2 * 0.5;
  double nu12_half = nu1_half + nu2_half;
  double lambda = sigma * 0.5;
  double coef_lambda = MathExp(-lambda);
  double nu_coef = nu1 / nu2;
  double g = x * nu_coef;
  double pwr_g = MathExp((nu1_half - 1) * MathLog(g));
  double g1 = g + 1.0;
  double pwr_g1 = MathExp(-nu12_half * MathLog(g1));
  double pwr_lambda = 1.0;
  double fact_mult = 1.0;

  double r_beta = MathBeta(nu1_half, nu2_half);

  int max_terms = 100;
  int j = 0;
  double pdf = 0;
  while (j < max_terms) {
    if (j > 0) {
      pwr_g *= g;
      pwr_lambda *= lambda;
      fact_mult /= j;
      pwr_g1 /= g1;
      double jm1 = j - 1;
      r_beta *= ((nu1_half + jm1) / (nu12_half + jm1));
    }
    double dp = pwr_g * pwr_g1 * coef_lambda * pwr_lambda * fact_mult / r_beta;
    pdf += dp;
    if (dp / (pdf + 10E-10) < 10E-14)
      break;
    j++;
  }

  if (j < max_terms)
    return TailLogValue(pdf * nu_coef, true, log_mode);
  else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
}

double MathProbabilityDensityNoncentralF(const double x, const double nu1,
                                         const double nu2, const double sigma,
                                         int &error_code) {
  return MathProbabilityDensityNoncentralF(x, nu1, nu2, sigma, false,
                                           error_code);
}

bool MathProbabilityDensityNoncentralF(const double &x[], const double nu1,
                                       const double nu2, const double sigma,
                                       const bool log_mode, double &result[]) {

  if (sigma == 0.0)
    return MathProbabilityDensityF(x, nu1, nu2, log_mode, result);

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2) ||
      !MathIsValidNumber(sigma))
    return false;

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  const int max_terms = 100;

  double nu1_half = nu1 * 0.5;
  double nu2_half = nu2 * 0.5;
  double nu12_half = nu1_half + nu2_half;
  double lambda = sigma * 0.5;
  double coef_lambda = MathExp(-lambda);
  double nu_coef = nu1 / nu2;
  double r_beta0 = MathBeta(nu1_half, nu2_half);
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg <= 0.0)
      result[i] = TailLog0(true, log_mode);
    else {
      double g = x_arg * nu_coef;
      double g1 = g + 1.0;

      double pwr_g = MathExp((nu1_half - 1) * MathLog(g));
      double pwr_g1 = MathExp(-nu12_half * MathLog(g1));
      double pwr_lambda = 1.0;
      double fact_mult = 1.0;
      double r_beta = r_beta0;

      int j = 0;
      double pdf = 0;
      while (j < max_terms) {
        if (j > 0) {
          pwr_g *= g;
          pwr_lambda *= lambda;
          fact_mult /= j;
          pwr_g1 /= g1;
          double jm1 = j - 1;
          r_beta *= ((nu1_half + jm1) / (nu12_half + jm1));
        }
        double dp =
            pwr_g * pwr_g1 * coef_lambda * pwr_lambda * fact_mult / r_beta;
        pdf += dp;
        if (dp / (pdf + 10E-10) < 10E-14)
          break;
        j++;
      }

      if (j < max_terms)
        result[i] = TailLogValue(pdf * nu_coef, true, log_mode);
      else
        return false;
    }
  }
  return true;
}

bool MathProbabilityDensityNoncentralF(const double &x[], const double nu1,
                                       const double nu2, const double sigma,
                                       double &result[]) {
  return MathProbabilityDensityNoncentralF(x, nu1, nu2, sigma, false, result);
}

double MathCumulativeDistributionNoncentralF(
    const double x, const double nu1, const double nu2, const double sigma,
    const bool tail, const bool log_mode, int &error_code) {

  if (sigma == 0.0)
    return MathCumulativeDistributionF(x, nu1, nu2, error_code);

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu1) ||
      !MathIsValidNumber(nu2) || !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0 ||
      x < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x <= 0)
    return TailLog0(tail, log_mode);

  double arg = (nu1 / nu2) * x;
  return MathCumulativeDistributionNoncentralBeta(arg / (1.0 + arg), nu1 * 0.5,
                                                  nu2 * 0.5, sigma, tail,
                                                  log_mode, error_code);
}

double MathCumulativeDistributionNoncentralF(const double x, const double nu1,
                                             const double nu2,
                                             const double sigma,
                                             int &error_code) {
  return MathCumulativeDistributionNoncentralF(x, nu1, nu2, sigma, true, false,
                                               error_code);
}

bool MathCumulativeDistributionNoncentralF(const double &x[], const double nu1,
                                           const double nu2, const double sigma,
                                           const bool tail, const bool log_mode,
                                           double &result[]) {

  if (sigma == 0.0)
    return MathCumulativeDistributionF(x, nu1, nu2, tail, log_mode, result);

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2) ||
      !MathIsValidNumber(sigma))
    return false;

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  int error_code = 0;
  double nu1_half = nu1 * 0.5;
  double nu2_half = nu2 * 0.5;
  ArrayResize(result, data_count);

  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg <= 0)
      result[i] = TailLog0(tail, log_mode);
    else {

      double arg = (nu1 / nu2) * x_arg;
      result[i] = MathCumulativeDistributionNoncentralBeta(
          arg / (1.0 + arg), nu1_half, nu2_half, sigma, tail, log_mode,
          error_code);

      if (error_code != ERR_OK)
        return false;
    }
  }
  return true;
}

bool MathCumulativeDistributionNoncentralF(const double &x[], const double nu1,
                                           const double nu2, const double sigma,
                                           double &result[]) {
  return MathCumulativeDistributionNoncentralF(x, nu1, nu2, sigma, true, false,
                                               result);
}

double MathQuantileNoncentralF(const double probability, const double nu1,
                               const double nu2, const double sigma,
                               const bool tail, const bool log_mode,
                               int &error_code) {
  if (log_mode == true && probability == QNEGINF)
    return 0.0;

  if (sigma == 0.0)
    return MathQuantileF(probability, nu1, nu2, tail, log_mode, error_code);

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(nu1) ||
      !MathIsValidNumber(nu2) || !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
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

  if (prob == 1.0) {
    error_code = ERR_RESULT_INFINITE;
    return QPOSINF;
  }
  error_code = ERR_OK;
  if (prob == 0.0)
    return 0.0;

  int max_iterations = 50;
  int iterations = 0;

  double h = 1.0;
  double h_min = 10E-10;
  double x = 0.5;
  int err_code = 0;

  while (iterations < max_iterations) {

    if ((MathAbs(h) > h_min && MathAbs(h) > MathAbs(h_min * x)) == false)
      break;

    double pdf =
        MathProbabilityDensityNoncentralF(x, nu1, nu2, sigma, err_code);
    double cdf =
        MathCumulativeDistributionNoncentralF(x, nu1, nu2, sigma, err_code);

    h = (cdf - prob) / pdf;

    double x_new = x - h;

    if (x_new < 0.0)
      x_new = x * 0.1;
    else if (x_new > 1.0)
      x_new = 1.0 - (1.0 - x) * 0.1;

    x = x_new;

    iterations++;
  }

  if (iterations < max_iterations)
    return x;
  else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
}

double MathQuantileNoncentralF(const double probability, const double nu1,
                               const double nu2, const double sigma,
                               int &error_code) {
  return MathQuantileNoncentralF(probability, nu1, nu2, sigma, true, false,
                                 error_code);
}

bool MathQuantileNoncentralF(const double &probability[], const double nu1,
                             const double nu2, const double sigma,
                             const bool tail, const bool log_mode,
                             double &result[]) {

  if (sigma == 0.0)
    return MathQuantileF(probability, nu1, nu2, tail, log_mode, result);

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2) ||
      !MathIsValidNumber(sigma))
    return false;

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0)
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

    if (prob == 1.0)
      result[i] = QPOSINF;
    else if (prob == 0.0)
      result[i] = 0.0;
    else {
      int max_iterations = 50;
      int iterations = 0;

      double h = 1.0;
      double h_min = 10E-10;
      double x = 0.5;
      int err_code = 0;

      while (iterations < max_iterations) {

        if ((MathAbs(h) > h_min && MathAbs(h) > MathAbs(h_min * x)) == false)
          break;

        double pdf =
            MathProbabilityDensityNoncentralF(x, nu1, nu2, sigma, err_code);
        double cdf =
            MathCumulativeDistributionNoncentralF(x, nu1, nu2, sigma, err_code);

        h = (cdf - prob) / pdf;

        double x_new = x - h;

        if (x_new < 0.0)
          x_new = x * 0.1;
        else if (x_new > 1.0)
          x_new = 1.0 - (1.0 - x) * 0.1;

        x = x_new;

        iterations++;
      }

      if (iterations < max_iterations)
        result[i] = x;
      else
        return false;
    }
  }
  return true;
}

bool MathQuantileNoncentralF(const double &probability[], const double nu1,
                             const double nu2, const double sigma,
                             double &result[]) {
  return MathQuantileNoncentralF(probability, nu1, nu2, sigma, true, false,
                                 result);
}

double MathRandomNoncentralF(const double nu1, const double nu2,
                             const double sigma, int &error_code) {

  if (sigma == 0.0)
    return MathRandomF(nu1, nu2, error_code);

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (sigma < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double num = MathRandomNoncentralChiSquare(nu1, sigma, error_code) * nu2;
  double den = MathRandomGamma(nu2 * 0.5, 2.0, error_code) * nu1;
  if (den != 0)
    return num / den;
  else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
}

bool MathRandomNoncentralF(const double nu1, const double nu2,
                           const double sigma, const int data_count,
                           double &result[]) {

  if (sigma == 0.0)
    return MathRandomF(nu1, nu2, data_count, result);

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2) ||
      !MathIsValidNumber(sigma))
    return false;

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0)
    return false;

  if (sigma < 0.0)
    return false;
  int error_code = 0;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double num = MathRandomNoncentralChiSquare(nu1, sigma, error_code) * nu2;
    double den = MathRandomGamma(nu2 * 0.5, 2.0, error_code) * nu1;
    if (den != 0)
      result[i] = num / den;
    else
      return false;
  }
  return true;
}

bool MathMomentsNoncentralF(const double nu1, const double nu2,
                            const double sigma, double &mean, double &variance,
                            double &skewness, double &kurtosis,
                            int &error_code) {

  if (sigma == 0)
    return MathMomentsF(nu1, nu2, mean, variance, skewness, kurtosis,
                        error_code);

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(nu1) || !MathIsValidNumber(nu2) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (nu1 != MathRound(nu1) || nu2 != MathRound(nu2) || nu1 <= 0 || nu2 <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  if (sigma < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  if (nu2 > 2)
    mean = nu2 * (nu1 + sigma) / (nu1 * (nu2 - 2));

  if (nu2 > 4)
    variance = 2 * MathPow(nu2 / nu1, 2) *
               ((nu2 - 2) * (nu1 + 2 * sigma) + MathPow(nu1 + sigma, 2)) /
               ((nu2 - 4) * MathPow(nu2 - 2, 2));

  double sigma_sqr = MathPow(sigma, 2);
  double sigma_cube = sigma_sqr * sigma;
  double nu12m2 = (nu1 + nu2 - 2);
  double nu2p10 = (nu2 + 10);

  if (nu2 > 6) {
    skewness = 2 * M_SQRT2 * MathSqrt(nu2 - 4);
    skewness *=
        (nu12m2 * (6 * sigma_sqr + (2 * nu1 + nu2 - 2) * (3 * sigma + nu1)) +
         2 * sigma_cube);
    skewness /= (nu2 - 6);
    skewness /= MathPow(nu12m2 * (2 * sigma + nu1) + sigma_sqr, 1.5);
  }

  if (nu2 > 8) {
    double coef =
        nu2p10 * (MathPow(nu1, 2) + nu1 * (nu2 - 2)) + 4 * MathPow(nu2 - 2, 2);
    kurtosis = 1;
    kurtosis = 3 * (nu2 - 4);
    kurtosis *= (nu12m2 * (coef * (4 * sigma + nu1) +
                           nu2p10 * (4 * sigma_cube +
                                     2 * sigma_sqr * (3 * nu1 + 2 * nu2 - 4))) +
                 nu2p10 * MathPow(sigma, 4));
    kurtosis /= (nu2 - 8) * (nu2 - 6);
    kurtosis /= MathPow((nu12m2 * (2 * sigma + nu1) + sigma_sqr), 2);
    kurtosis -= 3;
  }

  return true;
}

#endif
