#ifndef FUZZYRULE_H
#define FUZZYRULE_H

#include "FuzzyVariable.mqh"
#include "InferenceMethod.mqh"
#include <Arrays/List.mqh>

enum OperatorType { And, Or };

enum HedgeType { None, Slightly, Somewhat, Very, Extremely };

class ICondition : public CObject {
public:
  virtual bool IsTypeOf(EnCondition type) ;
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

  INamedVariable *Var(void) ;
  void Var(INamedVariable *value) ;

  bool Not(void) ;
  void Not(bool not ) ;

  INamedValue *Term(void) ;
  void Term(INamedValue *value) ;

  virtual bool IsTypeOf(EnCondition type) ;
};





class CFuzzyCondition : public CSingleCondition {
private:
  HedgeType m_hedge;

public:
  CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term, bool not );
  CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term, bool not,
                  HedgeType hedge);
  CFuzzyCondition(CFuzzyVariable *var, CFuzzyTerm *term);
  ~CFuzzyCondition(void);

  HedgeType Hedge(void) ;
  void Hedge(HedgeType value) ;

  virtual bool IsTypeOf(EnCondition type) ;
};





class CConditions : public ICondition {
private:
  bool m_not;
  OperatorType m_op;
  CList *m_conditions;

public:
  CConditions(void);
  ~CConditions(void);

  bool Not(void) ;
  void Not(bool value) ;

  OperatorType Op(void) ;
  void Op(OperatorType value) ;

  CList *ConditionsList(void) ;

  virtual bool IsTypeOf(EnCondition type) ;
};



class IParsableRule : public CObject {
public:
  virtual CConditions *Condition(void) ;
  virtual void Condition(CConditions *value) ;

  virtual CSingleCondition *Conclusion(void) ;
  virtual void Conclusion(CSingleCondition *value) ;

  virtual bool IsTypeOf(EnRule type) ;
};

class CGenericFuzzyRule : public IParsableRule {
private:
  CConditions *m_generic_condition;

public:
  CGenericFuzzyRule(void);
  ~CGenericFuzzyRule(void);

  CConditions *Condition(void) ;
  void Condition(CConditions *value) ;

  CFuzzyCondition *CreateCondition(CFuzzyVariable *var, CFuzzyTerm *term);
  CFuzzyCondition *CreateCondition(CFuzzyVariable *var, CFuzzyTerm *term,
                                   bool not );
  CFuzzyCondition *CreateCondition(CFuzzyVariable *var, CFuzzyTerm *term,
                                   bool not, HedgeType hedge);

  virtual CSingleCondition *Conclusion(void) ;
  virtual void Conclusion(CSingleCondition *value) ;

  virtual bool IsTypeOf(EnRule type) ;
};






class CMamdaniFuzzyRule : public CGenericFuzzyRule {
private:
  CSingleCondition *m_mamdani_conclusion;
  double m_weight;

public:
  CMamdaniFuzzyRule(void);
  ~CMamdaniFuzzyRule(void);

  CSingleCondition *Conclusion(void) ;
  void Conclusion(CSingleCondition *value) ;

  double Weight(void) ;
  void Weight(const double value) ;

  virtual bool IsTypeOf(EnRule type) ;
};



class CSugenoFuzzyRule : public CGenericFuzzyRule {
private:
  CSingleCondition *m_sugeno_conclusion;

public:
  CSugenoFuzzyRule(void);
  ~CSugenoFuzzyRule(void);

  CSingleCondition *Conclusion(void) ;
  void Conclusion(CSingleCondition *value) ;

  virtual bool IsTypeOf(EnRule type) ;
};



#endif
