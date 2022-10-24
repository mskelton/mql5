#ifndef CHART_OBJECTS_TXT_CONTROLS_H
#define CHART_OBJECTS_TXT_CONTROLS_H

#include "ChartObject.mqh"

class CChartObjectText : public CChartObject {
public:
  CChartObjectText(void);
  ~CChartObjectText(void);

  bool Create(long chart_id, const string name, const int window,
              const datetime time, const double price);

  virtual int Type(void) const override {
    return (OBJ_TEXT);
  }

  double Angle(void) const;
  bool Angle(const double angle) const;
  string Font(void) const;
  bool Font(const string font) const;
  int FontSize(void) const;
  bool FontSize(const int size) const;
  ENUM_ANCHOR_POINT Anchor(void) const;
  bool Anchor(const ENUM_ANCHOR_POINT anchor) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectText::CChartObjectText(void) {
}

CChartObjectText::~CChartObjectText(void) {
}

bool CChartObjectText::Create(long chart_id, const string name,
                              const int window, const datetime time,
                              const double price) {
  if (!ObjectCreate(chart_id, name, OBJ_TEXT, window, time, price))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);

  return (true);
}

double CChartObjectText::Angle(void) const {

  if (m_chart_id == -1)
    return (EMPTY_VALUE);

  return (ObjectGetDouble(m_chart_id, m_name, OBJPROP_ANGLE));
}

bool CChartObjectText::Angle(const double angle) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetDouble(m_chart_id, m_name, OBJPROP_ANGLE, angle));
}

string CChartObjectText::Font(void) const {

  if (m_chart_id == -1)
    return ("");

  return (ObjectGetString(m_chart_id, m_name, OBJPROP_FONT));
}

bool CChartObjectText::Font(const string font) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetString(m_chart_id, m_name, OBJPROP_FONT, font));
}

int CChartObjectText::FontSize(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_FONTSIZE));
}

bool CChartObjectText::FontSize(const int size) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_FONTSIZE, size));
}

ENUM_ANCHOR_POINT CChartObjectText::Anchor(void) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);

  return (
      (ENUM_ANCHOR_POINT)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ANCHOR));
}

bool CChartObjectText::Anchor(const ENUM_ANCHOR_POINT anchor) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_ANCHOR, anchor));
}

bool CChartObjectText::Save(const int file_handle) {
  int len;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Save(file_handle))
    return (false);

  if (FileWriteDouble(file_handle,
                      ObjectGetDouble(m_chart_id, m_name, OBJPROP_ANGLE)) !=
      sizeof(double))
    return (false);

  str = ObjectGetString(m_chart_id, m_name, OBJPROP_FONT);
  len = StringLen(str);
  if (FileWriteInteger(file_handle, len, INT_VALUE) != INT_VALUE)
    return (false);
  if (len != 0 && FileWriteString(file_handle, str, len) != len)
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_FONTSIZE),
          INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ANCHOR),
          INT_VALUE) != sizeof(int))
    return (false);

  return (true);
}

bool CChartObjectText::Load(const int file_handle) {
  int len;
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObject::Load(file_handle))
    return (false);

  if (!ObjectSetDouble(m_chart_id, m_name, OBJPROP_ANGLE, 0,
                       FileReadDouble(file_handle)))
    return (false);

  len = FileReadInteger(file_handle, INT_VALUE);
  str = (len != 0) ? FileReadString(file_handle, len) : "";
  if (!ObjectSetString(m_chart_id, m_name, OBJPROP_FONT, str))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_FONTSIZE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_ANCHOR,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  return (true);
}

class CChartObjectLabel : public CChartObjectText {
public:
  CChartObjectLabel(void);
  ~CChartObjectLabel(void);

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y);

  virtual int Type(void) const {
    return (OBJ_LABEL);
  }

  int X_Distance(void) const;
  bool X_Distance(const int X) const;
  int Y_Distance(void) const;
  bool Y_Distance(const int Y) const;
  int X_Size(void) const;
  int Y_Size(void) const;

  ENUM_BASE_CORNER Corner(void) const;
  bool Corner(const ENUM_BASE_CORNER corner) const;

  datetime Time(const int point) const {
    return (CChartObjectText::Time(point));
  }
  bool Time(const int point, const datetime time) const {
    return (false);
  }
  double Price(const int point) const {
    return (CChartObjectText::Price(point));
  }
  bool Price(const int point, const double price) const {
    return (false);
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectLabel::CChartObjectLabel(void) {
}

CChartObjectLabel::~CChartObjectLabel(void) {
}

bool CChartObjectLabel::Create(long chart_id, const string name,
                               const int window, const int X, const int Y) {
  if (!ObjectCreate(chart_id, name, OBJ_LABEL, window, 0, 0.0))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);
  if (!Description(name))
    return (false);
  if (!X_Distance(X) || !Y_Distance(Y))
    return (false);

  return (true);
}

