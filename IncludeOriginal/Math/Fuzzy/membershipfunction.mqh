#ifndef MEMBERSHIPFUNCTION_H
#define MEMBERSHIPFUNCTION_H

#include <Arrays\List.mqh>

enum MfCompositionType { MinMF, MaxMF, ProdMF, SumMF };

class IMembershipFunction : public CObject {
public:
  virtual double GetValue(const double x) = NULL;
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

  void B1(const double b1) {
    m_b1 = b1;
  }
  double B1(void) {
    return (m_b1);
  }
  void Sigma1(const double sigma1) {
    m_sigma1 = sigma1;
  }
  double Sigma1(void) {
    return (m_sigma1);
  }
  void B2(const double b2) {
    m_b2 = b2;
  }
  double B2(void) {
    return (m_b2);
  }
  void Sigma2(const double sigma2) {
    m_sigma2 = sigma2;
  }
  double Sigma2(void) {
    return (m_sigma2);
  }

  double GetValue(const double x);
};

CNormalCombinationMembershipFunction::CNormalCombinationMembershipFunction(
    void) {}

CNormalCombinationMembershipFunction::CNormalCombinationMembershipFunction(
    const double b1, const double sigma1, const double b2,
    const double sigma2) {
  m_b1 = b1;
  m_sigma1 = sigma1;
  m_b2 = b2;
  m_sigma2 = sigma2;
}

CNormalCombinationMembershipFunction::~CNormalCombinationMembershipFunction(
    void) {}

double CNormalCombinationMembershipFunction::GetValue(const double x) {
  if (m_b1 <= m_b2) {
    if (x < m_b1) {

      return (exp((x - m_b1) * (x - m_b1) / (-2.0 * m_sigma1 * m_sigma1)));
    } else if (x > m_b2) {

      return (exp((x - m_b2) * (x - m_b2) / (-2.0 * m_sigma2 * m_sigma2)));
    } else {

      return (1);
    }
  }
  if (m_b1 > m_b2) {
    if (x < m_b2) {

      return (exp((x - m_b1) * (x - m_b1) / (-2.0 * m_sigma1 * m_sigma1)));
    } else if (x > m_b1) {

      return (exp((x - m_b2) * (x - m_b2) / (-2.0 * m_sigma2 * m_sigma2)));
    } else {

      return (exp((x - m_b1) * (x - m_b1) / (-2.0 * m_sigma1 * m_sigma1)) *
              exp((x - m_b2) * (x - m_b2) / (-2.0 * m_sigma2 * m_sigma2)));
    }
  }

  return (m_b1);
}

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

  void A(const double a) {
    m_a = a;
  }
  double A(void) {
    return (m_a);
  }
  void B(const double b) {
    m_b = b;
  }
  double B(void) {
    return (m_b);
  }
  void C(const double c) {
    m_c = c;
  }
  double C(void) {
    return (m_c);
  }

  double GetValue(const double x);
};

CGeneralizedBellShapedMembershipFunction::
    CGeneralizedBellShapedMembershipFunction(void) {}

CGeneralizedBellShapedMembershipFunction::
    CGeneralizedBellShapedMembershipFunction(const double a, const double b,
                                             const double c) {
  m_a = a;
  m_b = b;
  m_c = c;
}

CGeneralizedBellShapedMembershipFunction::
    ~CGeneralizedBellShapedMembershipFunction(void) {}

double CGeneralizedBellShapedMembershipFunction::GetValue(const double x) {

  return (1 / (1 + pow(fabs((x - m_a) / m_c), 2 * m_b)));
}

class CS_ShapedMembershipFunction : public IMembershipFunction {
private:
  double m_a;
  double m_b;

public:
  CS_ShapedMembershipFunction(void);
  CS_ShapedMembershipFunction(const double a, const double b);
  ~CS_ShapedMembershipFunction(void);

  void A(const double a) {
    m_a = a;
  }
  double A(void) {
    return (m_a);
  }
  void B(const double b) {
    m_b = b;
  }
  double B(void) {
    return (m_b);
  }

