#ifndef MATH_H
#define MATH_H

#define ERR_OK 0
#define ERR_ARGUMENTS_NAN 1
#define ERR_ARGUMENTS_INVALID 2
#define ERR_RESULT_INFINITE 3
#define ERR_NON_CONVERGENCE 4

double QNaN = (double)"nan";
double QPOSINF = (double)"inf";
double QNEGINF = (double)"-inf";

double MathRandomNonZero(void) {
  double rnd = 0;

  while (rnd == 0.0 || rnd == 1.0)
    rnd = MathRand() / 32767.0;

  return (rnd);
}

bool MathMoments(const double &array[], double &mean, double &variance,
                 double &skewness, double &kurtosis, const int start = 0,
                 const int count = WHOLE_ARRAY) {

  mean = 0.0;
  variance = 0.0;
  skewness = 0.0;
  kurtosis = 0.0;

  int size = ArraySize(array);
  int data_count = 0;

  if (count == WHOLE_ARRAY)
    data_count = size;
  else
    data_count = count;

  if (data_count == 0)
    return (false);
  if (start + data_count > size)
    return (false);

  int ind1 = start;
  int ind2 = ind1 + data_count - 1;

  for (int i = ind1; i <= ind2; i++)
    mean += array[i];
  mean = mean / data_count;
  double S = 0.0;

  if (data_count > 1) {

    for (int i = ind1; i <= ind2; i++)
      variance += MathPow(array[i] - mean, 2);
    variance = variance / (data_count - 1);
    S = MathSqrt(variance);
  } else
    variance = QNaN;

  if (data_count > 2 && S > 0.0) {

    for (int i = ind1; i <= ind2; i++)
      skewness += MathPow(array[i] - mean, 3);
    skewness = skewness / (data_count * MathPow(S, 3));
  } else
    skewness = QNaN;

  if (data_count > 3 && S > 0.0) {

    for (int i = ind1; i <= ind2; i++)
      kurtosis += MathPow(array[i] - mean, 4);
    kurtosis = kurtosis / (data_count * MathPow(S, 4));
    kurtosis -= 3;
  } else
    kurtosis = QNaN;

  if ((!MathIsValidNumber(variance)) || (!MathIsValidNumber(skewness)) ||
      (!MathIsValidNumber(kurtosis)))
    return (false);
  else
    return (true);
}

#define M_1_SQRT_2PI 1 / MathSqrt(2 * M_PI)

double FactorialsTable[21] = {1,
                              1,
                              2,
                              6,
                              24,
                              120,
                              720,
                              5040,
                              40320,
                              362880,
                              3628800,
                              39916800,
                              479001600,
                              6227020800,
                              87178291200,
                              1307674368000,
                              20922789888000,
                              355687428096000,
                              6402373705728000,
                              121645100408832000,
                              2432902008176640000};

double MathPowInt(const double x, const int power) {

  if (power == 0)
    return (1.0);
  if (power < 0)
    return (0);

  double val = x;
  for (int i = 2; i <= power; i++)
    val *= x;

  return (val);
}

double MathFactorial(const int n) {
  if (n < 0)
    return (0);
  if (n <= 20)

    return (FactorialsTable[n]);
  else {

    double val = FactorialsTable[20];
    for (int i = 21; i <= n; i++)
      val *= i;

    return (val);
  }
}

double MathTrunc(const double x) {
  if (x >= 0)
    return (MathFloor(x));
  else
    return (MathCeil(x));
}

double MathRound(const double x, const int digits) {
  if (!MathIsValidNumber(x))
    return (QNaN);

  if (x == 0.0)
    return (x);

  if (digits > 0) {
    double sign = 1.0;
    double xx = x;
    if (xx < 0.0) {
      xx = -xx;
      sign = -1.0;
    }
    double pwr_factor = MathPow(10, digits);
    double int_value = MathFloor(xx);
    double res = (xx - int_value) * pwr_factor;
    res = MathFloor(MathAbs(res) + 0.5);
    return (sign * (int_value + res / pwr_factor));
  } else if (digits == 0)
    return MathRound(x);

  return (0);
}

double MathGamma(const double x) {

  const double logsqrt2pi = MathLog(MathSqrt(2 * M_PI));

  const double xminin = 2.23e-308;
  const double xbig = 171.624;
  double eps = 2.22e-16;

  const double p[8] = {
      -1.71618513886549492533811e+0, 2.47656508055759199108314e+1,
      -3.79804256470945635097577e+2, 6.29331155312818442661052e+2,
      8.66966202790413211295064e+2,  -3.14512729688483675254357e+4,
      -3.61444134186911729807069e+4, 6.64561438202405440627855e+4};
  const double q[8] = {
      -3.08402300119738975254353e+1, 3.15350626979604161529144e+2,
      -1.01515636749021914166146e+3, -3.10777167157231109440444e+3,
      2.25381184209801510330112e+4,  4.75584627752788110767815e+3,
      -1.34659959864969306392456e+5, -1.15132259675553483497211e+5};

  const double c[7] = {-1.910444077728e-03,
                       8.4171387781295e-04,
                       -5.952379913043012e-04,
                       7.93650793500350248e-04,
                       -2.777777777777681622553e-03,
                       8.333333333333333331554247e-02,
                       5.7083835261e-03};

  int parity = 0;
  double fact = 1.0;
  int n = 0;
  double y = x, y1, res, z, xnum = 0, xden = 0, ysq = 0, sum = 0;

  if (y <= 0.0) {

    y = -x;
    y1 = MathTrunc(y);
    res = y - y1;
    if (res != 0.0) {
      if (y1 != MathTrunc(y1 * 0.5) * 2.0)
        parity = 1;
      fact = -M_PI / MathSin(M_PI * res);
      y = y + 1.0;
    } else {
      return (QPOSINF);
    }
  }

  if (y < eps) {

    if (y >= xminin) {
      res = 1.0 / y;
    } else {
      return (QPOSINF);
    }
  } else if (y < 12.0) {
    y1 = y;
    if (y < 1.0) {

      z = y;
      y = y + 1.0;
    } else {

      n = int(y) - 1;
      y = y - double(n);
      z = y - 1.0;
    }

    xnum = 0.0;
    xden = 1.0;
    for (int i = 0; i < 8; i++) {
      xnum = (xnum + p[i]) * z;
      xden = xden * z + q[i];
    }
    res = xnum / xden + 1.0;
    if (y1 < y) {

      res = res / y1;
    } else if (y1 > y) {

      for (int i = 0; i < n; i++) {
        res = res * y;
        y = y + 1.0;
      }
    }
  } else {

    if (y <= xbig) {
      ysq = y * y;
      sum = c[6];
      for (int i = 0; i < 6; i++) {
        sum = sum / ysq + c[i];
      }
      sum = sum / y - y + logsqrt2pi;
      sum = sum + (y - 0.5) * MathLog(y);
      res = MathExp(sum);
    } else {
      return (QPOSINF);
    }
  }

  if (parity == 1)
    res = -res;
  if (fact != 1.0)
    res = fact / res;

  return (res);
}

