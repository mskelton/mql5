#ifndef NONCENTRAL_T_H
#define NONCENTRAL_T_H

#include "Math.mqh"
#include "Normal.mqh"
#include "T.mqh"

double MathProbabilityDensityNoncentralT(const double x, const double nu,
                                         const double delta,
                                         const bool log_mode, int &error_code) {

  if (delta == 0.0)
    return MathProbabilityDensityT(x, nu, error_code);

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu) ||
      !MathIsValidNumber(delta)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double nu_1 = nu + 1.0;
  double nu_1_half = nu_1 * 0.5;
  double log_nu = MathLog(nu);
  double factor1 =
      MathExp(-0.5 * (MathLog(M_PI) + log_nu) - (delta * delta) * 0.5 -
              MathGammaLog(nu * 0.5) + nu_1_half * log_nu);

  double nu_xx = nu + x * x;
  double log_nu_xx = MathLog(nu_xx);
  double factor2 = MathExp(-nu_1_half * log_nu_xx);

  const int max_terms = 500;
  double pwr = 1.0;
  double pwr_factor = x * delta * M_SQRT2;
  double pwr_nuxx = 1.0;
  double pwr_nuxx_factor = 1.0 / MathSqrt(nu_xx);
  double pwr_gamma = 1.0;
  int j = 0;
  double pdf = 0.0;
  while (j < max_terms) {
    if (j > 0) {
      pwr_nuxx *= pwr_nuxx_factor;
      pwr_gamma /= j;
      pwr *= pwr_factor;
    }
    double t = pwr * pwr_gamma * pwr_nuxx * MathGamma((nu_1 + j) * 0.5);
    pdf += t;

    if ((t / (pdf + 10E-10)) < 10E-20)
      break;
    j++;
  }

  if (j < max_terms)
    return TailLogValue(factor1 * factor2 * pdf, true, log_mode);
  else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
}

double MathProbabilityDensityNoncentralT(const double x, const double nu,
                                         const double delta, int &error_code) {
  return MathProbabilityDensityNoncentralT(x, nu, delta, false, error_code);
}

bool MathProbabilityDensityNoncentralT(const double &x[], const double nu,
                                       const double delta, const bool log_mode,
                                       double &result[]) {

  if (delta == 0.0)
    return MathProbabilityDensityT(x, nu, log_mode, result);

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(delta))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  double nu_1 = nu + 1.0;
  double nu_1_half = nu_1 * 0.5;
  double log_nu = MathLog(nu);
  double factor1 =
      MathExp(-0.5 * (MathLog(M_PI) + log_nu) - (delta * delta) * 0.5 -
              MathGammaLog(nu * 0.5) + nu_1_half * log_nu);
  double factor_delta = delta * M_SQRT2;
  const int max_terms = 500;

  int error_code = 0;
  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    double nu_xx = nu + x_arg * x_arg;
    double log_nu_xx = MathLog(nu_xx);
    double factor2 = MathExp(-nu_1_half * log_nu_xx);

    double pwr = 1.0;
    double pwr_factor = x_arg * factor_delta;
    double pwr_nuxx = 1.0;
    double pwr_nuxx_factor = 1.0 / MathSqrt(nu_xx);
    double pwr_gamma = 1.0;
    int j = 0;
    double pdf = 0.0;
    while (j < max_terms) {
      if (j > 0) {
        pwr_nuxx *= pwr_nuxx_factor;
        pwr_gamma /= j;
        pwr *= pwr_factor;
      }
      double t = pwr * pwr_gamma * pwr_nuxx * MathGamma((nu_1 + j) * 0.5);
      pdf += t;

      if ((t / (pdf + 10E-10)) < 10E-20)
        break;
      j++;
    }

    if (j < max_terms)
      result[i] = TailLogValue(factor1 * factor2 * pdf, true, log_mode);
    else
      return false;
  }
  return true;
}

bool MathProbabilityDensityNoncentralT(const double &x[], const double nu,
                                       const double delta, double &result[]) {
  return MathProbabilityDensityNoncentralT(x, nu, delta, false, result);
}

