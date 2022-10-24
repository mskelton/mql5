#ifndef NONCENTRAL_CHI_SQUARE_H
#define NONCENTRAL_CHI_SQUARE_H

#include "ChiSquare.mqh"
#include "Math.mqh"
#include "Normal.mqh"
#include "Poisson.mqh"

double MathProbabilityDensityNoncentralChiSquare(const double x,
                                                 const double nu,
                                                 const double sigma,
                                                 const bool log_mode,
                                                 int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x <= 0.0)
    return TailLog0(true, log_mode);

  int err_code = 0;
  int max_terms = 1000;
  double lambda = sigma * 0.5;
  double half_nu = nu * 0.5;
  double pwr_lambda = 1.0;
  double pwr_two = MathExp(-half_nu * MathLog(2));
  double pwr_x = MathExp((half_nu - 1.0) * MathLog(x));
  double fact_mult = 1.0;
  double coef_lambda_x = MathExp(-lambda - x * 0.5);
  double coef_gamma = 1.0 / MathGamma(half_nu);
  double inv_factor = 1.0;

  int j = 0;
  double pdf = 0;
  while (j < max_terms) {
    if (j > 0) {
      pwr_lambda *= lambda;
      pwr_x *= x;
      pwr_two *= 0.5;
      fact_mult *= 1.0 / j;
      inv_factor *= 1.0 / (j + half_nu - 1);
    }
    double dp = coef_gamma * inv_factor * pwr_lambda * pwr_two * pwr_x *
                fact_mult * coef_lambda_x;
    pdf = pdf + dp;

    if (dp / (pdf + 10E-10) < 10E-16)
      break;
    j++;
  }

  if (j < max_terms)
    return TailLogValue(pdf, true, log_mode);
  else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
}

double MathProbabilityDensityNoncentralChiSquare(double x, const double nu,
                                                 const double sigma,
                                                 int &error_code) {
  return MathProbabilityDensityNoncentralChiSquare(x, nu, sigma, false,
                                                   error_code);
}

bool MathProbabilityDensityNoncentralChiSquare(const double &x[],
                                               const double nu,
                                               const double sigma,
                                               const bool log_mode,
                                               double &result[]) {

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(sigma))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  ArrayResize(result, data_count);

  int max_terms = 1000;
  double lambda = sigma * 0.5;
  double half_nu = nu * 0.5;
  double coef_gamma = 1.0 / MathGamma(half_nu);
  double pwr_two2 = MathExp(-half_nu * MathLog(2));
  double pwr_half_num1 = (half_nu - 1.0);
  double coef_exp_lambda = MathExp(-lambda);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg <= 0)
      result[i] = TailLog0(true, log_mode);
    else {
      int err_code = 0;

      double pwr_lambda = 1.0;
      double pwr_two = pwr_two2;
      double pwr_x = MathPow(x_arg, pwr_half_num1);
      double fact_mult = 1.0;
      double coef_lambda_x = coef_exp_lambda * MathExp(-x_arg * 0.5);
      double inv_factor = 1.0;

      int j = 0;
      double pdf = 0;
      while (j < max_terms) {
        if (j > 0) {
          pwr_lambda *= lambda;
          pwr_x *= x_arg;
          pwr_two *= 0.5;
          fact_mult *= 1.0 / j;
          inv_factor *= 1.0 / (j + half_nu - 1);
        }
        double dp = coef_gamma * inv_factor * pwr_lambda * pwr_two * pwr_x *
                    fact_mult * coef_lambda_x;
        pdf = pdf + dp;

        if (dp / (pdf + 10E-10) < 10E-16)
          break;
        j++;
      }

      if (j < max_terms)
        result[i] = TailLogValue(pdf, true, log_mode);
      else
        return false;
    }
  }
  return true;
}

bool MathProbabilityDensityNoncentralChiSquare(const double &x[],
                                               const double nu,
                                               const double sigma,
                                               double &result[]) {
  return MathProbabilityDensityNoncentralChiSquare(x, nu, sigma, false, result);
}

