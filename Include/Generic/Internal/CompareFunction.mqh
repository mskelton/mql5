#ifndef COMPARE_FUNCTION_H
#define COMPARE_FUNCTION_H

#include <Generic/Interfaces/IComparable.mqh>

int Compare(const bool x, const bool y) ;

int Compare(const char x, const char y) ;

int Compare(const uchar x, const uchar y) ;

int Compare(const short x, const short y) ;

int Compare(const ushort x, const ushort y) ;

int Compare(const color x, const color y) ;

int Compare(const int x, const int y) ;

int Compare(const uint x, const uint y) ;

int Compare(const datetime x, const datetime y) ;

int Compare(const long x, const long y) ;

int Compare(const ulong x, const ulong y) ;

int Compare(const float x, const float y) ;

int Compare(const double x, const double y) ;

int Compare(const string x, const string y) ;

template <typename T> int Compare(T x, T y) ;

#endif
