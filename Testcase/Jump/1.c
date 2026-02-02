void codegen();

void codegen() {
  int fib[7];
  int i = 0;
  do {
    if (i == 0) {
      fib[i] = 0;
    } else {
      if (i == 1) {
        fib[i] = 1;
      } else {
        int *f1 = fib + i - 1, *f2 = fib + i - 2;
        fib[i] = *f1 + *f2;
      }
    }
    i = i + 1;
  } while (i < 7);

  output((fib[6] - fib[3])); // fib[6] - fib[3] = 6
  output((fib[5] - fib[1])); // fib[5] - fib[1] = 4
}
