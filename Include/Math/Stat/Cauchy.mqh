#ifndef CAUCHY_H
#define CAUCHY_H

#include "Math.mqh"

double MathProbabilityDensityCauchy(const double x, const double a,
                                    const double b, const bool log_mode,
                                    int &error_code);

double MathProbabilityDensityCauchy(const double x, const double a,
                                    const double b, int &error_code);

bool MathProbabilityDensityCauchy(const double x[], const double a,
                                  const double b, const bool log_mode,
                                  double result[]);

bool MathProbabilityDensityCauchy(const double x[], const double a,
                                  const double b, double result[]);

double MathCumulativeDistributionCauchy(const double x, const double a,
                                        const double b, const bool tail,
                                        const bool log_mode, int &error_code);

double MathCumulativeDistributionCauchy(const double x, const double a,
                                        const double b, int &error_code);

bool MathCumulativeDistributionCauchy(const double x[], const double a,
                                      const double b, const bool tail,
                                      const bool log_mode, double result[]);

bool MathCumulativeDistributionCauchy(const double x[], const double a,
                                      const double b, double result[]);

double MathQuantileCauchy(const double probability, const double a,
                          const double b, const bool tail, const bool log_mode,
                          int &error_code);

double MathQuantileCauchy(const double probability, const double a,
                          const double b, int &error_code);

bool MathQuantileCauchy(const double probability[], const double a,
                        const double b, const bool tail, const bool log_mode,
                        double result[]);

bool MathQuantileCauchy(const double probability[], const double a,
                        const double b, double result[]);

double MathRandomCauchy(const double a, const double b, int &error_code);

bool MathRandomCauchy(const double a, const double b, const int data_count,
                      double result[]);

bool MathMomentsCauchy(const double a, const double b, double &mean,
                       double &variance, double &skewness, double &kurtosis,
                       int &error_code);

#endif
