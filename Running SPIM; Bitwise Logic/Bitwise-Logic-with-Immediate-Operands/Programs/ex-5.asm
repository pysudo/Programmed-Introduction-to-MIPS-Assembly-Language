    .text
    .globl main
main:
        ori $1,$0,0xFACE

        ori $3,$0,0xF000        # create a mask for the 4th bit
        ori $4,$0,0x0F00        # create a mask for the 5th bit
        ori $5,$0,0x00F0        # create a mask for the 6th bit
        ori $6,$0,0x000F        # create a mask for the 7th bit

        and $3,$1,$3            # mask in 0xF000 into $3 
        and $4,$1,$4            # mask in 0x0A00 into $4 
        and $5,$1,$5            # mask in 0x00C0 into $5 
        and $6,$1,$6            # mask in 0x000E into $6 

        srl $3,$3,8             # move the pattern 0xF000 into proper position
        sll $5,$5,8             # move the pattern 0x00C0 into proper position

        or $2,$0,$0             # clear $2
        or $2,$2,$3             # OR $3 with  $2 into $2 itself
        or $2,$2,$4             # OR $4 with  $2 into $2 itself
        or $2,$2,$5             # OR $5 with  $2 into $2 itself
        or $2,$2,$6             # OR $6 with  $2 into $2 itself

