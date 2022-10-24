#ifndef GEOMETRIC_H
#define GEOMETRIC_H

#include "Math.mqh"

double MathProbabilityDensityGeometric(const double x, const double p,
                                       const bool log_mode, int &error_code);

double MathProbabilityDensityGeometric(const double x, const double p,
                                       int &error_code);

bool MathProbabilityDensityGeometric(const double x[], const double p,
                                     const bool log_mode, double result[]);

bool MathProbabilityDensityGeometric(const double x[], const double p,
                                     double result[]);

double MathCumulativeDistributionGeometric(const double x, const double p,
                                           const bool tail, const bool log_mode,
                                           int &error_code);

double MathCumulativeDistributionGeometric(const double x, const double p,
                                           int &error_code);

bool MathCumulativeDistributionGeometric(const double x[], const double p,
                                         const bool tail, const bool log_mode,
                                         double result[]);

bool MathCumulativeDistributionGeometric(const double x[], const double p,
                                         double result[]);

double MathQuantileGeometric(const double probability, const double p,
                             const bool tail, const bool log_mode,
                             int &error_code);

double MathQuantileGeometric(const double probability, const double p,
                             int &error_code);

bool MathQuantileGeometric(const double probability[], const double p,
                           const bool tail, const bool log_mode,
                           double result[]);

bool MathQuantileGeometric(const double probability[], const double p,
                           double result[]);

double MathRandomGeometric(const double p, int &error_code);

bool MathRandomGeometric(const double p, const int data_count, double result[]);

bool MathMomentsGeometric(const double p, double &mean, double &variance,
                          double &skewness, double &kurtosis, int &error_code);

#endif
