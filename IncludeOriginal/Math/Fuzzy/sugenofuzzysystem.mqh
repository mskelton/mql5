#ifndef SUGENOFUZZYSYSTEM_H
#define SUGENOFUZZYSYSTEM_H

#include "FuzzyRule.mqh"
#include "GenericFuzzySystem.mqh"
#include "InferenceMethod.mqh"
#include "RuleParser.mqh"
#include "SugenoVariable.mqh"
#include <Arrays\List.mqh>

class CSugenoFuzzySystem : public CGenericFuzzySystem {
private:
  CList *m_output;
  CList *m_rules;

public:
  CSugenoFuzzySystem(void);
  ~CSugenoFuzzySystem(void);

  CList *Output() {
    return (m_output);
  }

  CList *Rules() {
    return (m_rules);
  }

  CSugenoVariable *OutputByName(const string name);

  CLinearSugenoFunction *CreateSugenoFunction(const string name, CList *coeffs,
                                              const double constValue);
  CLinearSugenoFunction *CreateSugenoFunction(const string name,
                                              const double &coeffs[]);

  CSugenoFuzzyRule *EmptyRule();

  CSugenoFuzzyRule *ParseRule(const string rule);
  CList *EvaluateConditions(CList *fuzzifiedInput);
  CList *EvaluateFunctions(CList *inputValues);
  CList *CombineResult(CList *ruleWeights, CList *functionResults);
  CList *Calculate(CList *inputValues);
};

CSugenoFuzzySystem::CSugenoFuzzySystem(void) {
  m_output = new CList;
  m_rules = new CList;
}

CSugenoFuzzySystem::~CSugenoFuzzySystem(void) {
  delete m_output;
  delete m_rules;
}

CSugenoVariable *CSugenoFuzzySystem::OutputByName(const string name) {
  for (int i = 0; i < m_output.Total(); i++) {
    CSugenoVariable *var = m_output.GetNodeAtIndex(i);
    if (var.Name() == name) {

      return (var);
    }
  }
  Print("Variable with that name is not found");

  return (NULL);
}

CLinearSugenoFunction *
CSugenoFuzzySystem::CreateSugenoFunction(const string name, CList *coeffs,
                                         const double constValue) {

  return new CLinearSugenoFunction(name, CGenericFuzzySystem::Input(), coeffs,
                                   constValue);
}

CLinearSugenoFunction *
CSugenoFuzzySystem::CreateSugenoFunction(const string name,
                                         const double &coeffs[]) {

  return new CLinearSugenoFunction(name, Input(), coeffs);
}

CSugenoFuzzyRule *CSugenoFuzzySystem::EmptyRule() {

  return new CSugenoFuzzyRule();
}

CSugenoFuzzyRule *CSugenoFuzzySystem::ParseRule(const string rule) {

  return CRuleParser::Parse(rule, EmptyRule(), Input(), Output());
}

CList *CSugenoFuzzySystem::EvaluateConditions(CList *fuzzifiedInput) {
  CList *result = new CList;
  for (int i = 0; i < Rules().Total(); i++) {
    CDictionary_Obj_Double *p_rd = new CDictionary_Obj_Double;
    CSugenoFuzzyRule *rule = Rules().GetNodeAtIndex(i);
    p_rd.SetAll(rule, EvaluateCondition(rule.Condition(), fuzzifiedInput));
    result.Add(p_rd);
  }

  return (result);
}

CList *CSugenoFuzzySystem::EvaluateFunctions(CList *inputValues) {
  CList *result = new CList;
  for (int i = 0; i < Output().Total(); i++) {
    CSugenoVariable *var = Output().GetNodeAtIndex(i);
    CList *varResult = new CList;
    for (int j = 0; j < var.Functions().Total(); j++) {
      CDictionary_Obj_Double *p_fd = new CDictionary_Obj_Double;
      CLinearSugenoFunction *func = var.Functions().GetNodeAtIndex(j);
      p_fd.SetAll(func, func.Evaluate(inputValues));
      varResult.Add(p_fd);
    }
    CDictionary_Obj_Obj *p_vl = new CDictionary_Obj_Obj;
    p_vl.SetAll(var, varResult);
    result.Add(p_vl);
  }

  return (result);
}

