        .data
string: .space  10
vowels: .byte 'a', 'e', 'i', 'o', 'u'

prompt: .asciiz "Enter a string: "
result: .asciiz "The consonant version of the string is: "
LF:     .asciiz "\n"

        .text
main:
        li    $t8, 0              # Initalize the new line flag to 0.
        li    $t0, 10             # Set the size of the buffer.

        li    $v0, 4              # Ask the user for a string.
        la    $a0, prompt
        syscall

        li    $v0, 8              # Get the string from the user.
        la    $a0, string
        move  $a1, $t0
        syscall

        li    $t0, 0              # Set the counter to 0.
        subu  $sp, $sp, 4         # Push the null at the bottom of the stack.
        sb    $zero, ($sp)

length:
        lbu   $t1, string($t0)    # Grab the character at current index

        beq   $t1, $zero, contLF  # Push consonants starting from right to left.
        beq   $t1, 10, cont

        add   $t0, $t0, 1         # Increment the counter.

        b     length              # Reach the end of the string.

contLF:
        li    $t8, 1              # Set the new line flag to 1.

cont:
        subu  $t0, $t0, 1         # Decrement the counter to contain the last index.

push:
        lbu   $t1, string($t0)    # Grab the character at current index

        li    $t2, 0              # Set the vowel counter to 0.
        li    $t3, 5              # Initalize the maximum number of vowels.

filter:
        lbu   $t4, vowels($t2)    # Grab the vowel at the current index.
        beq   $t1, $t4, vowel     # Don't add to stack if character is a vowel.

        beq   $t2, $t3, consonant # If character is not a vowel, add to stack.
        addu  $t2, $t2, 1         # Increment the vowel counter by 1.

        b     filter              # Check if the character matches the next vowel.

consonant:
        subu  $sp, $sp, 4         # Push the consonant to the stack.
        sb    $t1, ($sp)

vowel:
        beq   $t0, $zero, pop     # After filtering the vowels, pop it to buffer.
        subu  $t0, $t0, 1         # Decrement the counter.

        b     push                # Filter the next vowel.

pop:
        li    $t0, 0              # Reinitalize the counter to 0.

loop:
        lb    $t1, ($sp)          # Pop the current character from the stack.
        addu  $sp, $sp, 4

        sb    $t1, string($t0)    # Store the character at current index

        beq   $t1, $zero, print   # After reaching the end of stack, print result.

        add   $t0, $t0, 1         # Incrment the counter.

        b     loop

print:
        beq   $t8, $zero, exit    # If new line flag is 0, print the result.

        li    $v0, 4              # Else add a new line.
        la    $a0, LF 
        syscall

exit:
        li    $v0, 4              # Print the reversed string.
        la    $a0, result
        syscall

        la    $a0, string
        syscall

        li    $v0, 10
        syscall

