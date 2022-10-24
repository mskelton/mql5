#ifndef T_H
#define T_H

#include "Gamma.mqh"
#include "Math.mqh"

double MathProbabilityDensityT(const double x, const double nu,
                               const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double pdf = MathExp(MathGammaLog((nu + 1.0) * 0.5) - MathGammaLog(nu * 0.5));
  pdf = pdf / (MathSqrt(nu * M_PI) * MathPow(1 + x * x / nu, (nu + 1.0) * 0.5));

  return TailLogValue(pdf, true, log_mode);
}

double MathProbabilityDensityT(const double x, const double nu,
                               int &error_code) {
  return MathProbabilityDensityT(x, nu, false, error_code);
}

bool MathProbabilityDensityT(const double &x[], const double nu,
                             const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(nu))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
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

    error_code = ERR_OK;

    double pdf =
        MathExp(MathGammaLog((nu + 1.0) * 0.5) - MathGammaLog(nu * 0.5));
    pdf = pdf / (MathSqrt(nu * M_PI) *
                 MathPow(1 + x_arg * x_arg / nu, (nu + 1.0) * 0.5));

    result[i] = TailLogValue(pdf, true, log_mode);
  }
  return true;
}

bool MathProbabilityDensityT(const double &x[], const double nu,
                             double &result[]) {
  return MathProbabilityDensityT(x, nu, false, result);
}

double MathCumulativeDistributionT(const double x, const double nu,
                                   const bool tail, const bool log_mode,
                                   int &error_code) {

  if (!MathIsValidNumber(x) || !MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  if (nu == 1.0)
    return TailLogValue(0.5 + MathArctan(x) / M_PI, tail, log_mode);

  if (x == 0)
    return TailLogValue(0.5, tail, log_mode);

  double cdf = 1.0 - MathBetaIncomplete(nu / (nu + x * x), nu * 0.5, 0.5);
  cdf = (1.0 - cdf) * 0.5;

  if (x > 0.0)
    cdf = 1.0 - cdf;

  return TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
}

double MathCumulativeDistributionT(const double x, const double nu,
                                   int &error_code) {
  return MathCumulativeDistributionT(x, nu, true, false, error_code);
}

bool MathCumulativeDistributionT(const double &x[], const double nu,
                                 const bool tail, const bool log_mode,
                                 double &result[]) {

  if (!MathIsValidNumber(nu))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
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

    if (nu == 1.0)
      result[i] = TailLogValue(0.5 + MathArctan(x_arg) / M_PI, tail, log_mode);
    else

        if (x_arg == 0)
      result[i] = TailLogValue(0.5, tail, log_mode);
    else {

      double cdf =
          1.0 - MathBetaIncomplete(nu / (nu + x_arg * x_arg), nu * 0.5, 0.5);
      cdf = (1.0 - cdf) * 0.5;

      if (x_arg > 0.0)
        cdf = 1.0 - cdf;

      result[i] = TailLogValue(MathMin(cdf, 1.0), tail, log_mode);
    }
  }
  return true;
}

bool MathCumulativeDistributionT(const double &x[], const double nu,
                                 double &result[]) {
  return MathCumulativeDistributionT(x, nu, true, false, result);
}

