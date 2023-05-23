## Program to bitwise OR two patterns.
  .text
  .globl main

main:
  ori $8,$0,0x0FA5 # Put first pattern into register $8.
  ori $10,$8,0x368F # or ($8) with seconds pattern. Result to $10.
## End of file
