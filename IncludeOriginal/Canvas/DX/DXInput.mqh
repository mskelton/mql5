#ifndef DXINPUT_H
#define DXINPUT_H

#include "DXHandle.mqh"

class CDXInput : public CDXHandleShared {
public:
  virtual ~CDXInput(void) {
    Shutdown();
  }

  template <typename TInput> bool Create(int context) {

    Shutdown();

    m_context = context;

    m_handle = DXInputCreate(m_context, sizeof(TInput));
    return (m_handle != INVALID_HANDLE);
  }

  template <typename TInput> bool InputSet(const TInput &input_data) {

    if (m_handle == INVALID_HANDLE)
      return (false);

    return (DXInputSet(m_handle, input_data));
  }

  virtual void Shutdown(void) {

    if (m_handle != INVALID_HANDLE)
      DXRelease(m_handle);
    m_handle = INVALID_HANDLE;
  }
};

#endif
