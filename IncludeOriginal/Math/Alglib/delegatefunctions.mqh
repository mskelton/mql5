#ifndef DELEGATEFUNCTIONS_H
#define DELEGATEFUNCTIONS_H

#include "matrix.mqh"
#include <Object.mqh>

class CNDimensional_Func {
public:
  CNDimensional_Func(void);
  ~CNDimensional_Func(void);

  virtual void Func(double &x[], double &func, CObject &obj);
};

CNDimensional_Func::CNDimensional_Func(void) {
}

CNDimensional_Func::~CNDimensional_Func(void) {
}

void CNDimensional_Func::Func(double &x[], double &func, CObject &obj) {
}

class CNDimensional_Grad {
public:
  CNDimensional_Grad(void);
  ~CNDimensional_Grad(void);

  virtual void Grad(double &x[], double &func, double &grad[], CObject &obj);
};

CNDimensional_Grad::CNDimensional_Grad(void) {
}

CNDimensional_Grad::~CNDimensional_Grad(void) {
}

void CNDimensional_Grad::Grad(double &x[], double &func, double &grad[],
                              CObject &obj) {
}

class CNDimensional_Hess {
public:
  CNDimensional_Hess(void);
  ~CNDimensional_Hess(void);

  virtual void Hess(double &x[], double &func, double &grad[],
                    CMatrixDouble &hess, CObject &obj);
};

CNDimensional_Hess::CNDimensional_Hess(void) {
}

CNDimensional_Hess::~CNDimensional_Hess(void) {
}

void CNDimensional_Hess::Hess(double &x[], double &func, double &grad[],
                              CMatrixDouble &hess, CObject &obj) {
}

class CNDimensional_FVec {
public:
  CNDimensional_FVec(void);
  ~CNDimensional_FVec(void);

  virtual void FVec(double &x[], double &fi[], CObject &obj);
};

CNDimensional_FVec::CNDimensional_FVec(void) {
}

CNDimensional_FVec::~CNDimensional_FVec(void) {
}

void CNDimensional_FVec::FVec(double &x[], double &fi[], CObject &obj) {
}

class CNDimensional_Jac {
public:
  CNDimensional_Jac(void);
  ~CNDimensional_Jac(void);

  virtual void Jac(double &x[], double &fi[], CMatrixDouble &jac, CObject &obj);
};

CNDimensional_Jac::CNDimensional_Jac(void) {
}

CNDimensional_Jac::~CNDimensional_Jac(void) {
}

void CNDimensional_Jac::Jac(double &x[], double &fi[], CMatrixDouble &jac,
                            CObject &obj) {
}

class CNDimensional_PFunc {
public:
  CNDimensional_PFunc(void);
  ~CNDimensional_PFunc(void);

  virtual void PFunc(double &c[], double &x[], double &func, CObject &obj);
};

CNDimensional_PFunc::CNDimensional_PFunc(void) {
}

CNDimensional_PFunc::~CNDimensional_PFunc(void) {
}

void CNDimensional_PFunc::PFunc(double &c[], double &x[], double &func,
                                CObject &obj) {
}

class CNDimensional_PGrad {
public:
  CNDimensional_PGrad(void);
  ~CNDimensional_PGrad(void);

  virtual void PGrad(double &c[], double &x[], double &func, double &grad[],
                     CObject &obj);
};

CNDimensional_PGrad::CNDimensional_PGrad(void) {
}

CNDimensional_PGrad::~CNDimensional_PGrad(void) {
}

void CNDimensional_PGrad::PGrad(double &c[], double &x[], double &func,
                                double &grad[], CObject &obj) {
}

class CNDimensional_PHess {
public:
  CNDimensional_PHess(void);
  ~CNDimensional_PHess(void);

  virtual void PHess(double &c[], double &x[], double &func, double &grad[],
                     CMatrixDouble &hess, CObject &obj);
};

CNDimensional_PHess::CNDimensional_PHess(void) {
}

CNDimensional_PHess::~CNDimensional_PHess(void) {
}

void CNDimensional_PHess::PHess(double &c[], double &x[], double &func,
                                double &grad[], CMatrixDouble &hess,
                                CObject &obj) {
}

class CNDimensional_ODE_RP {
public:
  CNDimensional_ODE_RP(void);
  ~CNDimensional_ODE_RP(void);

  virtual void ODE_RP(double &y[], double x, double &dy[], CObject &obj);
};

CNDimensional_ODE_RP::CNDimensional_ODE_RP(void) {
}

CNDimensional_ODE_RP::~CNDimensional_ODE_RP(void) {
}

void CNDimensional_ODE_RP::ODE_RP(double &y[], double x, double &dy[],
                                  CObject &obj) {
}

class CIntegrator1_Func {
public:
  CIntegrator1_Func(void);
  ~CIntegrator1_Func(void);

  virtual void Int_Func(double x, double xminusa, double bminusx, double &y,
                        CObject &obj);
};

CIntegrator1_Func::CIntegrator1_Func(void) {
}

CIntegrator1_Func::~CIntegrator1_Func(void) {
}

void CIntegrator1_Func::Int_Func(double x, double xminusa, double bminusx,
                                 double &y, CObject &obj) {
}

class CNDimensional_Rep {
public:
  CNDimensional_Rep(void);
  ~CNDimensional_Rep(void);

  virtual void Rep(double &arg[], double func, CObject &obj);
};

CNDimensional_Rep::CNDimensional_Rep(void) {
}

CNDimensional_Rep::~CNDimensional_Rep(void) {
}

void CNDimensional_Rep::Rep(double &arg[], double func, CObject &obj) {
}

#endif
