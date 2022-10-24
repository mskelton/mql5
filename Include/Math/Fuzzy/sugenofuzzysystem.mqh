#ifndef SUGENOFUZZYSYSTEM_H
#define SUGENOFUZZYSYSTEM_H

#include "FuzzyRule.mqh"
#include "InferenceMethod.mqh"
#include "RuleParser.mqh"
#include "SugenoVariable.mqh"
#include "genericfuzzysystem.mqh"
#include <Arrays/List.mqh>

class CSugenoFuzzySystem : public CGenericFuzzySystem {
private:
  CList *m_output;
  CList *m_rules;

public:
  CSugenoFuzzySystem(void);
  ~CSugenoFuzzySystem(void);

  CList *Output();

  CList *Rules();

  CSugenoVariable *OutputByName(const string name);

  CLinearSugenoFunction *CreateSugenoFunction(const string name, CList *coeffs,
                                              const double constValue);
  CLinearSugenoFunction *CreateSugenoFunction(const string name,
                                              const double coeffs[]);

  CSugenoFuzzyRule *EmptyRule();

  CSugenoFuzzyRule *ParseRule(const string rule);
  CList *EvaluateConditions(CList *fuzzifiedInput);
  CList *EvaluateFunctions(CList *inputValues);
  CList *CombineResult(CList *ruleWeights, CList *functionResults);
  CList *Calculate(CList *inputValues);
};

#endif
