#ifndef COLOR_GENERATOR_H
#define COLOR_GENERATOR_H

class CColorGenerator {
private:
  int m_index;
  bool m_generate;
  uint m_current_palette[20];
  const static uint s_default_palette[20];

public:
  CColorGenerator(void);
  ~CColorGenerator(void);

  uint Next(void);

  void Reset(void);
};
const uint CColorGenerator::s_default_palette[20] = {
    0x3366CC, 0xDC3912, 0xFF9900, 0x109618, 0x990099, 0x3B3EAC, 0x0099C6,
    0xDD4477, 0x66AA00, 0xB82E2E, 0x316395, 0x994499, 0x22AA99, 0xAAAA11,
    0x6633CC, 0xE67300, 0x8B0707, 0x329262, 0x5574A6, 0x3B3EAC};

CColorGenerator::CColorGenerator(void) : m_index(0), m_generate(false) {
  ArrayCopy(m_current_palette, s_default_palette);
}

CColorGenerator::~CColorGenerator(void) {
}

uint CColorGenerator::Next(void) {

  if (m_index == 20) {
    m_index = 0;
    if (!m_generate)
      m_generate = true;
  }

  if (m_generate)
    m_current_palette[m_index] =
        (m_index == 19
             ? (m_current_palette[m_index] ^ m_current_palette[0])
             : (m_current_palette[m_index] ^ m_current_palette[m_index + 1]));

  return (m_current_palette[m_index++]);
}

void CColorGenerator::Reset(void) {
  m_index = 0;
  m_generate = false;
  ArrayCopy(m_current_palette, s_default_palette);
}

#endif
