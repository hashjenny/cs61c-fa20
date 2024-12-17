.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
error_check_1:
    li t0, 1
    bge a1, t0, error_check_2 # if a1 >= 1 then error_check_2
    li a1, 72
    jal exit2
error_check_2:
    bge a2, t0, error_check_3 # if a1 >= 1 then error_check_3
    li a1, 72
    jal exit2
error_check_3:
    bge a4, t0, error_check_4 # if a4 >= 1 then error_check_4
    li a1, 73
    jal exit2
error_check_4:
    bge a5, t0, error_check_5 # if a5 >= 1 then error_check_5
    li a1, 73
    jal exit2
error_check_5:
    beq a2, a4, prologue # if a2 == a4 then prologue
    li a1, 74
    jal exit2

prologue:
    addi sp, sp, -56
    sw ra, 0(sp) #
    sw s0, 4(sp) #
    sw s1, 8(sp) #
    sw s2, 12(sp) #
    sw s3, 16(sp) #
    sw s4, 20(sp) #
    sw s5, 24(sp) #
    sw s6, 28(sp) #


    mv s0, a0   # m0
    mv s1, a1   # m0 rows
    mv s2, a2   # m0 cols
    mv s3, a3   # m1
    mv s4, a4   # m1 rows
    mv s5, a5   # m1 cols
    mv s6, a6

    mv t0, x0  # counter1
    mv t1, x0  # counter2
    mv t2, x0  # m0 row offset
    mv t3, x0  # m1 col offset
    mv t5, x0  # s6 counter
    mv t6, x0  # s6 offset

outer_loop_start:
    bge t0, s1, outer_loop_end # if t0 >= s1 then outer_loop_end
    slli t2, t2, 2
    mul t2, t2, s2
    add t2, s0, t2


inner_loop_start:
    bge t1, s2, inner_loop_end # if t1 >= s2 then inner_loop_end
    slli t3, t3, 2
    add t3, s3, t3

# run dot
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
    sw t0, 32(sp)
    sw t1, 36(sp)
    sw t2, 40(sp)
    sw t3, 44(sp)
    sw t4, 48(sp)
    sw t5, 52(sp)

    mv a0, t2
    mv a1, t3
    mv a2, s2
    li a3, 1
    mv a4, s5
    jal ra, dot  # jump to dot and save position to ra

    lw t0, 32(sp)
    lw t1, 36(sp)
    lw t2, 40(sp)
    lw t3, 44(sp)
    lw t4, 48(sp)
    lw t5, 52(sp)

    # save result to s6[i]
    mv t6, t5
    slli t6, t6, 2
    add t6, s6, t6
    sw a0, 0(t6)
    addi t5, t5, 1

    addi t1, t1, 1
    mv t3, t1
    j inner_loop_start  # jump to inner_loop_start


inner_loop_end:
    mv t1, x0
    mv t3, x0

    addi t0, t0, 1
    mv t2, t0
    j outer_loop_start  # jump to outer_loop_start


outer_loop_end:

    # Epilogue
    lw ra, 0(sp) #
    lw s0, 4(sp) #
    lw s1, 8(sp) #
    lw s2, 12(sp) #
    lw s3, 16(sp) #
    lw s4, 20(sp) #
    lw s5, 24(sp) #
    lw s6, 28(sp) #
    addi sp, sp, 56

    ret
