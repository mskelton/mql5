#ifndef RULEPARSER_H
#define RULEPARSER_H

#include "FuzzyRule.mqh"
#include "Helper.mqh"
#include "InferenceMethod.mqh"
#include "SugenoVariable.mqh"
#include <Arrays/ArrayObj.mqh>
#include <Arrays/List.mqh>

class IExpression : public CObject {
public:
  virtual string Text(void);

  virtual bool IsTypeOf(EnLexem type);
};

class CLexem : public IExpression {
public:
  virtual string Text(void);

  virtual bool IsTypeOf(EnLexem type);
};

class CConditionExpression : public IExpression {
private:
  CArrayObj *m_expressions;
  CFuzzyCondition *m_condition;

public:
  CConditionExpression(CArrayObj *expressions, CFuzzyCondition *condition);
  ~CConditionExpression(void);

  CArrayObj *Expressions(void);
  void Expressions(CArrayObj *value);

  CFuzzyCondition *Condition(void);
  void Condition(CFuzzyCondition *value);

  string Text(void);

  virtual bool IsTypeOf(EnLexem type);
};

class CKeywordLexem : public CLexem {
private:
  string m_name;

public:
  CKeywordLexem(const string name);
  ~CKeywordLexem(void);

  string Text(void);

  virtual bool IsTypeOf(EnLexem type);
};

class CVarLexem : public CLexem {
private:
  INamedVariable *m_var;
  bool m_input;

public:
  CVarLexem(INamedVariable *var, bool in);
  ~CVarLexem(void);

  INamedVariable *Var(void);
  void Var(INamedVariable *var);

  string Text(void);

  bool Input(void);
  void Input(bool value);

  virtual bool IsTypeOf(EnLexem type);
};

class IAltLexem : public CLexem {
public:
  virtual IAltLexem *Alternative(void);
  virtual void Alternative(IAltLexem *value);

  virtual bool IsTypeOf(EnLexem type);
};

class CTermLexem : public IAltLexem {
private:
  INamedValue *m_term;
  IAltLexem *m_alternative;
  bool m_input;

public:
  CTermLexem(INamedValue *term, bool in);
  ~CTermLexem(void);

  INamedValue *Term(void);
  void Term(INamedValue *value);

  string Text(void);

  IAltLexem *Alternative(void);
  void Alternative(IAltLexem *value);

  virtual bool IsTypeOf(EnLexem type);
};

class CRuleParser : public INamedVariable {
public:
  static IParsableRule *Parse(const string rule, IParsableRule *emptyRule,
                              CList *in, CList *out);

private:
  static CList *BuildLexemsList(CList *in, CList *out);
  static void BuildLexemsList(INamedVariable *var, bool in, CList *lexems);
  static CArrayObj *ParseLexems(const string rule, CList *lexems);
  static CArrayObj *ExtractSingleCondidtions(CArrayObj *conditionExpression,
                                             CList *in, CList *lexems);
  static CConditions *ParseConditions(CArrayObj *conditionExpression, CList *in,
                                      CList *lexems);
  static int FindPairBracket(CArrayObj *expressions, CList *lexems);
  static ICondition *ParseConditionsRecurse(CArrayObj *expressions,
                                            CList *lexems);
  static CSingleCondition *ParseConclusion(CArrayObj *conditionExpression,
                                           CList *out, CList *lexems);
};

#endif