double MathCumulativeDistributionNoncentralT(const double x, const double nu,
                                             const double delta,
                                             const bool tail,
                                             const bool log_mode,
                                             int &error_code) {

  if (delta == 0.0)
    return MathCumulativeDistributionT(x, nu, error_code);

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu) ||
      !MathIsValidNumber(delta)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (nu == 1.0) {
    error_code = ERR_OK;
    return TailLogValue(0.5 + MathArctan(x) * M_1_PI, tail, log_mode);
  }

  error_code = ERR_OK;

  const double errtol = 10E-25;

  const int max_iterations = 1000;

  double xx, del;
  double ptermf, qtermf, ptermb, qtermb, error;

  if (x < 0.0) {
    xx = -x;
    del = -delta;
  } else {
    xx = x;
    del = delta;
  }

  int err_code = 0;

  double cdf_normal =
      MathMin(MathCumulativeDistributionNormal(-del, 0, 1, err_code), 1.0);

  if (xx == 0.0)
    return TailLogValue(cdf_normal, tail, log_mode);

  double y = xx * xx / (nu + xx * xx);
  double dels = 0.5 * del * del;

  int k = (int)dels;
  double a = k + 0.5;
  double c = k + 1.0;
  double b = 0.5 * nu;

  double pkf = MathExp(-dels + k * MathLog(dels) - MathGammaLog(k + 1.0));
  double pkb = pkf;

  double qkf = MathExp(-dels + k * MathLog(dels) - MathGammaLog(k + 1.5));
  double qkb = qkf;

  double pbetaf = MathBetaIncomplete(y, a, b);
  double pbetab = pbetaf;

  double qbetaf = MathBetaIncomplete(y, c, b);
  double qbetab = qbetaf;

  double pgamf =
      MathExp(MathGammaLog(a + b - 1.0) - MathGammaLog(a) - MathGammaLog(b) +
              (a - 1.0) * MathLog(y) + b * MathLog(1.0 - y));
  double pgamb = pgamf * y * (a + b - 1.0) / a;

  double qgamf =
      MathExp(MathGammaLog(c + b - 1.0) - MathGammaLog(c) - MathGammaLog(b) +
              (c - 1.0) * MathLog(y) + b * MathLog(1.0 - y));
  double qgamb = qgamf * y * (c + b - 1.0) / c;

  double rempois = 1.0 - pkf;
  double delosq2 = del / M_SQRT2;
  double sum = pkf * pbetaf + delosq2 * qkf * qbetaf;
  double cons = 0.5 * (1.0 + 0.5 * MathAbs(delta));
  int j = 0;
  for (;;) {
    j++;
    pgamf *= y * (a + b + j - 2.0) / (a + j - 1.0);
    pbetaf -= pgamf;
    pkf *= dels / (k + j);
    ptermf = pkf * pbetaf;
    qgamf *= y * (c + b + j - 2.0) / (c + j - 1.0);
    qbetaf -= qgamf;
    qkf *= dels / (k + j + 0.5);
    qtermf = qkf * qbetaf;
    double term = ptermf + delosq2 * qtermf;
    sum += term;
    error = rempois * cons * pbetaf;
    rempois -= pkf;

    if (j <= k) {
      pgamb *= (a - j + 1.0) / (y * (a + b - j));
      pbetab += pgamb;
      pkb = (k - j + 1.0) * pkb / dels;
      ptermb = pkb * pbetab;
      qgamb *= (c - j + 1.0) / (y * (c + b - j));
      qbetab += qgamb;
      qkb = (k - j + 1.5) * qkb / dels;
      qtermb = qkb * qbetab;
      term = ptermb + delosq2 * qtermb;
      sum += term;
      rempois -= pkb;
      if (rempois <= errtol || j >= max_iterations)
        break;
    } else {
      if (error <= errtol || j >= max_iterations)
        break;
    }
  }

  if (j < max_iterations) {
    double cdf = 0.5 * sum + cdf_normal;

    if (x < 0)
      cdf = 1.0 - cdf;

    return TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
  } else {
    error_code = ERR_NON_CONVERGENCE;
    return QNaN;
  }
}

double MathCumulativeDistributionNoncentralT(const double x, const double nu,
                                             const double delta,
                                             int &error_code) {
  return MathCumulativeDistributionNoncentralT(x, nu, delta, true, false,
                                               error_code);
}

