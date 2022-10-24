#ifndef FUZZYRULE_H
#define FUZZYRULE_H

#include "FuzzyVariable.mqh"
#include "InferenceMethod.mqh"
#include <Arrays\List.mqh>

enum OperatorType { And, Or };

enum HedgeType { None, Slightly, Somewhat, Very, Extremely };

class ICondition : public CObject {
public:
  virtual bool IsTypeOf(EnCondition type) {
    return (type == TYPE_CLASS_ICondition);
  }
};

class CSingleCondition : public ICondition {
private:
  INamedVariable *m_var;
  INamedValue *m_term;
  bool m_not;

public:
  CSingleCondition(void);
  CSingleCondition(INamedVariable *var, INamedValue *term);
  CSingleCondition(INamedVariable *var, INamedValue *term, bool not );
  ~CSingleCondition(void);

  INamedVariable *Var(void) {
    return (m_var);
  }
  void Var(INamedVariable *value) {
    m_var = value;
  }

  bool Not(void) {
    return (m_not);
  }
  void Not(bool not ) {
    m_not = not ;
  }

  INamedValue *Term(void) {
    return (m_term);
  }
  void Term(INamedValue *value) {
    m_term = value;
  }

  virtual bool IsTypeOf(EnCondition type) {
    return (type == TYPE_CLASS_SingleCondition);
  }
};

CSingleCondition::CSingleCondition(void) {
  m_var = NULL;
  m_not = false;
  m_term = NULL;
};

CSingleCondition::CSingleCondition(INamedVariable *var, INamedValue *term) {
  m_var = var;
  m_term = term;
}

CSingleCondition::CSingleCondition(INamedVariable *var, INamedValue *term,
                                   bool not ) {
  m_var = var;
  m_term = term;
  m_not = not ;
}

CSingleCondition::~CSingleCondition(void) {
  if (CheckPointer(m_var) == POINTER_DYNAMIC)
    delete m_var;
  if (CheckPointer(m_term) == POINTER_DYNAMIC)
    delete m_term;
}

class CFuzzyCondition : public CSingleCondition {
private:
  HedgeType m_hedge;

public:
  CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term, bool not );
  CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term, bool not,
                  HedgeType hedge);
  CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term);
  ~CFuzzyCondition(void);

  HedgeType Hedge(void) {
    return (m_hedge);
  }
  void Hedge(HedgeType value) {
    m_hedge = value;
  }

  virtual bool IsTypeOf(EnCondition type) {
    return (type == TYPE_CLASS_FuzzyCondition);
  }
};

CFuzzyCondition::CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term,
                                 bool not ) {
  CSingleCondition::Var(var);
  CSingleCondition::Term(term);
  CSingleCondition::Not(not );
  m_hedge = None;
}

CFuzzyCondition::CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term,
                                 bool not, HedgeType hedge) {
  CSingleCondition::Var(var);
  CSingleCondition::Term(term);
  CSingleCondition::Not(not );
  m_hedge = hedge;
}

CFuzzyCondition::CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term)

{
  CSingleCondition::Var(var);
  CSingleCondition::Term(term);
  CSingleCondition::Not(false);
}

CFuzzyCondition::~CFuzzyCondition(void) {
}

class CConditions : public ICondition {
private:
  bool m_not;
  OperatorType m_op;
  CList *m_conditions;

public:
  CConditions(void);
  ~CConditions(void);

  bool Not(void) {
    return (m_not);
  }
  void Not(bool value) {
    m_not = value;
  }

  OperatorType Op(void) {
    return (m_op);
  }
  void Op(OperatorType value) {
    m_op = value;
  }

  CList *ConditionsList(void) {
    return (m_conditions);
  }

  virtual bool IsTypeOf(EnCondition type) {
    return (type == TYPE_CLASS_Conditions);
  }
};

CConditions::CConditions(void) {
  m_not = false;
  m_op = And;
  m_conditions = new CList;
}

CConditions::~CConditions(void) {
  delete m_conditions;
}

class IParsableRule : public CObject {
public:
  virtual CConditions *Condition(void) {
    return (NULL);
  }
  virtual void Condition(CConditions *value) {
  }

