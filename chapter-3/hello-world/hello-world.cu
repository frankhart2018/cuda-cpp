#include <iostream>

__global__ void kernel(void) {} // __global__ indicates that the function is to be run on device (GPU)

int main(void) {
  kernel<<<1,1>>>(); // <<<1,1>>> are the arguments passed to the host, the arguments to device will be as usual inside ().
  printf("Hello, World!\n");
  return 0;
}
