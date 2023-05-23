
        .text
main:
        # Subroutine 'getline' to be linked.
        li    $a0, 132          # Length of first buffer.
        jal   twoStrings        # Get the user's inputs into the buffers.
        nop                     # Branch delay.

        move  $s0, $v0          # Copy the address of the first buffer.
        move  $s1, $v1          # Copy the address of the second buffer.

        move  $a0, $v0          # Address of the first buffer.
        move  $a1, $v1          # Address of the second buffer.
        jal   compare           # Check if both the strings are identical.
        nop                     # Branch delay.

        move  $s2, $v0          # Copy the address of the third indicator string.

        li    $v0, 4            # Print all three strings.

        move  $a0, $s0
        syscall

        move  $a0, $s1
        syscall

        move  $a0, $s2
        syscall

        la    $a0, LF           # Skip two lines.
        syscall

        li    $v0, 10           # No need to store OS control address in stack.
        syscall

        .data
LF:     .asciiz "\n\n"

# convert -- Get the lines from the user and store it in buffer.
#
# on entry:
#   $a0 -- address of the first buffer.
#   $a1 -- address of the second buffer.

# on exit:
#   $v0 -- Address of the strings with positional indicator.

        .text
compare:
        li    $t0, 0            # Set the index to 0.

loop:
        lbu   $t1, 0($a0)       # Get the characters at current pointer.
        lbu   $t2, 0($a1)

        beq   $t1, $0, check2   # Check if characters at second buffer is null.
        beq   $t1, 10, check2   # Check if characters at second buffer is  newline.
        nop                     # Branch delay.

        beq   $t2, $0, check1   # Check if characters at second buffer is null.
        beq   $t2, 10, check1   # Check if characters at second buffer is newline.
        nop                     # Branch delay.

        bne   $t1, $t2, false   # Check if both the characters are identical.

        li    $t3, 95           # Integral ASCII value for whitespace.
        sb    $t3, str($t0)     # Store whitespace at the current index.

increment:
        addu  $a0, $a0, 1       # Point to the next character.
        addu  $a1, $a1, 1
        addu  $t0, $t0, 1       # Increment the index by 1.

        b     loop              # Compare the next characters.
        nop                     # Branch delay.

false:
        li    $t3, 42           # Integral ASCII value for '*'.
        sb    $t3, str($t0)     # Store '*' character at the current index.

        b     increment         # Point to the next index.
        nop                     # Branch delay.

check1:
        beq   $t1, $0, return   # Check if first string is also terminated.
        beq   $t1, 10, return

        move  $t1, $a0          # If not, first string length > second string.

        b     fillstar          # Check if next character in first buffer is null.
        nop                     # Branch delay.

check2:
        beq   $t2, $0, return   # Check if second string is also terminated.
        beq   $t2, 10, return

        move  $t1, $a1          # If not, second string length > first string.

fillstar:
        lbu   $t2, 0($t1)       # Get the current character of the lengthy string.
        nop                     # Load delay.

        beq   $t2, $0, return   # Return after terminating characters.
        beq   $t2, 10, return

        li    $t3, 42           # Integral ASCII value for '*'.
        sb    $t3, str($t0)     # Store '*' character at the current index.

        addu  $t1, $t1, 1       # Increment the index of excess string by 1.
        addu  $t0, $t0, 1       # Increment the index of indicator string by 1.

        b     fillstar          # Append '*' the the remaining spaces.

return:
        li    $t3, 0            # Integral ASCII value for null.
        sb    $t3, str($t0)     # Store null character at the current index.

        la    $v0, str          # Return the address of the indicator string.
        jr    $ra
        nop                     # Branch delay.

        .data
str:    .space 123