double MathGammaLog(const double x) {

  const double pnt68 = 0.6796875e0;
  const double sqrtpi = 0.9189385332046727417803297e0;

  const double xbig = 2.55E305;
  const double xinf = 1.79E308;
  const double eps = 2.22E-16;
  const double frtbig = 2.25E76;

  const double d1 = -5.772156649015328605195174e-1;
  const double p1[8] = {
      4.945235359296727046734888e0, 2.018112620856775083915565e2,
      2.290838373831346393026739e3, 1.131967205903380828685045e4,
      2.855724635671635335736389e4, 3.848496228443793359990269e4,
      2.637748787624195437963534e4, 7.225813979700288197698961e3};
  const double q1[8] = {
      6.748212550303777196073036e1, 1.113332393857199323513008e3,
      7.738757056935398733233834e3, 2.763987074403340708898585e4,
      5.499310206226157329794414e4, 6.161122180066002127833352e4,
      3.635127591501940507276287e4, 8.785536302431013170870835e3};

  const double d2 = 4.227843350984671393993777e-1;
  const double p2[8] = {
      4.974607845568932035012064e0, 5.424138599891070494101986e2,
      1.550693864978364947665077e4, 1.847932904445632425417223e5,
      1.088204769468828767498470e6, 3.338152967987029735917223e6,
      5.106661678927352456275255e6, 3.074109054850539556250927e6};
  const double q2[8] = {
      1.830328399370592604055942e2, 7.765049321445005871323047e3,
      1.331903827966074194402448e5, 1.136705821321969608938755e6,
      5.267964117437946917577538e6, 1.346701454311101692290052e7,
      1.782736530353274213975932e7, 9.533095591844353613395747e6};

  const double d4 = 1.791759469228055000094023e0;
  const double p4[8] = {
      1.474502166059939948905062e4,  2.426813369486704502836312e6,
      1.214755574045093227939592e8,  2.663432449630976949898078e9,
      2.940378956634553899906876e10, 1.702665737765398868392998e11,
      4.926125793377430887588120e11, 5.606251856223951465078242e11};
  const double q4[8] = {
      2.690530175870899333379843e3,  6.393885654300092398984238e5,
      4.135599930241388052042842e7,  1.120872109616147941376570e9,
      1.488613728678813811542398e10, 1.016803586272438228077304e11,
      3.417476345507377132798597e11, 4.463158187419713286462081e11};

  const double c[7] = {-1.910444077728e-03,
                       8.4171387781295e-04,
                       -5.952379913043012e-04,
                       7.93650793500350248e-04,
                       -2.777777777777681622553e-03,
                       8.333333333333333331554247e-02,
                       5.7083835261e-03};

  double y = x;
  double res = 0.0;
  double corr = 0;
  double xm1, xm2, xm4, xden, xnum;
  double ysq = 0;

  if ((y > 0 && y <= xbig)) {
    if (y <= eps) {
      res = -MathLog(y);
    } else {
      if (y <= 1.5) {

        if (y < pnt68) {
          corr = -MathLog(y);
          xm1 = y;
        } else {
          corr = 0.0;
          xm1 = (y - 0.5) - 0.5;
        }
        if ((y <= 0.5 || y >= pnt68)) {
          xden = 1.0;
          xnum = 0;
          for (int i = 0; i < 8; i++) {
            xnum = xnum * xm1 + p1[i];
            xden = xden * xm1 + q1[i];
          }
          res = corr + (xm1 * (d1 + xm1 * (xnum / xden)));
        } else {
          xm2 = (y - 0.5) - 0.5;
          xden = 1.0;
          xnum = 0.0;
          for (int i = 0; i < 8; i++) {
            xnum = xnum * xm2 + p2[i];
            xden = xden * xm2 + q2[i];
          }
          res = corr + xm2 * (d2 + xm2 * (xnum / xden));
        }
      } else {
        if (y <= 4.0) {

          xm2 = y - 2.0;
          xden = 1.0;
          xnum = 0.0;
          for (int i = 0; i < 8; i++) {
            xnum = xnum * xm2 + p2[i];
            xden = xden * xm2 + q2[i];
          }
          res = xm2 * (d2 + xm2 * (xnum / xden));
        } else {
          if (y <= 12.0) {

            xm4 = y - 4.0;
            xden = -1.0;
            xnum = 0.0;
            for (int i = 0; i < 8; i++) {
              xnum = xnum * xm4 + p4[i];
              xden = xden * xm4 + q4[i];
            }
            res = d4 + xm4 * (xnum / xden);
          } else {

            res = 0.0;
            if (y <= frtbig) {
              res = c[6];
              ysq = y * y;
              for (int i = 0; i < 6; i++) {
                res = res / ysq + c[i];
              }
            }
            res = res / y;
            corr = MathLog(y);
            res = res + sqrtpi - 0.5 * corr;
            res = res + y * (corr - 1.0);
          }
        }
      }
    }
  } else {

    if (y < 0 && MathFloor(y) != y) {

      if (y > -1.e-100)
        res = -2 * MathLog(MathAbs(y)) - MathGammaLog(-y);
      else
        res = MathLog(M_PI / MathAbs(y * MathSin(M_PI * y))) - MathGammaLog(-y);
    } else {

      res = QPOSINF;
    }
  }

  return (res);
}

double MathBeta(const double a, const double b) {
  return MathExp(MathBetaLog(a, b));
}

double MathBetaLog(const double a, const double b) {
  return (MathGammaLog(a) + MathGammaLog(b) - MathGammaLog(a + b));
}

double MathBetaIncomplete(const double x, const double p, const double q) {
  double acu = 0.1E-16;
  double pp, qq, xx;
  int ifault = 0;
  double value = x;

  if (p <= 0.0 || q <= 0.0) {
    ifault = 1;
    return (value);
  }

  if (x < 0.0 || 1.0 < x) {
    ifault = 2;
    return (value);
  }

  if (x == 0.0 || x == 1.0) {
    return (value);
  }

  double beta_log = MathGammaLog(p) + MathGammaLog(q) - MathGammaLog(p + q);

  double psq = p + q;
  double cx = 1.0 - x;

  int indx = 0;
  if (p < psq * x) {
    xx = cx;
    cx = x;
    pp = q;
    qq = p;
    indx = 1;
  } else {
    xx = x;
    pp = p;
    qq = q;
    indx = 0;
  }

  value = 1.0;
  double term = 1.0;
  double ai = 1.0;
  int ns = (int)(qq + cx * psq);

  double rx = xx / cx;
  double temp = qq - ai;

  if (ns == 0.0) {
    rx = xx;
  }

  for (;;) {
    term = term * temp * rx / (pp + ai);
    value = value + term;
    ;
    temp = MathAbs(term);

    if (temp <= acu && temp <= acu * value) {
      value = value *
              MathExp(pp * MathLog(xx) + (qq - 1.0) * MathLog(cx) - beta_log) /
              pp;
      if (indx) {
        value = 1.0 - value;
      }
      break;
    }

    ai = ai + 1.0;
    ns--;

    if (0 <= ns) {
      temp = qq - ai;
      if (ns == 0) {
        rx = xx;
      }
    } else {
      temp = psq;
      psq = psq + 1.0;
    }
  }

  return (value);
}

double MathGammaIncomplete(double x, double alpha) {
  double eps = 10e-20;
  int iflag = 0;
  bool ll;
  int imax = 5000;
  double uflo = 1.0e-100;
  double cdfx = 0.0;
  int k = 0;

  if (alpha <= uflo || eps <= uflo) {
    iflag = 1;
    return (QNaN);
  }

  iflag = 0;

  if (x <= 0.0)
    return (QNaN);

  double dx = double(x);

  double pdfl = double(alpha - 1.0) * MathLog(dx) - dx - MathGammaLog(alpha);

  if (pdfl < MathLog(uflo)) {
    if (x >= alpha)
      cdfx = 1.0;
  } else {
    double p = alpha;
    double u = MathExp(pdfl);

    ll = true;
    if (x >= p) {
      k = int(p);

      if (p <= double(k))
        k = k - 1;

      double eta = p - double(k);
      double bl = double((eta - 1.0) * MathLog(dx) - dx - MathGammaLog(eta));
      ll = bl > MathLog(eps);
    }

    double epsx = eps / x;

    if (ll == true) {

      for (int i = 0; i <= imax; i++) {
        if (u <= epsx * (p - x)) {
          return (cdfx);
        }
        u = x * u / p;
        cdfx = cdfx + u;
        p = p + 1.0;
      }
      iflag = 2;
    } else {

      for (int j = 1; j <= k; j++) {
        p = p - 1.0;

        if (u <= epsx * (x - p))
          break;

        cdfx = cdfx + u;
        u = p * u / x;
      }
      cdfx = 1.0 - cdfx;
    }
  }

  return (cdfx);
}

long MathBinomialCoefficient(const int n, const int k) {
  int mn, mx;
  long value = 0;
  int n_k = n - k;

  if (k < n_k) {
    mn = k;
    mx = n_k;
  } else {
    mn = n_k;
    mx = k;
  }
  if (mn > 0) {
    value = mx + 1;
    for (int i = 2; i <= mn; i++)
      value = (value * (mx + i)) / i;
  } else {
    if (mn < 0)
      return (0);
    if (mn == 0)
      return (1);
  }

  return (value);
}

