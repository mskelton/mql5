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
  uint WriteCharArray(const char array[], const int start_item = 0,
                      const int items_count = WHOLE_ARRAY);
  uint WriteShortArray(const short array[], const int start_item = 0,
                       const int items_count = WHOLE_ARRAY);
  uint WriteIntegerArray(const int array[], const int start_item = 0,
                         const int items_count = WHOLE_ARRAY);
  uint WriteLongArray(const long array[], const int start_item = 0,
                      const int items_count = WHOLE_ARRAY);
  uint WriteFloatArray(const float array[], const int start_item = 0,
                       const int items_count = WHOLE_ARRAY);
  uint WriteDoubleArray(const double array[], const int start_item = 0,
                        const int items_count = WHOLE_ARRAY);
  template <typename T>
  uint WriteArray(T array[], const int start_item = 0,
                  const int items_count = WHOLE_ARRAY);
  template <typename T> uint WriteStruct(T &data);
  bool WriteObject(CObject *object);
  template <typename T> uint WriteEnum(const T value);

  bool ReadChar(char &value);
  bool ReadShort(short &value);
  bool ReadInteger(int &value);
  bool ReadLong(long &value);
  bool ReadFloat(float &value);
  bool ReadDouble(double &value);
  bool ReadString(string &value);
  bool ReadString(string &value, const int size);
  uint ReadCharArray(char array[], const int start_item = 0,
                     const int items_count = WHOLE_ARRAY);
  uint ReadShortArray(short array[], const int start_item = 0,
                      const int items_count = WHOLE_ARRAY);
  uint ReadIntegerArray(int array[], const int start_item = 0,
                        const int items_count = WHOLE_ARRAY);
  uint ReadLongArray(long array[], const int start_item = 0,
                     const int items_count = WHOLE_ARRAY);
  uint ReadFloatArray(float array[], const int start_item = 0,
                      const int items_count = WHOLE_ARRAY);
  uint ReadDoubleArray(double array[], const int start_item = 0,
                       const int items_count = WHOLE_ARRAY);
  template <typename T>
  uint ReadArray(T array[], const int start_item = 0,
                 const int items_count = WHOLE_ARRAY);
  template <typename T> uint ReadStruct(T &data);
  bool ReadObject(CObject *object);
  template <typename T> bool ReadEnum(T &value);
};

#endif
