        .data
size:
        .word 8
array:
        .word 23, -12, 45, -32, 52, -72, 8, 13

        .text

init:
        lui   $1, 0x1000        # Set the starting address of the data section to $1.

        lw    $4, 0($1)         # Load the array size to $4.
        ori   $5, $0, 0         # Initalize array element counter to 0.

        ori   $1, $1, 4         # Increment to the next 4 bytes in $1.
        lw    $2, 0($1)         # Initalize first value at address $1 to be maximum.
        ori   $1, $1, 4         # Increment to the next 4 bytes in $1.
        or    $3, $0, $2        # Copy value of $2 to be minimum.

loop:
        beq   $4, $5, end       # If array elements are exhasted, end program.
        sll   $0, $0, 0         # Branch delay.

        lw    $8, 0($1)         # Load the next intergal value to $8.
        sll   $0, $0, 0         # Load delay.

        slt   $9, $3, $8        # If $8 lesser than the current minimum, set $9=0.
        beq   $9, $0, newmin    # If current minimum is large, current minimum = $8
        sll   $0, $0, 0         # Branch delay.

        slt   $9, $8, $2        # If $8 lesser than the current maximum, set $9=0.
        beq   $9, $0, newmax    # If current maximum is small, current maximum= $8
        sll   $0, $0, 0         # Branch delay.

        j     next              # No new maximum or minimum.
        sll   $0, $0, 0         # Branch delay.

newmin:
        or    $3, $0, $8        # Value in $8 is the new current minimum.

        j     next              # Point to the next 4 bytes of memory.
        sll   $0, $0, 0         # Branch delay.

newmax:
        or    $2, $0, $8        # Value in $8 is the new current maximum.

next:
        addi  $1, $1, 4         # Grab the next 4 bytes of the data section.
        addi  $5, $5, 1         # array element counter++.

        j     loop              # Compare the next element of the array.
        sll   $0, $0, 0         # Branch delay.

end:
        sll   $0, $0, 0         # Target for branch.

