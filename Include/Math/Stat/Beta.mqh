#ifndef BETA_H
#define BETA_H

#include "Math.mqh"

double MathProbabilityDensityBeta(const double x, const double a,
                                  const double b, const bool log_mode,
                                  int &error_code) ;

double MathProbabilityDensityBeta(const double x, const double a,
                                  const double b, int &error_code) ;

bool MathProbabilityDensityBeta(const double x[], const double a,
                                const double b, const bool log_mode,
                                double result[]) ;

bool MathProbabilityDensityBeta(const double x[], const double a,
                                const double b, double result[]) ;

double MathCumulativeDistributionBeta(const double x, const double a,
                                      const double b, const bool tail,
                                      const bool log_mode, int &error_code) ;

double MathCumulativeDistributionBeta(const double x, const double a,
                                      const double b, int &error_code) ;

bool MathCumulativeDistributionBeta(const double x[], const double a,
                                    const double b, const bool tail,
                                    const bool log_mode, double result[]) ;

bool MathCumulativeDistributionBeta(const double x[], const double a,
                                    const double b, double result[]) ;

double MathQuantileBeta(const double probability, const double a,
                        const double b, const bool tail, const bool log_mode,
                        int &error_code) ;

double MathQuantileBeta(const double probability, const double a,
                        const double b, int &error_code) ;

bool MathQuantileBeta(const double probability[], const double a,
                      const double b, const bool tail, const bool log_mode,
                      double result[]) ;

bool MathQuantileBeta(const double probability[], const double a,
                      const double b, double result[]) ;

double MathRandomBeta(const double a, const double b) ;

double MathRandomBeta(const double a, const double b, int &error_code) ;

bool MathRandomBeta(const double a, const double b, const int data_count,
                    double result[]) ;

bool MathMomentsBeta(const double a, const double b, double &mean,
                     double &variance, double &skewness, double &kurtosis,
                     int &error_code) ;

#endif
