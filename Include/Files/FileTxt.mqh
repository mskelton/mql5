#ifndef FILE_TXT_H
#define FILE_TXT_H

#include "File.mqh"

class CFileTxt : public CFile {
public:
  CFileTxt(void);
  ~CFileTxt(void);

  int Open(const string file_name, const int open_flags);

  uint WriteString(const string value);
  string ReadString(void);
};






#endif
