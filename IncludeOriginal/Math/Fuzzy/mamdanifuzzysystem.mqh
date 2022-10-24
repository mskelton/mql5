#ifndef MAMDANIFUZZYSYSTEM_H
#define MAMDANIFUZZYSYSTEM_H

#include "FuzzyRule.mqh"
#include "GenericFuzzySystem.mqh"
#include "InferenceMethod.mqh"
#include "RuleParser.mqh"
#include <Arrays\ArrayDouble.mqh>
#include <Arrays\List.mqh>

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

  CList *Output() {
    return (m_output);
  }

  CList *Rules() {
    return (m_rules);
  }

  ImplicationMethod ImplicationMethod() {
    return (m_impl_method);
  }
  void ImplicationMethod(ImplicationMethod value) {
    m_impl_method = value;
  }

  AggregationMethod AggregationMethod() {
    return (m_aggr_method);
  }
  void AggregationMethod(AggregationMethod value) {
    m_aggr_method = value;
  }

  DefuzzificationMethod DefuzzificationMethod() {
    return (m_defuzz_method);
  }
  void DefuzzificationMethod(DefuzzificationMethod value) {
    m_defuzz_method = value;
  }

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

CMamdaniFuzzySystem::CMamdaniFuzzySystem(void) {
  m_output = new CList;
  m_rules = new CList;
  m_impl_method = MinIpm;
  m_aggr_method = MaxAgg;
  m_defuzz_method = CentroidDef;
}

CMamdaniFuzzySystem::~CMamdaniFuzzySystem(void) {
  delete m_output;
  delete m_rules;
}

CFuzzyVariable *CMamdaniFuzzySystem::OutputByName(const string name) {
  for (int i = 0; i < m_output.Total(); i++) {
    CFuzzyVariable *var = m_output.GetNodeAtIndex(i);
    if (var.Name() == name) {

      return (var);
    }
  }
  Print("Variable with that name is not found");

  return (NULL);
}

CMamdaniFuzzyRule *CMamdaniFuzzySystem::EmptyRule() {

  return new CMamdaniFuzzyRule();
}

CMamdaniFuzzyRule *CMamdaniFuzzySystem::ParseRule(const string rule) {

  return CRuleParser::Parse(rule, EmptyRule(), Input(), Output());
}

CList *CMamdaniFuzzySystem::Calculate(CList *inputValues) {

  if (m_rules.Total() == 0) {
    Print("There should be one rule as minimum.");

    return (NULL);
  }

  CList *fuzzifiedInput = Fuzzify(inputValues);

  CList *evaluatedConditions = EvaluateConditions(fuzzifiedInput);

  CList *implicatedConclusions = Implicate(evaluatedConditions);

  CList *fuzzyResult = Aggregate(implicatedConclusions);

  CList *result = Defuzzify(fuzzyResult);

  delete fuzzyResult;
  for (int i = 0; i < implicatedConclusions.Total(); i++) {
    CDictionary_Obj_Obj *pair = implicatedConclusions.GetNodeAtIndex(i);
    CCompositeMembershipFunction *composite = pair.Value();
    delete composite.MembershipFunctions().GetNodeAtIndex(0);
    delete composite;
  }
  delete implicatedConclusions;
  delete evaluatedConditions;
  for (int i = 0; i < fuzzifiedInput.Total(); i++) {
    CDictionary_Obj_Obj *pair = fuzzifiedInput.GetNodeAtIndex(i);
    delete pair.Value();
  }
  delete fuzzifiedInput;

  return (result);
}

CList *CMamdaniFuzzySystem::EvaluateConditions(CList *fuzzifiedInput) {
  CList *result = new CList;
  for (int i = 0; i < Rules().Total(); i++) {
    CDictionary_Obj_Double *p_rd = new CDictionary_Obj_Double;
    CMamdaniFuzzyRule *rule = Rules().GetNodeAtIndex(i);
    p_rd.SetAll(rule, EvaluateCondition(rule.Condition(), fuzzifiedInput));
    result.Add(p_rd);
  }

  return (result);
}