  double GetValue(const double x);
};

CS_ShapedMembershipFunction::CS_ShapedMembershipFunction(void) {}

CS_ShapedMembershipFunction::CS_ShapedMembershipFunction(const double a,
                                                         const double b) {
  m_a = a;
  m_b = b;
}

CS_ShapedMembershipFunction::~CS_ShapedMembershipFunction(void) {}

double CS_ShapedMembershipFunction::GetValue(const double x) {
  if (x <= m_a) {

    return (0.0);
  } else if (m_a < x && x <= (m_a + m_b) / 2.0) {

    return (2.0 * ((x - m_a) / (m_b - m_a)) * ((x - m_a) / (m_b - m_a)));
  } else if ((m_a + m_b) / 2.0 < x && x < m_b) {

    return (1.0 - 2.0 * ((x - m_b) / (m_b - m_a)) * ((x - m_b) / (m_b - m_a)));
  } else {

    return (1.0);
  }
}

class CZ_ShapedMembershipFunction : public IMembershipFunction {
private:
  double m_a;
  double m_b;

public:
  CZ_ShapedMembershipFunction(void);
  CZ_ShapedMembershipFunction(const double a, const double b);
  ~CZ_ShapedMembershipFunction(void);

  void A(const double a) {
    m_a = a;
  }
  double A(void) {
    return (m_a);
  }
  void B(const double b) {
    m_b = b;
  }
  double B(void) {
    return (m_b);
  }

  double GetValue(const double x);
};

CZ_ShapedMembershipFunction::CZ_ShapedMembershipFunction(void) {}

CZ_ShapedMembershipFunction::CZ_ShapedMembershipFunction(const double a,
                                                         const double b) {
  m_a = a;
  m_b = b;
}

CZ_ShapedMembershipFunction::~CZ_ShapedMembershipFunction(void) {}

double CZ_ShapedMembershipFunction::GetValue(const double x) {
  if (x <= m_a) {

    return (1.0);
  } else if (m_a < x && x <= (m_a + m_b) / 2.0) {

    return (1.0 - 2.0 * ((x - m_a) / (m_b - m_a)) * ((x - m_a) / (m_b - m_a)));
  } else if ((m_a + m_b) / 2.0 <= x && x <= m_b) {

    return (2.0 * ((x - m_b) / (m_b - m_a)) * ((x - m_b) / (m_b - m_a)));
  } else {

    return (0.0);
  }
}

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

  void A(const double a) {
    m_a = a;
  }
  double A(void) {
    return (m_a);
  }
  void D(const double d) {
    m_d = d;
  }
  double D(void) {
    return (m_d);
  }
  void B(const double b) {
    m_b = b;
  }
  double B(void) {
    return (m_b);
  }
  void C(const double c) {
    m_c = c;
  }
  double C(void) {
    return (m_c);
  }

  double GetValue(const double x);
};

CP_ShapedMembershipFunction::CP_ShapedMembershipFunction(void) {}

CP_ShapedMembershipFunction::CP_ShapedMembershipFunction(const double a,
                                                         const double b,
                                                         const double c,
                                                         const double d) {
  m_a = a;
  m_d = d;
  m_b = b;
  m_c = c;
}

CP_ShapedMembershipFunction::~CP_ShapedMembershipFunction(void) {}

double CP_ShapedMembershipFunction::GetValue(const double x) {
  if (x <= m_a) {
    return (0.0);
  } else if (m_a < x && x <= (m_a + m_b) / 2.0) {
    return (2.0 * ((x - m_a) / (m_b - m_a)) * ((x - m_a) / (m_b - m_a)));
  } else if ((m_a + m_b) / 2.0 < x && x < m_b) {
    return (1.0 - 2.0 * ((x - m_b) / (m_b - m_a)) * ((x - m_b) / (m_b - m_a)));
  } else if (m_b <= x && x <= m_c) {
    return (1.0);
  } else if (m_c < x && x <= (m_c + m_d) / 2.0) {
    return (1.0 - 2.0 * ((x - m_c) / (m_d - m_c)) * ((x - m_c) / (m_d - m_c)));
  } else if ((m_c + m_d) / 2.0 < x && x < m_d) {
    return (2.0 * ((x - m_d) / (m_d - m_c)) * ((x - m_d) / (m_d - m_c)));
  } else {
    return (0.0);
  }
}

