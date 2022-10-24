#ifndef MATRIX_H
#define MATRIX_H

#include "arrayresize.mqh"
#include "complex.mqh"

class CRowDouble {
private:
  double m_array[];

public:
  CRowDouble(void);
  ~CRowDouble(void);

  int Size(void) const;
  void Resize(const int n);
  void Set(const int i, const double d);

  double operator[](const int i) const;
  void operator=(const double &array[]);
  void operator=(const CRowDouble &r);
};

CRowDouble::CRowDouble(void) {
}

CRowDouble::~CRowDouble(void) {
}

int CRowDouble::Size(void) const {
  return (ArraySize(m_array));
}

void CRowDouble::Resize(const int n) {
  ArrayResizeAL(m_array, n);
}

void CRowDouble::Set(const int i, const double d) {
  m_array[i] = d;
}

double CRowDouble::operator[](const int i) const {
  return (m_array[i]);
}

void CRowDouble::operator=(const double &array[]) {
  int size = ArraySize(array);

  if (size == 0)
    return;

  ArrayResizeAL(m_array, size);
  for (int i = 0; i < size; i++)
    m_array[i] = array[i];
}

void CRowDouble::operator=(const CRowDouble &r) {
  int size = r.Size();

  if (size == 0)
    return;

  ArrayResizeAL(m_array, size);
  for (int i = 0; i < size; i++)
    m_array[i] = r[i];
}

class CRowInt {
private:
  int m_array[];

public:
  CRowInt(void);
  ~CRowInt(void);

  int Size(void) const;
  void Resize(const int n);
  void Set(const int i, const int d);

  int operator[](const int i) const;
  void operator=(const int &array[]);
  void operator=(const CRowInt &r);
};

CRowInt::CRowInt(void) {
}

CRowInt::~CRowInt(void) {
}

int CRowInt::Size(void) const {
  return (ArraySize(m_array));
}

void CRowInt::Resize(const int n) {
  ArrayResizeAL(m_array, n);
}

void CRowInt::Set(const int i, const int d) {
  m_array[i] = d;
}

int CRowInt::operator[](const int i) const {
  return (m_array[i]);
}

void CRowInt::operator=(const int &array[]) {
  int size = ArraySize(array);

  if (size == 0)
    return;

  ArrayResizeAL(m_array, size);
  for (int i = 0; i < size; i++)
    m_array[i] = array[i];
}

void CRowInt::operator=(const CRowInt &r) {
  int size = r.Size();

  if (size == 0)
    return;

  ArrayResizeAL(m_array, size);
  for (int i = 0; i < size; i++)
    m_array[i] = r[i];
}

class CRowComplex {
private:
  al_complex m_array[];

public:
  CRowComplex(void);
  ~CRowComplex(void);

  int Size(void) const;
  void Resize(const int n);
  void Set(const int i, const al_complex &d);
  void Set(const int i, const double d);
  void SetRe(const int i, const double d);
  void SetIm(const int i, const double d);

  al_complex operator[](const int i) const;
  void operator=(const al_complex &array[]);
  void operator=(const CRowComplex &r);
};

CRowComplex::CRowComplex(void) {
}

CRowComplex::~CRowComplex(void) {
}

int CRowComplex::Size(void) const {
  return (ArraySize(m_array));
}

void CRowComplex::Resize(const int n) {
  ArrayResizeAL(m_array, n);
}

void CRowComplex::Set(const int i, const al_complex &d) {
  m_array[i] = d;
}

void CRowComplex::Set(const int i, const double d) {
  al_complex c(d, 0);
  m_array[i] = c;
}

void CRowComplex::SetRe(const int i, const double d) {
  m_array[i].re = d;
}

void CRowComplex::SetIm(const int i, const double d) {
  m_array[i].im = d;
}

al_complex CRowComplex::operator[](const int i) const {
  return (m_array[i]);
}

void CRowComplex::operator=(const al_complex &array[]) {
  int size = ArraySize(array);

  if (size == 0)
    return;

  ArrayResizeAL(m_array, size);
  for (int i = 0; i < size; i++)
    m_array[i] = array[i];
}

void CRowComplex::operator=(const CRowComplex &r) {
  int size = r.Size();

  if (size == 0)
    return;

  ArrayResizeAL(m_array, size);
  for (int i = 0; i < size; i++)
    m_array[i] = r[i];
}

class CMatrixDouble {
private:
  CRowDouble m_rows[];

public:
  CMatrixDouble(void);
  CMatrixDouble(const int rows);
  CMatrixDouble(const int rows, const int cols);
  ~CMatrixDouble(void);

  int Size(void) const;
  void Resize(const int n, const int m);

  CRowDouble *operator[](const int i) const;
  void operator=(const CMatrixDouble &m);
};

