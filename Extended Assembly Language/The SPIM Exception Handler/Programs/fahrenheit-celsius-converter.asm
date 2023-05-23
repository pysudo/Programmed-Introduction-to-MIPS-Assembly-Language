# Doesn't handle line feeds for attempting to type scale that is more than 1 chars.
        .data
scaleIP: .space 2
scaleOP: .word  0
scalePrompt: .asciiz "Enter Scale: "
tempPrompt: .asciiz "Enter Temperature: "
cConvert: .asciiz "Celsius Temperature: "
fConvert: .asciiz "Fahrenheit Temperature: "
errorMsg: .asciiz "scale should be either 'F' or 'C'.\n\n"
done:    .asciiz "done\n"

        .text
main:
        ori   $t0, $zero, 5     # Initalize constant 5.
        ori   $t1, $zero, 9     # Initalize constant 9.
        ori   $t2, $zero, 32    # Initalize constant 32.
        ori   $t3, $zero, 70    # Integral value of ASCII 'F'.
        ori   $t4, $zero, 67    # Integral value of ASCII 'C'.
        ori   $t5, $zero, 81    # Integral value of ASCII 'Q'.
        ori   $t8, $zero, 100   # Set literal 100.

loop:
        li    $v0, 4            # Prompt for the user to know the scale.
        la    $a0, scalePrompt
        syscall

        li    $v0, 8            # Let the user enter the desired scale for input.
        la    $a0, scaleIP
        ori   $a1, $zero, 3     # Size of buffer = 1 char + LF + null.
        syscall

        la    $t6, scaleIP      # Get the scale value from the user input.
        lb    $t7, 0($t6)
        nop

        beq   $t7, $t5, end     # If the scale inputed is 'Q', quit the program.
        nop                     # Branch delay.

        beq   $t7, $t4, setUnitF# If input scale is 'C' set desired unit to 'F'.
        nop

setUnitC:
        bne   $t7, $t3, error   # Print error, if scale is neither 'F' nor 'C'.

        move  $t6, $t4          # Copy the 'C' temperature scale.

        j     cont
        nop

setUnitF:
        move  $t6, $t3          # Copy the 'F' temperature scale.

cont:
        or    $t9, $zero, $zero
        ori   $t9, $t9, 0x0A0A  # Append line feed.
        sll   $t9, $t9, 8       # Make room for linefeed.
        or    $t9, $t9, $t6     # Copy the ASCII of the converted scale.
        sw    $t9, scaleOP      # Store the converted scale along with line feeds.


        li    $v0, 4            # Prompt for the user for the temperature value.
        la    $a0, tempPrompt
        syscall

        li    $v0, 5            # Get the temperature value from user input.
        syscall

        beq   $t7, $t4, toF     # If the desired scale is fahrenheit, convert to it.
        nop

        multu $t0, $t8          # (5 * 100) = 500
        mflo  $t7
        nop
        nop

        divu  $t7, $t1          # 500 / 9 for to C scale conversion.
        mflo  $t6
        nop
        nop

        sub   $t6, $v0, $t2     # F - 32

        multu $t7, $t6          # (500/9) (F - 32)
        mflo  $t9
        nop
        nop

        divu  $t9, $t8          # ((500/9) (F - 32)) / 100
        mflo  $t6

        li    $v0, 4            # Print the converted statement.
        la    $a0, fConvert
        syscall

        move  $a0, $t6          # Copy the value to be printed.

        j     print
        nop                     # Branch delay.

toF:
        multu $t1, $t8          # (9 * 100) = 500
        mflo  $t6
        nop
        nop

        divu  $t6, $t0          # 900 / 5 for to F scale conversion.
        mflo  $t7
        nop
        nop

        multu $t7, $v0          # (900/5) * C
        mflo  $t6
        nop
        nop

        multu $t2, $t8          # (32 * 100) = 3200
        mflo  $t7
        nop
        nop

        add   $t6, $t6, $t7     # (9/5) * C + 3200

        divu  $t6, $t8          # ((9/5) * C + 3200) / 100
        mflo  $t7

        li    $v0, 4            # Print the converted statement.
        la    $a0, cConvert
        syscall

        move  $a0, $t7          # Copy the value to be printed.

print:
        li    $v0, 1            # Print the converted value of desired scale.
        syscall

        li    $v0, 4            # Print the its corresponding unit.
        la    $a0, scaleOP
        syscall

        j     loop              # Process another conversion.

error:
        li    $v0, 4            # Indicate scale should either be 'F' or 'C'.
        la    $a0, errorMsg
        syscall

        j     loop              # Process another conversion.

end:
        li    $v0, 4            # Print "done" before quitting.
        la    $a0, done
        syscall

exit:
        li    $v0, 10
        syscall

