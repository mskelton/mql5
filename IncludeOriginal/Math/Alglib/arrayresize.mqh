#ifndef ARRAYRESIZE_H
#define ARRAYRESIZE_H

#include "complex.mqh"

class CRowInt;
class CRowDouble;
class CRowComplex;

int ArrayResizeAL(double &arr[], const int size) {
  int old = ArraySize(arr);
  int res = ArrayResize(arr, size);

  if (res > 0 && old < size)
    ArrayFill(arr, old, size - old, 0.0);

  return (res);
}

int ArrayResizeAL(int &arr[], const int size) {
  int old = ArraySize(arr);
  int res = ArrayResize(arr, size);

  if (res > 0 && old < size)
    ArrayFill(arr, old, size - old, 0);

  return (res);
}

int ArrayResizeAL(short &arr[], const int size) {
  int old = ArraySize(arr);
  int res = ArrayResize(arr, size);

  if (res > 0 && old < size)
    ArrayFill(arr, old, size - old, 0);

  return (res);
}

int ArrayResizeAL(char &arr[], const int size) {
  int old = ArraySize(arr);
  int res = ArrayResize(arr, size);

  if (res > 0 && old < size)
    ArrayFill(arr, old, size - old, 0);

  return (res);
}

int ArrayResizeAL(bool &arr[], const int size) {
  int old = ArraySize(arr);
  int res = ArrayResize(arr, size);

  if (res > 0 && old < size)
    ArrayFill(arr, old, size - old, false);

  return (res);
}

int ArrayResizeAL(string &arr[], const int size) {

  return (ArrayResize(arr, size));
}

int ArrayResizeAL(al_complex &arr[], const int size) {
  int old = ArraySize(arr);
  int res = ArrayResize(arr, size);

  if (res > 0 && old < size) {
    for (int i = old, len = size - old; i < len; i++) {
      arr[i].re = 0.0;
      arr[i].im = 0.0;
    }
  }

  return (res);
}

int ArrayResizeAL(CRowInt &arr[], const int size) {

  return (ArrayResize(arr, size));
}

int ArrayResizeAL(CRowDouble &arr[], const int size) {

  return (ArrayResize(arr, size));
}

int ArrayResizeAL(CRowComplex &arr[], const int size) {

  return (ArrayResize(arr, size));
}

#endif
