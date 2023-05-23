        .text
main:
        li    $v0, 4                    # Prompt to print either star of rectable.
        la    $a0, prompt
        syscall

        li    $v0, 5                    # Read the user's choice
        syscall

        move  $t0, $v0                  # Copy the user's choice.

        li    $v0, 4                    # Ask the user for the size of pattern.
        la    $a0, size
        syscall

        li    $v0, 5                    # Read the size of the pattern.
        syscall

        beq   $t0, 1, printT            # If user enters '1', print a triangle.
        nop                             # Branch delay.

printR:
        move  $a0, $v0                  # Print a rectangle of specified size.
        jal   rectangle
        nop                             # Branch delay.

        b     exit
        nop                             # Branch delay.

printT:
        move  $a0, $v0                  # Print a triangle of specified size.
        jal   triangle 
        nop                             # Branch delay.

exit:
        li    $v0, 4                    # Skip two lines.
        la    $a0, LF
        syscall

        li    $v0, 10
        syscall

        .data
prompt: .asciiz "Type '1' to print a triangle or enter any key to print a rectangle: "
size:   .asciiz "Enter the size of the shape: "
LF:     .asciiz "\n"


# rectangle -- Prints a rectangle pattern for a given size.
#
# on entry:
#   $a0 -- Size of the pattern.

# on exit:
#   no return values

        .text
rectangle:
        subu  $sp, $sp, 4               # Push the current return address.
        sw    $ra, ($sp)

        move  $s0, $a0                  # Copy of size of the rectangle.
        move  $s1, $a0                  # Initialize the counter to the size.
loopR:
        beq   $s1, $zero, finishR
        

        move  $a0, $s0                  # Get row of stars of given size $s0.
        jal   starline
        nop                             # Branch delay.

        move  $a0, $v0                  # Print the current row of stars.
        li    $v0, 4
        syscall

        subu  $s1, $s1, 1               # Decrement the remaining row to be printed.

        b     loopR
        nop                             # Branch delay.

finishR:
        lw    $ra, ($sp)                # Pop the return address.
        addu  $sp, $sp, 4

        jr    $ra                       # Return after printing pattern.
        nop                             # Branch delay.


# triangle -- Prints a triangle pattern for a given size.
#
# on entry:
#   $a0 -- Size of the pattern.

# on exit:
#   no return values

        .text
triangle:
        subu  $sp, $sp, 4               # Push the current return address.
        sw    $ra, ($sp)

        addu  $s0, $a0, 1               # Set loop condition to size + 1.
        li    $s1, 1                    # Initialize the counter to 1.
loopT:
        beq   $s1, $s0, finishT         # counter > size? return
        

        move  $a0, $s1                  # Get row of stars of given size $s1.
        jal   starline
        nop                             # Branch delay.

        move  $a0, $v0                  # Print the current row of stars.
        li    $v0, 4
        syscall

        addu  $s1, $s1, 1               # Decrement the remaining row to be printed.

        b     loopT
        nop                             # Branch delay.

finishT:
        lw    $ra, ($sp)                # Pop the return address.
        addu  $sp, $sp, 4

        jr    $ra                       # Return after printing pattern.
        nop                             # Branch delay.


# starline -- Prints specified number of '*' character in a row.
#
# on entry:
#   $a0 -- Length of the stars.

# on exit:
#   $v0 -- Address of the string of stars of specified length.

        .text
starline:
        bgt   $a0, 25, error
        addu  $a0, $a0, 1               # Reserve space for newline and null.

        li    $t0, 0                    # Integral equivalent of ASCII null.
        sb    $t0, stars($a0)
        nop                             # Store delay.

        subu  $a0, $a0, 1               # Point to index reserved for newline.

        li    $t0, 10                   # Integral equivalent of ASCII newline.
        sb    $t0, stars($a0)
        
        li    $t1, 42                   # Integral equivalent of ASCII '*'.

loop:
        beq   $a0, $zero, return        # Return if all stars for a row are printed.

        subu  $a0, $a0, 1               # Point to the previous index.
        sb    $t1, stars($a0)           # Add a star at the current index.

        b     loop                      # Print the next star in the reverse order.
        nop                             # Branch delay.

error:
        li    $v0, 0                    # Set the status as error.
        li    $v1, 0
        jr    $ra
        nop                             # Branch delay.


return:
        la    $v0, stars                # Return the address of stars of specified size.
        li    $v1, 0                    # Set the status as success.
        jr    $ra
        nop                             # Branch delay.

        .data
stars:  .space 27

