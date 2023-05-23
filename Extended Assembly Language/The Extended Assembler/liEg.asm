## liEg.asm
##
        .text
        .globl  main

main:
        li    $t0,43        #  first  value
        li    $t1,-96       #  second value
        li    $t7,-16772555 #  third  value
        addu  $t0,$t0,$t1   #  add the values
        addu  $t0,$t0,$t7   #  leave result in $t0
