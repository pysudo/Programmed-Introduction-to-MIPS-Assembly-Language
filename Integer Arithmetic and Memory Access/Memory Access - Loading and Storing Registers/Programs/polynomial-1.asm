# Evaluate 3(x^2) + 5x - 12

# Register Use:
#
# $7 base register, address of x
# $1 value of the polynomial

.data
x:    .word 10
poly: .word 0

    .text
    .globl main
main:
    lui   $7, 0x1000  # set base register at $7

    lw    $1, 0($7)   # put x in the acumulator at $1

    ori   $2, $0, 5   # put first coefficient 5 in $2
    mult  $1, $2      # evalute the 2nd term of the polynomial, lo = 5 * x
    mflo  $2          # push evaluted 2nd term in $2

    ori   $8, $0, 3   # put coefficient of the 1st term 3 in $8

    ori   $3, $0, 12  # put polynomial constant 12 in $3
    sub   $3, $2, $3  # subtract the 2nd term with constant 12

    mult  $1, $1      # evaluate term variable, lo = x * x
    mflo  $2          # push lo in $2
    sll   $0, $0, 0
    sll   $0, $0, 0

    mult  $2, $8      # evalute 1st term of the polynomial 3x^2
    mflo  $1          # extract the 1st term of the polynomial in $1
    sll   $0, $0, 0
    sll   $0, $0, 0

    add   $1, $1, $3  # evalute the rest of the polynomial

    sw    $1, 4($7)   # store the result of the polynomial in $1
