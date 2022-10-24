#ifndef MAMDANIFUZZYSYSTEM_H
#define MAMDANIFUZZYSYSTEM_H

#include "FuzzyRule.mqh"
#include "GenericFuzzySystem.mqh"
#include "InferenceMethod.mqh"
#include "RuleParser.mqh"
#include <Arrays/ArrayDouble.mqh>
#include <Arrays/List.mqh>

class CMamdaniFuzzySystem : public CGenericFuzzySystem {
private:
  CList *m_output;
  CList *m_rules;
  ImplicationMethod m_impl_method;
  AggregationMethod m_aggr_method;
  DefuzzificationMethod m_defuzz_method;

public:
  CMamdaniFuzzySystem(void);
  ~CMamdaniFuzzySystem(void);

  CList *Output();

  CList *Rules();

  ImplicationMethod ImplicationMethod();
  void ImplicationMethod(ImplicationMethod value);

  AggregationMethod AggregationMethod();
  void AggregationMethod(AggregationMethod value);

  DefuzzificationMethod DefuzzificationMethod();
  void DefuzzificationMethod(DefuzzificationMethod value);

  CFuzzyVariable *OutputByName(const string name);

  CMamdaniFuzzyRule *EmptyRule();

  CMamdaniFuzzyRule *ParseRule(const string rule);

  CList *Calculate(CList *inputValues);
  CList *EvaluateConditions(CList *fuzzifiedInput);
  CList *Implicate(CList *conditions);
  CList *Aggregate(CList *conclusions);
  CList *Defuzzify(CList *fuzzyResult);
  double Defuzzify(IMembershipFunction *mf, const double min, const double max);
};

#endif
