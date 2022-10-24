#ifndef EXPERT_SIGNAL_H
#define EXPERT_SIGNAL_H

#include "ExpertBase.mqh"

#define IS_PATTERN_USAGE(p) ((m_patterns_usage & (((int)1) << p)) != 0)

class CExpertSignal : public CExpertBase {
protected:
  double m_base_price;

  CArrayObj m_filters;

  double m_weight;
  int m_patterns_usage;
  int m_general;
  long m_ignore;
  long m_invert;
  int m_threshold_open;
  int m_threshold_close;
  double m_price_level;
  double m_stop_level;
  double m_take_level;
  int m_expiration;
  double m_direction;

public:
  CExpertSignal(void);
  ~CExpertSignal(void);

  void BasePrice(double value) {
    m_base_price = value;
  }
  int UsedSeries(void);

  void Weight(double value) {
    m_weight = value;
  }
  void PatternsUsage(int value) {
    m_patterns_usage = value;
  }
  void General(int value) {
    m_general = value;
  }
  void Ignore(long value) {
    m_ignore = value;
  }
  void Invert(long value) {
    m_invert = value;
  }
  void ThresholdOpen(int value) {
    m_threshold_open = value;
  }
  void ThresholdClose(int value) {
    m_threshold_close = value;
  }
  void PriceLevel(double value) {
    m_price_level = value;
  }
  void StopLevel(double value) {
    m_stop_level = value;
  }
  void TakeLevel(double value) {
    m_take_level = value;
  }
  void Expiration(int value) {
    m_expiration = value;
  }

  void Magic(ulong value);

  virtual bool ValidationSettings(void);

  virtual bool InitIndicators(CIndicators *indicators);

  virtual bool AddFilter(CExpertSignal *filter);

  virtual bool CheckOpenLong(double &price, double &sl, double &tp,
                             datetime &expiration);
  virtual bool CheckOpenShort(double &price, double &sl, double &tp,
                              datetime &expiration);

  virtual bool OpenLongParams(double &price, double &sl, double &tp,
                              datetime &expiration);
  virtual bool OpenShortParams(double &price, double &sl, double &tp,
                               datetime &expiration);

  virtual bool CheckCloseLong(double &price);
  virtual bool CheckCloseShort(double &price);

  virtual bool CloseLongParams(double &price);
  virtual bool CloseShortParams(double &price);

  virtual bool CheckReverseLong(double &price, double &sl, double &tp,
                                datetime &expiration);
  virtual bool CheckReverseShort(double &price, double &sl, double &tp,
                                 datetime &expiration);

  virtual bool CheckTrailingOrderLong(COrderInfo *order, double &price) {
    return (false);
  }
  virtual bool CheckTrailingOrderShort(COrderInfo *order, double &price) {
    return (false);
  }

  virtual int LongCondition(void) {
    return (0);
  }
  virtual int ShortCondition(void) {
    return (0);
  }
  virtual double Direction(void);
  void SetDirection(void) {
    m_direction = Direction();
  }
};

CExpertSignal::CExpertSignal(void)
    : m_base_price(0.0), m_general(-1), m_weight(1.0), m_patterns_usage(-1),
      m_ignore(0), m_invert(0), m_threshold_open(50), m_threshold_close(100),
      m_price_level(0.0), m_stop_level(0.0), m_take_level(0.0), m_expiration(0),
      m_direction(EMPTY_VALUE) {}

CExpertSignal::~CExpertSignal(void) {}

int CExpertSignal::UsedSeries(void) {
  if (m_other_symbol || m_other_period)
    return (0);

  int total = m_filters.Total();

  for (int i = 0; i < total; i++) {
    CExpertSignal *filter = m_filters.At(i);

    if (filter == NULL)
      return (false);
    m_used_series |= filter.UsedSeries();
  }

  return (m_used_series);
}

void CExpertSignal::Magic(ulong value) {
  int total = m_filters.Total();

  for (int i = 0; i < total; i++) {
    CExpertSignal *filter = m_filters.At(i);

    if (filter == NULL)
      continue;
    filter.Magic(value);
  }

  CExpertBase::Magic(value);
}

bool CExpertSignal::ValidationSettings(void) {
  if (!CExpertBase::ValidationSettings())
    return (false);

  int total = m_filters.Total();

  for (int i = 0; i < total; i++) {
    CExpertSignal *filter = m_filters.At(i);

    if (filter == NULL)
      return (false);
    if (!filter.ValidationSettings())
      return (false);
  }

  return (true);
}

bool CExpertSignal::InitIndicators(CIndicators *indicators) {

  if (indicators == NULL)
    return (false);

  CExpertSignal *filter;
  int total = m_filters.Total();

  for (int i = 0; i < total; i++) {
    filter = m_filters.At(i);
    m_used_series |= filter.UsedSeries();
  }

  if (!CExpertBase::InitIndicators(indicators))
    return (false);

  for (int i = 0; i < total; i++) {
    filter = m_filters.At(i);
    filter.SetPriceSeries(m_open, m_high, m_low, m_close);
    filter.SetOtherSeries(m_spread, m_time, m_tick_volume, m_real_volume);
    if (!filter.InitIndicators(indicators))
      return (false);
  }

  return (true);
}

bool CExpertSignal::AddFilter(CExpertSignal *filter) {

  if (filter == NULL)
    return (false);

  if (!filter.Init(m_symbol, m_period, m_adjusted_point))
    return (false);

  if (!m_filters.Add(filter))
    return (false);
  filter.EveryTick(m_every_tick);
  filter.Magic(m_magic);

  return (true);
}

