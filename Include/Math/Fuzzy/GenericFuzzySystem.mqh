#ifndef GENERICFUZZYSYSTEM_H
#define GENERICFUZZYSYSTEM_H

#include "Dictionary.mqh"
#include "FuzzyRule.mqh"
#include "InferenceMethod.mqh"
#include <Arrays/ArrayObj.mqh>
#include <Arrays/List.mqh>

class CGenericFuzzySystem {
private:
  CList *m_input;
  AndMethod m_and_method;
  OrMethod m_or_method;

protected:
  CGenericFuzzySystem(void);
  ~CGenericFuzzySystem(void);

public:
  CList *Input(void);

  void AndMethod(AndMethod value);
  enum AndMethod AndMethod(void);

  void OrMethod(OrMethod value);
  enum OrMethod OrMethod(void);

  CFuzzyVariable *InputByName(const string name);

  CList *Fuzzify(CList *inputValues);

protected:
  double EvaluateCondition(ICondition *condition, CList *fuzzifiedInput);
  double EvaluateConditionPair(const double cond1, const double cond2,
                               OperatorType op);

private:
  bool ValidateInputValues(CList *inputValues, string &msg);
};

#endif
