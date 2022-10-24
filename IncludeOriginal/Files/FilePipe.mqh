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
  uint WriteArray(T &array[], const int start_item = 0,
                  const int items_count = WHOLE_ARRAY);
  template <typename T> uint WriteStruct(T &data);
  bool WriteObject(CObject *object);
  template <typename T> uint WriteEnum(const T value) {
    return (WriteInteger((int)value));
  }

  template <typename T> bool ReadInteger(T &value);
  bool ReadLong(long &value);
  bool ReadFloat(float &value);
  bool ReadDouble(double &value);
  bool ReadString(string &value);
  bool ReadString(string &value, const int size);
  template <typename T>
  uint ReadArray(T &array[], const int start_item = 0,
                 const int items_count = WHOLE_ARRAY);
  template <typename T> uint ReadStruct(T &data);
  bool ReadObject(CObject *object);
  template <typename T> bool ReadEnum(T &value);
};

CFilePipe::CFilePipe(void) {
}

CFilePipe::~CFilePipe(void) {
}

int CFilePipe::Open(const string file_name, const int open_flags) {
  return (CFile::Open(file_name, open_flags | FILE_BIN));
}

bool CFilePipe::WaitForRead(const ulong size) {

  while (m_handle != INVALID_HANDLE && !IsStopped()) {

    if (FileSize(m_handle) >= size)
      return (true);

    Sleep(1);
  }

  return (false);
}

template <typename T> uint CFilePipe::WriteInteger(const T value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteInteger(m_handle, value, sizeof(T)));

  return (0);
}

uint CFilePipe::WriteLong(const long value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteLong(m_handle, value));

  return (0);
}

uint CFilePipe::WriteFloat(const float value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteFloat(m_handle, value));

  return (0);
}

uint CFilePipe::WriteDouble(const double value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteDouble(m_handle, value));

  return (0);
}

uint CFilePipe::WriteString(const string value) {

  if (m_handle != INVALID_HANDLE) {

    int size = StringLen(value);

    if (FileWriteInteger(m_handle, size) == sizeof(int))
      return (FileWriteString(m_handle, value, size));
  }

  return (0);
}

uint CFilePipe::WriteString(const string value, const int size) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteString(m_handle, value, size));

  return (0);
}

template <typename T>
uint CFilePipe::WriteArray(T &array[], const int start_item = 0,
                           const int items_count = WHOLE_ARRAY) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteArray(m_handle, array, start_item, items_count));

  return (0);
}

template <typename T> uint CFilePipe::WriteStruct(T &data) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteStruct(m_handle, data));

  return (0);
}

bool CFilePipe::WriteObject(CObject *object) {

  if (m_handle != INVALID_HANDLE)
    if (CheckPointer(object))
      return (object.Save(m_handle));

  return (false);
}

template <typename T> bool CFilePipe::ReadInteger(T &value) {

  if (WaitForRead(sizeof(T))) {
    ResetLastError();
    value = FileReadInteger(m_handle, sizeof(T));
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFilePipe::ReadLong(long &value) {

  if (WaitForRead(sizeof(long))) {
    ResetLastError();
    value = FileReadLong(m_handle);
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFilePipe::ReadFloat(float &value) {

  if (WaitForRead(sizeof(float))) {
    ResetLastError();
    value = FileReadFloat(m_handle);
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFilePipe::ReadDouble(double &value) {

  if (WaitForRead(sizeof(double))) {
    ResetLastError();
    value = FileReadDouble(m_handle);
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFilePipe::ReadString(string &value) {

  if (WaitForRead(sizeof(int))) {
    ResetLastError();
    int size = FileReadInteger(m_handle);
    if (GetLastError() == 0) {

      if (WaitForRead(size)) {
        value = FileReadString(m_handle, size);
        return (size == StringLen(value));
      }
    }
  }

  return (false);
}

bool CFilePipe::ReadString(string &value, const int size) {

  if (WaitForRead(size)) {
    value = FileReadString(m_handle, size);
    return (size == StringLen(value));
  }

  return (false);
}

template <typename T>
uint CFilePipe::ReadArray(T &array[], const int start_item = 0,
                          const int items_count = WHOLE_ARRAY) {

  uint size = ArraySize(array);
  if (items_count != WHOLE_ARRAY)
    size = items_count;

  if (WaitForRead(size * sizeof(T)))
    return (FileReadArray(m_handle, array, start_item, items_count));

  return (0);
}

template <typename T> uint CFilePipe::ReadStruct(T &data) {

  if (WaitForRead(sizeof(T)))
    return (FileReadStruct(m_handle, data));

  return (0);
}

bool CFilePipe::ReadObject(CObject *object) {

  if (CheckPointer(object))
    if (WaitForRead(sizeof(int)))
      return (object.Load(m_handle));

  return (false);
}

template <typename T> bool CFilePipe::ReadEnum(T &value) {
  int val;
  if (!ReadInteger(val))
    return (false);

  value = (T)val;
  return (true);
}

#endif
