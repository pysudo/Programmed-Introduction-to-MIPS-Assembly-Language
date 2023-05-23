        .data
size:   .word 12
array:  .word 50, 12, 52, -78, 03, 12, 99, 32, 53, 77, 47, 00

prompt: .asciiz "Enter an integer to search from the array: "
found:  .asciiz " is the index where the element was found.\n\n"
error:  .asciiz " does not exists in the array.\n\n"
done:   .asciiz "done"

        .text
main:
        li    $v0, 4            # Prompt an integer to search frpm the array.
        la    $a0, prompt
        syscall

        li    $v0, 5            # Grab the integer to be searched from the user.
        syscall

  
        li    $t0, 0            # Initalize a index to 0.
        lw    $t1, size         # Load the size of the array in bytes.
        mul   $t1, $t1, 4
search:
        beq   $t0, $t1, fail    # If the array list is exhausted, print failure.

        lw    $t2, array($t0)   # Grab the element at the current index.
        beq   $t2, $v0, pass    # Check if user input matches the array element.

        add   $t0, $t0, 4       # Move to the next index.

        b     search            # Check if next element matches user input.

pass:
        li    $v0, 1            # Print the index where the integer was found.
        div   $a0, $t0, 4
        syscall

        li    $v0, 4            # Let the user know the element has been found.
        la    $a0, found
        syscall
  
        b     main              # Ask the user for another integer to be searched.

fail:
        move  $t3, $v0          # Copy the integer that was searched.

        li    $v0, 1            # Print the integer to be searched.
        move  $a0, $t3
        syscall

        li    $v0, 4            # Let the user know the element does not exist.
        la    $a0, error 
        syscall

        b     main              # Ask the user for another integer to be searched.

exit:
        li    $v0, 4            # Print "done".
        la    $a0, done 
        syscall

        li    $v0, 10
        syscall

