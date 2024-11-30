.data
.word 2, 4, 6, 8
n: .word 9

.text
main:
    add t0, x0, x0
    addi t1, x0, 1
    la t3, n
    lw t3, 0(t3)
fib:
    beq t3, x0, finish
    add t2, t1, t0
    mv t0, t1
    mv t1, t2
    addi t3, t3, -1
    j fib
finish:
    addi a0, x0, 1
    addi a1, t0, 0
    ecall # print integer ecall
    addi a0, x0, 10
    ecall # terminate ecall

# 1.What do the .data, .word, .text directives mean (i.e. what do you use them for)? Hint: think about the 4 sections of memory.
# .data 用于定义数据段，表示程序中存放静态数据的部分。
# 任何在 .data 段中声明的变量或常量都将存储在内存中，通常用来保存程序运行中需要访问的固定数据。
# .word 用于分配一块内存，并初始化为指定的整数值（每个值通常占用一个字的空间，字大小依赖于系统架构，例如 RISC-V 的字为 4 字节）
# .text 用于定义代码段，表示程序的可执行指令所在部分。任何在 .text 段中声明的内容通常会被加载到内存中，供 CPU 执行。

# 2.Run the program to completion. What number did the program output? What does this number represent?
# 34 0x00000022

# 3.At what address is n stored in memory? Hint: Look at the contents of the registers.
# 0x10000010
