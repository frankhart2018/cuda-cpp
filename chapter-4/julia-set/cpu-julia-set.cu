#include "../../common/book.h"
#include "../../common/cpu_bitmap.h"

#define DIM 1000

struct cuComplex {
  float r;
  float i;

  cuComplex(float a, float b) : r(a), i(b) {}

  float magnitude2(void) {
    return r * r + i * i;
  }

  cuComplex operator*(const cuComplex& a) {
    return cuComplex(r*a.r - i*a.i, i*a.r + r*a.i);
  }

  cuComplex operator+(const cuComplex& a) {
    return cuComplex(r+a.r, i+a.i);
  }
};

int julia(int x, int y) {
  // Center the complex plane at image center
  const float scale = 1.5;
  float jx = scale * (float)(DIM / 2 - x) / (DIM / 2);
  float jy = scale * (float)(DIM / 2 - y) / (DIM / 2);

  // Translate pixel coordinate to complex space
  cuComplex c(-0.8, 0.156);
  cuComplex a(jx, jy);

  int i = 0;
  for(i = 0; i < 200; i++) {
    a = a * a + c;
    if (a.magnitude2() > 1000)
      return 0;
  }

  return 1;
}

void kernel(unsigned char* ptr) {
  for (int y = 0; y < DIM; y++) {
    for (int x = 0; x < DIM; x++) {
      int offset = x + y * DIM;

      int juliaValue = julia(x, y); // this method returns 1 if the point is in the set and 0 if it is not in the set
      ptr[offset * 4 + 0] = 255 * juliaValue; // Set color to red if it is in set, otherwise it is black
      ptr[offset * 4 + 1] = 0;
      ptr[offset * 4 + 2] = 0;
      ptr[offset * 4 + 3] = 255;
    }
  }
}

int main(void) {
  CPUBitmap bitmap(DIM, DIM);
  unsigned char *ptr = bitmap.get_ptr();

  kernel(ptr);

  bitmap.display_and_exit();
}
