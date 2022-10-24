#ifndef SUGENOVARIABLE_H
#define SUGENOVARIABLE_H

#include "Dictionary.mqh"
#include "FuzzyVariable.mqh"
#include <Arrays\List.mqh>

class ISugenoFunction : public CNamedValueImpl {
public:
  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_ISugenoFunction);
  }
};

class CLinearSugenoFunction : public ISugenoFunction {
private:
  CList *m_input;
  CList *m_coeffs;
  double m_const_value;

public:
  CLinearSugenoFunction(const string name, CList *in);
  CLinearSugenoFunction(const string name, CList *in, CList *coeffs,
                        const double constValue);
  CLinearSugenoFunction(const string name, CList *in, const double &coeffs[]);
  ~CLinearSugenoFunction(void);

  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_LinearSugenoFunction);
  }

  double ConstValue() {
    return (m_const_value);
  }
  void ConstValue(const double value) {
    m_const_value = value;
  }

  double GetCoefficient(CFuzzyVariable *var);
  void SetCoefficient(CFuzzyVariable *var, const double coeff);

  double Evaluate(CList *inputValues);
};

CLinearSugenoFunction::CLinearSugenoFunction(const string name, CList *in) {
  m_coeffs = new CList;
  CNamedValueImpl::Name(name);
  m_input = in;
}

CLinearSugenoFunction::CLinearSugenoFunction(const string name, CList *in,
                                             CList *coeffs,
                                             const double constValue) {
  CNamedValueImpl::Name(name);
  m_input = in;

  for (int i = 0; i < coeffs.Total(); i++) {
    CDictionary_Obj_Double *p_vd = coeffs.GetNodeAtIndex(i);
    if ((m_input.IndexOf(p_vd.Key()) == -1) && (in.Total() == coeffs.Total())) {
      Print("Input of the fuzzy system does not contain all variable.");
    }
  }
  m_coeffs = coeffs;
  m_const_value = constValue;
}

CLinearSugenoFunction::CLinearSugenoFunction(const string name, CList *in,
                                             const double &coeffs[]) {
  m_coeffs = new CList;
  m_input = in;
  CNamedValueImpl::Name(name);

  if (ArraySize(coeffs) != in.Total() &&
      ArraySize(coeffs) != (in.Total() + 1)) {
    Print("Wrong lenght of coefficients array");
  }

  for (int i = 0; i < in.Total(); i++) {
    CDictionary_Obj_Double *p_vd = new CDictionary_Obj_Double;
    CFuzzyVariable *var = in.GetNodeAtIndex(i);
    p_vd.SetAll(var, coeffs[i]);
    m_coeffs.Add(p_vd);
  }
  if (ArraySize(coeffs) == (in.Total() + 1)) {
    m_const_value = coeffs[ArraySize(coeffs) - 1];
  }
}

CLinearSugenoFunction::~CLinearSugenoFunction(void) {
  if (CheckPointer(m_input) == POINTER_DYNAMIC)
    delete m_input;
  if (CheckPointer(m_coeffs) == POINTER_DYNAMIC)
    delete m_coeffs;
}

double CLinearSugenoFunction::GetCoefficient(CFuzzyVariable *var) {
  if (var == NULL) {

    return (m_const_value);
  } else {
    for (int i = 0; i < m_coeffs.Total(); i++) {
      CDictionary_Obj_Double *p_vd = m_coeffs.GetNodeAtIndex(i);
      if (p_vd.Key() == var) {

        return (p_vd.Value());
      }
    }
  }

  return (NULL);
}

void CLinearSugenoFunction::SetCoefficient(CFuzzyVariable *var,
                                           const double coeff) {
  if (var == NULL) {
    m_const_value = coeff;
  } else {
    for (int i = 0; i < m_coeffs.Total(); i++) {
      CDictionary_Obj_Double *p_vd = m_coeffs.GetNodeAtIndex(i);
      if (p_vd.Key() == var) {
        p_vd.Value(coeff);
      }
      m_coeffs.Delete(i);
      m_coeffs.Insert(p_vd, i);
    }
  }
}

double CLinearSugenoFunction::Evaluate(CList *inputValues) {
  double result = 0.0;
  for (int i = 0; i < m_coeffs.Total(); i++) {
    CDictionary_Obj_Double *p_vd1 = m_coeffs.GetNodeAtIndex(i);
    CDictionary_Obj_Double *p_vd2 = inputValues.GetNodeAtIndex(i);
    result += (p_vd1.Value()) * (p_vd2.Value());
  }
  result += m_const_value;

  return (result);
}

class CSugenoVariable : public CNamedVariableImpl {
private:
  CList *m_functions;

public:
  CSugenoVariable(const string name);
  ~CSugenoVariable(void);

  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_SugenoVariable);
  }

  CList *Functions() {
    return (m_functions);
  }

  CList *Values() {
    return (m_functions);
  }

  ISugenoFunction *GetFuncByName(const string name);
};

CSugenoVariable::CSugenoVariable(const string name) {
  m_functions = new CList;
  CNamedVariableImpl::Name(name);
}

CSugenoVariable::~CSugenoVariable(void) {
  delete m_functions;
}

ISugenoFunction *CSugenoVariable::GetFuncByName(const string name) {
  CList *values = CSugenoVariable::Values();
  values.Total();
  for (int i = 0; i < values.Total(); i++) {
    CNamedValueImpl *func = values.GetNodeAtIndex(i);
    if (func.Name() == name) {
      ISugenoFunction *result = m_functions.GetNodeAtIndex(i);

      return (result);
    }
  }
  Print("The function of the same name is not found");

  return (NULL);
}

#endif
