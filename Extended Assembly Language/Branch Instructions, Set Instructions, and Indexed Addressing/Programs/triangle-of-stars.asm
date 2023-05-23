        .data
tree:   .space  31            # Reserved for pattern + 5 LF + NULL chars.

        .text
main:
        li    $t7, 10         # Integral value of ASCII LF.
        li    $t8, 42         # Integral value of ASCII "*"
        li    $t9, 32         # Integral value of ASCII whitespace.

        li    $t0, 9          # 9 width tree.
        li    $t1, 1          # 1 star at the top of the tree.
        sub   $t2, $t0, $t1   # (width - 1) spaces at the top of the tree.

        li    $t3, 0          # Initalize the index of the pattern to 0.

loop:
        bltz  $t2, print      # Print pattern.
        div   $t0, $t2, 2     # Spaces for each side of the star.
        move  $t4, $t0        # Make a copy of spaces for current interation.
        move  $t5, $t1        # Make a copy of stars for current interation.

        li    $t6, 0          # Flag to terminate iteration on current row.

spaces:
        beqz  $t4, stars      # If the spaces for a half of the row is exhausted.

        sb    $t9, tree($t3)  # Store a whitespace at current index of the tree.

        addi  $t3, $t3, 1     # Move to the next index.
        sub   $t4, $t4, 1     # Decrement the remaining spaces to be printed by 1.

        b     spaces          # Try to print a whitespace on the next index.

stars:
        move  $t4, $t3        # Make a copy of spaces for next possible interation.
        bnez  $t6, cont       # Both stars and spaces are printed, move to the next row.
        not   $t6, $t6        # Prevent any future interations.

starsloop:
        beqz  $t5, spaces     # If stars are exhausted, print spaces to its right.

        sb    $t8, tree($t3)  # Store a star at the current index of the tree.

        addi  $t3, $t3, 1     # Move to the next index.
        sub   $t5, $t5, 1     # Decrement the remaining stars to be printed by 1.

        b     starsloop       # Try to print a star on the next index.

cont:
        sb    $t7, tree($t3)  # Move to the next row of the tree.
        addi  $t3, $t3, 1     # Move to the next index.

        addi  $t1, $t1, 2     # Add two more stars for the next row.
        sub   $t2, $t2, 2     # Decrease two spaces for the next row.

        b     loop            # Print the pattern for the next row.

print:
        li    $v0, 4          # Print the pattern.
        la    $a0, tree
        syscall

        li    $v0, 10
        la    $a0, tree
        syscall

