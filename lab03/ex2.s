.globl main

.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
fun:
    addi t0, a0, 1
    sub t1, x0, a0
    mul a0, t0, t1
    jr ra

main:
    # BEGIN PROLOGUE
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    # END PROLOGUE
    addi t0, x0, 0
    addi s0, x0, 0
    la s1, source
    la s2, dest
loop:
    slli s3, t0, 2
    add t1, s1, s3
    lw t2, 0(t1)
    beq t2, x0, exit
    add a0, x0, t2
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal fun
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8
    add t2, x0, a0
    add t3, s2, s3
    sw t2, 0(t3)
    add s0, s0, t2
    addi t0, t0, 1
    jal x0, loop
exit:
    add a0, x0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    jr ra

# k -> t0
# 在 main 函数中，addi t0, x0, 0 初始化了 k 为 0。之后，t0 用于存储循环变量 k，它在每次循环时通过 addi t0, t0, 1 自增，直到 source[k] == 0 为止。

# sum -> s0
# 在 main 函数开始时，addi s0, x0, 0 将 sum 初始化为 0。每次在循环中计算出 fun(source[k]) 的结果后，sum 会通过 add s0, s0, t2 累加该结果，最终返回累加的值。

# 源数组 source 的地址通过 la s1, source 加载到寄存器 s1 中，s1 用作指向 source 数组的指针。
# 目标数组 dest 的地址通过 la s2, dest 加载到寄存器 s2 中，s2 用作指向 dest 数组的指针。

# 在每次循环时，s3 = k * 4 计算 k 对应的字节偏移量（每个元素4字节）。然后通过 add t1, s1, s3 计算出 source[k] 的地址，lw t2, 0(t1) 用来加载 source[k] 的值。
