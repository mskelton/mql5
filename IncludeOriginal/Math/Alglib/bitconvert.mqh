#ifndef BITCONVERT_H
#define BITCONVERT_H

#include "arrayresize.mqh"

class BitConverter {
public:
  BitConverter(void);
  ~BitConverter(void);

  static void GetBytes(const int d, uchar &bytes[]);
  static void GetBytes(const double d, uchar &bytes[]);
  static int ToInt32(uchar &bytes[]);
  static double ToDouble(uchar &bytes[]);
  static bool IsLittleEndian(void);
};

BitConverter::BitConverter(void) {
}

BitConverter::~BitConverter(void) {
}

static void BitConverter::GetBytes(const int d, uchar &bytes[]) {

  int x;
  int q;
  int r;
  int i;
  int div;

  ArrayResizeAL(bytes, 4);
  for (i = 0; i < 4; i++) {

    if (d >= 0)
      bytes[i] = 0;
    else
      bytes[i] = 255;
  }

  q = -1;
  r = -1;
  i = 3;
  div = 256 * 256 * 256;

  if (d < 0)
    x = ~d;
  else
    x = d;

  while (i != -1) {

    q = x / div;

    r = x % div;

    if (d >= 0)
      bytes[i] += (uchar)q;
    else
      bytes[i] -= (uchar)q;

    x = r;
    div = div / 256;
    i--;
  }
}

static void BitConverter::GetBytes(const double d, uchar &bytes[]) {

  double abs_d = MathAbs(d);

  double floor_d = MathFloor(abs_d);

  double fractional_d = abs_d - floor_d;

  int power;

  double exp_shift;

  int k;
  int j;
  uchar u;
  double step;
  double f;

  bool abs_d_to_bitArray[];

  bool d_to_bitArray[];

  ArrayResizeAL(d_to_bitArray, 64);
  ArrayResizeAL(bytes, 8);

  power = 0;

  while (1) {

    if (floor_d >= MathPow(2, power))
      power++;
    else
      break;
  }

  power--;

  if (power == -1) {
    power = 0;
    while (1) {

      if (fractional_d < MathPow(2, power))
        power--;
      else
        break;
    }
  }

  j = 0;
  step = power;
  while (abs_d != 0.0) {
    f = MathPow(2, step);

    if (f > abs_d) {

      ArrayResizeAL(abs_d_to_bitArray, j + 1);
      abs_d_to_bitArray[j] = 0;
      j++;
      step -= 1;
    } else {

      abs_d -= f;
      ArrayResizeAL(abs_d_to_bitArray, j + 1);
      abs_d_to_bitArray[j] = 1;
      j++;
      step -= 1;
    }
  }

  if (d >= 0)
    d_to_bitArray[0] = 0;
  else
    d_to_bitArray[0] = 1;

  exp_shift = 1023 + power;

  j = 1;
  for (int i = 10; i >= 0; i--) {
    if (MathPow(2, i) > exp_shift)
      d_to_bitArray[j] = 0;
    else {
      d_to_bitArray[j] = 1;

      exp_shift -= MathPow(2, i);
    }
    j++;
  }

  k = ArraySize(abs_d_to_bitArray);
  j = 1;

  for (int i = 12; i < 64; i++) {
    if (j < k) {
      d_to_bitArray[i] = abs_d_to_bitArray[i - 11];
      j++;
    } else
      d_to_bitArray[i] = 0;
  }

  ArrayReverse(d_to_bitArray);

  for (int i = 0; i < 8; i++) {
    u = 0;

    for (int t = 0; t < 8; t++)
      u += (uchar)(d_to_bitArray[i * 8 + t] * MathPow(2, t));

    bytes[i] = u;
  }
}

static int BitConverter::ToInt32(uchar &bytes[]) {

  int size = ArraySize(bytes);

  int d = 0;
  int mul = 256 * 256 * 256;

  for (int i = size - 1; i >= 0; i--) {
    d += bytes[i] * mul;
    mul = mul / 256;
  }

  return (d);
}

