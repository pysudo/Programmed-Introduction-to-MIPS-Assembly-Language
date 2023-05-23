# Evaluate the polynomial ax^3 + bx^2 + cx + d
        .data
x:      .word    7
a:      .word   -3
bb:     .word    3
c:      .word    9
d:      .word  -24
result: .word    0

        .text
main:
                            # Store the variables in temporary registers.
        lw    $t0, x
        lw    $t1, a
        lw    $t2, bb
        lw    $t3, c
        lw    $t4, d

        mult  $t0, $t0
        mflo  $t5           # $t5 = x^2
        nop
        nop

        mult  $t5, $t0
        mflo  $t6           # $t6 = x^3
        nop
        nop

        mult  $t1, $t6
        mflo  $t7           # $t7 = ax^3
        nop
        nop

        mult  $t2, $t5
        mflo  $t6           # $t6 = ax^2
        mult  $t3, $t0
        mflo  $t5           # $t5 = cx


        addu  $t4, $t4, $t5 # $t4 = cx + d
        addu  $t4, $t4, $t6 # $t4 = ax^2 + cx + d
        addu  $t4, $t4, $t7 # $t4 = ax^3 + ax^2 + cx + d

        sw    $t4, result   # result = ax^3 + ax^2 + cx + d
        nop

