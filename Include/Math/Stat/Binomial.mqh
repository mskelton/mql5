#ifndef BINOMIAL_H
#define BINOMIAL_H

#include "Beta.mqh"
#include "Math.mqh"

double MathProbabilityDensityBinomial(const double x, const double n,
                                      const double p, const bool log_mode,
                                      int &error_code) ;

double MathProbabilityDensityBinomial(const double x, const double n,
                                      const double p, int &error_code) ;

bool MathProbabilityDensityBinomial(const double x[], const double n,
                                    const double p, const bool log_mode,
                                    double result[]) ;

bool MathProbabilityDensityBinomial(const double x[], const double n,
                                    const double p, double result[]) ;

double MathCumulativeDistributionBinomial(const double x, const double n,
                                          double p, const bool tail,
                                          const bool log_mode,
                                          int &error_code) ;

double MathCumulativeDistributionBinomial(const double x, const double n,
                                          double p, int &error_code) ;

bool MathCumulativeDistributionBinomial(const double x[], const double n,
                                        double p, const bool tail,
                                        const bool log_mode, double result[]) ;

bool MathCumulativeDistributionBinomial(const double x[], const double n,
                                        double p, double result[]) ;

double MathQuantileBinomial(const double probability, const double n,
                            const double p, const bool tail,
                            const bool log_mode, int &error_code) ;

double MathQuantileBinomial(const double probability, const double n,
                            const double p, int &error_code) ;

bool MathQuantileBinomial(const double probability[], const double n,
                          const double p, const bool tail, const bool log_mode,
                          double result[]) ;

bool MathQuantileBinomial(const double probability[], const double n,
                          const double p, double result[]) ;

double MathRandomBinomial(const double n, const double p) ;

double MathRandomBinomial(const double n, const double p, int &error_code) ;

bool MathRandomBinomial(const double n, const double p, const int data_count,
                        double result[]) ;

bool MathMomentsBinomial(const double n, const double p, double &mean,
                         double &variance, double &skewness, double &kurtosis,
                         int &error_code) ;

#endif
