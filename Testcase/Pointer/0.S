.global codegen

codegen:
addi sp, sp, -200
sw ra, 196(sp)
sw s0, 192(sp)
addi s0, sp, 200
li t0, 42
sw t0, -4(sp)
addi sp, sp, -4
li t0, 53
sw t0, -4(sp)
addi sp, sp, -4
li t0, 2
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
mul t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
sub t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -12(s0) 
addi sp, sp, -4
sw t0, 0(sp)
lw t0, -12(s0)
sw t0, -4(sp)
addi sp, sp, -4
addi sp, sp, 4
addi t0, s0, -12
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -16(s0) 
addi sp, sp, -4
sw t0, 0(sp)
lw t0, -16(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -12(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
li t1, -1
mul t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
li t0, 8
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
div t0, t1, t0
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
sw t1, 0(t0)
sw t1, -4(sp)
addi sp, sp, -4
lw t0, -16(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 4
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
sub t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -12(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -12(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
jal ra, output
lw t0, -16(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
lw a0, 0(sp)
addi sp, sp, 4
jal ra, output
codegen_end:
addi sp, s0, -200
lw ra, 196(sp)
lw s0, 192(sp)
addi sp, sp, 200
jalr zero, 0(ra)
