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

  int Handle(void) const;
  string FileName(void) const;
  int Flags(void) const;
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

#endif
