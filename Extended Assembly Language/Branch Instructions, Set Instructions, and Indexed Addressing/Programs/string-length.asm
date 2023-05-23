        .data
prompt: .asciiz "Enter a string: "
result: .asciiz " is the length of the string.\n\n"

LF:     .asciiz "\n"
done:   .asciiz "done\n\n"

string: .space 10
buflen: .word 10                # Maximum length of the buffer.

        .text

main:
        li    $v0, 4            # Ask the user to enter a string.
        la    $a0, prompt
        syscall

        li    $v0, 8            # Store the user's string input in memory.
        la    $a0, string
        lw    $a1, buflen
        syscall

        li    $v0, 4            # Ask the user to enter a string.
        la    $a0, string
        syscall

        
        li    $t0, 0            # Initialize the counter to 0.
        li    $t1, 0            # Initialize the index to 0.

while:
        lb    $t3, string($t1)  # Grab the element at the current index.

        beq   $t3, 0, print     # Break loop if current element is null.
        beq   $t3, 10, print    # Break loop if current element is a new line.

        addu  $t0, $t0, 1       # counter++.
        addu  $t1, $t1, 1       # Point to the next index,

        b     while             # Count the next element.

print:
        beq   $t0, 0, end       # If the string length is 0, the user implies to quit.

        beq   $t3, 10, cont     # Check if newline is skipped.

        li    $v0, 4            # Append a newline before printing the result.
        la    $a0, LF 
        syscall

cont:
        li    $v0, 1            # Print the length of the string.
        move  $a0, $t0
        syscall

        li    $v0, 4            # Print the remaining result statment.
        la    $a0, result 
        syscall

        b     main              # Reprompt the user to check another string.

  end:  
        li    $v0, 4            # Print "done".
        la    $a0, done
        syscall

        li    $v0, 10
        syscall
