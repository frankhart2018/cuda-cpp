#include "../../common/book.h"

int main(void) {
  cudaDeviceProp prop;

  int count;
  HANDLE_ERROR(cudaGetDeviceCount(&count));

  for (int i = 0; i < count; i++) {
    HANDLE_ERROR(cudaGetDeviceProperties(&prop, i)); // This returns a structure of type cudaDeviceProp

    printf("--- General Information for device %d ---\n", i+1);
    printf("Name: %s\n", prop.name);
    printf("Compute capability: %d.%d\n", prop.major, prop.minor);
    printf("Clock rate: %d\n", prop.clockRate);

    printf("Device copy overlap: ");
    if (prop.deviceOverlap)
      printf("Enabled\n");
    else
      printf("Disabled\n");

    printf("Kernel execution timeout: ");
    if (prop.kernelExecTimeoutEnabled)
      printf("Enabled\n");
    else
      printf("Disabled\n");

    printf("\n---Memory Information for device %d ---\n", i+1);
    printf("Total global mem: %zu\n", prop.totalGlobalMem);
    printf("Total constant mem: %zu\n", prop.totalConstMem);
    printf("Max mem pitch: %zu\n", prop.memPitch);
    printf("Texture Alignment: %zu\n", prop.textureAlignment);

    printf("\n--- MP Information for device %d ---\n", i+1);
    printf("Multiprocessor count: %d\n", prop.multiProcessorCount);
    printf("Shared mem per mp: %zu\n", prop.sharedMemPerBlock);
    printf("Registers per mp: %d\n", prop.regsPerBlock);
    printf("Threads in warp: %d\n", prop.warpSize);
    printf("Max threads per block: %d\n", prop.maxThreadsPerBlock);
    printf("Max thread dimension: (%d, %d, %d)\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
    printf("Max grid dimensions: (%d, %d, %d)\n", prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
    printf("\n");
  }
}