static double BitConverter::ToDouble(uchar &bytes[]) {

  int s;

  int e = 0;

  double m = 0;

  bool bits[];
  ArrayResizeAL(bits, 64);

  for (int i = 0; i < 8; i++) {
    for (int j = 7; j >= 0; j--) {

      if (MathPow(2, j) > bytes[i])
        bits[i * 8 + j] = 0;
      else {
        bits[i * 8 + j] = 1;

        bytes[i] -= (uchar)MathPow(2, j);
      }
    }
  }

  bool allzero = true;
  for (int i = 0; i < 64; i++)
    if (bits[i] == 1)
      allzero = false;

  if (allzero == true)
    return (0.0);

  ArrayReverse(bits);

  s = bits[0];

  for (int i = 10; i >= 0; i--)
    e += (int)(bits[11 - i] * MathPow(2, i));

  for (int i = 0; i < 52; i++)
    m += bits[12 + i] * MathPow(2, -1 - i);

  return (MathPow(-1, s) * MathPow(2, e - 1023) * (1 + m));
}

static bool BitConverter::IsLittleEndian(void) {

  return (true);
}

void ArrayReverse(uchar &array[]) {

  int size = ArraySize(array);

  int half = size / 2;

  uchar temp;

  for (int i = 0; i < half; i++) {
    temp = array[i];
    array[i] = array[size - 1 - i];
    array[size - 1 - i] = temp;
  }
}

void ArrayReverse(bool &array[]) {

  int size = ArraySize(array);

  int half = size / 2;

  bool temp;

  for (int i = 0; i < half; i++) {
    temp = array[i];
    array[i] = array[size - 1 - i];
    array[size - 1 - i] = temp;
  }
}

string GetSelectionString(char &buf[], int startIndex, int lenght) {

  ushort res[];
  int size = ArraySize(buf);
  ArrayResizeAL(res, size);

  for (int i = 0; i < size; i++)
    res[i] = (ushort)buf[i];

  return (ShortArrayToString(res, startIndex, lenght));
}

double MathSign(const double x) {

  if (x > 0)
    return (1);

  if (x == 0)
    return (0);

  return (-1);
}
#ifndef __MQL5__

double MathSinh(const double x) {

  return ((MathPow(M_E, x) - MathPow(M_E, -x)) / 2);
}

double MathCosh(const double x) {

  return ((MathPow(M_E, x) + MathPow(M_E, -x)) / 2);
}

double MathTanh(const double x) {

  return (MathSinh(x) / MathCosh(x));
}
#endif

union UDoubleValue {
  double value;
  long bits;

  UDoubleValue(double dbl) : value(dbl) {
  }
  UDoubleValue(long bit_value) : bits(bit_value) {
  }
};

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

CInfOrNaN::CInfOrNaN(void) {
}

CInfOrNaN::~CInfOrNaN(void) {
}

static bool CInfOrNaN::IsPositiveInfinity(const double x) {
  UDoubleValue val = x;

  return (val.bits == 0x7FF0000000000000);
}

static bool CInfOrNaN::IsNegativeInfinity(const double x) {
  UDoubleValue val = x;

  return (val.bits == 0xFFF0000000000000);
}

static bool CInfOrNaN::IsInfinity(const double x) {
  UDoubleValue val = x;

  return (val.bits == 0x7FF0000000000000 || val.bits == 0xFFF0000000000000);
}

static bool CInfOrNaN::IsNaN(const double x) {

  if (MathIsValidNumber(x)) {

    return (false);
  }

  if (IsInfinity(x)) {

    return (false);
  }

  return (true);
}

static double CInfOrNaN::PositiveInfinity(void) {
  UDoubleValue val(0x7FF0000000000000);
  return (val.value);
}

static double CInfOrNaN::NegativeInfinity(void) {
  UDoubleValue val(0xFFF0000000000000);
  return (val.value);
}

static double CInfOrNaN::NaN(void) {
  UDoubleValue val(0x7FFFFFFFFFFFFFFF);
  return (val.value);
}

#endif
