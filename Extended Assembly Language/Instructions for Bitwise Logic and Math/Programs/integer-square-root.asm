        .data
prompt: .asciiz "Enter the number: "
undefined:
        .asciiz "Square root is undefined for negative integers. Try again.\n\n"
root:   .asciiz "The integer square root is: "
LF:   .asciiz "\n\n"

        .text
main:
        li    $v0, 4            # Prompt the user to enter the value of N.
        la    $a0, prompt
        syscall

        li    $v0, 5            # Get the value of N from the user.
        syscall

        slt   $t1, $v0, $zero   # If the integer is negative, set $t1 = 1.
        bne   $t1, $zero, undef # Square root for negative integers is undefined.
        nop                     # Branch delay.

        j     cont              # The integer N is positive.
        nop                     # Branch delay.

undef:
        li    $v0, 4            # Square root of negative number is undefined.
        la    $a0, undefined
        syscall

        j     main              # Start over.
        nop                     # Branch delay.

cont:
        move  $t0, $v0          # Copy the value of N to a temporary register.

        addi  $t1, $zero, -1    # Initalize -1 for the previous loop counter.
        ori   $t2, $zero, 0     # Initalize 0 for the current loop counter.

loop:
        mul   $t3, $t2, $t2     # Square the current loop counter.
        slt   $t4, $t0, $t3     # Set $t4 = 1, if current counter <= N.
        bne   $t4, $zero, end   # End program if upper limit is reached.
        nop                     # Branch delay.

        addi  $t1, $t1, 1       # Increment the previous loop counter.
        addi  $t2, $t2, 1       # Increment the current loop counter.

        j     loop              # Check if next counter is square root of N.

end:
        li    $v0, 4            # Print the integer square root is computed.
        la    $a0, root 
        syscall

        li    $v0, 1            # Print the integer square root.
        move  $a0, $t1 
        syscall

        li    $v0, 4            # Move to next line.
        la    $a0, LF 
        syscall

        li    $v0, 10
        syscall
