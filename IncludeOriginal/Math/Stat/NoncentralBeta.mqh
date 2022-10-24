#ifndef NONCENTRAL_BETA_H
#define NONCENTRAL_BETA_H

#include "Beta.mqh"
#include "Math.mqh"
#include "NoncentralChiSquare.mqh"

double MathProbabilityDensityNoncentralBeta(const double x, const double a,
                                            const double b, const double lambda,
                                            const bool log_mode,
                                            int &error_code) {

  if (lambda == 0.0)
    return MathProbabilityDensityBeta(x, a, b, error_code);

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0.0 || b <= 0.0 || lambda < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x <= 0.0 || x >= 1.0)
    return TailLog0(true, log_mode);

  double lambda_half = lambda * 0.5;
  double fact_mult = 1.0;
  double pwr_lambda_half = 1.0;
  double pwr_x = MathExp((a - 1.0) * MathLog(x));
  double r_beta = MathBeta(a, b);
  double pdf = 0;

  for (int j = 0;; j++) {
    if (j > 0) {
      pwr_x *= x;
      pwr_lambda_half *= lambda_half;
      fact_mult /= j;
      double jm1 = j - 1;
      r_beta *= ((a + jm1) / (a + b + jm1));
    }
    double term = pwr_x * fact_mult * pwr_lambda_half / r_beta;

    if (term < 10E-18)
      break;
    pdf += term;
  }

  pdf *= MathExp((b - 1.0) * MathLog(1.0 - x)) * MathExp(-lambda_half);

  return TailLogValue(pdf, true, log_mode);
}

double MathProbabilityDensityNoncentralBeta(const double x, const double a,
                                            const double b, const double lambda,
                                            int &error_code) {
  return MathProbabilityDensityNoncentralBeta(x, a, b, lambda, false,
                                              error_code);
}

bool MathProbabilityDensityNoncentralBeta(const double &x[], const double a,
                                          const double b, const double lambda,
                                          const bool log_mode,
                                          double &result[]) {

  if (lambda == 0.0)
    return MathProbabilityDensityBeta(x, a, b, log_mode, result);

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0.0 || b <= 0.0 || lambda < 0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  double lambda_half = lambda * 0.5;
  double exp_lambda_half = MathExp(-lambda_half);
  double r_beta0 = MathBeta(a, b);
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg <= 0.0 || x_arg >= 1.0)
      result[i] = TailLog0(true, log_mode);
    else {
      double fact_mult = 1.0;
      double pwr_lambda_half = 1.0;
      double pwr_x = MathExp((a - 1.0) * MathLog(x_arg));
      double r_beta = r_beta0;
      double pdf = 0;
      for (int j = 0;; j++) {
        if (j > 0) {
          pwr_x *= x_arg;
          pwr_lambda_half *= lambda_half;
          fact_mult /= j;
          double jm1 = j - 1;
          r_beta *= ((a + jm1) / (a + b + jm1));
        }
        double term = pwr_x * fact_mult * pwr_lambda_half / r_beta;

        if (term < 10E-18)
          break;
        pdf += term;
      }

      pdf *= MathExp((b - 1.0) * MathLog(1.0 - x_arg)) * exp_lambda_half;
      result[i] = TailLogValue(pdf, true, log_mode);
    }
  }
  return true;
}

bool MathProbabilityDensityNoncentralBeta(const double &x[], const double a,
                                          const double b, const double lambda,
                                          double &result[]) {
  return MathProbabilityDensityNoncentralBeta(x, a, b, lambda, false, result);
}

