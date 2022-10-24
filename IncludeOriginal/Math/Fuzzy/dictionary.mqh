#ifndef DICTIONARY_H
#define DICTIONARY_H

#include "RuleParser.mqh"
#include <Arrays\List.mqh>
#include <Object.mqh>

bool TryGetValue(CList *list, string key, CObject *&value) {
  for (int i = 0; i < list.Total(); i++) {
    CDictionary_String_Obj *pair = list.GetNodeAtIndex(i);
    if (pair.Key() == key) {
      value = pair.Value();
      return (true);
    }
  }
  return (false);
}

void RemoveRange(CArrayObj &list, const int index, const int count) {
  for (int i = 0; i < count; i++) {
    list.Delete(index);
  }
}

CArrayObj *GetRange(CArrayObj *list, const int index, const int count) {
  CArrayObj *new_list = new CArrayObj;
  for (int i = 0; i < count; i++) {
    new_list.Add(list.At(i + index));
  }
  return (new_list);
}

class CDictionary_Obj_Obj : public CObject {
private:
  CObject *m_key;
  CObject *m_value;

public:
  CDictionary_Obj_Obj(void);
  ~CDictionary_Obj_Obj(void);

  CObject *Key() {
    return (m_key);
  }
  void Key(CObject *key) {
    m_key = key;
  }

  CObject *Value() {
    return (m_value);
  }
  void Value(CObject *value) {
    m_value = value;
  }

  void SetAll(CObject *key, CObject *value);
};

CDictionary_Obj_Obj::CDictionary_Obj_Obj(void) {}

CDictionary_Obj_Obj::~CDictionary_Obj_Obj() {}

void CDictionary_Obj_Obj::SetAll(CObject *key, CObject *value) {
  m_key = key;
  m_value = value;
}

class CDictionary_String_Obj : public CObject {
private:
  string m_key;
  CObject *m_value;

public:
  CDictionary_String_Obj(void);
  ~CDictionary_String_Obj(void);

  string Key() {
    return (m_key);
  }
  void Key(const string key) {
    m_key = key;
  }

  CObject *Value() {
    return (m_value);
  }
  void Value(CObject *value) {
    m_value = value;
  }

  void SetAll(const string key, CObject *value);
};

CDictionary_String_Obj::CDictionary_String_Obj(void) {}

CDictionary_String_Obj::~CDictionary_String_Obj() {
  if (CheckPointer(m_value) == POINTER_DYNAMIC)
    delete m_value;
}

void CDictionary_String_Obj::SetAll(const string key, CObject *value) {
  m_key = key;
  m_value = value;
}

class CDictionary_Obj_Double : public CObject {
private:
  CObject *m_key;
  double m_value;

public:
  CDictionary_Obj_Double(void);
  ~CDictionary_Obj_Double(void);

  CObject *Key() {
    return (m_key);
  }
  void Key(CObject *key) {
    m_key = key;
  }

  double Value() {
    return (m_value);
  }
  void Value(const double value) {
    m_value = value;
  }

  void SetAll(CObject *key, const double value);
};

CDictionary_Obj_Double::CDictionary_Obj_Double(void) {}

CDictionary_Obj_Double::~CDictionary_Obj_Double() {}

void CDictionary_Obj_Double::SetAll(CObject *key, const double value) {
  m_key = key;
  m_value = value;
}

#endif
