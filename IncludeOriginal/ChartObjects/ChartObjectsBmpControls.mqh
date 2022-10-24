#ifndef CHART_OBJECTS_BMP_CONTROLS_H
#define CHART_OBJECTS_BMP_CONTROLS_H

#include "ChartObject.mqh"

class CChartObjectBitmap : public CChartObject {
public:
  CChartObjectBitmap(void);
  ~CChartObjectBitmap(void);

  string BmpFile(void) const;
  bool BmpFile(const string name) const;
  int X_Offset(void) const;
  bool X_Offset(const int X) const;
  int Y_Offset(void) const;
  bool Y_Offset(const int Y) const;

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const {
    return (OBJ_BITMAP);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectBitmap::CChartObjectBitmap(void) {}

CChartObjectBitmap::~CChartObjectBitmap(void) {}

bool CChartObjectBitmap::Create(long chart_id, const string name,
                                const int window, const datetime time,
                                const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_BITMAP, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

string CChartObjectBitmap::BmpFile(void) const {

  if (m_chart_id == -1)
    return ("");

  return (ObjectGetString(m_chart_id, m_name, OBJPROP_BMPFILE));
}

bool CChartObjectBitmap::BmpFile(const string name) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetString(m_chart_id, m_name, OBJPROP_BMPFILE, name));
}

int CChartObjectBitmap::X_Offset(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XOFFSET));
}

bool CChartObjectBitmap::X_Offset(const int X) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_XOFFSET, X));
}

int CChartObjectBitmap::Y_Offset(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YOFFSET));
}

bool CChartObjectBitmap::Y_Offset(const int Y) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_YOFFSET, Y));
}

bool CChartObjectBitmap::Save(const int file_handle) {
  int len;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Save(file_handle))
    return (false);

  str = ObjectGetString(m_chart_id, m_name, OBJPROP_BMPFILE);
  len = StringLen(str);
  if (FileWriteInteger(file_handle, len, INT_VALUE) != INT_VALUE)
    return (false);
  if (len != 0 && FileWriteString(file_handle, str, len) != len)
    return (false);

  return (true);
}

bool CChartObjectBitmap::Load(const int file_handle) {
  int len;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Load(file_handle))
    return (false);

  len = FileReadInteger(file_handle, INT_VALUE);
  str = (len != 0) ? FileReadString(file_handle, len) : "";
  if (!ObjectSetString(m_chart_id, m_name, OBJPROP_BMPFILE, str))
    return (false);

  return (true);
}

class CChartObjectBmpLabel : public CChartObject {
public:
  CChartObjectBmpLabel(void);
  ~CChartObjectBmpLabel(void);

  int X_Distance(void) const;
  bool X_Distance(const int X) const;
  int Y_Distance(void) const;
  bool Y_Distance(const int Y) const;
  int X_Size(void) const;
  int Y_Size(void) const;
  ENUM_BASE_CORNER Corner(void) const;
  bool Corner(const ENUM_BASE_CORNER corner) const;
  string BmpFileOn(void) const;
  bool BmpFileOn(const string name) const;
  string BmpFileOff(void) const;
  bool BmpFileOff(const string name) const;
  bool State(void) const;
  bool State(const bool state) const;
  int X_Offset(void) const;
  bool X_Offset(const int X) const;
  int Y_Offset(void) const;
  bool Y_Offset(const int Y) const;

  bool Time(const datetime time) const {
    return (false);
  }
  bool Price(const double price) const {
    return (false);
  }

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y);

  virtual int Type(void) const {
    return (OBJ_BITMAP_LABEL);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectBmpLabel::CChartObjectBmpLabel(void) {}

CChartObjectBmpLabel::~CChartObjectBmpLabel(void) {}

bool CChartObjectBmpLabel::Create(long chart_id, const string name,
                                  const int window, const int X, const int Y) {
  if (!ObjectCreate(chart_id, name, OBJ_BITMAP_LABEL, window, 0, 0.0))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);
  if (!X_Distance(X) || !Y_Distance(Y))
    return (false);

  return (true);
}

