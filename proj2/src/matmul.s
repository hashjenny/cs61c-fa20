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
    bne a2, a4, prologue # if a2 != a4 then prologue
    li a1, 74
    jal exit2

prologue:


outer_loop_start:




inner_loop_start:












inner_loop_end:




outer_loop_end:


    # Epilogue


    ret
