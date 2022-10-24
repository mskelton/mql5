#ifndef IMAP_H
#define IMAP_H

#include "ICollection.mqh"
template <typename TKey, typename TValue> class CKeyValuePair;

template <typename TKey, typename TValue>
interface IMap : public ICollection<CKeyValuePair<TKey, TValue> *> {

  bool Add(TKey key, TValue value);

  bool Contains(TKey key, TValue value);
  bool Remove(TKey key);

  bool TryGetValue(TKey key, TValue &value);
  bool TrySetValue(TKey key, TValue value);

  int CopyTo(TKey &dst_keys[], TValue &dst_values[], const int dst_start = 0);
};

#endif
