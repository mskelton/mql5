#ifndef INFERENCEMETHOD_H
#define INFERENCEMETHOD_H

#include <Arrays\List.mqh>

enum AndMethod { MinAnd, ProductionAnd };

enum OrMethod { MaxOr, ProbabilisticOr };

enum ImplicationMethod { MinIpm, ProductionImp };

enum AggregationMethod { MaxAgg, SumAgg };

enum DefuzzificationMethod {
  CentroidDef,
  BisectorDef,
  AverageMaximumDef,
  LargestMaximumDef,
  SmallestMaximumDef
};

enum EnType {
  TYPE_CLASS_INamedValue,
  TYPE_CLASS_INamedVariable,
  TYPE_CLASS_NamedVariableImpl,
  TYPE_CLASS_NamedValueImpl,
  TYPE_CLASS_FuzzyTerm,
  TYPE_CLASS_FuzzyVariable,
  TYPE_CLASS_SugenoVariable,
  TYPE_CLASS_ISugenoFunction,
  TYPE_CLASS_LinearSugenoFunction
};

enum EnLexem {
  TYPE_CLASS_IExpression,
  TYPE_CLASS_Lexem,
  TYPE_CLASS_ConditionExpression,
  TYPE_CLASS_VarLexem,
  TYPE_CLASS_KeywordLexem,
  TYPE_CLASS_AltLexem,
  TYPE_CLASS_TermLexem
};

enum EnCondition {
  TYPE_CLASS_ICondition,
  TYPE_CLASS_Conditions,
  TYPE_CLASS_SingleCondition,
  TYPE_CLASS_FuzzyCondition
};

enum EnRule {
  TYPE_CLASS_IParsableRule,
  TYPE_CLASS_GenericFuzzyRule,
  TYPE_CLASS_MamdaniFuzzyRule,
  TYPE_CLASS_SugenoFuzzyRule
};

#endif
