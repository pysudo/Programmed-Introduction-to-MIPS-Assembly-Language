        .data
string:
        .asciiz "ABCDEFG"

        .text

main:
        lui   $1, 0x1000        # Set the starting address of the data section to $1.

loop:
        lbu   $8, 0($1)         # Load the ascii value at the address stored in $1.
        sll   $0, $0, 0         # Load delay.

        beq   $8, $0, end       # End program, if pointed to null terminator.
        sll   $0, $0, 0         # Branch delay.

        addi  $8, $8, 0x20      # 0x20 increments corresponds to it's lowercase version.

        sb    $8, 0($1)         # Load the ascii value at the address stored in $1.
        sll   $0, $0, 0         # Load delay.

        addi  $1, $1, 1         # Point address to the next ascii location

        j     loop              # Grab the next ASCII value.

end:
        sll   $0, $0, 0         # Target for branch.
