    .text
    .globl main

main:
        ori $1,$0,0xDEAD       # load pattern into register $1
        sll $1,$1,16           # push the pattern into its correct position
        ori $1,$1,0xBEEF       # load the next pattern into register $1
                               # the pattern is positioned correctly by default
