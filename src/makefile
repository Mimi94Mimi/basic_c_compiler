all: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o codegen lex.yy.c y.tab.c code.c
	./codegen < test.c > codegen.S

exec:
	rm -rf output_prog
	riscv32-unknown-elf-gcc -o output_prog main.c codegen.S
	qemu-riscv32 output_prog

clean:
	rm -rf parser
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf codegen
	rm -rf *.output
	rm -rf *.S

tc1: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Basic/0.c > ../Testcase/Basic/codegen.S

tc1_exec:
	rm -rf ../Testcase/Basic/tc1_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Basic/tc1_prog ../main.c ../Testcase/Basic/codegen.S
	qemu-riscv32 ../Testcase/Basic/tc1_prog

tc2_0: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/ArithmeticExpression/0.c > ../Testcase/ArithmeticExpression/codegen.S

tc2_0_exec:
	rm -rf ../Testcase/ArithmeticExpression/tc2_0_prog
	riscv32-unknown-elf-gcc -o ../Testcase/ArithmeticExpression/tc2_0_prog ../main.c ../Testcase/ArithmeticExpression/codegen.S
	qemu-riscv32 ../Testcase/ArithmeticExpression/tc2_0_prog

tc2_1: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/ArithmeticExpression/1.c > ../Testcase/ArithmeticExpression/codegen.S

tc2_1_exec:
	rm -rf ../Testcase/ArithmeticExpression/tc2_1_prog
	riscv32-unknown-elf-gcc -o ../Testcase/ArithmeticExpression/tc2_1_prog ../main.c ../Testcase/ArithmeticExpression/codegen.S
	qemu-riscv32 ../Testcase/ArithmeticExpression/tc2_1_prog

tc3_0: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Pointer/0.c > ../Testcase/Pointer/codegen.S

tc3_0_exec:
	rm -rf ../Testcase/Pointer/tc3_0_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Pointer/tc3_0_prog ../main.c ../Testcase/Pointer/codegen.S
	qemu-riscv32 ../Testcase/Pointer/tc3_0_prog

tc3_1: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Pointer/1.c > ../Testcase/Pointer/codegen.S

tc3_1_exec:
	rm -rf ../Testcase/Pointer/tc3_1_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Pointer/tc3_1_prog ../main.c ../Testcase/Pointer/codegen.S
	qemu-riscv32 ../Testcase/Pointer/tc3_1_prog

tc4_0: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Jump/0.c > ../Testcase/Jump/codegen.S

tc4_0_exec:
	rm -rf ../Testcase/Jump/tc4_0_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Jump/tc4_0_prog ../main.c ../Testcase/Jump/codegen.S
	qemu-riscv32 ../Testcase/Jump/tc4_0_prog

tc4_1: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Jump/1.c > ../Testcase/Jump/codegen.S

tc4_1_exec:
	rm -rf ../Testcase/Jump/tc4_1_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Jump/tc4_1_prog ../main.c ../Testcase/Jump/codegen.S
	qemu-riscv32 ../Testcase/Jump/tc4_1_prog
