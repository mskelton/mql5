#ifndef DX_ENUMS_H
#define DX_ENUMS_H

typedef enum ENUM_DX_SHADER_TYPE {
  /**
   * Vertex shader
   */
  DX_SHADER_VERTEX,
  /**
   * Geometry shader
   */
  DX_SHADER_GEOMETRY,
  /**
   * Pixel shader
   */
  DX_SHADER_PIXEL,
} ENUM_DX_SHADER_TYPE;

typedef enum ENUM_DX_FORMAT {
  DX_FORMAT_420_OPAQUE,
  DX_FORMAT_A8P8,
  DX_FORMAT_A8_UNORM,
  DX_FORMAT_AI44,
  DX_FORMAT_AYUV,
  DX_FORMAT_B4G4R4A4_UNORM,
  DX_FORMAT_B5G5R5A1_UNORM,
  DX_FORMAT_B5G6R5_UNORM,
  DX_FORMAT_B8G8R8A8_TYPELESS,
  DX_FORMAT_B8G8R8A8_UNORM,
  DX_FORMAT_B8G8R8A8_UNORM_SRGB,
  DX_FORMAT_B8G8R8X8_TYPELESS,
  DX_FORMAT_B8G8R8X8_UNORM,
  DX_FORMAT_B8G8R8X8_UNORM_SRGB,
  DX_FORMAT_BC1_TYPELESS,
  DX_FORMAT_BC1_UNORM,
  DX_FORMAT_BC1_UNORM_SRGB,
  DX_FORMAT_BC2_TYPELESS,
  DX_FORMAT_BC2_UNORM,
  DX_FORMAT_BC2_UNORM_SRGB,
  DX_FORMAT_BC3_TYPELESS,
  DX_FORMAT_BC3_UNORM,
  DX_FORMAT_BC3_UNORM_SRGB,
  DX_FORMAT_BC4_SNORM,
  DX_FORMAT_BC4_TYPELESS,
  DX_FORMAT_BC4_UNORM,
  DX_FORMAT_BC5_SNORM,
  DX_FORMAT_BC5_TYPELESS,
  DX_FORMAT_BC5_UNORM,
  DX_FORMAT_BC6H_SF16,
  DX_FORMAT_BC6H_TYPELESS,
  DX_FORMAT_BC6H_UF16,
  DX_FORMAT_BC7_TYPELESS,
  DX_FORMAT_BC7_UNORM,
  DX_FORMAT_BC7_UNORM_SRGB,
  DX_FORMAT_D16_UNORM,
  DX_FORMAT_D24_UNORM_S8_UINT,
  DX_FORMAT_D32_FLOAT,
  DX_FORMAT_D32_FLOAT_S8X24_UINT,
  DX_FORMAT_FORCE_UINT,
  DX_FORMAT_G8R8_G8B8_UNORM,
  DX_FORMAT_IA44,
  DX_FORMAT_NV11,
  DX_FORMAT_NV12,
  DX_FORMAT_P010,
  DX_FORMAT_P016,
  DX_FORMAT_P208,
  DX_FORMAT_P8,
  DX_FORMAT_R10G10B10A2_TYPELESS,
  DX_FORMAT_R10G10B10A2_UINT,
  DX_FORMAT_R10G10B10A2_UNORM,
  DX_FORMAT_R10G10B10_XR_BIAS_A2_UNORM,
  DX_FORMAT_R11G11B10_FLOAT,
  DX_FORMAT_R16G16B16A16_FLOAT,
  DX_FORMAT_R16G16B16A16_SINT,
  DX_FORMAT_R16G16B16A16_SNORM,
  DX_FORMAT_R16G16B16A16_TYPELESS,
  DX_FORMAT_R16G16B16A16_UINT,
  DX_FORMAT_R16G16B16A16_UNORM,
  DX_FORMAT_R16G16_FLOAT,
  DX_FORMAT_R16G16_SINT,
  DX_FORMAT_R16G16_SNORM,
  DX_FORMAT_R16G16_TYPELESS,
  DX_FORMAT_R16G16_UINT,
  DX_FORMAT_R16G16_UNORM,
  DX_FORMAT_R16_FLOAT,
  DX_FORMAT_R16_SINT,
  DX_FORMAT_R16_SNORM,
  DX_FORMAT_R16_TYPELESS,
  DX_FORMAT_R16_UINT,
  DX_FORMAT_R16_UNORM,
  DX_FORMAT_R1_UNORM,
  DX_FORMAT_R24G8_TYPELESS,
  DX_FORMAT_R24_UNORM_X8_TYPELESS,
  DX_FORMAT_R32G32B32A32_FLOAT,
  DX_FORMAT_R32G32B32A32_SINT,
  DX_FORMAT_R32G32B32A32_TYPELESS,
  DX_FORMAT_R32G32B32A32_UINT,
  DX_FORMAT_R32G32B32_FLOAT,
  DX_FORMAT_R32G32B32_SINT,
  DX_FORMAT_R32G32B32_TYPELESS,
  DX_FORMAT_R32G32B32_UINT,
  DX_FORMAT_R32G32_FLOAT,
  DX_FORMAT_R32G32_SINT,
  DX_FORMAT_R32G32_TYPELESS,
  DX_FORMAT_R32G32_UINT,
  DX_FORMAT_R32G8X24_TYPELESS,
  DX_FORMAT_R32_FLOAT,
  DX_FORMAT_R32_FLOAT_X8X24_TYPELESS,
  DX_FORMAT_R32_SINT,
  DX_FORMAT_R32_TYPELESS,
  DX_FORMAT_R32_UINT,
  DX_FORMAT_R8G8B8A8_SINT,
  DX_FORMAT_R8G8B8A8_SNORM,
  DX_FORMAT_R8G8B8A8_TYPELESS,
  DX_FORMAT_R8G8B8A8_UINT,
  DX_FORMAT_R8G8B8A8_UNORM,
  DX_FORMAT_R8G8B8A8_UNORM_SRGB,
  DX_FORMAT_R8G8_B8G8_UNORM,
  DX_FORMAT_R8G8_SINT,
  DX_FORMAT_R8G8_SNORM,
  DX_FORMAT_R8G8_TYPELESS,
  DX_FORMAT_R8G8_UINT,
  DX_FORMAT_R8G8_UNORM,
  DX_FORMAT_R8_SINT,
  DX_FORMAT_R8_SNORM,
  DX_FORMAT_R8_TYPELESS,
  DX_FORMAT_R8_UINT,
  DX_FORMAT_R8_UNORM,
  DX_FORMAT_R9G9B9E5_SHAREDEXP,
  DX_FORMAT_UNKNOWN,
  DX_FORMAT_V208,
  DX_FORMAT_V408,
  DX_FORMAT_X24_TYPELESS_G8_UINT,
  DX_FORMAT_X32_TYPELESS_G8X24_UINT,
  DX_FORMAT_Y210,
  DX_FORMAT_Y216,
  DX_FORMAT_Y410,
  DX_FORMAT_Y416,
  DX_FORMAT_YUY2,
} ENUM_DX_FORMAT;

#endif
