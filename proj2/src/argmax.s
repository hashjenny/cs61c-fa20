.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:
    # Prologue
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)

    mv s0, a0  # array
    mv s1, a1  # array size
    mv t0, x0  # current index
    mv t1, x0  # array offset
    lw t2, 0(s0)  # largest value
    mv t3, x0  # the index of largest value

    # error check
    li t6, 1
    bge s1, t6, loop_start # if s1 >= 1 then loop_start
    li a1, 77
    jal exit2

loop_start:
    bge t0, s1, loop_end # if t0 >= s1 then loop_end
    slli t1, t1, 2
    add t4, s0, t1
    lw  t5, 0(t4)  # current value
    blt t5, t2, loop_continue # if t5 < t2 then loop_continue
    mv t2, t5
    mv t3, t0

loop_continue:
    addi t0, t0, 1
    mv t1, t0
    j loop_start  # jump to loop_continue


loop_end:
    mv a0, t3

    # Epilogue
    lw ra, 0(sp) #
    lw s0, 4(sp) #
    lw s1, 8(sp) #
    addi sp, sp, 12

    ret
