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

double MathPowInt(const double x, const int power) ;

double MathFactorial(const int n) ;

double MathTrunc(const double x) ;

double MathRound(const double x, const int digits) ;

double MathGamma(const double x) ;

double MathGammaLog(const double x) ;

double MathBeta(const double a, const double b) ;

double MathBetaLog(const double a, const double b) ;

double MathBetaIncomplete(const double x, const double p, const double q) ;

double MathGammaIncomplete(double x, double alpha) ;

long MathBinomialCoefficient(const int n, const int k) ;

double MathBinomialCoefficientLog(const int n, const int k) ;

double MathBinomialCoefficientLog(const double n, const double k) ;

double MathHypergeometric2F2(const double a, const double b, const double c,
                             const double d, const double z) ;

double TailLog0(const bool tail, const bool log_mode) ;

double TailLog1(const bool tail, const bool log_mode) ;

double TailLogValue(const double value, const bool tail, const bool log_mode) ;

double TailLogProbability(const double probability, const bool tail,
                          const bool log_mode) ;

bool MathSequence(const double from, const double to, const double step,
                  double result[]) ;

bool MathSequence(const int from, const int to, const int step, int result[]) ;

bool MathSequenceByCount(const double from, const double to, const int count,
                         double result[]) ;

bool MathSequenceByCount(const int from, const int to, const int count,
                         int result[]) ;

bool MathReplicate(const double array[], const int count, double result[]) ;

bool MathReplicate(const int array[], const int count, int result[]) ;

bool MathReverse(const double array[], double result[]) ;

bool MathReverse(const int array[], int result[]) ;

bool MathReverse(double array[]) ;

bool MathReverse(int array[]) ;

bool MathIdentical(const double array1[], const double array2[]) ;

bool MathIdentical(const int array1[], const int array2[]) ;

bool MathUnique(const double array[], double result[]) ;

bool MathUnique(const int array[], int result[]) ;

void MathQuickSortAscending(double array[], int indices[], int first,
                            int last) ;

void MathQuickSortDescending(double array[], int indices[], int first,
                             int last) ;

void MathQuickSort(double array[], int indices[], int first, int last,
                   int mode) ;

bool MathOrder(const double array[], int result[]) ;

bool MathOrder(const int array[], int result[]) ;

bool MathBitwiseNot(const int array[], int result[]) ;

bool MathBitwiseNot(int array[]) ;

bool MathBitwiseAnd(const int array1[], const int array2[], int result[]) ;

bool MathBitwiseOr(const int array1[], const int array2[], int result[]) ;

bool MathBitwiseXor(const int array1[], const int array2[], int result[]) ;

bool MathBitwiseShiftL(const int array[], const int n, int result[]) ;

bool MathBitwiseShiftL(int array[], const int n) ;

bool MathBitwiseShiftR(const int array[], const int n, int result[]) ;

bool MathBitwiseShiftR(int array[], const int n) ;

bool MathCumulativeSum(const double array[], double result[]) ;

bool MathCumulativeSum(double array[]) ;

bool MathCumulativeProduct(const double array[], double result[]) ;

bool MathCumulativeProduct(double array[]) ;

bool MathCumulativeMin(const double array[], double result[]) ;

bool MathCumulativeMin(double array[]) ;

bool MathCumulativeMax(const double array[], double result[]) ;

bool MathCumulativeMax(double array[]) ;

bool MathSin(const double array[], double result[]) ;

bool MathSin(double array[]) ;

bool MathCos(const double array[], double result[]) ;

bool MathCos(double array[]) ;

bool MathTan(const double array[], double result[]) ;

bool MathTan(double array[]) ;

bool MathArcsin(const double array[], double result[]) ;

bool MathArcsin(double array[]) ;

bool MathArccos(const double array[], double result[]) ;

bool MathArccos(double array[]) ;

bool MathArctan(const double array[], double result[]) ;

bool MathArctan(double array[]) ;

bool MathSinPi(const double array[], double result[]) ;

bool MathSinPi(double array[]) ;

bool MathCosPi(const double array[], double result[]) ;

bool MathCosPi(double array[]) ;

bool MathTanPi(const double array[], double result[]) ;

bool MathTanPi(double array[]) ;

bool MathAbs(const double array[], double result[]) ;

bool MathAbs(double array[]) ;

bool MathCeil(const double array[], double result[]) ;

bool MathCeil(double array[]) ;

bool MathFloor(const double array[], double result[]) ;

bool MathFloor(double array[]) ;

