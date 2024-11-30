.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    add t1, a0, x0 # return value
    add t2, a0, x0 # counter
    addi t3, x0, 2 # compare value
loop:
    blt t2, t3, break
    addi t2, t2, -1
    mul t1, t1, t2
    j loop
break:
    add a0, t1, x0
    ret

# int factorial(int n) {
#     int result = n;
#     while (n > 2) {
#         n--;
#         result *= n;
#     }
#     return result;
# }