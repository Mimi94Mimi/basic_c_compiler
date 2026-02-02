#include <stdio.h>


void output(int val);
void codegen() asm("codegen");

int main()
{
  codegen();
  return 0;
}


void output(int val)
{
  printf("Output(%d);\n", val);
}
