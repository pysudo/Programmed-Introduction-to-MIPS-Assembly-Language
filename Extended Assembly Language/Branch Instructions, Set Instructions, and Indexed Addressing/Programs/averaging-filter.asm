        .data
size:   .word 12
array:  .word 50, 53, 52, 49, 48, 51, 99, 45, 53, 47, 47, 50
result: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        .text
main:
        li    $t0, 4            # Initalize the counter to 0.
        lw    $t8, size         # Load the size of the array in bytes.
        mul   $t8, $t8, 4
        sub   $t1, $t8, 4       # Size - 1 of elements.

        lw    $t2, array($zero) # Copy the first element to the new array.
        sw    $t2, result($zero)

filter:
        beq   $t0, $t1, next    # Copy the last element after reaching the end.
        lw    $t2, array($t0)   # Initalize the sum to J.

        sub   $t3, $t0, 4       # J - 1
        lw    $t4, array($t3)
        add   $t2, $t2, $t4     # (J - 1) + J

        add   $t3, $t0, 4       # J + 1
        lw    $t4, array($t3)
        add   $t2, $t2, $t4     # (J - 1) + J + (J + 1)

        div   $t3, $t2, 3       # [(J - 1) + J + (J + 1)] / 3

        sw    $t3, result($t0)  # Store the average in the new array.

        add   $t0, $t0, 4       # Move to the next index of the old array.

        b     filter            # Computer the average of the next index.

next:
        lw    $t3, array($t0)   # Copy the last element onto the new array.
        sw    $t3, result($t0)

        li    $v0, 10
        syscall
