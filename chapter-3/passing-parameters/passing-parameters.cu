#include <iostream>
#include "../../common/book.h"

__global__ void add(int a, int b, int *c) {
  *c = a + b;
}

int main(void) {
  int c;
  int *dev_c; // Pointer to store result computed in device

  HANDLE_ERROR(cudaMalloc((void**)&dev_c, sizeof(int))); // Allocate sizeof int to dev_c

  add<<<1,1>>>(2, 7, dev_c); // Call device kernel

  HANDLE_ERROR(cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost)); // Copy result from device pointer to host integer c
  printf("2 + 7 = %d\n", c);
  cudaFree(dev_c); // Free the device memory
}

// The device pointer cannot read or write from memory

/*

  Summary of what can be done with device pointer"=

  1) We can pass pointers allocated with cudaMalloc() to functions that execute on the device.
  2) We can use pointers allocated with cudaMalloc() to read or write memory from code that executes on the device.
  3) We can pass pointers with cudaMalloc() to functions that execute on the host.
  4) We cannot use pointers allocated with cudaMalloc() to read or write memory from code that executes on the host.

*/