double MathBinomialCoefficientLog(const int n, const int k) {
  int mn, mx;
  long value = 0;
  int n_k = n - k;

  if (k < n_k) {
    mn = k;
    mx = n_k;
  } else {
    mn = n_k;
    mx = k;
  }
  if (mn > 0) {
    value = mx + 1;
    for (int i = 2; i <= mn; i++)
      value = (value * (mx + i)) / i;
  } else {
    if (mn < 0)
      return (QNEGINF);
    if (mn == 0)
      return (0);
  }

  return MathLog(value);
}

double MathBinomialCoefficientLog(const double n, const double k) {
  return (MathGammaLog(n + 1) - MathGammaLog(k + 1) - MathGammaLog(n - k + 1));
}

double MathHypergeometric2F2(const double a, const double b, const double c,
                             const double d, const double z) {
  double a1 = 1.0;
  double b1 = 1.0;
  double tol = 10E-10;

  for (int j = 1; j <= 500; j++) {

    a1 = (a + j - 1) * (b + j - 1) / (c + j - 1) / (d + j - 1) * z / j * a1;

    b1 = b1 + a1;

    if (MathAbs(a1) / MathAbs(b1) < tol)
      return (b1);
  }

  return (QNaN);
}

double TailLog0(const bool tail, const bool log_mode) {
  if (tail == true) {
    if (log_mode == true)
      return (QNEGINF);
    else
      return (0.0);
  } else {
    if (log_mode == true)
      return (0.0);
    else
      return (1.0);
  }
}

double TailLog1(const bool tail, const bool log_mode) {
  if (tail == true) {
    if (log_mode == true)
      return (0.0);
    else
      return (1.0);
  } else {
    if (log_mode == true)
      return (1.0);
    else
      return (0.0);
  }
}

double TailLogValue(const double value, const bool tail, const bool log_mode) {
  if (tail == true) {
    if (log_mode)
      return MathLog(MathAbs(value));
    else
      return (value);
  } else {
    if (log_mode)
      return MathLog(MathAbs(1.0 - value));
    else
      return (1.0 - value);
  }
}

double TailLogProbability(const double probability, const bool tail,
                          const bool log_mode) {
  if (tail == true) {
    if (log_mode)
      return MathExp(probability);
    else
      return (probability);
  } else {
    if (log_mode)
      return (1.0 - MathExp(probability));
    else
      return (1.0 - probability);
  }
}

bool MathSequence(const double from, const double to, const double step,
                  double &result[]) {

  if (!MathIsValidNumber(from) || !MathIsValidNumber(to) ||
      !MathIsValidNumber(step))
    return (false);

  if (to < from)
    return (false);

  int count = 1 + int((to - from) / step);

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  for (int i = 0; i < count; i++)
    result[i] = from + i * step;

  return (true);
}

bool MathSequence(const int from, const int to, const int step, int &result[]) {
  if (to < from)
    return (false);

  int count = 1 + int((to - from) / step);

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  for (int i = 0; i < count; i++)
    result[i] = from + i * step;

  return (true);
}

bool MathSequenceByCount(const double from, const double to, const int count,
                         double &result[]) {

  if (!MathIsValidNumber(from) || !MathIsValidNumber(to))
    return (false);

  if (to < from || count <= 0)
    return (false);

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  double step = (count == 1) ? 0 : ((to - from) / (count - 1));

  for (int i = 0; i < count; i++)
    result[i] = from + i * step;

  return (true);
}

bool MathSequenceByCount(const int from, const int to, const int count,
                         int &result[]) {
  if (to < from || count <= 0)
    return (false);

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  int step = (count == 1) ? 0 : ((to - from) / (count - 1));

  for (int i = 0; i < count; i++)
    result[i] = from + i * step;

  return (true);
}

bool MathReplicate(const double &array[], const int count, double &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);

  if (count <= 0)
    return (false);

  int target_size = size * count;
  if (ArraySize(result) < target_size)
    if (ArrayResize(result, target_size) != target_size)
      return (false);

  for (int i = 0; i < count; i++)
    ArrayCopy(result, array, i * size, 0, WHOLE_ARRAY);

  return (true);
}

bool MathReplicate(const int &array[], const int count, int &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);

  if (count <= 0)
    return (false);

  int target_size = size * count;
  if (ArraySize(result) < target_size)
    if (ArrayResize(result, target_size) != target_size)
      return (false);

  for (int i = 0; i < count; i++)
    ArrayCopy(result, array, i * size, 0, WHOLE_ARRAY);

  return (true);
}

bool MathReverse(const double &array[], double &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++) {
    int idx = size - 1 - i;
    result[idx] = array[i];
  }

  return (true);
}

bool MathReverse(const int &array[], int &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++) {
    int idx = size - 1 - i;
    result[idx] = array[i];
  }

  return (true);
}

bool MathReverse(double &array[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);
  int count = size / 2;
  for (int i = 0; i < count; i++) {
    int idx = size - 1 - i;

    double t = array[i];
    array[i] = array[idx];
    array[idx] = t;
  }

  return (true);
}

bool MathReverse(int &array[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);
  int count = size / 2;
  for (int i = 0; i < count; i++) {
    int idx = size - 1 - i;

    int t = array[i];
    array[i] = array[idx];
    array[idx] = t;
  }

  return (true);
}

bool MathIdentical(const double &array1[], const double &array2[]) {
  int size1 = ArraySize(array1);
  int size2 = ArraySize(array1);

  if (size1 != size2)
    return (false);

  if (size1 == 0)
    return (false);

  for (int i = 0; i < size1; i++) {
    if (array1[i] != array2[i])
      return (false);
  }

  return (true);
}

bool MathIdentical(const int &array1[], const int &array2[]) {
  int size1 = ArraySize(array1);
  int size2 = ArraySize(array1);

  if (size1 != size2)
    return (false);

  if (size1 == 0)
    return (false);

  for (int i = 0; i < size1; i++) {
    if (array1[i] != array2[i])
      return (false);
  }

  return (true);
}

bool MathUnique(const double &array[], double &result[]) {

  int size = ArraySize(array);
  if (size == 0)
    return (false);

  bool checked[];
  if (ArrayResize(checked, size) != size)
    return (false);
  ArrayFill(checked, 0, size, false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  int unique_count = 0;
  double value = 0;
  for (;;) {
    bool flag = false;
    for (int i = unique_count; i < size; i++) {
      if (!flag && !checked[i]) {
        value = array[i];
        result[unique_count] = array[i];
        unique_count++;
        checked[i] = true;
        flag = true;
      } else if (flag && value == array[i])
        checked[i] = true;
    }
    if (!flag)
      break;
  }

  ArrayResize(result, unique_count);

  return (true);
}

bool MathUnique(const int &array[], int &result[]) {

  int size = ArraySize(array);
  if (size == 0)
    return (false);

  bool checked[];
  if (ArrayResize(checked, size) != size)
    return (false);
  ArrayFill(checked, 0, size, false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  int unique_count = 0;
  int value = 0;
  for (;;) {
    bool flag = false;
    for (int i = unique_count; i < size; i++) {
      if (!flag && !checked[i]) {
        value = array[i];
        result[unique_count] = array[i];
        unique_count++;
        checked[i] = true;
        flag = true;
      } else if (flag && value == array[i])
        checked[i] = true;
    }
    if (!flag)
      break;
  }

  ArrayResize(result, unique_count);

  return (true);
}

void MathQuickSortAscending(double &array[], int &indices[], int first,
                            int last) {
  int i, j, t_int;
  double p_double, t_double;

  if (first < 0 || last < 0)
    return;

  i = first;
  j = last;
  while (i < last) {

    p_double = array[(first + last) >> 1];
    while (i < j) {
      while (array[i] < p_double) {

        if (i == ArraySize(array) - 1)
          break;
        i++;
      }
      while (array[j] > p_double) {

        if (j == 0)
          break;
        j--;
      }
      if (i <= j) {

        t_double = array[i];
        array[i] = array[j];
        array[j] = t_double;

        t_int = indices[i];
        indices[i] = indices[j];
        indices[j] = t_int;
        i++;

        if (j == 0)
          break;
        j--;
      }
    }
    if (first < j)
      MathQuickSortAscending(array, indices, first, j);
    first = i;
    j = last;
  }
}

void MathQuickSortDescending(double &array[], int &indices[], int first,
                             int last) {
  int i, j, t_int;
  double p_double, t_double;

  if (first < 0 || last < 0)
    return;

  i = first;
  j = last;
  while (i < last) {

    p_double = array[(first + last) >> 1];
    while (i < j) {
      while (array[i] > p_double) {

        if (i == ArraySize(array) - 1)
          break;
        i++;
      }
      while (array[j] < p_double) {

        if (j == 0)
          break;
        j--;
      }
      if (i <= j) {

        t_double = array[i];
        array[i] = array[j];
        array[j] = t_double;

        t_int = indices[i];
        indices[i] = indices[j];
        indices[j] = t_int;
        i++;

        if (j == 0)
          break;
        j--;
      }
    }
    if (first < j)
      MathQuickSortDescending(array, indices, first, j);
    first = i;
    j = last;
  }
}

void MathQuickSort(double &array[], int &indices[], int first, int last,
                   int mode) {
  if (mode > 0)
    MathQuickSortAscending(array, indices, first, last);
  else
    MathQuickSortDescending(array, indices, first, last);
}

bool MathOrder(const double &array[], int &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);

  double tmp_array[];
  ArrayCopy(tmp_array, array, 0, 0, WHOLE_ARRAY);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);
  for (int i = 0; i < size; i++)
    result[i] = i + 1;

  MathQuickSortAscending(tmp_array, result, 0, size - 1);

  return (true);
}