CList *CSugenoFuzzySystem::CombineResult(CList *ruleWeights,
                                         CList *functionResults) {
  CList *results = new CList;
  CList *numerators = new CList;
  CDictionary_Obj_Double *p_vd1;
  CList *denominators = new CList;
  CDictionary_Obj_Double *p_vd2;

  for (int i = 0; i < Output().Total(); i++) {
    p_vd1 = new CDictionary_Obj_Double;
    p_vd1.SetAll(Output().GetNodeAtIndex(i), 0.0);
    numerators.Add(p_vd1);
    p_vd2 = new CDictionary_Obj_Double;
    p_vd2.SetAll(Output().GetNodeAtIndex(i), 0.0);
    denominators.Add(p_vd2);
  }
  for (int i = 0; i < ruleWeights.Total(); i++) {
    double z = NULL;
    double w = NULL;
    CDictionary_Obj_Double *p_rd = ruleWeights.GetNodeAtIndex(i);
    CSugenoFuzzyRule *rule = p_rd.Key();
    CSugenoVariable *var = rule.Conclusion().Var();
    for (int j = 0; j < functionResults.Total(); j++) {
      CDictionary_Obj_Obj *p_vl = functionResults.GetNodeAtIndex(j);
      if (p_vl.Key() == var) {
        CList *list = p_vl.Value();
        for (int k = 0; k < list.Total(); k++) {
          CDictionary_Obj_Double *p_fd = list.GetNodeAtIndex(k);
          if (p_fd.Key() == rule.Conclusion().Term()) {
            z = p_fd.Value();
            break;
          }
        }
        break;
      }
    }
    for (int j = 0; j < ruleWeights.Total(); j++) {
      p_rd = ruleWeights.GetNodeAtIndex(j);
      if (p_rd.Key() == rule) {
        w = p_rd.Value();
        break;
      }
    }
    for (int j = 0; j < numerators.Total(); j++) {
      p_vd1 = numerators.GetNodeAtIndex(j);
      double num = p_vd1.Value();
      if (p_vd1.Key() == rule.Conclusion().Var()) {
        num = num + (z * w);
        p_vd1.Value(num);
        break;
      }
    }
    for (int j = 0; j < denominators.Total(); j++) {
      p_vd2 = denominators.GetNodeAtIndex(j);
      double den = p_vd2.Value();
      if (p_vd2.Key() == rule.Conclusion().Var()) {
        den = den + w;
        p_vd2.Value(den);
        break;
      }
    }
  }

  for (int i = 0; i < Output().Total(); i++) {
    CSugenoVariable *var = Output().GetNodeAtIndex(i);
    CDictionary_Obj_Double *p_vd_res = new CDictionary_Obj_Double;
    CDictionary_Obj_Double *p_vd_num;
    CDictionary_Obj_Double *p_vd_den;
    for (int j = 0; j < numerators.Total(); j++) {
      p_vd_num = numerators.GetNodeAtIndex(j);
      if (p_vd_num.Key() == var) {
        break;
      }
    }
    for (int j = 0; j < denominators.Total(); j++) {
      p_vd_den = denominators.GetNodeAtIndex(j);
      if (p_vd_den.Key() == var) {
        break;
      }
    }
    if (p_vd_den.Value() == 0.0) {
      p_vd_res.Value(0.0);
      results.Add(p_vd_res);
    } else {
      p_vd_res.Value(p_vd_num.Value() / p_vd_den.Value());
      results.Add(p_vd_res);
    }
  }

  delete numerators;
  delete denominators;
  return (results);
}

CList *CSugenoFuzzySystem::Calculate(CList *inputValues) {

  if (m_rules.Total() == 0) {
    Print("There should be one rule as minimum.");

    return (NULL);
  }

  CList *fuzzifiedInput = Fuzzify(inputValues);

  CList *ruleWeights = EvaluateConditions(fuzzifiedInput);

  CList *functionsResult = EvaluateFunctions(inputValues);

  CList *result = CombineResult(ruleWeights, functionsResult);

  for (int i = 0; i < functionsResult.Total(); i++) {
    CDictionary_Obj_Obj *pair = functionsResult.GetNodeAtIndex(i);
    delete pair.Value();
  }
  delete functionsResult;
  delete ruleWeights;
  for (int i = 0; i < fuzzifiedInput.Total(); i++) {
    CDictionary_Obj_Obj *pair = fuzzifiedInput.GetNodeAtIndex(i);
    delete pair.Value();
  }
  delete fuzzifiedInput;

  return (result);
}

#endif
