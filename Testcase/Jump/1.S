.global codegen

codegen:
addi sp, sp, -200
sw ra, 196(sp)
sw s0, 192(sp)
addi s0, sp, 200
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -40(s0) 
addi sp, sp, -4
sw t0, 0(sp)

DW1:
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
slt t2, t0, t1
slt t3, t1, t0
not t2, t2
not t3, t3
and t2, t2, t3
and t2, t2, 1
sw t2, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
beq t0, zero, I1_0
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t2, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -12
slli t1, t1, 2
sub t0, t0, t1
sw t2, 0(t0)
sw t2, -4(sp)
addi sp, sp, -4
j I1_1

I1_0:
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 1
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
slt t2, t0, t1
slt t3, t1, t0
not t2, t2
not t3, t3
and t2, t2, t3
and t2, t2, 1
sw t2, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
beq t0, zero, I2_0
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 1
sw t0, -4(sp)
addi sp, sp, -4
lw t2, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -12
slli t1, t1, 2
sub t0, t0, t1
sw t2, 0(t0)
sw t2, -4(sp)
addi sp, sp, -4
j I2_1

I2_0:
addi t0, s0, -12
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
li t2, -4
mul t1, t1, t2
add t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
li t0, 1
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
li t2, -4
mul t1, t1, t2
sub t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -44(s0) 
addi sp, sp, -4
sw t0, 0(sp)
addi t0, s0, -12
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
li t2, -4
mul t1, t1, t2
add t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
li t0, 2
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
li t2, -4
mul t1, t1, t2
sub t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -48(s0) 
addi sp, sp, -4
sw t0, 0(sp)
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -44(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -48(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
add t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t2, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -12
slli t1, t1, 2
sub t0, t0, t1
sw t2, 0(t0)
sw t2, -4(sp)
addi sp, sp, -4

I2_1:

I1_1:
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 1
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
add t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -40(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 7
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
slt t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
bne t0, zero, DW1
li t0, 28
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
li a1, 1
jal ra, digitalWrite
li t0, 6
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -12
slli t1, t1, 2
sub t0, t0, t1
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 3
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -12
slli t1, t1, 2
sub t0, t0, t1
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
sub t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
li t0, 1000
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
mul t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
jal ra, delay
li t0, 28
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
li a1, 0
jal ra, digitalWrite
li t0, 5
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -12
slli t1, t1, 2
sub t0, t0, t1
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 1
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -12
slli t1, t1, 2
sub t0, t0, t1
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
sub t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
li t0, 1000
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
mul t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
jal ra, delay
codegen_end:
addi sp, s0, -200
lw ra, 196(sp)
lw s0, 192(sp)
addi sp, sp, 200
jalr zero, 0(ra)
