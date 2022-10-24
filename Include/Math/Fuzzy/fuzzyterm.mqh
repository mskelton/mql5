#ifndef FUZZYTERM_H
#define FUZZYTERM_H

#include "Helper.mqh"
#include "MembershipFunction.mqh"
#include <Arrays/List.mqh>

class CFuzzyTerm : public CNamedValueImpl {
private:
  IMembershipFunction *m_mf;

public:
  CFuzzyTerm(const string name, IMembershipFunction *mf);
  ~CFuzzyTerm(void);

  virtual bool IsTypeOf(EnType type) ;

  IMembershipFunction *MembershipFunction() ;
};



#endif
