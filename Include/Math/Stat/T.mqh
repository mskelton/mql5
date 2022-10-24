#ifndef T_H
#define T_H

#include "Gamma.mqh"
#include "Math.mqh"

double MathProbabilityDensityT(const double x, const double nu,
                               const bool log_mode, int &error_code);

double MathProbabilityDensityT(const double x, const double nu,
                               int &error_code);

bool MathProbabilityDensityT(const double x[], const double nu,
                             const bool log_mode, double result[]);

bool MathProbabilityDensityT(const double x[], const double nu,
                             double result[]);

double MathCumulativeDistributionT(const double x, const double nu,
                                   const bool tail, const bool log_mode,
                                   int &error_code);

double MathCumulativeDistributionT(const double x, const double nu,
                                   int &error_code);

bool MathCumulativeDistributionT(const double x[], const double nu,
                                 const bool tail, const bool log_mode,
                                 double result[]);

bool MathCumulativeDistributionT(const double x[], const double nu,
                                 double result[]);

double MathQuantileT(const double probability, const double nu, const bool tail,
                     const bool log_mode, int &error_code);

double MathQuantileT(const double probability, const double nu,
                     int &error_code);

bool MathQuantileT(const double probability[], const double nu, const bool tail,
                   const bool log_mode, double result[]);

bool MathQuantileT(const double probability[], const double nu,
                   double result[]);

double MathRandomT(const double nu, int error_code);

bool MathRandomT(const double nu, const int data_count, double result[]);

double MathMomentsT(const double nu, double &mean, double &variance,
                    double &skewness, double &kurtosis, int &error_code);

#endif
