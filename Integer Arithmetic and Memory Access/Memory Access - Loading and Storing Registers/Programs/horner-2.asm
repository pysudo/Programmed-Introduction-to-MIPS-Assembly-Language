# Evaluate ax3 + bx2 + cx + d
#
# Register Use:
#
# $1 base register, value of x
# $7 value of the polynomial
# $8 temporary register

      .data
x:    .word 1
a:    .word -3
b:    .word 3
c:    .word 9
d:    .word -24
poly: .word 0

      .text
      .globl main
main:
      lui   $1, 0x1000      # set base register

      lw    $8, 0($1)       # load value of x to $8
      lw    $9, 4($1)       # load value of a to $9
      lw    $10, 8($1)      # load value of b to $10
      lw    $11, 12($1)     # load value of c to $11
      lw    $12, 16($1)     # load value of d to $12

      mult  $8, $9          # multiply 6 and x
      mflo  $7
      sll   $0, $0, 0
      sll   $0, $0, 0

      addu  $7, $7, $10     # add coefficient of the 2nd term

      mult  $8, $7          # multiply by x, 6x^2 - 3x
      mflo  $7
      sll   $0, $0, 0
      sll   $0, $0, 0

      addu  $7, $7, $11     # add coefficient of the 3nd term

      mult  $8, $7          # multiply by x, 6x3 - 3x2 + 7x
      mflo  $7
      sll   $0, $0, 0
      sll   $0, $0, 0

      addu  $7, $7, $12     # add the constant of the polynomial

      lw    $7, 4($1)       # store value of result in 'poly'
