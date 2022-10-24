#ifndef LOGNORMAL_H
#define LOGNORMAL_H

#include "Math.mqh"
#include "Normal.mqh"

double MathProbabilityDensityLognormal(const double x, const double mu,
                                       const double sigma, const bool log_mode,
                                       int &error_code) ;

bool MathProbabilityDensityLognormal(const double x[], const double mu,
                                     const double sigma, const bool log_mode,
                                     double result[]) ;

bool MathProbabilityDensityLognormal(const double x[], const double mu,
                                     const double sigma, double result[]) ;

double MathProbabilityDensityLognormal(const double x, const double mu,
                                       const double sigma, int &error_code) ;

double MathCumulativeDistributionLognormal(const double x, const double mu,
                                           const double sigma, const bool tail,
                                           const bool log_mode,
                                           int &error_code) ;

double MathCumulativeDistributionLognormal(const double x, const double mu,
                                           const double sigma,
                                           int &error_code) ;

bool MathCumulativeDistributionLognormal(const double x[], const double mu,
                                         const double sigma, const bool tail,
                                         const bool log_mode,
                                         double result[]) ;

bool MathCumulativeDistributionLognormal(const double x[], const double mu,
                                         const double sigma, double result[]) ;

double MathQuantileLognormal(const double probability, const double mu,
                             const double sigma, const bool tail,
                             const bool log_mode, int &error_code) ;

double MathQuantileLognormal(const double probability, const double mu,
                             const double sigma, int &error_code) ;

bool MathQuantileLognormal(const double probability[], const double mu,
                           const double sigma, const bool tail,
                           const bool log_mode, double result[]) ;

bool MathQuantileLognormal(const double probability[], const double mu,
                           const double sigma, double result[]) ;

double MathRandomLognormal(const double mu, const double sigma,
                           int &error_code) ;

bool MathRandomLognormal(const double mu, const double sigma,
                         const int data_count, double result[]) ;

bool MathMomentsLognormal(const double mu, const double sigma, double &mean,
                          double &variance, double &skewness, double &kurtosis,
                          int &error_code) ;

#endif
