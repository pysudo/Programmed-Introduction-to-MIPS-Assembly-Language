        .data
pairs:
        .word 5                  # number of pairs
        .word 60, 90             # first pair: height, weight
        .word 65, 105
        .word 72, 256
        .word 68, 270
        .word 62, 115

        .text

main:
        lui   $1, 0x1000        # Set $1 with the address of start of data section.
        lw    $2, 0($2)         # Load the array size.
        or    $8, $0, $0        # Initalize the sum of heights to 0.
        or    $9, $0, $0        # Initalize the sum of weights to 0.
        or    $10, $0, $0       # Initalize the counter to 0.

        ori   $1, $1, 4         # Point to the next 4 bytes in memeory.

loop:
        beq   $10, $2, average  # If the array list is exhausted, compute averages.
        sll   $0, $0, 0         # Branch delay.

        lw    $11, 0($1)        # Load the height.
        lw    $12, 4($1)        # Load the height.
        add   $8, $8, $11       # Add the height to the sum of heights.
        add   $9, $9, $12       # Add the weight to the sum of weights.

        addi  $1, $1, 8         # Point to the the next pair.
        addi  $10, $10, 1       # Counter++.

        j     loop              # Compute the next pair.

average:
        div   $8, $2            # Average the heights.
        mflo  $1                # Set $1 with the floored average of heights.
        sll   $0, $0, 0         # Load delay.

        div   $9, $2            # Average the weights.
        mflo  $2                # Set $2 with the floored average of weights.
        sll   $0, $0, 0         # Load delay.

