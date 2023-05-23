    .globl main
    .text

init:
    ori   $1, $0, 500       # Load the limit to which perfect number to be searched.
    or    $8, $0, $0        # Initalize the iterator to 0 in $8.

    lui   $2, 0x1000        # Store the address of the data section in $2.
    sw    $0, 0($2)         # Nullify the address location stored in $2.
    sll   $0, $0, 0

    addi  $1, $1, 1         # $1 = N + 1

searcher:
    or    $3, $2, $0        # Load address stored in $2 to $3 as a reference.
    addi  $8, $8, 1         # $8, X = X + 1

    or    $4, $0, $0
    slt   $4, $8, $1        # $8, iterator <= N? then set $4 = 1.
    beq   $4, $0, end       # If interator is > N, end the program.
    sll   $0, $0, 0

verifier:
    or    $9, $0, $0        # Initalize the probable integer divisor to 0 in $9.
    addi  $10, $8, -1       # $10 = X - 1.

check:
    addi  $9, $9, 1         # Increment the next divisor exclusive of 0.

    or    $4, $0, $0
    slt   $4, $10, $9        # Set $4 = 1, if divisor > (X - 1)?
    bne   $4, $0, nullflag
    sll   $0, $0, 0

    div   $8, $9            # Check if the divisor is perfectly divisible by X.
    mfhi  $4                # Store reminder in $4.
    sll   $0, $0, 0


    bne   $4, $0, check     # If perfectly divisible, reminder should be zero.
    sll   $0, $0, 0

    addi  $3, $3, 4         # Increment to the next 4 byte of free memory.
    sw    $9, 0($3)         # Store the divisor in immediate free memory.
    sll   $0, $0, 0


    j     check             # Check if the next divisor is divisible by X.
    sll   $0, $0, 0

nullflag:                   # Null flag to indicate divisor list is exhausted.
    addi  $3, $3, 4         # Increment to the next 4 byte of free memory.
    sw    $0, 0($3)         # Store null values on the next 4 bytes of memory.
    sll   $0, $0, 0

    addi  $3, $2, 4         # Load the location of 4 bytes after null in $3.
    or    $9, $0, $0        # Initalize the sum to 0 in $9.

sum:
    lw    $10, 0($3)        # Load the value of the valid divisor.
    sll   $0, $0, 0

    beq   $10, $0, verify   # If divisor list is exhausted, verify the sum.
    sll   $0, $0, 0

    add   $9, $9, $10       # Append the sum with current valid divisor.
    addi  $3, $3, 4         # Increment to the next 4 byte of memory.

    j     sum               # Add the next divisor to the sum.
    sll   $0, $0, 0

verify:                     # Verify if sum == X.
    bne   $9, $8, searcher  # If sum == X, it is a perfect number.
    sll   $0, $0, 0

perfect:                    # Store the perfect number in memory.
    sw    $9, 0($2)         # Store the perfect number in reserved memory.
    sll   $0, $0, 0

    addi  $2, $2, 4         # Increment the reserved memeory by 4 bytes.
    sw    $0, 0($2)         # Nullify the address location in $2.
    sll   $0, $0, 0

    j     searcher          # Continue search for the next perfect number.
    sll   $0, $0, 0

end:
    sll   $0, $0, 0

