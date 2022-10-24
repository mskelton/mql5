#ifndef ARRAYRESIZE_H
#define ARRAYRESIZE_H

#include "complex.mqh"

class CRowInt;
class CRowDouble;
class CRowComplex;

int ArrayResizeAL(double arr[], const int size);

int ArrayResizeAL(int arr[], const int size);

int ArrayResizeAL(short arr[], const int size);

int ArrayResizeAL(char arr[], const int size);

int ArrayResizeAL(bool arr[], const int size);

int ArrayResizeAL(string arr[], const int size);

int ArrayResizeAL(al_complex arr[], const int size);

int ArrayResizeAL(CRowInt arr[], const int size);

int ArrayResizeAL(CRowDouble arr[], const int size);

int ArrayResizeAL(CRowComplex arr[], const int size);

#endif
