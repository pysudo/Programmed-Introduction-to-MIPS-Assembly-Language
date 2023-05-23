        .data
string:
        .asciiz "    I  s  this a dagger    which I see before me   ?    "

        .text

main:
        lui   $1, 0x1000        # Current pointer
        lui   $2, 0x1000        # Destination pointer
        ori   $3, $0, 0x20      # Integral value for ASCII whitespace in $3.

check:
        lbu   $8, 0($1)         # Load the ascii value at the address stored in $1.
        sll   $0, $0, 0         # Load delay.
  
        beq   $8, $3, setdest   # If whitespace, set destination to this address.
        sll   $0, $0, 0         # Branch delay.

        addi  $1, $1, 1         # Point to the next byte address in $1.

        j     check 
        sll   $0, $0, 0         # Branch delay.
        
loop:
        lbu   $8, 0($1)         # Load the ascii value at the address stored in $1.
        sll   $0, $0, 0         # Load delay.

        beq   $8, $0, end       # If null, assign null to destination and end program.
        sll   $0, $0, 0         # Branch delay.
  
        beq   $8, $3, next      # If whitespace, increment current pointer to next byte..
        sll   $0, $0, 0         # Branch delay.
  
store:
        sb    $8, 0($2)         # Set the current pointer value to destination.
        sll   $0, $0, 0         # Write delay.

        addi  $2, $2, 1         # Point to the next byte address in $2.

next:
        addi  $1, $1, 1         # Point to the next byte address in $1.

        j     loop
        sll   $0, $0, 0         # Branch delay.

setdest:
        or    $2, $0, $1        # Copy current pointer to the destination.

        j     next              
        sll   $0, $0, 0         # Branch delay.

end:
        sb    $0, 0($2)         # Set null terminator to destination.
        sll   $0, $0, 0         # Write delay.
