#ifndef SIGNAL_ITF_H
#define SIGNAL_ITF_H

#include <Expert/ExpertSignal.mqh>

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

  void GoodMinuteOfHour(int value) ;
  void BadMinutesOfHour(long value) ;
  void GoodHourOfDay(int value) ;
  void BadHoursOfDay(int value) ;
  void GoodDayOfWeek(int value) ;
  void BadDaysOfWeek(int value) ;

  virtual double Direction(void);
};




#endif
