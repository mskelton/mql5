#ifndef CHI_SQUARE_H
#define CHI_SQUARE_H

#include "Gamma.mqh"
#include "Math.mqh"

double MathProbabilityDensityChiSquare(const double x, const double nu,
                                       const bool log_mode, int &error_code) ;

double MathProbabilityDensityChiSquare(const double x, const double nu,
                                       int &error_code) ;

bool MathProbabilityDensityChiSquare(const double x[], const double nu,
                                     const bool log_mode, double result[]) ;

bool MathProbabilityDensityChiSquare(const double x[], const double nu,
                                     double result[]) ;

double MathCumulativeDistributionChiSquare(const double x, const double nu,
                                           const bool tail, const bool log_mode,
                                           int &error_code) ;

double MathCumulativeDistributionChiSquare(const double x, const double nu,
                                           int &error_code) ;

bool MathCumulativeDistributionChiSquare(const double x[], const double nu,
                                         const bool tail, const bool log_mode,
                                         double result[]) ;

bool MathCumulativeDistributionChiSquare(const double x[], const double nu,
                                         double result[]) ;

double MathQuantileChiSquare(const double probability, const double nu,
                             const bool tail, const bool log_mode,
                             int &error_code) ;

double MathQuantileChiSquare(const double probability, const double nu,
                             int &error_code) ;

bool MathQuantileChiSquare(const double probability[], const double nu,
                           const bool tail, const bool log_mode,
                           double result[]) ;

bool MathQuantileChiSquare(const double probability[], const double nu,
                           double result[]) ;

double MathRandomChiSquare(const double nu, int &error_code) ;

bool MathRandomChiSquare(const double nu, const int data_count,
                         double result[]) ;

bool MathMomentsChiSquare(const double nu, double &mean, double &variance,
                          double &skewness, double &kurtosis, int &error_code) ;

#endif
