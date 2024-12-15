.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    # Prologue
    addi sp, sp, -24
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp) #
    sw s3, 16(sp)
    sw s4, 20(sp)

    mv s0, a0  # v0
    mv s1, a1  # v1
    mv s2, a2  # length
    mv s3, a3  # stride0
    mv s4, a4  # stride1

    mv t0, x0  # sum
    mv t1, x0  # index
    mv t2, x0  # offset

    # error check
    li t5, 1
    bge s2, t5, error_check_2 # if s2 >= 1 then error_check_2
    li a1, 75
    jal exit2
error_check_2:
    bge s3, t5, error_check_3 # if s3 >= 1 then error_check_3
    li a1, 76
    jal exit2
error_check_3:
    bge s4, t5, loop_start # if s4 >= 1 then loop_start
    li a1, 76
    jal exit2

loop_start:
    bge t1, s2, loop_end # if t1 >= s2 then loop_end
    slli t2, t1, 2
    mul t3, t2, s3  # v0 offset
    mul t4, t2, s4  # v1 offset

    add t3, s0, t3
    add t4, s1, t4

    lw t3, 0(t3)
    lw t4, 0(t4)

    mul t3, t3, t4
    add t0, t0, t3

    addi t1, t1, 1

    j loop_start  # jump to loop_start


loop_end:
    mv a0, t0

    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp) #
    lw s3, 16(sp)
    lw s4, 20(sp)
    addi sp, sp, 24

    ret
