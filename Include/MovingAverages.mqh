#ifndef MOVING_AVERAGES_H
#define MOVING_AVERAGES_H

double SimpleMA(const int position, const int period, const double price[]) ;

double ExponentialMA(const int position, const int period,
                     const double prev_value, const double price[]) ;

double SmoothedMA(const int position, const int period, const double prev_value,
                  const double price[]) ;

double LinearWeightedMA(const int position, const int period,
                        const double price[]) ;

int SimpleMAOnBuffer(const int rates_total, const int prev_calculated,
                     const int begin, const int period, const double price[],
                     double buffer[]) ;

int ExponentialMAOnBuffer(const int rates_total, const int prev_calculated,
                          const int begin, const int period,
                          const double price[], double buffer[]) ;

int LinearWeightedMAOnBuffer(const int rates_total, const int prev_calculated,
                             const int begin, const int period,
                             const double price[], double buffer[]) ;

int LinearWeightedMAOnBuffer(const int rates_total, const int prev_calculated,
                             const int begin, const int period,
                             const double price[], double buffer[],
                             int &weight_sum) ;

int SmoothedMAOnBuffer(const int rates_total, const int prev_calculated,
                       const int begin, const int period, const double price[],
                       double buffer[]) ;

#endif