class CSigmoidalMembershipFunction : public IMembershipFunction {
private:
  double m_a;
  double m_c;

public:
  CSigmoidalMembershipFunction(void);
  CSigmoidalMembershipFunction(const double a, const double c);
  ~CSigmoidalMembershipFunction(void);

  void A(const double a) {
    m_a = a;
  }
  double A(void) {
    return (m_a);
  }
  void C(const double c) {
    m_c = c;
  }
  double C(void) {
    return (m_c);
  }

  double GetValue(const double x);
};

CSigmoidalMembershipFunction::CSigmoidalMembershipFunction(void) {
  m_a = 0.0;
  m_c = 0.0;
}

CSigmoidalMembershipFunction::CSigmoidalMembershipFunction(const double a,
                                                           const double c) {
  m_a = a;
  m_c = c;
}

CSigmoidalMembershipFunction::~CSigmoidalMembershipFunction(void) {}

double CSigmoidalMembershipFunction::GetValue(const double x) {

  return (1 / (1 + exp(-m_a * (x - m_c))));
}

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

  void A1(const double a1) {
    m_a1 = a1;
  }
  double A1(void) {
    return (m_a1);
  }
  void C1(const double c1) {
    m_c1 = c1;
  }
  double C1(void) {
    return (m_c1);
  }
  void A2(const double a2) {
    m_a2 = a2;
  }
  double A2(void) {
    return (m_a2);
  }
  void C2(const double c2) {
    m_c2 = c2;
  }
  double C2(void) {
    return (m_c2);
  }

  double GetValue(const double x);
};

CProductTwoSigmoidalMembershipFunctions::
    CProductTwoSigmoidalMembershipFunctions(void) {
  m_a1 = 0.0;
  m_a2 = 0.0;
  m_c1 = 0.0;
  m_c2 = 0.0;
}

CProductTwoSigmoidalMembershipFunctions::
    CProductTwoSigmoidalMembershipFunctions(const double a1, const double c1,
                                            const double a2, const double c2) {
  m_a1 = a1;
  m_a2 = a2;
  m_c1 = c1;
  m_c2 = c2;
}

CProductTwoSigmoidalMembershipFunctions::
    ~CProductTwoSigmoidalMembershipFunctions(void) {}

double CProductTwoSigmoidalMembershipFunctions::GetValue(const double x) {
  double first_equation = 1 / (1 + exp(-m_a1 * (x - m_c1)));
  double second_equation = 1 / (1 + exp(-m_a2 * (x - m_c2)));

  return (first_equation * second_equation);
}

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

  void A1(const double a1) {
    m_a1 = a1;
  }
  double A1(void) {
    return (m_a1);
  }
  void C1(const double c1) {
    m_c1 = c1;
  }
  double C1(void) {
    return (m_c1);
  }
  void A2(const double a2) {
    m_a2 = a2;
  }
  double A2(void) {
    return (m_a2);
  }
  void C2(const double c2) {
    m_c2 = c2;
  }
  double C2(void) {
    return (m_c2);
  }

  double GetValue(const double x);
};

CDifferencTwoSigmoidalMembershipFunction::
    CDifferencTwoSigmoidalMembershipFunction(void) {}

CDifferencTwoSigmoidalMembershipFunction::
    CDifferencTwoSigmoidalMembershipFunction(const double a1, const double c1,
                                             const double a2, const double c2) {
  m_a1 = a1;
  m_a2 = a2;
  m_c1 = c1;
  m_c2 = c2;
}

CDifferencTwoSigmoidalMembershipFunction::
    ~CDifferencTwoSigmoidalMembershipFunction() {}

