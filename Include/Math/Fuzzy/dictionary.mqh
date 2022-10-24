#ifndef DICTIONARY_H
#define DICTIONARY_H

#include "RuleParser.mqh"
#include <Arrays/List.mqh>
#include <Object.mqh>

bool TryGetValue(CList *list, string key, CObject *&value) ;

void RemoveRange(CArrayObj &list, const int index, const int count) ;

CArrayObj *GetRange(CArrayObj *list, const int index, const int count) ;

class CDictionary_Obj_Obj : public CObject {
private:
  CObject *m_key;
  CObject *m_value;

public:
  CDictionary_Obj_Obj(void);
  ~CDictionary_Obj_Obj(void);

  CObject *Key() ;
  void Key(CObject *key) ;

  CObject *Value() ;
  void Value(CObject *value) ;

  void SetAll(CObject *key, CObject *value);
};




class CDictionary_String_Obj : public CObject {
private:
  string m_key;
  CObject *m_value;

public:
  CDictionary_String_Obj(void);
  ~CDictionary_String_Obj(void);

  string Key() ;
  void Key(const string key) ;

  CObject *Value() ;
  void Value(CObject *value) ;

  void SetAll(const string key, CObject *value);
};




class CDictionary_Obj_Double : public CObject {
private:
  CObject *m_key;
  double m_value;

public:
  CDictionary_Obj_Double(void);
  ~CDictionary_Obj_Double(void);

  CObject *Key() ;
  void Key(CObject *key) ;

  double Value() ;
  void Value(const double value) ;

  void SetAll(CObject *key, const double value);
};




#endif
