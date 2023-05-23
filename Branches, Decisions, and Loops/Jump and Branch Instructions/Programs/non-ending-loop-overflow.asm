    .text
.main:
    ori   $8, $0, 1       # Initialize the accumulator to 1.

loop:
    addu  $8, $8, $8      # Add accumulator to itself.
    j     loop            # Add the next number.
    sll   $0, $0, 0
