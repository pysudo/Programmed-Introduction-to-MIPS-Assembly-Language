    .globl main
    .text
main:
    addi  $8,$0,-0x1       # load the variable x in $8.
    sll   $10,$8,0x3      # multiply $8 by 8. 

    add   $10,$10,$8      # add $8 to its composite in $9. 
    add   $10,$10,$8
    add   $10,$10,$8
    add   $10,$10,$8
    add   $10,$10,$8

    sub   $11,$0,$10      # inverse the sign.
