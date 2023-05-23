# Register use:
# $t8, store the numerator values
# $t9, store the denominator values
        .data
K:      .asciiz "Enter the quantities picked, K: "
N:      .asciiz "Enter the total numbers, N: "
odds:   .asciiz "Your odds of winning are 1 in "
LF:   .asciiz "\n\n"

        .text
main:
        ori   $t8, $zero, 1     # Initalize the numerator to 1.
        ori   $t9, $zero, 1     # Initalize the denominator to 1.
        
        li    $v0, 4            # Prompt user to get the total available numbers.
        la    $a0, N
        syscall

        li    $v0, 5            # Get the total available numbers.
        syscall
        move  $t0, $v0          # Copy the total available numbers in the lottery.

        li    $v0, 4            # Prompt user to get his total picked numbers.
        la    $a0, K
        syscall

        li    $v0, 5            # Get the user's total picked numbers.
        syscall
        move  $t1, $v0          # Copy the total quantities picked from the lottery.

        add   $t2, $zero,  0    # Initalize the loop counter to -1.

loop:
        beq   $t2, $t1, end     # counter = K, move on to the denominator.
        nop                     # Branch delay.

        sub   $t4, $t0, $t2     # (N-K+1)
        mul   $t8, $t8, $t4     # N * (N-1) * (N-2) * (N-3) * (N-4) * ... * (N-K+1)

        add   $t2, $t2, 1       # Increment counter by 1.

        mul   $t9, $t9, $t2

        j     loop              # Evaluate the next term.
        nop                     # Branch delay.


end:
        # Print the odds of winning the lottery.
        li    $v0, 4
        la    $a0, odds 
        syscall

        div   $a0, $t8, $t9     # N * (N-1) * ... * (N-K+1) / 1  *  2   * ... * K

        li    $v0, 1
        syscall

        li    $v0, 4            # Skip 2 lines.
        la    $a0, LF
        syscall

        li    $v0, 10           # Exit
        syscall
