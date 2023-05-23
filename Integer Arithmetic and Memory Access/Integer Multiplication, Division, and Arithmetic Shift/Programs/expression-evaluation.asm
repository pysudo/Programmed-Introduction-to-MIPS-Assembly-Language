# (x*y)/z
# x = 1600000 (=0x186A00), y = 80000 (=0x13880), and z = 400000 (=61A80)
    .globl main
    .text
main:
    ori   $1, $0, 0x18      # push x = 0x186A00 into $1
    sll   $1, $1, 16
    ori   $1, $1, 0x6A00

    ori   $3, $0, 0x6       # push z = 0x61A80 into $3
    sll   $3, $3, 16
    ori   $3, $3, 0x1A80

    div   $1, $3            # divide x by z 
    mflo  $7                # extract the result into $7

    ori   $2, $0, 0x1       # push y = 0x13880 into $2
    sll   $2, $2, 16
    ori   $2, $2, 0x3880

    mult  $2, $7            # multiply the result in $7 with y
    mflo  $7                # extract the final result of th valuation into $7
