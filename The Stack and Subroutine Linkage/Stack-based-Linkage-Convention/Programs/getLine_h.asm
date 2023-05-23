# getLine -- Get the lines from the user and store it in buffer.
#
# on entry:
#   $a0 -- address of the input buffer.
#   $a1 -- size of the input buffer.

# on exit:
#   no return values
        .globl getLine
        .text
getLine:
        move  $t0, $a0          # Make a copy of the input buffer's address.

        li    $v0, 4            # Prompt the user to enter a string.
        la    $a0, prompt
        syscall

        li    $v0, 8            # Read the user input into the buffer.
        move  $a0, $t0          # Restore the buffer address.
        syscall

        jr    $ra               # Return void.
        nop                     # Branch delay.

        .data
prompt: .asciiz "Enter a string: "

