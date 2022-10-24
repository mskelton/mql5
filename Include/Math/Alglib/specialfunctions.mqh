#ifndef SPECIALFUNCTIONS_H
#define SPECIALFUNCTIONS_H

#include "alglibinternal.mqh"
#include "ap.mqh"

class CGammaFunc {
private:
  static double GammaStirlFunc(double x);

public:
  CGammaFunc(void);
  ~CGammaFunc(void);
  static double GammaFunc(double x);
  static double LnGamma(double x, double &sgngam);
};

class CNormalDistr {
public:
  CNormalDistr(void);
  ~CNormalDistr(void);

  static double ErrorFunction(double x);
  static double ErrorFunctionC(double x);
  static double NormalDistribution(const double x);
  static double InvErF(const double e);
  static double InvNormalDistribution(double y0);
};

class CIncGammaF {
public:
  CIncGammaF(void);
  ~CIncGammaF(void);

  static double IncompleteGamma(const double a, const double x);
  static double IncompleteGammaC(const double a, const double x);
  static double InvIncompleteGammaC(const double a, const double y0);
};

class CAiryF {
public:
  CAiryF(void);
  ~CAiryF(void);

  static void Airy(const double x, double &ai, double &aip, double &bi,
                   double &bip);
};

class CBessel {
private:
  static void BesselMFirstCheb(const double c, double &b0, double &b1,
                               double &b2);
  static void BesselMNextCheb(const double x, const double c, double &b0,
                              double &b1, double &b2);
  static void BesselM1FirstCheb(const double c, double &b0, double &b1,
                                double &b2);
  static void BesselM1NextCheb(const double x, const double c, double &b0,
                               double &b1, double &b2);
  static void BesselAsympt0(const double x, double &pzero, double &qzero);
  static void BesselAsympt1(const double x, double &pzero, double &qzero);

public:
  CBessel(void);
  ~CBessel(void);

  static double BesselJ0(double x);
  static double BesselJ1(double x);
  static double BesselJN(int n, double x);
  static double BesselY0(double x);
  static double BesselY1(double x);
  static double BesselYN(int n, double x);
  static double BesselI0(double x);
  static double BesselI1(double x);
  static double BesselK0(double x);
  static double BesselK1(double x);
  static double BesselKN(int nn, double x);
};

class CBetaF {
public:
  CBetaF(void);
  ~CBetaF(void);

  static double Beta(const double a, const double b);
};

class CIncBetaF {
private:
  static double IncompleteBetaFracExpans(const double a, const double b,
                                         const double x, const double big,
                                         const double biginv);
  static double IncompleteBetaFracExpans2(const double a, const double b,
                                          const double x, const double big,
                                          const double biginv);
  static double IncompleteBetaPowSeries(const double a, const double b,
                                        const double x, const double maxgam);

public:
  CIncBetaF(void);
  ~CIncBetaF(void);

  static double IncompleteBeta(double a, double b, double x);
  static double InvIncompleteBeta(const double a, double b, double y);
};

class CBinomialDistr {
public:
  CBinomialDistr(void);
  ~CBinomialDistr(void);

  static double BinomialDistribution(const int k, const int n, const double p);
  static double BinomialComplDistribution(const int k, const int n,
                                          const double p);
  static double InvBinomialDistribution(const int k, const int n,
                                        const double y);
};

class CChebyshev {
public:
  CChebyshev(void);
  ~CChebyshev(void);

  static double ChebyshevCalculate(const int r, const int n, const double x);
  static double ChebyshevSum(double c[], const int r, const int n,
                             const double x);
  static void ChebyshevCoefficients(const int n, double c[]);
  static void FromChebyshev(double a[], const int n, double b[]);
};

class CChiSquareDistr {
public:
  CChiSquareDistr(void);
  ~CChiSquareDistr(void);

  static double ChiSquareDistribution(const double v, const double x);
  static double ChiSquareComplDistribution(const double v, const double x);
  static double InvChiSquareDistribution(const double v, const double y);
};

class CDawson {
public:
  CDawson(void);
  ~CDawson(void);

  static double DawsonIntegral(double x);
};

class CElliptic {
public:
  CElliptic(void);
  ~CElliptic(void);

  static double EllipticIntegralK(const double m);
  static double EllipticIntegralKhighPrecision(const double m1);
  static double IncompleteEllipticIntegralK(double phi, const double m);
  static double EllipticIntegralE(double m);
  static double IncompleteEllipticIntegralE(const double phi, const double m);
};

class CExpIntegrals {
public:
  CExpIntegrals(void);
  ~CExpIntegrals(void);

  static double ExponentialIntegralEi(const double x);
  static double ExponentialIntegralEn(const double x, const int n);
};

class CFDistr {
public:
  CFDistr(void);
  ~CFDistr(void);

  static double FDistribution(const int a, const int b, const double x);
  static double FComplDistribution(const int a, const int b, const double x);
  static double InvFDistribution(const int a, const int b, const double y);
};

class CFresnel {
public:
  CFresnel(void);
  ~CFresnel(void);

  static void FresnelIntegral(double x, double &c, double &s);
};

class CHermite {
public:
  CHermite(void);
  ~CHermite(void);

  static double HermiteCalculate(const int n, const double x);
  static double HermiteSum(double c[], const int n, const double x);
  static void HermiteCoefficients(const int n, double c[]);
};

class CJacobianElliptic {
public:
  CJacobianElliptic(void);
  ~CJacobianElliptic(void);

  static void JacobianEllipticFunctions(const double u, const double m,
                                        double &sn, double &cn, double &dn,
                                        double &ph);
};

class CLaguerre {
public:
  CLaguerre(void);
  ~CLaguerre(void);

  static double LaguerreCalculate(const int n, const double x);
  static double LaguerreSum(double c[], const int n, const double x);
  static void LaguerreCoefficients(const int n, double c[]);
};

class CLegendre {
public:
  CLegendre(void);
  ~CLegendre(void);

  static double LegendreCalculate(const int n, const double x);
  static double LegendreSum(double c[], const int n, const double x);
  static void LegendreCoefficients(const int n, double c[]);
};

class CPoissonDistr {
public:
  CPoissonDistr(void);
  ~CPoissonDistr(void);

  static double PoissonDistribution(const int k, const double m);
  static double PoissonComplDistribution(const int k, const double m);
  static double InvPoissonDistribution(const int k, const double y);
};

class CPsiF {
public:
  CPsiF(void);
  ~CPsiF(void);

  static double Psi(double x);
};

class CStudenttDistr {
public:
  CStudenttDistr(void);
  ~CStudenttDistr(void);

  static double StudenttDistribution(const int k, const double t);
  static double InvStudenttDistribution(const int k, double p);
};

class CTrigIntegrals {
private:
  static void ChebIterationShiChi(const double x, const double c, double &b0,
                                  double &b1, double &b2);

public:
  CTrigIntegrals(void);
  ~CTrigIntegrals(void);

  static void SineCosineIntegrals(double x, double &si, double &ci);
  static void HyperbolicSineCosineIntegrals(double x, double &shi, double &chi);
};

#endif
