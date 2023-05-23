    .text
    .globl main
main:
        ori $1,$0,0xFACE        # load initial pattern in $1

        ori $8,$0,0xF000        # create a mask for the 4th bit
        ori $9,$0,0x0F00        # create a mask for the 5th bit
        ori $10,$0,0x00F0       # create a mask for the 6th bit
        ori $11,$0,0x000F       # create a mask for the 7th bit

        and $8,$1,$8            # mask in 0xF000 into $8 
        and $9,$1,$9            # mask in 0x0A00 into $9 
        and $10,$1,$10          # mask in 0x00C0 into $10 
        and $11,$1,$11          # mask in 0x000E into $11 

        sll $2,$8,24            # rotate 0xF000 towards right by 2 nibble
        srl $8,$8,8
        or  $8,$2,$8
        
        or $2,$0,$0             # clear $2
        
        srl $2,$10,24           # rotate 0x00C0 towards left by 2 nibble
        sll $10,$10,8
        or  $10,$2,$10
        
        or $2,$0,$0             # clear $2
        
        or $2,$2,$8             # OR $8 with  $2 into $2 itself
        or $2,$2,$9             # OR $9 with  $2 into $2 itself
        or $2,$2,$10            # OR $10 with  $2 into $2 itself
        or $2,$2,$11            # OR $11 with  $2 into $2 itself
        