CList *CMamdaniFuzzySystem::Implicate(CList *conditions) {
  CList *conclusions = new CList;
  for (int i = 0; i < conditions.Total(); i++) {
    CDictionary_Obj_Double *p_rd = conditions.GetNodeAtIndex(i);
    CMamdaniFuzzyRule *rule = p_rd.Key();
    MfCompositionType compType;
    switch (m_impl_method) {
    case MinIpm: {
      compType = MinMF;
      break;
    }
    case ProductionImp: {
      compType = ProdMF;
      break;
    }
    default: {
      Print("Internal error.");

      return (NULL);
    }
    }
    CFuzzyTerm *val = rule.Conclusion().Term();
    IMembershipFunction *first_fun =
        new CConstantMembershipFunction(p_rd.Value());
    IMembershipFunction *second_fun = val.MembershipFunction();
    CCompositeMembershipFunction *resultMF =
        new CCompositeMembershipFunction(compType, first_fun, second_fun);
    CDictionary_Obj_Obj *p_rf = new CDictionary_Obj_Obj;
    p_rf.SetAll(rule, resultMF);
    conclusions.Add(p_rf);
  }

  return (conclusions);
}

CList *CMamdaniFuzzySystem::Aggregate(CList *conclusions) {
  CList *fuzzyResult = new CList;
  for (int i = 0; i < Output().Total(); i++) {
    CFuzzyVariable *var = Output().GetNodeAtIndex(i);
    CList *mfList = new CList;
    for (int j = 0; j < conclusions.Total(); j++) {
      CDictionary_Obj_Obj *p_rf = conclusions.GetNodeAtIndex(j);
      CMamdaniFuzzyRule *rule = p_rf.Key();
      if (rule.Conclusion().Var() == var) {
        mfList.Add(p_rf.Value());
      }
    }
    MfCompositionType composType;
    switch (m_aggr_method) {
    case MaxAgg:
      composType = MaxMF;
      break;
    case SumAgg:
      composType = SumMF;
      break;
    default: {
      Print("Internal exception.");

      return (NULL);
    }
    }
    CDictionary_Obj_Obj *p_vf = new CDictionary_Obj_Obj;
    CCompositeMembershipFunction *func =
        new CCompositeMembershipFunction(composType, mfList);
    p_vf.SetAll(var, func);
    fuzzyResult.Add(p_vf);
  }

  return (fuzzyResult);
}

CList *CMamdaniFuzzySystem::Defuzzify(CList *fuzzyResult) {
  CList *crispResult = new CList;
  for (int i = 0; i < fuzzyResult.Total(); i++) {
    CDictionary_Obj_Double *p_vd = new CDictionary_Obj_Double;
    CDictionary_Obj_Obj *p_vf = fuzzyResult.GetNodeAtIndex(i);
    CFuzzyVariable *var = p_vf.Key();
    p_vd.SetAll(var, Defuzzify(p_vf.Value(), var.Min(), var.Max()));
    crispResult.Add(p_vd);
  }

  return (crispResult);
}

