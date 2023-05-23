    .data
N:
    .word 21
M:
    .word 14
GCD:
    .word 0

    .text
init:
    lui   $1, 0x1000        # Set the address of start of data section to $1.
    lw    $8, 0($1)         # Load the first integer N to $8.
    lw    $9, 4($1)         # Load the second integer M to $9.
    sll   $0, $0, 0

main:
    beq   $8, $9, end       # $8 and $9 are a common divisor, store in memory.
    sll   $0, $0, 0

    slt   $2, $8, $9        # If N > M, set $2 = 0.
    beq   $2, $0, greaterN
    sll   $0, $0, 0

    sub   $9, $9, $8        # M = M - N.

    j     main
    sll   $0, $0, 0

greaterN:
    sub   $8, $8, $9        # N = N - M.

    j     main
    sll   $0, $0, 0

end:
    sw    $8, 8($1)         # $8 = $9 = GCD.
    sll   $0, $0, 0

