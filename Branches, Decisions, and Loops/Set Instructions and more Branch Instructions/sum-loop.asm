        .text
init:   ori    $8,$0,0        # count = 0
        ori    $1,$0,0        # Initalize accumulator to 0.

test:   sltiu  $9,$8,10       # count < 10
        beq    $9,$0,endLp
        sll    $0,$0,0

        addu   $1,$1,$8       # add the counter to the accumulator.
        addiu  $8,$8,1        # count++ ;
        j      test
        sll    $0,$0,0

endLp:  sll    $0,$0,0        # branch target
