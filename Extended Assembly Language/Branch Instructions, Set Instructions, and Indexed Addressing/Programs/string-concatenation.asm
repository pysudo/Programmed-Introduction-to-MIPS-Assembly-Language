        .data
prompt1:
        .asciiz "Enter a string: "
prompt2:
        .asciiz "Enter another string: "

LF2:    .ascii  "\n"
LF1:    .asciiz "\n"
done:   .asciiz "done\n\n"

str1:   .space 10
str2:   .space 10
str3:   .space 20

maxlen: .word 10

        .text
main:
        li    $v0, 4            # Ask the user to enter a string.
        la    $a0, prompt1
        syscall

        li    $v0, 8            # Store the user's string input in memory.
        la    $a0, str1
        lw    $a1, maxlen
        syscall

        li    $t1, 0            # Initialize the index to 0.
        li    $t2, 0            # Initialize the concatanated string index to 0.
        li    $t8, 0            # Initialize second string check flag to 0.

concat:
        bne   $t8, 0, parse2    # If first is already parsed, parse second string.

parse1:
        lb    $t3, str1($t1)    # Grab the element at the current index.
        b     increment

parse2:
        lb    $t3, str2($t1)    # Grab the element at the current index.

increment:
        beq   $t3, 10, cont1    # Break loop if current element is a new line.
        beq   $t3, 0, cont1     # Break loop if current element is null.

        sb    $t3, str3($t2)

        addu  $t1, $t1, 1       # Move to next index of current parsing string.
        addu  $t2, $t2, 1       # Move to next index of concatanated string.

        b     concat            # Count the next element.

cont1:
        beqz  $t2, end          # If first string length is 0, user implies to quit.

        bnez  $t8, print        # If both strings are parsed, print concatanated result.

        addu  $t1, $t1, 1       # Move to next index of first string.
        lb    $t3, str1($t1)    # Grab the element at the current index.

        beqz  $t3, nextPrompt   # No LF on input, append LF before next prompt.

        li    $v0, 4            # Skip line.
        la    $a0, LF1
        syscall


nextPrompt:
        li    $v0, 4            # Ask the user for another string to concatanate.
        la    $a0, prompt2
        syscall

        li    $v0, 8            # Store the user's string input in memory.
        la    $a0, str2
        lw    $a1, maxlen
        syscall

        li    $t1, 0            # Reset the parsing string's index to 0.
        not   $t8, $t8          # Flag to parse the second string.

        b     concat            # Concat the second string with the first.

print:
        lb    $t3, str2($t1)    # Grab the element at the current index.
        bnez  $t3, cont2        # No LF on 2nd string, append LF before print.

        li    $v0, 4            # Skip a line.
        la    $a0, LF1
        syscall


cont2:
        li    $t0, 0            # End the concatanated string with a null.
        sb    $t0, str3($t2) 

        li    $v0, 4            # Print the concatanated string.
        la    $a0, str3
        syscall

        li    $v0, 4            # Skip two lines.
        la    $a0, LF2
        syscall

        b     main              # Reprompt the user to reverse another string.

  end:  
        li    $v0, 4            # Print "done".
        la    $a0, done
        syscall

        li    $v0, 10
        syscall

