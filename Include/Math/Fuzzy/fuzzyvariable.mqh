#ifndef FUZZYVARIABLE_H
#define FUZZYVARIABLE_H

#include "FuzzyTerm.mqh"
#include <Arrays/List.mqh>

class CFuzzyVariable : public CNamedVariableImpl {
private:
  double m_min;
  double m_max;
  CList *m_terms;

public:
  CFuzzyVariable(const string name, const double min, const double max);
  ~CFuzzyVariable(void);

  virtual bool IsTypeOf(EnType type) ;

  void Max(const double max) ;
  double Max(void) ;
  void Min(const double min) ;
  double Min(void) ;

  CList *Terms() ;
  void Terms(CList *terms) ;

  void AddTerm(CFuzzyTerm *term);

  CFuzzyTerm *GetTermByName(const string name);

  CList *Values() ;
};





#endif
