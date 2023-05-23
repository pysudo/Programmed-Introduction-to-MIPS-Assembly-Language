    .data
A:  .word   23
B:  .word   98
C:  .word   17
median:
    .space  4

    .text
init:
    lui   $1, 0x1000        # Set base register

    lw    $2, 0($1)         # Load the first value in $2.
    lw    $3, 4($1)         # Load the first value in $3.
    lw    $4, 8($1)         # Load the first value in $4.

equality:
    beq   $2, $3, storeA    # A = B
    sll   $0, $0, 0

    beq   $2, $3, storeA    # A = C
    sll   $0, $0, 0

    beq   $3, $4, storeB    # B = C
    sll   $0, $0, 0

checkBAC:

    slt   $8, $3, $2        # B < A?
    beq   $8, $0, checkCAB  # False: B > A
    sll   $0, $0, 0
    
    slt   $8, $2, $4        # C > A?
    beq   $8, $0, compareBC # False: C < A and B < A = B ? C
    sll   $0, $0, 0

    j     storeA            # True ==> B < A < C
    sll   $0, $0, 0

checkCAB:                   # B > A

    slt   $8, $4, $3,       # C < B?
    beq   $8, $0, storeB    # False: C > B ==> A < B < C
    sll   $0, $0, 0

    slt   $8, $4, $2,       # C < A?
    beq   $8, $0, storeC    # False: C > A ==> A < C < B
    sll   $0, $0, 0

    j     storeA            # True ==> C < A < B
    sll   $0, $0, 0

compareBC:                  # C < A and B < A
    slt   $8, $4, $3        # C < B?
    beq   $8, $0, storeC    # False: C > B and C < A ==> B < C < A
    sll   $0, $0, 0
    
    j     storeB            # C < A and B < A  and C < B ==> C < B < A
    sll   $0, $0, 0

storeA:
    sw    $2, 12($1)        # Store the median stored in $2
    sll   $0, $0, 0

    j     end
    sll   $0, $0, 0

storeB:
    sw    $3, 12($1)        # Store the median stored in $2
    sll   $0, $0, 0

    j     end
    sll   $0, $0, 0

storeC:
    sw    $4, 12($1)        # Store the median stored in $2
    sll   $0, $0, 0

    j     end
    sll   $0, $0, 0

end:
    sll   $0, $0, 0

