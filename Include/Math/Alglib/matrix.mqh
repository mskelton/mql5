#ifndef MATRIX_H
#define MATRIX_H

#include "arrayresize.mqh"
#include "complex.mqh"

class CRowDouble {
private:
  double m_array;

public:
  CRowDouble(void);
  ~CRowDouble(void);

  int Size(void) const;
  void Resize(const int n);
  void Set(const int i, const double d);

  double operator[](const int i) const;
  void operator=(const double array[]);
  void operator=(const CRowDouble &r);
};









class CRowInt {
private:
  int m_array;

public:
  CRowInt(void);
  ~CRowInt(void);

  int Size(void) const;
  void Resize(const int n);
  void Set(const int i, const int d);

  int operator[](const int i) const;
  void operator=(const int array[]);
  void operator=(const CRowInt &r);
};









class CRowComplex {
private:
  al_complex m_array;

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
  void operator=(const al_complex array[]);
  void operator=(const CRowComplex &r);
};












class CMatrixDouble {
private:
  CRowDouble m_rows;

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









class CMatrixInt {
private:
  CRowInt m_rows;

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









class CMatrixComplex {
private:
  CRowComplex m_rows;

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









#endif
