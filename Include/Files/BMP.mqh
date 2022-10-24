#ifndef BMP_H
#define BMP_H

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

#endif
