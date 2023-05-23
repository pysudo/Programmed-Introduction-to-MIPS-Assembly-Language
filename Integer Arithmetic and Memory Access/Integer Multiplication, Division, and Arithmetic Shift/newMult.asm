## newMult.asm
## 
## Program to calculate 5*x - 74
##
## Register Use:
##  $8   x
##  $9   result

      .text
      .globl  main

main:
      ori   $8,$0,12    # put x into $8
      ori   $9,$0,5     # put 5 into $9
      mult  $8,$9       # $lo = 5x
      mflo  $9          # $9 = 5x
      addiu $9,$9,-74   # $9 = 5x - 74
## End of file
