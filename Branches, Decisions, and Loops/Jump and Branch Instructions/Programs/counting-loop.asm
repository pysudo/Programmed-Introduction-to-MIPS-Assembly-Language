    .text
.main:
    or    $1, $0, $0      # Initialize the accumulator to 0.
    ori   $2, $0, 1       # Initialize the counter to 1.
    ori   $3, $0, 22      # Initialize the limiter to 22 or b10110.

loop:
    beq   $2, $3, exit    # Exit loop if counter equals the conditional limit.
    sll   $0, $0, 0

    add   $1, $1, $2      # Add the counter to the accumulator.
    addi  $2, $2, 1       # Increment the counter by 1.
    j     loop            # Add the next number.
    sll   $0, $0, 0

exit:
    j     exit            # Sponge for excess machine cycles.
    sll   $0, $0, 0