bool MathCumulativeDistributionNoncentralT(const double &x[], const double nu,
                                           const double delta, const bool tail,
                                           const bool log_mode,
                                           double &result[]) {

  if (delta == 0.0)
    return MathCumulativeDistributionT(x, nu, tail, log_mode, result);

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(delta))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
    return false;

  int data_count = ArraySize(x);
  if (data_count == 0)
    return false;

  ArrayResize(result, data_count);

  if (nu == 1.0) {
    for (int i = 0; i < data_count; i++) {
      double x_arg = x[i];
      if (!MathIsValidNumber(x_arg))
        return false;
      result[i] =
          TailLogValue(0.5 + MathArctan(x_arg) * M_1_PI, tail, log_mode);
    }
    return true;
  }

  int err_code = 0;

  double cdf_normal =
      MathMin(MathCumulativeDistributionNormal(-delta, 0, 1, err_code), 1.0);

  const double errtol = 10E-25;

  const int max_iterations = 1000;

  for (int i = 0; i < data_count; i++) {
    double x_arg = x[i];

    if (!MathIsValidNumber(x_arg))
      return false;

    double xx, del;
    double ptermf, qtermf, ptermb, qtermb, error;

    if (x_arg < 0.0) {
      xx = -x_arg;
      del = -delta;
    } else {
      xx = x_arg;
      del = delta;
    }

    if (xx == 0.0)
      result[i] = TailLogValue(cdf_normal, tail, log_mode);
    else {
      double y = xx * xx / (nu + xx * xx);
      double dels = 0.5 * del * del;

      int k = (int)dels;
      double a = k + 0.5;
      double c = k + 1.0;
      double b = 0.5 * nu;

      double pkf = MathExp(-dels + k * MathLog(dels) - MathGammaLog(k + 1.0));
      double pkb = pkf;

      double qkf = MathExp(-dels + k * MathLog(dels) - MathGammaLog(k + 1.5));
      double qkb = qkf;

      double pbetaf = MathBetaIncomplete(y, a, b);
      double pbetab = pbetaf;

      double qbetaf = MathBetaIncomplete(y, c, b);
      double qbetab = qbetaf;

      double pgamf = MathExp(MathGammaLog(a + b - 1.0) - MathGammaLog(a) -
                             MathGammaLog(b) + (a - 1.0) * MathLog(y) +
                             b * MathLog(1.0 - y));
      double pgamb = pgamf * y * (a + b - 1.0) / a;

      double qgamf = MathExp(MathGammaLog(c + b - 1.0) - MathGammaLog(c) -
                             MathGammaLog(b) + (c - 1.0) * MathLog(y) +
                             b * MathLog(1.0 - y));
      double qgamb = qgamf * y * (c + b - 1.0) / c;

      double rempois = 1.0 - pkf;
      double delosq2 = del / M_SQRT2;
      double sum = pkf * pbetaf + delosq2 * qkf * qbetaf;
      double cons = 0.5 * (1.0 + 0.5 * MathAbs(delta));
      int j = 0;
      for (;;) {
        j++;
        pgamf *= y * (a + b + j - 2.0) / (a + j - 1.0);
        pbetaf -= pgamf;
        pkf *= dels / (k + j);
        ptermf = pkf * pbetaf;
        qgamf *= y * (c + b + j - 2.0) / (c + j - 1.0);
        qbetaf -= qgamf;
        qkf *= dels / (k + j + 0.5);
        qtermf = qkf * qbetaf;
        double term = ptermf + delosq2 * qtermf;
        sum += term;
        error = rempois * cons * pbetaf;
        rempois -= pkf;

        if (j <= k) {
          pgamb *= (a - j + 1.0) / (y * (a + b - j));
          pbetab += pgamb;
          pkb = (k - j + 1.0) * pkb / dels;
          ptermb = pkb * pbetab;
          qgamb *= (c - j + 1.0) / (y * (c + b - j));
          qbetab += qgamb;
          qkb = (k - j + 1.5) * qkb / dels;
          qtermb = qkb * qbetab;
          term = ptermb + delosq2 * qtermb;
          sum += term;
          rempois -= pkb;
          if (rempois <= errtol || j >= max_iterations)
            break;
        } else {
          if (error <= errtol || j >= max_iterations)
            break;
        }
      }

      if (j < max_iterations) {
        double cdf = 0.5 * sum + cdf_normal;

        if (x_arg < 0)
          cdf = 1.0 - cdf;

        result[i] = TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
      } else
        return false;
    }
  }
  return true;
}

