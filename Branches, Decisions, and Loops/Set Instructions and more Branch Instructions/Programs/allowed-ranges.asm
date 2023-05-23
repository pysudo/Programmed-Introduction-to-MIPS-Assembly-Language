    .text
init:
    ori   $8, $0, 27    # Set the current temperature in $8.
    ori   $3, $0, 1     # Set temprature threshhold indicator to 1.

upper:
    sltiu $1, $8, 81    # Set $1 = 1, if temprature is within range, > 80
    beq   $1, $0, out   # Temperature out of range.
    sll   $0, $0, 0
    
    sltiu $1, $8, 60    # Set $1 = 1, if temprature is out of range, <= 60
    bne   $1, $0, lower # Temperature out of upper range.
    sll   $0, $0, 0

    j     cont          # Temperature within upper range.
    sll   $0, $0, 0

lower:
    sltiu $1, $8, 41    # Set $1 = 1, if temprature is within range, > 40
    beq   $1, $0, out   # Temperature out of range.
    sll   $0, $0, 0
    
    sltiu $1, $8, 20    # Set $1 = 1, if temprature is out of range, <= 20
    bne   $1, $0, out   # Temperature out of range.
    sll   $0, $0, 0
    
    j     cont          # Temperature within lower range.
    sll   $0, $0, 0

out:
    or    $3, $0, $0

cont:                   # Temperature within range.
    sll   $0, $0, 0

