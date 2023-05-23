    .globl main
    .text
main:
    ori  $8,$0,0x28       # load the variable x in $8.
    ori  $9,$0,0x4        # load the variable y in $9.

    sll  $6,$8,0x1        # shift left $8 by 1 bit into $6 to multiply it by 2.
    sll  $7,$9,0x2        # shift left $9 by 2 bit into $7 to multiply it by 4.

    add  $6,$6,$8         # add variable x to its multiples contained at $8.
    add  $7,$7,$9         # add variable y to its multiples contained at $9.

    sub  $10,$6,$7        # subtract $9 against $8 into $10.
