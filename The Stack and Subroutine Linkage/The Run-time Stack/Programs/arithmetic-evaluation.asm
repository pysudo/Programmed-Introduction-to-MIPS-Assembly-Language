# Evaluate 3ab - 2bc - 5a + 20ac - 16
        .data
a:      .word 0
bb:     .word 0
c:      .word 0

promptA:  .asciiz "Enter the value a: "
promptB:  .asciiz "Enter the value b: "
promptC:  .asciiz "Enter the value c: "
result:   .asciiz "The final value is "

        .text
main:
        subu  $sp, $sp, 4       # Push null at the bottom of the stack.
        sw    $zero, ($sp)

        li    $v0, 4            # Prompt for the value of variable 'a'.
        la    $a0, promptA
        syscall

        li    $v0, 5            # Get the value of variable 'a' from user.
        syscall

        move  $t0, $v0          # Copy the co-efficient 'a'.

        mul   $t1, $t0, -5      # -5a

        subu  $sp, $sp, 4       # Push '-5a' at the top of the stack.
        sw    $t1, ($sp)

        li    $v0, 4            # Prompt for the value of variable 'b'.
        la    $a0, promptB
        syscall

        li    $v0, 5            # Get the value of variable 'b' from user.
        syscall

        mul   $t1, $t0, $v0     # a*b
        mul   $t1, $t1, 3       # 3ab

        subu  $sp, $sp, 4       # Push '3ab' at the top of the stack.
        sw    $t1, ($sp)

        move  $t1, $v0          # Copy the co-efficient 'b'.

        li    $v0, 4            # Prompt for the value of variable 'c'.
        la    $a0, promptC
        syscall

        li    $v0, 5            # Get the value of variable 'c' from user.
        syscall

        mul   $t1, $t1, $v0     # b*c
        mul   $t1, $t1, -2      # -2bc

        subu  $sp, $sp, 4       # Push '-2bc' at the top of the stack.
        sw    $t1, ($sp)

        mul   $t1, $t0, $v0     # a*c
        mul   $t1, $t1, 20      # 20ac

        subu  $sp, $sp, 4       # Push '20ac' at the top of the stack.
        sw    $t1, ($sp)

        li    $t0, -16          # Set the sum to -16.

loop:
        lw    $t1, ($sp)        # Pop the item from top of the stack.
        addu  $sp, $sp, 4

        addu  $t0, $t0, $t1     # Add the current item to the sum.

        beq   $t1, $zero, print # Print final value after reaching the bottom of the stack.
        
        b     loop              # Add the next item of the stack to the sum.
  
print:
        li    $v0, 4            # Final value prompt.
        la    $a0, result
        syscall

        li    $v0, 1            # Print the final value.
        move  $a0, $t0
        syscall

exit:
        li    $v0, 10
        syscall

