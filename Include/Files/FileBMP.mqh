#ifndef FILE_BMP_H
#define FILE_BMP_H

#include "BMP.mqh"
#include <Object.mqh>

class CFileBMP : public CObject {
protected:
  int m_handle;
  BITMAPFILEHEADER m_file_header;
  BITMAPINFOHEADER m_info_header;

public:
  CFileBMP(void);
  ~CFileBMP(void);
  int OpenWrite(const string file_name, bool common_flag = false);
  int OpenRead(const string file_name, bool common_flag = false);
  int Write32BitsArray(uint uint_array[], const int width, const int height);
  int Read32BitsArray(uint uint_array[], int &width, int &height);
  void Close(void);
};

#endif
