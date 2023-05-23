        .text
main:
        subu    $sp, $sp, 4           # Push the caller's return address.
        sw      $ra, ($sp)

        subu    $sp, $sp, 4           # Push the caller's frame pointer.
        sw      $fp, ($sp)

        li      $s0, 4                # The Nth triangle number to be returned.

        move    $a0, $s0              # Calculate the Nth triangle number.
        jal     triNum
        move    $t0, $v0              # Make a copy the triangle number.

        li      $v0, 4                # Print the triangle number.
        la      $a0, result
        syscall

        li      $v0, 1                # at the position N
        move    $a0, $s0
        syscall

        li      $v0, 4                # Print the ':' seperator.
        la      $a0, sep
        syscall

        li      $v0, 1                # Print the triangle number.
        move    $a0, $t0
        syscall

        lw      $fp, ($sp)            # Pop the caller's frame pointer.
        addu    $sp, $sp, 4

        lw      $ra, ($sp)            # Pop the return address.
        addu    $sp, $sp, 4

        li      $v0, 10
        syscall

        .data
result: .asciiz "The triangle number at "
sep:    .asciiz ": "


# triNum -- Returns the Nth triangle number.
#
# on entry:
#   $a0 -- What Nth triangle number to be returned.

# on exit:
#   $v0 -- The triangle number at Nth position.

        .text
triNum:
        subu    $sp, $sp, 4           # Push the caller's return address.
        sw      $ra, ($sp)

        subu    $sp, $sp, 4           # Push the caller's frame pointer.
        sw      $fp, ($sp)

        subu    $sp, $sp, 4           # Push the caller's saved registers.
        sw      $s0, ($sp)

        move    $s0, $a0              # Make a copy of the argument.

        li      $v0, 1                # Initalize return value to 1.
        beq     $a0, 1, epilog        # If Triangle(1), return 1
        blt     $a0, 1, retZero       # If args < 0, return 0.

        b       recurse               # Calculate triangle number for N > 1 position.

retZero:
        li      $v0, 0                # Initalize return value to 0.
        b       epilog                # Return 0.

recurse:
        subu    $a0, $a0, 1           # N - 1
        jal     triNum

        addu    $v0, $v0, $s0         # N + Triangle(N-1)

epilog:
        lw      $s0, ($sp)            # Pop the caller's saved registers.
        addu    $sp, $sp, 4

        lw      $fp, ($sp)            # Pop the caller's frame pointer.
        addu    $sp, $sp, 4

        lw      $ra, ($sp)            # Pop the return address.
        addu    $sp, $sp, 4

        jr      $ra                   # Return the triangle number.

