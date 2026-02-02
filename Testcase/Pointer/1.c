void codegen();

void codegen() {
  int a = 58 / 17; /* a = 3 */
  int b = a * 2 + 10; /* b = 16 */
  int *c = &a; /* *c = 3 */
  *c = *c + 1; /* *c = 4, a = 4 */
  c = &b; /* *c = 16 */
  *c = b / a; /* *c = 4, b = 4 */
  output(a + 1); // ans: 5
  output(b - 2); // ans: 2
}
