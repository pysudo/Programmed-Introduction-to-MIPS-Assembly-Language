        .data
string:
        .asciiz    "In a  Hole in The   ground There lived a Hobbit"

        .text

main:
        lui   $1, 0x1000        # Set the starting address of the data section to $1.
        ori   $2, $0, 0x20      # Integral value for ASCII whitespace in $2.
        ori   $3, $0, 0x61      # Integral value of ASCII 'a'.
        ori   $4, $0, 1         # First letter of a word flag.

loop:
        lbu   $8, 0($1)         # Load the ascii value at the address stored in $1.
        sll   $0, $0, 0         # Load delay.
  
        beq   $8, $2, nextword  # If whitespace, increment the byte address.
        sll   $0, $0, 0         # Branch delay.

        beq   $8, $0, end       # If null, end program.
        sll   $0, $0, 0         # Branch delay.

        beq   $4, $0, next      # Skip if not the first letter of a word.
        sll   $0, $0, 0         # Branch delay.

checkupper:
        slt   $9, $8, $3        # If integral ASCII value < 97, set $9 = 1.

        bne   $9, $0, next      # If character is lowercase, leave as is.
        sll   $0, $0, 0         # Branch delay.

tolower:
        sub   $8, $8, $2        # 0x20 decrement corresponds to it's uppercase version.

        sb    $8, 0($1)         # Load the ascii value at the address stored in $1.
        sll   $0, $0, 0         # Load delay.

next:
        addi  $1, $1, 1         # Point to the next byte address in $1.
        ori   $4, $0, 0         # Set uppercase flag to 0.

        j     loop              # Grab the next ASCII value.
        sll   $0, $0, 0         # Branch delay.

nextword:
        addi  $1, $1, 1         # Point to the next byte address in $1.

        bne   $4, $0, loop      # Skip if the flag is already set.
        sll   $0, $0, 0         # Branch delay.

        ori   $4, $0, 1         # Set uppercase flag to 1.

        j     loop 
        sll   $0, $0, 0         # Branch delay.

end:
        sll   $0, $0, 0         # Target for branch.
