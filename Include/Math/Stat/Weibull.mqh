#ifndef WEIBULL_H
#define WEIBULL_H

#include "Math.mqh"

double MathProbabilityDensityWeibull(const double x, const double a,
                                     const double b, const bool log_mode,
                                     int &error_code);

double MathProbabilityDensityWeibull(const double x, const double a,
                                     const double b, int &error_code);

bool MathProbabilityDensityWeibull(const double x[], const double a,
                                   const double b, const bool log_mode,
                                   double result[]);

bool MathProbabilityDensityWeibull(const double x[], const double a,
                                   const double b, double result[]);

double MathCumulativeDistributionWeibull(const double x, const double a,
                                         const double b, const bool tail,
                                         const bool log_mode, int &error_code);

double MathCumulativeDistributionWeibull(const double x, const double a,
                                         const double b, int &error_code);

bool MathCumulativeDistributionWeibull(const double x[], const double a,
                                       const double b, const bool tail,
                                       const bool log_mode, double result[]);

bool MathCumulativeDistributionWeibull(const double x[], const double a,
                                       const double b, double result[]);

double MathQuantileWeibull(const double probability, const double a,
                           const double b, const bool tail, const bool log_mode,
                           int &error_code);

double MathQuantileWeibull(const double probability, const double a,
                           const double b, int &error_code);

bool MathQuantileWeibull(const double probability[], const double a,
                         const double b, const bool tail, const bool log_mode,
                         double result[]);

bool MathQuantileWeibull(const double probability[], const double a,
                         const double b, double result[]);

double MathRandomWeibull(const double a, const double b, int &error_code);

bool MathRandomWeibull(const double a, const double b, const int data_count,
                       double result[]);

bool MathMomentsWeibull(const double a, const double b, double &mean,
                        double &variance, double &skewness, double &kurtosis,
                        int &error_code);

#endif
