#ifndef NONCENTRAL_T_H
#define NONCENTRAL_T_H

#include "Math.mqh"
#include "Normal.mqh"
#include "T.mqh"

double MathProbabilityDensityNoncentralT(const double x, const double nu,
                                         const double delta,
                                         const bool log_mode, int &error_code);

double MathProbabilityDensityNoncentralT(const double x, const double nu,
                                         const double delta, int &error_code);

bool MathProbabilityDensityNoncentralT(const double x[], const double nu,
                                       const double delta, const bool log_mode,
                                       double result[]);

bool MathProbabilityDensityNoncentralT(const double x[], const double nu,
                                       const double delta, double result[]);

double MathCumulativeDistributionNoncentralT(const double x, const double nu,
                                             const double delta,
                                             const bool tail,
                                             const bool log_mode,
                                             int &error_code);

double MathCumulativeDistributionNoncentralT(const double x, const double nu,
                                             const double delta,
                                             int &error_code);

bool MathCumulativeDistributionNoncentralT(const double x[], const double nu,
                                           const double delta, const bool tail,
                                           const bool log_mode,
                                           double result[]);

bool MathCumulativeDistributionNoncentralT(const double x[], const double nu,
                                           const double delta, double result[]);

double MathQuantileNoncentralT(const double probability, const double nu,
                               const double delta, const bool tail,
                               const bool log_mode, int &error_code);

double MathQuantileNoncentralT(const double probability, const double nu,
                               const double delta, int &error_code);

bool MathQuantileNoncentralT(const double probability[], const double nu,
                             const double delta, const bool tail,
                             const bool log_mode, double result[]);

bool MathQuantileNoncentralT(const double probability[], const double nu,
                             const double delta, double result[]);

double MathRandomNoncentralT(const double nu, const double delta,
                             int &error_code);

bool MathRandomNoncentralT(const double nu, const double delta,
                           const int data_count, double result[]);

double MathMomentsNoncentralT(const double nu, const double delta, double &mean,
                              double &variance, double &skewness,
                              double &kurtosis, int &error_code);

#endif
