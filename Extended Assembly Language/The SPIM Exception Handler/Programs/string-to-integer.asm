        .data
prompt: .asciiz "Enter any integer: "
digits: .space  10                    # Reserve 10 bytes for stringified digits.
size:   .word   10                    # Size of the string.
result: .ascii "\nConverted integer: "

        .text
main:
        lw    $t0, size               # Get the maximum size of the input string.

        li    $v0, 4                  # Display the prompt for the user.
        la    $a0, prompt
        syscall

        li    $v0, 8                  # Read the string digits from the user.
        la    $a0, digits
        move  $a1, $t0                # Copy the buffer size of the input string.
        syscall

        ori   $t1, $zero, 0           # Initalize the value to 0.
        la    $t2, digits             # Load the address of the stored user input.

loop:
        lbu   $t3, 0($t2)             # Grab the string at the current pointer.
        nop                           # Load delay.

        beq   $t3, $zero, end         # If end of string is reached, quit.
        nop                           # Branch delay.

        ori   $t8, $zero, 10          # Integral representation of line feed.
        beq   $t3, $t8, end           # If line feed is encountered, quit.
        nop                           # Branch delay.


        ori   $t4, $zero, 10          # Store multipler.
        multu $t1, $t4                # value * 10.
        mflo  $t5
        nop

        sub   $t3, $t3, 0x30          # Convert to integral value from ASCII code.

        add   $t1, $t5, $t3           # value = value*10 + D.

        addi  $t2, $t2, 1             # Point to the next stringified digits.

        j     loop                    # Interate to next positive string integer.
        nop                           # Branch delay.

end:
        li    $v0, 4
        la    $a0, result 
        syscall

        li    $v0, 1                  # Check if converted integer = stringified integer.
        move  $a0, $t1                # Move the converted integer into the argument.
        syscall

        li    $v0, 10                 # End program.
        syscall