bool CExpertSignal::CheckOpenLong(double &price, double &sl, double &tp,
                                  datetime &expiration) {
  bool result = false;

  if (m_direction == EMPTY_VALUE)
    return (false);

  if (m_direction >= m_threshold_open) {

    result = true;

    if (!OpenLongParams(price, sl, tp, expiration))
      result = false;
  }

  m_base_price = 0.0;

  return (result);
}

bool CExpertSignal::CheckOpenShort(double &price, double &sl, double &tp,
                                   datetime &expiration) {
  bool result = false;

  if (m_direction == EMPTY_VALUE)
    return (false);

  if (-m_direction >= m_threshold_open) {

    result = true;

    if (!OpenShortParams(price, sl, tp, expiration))
      result = false;
  }

  m_base_price = 0.0;

  return (result);
}

bool CExpertSignal::OpenLongParams(double &price, double &sl, double &tp,
                                   datetime &expiration) {
  CExpertSignal *general = (m_general != -1) ? m_filters.At(m_general) : NULL;

  if (general == NULL) {

    double base_price = (m_base_price == 0.0) ? m_symbol.Ask() : m_base_price;
    price =
        m_symbol.NormalizePrice(base_price - m_price_level * PriceLevelUnit());
    sl = (m_stop_level == 0.0)
             ? 0.0
             : m_symbol.NormalizePrice(price - m_stop_level * PriceLevelUnit());
    tp = (m_take_level == 0.0)
             ? 0.0
             : m_symbol.NormalizePrice(price + m_take_level * PriceLevelUnit());
    expiration += m_expiration * PeriodSeconds(m_period);
    return (true);
  }

  return (general.OpenLongParams(price, sl, tp, expiration));
}

bool CExpertSignal::OpenShortParams(double &price, double &sl, double &tp,
                                    datetime &expiration) {
  CExpertSignal *general = (m_general != -1) ? m_filters.At(m_general) : NULL;

  if (general == NULL) {

    double base_price = (m_base_price == 0.0) ? m_symbol.Bid() : m_base_price;
    price =
        m_symbol.NormalizePrice(base_price + m_price_level * PriceLevelUnit());
    sl = (m_stop_level == 0.0)
             ? 0.0
             : m_symbol.NormalizePrice(price + m_stop_level * PriceLevelUnit());
    tp = (m_take_level == 0.0)
             ? 0.0
             : m_symbol.NormalizePrice(price - m_take_level * PriceLevelUnit());
    expiration += m_expiration * PeriodSeconds(m_period);
    return (true);
  }

  return (general.OpenShortParams(price, sl, tp, expiration));
}

bool CExpertSignal::CheckCloseLong(double &price) {
  bool result = false;

  if (m_direction == EMPTY_VALUE)
    return (false);

  if (-m_direction >= m_threshold_close) {

    result = true;

    if (!CloseLongParams(price))
      result = false;
  }

  m_base_price = 0.0;

  return (result);
}

bool CExpertSignal::CheckCloseShort(double &price) {
  bool result = false;

  if (m_direction == EMPTY_VALUE)
    return (false);

  if (m_direction >= m_threshold_close) {

    result = true;

    if (!CloseShortParams(price))
      result = false;
  }

  m_base_price = 0.0;

  return (result);
}

bool CExpertSignal::CloseLongParams(double &price) {
  CExpertSignal *general = (m_general != -1) ? m_filters.At(m_general) : NULL;

  if (general == NULL) {

    price = (m_base_price == 0.0) ? m_symbol.Bid() : m_base_price;
    return (true);
  }

  return (general.CloseLongParams(price));
}

bool CExpertSignal::CloseShortParams(double &price) {
  CExpertSignal *general = (m_general != -1) ? m_filters.At(m_general) : NULL;

  if (general == NULL) {

    price = (m_base_price == 0.0) ? m_symbol.Ask() : m_base_price;
    return (true);
  }

  return (general.CloseShortParams(price));
}

bool CExpertSignal::CheckReverseLong(double &price, double &sl, double &tp,
                                     datetime &expiration) {
  double c_price;

  if (!CheckCloseLong(c_price))
    return (false);

  if (!CheckOpenShort(price, sl, tp, expiration))
    return (false);

  if (c_price != price)
    return (false);

  return (true);
}

bool CExpertSignal::CheckReverseShort(double &price, double &sl, double &tp,
                                      datetime &expiration) {
  double c_price;

  if (!CheckCloseShort(c_price))
    return (false);

  if (!CheckOpenLong(price, sl, tp, expiration))
    return (false);

  if (c_price != price)
    return (false);

  return (true);
}

double CExpertSignal::Direction(void) {
  long mask;
  double direction;
  double result = m_weight * (LongCondition() - ShortCondition());
  int number = (result == 0.0) ? 0 : 1;

  int total = m_filters.Total();

  for (int i = 0; i < total; i++) {

    mask = ((long)1) << i;

    if ((m_ignore & mask) != 0)
      continue;
    CExpertSignal *filter = m_filters.At(i);

    if (filter == NULL)
      continue;
    direction = filter.Direction();

    if (direction == EMPTY_VALUE)
      return (EMPTY_VALUE);

    if ((m_invert & mask) != 0)
      result -= direction;
    else
      result += direction;
    number++;
  }

  if (number != 0)
    result /= number;

  return (result);
}

#endif
