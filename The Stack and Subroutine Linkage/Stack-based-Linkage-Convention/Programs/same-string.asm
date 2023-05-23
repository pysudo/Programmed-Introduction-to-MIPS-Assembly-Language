        .text
main:
        # Subroutine 'getline' to be linked.
        li    $a0, 132          # Length of first buffer.
        jal   twoStrings        # Get the user's inputs into the buffers.
        nop                     # Branch delay.

        move  $a0, $v0          # Address of the first buffer.
        move  $a1, $v1          # Address of the second buffer.
        jal   compare           # Check if both the strings are identical.
        nop                     # Branch delay.

        bne   $v0, $0, identical# If true, print that the strings are identical.
        li    $v0, 4            # Print the status of the two strings.

        la    $a0, nMatch       # Print that the strings are unidentical.
        syscall

        b     exit              # Exit the program.
        nop                     # Branch delay.

identical:
        la    $a0, match        # Print that the strings are identical.
        syscall

exit:
        li    $v0, 10           # No need to store OS control address in stack.
        syscall

        .data
match:  .asciiz "The two strings are identical.\n\n"
nMatch: .asciiz "The two strings are different.\n\n"


# convert -- Get the lines from the user and store it in buffer.
#
# on entry:
#   $a0 -- address of the first buffer.
#   $a1 -- address of the second buffer.

# on exit:
#   $v0 -- Boolean to indicate a match.

        .text
compare:
        lbu   $t0, 0($a0)       # Get the characters at current pointer.
        lbu   $t1, 0($a1)
        nop                     # Load delay.

        bne   $t0, $t1, false   # Check if both the characters are identical.
        beq   $t0, $zero, true  # Check if even character at second buffer is null.


        addu  $a0, $a0, 1       # Point to the next character.
        addu  $a1, $a1, 1

        b     compare           # Compare the next characters.
        nop                     # Branch delay.
true:
        li    $v0, 1            # Two strings are identical.

        jr    $ra               # Return that the two strings are identical.
        nop                     # Branch delay.
false:
        li    $v0, 0            # Two strings being identical is false.

        jr    $ra               # Return that the two strings are unidentical.
        nop                     # Branch delay.

