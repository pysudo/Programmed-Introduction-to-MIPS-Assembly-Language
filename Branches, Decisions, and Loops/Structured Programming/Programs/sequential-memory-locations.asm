# Registers:
# $2, comparison flag

    .globl main

    .data
array:
    .space 100

    .text
init:
    or    $8, $0, $0        # Initialize the counter to 0 in $2.
    lui   $1, 0x1000        # Initialize address of start of the data section.
main:
    
while:
    slti  $2, $8, 25        # Set $2 = 1, if the counter is less than 25.
    beq   $2, $0, cont      # Break interation if $2 = 0 as $8 > 24.
    sll $0, $0, 0

    sw  $8, 0($1)           # Store the current counter value.

    addi  $8, $8, 1         # Grab the next value to be stored.
    addi  $1, $1, 4         # Get the next four bytes of the data section.
    j     while             # Next iteration.
    sll $0, $0, 0

cont:
    sll $0, $0, 0
