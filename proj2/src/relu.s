.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)

    mv s0, a0  # s0 is the pointer to the array
    mv s1, a1  # s1 is the # of elements in the array
    mv t0, x0  # t0 is the counter
    mv t1, t0  # t1 is the offset

    li t5, 1
    bge s1, t5, loop_start # if s1 >= 1 then loop_start
    li a1, 78
    jal exit2

loop_start:
    bge t0, s1, loop_end # if t0 >= s1 then loop_end
    slli t1, t1, 2
    add t2, s0, t1  # t2 is s0[t0]
    lw t3, 0(t2)
    bge t3, x0, loop_continue # if t3 >= x0 then continue
    mv t3, x0

loop_continue:
    sw t3, 0(t2)
    addi t0, t0, 1
    mv t1, t0
    j loop_start  # jump to loop_continue


loop_end:
    # Epilogue
    lw ra, 0(sp) #
    lw s0, 4(sp) #
    lw s1, 8(sp) #
    addi sp, sp, 12

	ret
