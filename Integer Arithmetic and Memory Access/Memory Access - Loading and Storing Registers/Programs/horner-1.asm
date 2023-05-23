# Evaluate 6x^3 - 3x^2 + 7x + 2
#
# Register Use:
#
# $1 base register, value of x
# $7 value of the polynomial
# $8 temporary register

      .data
x:    .word -1
poly: .word 0

      .text
      .globl main
main:
      lui   $1, 0x1000      # set base register
      lw    $8, 0($1)      # load value of x to $8

      ori   $7, $0, 6       # set coefficient of 1st term in $7

      mult  $8, $7          # multiply 6 and x
      mflo  $7
      sll   $0, $0, 0
      sll   $0, $0, 0

      addiu $7, $7, -3      # add coefficient of the 2nd term

      mult  $8, $7          # multiply by x, 6x^2 - 3x
      mflo  $7
      sll   $0, $0, 0
      sll   $0, $0, 0

      addiu $7, $7, 7       # add coefficient of the 3nd term

      mult  $8, $7          # multiply by x, 6x3 - 3x2 + 7x
      mflo  $7
      sll   $0, $0, 0
      sll   $0, $0, 0

      addiu $7, $7, 2       # add the constant of the polynomial

      lw    $7, 4($1)      # store value of result in 'poly'