int CChartObjectLabel::X_Distance(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE));
}

bool CChartObjectLabel::X_Distance(const int X) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_XDISTANCE, X));
}

int CChartObjectLabel::Y_Distance(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE));
}

bool CChartObjectLabel::Y_Distance(const int Y) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_YDISTANCE, Y));
}

int CChartObjectLabel::X_Size(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XSIZE));
}

int CChartObjectLabel::Y_Size(void) const {

  if (m_chart_id == -1)
    return (0);

  return ((int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YSIZE));
}

ENUM_BASE_CORNER CChartObjectLabel::Corner(void) const {

  if (m_chart_id == -1)
    return (WRONG_VALUE);

  return (
      (ENUM_BASE_CORNER)ObjectGetInteger(m_chart_id, m_name, OBJPROP_CORNER));
}

bool CChartObjectLabel::Corner(const ENUM_BASE_CORNER corner) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_CORNER, corner));
}

bool CChartObjectLabel::Save(const int file_handle) {
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectText::Save(file_handle))
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

  return (true);
}

bool CChartObjectLabel::Load(const int file_handle) {
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectText::Load(file_handle))
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

  return (true);
}

class CChartObjectEdit : public CChartObjectLabel {
public:
  CChartObjectEdit(void);
  ~CChartObjectEdit(void);

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y, const int sizeX, const int sizeY);

  virtual int Type(void) const override {
    return (OBJ_EDIT);
  }

  bool X_Size(const int X) const;
  int X_Size(void) const {
    return (CChartObjectLabel::X_Size());
  }
  bool Y_Size(const int Y) const;
  int Y_Size(void) const {
    return (CChartObjectLabel::Y_Size());
  }
  color BackColor(void) const;
  bool BackColor(const color new_color) const;
  color BorderColor(void) const;
  bool BorderColor(const color new_color) const;
  bool ReadOnly(void) const;
  bool ReadOnly(const bool flag) const;
  ENUM_ALIGN_MODE TextAlign(void) const;
  bool TextAlign(const ENUM_ALIGN_MODE align) const;

  bool Angle(const double angle) const {
    return (false);
  }
  double Angle(void) const {
    return (CChartObjectLabel::Angle());
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectEdit::CChartObjectEdit(void) {
}

CChartObjectEdit::~CChartObjectEdit(void) {
}

bool CChartObjectEdit::Create(long chart_id, const string name,
                              const int window, const int X, const int Y,
                              const int sizeX, const int sizeY) {
  if (!ObjectCreate(chart_id, name, (ENUM_OBJECT)Type(), window, 0, 0, 0))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);
  if (!X_Distance(X) || !Y_Distance(Y))
    return (false);
  if (!X_Size(sizeX) || !Y_Size(sizeY))
    return (false);

  return (true);
}

bool CChartObjectEdit::X_Size(const int X) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_XSIZE, X));
}

bool CChartObjectEdit::Y_Size(const int Y) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_YSIZE, Y));
}

color CChartObjectEdit::BackColor(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ObjectGetInteger(m_chart_id, m_name, OBJPROP_BGCOLOR));
}

bool CChartObjectEdit::BackColor(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_BGCOLOR, new_color));
}

color CChartObjectEdit::BorderColor(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ObjectGetInteger(m_chart_id, m_name, OBJPROP_BORDER_COLOR));
}

bool CChartObjectEdit::BorderColor(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (
      ObjectSetInteger(m_chart_id, m_name, OBJPROP_BORDER_COLOR, new_color));
}

bool CChartObjectEdit::ReadOnly(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_READONLY));
}

bool CChartObjectEdit::ReadOnly(const bool flag) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_READONLY, flag));
}

ENUM_ALIGN_MODE CChartObjectEdit::TextAlign(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((ENUM_ALIGN_MODE)ObjectGetInteger(m_chart_id, m_name, OBJPROP_ALIGN));
}

bool CChartObjectEdit::TextAlign(const ENUM_ALIGN_MODE align) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_ALIGN, align));
}

bool CChartObjectEdit::Save(const int file_handle) {
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectLabel::Save(file_handle))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XSIZE),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YSIZE),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteLong(file_handle,
                    ObjectGetInteger(m_chart_id, m_name, OBJPROP_BGCOLOR)) !=
      sizeof(long))
    return (false);

  return (true);
}

bool CChartObjectEdit::Load(const int file_handle) {
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectLabel::Load(file_handle))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_XSIZE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_YSIZE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_BGCOLOR,
                        FileReadLong(file_handle)))
    return (false);

  return (true);
}

class CChartObjectButton : public CChartObjectEdit {
public:
  CChartObjectButton(void);
  ~CChartObjectButton(void);

  virtual int Type(void) const override {
    return (OBJ_BUTTON);
  }

