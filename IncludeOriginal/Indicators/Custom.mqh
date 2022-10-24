#ifndef CUSTOM_H
#define CUSTOM_H

#include "Indicator.mqh"

class CiCustom : public CIndicator {
protected:
  int m_num_params;
  MqlParam m_params[];

public:
  CiCustom(void);
  ~CiCustom(void);

  bool NumBuffers(const int buffers);
  int NumParams(void) const {
    return (m_num_params);
  }
  ENUM_DATATYPE ParamType(const int ind) const;
  long ParamLong(const int ind) const;
  double ParamDouble(const int ind) const;
  string ParamString(const int ind) const;

  virtual int Type(void) const {
    return (IND_CUSTOM);
  }

protected:
  virtual bool Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]);
};

CiCustom::CiCustom(void) : m_num_params(0) {
}

CiCustom::~CiCustom(void) {
}

bool CiCustom::NumBuffers(const int buffers) {
  bool result = true;

  if (m_buffers_total == 0) {
    m_buffers_total = buffers;
    return (true);
  }
  if (m_buffers_total != buffers) {
    Shutdown();
    result = CreateBuffers(m_symbol, m_period, buffers);
    if (result) {

      for (int i = 0; i < m_buffers_total; i++)
        ((CIndicatorBuffer *)At(i)).Name("LINE " + IntegerToString(i));
    }
  }

  return (result);
}

ENUM_DATATYPE CiCustom::ParamType(const int ind) const {
  if (ind >= m_num_params)
    return (WRONG_VALUE);

  return (m_params[ind].type);
}

long CiCustom::ParamLong(const int ind) const {
  if (ind >= m_num_params)
    return (0);
  switch (m_params[ind].type) {
  case TYPE_DOUBLE:
  case TYPE_FLOAT:
  case TYPE_STRING:
    return (0);
  }

  return (m_params[ind].integer_value);
}

double CiCustom::ParamDouble(const int ind) const {
  if (ind >= m_num_params)
    return (EMPTY_VALUE);
  switch (m_params[ind].type) {
  case TYPE_DOUBLE:
  case TYPE_FLOAT:
    break;
  default:
    return (EMPTY_VALUE);
  }

  return (m_params[ind].double_value);
}

string CiCustom::ParamString(const int ind) const {
  if (ind >= m_num_params || m_params[ind].type != TYPE_STRING)
    return ("");

  return (m_params[ind].string_value);
}

bool CiCustom::Initialize(const string symbol, const ENUM_TIMEFRAMES period,
                          const int num_params, const MqlParam &params[]) {
  int i;

  if (m_buffers_total == 0)
    m_buffers_total = 256;
  if (CreateBuffers(symbol, period, m_buffers_total)) {

    m_name = "Custom " + params[0].string_value;
    m_status = "(" + symbol + "," + PeriodDescription();
    for (i = 1; i < num_params; i++) {
      switch (params[i].type) {
      case TYPE_BOOL:
        m_status =
            m_status + "," + ((params[i].integer_value) ? "true" : "false");
        break;
      case TYPE_CHAR:
      case TYPE_UCHAR:
      case TYPE_SHORT:
      case TYPE_USHORT:
      case TYPE_INT:
      case TYPE_UINT:
      case TYPE_LONG:
      case TYPE_ULONG:
        m_status = m_status + "," + IntegerToString(params[i].integer_value);
        break;
      case TYPE_COLOR:
        m_status =
            m_status + "," + ColorToString((color)params[i].integer_value);
        break;
      case TYPE_DATETIME:
        m_status = m_status + "," + TimeToString(params[i].integer_value);
        break;
      case TYPE_FLOAT:
      case TYPE_DOUBLE:
        m_status = m_status + "," + DoubleToString(params[i].double_value);
        break;
      case TYPE_STRING:
        m_status = m_status + ",'" + params[i].string_value + "'";
        break;
      }
    }
    m_status = m_status + ") H=" + IntegerToString(m_handle);

    ArrayResize(m_params, num_params);
    for (i = 0; i < num_params; i++) {
      m_params[i].type = params[i].type;
      m_params[i].integer_value = params[i].integer_value;
      m_params[i].double_value = params[i].double_value;
      m_params[i].string_value = params[i].string_value;
    }
    m_num_params = num_params;

    for (i = 0; i < m_buffers_total; i++)
      ((CIndicatorBuffer *)At(i)).Name("LINE " + IntegerToString(i));

    return (true);
  }

  return (false);
}

#endif