bool MathOrder(const int &array[], int &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);

  double tmp_array[];
  if (ArrayResize(tmp_array, size) != size)
    return (false);
  for (int i = 0; i < size; i++)
    tmp_array[i] = array[i];

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);
  for (int i = 0; i < size; i++)
    result[i] = i + 1;

  MathQuickSortAscending(tmp_array, result, 0, size - 1);

  return (true);
}

bool MathBitwiseNot(const int &array[], int &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);
  for (int i = 0; i < size; i++)
    result[i] = ~array[i];

  return (true);
}

bool MathBitwiseNot(int &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = ~array[i];

  return (true);
}

bool MathBitwiseAnd(const int &array1[], const int &array2[], int &result[]) {
  int size1 = ArraySize(array1);
  int size2 = ArraySize(array2);
  if (size1 == 0 || size2 == 0 || size1 != size2)
    return (false);

  if (ArraySize(result) < size1)
    if (ArrayResize(result, size1) != size1)
      return (false);

  for (int i = 0; i < size1; i++)
    result[i] = array1[i] & array2[i];

  return (true);
}

bool MathBitwiseOr(const int &array1[], const int &array2[], int &result[]) {
  int size1 = ArraySize(array1);
  int size2 = ArraySize(array2);
  if (size1 == 0 || size2 == 0 || size1 != size2)
    return (false);

  if (ArraySize(result) < size1)
    if (ArrayResize(result, size1) != size1)
      return (false);

  for (int i = 0; i < size1; i++)
    result[i] = array1[i] | array2[i];

  return (true);
}

bool MathBitwiseXor(const int &array1[], const int &array2[], int &result[]) {
  int size1 = ArraySize(array1);
  int size2 = ArraySize(array2);
  if (size1 == 0 || size2 == 0 || size1 != size2)
    return (false);

  if (ArraySize(result) < size1)
    if (ArrayResize(result, size1) != size1)
      return (false);

  for (int i = 0; i < size1; i++)
    result[i] = array1[i] ^ array2[i];

  return (true);
}

bool MathBitwiseShiftL(const int &array[], const int n, int &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = array[i] << n;

  return (true);
}

bool MathBitwiseShiftL(int &array[], const int n) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = array[i] << n;

  return (true);
}

bool MathBitwiseShiftR(const int &array[], const int n, int &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = array[i] >> n;

  return (true);
}

bool MathBitwiseShiftR(int &array[], const int n) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = array[i] >> n;

  return (true);
}

bool MathCumulativeSum(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  double sum = 0.0;
  for (int i = 0; i < size; i++) {

    if (!MathIsValidNumber(array[i]))
      return (false);
    sum += array[i];
    result[i] = sum;
  }

  return (true);
}

bool MathCumulativeSum(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  double sum = 0.0;
  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(array[i]))
      return (false);
    sum += array[i];
    array[i] = sum;
  }

  return (true);
}

bool MathCumulativeProduct(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  double product = 1.0;
  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(array[i]))
      return (false);
    product *= array[i];
    result[i] = product;
  }

  return (true);
}

bool MathCumulativeProduct(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  double product = 1.0;
  for (int i = 0; i < size; i++) {

    if (!MathIsValidNumber(array[i]))
      return (false);
    product *= array[i];
    array[i] = product;
  }

  return (true);
}

bool MathCumulativeMin(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  double min = QPOSINF;
  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(array[i]) || !MathIsValidNumber(min))
      min += array[i];
    else
      min = MathMin(min, array[i]);
    result[i] = min;
  }

  return (true);
}

bool MathCumulativeMin(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  double min = QPOSINF;
  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(array[i]) || !MathIsValidNumber(min))
      min += array[i];
    else
      min = MathMin(min, array[i]);
    array[i] = min;
  }

  return (true);
}

bool MathCumulativeMax(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  double max = QNEGINF;
  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(array[i]) || !MathIsValidNumber(max))
      max += array[i];
    else
      max = MathMax(max, array[i]);
    result[i] = max;
  }

  return (true);
}

bool MathCumulativeMax(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  double max = QNEGINF;
  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(array[i]) || !MathIsValidNumber(max))
      max += array[i];
    else
      max = MathMax(max, array[i]);
    array[i] = max;
  }

  return (true);
}

bool MathSin(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathSin(array[i]);

  return (true);
}

bool MathSin(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathSin(array[i]);

  return (true);
}

bool MathCos(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathCos(array[i]);

  return (true);
}

bool MathCos(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathCos(array[i]);

  return (true);
}

bool MathTan(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathTan(array[i]);

  return (true);
}

bool MathTan(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathTan(array[i]);

  return (true);
}

bool MathArcsin(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathArcsin(array[i]);

  return (true);
}

bool MathArcsin(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathArcsin(array[i]);

  return (true);
}

bool MathArccos(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathArccos(array[i]);

  return (true);
}

bool MathArccos(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathArccos(array[i]);

  return (true);
}

bool MathArctan(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathArctan(array[i]);

  return (true);
}

bool MathArctan(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathArctan(array[i]);

  return (true);
}

bool MathSinPi(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathSin(M_PI * array[i]);

  return (true);
}

bool MathSinPi(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathSin(M_PI * array[i]);

  return (true);
}

bool MathCosPi(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathCos(M_PI * array[i]);

  return (true);
}

bool MathCosPi(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathCos(M_PI * array[i]);

  return (true);
}

bool MathTanPi(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathTan(M_PI * array[i]);

  return (true);
}

bool MathTanPi(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathTan(M_PI * array[i]);

  return (true);
}

bool MathAbs(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathAbs(array[i]);

  return (true);
}

bool MathAbs(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathAbs(array[i]);

  return (true);
}

bool MathCeil(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);
  for (int i = 0; i < size; i++)
    result[i] = MathCeil(array[i]);

  return (true);
}

bool MathCeil(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);
  for (int i = 0; i < size; i++)
    array[i] = MathCeil(array[i]);

  return (true);
}

bool MathFloor(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);
  for (int i = 0; i < size; i++)
    result[i] = MathFloor(array[i]);

  return (true);
}

bool MathFloor(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);
  for (int i = 0; i < size; i++)
    array[i] = MathFloor(array[i]);

  return (true);
}

bool MathTrunc(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);
  for (int i = 0; i < size; i++) {
    if (array[i] >= 0)
      result[i] = MathFloor(array[i]);
    else
      result[i] = MathCeil(array[i]);
  }

  return (true);
}

bool MathTrunc(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);
  for (int i = 0; i < size; i++) {
    if (array[i] >= 0)
      array[i] = MathFloor(array[i]);
    else
      array[i] = MathCeil(array[i]);
  }

  return (true);
}

bool MathSqrt(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathSqrt(array[i]);

  return (true);
}

bool MathSqrt(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathSqrt(array[i]);

  return (true);
}

bool MathExp(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathExp(array[i]);

  return (true);
}

bool MathExp(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathExp(array[i]);

  return (true);
}

bool MathPow(const double &array[], const double power, double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (!MathIsValidNumber(power))
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathPow(array[i], power);

  return (true);
}

