## Program to assemble the instruction ori  $8,$9,0x004A
##
        .text
        .globl  main

main:
        or    $25,$0,$0        # clear $25
        
        ori   $24,$0,0xD       # opcode
        sll   $24,$24,26       # shift opcode into position
        or    $25,$25,$24      # or it into the instruction
        
        ori   $24,$0,0x9       # operand $s
        sll   $24,$24,27       # remove fields not a part of operand $s
        srl   $24,$24,6        # shift operand $s into position
        or    $25,$25,$24      # or it into the instruction
        
        ori   $24,$0,0x8       # dest. $d
        sll   $24,$24,27       # remove fields not a part of dest. $d
        srl   $24,$24,11       # shift dest. $d into position
        or    $25,$25,$24      # or it into the instruction
        
        ori   $24,$0,0x004A    # immediate operand
        sll   $24,$24,16       # remove fields not a part of immediate operand
        srl   $24,$24,16       # shift immediate operand into position
        or    $25,$25,$24      # or it into the instruction
        
        ori   $8,$9,0x004A     # The actual assembler
                               # should create the same machine
                               # instruction as we now have in $25
## end of file
