.global codegen

codegen:
addi sp, sp, -200
sw ra, 196(sp)
sw s0, 192(sp)
addi s0, sp, 200
li t0, 26
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
li a1, 1
jal ra, digitalWrite
li t0, 1000
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
jal ra, delay
li t0, 26
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
li a1, 0
jal ra, digitalWrite
li t0, 1000
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
