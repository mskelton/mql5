#ifndef LOGISTIC_H
#define LOGISTIC_H

#include "Math.mqh"

double MathProbabilityDensityLogistic(const double x, const double mu,
                                      const double sigma, const bool log_mode,
                                      int &error_code);

double MathProbabilityDensityLogistic(const double x, const double mu,
                                      const double sigma, int &error_code);

bool MathProbabilityDensityLogistic(const double x[], const double mu,
                                    const double sigma, const bool log_mode,
                                    double result[]);

bool MathProbabilityDensityLogistic(const double x[], const double mu,
                                    const double sigma, double result[]);

double MathCumulativeDistributionLogistic(const double x, const double mu,
                                          double sigma, const bool tail,
                                          const bool log_mode, int &error_code);

double MathCumulativeDistributionLogistic(const double x, const double mu,
                                          double sigma, int &error_code);

bool MathCumulativeDistributionLogistic(const double x[], const double mu,
                                        const double sigma, const bool tail,
                                        const bool log_mode, double result[]);

bool MathCumulativeDistributionLogistic(const double x[], const double mu,
                                        const double sigma, double result[]);

double MathQuantileLogistic(const double probability, const double mu,
                            const double sigma, const bool tail,
                            const bool log_mode, int &error_code);

double MathQuantileLogistic(const double probability, const double mu,
                            const double sigma, int &error_code);

bool MathQuantileLogistic(const double probability[], const double mu,
                          const double sigma, const bool tail,
                          const bool log_mode, double result[]);

bool MathQuantileLogistic(const double probability[], const double mu,
                          const double sigma, double result[]);

double MathRandomLogistic(const double mu, const double sigma, int &error_code);

bool MathRandomLogistic(const double mu, const double sigma,
                        const int data_count, double result[]);

bool MathMomentsLogistic(const double mu, const double sigma, double &mean,
                         double &variance, double &skewness, double &kurtosis,
                         int &error_code);

#endif
