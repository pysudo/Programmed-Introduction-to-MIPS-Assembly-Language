        .text
main:
        subu    $sp, $sp, 4           # Push the caller's return address.
        sw      $ra, ($sp)

        subu    $sp, $sp, 4           # Push the caller's frame pointer.
        sw      $fp, ($sp)

        subu    $fp, $sp, 8           # int f; int c;
        move    $sp, $fp              # Update the current stack.

        li      $t0, 50               # Set value for 50 dollars.
        sw      $t0, 4($fp)           # f = 50.

        lw      $a0, 4($fp)           # Set 50 as argument for conversion.
        jal     toCent
        sw      $v0, 0($fp)           # c = toCent(f)

        lw      $t0, 0($fp)           # Variable c.

        li      $v0, 4                # Print the dollars to be converted.
        la      $a0, f
        syscall

        li      $v0, 1
        lw      $a0, 4($fp)           # Variable f.
        syscall

        li      $v0, 4                # Print the converted cents.
        la      $a0, c
        syscall

        li      $v0, 1
        lw      $a0, 0($fp)           # Variable c.
        syscall

        addu    $sp, $fp, 8           # Pop the stack frame.
        lw      $fp, ($sp)

        addu    $sp, $sp, 4           # Pop the caller's frame pointer.
        lw      $fp, ($sp)

        addu    $sp, $sp, 4           # Pop the return address.
        lw      $ra, ($sp)

        li      $v0, 10
        syscall

        .data
f:      .asciiz "f="
c:      .asciiz ", c="


# toCent - Converts a dollars into cents.
#
# on entry:
#   $a0 -- Value in dollars.

# on exit:
#   $v0 -- Dollar converted to cents.
        .text
toCent:
        subu    $sp, $sp, 4           # Push the prior frame pointer.
        sw      $fp, ($sp)

        subu    $fp, $sp, 4           # int v;
        move    $sp, $fp              # Update the current stack.

                                      # v = x - 32;
        subu    $t0, $a0, 32          # x - 32
        sw      $t0, 0($fp)

                                      # v =  5*v
        lw      $t0, 0($fp)           # v
        mul     $t0, $t0, 5           # 5*v
        sw      $t0, 0($fp)

                                      # v =  v/9
        lw      $t0, 0($fp)           # v
        div     $t0, $t0, 9           # v/9
        sw      $t0, 0($fp)

        lw      $v0, 0($fp)          # Return the converted cent.

        addu    $sp, $fp, 4           # Pop the stack frame.
        lw      $fp, ($sp)
        addu    $sp, $sp, 4

        jr      $ra

