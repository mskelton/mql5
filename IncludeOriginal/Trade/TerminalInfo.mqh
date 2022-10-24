#ifndef TERMINAL_INFO_H
#define TERMINAL_INFO_H

#include <Object.mqh>

class CTerminalInfo : public CObject {
public:
  CTerminalInfo(void);
  ~CTerminalInfo(void);

  int Build(void) const;
  bool IsConnected(void) const;
  bool IsDLLsAllowed(void) const;
  bool IsTradeAllowed(void) const;
  bool IsEmailEnabled(void) const;
  bool IsFtpEnabled(void) const;
  int MaxBars(void) const;
  int CodePage(void) const;
  int CPUCores(void) const;
  int MemoryPhysical(void) const;
  int MemoryTotal(void) const;
  int MemoryAvailable(void) const;
  int MemoryUsed(void) const;
  bool IsX64(void) const;
  int OpenCLSupport(void) const;
  int DiskSpace(void) const;

  string Language(void) const;
  string Name(void) const;
  string Company(void) const;
  string Path(void) const;
  string DataPath(void) const;
  string CommonDataPath(void) const;

  long InfoInteger(const ENUM_TERMINAL_INFO_INTEGER prop_id) const;
  string InfoString(const ENUM_TERMINAL_INFO_STRING prop_id) const;
};

CTerminalInfo::CTerminalInfo(void) {}

CTerminalInfo::~CTerminalInfo(void) {}

int CTerminalInfo::Build(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_BUILD));
}

bool CTerminalInfo::IsConnected(void) const {
  return ((bool)TerminalInfoInteger(TERMINAL_CONNECTED));
}

bool CTerminalInfo::IsDLLsAllowed(void) const {
  return ((bool)TerminalInfoInteger(TERMINAL_DLLS_ALLOWED));
}

bool CTerminalInfo::IsTradeAllowed(void) const {
  return ((bool)TerminalInfoInteger(TERMINAL_TRADE_ALLOWED));
}

bool CTerminalInfo::IsEmailEnabled(void) const {
  return ((bool)TerminalInfoInteger(TERMINAL_EMAIL_ENABLED));
}

bool CTerminalInfo::IsFtpEnabled(void) const {
  return ((bool)TerminalInfoInteger(TERMINAL_FTP_ENABLED));
}

int CTerminalInfo::MaxBars(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_MAXBARS));
}

int CTerminalInfo::CodePage(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_CODEPAGE));
}

int CTerminalInfo::CPUCores(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_CPU_CORES));
}

int CTerminalInfo::MemoryPhysical(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_MEMORY_PHYSICAL));
}

int CTerminalInfo::MemoryTotal(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_MEMORY_TOTAL));
}

int CTerminalInfo::MemoryAvailable(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_MEMORY_AVAILABLE));
}

int CTerminalInfo::MemoryUsed(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_MEMORY_USED));
}

bool CTerminalInfo::IsX64(void) const {
  return ((bool)TerminalInfoInteger(TERMINAL_X64));
}

int CTerminalInfo::OpenCLSupport(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_OPENCL_SUPPORT));
}

int CTerminalInfo::DiskSpace(void) const {
  return ((int)TerminalInfoInteger(TERMINAL_DISK_SPACE));
}

string CTerminalInfo::Language(void) const {
  return (TerminalInfoString(TERMINAL_LANGUAGE));
}

string CTerminalInfo::Name(void) const {
  return (TerminalInfoString(TERMINAL_NAME));
}

string CTerminalInfo::Company(void) const {
  return (TerminalInfoString(TERMINAL_COMPANY));
}

string CTerminalInfo::Path(void) const {
  return (TerminalInfoString(TERMINAL_PATH));
}

string CTerminalInfo::DataPath(void) const {
  return (TerminalInfoString(TERMINAL_DATA_PATH));
}

string CTerminalInfo::CommonDataPath(void) const {
  return (TerminalInfoString(TERMINAL_COMMONDATA_PATH));
}

long CTerminalInfo::InfoInteger(
    const ENUM_TERMINAL_INFO_INTEGER prop_id) const {
  return (TerminalInfoInteger(prop_id));
}

string CTerminalInfo::InfoString(
    const ENUM_TERMINAL_INFO_STRING prop_id) const {
  return (TerminalInfoString(prop_id));
}

#endif
