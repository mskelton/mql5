#ifndef FILE_BIN_H
#define FILE_BIN_H

#include "File.mqh"

class CFileBin : public CFile {
public:
  CFileBin(void);
  ~CFileBin(void);

  int Open(const string file_name, const int open_flags);

  uint WriteChar(const char value);
  uint WriteShort(const short value);
  uint WriteInteger(const int value);
  uint WriteLong(const long value);
  uint WriteFloat(const float value);
  uint WriteDouble(const double value);
  uint WriteString(const string value);
  uint WriteString(const string value, const int size);
  uint WriteCharArray(const char &array[], const int start_item = 0,
                      const int items_count = WHOLE_ARRAY);
  uint WriteShortArray(const short &array[], const int start_item = 0,
                       const int items_count = WHOLE_ARRAY);
  uint WriteIntegerArray(const int &array[], const int start_item = 0,
                         const int items_count = WHOLE_ARRAY);
  uint WriteLongArray(const long &array[], const int start_item = 0,
                      const int items_count = WHOLE_ARRAY);
  uint WriteFloatArray(const float &array[], const int start_item = 0,
                       const int items_count = WHOLE_ARRAY);
  uint WriteDoubleArray(const double &array[], const int start_item = 0,
                        const int items_count = WHOLE_ARRAY);
  template <typename T>
  uint WriteArray(T &array[], const int start_item = 0,
                  const int items_count = WHOLE_ARRAY);
  template <typename T> uint WriteStruct(T &data);
  bool WriteObject(CObject *object);
  template <typename T> uint WriteEnum(const T value) {
    return (WriteInteger((int)value));
  }

  bool ReadChar(char &value);
  bool ReadShort(short &value);
  bool ReadInteger(int &value);
  bool ReadLong(long &value);
  bool ReadFloat(float &value);
  bool ReadDouble(double &value);
  bool ReadString(string &value);
  bool ReadString(string &value, const int size);
  uint ReadCharArray(char &array[], const int start_item = 0,
                     const int items_count = WHOLE_ARRAY);
  uint ReadShortArray(short &array[], const int start_item = 0,
                      const int items_count = WHOLE_ARRAY);
  uint ReadIntegerArray(int &array[], const int start_item = 0,
                        const int items_count = WHOLE_ARRAY);
  uint ReadLongArray(long &array[], const int start_item = 0,
                     const int items_count = WHOLE_ARRAY);
  uint ReadFloatArray(float &array[], const int start_item = 0,
                      const int items_count = WHOLE_ARRAY);
  uint ReadDoubleArray(double &array[], const int start_item = 0,
                       const int items_count = WHOLE_ARRAY);
  template <typename T>
  uint ReadArray(T &array[], const int start_item = 0,
                 const int items_count = WHOLE_ARRAY);
  template <typename T> uint ReadStruct(T &data);
  bool ReadObject(CObject *object);
  template <typename T> bool ReadEnum(T &value);
};

CFileBin::CFileBin(void) {
}

CFileBin::~CFileBin(void) {
}

int CFileBin::Open(const string file_name, const int open_flags) {
  return (CFile::Open(file_name, open_flags | FILE_BIN));
}

uint CFileBin::WriteChar(const char value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteInteger(m_handle, value, sizeof(char)));

  return (0);
}

uint CFileBin::WriteShort(const short value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteInteger(m_handle, value, sizeof(short)));

  return (0);
}

uint CFileBin::WriteInteger(const int value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteInteger(m_handle, value, sizeof(int)));

  return (0);
}

uint CFileBin::WriteLong(const long value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteLong(m_handle, value));

  return (0);
}

uint CFileBin::WriteFloat(const float value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteFloat(m_handle, value));

  return (0);
}

uint CFileBin::WriteDouble(const double value) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteDouble(m_handle, value));

  return (0);
}

uint CFileBin::WriteString(const string value) {

  if (m_handle != INVALID_HANDLE) {

    int size = StringLen(value);

    if (FileWriteInteger(m_handle, size) == sizeof(int))
      return (FileWriteString(m_handle, value, size));
  }

  return (0);
}

uint CFileBin::WriteString(const string value, const int size) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteString(m_handle, value, size));

  return (0);
}

