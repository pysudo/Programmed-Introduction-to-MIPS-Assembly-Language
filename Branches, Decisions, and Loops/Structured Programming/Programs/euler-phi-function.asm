    .data
N:
    .word 21
phi:
    .word 0

    .text
main:
    lui   $1, 0x1000        # Set the address of start of data section to $1.
    or    $2, $0, $0        # Initialize phi to 0 and set it $2.
    lw    $3, 0($1)         # Load the integer N to $3.
    ori   $4, $0, 1         # Set the interator divisor to 1 on $8.
    or    $9, $0, $3        # Set the copy of integer N to $9.

countphi:
    or    $8, $0, $4        # Set the copy of iterator trail divisor to $8.
    slt   $5, $8, $9        # If trial divisor, $8 > N, set $5 = 0.
    beq   $5, $0, end

gcd:
    beq   $8, $9, relprime  # $8 and $9 have a common divisor.
    sll   $0, $0, 0

    slt   $10, $8, $9       # If N > M, set $10 = 0.
    beq   $10, $0, greaterN
    sll   $0, $0, 0

    sub   $9, $9, $8        # M = M - N.

    j     gcd
    sll   $0, $0, 0

greaterN:
    sub   $8, $8, $9        # N = N - M.

    j     gcd
    sll   $0, $0, 0

relprime:
    addi  $4, $4, 1         # Increment the trial divisor by 1.
    or    $9, $0, $3        # Set the copy of integer N to $9.

    ori   $11, $0, 1        # Set $11 to literal 1.
    bne   $8, $11, countphi # Both $8 (trial divisor) and $9 (N) are equal.
    sll   $0, $0, 0

    addi  $2, $2, 1         # trial divisor and N are relatively prime.

    j     countphi
    sll   $0, $0, 0

end:
    sw    $2, 4($1)         # Store the phi function in phi.

