#ifndef F_H
#define F_H

#include "Beta.mqh"
#include "ChiSquare.mqh"
#include "Math.mqh"

double MathProbabilityDensityF(const double x, const double nu1,
                               const double nu2, const bool log_mode,
                               int &error_code) ;

double MathProbabilityDensityF(const double x, const double nu1,
                               const double nu2, int &error_code) ;

bool MathProbabilityDensityF(const double x[], const double nu1,
                             const double nu2, const bool log_mode,
                             double result[]) ;

bool MathProbabilityDensityF(const double x[], const double nu1,
                             const double nu2, double result[]) ;

double MathCumulativeDistributionF(const double x, const double nu1,
                                   const double nu2, const bool tail,
                                   const bool log_mode, int &error_code) ;

double MathCumulativeDistributionF(const double x, const double nu1,
                                   const double nu2, int &error_code) ;

bool MathCumulativeDistributionF(const double x[], const double nu1,
                                 const double nu2, const bool tail,
                                 const bool log_mode, double result[]) ;

bool MathCumulativeDistributionF(const double x[], const double nu1,
                                 const double nu2, double result[]) ;

double MathQuantileF(const double probability, const double nu1,
                     const double nu2, const bool tail, const bool log_mode,
                     int &error_code) ;

double MathQuantileF(const double probability, const double nu1,
                     const double nu2, int &error_code) ;

bool MathQuantileF(const double probability[], const double nu1,
                   const double nu2, const bool tail, const bool log_mode,
                   double result[]) ;

bool MathQuantileF(const double probability[], const double nu1,
                   const double nu2, double result[]) ;

double MathRandomF(const double nu1, const double nu2, int &error_code) ;

bool MathRandomF(const double nu1, const double nu2, const int data_count,
                 double result[]) ;

bool MathMomentsF(const double nu1, const double nu2, double &mean,
                  double &variance, double &skewness, double &kurtosis,
                  int &error_code) ;

#endif
