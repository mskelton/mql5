#ifndef DXINPUT_H
#define DXINPUT_H

#include "DXHandle.mqh"

class CDXInput : public CDXHandleShared {
public:
  virtual ~CDXInput(void);

  template <typename TInput> bool Create(int context);

  template <typename TInput> bool InputSet(const TInput &input_data);

  virtual void Shutdown(void);
};

#endif
