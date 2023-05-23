# Evaluate 5u^2 - 12uv + 6v^2
        .text
main:
loop:
        li    $v0, 4                  # Prompt for the value of co-efficient 'u'.
        la    $a0, uInput
        syscall

        li    $v0, 5                  # Get the value of 'u' from the user.
        syscall
        move  $s0, $v0                # Make a copy of variable 'u'.

        li    $v0, 4                  # Prompt for the value of co-efficient 'v'.
        la    $a0, vInput
        syscall

        li    $v0, 5                  # Get the value of 'v' from the user.
        syscall
        move  $s1, $v0                # Make a copy of variable 'v'.

        bne   $s0, $s1, cont          # Check null if both variables are equal.
        beq   $s0, $zero, exit        # If u = v = 0, implies quit program.

cont:

        li    $a0, 5                  # Arguments to compute the first term.
        move  $a1, $s0
        move  $a2, $s0
        jal   threeMul                # 5u^2
        nop

        move  $s2, $v0                # Initalize the sum to 5u^2

        li    $a0, -12                # Arguments to compute the second term.
        move  $a1, $s0
        move  $a2, $s1
        jal   threeMul                # 12uv
        nop

        addu  $s2, $s2, $v0           # 5u^2 - 12uv

        li    $a0, 6                  # Arguments to compute the third term.
        move  $a1, $s1
        move  $a2, $s1
        jal   threeMul                # 6v^2
        nop

        addu  $s2, $s2, $v0           # 5u^2 - 12uv + 6v^2

        li    $v0, 4                  # Print the result of the equation.
        la    $a0, result
        syscall

        li    $v0, 1
        move  $a0, $s2
        syscall

        li    $v0, 4                  # new lines.
        la    $a0, LF
        syscall

        b     loop                    # Prompt for another evalution.
        nop                           # Branch delay.

threeMul:
        mul   $t0, $a0, $a1           # A*X*Y
        mul   $v0, $t0, $a2           # Return the product.

        jr    $ra
        nop

exit:
        li    $v0, 4                  # Print "done".
        la    $a0, done
        syscall

        li    $v0, 10
        syscall

        .data
uInput: .asciiz "Enter the value of u: "
vInput: .asciiz "Enter the value of v: "
result: .asciiz "The result of the equation is: "
done:   .asciiz "done"
LF:     .asciiz "\n\n"

