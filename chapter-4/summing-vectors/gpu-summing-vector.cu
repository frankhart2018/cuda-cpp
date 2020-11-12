#include "../../common/book.h"

#define N 50000

__global__ void add(int *a, int *b, int *c) {
  int tid = blockIdx.x; // handle the data at this index, x is for the x dimension, blockIdx is of two dimensions
  if(tid < N)
    c[tid] = a[tid] + b[tid];
}

int main(void) {
  int a[N], b[N], c[N];
  int *dev_a, *dev_b, *dev_c;

  // allocate the memory on the GPU
  HANDLE_ERROR(cudaMalloc((void**)&dev_a, N * sizeof(int)));
  HANDLE_ERROR(cudaMalloc((void**)&dev_b, N * sizeof(int)));
  HANDLE_ERROR(cudaMalloc((void**)&dev_c, N * sizeof(int)));

  // fill the arrays 'a' and 'b' on the CPU
  for (int i = 0; i < N; i++) {
    a[i] = -i;
    b[i] = i * i;
  }

  // copy the arrays 'a' and 'b' to the GPU
  HANDLE_ERROR(cudaMemcpy(dev_a, a, N * sizeof(int), cudaMemcpyHostToDevice));
  HANDLE_ERROR(cudaMemcpy(dev_b, b, N * sizeof(int), cudaMemcpyHostToDevice));
  HANDLE_ERROR(cudaMemcpy(dev_c, c, N * sizeof(int), cudaMemcpyHostToDevice));

  // Call CUDA kernel
  add<<<N,1>>>(dev_a, dev_b, dev_c); // N blocks, N copies of kernel running in parallel

  // The collection of parallel blocks is called a grid

  // copy the array 'c' back from the GPU to the CPU
  HANDLE_ERROR(cudaMemcpy(c, dev_c, N * sizeof(int), cudaMemcpyDeviceToHost));

  // display the results
  for (int i = 0; i < N; i++) {
    printf("%d + %d = %d\n", a[i], b[i], c[i]);
  }

  // free the memory allocated on the GPU
  cudaFree(dev_a);
  cudaFree(dev_b);
  cudaFree(dev_c);
}
