#ifndef AP_H
#define AP_H

#include "bitconvert.mqh"
#include "complex.mqh"
#include "matrix.mqh"
#include <Object.mqh>

struct RCommState {
public:
  int stage;
  int ia;
  bool ba;
  double ra;
  al_complex ca;

  RCommState(void);
  ~RCommState(void);
  ;
  void Copy(RCommState &obj);
};

class CAp {
public:
  static bool exception_happened;

  CAp(void);
  ~CAp(void);

  static int Len(const int a[]);
  static int Len(const bool a[]);
  static int Len(const double a[]);
  static int Len(const al_complex a[]);

  static int Rows(const CMatrixInt &a);
  static int Rows(const CMatrixDouble &a);
  static int Rows(const CMatrixComplex &a);

  static int Cols(const CMatrixInt &a);
  static int Cols(const CMatrixDouble &a);
  static int Cols(const CMatrixComplex &a);

  static void Swap(int &a, int &b);
  static void Swap(double &a, double &b);
  static void Swap(al_complex &a, al_complex &b);
  static void Swap(bool a[], bool b[]);
  static void Swap(int a[], int b[]);
  static void Swap(double a[], double b[]);
  static void Swap(al_complex a[], al_complex b[]);
  static void Swap(CMatrixInt &a, CMatrixInt &b);
  static void Swap(CMatrixDouble &a, CMatrixDouble &b);
  static void Swap(CMatrixComplex &a, CMatrixComplex &b);

  static bool Assert(const bool cond);
  static bool Assert(const bool cond, const string s);

  static int ThresHoldToDPS(const double threshold);

  static string StringJoin(const string sep, const string a[]);

  static string Format(const al_complex &a, const int dps);
  static string Format(const bool a[]);
  static string Format(const int a[]);
  static string Format(const double a[], const int dps);
  static string Format(const al_complex a[], const int dps);
  static string FormatB(const CMatrixInt &a);
  static string Format(const CMatrixInt &a);
  static string Format(const CMatrixDouble &a, const int dps);
  static string Format(const CMatrixComplex &a, const int dps);

  static bool IsSymmetric(const CMatrixDouble &a);
  static bool IsHermitian(const CMatrixComplex &a);
  static bool ForceSymmetric(CMatrixDouble &a);
  static bool ForceHermitian(CMatrixComplex &a);
};

class CHighQualityRandState {
public:
  int m_s1;
  int m_s2;
  double m_v;
  int m_magicv;

  CHighQualityRandState(void);
  ~CHighQualityRandState(void);
};

class CHighQualityRandStateShell {
private:
  CHighQualityRandState m_innerobj;

public:
  CHighQualityRandStateShell(void);
  CHighQualityRandStateShell(CHighQualityRandState &obj);
  ~CHighQualityRandStateShell(void);

  CHighQualityRandState *GetInnerObj(void);
};

class CHighQualityRand {
private:
  static int HQRndIntegerBase(CHighQualityRandState &state);

public:
  static const int m_HQRndMax;
  static const int m_HQRndM1;
  static const int m_HQRndM2;
  static const int m_HQRndMagic;

  CHighQualityRand(void);
  ~CHighQualityRand(void);

  static void HQRndRandomize(CHighQualityRandState &state);
  static void HQRndSeed(const int s1, const int s2,
                        CHighQualityRandState &state);
  static double HQRndUniformR(CHighQualityRandState &state);
  static int HQRndUniformI(CHighQualityRandState &state, const int n);
  static double HQRndNormal(CHighQualityRandState &state);
  static void HQRndUnit2(CHighQualityRandState &state, double &x, double &y);
  static void HQRndNormal2(CHighQualityRandState &state, double &x1,
                           double &x2);
  static double HQRndExponential(CHighQualityRandState &state,
                                 const double lambdav);
};

class CMath {
public:
  static bool m_first_call;
  static double m_last;
  static CHighQualityRandState m_state;

  static const double m_machineepsilon;
  static const double m_maxrealnumber;
  static const double m_minrealnumber;

  CMath(void);
  ~CMath(void);

  static bool IsFinite(const double d);
  static double RandomReal(void);
  static int RandomInteger(const int n);
  static double Sqr(const double x);
  static double AbsComplex(const al_complex &z);
  static double AbsComplex(const double r);
  static al_complex Conj(const al_complex &z);
  static al_complex Csqr(const al_complex &z);
};

char _sixbits2char_tbl[] = ;
class CSerializer {
