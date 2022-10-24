#ifndef NONCENTRAL_BETA_H
#define NONCENTRAL_BETA_H

#include "Beta.mqh"
#include "Math.mqh"
#include "NoncentralChiSquare.mqh"

double MathProbabilityDensityNoncentralBeta(const double x, const double a,
                                            const double b, const double lambda,
                                            const bool log_mode,
                                            int &error_code);

double MathProbabilityDensityNoncentralBeta(const double x, const double a,
                                            const double b, const double lambda,
                                            int &error_code);

bool MathProbabilityDensityNoncentralBeta(const double x[], const double a,
                                          const double b, const double lambda,
                                          const bool log_mode, double result[]);

bool MathProbabilityDensityNoncentralBeta(const double x[], const double a,
                                          const double b, const double lambda,
                                          double result[]);

double MathCumulativeDistributionNoncentralBeta(
    const double x, const double a, const double b, const double lambda,
    const bool tail, const bool log_mode, int &error_code);

double MathCumulativeDistributionNoncentralBeta(const double x, const double a,
                                                const double b,
                                                const double lambda,
                                                int &error_code);

bool MathCumulativeDistributionNoncentralBeta(
    const double x[], const double a, const double b, const double lambda,
    const bool tail, const bool log_mode, double result[]);

bool MathCumulativeDistributionNoncentralBeta(const double x[], const double a,
                                              const double b,
                                              const double lambda,
                                              double result[]);

double MathQuantileNoncentralBeta(const double probability, const double a,
                                  const double b, const double lambda,
                                  const bool tail, const bool log_mode,
                                  int &error_code);

double MathQuantileNoncentralBeta(const double probability, const double a,
                                  const double b, const double lambda,
                                  int &error_code);

bool MathQuantileNoncentralBeta(const double probability[], const double a,
                                const double b, const double lambda,
                                const bool tail, const bool log_mode,
                                double result[]);

bool MathQuantileNoncentralBeta(const double probability[], const double a,
                                const double b, const double lambda,
                                double result[]);

double MathRandomNoncentralBeta(const double a, const double b,
                                const double lambda, int &error_code);

bool MathRandomNoncentralBeta(const double a, const double b,
                              const double lambda, const int data_count,
                              double result[]);

double MathMomentsNoncentralBeta(const double a, const double b,
                                 const double lambda, double &mean,
                                 double &variance, double &skewness,
                                 double &kurtosis, int &error_code);

#endif
