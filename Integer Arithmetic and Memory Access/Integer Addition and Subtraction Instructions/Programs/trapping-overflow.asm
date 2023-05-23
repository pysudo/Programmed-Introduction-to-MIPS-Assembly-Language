    .globl main
    .text
main:
    ori     $9,$0,0x7000        # Initialize register $9 to 0x7000.
    sll     $9,$9,0x10          # Shift the bit pattern so that $9 contains 0x70000000.
    addu    $9,$9,$9            # Add $9 to itself.