double CDifferencTwoSigmoidalMembershipFunction::GetValue(const double x) {
  double first_equation = 1 / (1 + exp(-m_a1 * (x - m_c1)));
  double second_equation = 1 / (1 + exp(-m_a2 * (x - m_c2)));

  return (first_equation - second_equation);
}

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

  void X1(const double x) {
    m_x1 = x;
  }
  double X1(void) {
    return (m_x1);
  }
  void X2(const double x) {
    m_x2 = x;
  }
  double X2(void) {
    return (m_x2);
  }
  void X3(const double x) {
    m_x3 = x;
  }
  double X3(void) {
    return (m_x3);
  }
  void X4(const double x) {
    m_x4 = x;
  }
  double X4(void) {
    return (m_x4);
  }

  double GetValue(const double x);
};

CTrapezoidMembershipFunction::CTrapezoidMembershipFunction(void) {}

CTrapezoidMembershipFunction::CTrapezoidMembershipFunction(const double x1,
                                                           const double x2,
                                                           const double x3,
                                                           const double x4) {
  if (!(x1 <= x2 && x2 <= x3 && x3 <= x4)) {
    Print("Incorrect parameters! It is necessary to re-initialize them.");
  } else {
    m_x1 = x1;
    m_x2 = x2;
    m_x3 = x3;
    m_x4 = x4;
  }
}

CTrapezoidMembershipFunction::~CTrapezoidMembershipFunction() {}

double CTrapezoidMembershipFunction::GetValue(const double x) {
  double result = 0;
  if (x == m_x1 && x == m_x2) {
    result = 1.0;
  } else if (x == m_x3 && x == m_x4) {
    result = 1.0;
  } else if (x <= m_x1 || x >= m_x4) {
    result = 0;
  } else if ((x >= m_x2) && (x <= m_x3)) {
    result = 1;
  } else if ((x > m_x1) && (x < m_x2)) {
    result = (x / (m_x2 - m_x1)) - (m_x1 / (m_x2 - m_x1));
  } else {
    result = (-x / (m_x4 - m_x3)) + (m_x4 / (m_x4 - m_x3));
  }

  return (result);
}

class CNormalMembershipFunction : public IMembershipFunction {
private:
  double m_b;
  double m_sigma;

public:
  CNormalMembershipFunction(void);
  CNormalMembershipFunction(const double b, const double sigma);
  ~CNormalMembershipFunction(void);

  void B(const double b) {
    m_b = b;
  }
  double B(void) {
    return (m_b);
  }
  void Sigma(const double sigma) {
    m_sigma = sigma;
  }
  double Sigma(void) {
    return (m_sigma);
  }

  double GetValue(const double x);
};

CNormalMembershipFunction::CNormalMembershipFunction(void) {}

CNormalMembershipFunction::CNormalMembershipFunction(const double b,
                                                     const double sigma) {
  m_b = b;
  m_sigma = sigma;
}

CNormalMembershipFunction::~CNormalMembershipFunction(void) {}

double CNormalMembershipFunction::GetValue(const double x) {

  return (exp(-(x - m_b) * (x - m_b) / (2.0 * m_sigma * m_sigma)));
}

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

  void X1(const double x) {
    m_x1 = x;
  }
  double X1(void) {
    return (m_x1);
  }
  void X2(const double x) {
    m_x2 = x;
  }
  double X2(void) {
    return (m_x2);
  }
  void X3(const double x) {
    m_x3 = x;
  }
  double X3(void) {
    return (m_x3);
  }

  CNormalMembershipFunction *ToNormalMF(void);

  double GetValue(const double x);
};

CTriangularMembershipFunction::CTriangularMembershipFunction(void) {}

CTriangularMembershipFunction::CTriangularMembershipFunction(const double x1,
                                                             const double x2,
                                                             const double x3) {
  if (!(x1 <= x2 && x2 <= x3)) {
    Print("Incorrect parameters! It is necessary to re-initialize them.");
    return;
  }
  m_x1 = x1;
  m_x2 = x2;
  m_x3 = x3;
}

