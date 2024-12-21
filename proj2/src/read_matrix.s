.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88.
# - If you receive an fopen error or eof,
#   this function terminates the program with error code 90.
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 92.
# ==============================================================================
read_matrix:

    # Prologue
	addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)


    mv s0, a0  # filename
    mv s1, a1  # a pointer to row
    mv s2, a2  # a pointer to col

    # fopen
    mv a1, s0
    li a2, 0
    jal ra, fopen
    li t5, -1
    bne a0, t5, success_fopen
    li a0, 90
    jal exit2
success_fopen:
    mv s3, a0  # file descriptor

# =====================
    # malloc 8 bytes
    li a0, 8
    jal ra, malloc
    bne a0, x0, success_malloc
    li a0, 88
    jal exit2
success_malloc:
    mv s4, a0  # malloc memory

    # fread
    mv a1, s3
    mv a2, s4
    li a3, 8
    jal ra, fread
    li t4, 8  # temp value
    beq a0, t4, success_fread
    li a0, 91
    jal exit2
success_fread:
    lw t1, 0(s4)  # row
    lw t2, 4(s4)  # col
    mul t3, t1, t2
    li t4, 4
    mul t3, t3, t4  # total bytes
    mv s5, t3
# =====================

# =====================
    # malloc total bytes
    mv a0, s5
    jal ra, malloc
    bne a0, x0, success_malloc2
    li a0, 88
    jal exit2
success_malloc2:
    mv s4, a0  # malloc memory

    # fread total bytes
    mv a1, s3
    mv a2, s4
    mv a3, s5
    jal ra, fread
    beq a0, s5, success_fread2
    li a0, 91
    jal exit2
success_fread2:

# =====================

# =====================
    # fclose
    mv a1, s3
    jal ra, fclose
    beq a0, x0, success_fclose
    li a0, 92
    jal exit2
success_fclose:
# =====================

    mv a0, s4

    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28

    ret
