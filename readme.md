# C-to-RISC-V Compiler
## Introduction
This project features a functional **C-to-RISC-V Compiler** designed to bridge high-level programmatic logic with low-level hardware execution. By integrating classic compiler-construction tools—**Flex** and **Byacc**—with the modern **RISC-V ISA**, the system provides a complete end-to-end pipeline: from raw C source code to a verifiable binary executed via QEMU.

The compiler handles lexical scanning and syntactic parsing to generate RISC-V 32-bit assembly. To ensure functional correctness, it leverages the `riscv32-unknown-elf` GNU toolchain for final object linking and QEMU for architectural emulation.

## Prerequisites & Setup
This project is developed and tested on **Ubuntu 24.04**. To build and run the compiler, you need to install the lexical/syntax analysis tools and the RISC-V cross-compilation toolchain.

**1. Install Essential Build Tools**  
First, update your package list and install the required development tools:
```
sudo apt update
sudo apt install flex byacc build-essential
```

**2. Install RISC-V GNU Toolchain**  
Since we are targeting the RISC-V 32-bit architecture, a cross-compiler is required. Download and extract the pre-built toolchain:
```
# Download the toolchain for Ubuntu 24.04
wget https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2026.01.23/riscv32-elf-ubuntu-24.04-gcc.tar.xz

# Extract the archive
tar -Jxvf riscv32-elf-ubuntu-24.04-gcc.tar.xz
```

**3. Environment Configuration**  
Add the toolchain's binary directory to your system `PATH` so that `riscv32-unknown-elf-gcc` can be accessed from any terminal session.

Update your `.bashrc` file (ensure the path matches your actual installation directory):
```
# Append the path to .bashrc
echo 'export PATH="$PATH:/root/basic_c_compiler/riscv/bin"' >> ~/.bashrc

# Apply the changes
source ~/.bashrc
```

**4. Verification**  
To verify that the environment is set up correctly, run:
```
flex --version
byacc -V
riscv32-unknown-elf-gcc --version
```

## Build Pipeline & Linking Logic
The compilation process is divided into two main phases: Compiler Construction and Target Program Compilation.

### 1. Compiler Construction
The compiler's core logic is built by combining a scanner, a parser, and custom backend logic:

* Flex (`src/scanner.l`): Performs lexical analysis to identify tokens, generating `lex.yy.c`.

* Byacc (`src/parser.y`): Defines the language grammar and contains the core logic for emitting assembly code, generating `y.tab.c`.

Integration: Compiles the generated C files along with `src/code.c` (managing symbol tables and utility APIs) into an compiler executable which convert C code into assembly.

### 2. Cross-Language Linking & Execution (C + Assembly)
This stage translates the target C source code into a runnable RISC-V binary through a multi-step workflow:

```
# 1. Generate RISC-V Assembly (codegen.S)
./codegen < test.c > codegen.S

# 2. Cross-compile and Link C with Assembly
riscv32-unknown-elf-gcc -o output_prog main.c codegen.S

# 3. Execution and Verification
qemu-riscv32 output_prog
```

**Technical Detail: The Linking Mechanism**  
The project achieves seamless integration between C and Assembly by adhering to the RISC-V Calling Convention:

* External Symbol Export: The assembly file uses the **.global codegen** directive to export the entry point, **allowing main.c to call** the function across files.

* Parameter Passing: When codegen.S needs to output data, it loads the value into the a0 register and `uses jal ra, output` to jump to the output() function defined in main.c for validating output.

## Testing & Verification
The project includes a comprehensive suite of test cases located in the `Testcase/` directory. These tests are designed to verify the compiler's support for various C features, from basic linking to complex control flows.

**Test Categories**  
The test cases are organized into four major categories:

1. **Basic**: Verifies the fundamental linking between `main.c` and the generated RISC-V assembly. (1 test)

2. **ArithmeticExpression**: Validates arithmetic operations and operator precedence. (2 tests)

3. **Pointer**: Ensures correct memory addressing and pointer manipulation. (2 tests)

4. **Jump**: Tests control flow structures, including loops and conditional if-else statements. (2 tests)

**How to Run Tests**  
Navigate to the `src/` directory and use the following make commands to automate the compilation and execution process. Each command will generate the assembly, link it with the driver, and run the result through QEMU. **These assembly codes and binary file would be generated in the corresponding directory (`Testcase/***`)**

|Category  |Command                |Description                |
|----------|-----------------------|---------------------------|
|Basic     |`make tc1`               |Basic linking test         |
|Arithmetic|`make tc2_0` / `make tc2_1`|Expression evaluation tests|
|Pointer   |`make tc3_0` / `make tc3_1`|Memory & pointer tests     |
|Jump      |`make tc4_0` / `make tc4_1`|Loop and branch logic tests|


**Verification of Results**  
Upon execution, the program will display the output through the `output()` function defined in `main.c.` You should compare the printed values with the expected results defined in each test case to ensure the compiler's logic is correct.

## Showcase
All the tested C code and the assembly codes generated from them are avalible in `Testcase/<testcase_type>` folder.