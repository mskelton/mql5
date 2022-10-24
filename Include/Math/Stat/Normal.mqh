#ifndef NORMAL_H
#define NORMAL_H

#include "Math.mqh"

double MathProbabilityDensityNormal(const double x, const double mu,
                                    const double sigma, const bool log_mode,
                                    int &error_code);

double MathProbabilityDensityNormal(const double x, const double mu,
                                    const double sigma, int &error_code);

bool MathProbabilityDensityNormal(const double x[], const double mu,
                                  const double sigma, const bool log_mode,
                                  double result[]);

bool MathProbabilityDensityNormal(const double x[], const double mu,
                                  const double sigma, double result[]);

double MathCumulativeDistributionNormal(const double x, const double mu,
                                        const double sigma, const bool tail,
                                        const bool log_mode, int &error_code);

double MathCumulativeDistributionNormal(const double x, const double mu,
                                        const double sigma, int &error_code);

bool MathCumulativeDistributionNormal(const double x[], const double mu,
                                      const double sigma, const bool tail,
                                      const bool log_mode, double result[]);

bool MathCumulativeDistributionNormal(const double x[], const double mu,
                                      const double sigma, double result[]);

double MathQuantileNormal(const double probability, const double mu,
                          const double sigma, const bool tail,
                          const bool log_mode, int &error_code);

double MathQuantileNormal(const double probability, const double mu,
                          const double sigma, int &error_code);

bool MathQuantileNormal(const double probability[], const double mu,
                        const double sigma, const bool tail,
                        const bool log_mode, double result[]);

bool MathQuantileNormal(const double probability[], const double mu,
                        const double sigma, double result[]);

double MathRandomNormal(const double mu, const double sigma, int &error_code);

bool MathRandomNormal(const double mu, const double sigma, const int data_count,
                      double result[]);

bool MathMomentsNormal(const double mu, const double sigma, double &mean,
                       double &variance, double &skewness, double &kurtosis,
                       int &error_code);

#endif
