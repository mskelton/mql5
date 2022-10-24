#ifndef FASTTRANSFORMS_H
#define FASTTRANSFORMS_H

#include "alglibinternal.mqh"
#include "complex.mqh"

class CFastFourierTransform {
public:
  CFastFourierTransform(void);
  ~CFastFourierTransform(void);

  static void FFTC1D(al_complex a[], const int n);
  static void FFTC1DInv(al_complex a[], const int n);
  static void FFTR1D(double a[], const int n, al_complex f[]);
  static void FFTR1DInv(al_complex f[], const int n, double a[]);
  static void FFTR1DInternalEven(double a[], const int n, double buf[],
                                 CFtPlan &plan);
  static void FFTR1DInvInternalEven(double a[], const int n, double buf[],
                                    CFtPlan &plan);
};

class CConv {
public:
  CConv(void);
  ~CConv(void);

  static void ConvC1D(al_complex a[], const int m, al_complex b[], const int n,
                      al_complex r[]);
  static void ConvC1DInv(al_complex a[], const int m, al_complex b[],
                         const int n, al_complex r[]);
  static void ConvC1DCircular(al_complex s[], const int m, al_complex r[],
                              const int n, al_complex c[]);
  static void ConvC1DCircularInv(al_complex a[], const int m, al_complex b[],
                                 const int n, al_complex r[]);
  static void ConvR1D(double a[], const int m, double b[], const int n,
                      double r[]);
  static void ConvR1DInv(double a[], const int m, double b[], const int n,
                         double r[]);
  static void ConvR1DCircular(double s[], const int m, double r[], const int n,
                              double c[]);
  static void ConvR1DCircularInv(double a[], const int m, double b[],
                                 const int n, double r[]);
  static void ConvC1DX(al_complex a[], const int m, al_complex b[], const int n,
                       const bool circular, int alg, int q, al_complex r[]);
  static void ConvR1DX(double a[], const int m, double b[], const int n,
                       const bool circular, int alg, int q, double r[]);
};

class CCorr {
public:
  CCorr(void);
  ~CCorr(void);

  static void CorrC1D(al_complex signal[], const int n, al_complex pattern[],
                      const int m, al_complex r[]);
  static void CorrC1DCircular(al_complex signal[], const int m,
                              al_complex pattern[], const int n,
                              al_complex c[]);
  static void CorrR1D(double signal[], const int n, double pattern[],
                      const int m, double r[]);
  static void CorrR1DCircular(double signal[], const int m, double pattern[],
                              const int n, double c[]);
};

class CFastHartleyTransform {
public:
  CFastHartleyTransform(void);
  ~CFastHartleyTransform(void);

  static void FHTR1D(double a[], const int n);
  static void FHTR1DInv(double a[], const int n);
};

#endif
