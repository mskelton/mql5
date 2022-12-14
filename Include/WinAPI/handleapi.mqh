#ifndef HANDLEAPI_H
#define HANDLEAPI_H

#include <WinAPI/windef.mqh>

int CloseHandle(HANDLE object);
int DuplicateHandle(HANDLE source_process_handle, HANDLE source_handle,
                    HANDLE target_process_handle, HANDLE &target_handle,
                    uint desired_access, int inherit_handle, uint options);
int GetHandleInformation(HANDLE object, uint &flags);
int SetHandleInformation(HANDLE object, uint mask, uint flags);

int CompareObjectHandles(HANDLE first_object_handle,
                         HANDLE second_object_handle);

#endif