bool MathPow(double &array[], const double power) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (!MathIsValidNumber(power))
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathPow(array[i], power);

  return (true);
}

bool MathLog(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathLog(array[i]);

  return (true);
}

bool MathLog(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathLog(array[i]);

  return (true);
}

bool MathLog(const double &array[], const double base, double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (!MathIsValidNumber(base))
    return (false);

  if (base == 1.0 || base <= 0.0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  double factor = 1.0 / MathLog(base);
  for (int i = 0; i < size; i++)
    result[i] = MathLog(array[i]) * factor;

  return (true);
}

bool MathLog(double &array[], const double base) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (!MathIsValidNumber(base))
    return (false);

  if (base == 1.0 || base <= 0.0)
    return (false);

  double factor = 1.0 / MathLog(base);
  for (int i = 0; i < size; i++)
    array[i] = MathLog(array[i]) * factor;

  return (true);
}

bool MathLog2(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  static const double factor = 1.0 / M_LN2;
  for (int i = 0; i < size; i++)
    result[i] = MathLog(array[i]) * factor;

  return (true);
}

bool MathLog2(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  static const double factor = 1.0 / M_LN2;
  for (int i = 0; i < size; i++)
    array[i] = MathLog(array[i]) * factor;

  return (true);
}

bool MathLog10(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathLog10(array[i]);

  return (true);
}

bool MathLog10(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathLog10(array[i]);

  return (true);
}

bool MathArctan2(const double &y[], const double &x[], double &result[]) {
  int size = ArraySize(x);
  if (size == 0 || ArraySize(y) != size)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathArctan2(y[i], x[i]);

  return (true);
}

bool MathRound(const double &array[], int digits, double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);
  if (digits < 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathRound(array[i], digits);

  return (true);
}

bool MathRound(double &array[], int digits) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);
  if (digits < 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathRound(array[i], digits);

  return (true);
}

bool MathDifference(const double &array[], const int lag, double &result[]) {
  int size = ArraySize(array) - lag;
  if (lag < 1 || size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = array[i + lag] - array[i];

  if (ArrayResize(result, size) != size)
    return (false);

  return (true);
}

bool MathDifference(const int &array[], const int lag, int &result[]) {
  int size = ArraySize(array) - lag;
  if (lag < 1 || size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = array[i + lag] - array[i];

  if (ArrayResize(result, size) != size)
    return (false);

  return (true);
}

bool MathDifference(const double &array[], const int lag, const int differences,
                    double &result[]) {
  int size = ArraySize(array);

  if (size == 0 || differences < 0 || lag * differences >= size)
    return (false);

  if (ArrayCopy(result, array, 0, 0, WHOLE_ARRAY) != size)
    return (false);

  for (int i = 0; i < differences; i++) {
    if (!MathDifference(result, lag, result))
      return false;
  }

  return (true);
}

bool MathDifference(const int &array[], const int lag, const int differences,
                    int &result[]) {
  int size = ArraySize(array);

  if (size == 0 || differences < 0 || lag * differences >= size)
    return (false);

  if (ArrayCopy(result, array, 0, 0, WHOLE_ARRAY) != size)
    return (false);

  for (int i = 0; i < differences; i++) {
    if (!MathDifference(result, lag, result))
      return false;
  }

  return (true);
}

bool MathSample(const double &array[], const int count, double &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return false;

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);
  for (int i = 0; i < count; i++) {
    int ind = (int)((ulong)size * MathRand() / 32768);
    result[i] = array[ind];
  }

  return true;
}

bool MathSample(const int &array[], const int count, int &result[]) {
  int size = ArraySize(array);

  if (size == 0)
    return false;

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);
  for (int i = 0; i < count; i++) {
    int ind = (int)((ulong)size * MathRand() / 32768);
    result[i] = array[ind];
  }

  return true;
}

bool MathSample(const double &array[], const int count, const bool replace,
                double &result[]) {

  if (replace)
    return MathSample(array, count, result);

  int size = ArraySize(array);
  if (size == 0 || count > size)
    return (false);

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  int indices[];

  if (!MathSequenceByCount(0, size - 1, size, indices))
    return (false);

  for (int i = 0; i < count; i++) {

    int j = i + int((ulong)(size - i) * MathRand() / 32768);

    if (j != i) {
      int t = indices[i];
      indices[i] = indices[j];
      indices[j] = t;
    }
  }

  for (int i = 0; i < count; i++)
    result[i] = array[indices[i]];

  return (true);
}

bool MathSample(const int &array[], const int count, const bool replace,
                int &result[]) {

  if (replace)
    return MathSample(array, count, result);

  int size = ArraySize(array);
  if (size == 0 || count > size)
    return (false);

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  int indices[];

  if (!MathSequenceByCount(0, size - 1, size, indices))
    return (false);

  for (int i = 0; i < count; i++) {

    int j = i + int((ulong)(size - i) * MathRand() / 32768);

    if (j != i) {
      int t = indices[i];
      indices[i] = indices[j];
      indices[j] = t;
    }
  }

  for (int i = 0; i < count; i++)
    result[i] = array[indices[i]];

  return (true);
}

bool MathSample(const double &array[], double &probabilities[], const int count,
                double &result[]) {
  int size = ArraySize(array);

  if (size == 0 || size != ArraySize(probabilities))
    return (false);

  if (count <= 0)
    return (false);

  double prob[];
  if (ArrayCopy(prob, probabilities, 0, 0, WHOLE_ARRAY) != size)
    return (false);

  double sum = 0;
  for (int i = 0; i < size; i++)
    sum += prob[i];

  if (sum == 0.0)
    return (false);

  sum = 1.0 / sum;

  for (int i = 0; i < size; i++)
    prob[i] *= sum;

  int indices[];
  if (ArrayResize(indices, size) != size)
    return (false);
  for (int i = 0; i < size; i++)
    indices[i] = i;

  MathQuickSortDescending(prob, indices, 0, size - 1);
  for (int i = 1; i < size; i++)
    prob[i] += prob[i - 1];

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  for (int i = 0; i < count; i++) {
    double prb = MathRand() / 32767.0;
    for (int k = 0; k < size; k++) {
      if (prb <= prob[k]) {
        result[i] = array[indices[k]];
        break;
      }
    }
  }

  return true;
}

bool MathSample(const int &array[], double &probabilities[], const int count,
                int &result[]) {
  int size = ArraySize(array);

  if (size == 0 || size != ArraySize(probabilities))
    return (false);

  if (count <= 0)
    return (false);

  double prob[];
  if (ArrayCopy(prob, probabilities, 0, 0, WHOLE_ARRAY) != size)
    return (false);

  double sum = 0;
  for (int i = 0; i < size; i++)
    sum += prob[i];

  if (sum == 0.0)
    return (false);

  sum = 1.0 / sum;

  for (int i = 0; i < size; i++)
    prob[i] *= sum;

  int indices[];
  if (ArrayResize(indices, size) != size)
    return (false);
  for (int i = 0; i < size; i++)
    indices[i] = i;

  MathQuickSortDescending(prob, indices, 0, size - 1);
  for (int i = 1; i < size; i++)
    prob[i] += prob[i - 1];

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  for (int i = 0; i < count; i++) {
    double prb = MathRand() / 32767.0;
    for (int k = 0; k < size; k++) {
      if (prb <= prob[k]) {
        result[i] = array[indices[k]];
        break;
      }
    }
  }

  return true;
}

bool MathSample(const double &array[], double &probabilities[], const int count,
                const bool replace, double &result[]) {

  if (replace)
    return MathSample(array, probabilities, count, result);

  int size = ArraySize(array);

  if (size == 0 || size != ArraySize(probabilities))
    return (false);

  if (count <= 0 || count > size)
    return (false);

  double prob[];
  if (ArrayCopy(prob, probabilities, 0, 0, WHOLE_ARRAY) != size)
    return (false);

  double sum = 0;
  for (int i = 0; i < size; i++)
    sum += prob[i];

  if (sum == 0.0)
    return (false);

  sum = 1.0 / sum;

  for (int i = 0; i < size; i++)
    prob[i] *= sum;

  int indices[];
  if (ArrayResize(indices, size) != size)
    return (false);
  for (int i = 0; i < size; i++)
    indices[i] = i;

  MathQuickSortDescending(prob, indices, 0, size - 1);
  for (int i = 1; i < size; i++)
    prob[i] += prob[i - 1];

  bool taken_values[];
  if (ArrayResize(taken_values, size) != size)
    return (false);
  ArrayFill(taken_values, 0, size, false);

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  for (int i = 0; i < count; i++) {
    double prb = MathRand() / 32767.0;
    for (int k = 0; k < size; k++) {
      int ind = indices[k];

      if (prb <= prob[k] && taken_values[ind] == false) {
        result[i] = array[ind];
        taken_values[ind] = true;
        break;
      }
    }
  }

  return true;
}

