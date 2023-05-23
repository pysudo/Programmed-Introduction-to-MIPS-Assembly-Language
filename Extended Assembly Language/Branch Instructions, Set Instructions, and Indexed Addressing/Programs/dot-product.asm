        .data
length: .word 0
vectorA:
        .space 40
vectorB:
        .space 40
prompt:
        .asciiz "Enter the length of the vector: "
error:
        .asciiz "The size of the vector should be 1 through 10.\n\n"

promptA:
        .asciiz "Enter the elements of vector A:\n"
promptB:
        .asciiz "Enter the elements of vector B:\n"
indexAt:
        .asciiz " indexed element: "
result:
        .asciiz " is the sum of the product of vectors A and B."

        .text
errorPrompt:
        li    $v0, 4            # Invalid size.
        la    $a0, error 
        syscall

main:
        li    $v0, 4            # Prompt the user for the size of the vector.
        la    $a0, prompt
        syscall

        li    $v0, 5            # Read the length of the vectors.
        syscall

        bgt   $v0, 10, errorPrompt    # Print error message for invalid size.
        blez  $v0, errorPrompt

        move  $t0, $v0          # Copy the size of the vector.
        sw    $t0, length       # Store the size of the vectors in memory.

        li    $v0, 4            # Prompt the user for the elements of vector A.
        la    $a0, promptA
        syscall

        li    $t8, 0            # Flag to indicate if vector B is proccessed.
        la    $t2, vectorA      # Point the the array entrance.
        b     next              # First fill the element of vector A.

B:
        li    $t8, 1            # Vector B is filled at the end of the loop.

        li    $v0, 4            # Prompt the user for the elements of vector B.
        la    $a0, promptB
        syscall

        la    $t2, vectorB      # Point to the array entrance.

next:
        li    $t1, 0            # Set the index of the vectors to 0.

fill:
        beq   $t0, $t1, cont    # Continue after the elements of vector are filled.

        li    $v0, 1            # Print the current index being filled.
        move  $a0, $t1
        syscall

        li    $v0, 4            # Prompt at which index the current element is filled.
        la    $a0, indexAt
        syscall

        li    $v0, 5            # Read the elements of vector A.
        syscall

        sw    $v0, 0($t2)       # Store the element at the current index.

        add   $t1, $t1, 1       # Increment the current index.
        add   $t2, $t2, 4       # Move to the next address of the array element.
        b     fill

cont:   
        beq   $t8, $zero, B     # Vector B is to be filled before moving on.

        la    $t1, vectorA      # Point to the entrance vector A.
        la    $t2, vectorB      # Point to the entrance vector B.

        li    $a0, 0            # Initalize the sum of the product to 0.
        li    $t3, 0            # Initalize the counter to 0.

compute:
        beq   $t3, $t0, print   # After sum of product, print the result.

        lw    $t4, 0($t1)       # Load the element of vector A at current index.
        lw    $t5, 0($t2)       # Load the element of vector B at current index.

        mul   $t6, $t4, $t5     # Multiply corresponding elements of the vectors.
        add   $a0, $a0, $t6     # Add the product to the sum.

        add   $t1, $t1, 4       # Point to the next element of vector A.
        add   $t2, $t2, 4       # Point to the next element of vector B.
        add   $t3, $t3, 1       # Increment the counter by 1.

        b     compute           # Add the next product to the sum.

print:
        li    $v0, 1            # Print the sum of the product.
        syscall

        li    $v0, 4            # Print the resulting statement.
        la    $a0, result 
        syscall

        li    $v0, 10
        syscall
