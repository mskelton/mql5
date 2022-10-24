#ifndef STRING_H
#define STRING_H

#include <Object.mqh>

class CString : public CObject {
protected:
  string m_string;

public:
  CString(void);
  ~CString(void);

  string Str(void) const ;
  uint Len(void) const ;
  void Copy(string &copy) const;
  void Copy(CString *copy) const;

  bool Fill(const short character) ;
  void Assign(const string str) ;
  void Assign(const CString *str) ;
  void Append(const string str);
  void Append(const CString *str);
  uint Insert(const uint pos, const string substring);
  uint Insert(const uint pos, const CString *substring);

  int Compare(const string str) const;
  int Compare(const CString *str) const;
  int CompareNoCase(const string str) const;
  int CompareNoCase(const CString *str) const;

  string Left(const uint count) const;
  string Right(const uint count) const;
  string Mid(const uint pos, const uint count) const;

  int Trim(const string targets);
  int TrimLeft(const string targets);
  int TrimRight(const string targets);
  bool Clear(void) ;

  bool ToUpper(void) ;
  bool ToLower(void) ;
  void Reverse(void);

  int Find(const uint start, const string substring) const;
  int FindRev(const string substring) const;
  uint Remove(const string substring);
  uint Replace(const string substring, const string newstring);

protected:
  virtual int Compare(const CObject *node, const int mode = 0) const;
};

























#endif
