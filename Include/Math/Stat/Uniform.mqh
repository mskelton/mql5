#ifndef UNIFORM_H
#define UNIFORM_H

#include "Math.mqh"

double MathProbabilityDensityUniform(const double x, const double a,
                                     const double b, const bool log_mode,
                                     int &error_code) ;

double MathProbabilityDensityUniform(const double x, const double a,
                                     const double b, int &error_code) ;

bool MathProbabilityDensityUniform(const double x[], const double a,
                                   const double b, const bool log_mode,
                                   double result[]) ;

bool MathProbabilityDensityUniform(const double x[], const double a,
                                   const double b, double result[]) ;

double MathCumulativeDistributionUniform(const double x, const double a,
                                         const double b, const bool tail,
                                         const bool log_mode, int &error_code) ;

double MathCumulativeDistributionUniform(const double x, const double a,
                                         const double b, int &error_code) ;

bool MathCumulativeDistributionUniform(const double x[], const double a,
                                       const double b, const bool tail,
                                       const bool log_mode, double result[]) ;

bool MathCumulativeDistributionUniform(const double x[], const double a,
                                       const double b, double result[]) ;

double MathQuantileUniform(const double probability, const double a,
                           const double b, const bool tail, const bool log_mode,
                           int &error_code) ;

double MathQuantileUniform(const double probability, const double a,
                           const double b, int &error_code) ;

bool MathQuantileUniform(const double probability[], const double a,
                         const double b, const bool tail, const bool log_mode,
                         double result[]) ;

bool MathQuantileUniform(const double probability[], const double a,
                         const double b, double result[]) ;

double MathRandomUniform(const double a, const double b, int &error_code) ;

bool MathRandomUniform(const double a, const double b, const int data_count,
                       double result[]) ;

bool MathMomentsUniform(const double a, const double b, double &mean,
                        double &variance, double &skewness, double &kurtosis,
                        int &error_code) ;

#endif
