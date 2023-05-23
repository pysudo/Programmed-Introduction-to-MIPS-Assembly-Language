        .text
main:
        li    $s0, 0                # Initalize the sum to 0.

        li    $v0, 4                # Prompt for the value of co-efficient 'u'.
        la    $a0, uInput 
        syscall

        jal   pRead                 # Parse an integer.
        nop                         # Branch delay.

        beq   $v1, 0, printError    # Invalid character, print error and restart.
        nop                         # Branch delay.

        beq   $v1, 2, exit          # If user inputs "done", exit the program.
        nop                         # Branch delay.

        move  $s1, $v0              # Copy the co efficientof 'u'.

        li    $v0, 4                # Prompt for the value of co-efficient 'v'.
        la    $a0, vInput
        syscall

        jal   pRead                 # Parse an integer.
        nop                         # Branch delay.

        move  $s2, $v0              # Copy the co efficientof 'v'.

        beq   $v1, 0, printError    # Invalid character, print error and restart.
        nop                         # Branch delay.

        beq   $v1, 2, printError    # "done" is illegal for co efficient 'v'.
        nop                         # Branch delay.

        li    $a0, 5                # Arguments to compute the first term.
        move  $a1, $s1
        move  $a2, $s1
        jal   threeMul              # 5u^2
        nop                         # Branch delay.

        addu  $s0, $s0, $v0         # 5u^2

        li    $a0, -12              # Arguments to compute the second term.
        move  $a1, $s1
        move  $a2, $s2
        jal   threeMul              # 12uv
        nop                         # Branch delay.

        addu  $s0, $s0, $v0         # 5u^2 - 12uv

        li    $a0, 6                # Arguments to compute the third term.
        move  $a1, $s2
        move  $a2, $s2
        jal   threeMul              # 6v^2
        nop                         # Branch delay.

        addu  $s0, $s0, $v0         # 5u^2 - 12uv + 6v^2

        li    $v0, 4                # Print the result of the equation.
        la    $a0, result
        syscall

        li    $v0, 1
        move  $a0, $s0
        syscall

        li    $v0, 4                # new lines.
        la    $a0, LF
        syscall

        b     main                  # Prompt for another evalution.
        nop                         # Branch delay.

printError:
        li    $v0, 4                # Print error indicating invalid character.
        la    $a0, errMsg
        syscall

        b     main                  # Prompt for another evalution.
        nop                         # Branch delay.

exit:
        li    $v0, 10
        syscall

threeMul:
        mul   $t0, $a0, $a1         # A*X*Y
        mul   $v0, $t0, $a2         # Return the product.

        jr    $ra
        nop

pRead:
        li    $v0, 8                # Get the integer from user if possible.
        la    $a0, strInt
        lw    $a1, size
        nop                         # Load delay.
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

uInput: .asciiz "Enter the value of u: "
vInput: .asciiz "Enter the value of v: "
result: .asciiz "The result of the equation is: "
errMsg: .asciiz "The above character is invalid. Try again.\n\n"
done:   .asciiz "done\n"
LF:     .asciiz "\n\n"