int CChartObjectBmpLabel::X_Distance(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE));
}

bool CChartObjectBmpLabel::X_Distance(const int X) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE, X));
}

int CChartObjectBmpLabel::Y_Distance(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE));
}

bool CChartObjectBmpLabel::Y_Distance(const int Y) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE, Y));
}

int CChartObjectBmpLabel::X_Size(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XSIZE));
}

int CChartObjectBmpLabel::Y_Size(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YSIZE));
}

ENUM_BASE_CORNER CChartObjectBmpLabel::Corner(void) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);

  return (
      (ENUM_BASE_CORNER)ObjectGetInteger(m_chart_id, m_name, OBJPROP_CORNER));
}

bool CChartObjectBmpLabel::Corner(const ENUM_BASE_CORNER corner) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_CORNER, corner));
}

string CChartObjectBmpLabel::BmpFileOn(void) const {

  if (m_chart_id == -1)
    return ("");

  return (ObjectGetString(m_chart_id, m_name, OBJPROP_BMPFILE, 0));
}

bool CChartObjectBmpLabel::BmpFileOn(const string name) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetString(m_chart_id, m_name, OBJPROP_BMPFILE, 0, name));
}

string CChartObjectBmpLabel::BmpFileOff(void) const {

  if (m_chart_id == -1)
    return ("");

  return (ObjectGetString(m_chart_id, m_name, OBJPROP_BMPFILE, 1));
}

bool CChartObjectBmpLabel::BmpFileOff(const string name) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetString(m_chart_id, m_name, OBJPROP_BMPFILE, 1, name));
}

bool CChartObjectBmpLabel::State(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_STATE));
}

bool CChartObjectBmpLabel::State(const bool state) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_STATE, state));
}

int CChartObjectBmpLabel::X_Offset(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XOFFSET));
}

bool CChartObjectBmpLabel::X_Offset(const int X) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_XOFFSET, X));
}

int CChartObjectBmpLabel::Y_Offset(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YOFFSET));
}

bool CChartObjectBmpLabel::Y_Offset(const int Y) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_YOFFSET, Y));
}

bool CChartObjectBmpLabel::Save(const int file_handle) {
  int len;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Save(file_handle))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE),
          INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE),
          INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_CORNER),
          INT_VALUE) != sizeof(int))
    return (false);

  str = ObjectGetString(m_chart_id, m_name, OBJPROP_BMPFILE, 0);
  len = StringLen(str);
  if (FileWriteInteger(file_handle, len, INT_VALUE) != INT_VALUE)
    return (false);
  if (len != 0 && FileWriteString(file_handle, str, len) != len)
    return (false);

  str = ObjectGetString(m_chart_id, m_name, OBJPROP_BMPFILE, 1);
  len = StringLen(str);
  if (FileWriteInteger(file_handle, len, INT_VALUE) != INT_VALUE)
    return (false);
  if (len != 0 && FileWriteString(file_handle, str, len) != len)
    return (false);

  if (FileWriteLong(file_handle,
                    ObjectGetInteger(m_chart_id, m_name, OBJPROP_STATE)) !=
      sizeof(long))
    return (false);

  return (true);
}

bool CChartObjectBmpLabel::Load(const int file_handle) {
  int len;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Load(file_handle))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_CORNER,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  len = FileReadInteger(file_handle, INT_VALUE);
  str = (len != 0) ? FileReadString(file_handle, len) : "";
  if (!ObjectSetString(m_chart_id, m_name, OBJPROP_BMPFILE, 0, str))
    return (false);

  len = FileReadInteger(file_handle, INT_VALUE);
  str = (len != 0) ? FileReadString(file_handle, len) : "";
  if (!ObjectSetString(m_chart_id, m_name, OBJPROP_BMPFILE, 1, str))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_STATE,
                        FileReadLong(file_handle)))
    return (false);

  return (true);
}

#endif
