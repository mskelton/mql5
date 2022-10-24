#ifndef SIGNAL_ITF_H
#define SIGNAL_ITF_H

#include <Expert\ExpertSignal.mqh>

class CSignalITF : public CExpertSignal {
protected:
  int m_good_minute_of_hour;
  long m_bad_minutes_of_hour;
  int m_good_hour_of_day;
  int m_bad_hours_of_day;
  int m_good_day_of_week;
  int m_bad_days_of_week;

public:
  CSignalITF(void);
  ~CSignalITF(void);

  void GoodMinuteOfHour(int value) {
    m_good_minute_of_hour = value;
  }
  void BadMinutesOfHour(long value) {
    m_bad_minutes_of_hour = value;
  }
  void GoodHourOfDay(int value) {
    m_good_hour_of_day = value;
  }
  void BadHoursOfDay(int value) {
    m_bad_hours_of_day = value;
  }
  void GoodDayOfWeek(int value) {
    m_good_day_of_week = value;
  }
  void BadDaysOfWeek(int value) {
    m_bad_days_of_week = value;
  }

  virtual double Direction(void);
};

CSignalITF::CSignalITF(void)
    : m_good_minute_of_hour(-1), m_bad_minutes_of_hour(0),
      m_good_hour_of_day(-1), m_bad_hours_of_day(0), m_good_day_of_week(-1),
      m_bad_days_of_week(0) {
}

CSignalITF::~CSignalITF(void) {
}

double CSignalITF::Direction(void) {
  MqlDateTime s_time;

  TimeCurrent(s_time);

  if (!((m_good_day_of_week == -1 ||
         m_good_day_of_week == s_time.day_of_week) &&
        !(m_bad_days_of_week & (1 << s_time.day_of_week))))
    return (EMPTY_VALUE);

  if (!((m_good_hour_of_day == -1 || m_good_hour_of_day == s_time.hour) &&
        !(m_bad_hours_of_day & (1 << s_time.hour))))
    return (EMPTY_VALUE);

  if (!((m_good_minute_of_hour == -1 || m_good_minute_of_hour == s_time.min) &&
        !(m_bad_minutes_of_hour & (1 << s_time.min))))
    return (EMPTY_VALUE);

  return (0.0);
}

#endif
