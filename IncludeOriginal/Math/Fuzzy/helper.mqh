#ifndef HELPER_H
#define HELPER_H

#include "InferenceMethod.mqh"
#include <Arrays\List.mqh>

class INamedValue : public CObject {
public:
  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_INamedValue);
  }

  virtual string Name(void) {
    return ("");
  }
  virtual void Name(const string name) {
  }
};

class INamedVariable : public INamedValue {
public:
  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_INamedValue);
  }

  virtual CList *Values(void) {
    return (NULL);
  }
};

class CNamedVariableImpl : public INamedVariable {
private:
  string m_name;

public:
  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_NamedVariableImpl);
  }

  virtual void Name(const string name);
  virtual string Name(void) {
    return (m_name);
  }

  virtual CList *Values(void) {
    return (NULL);
  }
};

void CNamedVariableImpl::Name(const string name) {
  if (!CNameHelper::IsValidName(name)) {
    Print("Invalid variable name.");
  }
  m_name = name;
}

class CNamedValueImpl : public INamedValue {
private:
  string m_name;

public:
  virtual bool IsTypeOf(EnType type) {
    return (type == TYPE_CLASS_NamedVariableImpl);
  }

  virtual void Name(const string name);
  virtual string Name(void) {
    return (m_name);
  }
};

void CNamedValueImpl::Name(const string name) {
  if (!CNameHelper::IsValidName(name)) {
    Print("Invalid term name.");
  }
  m_name = name;
}

static string KEYWORDS[] = {"if",       "then",     "is",   "and",
                            "or",       "not",      "(",    ")",
                            "slightly", "somewhat", "very", "extremely"};

class CNameHelper {
public:
  static bool IsValidName(const string name) {

    if (StringLen(name) == 0) {

      return (false);
    }

    for (int i = 0; i < StringLen(name); i++) {

      char s = (char)StringGetCharacter(name, i);
      if (s != '_' && !(s >= 48 && s <= 57) && !(s >= 65 && s <= 90) &&
          !(s >= 97 && s <= 122)) {

        return (false);
      }
    }

    for (int i = 0; i < ArraySize(KEYWORDS); i++) {
      if (name == KEYWORDS[i]) {

        return (false);
      }
    }

    return (true);
  }
};

#endif
