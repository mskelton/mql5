#ifndef STRING_H
#define STRING_H

#include <Object.mqh>

class CString : public CObject {
protected:
  string m_string;

public:
  CString(void);
  ~CString(void);

  string Str(void) const {
    return (m_string);
  };
  uint Len(void) const {
    return (StringLen(m_string));
  };
  void Copy(string &copy) const;
  void Copy(CString *copy) const;

  bool Fill(const short character) {
    return (StringFill(m_string, character));
  };
  void Assign(const string str) {
    m_string = str;
  };
  void Assign(const CString *str) {
    m_string = str.Str();
  };
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
  bool Clear(void) {
    return (StringInit(m_string));
  };

  bool ToUpper(void) {
    return (StringToUpper(m_string));
  };
  bool ToLower(void) {
    return (StringToLower(m_string));
  };
  void Reverse(void);

  int Find(const uint start, const string substring) const;
  int FindRev(const string substring) const;
  uint Remove(const string substring);
  uint Replace(const string substring, const string newstring);

protected:
  virtual int Compare(const CObject *node, const int mode = 0) const;
};

CString::CString(void) : m_string("") {
}

CString::~CString(void) {
}

void CString::Copy(string &copy) const {
  copy = m_string;
}

void CString::Copy(CString *copy) const {
  copy.Assign(m_string);
}

void CString::Append(const string str) {
  m_string += str;
}

void CString::Append(const CString *str) {

  if (!CheckPointer(str))
    return;

  m_string += str.Str();
}

uint CString::Insert(const uint pos, const string substring) {
  string tmp = StringSubstr(m_string, 0, pos);

  tmp += substring;
  m_string = tmp + StringSubstr(m_string, pos);

  return (StringLen(m_string));
}

uint CString::Insert(const uint pos, const CString *substring) {

  if (!CheckPointer(substring))
    return (0);

  string tmp = StringSubstr(m_string, 0, pos);

  tmp += substring.Str();
  m_string = tmp + StringSubstr(m_string, pos);

  return (StringLen(m_string));
}

int CString::Compare(const string str) const {
  if (m_string < str)
    return (-1);
  if (m_string > str)
    return (1);

  return (0);
}

int CString::Compare(const CString *str) const {

  if (!CheckPointer(str))
    return (0);

  if (m_string < str.Str())
    return (-1);
  if (m_string > str.Str())
    return (1);

  return (0);
}

int CString::CompareNoCase(const string str) const {
  string tmp1, tmp2;

  tmp1 = m_string;
  tmp2 = str;
  StringToLower(tmp1);
  StringToLower(tmp2);

  if (tmp1 < tmp2)
    return (-1);
  if (tmp1 > tmp2)
    return (1);

  return (0);
}

int CString::CompareNoCase(const CString *str) const {
  string tmp1, tmp2;

  if (!CheckPointer(str))
    return (0);

  tmp1 = m_string;
  tmp2 = str.Str();
  StringToLower(tmp1);
  StringToLower(tmp2);

  if (tmp1 < tmp2)
    return (-1);
  if (tmp1 > tmp2)
    return (1);

  return (0);
}

int CString::Find(const uint start, const string substring) const {
  return (StringFind(m_string, substring, start));
}

int CString::FindRev(const string substring) const {
  int result, pos = -1;

  do {
    result = pos;
  } while ((pos = StringFind(m_string, substring, pos + 1)) >= 0);

  return (result);
}

string CString::Left(const uint count) const {
  return (StringSubstr(m_string, 0, count));
}

string CString::Right(const uint count) const {
  return (StringSubstr(m_string, StringLen(m_string) - count, count));
}

string CString::Mid(const uint pos, const uint count) const {
  return (StringSubstr(m_string, pos, count));
}

int CString::Trim(const string targets) {
  return (TrimLeft(targets) + TrimRight(targets));
}

int CString::TrimLeft(const string targets) {
  ushort ch;

  for (int i = 0; i < StringLen(m_string); i++) {
    ch = StringGetCharacter(m_string, i);
    if (ch <= ' ')
      continue;
    for (int j = 0; j < StringLen(targets); j++) {
      if (ch == StringGetCharacter(targets, j)) {
        StringSetCharacter(m_string, i, ' ');
        ch = ' ';
      }
    }
    if (ch != ' ')
      break;
  }

  return (StringTrimLeft(m_string));
}

int CString::TrimRight(const string targets) {
  ushort ch;

  for (int i = StringLen(m_string) - 1; i >= 0; i--) {
    ch = StringGetCharacter(m_string, i);
    if (ch <= ' ')
      continue;
    for (int j = 0; j < StringLen(targets); j++) {
      if (ch == StringGetCharacter(targets, j)) {
        StringSetCharacter(m_string, i, ' ');
        ch = ' ';
      }
    }
    if (ch != ' ')
      break;
  }

  return (StringTrimRight(m_string));
}

void CString::Reverse(void) {
  ushort ch;
  int i, j;

  for (i = StringLen(m_string) - 1, j = 0; i > j; i--, j++) {
    ch = StringGetCharacter(m_string, i);
    StringSetCharacter(m_string, i, StringGetCharacter(m_string, j));
    StringSetCharacter(m_string, j, ch);
  }
}

uint CString::Remove(const string substring) {
  int result = 0, len, pos = -1;
  string tmp;

  len = StringLen(substring);
  while ((pos = StringFind(m_string, substring, pos)) >= 0) {
    tmp = StringSubstr(m_string, 0, pos);
    m_string = tmp + StringSubstr(m_string, pos + len);
    result++;
  }

  return (result);
}

uint CString::Replace(const string substring, const string newstring) {
  int result = 0, len, pos = -1;
  string tmp;

  len = StringLen(substring);
  while ((pos = StringFind(m_string, substring, pos)) >= 0) {
    tmp = StringSubstr(m_string, 0, pos) + newstring;
    m_string = tmp + StringSubstr(m_string, pos + len);

    pos += StringLen(newstring);
    result++;
  }

  return (result);
}

int CString::Compare(const CObject *node, const int mode = 0) const {
  CString *str = (CString *)node;

  if (str == NULL)
    return (0);

  switch (mode) {
  case 0:
    return (Compare(str));
  case 1:
    return (CompareNoCase(str));
  }

  return (0);
}

#endif
