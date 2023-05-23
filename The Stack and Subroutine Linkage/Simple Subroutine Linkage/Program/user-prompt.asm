        .text
main:
        li    $s0, 0                # Initalize the sum to 0.

loop:
        jal   pRead                 # Prompt an integer for summation.

        beq   $v1, 1, loop          # Cannot sum character that cannot be parsed as int.
        nop                         # Branch delay.

        addu  $s0, $s0, $v0         # Add the input to the existing sum.

        beq   $v1, 2, printSum
        nop                         # Branch delay.

        b     loop                  # Ask the user for another integer.
        nop                         # Branch delay.

printSum:
        li    $v0, 4                # Print the sum of the integers.
        la    $a0, sum
        syscall

        li    $v0, 1
        move  $a0, $s0              # Copy the sum of integers.
        syscall

        b     exit                  # End the program.
        nop                         # Branch delay.

exit:
        li    $v0, 10
        syscall

pRead:
        li    $v0, 4                # Prompt the user to enter an integer.
        la    $a0, prompt
        syscall

        li    $v0, 8                # Get the integer from user if possible.
        la    $a0, strInt
        lw    $a1, size
        syscall

        li    $t0, 0                # Initalize the index to 0.
        li    $t8, 0                # Initalize the negative flag of integer to 0.

        lbu   $t1, strInt($t0)      # Get the first character of user input.
        nop                         # Load delay.

        beq   $t1, 100, finish      # Check if user implies to end the summation.
        nop                         # Branch delay.

        bne   $t1, 45, positive     # First character is not a negative sign.
        nop                         # Branch delay.

negative:
        li    $t8, 1                # Activate the negative flag.
        addu  $t0, $t0, 1           # Incrment the index by 1.

positive:
        li    $t2, 0                # Initalize the psuedo integer buffer to 0.

parse:                              # Try to convert the string to an integer.
        lbu   $t1, strInt($t0)      # Grab plausibe integer at the current index.
        nop                         # Load delay.

        beq   $t1, $zero, return    # Return parsed integer upon reachiing end of string.
        beq   $t1, 10, return
        nop                         # Branch delay.

        mul   $t2, $t2, 10          # Make room for the next integer to its right.

        blt   $t1, 48, error        # ASCII integral < 48, char cannot be parsed as int.
        bgt   $t1, 57, error        # ASCII integral < 57, char cannot be parsed as int.

        subu  $t3, $t1, 48          # Convert ASCII integer to its actual value.
        addu  $t2, $t2, $t3         # Append the integer to the psuedo buffer.

        addu  $t0, $t0, 1           # Incrment the index by 1.

        b     parse                 # Parse the next character of the string.
        nop                         # Branch delay.

return:
        move  $v0, $t2              # Return the parsed integer.

        beq   $t8, 0, cont          # Check if a sign needs to be flipped.
        nop                         # Branch delay.
        mul   $v0, $v0, -1          # Flip the sign.

cont:
        li    $v1, 1                # Flag the string as converted.

        jr    $ra                   # Return end summation indicator.
        nop                         # Branch delay.

finish:
        addu  $t0, $t0, 1           # Incrment the index by 1.

        lbu   $t1, strInt($t0)      # Grab char of plausibe string "done" at current index.
        lbu   $t2, done($t0)        # Grab char at current index of string "char"
        nop                         # Load delay.

        beq   $t1, $zero, endSum    # At end of string, check if user implies to end sum.
        nop                         # Branch delay.

        bne   $t1, $t2, error       # Input string != "done".
        nop                         # Branch delay.

        b     finish                # Compare the next character.
        nop                         # Branch delay.

endSum:
        bne   $t0, 5, error         # Substrings of "done" from index 0 is not allowed.

        li    $v0, 0
        li    $v1, 2

        jr    $ra                   # Return end summation indicator.
        nop                         # Branch delay.

error:
        li    $v0, 0
        li    $v1, 0

        jr    $ra                   # Return failure.
        nop                         # Branch delay.

        .data
strInt: .space 128
size:   .word 128

prompt: .asciiz "Enter an integer: "
sum:    .asciiz "The sum of the integers is: "
done:   .asciiz "done\n"
