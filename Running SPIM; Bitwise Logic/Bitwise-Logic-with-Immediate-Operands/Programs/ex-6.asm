    .text
    .globl main
main:
        ori $1,$0,0x7654        # load 0x7654 into $1
        sll $1,$1,16            # move 0x7654 into position
        ori $1,$1,0x3210        # OR 0x3210 into $1 with $1 itself
                                # initial pattern loaded in $1

        srl $8,$1,4             # discard everything right of the 2nd nibble
        sll $8,$8,28            # discard everything left of the 1st nibble
        srl $8,$8,4             # move the last nibble to 7th nibble position

        srl $9,$1,8             # discard everything right of the 3nd nibble
        sll $9,$9,28            # discard everything left of the 1st nibble
        srl $9,$9,8             # move the last nibble to 6th nibble position

        srl $10,$1,12           # discard everything right of the 4th nibble
        sll $10,$10,28          # discard everything left of the 1st nibble
        srl $10,$10,12          # move the last nibble to 5th nibble position

        srl $11,$1,16           # discard everything right of the 5th nibble
        sll $11,$11,28          # discard everything left of the 1st nibble
        srl $11,$11,16          # move the last nibble to 4th nibble position

        srl $12,$1,20           # discard everything right of the 6th nibble
        sll $12,$12,28          # discard everything left of the 1st nibble
        srl $12,$12,20          # move the last nibble to 3rd nibble position

        srl $13,$1,24           # discard everything right of the 7th nibble
        sll $13,$13,28          # discard everything left of the 1st nibble
        srl $13,$13,24          # move the last nibble to 2nd nibble position

        srl $14,$1,28           # discard everything right of the 8th nibble
        sll $14,$14,28          # discard everything left of the 1st nibble
        srl $14,$14,28          # move the last nibble to 1st nibble position
        
        or $2,$2,$8             # replace 7th nibble into register $2
        or $2,$2,$9             # replace 6th nibble into register $2
        or $2,$2,$10            # replace 5th nibble into register $2
        or $2,$2,$11            # replace 4th nibble into register $2
        or $2,$2,$12            # replace 3rd nibble into register $2
        or $2,$2,$13            # replace 2nd nibble into register $2
        or $2,$2,$14            # replace 1st nibble into register $2