  bool State(void) const;
  bool State(const bool state) const;

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectButton::CChartObjectButton(void) {
}

CChartObjectButton::~CChartObjectButton(void) {
}

bool CChartObjectButton::State(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((bool)ObjectGetInteger(m_chart_id, m_name, OBJPROP_STATE));
}

bool CChartObjectButton::State(const bool state) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_STATE, state));
}

bool CChartObjectButton::Save(const int file_handle) {
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectEdit::Save(file_handle))
    return (false);

  if (FileWriteLong(file_handle,
                    ObjectGetInteger(m_chart_id, m_name, OBJPROP_STATE)) !=
      sizeof(long))
    return (false);

  return (true);
}

bool CChartObjectButton::Load(const int file_handle) {
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectEdit::Load(file_handle))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_STATE,
                        FileReadLong(file_handle)))
    return (false);

  return (true);
}

class CChartObjectRectLabel : public CChartObjectLabel {
public:
  CChartObjectRectLabel(void);
  ~CChartObjectRectLabel(void);

  bool Create(long chart_id, const string name, const int window, const int X,
              const int Y, const int sizeX, const int sizeY);

  virtual int Type(void) const {
    return (OBJ_RECTANGLE_LABEL);
  }

  bool X_Size(const int X) const;
  int X_Size(void) const {
    return (CChartObjectLabel::X_Size());
  }
  bool Y_Size(const int Y) const;
  int Y_Size(void) const {
    return (CChartObjectLabel::Y_Size());
  }
  color BackColor(void) const;
  bool BackColor(const color new_color) const;
  ENUM_BORDER_TYPE BorderType(void) const;
  bool BorderType(const ENUM_BORDER_TYPE flag) const;

  bool Angle(const double angle) const {
    return (false);
  }
  double Angle(void) const {
    return (CChartObjectLabel::Angle());
  }

  virtual bool Save(const int file_handle);
  virtual bool Load(const int file_handle);
};

CChartObjectRectLabel::CChartObjectRectLabel(void) {
}

CChartObjectRectLabel::~CChartObjectRectLabel(void) {
}

bool CChartObjectRectLabel::Create(long chart_id, const string name,
                                   const int window, const int X, const int Y,
                                   const int sizeX, const int sizeY) {
  if (!ObjectCreate(chart_id, name, (ENUM_OBJECT)Type(), window, 0, 0, 0))
    return (false);
  if (!Attach(chart_id, name, window, 1))
    return (false);
  if (!X_Distance(X) || !Y_Distance(Y))
    return (false);
  if (!X_Size(sizeX) || !Y_Size(sizeY))
    return (false);

  return (true);
}

bool CChartObjectRectLabel::X_Size(const int X) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_XSIZE, X));
}

bool CChartObjectRectLabel::Y_Size(const int Y) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_YSIZE, Y));
}

color CChartObjectRectLabel::BackColor(void) const {

  if (m_chart_id == -1)
    return (CLR_NONE);

  return ((color)ObjectGetInteger(m_chart_id, m_name, OBJPROP_BGCOLOR));
}

bool CChartObjectRectLabel::BackColor(const color new_color) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_BGCOLOR, new_color));
}

ENUM_BORDER_TYPE CChartObjectRectLabel::BorderType(void) const {

  if (m_chart_id == -1)
    return (false);

  return ((ENUM_BORDER_TYPE)ObjectGetInteger(m_chart_id, m_name,
                                             OBJPROP_BORDER_TYPE));
}

bool CChartObjectRectLabel::BorderType(const ENUM_BORDER_TYPE type) const {

  if (m_chart_id == -1)
    return (false);

  return (ObjectSetInteger(m_chart_id, m_name, OBJPROP_BORDER_TYPE, type));
}

bool CChartObjectRectLabel::Save(const int file_handle) {
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectLabel::Save(file_handle))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_XSIZE),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteInteger(file_handle,
                       (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_YSIZE),
                       INT_VALUE) != sizeof(int))
    return (false);

  if (FileWriteLong(file_handle,
                    ObjectGetInteger(m_chart_id, m_name, OBJPROP_BGCOLOR)) !=
      sizeof(long))
    return (false);

  if (FileWriteInteger(
          file_handle,
          (int)ObjectGetInteger(m_chart_id, m_name, OBJPROP_BORDER_TYPE),
          INT_VALUE) != sizeof(int))
    return (false);

  return (true);
}

bool CChartObjectRectLabel::Load(const int file_handle) {
  string str;

  if (file_handle == INVALID_HANDLE || m_chart_id == -1)
    return (false);

  if (!CChartObjectLabel::Load(file_handle))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_XSIZE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_YSIZE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_BGCOLOR,
                        FileReadLong(file_handle)))
    return (false);

  if (!ObjectSetInteger(m_chart_id, m_name, OBJPROP_BORDER_TYPE,
                        FileReadInteger(file_handle, INT_VALUE)))
    return (false);

  return (true);
}

#endif
