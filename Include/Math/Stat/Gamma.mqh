#ifndef GAMMA_H
#define GAMMA_H

#include "Normal.mqh"

double MathInverseGammaIncomplete(const double a, const double y);

double MathProbabilityDensityGamma(const double x, const double a,
                                   const double b, const bool log_mode,
                                   int &error_code);

double MathProbabilityDensityGamma(const double x, const double a,
                                   const double b, int &error_code);

bool MathProbabilityDensityGamma(const double x[], const double a,
                                 const double b, const bool log_mode,
                                 double result[]);

bool MathProbabilityDensityGamma(const double x[], const double a,
                                 const double b, double result[]);

double MathCumulativeDistributionGamma(const double x, const double a,
                                       const double b, const bool tail,
                                       const bool log_mode, int &error_code);

double MathCumulativeDistributionGamma(const double x, const double a,
                                       const double b, int &error_code);

bool MathCumulativeDistributionGamma(const double x[], const double a,
                                     const double b, const bool tail,
                                     const bool log_mode, double result[]);

bool MathCumulativeDistributionGamma(const double x[], const double a,
                                     const double b, double result[]);

double MathQuantileGamma(const double probability, const double a,
                         const double b, const bool tail, const bool log_mode,
                         int &error_code);

double MathQuantileGamma(const double probability, const double a,
                         const double b, int &error_code);

bool MathQuantileGamma(const double probability[], const double a,
                       const double b, const bool tail, const bool log_mode,
                       double result[]);

bool MathQuantileGamma(const double probability[], const double a,
                       const double b, double result[]);

double MathRandomGamma(const double a, const double b);

double MathRandomGamma(const double a, const double b, int &error_code);

bool MathRandomGamma(const double a, const double b, const int data_count,
                     double result[]);

bool MathMomentsGamma(const double a, const double b, double &mean,
                      double &variance, double &skewness, double &kurtosis,
                      int &error_code);

#endif
