    .data
N:
    .word     223
isprime:
    .word     0

    .text

init:
    lui   $1, 0x1000        # Set the starting address of the data section.
    ori   $8, $0, 1         # Set $8 with literal 1.
    sw    $8, 4($1)         # Flip 'isprime' to 1.

main:
    lw    $9, 0($1)         # Load number to verify from address in $1 to $8.
    ori   $3, $0, 2         # Set the literal 2 in $3.
    or    $1, $0, $9        # Set N to $1.

    div   $9, $3            # Divide the number to be verified by 2.
    mflo  $2                # Store the quotient in $2. Only it's floor, ignore reminder.

    ori   $8, $0, 2         # Initalize the iterator divisor $8 to 2.

test:
    slt   $3, $2, $8        # If (N / 2) < divisor, set $4 = 1.
    bne   $3, $0, cont      # If $4 = 1, break loop.

    div   $1, $8            # Divide N by divisor in $8.
    mfhi  $9                # Grab reminder to $9.
    sll   $0, $0, 0

    beq   $9, $0, composite # If the reminder is 0, then N is composite number.

    addi  $8, $8, 1         # Increment the divisor by 1.
    j     check             # Check if the next divisor is divisible by N.
    sll $0, $0, 0

composite:
    lui   $1, 0x1000        # Set the starting address of the data section.
    sw    $0, 4($1)         # Reset isprime to 0 to indicate that N is not a prime number.

cont:
    sll $0, $0, 0

