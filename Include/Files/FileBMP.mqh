#ifndef FILE_BMP_H
#define FILE_BMP_H

#include <Object.mqh>

struct BITMAPFILEHEADER {
  ushort bfType;
  uint bfSize;
  ushort bfReserved1;
  ushort bfReserved2;
  uint bfOffBits;
};
struct BITMAPINFOHEADER {
  uint biSize;
  int biWidth;
  int biHeight;
  ushort biPlanes;
  ushort biBitCount;
  uint biCompression;
  uint biSizeImage;
  int biXPelsPerMeter;
  int biYPelsPerMeter;
  uint biClrUsed;
  uint biClrImportant;
};
#define BM 0x4D42

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