bool MathCumulativeDistributionNoncentralT(const double &x[], const double nu,
                                           const double delta,
                                           double &result[]) {
  return MathCumulativeDistributionNoncentralT(x, nu, delta, true, false,
                                               result);
}

double MathQuantileNoncentralT(const double probability, const double nu,
                               const double delta, const bool tail,
                               const bool log_mode, int &error_code) {

  if (delta == 0.0)
    return MathQuantileT(probability, nu, error_code);

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(delta)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (delta < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  double prob = TailLogProbability(probability, tail, log_mode);

  if (prob < 0.0 || prob > 1.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (prob == 0.0 || prob == 1.0) {
    error_code = ERR_RESULT_INFINITE;
    if (prob == 0.0)
      return QNEGINF;
    else
      return QPOSINF;
  }

  double sqr_delta_half = delta * delta * 0.5;
  double nu_half = nu * 0.5;
  double log_sqr_delta_half = MathLog(sqr_delta_half);
  double exp_sqr_delta_half = MathExp(-sqr_delta_half);
  double sqrt_sqr_delta_half = MathSqrt(sqr_delta_half);
  double nu_1 = nu + 1.0;
  double nu_1_half = nu_1 * 0.5;
  double log_nu = MathLog(nu);
  double factor1 = MathExp(-0.5 * (MathLog(M_PI) + log_nu) - sqr_delta_half -
                           MathGammaLog(nu * 0.5) + nu_1_half * log_nu);

  int err_code = 0;
  double p0 = MathCumulativeDistributionNormal(-delta, 0.0, 1.0, err_code);

  error_code = ERR_OK;
  double precision = 10E-20;
  const int max_iterations = 150;
  int iterations = 0;
  double x = 0.5;
  double h = 1.0;
  double h_min = precision;
  const int max_terms = 500;

  while (iterations < max_iterations) {

    if ((MathAbs(h) > h_min && MathAbs(h) > MathAbs(h_min * x)) == false)
      break;

    double x_arg_sqr = x * x;
    double nu_xx = nu + x_arg_sqr;
    double log_nu_xx = MathLog(nu_xx);
    double factor2 = MathExp(-nu_1_half * log_nu_xx);
    double pwr = 1.0;
    double pwr_factor = x * delta * M_SQRT2;
    double pwr_nuxx = 1.0;
    double pwr_nuxx_factor = 1.0 / MathSqrt(nu_xx);
    double pwr_gamma = 1.0;
    int j = 0;
    double pdf = 0.0;
    while (j < max_terms) {
      if (j > 0) {
        pwr_nuxx *= pwr_nuxx_factor;
        pwr_gamma /= j;
        pwr *= pwr_factor;
      }
      double t = pwr * pwr_gamma * pwr_nuxx * MathGamma((nu_1 + j) * 0.5);
      pdf += t;

      if ((t / (pdf + 10E-10)) < 10E-20)
        break;
      j++;
    }

    if (j > max_terms)
      return false;
    pdf = factor1 * factor2 * pdf;

    double t = (x * x) / (nu + x * x);
    double sum1 = 0.0;
    double sum2 = 0.0;

    double pwr_coef1 = 1.0;
    double pwr_coef2 = 1.0;
    double fact = 1.0;
    j = 0;
    if (x != 0) {
      while (j < max_terms) {
        if (j > 0) {
          pwr_coef1 *= sqrt_sqr_delta_half;
          pwr_coef2 *= sqr_delta_half;
          fact /= j;
        }
        double coef = 1.0 / MathGamma(j * 0.5 + 1.0);

        double t1 =
            pwr_coef1 * coef * MathBetaIncomplete(t, (j + 1.0) * 0.5, nu_half);
        sum1 += t1;

        double t2 =
            pwr_coef2 * fact * MathBetaIncomplete(t, (j + 0.5), nu_half);
        sum2 += t2;

        if ((MathAbs(t1 / (sum1 + 10E-10)) < precision) &&
            (MathAbs(t2 / (sum2 + 10E-10)) < precision))
          break;
        j++;
      }
    }

    if (j > max_terms)
      return false;

    double cdf = p0 + exp_sqr_delta_half * sum1 * 0.5;

    if (x < 0)
      cdf = cdf - exp_sqr_delta_half * sum2;

    cdf = MathMin(cdf, 1.0);

    h = (cdf - prob) / pdf;

    double x_new = x - h;
    if (x_new < 0.0)
      x_new = x * 0.1;
    else if (x_new > 1.0)
      x_new = 1.0 - (1.0 - x) * 0.1;

    if (MathAbs(x_new - x) < 10E-15)
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
}

double MathQuantileNoncentralT(const double probability, const double nu,
                               const double delta, int &error_code) {
  return MathQuantileNoncentralT(probability, nu, delta, true, false,
                                 error_code);
}

bool MathQuantileNoncentralT(const double &probability[], const double nu,
                             const double delta, const bool tail,
                             const bool log_mode, double &result[]) {

  if (delta == 0.0)
    return MathQuantileT(probability, nu, tail, log_mode, result);

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(delta))
    return false;

  if (nu != MathRound(nu) || nu < 0.0)
    return false;

  if (delta < 0.0)
    return false;

  int data_count = ArraySize(probability);
  if (data_count == 0)
    return false;

  double sqr_delta_half = delta * delta * 0.5;
  double nu_half = nu * 0.5;
  double log_sqr_delta_half = MathLog(sqr_delta_half);
  double exp_sqr_delta_half = MathExp(-sqr_delta_half);
  double sqrt_sqr_delta_half = MathSqrt(sqr_delta_half);
  double nu_1 = nu + 1.0;
  double nu_1_half = nu_1 * 0.5;
  double log_nu = MathLog(nu);
  double factor1 = MathExp(-0.5 * (MathLog(M_PI) + log_nu) - sqr_delta_half -
                           MathGammaLog(nu * 0.5) + nu_1_half * log_nu);

  int err_code = 0;
  double p0 = MathCumulativeDistributionNormal(-delta, 0.0, 1.0, err_code);

  double precision = 10E-20;
  double h_min = precision;
  const int max_iterations = 50;
  const int max_terms = 500;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double prob = TailLogProbability(probability[i], tail, log_mode);

    if (prob < 0.0 || prob > 1.0)
      return false;

    if (prob == 0.0 || prob == 1.0) {
      if (prob == 0.0)
        result[i] = QNEGINF;
      else
        result[i] = QPOSINF;
    } else {
      double x = 0.5;
      double h = 1.0;
      int iterations = 0;

      while (iterations < max_iterations) {

        if ((MathAbs(h) > h_min && MathAbs(h) > MathAbs(h_min * x)) == false)
          break;

        double x_arg_sqr = x * x;
        double nu_xx = nu + x_arg_sqr;
        double log_nu_xx = MathLog(nu_xx);
        double factor2 = MathExp(-nu_1_half * log_nu_xx);
        double pwr = 1.0;
        double pwr_factor = x * delta * M_SQRT2;
        double pwr_nuxx = 1.0;
        double pwr_nuxx_factor = 1.0 / MathSqrt(nu_xx);
        double pwr_gamma = 1.0;
        int j = 0;
        double pdf = 0.0;
        while (j < max_terms) {
          if (j > 0) {
            pwr_nuxx *= pwr_nuxx_factor;
            pwr_gamma /= j;
            pwr *= pwr_factor;
          }
          double t = pwr * pwr_gamma * pwr_nuxx * MathGamma((nu_1 + j) * 0.5);
          pdf += t;

          if ((t / (pdf + 10E-10)) < 10E-20)
            break;
          j++;
        }

        if (j > max_terms)
          return false;

        pdf = factor1 * factor2 * pdf;

        double t = (x * x) / (nu + x * x);
        double sum1 = 0.0;
        double sum2 = 0.0;

        double pwr_coef1 = 1.0;
        double pwr_coef2 = 1.0;
        double fact = 1.0;
        j = 0;
        if (x != 0) {
          while (j < max_terms) {
            if (j > 0) {
              pwr_coef1 *= sqrt_sqr_delta_half;
              pwr_coef2 *= sqr_delta_half;
              fact /= j;
            }
            double coef = 1.0 / MathGamma(j * 0.5 + 1.0);

            double t1 = pwr_coef1 * coef *
                        MathBetaIncomplete(t, (j + 1.0) * 0.5, nu_half);
            sum1 += t1;

            double t2 =
                pwr_coef2 * fact * MathBetaIncomplete(t, (j + 0.5), nu_half);
            sum2 += t2;

            if ((MathAbs(t1 / (sum1 + 10E-10)) < precision) &&
                (MathAbs(t2 / (sum2 + 10E-10)) < precision))
              break;
            j++;
          }
        }

        if (j > max_terms)
          return false;

        double cdf = p0 + exp_sqr_delta_half * sum1 * 0.5;

        if (x < 0)
          cdf = cdf - exp_sqr_delta_half * sum2;

        cdf = MathMin(cdf, 1.0);

        h = (cdf - prob) / pdf;

        double x_new = x - h;
        if (x_new < 0.0)
          x_new = x * 0.1;
        else if (x_new > 1.0)
          x_new = 1.0 - (1.0 - x) * 0.1;

        if (MathAbs(x_new - x) < 10E-15)
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

bool MathQuantileNoncentralT(const double &probability[], const double nu,
                             const double delta, double &result[]) {
  return MathQuantileNoncentralT(probability, nu, delta, true, false, result);
}

double MathRandomNoncentralT(const double nu, const double delta,
                             int &error_code) {

  if (delta == 0.0)
    return MathRandomT(nu, error_code);

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(delta)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  if (delta < 0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;
  int err_code = 0;

  double rnd_normal = delta + MathRandomNormal(0, 1, err_code);
  double rnd_nchi = MathRandomGamma(nu * 0.5, 2.0, err_code);

  double rnd_value = 0;
  if (rnd_nchi != 0)
    rnd_value = rnd_normal / MathSqrt(rnd_nchi / nu);
  return rnd_value;
}

bool MathRandomNoncentralT(const double nu, const double delta,
                           const int data_count, double &result[]) {

  if (delta == 0.0)
    return MathRandomT(nu, data_count, result);

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(delta))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
    return false;

  if (delta < 0)
    return false;

  int err_code = 0;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double rnd_normal = delta + MathRandomNormal(0, 1, err_code);
    double rnd_nchi = MathRandomGamma(nu * 0.5, 2.0, err_code);

    double rnd_value = 0;
    if (rnd_nchi != 0) {
      rnd_value = rnd_normal / MathSqrt(rnd_nchi / nu);
      result[i] = rnd_value;
    } else
      return false;
  }
  return true;
}

double MathMomentsNoncentralT(const double nu, const double delta, double &mean,
                              double &variance, double &skewness,
                              double &kurtosis, int &error_code) {

  if (delta == 0)
    return (MathMomentsT(nu, mean, variance, skewness, kurtosis, error_code));

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(nu) || !MathIsValidNumber(delta)) {
    error_code = ERR_ARGUMENTS_NAN;
    return false;
  }

  if (nu != MathRound(nu) || nu < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  if (delta < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return false;
  }

  error_code = ERR_OK;

  if (nu > 1)
    mean = delta * MathSqrt(nu) * MathGamma((nu - 1) * 0.5) /
           (MathSqrt(2) * MathGamma(nu * 0.5));

  double delta_sqr = delta * delta;

  double nu32 = 1 / ((nu - 3) * (nu - 2));
  if (nu > 2)
    variance = ((delta_sqr + 1) * nu) / (nu - 2) - MathPow(mean, 2);

  if (nu > 3) {
    skewness = -2 * variance;
    skewness += nu * (delta_sqr + 2 * nu - 3) * nu32;
    skewness *= mean * MathPow(variance, -1.5);
  }

  if (nu > 4) {
    kurtosis = -3 * variance;
    kurtosis += nu * (delta_sqr * (nu + 1) + 3 * (3 * nu - 5)) * nu32;
    kurtosis *= -MathPow(mean, 2);
    kurtosis += MathPow(nu, 2) * (MathPow(delta, 4) + 6 * delta_sqr + 3) /
                ((nu - 4) * (nu - 2));
    kurtosis *= MathPow(variance, -2);
    kurtosis -= 3;
  }

  return true;
}

#endif
