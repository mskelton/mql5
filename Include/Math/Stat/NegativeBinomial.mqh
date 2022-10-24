#ifndef NEGATIVE_BINOMIAL_H
#define NEGATIVE_BINOMIAL_H

#include "Gamma.mqh"
#include "Math.mqh"
#include "Poisson.mqh"

double MathProbabilityDensityNegativeBinomial(const double x, const double r,
                                              const double p,
                                              const bool log_mode,
                                              int &error_code) ;

double MathProbabilityDensityNegativeBinomial(const double x, const double r,
                                              const double p, int &error_code) ;

bool MathProbabilityDensityNegativeBinomial(const double x[], const double r,
                                            const double p, const bool log_mode,
                                            double result[]) ;

bool MathProbabilityDensityNegativeBinomial(const double x[], const double r,
                                            const double p, double result[]) ;

double MathCumulativeDistributionNegativeBinomial(const double x,
                                                  const double r, double p,
                                                  const bool tail,
                                                  const bool log_mode,
                                                  int error_code) ;

double MathCumulativeDistributionNegativeBinomial(const double x,
                                                  const double r, double p,
                                                  int error_code) ;

bool MathCumulativeDistributionNegativeBinomial(const double x[],
                                                const double r, double p,
                                                const bool tail,
                                                const bool log_mode,
                                                double result[]) ;

bool MathCumulativeDistributionNegativeBinomial(const double x[],
                                                const double r, double p,
                                                double result[]) ;

double MathQuantileNegativeBinomial(const double probability, const double r,
                                    const double p, const bool tail,
                                    const bool log_mode, int &error_code) ;

double MathQuantileNegativeBinomial(const double probability, const double r,
                                    const double p, int &error_code) ;

bool MathQuantileNegativeBinomial(const double probability[], const double r,
                                  const double p, const bool tail,
                                  const bool log_mode, double result[]) ;

bool MathQuantileNegativeBinomial(const double probability[], const double r,
                                  const double p, double result[]) ;

double MathRandomNegativeBinomial(const double r, const double p,
                                  int error_code) ;

bool MathRandomNegativeBinomial(const double r, const double p,
                                const int data_count, double result[]) ;

bool MathMomentsNegativeBinomial(const double r, double p, double &mean,
                                 double &variance, double &skewness,
                                 double &kurtosis, int &error_code) ;

#endif
