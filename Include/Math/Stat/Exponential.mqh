#ifndef EXPONENTIAL_H
#define EXPONENTIAL_H

#include "Math.mqh"

double MathProbabilityDensityExponential(const double x, const double mu,
                                         const bool log_mode, int &error_code) ;

double MathProbabilityDensityExponential(const double x, const double mu,
                                         int &error_code) ;

bool MathProbabilityDensityExponential(const double x[], const double mu,
                                       const bool log_mode, double result[]) ;

bool MathProbabilityDensityExponential(const double x[], const double mu,
                                       double result[]) ;

double MathCumulativeDistributionExponential(const double x, const double mu,
                                             const bool tail,
                                             const bool log_mode,
                                             int &error_code) ;

double MathCumulativeDistributionExponential(const double x, const double mu,
                                             int &error_code) ;

bool MathCumulativeDistributionExponential(const double x[], const double mu,
                                           const bool tail, const bool log_mode,
                                           double result[]) ;

bool MathCumulativeDistributionExponential(const double x[], const double mu,
                                           double result[]) ;

double MathQuantileExponential(const double probability, const double mu,
                               const bool tail, const bool log_mode,
                               int &error_code) ;

double MathQuantileExponential(const double probability, const double mu,
                               int &error_code) ;

bool MathQuantileExponential(const double probability[], const double mu,
                             const bool tail, const bool log_mode,
                             double result[]) ;

bool MathQuantileExponential(const double probability[], const double mu,
                             double result[]) ;

double MathRandomExponential(const double mu, int &error_code) ;

bool MathRandomExponential(const double mu, const int data_count,
                           double result[]) ;

bool MathMomentsExponential(const double mu, double &mean, double &variance,
                            double &skewness, double &kurtosis,
                            int &error_code) ;

#endif
