#ifndef FUZZYTERM_H
#define FUZZYTERM_H

#include "Helper.mqh"
#include "MembershipFunction.mqh"
#include <Arrays\List.mqh>

class CFuzzyTerm : public CNamedValueImpl {
private:
  IMembershipFunction *m_mf;

public:
  CFuzzyTerm(const string name, IMembershipFunction *mf);
  ~CFuzzyTerm(void);

  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_FuzzyTerm);
  }

  IMembershipFunction *MembershipFunction() {
    return (m_mf);
  }
};

CFuzzyTerm::CFuzzyTerm(const string name, IMembershipFunction *mf) {
  CNamedValueImpl::Name(name);
  m_mf = mf;
}

CFuzzyTerm::~CFuzzyTerm(void) {
  if (CheckPointer(m_mf) == POINTER_DYNAMIC) {
    delete m_mf;
  }
}

#endif
