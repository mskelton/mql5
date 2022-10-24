#ifndef MEMBERSHIPFUNCTION_H
#define MEMBERSHIPFUNCTION_H

#include <Arrays/List.mqh>

enum MfCompositionType { MinMF, MaxMF, ProdMF, SumMF };

class IMembershipFunction : public CObject {
public:
  virtual double GetValue(const double x);
};

class CNormalCombinationMembershipFunction : public IMembershipFunction {
private:
  double m_b1;
  double m_sigma1;
  double m_b2;
  double m_sigma2;

public:
  CNormalCombinationMembershipFunction(void);
  CNormalCombinationMembershipFunction(const double b1, const double sigma1,
                                       const double b2, const double sigma2);
  ~CNormalCombinationMembershipFunction(void);

  void B1(const double b1);
  double B1(void);
  void Sigma1(const double sigma1);
  double Sigma1(void);
  void B2(const double b2);
  double B2(void);
  void Sigma2(const double sigma2);
  double Sigma2(void);

  double GetValue(const double x);
};

class CGeneralizedBellShapedMembershipFunction : public IMembershipFunction {
private:
  double m_a;
  double m_b;
  double m_c;

public:
  CGeneralizedBellShapedMembershipFunction(void);
  CGeneralizedBellShapedMembershipFunction(const double a, const double b,
                                           const double c);
  ~CGeneralizedBellShapedMembershipFunction(void);

  void A(const double a);
  double A(void);
  void B(const double b);
  double B(void);
  void C(const double c);
  double C(void);

  double GetValue(const double x);
};

class CS_ShapedMembershipFunction : public IMembershipFunction {
private:
  double m_a;
  double m_b;

public:
  CS_ShapedMembershipFunction(void);
  CS_ShapedMembershipFunction(const double a, const double b);
  ~CS_ShapedMembershipFunction(void);

  void A(const double a);
  double A(void);
  void B(const double b);
  double B(void);

  double GetValue(const double x);
};

class CZ_ShapedMembershipFunction : public IMembershipFunction {
private:
  double m_a;
  double m_b;

public:
  CZ_ShapedMembershipFunction(void);
  CZ_ShapedMembershipFunction(const double a, const double b);
  ~CZ_ShapedMembershipFunction(void);

  void A(const double a);
  double A(void);
  void B(const double b);
  double B(void);

  double GetValue(const double x);
};

class CP_ShapedMembershipFunction : public IMembershipFunction {
private:
  double m_a;
  double m_d;
  double m_b;
  double m_c;

public:
  CP_ShapedMembershipFunction(void);
  CP_ShapedMembershipFunction(const double a, const double b, const double c,
                              const double d);
  ~CP_ShapedMembershipFunction(void);

  void A(const double a);
  double A(void);
  void D(const double d);
  double D(void);
  void B(const double b);
  double B(void);
  void C(const double c);
  double C(void);

  double GetValue(const double x);
};

class CSigmoidalMembershipFunction : public IMembershipFunction {
private:
  double m_a;
  double m_c;

public:
  CSigmoidalMembershipFunction(void);
  CSigmoidalMembershipFunction(const double a, const double c);
  ~CSigmoidalMembershipFunction(void);

  void A(const double a);
  double A(void);
  void C(const double c);
  double C(void);

  double GetValue(const double x);
};

class CProductTwoSigmoidalMembershipFunctions : public IMembershipFunction {
private:
  double m_a1;
  double m_c1;
  double m_a2;
  double m_c2;

public:
  CProductTwoSigmoidalMembershipFunctions(void);
  CProductTwoSigmoidalMembershipFunctions(const double a1, const double c1,
                                          const double a2, const double c2);
  ~CProductTwoSigmoidalMembershipFunctions(void);

  void A1(const double a1);
  double A1(void);
  void C1(const double c1);
  double C1(void);
  void A2(const double a2);
  double A2(void);
  void C2(const double c2);
  double C2(void);

  double GetValue(const double x);
};

class CDifferencTwoSigmoidalMembershipFunction : public IMembershipFunction {
private:
  double m_a1;
  double m_c1;
  double m_a2;
  double m_c2;

public:
  CDifferencTwoSigmoidalMembershipFunction(void);
  CDifferencTwoSigmoidalMembershipFunction(const double a1, const double c1,
                                           const double a2, const double c2);
  ~CDifferencTwoSigmoidalMembershipFunction(void);

  void A1(const double a1);
  double A1(void);
  void C1(const double c1);
  double C1(void);
  void A2(const double a2);
  double A2(void);
  void C2(const double c2);
  double C2(void);

  double GetValue(const double x);
};

class CTrapezoidMembershipFunction : public IMembershipFunction {
private:
  double m_x1;
  double m_x2;
  double m_x3;
  double m_x4;

public:
  CTrapezoidMembershipFunction(void);
  CTrapezoidMembershipFunction(const double x1, const double x2,
                               const double x3, const double x4);
  ~CTrapezoidMembershipFunction(void);

  void X1(const double x);
  double X1(void);
  void X2(const double x);
  double X2(void);
  void X3(const double x);
  double X3(void);
  void X4(const double x);
  double X4(void);

  double GetValue(const double x);
};

class CNormalMembershipFunction : public IMembershipFunction {
private:
  double m_b;
  double m_sigma;

public:
  CNormalMembershipFunction(void);
  CNormalMembershipFunction(const double b, const double sigma);
  ~CNormalMembershipFunction(void);

  void B(const double b);
  double B(void);
  void Sigma(const double sigma);
  double Sigma(void);

  double GetValue(const double x);
};

class CTriangularMembershipFunction : public IMembershipFunction {
private:
  double m_x1;
  double m_x2;
  double m_x3;

public:
  CTriangularMembershipFunction(void);
  CTriangularMembershipFunction(const double x1, const double x2,
                                const double x3);
  ~CTriangularMembershipFunction(void);

  void X1(const double x);
  double X1(void);
  void X2(const double x);
  double X2(void);
  void X3(const double x);
  double X3(void);

  CNormalMembershipFunction *ToNormalMF(void);

  double GetValue(const double x);
};

class CConstantMembershipFunction : public IMembershipFunction {
private:
  double m_constValue;

public:
  CConstantMembershipFunction();
  CConstantMembershipFunction(const double constValue);
  ~CConstantMembershipFunction();

  double GetValue(const double x);
};

class CCompositeMembershipFunction : public IMembershipFunction {
private:
  CList *m_mfs;
  MfCompositionType m_composType;

public:
  CCompositeMembershipFunction(MfCompositionType composType);
  CCompositeMembershipFunction(MfCompositionType composType,
                               IMembershipFunction *mf1,
                               IMembershipFunction *mf2);
  CCompositeMembershipFunction(MfCompositionType composType, CList *mfs);
  ~CCompositeMembershipFunction(void);

  CList *MembershipFunctions(void);
  MfCompositionType CompositionType(void);
  void CompositionType(MfCompositionType value);

  double GetValue(double const x);

private:
  double Compose(const double val1, const double val2);
};

#endif
