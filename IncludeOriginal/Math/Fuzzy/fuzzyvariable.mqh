#ifndef FUZZYVARIABLE_H
#define FUZZYVARIABLE_H

#include "FuzzyTerm.mqh"
#include <Arrays\List.mqh>

class CFuzzyVariable : public CNamedVariableImpl {
private:
  double m_min;
  double m_max;
  CList *m_terms;

public:
  CFuzzyVariable(const string name, const double min, const double max);
  ~CFuzzyVariable(void);

  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_FuzzyVariable);
  }

  void Max(const double max) {
    m_max = max;
  }
  double Max(void) {
    return (m_max);
  }
  void Min(const double min) {
    m_min = min;
  }
  double Min(void) {
    return (m_min);
  }

  CList *Terms() {
    return (m_terms);
  }
  void Terms(CList *terms) {
    m_terms = terms;
  }

  void AddTerm(CFuzzyTerm *term);

  CFuzzyTerm *GetTermByName(const string name);

  CList *Values() {
    return (m_terms);
  }
};

CFuzzyVariable::CFuzzyVariable(const string name, const double min,
                               const double max) {
  CNamedVariableImpl::Name(name);
  m_terms = new CList();
  if (min > max) {
    Print("Incorrect parameters! Maximum value must be greater than minimum "
          "one.");
  } else {
    m_min = min;
    m_max = max;
  }
}

CFuzzyVariable::~CFuzzyVariable(void) {
  delete m_terms;
}

void CFuzzyVariable::AddTerm(CFuzzyTerm *term) {
  m_terms.Add(term);
}

CFuzzyTerm *CFuzzyVariable::GetTermByName(const string name) {
  for (int i = 0; i < m_terms.Total(); i++) {
    CFuzzyTerm *term = m_terms.GetNodeAtIndex(i);
    if (term.Name() == name) {

      return (term);
    }
  }
  Print("Term with the same name can not be found!");

  return (NULL);
}

#endif
