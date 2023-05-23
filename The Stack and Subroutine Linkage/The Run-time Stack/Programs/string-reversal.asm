        .data
string: .space  10
prompt: .asciiz "Enter a string: "
result: .asciiz "The reversed string is: "
LF:     .asciiz "\n"

        .text
main:
        li    $t0, 10             # Set the size of the buffer.

        li    $v0, 4              # Ask the user for a string to be reversed.
        la    $a0, prompt
        syscall

        li    $v0, 8              # Get the string from the user.
        la    $a0, string
        move  $a1, $t0
        syscall

        li    $t0, 0              # Set the counter to 0.

push:
        lbu   $t1, string($t0)    # Grab the character at current index

        beq   $t1, $zero, contLF  # Reverse the string after reaching its end.
        beq   $t1, 10, cont

        subu  $sp, $sp, 4         # Push the current character to the stack.
        sb    $t1, ($sp)

        add   $t0, $t0, 1         # Incrment the counter.

        b     push                # Push the next character to the stack.

contLF:
        li    $v0, 4              # Print the reversed string on a new line.
        la    $a0, LF
        syscall

cont:
        move  $t8, $t0            # Copy the last index.
        li    $t0, 0              # Set the counter to 0.

        li    $v0, 4              # Print the result statement.
        la    $a0, result
        syscall

reverse:
        beq   $t0, $t8, print     # After storing reversed version, print the buffer.

        lb    $t1, ($sp)          # Pop the current character from the stack.
        addu  $sp, $sp, 4

        sb    $t1, string($t0)    # Store the character at current index


        add   $t0, $t0, 1         # Incrment the counter.
        b     reverse             # Reverse the order of the next character.

print:
        li    $v0, 4              # Print the reversed string.
        la    $a0, string
        syscall

        li    $v0, 10
        syscall

