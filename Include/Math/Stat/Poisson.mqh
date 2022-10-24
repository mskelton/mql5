#ifndef POISSON_H
#define POISSON_H

#include "Gamma.mqh"
#include "Math.mqh"

double MathProbabilityDensityPoisson(const double x, const double lambda,
                                     const bool log_mode, int &error_code) ;

double MathProbabilityDensityPoisson(const double x, const double lambda,
                                     int &error_code) ;

bool MathProbabilityDensityPoisson(const double x[], const double lambda,
                                   const bool log_mode, double result[]) ;

bool MathProbabilityDensityPoisson(const double x[], const double lambda,
                                   double result[]) ;

double MathCumulativeDistributionPoisson(const double x, const double lambda,
                                         const bool tail, const bool log_mode,
                                         int &error_code) ;

double MathCumulativeDistributionPoisson(const double x, const double lambda,
                                         int &error_code) ;

bool MathCumulativeDistributionPoisson(const double x[], const double lambda,
                                       const bool tail, const bool log_mode,
                                       double result[]) ;

bool MathCumulativeDistributionPoisson(const double x[], const double lambda,
                                       double result[]) ;

double MathQuantilePoisson(const double probability, const double lambda,
                           const bool tail, const bool log_mode,
                           int &error_code) ;

double MathQuantilePoisson(const double probability, const double lambda,
                           int &error_code) ;

bool MathQuantilePoisson(const double probability[], const double lambda,
                         const bool tail, const bool log_mode,
                         double result[]) ;

bool MathQuantilePoisson(const double probability[], const double lambda,
                         double result[]) ;

double MathRandomPoisson(const double lambda) ;

double MathRandomPoisson(const double lambda, int &error_code) ;

bool MathRandomPoisson(const double lambda, const int data_count,
                       double result[]) ;

bool MathMomentsPoisson(const double lambda, double &mean, double &variance,
                        double &skewness, double &kurtosis, int &error_code) ;

#endif
