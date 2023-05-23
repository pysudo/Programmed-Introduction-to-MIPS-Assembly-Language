    .text

init:
    ori   $8, $0, 0x0029      # Initialize register to find its siginificant bits.
    sll   $8, $8, 16
    ori   $8, $8, 0x8D7D 

    ori   $9, $0, 0           # Set the siginificant bit counter in $9.

loop:
    beq   $8, $0, exit        # Break out of the loop if $8 = 0.
    sll   $0, $0, 0

    srl   $8, $8, 1           # Eliminate each siginificant bit in $8 to the right.
    addi  $9, $9, 1           # Count each siginificant bit eliminated.

    j     loop

exit:
    sll   $0, $0, 0

