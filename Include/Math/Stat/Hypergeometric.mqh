#ifndef HYPERGEOMETRIC_H
#define HYPERGEOMETRIC_H

#include "Math.mqh"

double MathProbabilityDensityHypergeometric(const double x, const double m,
                                            const double k, const double n,
                                            const bool log_mode,
                                            int &error_code) ;

double MathProbabilityDensityHypergeometric(const double x, const double m,
                                            const double k, const double n,
                                            int &error_code) ;

bool MathProbabilityDensityHypergeometric(const double x[], const double m,
                                          const double k, const double n,
                                          const bool log_mode,
                                          double result[]) ;

bool MathProbabilityDensityHypergeometric(const double x[], const double m,
                                          const double k, const double n,
                                          double result[]) ;

double MathCumulativeDistributionHypergeometric(const double x, const double m,
                                                const double k, const double n,
                                                const bool tail,
                                                const bool log_mode,
                                                int &error_code) ;

double MathCumulativeDistributionHypergeometric(const double x, const double m,
                                                const double k, const double n,
                                                int &error_code) ;

bool MathCumulativeDistributionHypergeometric(const double x[], const double m,
                                              const double k, const double n,
                                              const bool tail,
                                              const bool log_mode,
                                              double result[]) ;

bool MathCumulativeDistributionHypergeometric(const double x[], const double m,
                                              const double k, const double n,
                                              double result[]) ;

double MathQuantileHypergeometric(const double probability, const double m,
                                  const double k, const double n,
                                  const bool tail, const bool log_mode,
                                  int &error_code) ;

double MathQuantileHypergeometric(const double probability, const double m,
                                  const double k, const double n,
                                  int &error_code) ;

bool MathQuantileHypergeometric(const double probability[], const double m,
                                const double k, const double n, const bool tail,
                                const bool log_mode, double result[]) ;

bool MathQuantileHypergeometric(const double probability[], const double m,
                                const double k, const double n,
                                double result[]) ;

double MathRandomHypergeometric(const double m, const double k, const double n,
                                int &error_code) ;

bool MathRandomHypergeometric(const double m, const double k, const double n,
                              const int data_count, double result[]) ;

bool MathMomentsHypergeometric(const double m, const double k, const double n,
                               double &mean, double &variance, double &skewness,
                               double &kurtosis, int &error_code) ;

#endif
