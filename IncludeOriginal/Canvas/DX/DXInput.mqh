#ifndef DXINPUT_H
#define DXINPUT_H
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include "DXHandle.mqh"
//+------------------------------------------------------------------+
//| Class CDXInput                                                   |
//+------------------------------------------------------------------+
class CDXInput : public CDXHandleShared {
public:
  //+------------------------------------------------------------------+
  //| Destructor                                                       |
  //+------------------------------------------------------------------+
  virtual ~CDXInput(void) {
    Shutdown();
  }
  //+------------------------------------------------------------------+
  //| Create a new input buffer                                        |
  //+------------------------------------------------------------------+
  template <typename TInput> bool Create(int context) {
    //--- shutdown input
    Shutdown();
    //--- save new context
    m_context = context;
    //--- create new input buffer
    m_handle = DXInputCreate(m_context, sizeof(TInput));
    return (m_handle != INVALID_HANDLE);
  }
  //+------------------------------------------------------------------+
  //| Set input data                                                   |
  //+------------------------------------------------------------------+
  template <typename TInput> bool InputSet(const TInput &input_data) {
    //--- check input handle
    if (m_handle == INVALID_HANDLE)
      return (false);
    //--- set input data
    return (DXInputSet(m_handle, input_data));
  }
  //+------------------------------------------------------------------+
  //| Shutdown                                                         |
  //+------------------------------------------------------------------+
  virtual void Shutdown(void) {
    //--- relase handle
    if (m_handle != INVALID_HANDLE)
      DXRelease(m_handle);
    m_handle = INVALID_HANDLE;
  }
};
//+------------------------------------------------------------------+

#endif
