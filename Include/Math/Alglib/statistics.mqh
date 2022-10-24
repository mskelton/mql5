#ifndef STATISTICS_H
#define STATISTICS_H

#include "alglibinternal.mqh"
#include "ap.mqh"
#include "linalg.mqh"
#include "specialfunctions.mqh"

class CBaseStat {
public:
  CBaseStat(void);
  ~CBaseStat(void);

  static bool SampleMoments(const double cx[], const int n, double &mean,
                            double &variance, double &skewness,
                            double &kurtosis);
  static bool SampleAdev(const double cx[], const int n, double &adev);
  static bool SampleMedian(const double cx[], const int n, double &median);
  static bool SamplePercentile(const double cx[], const int n, const double p,
                               double &v);

  static double Cov2(const double cx[], const double cy[], const int n);
  static double PearsonCorr2(const double cx[], const double cy[],
                             const int n);
  static double SpearmanCorr2(const double cx[], const double cy[],
                              const int n);
  static bool CovM(const CMatrixDouble &cx, const int n, const int m,
                   CMatrixDouble &c);
  static bool PearsonCorrM(const CMatrixDouble &cx, const int n, const int m,
                           CMatrixDouble &c);
  static bool SpearmanCorrM(const CMatrixDouble &cx, const int n, const int m,
                            CMatrixDouble &c);
  static bool CovM2(const CMatrixDouble &cx, const CMatrixDouble &cy,
                    const int n, const int m1, const int m2, CMatrixDouble &c);
  static bool PearsonCorrM2(const CMatrixDouble &cx, const CMatrixDouble &cy,
                            const int n, const int m1, const int m2,
                            CMatrixDouble &c);
  static bool SpearmanCorrM2(const CMatrixDouble &cx, const CMatrixDouble &cy,
                             const int n, const int m1, const int m2,
                             CMatrixDouble &c);

  static double PearsonCorrelation(const double x[], const double y[],
                                   const int n);
  static double SpearmanRankCorrelation(const double x[], const double y[],
                                        const int n);
};


















class CCorrTests {
private:
  static double SpearmanTail5(const double s);
  static double SpearmanTail6(const double s);
  static double SpearmanTail7(const double s);
  static double SpearmanTail8(const double s);
  static double SpearmanTail9(const double s);
  static double SpearmanTail(const double t, const int n);

public:
  CCorrTests(void);
  ~CCorrTests(void);

  static void PearsonCorrSignific(const double r, const int n,
                                  double &bothTails, double &leftTail,
                                  double &rightTail);
  static void SpearmanRankCorrSignific(const double r, const int n,
                                       double &bothTails, double &leftTail,
                                       double &rightTail);
};











class CJarqueBera {
private:
  static bool JarqueBeraStat(const double x[], const int n, double &s);
  static double JarqueBeraApprox(const int n, const double s);
  static void JBCheb(double x, double c, double &tj, double &tj1, double &r);
  static double JBTbl5(const double s);
  static double JBTbl6(const double s);
  static double JBTbl7(const double s);
  static double JBTbl8(const double s);
  static double JBTbl9(const double s);
  static double JBTbl10(const double s);
  static double JBTbl11(const double s);
  static double JBTbl12(const double s);
  static double JBTbl13(const double s);
  static double JBTbl14(const double s);
  static double JBTbl15(const double s);
  static double JBTbl16(const double s);
  static double JBTbl17(const double s);
  static double JBTbl18(const double s);
  static double JBTbl19(const double s);
  static double JBTbl20(const double s);
  static double JBTbl30(const double s);
  static double JBTbl50(const double s);
  static double JBTbl65(const double s);
  static double JBTbl100(const double s);
  static double JBTbl130(const double s);
  static double JBTbl200(const double s);
  static double JBTbl301(const double s);
  static double JBTbl501(const double s);
  static double JBTbl701(const double s);
  static double JBTbl1401(const double s);

public:
  CJarqueBera(void);
  ~CJarqueBera(void);

  static bool JarqueBeraTest(const double x[], const int n, double &p);
};

































