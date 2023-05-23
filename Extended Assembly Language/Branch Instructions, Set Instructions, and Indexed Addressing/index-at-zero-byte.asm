        .data
data:
        .byte 6, 34, 12, -32, 90      # index zero is first

        .text
main:
        li    $v1,0              # zero the sum
        li    $t1,0              # init index to 0
        li    $t2,0              # init loop counter
        
for:    beq   $t2,5,endfor       # for ( i=0; i < 5 ;i++ )
        lb    $v0,data($t1)
        addu  $v1,$v1,$v0        #     sum = sum+data[i]
        addi  $t1,$t1,1          #     increment index
        addi  $t2,$t2,1          #     increment counter
        b     for

endfor: nop

