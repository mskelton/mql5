#ifndef OPEN_CL_H
#define OPEN_CL_H

class COpenCL {
protected:
  int m_context;
  int m_program;

  string m_kernel_names[];
  int m_kernels[];
  int m_kernels_total;

  int m_buffers[];
  int m_buffers_total;
  string m_device_extensions;
  bool m_support_cl_khr_fp64;

public:
  COpenCL();
  ~COpenCL();

  int GetContext(void) const {
    return (m_context);
  }
  int GetProgram(void) const {
    return (m_program);
  }
  int GetKernel(const int kernel_index) const;
  string GetKernelName(const int kernel_index) const;

  bool GetGlobalMemorySize(long &global_memory_size);

  bool SupportDouble(void) const {
    return (m_support_cl_khr_fp64);
  }

  bool Initialize(const string program, const bool show_log = true);
  void Shutdown();

  bool SetBuffersCount(const int total_buffers);
  bool SetKernelsCount(const int total_kernels);

  bool KernelCreate(const int kernel_index, const string kernel_name);
  bool KernelFree(const int kernel_index);

  bool BufferCreate(const int buffer_index, const uint size_in_bytes,
                    const uint flags);
  bool BufferFree(const int buffer_index);
  template <typename T>
  bool BufferFromArray(const int buffer_index, T &data[],
                       const uint data_array_offset,
                       const uint data_array_count, const uint flags);
  template <typename T>
  bool BufferRead(const int buffer_index, T &data[],
                  const uint cl_buffer_offset, const uint data_array_offset,
                  const uint data_array_count);
  template <typename T>
  bool BufferWrite(const int buffer_index, T &data[],
                   const uint cl_buffer_offset, const uint data_array_offset,
                   const uint data_array_count);

  template <typename T>
  bool SetArgument(const int kernel_index, const int arg_index, T value);
  bool SetArgumentBuffer(const int kernel_index, const int arg_index,
                         const int buffer_index);
  bool SetArgumentLocalMemory(const int kernel_index, const int arg_index,
                              const int local_memory_size);

  bool Execute(const int kernel_index, const int work_dim,
               const uint &work_offset[], const uint &work_size[]);
  bool Execute(const int kernel_index, const int work_dim,
               const uint &work_offset[], const uint &work_size[],
               const uint &local_work_size[]);
};

COpenCL::COpenCL() {
  m_context = INVALID_HANDLE;
  m_program = INVALID_HANDLE;
  m_buffers_total = 0;
  m_kernels_total = 0;
  m_device_extensions = "";
  m_support_cl_khr_fp64 = false;
}

COpenCL::~COpenCL() {
  Shutdown();
}

int COpenCL::GetKernel(const int kernel_index) const {
  if (m_kernels_total <= 0 || kernel_index < 0 ||
      kernel_index >= m_kernels_total)
    return (INVALID_HANDLE);

  return m_kernels[kernel_index];
}

string COpenCL::GetKernelName(const int kernel_index) const {
  if (m_kernels_total <= 0 || kernel_index < 0 ||
      kernel_index >= m_kernels_total)
    return ("");

  return m_kernel_names[kernel_index];
}

bool COpenCL::GetGlobalMemorySize(long &global_memory_size) {
  if (m_context == INVALID_HANDLE)
    return (false);

  global_memory_size = CLGetInfoInteger(m_context, CL_DEVICE_GLOBAL_MEM_SIZE);
  if (global_memory_size == -1)
    return (false);

  return (true);
}

