#ifndef NONCENTRAL_F_H
#define NONCENTRAL_F_H

#include "F.mqh"
#include "Gamma.mqh"
#include "Math.mqh"
#include "NoncentralBeta.mqh"

double MathProbabilityDensityNoncentralF(const double x, const double nu1,
                                         const double nu2, const double sigma,
                                         const bool log_mode, int &error_code);

double MathProbabilityDensityNoncentralF(const double x, const double nu1,
                                         const double nu2, const double sigma,
                                         int &error_code);

bool MathProbabilityDensityNoncentralF(const double x[], const double nu1,
                                       const double nu2, const double sigma,
                                       const bool log_mode, double result[]);

bool MathProbabilityDensityNoncentralF(const double x[], const double nu1,
                                       const double nu2, const double sigma,
                                       double result[]);

double MathCumulativeDistributionNoncentralF(
    const double x, const double nu1, const double nu2, const double sigma,
    const bool tail, const bool log_mode, int &error_code);

double MathCumulativeDistributionNoncentralF(const double x, const double nu1,
                                             const double nu2,
                                             const double sigma,
                                             int &error_code);

bool MathCumulativeDistributionNoncentralF(const double x[], const double nu1,
                                           const double nu2, const double sigma,
                                           const bool tail, const bool log_mode,
                                           double result[]);

bool MathCumulativeDistributionNoncentralF(const double x[], const double nu1,
                                           const double nu2, const double sigma,
                                           double result[]);

double MathQuantileNoncentralF(const double probability, const double nu1,
                               const double nu2, const double sigma,
                               const bool tail, const bool log_mode,
                               int &error_code);

double MathQuantileNoncentralF(const double probability, const double nu1,
                               const double nu2, const double sigma,
                               int &error_code);

bool MathQuantileNoncentralF(const double probability[], const double nu1,
                             const double nu2, const double sigma,
                             const bool tail, const bool log_mode,
                             double result[]);

bool MathQuantileNoncentralF(const double probability[], const double nu1,
                             const double nu2, const double sigma,
                             double result[]);

double MathRandomNoncentralF(const double nu1, const double nu2,
                             const double sigma, int &error_code);

bool MathRandomNoncentralF(const double nu1, const double nu2,
                           const double sigma, const int data_count,
                           double result[]);

bool MathMomentsNoncentralF(const double nu1, const double nu2,
                            const double sigma, double &mean, double &variance,
                            double &skewness, double &kurtosis,
                            int &error_code);

#endif
