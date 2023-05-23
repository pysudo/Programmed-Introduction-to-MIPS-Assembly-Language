# Misunderstood problem statement.
        .data
size:
        .word 10
array:
        .word 2, 4, 7, 12, 34, 36, 42, 8, 57, 78

        .text

main:
        ori   $8, $0, 0         # Initalize the source counter to 0 in $8.
        ori   $9, $0, 1         # Initalize the destination counter to 1 in $9.

        lui   $1, 0x1000        # Set $1 with the address of start of data section.
        lw    $3, 0($1)         # Load $2 with the size of the array.
        addi  $1, $1, 4         # Update $1 to be the source pointer.
        addi  $2, $1, 4         # Set $2 as the destination pointer.

        beq   $3, $0, end       # If array size is 0, array is already sorted.
        sll   $0, $0, 0         # Branch delay.
        beq   $3, $9, end       # If array size is 1, array is already sorted.
        sll   $0, $0, 0         # Branch delay.

source:
        lw    $4, 0($1)         # Load $4 with the value of the source pointer.
        sll   $0, $0, 0         # Load delay.

loop:
        beq   $9, $3, next      # Destination counter = array size? proceed next iteration.
        sll   $0, $0, 0         # Branch delay.

        lw    $5, 0($2)         # Load $5 with the value of the destination pointer.
        sll   $0, $0, 0         # Load delay.

        slt   $10, $4, $5       # $10=0, If destination value < source value.
        beq   $10, $0, swap     # If destination value is large, swap with source.
        sll   $0, $0, 0         # Branch delay.

        addi  $2, $2, 4         # Destination pointer points to next element.
        addi  $9, $9, 1         # Destination counter++.

        j     loop              # Next interation.
        sll   $0, $0, 0         # Branch delay.

swap:
        sw    $5, 0($1)         # Replace source with destination.
        sll   $0, $0, 0         # Write delay.
        sw    $4, 0($2)         # Replace destination with source.
        sll   $0, $0, 0         # Write delay.

next:
        addi  $1, $1, 4         # Source pointer points to next element.
        addi  $2, $1, 4         # Destination pointer points to element after source.
        addi  $8, $8, 1         # Source counter++.
        addi  $9, $8, 1         # Destination counter = source counter + 1.

        bne   $8, $3, source    # Source counter = array size? exhasted interations.
        sll   $0, $0, 0         # Branch delay.

end:
        sll   $0, $0, 0         # Target for branch.
