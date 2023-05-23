# Register Use:
# $t9, flag to indicate whether N is prime or not.
        .data
prompt: .asciiz "Enter a positive integer: "
errorPrompt:
        .asciiz "No negative number. Please enter a positive integer: "
prime:  .asciiz " is a prime number\n\n"
nprime: .asciiz " is not a prime number\n\n"

        .text
error:
        li    $v0, 4            # Prompt the user to enter the value of N.
        la    $a0, errorPrompt 
        syscall

        j     check
        nop                     # Branch delay.

main:
        ori   $t8, $zero, 1     # Initalize the prime number indicator flag to true.

        li    $v0, 4            # Prompt the user to enter the value of N.
        la    $a0, prompt
        syscall

check:
        li    $v0, 5            # Get the value of N from the user.
        syscall
        move  $t9, $v0          # Make a copy of N for future reference.

        # Integer 0 and 1 are not prime numbers.
        beq   $v0, $zero, notprime
        beq   $v0, $t8, notprime

        slt   $t1, $v0, $zero   # If the integer is negative, set $t1 = 1.
        bne   $t1, $zero, error # Negative integers are invalid.
        nop                     # Branch delay.

        j     cont              # The integer N is positive.
        nop                     # Branch delay.

undef:
        li    $v0, 4            # Request for positive numbers.
        la    $a0, error 
        syscall

        j     check             # Recheck.
        nop                     # Branch delay.

cont:
        ori   $t1, $zero, 2     # Set literal 2.
        div   $t0, $v0, 2       # Set the upper limit as N/2.
        addi  $t0, $t0, 1       # Modify upper limit to (N / 2) + 1

        ori   $t1, $zero, 2     # Initalize the loop counter to 2.

loop:
        slt   $t2, $t1, $t0     # counter < upper limit, set flag to 1.
        beq   $t2, $zero, end
        nop                     # Branch delay

        remu  $t2, $t9, $t1     # Prime numbers have no remainders.
        beq   $t2, $zero, notprime
        nop

increment:
        addi  $t1, $t1, 1       # Increment the loop counter.

        j     loop              # Check if N is divisible by the next number.
        nop                     # Branch delay

notprime: ori $t8, $zero, 0

end:
        li    $v0, 1            # Print the integer N.
        move  $a0, $t9
        syscall

        beq   $t8, $zero, false # N is not a prime number.
        nop                     # Branch delay.

        li    $v0, 4            # Print that N is a prime number.
        la    $a0, prime
        syscall

        j     exit

false:
        li    $v0, 4            # Print that N is not a prime number.
        la    $a0, nprime
        syscall

exit:
        li    $v0, 10
        syscall

