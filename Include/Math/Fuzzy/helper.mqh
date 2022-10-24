#ifndef HELPER_H
#define HELPER_H

#include "InferenceMethod.mqh"
#include <Arrays/List.mqh>

class INamedValue : public CObject {
public:
  virtual bool IsTypeOf(EnType type) ;

  virtual string Name(void) ;
  virtual void Name(const string name) ;
};

class INamedVariable : public INamedValue {
public:
  virtual bool IsTypeOf(EnType type) ;

  virtual CList *Values(void) ;
};

class CNamedVariableImpl : public INamedVariable {
private:
  string m_name;

public:
  virtual bool IsTypeOf(EnType type) ;

  virtual void Name(const string name);
  virtual string Name(void) ;

  virtual CList *Values(void) ;
};


class CNamedValueImpl : public INamedValue {
private:
  string m_name;

public:
  virtual bool IsTypeOf(EnType type) ;

  virtual void Name(const string name);
  virtual string Name(void) ;
};


static string KEYWORDS[] = ;"if",       "then",     "is",   "and",

class CNameHelper {
public:
  static bool IsValidName(const string name) ;
};

#endif
