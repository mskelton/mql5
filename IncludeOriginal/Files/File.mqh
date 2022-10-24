#ifndef FILE_H
#define FILE_H

#include <Object.mqh>

class CFile : public CObject {
protected:
  int m_handle;
  string m_name;
  int m_flags;

public:
  CFile(void);
  ~CFile(void);

  int Handle(void) const {
    return (m_handle);
  };
  string FileName(void) const {
    return (m_name);
  };
  int Flags(void) const {
    return (m_flags);
  };
  void SetUnicode(const bool unicode);
  void SetCommon(const bool common);

  int Open(const string file_name, int open_flags,
           const short delimiter = '	');
  void Close(void);
  void Delete(void);
  ulong Size(void);
  ulong Tell(void);
  void Seek(const long offset, const ENUM_FILE_POSITION origin);
  void Flush(void);
  bool IsEnding(void);
  bool IsLineEnding(void);

  void Delete(const string file_name, const int common_flag = 0);
  bool IsExist(const string file_name, const int common_flag = 0);
  bool Copy(const string src_name, const int common_flag, const string dst_name,
            const int mode_flags);
  bool Move(const string src_name, const int common_flag, const string dst_name,
            const int mode_flags);

  bool FolderCreate(const string folder_name);
  bool FolderDelete(const string folder_name);
  bool FolderClean(const string folder_name);

  long FileFindFirst(const string file_filter, string &returned_filename);
  bool FileFindNext(const long search_handle, string &returned_filename);
  void FileFindClose(const long search_handle);
};

CFile::CFile(void) : m_handle(INVALID_HANDLE), m_name(""), m_flags(FILE_ANSI) {
}

CFile::~CFile(void) {

  if (m_handle != INVALID_HANDLE)
    Close();
}

void CFile::SetUnicode(const bool unicode) {

  if (m_handle == INVALID_HANDLE) {
    if (unicode)
      m_flags |= FILE_UNICODE;
    else
      m_flags &= ~FILE_UNICODE;
  }
}

void CFile::SetCommon(const bool common) {

  if (m_handle == INVALID_HANDLE) {
    if (common)
      m_flags |= FILE_COMMON;
    else
      m_flags &= ~FILE_COMMON;
  }
}

int CFile::Open(const string file_name, int open_flags, const short delimiter) {

  if (m_handle != INVALID_HANDLE)
    Close();

  if ((open_flags & (FILE_BIN | FILE_CSV)) == 0)
    open_flags |= FILE_TXT;

  m_handle = FileOpen(file_name, open_flags | m_flags, delimiter);
  if (m_handle != INVALID_HANDLE) {

    m_flags |= open_flags;
    m_name = file_name;
  }

  return (m_handle);
}

void CFile::Close(void) {

  if (m_handle != INVALID_HANDLE) {

    FileClose(m_handle);
    m_handle = INVALID_HANDLE;
    m_name = "";

    m_flags &= FILE_ANSI | FILE_UNICODE;
  }
}

void CFile::Delete(void) {

  if (m_handle != INVALID_HANDLE) {
    string file_name = m_name;
    int common_flag = m_flags & FILE_COMMON;

    Close();

    FileDelete(file_name, common_flag);
  }
}

ulong CFile::Size(void) {

  if (m_handle != INVALID_HANDLE)
    return (FileSize(m_handle));

  return (0);
}

ulong CFile::Tell(void) {

  if (m_handle != INVALID_HANDLE)
    return (FileTell(m_handle));

  return (0);
}

void CFile::Seek(const long offset, const ENUM_FILE_POSITION origin) {

  if (m_handle != INVALID_HANDLE)
    FileSeek(m_handle, offset, origin);
}

void CFile::Flush(void) {

  if (m_handle != INVALID_HANDLE)
    FileFlush(m_handle);
}

bool CFile::IsEnding(void) {

  if (m_handle != INVALID_HANDLE)
    return (FileIsEnding(m_handle));

  return (false);
}

bool CFile::IsLineEnding(void) {

  if (m_handle != INVALID_HANDLE)
    if ((m_flags & FILE_BIN) == 0)
      return (FileIsLineEnding(m_handle));

  return (false);
}

void CFile::Delete(const string file_name, const int common_flag) {

  if (file_name == m_name) {
    int flag = m_flags & FILE_COMMON;
    if (flag == common_flag)
      Close();
  }

  FileDelete(file_name, common_flag);
}

bool CFile::IsExist(const string file_name, const int common_flag) {
  return (FileIsExist(file_name, common_flag));
}

bool CFile::Copy(const string src_name, const int common_flag,
                 const string dst_name, const int mode_flags) {
  return (FileCopy(src_name, common_flag, dst_name, mode_flags));
}

bool CFile::Move(const string src_name, const int common_flag,
                 const string dst_name, const int mode_flags) {
  return (FileMove(src_name, common_flag, dst_name, mode_flags));
}

bool CFile::FolderCreate(const string folder_name) {
  return (::FolderCreate(folder_name, m_flags));
}

bool CFile::FolderDelete(const string folder_name) {
  return (::FolderDelete(folder_name, m_flags));
}

bool CFile::FolderClean(const string folder_name) {
  return (::FolderClean(folder_name, m_flags));
}

long CFile::FileFindFirst(const string file_filter, string &returned_filename) {
  return (::FileFindFirst(file_filter, returned_filename, m_flags));
}

bool CFile::FileFindNext(const long search_handle, string &returned_filename) {
  return (::FileFindNext(search_handle, returned_filename));
}

void CFile::FileFindClose(const long search_handle) {
  ::FileFindClose(search_handle);
}

#endif
