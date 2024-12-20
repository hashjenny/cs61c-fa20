1. While you’re in a gdb session, how do you set the arguments that will be passed to the program when it’s run?
`set args arg1 arg2 ... argn`
2. How do you create a breakpoint?
`b line_number` or `break line_number`
3. How do you execute the next line of C code in the program after stopping at a breakpoint?
`next` or `n`
4. If the next line of code is a function call, you’ll execute the whole function call at once if you use your answer to #3. (If not, consider a different command for #3!) How do you tell GDB that you want to debug the code inside the function (i.e. step into the function) instead? (If you changed your answer to #3, then that answer is most likely now applicable here.)
`step` or `s`
5. How do you continue the program after stopping at a breakpoint?
continue / c
6. How can you print the value of a variable (or even an expression like 1+2) in gdb?
`print 1 + 2` or `p 1 + 2`
`print var1`
`display var1`
7. How do you configure gdb so it displays the value of a variable after every step?
`display var`
`undisplay var`
8. How do you show a list of all variables and their values in the current function?
`info locals`
9. How do you quit out of gdb?
`quit` or `q`