bool COpenCL::Initialize(const string program, const bool show_log = true) {
  if ((m_context = CLContextCreate(CL_USE_ANY)) == INVALID_HANDLE) {
    Print("OpenCL not found. Error code=", GetLastError());
    return (false);
  }

  if (CLGetInfoString(m_context, CL_DEVICE_EXTENSIONS, m_device_extensions)) {
    string extenstions[];
    StringSplit(m_device_extensions, ' ', extenstions);
    m_support_cl_khr_fp64 = false;
    int size = ArraySize(extenstions);
    for (int i = 0; i < size; i++) {
      if (extenstions[i] == "cl_khr_fp64")
        m_support_cl_khr_fp64 = true;
    }
  }

  string build_error_log;
  if ((m_program = CLProgramCreate(m_context, program, build_error_log)) ==
      INVALID_HANDLE) {
    if (show_log) {
      string loglines[];
         StringSplit(build_error_log,'
',loglines);
         int lines_count=ArraySize(loglines);
         for(int i=0; i<lines_count; i++)
            Print(loglines[i]);
    }
    CLContextFree(m_context);
    Print("OpenCL program create failed. Error code=", GetLastError());
    return (false);
  }

  return (true);
}

void COpenCL::Shutdown() {

  if (m_buffers_total > 0) {
    for (int i = 0; i < m_buffers_total; i++)
      BufferFree(i);
    m_buffers_total = 0;
  }

  if (m_kernels_total > 0) {
    for (int i = 0; i < m_kernels_total; i++)
      KernelFree(i);
    m_kernels_total = 0;
  }

  if (m_program != INVALID_HANDLE) {
    CLProgramFree(m_program);
    m_program = INVALID_HANDLE;
  }
  if (m_context != INVALID_HANDLE) {
    CLContextFree(m_context);
    m_context = INVALID_HANDLE;
  }
}

bool COpenCL::SetBuffersCount(const int total_buffers) {
  if (total_buffers <= 0)
    return (false);

  m_buffers_total = total_buffers;
  if (ArraySize(m_buffers) < m_buffers_total)
    ArrayResize(m_buffers, m_buffers_total);
  for (int i = 0; i < m_buffers_total; i++)
    m_buffers[i] = INVALID_HANDLE;

  return (true);
}

bool COpenCL::SetKernelsCount(const int total_kernels) {
  if (total_kernels <= 0)
    return (false);

  m_kernels_total = total_kernels;
  if (ArraySize(m_kernels) < m_kernels_total)
    ArrayResize(m_kernels, m_kernels_total);
  if (ArraySize(m_kernel_names) < m_kernels_total)
    ArrayResize(m_kernel_names, m_kernels_total);

  for (int i = 0; i < m_kernels_total; i++) {
    m_kernel_names[i] = "";
    m_kernels[i] = INVALID_HANDLE;
  }

  return (true);
}

bool COpenCL::KernelCreate(const int kernel_index, const string kernel_name) {
  if (m_context == INVALID_HANDLE || m_program == INVALID_HANDLE)
    return (false);

  if (kernel_index < 0 || kernel_index >= m_kernels_total)
    return (false);

  int kernel_handle = m_kernels[kernel_index];
  if (kernel_handle == INVALID_HANDLE ||
      m_kernel_names[kernel_index] != kernel_name) {

    if ((kernel_handle = CLKernelCreate(m_program, kernel_name)) ==
        INVALID_HANDLE) {
      CLProgramFree(m_program);
      CLContextFree(m_context);
      Print("OpenCL kernel create failed. Error code=", GetLastError());
      return (false);
    } else {
      m_kernels[kernel_index] = kernel_handle;
      m_kernel_names[kernel_index] = kernel_name;
    }
  }
  return (true);
}

bool COpenCL::KernelFree(const int kernel_index) {

  if (kernel_index < 0 || kernel_index >= m_kernels_total)
    return (false);
  if (m_kernels[kernel_index] == INVALID_HANDLE)
    return (false);

  CLKernelFree(m_kernels[kernel_index]);
  m_kernels[kernel_index] = INVALID_HANDLE;

  return (true);
}

bool COpenCL::BufferCreate(const int buffer_index, const uint size_in_bytes,
                           const uint flags) {

  if (buffer_index < 0 || buffer_index >= m_buffers_total)
    return (false);

  if (m_context == INVALID_HANDLE || m_program == INVALID_HANDLE)
    return (false);

  int buffer_handle = CLBufferCreate(m_context, size_in_bytes, flags);
  if (buffer_handle != INVALID_HANDLE) {
    m_buffers[buffer_index] = buffer_handle;
    return (true);
  } else
    return (false);
}

bool COpenCL::BufferFree(const int buffer_index) {

  if (buffer_index < 0 || buffer_index >= m_buffers_total)
    return (false);
  if (m_buffers[buffer_index] == INVALID_HANDLE)
    return (false);

  CLBufferFree(m_buffers[buffer_index]);
  m_buffers[buffer_index] = INVALID_HANDLE;

  return (true);
}

template <typename T>
bool COpenCL::BufferFromArray(const int buffer_index, T &data[],
                              const uint data_array_offset,
                              const uint data_array_count, const uint flags) {

  if (m_context == INVALID_HANDLE || m_program == INVALID_HANDLE)
    return (false);
  if (buffer_index < 0 || buffer_index >= m_buffers_total ||
      data_array_count <= 0)
    return (false);

  if (m_buffers[buffer_index] == INVALID_HANDLE) {
    uint size_in_bytes = data_array_count * sizeof(T);
    int buffer_handle = CLBufferCreate(m_context, size_in_bytes, flags);
    if (buffer_handle != INVALID_HANDLE) {
      m_buffers[buffer_index] = buffer_handle;
    } else
      return (false);
  }

  uint data_written = CLBufferWrite(m_buffers[buffer_index], data, 0,
                                    data_array_offset, data_array_count);
  if (data_written != data_array_count)
    return (false);

  return (true);
}

template <typename T>
bool COpenCL::BufferRead(const int buffer_index, T &data[],
                         const uint cl_buffer_offset,
                         const uint data_array_offset,
                         const uint data_array_count) {

  if (buffer_index < 0 || buffer_index >= m_buffers_total ||
      data_array_count <= 0)
    return (false);
  if (m_buffers[buffer_index] == INVALID_HANDLE)
    return (false);
  if (m_context == INVALID_HANDLE || m_program == INVALID_HANDLE)
    return (false);

  uint data_read = CLBufferRead(m_buffers[buffer_index], data, cl_buffer_offset,
                                data_array_offset, data_array_count);
  if (data_read != data_array_count)
    return (false);

  return (true);
}

template <typename T>
bool COpenCL::BufferWrite(const int buffer_index, T &data[],
                          const uint cl_buffer_offset,
                          const uint data_array_offset,
                          const uint data_array_count) {

  if (buffer_index < 0 || buffer_index >= m_buffers_total ||
      data_array_count <= 0)
    return (false);
  if (m_buffers[buffer_index] == INVALID_HANDLE)
    return (false);
  if (m_context == INVALID_HANDLE || m_program == INVALID_HANDLE)
    return (false);

  uint data_written =
      CLBufferWrite(m_buffers[buffer_index], data, cl_buffer_offset,
                    data_array_offset, data_array_count);
  if (data_written != data_array_count)
    return (false);

  return (true);
}

template <typename T>
bool COpenCL::SetArgument(const int kernel_index, const int arg_index,
                          T value) {
  if (kernel_index < 0 || kernel_index >= m_kernels_total)
    return (false);

  int kernel_handle = m_kernels[kernel_index];
  if (kernel_handle == INVALID_HANDLE)
    return (false);

  return CLSetKernelArg(kernel_handle, arg_index, value);
}

bool COpenCL::SetArgumentBuffer(const int kernel_index, const int arg_index,
                                const int buffer_index) {
  if (m_context == INVALID_HANDLE || m_program == INVALID_HANDLE)
    return (false);
  if (kernel_index < 0 || kernel_index >= m_kernels_total)
    return (false);
  if (buffer_index < 0 || buffer_index >= m_buffers_total)
    return (false);
  if (m_buffers[buffer_index] == INVALID_HANDLE)
    return (false);

  return CLSetKernelArgMem(m_kernels[kernel_index], arg_index,
                           m_buffers[buffer_index]);
}

bool COpenCL::SetArgumentLocalMemory(const int kernel_index,
                                     const int arg_index,
                                     const int local_memory_size) {
  if (m_context == INVALID_HANDLE || m_program == INVALID_HANDLE)
    return (false);
  if (kernel_index < 0 || kernel_index >= m_kernels_total)
    return (false);

  long device_local_memory_size =
      CLGetInfoInteger(m_context, CL_DEVICE_LOCAL_MEM_SIZE);
  if (local_memory_size > device_local_memory_size)
    return (false);

  return CLSetKernelArgMemLocal(m_kernels[kernel_index], arg_index,
                                local_memory_size);
}

bool COpenCL::Execute(const int kernel_index, const int work_dim,
                      const uint &work_offset[], const uint &work_size[]) {
  if (kernel_index < 0 || kernel_index >= m_kernels_total)
    return (false);
  int kernel_handle = m_kernels[kernel_index];
  if (kernel_handle == INVALID_HANDLE)
    return (false);

  return CLExecute(kernel_handle, work_dim, work_offset, work_size);
}

bool COpenCL::Execute(const int kernel_index, const int work_dim,
                      const uint &work_offset[], const uint &work_size[],
                      const uint &local_work_size[]) {
  if (kernel_index < 0 || kernel_index >= m_kernels_total)
    return (false);

  return CLExecute(m_kernels[kernel_index], work_dim, work_offset, work_size,
                   local_work_size);
}

#endif
