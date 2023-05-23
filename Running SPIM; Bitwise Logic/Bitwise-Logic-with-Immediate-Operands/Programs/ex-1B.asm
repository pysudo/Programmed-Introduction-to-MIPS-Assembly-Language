    .text
    .globl main
main:
        ori $1,$0,0xD       # load the 0xD into $1
        sll $1,$1,4         # push left by 4 bits

        ori $1,$1,0xE       # append the 0xE into $1
        sll $1,$1,4         # push left by 4 bits

        ori $1,$1,0xA       # append the 0xA into $1
        sll $1,$1,4         # push left by 4 bits

        ori $1,$1,0xD       # append the 0xD into $1
        sll $1,$1,4         # push left by 4 bits

        ori $1,$1,0xB       # append the 0xB into $1
        sll $1,$1,4         # push left by 4 bits

        ori $1,$1,0xE       # append the 0xE into $1
        sll $1,$1,4         # push left by 4 bits

        ori $1,$1,0xE       # append the 0xE into $1
        sll $1,$1,4         # push left by 4 bits

        ori $1,$1,0xF       # append the 0xF into $1

