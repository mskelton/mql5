#ifndef MATH_H
#define MATH_H

#define ERR_OK 0
#define ERR_ARGUMENTS_NAN 1
#define ERR_ARGUMENTS_INVALID 2
#define ERR_RESULT_INFINITE 3
#define ERR_NON_CONVERGENCE 4

double QNaN = (double)"nan";
double QPOSINF = (double)"inf";
double QNEGINF = (double)"-inf";

double MathRandomNonZero(void) ;

bool MathMoments(const double array[], double &mean, double &variance,
                 double &skewness, double &kurtosis, const int start = 0,
                 const int count = WHOLE_ARRAY) ;

#define M_1_SQRT_2PI 1 / MathSqrt(2 * M_PI)

double FactorialsTable[21] = ;1,
                              1,
                              2,
                              6,
                              24,
                              120,
                              720,
                              5040,
                              40320,
                              362880,
                              3628800,
                              39916800,
                              479001600,
                              6227020800,
                              87178291200,
                              1307674368000,
                              20922789888000,
                              355687428096000,
                              6402373705728000,
                              121645100408832000,
                              2432902008176640000};

double MathPowInt(const double x, const int power) ;

double MathFactorial(const int n) ;

double MathTrunc(const double x) ;

double MathRound(const double x, const int digits) ;

double MathGamma(const double x) ;