class CMannWhitneyU {
private:
  static void UCheb(const double x, const double c, double &tj, double &tj1,
                    double &r);
  static double UThreePointInterpolate(const double p1, const double p2,
                                       const double p3, const int n);
  static double USigma(double s, const int n1, const int n2);
  static double USigma000(const int n1, const int n2);
  static double USigma075(const int n1, const int n2);
  static double USigma150(const int n1, const int n2);
  static double USigma225(const int n1, const int n2);
  static double USigma300(const int n1, const int n2);
  static double USigma333(const int n1, const int n2);
  static double USigma367(const int n1, const int n2);
  static double USigma400(const int n1, const int n2);
  static double UTbln5n5(const double s);
  static double UTbln5n6(const double s);
  static double UTbln5n7(const double s);
  static double UTbln5n8(const double s);
  static double UTbln5n9(const double s);
  static double UTbln5n10(const double s);
  static double UTbln5n11(const double s);
  static double UTbln5n12(const double s);
  static double UTbln5n13(const double s);
  static double UTbln5n14(const double s);
  static double UTbln5n15(const double s);
  static double UTbln5n16(const double s);
  static double UTbln5n17(const double s);
  static double UTbln5n18(const double s);
  static double UTbln5n19(const double s);
  static double UTbln5n20(const double s);
  static double UTbln5n21(const double s);
  static double UTbln5n22(const double s);
  static double UTbln5n23(const double s);
  static double UTbln5n24(const double s);
  static double UTbln5n25(const double s);
  static double UTbln5n26(const double s);
  static double UTbln5n27(const double s);
  static double UTbln5n28(const double s);
  static double UTbln5n29(const double s);
  static double UTbln5n30(const double s);
  static double UTbln5n100(const double s);
  static double UTbln6n6(const double s);
  static double UTbln6n7(const double s);
  static double UTbln6n8(const double s);
  static double UTbln6n9(const double s);
  static double UTbln6n10(const double s);
  static double UTbln6n11(const double s);
  static double UTbln6n12(const double s);
  static double UTbln6n13(const double s);
  static double UTbln6n14(const double s);
  static double UTbln6n15(const double s);
  static double UTbln6n30(const double s);
  static double UTbln6n100(const double s);
  static double UTbln7n7(const double s);
  static double UTbln7n8(const double s);
  static double UTbln7n9(const double s);
  static double UTbln7n10(const double s);
  static double UTbln7n11(const double s);
  static double UTbln7n12(const double s);
  static double UTbln7n13(const double s);
  static double UTbln7n14(const double s);
  static double UTbln7n15(const double s);
  static double UTbln7n30(const double s);
  static double UTbln7n100(const double s);
  static double UTbln8n8(const double s);
  static double UTbln8n9(const double s);
  static double UTbln8n10(const double s);
  static double UTbln8n11(const double s);
  static double UTbln8n12(const double s);
  static double UTbln8n13(const double s);
  static double UTbln8n14(const double s);
  static double UTbln8n15(const double s);
  static double UTbln8n30(const double s);
  static double UTbln8n100(const double s);
  static double UTbln9n9(const double s);
  static double UTbln9n10(const double s);
  static double UTbln9n11(const double s);
  static double UTbln9n12(const double s);
  static double UTbln9n13(const double s);
  static double UTbln9n14(const double s);
  static double UTbln9n15(const double s);
  static double UTbln9n30(const double s);
  static double UTbln9n100(const double s);
  static double UTbln10n10(const double s);
  static double UTbln10n11(const double s);
  static double UTbln10n12(const double s);
  static double UTbln10n13(const double s);
  static double UTbln10n14(const double s);
  static double UTbln10n15(const double s);
  static double UTbln10n30(const double s);
  static double UTbln10n100(const double s);
  static double UTbln11n11(const double s);
  static double UTbln11n12(const double s);
  static double UTbln11n13(const double s);
  static double UTbln11n14(const double s);
  static double UTbln11n15(const double s);
  static double UTbln11n30(const double s);
  static double UTbln11n100(const double s);
  static double UTbln12n12(const double s);
  static double UTbln12n13(const double s);
  static double UTbln12n14(const double s);
  static double UTbln12n15(const double s);
  static double UTbln12n30(const double s);
  static double UTbln12n100(const double s);
  static double UTbln13n13(const double s);
  static double UTbln13n14(const double s);
  static double UTbln13n15(const double s);
  static double UTbln13n30(const double s);
  static double UTbln13n100(const double s);
  static double UTbln14n14(const double s);
  static double UTbln14n15(const double s);
  static double UTbln14n30(const double s);
  static double UTbln14n100(const double s);

public:
  CMannWhitneyU(void);
  ~CMannWhitneyU(void);

  static void CMannWhitneyUTest(const double x[], const int n,
                                const double y[], const int m,
                                double &bothTails, double &leftTail,
                                double &rightTail);
};


















































































































class CSignTest {
public:
  CSignTest(void);
  ~CSignTest(void);

  static void OneSampleSignTest(const double x[], const int n,
                                const double median, double &bothTails,
                                double &leftTail, double &rightTail);
};




class CStudentTests {
public:
  CStudentTests(void);
  ~CStudentTests(void);

  static void StudentTest1(const double x[], const int n, const double mean,
                           double &bothTails, double &leftTail,
                           double &rightTail);
  static void StudentTest2(const double x[], const int n, const double y[],
                           const int m, double &bothTails, double &leftTail,
                           double &rightTail);
  static void UnequalVarianceTest(const double x[], const int n,
                                  const double y[], const int m,
                                  double &bothTails, double &leftTail,
                                  double &rightTail);
};






class CVarianceTests {
public:
  CVarianceTests(void);
  ~CVarianceTests(void);

  static void FTest(const double x[], const int n, const double y[],
                    const int m, double &bothTails, double &leftTail,
                    double &rightTail);
  static void OneSampleVarianceTest(const double x[], const int n,
                                    const double variance, double &bothTails,
                                    double &leftTail, double &rightTail);
};




static void

class CWilcoxonSignedRank {
private:
  static void WCheb(const double x, const double c, double &tj, double &tj1,
                    double &r);

  static double WSigma(const double s, const int n);
  static double W5(const double s);
  static double W6(const double s);
  static double W7(const double s);
  static double W8(const double s);
  static double W9(const double s);
  static double W10(const double s);
  static double W11(const double s);
  static double W12(const double s);
  static double W13(const double s);
  static double W14(const double s);
  static double W15(const double s);
  static double W16(const double s);
  static double W17(const double s);
  static double W18(const double s);
  static double W19(const double s);
  static double W20(const double s);
  static double W21(const double s);
  static double W22(const double s);
  static double W23(const double s);
  static double W24(const double s);
  static double W25(const double s);
  static double W26(const double s);
  static double W27(const double s);
  static double W28(const double s);
  static double W29(const double s);
  static double W30(const double s);
  static double W40(const double s);
  static double W60(const double s);
  static double W120(const double s);
  static double W200(const double s);

public:
  CWilcoxonSignedRank(void);
  ~CWilcoxonSignedRank(void);

  static void WilcoxonSignedRankTest(const double cx[], const int n,
                                     const double e, double &bothTails,
                                     double &leftTail, double &rightTail);
};




































#endif