CMatrixDouble::CMatrixDouble(void) {
}

CMatrixDouble::CMatrixDouble(const int rows) {
  ArrayResizeAL(m_rows, rows);
}

CMatrixDouble::CMatrixDouble(const int rows, const int cols) {
  ArrayResizeAL(m_rows, rows);
  for (int i = 0; i < rows; i++)
    m_rows[i].Resize(cols);
}

CMatrixDouble::~CMatrixDouble(void) {
}

int CMatrixDouble::Size(void) const {
  return (ArraySize(m_rows));
}

void CMatrixDouble::Resize(const int n, const int m) {

  if (n < 0 || m < 0)
    return;

  ArrayResizeAL(m_rows, n);
  for (int i = 0; i < n; i++)
    m_rows[i].Resize(m);
}

CRowDouble *CMatrixDouble::operator[](const int i) const {
  return (GetPointer(m_rows[i]));
}

void CMatrixDouble::operator=(const CMatrixDouble &m) {
  int r = m.Size();

  if (r == 0)
    return;
  int c = m[0].Size();

  if (c == 0)
    return;

  ArrayResizeAL(m_rows, r);
  for (int i = 0; i < r; i++)
    m_rows[i].Resize(c);

  for (int i = 0; i < r; i++)
    m_rows[i] = m[i];
}

class CMatrixInt {
private:
  CRowInt m_rows[];

public:
  CMatrixInt(void);
  CMatrixInt(const int rows);
  CMatrixInt(const int rows, const int cols);
  ~CMatrixInt(void);

  int Size(void) const;
  void Resize(const int n, const int m);

  CRowInt *operator[](const int i) const;
  void operator=(const CMatrixInt &m);
};

CMatrixInt::CMatrixInt(void) {
}

CMatrixInt::CMatrixInt(const int rows) {
  ArrayResizeAL(m_rows, rows);
}

CMatrixInt::CMatrixInt(const int rows, const int cols) {
  ArrayResizeAL(m_rows, rows);
  for (int i = 0; i < rows; i++)
    m_rows[i].Resize(cols);
}

CMatrixInt::~CMatrixInt(void) {
}

int CMatrixInt::Size(void) const {
  return (ArraySize(m_rows));
}

void CMatrixInt::Resize(const int n, const int m) {

  if (n < 0 || m < 0)
    return;

  ArrayResizeAL(m_rows, n);
  for (int i = 0; i < n; i++)
    m_rows[i].Resize(m);
}

CRowInt *CMatrixInt::operator[](const int i) const {
  return (GetPointer(m_rows[i]));
}

void CMatrixInt::operator=(const CMatrixInt &m) {
  int r = m.Size();

  if (r == 0)
    return;
  int c = m[0].Size();

  if (c == 0)
    return;

  ArrayResizeAL(m_rows, r);
  for (int i = 0; i < r; i++)
    m_rows[i].Resize(c);

  for (int i = 0; i < r; i++)
    m_rows[i] = m[i];
}

class CMatrixComplex {
private:
  CRowComplex m_rows[];

public:
  CMatrixComplex(void);
  CMatrixComplex(const int rows);
  CMatrixComplex(const int rows, const int cols);
  ~CMatrixComplex(void);

  int Size(void) const;
  void Resize(const int n, const int m);

  CRowComplex *operator[](const int i) const;
  void operator=(const CMatrixComplex &m);
};

CMatrixComplex::CMatrixComplex(void) {
}

CMatrixComplex::CMatrixComplex(const int rows) {
  ArrayResizeAL(m_rows, rows);
}

CMatrixComplex::CMatrixComplex(const int rows, const int cols) {
  ArrayResizeAL(m_rows, rows);
  for (int i = 0; i < rows; i++)
    m_rows[i].Resize(cols);
}

CMatrixComplex::~CMatrixComplex(void) {
}

int CMatrixComplex::Size(void) const {
  return (ArraySize(m_rows));
}

void CMatrixComplex::Resize(const int n, const int m) {

  if (n < 0 || m < 0)
    return;

  ArrayResizeAL(m_rows, n);
  for (int i = 0; i < n; i++)
    m_rows[i].Resize(m);
}

CRowComplex *CMatrixComplex::operator[](const int i) const {
  return (GetPointer(m_rows[i]));
}

void CMatrixComplex::operator=(const CMatrixComplex &m) {
  int r = m.Size();

  if (r == 0)
    return;
  int c = m[0].Size();

  if (c == 0)
    return;

  ArrayResizeAL(m_rows, r);
  for (int i = 0; i < r; i++)
    m_rows[i].Resize(c);

  for (int i = 0; i < r; i++)
    m_rows[i] = m[i];
}

#endif