bool MathSample(const int &array[], double &probabilities[], const int count,
                const bool replace, int &result[]) {

  if (replace)
    return MathSample(array, probabilities, count, result);

  int size = ArraySize(array);

  if (size == 0 || size != ArraySize(probabilities))
    return (false);

  if (count <= 0 || count > size)
    return (false);

  double prob[];
  if (ArrayCopy(prob, probabilities, 0, 0, WHOLE_ARRAY) != size)
    return (false);

  double sum = 0;
  for (int i = 0; i < size; i++)
    sum += prob[i];

  if (sum == 0.0)
    return (false);

  sum = 1.0 / sum;

  for (int i = 0; i < size; i++)
    prob[i] *= sum;

  int indices[];
  if (ArrayResize(indices, size) != size)
    return (false);
  for (int i = 0; i < size; i++)
    indices[i] = i;

  MathQuickSortDescending(prob, indices, 0, size - 1);
  for (int i = 1; i < size; i++)
    prob[i] += prob[i - 1];

  bool taken_values[];
  if (ArrayResize(taken_values, size) != size)
    return (false);
  ArrayFill(taken_values, 0, size, false);

  if (ArraySize(result) < count)
    if (ArrayResize(result, count) != count)
      return (false);

  for (int i = 0; i < count; i++) {
    double prb = MathRand() / 32767.0;
    for (int k = 0; k < size; k++) {
      int ind = indices[k];

      if (prb <= prob[k] && taken_values[ind] == false) {
        result[i] = array[ind];
        taken_values[ind] = true;
        break;
      }
    }
  }

  return true;
}

bool MathTukeySummary(const double &array[], const bool removeNAN,
                      double &minimum, double &lower_hinge, double &median,
                      double &upper_hinge, double &maximum) {

  minimum = QNaN;
  lower_hinge = QNaN;
  median = QNaN;
  upper_hinge = QNaN;
  maximum = QNaN;

  int size = ArraySize(array);
  if (size == 0)
    return (false);

  double data[];
  if (ArrayResize(data, size) != size)
    return (false);

  int actual_values = 0;
  if (removeNAN == true) {

    for (int i = 0; i < size; i++) {
      if (MathIsValidNumber(array[i])) {
        data[actual_values] = array[i];
        actual_values++;
      }
    }

    ArrayResize(data, actual_values);
  } else {

    for (int i = 0; i < size; i++) {
      if (!MathIsValidNumber(array[i]))
        return (false);
    }

    if (ArrayCopy(data, array, 0, 0, WHOLE_ARRAY) != size)
      return (false);
  }

  ArraySort(data);
  int n = ArraySize(data);
  if (n == 0)
    return (false);

  double n4 = MathFloor((n + 3) * 0.5) * 0.5;
  double ind[5];
  ind[0] = 0;
  ind[1] = n4 - 1;
  ind[2] = 0.5 * (n + 1) - 1;
  ind[3] = n - n4;
  ind[4] = n - 1;

  minimum = 0.5 * (data[(int)MathFloor(ind[0])] + data[(int)MathCeil(ind[0])]);
  lower_hinge =
      0.5 * (data[(int)MathFloor(ind[1])] + data[(int)MathCeil(ind[1])]);
  median = 0.5 * (data[(int)MathFloor(ind[2])] + data[(int)MathCeil(ind[2])]);
  upper_hinge =
      0.5 * (data[(int)MathFloor(ind[3])] + data[(int)MathCeil(ind[3])]);
  maximum = 0.5 * (data[(int)MathFloor(ind[4])] + data[(int)MathCeil(ind[4])]);

  return (true);
}

bool MathRange(const double &array[], double &min, double &max) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  min = array[0];
  max = array[0];
  for (int i = 1; i < size; i++) {
    double value = array[i];
    min = MathMin(min, value);
    max = MathMax(max, value);
  }

  return (true);
}

double MathMin(const double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (QNaN);
  double min_value = array[0];
  for (int i = 1; i < size; i++)
    min_value = MathMin(min_value, array[i]);

  return (min_value);
}

double MathMax(const double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (QNaN);
  double max_value = array[0];
  for (int i = 1; i < size; i++)
    max_value = MathMax(max_value, array[i]);

  return (max_value);
}

double MathSum(const double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (QNaN);

  double sum = 0.0;
  for (int i = 0; i < size; i++)
    sum += array[i];

  return (sum);
}

double MathProduct(const double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (QNaN);

  double product = 1.0;
  for (int i = 0; i < size; i++)
    product *= array[i];

  return (product);
}

double MathStandardDeviation(const double &array[]) {
  int size = ArraySize(array);
  if (size <= 1)
    return (QNaN);

  double mean = 0.0;
  for (int i = 0; i < size; i++)
    mean += array[i];

  mean = mean / size;

  double sdev = 0;
  for (int i = 0; i < size; i++)
    sdev += MathPow(array[i] - mean, 2);

  return MathSqrt(sdev / (size - 1));
}

double MathAverageDeviation(const double &array[]) {
  int size = ArraySize(array);
  if (size <= 1)
    return (QNaN);

  double mean = 0.0;
  for (int i = 0; i < size; i++)
    mean += array[i];
  mean = mean / size;

  double adev = 0;
  for (int i = 0; i < size; i++)
    adev += MathAbs(array[i] - mean);
  adev = adev / size;

  return (adev);
}

double MathMedian(double &array[]) {
  int size = ArraySize(array);

  if (size == 0)
    return (QNaN);

  double sorted_values[];
  if (ArrayCopy(sorted_values, array, 0, 0, WHOLE_ARRAY) != size)
    return (QNaN);
  ArraySort(sorted_values);

  if (size % 2 == 1)
    return (sorted_values[size / 2]);

  return (0.5 *
          (sorted_values[(size - 1) / 2] + sorted_values[(size + 1) / 2]));
}

double MathMean(const double &array[]) {
  int size = ArraySize(array);

  if (size < 1)
    return (QNaN);

  double mean = 0.0;
  for (int i = 0; i < size; i++)
    mean += array[i];
  mean = mean / size;

  return (mean);
}

double MathVariance(const double &array[]) {
  int size = ArraySize(array);

  if (size < 2)
    return (QNaN);

  double mean = 0.0;
  for (int i = 0; i < size; i++)
    mean += array[i];
  mean = mean / size;

  double variance = 0;
  for (int i = 0; i < size; i++)
    variance += MathPow(array[i] - mean, 2);
  variance = variance / (size - 1);

  return (variance);
}

double MathSkewness(const double &array[]) {
  int size = ArraySize(array);

  if (size < 3)
    return (QNaN);

  double mean = 0.0;
  for (int i = 0; i < size; i++)
    mean += array[i];
  mean = mean / size;

  double variance = 0;
  double skewness = 0;
  for (int i = 0; i < size; i++) {
    double sqr_dev = MathPow(array[i] - mean, 2);
    skewness += sqr_dev * (array[i] - mean);
    variance += sqr_dev;
  }
  variance = (variance) / (size - 1);
  double v3 = MathPow(MathSqrt(variance), 3);

  if (v3 != 0) {
    skewness = skewness / (size * v3);

    return (skewness);
  } else
    return (QNaN);
}

double MathKurtosis(const double &array[]) {
  int size = ArraySize(array);

  if (size < 4)
    return (QNaN);

  double mean = 0.0;
  for (int i = 0; i < size; i++)
    mean += array[i];
  mean = mean / size;

  double variance = 0;
  double kurtosis = 0;
  for (int i = 0; i < size; i++) {
    double sqr_dev = MathPow(array[i] - mean, 2);
    variance += sqr_dev;
    kurtosis += sqr_dev * sqr_dev;
  }

  variance = (variance) / (size - 1);
  double v4 = MathPow(MathSqrt(variance), 4);

  if (v4 != 0) {

    kurtosis = kurtosis / (size * v4);
    kurtosis -= 3;

    return (kurtosis);
  } else
    return (QNaN);
}