double MathCumulativeDistributionNoncentralChiSquare(
    const double x, const double nu, const double sigma, const bool tail,
    const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x <= 0.0)
    return TailLog0(true, log_mode);

  double cdf = 0.0;
  int max_terms = 100;
  double lambda = sigma * 0.5;
  double coef_lambda = MathExp(-lambda);
  double pwr_lambda = 1.0;
  double fact_mult = 1.0;
  double half_x = x * 0.5;
  double half_nu = nu * 0.5;

  int j = 0;
  while (j < max_terms) {
    if (j > 0) {
      pwr_lambda *= lambda;
      fact_mult /= j;
    }
    double coef1 = coef_lambda * pwr_lambda * fact_mult;
    double coef2 = MathMin(MathGammaIncomplete(half_x, half_nu + j), 1.0);
    double dp = coef1 * coef2;
    cdf = cdf + dp;
    if ((dp / (cdf + 10E-10)) < 10E-16)
      break;
    j++;
  }

  if (j < max_terms) {

    cdf = MathMin(cdf, 1.0);
    return TailLogValue(cdf, tail, log_mode);
  } else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
}

double MathCumulativeDistributionNoncentralChiSquare(const double x,
                                                     const double nu,
                                                     const double sigma,
                                                     int &error_code) {
  return MathCumulativeDistributionNoncentralChiSquare(x, nu, sigma, true,
                                                       false, error_code);
}

bool MathCumulativeDistributionNoncentralChiSquare(
    const double &x[], const double nu, const double sigma, const bool tail,
    const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(sigma))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  double lambda = sigma * 0.5;
  double coef_lambda = MathExp(-lambda);
  double half_nu = nu * 0.5;
  const int max_terms = 100;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg <= 0.0)
      result[i] = TailLog0(tail, log_mode);
    else {
      double pwr_lambda = 1.0;
      double fact_mult = 1.0;
      double half_x = x_arg * 0.5;
      double cdf = 0.0;
      int j = 0;

      while (j < max_terms) {
        if (j > 0) {
          pwr_lambda *= lambda;
          fact_mult /= j;
        }
        double coef1 = coef_lambda * pwr_lambda * fact_mult;
        double coef2 = MathMin(MathGammaIncomplete(half_x, half_nu + j), 1.0);
        double dp = coef1 * coef2;
        cdf = cdf + dp;
        if ((dp / (cdf + 10E-10)) < 10E-16)
          break;
        j++;
      }

      if (j < max_terms) {

        cdf = MathMin(cdf, 1.0);
        result[i] = TailLogValue(cdf, tail, log_mode);
      } else
        return false;
    }
  }
  return true;
}

bool MathCumulativeDistributionNoncentralChiSquare(const double &x[],
                                                   const double nu,
                                                   const double sigma,
                                                   double &result[]) {
  return MathCumulativeDistributionNoncentralChiSquare(x, nu, sigma, true,
                                                       false, result);
}

