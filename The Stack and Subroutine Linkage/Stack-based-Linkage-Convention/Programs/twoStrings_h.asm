# twoStrings -- Get two strings of a specified buffer size.
#
# on entry:
#   $a0 -- size of the buffer.

# on exit:
#   $v0 -- Address of the first string in a buffer.
#   $v1 -- Address of the second string in a buffer.

        .globl twoStrings
        .text
twoStrings:
        subu  $sp, $sp, 4       # Push the return address.
        sw    $ra, ($sp)

        move  $a1, $a0          # Copy the size of the buffer.

        # Subroutine 'getline' to be linked.
        la    $a0, str1         # Address of first buffer.
        li    $a1, 132          # Length of first buffer.
        jal   getLine           # Get the user's input into the first buffer.
        nop                     # Branch delay.


        la    $a0, str2         # Address of second buffer.
        li    $a1, 132          # Length of second buffer.
        jal   getLine           # Get the user's input into the second buffer.
        nop                     # Branch delay.


        lw    $ra, ($sp)        # Pop the return address.
        addu  $sp, $sp, 4

        la    $v0, str1         # Address of first buffer.
        la    $v1, str2         # Address of second buffer.

        jr    $ra               # Return the two strings.
        nop                     # Branch delay.

        .data
str1:   .space 132
str2:   .space 132

