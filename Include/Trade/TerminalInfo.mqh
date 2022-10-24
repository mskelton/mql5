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



























#endif
