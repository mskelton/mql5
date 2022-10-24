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

CFileTxt::CFileTxt(void) {
}

CFileTxt::~CFileTxt(void) {
}

int CFileTxt::Open(const string file_name, const int open_flags) {
  return (CFile::Open(file_name, open_flags | FILE_TXT));
}

uint CFileTxt::WriteString(const string value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteString(m_handle, value));

  return (0);
}

string CFileTxt::ReadString(void) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadString(m_handle));

  return ("");
}

#endif