double CMamdaniFuzzySystem::Defuzzify(IMembershipFunction *mf, const double min,
                                      const double max) {
  if (m_defuzz_method == CentroidDef) {
    int k = 50;
    double step = (max - min) / k;

    double ptLeft = 0.0;
    double ptCenter = 0.0;
    double ptRight = 0.0;
    double valLeft = 0.0;
    double valCenter = 0.0;
    double valRight = 0.0;
    double val2Left = 0.0;
    double val2Center = 0.0;
    double val2Right = 0.0;
    double numerator = 0.0;
    double denominator = 0.0;
    for (int i = 0; i < k; i++) {
      if (i == 0) {
        ptRight = min;
        valRight = mf.GetValue(ptRight);
        val2Right = ptRight * valRight;
      }
      ptLeft = ptRight;
      ptCenter = min + step * ((double)i + 0.5);
      ptRight = min + step * (i + 1);
      valLeft = valRight;
      valCenter = mf.GetValue(ptCenter);
      valRight = mf.GetValue(ptRight);
      val2Left = val2Right;
      val2Center = ptCenter * valCenter;
      val2Right = ptRight * valRight;
      numerator += step * (val2Left + 4 * val2Center + val2Right) / 3.0;
      denominator += step * (valLeft + 4 * valCenter + valRight) / 3.0;
    }
    delete mf;
    if (denominator != 0) {

      return (numerator / denominator);
    } else {

      return (MathLog(-1));
    }
  } else if (m_defuzz_method == BisectorDef) {

    double Area = 0.0;
    int k = 50;
    double now = min;
    for (int i = 0; i < k; i++) {
      Area += mf.GetValue(now);
      now = now + (max - min) / k;
    }
    now = min;
    double halfArea = fabs(Area / 2 - mf.GetValue(min));
    Area = 0.0;
    while (true) {
      Area += mf.GetValue(now);
      if (Area >= halfArea) {
        break;
      }
      now = now + (max - min) / k;
    }
    delete mf;

    return (now);
  } else if (m_defuzz_method == AverageMaximumDef) {

    double sum_max = 0;
    double count_max = 0;
    int k = 50;
    double now = min;
    double step = (max - min) / k;
    for (int i = 1; i < k; i++) {
      double point_1 = mf.GetValue(now);
      double point_0 = mf.GetValue(now - step);
      double point_2 = mf.GetValue(now + step);

      if (i == 1) {
        if (mf.GetValue(min) > mf.GetValue(min + step)) {
          sum_max += mf.GetValue(min);
          count_max++;
        }
      }

      if (i == k - 1) {
        if (mf.GetValue(max) > mf.GetValue(max - step)) {
          sum_max += mf.GetValue(max);
          count_max++;
        }
      }

      if ((point_1 > point_0) && (point_1 > point_2)) {
        sum_max += point_1;
        count_max++;
      }
    }
    if (count_max == 0) {
      delete mf;

      return (0);
    } else {
      delete mf;

      return (sum_max / count_max);
    }
  } else if (m_defuzz_method == LargestMaximumDef) {
    CArrayDouble *local_max = new CArrayDouble;
    double result;
    int k = 50;
    double now = min;
    double step = (max - min) / k;
    for (int i = 1; i < k; i++) {
      double point_1 = mf.GetValue(now);
      double point_0 = mf.GetValue(now - step);
      double point_2 = mf.GetValue(now + step);

      if (i == 1) {
        if (mf.GetValue(min) > mf.GetValue(min + step)) {
          local_max.Add(mf.GetValue(min));
        }
      }

      if (i == k - 1) {
        if (mf.GetValue(max) > mf.GetValue(max - step)) {
          local_max.Add(mf.GetValue(max));
        }
      }

      if ((point_1 > point_0) && (point_1 > point_2)) {
        local_max.Add(point_1);
      }
      now += step;
    }
    result = local_max.At(0);
    for (int i = 0; i < local_max.Total(); i++) {
      if (result <= local_max.At(i)) {
        result = local_max.At(i);
      }
    }
    now = min;
    while (true) {
      if (mf.GetValue(now) == result) {
        break;
      }
      now += step;
    }
    delete local_max;
    delete mf;

    return (now);
  } else if (m_defuzz_method == SmallestMaximumDef) {
    CArrayDouble *local_max = new CArrayDouble;
    double result;
    int k = 50;
    double now = min;
    double step = (max - min) / k;
    for (int i = 1; i < k; i++) {
      double point_1 = mf.GetValue(now);
      double point_0 = mf.GetValue(now - step);
      double point_2 = mf.GetValue(now + step);

      if (i == 1) {
        if (mf.GetValue(min) > mf.GetValue(min + step)) {
          local_max.Add(mf.GetValue(min));
        }
      }

      if (i == k - 1) {
        if (mf.GetValue(max) > mf.GetValue(max - step)) {
          local_max.Add(mf.GetValue(max));
        }
      }

      if ((point_1 > point_0) && (point_1 > point_2)) {
        local_max.Add(point_1);
      }
      now += step;
    }
    result = local_max.At(0);
    for (int i = 0; i < local_max.Total(); i++) {
      if (result >= local_max.At(i)) {
        result = local_max.At(i);
      }
    }
    now = min;
    while (true) {
      if (mf.GetValue(now) == result) {
        break;
      }
      now += step;
    }
    delete local_max;
    delete mf;

    return (now);
  } else {
    Print("Internal exception.");
    delete mf;

    return (0);
  }
}

#endif