bool MathLog1p(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathLog1p(array[i]);

  return (true);
}

bool MathLog1p(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathLog1p(array[i]);

  return (true);
}

bool MathExpm1(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathExpm1(array[i]);

  return (true);
}

bool MathExpm1(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathExpm1(array[i]);

  return (true);
}

bool MathSinh(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathSinh(array[i]);

  return (true);
}

bool MathSinh(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathSinh(array[i]);

  return (true);
}

bool MathCosh(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathCosh(array[i]);

  return (true);
}

bool MathCosh(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathCosh(array[i]);

  return (true);
}

bool MathTanh(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathTanh(array[i]);

  return (true);
}

bool MathTanh(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathTanh(array[i]);

  return (true);
}

bool MathArcsinh(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathArcsinh(array[i]);

  return (true);
}

bool MathArcsinh(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathArcsinh(array[i]);

  return (true);
}

bool MathArccosh(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathArccosh(array[i]);

  return (true);
}

bool MathArccosh(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathArccosh(array[i]);

  return (true);
}

bool MathArctanh(const double &array[], double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathArctanh(array[i]);

  return (true);
}

bool MathArctanh(double &array[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathArctanh(array[i]);

  return (true);
}

double MathSignif(const double x, const int digits) {
  if (x == 0)
    return x;

  int dig = digits;
  if (dig > 30)
    return x;
  if (dig < 1)
    dig = 1;

  double sign = 1.0;
  double xx = x;
  if (xx < 0.0) {
    sign = -sign;
    xx = -xx;
  }

  double l10 = MathLog10(xx);
  double e10 = (int)(dig - 1 - MathFloor(l10));
  double value = 0, pwr10;
  if (e10 > 0) {
    pwr10 = MathPow(10, e10);
    value = MathFloor((xx * pwr10) + 0.5) / pwr10;
  } else {
    pwr10 = MathPow(10, -e10);
    value = MathFloor((xx / pwr10) + 0.5) * pwr10;
  }
  return (sign * value);
}

bool MathSignif(const double &array[], int digits, double &result[]) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  if (ArraySize(result) < size)
    if (ArrayResize(result, size) != size)
      return (false);

  for (int i = 0; i < size; i++)
    result[i] = MathSignif(array[i], digits);

  return (true);
}

bool MathSignif(double &array[], int digits) {
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++)
    array[i] = MathSignif(array[i], digits);

  return (true);
}

bool MathRank(const double &array[], double &rank[]) {
  int size = ArraySize(array);
  if (size < 1)
    return (false);
  if (size == 1) {
    if (ArrayResize(rank, size) != size)
      return (false);
    rank[0] = 1;
    return (true);
  }

  double values[];
  int indices[];
  if (ArrayCopy(values, array, 0, 0, WHOLE_ARRAY) != size)
    return (false);
  if (!MathSequenceByCount(0, size, size, indices))
    return (false);
  if (ArrayResize(rank, size) != size)
    return (false);

  int i, j, k, t, tmpi;
  double tmp;

  if (size != 1) {
    i = 2;
    do {
      t = i;
      while (t != 1) {
        k = t / 2;
        if (values[k - 1] >= values[t - 1])
          t = 1;
        else {

          tmp = values[k - 1];
          values[k - 1] = values[t - 1];
          values[t - 1] = tmp;
          tmpi = indices[k - 1];
          indices[k - 1] = indices[t - 1];
          indices[t - 1] = tmpi;
          t = k;
        }
      }
      i = i + 1;
    } while (i <= size);
    i = size - 1;
    do {

      tmp = values[i];
      values[i] = values[0];
      values[0] = tmp;
      tmpi = indices[i];
      indices[i] = indices[0];
      indices[0] = tmpi;
      t = 1;
      while (t != 0) {
        k = 2 * t;
        if (k > i)
          t = 0;
        else {
          if (k < i)
            if (values[k] > values[k - 1])
              k++;
          if (values[t - 1] >= values[k - 1])
            t = 0;
          else {

            tmp = values[k - 1];
            values[k - 1] = values[t - 1];
            values[t - 1] = tmp;
            tmpi = indices[k - 1];
            indices[k - 1] = indices[t - 1];
            indices[t - 1] = tmpi;
            t = k;
          }
        }
      }
      i = i - 1;
    } while (i >= 1);
  }

  i = 0;
  while (i < size) {
    j = i + 1;
    while (j < size) {

      if (values[j] != values[i])
        break;
      j = j + 1;
    }
    for (k = i; k < j; k++)
      values[k] = 1 + (i + j - 1) * 0.5;
    i = j;
  }

  for (i = 0; i < size; i++)
    rank[indices[i]] = values[i];

  return (true);
}

bool MathRank(const int &array[], double &rank[]) {
  int size = ArraySize(array);
  if (size < 1)
    return (false);
  if (size == 1) {
    if (ArrayResize(rank, size) != size)
      return (false);
    rank[0] = 1;
    return (true);
  }

  double values[];
  int indices[];

  if (ArrayResize(values, size) != size)
    return (false);
  for (int i = 0; i < size; i++)
    values[i] = array[i];

  if (!MathSequenceByCount(0, size, size, indices))
    return (false);
  if (ArrayResize(rank, size) != size)
    return (false);

  int i, j, k, t, tmpi;
  double tmp;

  if (size != 1) {
    i = 2;
    do {
      t = i;
      while (t != 1) {
        k = t / 2;
        if (values[k - 1] >= values[t - 1])
          t = 1;
        else {

          tmp = values[k - 1];
          values[k - 1] = values[t - 1];
          values[t - 1] = tmp;
          tmpi = indices[k - 1];
          indices[k - 1] = indices[t - 1];
          indices[t - 1] = tmpi;
          t = k;
        }
      }
      i = i + 1;
    } while (i <= size);
    i = size - 1;
    do {

      tmp = values[i];
      values[i] = values[0];
      values[0] = tmp;
      tmpi = indices[i];
      indices[i] = indices[0];
      indices[0] = tmpi;
      t = 1;
      while (t != 0) {
        k = 2 * t;
        if (k > i)
          t = 0;
        else {
          if (k < i)
            if (values[k] > values[k - 1])
              k++;
          if (values[t - 1] >= values[k - 1])
            t = 0;
          else {

            tmp = values[k - 1];
            values[k - 1] = values[t - 1];
            values[t - 1] = tmp;
            tmpi = indices[k - 1];
            indices[k - 1] = indices[t - 1];
            indices[t - 1] = tmpi;
            t = k;
          }
        }
      }
      i = i - 1;
    } while (i >= 1);
  }

  i = 0;
  while (i < size) {
    j = i + 1;
    while (j < size) {

      if (values[j] != values[i])
        break;
      j = j + 1;
    }
    for (k = i; k < j; k++)
      values[k] = 1 + (i + j - 1) * 0.5;
    i = j;
  }

  for (i = 0; i < size; i++)
    rank[indices[i]] = values[i];

  return (true);
}

bool MathCorrelationPearson(const double &array1[], const double &array2[],
                            double &r) {
  r = QNaN;
  int size = ArraySize(array1);
  if (size <= 1 || ArraySize(array2) != size)
    return (false);

  double xmean = 0;
  double ymean = 0;
  double v = 1.0 / (double)size;
  double x0 = array1[0];
  double y0 = array2[0];
  double s = 0;
  double xv = 0;
  double yv = 0;
  double t1 = 0;
  double t2 = 0;
  bool samex = true;
  bool samey = true;

  for (int i = 0; i < size; i++) {
    s = array1[i];
    samex = samex && s == x0;
    xmean += s * v;
    s = array2[i];
    samey = samey && s == y0;
    ymean += s * v;
  }

  if (samex || samey)
    return (false);

  s = 0;
  for (int i = 0; i < size; i++) {
    t1 = array1[i] - xmean;
    t2 = array2[i] - ymean;
    xv += t1 * t1;
    yv += t2 * t2;
    s += t1 * t2;
  }

  if (xv == 0 || yv == 0)
    return (false);

  r = s / MathSqrt(xv * yv);

  return (true);
}