uint CFileBin::WriteCharArray(const char &array[], const int start_item,
                              const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::WriteShortArray(const short &array[], const int start_item,
                               const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::WriteIntegerArray(const int &array[], const int start_item,
                                 const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::WriteLongArray(const long &array[], const int start_item,
                              const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::WriteFloatArray(const float &array[], const int start_item,
                               const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::WriteDoubleArray(const double &array[], const int start_item,
                                const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteArray(m_handle, array, start_item, items_count));

  return (0);
}

template <typename T>
uint CFileBin::WriteArray(T &array[], const int start_item = 0,
                          const int items_count = WHOLE_ARRAY) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteArray(m_handle, array, start_item, items_count));

  return (0);
}

template <typename T> uint CFileBin::WriteStruct(T &data) {

  if (m_handle != INVALID_HANDLE)
    return (FileWriteStruct(m_handle, data));

  return (0);
}

bool CFileBin::WriteObject(CObject *object) {

  if (m_handle != INVALID_HANDLE)
    if (CheckPointer(object))
      return (object.Save(m_handle));

  return (false);
}

bool CFileBin::ReadChar(char &value) {

  if (m_handle != INVALID_HANDLE) {
    ResetLastError();
    value = (char)FileReadInteger(m_handle, sizeof(char));
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFileBin::ReadShort(short &value) {

  if (m_handle != INVALID_HANDLE) {
    ResetLastError();
    value = (short)FileReadInteger(m_handle, sizeof(short));
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFileBin::ReadInteger(int &value) {

  if (m_handle != INVALID_HANDLE) {
    ResetLastError();
    value = FileReadInteger(m_handle, sizeof(int));
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFileBin::ReadLong(long &value) {

  if (m_handle != INVALID_HANDLE) {
    ResetLastError();
    value = FileReadLong(m_handle);
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFileBin::ReadFloat(float &value) {

  if (m_handle != INVALID_HANDLE) {
    ResetLastError();
    value = FileReadFloat(m_handle);
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFileBin::ReadDouble(double &value) {

  if (m_handle != INVALID_HANDLE) {
    ResetLastError();
    value = FileReadDouble(m_handle);
    return (GetLastError() == 0);
  }

  return (false);
}

bool CFileBin::ReadString(string &value) {

  if (m_handle != INVALID_HANDLE) {
    ResetLastError();
    int size = FileReadInteger(m_handle);
    if (GetLastError() == 0) {
      value = FileReadString(m_handle, size);
      return (size == StringLen(value));
    }
  }

  return (false);
}

bool CFileBin::ReadString(string &value, const int size) {

  if (m_handle != INVALID_HANDLE) {
    value = FileReadString(m_handle, size);
    return (size == StringLen(value));
  }

  return (false);
}

uint CFileBin::ReadCharArray(char &array[], const int start_item,
                             const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::ReadShortArray(short &array[], const int start_item,
                              const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::ReadIntegerArray(int &array[], const int start_item,
                                const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::ReadLongArray(long &array[], const int start_item,
                             const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::ReadFloatArray(float &array[], const int start_item,
                              const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadArray(m_handle, array, start_item, items_count));

  return (0);
}

uint CFileBin::ReadDoubleArray(double &array[], const int start_item,
                               const int items_count) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadArray(m_handle, array, start_item, items_count));

  return (0);
}

template <typename T>
uint CFileBin::ReadArray(T &array[], const int start_item = 0,
                         const int items_count = WHOLE_ARRAY) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadArray(m_handle, array, start_item, items_count));

  return (0);
}

template <typename T> uint CFileBin::ReadStruct(T &data) {

  if (m_handle != INVALID_HANDLE)
    return (FileReadStruct(m_handle, data));

  return (0);
}

bool CFileBin::ReadObject(CObject *object) {

  if (m_handle != INVALID_HANDLE)
    if (CheckPointer(object))
      return (object.Load(m_handle));

  return (false);
}

template <typename T> bool CFileBin::ReadEnum(T &value) {
  int val;
  if (!ReadInteger(val))
    return (false);

  value = (T)val;
  return (true);
}

#endif
