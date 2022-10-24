#ifndef SUGENOVARIABLE_H
#define SUGENOVARIABLE_H

#include "FuzzyVariable.mqh"
#include <Arrays/List.mqh>

class ISugenoFunction : public CNamedValueImpl {
public:
  virtual bool IsTypeOf(EnType type);
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
  CLinearSugenoFunction(const string name, CList *in, const double coeffs[]);
  ~CLinearSugenoFunction(void);

  virtual bool IsTypeOf(EnType type);

  double ConstValue();
  void ConstValue(const double value);

  double GetCoefficient(CFuzzyVariable *var);
  void SetCoefficient(CFuzzyVariable *var, const double coeff);

  double Evaluate(CList *inputValues);
};

class CSugenoVariable : public CNamedVariableImpl {
private:
  CList *m_functions;

public:
  CSugenoVariable(const string name);
  ~CSugenoVariable(void);

  virtual bool IsTypeOf(EnType type);

  CList *Functions();

  CList *Values();

  ISugenoFunction *GetFuncByName(const string name);
};

#endif
