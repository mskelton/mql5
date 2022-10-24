#ifndef CHART_OBJECT_PANEL_H
#define CHART_OBJECT_PANEL_H

#include <Arrays/ArrayInt.mqh>
#include <Arrays/ArrayObj.mqh>
#include <ChartObjects/ChartObjectsTxtControls.mqh>

class CChartObjectPanel : public CChartObjectButton {
protected:
  CArrayObj m_attachment;
  CArrayInt m_dX;
  CArrayInt m_dY;
  bool m_expanded;

public:
  CChartObjectPanel();
  ~CChartObjectPanel();

  bool Attach(CChartObjectLabel *chart_object);
  bool X_Distance(const int X);
  int X_Distance(void) const;
  bool Y_Distance(const int Y);
  int Y_Distance(void) const;
  int X_Size() const;
  int X_Size(const int Y) const;
  int Y_Size() const;
  int Y_Size(const int Y) const;

  int Timeframes(void) const;
  virtual bool Timeframes(const int timeframes);
  bool State(const bool state);
  bool State(void) const;
  bool CheckState();

protected:
};

#endif