double MathQuantileNoncentralChiSquare(const double probability,
                                       const double nu, const double sigma,
                                       const bool tail, const bool log_mode,
                                       int &error_code) {
  if (log_mode == true) {
    if (probability == QNEGINF)
      return 0.0;
  }

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(nu) ||
      !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
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

  error_code = ERR_OK;

  const int max_terms = 1000;
  double lambda = sigma * 0.5;
  double half_nu = nu * 0.5;
  double coef_lambda = MathExp(-lambda);
  double half_nu_m1 = half_nu - 1.0;
  double coef_gamma = 1.0 / MathGamma(half_nu);
  double pwr_two2 = MathExp(-half_nu * MathLog(2));
  double pwr_half_num1 = (half_nu - 1.0);

  double x = 0.5;
  double h = 1.0;
  double h_min = 10E-10;

  const int max_iterations = 50;
  int iterations = 0;

  while (iterations < max_iterations) {

    if ((MathAbs(h) > h_min && MathAbs(h) > MathAbs(h_min * x)) == false)
      break;

    double half_x = x * 0.5;
    double pwr_lambda = 1.0;
    double pwr_two = pwr_two2;
    double pwr_x = MathPow(x, pwr_half_num1);
    double fact_mult = 1.0;
    double coef_lambda_x = coef_lambda * MathExp(-half_x);
    double inv_factor = 1.0;

    int j = 0;
    double pdf = 0;
    while (j < max_terms) {
      if (j > 0) {
        pwr_lambda *= lambda;
        pwr_x *= x;
        pwr_two *= 0.5;
        fact_mult *= 1.0 / j;
        inv_factor *= 1.0 / (j + half_nu - 1);
      }
      double dp = coef_gamma * inv_factor * pwr_lambda * pwr_two * pwr_x *
                  fact_mult * coef_lambda_x;
      pdf = pdf + dp;

      if (dp / (pdf + 10E-10) < 10E-16)
        break;
      j++;
    }

    if (j > max_terms) {
      error_code = ERR_NON_CONVERGENCE;
      return QNaN;
    }

    pwr_lambda = 1.0;
    fact_mult = 1.0;
    double cdf = 0.0;
    j = 0;

    while (j < max_terms) {
      if (j > 0) {
        pwr_lambda *= lambda;
        fact_mult /= j;
      }
      double coef1 = coef_lambda * pwr_lambda * fact_mult;
      double coef2 = MathMin(MathGammaIncomplete(half_x, half_nu + j), 1.0);
      double dp = coef1 * coef2;
      cdf = cdf + dp;
      if ((dp / (cdf + 10E-10)) < 10E-16)
        break;
      j++;
    }

    if (j > max_terms) {
      error_code = ERR_NON_CONVERGENCE;
      return QNaN;
    }

    h = (cdf - prob) / pdf;

    double x_new = x - h;
    if (x_new < 0.0)
      x_new = x * 0.1;
    else if (x_new > 1.0)
      x_new = 1.0 - (1 - x) * 0.1;
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

double MathQuantileNoncentralChiSquare(const double probability,
                                       const double nu, const double sigma,
                                       int &error_code) {
  return MathQuantileNoncentralChiSquare(probability, nu, sigma, true, false,
                                         error_code);
}

bool MathQuantileNoncentralChiSquare(const double &probability[],
                                     const double nu, const double sigma,
                                     const bool tail, const bool log_mode,
                                     double &result[]) {

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(sigma))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  double lambda = sigma * 0.5;
  double half_nu = nu * 0.5;
  double pwr_two0 = MathExp(-half_nu * MathLog(2));
  double pwr_gamma0 = 1.0 / MathGamma(half_nu);
  double coef_lambda = MathExp(-lambda);
  double half_nu_m1 = half_nu - 1.0;
  const int max_terms = 1000;
  const int max_iterations = 50;
  double h_min = 10E-10;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double prob = TailLogProbability(probability[i], tail, log_mode);

    if (prob == 0.0)
      result[i] = 0.0;
    else if (prob == 1.0)
      result[i] = QPOSINF;
    else {

      if (prob < 0.0 || prob > 1.0)
        return false;

      int err_code = 0;
      double x = 0.5;
      double h = 1.0;

      int iterations = 0;
      while (iterations < max_iterations) {

        if ((MathAbs(h) > h_min && MathAbs(h) > MathAbs(h_min * x)) == false)
          break;

        double half_x = x * 0.5;
        double pwr_lambda = 1.0;
        double pwr_two = pwr_two0;
        double pwr_x = MathPow(x, half_nu_m1);
        double fact_mult = 1.0;
        double coef_lambda_x = coef_lambda * MathExp(-half_x);
        double inv_factor = 1.0;

        int j = 0;
        double pdf = 0;
        while (j < max_terms) {
          if (j > 0) {
            pwr_lambda *= lambda;
            pwr_x *= x;
            pwr_two *= 0.5;
            fact_mult *= 1.0 / j;
            inv_factor *= 1.0 / (j + half_nu - 1);
          }
          double dp = pwr_gamma0 * inv_factor * pwr_lambda * pwr_two * pwr_x *
                      fact_mult * coef_lambda_x;
          pdf = pdf + dp;

          if (dp / (pdf + 10E-10) < 10E-16)
            break;
          j++;
        }

        if (j > max_terms)
          return false;

        pwr_lambda = 1.0;
        fact_mult = 1.0;
        pwr_lambda = 1.0;
        fact_mult = 1.0;
        double cdf = 0.0;
        j = 0;

        while (j < max_terms) {
          if (j > 0) {
            pwr_lambda *= lambda;
            fact_mult /= j;
          }
          double coef1 = coef_lambda * pwr_lambda * fact_mult;
          double coef2 = MathMin(MathGammaIncomplete(half_x, half_nu + j), 1.0);
          double dp = coef1 * coef2;
          cdf = cdf + dp;
          if ((dp / (cdf + 10E-10)) < 10E-16)
            break;
          j++;
        }

        if (j > max_terms)
          return false;

        h = (cdf - prob) / pdf;

        double x_new = x - h;
        if (x_new < 0.0)
          x_new = x * 0.1;
        else if (x_new > 1.0)
          x_new = 1.0 - (1 - x) * 0.1;
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

bool MathQuantileNoncentralChiSquare(const double &probability[],
                                     const double nu, const double sigma,
                                     double &result[]) {
  return MathQuantileNoncentralChiSquare(probability, nu, sigma, true, false,
                                         result);
}

double MathRandomNoncentralChiSquare(const double nu, const double sigma,
                                     int &error_code) {

  if (sigma == 0.0) {
    return MathRandomChiSquare(nu, error_code);
  }

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (sigma < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  int err_code = 0;
  if (nu > 1.0) {
    double rnd_chisquare = MathRandomGamma((nu - 1) * 0.5, 2.0, err_code);
    double rnd_normal = MathSqrt(sigma) + MathRandomNormal(0, 1, err_code);
    return rnd_chisquare + rnd_normal * rnd_normal;
  } else {
    int rnd_poisson = (int)MathRandomPoisson(sigma * 0.5);
    return MathRandomChiSquare(nu + 2 * rnd_poisson, err_code);
  }
}

bool MathRandomNoncentralChiSquare(const double nu, const double sigma,
                                   const int data_count, double &result[]) {

  if (sigma == 0.0)
    return MathRandomChiSquare(nu, data_count, result);

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(sigma))
    return false;

  if (nu != MathRound(nu) || nu <= 0)
    return false;

  if (sigma < 0.0)
    return false;

  int err_code = 0;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    if (nu > 1.0) {
      double rnd_chisquare = MathRandomGamma((nu - 1) * 0.5, 2.0, err_code);
      double rnd_normal = MathSqrt(sigma) + MathRandomNormal(0, 1, err_code);
      result[i] = rnd_chisquare + rnd_normal * rnd_normal;
    } else {
      int rnd_poisson = (int)MathRandomPoisson(sigma * 0.5);
      result[i] = MathRandomChiSquare(nu + 2 * rnd_poisson, err_code);
    }
  }
  return true;
}

bool MathMomentsNoncentralChiSquare(const double nu, const double sigma,
                                    double &mean, double &variance,
                                    double &skewness, double &kurtosis,
                                    int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(sigma)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  mean = nu + sigma;
  variance = 2 * nu + 4 * sigma;
  skewness = 2 * M_SQRT2 * (nu + 3 * sigma) * MathPow(nu + 2 * sigma, -1.5);
  kurtosis = 12 * (nu + 4 * sigma) * MathPow(nu + 2 * sigma, -2);

  return true;
}

#endif
