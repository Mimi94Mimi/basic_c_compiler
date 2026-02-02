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
	./parser < ../Testcase/Basic/0.c > ../Testcase/Basic/0.S
	rm -rf ../Testcase/Basic/0_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Basic/0_prog ./main.c ../Testcase/Basic/0.S
	qemu-riscv32 ../Testcase/Basic/0_prog

tc2_0: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/ArithmeticExpression/0.c > ../Testcase/ArithmeticExpression/0.S
	rm -rf ../Testcase/ArithmeticExpression/0_prog
	riscv32-unknown-elf-gcc -o ../Testcase/ArithmeticExpression/0_prog ./main.c ../Testcase/ArithmeticExpression/0.S
	qemu-riscv32 ../Testcase/ArithmeticExpression/0_prog

tc2_1: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/ArithmeticExpression/1.c > ../Testcase/ArithmeticExpression/1.S
	rm -rf ../Testcase/ArithmeticExpression/1_prog
	riscv32-unknown-elf-gcc -o ../Testcase/ArithmeticExpression/1_prog ./main.c ../Testcase/ArithmeticExpression/1.S
	qemu-riscv32 ../Testcase/ArithmeticExpression/1_prog

tc3_0: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Pointer/0.c > ../Testcase/Pointer/0.S
	rm -rf ../Testcase/Pointer/0_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Pointer/0_prog ./main.c ../Testcase/Pointer/0.S
	qemu-riscv32 ../Testcase/Pointer/0_prog

tc3_1: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Pointer/1.c > ../Testcase/Pointer/1.S
	rm -rf ../Testcase/Pointer/1_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Pointer/1_prog ./main.c ../Testcase/Pointer/1.S
	qemu-riscv32 ../Testcase/Pointer/1_prog

tc4_0: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Jump/0.c > ../Testcase/Jump/0.S
	rm -rf ../Testcase/Jump/0_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Jump/0_prog ./main.c ../Testcase/Jump/0.S
	qemu-riscv32 ../Testcase/Jump/0_prog

tc4_1: clean
	flex scanner.l
	byacc -v -d parser.y
	gcc -o parser lex.yy.c y.tab.c code.c
	./parser < ../Testcase/Jump/1.c > ../Testcase/Jump/1.S
	rm -rf ../Testcase/Jump/1_prog
	riscv32-unknown-elf-gcc -o ../Testcase/Jump/1_prog ./main.c ../Testcase/Jump/1.S
	qemu-riscv32 ../Testcase/Jump/1_prog