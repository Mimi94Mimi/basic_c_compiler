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
sw t0, -80(s0)
sw t0, -4(sp)
addi sp, sp, -4
F1_0:
lw t0, -80(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 17
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
slt t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
bne t1, zero, F1_2
j F1_3

F1_1:
lw t0, -80(s0)
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
sw t0, -80(s0)
sw t0, -4(sp)
addi sp, sp, -4
j F1_0

F1_2:
lw t0, -80(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -80(s0)
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
j F1_1

F1_3:
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -84(s0) 
addi sp, sp, -4
sw t0, 0(sp)
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -80(s0)
sw t0, -4(sp)
addi sp, sp, -4
F2_0:
lw t0, -80(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 17
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
slt t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
bne t1, zero, F2_2
j F2_3

F2_1:
lw t0, -80(s0)
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
sw t0, -80(s0)
sw t0, -4(sp)
addi sp, sp, -4
j F2_0

F2_2:
addi t0, s0, -12
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -80(s0)
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
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -156(s0) 
addi sp, sp, -4
sw t0, 0(sp)
lw t0, -84(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -160(s0) 
addi sp, sp, -4
sw t0, 0(sp)
lw t0, -160(s0)
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
or t2, t2, t3
sw t2, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -164(s0) 
addi sp, sp, -4
sw t0, 0(sp)
W3:
lw t0, -164(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
beq t0, zero, EW3
lw t0, -160(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 1
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
sub t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
li t0, 2
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
div t0, t1, t0
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -168(s0) 
addi sp, sp, -4
sw t0, 0(sp)
lw t0, -168(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -88
slli t1, t1, 2
sub t0, t0, t1
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -156(s0)
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
slt t0, t0, t1
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
beq t0, zero, I4_0
addi t0, s0, -88
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -160(s0)
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
addi t0, s0, -88
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -168(s0)
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
lw t0, 0(sp)
addi sp, sp, 4
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
sw t1, 0(t0)
sw t1, -4(sp)
addi sp, sp, -4
lw t0, -168(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -160(s0)
sw t0, -4(sp)
addi sp, sp, -4
j I4_1

I4_0:
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -164(s0)
sw t0, -4(sp)
addi sp, sp, -4

I4_1:
lw t0, -160(s0)
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
beq t0, zero, I5_0
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
sw t0, -164(s0)
sw t0, -4(sp)
addi sp, sp, -4
j I5_1

I5_0:

I5_1:
j W3

EW3:
lw t0, -160(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, -156(s0)
sw t0, -4(sp)
addi sp, sp, -4
lw t0, 0(sp)
addi sp, sp, 4
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
lw t2, 0(sp)
addi sp, sp, 4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -88
slli t1, t1, 2
sub t0, t0, t1
sw t2, 0(t0)
sw t2, -4(sp)
addi sp, sp, -4
lw t0, -84(s0)
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
sw t0, -84(s0)
sw t0, -4(sp)
addi sp, sp, -4
j F2_1

F2_3:
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -88
slli t1, t1, 2
sub t0, t0, t1
lw t0, 0(t0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 2
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -88
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
lw a0, 0(sp)
addi sp, sp, 4
jal ra, output
lw t0, -84(s0)
sw t0, -4(sp)
addi sp, sp, -4
li t0, 0
sw t0, -4(sp)
addi sp, sp, -4
lw t1, 0(sp)
addi sp, sp, 4
addi t0, s0, -88
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
lw a0, 0(sp)
addi sp, sp, 4
jal ra, output
codegen_end:
addi sp, s0, -200
lw ra, 196(sp)
lw s0, 192(sp)
addi sp, sp, 200
jalr zero, 0(ra)
