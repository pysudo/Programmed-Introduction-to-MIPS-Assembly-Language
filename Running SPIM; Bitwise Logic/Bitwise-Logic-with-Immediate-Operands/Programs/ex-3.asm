    .text
    .globl main
main:
        ori $1,$0,0x01        # load 0x01 into register $1
                
        sll $2,$1,2           # shift $1 by 2 bits into $1

        or  $1,$1,$2          # OR $1 and $2 into $1 to create 4 alternate bits
        sll $2,$1,4           # shift $1 by 4 bits into $1

        or  $1,$1,$2          # OR $1 and $2 into $1 to create 8 alternate bits
        sll $2,$1,8           # shift $1 by 8 bits into $1

        or  $1,$1,$2          # OR $1 and $2 into $1 to create 16 alternate bits
        sll $2,$1,16          # shift $1 by 16 bits into $1

        or  $1,$1,$2          # OR $1 and $2 into $1 to create 32 alternate bits

        sll $2,$1,1           # shift $1 by 1 bit into $2
                              # this enables $1 and $2 to have alternative set of bits with different states
        
        or $1,$1,$2           # OR $1 and $2 to set every bit into $1