double MathQuantileT(const double probability, const double nu, const bool tail,
                     const bool log_mode, int &error_code) {

  if (!MathIsValidNumber(probability) || !MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu < 0.0) {
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
      return (QNEGINF);
    else
      return (QPOSINF);
  }

  error_code = ERR_OK;

  if (nu == 1.0)
    return MathTan(M_PI * (prob - 0.5));

  if (prob == 0.5)
    return 0.0;

  int max_iterations = 50;
  int iterations = 0;

  double h = 1.0;
  double h_min = 10E-20;
  double x = 0.5;
  int err_code = 0;

  while (iterations < max_iterations) {

    if ((MathAbs(h) > h_min && MathAbs(h) > MathAbs(h_min * x)) == false)
      break;

    double pdf = MathProbabilityDensityT(x, nu, err_code);
    double cdf = MathCumulativeDistributionT(x, nu, err_code);

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

double MathQuantileT(const double probability, const double nu,
                     int &error_code) {
  return MathQuantileT(probability, nu, true, false, error_code);
}

bool MathQuantileT(const double &probability[], const double nu,
                   const bool tail, const bool log_mode, double &result[]) {

  if (!MathIsValidNumber(nu))
    return false;

  if (nu != MathRound(nu) || nu < 0.0)
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

    if (prob == 0.5)
      result[i] = 0.0;
    else if (prob == 0.0)
      result[i] = QNEGINF;
    else if (prob == 1.0)
      result[i] = QPOSINF;
    else {

      if (nu == 1.0)
        result[i] = MathTan(M_PI * (prob - 0.5));
      else {
        int max_iterations = 50;
        int iterations = 0;

        double h = 1.0;
        double h_min = 10E-18;
        double x = 0.5;
        int err_code = 0;

        while (iterations < max_iterations) {

          if ((MathAbs(h) > h_min && MathAbs(h) > MathAbs(h_min * x)) == false)
            break;

          double pdf = MathProbabilityDensityT(x, nu, err_code);
          double cdf = MathCumulativeDistributionT(x, nu, err_code);

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
  }
  return true;
}

bool MathQuantileT(const double &probability[], const double nu,
                   double &result[]) {
  return MathQuantileT(probability, nu, true, false, result);
}

double MathRandomT(const double nu, int error_code) {

  if (!MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu <= 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  double x1, x2, r2;
  do {
    x1 = 2.0 * MathRandomNonZero() - 1.0;
    x2 = 2.0 * MathRandomNonZero() - 1.0;
    r2 = x1 * x1 + x2 * x2;
  } while (r2 >= 1.0 || r2 == 0.0);

  double rnd_normal = x2 * MathSqrt(-2.0 * MathLog(r2) / r2);
  double rnd_gamma = MathRandomGamma(nu * 0.5, 1, error_code);

  double result = 0;
  if (rnd_gamma != 0)
    result = MathSqrt(nu * 0.5) * rnd_normal / MathSqrt(rnd_gamma);
  return (result);
}

bool MathRandomT(const double nu, const int data_count, double &result[]) {

  if (!MathIsValidNumber(nu))
    return false;

  if (nu != MathRound(nu) || nu <= 0.0)
    return false;

  int error_code = 0;

  ArrayResize(result, data_count);
  for (int i = 0; i < data_count; i++) {

    double x1, x2, r2;
    do {
      x1 = 2.0 * MathRandomNonZero() - 1.0;
      x2 = 2.0 * MathRandomNonZero() - 1.0;
      r2 = x1 * x1 + x2 * x2;
    } while (r2 >= 1.0 || r2 == 0.0);

    double rnd_normal = x2 * MathSqrt(-2.0 * MathLog(r2) / r2);
    double rnd_gamma = MathRandomGamma(nu * 0.5, 1, error_code);

    double rnd = 0;
    if (rnd_gamma != 0)
      rnd = MathSqrt(nu * 0.5) * rnd_normal / MathSqrt(rnd_gamma);
    result[i] = rnd;
  }
  return true;
}

double MathMomentsT(const double nu, double &mean, double &variance,
                    double &skewness, double &kurtosis, int &error_code) {

  mean = QNaN;
  variance = QNaN;
  skewness = QNaN;
  kurtosis = QNaN;

  if (!MathIsValidNumber(nu)) {
    error_code = ERR_ARGUMENTS_NAN;
    return QNaN;
  }

  if (nu != MathRound(nu) || nu < 0.0) {
    error_code = ERR_ARGUMENTS_INVALID;
    return QNaN;
  }

  error_code = ERR_OK;

  mean = 0;
  if (nu > 2)
    variance = nu / (nu - 2);
  skewness = 0;
  if (nu > 4)
    kurtosis = 6 / (nu - 4);

  return true;
}

#endif