bool MathCorrelationPearson(const int &array1[], const int &array2[],
                            double &r) {
  r = QNaN;
  int size = ArraySize(array1);
  if (size <= 1 || ArraySize(array2) != size)
    return (false);

  double xmean = 0;
  double ymean = 0;
  double v = 1.0 / (double)size;
  double x0 = array1[0];
  double y0 = array2[0];
  double s = 0;
  double xv = 0;
  double yv = 0;
  double t1 = 0;
  double t2 = 0;
  bool samex = true;
  bool samey = true;

  for (int i = 0; i < size; i++) {
    s = array1[i];
    samex = samex && s == x0;
    xmean += s * v;
    s = array2[i];
    samey = samey && s == y0;
    ymean += s * v;
  }

  if (samex || samey)
    return (false);

  s = 0;
  for (int i = 0; i < size; i++) {
    t1 = array1[i] - xmean;
    t2 = array2[i] - ymean;
    xv += t1 * t1;
    yv += t2 * t2;
    s += t1 * t2;
  }

  if (xv == 0 || yv == 0)
    return (false);

  r = s / MathSqrt(xv * yv);

  return (true);
}

bool MathCorrelationSpearman(const double &array1[], const double &array2[],
                             double &r) {
  r = QNaN;
  int size = ArraySize(array1);
  if (size < 1 || ArraySize(array2) != size)
    return (false);

  double rank_x[];
  double rank_y[];
  if (!MathRank(array1, rank_x))
    return (false);
  if (!MathRank(array2, rank_y))
    return (false);

  return MathCorrelationPearson(rank_x, rank_y, r);
}

bool MathCorrelationSpearman(const int &array1[], const int &array2[],
                             double &r) {
  r = QNaN;
  int size = ArraySize(array1);
  if (size < 1 || ArraySize(array2) != size)
    return (false);

  double rank_x[];
  double rank_y[];
  if (!MathRank(array1, rank_x))
    return (false);
  if (!MathRank(array2, rank_y))
    return (false);

  return MathCorrelationPearson(rank_x, rank_y, r);
}

bool MathCorrelationKendall(const double &array1[], const double &array2[],
                            double &tau) {
  tau = QNaN;
  int size = ArraySize(array1);
  if (size == 0 || ArraySize(array2) != size)
    return (false);

  int cnt1 = 0, cnt2 = 0, cnt = 0;

  for (int i = 0; i < size; i++) {
    for (int j = i + 1; j < size; j++) {
      double delta1 = array1[i] - array1[j];
      double delta2 = array2[i] - array2[j];
      double delta = delta1 * delta2;
      if (delta == 0) {
        if (delta1 != 0)
          cnt1++;
        if (delta2 != 0)
          cnt2++;
      } else {
        cnt1++;
        cnt2++;
        if (delta > 0.0)
          cnt++;
        else
          cnt--;
      }
    }
  }

  double den = cnt1 * cnt2;
  if (den == 0)
    return (false);
  tau = cnt / MathSqrt(den);

  return (true);
}

bool MathCorrelationKendall(const int &array1[], const int &array2[],
                            double &tau) {
  tau = QNaN;
  int size = ArraySize(array1);
  if (size == 0 || ArraySize(array2) != size)
    return (false);

  int cnt1 = 0, cnt2 = 0, cnt = 0;

  for (int i = 0; i < size; i++) {
    for (int j = i + 1; j < size; j++) {
      double delta1 = array1[i] - array1[j];
      double delta2 = array2[i] - array2[j];
      double delta = delta1 * delta2;
      if (delta == 0) {
        if (delta1 != 0)
          cnt1++;
        if (delta2 != 0)
          cnt2++;
      } else {
        cnt1++;
        cnt2++;
        if (delta > 0.0)
          cnt++;
        else
          cnt--;
      }
    }
  }

  double den = cnt1 * cnt2;
  if (den == 0)
    return (false);
  tau = cnt / MathSqrt(den);

  return (true);
}

bool MathQuantile(const double &array[], const double &probs[],
                  double &quantile[]) {
  int size = ArraySize(array);
  int size_p = ArraySize(probs);

  if (size == 0 || size_p == 0)
    return (false);

  for (int i = 0; i < size_p; i++) {

    if (!MathIsValidNumber(probs[i]))
      return (false);

    if (probs[i] < 0.0 || probs[i] > 1.0)
      return (false);
  }

  double x_values[];
  if (ArrayCopy(x_values, array, 0, 0, WHOLE_ARRAY) != size)
    return (false);

  if (ArraySize(quantile) < size_p)
    if (ArrayResize(quantile, size_p) != size_p)
      return (false);

  double ind[];
  int lo[];
  int hi[];
  ArrayResize(ind, size_p);
  ArrayResize(lo, size_p);
  ArrayResize(hi, size_p);

  for (int i = 0; i < size_p; i++) {
    ind[i] = (size - 1) * probs[i];
    lo[i] = (int)MathFloor(ind[i]);
    hi[i] = (int)MathCeil(ind[i]);
  }

  int indices[];
  MathSequenceByCount(0, size - 1, size, indices);
  MathQuickSort(x_values, indices, 0, size - 1, 1);
  for (int i = 0; i < size_p; i++) {
    quantile[i] = x_values[lo[i]];
    if (ind[i] > lo[i]) {
      double gamma = (ind[i] - lo[i]);
      quantile[i] = (1.0 - gamma) * quantile[i] + gamma * x_values[hi[i]];
    }
  }

  return (true);
}

bool MathProbabilityDensityEmpirical(const double &array[], const int count,
                                     double &x[], double &pdf[]) {
  if (count <= 1)
    return (false);
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(array[i]))
      return (false);
  }

  if (ArraySize(x) < count)
    if (ArrayResize(x, count) != count)
      return (false);
  if (ArraySize(pdf) < count)
    if (ArrayResize(pdf, count) != count)
      return (false);

  double minv = array[0];
  double maxv = array[0];
  for (int i = 1; i < size; i++) {
    minv = MathMin(minv, array[i]);
    maxv = MathMax(maxv, array[i]);
  }
  double range = maxv - minv;
  if (range == 0)
    return (false);

  for (int i = 0; i < count; i++) {
    x[i] = minv + i * range / (count - 1);
    pdf[i] = 0;
  }
  for (int i = 0; i < size; i++) {
    double v = (array[i] - minv) / range;
    int ind = int((v * (count - 1)));
    pdf[ind]++;
  }

  double dx = range / count;
  double sum = 0;
  for (int i = 0; i < count; i++)
    sum += pdf[i] * dx;
  if (sum == 0)
    return (false);
  double coef = 1.0 / sum;
  for (int i = 0; i < count; i++)
    pdf[i] *= coef;

  return (true);
}

bool MathCumulativeDistributionEmpirical(const double &array[], const int count,
                                         double &x[], double &cdf[]) {
  if (count <= 1)
    return (false);
  int size = ArraySize(array);
  if (size == 0)
    return (false);

  for (int i = 0; i < size; i++) {
    if (!MathIsValidNumber(array[i]))
      return (false);
  }

  if (ArraySize(x) < count)
    if (ArrayResize(x, count) != count)
      return (false);
  if (ArraySize(cdf) < count)
    if (ArrayResize(cdf, count) != count)
      return (false);

  double minv = array[0];
  double maxv = array[0];
  for (int i = 1; i < size; i++) {
    minv = MathMin(minv, array[i]);
    maxv = MathMax(maxv, array[i]);
  }
  double range = maxv - minv;
  if (range == 0)
    return (false);

  double pdf[];
  if (ArrayResize(pdf, count) != count)
    return (false);
  for (int i = 0; i < count; i++) {
    x[i] = minv + i * range / (count - 1);
    pdf[i] = 0;
  }
  for (int i = 0; i < size; i++) {
    double v = (array[i] - minv) / range;
    int ind = int((v * (count - 1)));
    pdf[ind]++;
  }

  double dx = range / count;
  double sum = 0;
  for (int i = 0; i < count; i++)
    sum += pdf[i] * dx;
  if (sum == 0)
    return (false);
  double coef = 1.0 / sum;
  for (int i = 0; i < count; i++)
    pdf[i] *= coef;

  sum = 0.0;
  for (int i = 0; i < count; i++) {
    sum += pdf[i] * dx;
    cdf[i] = sum;
  }

  return (true);
}

#endif
