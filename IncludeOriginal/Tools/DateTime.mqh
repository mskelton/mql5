#ifndef DATE_TIME_H
#define DATE_TIME_H

struct CDateTime : public MqlDateTime {

  string MonthName(const int num) const;
  string ShortMonthName(const int num) const;
  string DayName(const int num) const;
  string ShortDayName(const int num) const;
  string MonthName(void) const {
    return (MonthName(mon));
  }
  string ShortMonthName(void) const {
    return (ShortMonthName(mon));
  }
  string DayName(void) const {
    return (DayName(day_of_week));
  }
  string ShortDayName(void) const {
    return (ShortDayName(day_of_week));
  }
  int DaysInMonth(void) const;

  datetime DateTime(void) {
    return (StructToTime(this));
  }
  void DateTime(const datetime value) {
    TimeToStruct(value, this);
  }
  void DateTime(const MqlDateTime &value) {
    this = value;
  }
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

string CDateTime::MonthName(const int num) const {
  switch (num) {
  case 1:
    return ("January");
  case 2:
    return ("February");
  case 3:
    return ("March");
  case 4:
    return ("April");
  case 5:
    return ("May");
  case 6:
    return ("June");
  case 7:
    return ("July");
  case 8:
    return ("August");
  case 9:
    return ("September");
  case 10:
    return ("October");
  case 11:
    return ("November");
  case 12:
    return ("December");
  }

  return ("Bad month");
}

string CDateTime::ShortMonthName(const int num) const {
  switch (num) {
  case 1:
    return ("jan");
  case 2:
    return ("feb");
  case 3:
    return ("mar");
  case 4:
    return ("apr");
  case 5:
    return ("may");
  case 6:
    return ("jun");
  case 7:
    return ("jul");
  case 8:
    return ("aug");
  case 9:
    return ("sep");
  case 10:
    return ("oct");
  case 11:
    return ("nov");
  case 12:
    return ("dec");
  }

  return ("Bad month");
}

string CDateTime::DayName(const int num) const {
  switch (num) {
  case 0:
    return ("Sunday");
  case 1:
    return ("Monday");
  case 2:
    return ("Tuesday");
  case 3:
    return ("Wednesday");
  case 4:
    return ("Thursday");
  case 5:
    return ("Friday");
  case 6:
    return ("Saturday");
  }

  return ("Bad day of week");
}

string CDateTime::ShortDayName(const int num) const {
  switch (num) {
  case 0:
    return ("Su");
  case 1:
    return ("Mo");
  case 2:
    return ("Tu");
  case 3:
    return ("We");
  case 4:
    return ("Th");
  case 5:
    return ("Fr");
  case 6:
    return ("Sa");
  }

  return ("Bad day of week");
}

int CDateTime::DaysInMonth(void) const {
  int leap_year;

  switch (mon) {
  case 1:
  case 3:
  case 5:
  case 7:
  case 8:
  case 10:
  case 12:
    return (31);
  case 2:
    leap_year = year;
    if (year % 100 == 0)
      leap_year /= 100;
    return ((leap_year % 4 == 0) ? 29 : 28);
  case 4:
  case 6:
  case 9:
  case 11:
    return (30);
  }

  return (0);
}

void CDateTime::Date(const datetime value) {
  MqlDateTime dt;

  TimeToStruct(value, dt);

  Date(dt);
}

void CDateTime::Date(const MqlDateTime &value) {
  day = value.day;
  mon = value.mon;
  year = value.year;

  DayCheck();
}

void CDateTime::Time(const datetime value) {
  MqlDateTime dt;

  TimeToStruct(value, dt);

  Time(dt);
}

void CDateTime::Time(const MqlDateTime &value) {
  hour = value.hour;
  min = value.min;
  sec = value.sec;
}

void CDateTime::Sec(const int value) {

  if (value >= 0 && value < 60)
    sec = value;
}

void CDateTime::Min(const int value) {

  if (value >= 0 && value < 60)
    min = value;
}

void CDateTime::Hour(const int value) {

  if (value >= 0 && value < 24)
    hour = value;
}

void CDateTime::Day(const int value) {

  if (value > 0 && value <= DaysInMonth()) {
    day = value;

    DayCheck();
  }
}

void CDateTime::Mon(const int value) {

  if (value > 0 && value <= 12) {
    mon = value;

    DayCheck();
  }
}

void CDateTime::Year(const int value) {

  if (value >= 1970) {
    year = value;

    DayCheck();
  }
}

void CDateTime::SecDec(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    SecInc(-delta);
    return;
  }

  if (delta > 60) {
    MinDec(delta / 60);
    delta %= 60;
  }
  sec -= delta;
  if (sec < 0) {
    sec += 60;
    MinDec();
  }
}

void CDateTime::SecInc(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    SecDec(-delta);
    return;
  }

  if (delta > 60) {
    MinInc(delta / 60);
    delta %= 60;
  }
  sec += delta;
  if (sec >= 60) {
    sec -= 60;
    MinInc();
  }
}

void CDateTime::MinDec(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    MinInc(-delta);
    return;
  }

  if (delta > 60) {
    HourDec(delta / 60);
    delta %= 60;
  }
  min -= delta;
  if (min < 0) {
    min += 60;
    HourDec();
  }
}

void CDateTime::MinInc(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    MinDec(-delta);
    return;
  }

  if (delta > 60) {
    HourInc(delta / 60);
    delta %= 60;
  }
  min += delta;
  if (min >= 60) {
    min -= 60;
    HourInc();
  }
}

void CDateTime::HourDec(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    HourInc(-delta);
    return;
  }

  if (delta > 24) {
    DayDec(delta / 24);
    delta %= 24;
  }
  hour -= delta;
  if (hour < 0) {
    hour += 24;
    DayDec();
  }
}

void CDateTime::HourInc(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    HourDec(-delta);
    return;
  }

  if (delta > 24) {
    DayInc(delta / 24);
    delta %= 24;
  }
  hour += delta;
  if (hour >= 24) {
    hour -= 24;
    DayInc();
  }
}

void CDateTime::DayDec(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    DayInc(-delta);
    return;
  }

  while (day <= delta) {
    delta -= day;
    MonDec();
    day = DaysInMonth();
  }
  day -= delta;

  DayCheck();
}

void CDateTime::DayInc(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    DayDec(-delta);
    return;
  }

  while (DaysInMonth() - day < delta) {
    delta -= DaysInMonth() - day + 1;
    MonInc();
    day = 1;
  }
  day += delta;

  DayCheck();
}

void CDateTime::MonDec(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    MonInc(-delta);
    return;
  }

  if (delta > 12) {
    YearDec(delta / 12);
    delta %= 12;
  }
  mon -= delta;
  if (mon <= 0) {
    mon += 12;
    YearDec();
  }

  DayCheck();
}

void CDateTime::MonInc(int delta) {

  if (delta == 0)
    return;

  if (delta < 0) {
    MonDec(-delta);
    return;
  }

  if (delta > 12) {
    YearInc(delta / 12);
    delta %= 12;
  }
  mon += delta;
  if (mon > 12) {
    mon -= 12;
    YearInc();
  }

  DayCheck();
}

void CDateTime::YearDec(int delta) {

  if (delta != 0) {
    year -= delta;

    DayCheck();
  }
}

void CDateTime::YearInc(int delta) {

  if (delta != 0) {
    year += delta;

    DayCheck();
  }
}

void CDateTime::DayCheck(void) {
  if (day > DaysInMonth())
    day = DaysInMonth();

  TimeToStruct(StructToTime(this), this);
}

#endif
