    .text
.main:
    or    $1, $0, $0      # Initialize the accumulator to 0.
    ori   $2, $0, 1       # Initialize the counter to 1.

loop:
    add   $1, $1, $2      # Add the counter to the accumulator.
    addi  $2, $2, 1       # Increment the counter by 1.
    j     loop            # Add the next number.
    sll   $0, $0, 0
