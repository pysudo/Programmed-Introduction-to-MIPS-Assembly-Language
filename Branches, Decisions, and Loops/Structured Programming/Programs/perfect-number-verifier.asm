    .globl main

    .data
N:
    .word      6
isperfect:
    .word      0

    .text
main:
    lui   $4, 0x1000        # Initalize the memory location of the data section.
    lw    $1, 0($4)         # Load the number to be verified to $1.
    sll   $0, $0, 0

    or    $8, $0, $0        # Initalize the probable integer divisor to 0 in $8.

    addi  $2, $4, 8         # Store immediate free address of the data section to $2.

condition:
    addi  $9, $1, -1        # $9 = N - 1.

check:
    addi  $8, $8, 1         # Increment the next divisor exclusive of 0.

    slt   $3, $9, $8        # Set $3 = 1, if divisor > (N - 1)?
    bne   $3, $0, nullflag
    sll   $0, $0, 0

    div   $1, $8            # Check if the divisor is perfectly divisible by N.
    mfhi  $3                # Store reminder in $3.
    sll   $0, $0, 0


    bne   $3, $0, check     # If perfectly divisible, reminder should be zero.
    sll   $0, $0, 0

    sw    $8, 0($2)         # Store the divisor in immediate free memory.
    sll   $0, $0, 0

    addi  $2, $2, 4         # Increment to the next 4 byte of free memory.

    j     check             # Check if the next divisor is divisible by N.
    sll   $0, $0, 0

nullflag:                   # Null flag to indicate divisor list is exhausted.
    addi  $2, $2, 4         # Increment to the next 4 byte of free memory.
    sw    $0, 0($2)         # Store null values on the next 4 bytes of memory.
    sll   $0, $0, 0

    addi  $2, $4, 8         # Load the location of 4 bytes after 'isperfect'.
    or    $8, $0, $0        # Initalize the sum to 0 in $8.

sum:
    lw    $9, 0($2)         # Load the value of the valid divisor.
    sll   $0, $0, 0

    beq   $9, $0, verify    # If divisor list is exhausted, verify the sum.
    sll   $0, $0, 0

    add   $8, $8, $9        # Append the sum with current valid divisor.
    addi  $2, $2, 4         # Increment to the next 4 byte of memory.

    j     sum               # Add the next divisor to the sum.
    sll   $0, $0, 0

verify:                     # Verify if sum == N.
    addi  $2, $4, 4         # Load the location of 4 bytes after 'isperfect' to $2.
    sw    $0, 0($2)         # Initalize 'isperfect' to be false.

    bne   $8, $1, end       # If sum == N, it is a perfect number.
    sll   $0, $0, 0

perfect:
    ori   $9, $0, 0x1       # Load a true flag in $9.
    sw    $9, 0($2)         # Set 'isperfect' to true.

end:
    sll   $0, $0, 0