double MathCumulativeDistributionNoncentralBeta(
    const double x, const double a, const double b, const double lambda,
    const bool tail, const bool log_mode, int &error_code) {

  if (lambda == 0.0)
    return MathCumulativeDistributionBeta(x, a, b, error_code);

  if (!MathIsValidNumber(x) || !MathIsValidNumber(a) || !MathIsValidNumber(b)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0.0 || b <= 0.0 || lambda < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  if (x <= 0.0)
    return TailLog0(tail, log_mode);
  if (x >= 1.0)
    return TailLog1(tail, log_mode);

  const int max_terms = 100;
  double c = lambda * 0.5;
  double x0 = int(MathMax(c - 5 * MathSqrt(c), 0));
  double a0 = a + x0;
  double beta = MathGammaLog(a0) + MathGammaLog(b) - MathGammaLog(a0 + b);
  double temp = MathBetaIncomplete(x, a0, b);
  double gx =
      MathExp(a0 * MathLog(x) + b * MathLog(1 - x) - beta - MathLog(a0));

  double q = 0;
  if (a0 > a)
    q = MathExp(-c + x0 * MathLog(c) - MathGammaLog(x0 + 1));
  else
    q = MathExp(-c);

  double sumq = 1 - q;
  double betanc = q * temp;
  double ab = a + b;
  int j = 0;
  for (;;) {
    j++;
    temp -= gx;
    gx *= x * (ab + j - 1) / (a + j);
    q *= c / j;
    sumq -= q;
    betanc += temp * q;
    double err = (temp - gx) * sumq;
    if (j > max_terms || err < 1E-18)
      break;
  }
  double cdf = MathMin(betanc, 1.0);
  return TailLogValue(cdf, tail, log_mode);
}

double MathCumulativeDistributionNoncentralBeta(const double x, const double a,
                                                const double b,
                                                const double lambda,
                                                int &error_code) {
  return MathCumulativeDistributionNoncentralBeta(x, a, b, lambda, true, false,
                                                  error_code);
}

bool MathCumulativeDistributionNoncentralBeta(
    const double &x[], const double a, const double b, const double lambda,
    const bool tail, const bool log_mode, double &result[]) {

  if (lambda == 0.0)
    return MathCumulativeDistributionBeta(x, a, b, tail, log_mode, result);

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b))
    return false;

  if (a <= 0.0 || b <= 0.0 || lambda < 0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  const int max_terms = 100;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (x_arg <= 0.0)
      result[i] = TailLog0(tail, log_mode);
    if (x_arg >= 1.0)
      result[i] = TailLog1(tail, log_mode);
    else {
      double c = lambda * 0.5;
      double x0 = int(MathMax(c - 5 * MathSqrt(c), 0));
      double a0 = a + x0;
      double beta = MathGammaLog(a0) + MathGammaLog(b) - MathGammaLog(a0 + b);
      double temp = MathBetaIncomplete(x_arg, a0, b);
      double gx = MathExp(a0 * MathLog(x_arg) + b * MathLog(1 - x_arg) - beta -
                          MathLog(a0));

      double q = 0;
      if (a0 > a)
        q = MathExp(-c + x0 * MathLog(c) - MathGammaLog(x0 + 1));
      else
        q = MathExp(-c);

      double sumq = 1 - q;
      double betanc = q * temp;
      int j = 0;
      double ab = a + b;
      for (;;) {
        j++;
        temp -= gx;
        gx *= x_arg * (ab + j - 1) / (a + j);
        q *= c / j;
        sumq -= q;
        betanc += temp * q;
        double err = (temp - gx) * sumq;
        if (j > max_terms || err < 1E-18)
          break;
      }
      double cdf = MathMin(betanc, 1.0);
      result[i] = TailLogValue(cdf, tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionNoncentralBeta(const double &x[], const double a,
                                              const double b,
                                              const double lambda,
                                              double &result[]) {
  return MathCumulativeDistributionNoncentralBeta(x, a, b, lambda, true, false,
                                                  result);
}

double MathQuantileNoncentralBeta(const double probability, const double a,
                                  const double b, const double lambda,
                                  const bool tail, const bool log_mode,
                                  int &error_code) {
  if (log_mode == true && probability == QNEGINF)
    return 0.0;
  if (log_mode == false && probability == 0)
    return 0.0;

  if (lambda == 0.0)
    return MathQuantileBeta(probability, a, b, error_code);

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(a) ||
      !MathIsValidNumber(b) || !MathIsValidNumber(lambda)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0.0 || b <= 0.0 || lambda < 0) {
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
    return 1.0;

  double lambda_half = lambda * 0.5;
  double lambda_half_log = MathLog(lambda_half);
  double lambda_half_sqrt = MathSqrt(lambda_half);
  double lambda_half_exp = MathExp(-lambda_half);

  double x0 = int(MathMax(lambda_half - 5 * lambda_half_sqrt, 0));
  double b_gamma_log = MathGammaLog(b);
  double eps = 10E-18;
  double h_min = MathSqrt(eps);

  double r_beta0 = MathBeta(a, b);

  int err_code = 0;
  double x = 0.5;
  double h = 1.0;
  const int max_terms = 100;

  const int max_iterations = 50;
  int iterations = 0;
  while (iterations < max_iterations) {

    if ((MathAbs(h) > h_min * MathAbs(x) && MathAbs(h) > h_min) == false)
      break;

    double pdf = 0;
    if (x <= 0.0 || x >= 1.0)
      pdf = 0;
    else {
      double fact_mult = 1.0;
      double pwr_lambda_half = 1.0;
      double pwr_x = MathExp((a - 1.0) * MathLog(x));
      double r_beta = r_beta0;

      for (int j = 0;; j++) {
        if (j > 0) {
          pwr_x *= x;
          pwr_lambda_half *= lambda_half;
          fact_mult /= j;
          double jm1 = j - 1;
          r_beta *= ((a + jm1) / (a + b + jm1));
        }
        double term = pwr_x * fact_mult * pwr_lambda_half / r_beta;

        if (term < 10E-18)
          break;
        pdf += term;
      }

      pdf *= MathExp((b - 1.0) * MathLog(1.0 - x)) * lambda_half_exp;
    }

    double cdf = 0;
    if (x <= 0.0)
      cdf = 0;
    if (x >= 1.0)
      cdf = 1;
    else {
      double a0 = a + x0;
      double beta = MathGammaLog(a0) + b_gamma_log - MathGammaLog(a0 + b);
      double temp = MathBetaIncomplete(x, a0, b);
      double gx =
          MathExp(a0 * MathLog(x) + b * MathLog(1 - x) - beta - MathLog(a0));

      double q = 0;
      if (a0 > a)
        q = MathExp(-lambda_half + x0 * lambda_half_log - MathGammaLog(x0 + 1));
      else
        q = lambda_half_exp;

      double sumq = 1 - q;
      double betanc = q * temp;
      int j = 0;
      double ab = a + b;
      for (;;) {
        j++;
        temp -= gx;
        gx *= x * (ab + j - 1) / (a + j);
        q *= lambda_half / j;
        sumq -= q;
        betanc += temp * q;
        double err = (temp - gx) * sumq;
        if (j > max_terms || err < 1E-18)
          break;
      }
      cdf = MathMin(betanc, 1.0);
    }

    h = (cdf - prob) / pdf;

    double x_new = x - h;
    if (x_new < 0.0)
      x_new = x * 0.1;
    else if (x_new > 1.0)
      x_new = 1.0 - (1 - x) * 0.1;

    if (MathAbs(x_new - x) < 10E-16)
      break;
    x = x_new;

    iterations++;
  }

  if (iterations < max_iterations)
    return x;
  else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
  return x;
}

double MathQuantileNoncentralBeta(const double probability, const double a,
                                  const double b, const double lambda,
                                  int &error_code) {
  return MathQuantileNoncentralBeta(probability, a, b, lambda, true, false,
                                    error_code);
}

bool MathQuantileNoncentralBeta(const double &probability[], const double a,
                                const double b, const double lambda,
                                const bool tail, const bool log_mode,
                                double &result[]) {

  if (lambda == 0.0)
    return MathQuantileBeta(probability, a, b, tail, log_mode, result);

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b) ||
      !MathIsValidNumber(lambda))
    return false;

  if (a <= 0.0 || b <= 0.0 || lambda < 0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  int err_code = 0;
  ArrayResize(result, data_count);

  double lambda_half = lambda * 0.5;
  double lambda_half_log = MathLog(lambda_half);
  double lambda_half_sqrt = MathSqrt(lambda_half);
  double lambda_half_exp = MathExp(-lambda_half);
  double r_beta0 = MathBeta(a, b);

  double x0 = int(MathMax(lambda_half - 5 * lambda_half_sqrt, 0));
  double b_gamma_log = MathGammaLog(b);
  const double eps = 10E-18;
  double h_min = MathSqrt(eps);
  const int max_terms = 100;

  for (int i = 0; i < data_count; i++) {

    double prob = TailLogProbability(probability[i], tail, log_mode);

    if (!MathIsValidNumber(prob))
      return false;

    if (prob == 0.0)
      result[i] = 0.0;
    else if (prob == 1.0)
      result[i] = 1.0;
    else {
      double x = 0.5;
      double h = 1.0;

      const int max_iterations = 50;
      int iterations = 0;
      while (iterations < max_iterations) {

        if ((MathAbs(h) > h_min * MathAbs(x) && MathAbs(h) > h_min) == false)
          break;

        double pdf = 0;
        if (x <= 0.0 || x >= 1.0)
          pdf = 0;
        else {
          double fact_mult = 1.0;
          double pwr_lambda_half = 1.0;
          double pwr_x = MathExp((a - 1.0) * MathLog(x));
          double r_beta = r_beta0;

          for (int j = 0;; j++) {
            if (j > 0) {
              pwr_x *= x;
              pwr_lambda_half *= lambda_half;
              fact_mult /= j;
              double jm1 = j - 1;
              r_beta *= ((a + jm1) / (a + b + jm1));
            }
            double term = pwr_x * fact_mult * pwr_lambda_half / r_beta;

            if (term < 10E-18)
              break;
            pdf += term;
          }

          pdf *= MathExp((b - 1.0) * MathLog(1.0 - x)) * lambda_half_exp;
        }

        double cdf = 0;
        if (x <= 0.0)
          cdf = 0;
        if (x >= 1.0)
          cdf = 1;
        else {
          double a0 = a + x0;
          double beta = MathGammaLog(a0) + b_gamma_log - MathGammaLog(a0 + b);
          double temp = MathBetaIncomplete(x, a0, b);
          double gx = MathExp(a0 * MathLog(x) + b * MathLog(1 - x) - beta -
                              MathLog(a0));

          double q = 0;
          if (a0 > a)
            q = MathExp(-lambda_half + x0 * lambda_half_log -
                        MathGammaLog(x0 + 1));
          else
            q = lambda_half_exp;

          double sumq = 1 - q;
          double betanc = q * temp;
          int j = 0;
          double ab = a + b;
          for (;;) {
            j++;
            temp -= gx;
            gx *= x * (ab + j - 1) / (a + j);
            q *= lambda_half / j;
            sumq -= q;
            betanc += temp * q;
            double err = (temp - gx) * sumq;
            if (j > max_terms || err < 1E-18)
              break;
          }
          cdf = MathMin(betanc, 1.0);
        }

        h = (cdf - prob) / pdf;

        double x_new = x - h;
        if (x_new < 0.0)
          x_new = x * 0.1;
        else if (x_new > 1.0)
          x_new = 1.0 - (1 - x) * 0.1;

        if (MathAbs(x_new - x) < 10E-16)
          break;
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

bool MathQuantileNoncentralBeta(const double &probability[], const double a,
                                const double b, const double lambda,
                                double &result[]) {
  return MathQuantileNoncentralBeta(probability, a, b, lambda, true, false,
                                    result);
}

double MathRandomNoncentralBeta(const double a, const double b,
                                const double lambda, int &error_code) {

  if (lambda == 0.0)
    return MathRandomBeta(a, b, error_code);

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b) ||
      !MathIsValidNumber(lambda)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (a <= 0.0 || b <= 0.0 || lambda < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double chi1 = MathRandomNoncentralChiSquare(2 * a, 2 * lambda, error_code);
  double chi2 = MathRandomNoncentralChiSquare(2 * b, 2 * lambda, error_code);
  return chi1 / (chi1 + chi2);
}

bool MathRandomNoncentralBeta(const double a, const double b,
                              const double lambda, const int data_count,
                              double &result[]) {

  if (lambda == 0.0)
    return MathRandomBeta(a, b, data_count, result);

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b) ||
      !MathIsValidNumber(lambda))
    return false;

  if (a <= 0.0 || b <= 0.0 || lambda < 0)
    return false;

  int error_code = 0;

  ArrayResize(result, data_count);
  double lambda2 = lambda * 2;
  double a2 = a * 2;
  double b2 = b * 2;
  for (int i = 0; i < data_count; i++) {

    double chi1 = MathRandomNoncentralChiSquare(a2, lambda2, error_code);
    double chi2 = MathRandomNoncentralChiSquare(b2, lambda2, error_code);
    result[i] = chi1 / (chi1 + chi2);
  }
  return true;
}

double MathMomentsNoncentralBeta(const double a, const double b,
                                 const double lambda, double &mean,
                                 double &variance, double &skewness,
                                 double &kurtosis, int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(a) || !MathIsValidNumber(b) ||
      !MathIsValidNumber(lambda)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (a <= 0.0 || b <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  if (lambda < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  double lambda_half = lambda * 0.5;

  double f1 = MathHypergeometric2F2(a + 1, a + b, a, a + b + 1, lambda_half);
  double f2 = MathHypergeometric2F2(a + 2, a + b, a, a + b + 2, lambda_half);
  double f3 = MathHypergeometric2F2(a + 3, a + b, a, a + b + 3, lambda_half);
  double f4 = MathHypergeometric2F2(a + 4, a + b, a, a + b + 4, lambda_half);

  double exp_lambda_half = MathExp(-lambda_half);
  double exp_lambda = MathPow(exp_lambda_half, 2);

  double aab = a / (a + b);
  double aab2 = MathPow(aab, 2);
  double ab1 = (a + 1) / (a + b + 1);
  double ab2 = (a + 2) / (a + b + 2);
  double ab3 = (a + 3) / (a + b + 3);

  mean = aab * exp_lambda_half * f1;
  double mean2 = MathPow(mean, 2);
  variance = aab * ab1 * exp_lambda_half * f2 - mean2;
  skewness = (2 * MathPow(mean, 3) +
              exp_lambda_half * aab * ab1 * (-3 * mean * f2 + ab2 * f3)) *
             MathPow(variance, -1.5);
  kurtosis = -3 + (-3 * MathPow(mean, 4) +
                   exp_lambda * f1 * aab2 *
                       (6 * mean * ab1 * f2 - 4 * ab1 * ab2 * f3) +
                   aab * ab1 * ab2 * ab3 * exp_lambda_half * f4) *
                      MathPow(aab * ab1 * exp_lambda_half * f2 - mean2, -2);

  return true;
}

#endif
