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





#endif
