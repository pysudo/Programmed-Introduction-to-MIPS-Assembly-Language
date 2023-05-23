        .data
prompt: .asciiz "Enter a string: "

LF:     .asciiz "\n\n"
done:   .asciiz "done\n\n"

string: .space 10
mirror: .space 11               # Extra 1 byte to accommodate new line prepends.

maxlen: .word 10

        .text
main:
        li    $v0, 4            # Ask the user to enter a string.
        la    $a0, prompt
        syscall

        li    $v0, 8            # Store the user's string input in memory.
        la    $a0, string
        lw    $a1, maxlen
        syscall

        li    $t0, 0            # Initialize the counter to 0.
        li    $t1, 0            # Initialize the index to 0.

lengthcheck:
        lb    $t3, string($t1)  # Grab the element at the current index.

        beq   $t3, 10, ignoreLF # Break loop if current element is a new line.
        beq   $t3, 0, prependLF # Break loop if current element is null.

        addu  $t0, $t0, 1       # counter++.
        addu  $t1, $t1, 1       # Point to the next index,

        b     lengthcheck       # Count the next element.

prependLF:                      # String length > 0, no implicit quit.
        li    $t8, 10           # Prepend newline for the reversed string.
        sb    $t8, string($t0)

        b     cont

ignoreLF:
        beq   $t0, 0, end       # If the string length is 0, user implies to quit.

        sub   $t0, $t0, 1       # Last index = array size - 1.

cont:
        move  $t4, $t0          # Make a copy of the string's length.

reverse:
        bltz  $t0, print        # If index < 0, print the reversed string.

        sub   $t5, $t4, $t0     # size - index.


        lb    $t6, string($t0)  # Load the string element from the end.
        sb    $t6, mirror($t5)  # Store the element at the the start of reversed string.

        sub   $t0, $t0, 1       # index--.

        b     reverse           # Swap the next element.

print:
        li    $t0, 0            # End the reversed string with a null.
        addu  $t5, $t5, 1
        sb    $t0, mirror($t5) 

        li    $v0, 4            # Print the reversed string.
        la    $a0, mirror 
        syscall

        li    $v0, 4            # Skip two lines.
        la    $a0, LF
        syscall

        b     main              # Reprompt the user to reverse another string.

  end:  
        li    $v0, 4            # Print "done".
        la    $a0, done
        syscall

        li    $v0, 10
        syscall
