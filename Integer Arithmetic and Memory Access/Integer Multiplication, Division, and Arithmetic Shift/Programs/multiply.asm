    .globl main
    .text
main:
    ori   $1, $0, 16
    ori   $2, $0, 19

    mult  $1, $2
    mfhi  $7
    mflo  $8

## Operand 1                              0x00001000    0x00000FFF    0x0000FF00    0x00008000
## Significant Bits	                      13            12	          16	          16
## Operand 2                              0x00001000    0x00000FFF    0x0000FFFF    0x00001000
## Significant Bits	                      13            12	          16	          19
## Product	                              0X1000000     0x00FFE001    0xFEFF0100    0x08000000
## Significant Bits	                      25            24            25            26
## Product of Operand's Significant Bit	  0xA9	        0x90          0x100         0x130
## Significant Bits	                      8             8             9             9