CTriangularMembershipFunction::~CTriangularMembershipFunction(void) {}

CNormalMembershipFunction *CTriangularMembershipFunction::ToNormalMF(void) {
  double b = m_x2;
  double sigma25 = (m_x3 - m_x1) / 2.0;
  double sigma = sigma25 / 2.5;

  return new CNormalMembershipFunction(b, sigma);
}

double CTriangularMembershipFunction::GetValue(const double x) {
  double result = 0;
  if (x == m_x1 && x == m_x2) {
    result = 1.0;
  } else if (x == m_x2 && x == m_x3) {
    result = 1.0;
  } else if (x <= m_x1 || x >= m_x3) {
    result = 0;
  } else if (x == m_x2) {
    result = 1;
  } else if ((x > m_x1) && (x < m_x2)) {
    result = (x / (m_x2 - m_x1)) - (m_x1 / (m_x2 - m_x1));
  } else {
    result = (-x / (m_x3 - m_x2)) + (m_x3 / (m_x3 - m_x2));
  }

  return (result);
}

class CConstantMembershipFunction : public IMembershipFunction {
private:
  double m_constValue;

public:
  CConstantMembershipFunction();
  CConstantMembershipFunction(const double constValue);
  ~CConstantMembershipFunction();

  double GetValue(const double x) {
    return (m_constValue);
  }
};

CConstantMembershipFunction::CConstantMembershipFunction(void) {}

CConstantMembershipFunction::CConstantMembershipFunction(
    const double constValue) {
  if (constValue < 0.0 || constValue > 1.0) {
    Print("Incorrect parameter! It is necessary to re-initialize them.");
  }
  m_constValue = constValue;
}

CConstantMembershipFunction::~CConstantMembershipFunction(void) {}

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

  CList *MembershipFunctions(void) {
    return (m_mfs);
  }
  MfCompositionType CompositionType(void) {
    return (m_composType);
  }
  void CompositionType(MfCompositionType value) {
    m_composType = value;
  }

  double GetValue(double const x);

private:
  double Compose(const double val1, const double val2);
};

CCompositeMembershipFunction::CCompositeMembershipFunction(
    MfCompositionType composType) {
  m_mfs = new CList;
  m_composType = composType;
}

CCompositeMembershipFunction::CCompositeMembershipFunction(
    MfCompositionType composType, IMembershipFunction *mf1,
    IMembershipFunction *mf2) {
  m_mfs = new CList;
  m_mfs.Add(mf1);
  m_mfs.Add(mf2);
  m_composType = composType;
}

CCompositeMembershipFunction::CCompositeMembershipFunction(
    MfCompositionType composType, CList *mfs) {
  m_mfs = mfs;
  m_composType = composType;
}

CCompositeMembershipFunction::~CCompositeMembershipFunction() {
  m_mfs.FreeMode(false);
  delete m_mfs;
}

double CCompositeMembershipFunction::GetValue(double const x) {
  if (m_mfs.Total() == 0) {

    return 0.0;
  } else if (m_mfs.Total() == 1) {
    IMembershipFunction *fun = m_mfs.GetNodeAtIndex(0);

    return fun.GetValue(x);
  } else {
    IMembershipFunction *fun = m_mfs.GetNodeAtIndex(0);
    double result = fun.GetValue(x);
    for (int i = 1; i < m_mfs.Total(); i++) {
      fun = m_mfs.GetNodeAtIndex(i);
      result = Compose(result, fun.GetValue(x));
    }

    return (result);
  }
}

double CCompositeMembershipFunction::Compose(const double val1,
                                             const double val2) {
  switch (m_composType) {
  case MaxMF:

    return fmax(val1, val2);
  case MinMF:

    return fmin(val1, val2);
  case ProdMF:

    return (val1 * val2);
  case SumMF:

    return (val1 + val2);
  default: {
    Print("Incorrect type of composition");

    return (NULL);
  }
  }
}

#endif
