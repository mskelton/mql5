#ifndef FILE_PIPE_H
#define FILE_PIPE_H

#include "File.mqh"

class CFilePipe : public CFile {
public:
  CFilePipe(void);
  ~CFilePipe(void);

  int Open(const string file_name, const int open_flags);

  bool WaitForRead(const ulong size);

  template <typename T> uint WriteInteger(const T value);
  uint WriteLong(const long value);
  uint WriteFloat(const float value);
  uint WriteDouble(const double value);
  uint WriteString(const string value);
  uint WriteString(const string value, const int size);
  template <typename T>
  uint WriteArray(T array[], const int start_item = 0,
                  const int items_count = WHOLE_ARRAY);
  template <typename T> uint WriteStruct(T &data);
  bool WriteObject(CObject *object);
  template <typename T> uint WriteEnum(const T value);

  template <typename T> bool ReadInteger(T &value);
  bool ReadLong(long &value);
  bool ReadFloat(float &value);
  bool ReadDouble(double &value);
  bool ReadString(string &value);
  bool ReadString(string &value, const int size);
  template <typename T>
  uint ReadArray(T array[], const int start_item = 0,
                 const int items_count = WHOLE_ARRAY);
  template <typename T> uint ReadStruct(T &data);
  bool ReadObject(CObject *object);
  template <typename T> bool ReadEnum(T &value);
};

#endif
