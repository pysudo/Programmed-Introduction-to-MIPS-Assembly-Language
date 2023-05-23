        .data
result: .word     0
string1:
        .asciiz   "pUf!) (fi@n"
string2:
        .asciiz   "puf!) (fI@n"

        .text
main:
        ori   $t7, $zero, 0       # Flag to check if first string is compared.
        ori   $t0, $zero, 1       # Initialize the result to 1.
        sw    $t0, result

        la    $t1, string1        # Load the pointer of the first string.
        la    $t2, string2        # Load the pointer of the second string.

loop:
        lb    $t3, 0($t1)          # Load the character of the first string.
        lb    $t4, 0($t2)          # Load the character of the second string.

        beq   $t3, $zero, end     # End program if end a string is reached.
        beq   $t4, $zero, unequal # The length of the strings do not match.
        nop                       # Branch delay.

        slti  $t5, $t3, 97        # Check if character of first is uppercase alphabet.
        move  $t6, $t3            # Duplicate for comparison of lowercase alphabet.
        bne   $t5, $zero, islower
        nop                       # Branch delay.

        ori   $t7, $zero, 1       # First string has been compared.

        slti  $t5, $t4, 97        # Check if character of second is uppercase alphabet.
        move  $t6, $t4            # Duplicate for comparison of lowercase alphabet.
        bne   $t5, $zero, islower
        nop                       # Branch delay.


compare:
        bne   $t3, $t4, unequal   # The two strings are unequal.
        nop                       # Branch delay.

        addiu $t1, $t1, 1         # Point to the next character of first string.
        addiu $t2, $t2, 1         # Point to the next character of second string.

        ori   $t7, $zero, 0       # Reset flag.
        j     loop

islower:
        slti  $t5, $t6, 65        # Set $t5 = 1, if it is a special character.
        bne   $t5, $zero, compare # If $t5 = 0, it is probably uppercase character.
        nop                       # Branch delay.

        slti  $t5, $t6, 91        # Set $t5 = 1, if it is a uppercase alphabet.
        beq   $t5, $zero, compare # Directly compare if either one is a special character.
        nop                       # Branch delay.

        beq   $t7, $zero, tolower1# If first string is not yet compared.
        nop                       # Branch delay.

        addiu $t4, $t4, 32        # Lowercase the character of the second string.

        j     compare             # Compare the two alphabet characters.
        nop                       # Branch delay.

tolower1:
        addiu $t3, $t3, 32        # Lowercase the character of the first string.

        j     compare             # Compare the two alphabet characters.
        nop                       # Branch delay.

unequal:
        sw    $zero, result       # Set result = 0 to indicate string is unequal.
        j     finish
        nop                       # Branch delay.

end:
        bne   $t4, $zero, unequal # Verify if length of the strings match.

finish: nop
