# Evaluate 17xy - 12x - 6y + 12

# Register Use:
#
# $1 base register, address of x
# $2 value of polynomial
# $3 temporary register
# $7 value of x 
# $8 value of y 

          .data
x:        .word 1
y:        .word 0
answer:   .word 0

          .globl main
          .text
main:
          lui   $1, 0x1000      # set base register at $1

          lw    $7, 0($1)       # load the value of x to $7
          lw    $8, 4($1)       # load the value of y to $8

          ori   $2, $0, 12      # set constant of the polynomial to accumulator

          ori   $3, $0, 12      # set the 2nd term coefficient to $3
          mult  $3, $7          # evaluate the 2nd term
          mflo  $3              # extract the result of the product in $3
          sll   $0, $0, 0
          sll   $0, $0, 0

          subu  $2, $2, $3      # accumulator = 12 - 12x

          ori   $3, $0, 6       # set the 3nd term coefficient to $3
          mult  $3, $8          # evaluate the 2nd term
          mflo  $3              # extract the result of the product in $3
          sll   $0, $0, 0
          sll   $0, $0, 0

          subu  $2, $2, $3      # accumulator = (12 - 12x) - 6y

          ori   $3, $0, 17      # set the 1st term coefficient to $3
          mult  $3, $7          # 17x
          mflo  $7              # $7 = 17x
          sll   $0, $0, 0
          sll   $0, $0, 0

          mult  $7, $8          # 17xy
          mflo  $7              # $7 = 17xy
          sll   $0, $0, 0
          sll   $0, $0, 0

          addu  $2, $2, $7      # 17xy - 12x - 6y + 12

          sw    $2, 8($1)       # load the value of y to $8
