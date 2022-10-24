#ifndef WND_CONTAINER_H
#define WND_CONTAINER_H

#include "Wnd.mqh"
#include <Arrays/ArrayObj.mqh>

class CWndContainer : public CWnd {
private:
  CArrayObj m_controls;

public:
  CWndContainer(void);
  ~CWndContainer(void);

  virtual void Destroy(const int reason = 0);

  virtual bool OnEvent(const int id, const long &lparam, const double &dparam,
                       const string &sparam);
  virtual bool OnMouseEvent(const int x, const int y, const int flags);

  int ControlsTotal(void) const;
  CWnd *Control(const int ind) const;
  virtual CWnd *ControlFind(const long id);

  virtual bool MouseFocusKill(const long id = -1);

  bool Add(CWnd *control);
  bool Add(CWnd &control);

  bool Delete(CWnd *control);
  bool Delete(CWnd &control);

  virtual bool Move(const int x, const int y);
  virtual bool Move(const CPoint &point);
  virtual bool Shift(const int dx, const int dy);

  virtual long Id(const long id);
  long Id(void) const;

  virtual bool Enable(void);
  virtual bool Disable(void);
  virtual bool Show(void);
  virtual bool Hide(void);

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);

protected:
  virtual bool OnResize(void);
  virtual bool OnActivate(void);
  virtual bool OnDeactivate(void);
};

#endif
