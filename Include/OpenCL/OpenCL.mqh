#ifndef OPEN_CL_H
#define OPEN_CL_H

class COpenCL {
protected:
  int m_context;
  int m_program;

  string m_kernel_names;
  int m_kernels;
  int m_kernels_total;

  int m_buffers;
  int m_buffers_total;
  string m_device_extensions;
  bool m_support_cl_khr_fp64;

public:
  COpenCL();
  ~COpenCL();

  int GetContext(void) const;
  int GetProgram(void) const;
  int GetKernel(const int kernel_index) const;
  string GetKernelName(const int kernel_index) const;

  bool GetGlobalMemorySize(long &global_memory_size);

  bool SupportDouble(void) const;

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
  bool BufferFromArray(const int buffer_index, T data[],
                       const uint data_array_offset,
                       const uint data_array_count, const uint flags);
  template <typename T>
  bool BufferRead(const int buffer_index, T data[], const uint cl_buffer_offset,
                  const uint data_array_offset, const uint data_array_count);
  template <typename T>
  bool BufferWrite(const int buffer_index, T data[],
                   const uint cl_buffer_offset, const uint data_array_offset,
                   const uint data_array_count);

  template <typename T>
  bool SetArgument(const int kernel_index, const int arg_index, T value);
  bool SetArgumentBuffer(const int kernel_index, const int arg_index,
                         const int buffer_index);
  bool SetArgumentLocalMemory(const int kernel_index, const int arg_index,
                              const int local_memory_size);

  bool Execute(const int kernel_index, const int work_dim,
               const uint work_offset[], const uint work_size[]);
  bool Execute(const int kernel_index, const int work_dim,
               const uint work_offset[], const uint work_size[],
               const uint local_work_size[]);
};

#endif
