#ifndef NONCENTRAL_CHI_SQUARE_H
#define NONCENTRAL_CHI_SQUARE_H

#include "ChiSquare.mqh"
#include "Math.mqh"
#include "Normal.mqh"
#include "Poisson.mqh"

double MathProbabilityDensityNoncentralChiSquare(const double x,
                                                 const double nu,
                                                 const double sigma,
                                                 const bool log_mode,
                                                 int &error_code) ;

double MathProbabilityDensityNoncentralChiSquare(double x, const double nu,
                                                 const double sigma,
                                                 int &error_code) ;

bool MathProbabilityDensityNoncentralChiSquare(const double x[],
                                               const double nu,
                                               const double sigma,
                                               const bool log_mode,
                                               double result[]) ;

bool MathProbabilityDensityNoncentralChiSquare(const double x[],
                                               const double nu,
                                               const double sigma,
                                               double result[]) ;

double MathCumulativeDistributionNoncentralChiSquare(
    const double x, const double nu, const double sigma, const bool tail,
    const bool log_mode, int &error_code) ;

double MathCumulativeDistributionNoncentralChiSquare(const double x,
                                                     const double nu,
                                                     const double sigma,
                                                     int &error_code) ;

bool MathCumulativeDistributionNoncentralChiSquare(
    const double x[], const double nu, const double sigma, const bool tail,
    const bool log_mode, double result[]) ;

bool MathCumulativeDistributionNoncentralChiSquare(const double x[],
                                                   const double nu,
                                                   const double sigma,
                                                   double result[]) ;

double MathQuantileNoncentralChiSquare(const double probability,
                                       const double nu, const double sigma,
                                       const bool tail, const bool log_mode,
                                       int &error_code) ;

double MathQuantileNoncentralChiSquare(const double probability,
                                       const double nu, const double sigma,
                                       int &error_code) ;

bool MathQuantileNoncentralChiSquare(const double probability[],
                                     const double nu, const double sigma,
                                     const bool tail, const bool log_mode,
                                     double result[]) ;

bool MathQuantileNoncentralChiSquare(const double probability[],
                                     const double nu, const double sigma,
                                     double result[]) ;

double MathRandomNoncentralChiSquare(const double nu, const double sigma,
                                     int &error_code) ;

bool MathRandomNoncentralChiSquare(const double nu, const double sigma,
                                   const int data_count, double result[]) ;

bool MathMomentsNoncentralChiSquare(const double nu, const double sigma,
                                    double &mean, double &variance,
                                    double &skewness, double &kurtosis,
                                    int &error_code) ;

#endif
