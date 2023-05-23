    .text

init:
    or    $8, $0, $0      # Initialize sum of all numbers.
    or    $9, $0, $0      # Initialize sum of odds.
    or    $10, $0, $0     # Initialize sum of evens.
    
    ori   $1, $0, 1       # Initialize loop control variable for all numbers.
    ori   $2, $0, 1       # Initialize counter for odds.
    ori   $3, $0, 2       # Initialize counter for evens.

all:
    sltiu $4, $1, 101     # Set $4 to 1 if the counter for all numbers exceed 100.
    beq   $4, $0, exit    # Skip to end if all numbers counter is less than 100.
    sll   $0, $0, 0

    add   $8, $8, $1      # Add the current term for all numbers in $8.
    addi  $1, $1, 1       # Increment counter by 1.

odd:
    sltiu $4, $3, 101     # Set $4 to 1 if the counter for odds exceed 100.
    beq   $4, $0, even    # Counter exceeds 100, skip to even.
    sll   $0, $0, 0

    add   $9, $9, $2      # Add the current term for odd numbers in $9.
    addi  $2, $2, 2       # Increment counter by 2.

even:
    sltiu $4, $3, 101     # Set $4 to 1 if the counter for evens exceed 100.
    beq   $4, $0, all     # Counter exceeds 100, loop back to all.
    sll   $0, $0, 0

    add   $10, $10, $3    # Add the current term for even numbers in $10.
    addi  $3, $3, 2       # Increment counter by 2.

    j     all

exit:
    sll   $0, $0, 0
