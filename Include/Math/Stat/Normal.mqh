#ifndef NORMAL_H
#define NORMAL_H

#include "Math.mqh"

const static double normal_cdf_a[5] = ;
const static double normal_cdf_b[4] = ;

const static double normal_cdf_c[9] = ;
const static double normal_cdf_d[8] = ;

const static double normal_cdf_p[6] = ;
const static double normal_cdf_q[5] = ;

const double normal_q_a0 = 3.3871328727963666080;
const double normal_q_a1 = 1.3314166789178437745E+2;
const double normal_q_a2 = 1.9715909503065514427E+3;
const double normal_q_a3 = 1.3731693765509461125E+4;
const double normal_q_a4 = 4.5921953931549871457E+4;
const double normal_q_a5 = 6.7265770927008700853E+4;
const double normal_q_a6 = 3.3430575583588128105E+4;
const double normal_q_a7 = 2.5090809287301226727E+3;
const double normal_q_b1 = 4.2313330701600911252E+1;
const double normal_q_b2 = 6.8718700749205790830E+2;
const double normal_q_b3 = 5.3941960214247511077E+3;
const double normal_q_b4 = 2.1213794301586595867E+4;
const double normal_q_b5 = 3.9307895800092710610E+4;
const double normal_q_b6 = 2.8729085735721942674E+4;
const double normal_q_b7 = 5.2264952788528545610E+3;

const double normal_q_c0 = 1.42343711074968357734;
const double normal_q_c1 = 4.63033784615654529590;
const double normal_q_c2 = 5.76949722146069140550;
const double normal_q_c3 = 3.64784832476320460504;
const double normal_q_c4 = 1.27045825245236838258;
const double normal_q_c5 = 2.41780725177450611770E-1;
const double normal_q_c6 = 2.27238449892691845833E-2;
const double normal_q_c7 = 7.74545014278341407640E-4;
const double normal_q_d1 = 2.05319162663775882187;
const double normal_q_d2 = 1.67638483018380384940;
const double normal_q_d3 = 6.89767334985100004550E-1;
const double normal_q_d4 = 1.48103976427480074590E-1;
const double normal_q_d5 = 1.51986665636164571966E-2;
const double normal_q_d6 = 5.47593808499534494600E-4;
const double normal_q_d7 = 1.05075007164441684324E-9;

const double normal_q_e0 = 6.65790464350110377720E0;
const double normal_q_e1 = 5.46378491116411436990E0;
const double normal_q_e2 = 1.78482653991729133580E0;
const double normal_q_e3 = 2.96560571828504891230E-1;
const double normal_q_e4 = 2.65321895265761230930E-2;
const double normal_q_e5 = 1.24266094738807843860E-3;
const double normal_q_e6 = 2.71155556874348757815E-5;
const double normal_q_e7 = 2.01033439929228813265E-7;
const double normal_q_f1 = 5.99832206555887937690E-1;
const double normal_q_f2 = 1.36929880922735805310E-1;
const double normal_q_f3 = 1.48753612908506148525E-2;
const double normal_q_f4 = 7.86869131145613259100E-4;
const double normal_q_f5 = 1.84631831751005468180E-5;
const double normal_q_f6 = 1.42151175831644588870E-7;
const double normal_q_f7 = 2.04426310338993978564E-15;

double MathProbabilityDensityNormal(const double x, const double mu,
                                    const double sigma, const bool log_mode,
                                    int &error_code) ;

double MathProbabilityDensityNormal(const double x, const double mu,
                                    const double sigma, int &error_code) ;

bool MathProbabilityDensityNormal(const double x[], const double mu,
                                  const double sigma, const bool log_mode,
                                  double result[]) ;

bool MathProbabilityDensityNormal(const double x[], const double mu,
                                  const double sigma, double result[]) ;

double MathCumulativeDistributionNormal(const double x, const double mu,
                                        const double sigma, const bool tail,
                                        const bool log_mode, int &error_code) ;

double MathCumulativeDistributionNormal(const double x, const double mu,
                                        const double sigma, int &error_code) ;

bool MathCumulativeDistributionNormal(const double x[], const double mu,
                                      const double sigma, const bool tail,
                                      const bool log_mode, double result[]) ;

bool MathCumulativeDistributionNormal(const double x[], const double mu,
                                      const double sigma, double result[]) ;

double MathQuantileNormal(const double probability, const double mu,
                          const double sigma, const bool tail,
                          const bool log_mode, int &error_code) ;

double MathQuantileNormal(const double probability, const double mu,
                          const double sigma, int &error_code) ;

bool MathQuantileNormal(const double probability[], const double mu,
                        const double sigma, const bool tail,
                        const bool log_mode, double result[]) ;

bool MathQuantileNormal(const double probability[], const double mu,
                        const double sigma, double result[]) ;

double MathRandomNormal(const double mu, const double sigma, int &error_code) ;

bool MathRandomNormal(const double mu, const double sigma, const int data_count,
                      double result[]) ;

bool MathMomentsNormal(const double mu, const double sigma, double &mean,
                       double &variance, double &skewness, double &kurtosis,
                       int &error_code) ;

#endif
