# Evaluate the rational function (3x+7)/(2x+8)

    .text
    .globl main
main:
    addi $1, $0, 1      # put x in $1

    ori   $7, $0, 3     # put coefficient 3 in $7
    ori   $8, $0, 7     # put constant 7 in $8
    mult  $1, $7        # multiply x with constant 3
    mflo  $2            # push the multplied result of 3x in $2
    add   $2, $2, $8    # evalute and store the numerator in $2

    ori   $7, $0, 2     # put coefficient 2 in $7
    ori   $8, $0, 8     # put constant 8 in $8
    mult  $1, $7        # multiply x with constant 2
    mflo  $3            # push the multplied result of 2x in $3
    add   $3, $3, $8    # evalute and store the denominator in $3

    div   $2, $3        # divide the numerator by the denominator
