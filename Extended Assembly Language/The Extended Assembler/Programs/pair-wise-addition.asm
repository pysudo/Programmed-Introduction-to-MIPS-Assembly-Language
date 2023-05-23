        .data
size:   .word 7
array1: .word -30, -23, 56, -43, 72, -18, 71
array2: .word 45, 23, 21, -23, -82, 0, 69
result: .word 0, 0, 0, 0, 0, 0, 0

        .text
main:
        lw    $t0, size         # Load the size of the array. Also act as counter.

        la    $t1, array1       # Load the pointer of the first array.
        la    $t2, array2       # Load the pointer of the second array.
        la    $t3, result       # Load the pointer of the result array.

loop:
        beq   $t0, $zero, end   # End program if the element list is exhausted.
        nop                     # Branch delay.

        lw    $t4, 0($t1)       # Get the element of array1.
        lw    $t5, 0($t2)       # Get the element of array2.
        nop

        addu  $t6, $t4, $t5     # Sum the element from both the arrays.
        sw    $t6, 0($t3)       # Store the sum in result array.

        addiu $t1, $t1, 4       # Point to the next element in array1.
        addiu $t2, $t2, 4       # Point to the next element in array2.
        addiu $t3, $t3, 4       # Point to the next element in result array.
        addiu $t0, $t0, -1      # Decrement the size by 1.

        j     loop              # Get the next element.
        nop                     # Branch delay.

end:    nop
