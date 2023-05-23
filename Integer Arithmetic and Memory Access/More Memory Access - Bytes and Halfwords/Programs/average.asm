# Register Use:
#
# $1 base register
# $2 accumulator
# $3 temporary bits, 0xFFFFFEFF to enforce 8-bit arithmetic addition
      .data
      .byte   12
      .byte   97
      .byte  133
      .byte   82
      .byte  236

      .text
      .globl main
main:
      lui   $1, 0x1000      # set base register

      lbu   $7, 0($1)       # load values to be averaged into seperate register
      lbu   $8, 1($1)
      lbu   $9, 2($1)
      lbu   $10, 3($1)
      lbu   $11, 4($1)

      addu  $2, $7, $8      # 12 + 97
      or    $2, $2, $3      # enforce 8-bit arithmetic addition

      addu  $2, $2, $9      # (12 + 97) + 133
      or    $2, $2, $3      # enforce 8-bit arithmetic addition

      addu  $2, $2, $10     # (12 + 97 + 133) + 82
      or    $2, $2, $3      # enforce 8-bit arithmetic addition

      addu  $2, $2, $11     # (12 + 97 + 133 + 82) + 236
      or    $2, $2, $3      # enforce 8-bit arithmetic addition

      ori   $3, $0, 0x5     # total number of values to be averaged
      div   $2, $3          # evaluate the average
      mflo  $7              # extract quotient in $7
      mfhi  $8
      sll   $0, $0, 0
      sll   $0, $0, 0

      sb    $7, 5($1)       # store the quotient in memory