  virtual CSingleCondition *Conclusion(void) {
    return (NULL);
  }
  virtual void Conclusion(CSingleCondition *value) {
  }

  virtual bool IsTypeOf(EnRule type) {
    return (type == TYPE_CLASS_IParsableRule);
  }
};

class CGenericFuzzyRule : public IParsableRule {
private:
  CConditions *m_generic_condition;

public:
  CGenericFuzzyRule(void);
  ~CGenericFuzzyRule(void);

  CConditions *Condition(void) {
    return (m_generic_condition);
  }
  void Condition(CConditions *value) {
    m_generic_condition = value;
  }

  CFuzzyCondition *CreateCondition(CFuzzyVariable *var, CFuzzyTerm *term);
  CFuzzyCondition *CreateCondition(CFuzzyVariable *var, CFuzzyTerm *term,
                                   bool not );
  CFuzzyCondition *CreateCondition(CFuzzyVariable *var, CFuzzyTerm *term,
                                   bool not, HedgeType hedge);

  virtual CSingleCondition *Conclusion(void) {
    return (NULL);
  }
  virtual void Conclusion(CSingleCondition *value) {
  }

  virtual bool IsTypeOf(EnRule type) {
    return (type == TYPE_CLASS_GenericFuzzyRule);
  }
};

CGenericFuzzyRule::CGenericFuzzyRule(void) {
  m_generic_condition = new CConditions();
}

CGenericFuzzyRule::~CGenericFuzzyRule(void) {
  delete m_generic_condition;
}

CFuzzyCondition *CGenericFuzzyRule::CreateCondition(CFuzzyVariable *var,
                                                    CFuzzyTerm *term) {

  return new CFuzzyCondition(var, term);
}

CFuzzyCondition *CGenericFuzzyRule::CreateCondition(CFuzzyVariable *var,
                                                    CFuzzyTerm *term,
                                                    bool not ) {

  return new CFuzzyCondition(var, term, not );
}

CFuzzyCondition *CGenericFuzzyRule::CreateCondition(CFuzzyVariable *var,
                                                    CFuzzyTerm *term, bool not,
                                                    HedgeType hedge) {

  return new CFuzzyCondition(var, term, not, hedge);
}

class CMamdaniFuzzyRule : public CGenericFuzzyRule {
private:
  CSingleCondition *m_mamdani_conclusion;
  double m_weight;

public:
  CMamdaniFuzzyRule(void);
  ~CMamdaniFuzzyRule(void);

  CSingleCondition *Conclusion(void) {
    return (m_mamdani_conclusion);
  }
  void Conclusion(CSingleCondition *value) {
    m_mamdani_conclusion = value;
  }

  double Weight(void) {
    return (m_weight);
  }
  void Weight(const double value) {
    m_weight = value;
  }

  virtual bool IsTypeOf(EnRule type) {
    return (type == TYPE_CLASS_MamdaniFuzzyRule);
  }
};

CMamdaniFuzzyRule::CMamdaniFuzzyRule(void) {
  m_weight = 1.0;
}

CMamdaniFuzzyRule::~CMamdaniFuzzyRule(void) {
  if (CheckPointer(m_mamdani_conclusion) == POINTER_DYNAMIC)
    delete m_mamdani_conclusion;
}

class CSugenoFuzzyRule : public CGenericFuzzyRule {
private:
  CSingleCondition *m_sugeno_conclusion;

public:
  CSugenoFuzzyRule(void);
  ~CSugenoFuzzyRule(void);

  CSingleCondition *Conclusion(void) {
    return (m_sugeno_conclusion);
  }
  void Conclusion(CSingleCondition *value) {
    m_sugeno_conclusion = value;
  }

  virtual bool IsTypeOf(EnRule type) {
    return (type == TYPE_CLASS_SugenoFuzzyRule);
  }
};

CSugenoFuzzyRule::CSugenoFuzzyRule(void) {
}

CSugenoFuzzyRule::~CSugenoFuzzyRule(void) {
  if (CheckPointer(m_sugeno_conclusion) == POINTER_DYNAMIC)
    delete m_sugeno_conclusion;
}

#endif
