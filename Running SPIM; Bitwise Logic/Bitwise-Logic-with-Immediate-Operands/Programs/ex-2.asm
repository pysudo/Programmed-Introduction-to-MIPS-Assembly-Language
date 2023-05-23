    .text
    .globl main
main:
        ori $1,$0,0x01
        sll $2,$1,2
        sll $3,$1,3
        sll $4,$1,4
        sll $5,$1,5
        sll $6,$1,6
        sll $7,$1,7
        sll $1,$1,1
