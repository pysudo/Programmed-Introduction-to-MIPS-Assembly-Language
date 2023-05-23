    .text
    .globl main
main:
        ori $1,$0,0x5555        # load 0x5555 into $1
        sll $1,$1,16            # shift 0x5555 into position
        ori $1,$1,0x5555        # load 0x5555 into $1

        sll $2,$1,1             # shift pattern in $1 left one position into register $2

        or  $3,$1,$2            # OR $1 and $2 into $3
        and $4,$1,$2            # AND $1 and $2 into $4
        xor $5,$1,$2            # XOR $1 and $2 into $5
