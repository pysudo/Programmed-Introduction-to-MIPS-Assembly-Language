# read in three integers and print their sum
#
# This program uses simple linkage.
#
# Settings: Load delays  ON;  Branch delays ON
#           Trap file    ON;  Pseudoinstructions ON
#
         .text
         .globl  main

main:
         jal     pread          # read first integer
         nop                    #
         move    $s0,$v0        # save it in $s0

         jal     pread          # read second integer
         nop                    #
         move    $s1,$v0        # save it in $s1

         jal     pread          # read third integer
         nop                    #
         move    $s2,$v0        # save it in $s2

         addu    $s0,$s0,$s1    # compute the sum
         addu    $s3,$s0,$s2    # result in $s3

         li      $v0,4          # print a heading
         la      $a0,heading
         syscall

         move    $a0,$s3        # move sum into parameter
         li      $v0,1          # print the sum
         syscall

         li      $v0,10         # exit
         syscall

         .data
heading:
         .asciiz "The sum is: "
