#include "../../common/book.h"

#define N 50000

void add(int *a, int *b, int *c) {
  int tid = 0; // this is CPU zero, so we staart at zero
  while(tid < N) {
    c[tid] = a[tid] + b[tid];
    tid += 1; // if we have one CPU, we increment by one
  }

  /*
    We can also use multiple CPU cores here, one core initializes the loop with tid = 0
    and another with tid = 1. Then we can update tid by 2.
  */
}

int main(void) {
  int a[N], b[N], c[N];

  // fill the arrays 'a' and 'b' on the CPUs
  for(int i = 0; i < N; i++) {
    a[i] = -i;
    b[i] = i * i;
  }

  add(a, b, c);

  // display the results
  for(int i = 0; i < N; i++) {
    printf("%d + %d = %d\n", a[i], b[i], c[i]);
  }

  return 0;
}
