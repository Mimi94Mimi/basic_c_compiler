void codegen();

void codegen() {
  int a = 42 - 53 * 2; /* a = -64 */
  int *b = &a; /* *b = -64 */
  *b = -a / 8; /* a = 8, *b = 8 */
  a = *b - 4; /* a = 4, *b = 4 */
  output(a); /* output 4 */
  output(*b); /* output 4 */
}
