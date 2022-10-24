#ifndef DATE_TIME_H
#define DATE_TIME_H

struct CDateTime : public MqlDateTime {

  string MonthName(const int num) const;
  string ShortMonthName(const int num) const;
  string DayName(const int num) const;
  string ShortDayName(const int num) const;
  string MonthName(void) const ;
  string ShortMonthName(void) const ;
  string DayName(void) const ;
  string ShortDayName(void) const ;
  int DaysInMonth(void) const;

  datetime DateTime(void) ;
  void DateTime(const datetime value) ;
  void DateTime(const MqlDateTime &value) ;
  void Date(const datetime value);
  void Date(const MqlDateTime &value);
  void Time(const datetime value);
  void Time(const MqlDateTime &value);

  void Sec(const int value);
  void Min(const int value);
  void Hour(const int value);
  void Day(const int value);
  void Mon(const int value);
  void Year(const int value);

  void SecDec(int delta = 1);
  void SecInc(int delta = 1);
  void MinDec(int delta = 1);
  void MinInc(int delta = 1);
  void HourDec(int delta = 1);
  void HourInc(int delta = 1);
  void DayDec(int delta = 1);
  void DayInc(int delta = 1);
  void MonDec(int delta = 1);
  void MonInc(int delta = 1);
  void YearDec(int delta = 1);
  void YearInc(int delta = 1);

  void DayCheck(void);
};





























#endif
