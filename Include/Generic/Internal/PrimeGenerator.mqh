#ifndef PRIME_GENERATOR_H
#define PRIME_GENERATOR_H

class CPrimeGenerator {
private:
  const static int s_primes;
  const static int s_hash_prime;

public:
  static bool IsPrime(const int candidate);
  static int GetPrime(const int min);
  static int ExpandPrime(const int old_size);
};