bool MathTrunc(const double array[], double result[]) ;

bool MathTrunc(double array[]) ;

bool MathSqrt(const double array[], double result[]) ;

bool MathSqrt(double array[]) ;

bool MathExp(const double array[], double result[]) ;

bool MathExp(double array[]) ;

bool MathPow(const double array[], const double power, double result[]) ;

bool MathPow(double array[], const double power) ;

bool MathLog(const double array[], double result[]) ;

bool MathLog(double array[]) ;

bool MathLog(const double array[], const double base, double result[]) ;

bool MathLog(double array[], const double base) ;

bool MathLog2(const double array[], double result[]) ;

bool MathLog2(double array[]) ;

bool MathLog10(const double array[], double result[]) ;

bool MathLog10(double array[]) ;

bool MathArctan2(const double y[], const double x[], double result[]) ;

bool MathRound(const double array[], int digits, double result[]) ;

bool MathRound(double array[], int digits) ;

bool MathDifference(const double array[], const int lag, double result[]) ;

bool MathDifference(const int array[], const int lag, int result[]) ;

bool MathDifference(const double array[], const int lag, const int differences,
                    double result[]) ;

bool MathDifference(const int array[], const int lag, const int differences,
                    int result[]) ;

bool MathSample(const double array[], const int count, double result[]) ;

bool MathSample(const int array[], const int count, int result[]) ;

bool MathSample(const double array[], const int count, const bool replace,
                double result[]) ;

bool MathSample(const int array[], const int count, const bool replace,
                int result[]) ;

bool MathSample(const double array[], double probabilities[], const int count,
                double result[]) ;

bool MathSample(const int array[], double probabilities[], const int count,
                int result[]) ;

bool MathSample(const double array[], double probabilities[], const int count,
                const bool replace, double result[]) ;

bool MathSample(const int array[], double probabilities[], const int count,
                const bool replace, int result[]) ;

bool MathTukeySummary(const double array[], const bool removeNAN,
                      double &minimum, double &lower_hinge, double &median,
                      double &upper_hinge, double &maximum) ;

bool MathRange(const double array[], double &min, double &max) ;

double MathMin(const double array[]) ;

double MathMax(const double array[]) ;

double MathSum(const double array[]) ;

double MathProduct(const double array[]) ;

double MathStandardDeviation(const double array[]) ;

double MathAverageDeviation(const double array[]) ;

double MathMedian(double array[]) ;

double MathMean(const double array[]) ;

double MathVariance(const double array[]) ;

double MathSkewness(const double array[]) ;

double MathKurtosis(const double array[]) ;

bool MathLog1p(const double array[], double result[]) ;

bool MathLog1p(double array[]) ;

bool MathExpm1(const double array[], double result[]) ;

bool MathExpm1(double array[]) ;

bool MathSinh(const double array[], double result[]) ;

bool MathSinh(double array[]) ;

bool MathCosh(const double array[], double result[]) ;

bool MathCosh(double array[]) ;

bool MathTanh(const double array[], double result[]) ;

bool MathTanh(double array[]) ;

bool MathArcsinh(const double array[], double result[]) ;

bool MathArcsinh(double array[]) ;

bool MathArccosh(const double array[], double result[]) ;

bool MathArccosh(double array[]) ;

bool MathArctanh(const double array[], double result[]) ;

bool MathArctanh(double array[]) ;

double MathSignif(const double x, const int digits) ;

bool MathSignif(const double array[], int digits, double result[]) ;

bool MathSignif(double array[], int digits) ;

bool MathRank(const double array[], double rank[]) ;

bool MathRank(const int array[], double rank[]) ;

bool MathCorrelationPearson(const double array1[], const double array2[],
                            double &r) ;

bool MathCorrelationPearson(const int array1[], const int array2[],
                            double &r) ;

bool MathCorrelationSpearman(const double array1[], const double array2[],
                             double &r) ;

bool MathCorrelationSpearman(const int array1[], const int array2[],
                             double &r) ;

bool MathCorrelationKendall(const double array1[], const double array2[],
                            double &tau) ;

bool MathCorrelationKendall(const int array1[], const int array2[],
                            double &tau) ;

bool MathQuantile(const double array[], const double probs[],
                  double quantile[]) ;

bool MathProbabilityDensityEmpirical(const double array[], const int count,
                                     double x[], double pdf[]) ;

bool MathCumulativeDistributionEmpirical(const double array[], const int count,
                                         double x[], double cdf[]) ;

#endif
