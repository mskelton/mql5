#ifndef COMPLEX_H
#define COMPLEX_H

struct al_complex {
public:
  double re;
  double im;

public:
  al_complex(void);
  al_complex(const double x);
  al_complex(const double x, const double y);
  ~al_complex(void);

  void Copy(const al_complex &rhs);
  bool Eq(const al_complex &lhs, const al_complex &rhs);
  bool NotEq(const al_complex &lhs, const al_complex &rhs);
  al_complex Add(const al_complex &lhs, const al_complex &rhs);
  al_complex Sub(const al_complex &lhs, const al_complex &rhs);
  al_complex Mul(const al_complex &lhs, const al_complex &rhs);
  al_complex Div(const al_complex &lhs, const al_complex &rhs);
  al_complex Conjugate(void);

  void operator=(const double rhs);
  void operator=(const al_complex &rhs);
  void operator+=(const al_complex &rhs);
  void operator-=(const al_complex &rhs);
  bool operator==(const al_complex &rhs);
  bool operator==(const double rhs);
  bool operator!=(const al_complex &rhs);
  bool operator!=(const double rhs);
  al_complex operator+(const al_complex &rhs);
  al_complex operator+(const double rhs);
  al_complex operator+(void);
  al_complex operator-(const al_complex &rhs);
  al_complex operator-(const double rhs);
  al_complex operator-(void);
  al_complex operator*(const al_complex &rhs);
  al_complex operator*(const double rhs);
  al_complex operator/(const al_complex &rhs);
  al_complex operator/(const double rhs);
};

#endif
