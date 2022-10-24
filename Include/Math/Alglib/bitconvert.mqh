#ifndef BITCONVERT_H
#define BITCONVERT_H

#include "arrayresize.mqh"

class BitConverter {
public:
  BitConverter(void);
  ~BitConverter(void);

  static void GetBytes(const int d, uchar bytes[]);
  static void GetBytes(const double d, uchar bytes[]);
  static int ToInt32(uchar bytes[]);
  static double ToDouble(uchar bytes[]);
  static bool IsLittleEndian(void);
};








void ArrayReverse(uchar array[]) ;

void ArrayReverse(bool array[]) ;

string GetSelectionString(char buf[], int startIndex, int lenght) ;

double MathSign(const double x) ;
#ifndef __MQL5__

double MathSinh(const double x) ;

double MathCosh(const double x) ;

double MathTanh(const double x) ;
#endif

union UDoubleValue ;

class CInfOrNaN {
public:
  CInfOrNaN(void);
  ~CInfOrNaN(void);

  static bool IsPositiveInfinity(const double x);
  static bool IsNegativeInfinity(const double x);
  static bool IsInfinity(const double x);
  static bool IsNaN(const double x);

  static double PositiveInfinity(void);
  static double NegativeInfinity(void);
  static double NaN(void);
};










#endif
